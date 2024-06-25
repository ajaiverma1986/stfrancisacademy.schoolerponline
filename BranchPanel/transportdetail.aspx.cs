using System;
using System.Web.UI.WebControls;

public partial class BranchPanel_transportdetail : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private CommonClass CommonClass = new CommonClass();
    private string url;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrBrid"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        if (Session["stue"] == null)
        {
            Response.Redirect("Default.aspx");
        }
        if (!IsPostBack)
        {
            fillzonewisearea();
            check();
        }
    }

    private void fillzonewisearea()
    {
        DropDownList1.DataSource = CommonClass.Dll("zone");
        DropDownList1.DataTextField = "zonename";
        DropDownList1.DataValueField = "zoneid";
        DropDownList1.DataBind();
        DropDownList1.Items.Insert(0, new ListItem("--Select Sector--", "0"));
    }

    public void check()
    {
        DateTime date = Convert.ToDateTime(objdut.GetScalar("select getdate()"));
        int monthid12 = Convert.ToInt32(objdut.GetScalar("select DATEPART(month,getdate())"));

        int monthid = 0;

        if (monthid12 == 1)
        {
            monthid = 10;
        }
        else if (monthid12 == 2)
        {
            monthid = 11;
        }
        else if (monthid12 == 3)
        {
            monthid = 12;
        }
        else if (monthid12 == 4)
        {
            monthid = 1;
        }
        else if (monthid12 == 5)
        {
            monthid = 2;
        }
        else if (monthid12 == 6)
        {
            monthid = 3;
        }
        else if (monthid12 == 7)
        {
            monthid = 4;
        }
        else if (monthid12 == 8)
        {
            monthid = 5;
        }
        else if (monthid12 == 9)
        {
            monthid = 6;
        }
        else if (monthid12 == 10)
        {
            monthid = 7;
        }
        else if (monthid12 == 11)
        {
            monthid = 8;
        }
        else if (monthid12 == 12)
        {
            monthid = 9;
        }

        int actualmonth;
        actualmonth = monthid + 1;
        Session["deactivemonth"] = actualmonth;

        int studentid = Convert.ToInt32(objdut.GetScalar("select adid from tbl_admission  where adid='" + Session["stue"] + "'"));
        int count6 = Convert.ToInt32(objdut.GetScalar("select transport_status from tbl_Admission_student_Account where studentid='" + studentid + "' and paymonth=" + actualmonth + " and transtype='Monthly-Transport Fee'"));
        if (count6 == 0)
        {
            btndeactive.Visible = false;
        }
    }
}