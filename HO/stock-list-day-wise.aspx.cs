using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class HO_stock_list_day_wise : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static string BindStockList(string Id, string Mode, string FromDate, string ToDate, string Category, string SubCategory, string Product, string brid)
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
        param[7] = new SqlParameter("@Brid", brid);
        param[8] = new SqlParameter("@IsHo", 1);
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
    public static GetBranch[] BindBranch()
    {
        List<GetBranch> Details = new List<GetBranch>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        Dt = Objdut.GetDataTable("Select (Brid) as Id,(BrName) as Name From Branch_master where IsFranchisee=0 order By Brid Asc");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                GetBranch obje = new GetBranch();
                obje.Id = Convert.ToInt32(Dt.Rows[i]["Id"]);
                obje.Name = Convert.ToString(Dt.Rows[i]["Name"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }

    public class GetBranch
    {
        public int Id { get; set; }

        public string Name { get; set; }
    }
}