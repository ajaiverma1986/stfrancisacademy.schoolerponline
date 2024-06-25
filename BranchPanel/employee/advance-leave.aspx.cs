using System;
using System.Data;
using System.Data.SqlClient;

public partial class branchpanel_employee_today_leave : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private string url = "";
    private DataSet ds;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        if (!IsPostBack)
        {
            getleaveslist();
        }
    }

    private void getleaveslist()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 6);
        DataTable dt = objdut.GetDataTableSP(param, "usp_leavehistory");
        gvleavedetails.DataSource = dt;
        gvleavedetails.DataBind();
    }
}