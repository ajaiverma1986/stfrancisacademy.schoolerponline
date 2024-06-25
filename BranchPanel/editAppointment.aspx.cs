using Ionic.Zip;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Web.UI.WebControls;

public partial class CreateAppoinmentLetter : System.Web.UI.Page
{
    private string PageName = "";
    private Utility objut = new Utility();
    private DataUtility objDUT = new DataUtility();
    private Utility objUT = new Utility();
    private SqlDataReader rd;
    private FileInfo finfoevent;
    private int desig;
    private string brCode = string.Empty, pageName = string.Empty, url = string.Empty;
    private string strSqlCountry;
    private string strSqlCountry1;
    private string strSqlCountry2;
    private string dob;
    private int count1 = 0;
    private CommonClass objCL = new CommonClass();
    private DataTable dtTemp = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        PageName = Utility.GetCurrentPagename();

        if (!IsPostBack)
        {
            FillDDL();
            if (Request.QueryString.Count > 0)
            {
                ViewState["eid"] = Convert.ToInt32(Request.QueryString[0]);
                filldetail();
            }
        }
    }

    private void filldetail()
    {
        using (dtTemp = objCL.dtCommon(ViewState["eid"].ToString().Trim(), 3))
        {
            if (dtTemp.Rows.Count > 0)
            {
                ViewState["eid"] = dtTemp.Rows[0]["eid"].ToString();
                dob = dtTemp.Rows[0]["dob1"].ToString();
                txtRefNo.Text = dtTemp.Rows[0]["refNo"].ToString();
                txtFName.Text = dtTemp.Rows[0]["fname"].ToString();
                txtMName.Text = dtTemp.Rows[0]["mName"].ToString();
                txtLName.Text = dtTemp.Rows[0]["lname"].ToString();
                ddlTitle.SelectedValue = dtTemp.Rows[0]["Titleid"].ToString();
                txtPincode.Text = dtTemp.Rows[0]["pinCode"].ToString();
                txtHrName.Text = dtTemp.Rows[0]["hrName"].ToString();
                rdGender.SelectedValue = Convert.ToInt16(dtTemp.Rows[0]["gender"]).ToString();

                txtMobileNo2.Text = dtTemp.Rows[0]["mobile"].ToString();
                txtComment.Text = dtTemp.Rows[0]["comments"].ToString();
                txtAddressLine.Text = dtTemp.Rows[0]["address"].ToString();
                ViewState["desig"] = Convert.ToInt16(dtTemp.Rows[0]["desigid"]);
                desig = Convert.ToInt16(dtTemp.Rows[0]["desigid"]);
                int propation = Convert.ToInt16(dtTemp.Rows[0]["proid"]);

                int cid = Convert.ToInt16(dtTemp.Rows[0]["CID"]);
                int sid = Convert.ToInt16((dtTemp.Rows[0]["SID"]));
                int disid = Convert.ToInt16(dtTemp.Rows[0]["ctid"]);

                int Tcid = Convert.ToInt16(dtTemp.Rows[0]["Tcid"]);

                int Tsid = Convert.ToInt16(dtTemp.Rows[0]["Tsid"]);
                int Tdisid = Convert.ToInt16(dtTemp.Rows[0]["Tctid"]);
                string qu1 = "select * from state where cid=" + Tcid + " and sactive=1";
                ddlState2.DataSource = objDUT.GetDataTable(qu1);
                ddlState2.DataTextField = "statename";
                ddlState2.DataValueField = "sid";
                ddlState2.DataBind();
                if (Convert.ToInt16(dtTemp.Rows[0]["tcid"]) != 0)
                {
                    ddlCountry2.SelectedValue = Convert.ToInt16(dtTemp.Rows[0]["tcid"]).ToString();
                }
                else
                {
                    ddlCountry2.SelectedValue = "0";
                }
                if (Convert.ToInt16(dtTemp.Rows[0]["Tsid"]) != 0)
                {
                    ddlState2.SelectedValue = Convert.ToInt16(dtTemp.Rows[0]["Tsid"]).ToString();
                }
                else
                {
                    ddlState2.SelectedValue = "0";
                }
                string quer23 = "select * from city where sid=" + Tsid + " and active=1";
                ddlCity2.DataSource = objDUT.GetDataTable(quer23);
                ddlCity2.DataTextField = "cityname";
                ddlCity2.DataValueField = "ctid";
                ddlCity2.DataBind();

                if (Convert.ToInt16(dtTemp.Rows[0]["Pcid"]) != 0)
                {
                    ddlPCountry.SelectedValue = Convert.ToInt16(dtTemp.Rows[0]["Pcid"]).ToString();
                }
                else
                {
                    ddlPCountry.SelectedValue = "0";
                }
                if (Convert.ToInt16(dtTemp.Rows[0]["Tctid"]) != 0)
                {
                    ddlCity2.SelectedValue = Convert.ToInt16(dtTemp.Rows[0]["Tctid"]).ToString();
                }
                else
                {
                    ddlCity2.SelectedValue = "0";
                }

                int Pcid = Convert.ToInt16(dtTemp.Rows[0]["pCid"]);
                int Psid = Convert.ToInt16(dtTemp.Rows[0]["pSid"]);
                int Pdisid = Convert.ToInt16(dtTemp.Rows[0]["pCtid"]);

                ddlPstate.DataSource = CommonClass.ABC1("Statedll", Convert.ToInt32(ddlPCountry.SelectedValue));
                ddlPstate.DataTextField = "stateName";
                ddlPstate.DataValueField = "SID";
                ddlPstate.DataBind();

                if (Convert.ToInt16(dtTemp.Rows[0]["Psid"]) != 0)
                {
                    ddlPstate.SelectedValue = Convert.ToInt16(dtTemp.Rows[0]["Psid"]).ToString();
                }
                else
                {
                    ddlPstate.SelectedValue = "0";
                }
                string quer2 = "select * from city where sid=" + Psid + " and active=1";
                ddlPCity.DataSource = objDUT.GetDataTable(quer2);
                ddlPCity.DataTextField = "cityname";
                ddlPCity.DataValueField = "ctid";
                ddlPCity.DataBind();
                if (Convert.ToInt16(dtTemp.Rows[0]["Pctid"]) != 0)
                {
                    ddlPCity.SelectedValue = Convert.ToInt16(dtTemp.Rows[0]["Pctid"]).ToString();
                }
                else
                {
                    ddlPCity.SelectedValue = "0";
                }

                txtDatejoining.Text = Convert.ToDateTime(dtTemp.Rows[0]["doj"]).ToString("dd/MM/yyyy");
                ddlBranch.SelectedValue = dtTemp.Rows[0]["brid"].ToString();
                bindstate(cid);
                bindcity(sid);
                ddlCountry.SelectedValue = cid.ToString();
                ddlState.SelectedValue = sid.ToString();
                ddlCity.SelectedValue = disid.ToString();

                ddlDesigNation.SelectedValue = desig.ToString();
                ddlProbationPeriod.SelectedValue = propation.ToString();

                string[] array = new string[5];
                array = dob.Split('/');
                string day = Convert.ToInt32(array[0]).ToString();
                string month = Convert.ToInt32(array[1]).ToString();
                string year = Convert.ToInt32(array[2]).ToString().Trim();
                ddlDOBDay.Items.Insert(0, new ListItem("Day", "0"));
                for (int i = 1; i <= 31; i++)
                {
                    ddlDOBDay.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
                }
                ddlDOBDay.SelectedValue = day;
                ddlDOBMonth.Items.Insert(0, new ListItem("Month", "0"));
                for (int i = 1; i <= 12; i++)
                {
                    ddlDOBMonth.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
                }
                ddlDOBMonth.SelectedValue = month;
                ddlDOBYear.Items.Insert(0, new ListItem("Year", "0"));
                for (int i = 1980; i <= 2017; i++)
                {
                    int y = 1;
                    ddlDOBYear.Items.Insert(y, new ListItem(i.ToString(), i.ToString()));
                }
                ddlDOBYear.SelectedValue = year;

                //--------Recently added fields----------//
                if (dtTemp.Rows[0]["HQualficationID"].ToString() != "")
                {
                    ddlHightqulification.SelectedValue = dtTemp.Rows[0]["HQualficationID"].ToString();
                }
                else
                {
                    ddlHightqulification.SelectedValue = "0";
                }
                if (dtTemp.Rows[0]["PQualficationID"].ToString() != "")
                {
                    ddlprofessionalqulification.SelectedValue = dtTemp.Rows[0]["PQualficationID"].ToString();
                }
                else
                {
                    ddlprofessionalqulification.SelectedValue = "0";
                }

                txtNationality.Text = dtTemp.Rows[0]["nationality"].ToString();
                if (dtTemp.Rows[0]["mstatus"].ToString() != "")
                {
                    rblMStatus.SelectedValue = dtTemp.Rows[0]["mstatus"].ToString();
                }
                else
                {
                    rblMStatus.SelectedValue = "0";
                }
                txtforbirthplace.Text = dtTemp.Rows[0]["birthPlace"].ToString();
                txtChild.Text = dtTemp.Rows[0]["noOfChilds"].ToString();
                txtF1name.Text = dtTemp.Rows[0]["father"].ToString();
                txtMotherName.Text = dtTemp.Rows[0]["mother"].ToString();
                txtPanNo.Text = dtTemp.Rows[0]["panNo"].ToString();
                txtAdharno.Text = dtTemp.Rows[0]["aadharNo"].ToString();
                txtPassportNo.Text = dtTemp.Rows[0]["passportNo"].ToString();
                txtLicenseNo.Text = dtTemp.Rows[0]["dlNo"].ToString();
                txtVoterNo.Text = dtTemp.Rows[0]["voterIDNo"].ToString();
                //Details
                txtPhoneNo.Text = dtTemp.Rows[0]["phone"].ToString();
                txtEmailId.Text = dtTemp.Rows[0]["emailID"].ToString();
                txtInstant.Text = dtTemp.Rows[0]["messanger"].ToString();
                TextBox5.Text = dtTemp.Rows[0]["Taddress"].ToString();
                TextBox6.Text = dtTemp.Rows[0]["TPincode"].ToString();
                //------------
                txtJobTitle.Text = dtTemp.Rows[0]["jobTitle"].ToString();
                txtEmailAlloted.Text = dtTemp.Rows[0]["emailAlloted"].ToString();
                //Previous Organization//
                txtPorganisation.Text = dtTemp.Rows[0]["preOrganisation"].ToString();
                txtPaddress.Text = dtTemp.Rows[0]["pAddress"].ToString();
                txtPPincode.Text = dtTemp.Rows[0]["pPincode"].ToString();
                txtPdesignation.Text = dtTemp.Rows[0]["pDesignation"].ToString();
                txtPsalary.Text = Convert.ToDouble(dtTemp.Rows[0]["pSalary"]).ToString("0.00");
                txtDuration.Text = dtTemp.Rows[0]["pDuration"].ToString();
                txtPexperience.Text = dtTemp.Rows[0]["totalexperience"].ToString();
                txtRef1Name.Text = dtTemp.Rows[0]["ref1Name"].ToString();
                txtReContact1.Text = dtTemp.Rows[0]["ref1Contact"].ToString();
                txtRef2Name.Text = dtTemp.Rows[0]["ref2Name"].ToString();
                txtRefContact2.Text = dtTemp.Rows[0]["ref2Contact"].ToString();
                //HEALTH//
                txtBGroup.Text = dtTemp.Rows[0]["bloodGroup"].ToString();
                txtPastDisease.Text = dtTemp.Rows[0]["pastDeseas"].ToString();
                txtAnyEllergy.Text = dtTemp.Rows[0]["anyAlergy"].ToString();
                txtGeneticDisease.Text = dtTemp.Rows[0]["geneticDeseas"].ToString();
                txtmedicalCondition.Text = dtTemp.Rows[0]["medicalCondition"].ToString();
                //BANK//
                txtBankName.Text = dtTemp.Rows[0]["bankName"].ToString();
                txtAccountNo.Text = dtTemp.Rows[0]["accountNo"].ToString();
                txtIFSCCode.Text = dtTemp.Rows[0]["IFSC"].ToString();
                txtBranchCode.Text = dtTemp.Rows[0]["branchCode"].ToString();
                txtBranchName.Text = dtTemp.Rows[0]["branchName"].ToString();
                //PHOTO AND CV
                if (!string.IsNullOrEmpty(dtTemp.Rows[0]["photo"].ToString()))
                {
                    lblPhoto.Text = dtTemp.Rows[0]["photo"].ToString();
                    ViewState["photo1"] = lblPhoto.Text;
                }
                else
                {
                    ViewState["photo1"] = null;
                    lblPhoto.Text = "";
                }

                if (dtTemp.Rows[0]["cv"].ToString() != "")
                {
                    lblcertificte.Visible = true;
                    lblcertificte.Text = dtTemp.Rows[0]["cv"].ToString();
                    ViewState["cv1"] = dtTemp.Rows[0]["cv"].ToString();
                    //lbCertificate1.Visible = true;
                }
                else
                {
                    ViewState["cv1"] = null;
                    lblCV.Text = "";
                }
                empimage.ImageUrl = "~/facultyimage/" + dtTemp.Rows[0]["photo"].ToString();
            }
        }
    }

    protected void FillDDL()
    {
        ddlTitle.DataSource = CommonClass.ABC("ddlTitle");
        ddlTitle.DataTextField = "Title";
        ddlTitle.DataValueField = "Titleid";
        ddlTitle.DataBind();
        ddlTitle.Items.Insert(0, new ListItem("Select Title", "0"));

        ddlHightqulification.DataSource = CommonClass.ABC("ddlQualification");
        ddlHightqulification.DataTextField = "name";
        ddlHightqulification.DataValueField = "qid";
        ddlHightqulification.DataBind();
        ddlHightqulification.Items.Insert(0, new ListItem("Select Hight Qulification", "0"));

        ddlprofessionalqulification.DataSource = CommonClass.ABC("ddlProQualification");
        ddlprofessionalqulification.DataTextField = "name";
        ddlprofessionalqulification.DataValueField = "id";
        ddlprofessionalqulification.DataBind();
        ddlprofessionalqulification.Items.Insert(0, new ListItem("Select Professional Qulification", "0"));

        string que = "Select desigid,designame from designation_Master where status=1";
        DataTable dtDesignation = objDUT.GetDataTable(que);
        if (dtDesignation.Rows.Count > 0)
        {
            ddlDesigNation.DataSource = dtDesignation;
            ddlDesigNation.DataTextField = "designame";
            ddlDesigNation.DataValueField = "desigid";
            ddlDesigNation.DataBind();
            ddlDesigNation.Items.Insert(0, new ListItem("Select Designation", "0"));
        }

        ddlProbationPeriod.DataSource = CommonClass.ABC("ddlProbationPeriod");
        ddlProbationPeriod.DataTextField = "timeInMonth";
        ddlProbationPeriod.DataValueField = "id";
        ddlProbationPeriod.DataBind();
        ddlProbationPeriod.Items.Insert(0, new ListItem("Select Probation Period", "0"));

        DataTable dt2 = CommonClass.ABC("Countrydll");

        ddlCountry.DataSource = dt2;
        ddlCountry.DataTextField = "countryName";
        ddlCountry.DataValueField = "CID";
        ddlCountry.DataBind();
        ddlCountry.Items.Insert(0, new ListItem("Select Country", "0"));

        ddlCountry2.DataSource = dt2;
        ddlCountry2.DataTextField = "countryName";
        ddlCountry2.DataValueField = "CID";
        ddlCountry2.DataBind();
        ddlCountry2.Items.Insert(0, new ListItem("Select Country", "0"));

        ddlPCountry.DataSource = CommonClass.ABC("Countrydll");
        ddlPCountry.DataTextField = "countryName";
        ddlPCountry.DataValueField = "CID";
        ddlPCountry.DataBind();
        ddlPCountry.Items.Insert(0, new ListItem("Select Country", "0"));
        ddlPstate.Items.Insert(0, new ListItem("Select State", "0"));
        ddlPCity.Items.Insert(0, new ListItem("Select City", "0"));

        ddlBranch.DataSource = CommonClass.ABC("BranchDll");
        ddlBranch.DataTextField = "BrName";
        ddlBranch.DataValueField = "BrId";
        ddlBranch.DataBind();
        ddlBranch.Items.Insert(0, new ListItem("Select Branch", "0"));
    }

    protected void fillDOB()
    {
        ddlDOBDay.Items.Insert(0, new ListItem("Day", "0"));
        for (int i = 1; i <= 31; i++)
        {
            ddlDOBDay.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
        }

        ddlDOBMonth.Items.Insert(0, new ListItem("Month", "0"));
        for (int i = 1; i <= 12; i++)
        {
            ddlDOBMonth.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
        }

        int year = System.DateTime.Now.Year;
        int yearto = year - 16;
        int yearfrom = year - 75;
        ddlDOBYear.Items.Insert(0, new ListItem("Year", "0"));
        for (int i = yearfrom; i <= yearto; i++)
        {
            int y = 1;
            ddlDOBYear.Items.Insert(y, new ListItem(i.ToString(), i.ToString()));
            y++;
        }
    }

    protected void txtRefNo_TextChanged(object sender, EventArgs e)
    {
        using (dtTemp = objCL.dtCommon(txtRefNo.Text.Trim(), 2))
        {
            if (dtTemp.Rows.Count > 0)
            {
                txtFName.Text = dtTemp.Rows[0]["fname"].ToString();
                txtMName.Text = dtTemp.Rows[0]["mname"].ToString();
                txtLName.Text = dtTemp.Rows[0]["lname"].ToString();
                rdGender.SelectedValue = Convert.ToInt16(dtTemp.Rows[0]["gender"]).ToString();
                txtFName.Text = dtTemp.Rows[0]["fname"].ToString();

                int cid = Convert.ToInt16(dtTemp.Rows[0]["cid"]);
                int sid = Convert.ToInt16(dtTemp.Rows[0]["sid"]);
                int disid = Convert.ToInt16(dtTemp.Rows[0]["ctid"]);
                bindstate(cid);
                bindcity(sid);
                ddlCountry.SelectedValue = cid.ToString();
                ddlState.SelectedValue = sid.ToString();
                ddlCity.SelectedValue = disid.ToString();
                ddlDesigNation.SelectedValue = dtTemp.Rows[0]["desigtype"].ToString();
                txtPhoneNo.Text = dtTemp.Rows[0]["mobile"].ToString();
                txtEmailId.Text = dtTemp.Rows[0]["emailID"].ToString();
            }
        }
    }

    protected void bindstate(int cid)
    {
        DataTable dtstate = new DataTable();
        dtstate = CommonClass.ABC1("Statedll", cid);
        if (dtstate.Rows.Count == 0)
        {
            ddlState.Items.Insert(0, new ListItem("Select State", ""));
            Utility.ViewAlertMessage(Page, "No state for this country");
            return;
        }

        ddlState.DataSource = dtstate;

        ddlState.DataTextField = "statename";
        ddlState.DataValueField = "sid";
        ddlState.DataBind();
    }

    protected void bindcity(int sid)
    {
        string strSql = "select ctId,cityName from city where cityName<>'Others' and sid=" + sid + " order by cityName";
        DataTable dtCity = objDUT.GetDataTable(strSql);
        ddlCity.DataSource = dtCity;
        ddlCity.DataTextField = "cityName";
        ddlCity.DataValueField = "ctId";
        ddlCity.DataBind();
    }

    protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        string querystsateCount = "select COUNT(*) from STATE where CID=" + ddlCountry.SelectedValue + "";
        int statecount = Convert.ToInt32(objDUT.GetScalar(querystsateCount));
        if (statecount == 0)
        {
            lblStateMsg2.Visible = false;
            lblCountryMsg2.Visible = true;
            lblCountryMsg2.Text = "There is no state against this country!! Please add state in master settings.";
            ddlState.Items.Clear();
            ddlState.Items.Insert(0, new ListItem("Select State", "0"));

            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, new ListItem("Select City", "0"));
        }
        else
        {
            ddlState.Items.Clear();
            lblCountryMsg2.Visible = false;
            ddlState.DataSource = CommonClass.ABC1("Statedll", Convert.ToInt32(ddlCountry.SelectedValue));
            ddlState.DataTextField = "stateName";
            ddlState.DataValueField = "SID";
            ddlState.DataBind();
            ddlState.Items.Insert(0, new ListItem("Select State", "0"));
        }
    }

    protected void ddlState_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlCity.Items.Clear();
        int intStateId = Convert.ToInt32(ddlState.SelectedValue);
        DataTable dtCity = CommonClass.ABC1("Citydll", Convert.ToInt32(ddlState.SelectedValue));
        if (dtCity.Rows.Count == 0)
        {
            ddlCity.Items.Insert(0, new ListItem("Select Ctiy", ""));
            Utility.ViewAlertMessage(Page, "No city for this state");
            return;
        }
        ddlCity.DataSource = dtCity;
        ddlCity.DataTextField = "cityname";
        ddlCity.DataValueField = "ctid";
        ddlCity.DataBind();
        ddlCity.Items.Insert(0, new ListItem("Select City", "0"));
    }

    protected void ddlState_SelectedIndexChanged2(object sender, EventArgs e)
    {
        int intStateId = Convert.ToInt32(ddlState.SelectedValue);
        string querycityCount = "select COUNT(*) from CITY where SID=" + intStateId + "";
        int citycount = Convert.ToInt32(objDUT.GetScalar(querycityCount));
        if (citycount == 0)
        {
            lblStateMsg2.Visible = true;
            lblStateMsg2.Text = "There is no city against this state!! Please add city in master settings.";
            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, new ListItem("Select City", "0"));
        }
        else
        {
            lblStateMsg2.Visible = false;
            ddlCity.Items.Clear();
            string strSql = "select ctId,cityName from city where cityName<>'Others' and sid=" + intStateId + " order by cityName";
            DataTable dtCity = objDUT.GetDataTable(strSql);
            ddlCity.DataSource = dtCity;
            ddlCity.DataTextField = "cityName";
            ddlCity.DataValueField = "ctId";
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, new ListItem("Select City", "0"));
        }
    }

    protected void ddlPCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        string querystsateCount = "select COUNT(*) from STATE where CID=" + ddlPCountry.SelectedValue + "";
        int statecount = Convert.ToInt32(objDUT.GetScalar(querystsateCount));
        if (statecount == 0)
        {
            lblStateMsg.Visible = false;
            lblCountryMsg.Visible = true;
            lblCountryMsg.Text = "There is no state against this country!! Please add state in master settings.";
            ddlPstate.Items.Clear();
            ddlPstate.Items.Insert(0, new ListItem("Select State", "0"));
            ddlPCity.Items.Clear();
            ddlPCity.Items.Insert(0, new ListItem("Select City", "0"));
        }
        else
        {
            ddlPstate.Items.Clear();
            lblCountryMsg.Visible = false;
            ddlPstate.DataSource = CommonClass.ABC1("Statedll", Convert.ToInt32(ddlPCountry.SelectedValue));
            ddlPstate.DataTextField = "stateName";
            ddlPstate.DataValueField = "SID";
            ddlPstate.DataBind();
            ddlPstate.Items.Insert(0, new ListItem("Select State", "0"));
        }
    }

    protected void ddlPstate_SelectedIndexChanged(object sender, EventArgs e)
    {
        int intStateId = Convert.ToInt32(ddlPstate.SelectedValue);
        string querycityCount = "select COUNT(*) from CITY where SID=" + intStateId + "";
        int citycount = Convert.ToInt32(objDUT.GetScalar(querycityCount));
        if (citycount == 0)
        {
            lblStateMsg.Visible = true;
            lblStateMsg.Text = "There is no city against this state!! Please add city in master settings.";
            ddlPCity.Items.Clear();
            ddlPCity.Items.Insert(0, new ListItem("Select City", "0"));
        }
        else
        {
            lblStateMsg.Visible = false;
            ddlPCity.Items.Clear();
            string strSql = "select ctId,cityName from city where cityName<>'Others' and sid=" + intStateId + " order by cityName";
            DataTable dtCity = objDUT.GetDataTable(strSql);
            ddlPCity.DataSource = dtCity;
            ddlPCity.DataTextField = "cityName";
            ddlPCity.DataValueField = "ctId";
            ddlPCity.DataBind();
            ddlPCity.Items.Insert(0, new ListItem("Select City", "0"));
        }
    }

    protected void ddlState2_SelectedIndexChanged(object sender, EventArgs e)
    {
        int intStateId = Convert.ToInt32(ddlState2.SelectedValue);
        string querycityCount = "select COUNT(*) from CITY where SID=" + intStateId + "";
        int citycount = Convert.ToInt32(objDUT.GetScalar(querycityCount));
        if (citycount == 0)
        {
            lblstatmsg1.Visible = true;
            lblstatmsg1.Text = "There is no city against this state!! Please add city in master settings.";
            ddlCity2.Items.Clear();
            ddlCity2.Items.Insert(0, new ListItem("Select City", "0"));
        }
        else
        {
            lblstatmsg1.Visible = false;
            ddlCity2.Items.Clear();
            string strSql = "select ctId,cityName from city where cityName<>'Others' and sid=" + intStateId + " order by cityName";
            DataTable dtCity = objDUT.GetDataTable(strSql);
            ddlCity2.DataSource = dtCity;
            ddlCity2.DataTextField = "cityName";
            ddlCity2.DataValueField = "ctId";
            ddlCity2.DataBind();
            ddlCity2.Items.Insert(0, new ListItem("Select City", "0"));
        }
    }

    private void bindprobation(int propation)
    {
        string query = "select id,timeInMonth from tblProbationPeriod where id=" + propation + " order by timeInMonth";
        ddlProbationPeriod.DataSource = objDUT.GetDataTable(query);
        ddlProbationPeriod.DataTextField = "timeInMonth";
        ddlProbationPeriod.DataValueField = "id";
        ddlProbationPeriod.DataBind();
        ddlProbationPeriod.Items.Insert(0, new ListItem("Select Probation Period", ""));
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            string dob = ddlDOBMonth.SelectedValue + "/" + ddlDOBDay.SelectedValue + "/" + ddlDOBYear.SelectedValue;
            DateTime dt = Convert.ToDateTime(dob);
            string doj = txtDatejoining.Text;
            string dd = doj.Substring(0, 2);
            string mm = doj.Substring(3, 2);
            string yy = doj.Substring(6, 4);
            doj = mm + "/" + dd + "/" + yy;
            DateTime dt1 = Convert.ToDateTime(doj);
            SqlParameter[] param = new SqlParameter[80];
            param[0] = new SqlParameter("@brid", Session["BrBrid"]);
            param[1] = new SqlParameter("@refNo", txtRefNo.Text.Trim());
            param[2] = new SqlParameter("@staffID", "");
            if (ddlTitle.SelectedValue != "0")
            {
                param[3] = new SqlParameter("@title", ddlTitle.SelectedItem.Text);
            }
            else
            {
                param[3] = new SqlParameter("@title", "");
            }
            param[4] = new SqlParameter("@fname", txtFName.Text.Trim());
            param[5] = new SqlParameter("@mname", txtMName.Text.Trim());
            param[6] = new SqlParameter("@lname", txtLName.Text.Trim());
            if (ddlTitle.SelectedValue != "0")
            {
                param[7] = new SqlParameter("@gender", Convert.ToInt32(rdGender.SelectedValue));
            }
            else
            {
                param[7] = new SqlParameter("@gender", 0);
            }

            param[8] = new SqlParameter("@dob", dt);
            if (ddlCountry.SelectedValue != "0")
            {
                param[9] = new SqlParameter("@cid", Convert.ToInt32(ddlCountry.SelectedValue));
            }
            else
            {
                param[9] = new SqlParameter("@cid", 0);
            }
            if (ddlState.SelectedValue != "0")
            {
                param[10] = new SqlParameter("@sid", Convert.ToInt32(ddlState.SelectedValue));
            }
            else
            {
                param[10] = new SqlParameter("@sid", 0);
            }
            if (ddlCity.SelectedValue != "0")
            {
                param[11] = new SqlParameter("@ctid", Convert.ToInt32(ddlCity.SelectedValue));
            }
            else
            {
                param[11] = new SqlParameter("@ctid", 0);
            }
            param[12] = new SqlParameter("@address", txtAddressLine.Text.Trim());
            param[13] = new SqlParameter("@pinCode", txtPincode.Text.Trim());
            if (ddlCountry2.SelectedValue != "0")
            {
                param[14] = new SqlParameter("@Tcid", Convert.ToInt32(ddlCountry2.SelectedValue));
            }
            else
            {
                param[14] = new SqlParameter("@Tcid", 0);
            }
            if (ddlState2.SelectedValue != "0")
            {
                param[15] = new SqlParameter("@Tsid", Convert.ToInt32(ddlState2.SelectedValue));
            }
            else
            {
                param[15] = new SqlParameter("@Tsid", 0);
            }
            if (ddlCity2.SelectedValue != "0")
            {
                param[16] = new SqlParameter("@Tctid", Convert.ToInt32(ddlCity2.SelectedValue));
            }
            else
            {
                param[16] = new SqlParameter("@Tctid", 0);
            }
            param[17] = new SqlParameter("@Taddress", TextBox5.Text.Trim());
            param[18] = new SqlParameter("@TpinCode", TextBox6.Text.Trim());
            param[19] = new SqlParameter("@doj", dt1);
            param[20] = new SqlParameter("@salary", "");
            param[21] = new SqlParameter("@jobTitle", txtJobTitle.Text.Trim());

            if (ddlDesigNation.SelectedValue != "Select Designation")
            {
                param[22] = new SqlParameter("@desigType", Convert.ToInt16(ddlDesigNation.SelectedValue));
                param[23] = new SqlParameter("@designation", ddlDesigNation.SelectedItem.Text.Trim());
            }
            else
            {
                param[22] = new SqlParameter("@desigType", 0);
                param[23] = new SqlParameter("@designation", "");
            }
            param[24] = new SqlParameter("@department", "");
            param[25] = new SqlParameter("@departmentID", 0);

            if (ddlBranch.SelectedValue != "0")
            {
                param[26] = new SqlParameter("@branchID", Convert.ToInt32(ddlBranch.SelectedValue));
            }
            else
            {
                param[26] = new SqlParameter("@branchID", 0);
            }
            if ((ddlProbationPeriod.SelectedValue != "0"))
            {
                param[27] = new SqlParameter("@probationPeriond", Convert.ToInt16(ddlProbationPeriod.SelectedValue));
            }
            else
            {
                param[27] = new SqlParameter("@probationPeriond", 0);
            }
            param[28] = new SqlParameter("@hrName", txtHrName.Text.Trim());
            param[29] = new SqlParameter("@mobile", txtMobileNo2.Text.Trim());
            param[30] = new SqlParameter("@phone", txtPhoneNo.Text.Trim());
            param[31] = new SqlParameter("@emailID", txtEmailId.Text.Trim());
            param[32] = new SqlParameter("@messanger", txtInstant.Text.Trim());
            if (ddlHightqulification.SelectedValue != "0")
            {
                param[33] = new SqlParameter("@HQualificaton", ddlHightqulification.SelectedItem.Text);
            }
            else
            {
                param[33] = new SqlParameter("@HQualificaton", "");
            }
            if (ddlprofessionalqulification.SelectedValue != "0")
            {
                param[34] = new SqlParameter("@QQualificaton", ddlprofessionalqulification.SelectedItem.Text);
            }
            else
            {
                param[34] = new SqlParameter("@QQualificaton", "");
            }

            param[35] = new SqlParameter("@birthPlace", txtforbirthplace.Text);
            if (rblMStatus.SelectedValue != "0")
            {
                param[36] = new SqlParameter("@mStatus", Convert.ToInt32(rblMStatus.SelectedValue));
            }
            else
            {
                param[36] = new SqlParameter("@mStatus", Convert.ToInt32(rblMStatus.SelectedValue));
            }
            param[37] = new SqlParameter("@noOfChilds", txtChild.Text.Trim());
            param[38] = new SqlParameter("@father", txtF1name.Text.Trim());
            param[39] = new SqlParameter("@mother", txtMotherName.Text.Trim());
            param[40] = new SqlParameter("@panNo", txtPanNo.Text.Trim());
            param[41] = new SqlParameter("@voterIdNo", txtVoterNo.Text.Trim());
            param[42] = new SqlParameter("@aadharNo", txtAdharno.Text.Trim());
            param[43] = new SqlParameter("@dlNo", txtLicenseNo.Text.Trim());
            param[44] = new SqlParameter("@comments", txtComment.Text.Trim());
            if (fuPhoto.HasFile)
            {
                string fileexe = Path.GetExtension(fuPhoto.FileName);
                if (fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".gif")
                {
                    if (ViewState["photo1"] != null)
                    {
                        File.Delete(Server.MapPath("../facultyimage/" + ViewState["photo1"].ToString()));
                        finfoevent = new FileInfo(ViewState["photo1"].ToString());
                        finfoevent.Delete();
                    }
                    string filename = Path.GetFileName(fuPhoto.PostedFile.FileName);
                    string path = Server.MapPath("../facultyimage/");
                    fuPhoto.SaveAs(Server.MapPath("../facultyimage/" + ViewState["eid"].ToString() + filename));
                    param[45] = new SqlParameter("@photo", ViewState["eid"].ToString() + filename);
                }
                else
                {
                    param[45] = new SqlParameter("@photo", lblPhoto.Text);
                }
            }
            else
            {
                param[45] = new SqlParameter("@photo", lblPhoto.Text);
            }

            if (fuFather.HasFile)
            {
                using (var zip = new ZipFile())
                {
                    if (ViewState["cv1"] != null)
                    {
                        File.Delete(Server.MapPath("../userImage/" + ViewState["cv1"].ToString()));
                        finfoevent = new FileInfo(ViewState["cv1"].ToString());
                        finfoevent.Delete();
                    }
                    string filename = Path.GetFileName(fuFather.PostedFile.FileName);
                    string filenameWitoutextension = Path.GetFileNameWithoutExtension(fuFather.FileName);
                    int spacecount = filenameWitoutextension.IndexOf(' ');
                    if (spacecount == -1)
                    {
                        filenameWitoutextension = filenameWitoutextension.Trim();
                    }
                    else
                    {
                        filenameWitoutextension = filenameWitoutextension.Substring(0, spacecount);
                    }
                    string destdir = Server.MapPath(("../userImage/" + filenameWitoutextension + ".Zip"));
                    zip.Save(destdir);
                    param[46] = new SqlParameter("@cv", filenameWitoutextension + ".Zip");
                }
            }
            else
            {
                param[46] = new SqlParameter("@cv", lblCV.Text);
            }
            param[47] = new SqlParameter("@isDocumentSubmit", "");
            param[48] = new SqlParameter("@emailAlloted", txtEmailAlloted.Text.Trim());
            param[49] = new SqlParameter("@preOrganisation", txtPorganisation.Text.Trim());
            if (ddlPCountry.SelectedValue != "Select Country")
            {
                param[50] = new SqlParameter("@pCid", Convert.ToInt32(ddlPCountry.SelectedValue));
            }
            else
            {
                param[50] = new SqlParameter("@pCid", 0);
            }
            if (ddlPstate.SelectedValue != "Select State")
            {
                param[51] = new SqlParameter("@pSid", Convert.ToInt32(ddlPstate.SelectedValue));
            }
            else
            {
                param[51] = new SqlParameter("@pSid", 0);
            }
            if (ddlPCity.SelectedValue != "Select City")
            {
                param[52] = new SqlParameter("@pCtid", Convert.ToInt32(ddlPCity.SelectedValue));
            }
            else
            {
                param[52] = new SqlParameter("@pCtid", 0);
            }
            param[53] = new SqlParameter("@pPincode", txtPPincode.Text.Trim());
            param[54] = new SqlParameter("@pDesignation", txtPdesignation.Text.Trim());
            param[55] = new SqlParameter("@pSalary", txtPsalary.Text.Trim());
            if (txtDuration.Text.Trim() == "")
            {
                param[56] = new SqlParameter("@pDuration", 0);
            }
            else
            {
                param[56] = new SqlParameter("@pDuration", Convert.ToInt32(txtDuration.Text.Trim()));
            }

            if (txtPexperience.Text == "")
            {
                param[57] = new SqlParameter("@totalExperience", 0);
            }
            else
            {
                param[57] = new SqlParameter("@totalExperience", Convert.ToInt16(txtPexperience.Text.Trim()));
            }
            param[58] = new SqlParameter("@ref1Name", txtRef1Name.Text.Trim());
            param[59] = new SqlParameter("@ref1Contact", txtReContact1.Text.Trim());
            param[60] = new SqlParameter("@ref2Name", txtRef2Name.Text.Trim());
            param[61] = new SqlParameter("@ref2Contact", txtRefContact2.Text.Trim());
            param[62] = new SqlParameter("@bloodGroup", txtBGroup.Text.Trim());
            param[63] = new SqlParameter("@medicalCondition", txtmedicalCondition.Text.Trim());
            param[64] = new SqlParameter("@pastDeseas", txtPastDisease.Text.Trim());
            param[65] = new SqlParameter("@geneticDeseas", txtGeneticDisease.Text.Trim());
            param[66] = new SqlParameter("@anyAlergy", txtAnyEllergy.Text.Trim());
            param[67] = new SqlParameter("@accountNo", txtAccountNo.Text.Trim());
            param[68] = new SqlParameter("@bankName", txtBankName.Text.Trim());
            param[69] = new SqlParameter("@branchName", txtBranchName.Text.Trim());
            param[70] = new SqlParameter("@branchCode", txtBranchCode.Text.Trim());
            param[71] = new SqlParameter("@IFSC", txtIFSCCode.Text.Trim());
            param[72] = new SqlParameter("@passportNo", txtPassportNo.Text.Trim());
            param[73] = new SqlParameter("@pAddress", txtPaddress.Text.Trim());
            param[74] = new SqlParameter("@mode", 2);
            if (ddlHightqulification.SelectedValue != "0")
            {
                param[75] = new SqlParameter("@HQualificationID", Convert.ToInt32(ddlHightqulification.SelectedValue));
            }
            else
            {
                param[75] = new SqlParameter("@HQualificationID", 0);
            }
            if (ddlprofessionalqulification.SelectedValue != "0")
            {
                param[76] = new SqlParameter("@PQualificationID", Convert.ToInt32(ddlprofessionalqulification.SelectedValue));
            }
            else
            {
                param[76] = new SqlParameter("@PQualificationID", 0);
            }
            param[77] = new SqlParameter("@nationality", txtNationality.Text);
            param[78] = new SqlParameter("@intResult", Convert.ToInt32(0));
            param[78].Direction = ParameterDirection.Output;

            param[79] = new SqlParameter("@facid", Convert.ToInt32(ViewState["eid"]));

            int result = objDUT.ExecuteSqlSP(param, "usp_addEmp_Master");
            if (result == 2)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Appointment has been updated successfully.");
                Response.Redirect("appointed-employer-list.aspx");
            }
        }
        catch (Exception exx)
        {
        }
    }

    private void GenerateThumbnails(double scaleFactor, Stream sourcePath, string targetPath)
    {
        using (var image = System.Drawing.Image.FromStream(sourcePath))
        {
            var newWidth = (int)(image.Width * scaleFactor);
            var newHeight = (int)(image.Height * scaleFactor);
            var thumbnailImg = new Bitmap(newWidth, newHeight);
            var thumbGraph = Graphics.FromImage(thumbnailImg);
            thumbGraph.CompositingQuality = CompositingQuality.HighQuality;
            thumbGraph.SmoothingMode = SmoothingMode.HighQuality;
            thumbGraph.InterpolationMode = InterpolationMode.HighQualityBicubic;
            var imageRectangle = new Rectangle(0, 0, newWidth, newHeight);
            thumbGraph.DrawImage(image, imageRectangle);
            thumbnailImg.Save(targetPath, image.RawFormat);
        }
    }

    protected void txtEmailId_TextChanged(object sender, EventArgs e)
    {
        if (txtEmailId.Text != "")
        {
            if (!Utility.isValidEmail(txtEmailId.Text))
            {
                lblFemail.Visible = true;
                lblFemail.Text = "Please Enter Valid e-Mail Id.";
                txtEmailId.Text = "";
                txtEmailId.Focus();
                return;
            }
        }
        lblFemail.Visible = false;
    }

    protected void ddlPCity_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    protected void ddlCountry2_SelectedIndexChanged(object sender, EventArgs e)
    {
        string querystsateCount = "select COUNT(*) from STATE where CID=" + ddlCountry2.SelectedValue + "";
        int statecount = Convert.ToInt32(objDUT.GetScalar(querystsateCount));
        if (statecount == 0)
        {
            lblstatmsg1.Visible = false;
            lblcontymsg1.Visible = true;
            lblcontymsg1.Text = "There is no state against this country!! Please add state in master settings.";
            ddlState2.Items.Clear();
            ddlState2.Items.Insert(0, new ListItem("Select State", "0"));
            ddlCity2.Items.Clear();
            ddlCity2.Items.Insert(0, new ListItem("Select City", "0"));
        }
        else
        {
            ddlState2.Items.Clear();
            lblcontymsg1.Visible = false;
            ddlState2.DataSource = CommonClass.ABC1("Statedll", Convert.ToInt32(ddlCountry2.SelectedValue));
            ddlState2.DataTextField = "stateName";
            ddlState2.DataValueField = "SID";
            ddlState2.DataBind();
            ddlState2.Items.Insert(0, new ListItem("Select State", "0"));
        }
    }

    protected void ddlCity2_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    protected void lblcertificte_Click(object sender, EventArgs e)
    {
        string filepath = ViewState["cv1"].ToString();
        Response.ContentType = "application/octet-stream";
        Response.AppendHeader("Content-Disposition", "attachment;filename=" + filepath);
        string aaa = Server.MapPath("../userImage/" + filepath);
        Response.TransmitFile(Server.MapPath("../userImage/" + filepath));
        Response.End();
    }

    protected void ddlDOBMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    protected void ddlDOBDay_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
}