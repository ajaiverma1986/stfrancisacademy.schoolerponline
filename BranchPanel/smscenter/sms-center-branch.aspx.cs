using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;
public partial class BranchPanel_sms_center_branch : System.Web.UI.Page
{
    private DataTable dt, dt1;
    private DataUtility objdut = new DataUtility();
    private string url = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!IsPostBack)
        {
            fillsource();
            BindSessionDDL();
            getempnames();
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
    [WebMethod]
    public static GetStatusDetails[] BindGridByJs(string facultyname, string facultymob, string department, string designation)
    {
        DataSet Ds = new DataSet();
        List<GetStatusDetails> StatusDetails = new List<GetStatusDetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[5];
        Param[0] = new SqlParameter("@Name", facultyname);
        Param[1] = new SqlParameter("@Mobile", facultymob);
        Param[2] = new SqlParameter("@deptid", department);
        Param[3] = new SqlParameter("@designationid", designation);
        Param[4] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        Ds = Objdut.GetDataSetSP(Param, "[usp_Bindsmsfaculty]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                GetStatusDetails user = new GetStatusDetails();
                user.BindGridDataforemp = dtrow["BindGridDataforemp"].ToString();
                user.mobilenum = dtrow["mobilenum"].ToString();
                user.facultyid = dtrow["eid"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
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
    public static GetstudentDetails[] BindGridforstudent(string stunames, string stumob, string fromdate, string todate, int courseid, string checkcoursejoin, int fyid)
    {
        DataSet Ds = new DataSet();
        List<GetstudentDetails> studentDetails = new List<GetstudentDetails>();
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
        Ds = Objdut.GetDataSetSP(param, "[usp_Bindsmsstudent]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                GetstudentDetails user = new GetstudentDetails();
                user.BindGridDataforstu = dtrow["BindGridDataforstu"].ToString();
                user.rollnumber = dtrow["Classname"].ToString();
                user.studentId = dtrow["RID"].ToString();
                user.GuardianPhone = dtrow["PrimaryMobileNo"].ToString();
                studentDetails.Add(user);
            }
        }
        return studentDetails.ToArray();
    }
    public class GetstudentDetails
    {
        public string BindGridDataforstu { get; set; }
        public string studentId { get; set; }
        public string rollnumber { get; set; }
        public string GuardianPhone { get; set; }
    }
    [WebMethod]
    public static int smssendglobal(string PerTypeID, string GlobalEID, string globalsmstoall, string message, int apiforsms)
    {
        int result = 0,userid=0;
        userid =Convert.ToInt32(HttpContext.Current.Session["BRADID"]);
        int Brid = Convert.ToInt32(HttpContext.Current.Session["Brbrid"]);
        message = message.Replace("~", "'");
        try
        {
            System.Threading.Thread ThreadUpdateGrowthMocha = new System.Threading.Thread(delegate()
            {
                result = SendSMSFromMessagecenter(PerTypeID, GlobalEID, globalsmstoall, "Awapal Office", message, apiforsms, userid, Brid);
            });
            ThreadUpdateGrowthMocha.Start();
        }
        catch
        {

        }       
        result = 1;
        return result;
    }
    public static int SendSMSFromMessagecenter(string PerTypeID, string GlobalEID, string Mobileno, string sender, string Message, int apitype, int userid, int Brid)
    {
        DataUtility Objdut = new DataUtility();
        int result = 0;
        string api = (string)(Objdut.GetScalar("select isnull(sms_api,'') sms_api from tbl_smsapisetting where Brid=" + Brid + " and status=1"));
        if (api != null)
        {
            string[] Mobile;
            Mobile = Mobileno.Split(',');

            string[] EID;
            EID = GlobalEID.Split(',');
            if (Mobile.Length > 0)
            {
                for (int i = 0; i < Mobile.Length; i++)
                {
                    if (Mobile[i].ToString().Length > 9)
                    {
                        result = sendMessageToMobile.SMSSend(Mobile[i].ToString(), Message, api);
                        SqlParameter[] smssend = new SqlParameter[10];
                        smssend[0] = new SqlParameter("@mode", 11);
                        smssend[1] = new SqlParameter("@mobile", Mobile[i].ToString());
                        smssend[2] = new SqlParameter("@Message", Message);
                        smssend[3] = new SqlParameter("@UserId", userid);
                        smssend[4] = new SqlParameter("@ModuleId", 19);
                        smssend[5] = new SqlParameter("@brid", Brid);
                        smssend[6] = new SqlParameter("@EID", EID[i].ToString());
                        smssend[7] = new SqlParameter("@PerTypeID", Convert.ToInt32(PerTypeID));
                        smssend[8] = new SqlParameter("@intResult", DbType.Int32);
                        smssend[8].Direction = ParameterDirection.Output;
                        if (result == 1)
                        {
                            smssend[9] = new SqlParameter("@status", Convert.ToInt32(1));
                        }
                        else
                        {
                            smssend[9] = new SqlParameter("@status", Convert.ToInt32(0));
                        }
                        Objdut.ExecuteSqlSP(smssend, "[usp_general_master_setting]");
                    }
                }
            }
        }
        return result;
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
            if(ds.Tables.Count>=4)
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