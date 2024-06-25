using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HO_cheque_payment : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    DataUtility Objdut = new DataUtility();
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
        DataTable dt = new DataTable();
        dt = Objdut.GetDataTable("select Brid,BrName from Branch_master where BrActive=1 and isDeleted=0 and isActive=1");
        if (dt.Rows.Count > 0)
        {
            ddlbranch.DataSource = dt;
            ddlbranch.DataValueField = "Brid";
            ddlbranch.DataTextField = "BrName";
            ddlbranch.DataBind();
        }
        ddlbranch.Items.Insert(0, new ListItem("--Select Branch--", "0"));
    }
    public class Chequelist
    {
        public string SCDID { get; set; }
        public string Name { get; set; }
        public string Classname { get; set; }
        public string ChequeAmount { get; set; }
        public string Chequeno { get; set; }
        public string ChequeDate { get; set; }
        public string ChequeClearDate { get; set; }
        public string BankName { get; set; }
        public string ChequeStatus { get; set; }
        public string pagecount { get; set; }
    }
    [WebMethod]
    public static Chequelist[] ChequeDetail(string pagesize, string pageno, string checkno, string fromdate, string todate, string fyid, string txtbankname, string classid,string brid)
    {
        List<Chequelist> Details = new List<Chequelist>();
        DataSet Ds = new DataSet();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[8];
        param[0] = new SqlParameter("@pagesize", pagesize);
        param[1] = new SqlParameter("@brid", brid);
        param[2] = new SqlParameter("@fyid", fyid);
        param[3] = new SqlParameter("@pageno", pageno);
        param[4] = new SqlParameter("@checkno", checkno);
        param[5] = new SqlParameter("@fromdate", fromdate);
        param[6] = new SqlParameter("@todate", todate);
        param[7] = new SqlParameter("@bankname", txtbankname);
        Ds = Objdut.GetDataSetSP(param, "Usp_BindChequeList");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtRow in Ds.Tables[0].Rows)
            {
                Chequelist obj = new Chequelist();
                obj.SCDID = dtRow["SCDID"].ToString();
                obj.Name = dtRow["Name"].ToString();
                obj.Classname = dtRow["Classname"].ToString();
                obj.ChequeAmount = dtRow["ChequeAmount"].ToString();
                obj.Chequeno = dtRow["Chequeno"].ToString();
                obj.ChequeDate = dtRow["ChequeDate"].ToString();
                obj.ChequeClearDate = dtRow["ChequeClearDate"].ToString();
                obj.BankName = dtRow["BankName"].ToString();
                obj.ChequeStatus = dtRow["ChequeStatus"].ToString();
                obj.pagecount = Ds.Tables[1].Rows[0]["pages"].ToString();
                Details.Add(obj);
            }
        }
        return Details.ToArray();
    }
}