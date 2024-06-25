using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_inventory_requested_stock_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static string BindRequestedStockList(string Id, string Mode, string FromDate, string ToDate, string Category, string SubCategory, string Product)
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
        DataTable Dt = Objdut.GetDataTableSP(param, "[Usp_BindRequestedStock]");
        return (Dt.Rows[0]["AllDataForBind"].ToString());
    }

    [WebMethod]
    public static int ReciveStock(string Remark, string Date, string StockRequestId)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@Remark", Remark);
        param[1] = new SqlParameter("@Date", Date);
        param[2] = new SqlParameter("@StockRequestId", StockRequestId);
        param[3] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[4] = new SqlParameter("@intresult", SqlDbType.Int);
        param[4].Direction = ParameterDirection.Output;
        int result = Objdut.ExecuteSqlSP(param, "Usp_ReciveStock");
        return result;
    }
}