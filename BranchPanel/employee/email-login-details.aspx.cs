using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net.Mail;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class branchpanel_employee_send_login_details : System.Web.UI.Page
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
                    if (Convert.ToInt32(mode) == 2)
                    {
                        string Message = "USERNAME:" + Dt.Rows[i]["Loginid"].ToString();
                        Message = Message + ",PASSWORD:" + Dt.Rows[i]["Password"].ToString();
                        Message = Message + ",LOGIN LINK:" + Dt.Rows[i]["Loginlink"].ToString();
                        SendMail(Dt.Rows[i]["Emailid"].ToString(), "Your Login Details---:,", Message);
                        return "email";
                    }
                }
            }
        }
        return "true";
    }

    [WebMethod]
    public static int SendMail(string emailid, string subject, string msg)
    {
        int send = 0;
        DataUtility objUTL = new DataUtility();
        DataTable dtformail = objUTL.GetDataTable("select module_hostname,emialid_for_module,password_of_email from tbl_email_sms_send_master where ModuleId=4");
        if (dtformail.Rows.Count > 0)
        {
            emailforhost = dtformail.Rows[0]["emialid_for_module"].ToString();
            hostname = dtformail.Rows[0]["module_hostname"].ToString();
            password = dtformail.Rows[0]["password_of_email"].ToString();
        }
        if (send == 0)
        {
            MailMessage mm = new MailMessage("noreply@qads.bz", "amitsharma@awapalsolutions.com");
            mm.IsBodyHtml = true;

            StreamReader reader = new StreamReader(System.Web.HttpContext.Current.Server.MapPath("sendmailfromgrid.html"));
            string readFile = reader.ReadToEnd();
            myString = readFile;
            myString = myString.Replace("$$to$$", emailid);
            myString = myString.Replace("$$subject$$", subject);
            myString = myString.Replace("$$msg$$", msg);
            mm.Subject = subject;
            mm.Body = myString;
            System.Net.NetworkCredential webmail = new System.Net.NetworkCredential("noreply@qads.bz", "User@123");
            System.Net.Mail.SmtpClient ms = new SmtpClient("mail.qads.bz");
            ms.UseDefaultCredentials = true;
            ms.Credentials = webmail;
            if (send == 0)
            {
                ms.Send(mm);
                send = 1;
            }
        }
        return send;
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