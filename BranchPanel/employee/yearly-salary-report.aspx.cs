using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class branchpanel_employee_yearly_salary_report : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable Dt;
    public static int fyid = 2;
    public static int payid = 1;

    protected void Page_Load(object sender, EventArgs e)
    {
        fyid = CommonClass.Scaler("ActiveAcademicYear");
        payid = CommonClass.Scaler("getpayid", fyid);
        if (!IsPostBack)
        {
            BindGrid();
            FillAllDDL();
        }
    }

    protected void BindGrid()
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@fyid", fyid);
        param[1] = new SqlParameter("@monthid", 0);
        Dt = objdut.GetDataTableSP(param, "[usp_yearly_salary_report]");
        if (Dt.Rows.Count > 0)
        {
            gridyearlysalaryreport.DataSource = Dt;
            gridyearlysalaryreport.DataBind();
            lblnoofemployee.Text = Convert.ToString(Dt.Rows[0]["total_no_of_employee"]);
            lblmonthlysalarytotal.Text = Convert.ToString(Dt.Rows[0]["total_monthly_salary"]);
            lblsalarydeduction.Text = Convert.ToString(Dt.Rows[0]["total_salary_deduction"]);
            lbltaxdeduction.Text = Convert.ToString(Dt.Rows[0]["total_employee_tax_deduction"]);
            lblrecalculatedsalary.Text = Convert.ToString(Dt.Rows[0]["total_modified_salary"]);
            lblemployertax.Text = Convert.ToString(Dt.Rows[0]["total_employer_tax_deduction"]);
        }
        else
        {
            gridyearlysalaryreport.EmptyDataText = "No yearly salary report found.";
            gridyearlysalaryreport.DataBind();
        }
    }

    protected void FillAllDDL()
    {
        ddlfinancialyear.DataSource = CommonClass.ABC("DdlFinancialyear");
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataValueField = "FYID";
        ddlfinancialyear.DataBind();
        ddlfinancialyear.SelectedValue = fyid.ToString();

        ddlpayid.DataSource = CommonClass.ABC1("DdlMonth", fyid);
        ddlpayid.DataTextField = "Month_Name";
        ddlpayid.DataValueField = "payid";
        ddlpayid.DataBind();
        ddlpayid.Items.Insert(0, new ListItem("---Select Month---", "0"));
    }

    [WebMethod]
    public static getmonths[] BindGridByJs(string fyid, string payid)
    {
        DataSet ds = new DataSet();
        List<getmonths> details = new List<getmonths>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_yearly_salary_report]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@fyid", Convert.ToInt32(fyid));
                param[1] = new SqlParameter("@monthid", Convert.ToInt32(payid));
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getmonths user = new getmonths();
                        user.RowNumber = dtrow["RowNumber"].ToString();
                        user.month_name = dtrow["month_name"].ToString();
                        user.no_of_employee = dtrow["no_of_employee"].ToString();
                        user.monthlysalary = dtrow["monthlysalary"].ToString();
                        user.salary_deduction = dtrow["salary_deduction"].ToString();
                        user.employee_tax_deduction = dtrow["employee_tax_deduction"].ToString();
                        user.modifiedsalary = dtrow["modifiedsalary"].ToString();
                        user.employer_tax_deduction = dtrow["employer_tax_deduction"].ToString();
                        user.status = dtrow["status"].ToString();
                        user.total_no_of_employee = dtrow["total_no_of_employee"].ToString();
                        user.total_monthly_salary = dtrow["total_monthly_salary"].ToString();
                        user.total_salary_deduction = dtrow["total_salary_deduction"].ToString();
                        user.total_employee_tax_deduction = dtrow["total_employee_tax_deduction"].ToString();
                        user.total_modified_salary = dtrow["total_modified_salary"].ToString();
                        user.total_employer_tax_deduction = dtrow["total_employer_tax_deduction"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getmonths
    {
        public string RowNumber { get; set; }

        public string month_name { get; set; }

        public string no_of_employee { get; set; }

        public string monthlysalary { get; set; }

        public string salary_deduction { get; set; }

        public string employee_tax_deduction { get; set; }

        public string modifiedsalary { get; set; }

        public string employer_tax_deduction { get; set; }

        public string status { get; set; }

        public string total_no_of_employee { get; set; }

        public string total_monthly_salary { get; set; }

        public string total_salary_deduction { get; set; }

        public string total_employee_tax_deduction { get; set; }

        public string total_modified_salary { get; set; }

        public string total_employer_tax_deduction { get; set; }
    }
}