using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdminPanel_Login : BasePage
{
    private DataUtility objut = new DataUtility();
    private SqlParameter[] param = new SqlParameter[10];
    private SqlDataReader sdr;

    private static int academic = 0;

    private DataTable table;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] != null)
        {
            academic = CommonClass.Scaler("ActiveAcademicYear");

            if (!Page.IsPostBack)
            {

            }
        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }
    }
}