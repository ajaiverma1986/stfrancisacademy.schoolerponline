using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Student_Registration_chequepayment : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            fillfyear();
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
    public class Chequelist
    {
        public string Regfeeid { get; set; }
        public string Registrationno { get; set; }
        public string Name { get; set; }
        public string Classname { get; set; }
        public string ChequeAmount { get; set; }
        public string ChkRefNo { get; set; }
        public string ChkRefDate { get; set; }
        public string BankName { get; set; }
        public string CheckStatusChageDate { get; set; }
        public string CheckStatus { get; set; }
        public string PageCount { get; set; }
    }
    [WebMethod]
    public static Chequelist[] ChequeDetail(string pagesize, string pageno, string checkno, string fromdate, string todate, string fyid, string txtbankname)
    {
        List<Chequelist> Details = new List<Chequelist>();
        DataSet Ds = new DataSet();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[8];
        param[0] = new SqlParameter("@pagesize", pagesize);
        param[1] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);
        param[2] = new SqlParameter("@fyid", fyid);
        param[3] = new SqlParameter("@pageno", pageno);
        param[4] = new SqlParameter("@checkno", checkno);
        param[5] = new SqlParameter("@fromdate", fromdate);
        param[6] = new SqlParameter("@todate", todate);
        param[7] = new SqlParameter("@bankname", txtbankname);
        Ds = Objdut.GetDataSetSP(param, "Usp_BindCheque");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtRow in Ds.Tables[0].Rows)
            {
                Chequelist obj = new Chequelist();
                obj.Regfeeid = dtRow["Regfeeid"].ToString();
                obj.Registrationno = dtRow["Registrationno"].ToString();
                obj.Name = dtRow["Name"].ToString();
                obj.Classname = dtRow["Classname"].ToString();
                obj.ChequeAmount = dtRow["ChequeAmount"].ToString();
                obj.ChkRefNo = dtRow["ChkRefNo"].ToString();
                obj.ChkRefDate = dtRow["ChkRefDate"].ToString();
                obj.BankName = dtRow["BankName"].ToString();
                obj.CheckStatusChageDate = dtRow["CheckStatusChageDate"].ToString();
                obj.CheckStatus = dtRow["CheckStatus"].ToString();
                obj.PageCount = Ds.Tables[1].Rows[0]["pages"].ToString();
                Details.Add(obj);
            }
        }
        return Details.ToArray();
    }
    [WebMethod]
    public static int Check_Method(string rfid, string date, string statusname, string comment, string statusid)
    {
        DataUtility objDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[7];
        param[0] = new SqlParameter("@rfid", rfid);
        param[1] = new SqlParameter("@CheckDDNeftStatusChangeDate", date);
        param[2] = new SqlParameter("@CheckDDNeftStatsName", statusname);
        param[3] = new SqlParameter("@CheckDDNeftStatsId", statusid);
        param[4] = new SqlParameter("@Comment", comment);
        param[5] = new SqlParameter("@userId", HttpContext.Current.Session["BrADID"]);
        param[6] = new SqlParameter("@IntResult", SqlDbType.Int);
        param[6].Direction = ParameterDirection.Output;
        int count = objDUT.ExecuteSqlSP(param, "[Usp_RegistrationFeeCheque]");
        return count;
    }
}