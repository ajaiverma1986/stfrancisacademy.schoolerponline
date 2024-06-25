using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class AdminPanel_Login : System.Web.UI.Page
{
    DataUtility Objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
      // UpdateTransMultiFee();
	//getTransFee();
    }
    private void UpdateTransMultiFee()
    {
        string strQuery = @"Select * from tbl_transfee where Brid=" + Convert.ToInt32(Session["BrBrid"]) + " and Fyid=(Select TOP 1 Fyid from financial_Year where IsActive=1) " +
            "and AllAsaid <> '' and PayStatus=2 and FeeFineAmount > 0  and Payment_Date < '2022-06-30' order by Payment_Date desc";
        DataTable dt = Objdut.GetDataTable(strQuery);
        foreach (DataRow dr in dt.Rows)
        {
            string strUpdate = @"update tbl_TransFee SET FeeAmount = (ISNULL(FeeAmount,0) - ISNULL(FeeFineAmount,0)) where PayAmtID=" + dr["PayAmtID"] + "";
            Objdut.ExecuteSql(strUpdate);
        }
    }
 public void getTransFee()
    {
        DataUtility objdut = new DataUtility();
        DataTable ds = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            string strQuery = @"Select AllAsaid from tbl_TransFee where Fyid =(select FYID from financial_Year where IsActive=1) 
                                and Brid=" + Convert.ToInt16(Session["BrBrid"]) + " and ISNULL(AllAsaid,'') <> '' order by PayAmtID desc";
            using (SqlCommand cmd = new SqlCommand(strQuery, con))
            {
                con.Open();
                cmd.CommandType = CommandType.Text;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Rows.Count > 0)
                {
                    foreach(DataRow dr in ds.Rows)
                    {
                        getTransFeeByMonth(dr.ItemArray[0].ToString());
                    }
                }
            }
        }
    }
    public void getTransFeeByMonth(string AllAsaid)
    {
        DataUtility objdut = new DataUtility();
        DataTable ds = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            string strQuery = @"Select distinct TOP 1 Payment_Date from tbl_TransFee where ASAID IN (" + AllAsaid + ") order by Payment_Date desc";
            using (SqlCommand cmd = new SqlCommand(strQuery, con))
            {
                con.Open();
                cmd.CommandType = CommandType.Text;
                var Payment_Date = Convert.ToString(cmd.ExecuteScalar());
                if (!string.IsNullOrWhiteSpace(Payment_Date))
                    UpdatePaymentDate(AllAsaid, Payment_Date);
            }
        }
    }

    private void UpdatePaymentDate(string allAsaid,string Payment_Date)
    {
        DataUtility objdut = new DataUtility();
        DataTable ds = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            var payDate = Convert.ToDateTime(Payment_Date).ToString("MM/dd/yyyy");
            string strQuery = @"update tbl_TransFee set Payment_Date='" + payDate + "' where allAsaid='" + allAsaid + "'";
            using (SqlCommand cmd = new SqlCommand(strQuery, con))
            {
                con.Open();
                cmd.CommandType = CommandType.Text;
                var result = cmd.ExecuteNonQuery();
            }
        }
    }
}