using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net.Mail;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_offered_employer_list : System.Web.UI.Page
{
    private SqlParameter[] param1 = new SqlParameter[3];
    private DataUtility objDUT = new DataUtility();

    private DataSet ds;
    private static string myString = "", emailforhost = "", hostname = "", password = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FillDDLAll();
            fillgrid();
        }

        // objDUT.GetDataSetSP("change_offer_letter_status");
    }

    private void fillgrid()
    {
        param1[0] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));

        param1[1] = new SqlParameter("@pagesize", SqlDbType.Int);
        param1[1].Value = 50;

        param1[2] = new SqlParameter("@pageno", SqlDbType.Int);
        param1[2].Value = 1;

        ds = objDUT.GetDataSetSP(param1, "usp_offerlettersearch");

        if (ds.Tables[0].Rows.Count > 0)
        {
            grdOfferLetter.DataSource = ds.Tables[0];
            grdOfferLetter.DataBind();
            hfpages.Value = ds.Tables[1].Rows[0]["pages"].ToString();
            trforpagging.Style.Add("display", "block");
        }
        else
        {
            grdOfferLetter.EmptyDataText = "Currently, offered employee list is not available.";
            grdOfferLetter.DataSource = null;
            grdOfferLetter.DataBind();
            trforpagging.Style.Add("display", "none");
        }
    }

    private void FillDDLAll()
    {
        DataTable dt = objDUT.GetDataTable("select desigID,desigName from designation_master where status=1");
        if (dt.Rows.Count > 0)
        {
            ddldesignation.DataSource = dt;
            ddldesignation.DataValueField = "desigID";
            ddldesignation.DataTextField = "desigName";
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
        ddlstatus.DataSource = CommonClass.ABC("ddlStatus");
        ddlstatus.DataTextField = "StatusName";
        ddlstatus.DataValueField = "StatusId";
        ddlstatus.DataBind();
        ddlstatus.Items.Insert(0, new ListItem("---Select Status---", "0"));
    }

    [WebMethod]
    public static offEmpList[] GetOfferedEmployeelist(string refNo, string name, string mobile, string designationid, string deptid, string id, string emailid, string statusid, int pagesize, int pageno)
    {
        DataSet ds = new DataSet();
        List<offEmpList> details = new List<offEmpList>();

        SqlParameter[] p = new SqlParameter[11];

        p[0] = new SqlParameter("@brid", SqlDbType.VarChar, 50);
        p[0].Value = HttpContext.Current.Session["BrBrid"].ToString();

        p[1] = new SqlParameter("@refno", SqlDbType.VarChar, 200);
        p[1].Value = refNo;

        p[2] = new SqlParameter("@name", SqlDbType.VarChar, 200);
        p[2].Value = name;

        p[3] = new SqlParameter("@mobileno", SqlDbType.VarChar, 200);
        p[3].Value = mobile;

        p[4] = new SqlParameter("@designationid", SqlDbType.VarChar, 50);
        p[4].Value = designationid;

        p[5] = new SqlParameter("@pagesize", SqlDbType.Int);
        p[5].Value = 50;

        p[6] = new SqlParameter("@pageno", SqlDbType.Int);

        if (id != "")
        {
            p[6].Value = 1;
        }
        else
        {
            p[6].Value = pageno;
        }

        p[7] = new SqlParameter("@deptid", SqlDbType.VarChar, 50);
        p[7].Value = deptid;

        p[8] = new SqlParameter("@id", SqlDbType.VarChar, 100);
        p[8].Value = id;

        p[9] = new SqlParameter("@emailid", SqlDbType.VarChar, 100);
        p[9].Value = emailid;

        p[10] = new SqlParameter("@status", SqlDbType.VarChar, 100);
        p[10].Value = statusid;

        DataUtility ObjDUT = new DataUtility();

        ds = ObjDUT.GetDataSetSP(p, "usp_offerlettersearch");

        foreach (DataRow dtrow in ds.Tables[0].Rows)
        {
            offEmpList user = new offEmpList();
            user.RowNumber = dtrow["RowNumber"].ToString();
            user.brid = dtrow["brid"].ToString();
            user.id = dtrow["id"].ToString();
            user.refNo = dtrow["refNo"].ToString();
            user.name = dtrow["name"].ToString();

            user.doi = dtrow["dateofinterview"].ToString();
            user.mobile = dtrow["mobile"].ToString();
            user.emailid = dtrow["emailid"].ToString();
            user.address = dtrow["address"].ToString();
            user.country = dtrow["countryName"].ToString();
            user.state = dtrow["stateName"].ToString();
            if (dtrow["cityName"].ToString() != "")
            {
                user.city = dtrow["cityName"].ToString();
            }
            else
            {
                user.city = dtrow["othercity"].ToString();
            }

            user.pinCode = dtrow["pinCode"].ToString();
            user.gender = dtrow["gender"].ToString();

            user.doj = dtrow["doj"].ToString();
            user.annualCTC = dtrow["annualCTC"].ToString();
            DateTime date = Convert.ToDateTime(dtrow["date"]);
            user.date = date.ToString("dd/MM/yyyy");

            if (dtrow["ctcappliedfrom"].ToString() != null && dtrow["ctcappliedfrom"].ToString() != "")
            {
                DateTime ctcappliedfrom = Convert.ToDateTime(dtrow["ctcappliedfrom"]);
                user.ctcappliedfrom = ctcappliedfrom.ToString("dd/MM/yyyy");
            }
            user.inhandsalary = dtrow["inhandsalary"].ToString();
            user.emplyeetype = dtrow["emplyeetype"].ToString();

            user.department = dtrow["department"].ToString();
            user.desigtype = dtrow["desigtype"].ToString();
            user.hrName = dtrow["hrName"].ToString();
            user.comments = dtrow["comments"].ToString();
            user.status = dtrow["status"].ToString();
            user.statusid = dtrow["statusid"].ToString();
            user.DOB = dtrow["DOB"].ToString();
            user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString();

            details.Add(user);
        }
        return details.ToArray();
    }

    public class offEmpList
    {
        public string RowNumber { get; set; }

        public string DOB { get; set; }

        public string brid { get; set; }

        public string id { get; set; }

        public string refNo { get; set; }

        public string name { get; set; }

        public string designation { get; set; }

        public string mobile { get; set; }

        public string emailid { get; set; }

        public string doi { get; set; }

        public string address { get; set; }

        public string country { get; set; }

        public string state { get; set; }

        public string city { get; set; }

        public string pinCode { get; set; }

        public string gender { get; set; }

        public string annualCTC { get; set; }

        public string date { get; set; }

        public string desigtype { get; set; }

        public string department { get; set; }

        public string doj { get; set; }

        public string hrName { get; set; }

        public string comments { get; set; }

        public string status { get; set; }

        public string statusid { get; set; }

        public string inhandsalary { get; set; }

        public string emplyeetype { get; set; }

        public string ctcappliedfrom { get; set; }

        public string pagecount { get; set; }
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
            MailMessage mm = new MailMessage("noreply@qads.bz", "jaikey@awapalsolutions.com");
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
    public static int sendsmsonmobile(string mobile, string msg)
    {
        string mobileno = mobile;
        string sender = "Awapal Office";
        string message = msg;
        int result1=0;
        if (HttpContext.Current.Session["brbrid"].ToString() != "")
        {
            result1 = sendMessageToMobile.SMSSend(mobileno, message, HttpContext.Current.Session["brbrid"].ToString());
        }
        return result1;
    }
}