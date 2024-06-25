using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class branchpanel_employee_tax_deduction_report : System.Web.UI.Page
{
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
        Dt = objdut.GetDataTableSP(param, "[usp_salary_duduction_report]");

        if (Dt.Rows.Count > 0)
        {
            gridsalarydeductionreport.DataSource = Dt;
            gridsalarydeductionreport.DataBind();
            lbltotalmonthlysalary.Text = Dt.Rows[0]["totalmonthlysalary"].ToString();
            lbltotalrecalculatedsalary.Text = Dt.Rows[0]["totalpaidsalary"].ToString();
            lbltotaldeduction.Text = Dt.Rows[0]["totaldeductsalary"].ToString();
        }
        else
        {
            gridsalarydeductionreport.EmptyDataText = "No salary deduction report found.";
            gridsalarydeductionreport.DataBind();
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
            using (SqlCommand cmd = new SqlCommand("[usp_salary_duduction_report]", con))
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
                        user.refno = dtrow["refno"].ToString();
                        user.empname = dtrow["name"].ToString();
                        user.monthlysalary = dtrow["monthlysalary"].ToString();
                        user.paidsalary = dtrow["paidsalary"].ToString();
                        user.lbldedudtion = dtrow["deductamount"].ToString();
                        user.totalmonthlysalary = dtrow["totalmonthlysalary"].ToString();
                        user.totalpaidsalary = dtrow["totalpaidsalary"].ToString();
                        user.totaldeductsalary = dtrow["totaldeductsalary"].ToString();
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

        public string refno { get; set; }

        public string empname { get; set; }

        public string monthlysalary { get; set; }

        public string paidsalary { get; set; }

        public string lbldedudtion { get; set; }

        public string totalmonthlysalary { get; set; }

        public string totalpaidsalary { get; set; }

        public string totaldeductsalary { get; set; }
    }
}