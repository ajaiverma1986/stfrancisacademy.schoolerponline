using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_EmailCenter_email_center : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        BindSessionDDL();
       
        getempnames();
        if (!IsPostBack)
        {
            fillsource();
        }
    }
    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlfyear.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlfyear.DataValueField = "Fyid";
        ddlfyear.DataTextField = "FYName";
        ddlfyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    [WebMethod]
    public static BIndClass[] BindClassDDL(string Fyid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(Fyid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        List<BIndClass> BindObj = new List<BIndClass>();
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            BIndClass Obj = new BIndClass();
            Obj.ID = Dt.Rows[i]["classid"].ToString();
            Obj.ClassName = Dt.Rows[i]["Classname"].ToString();
            BindObj.Add(Obj);
        }
        return BindObj.ToArray();
    }
    public class BIndClass
    {
        public string ID { get; set; }
        public string ClassName { get; set; }
    }
    [WebMethod]
    public static GetstudentDetails[] BindGridforstudent(string stunames, string stumob, string fromdate, string todate, string classid, string studentstatus, int fyid, string emailidforsearch)
    
    {
        DataSet Ds = new DataSet();
        List<GetstudentDetails> studentDetails = new List<GetstudentDetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[9];
        param[0] = new SqlParameter("@Name", stunames);
        param[1] = new SqlParameter("@ParentMobileNo", stumob);
        param[2] = new SqlParameter("@AdmissionFromDate", fromdate);
        param[3] = new SqlParameter("@AdmissionToDate", todate);
        param[4] = new SqlParameter("@applyingforclass", classid);
        param[5] = new SqlParameter("@status", studentstatus);
        param[6] = new SqlParameter("@Fyid", fyid);
        param[7] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        param[8] = new SqlParameter("@EmailIdForSearch", emailidforsearch);
        Ds = Objdut.GetDataSetSP(param, "[usp_Bindsmsstudent]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                GetstudentDetails user = new GetstudentDetails();
                user.Name = dtrow["Name"].ToString();
                user.Email = dtrow["Email"].ToString();
                user.Classname = dtrow["Classname"].ToString();
                user.BindGridData = dtrow["BindGridData"].ToString();
                studentDetails.Add(user);
            }
        }
        return studentDetails.ToArray();
    }
    public class GetstudentDetails
    {
        public string Name { get; set; }

        public string Email { get; set; }

        public string Classname { get; set; }

        public string BindGridData { get; set; }
    }
    [WebMethod]
    public static GetStatusDetails[] BindGridByJs(string facultyname, string facultymob, string department, string designation, string emailidforsearch)
    {
        DataSet Ds = new DataSet();
        List<GetStatusDetails> StatusDetails = new List<GetStatusDetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[6];
        Param[0] = new SqlParameter("@Name", facultyname);
        Param[1] = new SqlParameter("@Mobile", facultymob);
        Param[2] = new SqlParameter("@deptid", department);
        Param[3] = new SqlParameter("@designationid", designation);
        Param[4] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        Param[5] = new SqlParameter("@EmailIdForSearch", emailidforsearch);
        Ds = Objdut.GetDataSetSP(Param, "[usp_Bindsmsfaculty]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                GetStatusDetails user = new GetStatusDetails();
                user.EmailId = dtrow["emailID"].ToString();
                user.DtatForBindGrid = dtrow["BindGridData"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class GetStatusDetails
    {
        public string DtatForBindGrid { get; set; }

        public string EmailId { get; set; }
    }
    [WebMethod]
    public static getdesignation[] getdegnitaion(string did)
    {
        List<getdesignation> details = new List<getdesignation>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select desigName,desigid from designation_master where status=1 and deptid='" + did + "'", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                getdesignation objdeg = new getdesignation();
                objdeg.desigid = Convert.ToInt32("0");
                objdeg.desigName = "---Select Designation---";
                details.Add(objdeg);
                foreach (DataRow dtrow in dt.Rows)
                {
                    getdesignation objdesignation = new getdesignation();
                    objdesignation.desigid = Convert.ToInt32(dtrow["desigid"].ToString());
                    objdesignation.desigName = dtrow["desigName"].ToString();
                    details.Add(objdesignation);
                }
            }
        }
        return details.ToArray();
    }
    public class getdesignation
    {
        public int desigid { get; set; }

        public string desigName { get; set; }
    }
    private void getempnames()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@brid", Session["BrBrid"]);
        DataTable dt = new DataTable();
        dt = objdut.GetDataTable("select deptName,deptid from dept_master where status =1");
        ddlfacultydeptnstuname.DataTextField = "deptName";
        ddlfacultydeptnstuname.DataValueField = "deptid";
        ddlfacultydeptnstuname.DataSource = dt;
        ddlfacultydeptnstuname.DataBind();
        ddlfacultydeptnstuname.Items.Insert(0, new ListItem("---Select Department---", "0"));
        dt.Clear();
        dt = objdut.GetDataTable("select desigName,desigid from designation_master where status=1 ");
        ddlstudesg.DataTextField = "desigName";
        ddlstudesg.DataValueField = "desigid";
        ddlstudesg.DataSource = dt;
        ddlstudesg.DataBind();
        ddlstudesg.Items.Insert(0, new ListItem("---Select Designation---", "0"));
        dt.Clear();
    }
    protected void btnsendmail_Click(object sender, EventArgs e)
    {
        System.Threading.Thread ThreadEmailMsgOnRegister = new System.Threading.Thread(delegate()
       {
            SendPromotionalEmail();
        });
        ThreadEmailMsgOnRegister.Start();
        divformessage.Visible = true;
    }
    public void SendPromotionalEmail()
    {
        string EmailIdForMail = "", SubjectForMail = "", MailContent = "";
        SubjectForMail = txtmailsubject.Text.Trim();
        MailContent = ftCreateMail.Text.Trim();
        MailContent = MailContent.Replace("/BranchPanel/EmailCenter/email_document/", "http://schooldemo.awapalsolutions.com/BranchPanel/EmailCenter/email_document/");
        EmailIdForMail = Request.Form[hfforsendmail.UniqueID];
        DataUtility Objdut = new DataUtility();
        DataTable Dt = new DataTable();
        Dt = objdut.GetDataTable(@"Select (emialid_for_module)As EmailId,(Password_of_email)As Password,(Module_hostname)As HostName,
        (smtp_port) As PortNo From  tbl_email_sms_send_master Where  ModuleName='HR MANAGEMENT'");
        SendMail.SendDemo(Convert.ToString(Dt.Rows[0]["EmailId"]), EmailIdForMail, "", "", SubjectForMail, MailContent, Convert.ToString(Dt.Rows[0]["Password"]),
        Convert.ToString(Dt.Rows[0]["HostName"]));
    }
    private void fillsource()
    {
        string q1 = "usp_bindsourceProductstatus";
        DataSet ds = objdut.GetDataSetSP(q1);
        DataTable dtcntry;
        dtcntry = ds.Tables[4];
        if (dtcntry.Rows.Count > 0)
        {
            ddlsearchingstatus.DataSource = dtcntry;
            ddlsearchingstatus.DataValueField = "esid";
            ddlsearchingstatus.DataTextField = "statusname";
            ddlsearchingstatus.DataBind();
            ListItem li = new ListItem("-Status-", "0");
            ddlsearchingstatus.Items.Insert(0, li);
        }
    }

    public class NoOfEnquiry
    {
        public string enquiry { get; set; }

        public string checkapi { get; set; }

        public string email { get; set; }
    }

    [WebMethod]
    public static NoOfEnquiry[] countenquiry(string classid, string enqstatus, string fromdate, string todate)
    {
        DataUtility ObjDut = new DataUtility();
        List<NoOfEnquiry> details = new List<NoOfEnquiry>();
        SqlParameter[] param = new SqlParameter[5];
        DataSet ds = new DataSet();
        param[0] = new SqlParameter("@searbyproduct", classid);
        param[1] = new SqlParameter("@searchbystatus", enqstatus);
        param[2] = new SqlParameter("@fromdate", fromdate);
        param[3] = new SqlParameter("@TODATE", todate);
        param[4] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        ds = ObjDut.GetDataSetSP(param, "Usp_CountEnquiry");
        if (ds.Tables.Count > 0)
        {
            NoOfEnquiry objenquiry = new NoOfEnquiry();
            objenquiry.enquiry = ds.Tables[0].Rows[0]["enquiry"].ToString();
            objenquiry.checkapi = ds.Tables[3].Rows[0]["checkapi"].ToString();
            objenquiry.email = ds.Tables[2].Rows[0]["email"].ToString();
            details.Add(objenquiry);
        }
        return details.ToArray();
    }
}