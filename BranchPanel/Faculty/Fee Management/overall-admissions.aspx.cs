using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_Fee_Management_overall_admissions : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillfyear();
        }
    }
    public void fillfyear()
    {
        DataTable Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);

     
    }
    [WebMethod]
    public static getcourse[] BindClassMethod(int fyid)
    {
        List<getcourse> Details = new List<getcourse>();
        DataTable Dt = new DataTable();
        Dt = CommonClass.ABC("GetClassDDL", fyid, Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                getcourse obje = new getcourse();
                obje.courseID = Convert.ToInt32(Dt.Rows[i]["classid"]);
                obje.courseName = Convert.ToString(Dt.Rows[i]["Classname"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }
    [WebMethod]
    public static getcourse[] BindSectionMethod(int fyid, int ClassID)
    {
        List<getcourse> Details = new List<getcourse>();
        DataTable Dt = new DataTable();
        Dt = CommonClass.ABC("GetSection", ClassID, Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                getcourse obje = new getcourse();
                obje.courseID = Convert.ToInt32(Dt.Rows[i]["SectionID"]);
                obje.courseName = Convert.ToString(Dt.Rows[i]["Section"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }

    public class getcourse
    {
        public int courseID { get; set; }

        public string courseName { get; set; }
    }

    [WebMethod]
    public static GetadmissionDetails[] BindGridByJs(string StudentName, string ParentMobileNo, string AdmissionNo, string PaidFromDate, string PaidToDate, string FromDate, string ToDate, string ClassId, string SectionId, string pagesize,string pageno, string fyid)
    {
        DataSet Ds = new DataSet();
        List<GetadmissionDetails> Details = new List<GetadmissionDetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[11];
        Param[0] = new SqlParameter("@Name", StudentName);
        Param[1] = new SqlParameter("@Mobile", ParentMobileNo);
        Param[2] = new SqlParameter("@AdmissionNo", AdmissionNo);
        Param[3] = new SqlParameter("@FromDate", FromDate);
        Param[4] = new SqlParameter("@ToDate", ToDate);
        Param[5] = new SqlParameter("@ClassId", ClassId);
        Param[6] = new SqlParameter("@pagesize", pagesize);
        Param[7] = new SqlParameter("@pageno", pageno);
        Param[8] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        Param[9] = new SqlParameter("@fyid", fyid);
        Param[10] = new SqlParameter("@SectionID", SectionId);

        Ds = Objdut.GetDataSetSP(Param, "[Usp_BindOverallAdmission]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow DtRow in Ds.Tables[0].Rows)
            {
                GetadmissionDetails user = new GetadmissionDetails();
                user.AdmissionDate = DtRow["AdmissionDate"].ToString();
                user.AdmissionNo = DtRow["AdmissionNo"].ToString();
                user.Name = DtRow["Name"].ToString();
                user.MobileNo = DtRow["MobileNo"].ToString();
                user.Class = DtRow["Class"].ToString();
                user.SectionID = DtRow["Section"].ToString();
                user.Discount = DtRow["Discount"].ToString();
                user.TotalFee = DtRow["TotalFee"].ToString();
                user.FeeFine = DtRow["FeeFine"].ToString();
                user.PaidFee = DtRow["PaidFee"].ToString();
                user.BalanceFee = DtRow["BalanceFee"].ToString();
                user.TaxPaid = DtRow["TaxPaid"].ToString();  
                user.pagecount = Ds.Tables[1].Rows[0]["pages"].ToString();
                user.SumOfDiscount = DtRow["SumOfDiscount"].ToString();
                user.SumOfTotalFee = DtRow["SumOfTotalFee"].ToString();
                user.SumOfPaid = DtRow["SumOfPaid"].ToString();
                user.SumOfFeeFine = DtRow["SumOfFeeFine"].ToString();
                user.SumOfBalance = DtRow["SumOfBalance"].ToString();
                user.SumOfTaxPaid = DtRow["SumOfTaxPaid"].ToString(); 
                Details.Add(user);
            }
        }
        return Details.ToArray();
    }

    public class GetadmissionDetails
    {
        public string AdmissionDate { get; set; }

        public string AdmissionNo { get; set; }

        public string Name { get; set; }

        public string MobileNo { get; set; }

        public string Class { get; set; }
        public string SectionID { get; set; }

        public string Discount { get; set; }

        public string TotalFee { get; set; }

        public string PaidFee { get; set; }
        public string FeeFine { get; set; }

        public string BalanceFee { get; set; }

        public string TaxPaid { get; set; }

        public string pagecount { get; set; }

        public string SumOfDiscount { get; set; }

        public string SumOfTotalFee { get; set; }

        public string SumOfPaid { get; set; }
        public string SumOfFeeFine { get; set; }

        public string SumOfBalance { get; set; }

        public string SumOfTaxPaid { get; set; }

    }

    [WebMethod]
    public static getlabelsdetails[] Bindlable(string StudentName, string ParentMobileNo, string AdmissionNo, string PaidFromDate, string PaidToDate, string FromDate, string ToDate, string ClassId, string pagesize,          string pageno, string fyid)
    {
        DataSet Ds = new DataSet();
        List<getlabelsdetails> Details = new List<getlabelsdetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[10];
        Param[0] = new SqlParameter("@Name", StudentName);
        Param[1] = new SqlParameter("@Mobile", ParentMobileNo);
        Param[2] = new SqlParameter("@AdmissionNo", AdmissionNo);
        Param[3] = new SqlParameter("@FromDate", FromDate);
        Param[4] = new SqlParameter("@ToDate", ToDate);
        Param[5] = new SqlParameter("@ClassId", ClassId);
        Param[6] = new SqlParameter("@pagesize", pagesize);
        Param[7] = new SqlParameter("@pageno", pageno);
        Param[8] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        Param[9] = new SqlParameter("@fyid", fyid);
        Ds = Objdut.GetDataSetSP(Param, "[Usp_BindOverallAdmission]");
        if (Ds.Tables[2].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[2].Rows)
            {
                getlabelsdetails user = new getlabelsdetails();
                user.TotalAdmission = dtrow["TotalAdmission"].ToString();
                user.TotalFee = dtrow["TotalFee"].ToString();
                user.RecivedFee = dtrow["RecivedFee"].ToString();
                user.RecivedTax = dtrow["RecivedTax"].ToString();
                user.TotalRecivedFee = dtrow["TotalRecivedFee"].ToString();
                user.TotalBalanceFee = dtrow["TotalBalanceFee"].ToString();
                user.TotalFeeFine = dtrow["TotalFeeFine"].ToString();
                user.TotalDiscount = dtrow["TotalDiscount"].ToString();
                Details.Add(user);
            }
        }
        return Details.ToArray();
    }

    public class getlabelsdetails
    {
        public string TotalAdmission { get; set; }

        public string TotalFee { get; set; }

        public string RecivedFee { get; set; }

        public string RecivedTax { get; set; }

        public string TotalRecivedFee { get; set; }

        public string TotalBalanceFee { get; set; }
        public string TotalFeeFine { get; set; }
        public string TotalDiscount { get; set; }
    }
}