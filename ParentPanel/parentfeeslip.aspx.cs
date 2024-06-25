using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class ParentPanel_parentfeeslip : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();
    private double total_credit = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ADID4"] == null)
        {
            Response.Redirect("~/LoginP.aspx");
        }
        if (!IsPostBack)
        {
            ViewState["acad"] = CommonClass.Scaler("ActiveAcademicYear");
            if (Request.QueryString.Count > 0)
            {
                int rid = Convert.ToInt32(Request.QueryString["studentid"]);
                string query = "select ReceiptNo,ADNO,paymoth,brid,empid,fyid,convert(varchar(14),dateoftransaction,103) as dateoftransaction from tbl_ReceiptMaster where Rid=" + rid;
                DataTable dt = objDUT.GetDataTable(query);
                if (dt.Rows.Count > 0)
                {
                    ViewState["receiptno"] = dt.Rows[0]["ReceiptNo"].ToString();
                    ViewState["date"] = dt.Rows[0]["dateoftransaction"].ToString();
                    Session["Monthid"] = dt.Rows[0]["paymoth"].ToString();
                    Session["brid"] = dt.Rows[0]["brid"].ToString();
                    Session["academicYearID"] = dt.Rows[0]["fyid"].ToString();
                    ViewState["fyname"] = (objDUT.GetScalar("Select fyname from financial_Year where isclosed=0 and isactive=1 and fyid=" + ViewState["acad"] + "")).ToString();
                    Session["Adid"] = dt.Rows[0]["ADNO"].ToString();
                }
            }
            fillstudent();
            fillgrid();
            filfun();
        }
    }

    private void filfun()
    {
        if (Request.QueryString.Count > 0)
        {
            lblreceiptno.Text = Convert.ToString(ViewState["receiptno"]);
            lblDate.Text = ViewState["date"].ToString();
            lblYear.Text = ViewState["fyname"].ToString();
        }
        else
        {
            string q = ("select isnull(receiptno,'') as receiptno,ADNO,paymoth,brid,empid,fyid,convert(varchar(14),dateoftransaction,103) as dateoftransaction from tbl_receiptmaster where rid=(select max(rid) from tbl_receiptmaster)");
            DataTable dt = objDUT.GetDataTable(q);
            if (dt.Rows.Count > 0)
            {
                lblreceiptno.Text = dt.Rows[0]["receiptno"].ToString();
                lblDate.Text = dt.Rows[0]["dateoftransaction"].ToString();
                Session["academicYearID"] = dt.Rows[0]["fyid"].ToString();
                lblYear.Text = (objDUT.GetScalar("Select fyname from financial_Year where isclosed=0 and isactive=1 and fyid=" + ViewState["acad"] + "")).ToString();
            }
        }
    }

    private void fillstudent()
    {
        string query = "select (firstname+' '+lastname)as name,(applyclass+' '+tbl_Admission.section) as class,adno from tbl_Admission inner join student_master on student_master.sturegno=tbl_Admission.sturegno  where adid=" + Session["ADID4"] + " and tbl_Admission.brid=" + Session["Branchid"] + " and tbl_Admission.fyid=" + ViewState["acad"] + " and tbl_Admission.status=1";
        DataTable dt = objDUT.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            lblname.Text = dt.Rows[0]["name"].ToString();
            lblrollno.Text = dt.Rows[0]["adno"].ToString();
            lblClass.Text = dt.Rows[0]["class"].ToString();
        }
    }

    private void fillgrid()
    {
        string query = @"select SUBSTRING(transtype,(charindex('-',transtype)+1),LEN(transtype)) as transtype,sum(Credit) as Credit
                          from tbl_Admission_student_Account,Month_name where studentid=" + Session["ADID4"] + @"
                         and brid=" + Session["Branchid"] + " and academicyearid=" + ViewState["acad"] + " and paymonth in(" + Session["mothids"] + ") and paymonth=MonthId  group by transtype order by transtype asc";
        DataTable dt = objDUT.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbl2 = (Label)e.Row.FindControl("lblParticulars");
            //Label lbl3 = (Label)e.Row.FindControl("lblDuration");
            if (lbl2.Text == "Admission Fee" || lbl2.Text == "Term Fee")
            {
                // lbl3.Text = "";
            }
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //******* total credit
            Label lbl_credit = (Label)e.Row.FindControl("lblAmount");
            total_credit += Convert.ToDouble(lbl_credit.Text);
        }

        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblamount = (Label)e.Row.FindControl("lblTotalcredit");
            lblamount.Text = string.Format("{0:f}", total_credit);

            Label lblPaid = (Label)e.Row.FindControl("lblTotaldebit");

            lblPaid.Text = string.Format("{0:f}", objDUT.GetScalar("select isnull(SUM(payfee),0) as debit from Payfee_master where studentid=" + Session["ADID4"] + " and brid=" + Session["Branchid"] + " and fyid=" + ViewState["acad"] + " and paymonths in (" + Session["mothids"] + ")"));

            if (lblPaid.Text == "")
            {
                lblPaid.Text = "0.00";

                Label lblBalence = (Label)e.Row.FindControl("lblTotalbal");
                lblBalence.Text = String.Format("{0:f}", (Convert.ToDouble(lblamount.Text) - Convert.ToDouble(lblPaid.Text)));

                if (lblBalence.Text == "0.00")
                {
                    // PayNow.Visible = false;
                }
                else
                {
                    //PayNow.Visible = true;
                }
            }
            else
            {
                Label lblBalence = (Label)e.Row.FindControl("lblTotalbal");
                lblBalence.Text = String.Format("{0:f}", (Convert.ToDouble(lblamount.Text) - Convert.ToDouble(lblPaid.Text)));

                if (lblBalence.Text == "0.00")
                {
                    //PayNow.Visible = false;
                }
                else
                {
                    //PayNow.Visible = true;
                }
            }
        }
    }
}