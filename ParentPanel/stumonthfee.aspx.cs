using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class ParentPanel_stumonthfee : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private CommonClass CommmonOBJ = new CommonClass();
    private SqlParameter[] param = new SqlParameter[4];
    private string url, query, query1, query2, query3, query4, qrt, srt;
    private DataTable dt, dt1;
    private int monthId, ourmonthid, stuID;
    private double total_debit = 0, total_credit = 0, total_balanced = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["ADID4"] == null)
        {
            Response.Redirect("~/LoginP.aspx");
        }

        if (!IsPostBack)
        {
            ViewState["acad"] = CommonClass.Scaler("ActiveAcademicYear");
            l1.Visible = true;

            bind_month();
        }
    }

    private void bind_month()
    {
        DataTable dt = CommmonOBJ.Dll("MonthName");
        ddlMonth.DataSource = dt;
        ddlMonth.DataBind();
        ddlMonth.DataTextField = "MonthName";
        ddlMonth.DataValueField = "MonthId";
        ddlMonth.DataBind();
        ddlMonth.Items.Insert(0, "--Select Month--");
    }

    protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        Table4.Visible = true;
        gridreport.Visible = true;
        bindreport();
        binddetail();
    }

    public void binddetail()
    {
        System.Threading.Thread.Sleep(1000);
        if (Convert.ToInt16(Session["transptype"]) == 1)
        {
            srt = "select isnull(sum(credit),0) as credit from tbl_Admission_student_Account where paymonth=" + ddlMonth.SelectedValue + "and academicyearid=" + ViewState["acad"] + " and studentid=" + Session["ADID4"];
        }
        else
        {
            srt = "select isnull(sum(credit),0) as credit from tbl_Admission_student_Account where paymonth=" + ddlMonth.SelectedValue + "and academicyearid=" + ViewState["acad"] + " and studentid=" + Session["ADID4"] + " and transtype!='Monthly-Transport Fee'";
        }

        int cou;
        cou = Convert.ToInt32(objdut.GetScalar(srt));
        lblTotal.Text = cou.ToString();
        string srt1 = "select isnull(sum(payfee),0) as payfee from Payfee_master where paymonths=" + ddlMonth.SelectedValue + "and fyid=" + ViewState["acad"] + " and studentid=" + Session["ADID4"];
        int cou1;
        cou1 = Convert.ToInt32(objdut.GetScalar(srt1));
        lblReceived.Text = cou1.ToString();
        double a = cou;
        double b = cou1;
        double c = a - b;
        lblremain.Text = c.ToString();
    }

    public void bindreport()
    {
        string qr1 = @"select distinct sm.FirstName,sm.sturegno,tm.ADNO,tm.ApplyClass,sum(pa.payfee) as total from Payfee_master pa
                     join student_master sm on pa.Studentid=sm.ADMIID join tbl_Admission tm on tm.sturegno=sm.sturegno where pa.paymonths=" + ddlMonth.SelectedValue + " and  Studentid=" + Session["ADID4"] + " and tm.brid=" + Convert.ToDouble(Session["Branchid"]) + " group by pa.studentid,sm.FirstName,sm.sturegno,tm.ADNO,tm.ApplyClass ";

        DataTable dt3 = objdut.GetDataTable(qr1);
        if (dt3.Rows.Count > 0)
        {
            gridreport.DataSource = dt3;
            gridreport.DataBind();
        }
        else
        {
            gridreport.EmptyDataText = "No Record Found.!";
            gridreport.DataBind();
        }
    }

    protected void gridreport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lb1 = (Label)e.Row.FindControl("lblamnt");
            Label lb2 = (Label)e.Row.FindControl("lblstudentname");
            Label lb3 = (Label)e.Row.FindControl("lbldue");
            lb3.ForeColor = System.Drawing.Color.Red;
            if (Convert.ToInt16(Session["transptype"]) == 1)
            {
                qrt = "select isnull(sum(credit),0) as credit from tbl_Admission_student_Account where studentid=" + Session["ADID4"] + " and paymonth=" + ddlMonth.SelectedValue;
            }
            else
            {
                qrt = "select isnull(sum(credit),0) as credit from tbl_Admission_student_Account where studentid=" + Session["ADID4"] + " and paymonth=" + ddlMonth.SelectedValue + " and transtype!='Monthly-Transport Fee'";
            }

            int cou5;
            cou5 = Convert.ToInt32(objdut.GetScalar(qrt));
            double a = cou5;
            double b = Convert.ToDouble(lb1.Text);
            double c = 0.0;
            c = a - b;
            lb3.Text = Convert.ToString(c);
        }
    }
}