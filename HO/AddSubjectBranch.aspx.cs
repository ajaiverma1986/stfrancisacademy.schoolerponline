using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private string subjectname = string.Empty;
    private string subjectid = string.Empty;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private CommonClass clsobj = new CommonClass();
    private SqlParameter[] param1 = new SqlParameter[4];

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindSessionDDL();
            btnSubmit.Visible = false;
            FillDDl(0);
        }
    }

    protected void FillDDl(int ro)
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@ID", SqlDbType.Int);
        if (ro == 0)
        {
            param[0].Value = 0;
        }
        else
        {
            param[0].Value = ro;
        }
        param[1] = new SqlParameter("@master", SqlDbType.VarChar, 50);
        param[1].Value = "branch";
        DataTable dt = new DataTable();
        dt = objdut.GetMaster(param);
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string brcode = dt.Rows[i]["brCode"].ToString();
                string brname = dt.Rows[i]["brname"].ToString();
                string name = brcode + "--(" + brname + ")";
                string brid = dt.Rows[i]["brid"].ToString();
                ListItem li = new ListItem(name, brid);
                ddlbranch.Items.Add(li);
            }
        }
    }

    protected void ddlbranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@brid",ddlbranch.SelectedValue);
        param[2] = new SqlParameter("@fyid",ddlfyear.SelectedValue);
        dt = objdut.GetDataTableSP(param, "Usp_Class");
        if (dt.Rows.Count > 0)
        {
            DropDownList1.DataSource = dt;
            DropDownList1.DataTextField = "classname";
            DropDownList1.DataValueField = "classid";
            DropDownList1.DataBind();

            ListItem li = new ListItem("--Select Class--", "0");
            DropDownList1.Items.Insert(0, li);
        }
        else
        {
            dt.Dispose();
            dt.Clear();
            DropDownList1.DataSource = dt;
            DropDownList1.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            DropDownList1.Items.Insert(0, li);

            lblmsg.Text = "this branch has no class.";
            btnSubmit.Visible = false;
            tr2.Visible = false;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int count = 0;
        subjectname = "";
        subjectid = "";
        foreach (GridViewRow gvrow in grdBranch.Rows)
        {
            CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
            CheckBox chkmode = (CheckBox)gvrow.FindControl("chkmode");
            Label subjectname1 = (Label)gvrow.FindControl("lblsubject");
            HiddenField hd1 = (HiddenField)gvrow.FindControl("HD1");
            if (chkdelete.Checked)
            {
                count = count + 1;

                var hdfValue = hd1.Value;
                if (chkmode.Checked)
                    hdfValue = "1_" + Convert.ToString(hd1.Value);
                else
                    hdfValue = "0_" + Convert.ToString(hd1.Value);

                subjectname = subjectname + "," + subjectname1.Text;
                subjectid = subjectid + "," + hdfValue;
            }
        }
        if (count == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select atleast one Subject.");
            return;
        }
        subjectid = subjectid.Remove(0, 1);
        if (ddlbranch.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select Branch.");
            return;
        }
        param1[0] = new System.Data.SqlClient.SqlParameter("@brid", ddlbranch.SelectedValue);
        param1[1] = new System.Data.SqlClient.SqlParameter("@subjectid", subjectid);
        param1[2] = new System.Data.SqlClient.SqlParameter("@classid", DropDownList1.SelectedValue);
        param1[3] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param1[3].Direction = ParameterDirection.Output;

        int intresult = objdut.ExecuteSqlSP(param1, "addsubjectinbranch");
        if (intresult > 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Subject added successfully in the selected Branch.");
        }
    }

    protected void chkall_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvrow in grdBranch.Rows)
        {
            CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
            if (chkall.Checked)
            {
                chkdelete.Checked = true;
            }
            else
            {
                chkdelete.Checked = false;
            }
            btnSubmit.Visible = true;
        }
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable Dt = new DataTable();
        tr2.Visible = true;
        SqlParameter[] param=new SqlParameter[3];
        param[0] = new SqlParameter("@classid", DropDownList1.SelectedValue);
        param[1] = new SqlParameter("@brid", ddlbranch.SelectedValue);
        param[2] = new SqlParameter("@mode",4);
        Dt = objdut.GetDataTableSP(param, "Usp_Subject");
        if (Dt.Rows.Count > 0)
        {
            grdBranch.DataSource = Dt;
            grdBranch.DataBind();

            tr1.Visible = true;
            btnSubmit.Visible = true;
        }
        else
        {
            grdBranch.DataSource = null;
            grdBranch.DataBind();
            tr1.Visible = true;
            btnSubmit.Visible = false;
            if (DropDownList1.SelectedValue != "0")
            {
                lblmsg.Text = "please add subject in " + DropDownList1.SelectedItem.Text + " class";
            }
        }
    }
    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlfyear.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlfyear.DataValueField = "Fyid";
        ddlfyear.DataTextField = "FYName";
        ddlfyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }

    protected void chkMarkAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvrow in grdBranch.Rows)
        {
            CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkmode");
            if (chkMarkAll.Checked)
            {
                chkdelete.Checked = true;
            }
            else
            {
                chkdelete.Checked = false;
            }
            btnSubmit.Visible = true;
        }
    }
}