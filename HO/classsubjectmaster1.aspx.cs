using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HO_classsubjectmaster1 : System.Web.UI.Page
{
    private DataTable dt;
    private string url;
    private string PageName, str;
    private string subjectname = string.Empty;
    private string subjectid = string.Empty;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private CommonClass clsobj = new CommonClass();
    
    private CommonClass CommonClass = new CommonClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["User"] == null)
        {
        }

        btnSubmit.Visible = false;
        if (!IsPostBack)
        {
            fillfyear();
            fillgrid();
        }
    }
    public void fillfyear()
    {
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }


    private void fillgrid()
    {
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 5);
        param[1] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
        dt = objdut.GetDataTableSP(param, "Usp_Class");
        if (dt.Rows.Count > 0)
        {
            DataView view = new DataView(dt);
            DataTable dtClass = view.ToTable(true, "Classname", "id");
            grdBranch.DataSource = dtClass;
            grdBranch.DataBind();
        }
    }

    protected void grdBranch_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        tr2.Visible = true;
        int classid = Convert.ToInt32(e.CommandArgument);
        ViewState["class"] = classid;

        foreach (GridViewRow grv in grdBranch.Rows)
        {
            LinkButton lbClass1 = (LinkButton)grv.FindControl("lblsubject");
            LinkButton lbEdit1 = (LinkButton)grv.FindControl("lblsubject22");
            lnk.Visible = true;
            lnk = lbEdit1;

            lbClass1.ForeColor = System.Drawing.Color.Blue;
            lnk.ForeColor = System.Drawing.Color.Blue;
        }
        if (e.CommandName == "c1")
        {
            GridViewRow gvrow2 = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            LinkButton lbClass = (LinkButton)gvrow2.FindControl("lblsubject");
            LinkButton lbEdit = (LinkButton)gvrow2.FindControl("lblsubject22");
            lbClass.ForeColor = System.Drawing.Color.Green;
            lbEdit.ForeColor = System.Drawing.Color.Green;
            lnk = lbEdit;
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@mode", 2);
            param[1] = new SqlParameter("@classid", ViewState["class"]);
            ds = objdut.GetDataSetSP(param, "Usp_Subject");
            if (ds.Tables[0].Rows.Count > 0)
            {
                lnk.Visible = true;
                grdsubject.DataSource = ds.Tables[0];
                grdsubject.DataBind();
                btnSubmit.Visible = false;
                foreach (GridViewRow gvrow in grdsubject.Rows)
                {
                    CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
                    chkdelete.Enabled = false;
                }
            }
            else
            {
                grdsubject.DataSource = null;
                grdsubject.DataBind();
                btnSubmit.Visible = false;
            }
            if (ds.Tables[1].Rows.Count > 0)
            {
                gridoptionalsubject.DataSource = ds.Tables[1];
                gridoptionalsubject.DataBind();
                btnSubmit.Visible = false;
                foreach (GridViewRow gvrow in gridoptionalsubject.Rows)
                {
                    CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
                    chkdelete.Enabled = false;
                }
            }
            else
            {
                gridoptionalsubject.DataSource = null;
                gridoptionalsubject.DataBind();
                btnSubmit.Visible = true;
            }
        }
        if (e.CommandName == "c2")
        {
        }
    }

    protected void lnk_Click(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@classid", ViewState["class"]);
        ds = objdut.GetDataSetSP(param, "Usp_Subject");
        if (ds.Tables[0].Rows.Count > 0)
        {
            grdsubject.DataSource = ds.Tables[0];
            grdsubject.DataBind();
            btnSubmit.Visible = true;
        }
        else
        {
            grdsubject.DataSource = null;
            grdsubject.DataBind();
            btnSubmit.Visible = true;
        }
        if (ds.Tables[1].Rows.Count > 0)
        {
            gridoptionalsubject.DataSource = ds.Tables[1];
            gridoptionalsubject.DataBind();
            btnSubmit.Visible = true;
        }
        else
        {
            gridoptionalsubject.DataSource = null;
            gridoptionalsubject.DataBind();
            btnSubmit.Visible = true;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int count = 0;
        subjectname = "";
        subjectid = "";
        SqlParameter[] param1 = new SqlParameter[4];
        foreach (GridViewRow gvrow in grdsubject.Rows)
        {
            CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
            Label subjectname1 = (Label)gvrow.FindControl("lblsubject123");
            HiddenField hd1 = (HiddenField)gvrow.FindControl("HD12");
            if (chkdelete.Checked)
            {
                count = count + 1;
                subjectname = subjectname + "," + subjectname1.Text;
                subjectid = subjectid + "," + hd1.Value;
            }
        }
        foreach (GridViewRow gvrow in gridoptionalsubject.Rows)
        {
            CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
            Label subjectname1 = (Label)gvrow.FindControl("lblsubject123");
            HiddenField hd1 = (HiddenField)gvrow.FindControl("HD12");
            if (chkdelete.Checked)
            {
                subjectname = subjectname + "," + subjectname1.Text;
                subjectid = subjectid + "," + hd1.Value;
            }
        }
        if (count == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select atleast one Subject.");

            btnSubmit.Visible = true;
            return;
        }
        subjectid = subjectid.Remove(0, 1);

        param1[0] = new System.Data.SqlClient.SqlParameter("@classid", Convert.ToInt32(ViewState["class"]));
        param1[1] = new System.Data.SqlClient.SqlParameter("@subjectid", subjectid);

        param1[2] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param1[2].Direction = ParameterDirection.Output;
        param1[3] = new SqlParameter("@Userid",Session["ADID"]);
        int intresult = objdut.ExecuteSqlSP(param1, "addsubjectinclass");
        if (intresult > 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Subject added successfully in the selected Class.");
            grdsubject.DataSource = null;
            grdsubject.DataBind();
            btnSubmit.Visible = false;
            tr2.Visible = false;
        }
    }
    protected void ddlfinancialyear_SelectedIndexChanged(object sender, EventArgs e)
    {
        grdsubject.DataSource = null;
        grdsubject.DataBind();
        btnSubmit.Visible = false;
        tr2.Visible = false;
        fillgrid();
    }
}