using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_setdiscount : System.Web.UI.Page
{
    private string url, q = "";
    private DataTable dt;
    private DataUtility objdut = new DataUtility();
    private CommonClass CommonClass = new CommonClass();
    private int regid1;
    private SqlParameter[] param;
    public static int fyid = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

        fyid = CommonClass.Scaler("ActiveAcademicYear");
        url = Request.Url.ToString();

        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!IsPostBack)
        {
            bindgrid();
            fillfyid();
        }
    }

    private void fillfyid()
    {
        string str = "select FYID,FYName from financial_Year";
        dt = objdut.GetDataTable(str);
        if (dt.Rows.Count > 0)
        {
            ddlfinancialyear.DataSource = dt;
            ddlfinancialyear.DataTextField = "FYName";
            ddlfinancialyear.DataValueField = "FYID";
            ddlfinancialyear.DataBind();
            ddlfinancialyear.Items.Insert(0, new ListItem("--Select Financial Year--", "0"));
            ddlfinancialyear.SelectedValue = fyid.ToString();
        }
        dt.Dispose();
    }

    public void bindgrid()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@brid", Session["BrBrid"]);

        dt = objdut.GetDataTableSP(param, "binddiscountreport");
        if (dt.Rows.Count > 0)
        {
            griddiscount.DataSource = dt;
            griddiscount.DataBind();
        }
        else
        {
            griddiscount.EmptyDataText = "No Record Found";
            griddiscount.DataSource = null;
            griddiscount.DataBind();
            dt.Dispose();
        }
    }
}