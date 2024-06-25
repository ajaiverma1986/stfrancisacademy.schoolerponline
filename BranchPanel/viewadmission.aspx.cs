using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_viewadmission : System.Web.UI.Page
{
    private string url, q = "";
    private DataTable dt;
    private DataUtility objdut = new DataUtility();
    private CommonClass commonobj = new CommonClass();
    private int regid1;
    private SqlParameter[] param;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();

        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        if (Request.QueryString.Count > 0)
        {
            Session["stue"] = Convert.ToInt32(Request.QueryString[0]);

            if (Session["stue"] == null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        if (Request.QueryString.Count == 0 && Session["stue"] == null)
        {
            Response.Redirect("Default.aspx");
        }

        getdate();
        if (!IsPostBack)
        {
            ViewState["fyid"] = Convert.ToInt32(objdut.GetScalar("select fyid from tbl_admission where adid=" + Session["stue"]));
            fillclass();
            fillCountry();
            ViewState["Rid"] = Session["stue"];

            int result = Convert.ToInt32(objdut.GetScalar("select count(1) from tbl_Admission where status=1 and adid=" + Session["stue"] + "  and fyid=" + Convert.ToInt32(ViewState["fyid"]) + " and brid=" + Convert.ToInt32(Session["BrBrid"])));
            // int result = commonobj.Scaler("Chekdetail", studentadno, Convert.ToInt32(ViewState["fyid"]), Convert.ToInt32(Session["BrBrid"]));
            if (result == 1)
            {
                showdetails(Convert.ToInt32(Session["stue"]));
            }
            else
            {
                Response.Redirect("studentadmissionlistaspx.aspx");
            }
        }
    }

    public void getdate()
    {
        string date = (DateTime.Today.Date).ToShortDateString();
        txtToDate.Text = date;
    }

    public void fillCountry()
    {
        ddlCountry1.DataSource = CommonClass.ABC("Countrydll");
        ddlCountry1.DataTextField = "countryName";
        ddlCountry1.DataValueField = "CID";
        ddlCountry1.DataBind();
        ddlCountry1.Items.Insert(0, new ListItem("--Select Country--", "0"));
        ddl_state.Items.Insert(0, new ListItem("--Select State--", "0"));
        ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
    }

    public void fillclass()
    {
        // string str = " select classid,Classname from ClassBranch_master where BranchId=1 and Status=1";
        // DataTable dt = objdut.GetDataTable(str);
        ddlClass.DataSource = CommonClass.ABC1("ClassInBranch", Convert.ToInt32(Session["BrBrid"]));
        //ddl_Course.DataSource = dt;
        ddlClass.DataTextField = "Classname";
        ddlClass.DataValueField = "classid";
        ddlClass.DataBind();
        ListItem li = new ListItem("--Select Class--", "0");
        ddlClass.Items.Insert(0, li);

        //ddlSection.Items.Insert(0, new ListItem("--Select Section--", "0"));
    }

    protected void showdetails(int Prid)
    {
        int idStudent = Prid;
        string query = "Select *,tm.ADNO,tm.adid,tm.classid from student_master sm inner join tbl_Admission tm on sm.sturegno=tm.sturegno where tm.adid=" + idStudent + " and tm.brid=" + Convert.ToInt32(Session["BrBrid"]) + " and tm.fyid=" + Convert.ToInt32(ViewState["fyid"]);

        dt = objdut.GetDataTable(query);

        if (dt.Rows.Count > 0)
        {
            txtRegNo.Text = dt.Rows[0]["ADNO"].ToString();
            txtName.Text = dt.Rows[0]["FirstName"].ToString();
            txtmidname.Text = dt.Rows[0]["MiddleName"].ToString();
            txtLName.Text = dt.Rows[0]["LastName"].ToString();
            txtFname.Text = dt.Rows[0]["FfirstName"].ToString();
            txtmidname1.Text = dt.Rows[0]["FMiddleName"].ToString();
            txtlastname1.Text = dt.Rows[0]["FLastName"].ToString();
            txtmother.Text = dt.Rows[0]["MFirstName"].ToString();
            txtmidname2.Text = dt.Rows[0]["MmiddleName"].ToString();
            txtlastname2.Text = dt.Rows[0]["MLastName"].ToString();
            txtToDate.Text = Convert.ToDateTime(dt.Rows[0]["DateofBirth"]).ToString("MMM dd yyyy");
            rbgender.SelectedValue = dt.Rows[0]["Gender"].ToString();
            ViewState["adid"] = dt.Rows[0]["adid"].ToString();

            txtPAddress.Text = dt.Rows[0]["Address"].ToString();

            txtmob.Text = dt.Rows[0]["FMobileNo"].ToString();

            if (Convert.ToInt32(dt.Rows[0]["classid"].ToString()) != 0)
            {
                ddlClass.SelectedValue = dt.Rows[0]["classid"].ToString();
                ddlClass.DataSource = CommonClass.ABC1("ClassInBranch", Convert.ToInt32(Session["BrBrid"]));//commonobj.Dll("Statedll", Convert.ToInt32(dr["countryid"].ToString()));
                ddlClass.DataTextField = "Classname";
                ddlClass.DataValueField = "classid";
                ddlClass.DataBind();
            }

            if (Convert.ToInt32(dt.Rows[0]["countryid"].ToString()) != 0)
            {
                ddlCountry1.SelectedValue = dt.Rows[0]["countryid"].ToString();
            }
            if (Convert.ToInt32(dt.Rows[0]["stateid"].ToString()) != 0)
            {
                ddl_state.Items.Clear();
                ddl_state.DataSource = CommonClass.ABC1("Statedll", Convert.ToInt32(dt.Rows[0]["countryid"].ToString()));//commonobj.Dll("Statedll", Convert.ToInt32(dr["countryid"].ToString()));
                ddl_state.DataTextField = "stateName";
                ddl_state.DataValueField = "SID";
                ddl_state.DataBind();
                ddl_state.Items.Insert(0, new ListItem("--Select State--", "0"));
                ddl_state.SelectedValue = dt.Rows[0]["stateid"].ToString();
            }
            if (Convert.ToInt32(dt.Rows[0]["cityid"].ToString()) != 0)
            {
                ddlCity1.Items.Clear();
                ddlCity1.DataSource = CommonClass.ABC1("Citydll", Convert.ToInt32(dt.Rows[0]["stateid"].ToString()));
                ddlCity1.DataTextField = "cityName";
                ddlCity1.DataValueField = "ctID";
                ddlCity1.DataBind();
                ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
                ddlCity1.SelectedValue = dt.Rows[0]["cityid"].ToString();
            }
            txtPZIP.Text = dt.Rows[0]["PINCode"].ToString();
            //txtmob.Text = dt.Rows[0]["FPhoneno"].ToString();

            txtadmNo.Text = dt.Rows[0]["ADNO"].ToString();
        }
        dt.Dispose();
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        Response.Redirect("completeadmission.aspx?sturegno=" + Convert.ToInt32(ViewState["Rid"]));
    }

    protected void btnupdate_Click(object sender, EventArgs e)
    {
        int idStudent = Convert.ToInt32(ViewState["adid"]);

        string brusername = (string)Session["Brusername"];
        int brID = Convert.ToInt32(Session["BrBrid"]);
        param = new SqlParameter[28];
        param[0] = new SqlParameter("@mode", "updatestu");
        param[1] = new SqlParameter("@firstname", txtName.Text.Trim());
        param[2] = new SqlParameter("@middlename", txtmidname.Text.Trim());
        param[3] = new SqlParameter("@lastname", txtLName.Text.Trim());
        param[4] = new SqlParameter("@FfirstName", txtFname.Text.Trim());
        param[5] = new SqlParameter("@FMiddleName", txtmidname1.Text.Trim());
        param[6] = new SqlParameter("@FLastName", txtlastname1.Text.Trim());
        param[7] = new SqlParameter("@MFirstName", txtmother.Text.Trim());
        param[8] = new SqlParameter("@MmiddleName", txtmidname2.Text.Trim());
        param[9] = new SqlParameter("@MLastName", txtlastname2.Text.Trim());
        param[10] = new SqlParameter("@dateofbirth", txtToDate.Text.Trim());

        param[11] = new SqlParameter("@gender", rbgender.SelectedValue);

        param[12] = new SqlParameter("@applyclass", ddlClass.SelectedItem.Text);
        param[13] = new SqlParameter("@classid", ddlClass.SelectedValue);

        param[14] = new SqlParameter("@Address", txtPAddress.Text.Trim());
        param[15] = new SqlParameter("@countryid", ddlCountry1.SelectedValue);
        param[16] = new SqlParameter("@countryname", ddlCountry1.SelectedItem.Text.Trim());

        param[17] = new SqlParameter("@statename", ddl_state.SelectedItem.Text.Trim());
        param[18] = new SqlParameter("@stateid", ddl_state.SelectedItem.Value);

        param[19] = new SqlParameter("@cityid", ddlCity1.SelectedItem.Value);
        param[20] = new SqlParameter("@cityname", ddlCity1.SelectedItem.Text.Trim());
        param[21] = new SqlParameter("@FPhoneNo", txtmob.Text.Trim());
        param[22] = new SqlParameter("@pincodeP", txtPZIP.Text.Trim());
        param[23] = new SqlParameter("@adid", idStudent);

        param[24] = new SqlParameter("@intResult", Convert.ToInt32(0));
        param[24].Direction = ParameterDirection.Output;
        param[25] = new SqlParameter("@branchname", brusername);
        param[26] = new SqlParameter("@fyid", ViewState["fyid"]);
        param[27] = new SqlParameter("@brid", brID);
        int count = Convert.ToInt32(objdut.ExecuteSqlSP(param, "usp_updateAdmission"));
        if (count == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Admission updated successfully.");

            Response.Redirect("studentadmissionlistaspx.aspx");
            return;
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "There was an error updating the record. Redirecting you to the original page.");
            return;
        }
    }

    protected void ddlCountry1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string querystsateCount = "select COUNT(*) from STATE where CID=" + ddlCountry1.SelectedValue + "";
        int statecount = Convert.ToInt32(objdut.GetScalar(querystsateCount));
        if (statecount == 0)
        {
            lblStateMsg.Visible = false;
            lblCountryMsg.Visible = true;
            lblCountryMsg.Text = "There is no state against this country!! Please add state in master settings.";
            ddl_state.Items.Clear();
            ddl_state.Items.Insert(0, new ListItem("--Select State--", "0"));
            ddlCity1.Items.Clear();
            ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
            ddlCountry1.Focus();
        }
        else
        {
            ddl_state.Items.Clear();
            lblCountryMsg.Visible = false;
            ddl_state.DataSource = commonobj.Dll("Statedll", Convert.ToInt32(ddlCountry1.SelectedValue));
            ddl_state.DataTextField = "stateName";
            ddl_state.DataValueField = "SID";
            ddl_state.DataBind();

            ddl_state.Items.Insert(0, new ListItem("--Select State--", "0"));
            ddl_state.Focus();
        }
    }

    protected void ddl_state_SelectedIndexChanged(object sender, EventArgs e)
    {
        int intStateId = Convert.ToInt32(ddl_state.SelectedValue);
        string querycityCount = "select COUNT(*) from CITY where SID=" + intStateId + "";
        int citycount = Convert.ToInt32(objdut.GetScalar(querycityCount));
        if (citycount == 0)
        {
            lblStateMsg.Visible = true;
            lblStateMsg.Text = "There is no city against this state!! Please add city in master settings.";
            ddlCity1.Items.Clear();
            ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
            ddl_state.Focus();
        }
        else
        {
            lblStateMsg.Visible = false;
            ddlCity1.Items.Clear();
            string strSql = "select ctId,cityName from city where cityName<>'Others' and sid=" + intStateId + " order by cityName";
            DataTable dtCity = objdut.GetDataTable(strSql);
            ddlCity1.DataSource = dtCity;
            ddlCity1.DataTextField = "cityName";
            ddlCity1.DataValueField = "ctId";
            ddlCity1.DataBind();
            ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
            ddlCity1.Focus();
        }
    }
}