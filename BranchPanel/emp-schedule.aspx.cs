using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;

public partial class BranchPanel_emp_schedule : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private static int fyid = 2;
    private CommonClass CommonClass = new CommonClass();

    protected void Page_Load(object sender, System.EventArgs e)
    {
        fyid = CommonClass.Scaler("ActiveAcademicYear");
        if (!IsPostBack)
        {
            BindGrid();
        }
    }

    protected void BindGrid()
    {
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@teacherid", Convert.ToInt32(Session["empid"]));
        param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        param[2] = new SqlParameter("@fyid", fyid);
        dt = objdut.GetDataTableSP(param, "usp_teachertimetableteacherpanel");
        if (dt.Rows.Count > 0)
        {
            gridcreatetimetable.DataSource = dt;
            gridcreatetimetable.DataBind();
        }
        else
        {
            gridcreatetimetable.EmptyDataText = "No Record Found";
            gridcreatetimetable.DataBind();
        }
    }
}