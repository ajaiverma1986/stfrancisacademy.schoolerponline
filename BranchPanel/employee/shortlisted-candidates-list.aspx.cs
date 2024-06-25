using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net.Mail;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class branchpanel_employee_shortlisted_candidates_list : System.Web.UI.Page
{
    private SqlParameter[] param1 = new SqlParameter[3];
    private DataUtility objDUT = new DataUtility();

    private DataSet ds;
    private static string myString = "", emailforhost = "", hostname = "", password = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                fillgrid();
                FillDDLAll();
            }
        }
        catch (Exception exx)
        {
        }
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
            ddldept.Items.Insert(0, new ListItem("---Select Department---", ""));
        }
    }

    private void fillgrid()
    {
        param1[0] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));

        param1[1] = new SqlParameter("@pagesize", SqlDbType.Int);
        param1[1].Value = 50;

        param1[2] = new SqlParameter("@pageno", SqlDbType.Int);
        param1[2].Value = 1;

        ds = objDUT.GetDataSetSP(param1, "search_shortlisted_emp");

        if (ds.Tables[0].Rows.Count > 0)
        {
            grdforshortlistedemp.DataSource = ds.Tables[0];
            grdforshortlistedemp.DataBind();
            hfpages.Value = ds.Tables[1].Rows[0]["pages"].ToString();
            trforpagging.Style.Add("display", "block");
        }
        else
        {
            grdforshortlistedemp.EmptyDataText = "Currently, shortlisted employee list is not available.";
            grdforshortlistedemp.DataSource = null;
            grdforshortlistedemp.DataBind();
            trforpagging.Style.Add("display", "none");
        }
    }

    [WebMethod]
    public static offEmpList[] GetShortlistedEmp(string name, string mobile, string designationid, string deptid, string shortlistedid, string emailid, int pagesize, int pageno)
    {
        DataSet ds = new DataSet();
        List<offEmpList> details = new List<offEmpList>();

        SqlParameter[] p = new SqlParameter[9];
        p[0] = new SqlParameter("@brid", SqlDbType.VarChar, 50);
        p[0].Value = HttpContext.Current.Session["BrBrid"].ToString();

        p[1] = new SqlParameter("@name", SqlDbType.VarChar, 200);
        p[1].Value = name;

        p[2] = new SqlParameter("@mobileno", SqlDbType.VarChar, 200);
        p[2].Value = mobile;

        p[3] = new SqlParameter("@designationid", SqlDbType.VarChar, 50);
        p[3].Value = designationid;

        p[4] = new SqlParameter("@pagesize", SqlDbType.Int);
        p[4].Value = 50;

        p[5] = new SqlParameter("@pageno", SqlDbType.Int);
        p[5].Value = pageno;

        p[6] = new SqlParameter("@deptid", SqlDbType.VarChar, 50);
        p[6].Value = deptid;

        p[7] = new SqlParameter("@id", SqlDbType.VarChar, 100);
        p[7].Value = shortlistedid;

        p[8] = new SqlParameter("@emailid", SqlDbType.VarChar, 100);
        p[8].Value = emailid;

        DataUtility ObjDUT = new DataUtility();

        ds = ObjDUT.GetDataSetSP(p, "search_shortlisted_emp");

        foreach (DataRow dtrow in ds.Tables[0].Rows)
        {
            offEmpList user = new offEmpList();
            user.RowNumber = dtrow["RowNumber"].ToString();
            //user.brid = dtrow["brid"].ToString();
            user.shortlistedid = dtrow["shortcanid"].ToString();
            user.name = dtrow["name2"].ToString();

            user.contact_no = dtrow["contact_no"].ToString();
            user.email_id = dtrow["email_id"].ToString();
            user.address = dtrow["address"].ToString();
            user.pinCode = dtrow["pinCode"].ToString();
            user.country = dtrow["countryName"].ToString();
            user.state = dtrow["stateName"].ToString();
            user.city = dtrow["cityName"].ToString();
            user.imagename = dtrow["imagename"].ToString();
            user.expected_ctc_per_annum = dtrow["expected_ctc_per_annum"].ToString();
            user.current_ctc_per_annum = dtrow["current_ctc_per_annum"].ToString();

            user.experience_year = dtrow["experience_year"].ToString();
            user.experience_month = dtrow["experience_month"].ToString();
            user.experience_day = dtrow["experience_day"].ToString();

            user.department = dtrow["deptName"].ToString();
            user.remak = dtrow["remak"].ToString();
            user.gender = dtrow["gender"].ToString();
            user.shortlisted_day = dtrow["shortlisted_day"].ToString();
            user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString();

            details.Add(user);
        }
        return details.ToArray();
    }

    public class offEmpList
    {
        public string RowNumber { get; set; }

        public string brid { get; set; }

        public string shortlistedid { get; set; }

        public string name { get; set; }

        public string contact_no { get; set; }

        public string email_id { get; set; }

        public string address { get; set; }

        public string country { get; set; }

        public string state { get; set; }

        public string city { get; set; }

        public string pinCode { get; set; }

        public string gender { get; set; }

        public string cv_name { get; set; }

        public string expected_ctc_per_annum { get; set; }

        public string department { get; set; }

        public string current_ctc_per_annum { get; set; }

        public string experience_year { get; set; }

        public string experience_month { get; set; }

        public string experience_day { get; set; }

        public string shortlisted_day { get; set; }

        public string imagename { get; set; }

        public string remak { get; set; }

        public string pagecount { get; set; }
    }

    [WebMethod]
    public static int SendMail(string emailid, string subject, string msg)
    {
        int send = 0;
        try
        {
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
                MailMessage mm = new MailMessage(emailforhost, emailid);
                mm.IsBodyHtml = true;

                StreamReader reader = new StreamReader(System.Web.HttpContext.Current.Server.MapPath("sendmailfromgrid.html"));
                string readFile = reader.ReadToEnd();
                myString = readFile;
                myString = myString.Replace("$$to$$", emailid);
                myString = myString.Replace("$$subject$$", subject);
                myString = myString.Replace("$$msg$$", msg);
                mm.Subject = subject;
                mm.Body = myString;
                System.Net.NetworkCredential webmail = new System.Net.NetworkCredential(emailforhost, password);
                System.Net.Mail.SmtpClient ms = new SmtpClient(hostname);
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
        catch (Exception exx)
        {
            return 2;
        }
    }
}