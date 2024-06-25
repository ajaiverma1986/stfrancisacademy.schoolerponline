using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class BranchPanel_Fee_Management_collection : System.Web.UI.Page
{
    DataUtility objUTL = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        BindSessionDDL();
        if (!IsPostBack)
        {
            bindUser();
        }
    }

    private void bindUser()
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@Userid", Convert.ToInt32(Session["BrADID"]));
        param[1] = new SqlParameter("@Brid", Convert.ToInt32(Session["BrBrid"]));
        DataSet ds = objUTL.GetDataSetSP(param, "[search_user_list]");
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddluser.DataSource = ds.Tables[0];
            ddluser.DataValueField = "Eid";
            ddluser.DataTextField = "UserName";
            ddluser.DataBind();
        }
        //ddluser.Items.Insert(0, New ListItem("--Select Customer--", "0"))
        ddluser.Items.Insert(0, new ListItem("--Select--", "0"));
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
    [WebMethod]
    public static Getfee[] BindGridByJs(string fromdate, string todate, string name, string receiptno, string mobileno, string paymentmode, int Fyid, string pagesize, string pageno, string userc)       
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
        param[11] = new SqlParameter("@userc", userc);
        Ds = Objdut.GetDataSetSP(param, "[usp_studentcollection]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
			 DataTable dtCol = new DataTable();
            dtCol.Columns.Add("S.No.");
            dtCol.Columns.Add("Reg No");
            dtCol.Columns.Add("Paid Date");
            dtCol.Columns.Add("Receipt No.");
            dtCol.Columns.Add("Name");           
            dtCol.Columns.Add("Class");
            dtCol.Columns.Add("Father Name");
            dtCol.Columns.Add("Payment Mode");
            dtCol.Columns.Add("Fee Paid");
			dtCol.Columns.Add("User Name");
            ManageDoc doc = new ManageDoc();
            string baseUrl = HttpContext.Current.Request.Url.Scheme + "://" + HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.ApplicationPath.TrimEnd('/') + "/";
            string fileName =  "collectionPdf" + DateTime.Now.ToString("ddMMyyyyhhmm") + ".pdf";            
            int i = 1;
			decimal totalfee = 0;
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
				var payMode= dtrow["PaymentModeName"].ToString();
				if(payMode!=""){
					if(payMode.ToLower()=="case"){
						dtrow["PaymentModeName"]="Cash";
					}
				}
                Getfee user = new Getfee();
				 DataRow dr = dtCol.NewRow();
                dr["S.No."] = i;
                dr["Reg No"] = dtrow["RegNewNo"].ToString();
                dr["Paid Date"] = dtrow["PaidDate"].ToString();
                dr["Receipt No."] = dtrow["ReciptNo"].ToString();
                dr["Name"] = dtrow["studentname"].ToString();
                dr["Class"] = dtrow["Classname"].ToString();
                dr["Father Name"] = dtrow["FatherName"].ToString();
                dr["Payment Mode"] = dtrow["PaymentModeName"].ToString();
                dr["Fee Paid"] = dtrow["PaidAmountWithOutTax"].ToString();
                dr["User Name"] = dtrow["UserName"].ToString();
                dtCol.Rows.Add(dr);
                user.RegNewNo = dtrow["RegNewNo"].ToString();
                user.PaidDate = dtrow["PaidDate"].ToString();
                user.ReciptNo = dtrow["ReciptNo"].ToString();
                user.studentname = dtrow["studentname"].ToString();
                user.PrimaryMobileNo = dtrow["PrimaryMobileNo"].ToString();
                user.PaymentModeName = dtrow["PaymentModeName"].ToString();
                user.PaidAmountWithOutTax = dtrow["PaidAmountWithOutTax"].ToString();
                user.PaidTaxAmount = dtrow["PaidTaxAmount"].ToString();
                user.Total = dtrow["Total"].ToString();
                user.CommentOrRemark = dtrow["CommentOrRemark"].ToString();
                user.Classname = dtrow["Classname"].ToString();
                user.FatherName = dtrow["FatherName"].ToString();
                user.UserName = dtrow["UserName"].ToString();
                user.Discount = dtrow["Discount"].ToString();
                user.pagecount = Ds.Tables[2].Rows[0]["pages"].ToString();
                user.TtlPaidAmountWithOutTax = Ds.Tables[1].Rows[0]["Column1"].ToString();
                user.TtlPaidTaxAmount = Ds.Tables[1].Rows[0]["Column2"].ToString();
                user.TtlTotal = Ds.Tables[1].Rows[0]["Column3"].ToString();

				  user.filePath = baseUrl+"/Uploads/" + fileName;
			    decimal tempfee = 0;
                decimal.TryParse(dtrow["PaidAmountWithOutTax"].ToString(), out tempfee);
                totalfee = totalfee + tempfee;
                           // total = total + temptotal;
                Details.Add(user);
                i++;
            }
            doc.CreatePdf(HttpContext.Current.Server.MapPath("~/Uploads/") + fileName, dtCol, "Fee Collection Report",totalfee.ToString()+"("+ conversion(totalfee.ToString())+")");
        }
        return Details.ToArray();
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
    public class Getfee
    {
        public string AdmissionNo { get; set; }
        public string RegNewNo { get; set; }
        public string ReciptNo { get; set; }
        public string studentname { get; set; }
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
        public string FatherName{get;set;}
        public string UserName { get; set; }
        public string Discount { get; set; }
    }
    
}
