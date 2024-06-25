using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class BranchPanel_depositfeestudent : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();
    private CommonClass CommonClass = new CommonClass();
    private double total_credit = 0, total_sum = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["BrBrid"] == null)
        {
            Response.Redirect("~/LogOut.aspx");
        }
        if (!IsPostBack)
        {
            filfun();
            fillstudent();
            fillrecipt();
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
            string sr = "select top(1) isnull(receiptno,'') as receiptno,brid,fyid,convert(varchar(14),transaction_date,103) as transaction_date from tbl_payfee where studentid=" + Session["Adid"] + " order by pid desc";

            DataTable dt = objDUT.GetDataTable(sr);
            if (dt.Rows.Count > 0)
            {
                lblreceiptno.Text = dt.Rows[0]["receiptno"].ToString();
                ViewState["reciept"] = lblreceiptno.Text;
                lblDate.Text = dt.Rows[0]["transaction_date"].ToString();
                Session["academicYearID"] = dt.Rows[0]["fyid"].ToString();
                lblYear.Text = (objDUT.GetScalar("Select fyname from financial_Year where isclosed=0 and isactive=1 and fyid=" + Convert.ToInt32(Session["academicYearID"]) + "")).ToString();
            }
        }
    }

    private void fillstudent()
    {
        string query = "select (firstname+' '+lastname)as name,(ta.applyclass+' '+ta.section) as class,adno from tbl_Admission ta inner join student_master sm on sm.sturegno=ta.sturegno  where adid=" + Session["Adid"] + " and ta.brid=" + Session["BrBrid"] + " and ta.fyid=" + CommonClass.Scaler("ActiveAcademicYear") + " and ta.status=1";
        DataTable dt = objDUT.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            lblname.Text = dt.Rows[0]["name"].ToString();
            lblrollno.Text = dt.Rows[0]["adno"].ToString();
            lblClass.Text = dt.Rows[0]["class"].ToString();
        }
    }

    private void fillrecipt()
    {
        string srt = "select isnull((payfee),0) as Credit,transtype,MonthName from tbl_payfee tp left join Month_name mn on mn.MonthId=tp.paymonths where  receiptno='" + ViewState["reciept"] + "' and brid=" + Session["BrBrid"] + "and fyid=" + CommonClass.Scaler("ActiveAcademicYear");
        DataTable dt = objDUT.GetDataTable(srt);
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
            string amount = ((Label)e.Row.FindControl("lblAmount")).Text;

            total_sum = total_sum + Convert.ToDouble(amount);
        }

        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lbl = (Label)e.Row.FindControl("lblTotalcredit");
            lbl.Text = total_sum.ToString();
        }
    }
}