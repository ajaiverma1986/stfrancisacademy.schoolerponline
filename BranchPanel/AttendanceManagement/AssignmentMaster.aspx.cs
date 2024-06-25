using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class BranchPanel_AttendanceManagement_AssignmentMaster : System.Web.UI.Page
{
    private string url = "", query = "", filename, AllSturegno = "";
    private int idStudent = 0, count = 0;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private FileInfo finfoevent;
    private int id = 0;
    private int lecid = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindClass();
            if (Request.QueryString["assignid"] == null)
            {
                fillgrid(0);
            }
            else {
                fillEditField(Convert.ToInt32(Request.QueryString["assignid"]));
            }            
        }

    }

    private void fillEditField(int assignid)
    {
        getRecord(assignid);
        if (dt.Rows.Count > 0) {
           // BindClass();
            ResetField();
            ddlapplyingforclass.SelectedValue = dt.Rows[0]["classid"].ToString();

            ddlapplyingforclass_SelectedIndexChanged(null, null);
            ddlsection.SelectedValue = dt.Rows[0]["sectionid"].ToString();
            txtdateforattendance.Text = dt.Rows[0]["uploadon"].ToString();
            txttopic.Text = dt.Rows[0]["topicname"].ToString();
            txtassign.Text = dt.Rows[0]["assignby"].ToString();
            hdfFIle.Value = dt.Rows[0]["document"].ToString();
        }
    }

    public void ResetField()
    {
        ddlapplyingforclass.SelectedValue = "0";
        // ddlsection.SelectedValue = "0";
        txtdateforattendance.Text = "";
        txttopic.Text = "";
        txtassign.Text = "";
        hdfFIle.Value = "0";
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
        int ModeID = 0;
        if (Request.QueryString["assignid"] != null)
        {
            idStudent = Convert.ToInt32(Request.QueryString["assignid"]);
            ModeID = 2;
            var spilt = hdfFIle.Value.ToString().Split('/');
            if (spilt.Length > 1) {
                hdfFIle.Value = spilt[1].ToString();
            }           
        }
        else {
            idStudent = Convert.ToInt16(objdut.GetScalar("select isnull(max(assignid),0)+1 from tbl_assignment where status=1"));
            ModeID = 1;
        }
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
        if (Request.QueryString["assignid"] == null)
        {
            if (!fu1.HasFile)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Please Select File");
            }
        }
        if (fu1.HasFile)
        {
            if (fu1.PostedFile.ContentLength <= 555555524288)
            {
                filename = Path.GetFileName(fu1.PostedFile.FileName);
                // lecid = Convert.ToInt32(objdut.GetScalar("select LecID from Lecture_Master where SubId=" + ddlsubject.SelectedValue + "and batchid=" + ddlbatch.SelectedValue));
                int ss = int.Parse(ddlapplyingforclass.SelectedItem.Value.ToString());
                hdfFIle.Value = idStudent + filename;
                fu1.SaveAs(Server.MapPath("~/BranchPanel/Assignment/" + hdfFIle.Value));
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "File size greater than 3 MB!!!");

                return;
            }
        }

        SqlParameter[] param = new SqlParameter[16];
        string pname = "usp_uploadassignment";
        param[0] = new SqlParameter("@document", hdfFIle.Value);
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
        param[14] = new SqlParameter("@ModeID", ModeID);
        param[15] = new SqlParameter("@UplodDate", Convert.ToDateTime(txtdateforattendance.Text));
        int result = objdut.ExecuteSqlSP(param, pname);
        if (result > 0)
        {
            if (result == 1)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('File uploaded successfully');window.location ='AssignmentMaster.aspx';", true);
                //Utility.ViewAlertMessage(this.Master.Page, "File uploaded successfully");
            }
            if (result == 2) {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('File updated successfully');window.location ='AssignmentMaster.aspx';", true);
               // Utility.ViewAlertMessage(this.Master.Page, "File updated successfully");
            }
            ResetField();
            fillgrid(0);
            //Response.Redirect("AssignmentMaster.aspx");
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
    public void getRecord(int assignid) {
        string strq = "";
        if (assignid > 0)
        {
            strq = " and assignid=" + assignid;
        }
        string q = @"select isnull(ClassID,0) ClassID,isnull(sectionid,0) sectionid,isnull(assignid,0) assignid, isnull(branchName,'') branchName,isnull(sectionName,'')
             sectionName,topicname,uploadon,isnull(assignby,'')
            assignby,'Assignment/'+document as document   from tbl_assignment where lectureid=" + Convert.ToInt32(Session["BrBrid"]) + "";
        strq = strq + " order by uploadon desc";
        q = q + strq;
        dt = objdut.GetDataTable(q);
    }
    private void fillgrid(int assignid)
    {
        getRecord(assignid);
        if (dt.Rows.Count > 0)
        {
            GrdAttendence.DataSource = dt;
            GrdAttendence.DataBind();
        }
    }
    protected void GrdAttendence_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int AssignID = Convert.ToInt32(e.CommandArgument.ToString());
        if (e.CommandName == "Edit")
        {
            if (AssignID > 0)
            {
                Response.Redirect("AssignmentMaster.aspx?assignid=" + AssignID);
            }
        }
        else if (e.CommandName == "Delete")
        {

            if (AssignID > 0)
            {
                string q = @"delete from tbl_assignment where lectureid=" + Convert.ToInt32(Session["BrBrid"]) + " and assignid=" + AssignID + "";
                int result = objdut.ExecuteSql(q);
                if (result > 0)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Assignment Deleted successfully");
                }
            }
            fillgrid(0);
        }      
    }
    protected void GrdAttendence_RowDeleting(object sender, GridViewDeleteEventArgs e) { }
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

    protected void Button1_Click(object sender, EventArgs e)
    {
        ResetField();
        fillgrid(0);
    }
}