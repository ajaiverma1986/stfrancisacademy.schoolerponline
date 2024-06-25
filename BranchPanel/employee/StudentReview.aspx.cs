using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class EmployeePanel_StudentReview : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private int eid = 0;
    private DataTable dt;
    private int idStudent = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["StuRegNo"] != null)
            {
                eid = Convert.ToInt32(Session["StuRegNo"]);
            }
            idStudent = Convert.ToInt16(Session["StuRegNo"]);
            showDetails(eid);
            getusername();
            bindReview(eid);
        }
    }

    protected void showDetails(int id)
    {
        dt = CommonClass.ABC("stuDentDetails", id, Convert.ToInt32(Session["brbrid"]));
        

        if (dt.Rows.Count > 0)
        {
           
            lblRollno.InnerText = "";
            lblname.InnerText = dt.Rows[0]["StudentFirstName"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["StudentMiddleName"].ToString()))
            {
                lblname.InnerText = lblname.InnerText + dt.Rows[0]["StudentMiddleName"].ToString();
            }
            else
            {
                lblname.InnerText = lblname.InnerText + "";
            }

           
            lblname.InnerText = lblname.InnerText + " " + dt.Rows[0]["StudentLastName"].ToString();
           
            lblGender.InnerText = dt.Rows[0]["GenderName"].ToString();
            lblDOB.InnerText = Convert.ToDateTime(dt.Rows[0]["StudentDOB"]).ToString("dd MMM yyyy");
            if (!string.IsNullOrEmpty(dt.Rows[0]["Address"].ToString()))
            {
                lblAddress.InnerText = dt.Rows[0]["Address"].ToString();
            }
            else
            {
                lblAddress.InnerText = "NA";
            }
            
           
        }
        else
        {
            Session["StudID"] = null;
            Response.Redirect("../user-login.aspx");
        }

      
      
    }

   public void bindReview(int eid)
   {
       DataUtility objdut = new DataUtility();
       SqlParameter[] param = new SqlParameter[4];
       param[0] = new SqlParameter("@SturegNo", eid);
       param[1] = new SqlParameter("@Date", DateTime.Now);
       param[2] = new SqlParameter("@Brid", Convert.ToInt32(Session["brbrid"]));
       param[3] = new SqlParameter("@callType", "SI");
       DataTable dtrev = objdut.GetDataTableSP(param, "usp_StudentReview");
       if (dtrev != null && dtrev.Rows.Count > 0)
       {
           grdReview.DataSource = dtrev;
           grdReview.DataBind();

           lblDate.Text = Convert.ToDateTime(dtrev.Rows[0]["ReviewForDate"]).ToString("dd-MM-yyyy");
           txtReview.Text = Convert.ToString(dtrev.Rows[0]["Review"]);
       }
       else
       {
           grdReview.DataSource = null;
           grdReview.DataBind();
       }
   }

    public void getusername()
    {
        DataUtility Objdut = new DataUtility();
        lbluser.Text = Convert.ToString(Objdut.GetScalar("select (StudentFirstName+' '+StudentMiddleName+' '+StudentLastName) as stuname from tbl_StudentRegistration where Registration_No='" + HttpContext.Current.Session["loginid"] + "'"));
    }
    protected void grdReview_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdReview.PageIndex = e.NewPageIndex;
        if (Session["StuRegNo"] != null)
        {
            eid = Convert.ToInt32(Session["StuRegNo"]);
        }
        bindReview(eid);
    }
}