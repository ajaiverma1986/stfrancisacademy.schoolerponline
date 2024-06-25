using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class HO_overall_stock_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static string BindStockList(string Category, string SubCategory, string Product, string TillDate, string brid)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@CategoryId", Category);
        param[1] = new SqlParameter("@SubcategoryId", SubCategory);
        param[2] = new SqlParameter("@ProductId", Product);
        param[3] = new SqlParameter("@Brid", brid);
        param[4] = new SqlParameter("@TillDate", TillDate);
        DataTable Dt = Objdut.GetDataTableSP(param, "[USp_OverallStockList]");
        return (Dt.Rows[0]["AllDataForBind"].ToString());
    }
}