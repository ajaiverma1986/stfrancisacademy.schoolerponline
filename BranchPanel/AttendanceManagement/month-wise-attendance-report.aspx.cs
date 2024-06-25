using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_AttendanceManagement_month_wise_attendance_report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindSessionDDL();
        BindClass();
    }

    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlregistrationsession.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlregistrationsession.DataValueField = "Fyid";
        ddlregistrationsession.DataTextField = "FYName";
        ddlregistrationsession.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlregistrationsession.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }

    public void BindClass()
    {
        DataTable Dt = new DataTable();
        CommonClass CommonClass = new CommonClass();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ActiveFinancialyear), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        if (Dt.Rows.Count > 0)
        {
            ddlapplyingforclass.DataSource = Dt;
            ddlapplyingforclass.DataTextField = "Classname";
            ddlapplyingforclass.DataValueField = "classid";
            ddlapplyingforclass.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlapplyingforclass.Items.Insert(0, li);
        }
    }

    [WebMethod]
    public static BindSection[] BindSectionDDL(string Classid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("sectiondll", Convert.ToInt32(Classid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        List<BindSection> BindObj = new List<BindSection>();
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            BindSection Obj = new BindSection();
            Obj.SECTIONID = Dt.Rows[i]["cwsid"].ToString();
            Obj.SECTIONNAME = Dt.Rows[i]["sectionname"].ToString();
            BindObj.Add(Obj);
        }
        return BindObj.ToArray();
    }

    public class BindSection
    {
        public string SECTIONID { get; set; }

        public string SECTIONNAME { get; set; }
    }

    [WebMethod]
    public static BindMonth[] BindMonthMethod(string Fyid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC1("MonthName", Convert.ToInt32(Fyid));
        List<BindMonth> BindObj = new List<BindMonth>();
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            BindMonth Obj = new BindMonth();
            Obj.ID = Dt.Rows[i]["MonthId"].ToString();
            Obj.NAME = Dt.Rows[i]["MonthName"].ToString();
            BindObj.Add(Obj);
        }
        return BindObj.ToArray();
    }

    public class BindMonth
    {
        public string ID { get; set; }

        public string NAME { get; set; }
    }

    [WebMethod]
    public static BindAttendance[] BindAttendanceGrid(string Classid, string SectionId, string MonthId)
    {
        int TotalPresent = 0;
        int TotalAbsent = 0;
        int TotalPr = 0;
        int NoDay = 0;
        DataUtility ObjDut = new DataUtility();
        List<BindAttendance> BindAttendanceObj = new List<BindAttendance>();
        SqlParameter[] Param = new SqlParameter[5];
        Param[0] = new SqlParameter("@ClassId", Classid);
        Param[1] = new SqlParameter("@SectionId", SectionId);
        Param[2] = new SqlParameter("@MonthId", MonthId);
        Param[3] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        Param[4] = new SqlParameter("@Mode", 3);
        DataTable Dt = ObjDut.GetDataTableSP(Param, "[Usp_TakeAttendance]");
        DataView view = new DataView(Dt);
        DataTable distinctValues = view.ToTable(true, "SturegNo", "Name", "AdmissionNo");
        for (int i = 0; i < distinctValues.Rows.Count; i++)
        {
            TotalPresent = (int)Dt.Compute("Count(IsPresent)", "IsPresent = 1 AND SturegNo=" + distinctValues.Rows[i]["SturegNo"] + "");
            TotalAbsent = (int)Dt.Compute("Count(IsAbsent)", "IsAbsent = 1 AND SturegNo=" + distinctValues.Rows[i]["SturegNo"] + "");
            NoDay = TotalAbsent + TotalPresent;
            if (NoDay > 0)
            {
                TotalPr = (TotalPresent * 100) / NoDay;
            }
            BindAttendance Obj = new BindAttendance();
            Obj.ROWNUMBER = (i+1).ToString();
            Obj.ADMISSIONNO = distinctValues.Rows[i]["AdmissionNo"].ToString();
            Obj.NAME = distinctValues.Rows[i]["Name"].ToString();
            Obj.NOD = NoDay.ToString();
            Obj.PRE = TotalPresent.ToString();
            Obj.ABS = TotalAbsent.ToString();
            Obj.PER = TotalPr.ToString();
            BindAttendanceObj.Add(Obj);
        }
        return BindAttendanceObj.ToArray();
    }

    public class BindAttendance
    {
        public string ROWNUMBER { get; set; }

        public string ADMISSIONNO { get; set; }

        public string NAME { get; set; }

        public string NOD { get; set; }

        public string PRE { get; set; }

        public string ABS { get; set; }

        public string PER { get; set; }
    }
}