using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_Addarea : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    private DataUtility objdut = new DataUtility();
    private Utility objut = new Utility();

    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
    private SqlCommand cmd = new SqlCommand();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            divall.Visible = false;
            divgrid.Visible = true;
            fildll();
            fillgridview();
        }
    }

    private void fillgridview()
    {
        string query = "select  areaid,zonename, areaname from tbl_addarea where status=1 order by areaid desc";
        ViewState["q"] = query;
        DataTable dt;
        dt = objdut.GetDataTable(query);
        griview_addarea.DataSource = dt;
        griview_addarea.DataBind();
    }

    protected void fildll()
    {
        ddl_Busroot.DataSource = CommonClass.ABC("zone");   //CommonClass.Dll("zone");
        ddl_Busroot.DataTextField = "zonename";
        ddl_Busroot.DataValueField = "zoneid";
        ddl_Busroot.DataBind();
        ddl_Busroot.Items.Insert(0, new ListItem("--Select Zone--", "0"));
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        if (checkValidation())
        {
            if (btnAdd.Text != "Update")
            {
                SqlParameter[] param = new SqlParameter[6];
                param[0] = new SqlParameter("@mode", "addarea");
                param[1] = new SqlParameter("@areaname", txtarea.Text.Trim());
                param[2] = new SqlParameter("@zonename", ddl_Busroot.SelectedItem.Text);
                param[3] = new SqlParameter("@zoneid", ddl_Busroot.SelectedValue);
                param[4] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                param[4].Direction = ParameterDirection.Output;
                // param[5] = new SqlParameter("@roadname", txtroad.Text);
                param[5] = new SqlParameter("@id", Convert.ToInt32("0"));
                int ret = objdut.ExecuteSqlSP(param, "usp_Addarea");
                if (ret > 0)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Successfully added information");
                    divall.Visible = false;
                    divgrid.Visible = true;
                    Button2.Visible = true;
                    divtop.Visible = true;
                    fillgridview();
                    reset();
                }
            }
            else if (btnAdd.Text == "Update")
            {
                SqlParameter[] param = new SqlParameter[6];
                param[0] = new SqlParameter("@mode", "updateArea");
                param[1] = new SqlParameter("@areaname", txtarea.Text.Trim());
                param[2] = new SqlParameter("@zonename", ddl_Busroot.SelectedItem.Text);
                param[3] = new SqlParameter("@zoneid", ddl_Busroot.SelectedValue);
                param[4] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                param[4].Direction = ParameterDirection.Output;
                //param[5] = new SqlParameter("@roadname", txtroad.Text);
                param[5] = new SqlParameter("@id", Convert.ToInt32(ViewState["id1"]));
                int ret = objdut.ExecuteSqlSP(param, "usp_Addarea");

                if (ret > 0)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Successfully Updted");
                    divall.Visible = false;
                    divgrid.Visible = true;
                    Button2.Visible = true;
                    divtop.Visible = true;
                    fillgridview();
                    reset();
                }
            }
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Error");
        }
    }

    public bool checkValidation()
    {
        if (ddl_Busroot.SelectedItem.Value == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select Zone .");
            return false;
        }
        else
            return true;
    }

    public void reset()
    {
        ddl_Busroot.SelectedIndex = 0;
        txtarea.Text = "";
        //txtroad.Text = "";
        btnAdd.Text = "Submit";
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        divtop.Visible = true;
        Button1.Visible = false;
        divall.Visible = false;
        divgrid.Visible = true;
        Button2.Visible = true;
    }

    protected void griview_addarea_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        string query = (string)ViewState["q"];
        griview_addarea.PageIndex = e.NewPageIndex;
        fillgrid(query);
    }

    private void fillgrid(string query)
    {
        DataTable dt = objdut.GetDataTable(query);

        if (dt.Rows.Count > 0)
        {
            griview_addarea.DataSource = dt;
            griview_addarea.DataBind();
        }
        else
        {
            griview_addarea.DataSource = null;
            griview_addarea.DataBind();
        }
    }

    protected void griview_addarea_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int areaid = Convert.ToInt32(e.CommandArgument);
        ViewState["id1"] = areaid;
        if (e.CommandName == "Edit1")
        {
            divall.Visible = true;
            divgrid.Visible = false;
            string query = "select Zoneid,areaname from tbl_addarea where areaid=" + areaid;
            SqlDataReader dr = objdut.GetDataReader(query);
            if (dr.HasRows)
            {
                dr.Read();
                ddl_Busroot.SelectedValue = dr["zoneid"].ToString();
                txtarea.Text = dr["areaname"].ToString();
                //txtroad.Text = dr["roadname"].ToString();
                dr.Close();
            }
            Button2.Visible = false;
            btnAdd.Text = "Update";
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        ddl_Busroot.SelectedValue = "0";
        txtarea.Text = "";
        divtop.Visible = false;
        Button1.Visible = true;
        divall.Visible = true;
        divgrid.Visible = false;
        // Button1.Visible = false;
        Button2.Visible = false;
    }
}