﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Teacherpanel_StuAssignment : System.Web.UI.Page
{
    private string url = "", query = "", filename, AllSturegno = "";
    private int idStudent = 0, count = 0;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private FileInfo finfoevent;
    private int id = 0;
    private int lecid = 0;
    private static int eid = 0;
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
            BindClass();
            fillgrid();
        }

    }
    public void BindClass()
    {
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 7);
        param[1] = new SqlParameter("@empid", eid);
        //param[1] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
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
    //public void BindClass()
    //{
    //    DataTable Dt = new DataTable();
    //    CommonClass CommonClass = new CommonClass();
    //    int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
    //    Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ActiveFinancialyear), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
    //    if (Dt.Rows.Count > 0)
    //    {
    //        ddlapplyingforclass.DataSource = Dt;
    //        ddlapplyingforclass.DataTextField = "Classname";
    //        ddlapplyingforclass.DataValueField = "classid";
    //        ddlapplyingforclass.DataBind();
    //        ListItem li = new ListItem("--Select Class--", "0");
    //        ddlapplyingforclass.Items.Insert(0, li);
    //    }
    //}
    //--------------------------------------------------------------------------------------------------------------------------
    //[WebMethod]
    //public static BindSection[] BindSectionDDL(string Classid)
    //{
    //    DataTable Dt;
    //    Dt = CommonClass.ABC("sectiondll", Convert.ToInt32(Classid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
    //    List<BindSection> BindObj = new List<BindSection>();
    //    for (int i = 0; i < Dt.Rows.Count; i++)
    //    {
    //        BindSection Obj = new BindSection();
    //        Obj.SECTIONID = Dt.Rows[i]["cwsid"].ToString();
    //        Obj.SECTIONNAME = Dt.Rows[i]["sectionname"].ToString();
    //        BindObj.Add(Obj);
    //    }
    //    return BindObj.ToArray();
    //}
    //public class BindSection
    //{
    //    public string SECTIONID { get; set; }
    //    public string SECTIONNAME { get; set; }
    //}
    public class BindSection
    {
        public string SECTIONID { get; set; }
        public string SECTIONNAME { get; set; }
    }
    [WebMethod]
    public static BindSection[] BindSectionDDL(string Classid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("sectiondll", Convert.ToInt32(Classid), Convert.ToInt32(0));
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
        int intresult = 0;
        DataUtility Objdut = new DataUtility();
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
        return intresult;
    }
    protected void btnSend_Click(object sender, EventArgs e)
    {
        idStudent = Convert.ToInt16(objdut.GetScalar("select isnull(max(assignid),0)+1 from tbl_assignment where status=1"));
        if (ddlapplyingforclass.Text == "--Select Class--")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Class.");
            return;
        }


        if (txttopic.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Topic");
            return;
        }
        if (fu1.HasFile)
        {
            if (fu1.PostedFile.ContentLength <= 524288)
            {
                filename = Path.GetFileName(fu1.PostedFile.FileName);
                // lecid = Convert.ToInt32(objdut.GetScalar("select LecID from Lecture_Master where SubId=" + ddlsubject.SelectedValue + "and batchid=" + ddlbatch.SelectedValue));
                int ss = int.Parse(ddlapplyingforclass.SelectedItem.Value.ToString());
                fu1.SaveAs(Server.MapPath("~/BranchPanel/Assignment/" + idStudent + filename));
                SqlParameter[] param = new SqlParameter[14];
                string pname = "usp_uploadassignment";
                param[0] = new SqlParameter("@document", idStudent + filename);
                param[1] = new SqlParameter("@batchid", ddlapplyingforclass.SelectedValue);
                param[2] = new SqlParameter("@subjectid", ddlsection.SelectedValue);
                param[3] = new SqlParameter("@topicname", txttopic.Text.Trim());
                param[4] = new SqlParameter("@lecid ", Session["BrBrid"]);
                param[5] = new SqlParameter("@url", Request.Url.ToString());
                param[6] = new SqlParameter("@intresult", 0);
                param[6].Direction = ParameterDirection.Output;
                param[7] = new SqlParameter("@facultyid", Session["empid"]);
                param[8] = new SqlParameter("@AllSturegno", idStudent.ToString());
                param[9] = new SqlParameter("@AssignBy", txtassign.Text);
                param[10] = new SqlParameter("@branchName", ddlapplyingforclass.SelectedItem.Text);
                param[11] = new SqlParameter("@sectionName", ddlsection.SelectedItem.Text);
                param[12] = new SqlParameter("@classid", Convert.ToInt32(ddlapplyingforclass.SelectedValue));
                param[13] = new SqlParameter("@sectionid", Convert.ToInt32(ddlsection.SelectedValue));
                int result = objdut.ExecuteSqlSP(param, pname);
                if (result > 0)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "File uploaded successfully");
                    fillgrid();
                    //dd2.Visible = false;
                    //Button1.Visible = true;

                    //grdshw.Visible = true;

                    // btnSend.Visible = false;
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "error!!!!!!");
                }
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "File size greater than 512 KB!!!");

                return;
            }
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select File");
        }
    }
    private void fillgrid()
    {
        string q = @"select isnull(branchName,'') branchName,isnull(sectionName,'')
             sectionName,topicname,uploadon,isnull(assignby,'')
            assignby,'Assignment/'+document as document   from tbl_assignment where lectureid=" + Convert.ToInt32(Session["BrBrid"]) + " order by uploadon desc";
        dt = objdut.GetDataTable(q);
        if (dt.Rows.Count > 0)
        {
            GrdAttendence.DataSource = dt;
            GrdAttendence.DataBind();
        }
    }
    protected void ddlapplyingforclass_SelectedIndexChanged(object sender, EventArgs e)
    {
        string Classid = ddlapplyingforclass.SelectedValue;
        DataTable Dt;
        Dt = CommonClass.ABC("sectiondll", Convert.ToInt32(Classid), Convert.ToInt32(Session["BrBrid"]));
        if (Dt.Rows.Count > 0)
        {
            ddlsection.DataSource = Dt;
            ddlsection.DataTextField = "sectionname";
            ddlsection.DataValueField = "cwsid";
            ddlsection.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlsection.Items.Insert(0, li);
        }
    }
}