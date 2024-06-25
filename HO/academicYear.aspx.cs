using System;
using System.Web.UI.WebControls;

public partial class HO_academicYear : System.Web.UI.Page
{
    private DataUtility objDut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        AcademicYear();
        if (!IsPostBack)
        {
            fillDDL();
            fillMonth();
        }
    }

    protected void fillDDL()
    {
        for (int i = 2013; i <= Convert.ToInt32(System.DateTime.Today.Year); i++)
        {
            ddlStartYear.Items.Add(i.ToString());
        }
    }

    protected void ddlStartYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlStartYear.SelectedValue != "0")
        {
            for (int i = (Convert.ToInt32(System.DateTime.Today.Year)) + 1; i <= (Convert.ToInt32(System.DateTime.Today.Year)) + 1; i++)
            {
                txtEndYear.Text = i.ToString();
            }
        }
    }

    protected void fillMonth()
    {
        string query = "Select * from month_name";
        ddlMonth.DataSource = objDut.GetDataTable(query);
        ddlMonth.DataTextField = "MonthName";
        ddlMonth.DataValueField = "MonthId";
        ddlMonth.DataBind();
        ListItem li = new ListItem("--Select Month--", "0");
        ddlMonth.Items.Insert(0, li);
    }

    protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        int id = (Convert.ToInt32(ddlMonth.SelectedValue)) - 1;
        string query = "Select MonthName from month_name where MonthId=" + id;
        string res = objDut.GetScalar(query).ToString();
        //ddlEndMonth.Items.Add(res);
        txtEndMonth.Text = res;
    }

    public void AcademicYear()
    {
        string query = "Select FYName from financial_year where isActive=1";
        string res = objDut.GetScalar(query).ToString();
        lblAcaYear.Text = res;
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
    }
}