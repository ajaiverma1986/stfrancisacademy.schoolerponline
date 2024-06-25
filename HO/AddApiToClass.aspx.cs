using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class HO_AddApiToClass : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private string Classname = string.Empty;
    private string classid = string.Empty;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private CommonClass clsobj = new CommonClass();
    private CommonClass CommonClass = new CommonClass();
    private SqlParameter[] param1 = new SqlParameter[3];
    protected void Page_Load(object sender, EventArgs e)
    {
        btnSubmit.Visible = false;
        if (!IsPostBack)
        {
            fillfyear();
            fillbranch();
        }
    }
    public void fillfyear()
    {
        DataTable Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    private void fillbranch()
    {
        string str = "Select smsapiid,sms_api,status,api_type,Brid from tbl_smsapisetting";
        DataTable dt = objdut.GetDataTable(str);
        if (dt.Rows.Count > 0)
        {
            grdAPI.DataSource = dt;
            grdAPI.DataBind();
        }
    }

    protected void grdAPI_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        tr2.Visible = true;
        int smsapiid = Convert.ToInt32(e.CommandArgument);
        ViewState["smsapiid"] = smsapiid;
        foreach (GridViewRow grv in grdAPI.Rows)
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
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@mode", 12);
            param[1] = new SqlParameter("@ApiID", ViewState["smsapiid"]);
            param[2] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
            DataTable dt44 = objdut.GetDataTableSP(param, "Usp_Class");
            if (dt44.Rows.Count > 0)
            {
                lnk.Visible = true;
                grdclass.DataSource = dt44;
                grdclass.DataBind();
                divforfy.Style.Add("display", "block");
                btnSubmit.Visible = false;
                foreach (GridViewRow gvrow in grdclass.Rows)
                {
                    CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass1");
                    chkdelete.Enabled = false;
                }
            }
            else
            {
                grdclass.DataSource = null;
                grdclass.DataBind();
                btnSubmit.Visible = false;
            }
            if (e.CommandName == "c2")
            {
            }
        }
    }
    protected void GetClass()
    {
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 12);
        param[1] = new SqlParameter("@ApiID", ViewState["smsapiid"]);
        param[2] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
        DataTable dt = new DataTable();
        dt = objdut.GetDataTableSP(param, "Usp_Class");
        if (dt.Rows.Count > 0)
        {
            grdclass.DataSource = dt;
            grdclass.DataBind();
            grdclass.Visible = true;
            btnSubmit.Visible = true;
        }
        else
        {
            grdclass.DataSource = null;
            grdclass.DataBind();
            grdclass.Visible = true;
            btnSubmit.Visible = true;
        }
    }
    protected void lnk_Click(object sender, EventArgs e)
    {
        GetClass();
    }

    protected void btnSubmit_Click1(object sender, EventArgs e)
    {
        int count = 0;
        Classname = "";
        classid = "";
        foreach (GridViewRow gvrow in grdclass.Rows)
        {
            CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass1");
            Label classname = (Label)gvrow.FindControl("lblsubject123");
            HiddenField hd1 = (HiddenField)gvrow.FindControl("HD12");
            if (chkdelete.Checked)
            {
                count = count + 1;

                Classname = Classname + "," + classname.Text;
                classid = classid + "," + hd1.Value;
            }
        }
        if (count == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select atleast one Class.");
            btnSubmit.Visible = true;
            return;
        }
        classid = classid.Remove(0, 1);
        SqlParameter[] param = new SqlParameter[5];
        param[0] = new System.Data.SqlClient.SqlParameter("@ApiID", Convert.ToInt32(ViewState["smsapiid"]));
        param[1] = new System.Data.SqlClient.SqlParameter("@classid", classid);
        param[2] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[2].Direction = ParameterDirection.Output;
        param[3] = new SqlParameter("@userid", Session["ADID"]);
        param[4] = new SqlParameter("@Fyid", ddlfinancialyear.SelectedValue);
        int intresult = objdut.ExecuteSqlSP(param, "addApiToClass");

        if (intresult > 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Class added successfully in the selected Branch.");
            grdclass.DataSource = null;
            grdclass.DataBind();
            btnSubmit.Visible = false;
            divforfy.Style.Add("display", "none");
            tr2.Visible = false;
        }
    }
    protected void ddlfinancialyear_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetClass();
    }
}