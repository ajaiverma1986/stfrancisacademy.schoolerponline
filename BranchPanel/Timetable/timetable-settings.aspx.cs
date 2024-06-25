using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_timetable_settings : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        fillfyear();
        fillMultipleschedule();
    }

    public void fillfyear()
    {
        DataTable Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
        ddlfinacialyearforsearching.DataSource = Dt;
        ddlfinacialyearforsearching.DataValueField = "fyid";
        ddlfinacialyearforsearching.DataTextField = "FYName";
        ddlfinacialyearforsearching.DataBind();
        ddlfinacialyearforsearching.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    private void fillMultipleschedule()
    {
        DataUtility objDut = new DataUtility();
        string Query = "select did,dayname from days where status=1";
        DataTable dt_day = objDut.GetDataTable(Query);
        if (dt_day.Rows.Count > 0)
        {
            ddlstarttime.DataSource = GetTimeIntervals();
            ddlstarttime.DataBind();
            ddlendtime.DataSource = GetTimeIntervals();
            ddlendtime.DataBind();
        }
    }
    public List<string> GetTimeIntervals()
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

    public class GetSchedule
    {
        public string classid { get; set; }
        public string Classname { get; set; }
        public string NoOfPeriod { get; set; }
        public string FromDate { get; set; }
        public string ToDate { get; set; }
        public string FromTime { get; set; }
        public string ToTime { get; set; }
    }

    [WebMethod]
    public static GetSchedule[] PeriodScheduleList(string fyid)
    {
        List<GetSchedule> Details = new List<GetSchedule>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        int brid = Convert.ToInt32(HttpContext.Current.Session["BrBrid"]);
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@brid", brid);
        param[2] = new SqlParameter("@fyid", fyid);
        Dt = Objdut.GetDataTableSP(param, "[Usp_timetablesettingsdetails]");
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtRow in Dt.Rows)
            {
                GetSchedule obj = new GetSchedule();
                obj.classid = dtRow["classid"].ToString();
                obj.Classname = dtRow["Classname"].ToString();
                obj.NoOfPeriod = dtRow["NoOfPeriod"].ToString();
                obj.FromDate = dtRow["FromDate"].ToString();
                obj.ToDate = dtRow["ToDate"].ToString();
                obj.FromTime = dtRow["FromTime"].ToString();
                obj.ToTime = dtRow["ToTime"].ToString();
                Details.Add(obj);
            }
        }
        return Details.ToArray();
    }

    [WebMethod]
    public static int Addperiod(string allclassid, string allperiodname, string allstarttime, string allendtime, string noperiod, string fyid,string fromdate,string todate,string fromtime,string totime,string rewised)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[15];
        param[0] = new SqlParameter("@classid", allclassid);
        param[1] = new SqlParameter("@fyid", fyid);
        param[2] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);
        param[3] = new SqlParameter("@noperiod", noperiod);
        param[4] = new SqlParameter("@StartTime", allstarttime);
        param[5] = new SqlParameter("@EndTime", allendtime);
        param[6] = new SqlParameter("@periodName", allperiodname);
        param[7] = new SqlParameter("@intresult", SqlDbType.Int);
        param[7].Direction = ParameterDirection.Output;
        param[8] = new SqlParameter("@userid", HttpContext.Current.Session["BrADID"]);
        param[9] = new SqlParameter("@mode",1);
        param[10] = new SqlParameter("@fromdate", fromdate);
        param[11] = new SqlParameter("@todate", todate);
        param[12] = new SqlParameter("@fromtime", fromtime);
        param[13] = new SqlParameter("@totime", totime);
        param[14] = new SqlParameter("@rewised", rewised);
        int result = objdut.ExecuteSqlSP(param, "[Usp_timetablesettingsdetails]");
        return result;
    }

    public class PeriodList
    {
        public string Id { get; set; }
        public string classid { get; set; }
        public string Classname { get; set; }
        public string NoOfPeriod { get; set; }
        public string FromTime { get; set; }
        public string ToTime { get; set; }
        public string fyid { get; set; }
        public string FromDate { get; set; }
        public string Todate { get; set; }
    }

    [WebMethod]
    public static PeriodList[] BindPeriod(string classid, string fyid)
    {
        List<PeriodList> Details = new List<PeriodList>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode",2);
        param[1] = new SqlParameter("@brid",HttpContext.Current.Session["BrBrid"]);
        param[2] = new SqlParameter("@classid", classid);
        param[3] = new SqlParameter("@fyid", fyid);
        Dt = Objdut.GetDataTableSP(param, "[Usp_timetablesettingsdetails]");
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtRow in Dt.Rows)
            {
                PeriodList obj = new PeriodList();
                obj.Id = dtRow["classid"].ToString();
                obj.classid = dtRow["classid"].ToString();
                obj.Classname = dtRow["Classname"].ToString();
                obj.NoOfPeriod = dtRow["NoOfPeriod"].ToString();
                obj.FromTime = dtRow["FromTime"].ToString();
                obj.ToTime = dtRow["ToTime"].ToString();
                obj.fyid = dtRow["fyid"].ToString();
                obj.FromDate = dtRow["FromDate"].ToString();
                obj.Todate = dtRow["Todate"].ToString();
                Details.Add(obj);
            }
        }
        return Details.ToArray();
    }

    public class GetDetails
    {
        public string Pid { get; set; }

        public string Periodname { get; set; }

        public string StartTime { get; set; }

        public string EndTime { get; set; }
    }

    [WebMethod]
    public static GetDetails[] showPeriodDetail(string classid, string fyid)
    {
        List<GetDetails> Details = new List<GetDetails>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", 4);
        param[1] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);
        param[2] = new SqlParameter("@classid", classid);
        param[3] = new SqlParameter("@fyid", fyid);
        Dt = Objdut.GetDataTableSP(param, "[Usp_timetablesettingsdetails]");
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtRow in Dt.Rows)
            {
                GetDetails obj = new GetDetails();
                obj.Pid = dtRow["Pid"].ToString();
                obj.Periodname = dtRow["Periodname"].ToString();
                obj.StartTime = dtRow["StartTime"].ToString();
                obj.EndTime = dtRow["EndTime"].ToString();
                Details.Add(obj);
            }
        }
        return Details.ToArray();
    }
}