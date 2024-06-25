using BusinessObjects.Entity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

//using Regular.Common;

public partial class ModulePermission : System.Web.UI.Page
{
    private string PageName;
    private Utility objut = new Utility();

    #region Global Veriable

    //CommonManger objCommonManager = new CommonManger();
    private DataUtility objDUT = new DataUtility();

    private DataTable dsUserListRightData = new DataTable();
    private List<Right> ListRight = new List<Right>();
    private DataSet dsPageData = new DataSet();
    private string url;

    #endregion Global Veriable

    #region Page_Load

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        //PageName = Utility.GetCurrentPagename();

        //if (!objut.isAccessible(((User)Session["BrUser"]).UserID, PageName))
        //{
        //    Response.Redirect("~/Login.aspx");
        //}
        this.Page.Title = ConfigurationManager.AppSettings["titleBar"];

        if (!IsPostBack)
        {
            trRO.Visible = false;
            binduserrole();
        }
    }

    #endregion Page_Load

    #region

    protected void binduserrole()
    {
        if (dropUserGroup.SelectedIndex > 0)
        {
            ViewState["ATOID"] = dropUserGroup.SelectedValue;
            ddlRole.DataTextField = "RoleName";
            ddlRole.DataValueField = "rid";
            ddlRole.DataSource = objDUT.GetDataTable("select RoleName,rid from tblrole where IsActive=1 and IsDeleted=0 and associatedToID=" + dropUserGroup.SelectedValue + " order by roleid");
            ddlRole.DataBind();
            ListItem li = new ListItem("--Select--", "0");
            ddlRole.Items.Insert(0, li);

            if (dropUserGroup.SelectedValue == "101")
            {
                bindRO(0);
                trRO.Visible = false;
                ViewState["brnchid"] = Session["BrBrid"];
            }
            else
            {
                ViewState["brnchid"] = Session["BrBrid"];
                trRO.Visible = false;
            }
        }
        else
        {
            ddlRole.DataSource = null;
            ddlRole.DataBind();
            ListItem li = new ListItem("--Select--", "0");
            ddlRole.Items.Insert(0, li);
        }
    }

    #endregion

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

    #endregion

    #region BindModuleDatalist

    private void BindModuleDatalist(int userGroup)
    {
        //rptModule.DataSource = objCommonManager.GetTableWithParameter("[uspModulePermission]", "@userid", ddlUserName.SelectedValue.ToString(), "@QueryType", "GetAllModule");

        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@userid", SqlDbType.BigInt);
        param[0].Value = Convert.ToInt64(ddlUserName.SelectedValue);
        param[1] = new SqlParameter("@QueryType", SqlDbType.VarChar, 50);
        param[1].Value = "GetAllModule";
        param[2] = new SqlParameter("@associatedToID", SqlDbType.Int);
        param[2].Value = userGroup;

        rptModule.DataSource = objDUT.GetDataTableSP(param, "uspModulePermission");
        rptModule.DataBind();
        addeventInRepeater();
    }

    #endregion

    #region ddlUserName_SelectedIndexChanged

    protected void ddlUserName_SelectedIndexChanged(object sender, EventArgs e)
    {
        grddiv.Visible = true;
        rptModule.Visible = true;
        chkGroupPermission.Checked = false;
        BindModuleDatalist(int.Parse(dropUserGroup.SelectedValue));
        div1.Visible = true;
    }

    #endregion

    #region "rptModule_ItemDataBound"

    protected void rptModule_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        DataTable dt = new DataTable();
        string moduleId = ((Label)e.Item.FindControl("lblModuleId")).Text;
        Label1.Text = Label1.Text + ",";
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@userid", SqlDbType.BigInt);
        param[0].Value = Convert.ToInt64(ddlUserName.SelectedValue);
        param[1] = new SqlParameter("@moduleid", SqlDbType.VarChar, 50);
        param[1].Value = moduleId;
        param[2] = new SqlParameter("@QueryType", SqlDbType.VarChar, 50);
        param[2].Value = "GetAllPage";

        dt = objDUT.GetDataTableSP(param, "uspModulePermission");

        Repeater rptForm1 = (Repeater)e.Item.FindControl("rptForm");
        rptForm1.DataSource = dt;
        rptForm1.DataBind();
        dt.Dispose();
    }

    #endregion

    #region imgSubmit_Click

    protected void imgSubmit_Click(object sender, EventArgs e)
    {
        if ((ddlUserName.SelectedIndex == 0) && (chkGroupPermission.Checked == false))
        {
            Utility.ViewAlertMessage(Page, "Please Select User Name First.");
        }
        else if (((ddlUserName.SelectedIndex == 0) && (chkGroupPermission.Checked == true)) || ((ddlUserName.SelectedIndex != 0) && (chkGroupPermission.Checked == false)))
        {
            int count = 0;
            foreach (RepeaterItem ri in rptModule.Items)
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
                Utility.ViewAlertMessage(Page, "Please Select At Least One Module To Assign Permission.");
            }
            else
            {
                MenuManager objRightManager = new MenuManager();
                foreach (RepeaterItem ri in rptModule.Items)
                {
                    Right objright = new Right();
                    if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
                    {
                        CheckBox chkmodule = (CheckBox)ri.FindControl("chkmodule");
                        Label lblmoduleid = (Label)ri.FindControl("lblmoduleid");
                        Repeater rptForm = (Repeater)ri.FindControl("rptForm");
                        objright.ModuleId = Int16.Parse(lblmoduleid.Text.Trim());
                        objright.UserId = Int16.Parse(ddlUserName.SelectedValue.Trim());
                        objright.IsActive = chkmodule.Checked;
                        ListRight.Add(objright);
                        foreach (RepeaterItem ri1 in rptForm.Items)
                        {
                            objright = new Right();
                            if (ri1.ItemType == ListItemType.Item || ri1.ItemType == ListItemType.AlternatingItem)
                            {
                                CheckBox chkpage = (CheckBox)ri1.FindControl("chkpage");
                                Label lblpageid = (Label)ri1.FindControl("lblpageid");
                                objright.ModuleId = Int16.Parse(lblpageid.Text.Trim());
                                objright.UserId = Int16.Parse(ddlUserName.SelectedValue.Trim());
                                objright.IsActive = chkpage.Checked;
                                ListRight.Add(objright);
                            }
                        }
                    }
                }
                int returnedStudentID = objRightManager.SaveRightInformation(ListRight);
                if (returnedStudentID == 0)
                {
                    Utility.ViewAlertMessage(Page, "Record Save Successfully.");
                    Session.Remove("RootNode");
                    Session.Remove("Page");
                }
                else
                {
                    Utility.ViewAlertMessage(Page, "Error while saving the record.");
                }
                UncheckAll();
            }
        }
    }

    #endregion

    #region chkGroupPermission_CheckedChanged

    protected void chkGroupPermission_CheckedChanged(object sender, EventArgs e)
    {
        if (chkGroupPermission.Checked == true)
        {
            ddlUserName.SelectedIndex = 0;
            Utility.ViewAlertMessage(Page, "You are going to give permission to particular module to all user.");
            BindModuleDatalist(int.Parse(dropUserGroup.SelectedValue));
        }
    }

    #endregion

    #region UncheckAll

    private void UncheckAll()
    {
        foreach (RepeaterItem ri in rptModule.Items)
        {
            if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
            {
                CheckBox chkmodule = (CheckBox)ri.FindControl("chkmodule");
                Repeater rptForm = (Repeater)ri.FindControl("rptForm");
                if (chkmodule != null && chkmodule.Checked)
                {
                    chkmodule.Checked = false;
                    foreach (RepeaterItem ri1 in rptForm.Items)
                    {
                        if (ri1.ItemType == ListItemType.Item || ri1.ItemType == ListItemType.AlternatingItem)
                        {
                            CheckBox chkpage = (CheckBox)ri1.FindControl("chkpage");
                            if (chkpage != null && chkpage.Checked)
                            {
                                chkpage.Checked = false;
                            }
                        }
                    }
                }
            }
        }
        if (ddlUserName.SelectedIndex != 0)
        {
            ddlUserName.SelectedIndex = 0;
        }
        if (chkGroupPermission.Checked == true)
        {
            chkGroupPermission.Checked = false;
        }
    }

    #endregion

    #region imgClear_Click

    protected void imgClear_Click(object sender, EventArgs e)
    {
        UncheckAll();
    }

    #endregion
    #region UserSelectionChanges

    protected void dropUserGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (dropUserGroup.SelectedIndex > 0)
        {
            ViewState["ATOID"] = dropUserGroup.SelectedValue;
            ddlRole.DataTextField = "RoleName";
            ddlRole.DataValueField = "rid";
            ddlRole.DataSource = objDUT.GetDataTable("select RoleName,rid from tblrole where IsActive=1 and IsDeleted=0 and associatedToID=" + dropUserGroup.SelectedValue + "");
            ddlRole.DataBind();
            ListItem li = new ListItem("--Select--", "0");
            ddlRole.Items.Insert(0, li);

            if (dropUserGroup.SelectedValue == "101")
            {
                bindRO(0);
                trRO.Visible = true;
            }
            else
            {
                ViewState["brnchid"] = Session["BrBrid"];
                trRO.Visible = false;
            }
        }
        else
        {
            ddlRole.DataSource = null;
            ddlRole.DataBind();
            ListItem li = new ListItem("--Select--", "0");
            ddlRole.Items.Insert(0, li);
        }
    }

    #endregion

    protected void ddlRole_SelectedIndexChanged(object sender, EventArgs e)
    {
        rptModule.Visible = false;
        if (Convert.ToInt32(ViewState["brnchid"]) > 0)
        {
            ddlUserName.DataTextField = "UserName";
            ddlUserName.DataValueField = "UserId";
            ddlUserName.DataSource = objDUT.GetDataTable("select tu.username,tu.userid,tu.roleid,tu.eid,te.brid from tblemployee te left outer join  tbluser tu on tu.eid=te.eid where te.brid=" + ViewState["brnchid"] + " and te.IsActive=1 and te.IsDeleted = 0 and te.associatedToID=" + ViewState["ATOID"] + " and RoleId =" + ddlRole.SelectedValue + "");
            ddlUserName.DataBind();
            ListItem li = new ListItem("--Select--", "0");
            ddlUserName.Items.Insert(0, li);
        }
        else
        {
            ddlUserName.DataTextField = "UserName";
            ddlUserName.DataValueField = "UserId";
            ddlUserName.DataSource = objDUT.GetDataTable("Select tu.Userid, tu.UserName from tblUser tu inner join tblEmployee te on tu.EID=te.Eid and te.brID=" + Session["BrBrid"] + " where tu.IsActive=1 and tu.IsDeleted = 0 and tu.associatedToID=101");
            //  Select tu.Userid, tu.UserName from tblUser tu inner join tblEmployee te on tu.EID=te.Eid and te.brID="+ Session["BrBrid"] +" where tu.IsActive=1 and tu.IsDeleted = 0 and tu.associatedToID=101
            ddlUserName.DataBind();
            ListItem li = new ListItem("--Select--", "0");
            ddlUserName.Items.Insert(0, li);
        }

        BindModuleDatalist(int.Parse(dropUserGroup.SelectedValue));
    }

    private void bindRO(int ro)
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
        dropRO.DataTextField = "brCode";
        dropRO.DataValueField = "brid";
        dropRO.DataSource = objDUT.GetMaster(param);
        dropRO.DataBind();
        dropRO.Items.Insert(0, new ListItem("--Select Branch--", "0"));
    }

    protected void dropRO_SelectedIndexChanged(object sender, EventArgs e)
    {
        ViewState["brnchid"] = Session["BrBrid"];
    }
}