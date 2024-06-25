using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_inventory_add_stock : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static string BindEveryThing(string Id, string Mode, string Name)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@Id", Id);
        param[1] = new SqlParameter("@Mode", Mode);
        param[2] = new SqlParameter("@NameForSearch", Name);
        DataTable Dt = Objdut.GetDataTableSP(param, "[Usp_BindEveryThingOfStock]");
        return (Dt.Rows[0]["AllDataForBind"].ToString());
    }
    [WebMethod]
    public static int AddStock(string StockName = "", string AllCategory = "", string AllSubCategory = "", string AllProduct = "", string AllQuantity = "",
    string AllDescription = "", string Date = "")
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[9];
        param[0] = new SqlParameter("@StockName", StockName);
        param[1] = new SqlParameter("@AllCategory", AllCategory);
        param[2] = new SqlParameter("@AllSubCategory", AllSubCategory);
        param[3] = new SqlParameter("@AllProduct", AllProduct);
        param[4] = new SqlParameter("@AllQuantity", AllQuantity);
        param[5] = new SqlParameter("@AllDescription", AllDescription);
        param[6] = new SqlParameter("@Date", Date);
        param[7] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[8] = new SqlParameter("@intresult", SqlDbType.Int);
        param[8].Direction = ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, "Usp_AddStock");
        return result;
    }
}