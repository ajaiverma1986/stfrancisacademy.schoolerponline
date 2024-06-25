using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI;
using System.Web;

public partial class BranchPanel_commonpage_list_of_holiday : System.Web.UI.Page
{
    private CommonClass commonOBJ = new CommonClass();
    CommonClass CommonClass = new CommonClass();
    private static int fyid = 2,brid=0;
    private DataUtility objDUT = new DataUtility();
    DataUtility obj = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        fyid = CommonClass.GetActiveAcedmicYear();
        if (!IsPostBack)
        {
           
            FillDDLAll();
            Branch();
            BindCalender();     
        }
    }

    protected void FillDDLAll()
    {
        DateTime moment = DateTime.Now;
        ddlmonth.DataSource = CommonClass.ABC("DdlMonthinDatePicker");
        ddlmonth.DataTextField = "Month_Name";
        ddlmonth.DataValueField = "Month_Id";
        ddlmonth.DataBind();
        ddlmonth.SelectedValue = moment.Month.ToString();
    }
    public void Branch()
    {
       
        DataTable dt = new DataTable();
        dt = obj.GetDataTable("select Brid,BrName from Branch_master where BrActive=1 and isDeleted=0 and isActive=1");
        if (dt.Rows.Count > 0)
        {
            ddlbranch.DataSource = dt;
            ddlbranch.DataValueField = "Brid";
            ddlbranch.DataTextField = "BrName";
            ddlbranch.DataBind();
        }

    }
    protected void BindCalender()
    {
        DateTime moment = DateTime.Now;
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@fyid",fyid);
        param[1] = new SqlParameter("@Month",moment.Month.ToString());
        param[2] = new SqlParameter("@Brid", ddlbranch.SelectedValue);
        DataTable Dt = objDUT.GetDataTableSP(param, "[usp_listofholiday]");
        if (Dt.Rows.Count > 0)
        {
            Grid_Calender.DataSource = Dt;
            Grid_Calender.DataBind();
        }
    }

    [WebMethod]
    public static getmonths[] BindDbDatePicker(string month, string BrId)
    {
        DataSet ds = new DataSet();
        List<getmonths> details = new List<getmonths>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_listofholiday]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@fyid", fyid);
                param[1] = new SqlParameter("@Month", month);
                param[2] = new SqlParameter("@Brid", BrId);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getmonths user = new getmonths();
                        user.mon = dtrow["Mon"].ToString();
                        user.tue = dtrow["Tue"].ToString();
                        user.wed = dtrow["Wed"].ToString();
                        user.thu = dtrow["Thr"].ToString();
                        user.fri = dtrow["Fri"].ToString();
                        user.sat = dtrow["Sat"].ToString();
                        user.sun = dtrow["Sun"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getmonths
    {
        public string mon { get; set; }

        public string tue { get; set; }

        public string wed { get; set; }

        public string thu { get; set; }

        public string fri { get; set; }

        public string sat { get; set; }

        public string sun { get; set; }
    }

    protected void ddlbranch_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}