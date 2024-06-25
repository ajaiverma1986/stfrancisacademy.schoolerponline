using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class branchpanel_employee_employee_deduction_report : System.Web.UI.Page
{
    private CommonClass commonOBJ = new CommonClass();
    private DataUtility objdut = new DataUtility();
    private DataTable Dt;
    private static int fyid = 2;
    private static int payid = 1;

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
        param[1] = new SqlParameter("@payid", payid);

        Dt = objdut.GetDataTableSP(param, "[usp_monthly_tax_report]");

        if (Dt.Rows.Count > 0)
        {
            gridmonthlytaxreport.DataSource = Dt;
            gridmonthlytaxreport.DataBind();
            lblemptds.Text = Dt.Rows[0]["total_employee_tds"].ToString();
            lblemployertds.Text = Dt.Rows[0]["total_employer_tds"].ToString();
            lblempesi.Text = Dt.Rows[0]["total_employee_esi"].ToString();
            lblemployeresi.Text = Dt.Rows[0]["total_employer_esi"].ToString();
            lblemppf.Text = Dt.Rows[0]["total_employee_pf"].ToString();
            lblemployerpf.Text = Dt.Rows[0]["total_employer_pf"].ToString();
            lblemployeededuction.Text = Dt.Rows[0]["total_employee_tax_deduction_all"].ToString();
            lblemployerdeduction.Text = Dt.Rows[0]["total_employer_tax_deduction_all"].ToString();
        }
        else
        {
            gridmonthlytaxreport.EmptyDataText = "No monthly tax report found.";
            gridmonthlytaxreport.DataBind();
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
        ddlpayid.SelectedValue = payid.ToString();

        ddldept.DataSource = CommonClass.ABC("DdlDepartment");
        ddldept.DataTextField = "deptName";
        ddldept.DataValueField = "deptid";
        ddldept.DataBind();
        ddldept.Items.Insert(0, new ListItem("---Select Department---", "0"));

        ddldesignation.DataSource = CommonClass.ABC("DdlDesignation");
        ddldesignation.DataTextField = "desigName";
        ddldesignation.DataValueField = "desigID";
        ddldesignation.DataBind();
        ddldesignation.Items.Insert(0, new ListItem("---Select Designation---", "0"));
    }

    [WebMethod]
    public static getmonths[] BindGridByJs(string fyid, string payid, string empid, string emprefno, string empname, string departmrnt, string designation, string status)
    {
        DataSet ds = new DataSet();
        List<getmonths> details = new List<getmonths>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_monthly_tax_report]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[9];
                param[0] = new SqlParameter("@fyid", Convert.ToInt32(fyid));
                param[1] = new SqlParameter("@payid", Convert.ToInt32(payid));
                param[2] = new SqlParameter("@empid", Convert.ToInt32(0));
                param[3] = new SqlParameter("@emprefno", emprefno);
                param[4] = new SqlParameter("@empname", empname);
                param[5] = new SqlParameter("@empcode", "");
                param[6] = new SqlParameter("@department", Convert.ToInt32(departmrnt));
                param[7] = new SqlParameter("@designation", Convert.ToInt32(designation));
                param[8] = new SqlParameter("@status", Convert.ToInt32(0));
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);
                cmd.Parameters.Add(param[6]);
                cmd.Parameters.Add(param[7]);
                cmd.Parameters.Add(param[8]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getmonths user = new getmonths();
                        user.RowNumber = dtrow["RowNumber"].ToString();
                        user.ref_no = dtrow["ref_no"].ToString();
                        user.name = dtrow["name"].ToString();
                        user.employee_tds = dtrow["employee_tds"].ToString();
                        user.employer_tds = dtrow["employer_tds"].ToString();
                        user.employee_esi = dtrow["employee_esi"].ToString();
                        user.employer_esi = dtrow["employer_esi"].ToString();
                        user.employe_pf = dtrow["employe_pf"].ToString();
                        user.employer_pf = dtrow["employer_pf"].ToString();
                        user.total_employee_tax_deduction_employeewise = dtrow["total_employee_tax_deduction_employeewise"].ToString();
                        user.total_employer_tax_deduction_employeewise = dtrow["total_employer_tax_deduction_employeewise"].ToString();
                        user.total_employee_tds = dtrow["total_employee_tds"].ToString();
                        user.total_employer_tds = dtrow["total_employer_tds"].ToString();
                        user.total_employee_esi = dtrow["total_employee_esi"].ToString();
                        user.total_employer_esi = dtrow["total_employer_esi"].ToString();
                        user.total_employee_pf = dtrow["employer_pf"].ToString();
                        user.total_employer_pf = dtrow["total_employee_esi"].ToString();
                        user.total_employee_tax_deduction_all = dtrow["total_employer_esi"].ToString();
                        user.total_employer_tax_deduction_all = dtrow["employer_pf"].ToString();
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

        public string ref_no { get; set; }

        public string name { get; set; }

        public string employee_tds { get; set; }

        public string employer_tds { get; set; }

        public string employee_esi { get; set; }

        public string employer_esi { get; set; }

        public string employe_pf { get; set; }

        public string employer_pf { get; set; }

        public string total_employee_tax_deduction_employeewise { get; set; }

        public string total_employer_tax_deduction_employeewise { get; set; }

        public string total_employee_tds { get; set; }

        public string total_employer_tds { get; set; }

        public string total_employee_esi { get; set; }

        public string total_employer_esi { get; set; }

        public string total_employee_pf { get; set; }

        public string total_employer_pf { get; set; }

        public string total_employee_tax_deduction_all { get; set; }

        public string total_employer_tax_deduction_all { get; set; }
    }
}