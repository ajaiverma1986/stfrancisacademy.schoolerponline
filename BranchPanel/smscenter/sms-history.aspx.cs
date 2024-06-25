using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_smscenter_sms_history : System.Web.UI.Page
{
    private DataTable dt, dt1;
    private DataUtility objdut = new DataUtility();
    private string url = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillsource();
            BindSessionDDL();
            getempnames();
        }   
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
        ddlfacultydeptnstuname.Items.Insert(0, new ListItem("--Select Department--", "0"));
        dt.Clear();

        dt = objdut.GetDataTable("select desigName,desigid from designation_master where status=1 ");
        ddlstudesg.DataTextField = "desigName";
        ddlstudesg.DataValueField = "desigid";
        ddlstudesg.DataSource = dt;
        ddlstudesg.DataBind();
        ddlstudesg.Items.Insert(0, new ListItem("--Select Designation--", "0"));
        dt.Clear();
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
    public static GetSmsDetails[] BindGridforstudent(string stunames, string stumob, string fromdate, string todate, int courseid, string checkcoursejoin, int fyid)
    {
        DataSet Ds = new DataSet();
        List<GetSmsDetails> studentDetails = new List<GetSmsDetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[8];
        param[0] = new SqlParameter("@Name", stunames);
        param[1] = new SqlParameter("@ParentMobileNo", stumob);
        param[2] = new SqlParameter("@AdmissionFromDate", fromdate);
        param[3] = new SqlParameter("@AdmissionToDate", todate);
        param[4] = new SqlParameter("@applyingforclass", courseid);
        param[5] = new SqlParameter("@status", checkcoursejoin);
        param[6] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        param[7] = new SqlParameter("@Fyid", fyid);
        Ds = Objdut.GetDataSetSP(param, "[usp_BindsmsHISTORYstudent]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow Dtrow in Ds.Tables[0].Rows)
            {
                GetSmsDetails user = new GetSmsDetails();
                user.Date = Dtrow["Date"].ToString();
                user.Time = Dtrow["Time"].ToString();
                user.Message = Dtrow["Message"].ToString();
                user.Mobile = Dtrow["Mobile"].ToString();
                user.Name = Dtrow["Name"].ToString();
                user.Status = Dtrow["Status"].ToString();
                studentDetails.Add(user);
            }
        }
        return studentDetails.ToArray();
    }
    [WebMethod]
    public static GetSmsDetails[] BindGridByJs(string facultyname, string facultymob, string department, string designation)
    {
        DataSet Ds = new DataSet();
        List<GetSmsDetails> Details = new List<GetSmsDetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[5];
        Param[0] = new SqlParameter("@Name", facultyname);
        Param[1] = new SqlParameter("@Mobile", facultymob);
        Param[2] = new SqlParameter("@deptid", department);
        Param[3] = new SqlParameter("@designationid", designation);
        Param[4] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        Ds = Objdut.GetDataSetSP(Param, "[usp_BindsmsHISTORYfaculty]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow Dtrow in Ds.Tables[0].Rows)
            {
                GetSmsDetails user = new GetSmsDetails();
                user.Date = Dtrow["Date"].ToString();
                user.Time = Dtrow["Time"].ToString();
                user.Message = Dtrow["Message"].ToString();
                user.Mobile = Dtrow["Mobile"].ToString();
                user.Name = Dtrow["Name"].ToString();
                user.Status = Dtrow["Status"].ToString();
                Details.Add(user);
            }
        }
        return Details.ToArray();
    }
    public class GetStatusDetails
    {
        public string Name { get; set; }

        public string mobilenum { get; set; }

        public string facultyid { get; set; }

        public string empcode { get; set; }

        public string BindGridDataforemp { get; set; }
    }
    [WebMethod]
    public static GetSmsDetails[] BindGridOfSmsDetails()
    {
        DataSet Ds = new DataSet();
        List<GetSmsDetails> Details = new List<GetSmsDetails>();
        DataUtility Objdut = new DataUtility();
        Ds = Objdut.GetDataSet(@"Select Sr.brid,eid,Sr.StudentFirstName+' '+ StudentMiddleName+' '+StudentLastName as Name, CONVERT(varchar(15),CAST(sms_time AS TIME),100) As Time,Convert(Varchar(11),sms_date,106)As Date,(Sms_Text)As Message,(Mobile_No) As Mobile,CASE SH.Status When 1 Then 'Yes' ELSE 'NO' END AS Status From tbl_sms_history SH
                inner join tbl_StudentRegistration SR on SR.RID = SH.eid and SR.Brid = SH.Brid where Sr.Brid=" + HttpContext.Current.Session["BrBrid"] + " order by smsid desc, sms_time desc");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow Dtrow in Ds.Tables[0].Rows)
            {
                GetSmsDetails user = new GetSmsDetails();
                user.Date = Dtrow["Date"].ToString();
                user.Time = Dtrow["Time"].ToString();
                user.Message = Dtrow["Message"].ToString();
                user.Mobile = Dtrow["Mobile"].ToString();
                user.Name = Dtrow["Name"].ToString();
                user.Status = Dtrow["Status"].ToString();
                Details.Add(user);
            }
        }
        return Details.ToArray();
    }

    public class GetSmsDetails
    {
        public string Name { get; set; }
        public string Date { get; set; }

        public string Time { get; set; }

        public string Message { get; set; }

        public string Mobile { get; set; }
        public string Status { get; set; }

    }
    public class getdesignation
    {
        public int desigid { get; set; }
        public string desigName { get; set; }
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
    public class getemployee
    {
        public int eid { get; set; }
        public string empname { get; set; }
    }
    [WebMethod]
    public static getemployee[] getemployeename(string did, string degid)
    {
        List<getemployee> details = new List<getemployee>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            string query = "Select name as empname, facultyid from faculty_master where status = 1 and brid='" + HttpContext.Current.Session["BRBRID"] + "'";

            if (did != "0" && degid == "0")
            {
                query = query + " and dept_id='" + did + "'";
            }
            else if (did == "0" && degid != "0")
            {
                query = query + " and desig_id='" + degid + "'";
            }
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                getemployee objdeg = new getemployee();
                objdeg.eid = Convert.ToInt32("0");
                objdeg.empname = "";
                details.Add(objdeg);
                foreach (DataRow dtrow in dt.Rows)
                {
                    getemployee objdesignation = new getemployee();
                    objdesignation.eid = Convert.ToInt32(dtrow["facultyid"].ToString());
                    objdesignation.empname = dtrow["empname"].ToString();
                    details.Add(objdesignation);
                }
            }
        }
        return details.ToArray();
    }
    private void fillsource()
    {
        DataUtility ObjDut = new DataUtility();
        string q1 = "usp_bindsourceProductstatus";
        DataSet ds = ObjDut.GetDataSetSP(q1);
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
    [WebMethod]
    public static NoOfEnquiry[] countenquiry(string courseid, string enqstatus, string fromdate, string todate)
    {
        DataUtility ObjDut = new DataUtility();
        List<NoOfEnquiry> details = new List<NoOfEnquiry>();
        SqlParameter[] param = new SqlParameter[5];
        DataSet ds = new DataSet();
        param[0] = new SqlParameter("@searbyproduct", courseid);
        param[1] = new SqlParameter("@searchbystatus", enqstatus);
        param[2] = new SqlParameter("@fromdate", fromdate);
        param[3] = new SqlParameter("@TODATE", todate);
        param[4] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        ds = ObjDut.GetDataSetSP(param, "Usp_CountEnquiry");
        if (ds.Tables.Count > 0)
        {
            NoOfEnquiry objenquiry = new NoOfEnquiry();
            objenquiry.enquiry = ds.Tables[0].Rows[0]["enquiry"].ToString();
            if (ds.Tables.Count >= 4)
                objenquiry.checkapi = ds.Tables[3].Rows[0]["checkapi"].ToString();
            if (ds.Tables.Count >= 2)
                objenquiry.mobile = ds.Tables[1].Rows[0]["mobile"].ToString();
            details.Add(objenquiry);
        }
        return details.ToArray();
    }
    public class NoOfEnquiry
    {
        public string enquiry { get; set; }

        public string checkapi { get; set; }

        public string mobile { get; set; }
    }
}