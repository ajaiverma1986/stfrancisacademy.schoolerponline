using System;
using System.Data;

public partial class BranchPanel_FeeDuration : System.Web.UI.Page
{
    private string url, fromDate, toDate, query1, query2, month;
    private DataUtility objdut = new DataUtility();
    private Utility objut = new Utility();
    private DataTable dt, dt1;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!IsPostBack)
        {
            tblMain.Visible = false;
        }
    }

    protected void txtDate_TextChanged(object sender, EventArgs e)
    {
        if (txtDate.Text.Trim() != "")
        {
            tblMain.Visible = false;
            fromDate = Convert.ToDateTime(txtDate.Text.Trim()).ToString("yyyy-MM-dd");
            ViewState["fromdate"] = 1;
            ViewState["datevalue"] = fromDate;
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select date first.");
            txtDate.Focus();
            return;
        }
    }

    protected void txtToDate_TextChanged(object sender, EventArgs e)
    {
        tblMain.Visible = false;
        if (txtToDate.Text.Trim() != "")
        {
            toDate = Convert.ToDateTime(txtToDate.Text).ToString("yyyy-MM-dd");
            month = toDate.Substring(5, 2);
            if (Convert.ToInt32(ViewState["fromdate"]) == 1)
            {
                query1 = @"select isnull(SUM(credit),0) as TotalPayable,isnull(SUM(debit),0) as TotalPaid,isnull(SUM(credit)-SUM(debit),0) as Due from student_Account where brid=" + Convert.ToInt32(Session["BrBrid"]) + " and transdate>='" + ViewState["datevalue"].ToString() + " 00:00:00:000' and transdate<='" + toDate + " 23:59:59:999'";
                dt = objdut.GetDataTable(query1);
                if (dt.Rows.Count > 0)
                {
                    tblMain.Visible = true;
                    ViewState["fromdate"] = null;
                    lblDatePay.Text = "Rs " + string.Format("{0:f}", dt.Rows[0]["TotalPayable"]);
                    lblPaidAmount.Text = "Rs " + string.Format("{0:f}", dt.Rows[0]["TotalPaid"]);
                    lbTotalDue.Text = "Rs " + string.Format("{0:f}", dt.Rows[0]["Due"]);
                }
            }
            else
            {
                query2 = @"select isnull(SUM(credit),0) as TotalPayable,isnull(SUM(debit),0) as TotalPaid,isnull(SUM(credit)-SUM(debit),0) as Due from student_Account where brid=" + Convert.ToInt32(Session["BrBrid"]) + " and transdate>='" + toDate + " 00:00:00:000' and transdate<='" + toDate + " 23:59:59:999' and paymonth<='" + month + "'";
                dt = objdut.GetDataTable(query2);
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["TotalPayable"].ToString() == "0.0000")
                    {
                        Utility.ViewAlertMessage(Page, "No records found for this date.!");
                        txtToDate.Text = "";
                        txtToDate.Focus();
                        return;
                    }
                    if (dt.Rows[0]["TotalPaid"].ToString() == "0.0000")
                    {
                        Utility.ViewAlertMessage(Page, "No records found for this date.!");
                        txtToDate.Text = "";
                        txtToDate.Focus();
                        return;
                    }
                    if (dt.Rows[0]["Due"].ToString() == "0.0000")
                    {
                        Utility.ViewAlertMessage(Page, "No records found for this date.!");
                        txtToDate.Text = "";
                        txtToDate.Focus();
                        return;
                    }
                    tblMain.Visible = true;
                    lblDatePay.Text = "Rs " + string.Format("{0:f}", dt.Rows[0]["TotalPayable"]);
                    lblPaidAmount.Text = "Rs " + string.Format("{0:f}", dt.Rows[0]["TotalPaid"]);
                    lbTotalDue.Text = "Rs " + string.Format("{0:f}", dt.Rows[0]["Due"]);
                }
                else
                {
                    Utility.ViewAlertMessage(Page, "No records found for this date.!");
                    txtToDate.Text = "";
                    txtToDate.Focus();
                    return;
                }
            }
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select date first.");
            txtToDate.Focus();
            return;
        }
    }

    protected void btnTotalBack_Click(object sender, EventArgs e)
    {
        tblMain.Visible = false;
        txtDate.Text = "";
        txtToDate.Text = "";
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        Response.Redirect("Recentfee.aspx");
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
        Response.Redirect("MonthWiseFee.aspx");
    }

    protected void btn3_Click(object sender, EventArgs e)
    {
        Response.Redirect("ClassFee.aspx");
    }

    protected void btn4_Click(object sender, EventArgs e)
    {
        Response.Redirect("FeeDuration.aspx");
    }

    protected void btn5_Click(object sender, EventArgs e)
    {
        Response.Redirect("getDistID.aspx?type=FSR");
    }
}