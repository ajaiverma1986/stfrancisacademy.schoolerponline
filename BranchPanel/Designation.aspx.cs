using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_Designation : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private DataTable dt;
    private DataUtility objdut = new DataUtility();
    private SqlParameter[] param = new SqlParameter[4];

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        //PageName = Utility.GetCurrentPagename();

        if (!IsPostBack)
        {
            divgrid.Visible = true;
            divall.Visible = false;
            btnUpdate.Visible = false;
            Cancel.Visible = false;
            fillDepartMent();
            fillGrid();
        }
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        Response.Redirect("Department.aspx");
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
        Response.Redirect("Designation.aspx");
    }

    public void fillDepartMent()
    {
        if (CommonClass.ABC1("GetAllDepartment", Convert.ToInt32(Session["BrBrid"])).Rows.Count > 0)
        {
            ddlCountry.DataSource = CommonClass.ABC1("GetAllDepartment", Convert.ToInt32(Session["BrBrid"]));
            ddlCountry.DataTextField = "deptName";
            ddlCountry.DataValueField = "deptid";

            ddlCountry.DataBind();
            ListItem li = new ListItem("--Department--", "0");
            ddlCountry.Items.Insert(0, li);
        }
    }

    protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        dt = CommonClass.ABC1("GetAllDesignationinSingledepartment", Convert.ToInt32(ddlCountry.SelectedValue));
        if (dt.Rows.Count > 0)
        {
            Grid_state.DataSource = dt;
            Grid_state.DataBind();
            dt.Clear();
        }
        else
        {
            Grid_state.DataSource = null;
            Grid_state.DataBind();
        }
    }

    protected void btnstate_Click(object sender, EventArgs e)
    {
        if (ddlCountry.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(Page, "please select department.");
            return;
        }
        if (txtState.Text == "")
        {
            Utility.ViewAlertMessage(Page, "please enter designation name.");
            return;
        }
        string pname = "usp_AddDesig";
        param[0] = new SqlParameter("@deptid", ddlCountry.SelectedValue);
        param[1] = new SqlParameter("@designame", txtState.Text);
        if (chkfetype.Checked)
        {
            param[2] = new SqlParameter("@status", 1);
        }
        else
        {
            param[2] = new SqlParameter("@status", 0);
        }
        param[3] = new SqlParameter("@intresult", Convert.ToInt32("0"));
        param[3].Direction = ParameterDirection.Output;

        int count = objdut.ExecuteSqlSP(param, pname);
        if (count > 0)
        {
            if (count == 1)
            {
                fillGrid();
                ddlCountry.SelectedValue = "0";
                txtState.Text = "";
                chkfetype.Checked = false;
                Utility.ViewAlertMessage(Page, "record saved successfully.");
                divgrid.Visible = true;
                Button2.Visible = true;
                divall.Visible = false;
                return;
            }
            if (count == 2)
            {
                Utility.ViewAlertMessage(Page, "selected department is not active.");
                return;
            }
            if (count == 3)
            {
                Utility.ViewAlertMessage(Page, "please enter designation name.");
                return;
            }
        }
        else
        {
            Utility.ViewAlertMessage(Page, "record not saved Please try latter.");
            return;
        }
    }

    protected void btnUpdate_Click1(object sender, EventArgs e)
    {
        if (ddlCountry.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(Page, "please select department.");
            return;
        }
        if (txtState.Text == "")
        {
            Utility.ViewAlertMessage(Page, "please enter designation name.");
            return;
        }

        string update = "update designation_master set desigName=@designame,deptid=@deptid,deptname=@deptname,status=@status where desigid=" + ViewState["desigid"];
        SqlParameter[] upParam = new SqlParameter[4];
        upParam[0] = new SqlParameter("@designame", txtState.Text);
        upParam[1] = new SqlParameter("@deptid", Convert.ToInt32(ddlCountry.SelectedValue));
        upParam[2] = new SqlParameter("@deptname", Convert.ToString(ddlCountry.SelectedItem.Text));
        upParam[3] = new SqlParameter("@status", (chkfetype.Checked ? 1 : 0));
        int result = objdut.ExecuteSql(upParam, update);
        if (result > 0)
        {
            Utility.ViewAlertMessage(Page, "designation updated successfully.");
            divgrid.Visible = true;
            divall.Visible = false;
            Button2.Visible = true;
            fillGrid();
        }
    }

    public void fillGrid()
    {
        dt = CommonClass.ABC1("GetAllDesignation", Convert.ToInt32(Session["BrBrid"]));
        if (dt.Rows.Count > 0)
        {
            Grid_state.DataSource = dt;
            Grid_state.DataBind();
            dt.Clear();
        }
    }

    protected void Grid_state_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "edit16")
        {
            divgrid.Visible = false;
            divall.Visible = true;
            Button2.Visible = false;
            btnstate.Visible = false;
            btnUpdate.Visible = true;
            Cancel.Visible = true;
            int desigid = Convert.ToInt32(e.CommandArgument);
            ViewState["desigid"] = desigid;
            string query = "select deptid,desigName,status from designation_master where desigID=" + desigid;

            DataTable dt = objdut.GetDataTable(query);
            if (dt.Rows.Count > 0)
            {
                ddlCountry.SelectedValue = dt.Rows[0]["deptid"].ToString();
                txtState.Text = dt.Rows[0]["desigName"].ToString();
                if (dt.Rows[0]["status"].ToString() == "1")
                {
                    chkfetype.Checked = true;
                }
                dt.Dispose();
            }
        }
    }

    protected void Cancel_Click(object sender, EventArgs e)
    {
        ddlCountry.SelectedValue = "0";
        txtState.Text = "";
        chkfetype.Checked = false;
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        divall.Visible = true;
        divgrid.Visible = false;
        Button2.Visible = false;
        Cancel.Visible = false;
        btnstate.Visible = true;
        btnUpdate.Visible = false;
        ddlCountry.SelectedValue = "0";
        txtState.Text = "";
    }
}