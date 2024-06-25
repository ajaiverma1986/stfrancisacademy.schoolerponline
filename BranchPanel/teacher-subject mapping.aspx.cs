using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_teacher_subject_mapping : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();
    private DataTable dt, dt1;
    private int count1 = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillDepartMent();
        }
    }

    private void fillDepartMent()
    {
        string query = " select eid,(Title + ' ' + fname + ' '+ mname + ' ' +lname) as name from tblEmp_Master where brid=1 and desigtype=1 and departmentid=2 and status=1";
        dt = objDUT.GetDataTable(query);

        if (dt.Rows.Count > 0)
        {
            ddlteacher.DataSource = dt;
            ddlteacher.DataTextField = "name";
            ddlteacher.DataValueField = "eid";

            ddlteacher.DataBind();
            ListItem li = new ListItem("--Teacher--", "0");
            ddlteacher.Items.Insert(0, li);
        }
    }

    private void bindsubjectforteacher()
    {
        dt1 = new DataTable();
        dt1 = objDUT.GetDataTable(@"select sbm.classname, sbm.classid,cast(isnull(tsm.status,0)as bit) as status
            from ClassBranch_master sbm left outer join tblTeacherSubjectMapping tsm on tsm.brid=sbm.branchid
            and tsm.eid=" + ddlteacher.SelectedValue + "  where sbm.BranchId=" + Convert.ToInt32(Session["BrBrid"]) + "  group by sbm.classid,sbm.classname,tsm.status");
        if (dt1.Rows.Count == 0)
        {
            lbl.Text = "No class and subject is not create";
        }
        rptModule.DataSource = dt1;
        rptModule.DataBind();
        addeventInRepeater();
    }

    #region addeventInRepeater

    public void addeventInRepeater()
    {
        string rpt1 = rptModule.ClientID;
        string chkpage = "chkpage";
        int rptModuleItemIndex = 0;
        foreach (RepeaterItem ri in rptModule.Controls)
        {
            if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
            {
                CheckBox chkmod = (CheckBox)ri.FindControl("chkmodule");
                Repeater rptForm1 = (Repeater)ri.FindControl("rptForm");
                int count = rptForm1.Items.Count;
                chkmod.Attributes.Add("onclick", "checkModule('" + rpt1 + "', " + count + ",'" + rptForm1.ClientID + "','" + chkmod.ClientID + "','" + chkpage + "');");
                int rptFormItemIndex = 0;
                foreach (RepeaterItem ri1 in rptForm1.Controls)
                {
                    if (ri1.ItemType == ListItemType.Item || ri1.ItemType == ListItemType.AlternatingItem)
                    {
                        string rpt2 = rptForm1.ClientID;
                        CheckBox chkp = (CheckBox)ri1.FindControl("chkpage");
                        chkp.Attributes.Add("onclick", "checkPage('" + rpt1 + "'," + rptModuleItemIndex + "," + rptFormItemIndex + ",'" + rptForm1.ClientID + "','" + chkmod.ClientID + "','" + chkpage + "');");
                        rptFormItemIndex++;
                    }
                }
            }
            rptModuleItemIndex++;
        }
    }

    #endregion addeventInRepeater

    #region "rptModule_ItemDataBound"

    protected void rptModule_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Label l = e.Item.FindControl("lblModuleId") as Label;
        CheckBox l1 = e.Item.FindControl("chkmodule") as CheckBox;

        DataTable dt2 = new DataTable();

        dt2 = objDUT.GetDataTable(@"select sbm.Subjectname,sbm.Subjectid,cast(isnull(tsm.status,0)as bit) as status
    from SubjectBranch_master sbm left outer join tblTeacherSubjectMapping tsm on tsm.brid=sbm.branchid and tsm.classID=sbm.classid
    and tsm.eid=" + ddlteacher.SelectedValue + "  where sbm.BranchId=" + Session["BrBrid"] + " and sbm.classid=" + l.Text + "  group by sbm.Subjectid,sbm.Subjectname,tsm.status");

        if (dt2.Rows.Count > 0)
        {
            Repeater rptForm1 = (Repeater)e.Item.FindControl("rptForm");
            rptForm1.DataSource = dt2;
            rptForm1.DataBind();
            dt2.Dispose();
        }
        else
        {
            l1.Checked = false;
        }
    }

    #endregion "rptModule_ItemDataBound"

    private bool sendclassandsubject()
    {
        try
        {
            string fullstring = string.Empty;
            int count = 0;
            foreach (RepeaterItem ri in rptModule.Items)
            {
                if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chkmodule = (CheckBox)ri.FindControl("chkmodule");
                    Repeater rptForm = (Repeater)ri.FindControl("rptForm");
                    if (chkmodule != null && chkmodule.Checked)
                    {
                        foreach (RepeaterItem ri1 in rptForm.Items)
                        {
                            CheckBox chkpage = (CheckBox)ri1.FindControl("chkpage");
                            if (ri1.ItemType == ListItemType.Item || ri1.ItemType == ListItemType.AlternatingItem)
                            {
                                if (chkpage != null && chkpage.Checked)
                                {
                                    count1++;
                                }
                            }
                        }
                        if (count1 == 0)
                        {
                            Utility.ViewAlertMessage(Page, "Please select atleast one subject of perticular class");
                            return false;
                        }
                        count1 = 0;

                        count++;
                    }

                    if (chkmodule == null && !chkmodule.Checked)
                    {
                        foreach (RepeaterItem ri1 in rptForm.Items)
                        {
                            CheckBox chkpage = (CheckBox)ri1.FindControl("chkpage");
                            if (ri1.ItemType == ListItemType.Item || ri1.ItemType == ListItemType.AlternatingItem)
                            {
                                if (chkpage != null && chkpage.Checked)
                                {
                                    Utility.ViewAlertMessage(Page, "Please First Select Class then Select Subject");
                                    return false;
                                }
                            }
                        }
                    }
                }
            }
            if (count <= 0)
            {
                Utility.ViewAlertMessage(Page, "Please Select At Least One class .");
                return false;
            }

            foreach (RepeaterItem ri in rptModule.Items)
            {
                if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chkmodule = (CheckBox)ri.FindControl("chkmodule");
                    Repeater rptForm = (Repeater)ri.FindControl("rptForm");

                    Label lblclassid = (Label)ri.FindControl("lblModuleId");
                    if (chkmodule != null && chkmodule.Checked)
                    {
                        fullstring = fullstring + lblclassid.Text;

                        foreach (RepeaterItem ri1 in rptForm.Items)
                        {
                            CheckBox chkpage = (CheckBox)ri1.FindControl("chkpage");
                            Label lblsubjectid = (Label)ri1.FindControl("lblpageid");
                            if (chkpage != null && chkpage.Checked)
                            {
                                fullstring = fullstring + "/" + lblsubjectid.Text;
                            }
                        }

                        fullstring = fullstring + ",";
                    }
                }
            }

            if (fullstring != null)
            {
                int fullen = fullstring.Length;
                fullstring = fullstring.Remove(fullen - 1, 1);

                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@brid", Session["BrBrid"]);
                param[1] = new SqlParameter("@fullstring", fullstring);
                param[2] = new SqlParameter("@intresult", SqlDbType.Int);
                param[2].Direction = ParameterDirection.Output;
                param[3] = new SqlParameter("@eid", ddlteacher.SelectedValue);

                int result = objDUT.ExecuteSqlSP(param, "sp_subjectforteacher");
            }

            return true;
        }
        catch (Exception ex)
        {
            Utility.ViewAlertMessage(Page, "Some Error .");
            return false;
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (ddlteacher.SelectedIndex > 0)
        {
            if (!sendclassandsubject())
            {
                return;
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "Recod save successfully.!!");
            }
        }
    }

    protected void ddlteacher_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindsubjectforteacher();
    }
}