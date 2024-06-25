using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_inventory_distributed_stock_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static string BindDistributedStockList(string FromDate, string ToDate, string Category, string SubCategory, string Product, string Type, string Mode)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[8];
        param[0] = new SqlParameter("@FromDate", FromDate);
        param[1] = new SqlParameter("@ToDate", ToDate);
        param[2] = new SqlParameter("@Category", Category);
        param[3] = new SqlParameter("@SubCategory", SubCategory);
        param[4] = new SqlParameter("@Product", Product);
        param[5] = new SqlParameter("@Type", Type);
        param[6] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[7] = new SqlParameter("@Mode", Mode);
        DataTable Dt = Objdut.GetDataTableSP(param, "[Usp_BindDistributedProductList]");
        return (Dt.Rows[0]["AllDataForBind"].ToString());
    }
}