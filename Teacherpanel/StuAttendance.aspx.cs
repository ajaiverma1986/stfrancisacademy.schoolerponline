﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Teacherpanel_StuAttendance : System.Web.UI.Page
{
    DataUtility objdut = new DataUtility();
    DataTable Dt = new DataTable();
    private static int eid = 0;
    int fyid = 0;
    protected void Page_Init(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
        Response.Cache.SetExpires(System.DateTime.UtcNow.AddSeconds(-1));
        Response.Cache.SetNoStore();
    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["update"] = Session["update"];
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["eid"] == null)
        {
            Response.Redirect("~/Teacher-login.aspx");
        }
        if (!IsPostBack)
        {
            Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString());
            eid = Convert.ToInt32(Session["eid"]);
            BindClass();
           // Section();
        }
    }
    public class BindSection
    {
        public string SECTIONID { get; set; }
        public string SECTIONNAME { get; set; }
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
  
    public void BindClass()
    {
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 7);
        param[1] = new SqlParameter("@empid", eid);
        //  param[1] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
        dt = objdut.GetDataTableSP(param, "Usp_Class");
        if (dt.Rows.Count > 0)
        {
            ddlapplyingforclass.DataSource = dt;
            ddlapplyingforclass.DataTextField = "Classname";
            ddlapplyingforclass.DataValueField = "classid";
            ddlapplyingforclass.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlapplyingforclass.Items.Insert(0, li);

        }
    }

   


    [WebMethod]
    public static BindAttendance[] BindAttendanceGrid(string Classid, string SectionId, string Date)
    {
        DataUtility ObjDut = new DataUtility();
        List<BindAttendance> BindAttendanceObj = new List<BindAttendance>();
        SqlParameter[] Param = new SqlParameter[4];
        Param[0] = new SqlParameter("@ClassId", Classid);
        Param[1] = new SqlParameter("@SectionId", SectionId);
        Param[2] = new SqlParameter("@Date", Date);
        Param[3] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        DataTable Dt = ObjDut.GetDataTableSP(Param, "[Usp_TakeAttendance]");
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            BindAttendance Obj = new BindAttendance();
            Obj.ROWNUMBER = Dt.Rows[i]["RowNumber"].ToString();
            Obj.ADMISSIONNO = Dt.Rows[i]["AdmissionNo"].ToString();
            Obj.STUREGNO = Dt.Rows[i]["SturegNo"].ToString();
            Obj.NAME = Dt.Rows[i]["Name"].ToString();
            Obj.ATTENDANCESTATUS = Dt.Rows[i]["AttendanceStatus"].ToString();
            Obj.CHECKBOXSTATUS = Dt.Rows[i]["CheckBoxStatus"].ToString();
            BindAttendanceObj.Add(Obj);
        }
        return BindAttendanceObj.ToArray();
    }
    public class BindAttendance
    {
        public string ROWNUMBER { get; set; }
        public string ADMISSIONNO { get; set; }
        public string STUREGNO { get; set; }    
        public string NAME { get; set; }
        public string ATTENDANCESTATUS { get; set; }
        public string CHECKBOXSTATUS { get; set; }
    }

    [WebMethod]
    public static int TakeAttendance(string AdmissionNo, string SturegNo, string AttendanceStatus, string Date)
    {
        DataUtility Objdut = new DataUtility();
        int intresult = 0;
        SqlParameter[] Param = new SqlParameter[8];
        Param[0] = new SqlParameter("@AdmissionNo", AdmissionNo);
        Param[1] = new SqlParameter("@SturegNo", SturegNo);
        Param[2] = new SqlParameter("@AttendanceStatus", AttendanceStatus);
        Param[3] = new SqlParameter("@intresult", SqlDbType.Int);
        Param[3].Direction = ParameterDirection.Output;
        Param[4] = new SqlParameter("@Date", Date);
        Param[5] = new SqlParameter("@Brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        Param[6] = new SqlParameter("@userId", Convert.ToInt32(HttpContext.Current.Session["BrAdid"]));
        Param[7] = new SqlParameter("@SystemName", "");
        intresult = Objdut.ExecuteSqlSP(Param, "[usp_managestudentattendance]");

        if (intresult == 1)
        {

            string[] Attendance = AttendanceStatus.Split(',');
            string[] StudentID = SturegNo.Split(',');
            for (int i = 0; i < StudentID.Length; i++)
            {
                if (Convert.ToInt32(Attendance[i]) == 0)
                {
                    string msg1 = "", msg2 = "", msg3 = "";
                    msg1 = "'Dear Parent , Student ";
                    msg2 = " is absent Today(" + DateTime.Today.ToString("dd/MM/yyyy") + ").";
                    msg3 = " Please Contact School. ";
                    int ied = CommonClass.getStudentMobileNo(Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), Convert.ToDecimal(StudentID[i]), Convert.ToInt32(CommonClass.Scaler("ActiveAcademicYear")), msg1, msg2, msg3);
                }
            }
        }
        return intresult;
    }
    
    //'''''''''''''''''''''''''''''''''''''''''''''''''''' shivam
    protected void ddlapplyingforclass_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlapplyingforclass.SelectedValue == "0")
        {

            ddlsection.DataSource = null;
            ddlsection.DataBind();
        }
        else
        {
            //Section();
        }
    }
   
    //protected void ddlsection_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (ddlsection.SelectedValue == "0")
    //    {
    //        DataTable dtStd = new DataTable();
    //        dtStd = null;

    //        ddlsection.DataSource = dtStd;
    //        ddlsection.DataBind();
    //    }
    //    else
    //    {

    //        Response.Write("no section");
    //    }
    //}
}