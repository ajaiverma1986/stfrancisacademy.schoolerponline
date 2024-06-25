using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class HO_feesSetting : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private Utility objut = new Utility();
    private DataUtility objDUT = new DataUtility();
    private CommonClass CommonClass = new CommonClass();
    private SqlParameter[] param = new SqlParameter[5];
    private string feeid = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        grddiv.Visible = false;
        ImageButton1.Visible = false;
        if (!IsPostBack)
        {
            fillBranch();
        }
    }

    public void fillBranch()
    {
        DDlBranch.DataSource = CommonClass.Dll("BranchDll");
        DDlBranch.DataTextField = "BrName";
        DDlBranch.DataValueField = "BrId";
        DDlBranch.DataBind();
        ListItem li = new ListItem("--Select Branch--", "0");
        DDlBranch.Items.Insert(0, li);
        ddlfinancialyear.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        ListItem liforallacedmicyear = new ListItem("-- Select Session--", "0");
        ddlfinancialyear.Items.Insert(0, liforallacedmicyear);
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
        ListItem liforclass = new ListItem("--Select Class--", "0");
        ddlClass.Items.Insert(0, liforclass);
    }

    #region addeventInRepeater

    public void addeventInRepeater()
    {
        string rpt1 = rptfeetype.ClientID;
        string chkpage = "chkpage";
        int rptModuleItemIndex = 0;
        foreach (RepeaterItem ri in rptfeetype.Controls)
        {
            if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
            {
                CheckBox chkmod = (CheckBox)ri.FindControl("chkmodule");
                Repeater rptForm1 = (Repeater)ri.FindControl("rptfeesubtype");
                int count = rptForm1.Items.Count;
                chkmod.Attributes.Add("onclick", "checkModule('" + rpt1 + "', " + count + ",'" + rptForm1.ClientID + "','" + chkmod.ClientID + "','" + chkpage + "');");
                int rptFormItemIndex = 0;
                foreach (RepeaterItem ri1 in rptForm1.Controls)
                {
                    if (ri1.ItemType == ListItemType.Item || ri1.ItemType == ListItemType.AlternatingItem)
                    {
                        string rpt2 = rptForm1.ClientID;
                        CheckBox chkp = (CheckBox)ri1.FindControl("chkpage");
                        chkp.Attributes.Add("onclick", "checkPage('" + rpt1 + "'," + rptModuleItemIndex + "," + rptFormItemIndex + ",'" + rptForm1.ClientID + "','" +                                       chkmod.ClientID + "','" + chkpage + "');");
                        rptFormItemIndex++;
                    }
                }
            }
            rptModuleItemIndex++;
        }
    }

    #endregion addeventInRepeater

    private void fillrepetor()
    {
        rptfeetype.DataSource = objDUT.GetDataTable("select feestructure.id,feestructure.Feename,isnull(classfee_master.Status,0)as status from feestructure left outer join classfee_master on classfee_master.Feeid=feestructure.id and classfee_master.Classid=" + ddlClass.SelectedValue + " and classfee_master.brid=" + DDlBranch.SelectedValue + "  where Feesubtype=0 and feestructure.status=1");
        rptfeetype.DataBind();
        addeventInRepeater();
    }
    protected void rptfeetype_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        DataTable dt = new DataTable();
        string moduleId = ((Label)e.Item.FindControl("lblModuleId")).Text;

        dt = objDUT.GetDataTable("select feestructure.id,feestructure.Feename,isnull(classfee_master.Status,0)as status from feestructure left outer join classfee_master on classfee_master.Feeid=feestructure.id and classfee_master.Classid=" + ddlClass.SelectedValue + " and classfee_master.brid=" + DDlBranch.SelectedValue + " where feestructure.status=1 and feestructure.fyid=" + ddlfinancialyear.SelectedValue + " and Feesubtype=" + moduleId);

        Repeater rptForm1 = (Repeater)e.Item.FindControl("rptfeesubtype");
        rptForm1.DataSource = dt;
        rptForm1.DataBind();
        dt.Dispose();
    }
    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlClass.SelectedValue != "0")
        {
            trdiv.Visible = true;
            if ((ddlClass.SelectedValue != "0") && (DDlBranch.SelectedValue != "0"))
            {
                lblmsg.Visible = false;
                grddiv.Visible = true;
                ImageButton1.Visible = true;
                fillrepetor();
            }
            else
            {
                ddlClass.SelectedValue = "0";
                Utility.ViewAlertMessage(Page, "Please select branch first.");
                DDlBranch.Focus();
                return;
            }
        }
        else
        {
            trdiv.Visible = false;
        }
    }
    protected void ImageButton1_Click(object sender, EventArgs e)
    {
        if (ddlfinancialyear.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(Page, "Select Session Please.");
            ddlfinancialyear.Focus();
            return;
        }
        if (DDlBranch.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(Page, "Select Branch Please.");
            DDlBranch.Focus();
            return;
        }
        if (ddlClass.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(Page, "Select Class Please.");
            ddlClass.Focus();
            return;
        }
        else
        {
            int count = 0;
            foreach (RepeaterItem ri in rptfeetype.Items)
            {
                if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chkmodule = (CheckBox)ri.FindControl("chkmodule");
                    if (chkmodule != null && chkmodule.Checked)
                    {
                        count++;
                        break;
                    }
                }
            }
            if (count <= 0)
            {
                Utility.ViewAlertMessage(Page, "Please select at least one fee type.");
            }
            else
            {
                foreach (RepeaterItem ri in rptfeetype.Items)
                {
                    if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
                    {
                        CheckBox chkmodule = (CheckBox)ri.FindControl("chkmodule");
                        Label lblmoduleid = (Label)ri.FindControl("lblmoduleid");
                        if (chkmodule.Checked)
                        {
                            feeid = feeid + "," + lblmoduleid.Text;
                        }
                        Repeater rptForm = (Repeater)ri.FindControl("rptfeesubtype");
                        foreach (RepeaterItem ri1 in rptForm.Items)
                        {
                            if (ri1.ItemType == ListItemType.Item || ri1.ItemType == ListItemType.AlternatingItem)
                            {
                                CheckBox chkpage = (CheckBox)ri1.FindControl("chkpage");
                                Label lblpageid = (Label)ri1.FindControl("lblpageid");
                                if (chkpage.Checked)
                                {
                                    feeid = feeid + "," + lblpageid.Text;
                                }
                            }
                        }
                    }
                }
                feeid = feeid.Remove(0, 1);
            }

            param[0] = new System.Data.SqlClient.SqlParameter("@classid", ddlClass.SelectedValue);
            param[1] = new System.Data.SqlClient.SqlParameter("@feeid", feeid);

            param[2] = new SqlParameter("@brid", DDlBranch.SelectedValue);
            param[3] = new SqlParameter("@intResult", Convert.ToInt32("0"));
            param[3].Direction = ParameterDirection.Output;
            param[4] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
            int intresult = objDUT.ExecuteSqlSP(param, "addfeestypeinclass");
            if (intresult == 1)
            {
                Utility.ViewAlertMessage(Page, "Fee Type Successfully Added To Selected Class.");
                DDlBranch.SelectedValue = "0";
                ddlClass.SelectedValue = "0";
                Session.Remove("RootNode");
                Session.Remove("Page");
            }
            else
            {
                Utility.ViewAlertMessage(Page, "Error while saving the record.");
            }
            trdiv.Visible = false;
        }
    }
    protected void DDlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DDlBranch.SelectedValue != "0")
        {
            string query = "select classid,Class_Master.Classname from ClassBranch_master inner join Class_Master on Class_Master.id = ClassBranch_master.classid " +
                " where BranchId=" + DDlBranch.SelectedValue + " and ClassBranch_master.Status=1 and ClassBranch_master.fyid=" + ddlfinancialyear.SelectedValue + "";
            DataTable dt = objDUT.GetDataTable(query);
            if (dt.Rows.Count > 0)
            {
                ddlClass.DataSource = dt;
                ddlClass.DataTextField = "Classname";
                ddlClass.DataValueField = "classid";
                ddlClass.DataBind();
                ListItem li = new ListItem("--Select Class--", "0");
                ddlClass.Items.Insert(0, li);
            }
            else
            {
                dt.Dispose();
                dt.Clear();
                ddlClass.DataSource = dt;
                ddlClass.DataBind();
                ListItem li = new ListItem("--Select Class--", "0");
                ddlClass.Items.Insert(0, li);
                lblmsg.Text = "this branch has no class.";
                grddiv.Visible = false;
                trdiv.Visible = false;
                ImageButton1.Visible = false;
            }
        }
        else
        {
            ddlClass.Items.Clear();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlClass.Items.Insert(0, li);
            ddlClass.SelectedValue = "0";
            trdiv.Visible = false;
        }
    }
    protected void ddlfinancialyear_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DDlBranch.SelectedValue != "0")
        {
            string query = "select classid,Classname from ClassBranch_master where BranchId=" + DDlBranch.SelectedValue + " and Status=1 and classid in (select id from Class_Master where Status=1 and fyid=" + ddlfinancialyear.SelectedValue + ")";
            DataTable dt = objDUT.GetDataTable(query);
            if (dt.Rows.Count > 0)
            {
                ddlClass.DataSource = dt;
                ddlClass.DataTextField = "Classname";
                ddlClass.DataValueField = "classid";
                ddlClass.DataBind();
                ListItem li = new ListItem("--Select Class--", "0");
                ddlClass.Items.Insert(0, li);
            }
            else
            {
                dt.Dispose();
                dt.Clear();
                ddlClass.DataSource = dt;
                ddlClass.DataBind();
                ListItem li = new ListItem("--Select Class--", "0");
                ddlClass.Items.Insert(0, li);
                lblmsg.Text = "this branch has no class.";
                grddiv.Visible = false;
                trdiv.Visible = false;
                ImageButton1.Visible = false;
            }
        }
        else
        {
            ddlClass.Items.Clear();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlClass.Items.Insert(0, li);
            ddlClass.SelectedValue = "0";
            trdiv.Visible = false;
        }
    }
}