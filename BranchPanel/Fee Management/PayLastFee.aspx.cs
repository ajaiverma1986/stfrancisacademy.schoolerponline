using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Fee_Management_PayLastFee : System.Web.UI.Page
{
    int IdStudent = 0;
    private DataUtility Objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindSessionDDL();
            BindClass();
            BindBalFee();
        }
    }
    public void BindBalFee()
    {
        string ActualAmt = Objdut.GetScalar("Select ISNULL(Sum(FeeAmount),0) AS FeeAmount from tbl_LastYearFee where RID=" + Request.QueryString["RID"] + " and Fyid=" + Request.QueryString["FYID"] + "").ToString();
        string PaidAmt = Objdut.GetScalar("Select ISNULL(Sum(FeeAmount),0) AS FeeAmount from LastYearPayDT where RID=" + Request.QueryString["RID"] + " and Fyid=" + Request.QueryString["FYID"] + "").ToString();
        txtAmount.Text = (Convert.ToDecimal(ActualAmt) - Convert.ToDecimal(PaidAmt)).ToString();
    }
    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlregistrationsession.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlregistrationsession.DataValueField = "Fyid";
        ddlregistrationsession.DataTextField = "FYName";
        ddlregistrationsession.DataBind();
        ddlregistrationsession.Items.Insert(0, new ListItem("--Select Session--", "0"));
        //int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        //ddlregistrationsession.SelectedValue = Convert.ToString(ActiveFinancialyear);
    } 
    public void BindClass()
    {
        DataTable Dt = new DataTable();
        CommonClass CommonClass = new CommonClass();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ActiveFinancialyear), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        if (Dt.Rows.Count > 0)
        {
            //ddlapplyingforclass.DataSource = Dt;
            //ddlapplyingforclass.DataTextField = "Classname";
            //ddlapplyingforclass.DataValueField = "classid";
            //ddlapplyingforclass.DataBind();
            //ListItem li = new ListItem("--Select Class--", "0");
            //ddlapplyingforclass.Items.Insert(0, li);
        }
    }
    protected void btnforupdateorsave_Click(object sender, EventArgs e)
    {

        SqlParameter[] Param = new SqlParameter[9];
        Param[00] = new SqlParameter("@Brid", Convert.ToInt32(Session["BrBrid"]));
        Param[01] = new SqlParameter("@Fyid", ddlregistrationsession.SelectedValue);
        Param[02] = new SqlParameter("@RID", fdRid.Value);
        Param[03] = new SqlParameter("@Registration_No", txtRegNo.Text.Trim());
        Param[04] = new SqlParameter("@AdmissionNo", txtAdmNo.Text.Trim());
        Param[05] = new SqlParameter("@FeeAmount", txtPaidAmt.Text.Trim());
        Param[06] = new SqlParameter("@RegistrationDate", txtPayDate.Text.Trim());
        Param[07] = new SqlParameter("@Mode", Convert.ToInt32(6));
        Param[08] = new SqlParameter("@intresult", Convert.ToInt32("0"));
        Param[08].Direction = ParameterDirection.Output;

        int intresult = Objdut.ExecuteSqlSP(Param, "[usp_StudentLastYearFee]");
        if (intresult == 1)
        {
            int ID = (int)(Objdut.GetScalar("Select ISNULL(PayAmtID,0) from LastYearPayDT where RID=" + fdRid.Value + " and AdmissionNo='" + txtAdmNo.Text.Trim() + "' and Fyid=" + ddlregistrationsession.SelectedValue + " order by PayAmtID desc"));            
            Response.Write("<script type='text/javascript'>window.open('LYFeeReceipt.aspx?enrollid=" + ID + "','_blank');</script>");            
        }
        else
        {
            Utility.ViewAlertMessage(this, "Sorry Error duaring Payment ! Try again");
        }
        Emptly();
    }
    public void Emptly()
    {
        fdRid.Value = "0";
        txtPaidAmt.Text = "0";
        txtAmount.Text = "0";
        ddlregistrationsession.SelectedValue = "0";
        txtPayDate.Text = "";
        txtRegNo.Text = "";
        txtAdmNo.Text = "";
        txtstudentfirstname.Text = "";
        txtstudentMiddlename.Text = "";
        txtstudentlastname.Text = "";
        //Response.Redirect("AddLastYearFee.aspx");
    }
}