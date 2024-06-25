using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Fee_Management_transportFeeCollection : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindSessionDDL();
    }
    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlfyear.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlfyear.DataValueField = "Fyid";
        ddlfyear.DataTextField = "FYName";
        ddlfyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    private static DataTable getVehicleByStudent(int VehicleID,DataUtility Objdut)
    {
        DataTable dtVehicleToStudent = new DataTable();
        string str = "";
        if (VehicleID > 0) {
            str = " and VehicleRegID=" + VehicleID;
        }
        string strVehicleToStudent = "select * from tbl_TransPortDetails where 1=1"+ str;
        dtVehicleToStudent = Objdut.GetDataTable(strVehicleToStudent);
        return dtVehicleToStudent;
    }

    [WebMethod]
    public static Getfee[] BindGridByJs(string fromdate, string todate, string name, string receiptno, string mobileno, string paymentmode, int Fyid, int VehicleID, string pagesize, string pageno)
    {
        DataSet Ds = new DataSet();
        List<Getfee> Details = new List<Getfee>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[12];
        param[0] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[1] = new SqlParameter("@Mode", 1);
        param[2] = new SqlParameter("@Fromdate", fromdate);
        param[3] = new SqlParameter("@Todate", todate);
        param[4] = new SqlParameter("@Name", name);
        param[5] = new SqlParameter("@ReciptNo", receiptno);
        param[6] = new SqlParameter("@MobileNo", mobileno);
        param[7] = new SqlParameter("@paymentmode", paymentmode);
        param[8] = new SqlParameter("@Fyid", Fyid);
        param[9] = new SqlParameter("@pagesize", pagesize);
        param[10] = new SqlParameter("@pageno", pageno);
        param[11] = new SqlParameter("@VehicleID", VehicleID);
        Ds = Objdut.GetDataSetSP(param, "[usp_studentTransportcollection]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            DataTable dtCol = new DataTable();
            dtCol.Columns.Add("S.No.");
            dtCol.Columns.Add("Date"); 
            dtCol.Columns.Add("AdmissionID");
            dtCol.Columns.Add("Name");
            dtCol.Columns.Add("Parent Name");
            dtCol.Columns.Add("Mobile No");
            dtCol.Columns.Add("Class");
            dtCol.Columns.Add("Section");
            dtCol.Columns.Add("Transport Name");
            dtCol.Columns.Add("Trip");
            dtCol.Columns.Add("Area");
            dtCol.Columns.Add("Transport Fee");
            dtCol.Columns.Add("Calculated Amount");
            dtCol.Columns.Add("Recevied Amount");
            dtCol.Columns.Add("FeeMonth");
            dtCol.Columns.Add("Fine");
            dtCol.Columns.Add("Receipt No");            
            dtCol.Columns.Add("LoggedInUser");
            ManageDoc doc = new ManageDoc();
            string baseUrl = HttpContext.Current.Request.Url.Scheme + "://" + HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.ApplicationPath.TrimEnd('/') + "/";
            string fileName = "collectionPdf" + DateTime.Now.ToString("ddMMyyyyhhmm") + ".pdf";
            int i = 1; 
            decimal total = 0;
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                if (Convert.ToDecimal(dtrow["TransportFee"]) > 0)
                {
                    Getfee user = new Getfee();
                    DataRow dr = dtCol.NewRow();
                    dr["S.No."] = i.ToString();
                    dr["Date"] = dtrow["PaidDate"].ToString();
                    dr["AdmissionID"] = dtrow["RegNewNo"].ToString();
                    dr["Name"] = dtrow["studentname"].ToString();
                    dr["Parent Name"] = dtrow["FatherName"].ToString();
                    dr["Mobile No"] = dtrow["PrimaryMobileNo"].ToString();
                    dr["Class"] = dtrow["Classname"].ToString();
                    dr["Section"] = dtrow["Sectionname"].ToString();
                    dr["Transport Name"] = dtrow["Vehiclename"].ToString();
                    dr["Trip"] = dtrow["Stoppage"].ToString();
                    dr["Area"] = dtrow["StoppageName"].ToString();
                    dr["Transport Fee"] = dtrow["PaidAmountWithOutTax"].ToString();
                    dr["Calculated Amount"] = dtrow["PaidAmountWithOutTax"].ToString();
                    dr["Recevied Amount"] = dtrow["PaidAmountWithOutTax"].ToString();
                    dr["FeeMonth"] = Convert.ToString(getMonthName(dtrow["PayAmtID"].ToString()));
                    dr["Fine"] = dtrow["FeeFineAmt"].ToString(); ;
                    dr["Receipt No"] = dtrow["ReciptNo"].ToString();
                    dr["LoggedInUser"] = dtrow["UserName"].ToString();
                    dtCol.Rows.Add(dr);
                    dtCol.AcceptChanges();

                    user.Stoppage = dtrow["Stoppage"].ToString();
                    user.RegNewNo = dtrow["RegNewNo"].ToString();
                    user.PaidDate = dtrow["PaidDate"].ToString();
                    user.ReciptNo = dtrow["ReciptNo"].ToString();
                    user.studentname = dtrow["studentname"].ToString();
                    user.ParentName = dtrow["FatherName"].ToString();
                    user.PrimaryMobileNo = dtrow["PrimaryMobileNo"].ToString();

                    user.TransportName = dtrow["Vehiclename"].ToString();
                    user.Trip = dtrow["StoppageName"].ToString();
                    user.AreaName = dtrow["Stoppage"].ToString();

                    user.PaymentModeName = "Cash";
                    user.PaidAmountWithOutTax = dtrow["TransportFee"].ToString();
                    user.PaidTaxAmount = "0.00";
                    user.Total = dtrow["TransportFee"].ToString();
                    user.CommentOrRemark = dtrow["CommentOrRemark"].ToString();
                    user.Classname = dtrow["Classname"].ToString();
                    user.Sectionname = dtrow["Sectionname"].ToString();
                    user.FeeMonth = Convert.ToString(getMonthName(dtrow["PayAmtID"].ToString()));
                    user.FineAmount = dtrow["FeeFineAmt"].ToString();
                    user.UserName = dtrow["UserName"].ToString();
                    
                    
                    user.pagecount = Ds.Tables[2].Rows[0]["pages"].ToString();
                    total = total + Convert.ToDecimal(dtrow["TransportFee"]);
                    user.TtlPaidAmountWithOutTax = total.ToString();
                    user.TtlPaidTaxAmount = total.ToString();
                    user.TtlTotal = total.ToString();
                    user.filePath = baseUrl + "/Uploads/" + fileName;
                    Details.Add(user);
                }
            }
            //doc.CreatePdf(HttpContext.Current.Server.MapPath("~/Uploads/") + fileName, dtCol, "Fee Collection Report " + total.ToString() + "(" + conversion(total.ToString()) + ")");
            doc.CreatePdf(HttpContext.Current.Server.MapPath("~/Uploads/") + fileName, dtCol, "Transport Collection Report " + total.ToString() + "(" + conversion(total.ToString()) + ")", total.ToString());
        }
        return Details.ToArray();
    }
    [WebMethod]
    public static string getMonthName(string PayAmtId)
    {
        string monthNameList = "";
        DataUtility Objdut = new DataUtility();
        string allAsaid = Convert.ToString(Objdut.GetScalar("Select ISNULL(AllAsaid,'') from tbl_TransFee where PayAmtId=" + PayAmtId));
        if (string.IsNullOrEmpty(allAsaid))
        {
            allAsaid = Convert.ToString(Objdut.GetScalar("Select ISNULL(Asaid,'') from tbl_TransFee where PayAmtId=" + PayAmtId));
        }
        string[] AsaidList = allAsaid.Split(',');
        if (AsaidList.Length > 0)
        {
            for (int i = 0; i < AsaidList.Length; i++)
            {
                string monthName = Convert.ToString(Objdut.GetScalar("Select ISNULL(DateName(month, DateAdd(month, MonthId,-1)),'') from tbl_StudentAdmissionInstallment where ASAID=" + AsaidList[i]));
                if (string.IsNullOrEmpty(monthNameList))
                {
                    monthNameList = monthName;
                }
                else
                {
                    monthNameList = monthNameList + "," + monthName;
                }
            }
        }
        return monthNameList;
    }
    public static string conversion(string amount)
    {
        double m = Convert.ToInt64(Math.Floor(Convert.ToDouble(amount)));
        double l = Convert.ToDouble(amount);
        double j = (l - m) * 100;

        var beforefloating = ConvertNumbertoWords(Convert.ToInt64(m));
        var afterfloating = ConvertNumbertoWords(Convert.ToInt64(j));

        var Content = beforefloating + ' ' + " RUPEES" + " and " + afterfloating + ' ' + " PAISE only";
        return Content;
    }
    public static string ConvertNumbertoWords(long number)
    {
        if (number == 0) return "ZERO";
        if (number < 0) return "minus " + ConvertNumbertoWords(Math.Abs(number));
        string words = "";
        if ((number / 100000) > 0)
        {
            words += ConvertNumbertoWords(number / 100000) + " LAKH ";
            number %= 100000;
        }
        if ((number / 1000) > 0)
        {
            words += ConvertNumbertoWords(number / 1000) + " THOUSAND ";
            number %= 1000;
        }
        if ((number / 100) > 0)
        {
            words += ConvertNumbertoWords(number / 100) + " HUNDRED ";
            number %= 100;
        }
        //if ((number / 10) > 0)  
        //{  
        // words += ConvertNumbertoWords(number / 10) + " RUPEES ";  
        // number %= 10;  
        //}  
        if (number > 0)
        {
            if (words != "") words += " ";
            var unitsMap = new[]
        {
            "ZERO", "ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN", "EIGHT", "NINE", "TEN", "ELEVEN", "TWELVE", "THIRTEEN", "FOURTEEN", "FIFTEEN", "SIXTEEN", "SEVENTEEN", "EIGHTEEN", "NINETEEN"
        };
            var tensMap = new[]
        {
            "ZERO", "TEN", "TWENTY", "THIRTY", "FORTY", "FIFTY", "SIXTY", "SEVENTY", "EIGHTY", "NINETY"
        };
            if (number < 20) words += unitsMap[number];
            else
            {
                words += tensMap[number / 10];
                if ((number % 10) > 0) words += " " + unitsMap[number % 10];
            }
        }
        return words;
    }
    public class Getfee
    {
        public string AdmissionNo { get; set; }
        public string RegNewNo { get; set; }
        public string ReciptNo { get; set; }
        public string studentname { get; set; }
        public string ParentName { get; set; }
        public string PrimaryMobileNo { get; set; }
        public string PaymentModeName { get; set; }
        public string PaidAmountWithOutTax { get; set; }
        public string Total { get; set; }
        public string PaidTaxAmount { get; set; }
        public string CommentOrRemark { get; set; }
        public string Classname { get; set; }
        public string PaidDate { get; set; }
        public string pagecount { get; set; }
        public string TtlPaidAmountWithOutTax { get; set; }
        public string TtlTotal { get; set; }
        public string TtlPaidTaxAmount { get; set; }
        public string filePath { get; set; }
        public string Stoppage { get; set; }
        public string Sectionname { get; set; }
        public string FeeMonth { get; set; }
        public string UserName { get; set; }
        public string Vehiclename { get; set; }
        public string TransportName { get; set; }
        public string Trip { get; set; }
        public string AreaName { get; set; }
        public string FineAmount { get; set; }
    }
}