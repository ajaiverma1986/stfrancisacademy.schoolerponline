using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

public partial class HO_MyProfile : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private Utility objut = new Utility();
    private DataUtility objDUT = new DataUtility();
    private CommonClass CommonClass = new CommonClass();
    private Utility objUT = new Utility();
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
    private int result = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["User"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        PageName = Utility.GetCurrentPagename();

        if (!objut.isAccessible(((User)Session["User"]).UserID, PageName))
        {
            Response.Redirect("~/Login.aspx");
        }
        if (!IsPostBack)
        {
            FillDLL1();
            FillDDL();
            show();
        }
    }

    protected void FillDLL1()
    {
        try
        {
            for (int i = 1901; i <= Convert.ToInt32(System.DateTime.Today.Year); i++)
            {
                ddlyear.Items.Add(i.ToString());
            }
            ddlyear.Items.Insert(0, new ListItem("Year", "0"));
            for (int j = 1; j <= 12; j++)
            {
                ddlmon.Items.Add(j.ToString());
            }
            ddlmon.Items.Insert(0, new ListItem("Month", "0"));
            for (int k = 1; k <= 31; k++)
            {
                ddlday.Items.Add(k.ToString());
            }
            ddlday.Items.Insert(0, new ListItem("Day", "0"));
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            // lblMessage.Text = objUT.ShowMsg(MsgType.ERROR).ToString();
        }
    }

    protected bool val()
    {
        if (ddlmon.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Month ");
            ddlmon.Focus();
            return false;
        }
        if (ddlyear.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Year ");
            ddlyear.Focus();
            return false;
        }
        if (ddlday.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Date ");
            ddlday.Focus();
            return false;
        }
        return true;
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        SqlParameter[] paramRO = new SqlParameter[28];

        paramRO[0] = new SqlParameter("@EmployeeID", SqlDbType.VarChar, 10);
        paramRO[0].Value = "";

        paramRO[1] = new SqlParameter("@Name", SqlDbType.VarChar, 100);
        paramRO[1].Value = txtName.Text.Trim();

        paramRO[2] = new SqlParameter("@UID", SqlDbType.Int);
        paramRO[2].Value = Convert.ToInt32(HfUid.Value);

        paramRO[3] = new SqlParameter("@AssociatedToID", SqlDbType.Int);
        paramRO[3].Value = 10101;

        paramRO[4] = new SqlParameter("@EID", SqlDbType.Int);
        paramRO[4].Value = Convert.ToInt32(HfEID.Value);

        paramRO[5] = new SqlParameter("@UserName", SqlDbType.VarChar, 50);
        paramRO[5].Value = txtloginid.Text;

        paramRO[6] = new SqlParameter("@Password", SqlDbType.VarChar, 50);
        paramRO[6].Value = Convert.ToInt32(HiddenField1.Value); ;

        paramRO[7] = new SqlParameter("@RoleId", SqlDbType.Int);
        paramRO[7].Value = Session["RoleID"];

        paramRO[8] = new SqlParameter("@CreatedByID", SqlDbType.Int);
        paramRO[8].Value = Convert.ToInt32(((User)Session["User"]).UserID);

        paramRO[9] = new SqlParameter("@isActive", SqlDbType.Bit);
        paramRO[9].Value = 1;

        paramRO[10] = new SqlParameter("@queryType", SqlDbType.VarChar, 50);
        paramRO[10].Value = "UpdateUserWithEmployee";

        paramRO[11] = new SqlParameter("@intResult", SqlDbType.Int);
        paramRO[11].Direction = ParameterDirection.Output;

        paramRO[12] = new SqlParameter("@mobileno", SqlDbType.VarChar);
        paramRO[12].Value = txtmobile.Text.Trim();

        paramRO[13] = new SqlParameter("@mailid", SqlDbType.VarChar);
        paramRO[13].Value = txtemailid.Text.Trim();

        paramRO[14] = new SqlParameter("@address", SqlDbType.VarChar);
        paramRO[14].Value = txtaddress.Text.Trim();

        paramRO[15] = new SqlParameter("@pincode", SqlDbType.VarChar);
        paramRO[15].Value = txtPinCode.Text.Trim();

        paramRO[16] = new SqlParameter("@stateid", SqlDbType.Int);
        if (ddlState.SelectedIndex > 0)
        {
            paramRO[16].Value = ddlState.SelectedValue;
        }
        else
        {
            paramRO[16].Value = 0;
        }

        paramRO[17] = new SqlParameter("@cityid", SqlDbType.Int);
        if (ddlCity.SelectedIndex >= 0)
        {
            paramRO[17].Value = ddlCity.SelectedValue;
        }
        else
        {
            paramRO[17].Value = 0;
        }

        paramRO[18] = new SqlParameter("@cid", SqlDbType.Int);
        if (ddlcountry.SelectedIndex >= 0)
        {
            paramRO[18].Value = ddlcountry.SelectedValue;
        }
        else
        {
            paramRO[18].Value = 0;
        }
        paramRO[19] = new SqlParameter("@phone", SqlDbType.VarChar, 100);

        paramRO[19].Value = txtphoneno.Text;
        paramRO[20] = new SqlParameter("@photo", SqlDbType.VarChar, 100);
        if (fileupload1.HasFile)
        {
            string fileexe = Path.GetExtension(fileupload1.FileName);
            if (fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".gif")
            {
                if (fileupload1.PostedFile.ContentLength < 307200)
                {
                    string filename = Path.GetFileName(fileupload1.PostedFile.FileName);
                    string path = Server.MapPath("../userImage");
                    int maxid = Convert.ToInt32(1);

                    string filenewname = (maxid) + "_" + filename;
                    fileupload1.SaveAs(Server.MapPath("../userImage/" + (maxid) + "_" + filename));
                    paramRO[20].Value = filenewname;
                }
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "Only image files can be uploaded!.");
                return;
            }
        }
        else
        {
            paramRO[20].Value = ViewState["photo"];
        }
        //paramRO[21]=new SqlParameter("

        //paramRO[21] = new SqlParameter("@FaxNo", SqlDbType.VarChar, 50);

        paramRO[21] = new SqlParameter("@FaxNo", SqlDbType.VarChar);
        paramRO[21].Value = txtfaxno.Text.Trim();

        paramRO[22] = new SqlParameter("@InstantMan", SqlDbType.VarChar);
        paramRO[22].Value = txtinstmess.Text.Trim();

        paramRO[23] = new SqlParameter("@OrgName", SqlDbType.VarChar);
        paramRO[23].Value = txtorgname.Text.Trim();

        // concotination of three dropdownlist

        if (ddlday.SelectedIndex > 0)
        {
            string str = ddlday.SelectedItem.Text;
            string str1 = ddlmon.SelectedItem.Text;
            string str2 = ddlyear.SelectedItem.Text;
            string final = str1 + "-" + str + "-" + str2;

            DateTime dt = Convert.ToDateTime(final);

            //

            paramRO[24] = new SqlParameter("@Date", SqlDbType.VarChar);
            paramRO[24].Value = dt;
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Day ");
            ddlday.Focus();
        }

        paramRO[25] = new SqlParameter("@AddtionalInfo", SqlDbType.VarChar);
        paramRO[25].Value = txtaddinfo.Text.Trim();

        paramRO[26] = new SqlParameter("@instatntManID1", SqlDbType.Int);
        if (ddlinsmess.SelectedIndex >= 0)
        {
            paramRO[26].Value = ddlinsmess.SelectedValue;
        }

        paramRO[27] = new SqlParameter("@instantMan_Name", SqlDbType.VarChar);
        paramRO[27].Value = ddlinsmess.SelectedItem.Text;

        result = objDUT.ExecuteSqlSP(paramRO, "uspUser");
        if (result == 0)
        {
            if (fileupload1.HasFile)
            {
                string filename = Path.GetFileName(fileupload1.PostedFile.FileName);
            }

            Utility.ViewAlertMessage(this.Master.Page, "User details updated successfuly");

            FIELDSET1.Visible = true;
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

    protected void FillDDL()
    {
        //Fill Countury

        ddlcountry.DataSource = CommonClass.ABC("Countrydll");
        ddlcountry.DataTextField = "countryName";
        ddlcountry.DataValueField = "CID";
        ddlcountry.DataBind();
        ddlcountry.Items.Insert(0, new ListItem("--Select Country--", "0"));

        ddlState.Items.Insert(0, new ListItem("--Select State--", "0"));
        ddlCity.Items.Insert(0, new ListItem("--Select City--", "0"));
    }

    protected void ddlcountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        //****Bind State
        string querystsateCount = "select COUNT(*) from STATE where CID=" + ddlcountry.SelectedValue + "";
        int statecount = Convert.ToInt32(objDUT.GetScalar(querystsateCount));
        if (statecount == 0)
        {
            lblStateMsg.Visible = false;
            lblCountryMsg.Visible = true;
            lblCountryMsg.Text = "There is no state against this country!! Please add state in master settings.";
            ddlState.Items.Clear();
            ddlState.Items.Insert(0, new ListItem("--Select State--", "0"));
            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, new ListItem("--Select City--", "0"));
        }
        else
        {
            //Bind State here
            ddlState.Items.Clear();
            lblCountryMsg.Visible = false;
            ddlState.DataSource = CommonClass.ABC1("Statedll", Convert.ToInt32(ddlcountry.SelectedValue));
            ddlState.DataTextField = "stateName";
            ddlState.DataValueField = "SID";

            ddlState.DataBind();
            ddlState.Items.Insert(0, new ListItem("--Select State--", "0"));
            //ddlState.SelectedValue = "33";
        }
    }

    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        //********Bind City
        int intStateId = Convert.ToInt32(ddlState.SelectedValue);
        string querycityCount = "select COUNT(*) from CITY where SID=" + intStateId + "";
        int citycount = Convert.ToInt32(objDUT.GetScalar(querycityCount));
        if (citycount == 0)
        {
            lblStateMsg.Visible = true;
            lblStateMsg.Text = "There is no city against this state!! Please add city in master settings.";
            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, new ListItem("--Select City--", "0"));
        }
        else
        {
            lblStateMsg.Visible = false;
            ddlCity.Items.Clear();
            string strSql = "select ctId,cityName from city where cityName<>'Others' and sid=" + intStateId + " order by cityName";
            DataTable dtCity = objDUT.GetDataTable(strSql);
            ddlCity.DataSource = CommonClass.ABC1("Citydll", Convert.ToInt32(ddlState.SelectedValue));
            ddlCity.DataTextField = "cityName";
            ddlCity.DataValueField = "ctId";
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, new ListItem("--Select City--", "0"));
        }
    }

    protected void show()
    {
        SqlParameter[] paramRo = new SqlParameter[3];
        paramRo[0] = new SqlParameter("@UId", SqlDbType.Int);
        paramRo[0].Value = Session["ADID"];

        paramRo[1] = new SqlParameter("@queryType", SqlDbType.VarChar, 50);
        paramRo[1].Value = "GetUserByUserID";
        paramRo[2] = new SqlParameter("@intResult", SqlDbType.Int);
        paramRo[2].Direction = ParameterDirection.Output;
        DataTable dt = objDUT.GetDataTableSP(paramRo, "uspUser");

        if (dt.Rows.Count > 0)
        {
            txtloginid.Text = dt.Rows[0]["UserName"].ToString();
            txtphoneno.Text = dt.Rows[0]["phone"].ToString();

            txtaddress.Text = dt.Rows[0]["permamentAddress"].ToString();
            txtName.Text = dt.Rows[0]["Name"].ToString();
            txtmobile.Text = dt.Rows[0]["mobileno"].ToString();
            txtemailid.Text = dt.Rows[0]["mailid"].ToString();

            if (Convert.ToInt32(dt.Rows[0]["cid"].ToString()) != 0)
            {
                ddlcountry.SelectedValue = dt.Rows[0]["cid"].ToString();
            }
            if (Convert.ToInt32(dt.Rows[0]["stateid"].ToString()) != 0)
            {
                ddlState.Items.Clear();
                ddlState.DataSource = CommonClass.ABC1("Statedll", Convert.ToInt32(dt.Rows[0]["cid"].ToString()));
                ddlState.DataTextField = "stateName";
                ddlState.DataValueField = "SID";

                ddlState.DataBind();
                ddlState.Items.Insert(0, new ListItem("--Select State--", "0"));
                ddlState.SelectedValue = dt.Rows[0]["stateid"].ToString();
            }
            if (Convert.ToInt32(dt.Rows[0]["cityid"].ToString()) != 0)
            {
                ddlCity.Items.Clear();
                ddlCity.DataSource = CommonClass.ABC1("Citydll", Convert.ToInt32(dt.Rows[0]["stateid"].ToString()));
                ddlCity.DataTextField = "cityName";
                ddlCity.DataValueField = "ctID";

                ddlCity.DataBind();
                ddlCity.Items.Insert(0, new ListItem("--Select City--", "0"));
                ddlCity.SelectedValue = dt.Rows[0]["cityid"].ToString();
            }

            txtPinCode.Text = dt.Rows[0]["pincode"].ToString();

            HfUid.Value = dt.Rows[0]["UserId"].ToString();
            HfEID.Value = dt.Rows[0]["EId"].ToString();
            HiddenField1.Value = dt.Rows[0]["Password"].ToString();
            imguser.ImageUrl = "~/userImage/" + dt.Rows[0]["photo"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["photo"].ToString()))
            {
                ViewState["photo"] = dt.Rows[0]["photo"].ToString();
            }
            else
            {
                ViewState["photo"] = "";
            }

            txtfaxno.Text = dt.Rows[0]["Faxno"].ToString();

            txtinstmess.Text = dt.Rows[0]["InstantManagerId"].ToString();

            txtorgname.Text = dt.Rows[0]["OrganizationName"].ToString();

            if (!string.IsNullOrEmpty(Convert.ToString(dt.Rows[0]["DOB"])))
            {
                string datetime = Convert.ToDateTime(dt.Rows[0]["DOB"]).ToString("dd/MM/yyyy");

                string xyz = datetime.Substring(6, 4).ToString();

                ddlyear.SelectedValue = xyz;

                string datetime1 = Convert.ToDateTime(dt.Rows[0]["DOB"]).ToString("dd/MM/yyyy");
                string xyz1 = datetime1.Substring(3, 2).ToString();

                ddlmon.SelectedValue = Convert.ToInt32(xyz1).ToString();

                string datetime12 = Convert.ToDateTime(dt.Rows[0]["DOB"]).ToString("dd/MM/yyyy");
                string xyz12 = datetime12.Substring(0, 2).ToString();

                ddlday.SelectedValue = Convert.ToInt32(xyz12).ToString();
            }
            txtaddinfo.Text = dt.Rows[0]["additionalinformation"].ToString();

            if (dt.Rows[0]["InstantManagerID1"].ToString() != "null")
            {
                ddlinsmess.SelectedValue = dt.Rows[0]["InstantManagerID1"].ToString();
            }
            else
            {
                ddlinsmess.SelectedItem.Value = "0";
            }
        }
    }

    protected void btnUpdateCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Common/Default.aspx");
    }
}