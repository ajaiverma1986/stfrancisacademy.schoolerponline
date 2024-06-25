using System;
using System.Data;
using System.Web.UI;

public partial class BranchPanel_StudentReport : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();
    private Utility objUT = new Utility();
    private CommonClass CommmonOBJ = new CommonClass();
    private string PageName = "", url = "", query1, query2;
    private DataTable dt;
    private int classid, sectionid, studentid;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        // PageName = Utility.GetCurrentPagename();

        //if (!objUT.isAccessible(((User)Session["BrUser"]).UserID, PageName))
        //{
        //    //Response.Redirect("~/Login.aspx");
        //}
        if (!IsPostBack)
        {
            //academicyear_id = CommmonOBJ.Scaler("ActiveAcademicYear");
            DDL_Class_Bind();
            DDLSection.Enabled = false;
            ddlStudent.Enabled = false;
            //tr1.Visible = false;
            GrdAttendence.Visible = false;
            btnBack.Visible = false;
        }
    }

    private void DDL_Class_Bind()
    {
        dt = CommmonOBJ.Dll("ClassInBranch", Convert.ToInt32(Session["BrBrid"])); //objDUT.GetDataTable(query);
        DDLClass.DataSource = dt;
        DDLClass.DataBind();
        DDLClass.DataTextField = "Classname";
        DDLClass.DataValueField = "classid";
        DDLClass.DataBind();
        DDLClass.Items.Insert(0, "--Select Class--");
        DDLSection.Items.Insert(0, "--Select Section--");
        ddlStudent.Items.Insert(0, "--Select Student--");
    }

    protected void DDLClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        DDLSection.Items.Clear();
        GrdAttendence.DataSource = null;
        GrdAttendence.DataBind();
        ddlStudent.Items.Clear();
        ddlStudent.Items.Insert(0, "--Select Student--");
        ddlStudent.Enabled = false;
        if (DDLClass.SelectedValue == "--Select Class--")
        {
            DDLSection.Items.Clear();
            DDLSection.Items.Insert(0, "--Select Section--");
            ddlStudent.Items.Clear();
            ddlStudent.Items.Insert(0, "--Select Student--");
            ddlStudent.Enabled = false;
            DDLSection.Enabled = false;

            btnBack.Visible = false;
            GrdAttendence.Visible = false;
        }
        else
        {
            classid = Convert.ToInt32(DDLClass.SelectedValue);
            ViewState["Classid"] = classid;
            dt = CommmonOBJ.Dll("sectiondll", Convert.ToInt32(DDLClass.SelectedValue), Convert.ToInt32(Session["BrBrid"])); //objDUT.GetDataTable(query);
            DDLSection.DataSource = dt;
            DDLSection.DataBind();
            DDLSection.Enabled = true;
            DDLSection.DataTextField = "sectionname";
            DDLSection.DataValueField = "cwsid";
            DDLSection.DataBind();
            DDLSection.Items.Insert(0, "--Select Section--");
        }
    }

    protected void DDLSection_SelectedIndexChanged(object sender, EventArgs e)
    {
        GrdAttendence.DataSource = null;
        GrdAttendence.DataBind();
        if (DDLSection.SelectedValue == "--Select Section--")
        {
            DDLClass.Items.Clear();
            DDLSection.Items.Clear();
            DDL_Class_Bind();
            ddlStudent.Items.Clear();
            ddlStudent.Items.Insert(0, "--Select Student--");
            ddlStudent.Enabled = false;

            btnBack.Visible = false;
            GrdAttendence.Visible = false;
        }
        else
        {
            sectionid = Convert.ToInt32(DDLSection.SelectedValue);
            ViewState["Sectionid"] = sectionid;
            query1 = "select (FirstName+' '+MiddleName+' ' +LastName) as studentNAme,adid from tbl_Admission ta inner join student_master  sm on ta.sturegno=sm.sturegno where ta.fyid=" + CommonClass.Scaler("ActiveAcademicYear") + " and ta.Brid=" + Session["BrBrid"] + @"
                      and classid=" + Convert.ToInt32(ViewState["Classid"]) + " and sectionID=" + sectionid + "";
            dt = objDUT.GetDataTable(query1);
            if (dt.Rows.Count > 0)
            {
                ddlStudent.Enabled = true;
                ddlStudent.DataSource = dt;
                ddlStudent.DataTextField = "studentNAme";
                ddlStudent.DataValueField = "adid";
                ddlStudent.DataBind();
                ddlStudent.Items.Insert(0, "--Select Student--");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('No student found in this section.')", true);
                return;
            }
        }
    }

    protected void ddlStudent_SelectedIndexChanged(object sender, EventArgs e)
    {
        GrdAttendence.DataSource = null;
        GrdAttendence.DataBind();
        btnBack.Visible = false;
        if (ddlStudent.SelectedValue == "--Select Student--")
        {
        }
        else
        {
            studentid = Convert.ToInt32(ddlStudent.SelectedValue);

            btnBack.Visible = true;
            GrdAttendence.Visible = true;
            query2 = "select COUNT(ta.date) as workingdays,SUM(case ta.attendance when 1 then 1 else 0 end) as PresentDays,(((SUM(case ta.attendance when 1 then 1 else 0 end))*100)/COUNT(ta.date)) as Percentage ,mn.MonthName,mn.MonthId from tbl_attendance ta  right outer join Month_name mn on mn.MONTHID=ta.MonthId where ta.FYID=" + CommonClass.Scaler("ActiveAcademicYear") + @"
                       and ta.CWSID=" + Convert.ToInt32(ViewState["Sectionid"]) + " and ta.CLASSID=" + Convert.ToInt32(ViewState["Classid"]) + " and ta.ADID=" + studentid + " and ta.brid=" + Convert.ToInt16(Session["BrBrid"]) + "  group by mn.MonthName,mn.MonthId order by mn.monthid asc";
            dt = objDUT.GetDataTable(query2);
            if (dt.Rows.Count > 0)
            {
                GrdAttendence.DataSource = dt;
                GrdAttendence.DataBind();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('No attendance has been taken for this student.')", true);
                return;
            }
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        DDLSection.Items.Clear();
        DDL_Class_Bind();
        DDLSection.Enabled = false;
        ddlStudent.Items.Clear();
        ddlStudent.Items.Insert(0, "--Select Student--");
        ddlStudent.Enabled = false;

        GrdAttendence.Visible = false;
        btnBack.Visible = false;
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        Response.Redirect("DaywiseAttendence.aspx");
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
        Response.Redirect("AttendanceReport2.aspx");
    }

    protected void btn3_Click(object sender, EventArgs e)
    {
        Response.Redirect("StudentReport.aspx");
    }
}