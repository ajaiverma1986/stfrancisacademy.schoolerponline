using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_inventory_stock_request_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static string BindRequestedStockList(string Id, string Mode, string FromDate, string ToDate, string Category, string SubCategory, string Product)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[9];
        param[0] = new SqlParameter("@Id", Id);
        param[1] = new SqlParameter("@Mode", Mode);
        param[2] = new SqlParameter("@FromDate", FromDate);
        param[3] = new SqlParameter("@ToDate", ToDate);
        param[4] = new SqlParameter("@Category", Category);
        param[5] = new SqlParameter("@Subcategory", SubCategory);
        param[6] = new SqlParameter("@Product", Product);
        param[7] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[8] = new SqlParameter("@IsStockRequestListPage", 1);
        DataTable Dt = Objdut.GetDataTableSP(param, "[Usp_BindRequestedStock]");
        return (Dt.Rows[0]["AllDataForBind"].ToString());
    }

    [WebMethod]
    public static int ApproveStock(string AllStockRequestedProductId = "", string AllApproveQuentity = "", string AllApproveDescription = "", string AllDate = "", string Mode = "", string Remark = "")
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[8];
        param[0] = new SqlParameter("@AllStockRequestedProductId", AllStockRequestedProductId);
        param[1] = new SqlParameter("@AllApproveQuentity", AllApproveQuentity);
        param[2] = new SqlParameter("@AllApproveDescription", AllApproveDescription);
        param[3] = new SqlParameter("@AllDate", AllDate);
        param[4] = new SqlParameter("@Mode", Mode);
        param[5] = new SqlParameter("@Remark", Remark);
        param[6] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[7] = new SqlParameter("@intresult", SqlDbType.Int);
        param[7].Direction = ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, "Usp_ApproveStock");
        return result;
    }

    //code for check for all product start here
    public class ProductAvailable
    {
        public string Product_Id { set; get; }

        public string Toatl_Available_Product { set; get; }
    }

    [WebMethod]
    public static ProductAvailable[] CheckProduct(string tid)
    {
        DataUtility Objdut = new DataUtility();
        List<ProductAvailable> Details = new List<ProductAvailable>();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@AllProductid", tid);
        param[1] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[2] = new SqlParameter("@mode", 3);
        DataTable Dt = Objdut.GetDataTableSP(param, "[Usp_BindRequestedStock]");
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in Dt.Rows)
            {
                ProductAvailable prodobj = new ProductAvailable();
                prodobj.Product_Id = dtrow["Product_Id"].ToString();
                prodobj.Toatl_Available_Product = dtrow["Toatl_Available_Product"].ToString();
                Details.Add(prodobj);
            }
        }
        return Details.ToArray();
    }

    //code for check for all product start here
}