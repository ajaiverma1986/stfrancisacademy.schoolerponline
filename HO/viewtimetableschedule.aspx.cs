using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HO_viewtimetableschedule : System.Web.UI.Page
{
    DataUtility Objdut = new DataUtility();
    private CommonClass CommonClass = new CommonClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDDl();
            
            //BindTeacher();
            //BindClass();
        }
    }

    public void BindDDl()
    {
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
        ddlfyear1.DataSource = Dt;
        ddlfyear1.DataValueField = "fyid";
        ddlfyear1.DataTextField = "FYName";
        ddlfyear1.DataBind();
        ddlfyear1.SelectedValue = Convert.ToString(ActiveFinancialyear);
        DataTable dt = new DataTable();
        dt = Objdut.GetDataTable("select Brid,BrName from Branch_master where BrActive=1 and isDeleted=0 and isActive=1");
        if (dt.Rows.Count > 0)
        {
            ddlbranch.DataSource = dt;
            ddlbranch.DataValueField = "Brid";
            ddlbranch.DataTextField = "BrName";
            ddlbranch.DataBind();
            ddlbranch1.DataSource = dt;
            ddlbranch1.DataValueField = "Brid";
            ddlbranch1.DataTextField = "BrName";
            ddlbranch1.DataBind();
            ddlbranch2.DataSource = dt;
            ddlbranch2.DataValueField = "Brid";
            ddlbranch2.DataTextField = "BrName";
            ddlbranch2.DataBind();
        }
        ddlbranch.Items.Insert(0, new ListItem("--Select Branch--", "0"));
        ddlbranch1.Items.Insert(0, new ListItem("--Select Branch--", "0"));
        ddlbranch2.Items.Insert(0, new ListItem("--Select Branch--", "0"));
    }

    protected void BindClass()
    {
        ddlclass.Items.Clear();
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@brid", ddlbranch.SelectedValue);
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
        //ddlsection.Items.Insert(0, new ListItem("--Select Section--", "0"));
    }

    protected void BindSection()
    {
        ddlsection.Items.Clear();
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@classid", ddlclass.SelectedValue);
        param[1] = new SqlParameter("@brid", ddlbranch.SelectedValue);
        param[2] = new SqlParameter("@mode", 5);
        dt = Objdut.GetDataTableSP(param, "[Usp_timetablesettingsdetails]");
        if (dt.Rows.Count > 0)
        {
            ddlsection.DataSource = dt;
            ddlsection.DataValueField = "cwsid";
            ddlsection.DataTextField = "sectionname";
            ddlsection.DataBind();
        }
        ddlsection.Items.Insert(0, new ListItem("--Select Section--", "0"));
    }

    public void BindGrid()
    {
        DataTable Dt = new DataTable();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@ClassId", ddlclass.SelectedValue);
        param[1] = new SqlParameter("@SectionId", ddlsection.SelectedValue);
        param[2] = new SqlParameter("@BranchId", ddlbranch.SelectedValue);
        param[3] = new SqlParameter("@Fyid", ddlfinancialyear.SelectedValue);
        Dt = Objdut.GetDataTableSP(param, "[UspManageClassView]");
        if (Dt.Rows.Count > 1)
        {
            grdtimetable.DataSource = Dt;
            grdtimetable.DataBind();
        }
        else
        {
            divfordownload.Style.Add("display", "none");
            divforprint.Style.Add("display", "none");
            grdtimetable.EmptyDataText = "No time table scheduled for selected class or section.";
            grdtimetable.DataBind();
        }
    }

    protected void ddlfinancialyear_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindClass();
        divfordownload.Style.Add("display", "none");
        divforprint.Style.Add("display", "none");
        divforclass.Style.Add("display", "block");
        grdtimetable.DataSource = null;
        grdtimetable.DataBind();
        ddlsection.Items.Clear();
        ddlsection.Items.Insert(0, new ListItem("--Select Section--", "0"));
    }

    protected void ddlclass_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlclass.SelectedValue != "0")
        {
            divfordownload.Style.Add("display", "none");
            divforprint.Style.Add("display", "none");
            divforclass.Style.Add("display", "block");
            
            grdtimetable.DataSource = null;
            grdtimetable.DataBind();
            BindSection();
        }
        else
        {
            divfordownload.Style.Add("display", "none");
            divforprint.Style.Add("display", "none");
            divforclass.Style.Add("display", "block");
            grdtimetable.DataSource = null;
            grdtimetable.DataBind();
            ddlsection.Items.Clear();
            ddlsection.Items.Insert(0, new ListItem("--Select Section--", "0"));
        }
    }

    protected void ddlsection_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlsection.SelectedValue != "0")
        {
            divfordownload.Style.Add("display", "block");
            divforprint.Style.Add("display", "block");
            divforclass.Style.Add("display", "block");
            BindGrid();
        }
        else
        {
            divfordownload.Style.Add("display", "none");
            divforprint.Style.Add("display", "none");
            divforclass.Style.Add("display", "block");
            grdtimetable.DataSource = null;
            grdtimetable.DataBind();
        }
    }

    protected void ddlbranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlbranch.SelectedValue != "0")
        {
            divforclass.Style.Add("display", "block");
            divclass.Style.Add("display", "block");
            divforteacher.Style.Add("display", "none");
            divteacher.Style.Add("display", "none");
            divfordownload.Style.Add("display", "none");
            divforprint.Style.Add("display", "none");
            ddlsection.SelectedValue = "0";
            grdtimetable.DataSource = null;
            grdtimetable.DataBind();
            BindClass();
        }
        else
        {
            divforclass.Style.Add("display", "block");
            divforteacher.Style.Add("display", "none");
            divteacher.Style.Add("display", "none");
            divfordownload.Style.Add("display", "none");
            divforprint.Style.Add("display", "none");
            ddlclass.SelectedValue = "0";
            ddlsection.SelectedValue = "0";
            grdtimetable.DataSource = null;
            grdtimetable.DataBind();
        }
    }
    protected void BindTeacher()
    {
        DataSet Ds = new DataSet();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 8);
        Ds = Objdut.GetDataSetSP(param, "[Usp_timetablesettingsdetails]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            ddlteacher.DataSource = Ds.Tables[0];
            ddlteacher.DataValueField = "eid";
            ddlteacher.DataTextField = "fname";
            ddlteacher.DataBind();
        }
        ddlteacher.Items.Insert(0, new ListItem("--Select Teacher--", "0"));
    }
    protected void ddlteacher_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlteacher.SelectedValue != "0")
        {
            divforclass.Style.Add("display", "none");
            divfordownload.Style.Add("display", "block");
            divforprint.Style.Add("display", "block");
            Bindteacher();
        }
        else
        {
            divfordownload.Style.Add("display", "none");
            divforprint.Style.Add("display", "none");
            grdtimetable.DataSource = null;
            grdtimetable.DataBind();
        }
    }
    protected void ddlbranch1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlbranch1.SelectedValue != "0")
        {
            divforclass.Style.Add("display", "none");
            divclass.Style.Add("display", "none");
            divforteacher.Style.Add("display", "block");
            divteacher.Style.Add("display", "block");
            GridView1.DataSource = null;
            GridView1.DataBind();
            BindTeacher();
        }
        else
        {
            divforclass.Style.Add("display", "none");
            divforteacher.Style.Add("display", "block");
            divteacher.Style.Add("display", "none");
            GridView1.DataSource = null;
            GridView1.DataBind();
        }
        
    }
    public void Bindteacher()
    {
        DataTable Dt = new DataTable();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@Teacherid", ddlteacher.SelectedValue);

        param[1] = new SqlParameter("@BranchId", ddlbranch1.SelectedValue);

        Dt = Objdut.GetDataTableSP(param, "[UspManageTeacherView]");
        if (Dt.Rows.Count > 1)
        {

            GridView1.DataSource = Dt;
            GridView1.DataBind();
        }
        else
        {
            div1.Style.Add("display", "none");
            div2.Style.Add("display", "none");
            GridView1.EmptyDataText = "No time table scheduled for selected class or section.";
            GridView1.DataBind();
        }
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
    public static GetPeriodDetails[] PeriodDetail(string classid, string fyid, string sectionid, string dayid,string brid)
    {
        List<GetPeriodDetails> Details = new List<GetPeriodDetails>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@mode", 11);
        param[1] = new SqlParameter("@brid", brid);
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
}