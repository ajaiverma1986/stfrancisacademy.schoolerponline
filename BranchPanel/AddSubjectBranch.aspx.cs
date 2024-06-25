using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_AddSubjectBranch : System.Web.UI.Page
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
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        // PageName = Utility.GetCurrentPagename();
        tr1.Visible = false;
        btnSubmit.Visible = false;
        if (!IsPostBack)
        {
            //FillDDl(0);
            l1.Visible = false;
            fillClass();
            BindSessionDDL();
        }
    }

    
    protected void ddlbranch_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int count = 0;
        subjectname = "";
        subjectid = "";
        foreach (GridViewRow gvrow in grdBranch.Rows)
        {
            CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
            Label subjectname1 = (Label)gvrow.FindControl("lblsubject");
            HiddenField hd1 = (HiddenField)gvrow.FindControl("HD1");
            if (chkdelete.Checked)
            {
                count = count + 1;
                subjectname = subjectname + "," + subjectname1.Text;
                subjectid = subjectid + "," + hd1.Value;
                // subjectid = hd1.Value + ",";
            }
        }
        if (count == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select atleast one Subject.");
            //lblmsg.Text = "please select atleast one Subject.";
            return;
        }
        subjectid = subjectid.Remove(0, 1);
        //if (ddlbranch.SelectedValue == "0")
        //{
        //    Utility.ViewAlertMessage(this.Master.Page, "Please select Branch.");
        //    //lblmsg.Text = "please select Branch.";
        //    return;
        //}
        param1[0] = new System.Data.SqlClient.SqlParameter("@brid", Session["BrBrid"]);
        param1[1] = new System.Data.SqlClient.SqlParameter("@subjectid", subjectid);
        param1[2] = new System.Data.SqlClient.SqlParameter("@classid", DropDownList1.SelectedValue);
        param1[3] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param1[3].Direction = ParameterDirection.Output;
        int intresult = objdut.ExecuteSqlSP(param1, "addsubjectinbranch");
        if (intresult > 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Subject added successfully in the selected Branch.");
            return;
            //lblmsg.Text = "Subject added successfully in the selected Branch";
        }
    }

    protected void chkall_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvrow in grdBranch.Rows)
        {
            //Finiding checkbox control in gridview for particular row
            CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
            if (chkall.Checked)
            {
                chkdelete.Checked = true;
            }
            else
            {
                chkdelete.Checked = false;
            }
            tr1.Visible = true;
            btnSubmit.Visible = true;
        }
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        chkall.Checked = false;
        string query = "select COUNT(*) from classsubject_master where classid=" + DropDownList1.SelectedValue + " and status=1";
        int count = Convert.ToInt32(objdut.GetScalar(query));
        if (count == 0)
        {
            grdBranch.DataSource = null;
            grdBranch.DataBind();
            btnSubmit.Visible = false;
            tr1.Visible = false;
            lblmsg.Text = "Please add subject in " + DropDownList1.SelectedItem.Text + " class.";
            return;
        }
        string str = @"select sm.id,sm.SubjectName,isnull(sbm.Status,0)as status from Subject_Master sm left outer join
                       classsubject_master csm on csm.subjectid=sm.id and csm.classid=" + DropDownList1.SelectedValue + " left outer join SubjectBranch_master sbm on sm.id=sbm.Subjectid and csm.classid=sbm.classid and sbm.BranchId=" + Session["BrBrid"] + " where sm.Status=1 ";
        string str1 = @"select sm.id,sm.SubjectName,isnull(sbm.Status,0)as status from Subject_Master sm left outer join
                       classsubject_master csm on csm.subjectid=sm.id and csm.classid=" + DropDownList1.SelectedValue + " left outer join SubjectBranch_master sbm on sm.id=sbm.Subjectid and csm.classid=sbm.classid and sbm.BranchId=" + Session["BrBrid"] + " where sm.Status=1 and csm.classid=" + DropDownList1.SelectedValue;
        DataTable dt = objdut.GetDataTable(str1);
        if (dt.Rows.Count > 0)
        {
            grdBranch.DataSource = dt;
            grdBranch.DataBind();
            tr1.Visible = true;
            btnSubmit.Visible = true;
        }
        else
        {
            grdBranch.DataSource = null;
            grdBranch.DataBind();
            tr1.Visible = false;
            btnSubmit.Visible = false;
            if (DropDownList1.SelectedValue != "0")
            {
                lblmsg.Text = "Please add subject in " + DropDownList1.SelectedItem.Text + " class.";
                return;
            }
        }
    }
    
    protected void fillClass()
    {
        string query = "select classid,Classname from ClassBranch_master where BranchId=" + Session["BrBrid"] + " and Status=1 and classid in (select id from Class_Master where Status=1)";
        DataTable dt = objdut.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            DropDownList1.DataSource = dt;
            DropDownList1.DataTextField = "Classname";
            DropDownList1.DataValueField = "classid";
            DropDownList1.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            DropDownList1.Items.Insert(0, li);
            //tr1.Visible = true;
            // btnSubmit.Visible = true;
        }
        else
        {
            dt.Dispose();
            dt.Clear();
            DropDownList1.DataSource = dt;
            DropDownList1.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            DropDownList1.Items.Insert(0, li);
            lblmsg.Text = "This branch has no class.";
            btnSubmit.Visible = false;
            tr1.Visible = false;
        }
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        Response.Redirect("AddSubjectBranch.aspx");
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
}