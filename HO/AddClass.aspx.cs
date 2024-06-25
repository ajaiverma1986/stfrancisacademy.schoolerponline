using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class HO_feetype : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private Utility objut = new Utility();
    private SqlParameter[] param = new SqlParameter[7];
    private DataUtility objdut = new DataUtility();
    private int id;
    private CommonClass CommonClass = new CommonClass();

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["User"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        txtAddClass.Focus();
        if (!IsPostBack)
        {
            
            fillfyear();
            divgrid.Visible = true;
            divall.Visible = false;

            btnUpdate.Visible = false;
            GridBind();
        }
    }

    public void fillfyear()
    {
        DataTable Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        //int ViewState["Fyid"] = CommonClass.GetActiveAcedmicYear();
        ViewState["Fyid"] = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ViewState["Fyid"]);

        ddlfinacialyearforsearching.DataSource = Dt;
        ddlfinacialyearforsearching.DataValueField = "fyid";
        ddlfinacialyearforsearching.DataTextField = "FYName";
        ddlfinacialyearforsearching.DataBind();
        ddlfinacialyearforsearching.SelectedValue = Convert.ToString(ViewState["Fyid"]);
    }

    protected void GridBind()
    {
        //int ViewState["Fyid"] = CommonClass.GetActiveAcedmicYear();
        ddlfinacialyearforsearching.SelectedValue = Convert.ToString(ViewState["Fyid"]);
        DataTable dt = new DataTable();
        dt = CommonClass.ABC("Getallclassh", Convert.ToInt32(ViewState["Fyid"]));
        if (dt.Rows.Count > 0)
        {
            grdBranch.DataSource = dt;
            grdBranch.DataBind();
        }
        else
        {
            grdBranch.EmptyDataText = "No Class Added Till Now In The System";
            grdBranch.DataBind();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (txtAddClass.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Class.");
            txtAddClass.Focus();
            return;
        }
        if (txtdisplayorder.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Display Order.");
            txtAddClass.Focus();
            return;
        }
        else
        {
            param[0] = new SqlParameter("@Classname", txtAddClass.Text.Trim());
            param[1] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
            param[2] = new SqlParameter("@userid", Session["ADID"]);
            param[3] = new SqlParameter("@intresult", SqlDbType.Int);
            param[3].Direction = ParameterDirection.Output;
            param[4] = new SqlParameter("@mode", 1);
            param[5] = new SqlParameter("@DisplayOrder", txtdisplayorder.Text);
            param[6] = new SqlParameter("@SchoolType", Convert.ToInt32(rbtnlistschooltype.SelectedValue));
            int result = objdut.ExecuteSqlSP(param, "Usp_Class");
            if (result == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Class Added Successfully.");
                divgrid.Visible = true;
                divall.Visible = false;
                Button1.Visible = true;
                txtAddClass.Text = "";
                GridBind();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "This Class is Already Exist in This Session");
            }
        }
    }

    protected void grdBranch_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "edit12")
        {
            divall.Visible = true;
            divgrid.Visible = false;
            Button1.Visible = false;
            int id = Convert.ToInt32(e.CommandArgument);
            string query = "select Id,Classname,Fyid,DisplayOrder,SchoolType From class_master where  id=" + id;
            DataTable table = objdut.GetDataTable(query);
            if (table.Rows.Count > 0)
            {
                txtAddClass.Text = table.Rows[0]["Classname"].ToString();
                ViewState["id"] = table.Rows[0]["Id"].ToString();
                ddlfinancialyear.SelectedValue = Convert.ToString(table.Rows[0]["Fyid"]);
                txtdisplayorder.Text = table.Rows[0]["DisplayOrder"].ToString();
                rbtnlistschooltype.SelectedValue = Convert.ToString(table.Rows[0]["SchoolType"]);
            }
        }
        ddlfinancialyear.Enabled = false;
        btnUpdate.Visible = true;
        btnback.Visible = true;
        btnSubmit.Visible = false;
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (txtAddClass.Text != "")
        {
            SqlParameter[] param = new SqlParameter[8];
            param[0] = new SqlParameter("@Classname", txtAddClass.Text.Trim());
            param[1] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
            param[2] = new SqlParameter("@userid", Session["ADID"]);
            param[3] = new SqlParameter("@intresult", SqlDbType.Int);
            param[3].Direction = ParameterDirection.Output;
            param[4] = new SqlParameter("@mode", 2);
            param[5] = new SqlParameter("@Id", ViewState["id"]);
            param[6] = new SqlParameter("@displayorder", txtdisplayorder.Text);
            param[7] = new SqlParameter("@SchoolType", Convert.ToInt32(rbtnlistschooltype.SelectedValue));
            int result1 = objdut.ExecuteSqlSP(param, "Usp_Class");
            if (result1 == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Class Updated Successfully.");
                divall.Visible = false;
                divgrid.Visible = true;
                txtAddClass.Text = "";
                btnUpdate.Visible = false;
                btnSubmit.Visible = true;
                Button1.Visible = true;
                btnback.Visible = false;
                GridBind();
            }
            else if (result1 == 2)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Class Successfully Added In Selected Session.");
                divall.Visible = false;
                divgrid.Visible = true;
                txtAddClass.Text = "";
                btnUpdate.Visible = false;
                btnSubmit.Visible = true;
                Button1.Visible = true;
                btnback.Visible = false;
                GridBind();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "This Class is Already Exist In This Session.");
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        //int ViewState["Fyid"] = CommonClass.GetActiveAcedmicYear();
        divall.Visible = true;
        divgrid.Visible = false;
        Button1.Visible = false;
        btnback.Visible = true;
        btnSubmit.Visible = true;
        ddlfinancialyear.Enabled = true;
        ddlfinancialyear.SelectedValue = ViewState["Fyid"].ToString();
        txtAddClass.Text = "";
        txtdisplayorder.Text = "";
    }

    protected void btnback_Click(object sender, EventArgs e)
    {
        divgrid.Visible = true;
        divall.Visible = false;
        Button1.Visible = true;
        btnback.Visible = false;
        btnUpdate.Visible = false;
        GridBind();
    }

    protected void ddlfinacialyearforsearching_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable table = CommonClass.ABC("Getallclassh", Convert.ToInt32(ddlfinacialyearforsearching.SelectedValue));
        if (table.Rows.Count > 0)
        {
            grdBranch.DataSource = table;
            grdBranch.DataBind();
        }
        else
        {
            grdBranch.EmptyDataText = "No Class Added Till Now In The System.";
            grdBranch.DataBind();
        }
    }
}