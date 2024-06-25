using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Timetable_viewtimetable : System.Web.UI.Page
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
        Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
        BindClass();
    }
    protected void BindClass()
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
        ddlsection.Items.Insert(0, new ListItem("--Select Section--", "0"));
    }
    protected void BindSection()
    {
        ddlsection.Items.Clear();
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@classid",ddlclass.SelectedValue);
        param[1] = new SqlParameter("@brid",HttpContext.Current.Session["BrBrid"]);
        param[2] = new SqlParameter("@mode",5);
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
    protected void ddlfinancialyear_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindClass();
        divfordownload.Style.Add("display", "none");
        divforprint.Style.Add("display", "none");
        grdtimetable.DataSource = null;
        grdtimetable.DataBind();
        ddlsection.Items.Clear();
        ddlsection.Items.Insert(0, new ListItem("--Select Section--", "0"));
    }
    public void BindGrid()
    {
        DataTable Dt = new DataTable();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@ClassId",ddlclass.SelectedValue);
        param[1] = new SqlParameter("@SectionId",ddlsection.SelectedValue);
        param[2] = new SqlParameter("@BranchId",Session["BrBrid"]);
        param[3] = new SqlParameter("@Fyid",ddlfinancialyear.SelectedValue);
        Dt = Objdut.GetDataTableSP(param,"[UspManageClassView]");
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
    protected void ddlclass_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlclass.SelectedValue != "0")
        {
            divfordownload.Style.Add("display", "none");
            divforprint.Style.Add("display", "none");
            grdtimetable.DataSource = null;
            grdtimetable.DataBind();
            BindSection();
        }
        else
        {
            divfordownload.Style.Add("display", "none");
            divforprint.Style.Add("display", "none");
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
            BindGrid();
        }
        else
        {
            divfordownload.Style.Add("display", "none");
            divforprint.Style.Add("display", "none");
            grdtimetable.DataSource = null;
            grdtimetable.DataBind();
        }
    }
}