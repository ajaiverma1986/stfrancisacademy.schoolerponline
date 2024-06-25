using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Fee_Management_account_management : System.Web.UI.Page
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

    }
    [WebMethod]
    public static GetOverDueFeeDetails[] BindGridOfOverDueList(int Fyid, string pagesize, string pageno, string stuname, string duefromdate, string duetodate, string mobileno, string classid)
    {
        DataSet Ds = new DataSet();
        List<GetOverDueFeeDetails> Details = new List<GetOverDueFeeDetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[9];
        param[0] = new SqlParameter("@Fyid", Fyid);
        param[1] = new SqlParameter("@pagesize", pagesize);
        param[2] = new SqlParameter("@pageno", pageno);
        param[3] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        param[4] = new SqlParameter("@DueFromDate", duefromdate);
        param[5] = new SqlParameter("@DueToDate", duetodate);
        param[6] = new SqlParameter("@Mobileno", mobileno);
        param[7] = new SqlParameter("@Name", stuname);
        param[8] = new SqlParameter("@classid", classid);
        Ds = Objdut.GetDataSetSP(param, "[Usp_Total_BindOverDue]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow Dtrow in Ds.Tables[0].Rows)
            {
                GetOverDueFeeDetails user = new GetOverDueFeeDetails();
                user.Rownumber = Dtrow["Rownumber"].ToString();
                user.AdmissionNo = Dtrow["AdmissionNo"].ToString();
                user.Name = Dtrow["Name"].ToString();
                user.DueDate = DateTime.Now.ToString("1/MM/yyyy");
                user.PayableOrDueAmount = Dtrow["PayableOrDueAmount"].ToString();
                user.Mobile = Dtrow["Mobile"].ToString();
                user.Sturegno = Dtrow["Sturegno"].ToString();
                user.pagecount = Ds.Tables[1].Rows[0]["pages"].ToString();
                user.TotalStudent = Ds.Tables[2].Rows[0]["TotalStudent"].ToString();
                user.TotalOverDueFee = Ds.Tables[2].Rows[0]["TotalOverDueFee"].ToString();
                user.Tax = Dtrow["Tax"].ToString();
                user.TaxWithFee = Dtrow["TaxWithFee"].ToString();
                user.classes = Dtrow["Class"].ToString();
                //user.Asaid = Dtrow["Asaid"].ToString();
                user.Samid = Dtrow["Samid"].ToString();
                Details.Add(user);
            }
        }
        return Details.ToArray();
    }

    public class GetOverDueFeeDetails
    {
        public string Rownumber { get; set; }
        public string AdmissionNo { get; set; }
        public string Name { get; set; }
        public string DueDate { get; set; }
        public string PayableOrDueAmount { get; set; }
        public string Mobile { get; set; }
        public string Sturegno { get; set; }
        public string pagecount { get; set; }
        public string TotalStudent { get; set; }
        public string TotalOverDueFee { get; set; }
        public string Tax { get; set; }
        public string TaxWithFee { get; set; }
        public string classes { get; set; }
        public string Asaid { get; set; }
        public string Samid { get; set; }
    }
}