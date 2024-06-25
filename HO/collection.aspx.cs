using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HO_collection : System.Web.UI.Page
{
    DataUtility obj = new DataUtility();
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
        DataTable dt = new DataTable();
        dt = obj.GetDataTable("select Brid,BrName from Branch_master where BrActive=1 and isDeleted=0 and isActive=1");
        if (dt.Rows.Count > 0)
        {
            ddlbranch.DataSource = dt;
            ddlbranch.DataValueField = "Brid";
            ddlbranch.DataTextField = "BrName";
            ddlbranch.DataBind();
        }
        ddlbranch.Items.Insert(0, new ListItem("--Select Branch--", "0"));
    }
    [WebMethod]
    public static Getfee[] BindGridByJs(string fromdate, string todate, string name, string receiptno, string mobileno, string paymentmode, int Fyid, string brid, string pageno)
    {
        DataSet Ds = new DataSet();
        List<Getfee> Details = new List<Getfee>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[10];
        param[0] = new SqlParameter("@Brid", brid);
        param[1] = new SqlParameter("@Mode", 1);
        param[2] = new SqlParameter("@Fromdate", fromdate);
        param[3] = new SqlParameter("@Todate", todate);
        param[4] = new SqlParameter("@Name", name);
        param[5] = new SqlParameter("@ReciptNo", receiptno);
        param[6] = new SqlParameter("@MobileNo", mobileno);
        param[7] = new SqlParameter("@paymentmode", paymentmode);
        param[8] = new SqlParameter("@Fyid", Fyid);
        param[9] = new SqlParameter("@pageno", pageno);
        Ds = Objdut.GetDataSetSP(param, "[usp_studentcollection]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                Getfee user = new Getfee();
                user.AdmissionNo = dtrow["AdmissionNo"].ToString();
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
                user.pagecount = Ds.Tables[2].Rows[0]["pages"].ToString();
                user.TtlPaidAmountWithOutTax = Ds.Tables[1].Rows[0]["Column1"].ToString();
                user.TtlPaidTaxAmount = Ds.Tables[1].Rows[0]["Column2"].ToString();
                user.TtlTotal = Ds.Tables[1].Rows[0]["Column3"].ToString();
                Details.Add(user);
            }
        }
        return Details.ToArray();
    }
    public class Getfee
    {
        public string AdmissionNo { get; set; }
        public string ReciptNo { get; set; }
        public string studentname { get; set; }
        public string PrimaryMobileNo { get; set; }
        public string PaymentModeName { get; set; }
        public string PaidAmountWithOutTax { get; set; }
        public string Total { get; set; }
        public string PaidTaxAmount { get; set; }
        public string TtlPaidAmountWithOutTax { get; set; }
        public string TtlTotal { get; set; }
        public string TtlPaidTaxAmount { get; set; }
        public string CommentOrRemark { get; set; }
        public string Classname { get; set; }
        public string PaidDate { get; set; }
        public string pagecount { get; set; }
    }
    
}