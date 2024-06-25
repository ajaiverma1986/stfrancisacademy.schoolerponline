using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
public partial class BranchPanel_setdiscount : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    public static int fyid = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        fyid = CommonClass.Scaler("ActiveAcademicYear");
        if (!IsPostBack)
        {
            fillfyid();
        }
    }
    private void fillfyid()
    {
        string str = "select FYID,FYName from financial_Year";
        DataTable Dt = objdut.GetDataTable(str);
        if (Dt.Rows.Count > 0)
        {
            ddlfinancialyear.DataSource = Dt;
            ddlfinancialyear.DataTextField = "FYName";
            ddlfinancialyear.DataValueField = "FYID";
            ddlfinancialyear.DataBind();
            ddlfinancialyear.SelectedValue = fyid.ToString();
        }
        Dt.Dispose();
    }
}