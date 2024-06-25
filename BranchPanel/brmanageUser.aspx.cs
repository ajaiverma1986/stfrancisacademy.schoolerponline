using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HO_manageUser : System.Web.UI.Page
{
    private string url1;
    private string PageName;
    private Utility objut = new Utility();
    private DataUtility objDUT = new DataUtility();
    private int result = 0;
    private Utility objUT = new Utility();
    private string brCode = string.Empty, pageName = string.Empty, url = string.Empty;
    private string strSqlCountry;

    protected void Page_Load(object sender, EventArgs e)
    {
        url1 = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url1);
        }
        //PageName = Utility.GetCurrentPagename();

        //if (!objut.isAccessible(((User)Session["BrUser"]).UserID, PageName))
        //{
        //    Response.Redirect("~/Login.aspx");
        //}

        if (!Page.IsPostBack)
        {
            try
            {
                //________________ Get State
                trRO.Visible = false;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@ID", SqlDbType.Int);
                param[0].Value = 0;
                param[1] = new SqlParameter("@master", SqlDbType.VarChar, 50);
                param[1].Value = "Branchrole";
                dropRole.DataTextField = "RoleName";
                dropRole.DataValueField = "RoleID";
                dropRole.DataSource = objDUT.GetMaster(param);
                dropRole.DataBind();
                dropRole.Items.Insert(0, new ListItem("--Role--", "0"));

                //________________ Get RO List

                FillDDL();
                getloginid();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        lblmsg.Text = "";
    }

    private void getloginid()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@intresult", SqlDbType.Int);
        param[0].Direction = ParameterDirection.Output;
        ViewState["loginid"] = objDUT.GetScalerSP(param, "sp_getloginid");
        txtUserName.Text = ViewState["loginid"].ToString();
    }

    protected void Button1_Click(object sender, ImageClickEventArgs e)
    {
        txtPass.Attributes.Add("value", "");
        txtRePass.Attributes.Add("value", "");

        txtUserName.Text = "";
        txtName.Text = "";
        txtphone.Text = "";
        txtmobile.Text = "";
        txtaddress.Text = "";
        txtmailid.Text = "";
        txtPinCode.Text = "";
        txtPass.Text = "";
        txtRePass.Text = "";

        //txtROCode.Enabled = true;

        FIELDSET1.Visible = true;

        btSave.Visible = true;
    }

    public bool ValidateEntry()
    {
        bool flag = true;
        lblmsg.Text = "";
        if (dropRole.SelectedIndex == 0)
        {
            lblmsg.Text += "Please Select Role !! ";
            flag = false;
        }
        if (dropRole.SelectedItem.Text == "RO Admin" && dropRO.SelectedIndex == 0)
        {
            lblmsg.Text += "Please Select RO !! ";
            flag = false;
        }
        if (!String.IsNullOrEmpty(txtmobile.Text))
        {
            if (!objUT.IsNumeric(txtmobile.Text))
            {
                lblmsg.Text += "Please Enter Valid Mobile Number !! ";
                flag = false;
            }
        }
        //if (!String.IsNullOrEmpty(txtPinCode.Text))
        //{
        //    if (!objUT.IsNumeric(txtPinCode.Text))
        //    {
        //        lblmsg.Text += "Please Enter Valid Pin Code !! ";
        //        flag = false;
        //    }
        //}
        //if (ddlState.SelectedItem.Text == "-State-")
        //{
        //    lblmsg.Text += "Please Select State !! ";
        //    flag = false;
        //    return flag;
        //}
        //if (ddlCity.SelectedItem.Text == "-District-")
        //{
        //    lblmsg.Text += "Please Select City !! ";
        //    flag = false;
        //    return flag;
        //}
        return flag;
    }

    protected void FillDDL()
    {
        strSqlCountry = "select * from country where cActive=1 order by countryname";
        DataTable dtCountry = objDUT.GetDataTable(strSqlCountry);
        ddlcountry.DataSource = dtCountry;
        ddlcountry.DataTextField = "countryname";
        ddlcountry.DataValueField = "cid";
        ddlcountry.DataBind();
        //strSqlCountry = "select * from state where statename='Others'";
        //DataTable dtOstate = objDUT.GetDataTable(strSqlCountry);
        //if (dtOstate.Rows.Count > 0)
        //{
        //    ListItem li = new ListItem(dtOstate.Rows[0]["stateName"].ToString(), dtOstate.Rows[0]["sid"].ToString());
        //    ddlState.Items.Add(li);
        //}
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        if (!ValidateEntry())
        {
            return;
        }

        SqlParameter[] paramRO = new SqlParameter[21];
        paramRO[0] = new SqlParameter("@EmployeeID", SqlDbType.VarChar, 10);
        paramRO[0].Value = "";

        paramRO[1] = new SqlParameter("@Name", SqlDbType.VarChar, 100);
        paramRO[1].Value = txtName.Text.Trim();

        paramRO[2] = new SqlParameter("UID", SqlDbType.Int);
        paramRO[2].Value = 0;

        paramRO[3] = new SqlParameter("@AssociatedToID", SqlDbType.Int);
        paramRO[3].Value = 0;

        paramRO[4] = new SqlParameter("@EID", SqlDbType.Int);
        paramRO[4].Value = 0;

        paramRO[5] = new SqlParameter("@UserName", SqlDbType.VarChar, 50);
        paramRO[5].Value = txtUserName.Text.Trim();

        paramRO[6] = new SqlParameter("@Password", SqlDbType.VarChar, 50);
        paramRO[6].Value = txtPass.Text.Trim();

        paramRO[7] = new SqlParameter("@RoleId", SqlDbType.Int);
        paramRO[7].Value = Convert.ToInt32(dropRole.SelectedValue);

        paramRO[8] = new SqlParameter("@CreatedByID", SqlDbType.Int);
        paramRO[8].Value = Convert.ToInt32(((User)Session["BrUser"]).UserID);

        paramRO[9] = new SqlParameter("@isActive", SqlDbType.Bit);
        paramRO[9].Value = Convert.ToBoolean(chkActive.Checked);

        paramRO[10] = new SqlParameter("@queryType", SqlDbType.VarChar, 50);
        paramRO[10].Value = "SaveUserWithEmployee";

        paramRO[11] = new SqlParameter("@brID", SqlDbType.Int);
        if (Convert.ToInt32(Session["BrBrid"]) > 0)
        {
            paramRO[11].Value = Convert.ToInt32(Session["BrBrid"]);
        }
        else
        {
            paramRO[11].Value = 0;
        }
        paramRO[12] = new SqlParameter("@intResult", SqlDbType.Int);
        paramRO[12].Direction = ParameterDirection.Output;

        paramRO[13] = new SqlParameter("@mobileno", SqlDbType.VarChar);
        paramRO[13].Value = txtmobile.Text.Trim();

        paramRO[14] = new SqlParameter("@mailid", SqlDbType.VarChar);
        paramRO[14].Value = txtmailid.Text.Trim();

        paramRO[15] = new SqlParameter("@address", SqlDbType.VarChar);
        paramRO[15].Value = txtaddress.Text.Trim();

        paramRO[16] = new SqlParameter("@pincode", SqlDbType.VarChar);
        paramRO[16].Value = txtPinCode.Text.Trim();

        paramRO[17] = new SqlParameter("@stateid", SqlDbType.Int);
        if (ddlState.SelectedIndex > 0)
        {
            paramRO[17].Value = ddlState.SelectedValue;
        }
        else
        {
            paramRO[17].Value = 0;
        }

        paramRO[18] = new SqlParameter("@cityid", SqlDbType.Int);
        if (ddlCity.SelectedIndex >= 0)
        {
            paramRO[18].Value = ddlCity.SelectedValue;
        }
        else
        {
            paramRO[18].Value = 0;
        }

        paramRO[19] = new SqlParameter("@cid", SqlDbType.Int);
        if (ddlcountry.SelectedIndex >= 0)
        {
            paramRO[19].Value = ddlcountry.SelectedValue;
        }
        else
        {
            paramRO[19].Value = 0;
        }
        paramRO[20] = new SqlParameter("@phone", SqlDbType.VarChar, 100);

        paramRO[20].Value = txtphone.Text;

        result = objDUT.ExecuteSqlSP(paramRO, "uspUser");
        if (result == 0)
        {
            txtUserName.Text = "";
            ViewState["loginid"] = null;
            getloginid();

            if (fileupload1.HasFile)
            {
                string fileexe = Path.GetExtension(fileupload1.FileName);
                if (fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".gif")
                {
                    string filename = Path.GetFileName(fileupload1.PostedFile.FileName);
                    int maxid = Convert.ToInt32(objDUT.GetScalar("select MAX(Eid) from tblEmployee"));
                    fileupload1.SaveAs(Server.MapPath("../BranchPhoto/" + maxid + filename));
                    objDUT.ExecuteSql("update tblEmployee set photo='" + maxid + filename + "' where eid=" + maxid);
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "User created successfully but only images can be uploaded.");
                    reset();
                    return;
                }
            }

            //bindROList();
            //bindUserList();
            Utility.ViewAlertMessage(this.Master.Page, "User created successfully");

            reset();
        }
        else if (result == 2)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Login ID already exists");
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Some Error!!");
        }
    }

    private void reset()
    {
        txtPass.Attributes.Add("value", "");
        txtRePass.Attributes.Add("value", "");

        txtName.Text = "";
        txtphone.Text = "";
        txtmobile.Text = "";
        txtaddress.Text = "";
        txtmailid.Text = "";
        txtPinCode.Text = "";
        txtPass.Text = "";
        txtRePass.Text = "";
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        txtPass.Attributes.Add("value", "");
        txtRePass.Attributes.Add("value", "");

        txtName.Text = "";
        txtphone.Text = "";
        txtmobile.Text = "";
        txtaddress.Text = "";
        txtmailid.Text = "";
        txtPinCode.Text = "";
        txtPass.Text = "";
        txtRePass.Text = "";
    }

    protected void dropState_SelectedIndexChanged(object sender, EventArgs e)
    {
        //________________ Get State
        if (dropRole.SelectedValue == "3")
        {
            bindRO(0);
            trRO.Visible = false;
        }
        else
        {
            trRO.Visible = false;
        }
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

    protected void getRole(int userG)
    {
        dropRole.DataTextField = "RoleName";
        dropRole.DataValueField = "RoleId";
        dropRole.DataSource = objDUT.GetDataTable("Select RoleName,RoleID  from tblRole where IsActive=1 and IsDeleted = 0 and associatedToID=" + userG + " and RoleId<>1 order by rolename");
        dropRole.DataBind();
        ListItem li = new ListItem("--Select--", "0");
        dropRole.Items.Insert(0, li);
    }

    protected void dropUserGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (dropUserGroup.SelectedIndex > 0)
        {
            getRole(int.Parse(dropUserGroup.SelectedValue));
            if (dropUserGroup.SelectedValue == "101")
            {
                bindRO(0);
                trRO.Visible = true;
            }
            else
            {
                trRO.Visible = false;
            }
        }
    }

    protected void StateGrid_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            HiddenField hfRmid = e.Item.FindControl("HiddenField1") as HiddenField;
            LinkButton Deact = e.Item.FindControl("DE1") as LinkButton;
            LinkButton Act = e.Item.FindControl("A1") as LinkButton;
            bool ad = Convert.ToBoolean(objDUT.GetScalar("select isactive from tbluser where userid=" + hfRmid.Value + ""));
            if (!ad)
            {
                Deact.Visible = false;
            }
            else
            {
                Act.Visible = false;
            }
        }
    }

    protected void dropRO_DataBound(object sender, EventArgs e)
    {
        if (dropRO.Items.Count > 0)
        {
            foreach (ListItem li in dropRO.Items)
            {
                string ldt = objDUT.GetScalar("Select brname from branch_master where brcode='" + li.Text + "'").ToString();
                li.Text = li.Text + "(" + ldt + ")";
            }
        }
    }

    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlCity.Items.Clear();
        int intStateId = Convert.ToInt32(ddlState.SelectedValue);
        string strSql = " select ctid,cityname from city where cityname<>'Others' and sid=" + intStateId + " order by cityname";
        DataTable dtCity = objDUT.GetDataTable(strSql);
        ddlCity.DataSource = dtCity;
        ddlCity.DataTextField = "cityname";
        ddlCity.DataValueField = "ctId";
        ddlCity.DataBind();
        ddlCity.Items.Insert(0, new ListItem("--City--", "0"));
    }

    protected void ddlcountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        strSqlCountry = "select * from state where sActive=1 and cid=" + ddlcountry.SelectedValue + " order by statename";
        DataTable dtCountry = objDUT.GetDataTable(strSqlCountry);
        ddlState.DataSource = dtCountry;
        ddlState.DataTextField = "statename";
        ddlState.DataValueField = "sid";
        ddlState.DataBind();
    }
}