using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Timetable_create_timetable_schedule : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    DataUtility Objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDDl();
        }
    }
    protected void BindDDl()
    {
        DataTable Dt = new DataTable();
        Dt= CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@brid",Session["BrBrid"]);
        param[2] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
        dt = Objdut.GetDataTableSP(param, "Usp_Class");
        if (dt.Rows.Count > 0)
        {
            ddlclass.DataSource = dt;
            ddlclass.DataValueField = "classid";
            ddlclass.DataTextField = "Classname";
            ddlclass.DataBind();  
        }
        ddlclass.Items.Insert(0, new ListItem("--Select Class--", "0"));
        ddlsection.Items.Insert(0, new ListItem("--Select Section--", "0"));
    }
    public static List<string> GetTimeIntervals()
    {
        List<string> timeIntervals = new List<string>();
        DateTime date = DateTime.MinValue.AddHours(6); // start at 6am
        DateTime endDate = DateTime.MinValue.AddDays(1).AddHours(6); // end at 5:45am (< 6am)

        while (date < endDate)
        {
            timeIntervals.Add(date.ToShortTimeString());
            date = date.AddMinutes(5);
        }
        return timeIntervals;
    }

    public class Section
    {
        public int cwsid { get; set; }

        public string sectionname { get; set; }
    }
    [WebMethod]
    public static Section[] Sectionname(string classid)
    {
        DataUtility objdut = new DataUtility();
        List<Section> Details = new List<Section>();
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@classid", classid);
        param[1] = new SqlParameter("@brid",HttpContext.Current.Session["BrBrid"]);
        param[2] = new SqlParameter("@mode",5);
        dt = objdut.GetDataTableSP(param, "[Usp_timetablesettingsdetails]");
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in dt.Rows)
            {
                Section Dsdetails = new Section();
                Dsdetails.cwsid = Convert.ToInt32(dtrow["cwsid"].ToString());
                Dsdetails.sectionname = dtrow["sectionname"].ToString();
                Details.Add(Dsdetails);
            }
        }
        return Details.ToArray();
    }



    public class CourseScheduleList
    {
        public string dayname { get; set; }

        public string did { get; set; }

        //public string Classid { get; set; }

       public string Status { get; set; }
    }


    [WebMethod]
    public static CourseScheduleList[] fillClassScheduleList(string classid, string fyid,string sectionid)
    {
        DataTable dt = new DataTable();
        List<CourseScheduleList> details = new List<CourseScheduleList>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@classid",classid);
        param[1] = new SqlParameter("@fyid", fyid);
        param[2] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);
        param[3] = new SqlParameter("@mode",6);
        param[4] = new SqlParameter("@sectionid", sectionid);
        dt = ObjDUT.GetDataTableSP(param, "[Usp_timetablesettingsdetails]");
        foreach (DataRow dtrow in dt.Rows)
        {
            CourseScheduleList user = new CourseScheduleList();
            user.did = dtrow["did"].ToString();
            user.dayname = dtrow["dayname"].ToString();
            //user.Classid = dtrow["Classid"].ToString();
            user.Status = dtrow["Status"].ToString();
            details.Add(user);
        }
        return details.ToArray();
    }

    [WebMethod]
    public static int savetimetable(string classid, string dayid, string Periodid, string subjectid, string teacherid, string fyid, string fromdate, string todate, string sectionid, string remark, string subjectname, string teachername, string starttime)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[17];
        param[0] = new SqlParameter("@pid", Periodid);
        param[1] = new SqlParameter("@classid", classid);
        param[2] = new SqlParameter("@sectionid", sectionid);
        param[3] = new SqlParameter("@subjectid", subjectid);
        param[4] = new SqlParameter("@dayid", dayid);
        param[5] = new SqlParameter("@teacherid", teacherid);
        param[6] = new SqlParameter("@fyid", fyid);
        param[7] = new SqlParameter("@intresult", SqlDbType.Int);
        param[7].Direction = ParameterDirection.Output;
        param[8] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);
        param[9] = new SqlParameter("@fromdate", fromdate);
        param[10] = new SqlParameter("@todate", todate);
        param[11] = new SqlParameter("@userid", HttpContext.Current.Session["BrADID"]);
        param[12] = new SqlParameter("@remark", remark);
        param[13] = new SqlParameter("@mode",9);
        param[14] = new SqlParameter("@subjectname", subjectname);
        param[15] = new SqlParameter("@teachername", teachername);
        param[16] = new SqlParameter("@StartTime", starttime);
        int res = Objdut.ExecuteSqlSP(param, "[Usp_timetablesettingsdetails]");
        return res;
    }

    [WebMethod]
    public static Schedulelist[] ViewScheduleDetail(string Courseid, string Brid, string dayid)
    {
        DataTable dt = new DataTable();
        List<Schedulelist> details = new List<Schedulelist>();
        DataUtility ObjDUT = new DataUtility();
        dt = ObjDUT.GetDataTable(@"select csid,CourseFromTime,CourseToTime from tbl_CourseSchedule where Courseid=" + Courseid + " and brid=" + Brid + " and dayid=" + dayid + " and Status=1 and IsDeleted=0 ");
        foreach (DataRow dtrow in dt.Rows)
        {
            Schedulelist user = new Schedulelist();
            user.csid = dtrow["csid"].ToString();
            user.CourseFromTime = dtrow["CourseFromTime"].ToString();
            user.CourseToTime = dtrow["CourseToTime"].ToString();
            details.Add(user);
        }
        return details.ToArray();
    }

    public class Schedulelist
    {
        public string csid { get; set; }
        public string CourseFromTime { get; set; }
        public string CourseToTime { get; set; }
    }

    [WebMethod]
    public static int DeleteCourseSchedule(string Mode, string csid)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@Mode", Mode);
        param[1] = new SqlParameter("@csid", csid);
        param[2] = new SqlParameter("@intresult", SqlDbType.Int);
        param[2].Direction = ParameterDirection.Output;
        int res = Objdut.ExecuteSqlSP(param, "usp_SaveCourseSchedule");
        return res;
    }

    public class Subjectlist
    {
        public string Subjectid { get; set; }
        public string Subjectname { get; set; }
    }

    [WebMethod]
    public static Subjectlist[] Subject(string classid)
    {
        DataUtility objdut = new DataUtility();
        List<Subjectlist> Details = new List<Subjectlist>();
        DataSet Ds = new DataSet();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@classid", classid);
        param[1] = new SqlParameter("@mode", 7);
        param[2] = new SqlParameter("@brid",HttpContext.Current.Session["BrBrid"]);
        Ds = objdut.GetDataSetSP(param, "[Usp_timetablesettingsdetails]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                Subjectlist Dsdetails = new Subjectlist();
                Dsdetails.Subjectid = dtrow["Subjectid"].ToString();
                Dsdetails.Subjectname = dtrow["Subjectname"].ToString();
                Details.Add(Dsdetails);
            }
        }
        return Details.ToArray();
    }
    public class Teacherlist
    {
        public string eid { get; set; }
        public string fname { get; set; }
    }
    [WebMethod]
    public static Teacherlist[] Teacher()
    {
        DataUtility objdut = new DataUtility();
        List<Teacherlist> Details = new List<Teacherlist>();
        DataSet Ds = new DataSet();
        SqlParameter[] param1 = new SqlParameter[2];
        param1[0] = new SqlParameter("@mode", 8);
        param1[1] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);
        Ds = objdut.GetDataSetSP(param1, "[Usp_timetablesettingsdetails]");

        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                Teacherlist Dsdetails = new Teacherlist();
                Dsdetails.eid = dtrow["eid"].ToString();
                Dsdetails.fname = dtrow["fname"].ToString();
                Details.Add(Dsdetails);
            }
        }
        return Details.ToArray();
    }
    [WebMethod]
    public static int CheckSchedule(string classid, string fyid, string dayid, string Periodid, string sectionid)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[7];
        param[0] = new SqlParameter("@dayid", dayid);
        param[1] = new SqlParameter("@pid", Periodid);
        param[2] = new SqlParameter("@classid", classid);
        param[3] = new SqlParameter("@fyid", fyid);
        param[4] = new SqlParameter("@brid",HttpContext.Current.Session["BrBrid"]);
        param[5] = new SqlParameter("@sectionid", sectionid);
        param[6] = new SqlParameter("@mode",10);
        int res = Convert.ToInt32(Objdut.GetScalerSP(param, "Usp_timetablesettingsdetails"));
        return res;
    }

    public class GetPeriodDetails
    {
        public string Pid { get; set; }

        public string Periodname { get; set; }

        public string StartTime { get; set; }

        public string EndTime { get; set; }

        public string Subjectname { get; set; }

        public string Facultyname { get; set; }

    }

    [WebMethod]
    public static GetPeriodDetails[] PeriodDetail(string classid, string fyid, string sectionid, string dayid)
    {
        List<GetPeriodDetails> Details = new List<GetPeriodDetails>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@mode", 11);
        param[1] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);
        param[2] = new SqlParameter("@classid", classid);
        param[3] = new SqlParameter("@fyid", fyid);
        param[4] = new SqlParameter("@sectionid", sectionid);
        param[5] = new SqlParameter("Dayid", dayid);
        Dt = Objdut.GetDataTableSP(param, "[Usp_timetablesettingsdetails]");
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtRow in Dt.Rows)
            {
                GetPeriodDetails obj = new GetPeriodDetails();
                obj.Pid = dtRow["Pid"].ToString();
                obj.Periodname = dtRow["Periodname"].ToString();
                obj.StartTime = dtRow["StartTime"].ToString();
                obj.EndTime = dtRow["EndTime"].ToString();
                obj.Subjectname = dtRow["Subjectname"].ToString();
                obj.Facultyname = dtRow["Facultyname"].ToString();
                Details.Add(obj);
            }
        }
        return Details.ToArray();
    }
    protected void ddlfinancialyear_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlclass.Items.Clear();
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@brid", Session["BrBrid"]);
        param[2] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
        dt = Objdut.GetDataTableSP(param, "Usp_Class");
        if (dt.Rows.Count > 0)
        {
            ddlclass.DataSource = dt;
            ddlclass.DataValueField = "classid";
            ddlclass.DataTextField = "Classname";
            ddlclass.DataBind();
        }
        ddlclass.Items.Insert(0, new ListItem("--Select Class--", "0"));
    }
}