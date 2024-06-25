using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class branchpanel_employee_monthly_sallery_report : System.Web.UI.Page
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
            Insert_Into_Temp_and_Bind();
            FillAllDDL();
        }
    }
    protected void Insert_Into_Temp_and_Bind()
    {
        SqlParameter[] param = new SqlParameter[7];

        param[0] = new SqlParameter("@payid", payid);

        param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));

        param[2] = new SqlParameter("@fyid", fyid);

        param[3] = new SqlParameter("@eid", Convert.ToInt32(0));

        param[4] = new SqlParameter("@effectivedays", 0);

        param[5] = new SqlParameter("@isclosed", 0);

        param[6] = new SqlParameter("@issavechange", 0);

        Dt = objdut.GetDataTableSP(param, "[usp_monthly_calculatesallery]");

        if (Dt.Rows.Count > 0)
        {
            grdformonthlysalaryreport.DataSource = Dt;
            grdformonthlysalaryreport.DataBind();
            lblmonthlysalarytotal.Text = Convert.ToString(Dt.Rows[0]["total_monthly_salary"]);
            lblsyscalculatedsalarytotal.Text = Convert.ToString(Dt.Rows[0]["total_calculatedsalary_salary"]);
            lbltotalrecalculatedsalary.Text = Convert.ToString(Dt.Rows[0]["total_modifiedsalary_salary"]);
            lbltotaldeduction.Text = Convert.ToString(Dt.Rows[0]["total_tax_deduction"]);
        }
        else
        {
            grdformonthlysalaryreport.EmptyDataText = "No monthly salary report found.";
            grdformonthlysalaryreport.DataBind();
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

        ddlstatus.DataSource = CommonClass.ABC("Ddltempstatus");
        ddlstatus.DataTextField = "StatusName";
        ddlstatus.DataValueField = "tbl_tempdatastatusid";
        ddlstatus.DataBind();
        ddlstatus.Items.Insert(0, new ListItem("---Select Status---", "0"));
    }
    public class Employee
    {
        public string EmpCode{ get; set; }
        public string EmpName{ get; set; }
        public string DOB{ get; set; }
        public string Email{ get; set; }
        public string BankName{ get; set; }
        public string BankACNo{ get; set; }
        public string Designation { get; set; }
        public string PanNo { get; set; }
    }
    [WebMethod]
    public static getmonths[] BindGridByJs(string fyid, string payid, string empid, string emprefno, string empname, string departmrnt, string designation, string status)
    {
        DataSet ds = new DataSet();
        List<getmonths> details = new List<getmonths>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_monthly_salary_report]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[9];
                param[0] = new SqlParameter("@fyid", Convert.ToInt32(fyid));
                param[1] = new SqlParameter("@payid", Convert.ToInt32(payid));
                param[2] = new SqlParameter("@empid", Convert.ToInt32(empid));
                param[3] = new SqlParameter("@emprefno", emprefno);
                param[4] = new SqlParameter("@empname", empname);
                param[5] = new SqlParameter("@empcode", "");
                param[6] = new SqlParameter("@department", Convert.ToInt32(departmrnt));
                param[7] = new SqlParameter("@designation", Convert.ToInt32(designation));
                param[8] = new SqlParameter("@status", Convert.ToInt32(status));
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
                        user.monthly_salary = dtrow["monthly_salary"].ToString();
                        user.calculated_salary = dtrow["calculated_salary"].ToString();
                        user.modified_salary = dtrow["modified_salary"].ToString();
                        user.deduction = dtrow["deduction"].ToString();
                        user.payid = dtrow["payid"].ToString();
                        user.empid = dtrow["empid"].ToString();
                        user.paid_status_name = dtrow["paid_status_name"].ToString();
                        user.locked_status_id = dtrow["locked_status_id"].ToString();
                        user.paid_status_id = dtrow["paid_status_id"].ToString();
                        user.total_monthly_salary = dtrow["total_monthly_salary"].ToString();
                        user.total_calculatedsalary_salary = dtrow["total_calculatedsalary_salary"].ToString();
                        user.total_modifiedsalary_salary = dtrow["total_modifiedsalary_salary"].ToString();
                        user.total_tax_deduction = dtrow["total_tax_deduction"].ToString();
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

        public string monthly_salary { get; set; }

        public string calculated_salary { get; set; }

        public string modified_salary { get; set; }

        public string deduction { get; set; }

        public string payid { get; set; }

        public string empid { get; set; }

        public string paid_status_name { get; set; }

        public string locked_status_id { get; set; }

        public string paid_status_id { get; set; }

        public string total_monthly_salary { get; set; }

        public string total_calculatedsalary_salary { get; set; }

        public string total_modifiedsalary_salary { get; set; }

        public string total_tax_deduction { get; set; }
    }

    [WebMethod]
    public static desigdetail[] binddesignation(string did)
    {
        List<desigdetail> details = new List<desigdetail>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select desid,desname from tbl_ddmaster where did=" + Convert.ToInt32(did) + "  and status=1", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                desigdetail subjectdetails0 = new desigdetail();
                subjectdetails0.desigid = Convert.ToInt32("0");
                subjectdetails0.designame = "---Select Designation---";
                details.Add(subjectdetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    desigdetail dsdetails = new desigdetail();
                    dsdetails.desigid = Convert.ToInt32(dtrow["desid"].ToString());
                    dsdetails.designame = dtrow["desname"].ToString();
                    details.Add(dsdetails);
                }
            }
        }
        return details.ToArray();
    }

    public class desigdetail
    {
        public int desigid { get; set; }

        public string designame { get; set; }
    }
}