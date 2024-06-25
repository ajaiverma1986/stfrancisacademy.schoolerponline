using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;

public partial class BranchPanel_sallery_report : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private static int fyid = 0;
    private CommonClass commonOBJ = new CommonClass();
    private DataTable dt;
    private int payid;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                BindDDLpayid();
                fyid = CommonClass.Scaler("ActiveAcademicYear");
                fillgrid(0);
            }
        }
        catch (Exception exx)
        {
        }
    }

    protected void ddlpayid_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlpayid.SelectedValue == "0")
        {
            fillgrid(0);
        }
        else
        {
            fillgrid(Convert.ToInt32(ddlpayid.SelectedValue));
        }
        tblforsalarydetails.Visible = false;
        btnback.Visible = false;
    }

    protected void BindDDLpayid()
    {
        DataTable dt;
        string query = "select (cast(payid as varchar(20))+' ('+convert(varchar(13),startdate,106)+' To '+convert(varchar(13),enddate,106)+')') as payname,payid from tbl_MonthlySalaryMaster where fyid=2";
        dt = objdut.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            ddlpayid.DataSource = dt;
            ddlpayid.DataTextField = "payname";
            ddlpayid.DataValueField = "payid";
            ddlpayid.DataBind();
            ddlpayid.Items.Insert(0, new ListItem("  Select PayID  ", "0"));
        }
        else
        {
            ddlpayid.Items.Insert(0, new ListItem("  Select PayID  ", "0"));
        }
        dt.Dispose();
    }

    private void fillgrid(int payid)
    {
        try
        {
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@fyid", SqlDbType.Int);
            param[0].Value = fyid;

            param[1] = new SqlParameter("@payid", SqlDbType.Int);
            param[1].Value = payid;

            param[2] = new SqlParameter("@empid", SqlDbType.Int);
            param[2].Value = Convert.ToInt32(HttpContext.Current.Session["empid"]);

            DataTable dt = objdut.GetDataTableSP(param, "usp_emp_salary_report");

            if (dt.Rows.Count > 0)
            {
                gvsalaryreports.DataSource = dt;
                gvsalaryreports.DataBind();
            }
            else
            {
                gvsalaryreports.EmptyDataText = "No salary report is available.";
                gvsalaryreports.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void gvsalaryreports_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ShowDetails")
        {
            payid = Convert.ToInt32(e.CommandArgument);
            if (ddlpayid.SelectedIndex == 0)
            {
                fillgrid(1);
            }
            else
            {
                fillgrid(Convert.ToInt32(ddlpayid.SelectedValue));
            }

            BindGrid();
        }
    }

    protected void BindGrid()
    {
        try
        {
            SqlParameter[] param = new SqlParameter[5];

            if (ddlpayid.SelectedIndex == 0)
            {
                param[0] = new SqlParameter("@payid", 1);
            }
            else
            {
                param[0] = new SqlParameter("@payid", payid);
            }
            param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));

            param[2] = new SqlParameter("@fyid", fyid);

            param[3] = new SqlParameter("@empid", Convert.ToInt32(HttpContext.Current.Session["empid"]));

            param[4] = new SqlParameter("@effectivedays", 0);

            dt = objdut.GetDataTableSP(param, "[usp_calculatesallery]");

            if (dt.Rows.Count > 0)
            {
                gvdetails.DataSource = dt;
                gvdetails.DataBind();
            }
            else
            {
                gvdetails.EmptyDataText = "No salary report is available.";
                gvdetails.DataBind();
            }
            btnback.Visible = true;
            tblforsalarydetails.Visible = true;
        }
        catch (Exception ex)
        {
        }
    }

    protected void btnback_Click(object sender, EventArgs e)
    {
        fillgrid(0);
        tblforsalarydetails.Visible = false;
        btnback.Visible = false;
    }
}