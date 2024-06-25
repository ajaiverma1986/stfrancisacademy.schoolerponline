using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Expence_Management_expense_manager : System.Web.UI.Page
{
    private string pname = "", Exid;
    private int count = 0;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private DataTable Dt;
    protected void Page_Load(object sender, EventArgs e)
    {

        Exid = Request.QueryString["Exid"];
        if (!IsPostBack)
        {

            fillddl();
            Exid = Request.QueryString["Exid"];
            if (Exid != null)
            {
                btnclear.Visible = true;
                buttonclear.Visible = false;
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@mode", 1);
                param[1] = new SqlParameter("@Exid", Exid);
                param[2] = new SqlParameter("@Brid", Convert.ToString(Session["BrBrid"]));
                Dt = objdut.GetDataTableSP(param, "[usp_expenselist]");
                if (Dt.Rows.Count > 0)
                {
                    ddltitle.SelectedValue = Dt.Rows[0]["titleid"].ToString();
                    if (Dt.Rows[0]["titleid"].ToString() == "7")
                    {
                        divtitle.Style.Add("display", "block");
                        txtdetails.Text = Dt.Rows[0]["CategoryDescription"].ToString();
                    }
                    else
                    {
                        divtitle.Style.Add("display", "none");
                        txtdetails.Text = "";
                    }
                    txtAmount.Text = Dt.Rows[0]["Expense"].ToString();
                    txtToDate.Text = Dt.Rows[0]["ExpenseDate"].ToString();
                    txtdescription.Text = Dt.Rows[0]["Description"].ToString();
                    txtservicetax.Text = Dt.Rows[0]["vat_servicetax"].ToString();
                    txtincludingtax.Text = Dt.Rows[0]["Expensewithtax"].ToString();
                    lbltopic.Text = Dt.Rows[0]["expence_file"].ToString();
                    if (lbltopic.Text != "")
                    {
                        imguser.ImageUrl = "ExpenceDocument/" + Dt.Rows[0]["expence_file"].ToString();

                    }
                    else
                    {
                        imguser.Visible = false;
                    }
                    btnSubmit.Text = "Update";
                }
            }
        }
    }
    public void fillddl()
    {
        string query = "select titleid,titlename from tbl_expencemaster where status=1 and titlename<>'salary' and brid=" + Convert.ToString(Session["BrBrid"]) + "";
        Dt = objdut.GetDataTable(query);
        if (Dt.Rows.Count > 0)
        {
            ddltitle.DataSource = Dt;
            ddltitle.DataTextField = "titlename";
            ddltitle.DataValueField = "titleid";
            ddltitle.DataBind();
            ddltitle.Items.Insert(0, new ListItem("---Select Category---", "0"));
        }
    }
    public void reset()
    {
        txtToDate.Text = "";
        txtAmount.Text = "";
        txtdescription.Text = "";
        txtdetails.Text = "";
        ddltitle.SelectedIndex = 0;
        txtservicetax.Text = "";
        txtincludingtax.Text = "";

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string ExpenseDate = Request.Form[txtToDate.UniqueID];
        Session["ExpenseDate"] = ExpenseDate;
        pname = "USP_ExpenseManager";
        SqlParameter[] param = new SqlParameter[13];
        param[0] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));
        param[1] = new SqlParameter("@titlename", ddltitle.SelectedItem.Text);
        param[2] = new SqlParameter("@titleid", ddltitle.SelectedValue);
        param[3] = new SqlParameter("@categorydescription", txtdetails.Text.Trim());
        param[4] = new SqlParameter("@ExpenseDate", ExpenseDate);
        param[5] = new SqlParameter("@Expense", txtAmount.Text.Trim());
        param[6] = new SqlParameter("@Description", txtdescription.Text.Trim());
        param[7] = new SqlParameter("@intresult", Convert.ToInt32("0"));
        param[7].Direction = ParameterDirection.Output;
        param[8] = new SqlParameter("@vat_servicetax", txtservicetax.Text.Trim());
        if (txtservicetax.Text == "")
        {
            //param[10] = new SqlParameter("@Expensewithtax", Request.Form[txtAmount.UniqueID]);
            txtincludingtax.Text = txtAmount.Text.Trim();
            param[10] = new SqlParameter("@Expensewithtax", txtincludingtax.Text.Trim());
        }
        else if (txtservicetax.Text != "")
        {

            txtincludingtax.Text = Convert.ToString((Convert.ToDecimal(txtAmount.Text) + Convert.ToDecimal(txtservicetax.Text)));
            param[10] = new SqlParameter("@Expensewithtax", txtincludingtax.Text.Trim());
        }
        if (Exid != null && Exid != "")
        {
            param[11] = new SqlParameter("@mode", 1);
        }
        else
            param[11] = new SqlParameter("@mode", 2);
        param[12] = new SqlParameter("@Exid", Exid);
        if (fileuploadExcel.HasFile)
        {
            if (fileuploadExcel.PostedFile.ContentLength <= 5242880)
            {
                string fileexe = Path.GetExtension(fileuploadExcel.FileName);
                if (fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".gif")
                {
                    int iLen = fileuploadExcel.PostedFile.ContentLength;
                    byte[] b = new byte[iLen];
                    fileuploadExcel.PostedFile.InputStream.Read(b, 0, iLen);
                    string Extension = Path.GetExtension(fileuploadExcel.FileName);
                    string FileName = Path.GetFileName(fileuploadExcel.PostedFile.FileName);
                    string pathforsaveimage = Server.MapPath(("ExpenceDocument/" + FileName));
                    MasterImageUpload.CreateImage(b, FileName, Extension, pathforsaveimage);
                    param[9] = new SqlParameter("@expence_file", FileName);
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Only image files can be uploaded!!!");
                    fileuploadExcel.Focus();
                    return;
                }
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "File size greater than 5 mb!!!");
                fileuploadExcel.Focus();
                return;
            }
        }
        else
        {

            string FileName = Path.GetFileName(fileuploadExcel.PostedFile.FileName);
            param[9] = new SqlParameter("@expence_file", lbltopic.Text.Trim());
        }
        int result = objdut.ExecuteSqlSP(param, pname);
        if (result == 1)
        {
            reset();
            Utility.ViewAlertMessage(this.Master.Page, "Expense Added Successfully");
            Response.Redirect("expense_list.aspx");
        }
        if (result == 2)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Valid Date.");
            txtToDate.Text = "";
        }
        if (result == 3)
        {
            reset();
            Utility.ViewAlertMessage(this.Master.Page, "Expense updated Successfully");
            Response.Redirect("expense_list.aspx");
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Plz try again.");
        }
    }
    protected void btnclear_Click1(object sender, EventArgs e)
    {
        if (Exid != null && Exid != "")
        {
            Response.Redirect("expense_list.aspx");

        }
    }
}