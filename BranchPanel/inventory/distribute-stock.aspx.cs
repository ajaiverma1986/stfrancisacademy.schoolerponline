using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_inventory_distribute_stock_list : System.Web.UI.Page
{
    private DataUtility Objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        BindDDL();
    }

    public void BindDDL()
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@Brid", Convert.ToString(HttpContext.Current.Session["Brbrid"]));
        param[1] = new SqlParameter("@mode",1);
        DataTable Dt = Objdut.GetDataTableSP(param, "[Usp_Bind_AllClass]");
        ddlClass.DataSource = Dt;
        ddlClass.DataTextField = "ClassName";
        ddlClass.DataValueField = "ClassID";
        ddlClass.DataBind();
        ddlClass.Items.Insert(0, new ListItem("All Class", "0"));
    
        param[0] = new SqlParameter("@Brid", Convert.ToString(HttpContext.Current.Session["Brbrid"]));
        param[1] = new SqlParameter("@mode", 2);
        Dt = Objdut.GetDataTableSP(param, "[Usp_Bind_AllClass]");
        ddlSection.DataSource = Dt;
        ddlSection.DataTextField = "SectionName";
        ddlSection.DataValueField = "cwsid";
        ddlSection.DataBind();
        ddlSection.Items.Insert(0, new ListItem("All Section", "0"));
    }

    [WebMethod]
    public static string BindSearchingGrid(string SearchMode, string SearchingValue, string Section, string Class)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@SearchMode", SearchMode);
        param[1] = new SqlParameter("@SearchingValue", SearchingValue);
        param[2] = new SqlParameter("@Section", Section);
        param[3] = new SqlParameter("@Class", Class);
        param[4] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        DataTable Dt = Objdut.GetDataTableSP(param, "[Usp_BindSearchResult]");
        return (Dt.Rows[0]["AllDataForBind"].ToString());
    }

    [WebMethod]
    public static int DistributeProduct(string DistributerType = "", string DistributerId = "", string AllProductId = "", string AllQuentity = "", string AllComment = "",
    string DistributedDate = "", string DistributeStockName = "")
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[9];
        param[0] = new SqlParameter("@DistributerType", DistributerType);
        param[1] = new SqlParameter("@DistributerId", DistributerId);
        param[2] = new SqlParameter("@AllProductId", AllProductId);
        param[3] = new SqlParameter("@AllQuentity", AllQuentity);
        param[4] = new SqlParameter("@AllComment", AllComment);
        param[5] = new SqlParameter("@DistributedDate", DistributedDate);
        param[6] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[7] = new SqlParameter("@DistributeStockName", DistributeStockName);
        param[8] = new SqlParameter("@intresult", SqlDbType.Int);
        param[8].Direction = ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, "Usp_DsitributeStock");
        return result;
    }

    //check product start here
    [WebMethod]
    public static int CheckProduct(string pid)
    {
        DataUtility Objdut = new DataUtility();
        int brid = Convert.ToInt32(HttpContext.Current.Session["BrBrid"]);
        string query = "select Toatl_Available_Product from tbl_product_availability where Product_id=" + pid + " and Brid=" + brid + "";
        int Result = Convert.ToInt32(Objdut.GetScalar(query));
        return Result;
    }

    //check product end here
}