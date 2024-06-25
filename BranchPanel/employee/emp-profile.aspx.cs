using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Globalization;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;

public partial class BranchPanel_emp_profile : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();
    private Utility objUT = new Utility();
    private CommonClass objCL = new CommonClass();
    private DataTable dtTemp = null;
    private string query;
    private FileInfo finfoevent;
    private int refNo = 0;
    private int employeeid = 0, statusid = 0;
    private string refno = "", finalfilename = "", finalpicname = "", multifile = "";
    private string dob;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["empid"] != null)
            {
                employeeid = Convert.ToInt32(Session["empid"]);
            }
            if (!IsPostBack)
            {
                if (Request.QueryString.Count > 0)
                {
                    employeeid = Convert.ToInt32(Request.QueryString["id"].ToString());
                    Session["empid"] = employeeid;
                }
                txtRefNo.Enabled = false;
                FillExperience();
                FillDDL();
                filldetail();
            }
        }
        catch (Exception exp)
        {
            return;
        }
    }

    private DataRow dr;

    public void bind_education_grid(string qualifc, string board, string passingyear, string sess, string roll, string percent, string add)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Rownumber", typeof(int));
        dt.Columns.Add("qualification", typeof(string));
        dt.Columns.Add("education_board", typeof(string));
        dt.Columns.Add("passing_year", typeof(string));
        dt.Columns.Add("session", typeof(string));
        dt.Columns.Add("rollnumber", typeof(string));
        dt.Columns.Add("percentage", typeof(string));
        dt.Columns.Add("institute_address", typeof(string));
        dt.Columns.Add("institute_address_complete", typeof(string));

        string[] qualifcation = qualifc.Split('~');
        string[] edu_board = board.Split('~');
        string[] passyear = passingyear.Split('~');
        string[] session = sess.Split('~');
        string[] rollnum = roll.Split('~');
        string[] percentage = percent.Split('~');
        string[] address = add.Split('~');

        for (int i = 0; i < qualifcation.Length - 1; i++)
        {
            if (qualifcation[i].ToString() != "")
            {
                dr = dt.NewRow();
                string name = objDUT.GetScalar("select name from tblQualification where qid=" + Convert.ToInt32(qualifcation[i]) + " and status=1").ToString();

                dr[0] = i + 1;
                dr[1] = name;
                dr[2] = edu_board[i];
                dr[3] = passyear[i];
                dr[4] = session[i];
                dr[5] = rollnum[i];
                dr[6] = percentage[i];

                int length = address[i].Length;
                if (length > 10)
                {
                    dr[7] = address[i].Substring(0, 10) + "...";
                }
                else
                {
                    dr[7] = address[i];
                }
                dr[8] = address[i];
                dt.Rows.Add(dr);
            }
        }
        if (dt.Rows.Count > 0)
        {
            btnedit.Style.Add("display", "block");
            divforgrid.Style.Add("display", "block");
            grdOfferLetter.DataSource = dt;
            grdOfferLetter.DataBind();
        }
        else
        {
            grdOfferLetter.EmptyDataText = "Currently, Education detail is not available";
            grdOfferLetter.DataBind();
            divforgrid.Style.Add("display", "block");
            btnedit.Style.Add("display", "none");
        }
    }

    private void filldetail()
    {
        using (dtTemp = objCL.dtCommon(Session["empid"].ToString().Trim(), 3))
        {
            if (dtTemp.Rows.Count > 0)
            {
                bindImage();
                //==========General Details====================
                ViewState["eid"] = dtTemp.Rows[0]["eid"].ToString();
                qualification.Value = dtTemp.Rows[0]["qualificaton"].ToString();
                bord.Value = dtTemp.Rows[0]["education_board"].ToString();
                passingyear.Value = dtTemp.Rows[0]["passing_year"].ToString();
                session.Value = dtTemp.Rows[0]["session"].ToString();
                rollnumber.Value = dtTemp.Rows[0]["rollnumber"].ToString();
                percentage.Value = dtTemp.Rows[0]["percentage"].ToString();
                institute_address.Value = dtTemp.Rows[0]["institute_address"].ToString();

                try
                {
                    if (qualification.Value != "" && bord.Value != "" && passingyear.Value != "")
                    {
                        bind_education_grid(qualification.Value, bord.Value, passingyear.Value, session.Value, rollnumber.Value, percentage.Value, institute_address.Value);
                    }
                    else
                    {
                        string msg = "<span style='font-size:15px; color:Red;margin-left:10px'> No education details available.</span>";
                        grdOfferLetter.EmptyDataText = msg;
                        grdOfferLetter.DataBind();
                        divforgrid.Style.Add("display", "block");
                        btnedit.Style.Add("display", "block");
                    }
                }
                catch
                {
                }

                dob = dtTemp.Rows[0]["dob"].ToString();
                txtRefNo.Text = dtTemp.Rows[0]["refNo"].ToString();
                txtFName.Text = dtTemp.Rows[0]["fname"].ToString();
                txtMName.Text = dtTemp.Rows[0]["mName"].ToString();
                txtLName.Text = dtTemp.Rows[0]["lname"].ToString();
                ddlTitle.SelectedValue = dtTemp.Rows[0]["Titleid"].ToString();
                txtPincode.Text = dtTemp.Rows[0]["pinCode"].ToString();
                rdGender.SelectedValue = Convert.ToInt16(dtTemp.Rows[0]["gender"]).ToString();

                string[] array = new string[5];
                array = dob.Split('/', ' ');
                string day = Convert.ToInt32(array[1]).ToString();
                string month = Convert.ToInt32(array[0]).ToString();
                string year = Convert.ToInt32(array[2]).ToString().Trim();
                txtdob.Text = day + "/" + month + "/" + year;
                //====code for bind id proofs data==========
                if (dtTemp.Rows[0]["id_proof_id"].ToString() != "0")
                {
                    ddlidproof.SelectedValue = dtTemp.Rows[0]["id_proof_id"].ToString();
                    txtidproof.Text = dtTemp.Rows[0]["id_proof_number"].ToString();
                    txtidproof.Style.Add("display", "block");
                }
                else
                {
                    txtidproof.Style.Add("display", "none");
                }

                if (dtTemp.Rows[0]["residential_id"].ToString() != "0")
                {
                    ddlresidentioalproof.SelectedValue = dtTemp.Rows[0]["residential_id"].ToString();
                    txtresidenceproof.Text = dtTemp.Rows[0]["residential_proof_number"].ToString();
                    txtresidenceproof.Style.Add("display", "block");
                }
                else
                {
                    txtresidenceproof.Style.Add("display", "none");
                }

                if (dtTemp.Rows[0]["cv"].ToString() != "")
                {
                    hfforresume.Value = dtTemp.Rows[0]["cv"].ToString();
                }

                if (dtTemp.Rows[0]["experience_letter"].ToString() != "")
                {
                    hfforexperienceletter.Value = dtTemp.Rows[0]["experience_letter"].ToString();
                }

                if (dtTemp.Rows[0]["salary_slip"].ToString() != "")
                {
                    hfforsalaryslip.Value = dtTemp.Rows[0]["salary_slip"].ToString();
                }

                if (dtTemp.Rows[0]["appointment_letter"].ToString() != "")
                {
                    hfforappointment.Value = dtTemp.Rows[0]["appointment_letter"].ToString();
                }

                if (dtTemp.Rows[0]["resignation_letter"].ToString() != "")
                {
                    hfforresignation.Value = dtTemp.Rows[0]["resignation_letter"].ToString();
                }
                if (dtTemp.Rows[0]["offer_letter"].ToString() != "")
                {
                    hfforofferletter.Value = dtTemp.Rows[0]["offer_letter"].ToString();
                }

                txtforbirthplace.Text = dtTemp.Rows[0]["birthPlace"].ToString();

                if (dtTemp.Rows[0]["isDocumentSubmit"].ToString() != "")
                {
                    string documetlist = dtTemp.Rows[0]["isDocumentSubmit"].ToString();
                    string[] strArray = documetlist.Split(',');

                    foreach (string selectedval in strArray)
                    {
                        if (selectedval != "")
                        {
                            chkboxlistfordocuments.Items.FindByValue(selectedval).Selected = true;
                        }
                    }
                }

                if (dtTemp.Rows[0]["other_nationality_name"].ToString() != "")
                {
                    txtothernationality.Text = dtTemp.Rows[0]["other_nationality_name"].ToString();
                    divfornationality.Style.Add("display", "block");
                    rdblistfornationality.SelectedValue = "2";
                }
                else
                {
                    divfornationality.Style.Add("display", "none");
                    rdblistfornationality.SelectedValue = "1";
                }

                if (dtTemp.Rows[0]["mstatus"].ToString() != "")
                {
                    if (dtTemp.Rows[0]["mstatus"].ToString() == "2")
                    {
                        rblMStatus.SelectedValue = "2";
                        divfordependents.Style.Add("display", "block");
                    }
                    else
                    {
                        rblMStatus.SelectedValue = "1";
                        divfordependents.Style.Add("display", "none");
                    }
                }

                txtChild.Text = dtTemp.Rows[0]["noOfChilds"].ToString();
                txtComment.Text = dtTemp.Rows[0]["comments"].ToString();

                //===========Permanenet Address Details============
                if (dtTemp.Rows[0]["permanentaddresstype"].ToString() != "")
                {
                    if (dtTemp.Rows[0]["permanentaddresstype"].ToString() == "2")
                    {
                        rdbpermanentaddresstype.SelectedValue = "2";
                    }
                    else
                    {
                        rdbpermanentaddresstype.SelectedValue = "1";
                    }
                }
                txtAddressLine.Text = dtTemp.Rows[0]["address"].ToString();
                txtpermanentlandmark.Text = dtTemp.Rows[0]["permanent_address_landmark"].ToString();
                int cid = Convert.ToInt16(dtTemp.Rows[0]["CID"]);
                ddlCountry.SelectedValue = cid.ToString();

                string qu2 = "select * from state where cid=" + cid + " and sactive=1";
                ddlState.DataSource = objDUT.GetDataTable(qu2);
                ddlState.DataTextField = "statename";
                ddlState.DataValueField = "sid";
                ddlState.DataBind();
                ddlState.Items.Insert(0, new ListItem("---Select State---", "0"));

                int sid = Convert.ToInt16((dtTemp.Rows[0]["SID"]));
                string quer3 = "select * from city where sid=" + sid + " and active=1";
                ddlCity.DataSource = objDUT.GetDataTable(quer3);
                ddlCity.DataTextField = "cityname";
                ddlCity.DataValueField = "ctid";
                ddlCity.DataBind();
                ddlCity.Items.Insert(0, new ListItem("---Select City---", "0"));
                int disid = Convert.ToInt16(dtTemp.Rows[0]["ctid"]);

                ddlState.SelectedValue = sid.ToString();
                if (disid == 0)
                {
                    ddlCity.SelectedValue = "0";
                    divforpermanentothercity.Style.Add("display", "block");
                    txtothercity2.Text = dtTemp.Rows[0]["permanentadd_othercity"].ToString();
                }
                else
                {
                    divforpermanentothercity.Style.Add("display", "none");
                    ddlCity.SelectedValue = disid.ToString();
                }

                //===========Current Address Details===============
                if (dtTemp.Rows[0]["currentaddresstype"].ToString() != "")
                {
                    if (dtTemp.Rows[0]["currentaddresstype"].ToString() == "2")
                    {
                        rdbforcurrentaddresstype.SelectedValue = "2";
                    }
                    else
                    {
                        rdbforcurrentaddresstype.SelectedValue = "1";
                    }
                }

                txtcurrentlandmark.Text = dtTemp.Rows[0]["current_address_landmark"].ToString();
                txtPhoneNo.Text = dtTemp.Rows[0]["phone"].ToString();
                txtEmailid.Text = dtTemp.Rows[0]["emailID"].ToString();
                txtcurrentaddress.Text = dtTemp.Rows[0]["Taddress"].ToString();
                txtpincode2.Text = dtTemp.Rows[0]["TPincode"].ToString();
                txtContactNo.Text = dtTemp.Rows[0]["mobile"].ToString();

                if (Convert.ToInt16(dtTemp.Rows[0]["tcid"]) != 0)
                {
                    ddlCountry2.SelectedValue = Convert.ToInt16(dtTemp.Rows[0]["tcid"]).ToString();
                }
                else
                {
                    ddlCountry2.SelectedValue = "0";
                }
                int Tcid = Convert.ToInt16(dtTemp.Rows[0]["Tcid"]);
                string qu1 = "select * from state where cid=" + Tcid + " and sactive=1";
                ddlState2.DataSource = objDUT.GetDataTable(qu1);
                ddlState2.DataTextField = "statename";
                ddlState2.DataValueField = "sid";
                ddlState2.DataBind();
                ddlState2.Items.Insert(0, new ListItem("---Select State---", "0"));

                if (Convert.ToInt16(dtTemp.Rows[0]["Tsid"]) != 0)
                {
                    ddlState2.SelectedValue = Convert.ToInt16(dtTemp.Rows[0]["Tsid"]).ToString();
                }
                else
                {
                    ddlState2.SelectedValue = "0";
                }
                int Tsid = Convert.ToInt16(dtTemp.Rows[0]["Tsid"]);
                string quer23 = "select * from city where sid=" + Tsid + " and active=1";

                ddlCity2.DataSource = objDUT.GetDataTable(quer23);
                ddlCity2.DataTextField = "cityname";
                ddlCity2.DataValueField = "ctid";
                ddlCity2.DataBind();
                ddlCity2.Items.Insert(0, new ListItem("---Select City---", "0"));
                if (Convert.ToInt16(dtTemp.Rows[0]["Tctid"]) != 0)
                {
                    ddlCity2.SelectedValue = Convert.ToInt16(dtTemp.Rows[0]["Tctid"]).ToString();
                    divforcurrentothercity.Style.Add("display", "none");
                }
                else
                {
                    ddlCity2.SelectedValue = "0";
                    divforcurrentothercity.Style.Add("display", "block");
                    txtcurrentadd_othercity.Text = dtTemp.Rows[0]["currentadd_othercity"].ToString();
                }

                //===========Gardians details==============
                txtF1name.Text = dtTemp.Rows[0]["father"].ToString();
                txtMotherName.Text = dtTemp.Rows[0]["mother"].ToString();
                txtf1mobileno.Text = dtTemp.Rows[0]["fathercontactno"].ToString();
                txtmothermobileno.Text = dtTemp.Rows[0]["mothercontactno"].ToString();
                txtparentsaddress.Text = dtTemp.Rows[0]["parentsaddress"].ToString();
                txtfatheralternateno.Text = dtTemp.Rows[0]["father_alternate_no"].ToString();
                txtfatheremailid.Text = dtTemp.Rows[0]["father_emailid"].ToString();
                txtfatheroccupation.Text = dtTemp.Rows[0]["father_occupation"].ToString();

                Decimal fincome = Convert.ToDecimal(dtTemp.Rows[0]["father_annual_income"]);
                txtfatherannualincome.Text = fincome.ToString("0.00");

                //============Employement History===============
                txtPorganisation.Text = dtTemp.Rows[0]["preOrganisation"].ToString();
                txtPaddress.Text = dtTemp.Rows[0]["pAddress"].ToString();

                ViewState["desig"] = Convert.ToInt16(dtTemp.Rows[0]["desigtype"]);

                if (Convert.ToInt16(dtTemp.Rows[0]["Pcid"]) != 0)
                {
                    ddlPCountry.SelectedValue = Convert.ToInt16(dtTemp.Rows[0]["Pcid"]).ToString();
                }
                else
                {
                    ddlPCountry.SelectedValue = "0";
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

                txtPPincode.Text = dtTemp.Rows[0]["pPincode"].ToString();
                txtPdesignation.Text = dtTemp.Rows[0]["pDesignation"].ToString();
                txtPsalary.Text = Convert.ToDouble(dtTemp.Rows[0]["pSalary"]).ToString("0.00");

                string totalexperience = dtTemp.Rows[0]["totalexperience"].ToString();

                string[] totalexp = totalexperience.Split(',');

                ddlyear.SelectedValue = totalexp[0];

                ddlmonth.SelectedValue = totalexp[1];

                if (ddlyear.SelectedValue != "0" || ddlmonth.SelectedValue != "0" || ddlday.SelectedValue != "0")
                {
                    divforemploymenthistory.Style.Add("display", "block");
                }
                else
                {
                    divforemploymenthistory.Style.Add("display", "none");
                }
                //txtPexperience.Text = dtTemp.Rows[0]["totalexperience"].ToString();
                txtRef1Name.Text = dtTemp.Rows[0]["ref1Name"].ToString();
                txtReContact1.Text = dtTemp.Rows[0]["ref1Contact"].ToString();
                txtRef2Name.Text = dtTemp.Rows[0]["ref2Name"].ToString();
                txtRefContact2.Text = dtTemp.Rows[0]["ref2Contact"].ToString();

                //================Medical Details=====================
                txtBGroup.Text = dtTemp.Rows[0]["bloodGroup"].ToString();
                txtPastDisease.Text = dtTemp.Rows[0]["pastDeseas"].ToString();
                txtAnyEllergy.Text = dtTemp.Rows[0]["anyAlergy"].ToString();
                txtGeneticDisease.Text = dtTemp.Rows[0]["geneticDeseas"].ToString();
                txtmedicalCondition.Text = dtTemp.Rows[0]["medicalCondition"].ToString();

                //=================Account Details====================
                txtBankName.Text = dtTemp.Rows[0]["bankName"].ToString();
                txtAccountNo.Text = dtTemp.Rows[0]["accountNo"].ToString();
                txtIFSCCode.Text = dtTemp.Rows[0]["IFSC"].ToString();
                txtBranchCode.Text = dtTemp.Rows[0]["branchCode"].ToString();
                txtBranchName.Text = dtTemp.Rows[0]["branchName"].ToString();

                if (!string.IsNullOrEmpty(dtTemp.Rows[0]["photo"].ToString()))
                {
                    if (System.IO.File.Exists(HttpContext.Current.Server.MapPath("../../employeeimage/" + dtTemp.Rows[0]["photo"].ToString())))
                    {
                        ViewState["photo1"] = dtTemp.Rows[0]["photo"].ToString();
                    }
                }
                else
                {
                    ViewState["photo1"] = null;
                }

                txtbiometricdetails.Text = dtTemp.Rows[0]["AddBiometric_Card_No"].ToString();
                hdvforidproofupload.Value = dtTemp.Rows[0]["id_proof_file"].ToString();
                hdvforresidentialproofupload.Value = dtTemp.Rows[0]["residential_proof_file"].ToString();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No appointment letter available");
            }
        }
    }

    protected void DeleteOldfilefromfolder(string prevfile)
    {
        string[] strArray = prevfile.Split(',');
        foreach (string file in strArray)
        {
            if (file != "")
            {
                if (System.IO.File.Exists(HttpContext.Current.Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + file)))
                {
                    System.IO.File.Delete(HttpContext.Current.Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + file));
                }
            }
        }
    }

    protected void FillDDL()
    {
        ddlTitle.DataSource = CommonClass.ABC("ddlTitle");
        ddlTitle.DataTextField = "Title";
        ddlTitle.DataValueField = "Titleid";
        ddlTitle.DataBind();
        ddlTitle.Items.Insert(0, new ListItem("---Select Title---", "0"));

        ddlCountry.DataSource = CommonClass.ABC("Countrydll");
        ddlCountry.DataTextField = "countryName";
        ddlCountry.DataValueField = "CID";
        ddlCountry.DataBind();
        ddlCountry.Items.Insert(0, new ListItem("---Select Country---", "0"));

        ddlPCountry.DataSource = CommonClass.ABC("Countrydll");
        ddlPCountry.DataTextField = "countryName";
        ddlPCountry.DataValueField = "CID";
        ddlPCountry.DataBind();
        ddlPCountry.Items.Insert(0, new ListItem("---Select Country---", "0"));

        ddlCountry2.DataSource = CommonClass.ABC("Countrydll");
        ddlCountry2.DataTextField = "countryName";
        ddlCountry2.DataValueField = "CID";
        ddlCountry2.DataBind();
        ddlCountry2.Items.Insert(0, new ListItem("---Select Country---", "0"));

        ddlidproof.DataSource = CommonClass.ABC("idproof");
        ddlidproof.DataTextField = "name";
        ddlidproof.DataValueField = "proof_id";
        ddlidproof.DataBind();
        ddlidproof.Items.Insert(0, new ListItem("---Select ID Proof---", "0"));

        ddlresidentioalproof.DataSource = CommonClass.ABC("residenceproof");
        ddlresidentioalproof.DataTextField = "name";
        ddlresidentioalproof.DataValueField = "proof_id";
        ddlresidentioalproof.DataBind();
        ddlresidentioalproof.Items.Insert(0, new ListItem("---Select Residential Proof---", "0"));
    }

    protected void FillExperience()
    {
        ddlyear.Items.Insert(0, new ListItem("---Years---", "0"));
        for (int i = 1; i <= 12; i++)
        {
            ddlyear.Items.Insert(i, new ListItem((i - 1).ToString(), (i - 1).ToString()));
        }

        ddlmonth.Items.Insert(0, new ListItem("---Months---", "0"));
        for (int i = 1; i <= 12; i++)
        {
            ddlmonth.Items.Insert(i, new ListItem((i - 1).ToString(), (i - 1).ToString()));
        }
        ddlday.Items.Insert(0, new ListItem("---Days---", "0"));
        for (int i = 0; i <= 30; i++)
        {
            ddlday.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
        }
    }

    protected void bindImage()
    {
        DataTable dtforimage = new DataTable();
        dtforimage.Columns.Add("ID", typeof(int));
        dtforimage.Columns.Add("ImageName", typeof(string));
        dtforimage.Columns.Add("Download", typeof(string));

        DataRow dr;

        DataTable dt = objDUT.GetDataTable("select cv from tblEmp_Master where eid=" + Convert.ToInt32(Session["empid"]) + "");
        if (dt.Rows.Count > 0)
        {
            int rownumber = 1;
            string imagename = dt.Rows[0]["cv"].ToString();
            string[] imagenames = imagename.Split(',');
            foreach (string image in imagenames)
            {
                if (image != "")
                {
                    dr = dtforimage.NewRow();
                    dr["ID"] = rownumber;
                    dr["ImageName"] = image;
                    dr["Download"] = "Download";
                    dtforimage.Rows.Add(dr);
                    rownumber += 1;
                }
            }
            if (dtforimage.Rows.Count > 0)
            {
                divresume.Visible = true;
                gridforimagename.DataSource = dtforimage;
                gridforimagename.DataBind();
            }
            else
            {
                divresume.Visible = false;
            }
        }
    }

    protected void btnSubmit_Click2(object sender, EventArgs e)
    {
        try
        {
            refno = objDUT.GetScalar("SELECT cast(RAND()*10000 as int) AS [RandomNumber]").ToString();

            string Fname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtFName.Text.Trim());
            string mname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtMName.Text.Trim());
            string lastname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtLName.Text.Trim());

            SqlParameter[] param = new SqlParameter[110];

            param[0] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));
            param[1] = new SqlParameter("@refNo", txtRefNo.Text.Trim());
            param[2] = new SqlParameter("@staffID", "");
            param[3] = new SqlParameter("@title", ddlTitle.SelectedValue);
            param[4] = new SqlParameter("@fname", Fname);
            param[5] = new SqlParameter("@mname", mname);
            param[6] = new SqlParameter("@lname", lastname);
            param[7] = new SqlParameter("@gender", Convert.ToInt16(rdGender.SelectedValue));

            string dobdate = Request.Form[txtdob.UniqueID];
            string[] dobdatearrya = dobdate.Split('/');
            dobdate = dobdatearrya[2] + '-' + dobdatearrya[1] + '-' + dobdatearrya[0];

            param[8] = new SqlParameter("@dob", dobdate);
            param[30] = new SqlParameter("@birthPlace", txtforbirthplace.Text.Trim());

            param[19] = new SqlParameter("@doj", "");
            param[9] = new SqlParameter("@cid", Convert.ToInt16(ddlCountry.SelectedValue));
            param[10] = new SqlParameter("@sid", Convert.ToInt16(Request.Form[ddlState.UniqueID]));
            param[11] = new SqlParameter("@ctid", Convert.ToInt16(Request.Form[ddlCity.UniqueID]));
            param[12] = new SqlParameter("@address", txtAddressLine.Text.Trim());
            param[13] = new SqlParameter("@pinCode", txtPincode.Text.Trim());
            param[14] = new SqlParameter("@Tcid", Convert.ToInt16(ddlCountry2.SelectedValue));
            param[15] = new SqlParameter("@Tsid", Convert.ToInt16(Request.Form[ddlState2.UniqueID]));
            param[16] = new SqlParameter("@Tctid", Convert.ToInt16(Request.Form[ddlCity2.UniqueID]));
            param[17] = new SqlParameter("@Taddress", txtcurrentaddress.Text.Trim());
            param[18] = new SqlParameter("@TpinCode", txtpincode2.Text.Trim());
            param[20] = new SqlParameter("@salary", 0.00);
            param[21] = new SqlParameter("@branchID", 0);
            param[22] = new SqlParameter("@probationPeriond", 0);
            param[23] = new SqlParameter("@hrName", "");
            param[24] = new SqlParameter("@mobile", txtContactNo.Text.Trim());
            param[25] = new SqlParameter("@phone", txtPhoneNo.Text.Trim());
            param[26] = new SqlParameter("@emailID", txtEmailid.Text.Trim());
            param[27] = new SqlParameter("@messanger", "");

            param[28] = new SqlParameter("@HQualificaton", txtqualification.Text.Trim());

            param[79] = new SqlParameter("@education_board", txtboard.Text.Trim());

            param[29] = new SqlParameter("@passing_year", txtyear.Text.Trim());

            param[80] = new SqlParameter("@session", txtsession.Text.Trim());

            param[31] = new SqlParameter("@mStatus", Convert.ToInt32(rblMStatus.SelectedValue));
            if (txtChild.Text != "")
            {
                param[32] = new SqlParameter("@noOfChilds", Convert.ToInt16(txtChild.Text));
            }
            else
            {
                param[32] = new SqlParameter("@noOfChilds", 0);
            }

            param[33] = new SqlParameter("@father", txtF1name.Text.Trim());
            param[34] = new SqlParameter("@mother", txtMotherName.Text.Trim());
            param[35] = new SqlParameter("@panNo", "");

            int idindex = ddlidproof.SelectedIndex;
            string idproof = CultureInfo.CurrentCulture.TextInfo.ToUpper(txtidproof.Text.Trim());

            if (idindex > 0)
            {
                param[36] = new SqlParameter("id_proof_id", ddlidproof.SelectedValue);
                param[38] = new SqlParameter("@id_proof_number", idproof);
            }
            else
            {
                param[36] = new SqlParameter("id_proof_id", "0");
                param[38] = new SqlParameter("@id_proof_number", "");
            }

            int resindex = ddlresidentioalproof.SelectedIndex;
            string residproof = CultureInfo.CurrentCulture.TextInfo.ToUpper(txtresidenceproof.Text.Trim());
            if (resindex > 0)
            {
                param[37] = new SqlParameter("@residential_id", ddlresidentioalproof.SelectedValue);
                param[77] = new SqlParameter("@residential_proof_number", residproof);
            }
            else
            {
                param[37] = new SqlParameter("@residential_id", "0");
                param[77] = new SqlParameter("@residential_proof_number", "");
            }

            param[39] = new SqlParameter("@comments", txtComment.Text.Trim());

            //if (fileuploadforcv.HasFiles)
            //{
            //    if (hfforresume.Value != "")
            //    {
            //        DeleteOldfilefromfolder(hfforresume.Value);
            //    }
            //    foreach (HttpPostedFile postedfile in fileuploadforcv.PostedFiles)
            //    {
            //        finalfilename = refno + postedfile.FileName;
            //        fileuploadforcv.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
            //        multifile += finalfilename + ",";
            //    }
            //    param[41] = new SqlParameter("@cv", multifile);
            //    multifile = "";
            //}
            if (fileuploadforcv.HasAttributes)
            {
                if (hfforresume.Value != "")
                {
                    DeleteOldfilefromfolder(hfforresume.Value);
                }
                HttpPostedFile postedfile = fileuploadforcv.PostedFile; 
                finalfilename = refno + postedfile.FileName;
                fileuploadforcv.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
                param[41] = new SqlParameter("@cv", multifile);
                multifile = "";
            }
            else
            {
                if (hfforresume.Value != "")
                {
                    param[41] = new SqlParameter("@cv", hfforresume.Value);
                }
                else
                {
                    param[41] = new SqlParameter("@cv", "");
                }
            }

            List<String> documentlist = new List<String>();
            foreach (ListItem item in chkboxlistfordocuments.Items)
            {
                if (item.Selected)
                {
                    documentlist.Add(item.Value);
                }
            }
            string finaldocs = String.Join(",", documentlist.ToArray());
            param[42] = new SqlParameter("@isDocumentSubmit", finaldocs);
            param[43] = new SqlParameter("@emailAlloted", "");
            param[44] = new SqlParameter("@preOrganisation", txtPorganisation.Text.Trim());
            param[45] = new SqlParameter("@pCid", Convert.ToInt16(Request.Form[ddlPCountry.UniqueID]));
            param[46] = new SqlParameter("@pSid", Convert.ToInt16(Request.Form[ddlPstate.UniqueID]));
            param[47] = new SqlParameter("@pCtid", Convert.ToInt16(Request.Form[ddlPCity.UniqueID]));
            param[48] = new SqlParameter("@pPincode", txtPPincode.Text.Trim());
            param[49] = new SqlParameter("@pDesignation", txtPdesignation.Text.Trim());
            if (txtPsalary.Text != "")
            {
                param[50] = new SqlParameter("@pSalary", Convert.ToDecimal(txtPsalary.Text.Trim()));
            }
            else
            {
                param[50] = new SqlParameter("@pSalary", 0.00);
            }
            param[51] = new SqlParameter("@pDuration", 0);
            string totalexperience = ddlyear.SelectedValue + "," + ddlmonth.SelectedValue + "," + ddlday.SelectedValue;
            param[52] = new SqlParameter("@totalExperience", totalexperience);
            param[53] = new SqlParameter("@ref1Name", txtRef1Name.Text.Trim());
            param[54] = new SqlParameter("@ref1Contact", txtReContact1.Text.Trim());
            param[55] = new SqlParameter("@ref2Name", txtRef2Name.Text.Trim());
            param[56] = new SqlParameter("@ref2Contact", txtRefContact2.Text.Trim());
            param[57] = new SqlParameter("@bloodGroup", txtBGroup.Text.Trim());
            param[58] = new SqlParameter("@medicalCondition", txtmedicalCondition.Text.Trim());
            param[59] = new SqlParameter("@pastDeseas", txtPastDisease.Text.Trim());
            param[60] = new SqlParameter("@geneticDeseas", txtGeneticDisease.Text.Trim());
            param[61] = new SqlParameter("@anyAlergy", txtAnyEllergy.Text.Trim());
            param[62] = new SqlParameter("@accountNo", txtAccountNo.Text.Trim());
            param[63] = new SqlParameter("@bankName", txtBankName.Text.Trim());
            param[64] = new SqlParameter("@branchName", txtBranchName.Text.Trim());
            param[65] = new SqlParameter("@branchCode", txtBranchCode.Text.Trim());

            string ifsc = CultureInfo.CurrentCulture.TextInfo.ToUpper(txtIFSCCode.Text.Trim());
            param[66] = new SqlParameter("@IFSC", ifsc);
            param[67] = new SqlParameter("@mode", 2);
            param[68] = new SqlParameter("@intResult", Convert.ToInt16(0));
            param[68].Direction = ParameterDirection.Output;

            if (fileuploadforpic.HasFile)
            {
                if (ViewState["photo1"] != null)
                {
                    if (System.IO.File.Exists(HttpContext.Current.Server.MapPath("../../employeeimage/" + (ViewState["photo1"].ToString()))))
                    {
                        System.IO.File.Delete(HttpContext.Current.Server.MapPath("../../employeeimage/" + (ViewState["photo1"].ToString())));
                    }
                }
                string filename = Path.GetFileName(fileuploadforpic.PostedFile.FileName);
                string targetPath = Server.MapPath(("../../employeeimage/" + refno + filename));
                Stream strm = fileuploadforpic.PostedFile.InputStream;
                var targetFile = targetPath;
                GenerateThumbnails(0.5, strm, targetFile);
                param[40] = new SqlParameter("@photo", refno + filename);
            }
            else
            {
                if (ViewState["photo1"] != null)
                {
                    param[40] = new SqlParameter("@photo", ViewState["photo1"].ToString());
                }
                else
                    param[40] = new SqlParameter("@photo", "");
            }

            param[69] = new SqlParameter("@department", "");
            param[70] = new SqlParameter("@departmentID", 0);
            param[71] = new SqlParameter("@jobTitle", "");
            param[72] = new SqlParameter("@desigType", 0);
            param[73] = new SqlParameter("@designation", "");
            param[74] = new SqlParameter("@facid", Convert.ToInt16(ViewState["eid"]));
            param[75] = new SqlParameter("@ctc", 0.00);
            param[76] = new SqlParameter("@ctcappliedfrom", "");

            param[78] = new SqlParameter("@pAddress", txtPaddress.Text.Trim());
            param[81] = new SqlParameter("@nationality", rdblistfornationality.SelectedValue);
            param[82] = new SqlParameter("@fathercontactno", txtf1mobileno.Text.Trim());
            param[83] = new SqlParameter("@mothercontactno", txtmothermobileno.Text.Trim());
            param[84] = new SqlParameter("@parentsaddress", txtparentsaddress.Text.Trim());
            param[85] = new SqlParameter("@pfno", "");
            param[86] = new SqlParameter("@esino", "");

            string biometric = CultureInfo.CurrentCulture.TextInfo.ToUpper(txtbiometricdetails.Text.Trim());
            param[87] = new SqlParameter("@AddBiometric_Card_No", biometric);
            param[88] = new SqlParameter("@employeetype", 0);
            param[89] = new SqlParameter("@current_address_landmark", txtcurrentlandmark.Text.Trim());
            param[90] = new SqlParameter("@permanent_address_landmark", txtpermanentlandmark.Text.Trim());
            param[91] = new SqlParameter("@other_nationality", txtothernationality.Text.Trim());
            //==========this code is for experience letter parameter==============
            //if (fileuploadforexperienceltr.HasFiles)
            //{
            //    if (hfforexperienceletter.Value != "")
            //    {
            //        DeleteOldfilefromfolder(hfforexperienceletter.Value);
            //    }

            //    foreach (HttpPostedFile postedfile in fileuploadforexperienceltr.PostedFiles)
            //    {
            //        finalfilename = refno + postedfile.FileName;
            //        fileuploadforexperienceltr.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
            //        multifile += finalfilename + ",";
            //    }
            //    param[92] = new SqlParameter("@experience_letter", multifile);
            //    multifile = "";
            //}
            if (fileuploadforexperienceltr.HasFile)
            {
                if (hfforexperienceletter.Value != "")
                {
                    DeleteOldfilefromfolder(hfforexperienceletter.Value);
                }

                HttpPostedFile postedfile = fileuploadforexperienceltr.PostedFile;
                finalfilename = refno + postedfile.FileName;
                fileuploadforexperienceltr.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
                param[92] = new SqlParameter("@experience_letter", multifile);
            }
            else
            {
                if (hfforexperienceletter.Value != "")
                {
                    param[92] = new SqlParameter("@experience_letter", hfforexperienceletter.Value);
                }
                else
                {
                    param[92] = new SqlParameter("@experience_letter", "");
                }
            }

            param[93] = new SqlParameter("@tds_account_number", "");
            param[94] = new SqlParameter("@father_alternate_no", txtfatheralternateno.Text.Trim());

            //============code for salary slip insert===========
            //if (fileuploadforsalaryslip.HasFiles)
            //{
            //    if (hfforsalaryslip.Value != "")
            //    {
            //        DeleteOldfilefromfolder(hfforsalaryslip.Value);
            //    }

            //    foreach (HttpPostedFile postedfile in fileuploadforsalaryslip.PostedFiles)
            //    {
            //        finalfilename = refno + postedfile.FileName;
            //        fileuploadforsalaryslip.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
            //        multifile += finalfilename + ",";
            //    }
            //    param[95] = new SqlParameter("@salary_slip", multifile);
            //    multifile = "";
            //}
            if (fileuploadforsalaryslip.HasFile)
            {
                if (hfforsalaryslip.Value != "")
                {
                    DeleteOldfilefromfolder(hfforsalaryslip.Value);
                }

                HttpPostedFile postedfile = fileuploadforsalaryslip.PostedFile;
                finalfilename = refno + postedfile.FileName;
                fileuploadforsalaryslip.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));

                param[95] = new SqlParameter("@salary_slip", multifile);
                multifile = "";
            }
            else
            {
                if (hfforsalaryslip.Value != "")
                {
                    param[95] = new SqlParameter("@salary_slip", hfforsalaryslip.Value);
                }
                else
                {
                    param[95] = new SqlParameter("@salary_slip", "");
                }
            }
            //============code for Appointment letter insert===========
            ////if (fileuploadforappointmentleter.HasFiles)
            ////{
            ////    if (hfforappointment.Value != "")
            ////    {
            ////        DeleteOldfilefromfolder(hfforappointment.Value);
            ////    }

            ////    foreach (HttpPostedFile postedfile in fileuploadforappointmentleter.PostedFiles)
            ////    {
            ////        finalfilename = refno + postedfile.FileName;
            ////        fileuploadforappointmentleter.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
            ////        multifile += finalfilename + ",";
            ////    }
            ////    param[96] = new SqlParameter("@appointment_letter", multifile);
            ////    multifile = "";
            ////}
            if (fileuploadforappointmentleter.HasFile)
            {
                if (hfforappointment.Value != "")
                {
                    DeleteOldfilefromfolder(hfforappointment.Value);
                }

                HttpPostedFile postedfile = fileuploadforappointmentleter.PostedFile;
                finalfilename = refno + postedfile.FileName;
                fileuploadforappointmentleter.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));

                param[96] = new SqlParameter("@appointment_letter", multifile);
                multifile = "";
            }
            else
            {
                if (hfforappointment.Value != "")
                {
                    param[96] = new SqlParameter("@appointment_letter", hfforappointment.Value);
                }
                else
                {
                    param[96] = new SqlParameter("@appointment_letter", "");
                }
            }

            //============code for resignation_letter letter insert===========
            //if (fileuploadforresignationltr.HasFiles)
            //{
            //    if (hfforresignation.Value != "")
            //    {
            //        DeleteOldfilefromfolder(hfforresignation.Value);
            //    }

            //    foreach (HttpPostedFile postedfile in fileuploadforresignationltr.PostedFiles)
            //    {
            //        finalfilename = refno + postedfile.FileName;
            //        fileuploadforresignationltr.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
            //        multifile += finalfilename + ",";
            //    }
            //    param[97] = new SqlParameter("@resignation_letter", multifile);
            //    multifile = "";
            //}
            if (fileuploadforresignationltr.HasFile)
            {
                if (hfforresignation.Value != "")
                {
                    DeleteOldfilefromfolder(hfforresignation.Value);
                }

                HttpPostedFile postedfile =fileuploadforresignationltr.PostedFile; 
                finalfilename = refno + postedfile.FileName;
                fileuploadforresignationltr.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
                param[97] = new SqlParameter("@resignation_letter", multifile);
                multifile = "";
            }
            else
            {
                if (hfforresignation.Value != "")
                {
                    param[97] = new SqlParameter("@resignation_letter", hfforresignation.Value);
                }
                else
                {
                    param[97] = new SqlParameter("@resignation_letter", "");
                }
            }

            //============code for Offer letter insert===========

            //if (fileuploadforofferletter.HasFiles)
            //{
            //    if (hfforofferletter.Value != "")
            //    {
            //        DeleteOldfilefromfolder(hfforofferletter.Value);
            //    }

            //    foreach (HttpPostedFile postedfile in fileuploadforofferletter.PostedFiles)
            //    {
            //        finalfilename = refno + postedfile.FileName;
            //        fileuploadforofferletter.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
            //        multifile += finalfilename + ",";
            //    }
            //    param[98] = new SqlParameter("@offer_letter", multifile);
            //    multifile = "";
            //}
            if (fileuploadforofferletter.HasFile)
            {
                if (hfforofferletter.Value != "")
                {
                    DeleteOldfilefromfolder(hfforofferletter.Value);
                }

                HttpPostedFile postedfile = fileuploadforofferletter.PostedFile; finalfilename = refno + postedfile.FileName;
                fileuploadforofferletter.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
                param[98] = new SqlParameter("@offer_letter", multifile);
                multifile = "";
            }
            else
            {
                if (hfforofferletter.Value != "")
                {
                    param[98] = new SqlParameter("@offer_letter", hfforofferletter.Value);
                }
                else
                {
                    param[98] = new SqlParameter("@offer_letter", "");
                }
            }

            param[99] = new SqlParameter("@rollnumber", txtrollnumber.Text.Trim());

            param[100] = new SqlParameter("@percentage", txtpercent.Text.Trim());

            param[101] = new SqlParameter("@institute_address", txtinstituteaddress.Text.Trim());

            param[102] = new SqlParameter("@father_emailid", txtfatheremailid.Text.Trim());

            param[103] = new SqlParameter("@father_occupation", txtfatheroccupation.Text.Trim());

            if (txtfatherannualincome.Text != "")
            {
                param[104] = new SqlParameter("@father_annual_income", Convert.ToDecimal(txtfatherannualincome.Text.Trim()));
            }
            else
            {
                param[104] = new SqlParameter("@father_annual_income", 0.00);
            }

            param[105] = new SqlParameter("@currentaddresstype", rdbforcurrentaddresstype.SelectedValue);
            param[106] = new SqlParameter("@permanentaddresstype", rdbpermanentaddresstype.SelectedValue);

            if (fileuploadforid.HasFile)
            {
                if (hdvforidproofupload.Value != "")
                {
                    DeleteOldfilefromfolder(hdvforidproofupload.Value);
                }
                string filename = Path.GetFileName(fileuploadforid.PostedFile.FileName);
                string finalfinalfilename = refno.ToString() + filename;
                Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfinalfilename);
                param[107] = new SqlParameter("@id_proof_file", finalfinalfilename);
            }
            else
            {
                if (hdvforidproofupload.Value != "")
                {
                    param[107] = new SqlParameter("@id_proof_file", hdvforidproofupload.Value);
                }
                else
                {
                    param[107] = new SqlParameter("@id_proof_file", "");
                }
            }

            if (fileuploadforresidential.HasFile)
            {
                if (hdvforresidentialproofupload.Value != "")
                {
                    DeleteOldfilefromfolder(hdvforresidentialproofupload.Value);
                }

                string filenameforres = Path.GetFileName(fileuploadforresidential.PostedFile.FileName);
                string ffn = refno.ToString() + filenameforres;
                Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + ffn);
                param[108] = new SqlParameter("@residential_proof_file", ffn);
            }
            else
            {
                if (hdvforresidentialproofupload.Value != "")
                {
                    param[108] = new SqlParameter("@residential_proof_file", hdvforresidentialproofupload.Value);
                }
                else
                {
                    param[108] = new SqlParameter("@residential_proof_file", "");
                }
            }

            if (Session["BrADID"] != null)
            {
                param[109] = new SqlParameter("@userid", Convert.ToInt32(Session["BrADID"]));
            }
            else
            {
                param[109] = new SqlParameter("@userid", 0);
            }

            int result = objDUT.ExecuteSqlSP(param, "usp_addEmp_Master");

            if (result == 2)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Profile has been updated successfully.");
            }
        }
        catch (Exception ex)
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

    private void reset()
    {
        txtFName.Text = "";
        txtMName.Text = "";
        txtLName.Text = "";
        ddlTitle.SelectedIndex = -1;
        ddlCountry.SelectedIndex = -1;
        ddlState.SelectedIndex = -1;
        ddlCity.SelectedIndex = -1;
        txtPincode.Text = "";
        txtContactNo.Text = "";
        txtEmailid.Text = "";
        txtAddressLine.Text = "";
    }

    protected void Cancel_Click(object sender, EventArgs e)
    {
    }

    //protected void lblcertificte_Click(object sender, EventArgs e)
    //{
    //    string filepath = ViewState["cv1"].ToString();
    //    Response.ContentType = "application/octet-stream";
    //    Response.AppendHeader("Content-Disposition", "attachment;filename=" + filepath);
    //    string aaa = Server.MapPath("../userImage/" + filepath);
    //    Response.TransmitFile(Server.MapPath("../userImage/" + filepath));
    //    Response.End();
    //}

    protected void lbldateofinterview_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkbtn = sender as LinkButton;
            GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
            Label lbl = (Label)gridforimagename.Rows[gvrow.RowIndex].FindControl("lblimagename");
            string filepath = lbl.Text;

            filepath = "~/branchpanel/employee/AppointedEmployeeDocs/" + filepath;
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filepath));
            Response.WriteFile(filepath);
            Response.End();
        }
        catch (Exception ex)
        {
        }
    }

    protected void empimage_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        try
        {
            if (ViewState["photo1"] != null)
            {
                string filepath = "~/employeeimage/" + ViewState["photo1"].ToString();
                Response.ContentType = ContentType;
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filepath));
                Response.WriteFile(filepath);
                Response.End();
            }
        }
        catch (Exception ex)
        {
        }
    }
}