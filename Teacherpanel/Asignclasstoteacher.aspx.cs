using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class Teacherpanel_Asignclasstoteacher : System.Web.UI.Page
{

    DataUtility objdut = new DataUtility();
  private static int empid=0;
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
            //fillleavetypes();
            //fillleavegrid();
            //getlastleave();
            //getdatewiseleavedetails();
            //gethalfday();
            fillgrid();
        }
    }
    private void fillgrid()
    {
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 7);
        param[1] = new SqlParameter("@empid", eid);
        param[2] = new SqlParameter("@fyid", 1);
        dt = objdut.GetDataTableSP(param, "Usp_Class");
        if (dt.Rows.Count > 0)
        {
            grdteacherclass.DataSource = dt;
            grdteacherclass.DataBind();
        }
    }

    protected void grdteacherclass_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.ToString() == "btnatten")
        {
            //Response.Redirect("~/Branchpanel/AttendanceManagement/take-student-attendance.aspx?ID=" + e.CommandArgument + "tcid");
            Response.Redirect("StuAttendance.aspx?ID=" + e.CommandArgument + "tcid");
        }
        if (e.CommandName.ToString() == "btnassign")
        {
            Response.Redirect("StuAssignment.aspx?ID=" + e.CommandArgument + "tcid");
        }
    }
}
