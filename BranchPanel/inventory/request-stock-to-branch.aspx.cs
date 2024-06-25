using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_inventory_request_stock_to_branch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static GetBranch[] BindBranch()
    {
        List<GetBranch> Details = new List<GetBranch>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        Dt = Objdut.GetDataTable("Select (Brid) as Id,(BrName)as Name From Branch_master Where Bractive=1 and Brid<>" + HttpContext.Current.Session["BrBrid"] + " order By Brid Asc");
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

    [WebMethod]
    public static int RequestStock(string StockName = "", string AllCategory = "", string AllSubCategory = "", string AllProduct = "", string AllQuantity = "",
    string AllDescription = "", string Date = "", string Brid = "0", string RequestRemark = "")
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[11];
        param[0] = new SqlParameter("@StockName", StockName);
        param[1] = new SqlParameter("@AllCategory", AllCategory);
        param[2] = new SqlParameter("@AllSubCategory", AllSubCategory);
        param[3] = new SqlParameter("@AllProduct", AllProduct);
        param[4] = new SqlParameter("@AllQuantity", AllQuantity);
        param[5] = new SqlParameter("@AllDescription", AllDescription);
        param[6] = new SqlParameter("@Date", Date);
        param[7] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[8] = new SqlParameter("@RequestForBrid", Brid);
        param[9] = new SqlParameter("@RequestRemark", RequestRemark);
        param[10] = new SqlParameter("@intresult", SqlDbType.Int);
        param[10].Direction = ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, "Usp_RequestStock");
        return result;
    }
}