using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Services;

public partial class HO_session_management : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static string BindData(string StartYear)
    {
        DataUtility ObjDut = new DataUtility();
        DataSet Ds;
        SqlParameter[] Param = new SqlParameter[1];
        Param[0] = new SqlParameter("@Starttingyear", StartYear);
        Ds = ObjDut.GetDataSetSP(Param, "[USP_GetFinancialyearDetails]");
        return Ds.GetXml();

    }
    [WebMethod]
    public static string SaveData(string StartYear)
    {
        DataUtility ObjDut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[2];
        Param[0] = new SqlParameter("@Starttingyear", StartYear);
        Param[1] = new SqlParameter("@intresult", SqlDbType.Int);
        Param[1].Direction = ParameterDirection.Output;
        int IntResult = ObjDut.ExecuteSqlSP(Param, "[usp_Financialyear]");
        return ((IntResult > 0 ? (ConfigurationManager.AppSettings["InsertMsg"].ToString())
        : ConfigurationManager.AppSettings["ErrorMessage"].ToString()).ToString());

    }
    [WebMethod]
    public static string BindGrid()
    {
        DataUtility ObjDut = new DataUtility();
        DataSet Ds;
        Ds = ObjDut.GetDataSet("[USP_GetFinancialyearDetails]");
        return Ds.GetXml();

    }
}