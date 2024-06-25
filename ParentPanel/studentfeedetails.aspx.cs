using System;
using System.Data;

public partial class ParentPanel_studentfeedetails : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private string PageName = "", url = "", srt;
    private long loginID;
    private decimal amount;
    private int branchID, brID, adid;
    private double result, amount1, Payableamount;
    private DataTable dt;

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

            fillgrd();
        }
    }

    private void fillgrd()
    {
        dt = CommonClass.parentpanel("parentfees", Convert.ToString(Session["ADID4"]));
        if (dt.Rows.Count > 0)
        {
            gridreport.DataSource = dt;
            gridreport.DataBind();
            Table2.Visible = true;
        }
        else
        {
            gridreport.EmptyDataText = "No Record Found .";
            gridreport.DataBind();
            Table2.Visible = false;
        }
        binddetail();
    }

    public void binddetail()
    {
        if (Convert.ToInt16(Session["transptype"]) == 1)
        {
            srt = "select isnull(sum(credit),0) as credit from tbl_Admission_student_Account where studentid=" + Session["ADID4"] + "and  academicyearid=" + ViewState["acad"];
        }
        else
        {
            srt = "select isnull(sum(credit),0) as credit from tbl_Admission_student_Account where studentid=" + Session["ADID4"] + "and  academicyearid=" + ViewState["acad"] + " and transtype!='Monthly-Transport Fee'";
        }
        double cou;
        cou = Convert.ToDouble(objdut.GetScalar(srt));
        lblTotal.Text = cou.ToString();
        string srt1 = "select isnull(sum(payfee),0) as payfee from Payfee_master where Studentid=" + Session["ADID4"] + "and  fyid=" + ViewState["acad"];
        int cou1;
        cou1 = Convert.ToInt32(objdut.GetScalar(srt1));
        lblReceived.Text = cou1.ToString();
        double a = cou;
        double b = cou1;
        double c = a - b;
        lblremain.Text = c.ToString();
    }
}