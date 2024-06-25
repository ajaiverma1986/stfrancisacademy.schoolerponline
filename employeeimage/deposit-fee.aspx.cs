using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_Fee_Management_deposit_fee : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillfyear();
        }
    }

    public void fillfyear()
    {
        DataTable Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }

    [WebMethod]
    public static string BindFeeDetails(string pageno, string pagesize, string name, string admission, string fyid, string classid, string duefromdate, string duetodate)
    {
        DataSet Ds = new DataSet();
        DataUtility obj = new DataUtility();
        SqlParameter[] param = new SqlParameter[10];
        param[0] = new SqlParameter("@Mode", 2);
        param[1] = new SqlParameter("@pagesize", pagesize);
        param[2] = new SqlParameter("@pageno", pageno);
        param[3] = new SqlParameter("@FromDate", duefromdate);
        param[4] = new SqlParameter("@ToDate", duetodate);
        param[5] = new SqlParameter("@AdmissionNo", admission);
        param[6] = new SqlParameter("@Classid", classid);
        param[7] = new SqlParameter("@Name", name);
        param[8] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[9] = new SqlParameter("@fyid", fyid);
        Ds = obj.GetDataSetSP(param, "[StudentsAllDetails]");
        return Ds.GetXml().ToString();
    }
}