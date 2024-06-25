using System;
using System.Data;
using System.Data.SqlClient;

public partial class BranchPanel_PayFee : System.Web.UI.Page
{
    private string PageName, url, query, query2;
    private int branchID, brID, adid;
    private decimal amount;
    private double result, amount1, Payableamount;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private CommonClass CommonClass = new CommonClass();
    private Utility obju = new Utility();
    private DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if ((Session["Adid"] == null) || (Session["mothids"] == null))
        {
            Response.Redirect("getDistID.aspx?type=FS");
        }

        if (!IsPostBack)
        {
            ll1.Visible = false;
            ll2.Visible = false;
            txtCheque.Visible = false;
            txtBankName.Visible = false;
            lblmsg.Visible = false;
            fillFee();
            fillFeemonth();
            // filgrid();
        }
    }

    private void filgrid()
    {
        query = "select monthid,monthname from Month_name";

        dt = objdut.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            ddlmonth1.DataSource = dt;
            ddlmonth1.DataTextField = "monthname";
            ddlmonth1.DataValueField = "monthid";
            ddlmonth1.DataBind();
            ddlmonth1.Items.Insert(0, "--Select Month--");
        }

        dt.Dispose();
    }

    public void fillFee()
    {
        branchID = Convert.ToInt32(Session["BrBrid"]);

        Label7.Text = Convert.ToString(objdut.GetScalar(@"select cast (isnull(SUM(credit),0) as decimal(18,2)) as credit from student_Account
                         where studentid=" + Session["Adid"] + " and  brid=" + branchID + " and academicyearid=" + CommonClass.Scaler("ActiveAcademicYear")));
        string total = Convert.ToString(objdut.GetScalar(@"select isnull(SUM(credit),0) as credit from student_Account
                         where studentid=" + Session["Adid"] + " and  brid=" + branchID + " and academicyearid=" + CommonClass.Scaler("ActiveAcademicYear")));

        Label10.Text = Convert.ToString(objdut.GetScalar(@"select cast (isnull(SUM(payfee),0) as decimal(18,2)) as credit from Payfee_master
                         where studentid=" + Session["Adid"] + " and fyid=" + CommonClass.Scaler("ActiveAcademicYear") + " and trstatus=1"));
        string paid = Convert.ToString(Convert.ToString(objdut.GetScalar(@"select isnull(SUM(payfee),0) as credit from Payfee_master
                         where studentid=" + Session["Adid"] + " and fyid=" + CommonClass.Scaler("ActiveAcademicYear") + " and trstatus=1")));

        string bal = Convert.ToString(Convert.ToString(objdut.GetScalar(@"select cast (isnull(SUM(payfee),0) as decimal(18,2)) as credit from Payfee_master
                         where studentid=" + Session["Adid"] + "   and fyid=" + CommonClass.Scaler("ActiveAcademicYear") + " and trstatus=1")));

        Label11.Text = (Convert.ToDouble(total) - Convert.ToDouble(paid)).ToString("0.00");

        string query = Convert.ToString(objdut.GetScalar(@"select isnull(SUM(credit),0) as credit from student_Account,Month_name mn
                         where studentid=" + Session["Adid"] + " and paymonth in(" + Session["mothids"] + ") and paymonth=mn.MonthId"));

        lbl1.Text = "Total amount(Selected Months):";
        lbl2.Text = "Rs " + Convert.ToDouble(Convert.ToDouble(query)).ToString("0.00");

        string query1 = Convert.ToString(Convert.ToString(objdut.GetScalar(@"select isnull(SUM(payfee),0) as credit from Payfee_master,Month_name mn
                         where studentid=" + Session["Adid"] + " and paymonths in(" + Session["mothids"] + ") and paymonths=mn.MonthId and trstatus=1")));

        Label4.Text = "Rs " + Convert.ToDouble(query1).ToString("0.00");

        Label6.Text = (Convert.ToDouble(query) - Convert.ToDouble(query1)).ToString("0.00");

        ViewState["amountPayable"] = Convert.ToDouble(Label6.Text);
    }

    public void fillFeemonth()
    {
        SqlParameter[] param1 = new SqlParameter[2];
        param1[0] = new SqlParameter("@monthids", Session["mothids"]);
        param1[1] = new SqlParameter("@values", SqlDbType.VarChar, 500, "");
        param1[1].Direction = ParameterDirection.Output;

        DataTable dt = objdut.GetDataTableSP(param1, "usp_mothname");
        lblMonthName.Text = (param1[1].Value.ToString());
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //if (txtAmount.Text == "")
        //{
        //    lblmsg.Text = "Enter amount";
        //    txtAmount.Focus();
        //    return;
        //}
        if (validate())
        {
            amount = Convert.ToDecimal(txtAmount.Text);
            brID = Convert.ToInt32(Session["BrBrid"]);
            adid = Convert.ToInt32(Session["Adid"]);
            query2 = "usp_submitfee";
            SqlParameter[] param = new SqlParameter[10];
            param[0] = new SqlParameter("@Adid", adid);
            param[1] = new SqlParameter("@brid", brID);
            param[2] = new SqlParameter("@debitAmt", lblremainbal.Text);
            param[9] = new SqlParameter("@setAmt", amount);
            param[3] = new SqlParameter("@paymode", ddlPayMode.SelectedItem.Text);
            if (ddlPayMode.SelectedIndex > 1)
            {
                param[4] = new SqlParameter("@BankName", txtBankName.Text.Trim());
                param[5] = new SqlParameter("@checkno", txtCheque.Text.Trim());
            }
            else
            {
                param[4] = new SqlParameter("@BankName", "");
                param[5] = new SqlParameter("@checkno", "");
            }
            param[8] = new SqlParameter("@nextmonthid", Convert.ToInt32("0"));
            param[6] = new SqlParameter("@intresult", Convert.ToInt32("0"));
            param[6].Direction = ParameterDirection.Output;
            // Session["acid"]
            param[7] = new SqlParameter("@monthids", Session["mothids"]);
            int count = objdut.ExecuteSqlSP(param, query2);
            if (count == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Fee inserted successfully..");
                Response.Redirect("depositfeestudent.aspx");
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "An error occured. Please try again.");
                return;
            }
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please fill all necessary details.");
            return;
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Session["acid"] = null;
        Response.Redirect("getDistID.aspx?type=FS");
    }

    protected void ddlPaymode_SelectedIndexChanged(object sender, EventArgs e)
    {
        if ((ddlPayMode.SelectedIndex == 1))
        {
            ll1.Visible = false;
            ll2.Visible = false;
            txtBankName.Visible = false;
            txtCheque.Visible = false;
        }
        if ((ddlPayMode.SelectedIndex == 0))
        {
            ll1.Visible = false;
            ll2.Visible = false;
            txtBankName.Visible = false;
            txtCheque.Visible = false;
        }

        if (ddlPayMode.SelectedIndex == 2)
        {
            ll1.Visible = true;
            ll2.Visible = true;
            lblCDd.Text = "Draft No";
            txtBankName.Visible = true;
            txtCheque.Visible = true;
        }
        if (ddlPayMode.SelectedIndex == 3)
        {
            ll1.Visible = true;
            ll2.Visible = true;
            lblCDd.Text = "Cheque No";
            txtBankName.Visible = true;
            txtCheque.Visible = true;
        }
    }

    protected void txtAmount_TextChanged(object sender, EventArgs e)
    {
        lblremain.Visible = false;
        lblremainbal.Text = "";
        lblmsg.Visible = false;
        if (txtAmount.Text != "")
        {
            if (!double.TryParse(txtAmount.Text, out  result))
            {
                lblmsg.Visible = true;
                lblmsg.Text = "Please enter numeric value!!";
                txtAmount.Text = "";
                return;
            }
            else
            {
                amount1 = Convert.ToDouble(txtAmount.Text);
                Payableamount = (double)ViewState["amountPayable"];
                if (Payableamount < amount1)
                {
                    ddlmonth.Visible = false;
                    lblmsg.Visible = true;
                    lblmsg.Text = "Amount to be paid is greater than balance amount!";
                    txtAmount.Text = "";
                    return;
                }
                else if (Payableamount == amount1)
                {
                    amount1 = Convert.ToDouble(txtAmount.Text);
                    Payableamount = (double)ViewState["amountPayable"];

                    lblremainbal.Text = Convert.ToString(Payableamount - amount1);
                    ddlmonth.Visible = false;
                }
                else
                {
                    filgrid();
                    amount1 = Convert.ToDouble(txtAmount.Text);
                    Payableamount = (double)ViewState["amountPayable"];
                    lblremain.Visible = true;
                    lblremainbal.Text = Convert.ToString(Payableamount - amount1);
                    //ddlmonth.Visible = true;
                    // Label1.Text ="";
                }
            }
        }
    }

    public bool validate()
    {
        if (Convert.ToInt32(ddlPayMode.SelectedValue) > 1)
        {
            if ((txtBankName.Text == "") || (txtCheque.Text == ""))
            {
                Utility.ViewAlertMessage(this.Master.Page, "Please fill bank details .");
                txtBankName.Focus();
                txtCheque.Focus();
                return false;
            }
        }
        return true;
    }

    protected void ddlmonth1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Label1.Text = "";
        SqlParameter[] param1 = new SqlParameter[3];
        param1[0] = new SqlParameter("@monthids", Session["mothids"]);
        param1[1] = new SqlParameter("@monthidsselected", ddlmonth1.SelectedValue);
        param1[2] = new SqlParameter("@ouputvalues", Convert.ToInt32("0"));
        param1[2].Direction = ParameterDirection.Output;

        DataTable dt = objdut.GetDataTableSP(param1, "usp_monthchecking");
        int check = Convert.ToInt32((param1[2].Value.ToString()));
        if (Convert.ToInt32(ddlmonth1.SelectedValue) > check)
        {
        }
        else
        {
            Label1.Text = "Wrong Selection.Please select next month from " + lblMonthName.Text + " months !!";
        }
    }
}