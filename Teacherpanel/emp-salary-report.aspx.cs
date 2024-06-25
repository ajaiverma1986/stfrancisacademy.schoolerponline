using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;

public partial class EmployeePanel_emp_salary_report : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable Dt;
    private static int fyid = 2;
    public string empid = "0", status = "0", payid = "0";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGrid();
        }
    }

    protected void BindGrid()
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@fyid", fyid);
        param[1] = new SqlParameter("@eid", Convert.ToInt32(HttpContext.Current.Session["eid"]));
        Dt = objdut.GetDataTableSP(param, "[usp_Bindsalarylistofpayid]");
        if (Dt.Rows.Count > 0)
        {
            gridmain.DataSource = Dt;
            gridmain.DataBind();
        }
    }
}