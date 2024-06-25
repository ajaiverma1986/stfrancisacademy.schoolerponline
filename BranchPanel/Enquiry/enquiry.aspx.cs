using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class BranchPanel_enquiry : System.Web.UI.Page
{
    SqlParameter[] param;
    DataUtility Objdut = new DataUtility();
    DataTable dt, dt3;
    int chkmobile, email;

    Utility objUT = new Utility();

    string url = "", PageName;
    protected void Page_Load(object sender, EventArgs e)
    {       
        if (!IsPostBack)
        {
            fillsource();

        }
    }

    private void fillsource()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 3);
        dt = Objdut.GetDataTableSP(param, "usp_enquirygenraldetails");
        if (dt.Rows.Count > 0)
        {
            ddlenquiry.DataSource = dt;
            ddlenquiry.DataTextField = "EnquirySource";
            ddlenquiry.DataValueField = "id";
            ddlenquiry.DataBind();
            ddlenquiry.Items.Insert(0, new ListItem("---Select Enquiry Source---", "0"));
        }
        dt.Clear();

            dt = Objdut.GetDataTable("select classid,Classname from ClassBranch_master where BranchId=1 and status =1");
            Ddlenquirytype.DataSource = dt;
            Ddlenquirytype.DataTextField = "Classname";
            Ddlenquirytype.DataValueField = "classid";
            Ddlenquirytype.DataBind();
            Ddlenquirytype.Items.Insert(0, new ListItem("---Select Class---", "0"));
            dt.Clear();

        
        param[0] = new SqlParameter("@mode", 4);
        dt = Objdut.GetDataTableSP(param, "usp_enquirygenraldetails");
        if (dt.Rows.Count > 0)
        {
            ddlStatus.DataSource = dt;
            ddlStatus.DataTextField = "statusname";
            ddlStatus.DataValueField = "esid";
            ddlStatus.DataBind();
            ddlStatus.Items.Insert(0, new ListItem("---Select Enquiry Status---", "0"));
            ddlStatus.SelectedValue = "1";
        }

    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        param = new SqlParameter[21];
        param[0] = new SqlParameter("@enquirydate", Request.Form[txtToDate.UniqueID]);
        param[1] = new SqlParameter("@source", ddlenquiry.SelectedItem.Text.Trim());
        param[2] = new SqlParameter("@sourceid", ddlenquiry.SelectedValue);
        param[3] = new SqlParameter("@name", txtname.Text.Trim());
        param[4] = new SqlParameter("@emailid", txtFEmailid.Text.Trim());
        param[5] = new SqlParameter("@mobileno", txtFMobile.Text.Trim());
        param[6] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
        param[7] = new SqlParameter("@landlineno", "");
        param[8] = new SqlParameter("@enqtype", Ddlenquirytype.SelectedItem.Text);
        param[9] = new SqlParameter("@enqtypeid", Ddlenquirytype.SelectedValue);
        param[10] = new SqlParameter("@enqstatus", ddlStatus.SelectedItem.Text);
        param[11] = new SqlParameter("@enqstatusid", ddlStatus.SelectedValue);
        param[12] = new SqlParameter("@status", 0);
        param[13] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[13].Direction = ParameterDirection.Output;
        param[14] = new SqlParameter("@msg", TextBox1.Text.Trim());
        param[15] = new SqlParameter("@EnqAddby", Session["Brusername"]);
        param[16] = new SqlParameter("@city", txtboxID.Text.Trim());
        param[17] = new SqlParameter("@mob2", txtmob2.Text != "" ? txtmob2.Text : "");
        param[18] = new SqlParameter("@mob3", "");
        param[19] = new SqlParameter("@email2", txtemail2.Text != "" ? txtemail2.Text : "");
        param[20] = new SqlParameter("@enqtime", Request.Form[txtstarttime.UniqueID]);
        int result = Objdut.ExecuteSqlSP(param, "usp_enquiry");
        if (result == 1)
        {
            Response.Redirect("viewenquiry.aspx");
        }
        else
        {
            return;
        }

    }

    [WebMethod]
    public static List<GetClassLIst> BindCity(string cityname)
    {
        try
        {
            List<GetClassLIst> objgetclasslist = new List<GetClassLIst>();
            DataUtility objDUT = new DataUtility();
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@cityname", cityname);
            DataTable Dt = objDUT.GetDataTableSP(param, "[usp_BindCity]");
            foreach (DataRow dtrow in Dt.Rows)
            {
                GetClassLIst getclasslist = new GetClassLIst();
                getclasslist.CityName = dtrow["cityName"].ToString();
                getclasslist.CityId = dtrow["CTID"].ToString();
                objgetclasslist.Add(getclasslist);
            }
            return objgetclasslist;
        }
        catch (Exception ex)
        {
            List<GetClassLIst> objrefofcity = new List<GetClassLIst>();
            return objrefofcity;
        }
    }

    public class GetClassLIst
    {
        public string CityName { get; set; }

        public string CityId { get; set; }
    }

}
    