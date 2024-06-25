using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HO_manageUser : System.Web.UI.Page
{
    private string PageName, photo, strSqlCountry;

    private Utility objut = new Utility();
    private DataUtility objDUT = new DataUtility();
    private int result = 0, brid = 0;
    private FileInfo finfoevent;
    private Utility objUT = new Utility();
    private string brCode = string.Empty, pageName = string.Empty, url = string.Empty;
    private CommonClass CommonClass = new CommonClass();

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

        if (!Page.IsPostBack)
        {
            FIELDSET1.Visible = false;
            try
            {
                //________________ Get State
                rp1.Visible = true;
                trRO.Visible = false;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@ID", SqlDbType.Int);
                param[0].Value = 0;
                param[1] = new SqlParameter("@master", SqlDbType.VarChar, 50);
                param[1].Value = "role";
                dropRole.DataTextField = "RoleName";
                dropRole.DataValueField = "RoleID";
                dropRole.DataSource = objDUT.GetMaster(param);
                dropRole.DataBind();
                dropRole.Items.Insert(0, new ListItem("--Role--", "0"));

                //________________ Get RO List
                bindUserList();
                FillDDL();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        lblmsg.Text = "";
    }

    private void bindUserList()
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@ID", SqlDbType.Int);
        param[0].Value = Convert.ToInt32(Session["BrBrid"]);
        param[1] = new SqlParameter("@master", SqlDbType.VarChar, 50);
        param[1].Value = "alluserwithBrach";

        rptCity.DataSource = objDUT.GetMaster(param);
        rptCity.DataBind();
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
        filed.Visible = false;
        FIELDSET1.Visible = true;
        btCreate.Enabled = false;
        btUpdate.Visible = false;
        lblStatus.Text = "Add New";
        btSave.Visible = true;
        rptCity.Visible = false;
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@intresult", SqlDbType.Int);
        param[0].Direction = ParameterDirection.Output;
        ViewState["loginid"] = objDUT.GetScalerSP(param, "sp_getloginid");
        txtUserName.Text = ViewState["loginid"].ToString();
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        if (!ValidateEntry())
        {
            return;
        }

        SqlParameter[] paramRO = new SqlParameter[22];

        paramRO[0] = new SqlParameter("@EmployeeID", SqlDbType.VarChar, 10);
        paramRO[0].Value = "";

        paramRO[1] = new SqlParameter("@Name", SqlDbType.VarChar, 100);
        paramRO[1].Value = txtName.Text.Trim();

        paramRO[2] = new SqlParameter("UID", SqlDbType.Int);
        paramRO[2].Value = Convert.ToInt32(HfUid.Value);

        paramRO[3] = new SqlParameter("@AssociatedToID", SqlDbType.Int);
        paramRO[3].Value = 0;

        paramRO[4] = new SqlParameter("@EID", SqlDbType.Int);
        paramRO[4].Value = Convert.ToInt32(HfEID.Value);

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
        paramRO[10].Value = "UpdateUserWithEmployee";

        paramRO[11] = new SqlParameter("@brID", SqlDbType.Int);
        if (dropRO.SelectedIndex > 0)
        {
            paramRO[11].Value = Convert.ToInt32(dropRO.SelectedValue);
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
        if (fileupload1.HasFile)
        {
            string fileexe = Path.GetExtension(fileupload1.FileName);
            if (fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".gif")
            {/////////////////////
                if (ViewState["photoname"] != null)
                {
                    File.Delete(Server.MapPath("../BranchPhoto/" + ViewState["photoname"].ToString()));
                    finfoevent = new FileInfo(ViewState["photoname"].ToString());
                    finfoevent.Delete();
                }
                string filename = Path.GetFileName(fileupload1.PostedFile.FileName);
                fileupload1.SaveAs(Server.MapPath("../BranchPhoto/" + Convert.ToInt32(HfEID.Value) + filename));
                paramRO[21] = new SqlParameter("@photo", Convert.ToInt32(HfEID.Value) + filename);
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "Only image files can be uploaded.!");
                return;
            }
        }
        else
        {
            if (ViewState["photoname"] != null)
            {
                paramRO[21] = new SqlParameter("@photo", ViewState["photoname"].ToString());
            }
            else
            {
                paramRO[21] = new SqlParameter("@photo", "");
            }
        }

        result = objDUT.ExecuteSqlSP(paramRO, "uspUser");
        if (result == 0)
        {
            //bindROList();
            bindUserList();
            Utility.ViewAlertMessage(this.Master.Page, "User details updated successfuly");
            rptCity.Visible = true;
            FIELDSET1.Visible = false;
        }
        else if (result == 2)
        {
            Utility.ViewAlertMessage(this.Master.Page, "User Name already exists");
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Some Error!!");
        }
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
        string strsqlstate = "select * from state where sactive=1 order by statename";
        DataTable dtOstate = objDUT.GetDataTable(strsqlstate);
        ddlState.DataSource = dtOstate;
        ddlState.DataTextField = "statename";
        ddlState.DataValueField = "sid";
        ddlState.DataBind();

        string strsqldistrict = "  select CTID,cityname from CITY order by cityname";
        DataTable dtOdistrict = objDUT.GetDataTable(strsqldistrict);
        ddlCity.DataSource = dtOdistrict;
        ddlCity.DataTextField = "cityname";
        ddlCity.DataValueField = "ctid";
        ddlCity.DataBind();
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        if (!ValidateEntry())
        {
            return;
        }

        SqlParameter[] paramRO = new SqlParameter[20];

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
        paramRO[8].Value = Convert.ToInt32(((User)Session["User"]).UserID);

        paramRO[9] = new SqlParameter("@isActive", SqlDbType.Bit);
        paramRO[9].Value = Convert.ToBoolean(chkActive.Checked);

        paramRO[10] = new SqlParameter("@queryType", SqlDbType.VarChar, 50);
        paramRO[10].Value = "SaveUserWithEmployee";

        paramRO[11] = new SqlParameter("@brID", SqlDbType.Int);
        if (dropRO.SelectedIndex > 0)
        {
            paramRO[11].Value = Convert.ToInt32(dropRO.SelectedValue);
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
        paramRO[19] = new SqlParameter("@phone", SqlDbType.VarChar, 100);

        paramRO[19].Value = txtphone.Text;

        result = objDUT.ExecuteSqlSP(paramRO, "uspUser");
        if (result == 0)
        {
            if (fileupload1.HasFile)
            {
                string filename = Path.GetFileName(fileupload1.PostedFile.FileName);
                //Server.MapPath("~/BranchPhoto" + filename);
                int maxid = Convert.ToInt32(objDUT.GetScalar("select MAX(Eid) from tblEmployee"));
                fileupload1.SaveAs(Server.MapPath("../BranchPhoto/" + maxid + filename));
                objDUT.ExecuteSql("update tblEmployee set photo='" + filename + "' where eid=" + maxid);
            }

            //bindROList();
            bindUserList();
            Utility.ViewAlertMessage(this.Master.Page, "User created successfully.");

            FIELDSET1.Visible = false;
            return;
        }
        else if (result == 2)
        {
            Utility.ViewAlertMessage(this.Master.Page, "User Name already exists.");
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Some Error!!");
        }
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        FIELDSET1.Visible = false;
        btCreate.Enabled = true;
        btUpdate.Visible = false;
        lblStatus.Text = "";
        btSave.Visible = false;
        dropUserGroup.Enabled = true;
        rptCity.Visible = true;
        filed.Visible = true;
    }

    protected void StateGrid_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        brid = Convert.ToInt32(e.CommandArgument);
        if (e.CommandName == "Edit")
        {
            rptCity.Visible = false;
            rp1.Visible = false;
            FIELDSET1.Visible = true;
            btCreate.Enabled = false;
            btUpdate.Visible = true;
            lblStatus.Text = "Update";
            btSave.Visible = false;
            filed.Visible = false;

            SqlParameter[] paramRO = new SqlParameter[13];

            paramRO[0] = new SqlParameter("@EmployeeID", SqlDbType.VarChar, 10);
            paramRO[0].Value = "";

            paramRO[1] = new SqlParameter("@Name", SqlDbType.VarChar, 100);
            paramRO[1].Value = "";

            paramRO[2] = new SqlParameter("UID", SqlDbType.Int);
            paramRO[2].Value = brid;

            paramRO[3] = new SqlParameter("@AssociatedToID", SqlDbType.Int);
            paramRO[3].Value = 0;

            paramRO[4] = new SqlParameter("@EID", SqlDbType.Int);
            paramRO[4].Value = 0;

            paramRO[5] = new SqlParameter("@UserName", SqlDbType.VarChar, 50);
            paramRO[5].Value = "";

            paramRO[6] = new SqlParameter("@Password", SqlDbType.VarChar, 50);
            paramRO[6].Value = "";

            paramRO[7] = new SqlParameter("@RoleId", SqlDbType.Int);
            paramRO[7].Value = 0;

            paramRO[8] = new SqlParameter("@CreatedByID", SqlDbType.Int);
            paramRO[8].Value = 0;

            paramRO[9] = new SqlParameter("@isActive", SqlDbType.Bit);
            paramRO[9].Value = 0;

            paramRO[10] = new SqlParameter("@queryType", SqlDbType.VarChar, 50);
            paramRO[10].Value = "GetUserByUserID";

            paramRO[11] = new SqlParameter("@brID", SqlDbType.Int);

            paramRO[11].Value = 0;
            paramRO[12] = new SqlParameter("@intResult", SqlDbType.Int);
            paramRO[12].Direction = ParameterDirection.Output;

            DataTable dt = objDUT.GetDataTableSP(paramRO, "uspUser");
            if (dt.Rows.Count == 0)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Not Editable");
                FIELDSET1.Visible = false;
                rptCity.Visible = true;
                rp1.Visible = true;
                return;
            }

            if (dt.Rows.Count > 0)
            {
                dropUserGroup.SelectedValue = dt.Rows[0]["AssociatedToID"].ToString();
                dropUserGroup.Enabled = false;
                getRole(int.Parse(dt.Rows[0]["AssociatedToID"].ToString()));
                // dropRole.SelectedValue = dt.Rows[0]["RoleID"].ToString();
                if (dt.Rows[0]["AssociatedToID"].ToString() == "101")
                {
                    bindRO(0);
                    dropRO.SelectedValue = dt.Rows[0]["brID"].ToString();
                }

                txtUserName.Text = dt.Rows[0]["username"].ToString();
                txtName.Text = dt.Rows[0]["Name"].ToString();
                txtPass.Attributes.Add("value", dt.Rows[0]["Password"].ToString());
                txtRePass.Attributes.Add("value", dt.Rows[0]["Password"].ToString());

                txtUserName.Text = dt.Rows[0]["UserName"].ToString();
                chkActive.Checked = Convert.ToBoolean(dt.Rows[0]["isActive"].ToString());
                txtphone.Text = dt.Rows[0]["phone"].ToString();
                txtmobile.Text = dt.Rows[0]["mobileno"].ToString();
                txtmailid.Text = dt.Rows[0]["mailid"].ToString();
                txtaddress.Text = dt.Rows[0]["permamentaddress"].ToString();
                txtPinCode.Text = dt.Rows[0]["pincode"].ToString();

                if (Convert.ToInt32(dt.Rows[0]["cid"].ToString()) != 0)
                {
                    ddlcountry.SelectedValue = dt.Rows[0]["cid"].ToString();
                }
                if (Convert.ToInt32(dt.Rows[0]["stateid"].ToString()) != 0)
                {
                    ddlState.Items.Clear();
                    ddlState.DataSource = CommonClass.Dll("Statedll", Convert.ToInt32(dt.Rows[0]["cid"].ToString()));
                    ddlState.DataTextField = "stateName";
                    ddlState.DataValueField = "SID";

                    ddlState.DataBind();
                    ddlState.Items.Insert(0, new ListItem("--Select State--", "0"));
                    ddlState.SelectedValue = dt.Rows[0]["stateid"].ToString();
                }

                if (Convert.ToInt32(dt.Rows[0]["cityid"].ToString()) != 0)
                {
                    ddlCity.Items.Clear();
                    ddlCity.DataSource = CommonClass.Dll("Citydll", Convert.ToInt32(dt.Rows[0]["stateid"].ToString()));
                    ddlCity.DataTextField = "cityName";
                    ddlCity.DataValueField = "ctID";

                    ddlCity.DataBind();
                    ddlCity.Items.Insert(0, new ListItem("--Select City--", "0"));
                    ddlCity.SelectedValue = dt.Rows[0]["cityid"].ToString();
                }

                HfUid.Value = dt.Rows[0]["UserId"].ToString();
                HfEID.Value = dt.Rows[0]["EId"].ToString();
                if (!string.IsNullOrEmpty(dt.Rows[0]["photo"].ToString()))
                {
                    imgStudent.ImageUrl = "~/BranchPhoto/" + dt.Rows[0]["photo"].ToString();
                    ViewState["photoname"] = dt.Rows[0]["photo"].ToString();
                }
                else
                {
                    ViewState["photoname"] = null;
                }
            }
        }
        if (e.CommandName == "Deactivate")
        {
            int i = objDUT.ExecuteSql("update tbluser set isactive=0 where userid=" + brid + "");
            if (i == 1)

                bindUserList();
            Utility.ViewAlertMessage(this.Master.Page, "Record Deactivate Successfully");
        }
        if (e.CommandName == "Activate")
        {
            int i = objDUT.ExecuteSql("update tbluser set isactive=1 where userid=" + brid + "");
            if (i == 1)

                bindUserList();
            Utility.ViewAlertMessage(this.Master.Page, "Record Activate Successfully");
        }
        if (e.CommandName == "Delete")
        {
            int i = objDUT.ExecuteSql("update tbluser set isDeleted=1 where userid=" + brid + "");
            if (i == 1)

                bindUserList();
            Utility.ViewAlertMessage(this.Master.Page, "Record Delete Successfully");
        }
    }

    protected void dropState_SelectedIndexChanged(object sender, EventArgs e)
    {
        //________________ Get State
        if (dropRole.SelectedValue == "3")
        {
            bindRO(0);
            trRO.Visible = true;
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
        string strSql = "select CTID,cityName from CITY where cityName<>'Others' and sid=" + intStateId + " order by cityName";
        DataTable dtCity = objDUT.GetDataTable(strSql);
        ddlCity.DataSource = dtCity;
        ddlCity.DataTextField = "cityName";
        ddlCity.DataValueField = "CTID";
        ddlCity.DataBind();
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