using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_inventory_stock_list_day_wise : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static string BindStockList(string Id, string Mode, string FromDate, string ToDate, string Category, string SubCategory, string Product)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[8];
        param[0] = new SqlParameter("@Id", Id);
        param[1] = new SqlParameter("@Mode", Mode);
        param[2] = new SqlParameter("@FromDate", FromDate);
        param[3] = new SqlParameter("@ToDate", ToDate);
        param[4] = new SqlParameter("@Category", Category);
        param[5] = new SqlParameter("@Subcategory", SubCategory);
        param[6] = new SqlParameter("@Product", Product);
        param[7] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        DataTable Dt = Objdut.GetDataTableSP(param, "[Usp_BindDailyStock]");
        return (Dt.Rows[0]["AllDataForBind"].ToString());
    }

    [WebMethod]
    public static string BindAllDDL(string Id, string Mode)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@Id", Id);
        param[1] = new SqlParameter("@Mode", Mode);
        DataTable Dt = Objdut.GetDataTableSP(param, "[Usp_BindCategorySubcategoryProductList]");
        return (Dt.Rows[0]["AllDataForBind"].ToString());
    }

    [WebMethod]
    public static int DeleteStock(string stockid = "")
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@stocksid", stockid);
        param[1] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[2] = new SqlParameter("@intresult", SqlDbType.Int);
        param[2].Direction = ParameterDirection.Output;
        param[3] = new SqlParameter("@mode", "deleteStock");
        int result = objdut.ExecuteSqlSP(param, "[usp_FillStockList]");
        return result;
    }
}