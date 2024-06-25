using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HO_overall_admissions : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    DataUtility obj = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillfyear();
        }
    }
    public void fillfyear()
    {
        DataTable Dt =new DataTable();
        Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
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
        ddlclass.Items.Insert(0, new ListItem("--Select Class--", "0"));
    }
    [WebMethod]
    public static BIndClass[] BindClassDDL(string brid, string fyid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(fyid), Convert.ToInt32(brid));
        List<BIndClass> BindObj = new List<BIndClass>();
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            BIndClass Obj = new BIndClass();
            Obj.ID = Dt.Rows[i]["classid"].ToString();
            Obj.ClassName = Dt.Rows[i]["Classname"].ToString();
            BindObj.Add(Obj);
        }
        return BindObj.ToArray();
    }

    public class BIndClass
    {
        public string ID { get; set; }

        public string ClassName { get; set; }
    }

    [WebMethod]
    public static GetadmissionDetails[] BindGridByJs(string StudentName, string ParentMobileNo, string AdmissionNo, string FromDate, string ToDate, string ClassId, string pagesize, string pageno, string fyid, string brid)
    {
        DataSet Ds = new DataSet();
        List<GetadmissionDetails> Details = new List<GetadmissionDetails>();
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
        Param[8] = new SqlParameter("@Brid", brid);
        Param[9] = new SqlParameter("@fyid", fyid);
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
                user.Discount = DtRow["Discount"].ToString();
                user.TotalFee = DtRow["TotalFee"].ToString();
                user.PaidFee = DtRow["PaidFee"].ToString();
                user.BalanceFee = DtRow["BalanceFee"].ToString();
                user.TaxPaid = DtRow["TaxPaid"].ToString();
                user.pagecount = Ds.Tables[1].Rows[0]["pages"].ToString();
                user.SumOfDiscount = DtRow["SumOfDiscount"].ToString();
                user.SumOfTotalFee = DtRow["SumOfTotalFee"].ToString();
                user.SumOfPaid = DtRow["SumOfPaid"].ToString();
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

        public string Discount { get; set; }

        public string TotalFee { get; set; }

        public string PaidFee { get; set; }

        public string BalanceFee { get; set; }

        public string TaxPaid { get; set; }

        public string pagecount { get; set; }

        public string SumOfDiscount { get; set; }

        public string SumOfTotalFee { get; set; }

        public string SumOfPaid { get; set; }

        public string SumOfBalance { get; set; }

        public string SumOfTaxPaid { get; set; }

    }

    [WebMethod]
    public static getlabelsdetails[] Bindlable(string StudentName, string ParentMobileNo, string AdmissionNo, string FromDate, string ToDate, string ClassId, string pagesize, string pageno, string fyid,string brid)
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
        Param[8] = new SqlParameter("@Brid", brid);
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
    }

}