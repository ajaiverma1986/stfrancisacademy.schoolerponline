using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Expence_Management_expense_list : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    private DataUtility objdut = new DataUtility();
    private DataTable Dt;
    private static int fyid = 2;
    private static int payid = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        fyid = CommonClass.GetActiveAcedmicYear();
        payid = Convert.ToInt32(objdut.GetScalar("select payid,mn.MonthName from tbl_MonthlySalaryMaster tms inner join Month_name mn on tms.monthid=mn.MonthId where fyid=" + fyid + "and tms.status=1"));
        if (!IsPostBack)
        {
            string x = Request.QueryString["Exid"];
            FillAllDDL();
            BindGrid();
        }
    }
    protected void FillAllDDL()
    {
        string Query = "select titleid,titlename from tbl_expencemaster where status=1 and titlename<>'salary' and brid=" + Convert.ToString(Session["BrBrid"]) + "";
        Dt = objdut.GetDataTable(Query);
        ddlcategory.DataSource = Dt;
        ddlcategory.DataTextField = "titlename";
        ddlcategory.DataValueField = "titleid";
        ddlcategory.DataBind();
        ddlcategory.Items.Insert(0, new ListItem("---Select Category---", "0"));
        Dt.Dispose();
    }
    protected void BindGrid()
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@Brid", Session["BrBrid"]);
        Dt = objdut.GetDataTableSP(param, "[usp_expenselist]");
        if (Dt.Rows.Count > 0)
        {
            grdformonthlysalaryreport.DataSource = Dt;
            lbltotal.Text = "" + (from row in Dt.AsEnumerable() select row.Field<Decimal>("Expense")).Sum().ToString();
            lbltax.Text = " " + (from row in Dt.AsEnumerable() select row.Field<Decimal>("vat_servicetax")).Sum().ToString();
            lblamounaftertax.Text = "" + (from row in Dt.AsEnumerable() select row.Field<Decimal>("Expensewithtax")).Sum().ToString();
            grdformonthlysalaryreport.DataBind();
            DataUtility Objdut = new DataUtility();
            forurl.Value = Convert.ToString(objdut.GetScalar("Select Url From tbl_institutemaster"));

        }
        else
        {
            div2.Visible = false;
            DataTable NoRecord = new DataTable();
            NoRecord.Columns.Add("RowNumber");
            NoRecord.Columns.Add("ExpenseDate");
            NoRecord.Columns.Add("fullTitlename");
            NoRecord.Columns.Add("Titlename");
            NoRecord.Columns.Add("fullDescription");
            NoRecord.Columns.Add("Description");
            NoRecord.Columns.Add("CategoryDescription");
            NoRecord.Columns.Add("Expense");
            NoRecord.Columns.Add("vat_servicetax");
            NoRecord.Columns.Add("Expensewithtax");
            NoRecord.Columns.Add("Exid");
            NoRecord.Columns.Add("expence_file");
            NoRecord.Rows.Add();
            grdformonthlysalaryreport.DataSource = NoRecord;
            grdformonthlysalaryreport.DataBind();
            trnorecordfound.Style.Add("display", "block");
            divgridforsalary.Style.Add("display", "none");
            lbltotal.Style.Add("display", "none");
        }
    }
    [WebMethod]
    public static getmonths[] BindGridByJs(string payid, string fyid, string fromdate, string todate, string titleid)
    {
        DataSet ds = new DataSet();
        List<getmonths> details = new List<getmonths>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_expenselist]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[6];
                param[0] = new SqlParameter("@payid", Convert.ToInt32(payid));
                param[1] = new SqlParameter("@expenseFromDate", fromdate);
                param[2] = new SqlParameter("@expenseToDate", todate);
                param[3] = new SqlParameter("@TitleId", Convert.ToInt32(titleid));
                param[4] = new SqlParameter("@mode", 2);
                param[5] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dtrow in ds.Tables[0].Rows)
                        {
                            getmonths user = new getmonths();
                            user.RowNumber = dtrow["RowNumber"].ToString();
                            user.ExpenseDate = dtrow["ExpenseDate"].ToString();
                            user.Titlename = dtrow["Titlename"].ToString();
                            user.fullTitlename = dtrow["fullTitlename"].ToString();
                            user.Description = dtrow["Description"].ToString();
                            user.fullDescription = dtrow["fullDescription"].ToString();
                            user.CategoryDescription = dtrow["CategoryDescription"].ToString();
                            user.Expense = dtrow["Expense"].ToString();
                            user.vat_servicetax = dtrow["vat_servicetax"].ToString();
                            user.Expensewithtax = dtrow["Expensewithtax"].ToString();
                            user.expence_file = dtrow["expence_file"].ToString();
                            user.Exid = dtrow["Exid"].ToString();
                            details.Add(user);
                        }
                    }
                }
            }
        }
        return details.ToArray();
    }
    public class getmonths
    {
        public string RowNumber { get; set; }
        public string ExpenseDate { get; set; }
        public string Titlename { get; set; }
        public string Description { get; set; }
        public string CategoryDescription { get; set; }
        public string Expense { get; set; }
        public string vat_servicetax { get; set; }
        public string Expensewithtax { get; set; }
        public string expence_file { get; set; }
        public string Exid { get; set; }
        public string fullTitlename { get; set; }
        public string fullDescription { get; set; }
    }
    protected void grdformonthlysalaryreport_RowCommand(object sender, GridViewCommandEventArgs e)
    {
    }
    protected void btndownloadreport_Click1(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        try
        {
            ImageButton lnkbtn = sender as ImageButton;
            GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
            Label lbl = (Label)grdformonthlysalaryreport.Rows[gvrow.RowIndex].FindControl("lbltopic");
            if (lbl.Text != "")
            {
                string filepath = lbl.Text;
                filepath = "/BranchPanel/Expence Management/ExpenceDocument/ " + filepath;
                Response.ContentType = ContentType;
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filepath));
                Response.TransmitFile(filepath);
                Response.End();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "There is no attachment to be download.");
            }
        }
        catch (Exception ex)
        {
        }
    }
}