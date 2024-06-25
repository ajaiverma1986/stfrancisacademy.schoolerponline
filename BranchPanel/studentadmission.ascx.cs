using System;
using System.Data;

public partial class BranchPanel_studentadmission : System.Web.UI.UserControl
{
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        string url = Request.Url.ToString();
        if (Session["BrBrid"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        //if (Session["stue"] == null)
        //{
        //    Response.Redirect("Default.aspx");
        //}

        if (!IsPostBack)
        {
            //int x = Convert.ToInt32(objdut.GetScalar("select FYID from financial_Year where isActive=1 and isClosed=0"));
            ViewState["fyid"] = Convert.ToInt32(objdut.GetScalar("select fyid from tbl_admission where adid=" + Session["stue"]));
            int id = Convert.ToInt32(Session["stue"]);
            filstudetail(id);
        }
    }

    public void filstudetail(int id)
    {
        string query = "select (firstname+' '+middlename+' '+lastname) as name,tbl_Admission.ADMIID,applyclass, FMobileNo,UploadChildPhoto,tbl_Admission.ADNO from Student_Master  inner join tbl_Admission on tbl_Admission.sturegno=Student_Master.sturegno  where tbl_Admission.adid=" + id + " and tbl_Admission.brid=" + Convert.ToInt32(Session["BrBrid"]) + " and tbl_Admission.fyid=" + Convert.ToInt32(ViewState["fyid"]);
        DataTable dt = objdut.GetDataTable(query);

        if (dt.Rows.Count > 0)
        {
            lblmobile.Text = dt.Rows[0]["FMobileNo"].ToString();
            lblname.Text = dt.Rows[0]["name"].ToString();
            lblroll.Text = dt.Rows[0]["ADNO"].ToString();
            lblclasss.Text = dt.Rows[0]["applyclass"].ToString();
            Session["admno"] = dt.Rows[0]["ADNO"].ToString();
            Session["Adid2"] = dt.Rows[0]["admiid"].ToString();
            if (string.IsNullOrEmpty(dt.Rows[0]["UploadChildPhoto"].ToString()))
            {
                imgstu.ImageUrl = "~/images/9update.png";
            }
            else
            {
                imgstu.ImageUrl = "~/StudentPhoto/" + dt.Rows[0]["UploadChildPhoto"].ToString();
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("completeadmission.aspx?sturegno=" + Convert.ToInt32(Session["stue"]));
    }

    protected void btnprofile_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewadmission.aspx?sturegno=" + Convert.ToInt32(Session["stue"]));
    }
}