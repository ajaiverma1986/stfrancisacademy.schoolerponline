using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class BranchPanel_student_admission_form : System.Web.UI.Page
{
    private DataTable dt;
    private DataUtility objdut = new DataUtility();
    private CommonClass CommonClass = new CommonClass();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillzonewisearea();
            fillDATEDDL();
            fillCountry();
            state();
            fillfyid();
            ddlCountry1.SelectedValue = "96";
            txtOfficer.Text = Convert.ToString(Session["Brusername"]);
        }
    }

    private void fillfyid()
    {
        string str = "select FYID,FYName from financial_Year";
        dt = objdut.GetDataTable(str);
        if (dt.Rows.Count > 0)
        {
            ddlfinancialyear.DataSource = dt;
            ddlfinancialyear.DataTextField = "FYName";
            ddlfinancialyear.DataValueField = "FYID";
            ddlfinancialyear.DataBind();
            ddlfinancialyear.Items.Insert(0, new ListItem("--Select Financial Year--", "0"));
        }
        dt.Dispose();
    }

    private void fillzonewisearea()
    {
        DropDownList1.DataSource = CommonClass.Dll("zone");
        DropDownList1.DataTextField = "zonename";
        DropDownList1.DataValueField = "zoneid";
        DropDownList1.DataBind();
        DropDownList1.Items.Insert(0, new ListItem("--Select Zone--", "0"));
    }

    private void state()
    {
        ddl_state.Items.Clear();
        lblCountryMsg.Visible = false;
        string str = "select SID,stateName  from STATE where CID=96 order by stateName  ";
        DataTable dt1 = objdut.GetDataTable(str);
        if (dt1.Rows.Count > 0)
        {
            //ddlState1.DataSource = CommonClass.Dll("Statedll", Convert.ToInt32(ddlCountry1.SelectedValue));
            ddl_state.DataSource = dt1;
            ddl_state.DataTextField = "stateName";
            ddl_state.DataValueField = "SID";
            ddl_state.DataBind();

            ddl_state.Items.Insert(0, new ListItem("--Select State--", "0"));
            ddl_state.Focus();
        }
    }

    public void fillCountry()
    {
        ddlCountry1.DataSource = CommonClass.ABC("Countrydll");// CommonClass.Dll("Countrydll");
        ddlCountry1.DataTextField = "countryName";
        ddlCountry1.DataValueField = "CID";
        ddlCountry1.DataBind();
        ddlCountry1.Items.Insert(0, new ListItem("--Select Country--", "0"));
        ddl_state.Items.Insert(0, new ListItem("--Select State--", "0"));
        ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
    }

    public void fillDATEDDL()
    {
        dt = CommonClass.ABC("MonthName");//CommmonOBJ.Dll("MonthName");
        ddlMonth.DataSource = dt;
        ddlMonth.DataBind();
        ddlMonth.DataTextField = "MonthName";
        ddlMonth.DataValueField = "MonthId";
        ddlMonth.DataBind();
        ddlMonth.Items.Insert(0, "--Month--");
        ddlDate.Items.Insert(0, "--Date--");
        ddlYear.Items.Insert(0, "--Year--");
    }
}