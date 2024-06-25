using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class branchpanel_employee_sms_login_details : System.Web.UI.Page
{
    private SqlParameter[] param1 = new SqlParameter[3];
    private DataUtility objDUT = new DataUtility();
    private DataTable Dt;
    private static string myString = "", emailforhost = "", hostname = "", password = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BinDGrid();
            FillDDLAll();
        }
    }

    public void BinDGrid()
    {
        Dt = objDUT.GetDataTableSP("usp_BindDataForSmsOrEmail");
        gridforsendmailorsms.DataSource = Dt;
        gridforsendmailorsms.DataBind();
    }

    private void FillDDLAll()
    {
        DataTable dt = objDUT.GetDataTable("select desid,desname from tbl_ddmaster where status=1");
        if (dt.Rows.Count > 0)
        {
            ddldesignation.DataSource = dt;
            ddldesignation.DataValueField = "desid";
            ddldesignation.DataTextField = "desname";
            ddldesignation.DataBind();
            ddldesignation.Items.Insert(0, new ListItem("---Select Designation---", ""));
        }
        DataTable dtfordept = objDUT.GetDataTable("select deptid,deptname from dept_master where status=1");
        if (dtfordept.Rows.Count > 0)
        {
            ddldept.DataSource = dtfordept;
            ddldept.DataTextField = "deptname";
            ddldept.DataValueField = "deptid";
            ddldept.DataBind();
            ddldept.Items.Insert(0, new ListItem("---Select Department---", "0"));
        }
    }

    [WebMethod]
    public static string GetDetilsByEid(string allselectedeid, string mode)
    {
        DataTable Dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_getemployeedetailsforsendlogindetails]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[9];
                param[0] = new SqlParameter("@empid", allselectedeid);
                param[1] = new SqlParameter("@mode", Convert.ToInt32(mode));
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(Dt);
                for (int i = 0; i <= Dt.Rows.Count; i++)
                {
                    if (Convert.ToInt32(mode) == 1)
                    {
                        string Message = "Your Login Details---:,";
                        Message = Message + "USERNAME:" + Dt.Rows[i]["Loginid"].ToString();
                        Message = Message + ",PASSWORD:" + Dt.Rows[i]["Password"].ToString();
                        Message = Message + ",LOGIN LINK:" + Dt.Rows[i]["Loginlink"].ToString();
                        sendsmsonmobile(Dt.Rows[i]["Mobile"].ToString(), Message);
                        return "sms";
                    }
                }
            }
        }
        return "true";
    }

    [WebMethod]
    public static int sendsmsonmobile(string mobile, string msg)
    {
        string mobileno = mobile;
        string sender = "Awapal Office";
        string message = msg;
        int result1 = 0;
        if(HttpContext.Current.Session["brbrid"].ToString()!="")
        {
            result1 = sendMessageToMobile.SMSSend(mobileno, sender, HttpContext.Current.Session["brbrid"].ToString());
        }
        return result1;
    }

    [WebMethod]
    public static getmonths[] BindGridByJs(string name = "", string mobileno = "", string emailid = "", string loginid = "", string deptartment = "0", string designation = "0")
    {
        DataSet ds = new DataSet();
        List<getmonths> details = new List<getmonths>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_BindDataForSmsOrEmail]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[6];
                param[0] = new SqlParameter("@name", name);
                param[1] = new SqlParameter("@mobileno", mobileno);
                param[2] = new SqlParameter("@emailid", emailid);
                param[3] = new SqlParameter("@loginid", loginid);
                param[4] = new SqlParameter("@deptartment", deptartment);
                param[5] = new SqlParameter("@designation", designation);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getmonths user = new getmonths();
                        user.eid = dtrow["eid"].ToString();
                        user.Name = dtrow["Name"].ToString();
                        user.username = dtrow["username"].ToString();
                        user.password = dtrow["password"].ToString();
                        user.emailID = dtrow["emailID"].ToString();
                        user.mobile = dtrow["mobile"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getmonths
    {
        public string eid { get; set; }

        public string Name { get; set; }

        public string username { get; set; }

        public string password { get; set; }

        public string emailID { get; set; }

        public string mobile { get; set; }
    }
}