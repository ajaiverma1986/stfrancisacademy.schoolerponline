using DocumentFormat.OpenXml.Drawing.Charts;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_employee_PaySlipReport : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    System.Data.DataTable dt = new System.Data.DataTable();
    int empid = 0;
    int fyid = 0;
    int payid = 0;
    int MontID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        getrecieptgenraldetails();
        if (Request.QueryString["EID"] != null)
        {
            empid = Convert.ToInt32(Request.QueryString["EID"]);
            payid = Convert.ToInt32(Request.QueryString["payid"]);
            GetFinancialYear();
            GetEmp();
            BindGrid();
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "message", "javascript:window.print()", true);
    }
    public void GetFinancialYear()
    {
        fyid = (int)(objdut.GetScalar("Select ISNULL(fyid,0) from financial_Year where IsActive=1"));
    }
    private void getrecieptgenraldetails()
    {
        string value = "";
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 10);
        value = objdut.GetScalerSP(param, "[usp_general_master_setting]").ToString();
        string[] getdata = value.Split('~');
        string isbranch = getdata[0];
        string address = "", serviceno = "", Ph = "", mobile = "", Contact = "", EmailID = "", tin = "", SchoolAffi = "", Website = "";
        string branchdata = Convert.ToString(objdut.GetScalar(@"select BrAddress+'^'+City+', '+state+', '+Country+', '+pincode+'^'+
            LandLineNo+','+MobileNo+'^'+Emailid+'^'+isnull(Website,'')+'^'+isnull(SchoolAffi,'')+'^'+isnull(BrName,'')+'^'+isnull(photo,'') from branch_master where brid = " + Session["brbrid"] + ""));
        if (branchdata != "")
        {
            string[] getbranchdata = branchdata.Split('^');
            address = getbranchdata[0];
            Add.InnerText = getbranchdata[1];

            string[] getCont;
            Contact = getbranchdata[2];
            getCont = Contact.Split(',');
            Ph = getCont[0].ToString();
            mobile = getCont[1].ToString();
            EmailID = getbranchdata[3].ToString();
            Website = getbranchdata[4].ToString();
            SchoolAffi = getbranchdata[5].ToString();
            CompanyName.InnerText = getbranchdata[6].ToString();

            Add.InnerText = address;


            SpFone.InnerText = Ph.ToString();
            SMobile.InnerText = mobile.ToString();
            SEmailID.InnerText = EmailID.ToString();
            //if (SchoolAffi != "")
            //{
            //    SchoolAffia.InnerText = SchoolAffi.Trim();
            //    affhead.InnerText = "Affiliation No:";

            //}
            //else
            //{
            //    affhead.InnerText = ".";
            //}
            SWebsite.InnerText = Website.Trim();
            if (getbranchdata[7].ToString() != "")
            {
                Image1.ImageUrl = "~/BranchPanel/images/" + getbranchdata[7].ToString();
            }
            else
            {
                Image1.ImageUrl = "~/BranchPanel/images/9update.png";
            }
        }
    }
    public void GetEmp()
    {
        CommonClass objCL = new CommonClass();
        DataSet ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            ds.Tables.Add(objCL.dtCommon(empid.ToString().Trim(), 3));
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dtrow in ds.Tables[0].Rows)
                {
                    Employee user = new Employee();
                    lblsalaryempid.Text = dtrow["refNo"].ToString();
                    lblsalaryname.Text = dtrow["fname"].ToString() + " " + dtrow["mName"].ToString() + " " + dtrow["lname"].ToString();
                    lblsalarydoj.Text = Convert.ToDateTime(dtrow["doJ"]).ToString("dd MMM yyyy");
                    lblSalaryBankName.Text = dtrow["bankName"].ToString();
                    lblsalarybankaccno.Text = dtrow["accountNo"].ToString();
                    lblsalarydesignation.Text = dtrow["designation"].ToString();
                    lblsalaryemppanno.Text = dtrow["panNo"].ToString();
                }
            }
        }
    }
    protected void BindGrid()
    {        
        SqlParameter[] param = new SqlParameter[5];

        param[0] = new SqlParameter("@payid", Convert.ToInt32(payid));

        param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));

        param[2] = new SqlParameter("@fyid", fyid);

        param[3] = new SqlParameter("@empid", Convert.ToInt32(empid));

        param[4] = new SqlParameter("@effectivedays", Convert.ToDecimal(0));

        dt = objdut.GetDataTableSP(param, "[usp_calculatesallery]");

        if (dt.Rows.Count > 0)
        {
            NumberToEnglish ObNumToEng = new NumberToEnglish();
            lblHalfDays.Text = dt.Rows[0]["totalHalfDay"].ToString();
            mont.InnerText = dt.Rows[0]["MonthName"].ToString().ToUpper();
            lblsalarypaidday.Text = dt.Rows[0]["workingdayofemployees"].ToString();
            lblsalaryWorkingpaidday.Text = dt.Rows[0]["workingdayofoffice"].ToString();
            lblsalaryleavetaken.Text = dt.Rows[0]["totalunpaidleave"].ToString();
            lblsalarybasicactual.Text = dt.Rows[0]["MonthlySalary"].ToString();            
            double NetAmt = 0;
            NetAmt = Convert.ToDouble(dt.Rows[0]["calculatedsalary"]) - Convert.ToDouble(dt.Rows[0]["employee_advn_amount"]);
            lblNetPaySalary.Text = NetAmt.ToString();
            lblNetPaySalaryAlp.Text = ObNumToEng.changeNumericToWords(NetAmt).ToString();
            lblsalarybasicearned.Text = dt.Rows[0]["employee_pf_amount"].ToString();
            lblsalaryESIaearned.Text = dt.Rows[0]["employee_esi_amount"].ToString();
            lblsalarytdsearned.Text = dt.Rows[0]["employee_tds_amount"].ToString();
            lblsalaryAdvnearned.Text = dt.Rows[0]["employee_advn_amount"].ToString();
            //gridmain.DataSource = dt;
            //gridmain.DataBind();
        }

        //if (status == "r" || status == "p")
        //{
        //    tablemaingrid.Style.Add("display", "none");
        //}
        //else
        //{
        //    tablemaingrid.Style.Add("display", "block");
        //}
    }
}