using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Timetable_viewtimetable_teacherwise : System.Web.UI.Page
{
    DataUtility Objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindTeacher();
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
        ddlteacher.Items.Insert(0,new ListItem("--Select Teacher--","0"));
    }

    public void BindGrid()
    {
        DataTable Dt = new DataTable();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@Teacherid", ddlteacher.SelectedValue);
        
        param[1] = new SqlParameter("@BranchId", Session["BrBrid"]);

        Dt = Objdut.GetDataTableSP(param, "[UspManageTeacherView]");
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
    protected void ddlteacher_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlteacher.SelectedValue != "0")
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