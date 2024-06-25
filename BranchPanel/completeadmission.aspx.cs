using Ionic.Zip;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

public partial class BranchPanel_completeadmission : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private int num1 = 0;
    private SqlParameter[] param = new SqlParameter[2];
    private CommonClass commonobj = new CommonClass();
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private FileInfo finfoevent;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();

        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        getdate();

        if (!IsPostBack)
        {
            int x = Convert.ToInt32(objdut.GetScalar("select fyid from tbl_admission where adid=" + Session["stue"]));
            ViewState["fyid"] = x;
            fillCountry();
            fillCountry2();
            fillclass();
            if (Request.QueryString.Count > 0)
            {
                bool res = int.TryParse(Request.QueryString[0].ToString(), out num1);
                if (res == false)
                {
                    Response.Redirect("studentadmissionlistaspx.aspx", false);
                }
                else
                {
                    int studentadno = Convert.ToInt32(Request.QueryString[0]);
                    ViewState["adid"] = studentadno;
                    Session["ad"] = ViewState["adid"];
                    int result = Convert.ToInt32(objdut.GetScalar("select count(sturegno)as rid from tbl_Admission where status=1 and adid=" + studentadno + "  and fyid=" +                         Convert.ToInt32(ViewState["fyid"]) + " and brid=" + Convert.ToInt32(Session["BrBrid"])));
                    if (result == 1)
                    {
                        txtOfficer.Text = Convert.ToString(Session["Brusername"]);
                        showdetails(studentadno);
                    }
                    else
                    {
                        Response.Redirect("studentadmissionlistaspx.aspx");
                    }
                }
            }
        }
    }

    public void getdate()
    {
        string date = (DateTime.Today.Date).ToShortDateString();
        txtAdmDate.Text = date;
    }

    protected void ddlExStudent_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlExStudent.SelectedItem.Text == "Yes")
        {
            ll1.Visible = true;
            ll2.Visible = true;
            txtPEBRAddress.Visible = true;
            txtPPyear.Visible = true;
        }
        else
        {
            ll1.Visible = false;
            ll2.Visible = false;
            txtPEBRAddress.Visible = false;
            txtPPyear.Visible = false;
        }
    }

    protected void showdetails(int Prid)
    {
        int idStudent = Prid;
        string query = "Select *,tm.ADNO,tm.adid,tm.classid from student_master sm inner join tbl_Admission tm on sm.sturegno=tm.sturegno where tm.adid=" + idStudent + " and tm.brid=" + Convert.ToInt32(Session["BrBrid"]) + " and tm.fyid=" + Convert.ToInt32(ViewState["fyid"]);
        SqlDataReader dr = objdut.GetDataReader(query);
        dr.Read();
        if (dr.HasRows)
        {
            //-----Student Details--------//
            txtRegNo.Text = dr["ADNO"].ToString();
            TextBox2.Text = dr["FirstName"].ToString();
            TextBox11.Text = dr["MiddleName"].ToString();
            txtLName.Text = dr["LastName"].ToString();
            txtToDate.Text = Convert.ToDateTime(dr["DateofBirth"]).ToString("MMM dd yyyy");
            rbgender.SelectedValue = dr["Gender"].ToString();
            txtNation.Text = dr["Nationality"].ToString();
            txtBirthPlace.Text = dr["BirthPlace"].ToString();
            txtReligion.Text = dr["Religion"].ToString();
            txtMotherTongue.Text = dr["MotherTongue"].ToString();
            if (string.IsNullOrEmpty(dr["BloodID"].ToString()))
            {
                ddlBloodGroup.SelectedValue = "0";
            }
            else
            {
                ddlBloodGroup.SelectedValue = dr["BloodID"].ToString();
            }
            if (string.IsNullOrEmpty(dr["CategoryID"].ToString()))
            {
                ddlCategory.SelectedValue = "0";
            }
            else
            {
                ddlCategory.SelectedValue = dr["CategoryID"].ToString();
            }
            ddlClass.SelectedValue = dr["classid"].ToString();
            rbTransport.SelectedValue = dr["Transport"].ToString();
            if (dr["UploadChildPhoto"].ToString() != "")
            {
                lblStuPhoto.Text = dr["UploadChildPhoto"].ToString();
                ViewState["studPhoto"] = lblStuPhoto.Text;
            }
            else
            {
                ViewState["studPhoto"] = null;
                lblStuPhoto.Text = "";
            }
            if (dr["UploadBirthCirtificate"].ToString() != "")
            {
                lblBC.Text = dr["UploadBirthCirtificate"].ToString();
                ViewState["Cer"] = lblBC.Text;
                lbCertificate.Visible = true;
            }
            else
            {
                ViewState["Cer"] = null;
                lblBC.Text = "";
            }
            txtDocSubmitted.Text = dr["DocumentsSubmitted"].ToString();
            txtAddInfo.Text = dr["Comments"].ToString();

            //--------Father-----------//
            txtFFname.Text = dr["FfirstName"].ToString();
            txtFMname.Text = dr["FMiddleName"].ToString();
            txtFLname.Text = dr["FLastName"].ToString();

            if ((dr["FDateOfBirth"].ToString() == "Jan  1 1900 12:00AM"))
            {
                txtDate.Text = "";
            }
            else
            {
                txtDate.Text = dr["FDateOfBirth"].ToString();
            }
            txtFNation.Text = dr["FNationality"].ToString();
            if (string.IsNullOrEmpty(dr["FQualification"].ToString()))
            {
                ddlQualifiaction1.SelectedValue = "0";
            }
            else
            {
                ddlQualifiaction1.SelectedItem.Text = dr["FQualification"].ToString();
            }
            txtFOccup.Text = dr["FOccupation"].ToString();
            txtFDesig.Text = dr["FDesignation"].ToString();
            txtFON.Text = dr["FNameOfOrganisation"].ToString();
            txtAddressF.Text = dr["FBusinessAddress"].ToString();
            txtFPhone.Text = dr["FPhoneNo"].ToString();
            txtFMobile.Text = dr["FMobileNo"].ToString();
            txtFEmailid.Text = dr["FEmail"].ToString();
            if (dr["UploadFatherPhoto"].ToString() != "")
            {
                lblFather.Text = dr["UploadFatherPhoto"].ToString();
                ViewState["FPhoto"] = lblFather.Text;
            }
            else
            {
                ViewState["FPhoto"] = null;
                lblFather.Text = "";
            }

            //------------Mother------------//
            txtMFname.Text = dr["MFirstName"].ToString();
            txtMMname.Text = dr["MmiddleName"].ToString();
            txtMLname.Text = dr["MLastName"].ToString();

            if ((dr["MDateOfBirth"].ToString() == "Jan  1 1900 12:00AM"))
            {
                txtMDOB.Text = "";
            }
            else
            {
                txtMDOB.Text = dr["MDateOfBirth"].ToString();
            }
            txtMNation.Text = dr["MNationality"].ToString();
            // DropDownList1.SelectedItem.Text = dr["MQualification"].ToString();

            if (string.IsNullOrEmpty(dr["MQualification"].ToString()))
            {
                DropDownList1.SelectedValue = "0";
            }
            else
            {
                DropDownList1.SelectedItem.Text = dr["MQualification"].ToString();
            }

            txtMOccup.Text = dr["MOccupation"].ToString();
            txtMDesig.Text = dr["MDesignation"].ToString();
            txtMON.Text = dr["MNameOfOrganisation"].ToString();
            txtAddressM.Text = dr["MBusinessAddress"].ToString();
            txtMPhone.Text = dr["MPhoneNo"].ToString();
            txtMMobile.Text = dr["MMobileNo"].ToString();
            txtMEmailid.Text = dr["MEmail"].ToString();
            if (dr["UploadMotherPhoto"].ToString() != "")
            {
                lblmother.Text = dr["UploadMotherPhoto"].ToString();
                ViewState["MPhoto"] = lblmother.Text;
            }
            else
            {
                ViewState["MPhoto"] = null;
                lblmother.Text = "";
            }

            //-----------guardian-------------//
            if (dr["LfirstName"].ToString() != "")
            {
                TextBox1.Visible = true;
                l1.Visible = true;
                TextBox1.Text = dr["LfirstName"].ToString();
            }
            else
            {
                TextBox1.Visible = false;
                l1.Visible = false;
            }
            if (dr["LMiddleName"].ToString() != "")
            {
                txtmidnameg.Visible = true;
                txtmidnameg.Text = dr["LMiddleName"].ToString();
            }
            else
            {
                txtmidnameg.Visible = false;
                l1.Visible = false;
            }
            if (dr["LLastName"].ToString() != "")
            {
                txtlastg.Visible = true;
                txtlastg.Text = dr["LLastName"].ToString();
            }
            else
            {
                txtlastg.Visible = false;
                l1.Visible = false;
            }
            if (dr["LNationality"].ToString() != "")
            {
                l2.Visible = true;
                TextBox3.Visible = true;
                TextBox3.Text = dr["LNationality"].ToString();
            }
            else
            {
                TextBox3.Visible = false;
                l2.Visible = false;
            }
            if (dr["LQualificationID"].ToString() != "0")
            {
                DropDownList2.Visible = true;
                l3.Visible = true;
                DropDownList2.SelectedValue = dr["LQualificationID"].ToString();
            }
            else
            {
                DropDownList2.Visible = false;
                l3.Visible = false;
            }
            if (dr["LOccupation"].ToString() != "")
            {
                TextBox4.Visible = true;
                l4.Visible = true;
                TextBox4.Text = dr["LOccupation"].ToString();
            }
            else
            {
                TextBox4.Visible = false;
                l4.Visible = false;
            }
            if (dr["LDesignation"].ToString() != "")
            {
                TextBox5.Visible = true;
                l5.Visible = true;
                TextBox5.Text = dr["LDesignation"].ToString();
            }
            else
            {
                TextBox5.Visible = false;
                l5.Visible = false;
            }
            if (dr["LNameOfOrganisation"].ToString() != "")
            {
                TextBox6.Visible = true;
                l6.Visible = true;
                TextBox6.Text = dr["LNameOfOrganisation"].ToString();
            }
            else
            {
                TextBox6.Visible = false;
                l6.Visible = false;
            }
            if (dr["LBusinessAddress"].ToString() != "")
            {
                TextBox7.Visible = true;
                l7.Visible = true;
                TextBox7.Text = dr["LBusinessAddress"].ToString();
            }
            else
            {
                TextBox7.Visible = false;
                l7.Visible = false;
            }
            if (dr["LPhoneNo"].ToString() != "")
            {
                TextBox8.Visible = true;
                l8.Visible = true;
                TextBox8.Text = dr["LPhoneNo"].ToString();
            }
            else
            {
                TextBox8.Visible = false;
                l8.Visible = false;
            }
            if (dr["LMobileNo"].ToString() != "")
            {
                txtGISD.Visible = true;
                TextBox9.Visible = true;
                l9.Visible = true;
                TextBox9.Text = dr["LMobileNo"].ToString();
            }
            else
            {
                txtGISD.Visible = false;
                TextBox9.Visible = false;
                l9.Visible = false;
            }
            if (dr["LEmail"].ToString() != "")
            {
                l10.Visible = true;
                TextBox10.Visible = true;
                TextBox10.Text = dr["LEmail"].ToString();
            }
            else
            {
                TextBox10.Visible = false;
                l10.Visible = false;
            }

            //--------Permanent Address-----------//
            txtPAddress.Text = dr["Address"].ToString();
            if (Convert.ToInt32(dr["countryid"].ToString()) != 0)
            {
                ddlCountry1.SelectedValue = dr["countryid"].ToString();
            }
            if (Convert.ToInt32(dr["stateid"].ToString()) != 0)
            {
                ddlState1.Items.Clear();
                ddlState1.DataSource = CommonClass.ABC1("Statedll", Convert.ToInt32(dr["countryid"].ToString()));//commonobj.Dll("Statedll", Convert.ToInt32(dr["countryid"].ToString()));
                ddlState1.DataTextField = "stateName";
                ddlState1.DataValueField = "SID";
                ddlState1.DataBind();
                ddlState1.Items.Insert(0, new ListItem("--Select State--", "0"));
                ddlState1.SelectedValue = dr["stateid"].ToString();
            }
            if (Convert.ToInt32(dr["cityid"].ToString()) != 0)
            {
                ddlCity1.Items.Clear();
                ddlCity1.DataSource = CommonClass.ABC1("Citydll", Convert.ToInt32(dr["stateid"].ToString()));
                ddlCity1.DataTextField = "cityName";
                ddlCity1.DataValueField = "ctID";
                ddlCity1.DataBind();
                ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
                ddlCity1.SelectedValue = dr["cityid"].ToString();
            }
            txtPZIP.Text = dr["PINCode"].ToString();

            //----------Temporary Address----------//
            txtTAddress.Text = dr["TAddress"].ToString();
            // ddlcountry2.SelectedValue = dr["Tcountryid"].ToString();
            if (Convert.ToInt32(dr["Tcountryid"].ToString()) != 0)
            {
                ddlcountry2.SelectedValue = dr["Tcountryid"].ToString();
            }
            else
            {
                ddlcountry2.SelectedValue = "0";
            }
            // ddlState2.SelectedValue = dr["Tstateid"].ToString();
            if (Convert.ToInt32(dr["Tstateid"].ToString()) != 0)
            {
                ddlState2.Items.Clear();
                ddlState2.DataSource = CommonClass.ABC1("Statedll", Convert.ToInt32(dr["Tcountryid"].ToString()));
                ddlState2.DataTextField = "stateName";
                ddlState2.DataValueField = "SID";
                ddlState2.DataBind();
                ddlState2.Items.Insert(0, new ListItem("--Select State--", "0"));
                ddlState2.SelectedValue = dr["Tstateid"].ToString();
            }
            else
            {
                ddlState2.SelectedValue = "0";
            }
            //ddlCity2.SelectedValue = dr["Tcityid"].ToString();
            if (Convert.ToInt32(dr["Tcityid"].ToString()) != 0)
            {
                ddlCity2.Items.Clear();
                ddlCity2.DataSource = CommonClass.ABC1("Citydll", Convert.ToInt32(dr["Tstateid"].ToString()));
                ddlCity2.DataTextField = "cityName";
                ddlCity2.DataValueField = "ctID";
                ddlCity2.DataBind();
                ddlCity2.Items.Insert(0, new ListItem("--Select City--", "0"));
                ddlCity2.SelectedValue = dr["Tcityid"].ToString();
            }
            else
            {
                ddlCity2.SelectedValue = "0";
            }
            txtTZIP.Text = dr["PINCodeT"].ToString();

            //--------Previous History-------//
            txtPreSchool.Text = dr["Preschoolname"].ToString();
            if (string.IsNullOrEmpty(dr["preclassname"].ToString()))
            {
                ddlcurrentclass.SelectedValue = "0";
            }
            else
            {
                ddlcurrentclass.SelectedItem.Text = dr["preclassname"].ToString();
            }
            txtAcaYear.Text = dr["Academicyear"].ToString();

            //ddlPErcentage.SelectedItem.Text = dr["totalpercentage"].ToString();

            if (string.IsNullOrEmpty(dr["totalpercentage"].ToString()))
            {
                ddlPErcentage.SelectedValue = "0";
            }
            else
            {
                ddlPErcentage.SelectedItem.Text = dr["totalpercentage"].ToString();
            }

            txtReason.Text = dr["Reasonforleaving"].ToString();
            if (dr["uploadletestreportCard"].ToString() != "")
            {
                lblReport.Text = dr["uploadletestreportCard"].ToString();
                ViewState["Doc"] = lblReport.Text;
                lbPRogress.Visible = true;
            }
            else
            {
                ViewState["Doc"] = null;
                lblReport.Text = "";
            }

            //-----------Other details---------//
            if (Convert.ToInt32(dr["parentExstudent"]) == 1)
            {
                ll1.Visible = true;
                ll2.Visible = true;
                txtPPyear.Visible = true;
                txtPEBRAddress.Visible = true;
                ddlExStudent.SelectedValue = "1";
                txtPPyear.Text = dr["PAcademicyear"].ToString();
                txtPEBRAddress.Text = dr["Pbranchname"].ToString();
            }
            else
            {
                ddlExStudent.SelectedValue = "0";
                ll1.Visible = false;
                ll2.Visible = false;
                txtPPyear.Visible = false;
                txtPEBRAddress.Visible = false;
            }
            if (Convert.ToInt32(dr["ifstaffchild"]) == 1)
            {
                ll6.Visible = true;
                txtStaffMem.Visible = true;
                rbStaff.SelectedValue = "1";
                txtStaffMem.Text = dr["membername"].ToString();
            }
            else
            {
                ll6.Visible = false;
                txtStaffMem.Visible = false;
                rbStaff.SelectedValue = "0";
            }
            if (Convert.ToInt32(dr["ifsibling"]) == 1)
            {
                sib1.Visible = true;
                sib2.Visible = true;
                Label1.Visible = true;
                txtsibling.Visible = true;
                txtCSsibling.Visible = true;
                DropDownList3.Visible = true;
                rblSibling.SelectedValue = "1";
                txtsibling.Text = dr["siblingname"].ToString();
                txtCSsibling.SelectedValue = dr["SiblingClassid"].ToString();
                DropDownList3.Items.Clear();
                DropDownList3.DataSource = CommonClass.ABC("sectiondll", Convert.ToInt32(dr["SiblingClassid"].ToString()), Convert.ToInt32(Session["BrBrid"]));
                DropDownList3.DataTextField = "sectionname";
                DropDownList3.DataValueField = "cwsid";
                DropDownList3.DataBind();
                ListItem liS1 = new ListItem("--Select section--", "0");
                DropDownList3.Items.Insert(0, liS1);

                DropDownList3.SelectedValue = dr["SiblingSectionid"].ToString();
            }
            else
            {
                rblSibling.SelectedValue = "0";
                sib1.Visible = false;
                sib2.Visible = false;
                txtsibling.Visible = false;
                txtCSsibling.Visible = false;
                Label1.Visible = false;
                DropDownList3.Visible = false;
            }
            txtadmNo.Text = dr["ADNO"].ToString();
            // ViewState["adid"] = dr["adid"].ToString();
            txtClassSec.Text = ddlClass.SelectedItem.Text;
            imgstu.ImageUrl = "~/StudentPhoto/" + dr["UploadChildPhoto"].ToString();
            imgFather.ImageUrl = "~/FatherPhoto/" + dr["UploadFatherPhoto"].ToString();
            imgMother.ImageUrl = "~/MotherPhoto/" + dr["UploadMotherPhoto"].ToString();
            dr.Close();
        }
        else
        {
            dr.Close();
            lblMsg.Text = "Error in code";
        }
    }

    public void fillCountry()
    {
        ddlCountry1.DataSource = CommonClass.ABC("Countrydll");
        ddlCountry1.DataTextField = "countryName";
        ddlCountry1.DataValueField = "CID";
        ddlCountry1.DataBind();
        ddlCountry1.Items.Insert(0, new ListItem("--Select Country--", "0"));
        ddlState1.Items.Insert(0, new ListItem("--Select State--", "0"));
        ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
    }

    public void fillCountry2()
    {
        ddlcountry2.DataSource = CommonClass.ABC("Countrydll");//ClassInBranch
        ddlcountry2.DataTextField = "countryName";
        ddlcountry2.DataValueField = "CID";
        ddlcountry2.DataBind();
        ddlcountry2.Items.Insert(0, new ListItem("--Select Country--", "0"));
        ddlState2.Items.Insert(0, new ListItem("--Select State--", "0"));
        ddlCity2.Items.Insert(0, new ListItem("--Select City--", "0"));
    }

    public void fillclass()
    {
        // string query = "Select * from ClassBranch_master where BranchId=" + Convert.ToDouble(Session["BrBrid"]) + " and status=1";
        ddlClass.DataSource = CommonClass.ABC1("ClassInBranch", Convert.ToInt32(Session["BrBrid"]));//objdut.GetDataTable(query);
        ddlClass.DataTextField = "Classname";
        ddlClass.DataValueField = "classid";
        ddlClass.DataBind();
        ListItem li = new ListItem("--Select Class--", "0");
        ddlClass.Items.Insert(0, li);
        txtCSsibling.DataSource = CommonClass.ABC1("ClassInBranch", Convert.ToInt32(Session["BrBrid"]));// objdut.GetDataTable(query);
        txtCSsibling.DataTextField = "Classname";
        txtCSsibling.DataValueField = "classid";
        txtCSsibling.DataBind();
        ListItem li1 = new ListItem("--Select Class--", "0");
        txtCSsibling.Items.Insert(0, li1);
    }

    protected void cb1_CheckedChanged(object sender, EventArgs e)
    {
        if (cb1.Checked)
        {
            txtTAddress.Text = txtPAddress.Text;
            ddlcountry2.SelectedValue = ddlCountry1.SelectedValue;

            ddlState2.Items.Clear();
            // lblCountryMsg1.Visible = false;
            ddlState2.DataSource = CommonClass.ABC1("Statedll", Convert.ToInt32(ddlcountry2.SelectedValue));
            ddlState2.DataTextField = "stateName";
            ddlState2.DataValueField = "SID";

            ddlState2.DataBind();
            ddlState2.Items.Insert(0, new ListItem("--Select State--", "0"));
            ddlState2.SelectedValue = ddlState1.SelectedValue;

            ddlCity2.Items.Clear();

            DataTable dtCity = CommonClass.ABC1("Citydll", Convert.ToInt32(ddlState2.SelectedValue));//objdut.GetDataTable(strSql);
            ddlCity2.DataSource = dtCity;
            ddlCity2.DataTextField = "cityName";
            ddlCity2.DataValueField = "ctId";
            ddlCity2.DataBind();
            ddlCity2.Items.Insert(0, new ListItem("--Select City--", "0"));

            ddlCity2.SelectedValue = ddlCity1.SelectedValue;
            txtTZIP.Text = txtPZIP.Text;
        }
        else
        {
            ddlState2.Items.Clear();
            ddlState2.Items.Insert(0, new ListItem("--Select State--", "0"));
            ddlCity2.Items.Clear();
            ddlCity2.Items.Insert(0, new ListItem("--Select City--", "0"));
            txtTAddress.Text = "";
            ddlcountry2.SelectedValue = "0";
            ddlState2.SelectedValue = "0";
            ddlCity2.SelectedIndex = 0;
            txtTZIP.Text = "";
        }
    }

    protected void rblSibling_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rblSibling.SelectedItem.Text == "Yes")
        {
            //RequiredFieldValidator28.Enabled = true;
            //RequiredFieldValidator29.Enabled = true;
            sib1.Visible = true;
            sib2.Visible = true;
            txtCSsibling.Visible = true;
            txtsibling.Visible = true;
            Label1.Visible = true;
            DropDownList3.Visible = true;
        }
        else
        {
            //RequiredFieldValidator28.Enabled = false;
            //RequiredFieldValidator29.Enabled = false;
            sib1.Visible = false;
            sib2.Visible = false;
            txtCSsibling.Visible = false;
            txtsibling.Visible = false;
            Label1.Visible = false;
            DropDownList3.Visible = false;
        }
    }

    protected void cb2_CheckedChanged(object sender, EventArgs e)
    {
        if (cb1.Checked)
        {
            TextBox1.Visible = false;
            TextBox3.Visible = false;
            TextBox4.Visible = false;
            TextBox5.Visible = false;
            TextBox6.Visible = false;
            TextBox7.Visible = false;
            TextBox8.Visible = false;
            TextBox9.Visible = false;
            TextBox10.Visible = false;
            DropDownList2.Visible = false;
            l1.Visible = false; l2.Visible = false; l3.Visible = false; l4.Visible = false; l5.Visible = false; l6.Visible = false;
            l7.Visible = false; l8.Visible = false; l9.Visible = false; l10.Visible = false;
        }
        else
        {
            TextBox1.Visible = true;
            TextBox3.Visible = true;
            TextBox4.Visible = true;
            TextBox5.Visible = true;
            TextBox6.Visible = true;
            TextBox7.Visible = true;
            TextBox8.Visible = true;
            TextBox9.Visible = true;
            TextBox10.Visible = true;
            DropDownList2.Visible = true;
            l1.Visible = true; l2.Visible = true; l3.Visible = true; l4.Visible = true; l5.Visible = true; l6.Visible = true;
            l7.Visible = true; l8.Visible = true; l9.Visible = true; l10.Visible = true;
        }
    }

    protected void ddlCountry1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string querystsateCount = "select COUNT(*) from STATE where CID=" + ddlCountry1.SelectedValue + "";
        int statecount = Convert.ToInt32(objdut.GetScalar(querystsateCount));
        if (statecount == 0)
        {
            lblStateMsg1.Visible = false;
            lblCountryMsg1.Visible = true;
            lblCountryMsg1.Text = "There is no state against this country!! Please add state in master settings.";
            ddlState1.Items.Clear();
            ddlState1.Items.Insert(0, new ListItem("--Select State--", "0"));
            ddlCity1.Items.Clear();
            ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
        }
        else
        {
            //Bind State here
            ddlState1.Items.Clear();
            lblCountryMsg1.Visible = false;
            ddlState1.DataSource = CommonClass.ABC1("Statedll", Convert.ToInt32(ddlCountry1.SelectedValue));
            ddlState1.DataTextField = "stateName";
            ddlState1.DataValueField = "SID";

            ddlState1.DataBind();
            ddlState1.Items.Insert(0, new ListItem("--Select State--", "0"));
            //ddlState.SelectedValue = "33";
        }
    }

    protected void ddlState1_SelectedIndexChanged(object sender, EventArgs e)
    {
        int intStateId = Convert.ToInt32(ddlState1.SelectedValue);
        string querycityCount = "select COUNT(*) from CITY where SID=" + intStateId + "";
        int citycount = Convert.ToInt32(objdut.GetScalar(querycityCount));
        if (citycount == 0)
        {
            lblStateMsg1.Visible = true;
            lblStateMsg1.Text = "There is no city against this state!! Please add city in master settings.";
            ddlCity1.Items.Clear();
            ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
        }
        else
        {
            lblStateMsg1.Visible = false;
            ddlCity1.Items.Clear();
            string strSql = "select ctId,cityName from city where cityName<>'Others' and sid=" + intStateId + " order by cityName";
            DataTable dtCity = CommonClass.ABC1("Citydll", intStateId);// objdut.GetDataTable(strSql);
            ddlCity1.DataSource = dtCity;
            ddlCity1.DataTextField = "cityName";
            ddlCity1.DataValueField = "ctId";
            ddlCity1.DataBind();
            ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
        }
    }

    protected void ddlcountry2_SelectedIndexChanged(object sender, EventArgs e)
    {
        string querystsateCount2 = "select COUNT(*) from STATE where CID=" + ddlcountry2.SelectedValue + "";
        int statecount = Convert.ToInt32(objdut.GetScalar(querystsateCount2));
        if (statecount == 0)
        {
            lblState2.Visible = false;
            lblCountryMSg2.Visible = true;
            lblCountryMSg2.Text = "There is no state against this country!! Please add state in master settings.";
            ddlState2.Items.Clear();
            ddlState2.Items.Insert(0, new ListItem("--Select State--", "0"));
            ddlCity2.Items.Clear();
            ddlCity2.Items.Insert(0, new ListItem("--Select City--", "0"));
        }
        else
        {
            //Bind State here
            ddlState2.Items.Clear();
            lblCountryMSg2.Visible = false;
            ddlState2.DataSource = CommonClass.ABC1("Statedll", Convert.ToInt32(ddlcountry2.SelectedValue));
            ddlState2.DataTextField = "stateName";
            ddlState2.DataValueField = "SID";

            ddlState2.DataBind();
            ddlState2.Items.Insert(0, new ListItem("--Select State--", "0"));
            //ddlState.SelectedValue = "33";
        }
    }

    protected void ddlState2_SelectedIndexChanged(object sender, EventArgs e)
    {
        int intStateId2 = Convert.ToInt32(ddlState2.SelectedValue);
        string querycityCount2 = "select COUNT(*) from CITY where SID=" + intStateId2 + "";
        int citycount2 = Convert.ToInt32(objdut.GetScalar(querycityCount2));
        if (citycount2 == 0)
        {
            lblState2.Visible = true;
            lblState2.Text = "There is no city against this state!! Please add city in master settings.";
            ddlCity2.Items.Clear();
            ddlCity2.Items.Insert(0, new ListItem("--Select City--", "0"));
        }
        else
        {
            lblState2.Visible = false;
            ddlCity2.Items.Clear();

            DataTable dtCity = CommonClass.ABC1("Citydll", intStateId2);//objdut.GetDataTable(strSql);
            ddlCity2.DataSource = dtCity;
            ddlCity2.DataTextField = "cityName";
            ddlCity2.DataValueField = "ctId";
            ddlCity2.DataBind();
            ddlCity2.Items.Insert(0, new ListItem("--Select City--", "0"));
        }
    }

    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        if (CheckBox1.Checked)
        {
            l1.Visible = true; l2.Visible = true; l3.Visible = true; l4.Visible = true; l5.Visible = true; l6.Visible = true;
            l7.Visible = true; l8.Visible = true; l9.Visible = true; l10.Visible = true;
            TextBox1.Visible = true;
            TextBox3.Visible = true;
            TextBox4.Visible = true;
            TextBox5.Visible = true;
            TextBox6.Visible = true;
            TextBox7.Visible = true;
            TextBox8.Visible = true;
            TextBox9.Visible = true;
            TextBox10.Visible = true;
            txtmidnameg.Visible = true;
            txtlastg.Visible = true;
            DropDownList2.Visible = true;
            txtGISD.Visible = true;
        }
        else
        {
            ClearGuardian();
        }
    }

    protected void rbStaff_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rbStaff.SelectedItem.Text == "Yes")
        {
            ll6.Visible = true;
            txtStaffMem.Visible = true;
        }
        else
        {
            ll6.Visible = false;
            txtStaffMem.Visible = false;
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        checkValidation();
        if (checkValidation())
        {
            int idStudent = Convert.ToInt32(ViewState["adid"]);
            string brusername = (string)Session["Brusername"];
            int brID = Convert.ToInt32(Session["BrBrid"]);
            string pname = "usp_updateAdmission";
            SqlParameter[] param = new SqlParameter[100];
            //param 1 to 19 is student detail
            param[0] = new SqlParameter("@firstname", TextBox2.Text.Trim());

            param[97] = new SqlParameter("@brid", brID);
            param[98] = new SqlParameter("@fyid", Convert.ToInt32(ViewState["fyid"]));
            param[99] = new SqlParameter("@mode", "updateall");

            param[1] = new SqlParameter("@middlename", TextBox11.Text.Trim());
            param[2] = new SqlParameter("@lastname", txtLName.Text.Trim());
            param[3] = new SqlParameter("@dateofbirth", txtToDate.Text);
            param[4] = new SqlParameter("@gender", rbgender.SelectedValue);
            param[5] = new SqlParameter("@nationality", txtNation.Text.Trim());
            param[6] = new SqlParameter("@birthplace", txtBirthPlace.Text);
            param[7] = new SqlParameter("@religion", txtReligion.Text);
            param[8] = new SqlParameter("@mothertongue", txtMotherTongue.Text.Trim());
            if (ddlBloodGroup.SelectedValue != "0")
            {
                param[9] = new SqlParameter("@bloodgroup", ddlBloodGroup.SelectedItem.Text.Trim());
                param[10] = new SqlParameter("@bloodid", ddlBloodGroup.SelectedValue);
            }
            else
            {
                param[9] = new SqlParameter("@bloodgroup", "");
                param[10] = new SqlParameter("@bloodid", 0);
            }
            param[11] = new SqlParameter("@category", ddlCategory.SelectedItem.Text.Trim());
            param[12] = new SqlParameter("@categoryid", ddlCategory.SelectedValue);
            param[13] = new SqlParameter("@applyclass", ddlClass.SelectedItem.Text);
            param[14] = new SqlParameter("@classid", ddlClass.SelectedValue);
            param[15] = new SqlParameter("@transport", rbTransport.SelectedValue);

            if (fuPhoto.HasFile)
            {
                string fileexe = Path.GetExtension(fuPhoto.FileName);
                if (fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".gif")
                {
                    if (ViewState["studPhoto"] != null)
                    {
                        File.Delete(Server.MapPath("../StudentPhoto/" + ViewState["studPhoto"].ToString()));
                        finfoevent = new FileInfo(ViewState["studPhoto"].ToString());
                        finfoevent.Delete();
                    }
                    string filename = Path.GetFileName(fuPhoto.PostedFile.FileName);
                    string path = Server.MapPath("../StudentPhoto/");
                    fuPhoto.SaveAs(Server.MapPath("../StudentPhoto/" + idStudent + filename));
                    param[16] = new SqlParameter("@uploadchildphoto", idStudent + filename);
                }
                else
                {
                    param[16] = new SqlParameter("@uploadchildphoto", lblStuPhoto.Text);
                }
            }
            else
            {
                param[16] = new SqlParameter("@uploadchildphoto", lblStuPhoto.Text);
            }

            if (fuBirCet.HasFile)
            {
                using (var zip = new ZipFile())
                {
                    if (ViewState["Cer"] != null)
                    {
                        File.Delete(Server.MapPath("../StudentDocument/" + ViewState["Cer"].ToString()));
                        finfoevent = new FileInfo(ViewState["Cer"].ToString());
                        finfoevent.Delete();
                    }
                    string filename = Path.GetFileName(fuBirCet.PostedFile.FileName);
                    string filenameWitoutextension = Path.GetFileNameWithoutExtension(fuBirCet.FileName);
                    int spacecount = filenameWitoutextension.IndexOf(' ');
                    if (spacecount == -1)
                    {
                        filenameWitoutextension = filenameWitoutextension.Trim();
                    }
                    else
                    {
                        filenameWitoutextension = filenameWitoutextension.Substring(0, spacecount);
                    }
                    string destdir = Server.MapPath(("../StudentDocument/" + idStudent + filenameWitoutextension + ".Zip"));
                    zip.Save(destdir);
                    param[17] = new SqlParameter("@UploadBirthCirtificate", idStudent + filenameWitoutextension + ".Zip");
                }
            }
            else
            {
                param[17] = new SqlParameter("@UploadBirthCirtificate", lblBC.Text);
            }
            param[18] = new SqlParameter("@DocumentsSubmitted", txtDocSubmitted.Text.Trim());
            param[19] = new SqlParameter("@Comments", txtAddInfo.Text.Trim());

            //----------student Father's Details----------//
            param[20] = new SqlParameter("@FfirstName", txtFFname.Text.Trim());
            param[21] = new SqlParameter("@FMiddleName", txtFMname.Text.Trim());
            param[22] = new SqlParameter("@FLastName", txtFLname.Text.Trim());
            param[23] = new SqlParameter("@FDateOfBirth", "1-1-1990");
            param[24] = new SqlParameter("@FNationality", txtFNation.Text.Trim());
            param[25] = new SqlParameter("@FQualification", ddlQualifiaction1.SelectedItem.Text.Trim());
            param[26] = new SqlParameter("@FOccupation", txtFOccup.Text.Trim());
            param[27] = new SqlParameter("@FDesignation", txtFDesig.Text.Trim());
            param[28] = new SqlParameter("@FNameOfOrganisation", txtFON.Text.Trim());
            param[29] = new SqlParameter("@FBusinessAddress", txtAddressF.Text.Trim());

            if (fuFather.HasFile)
            {
                string fileexe = Path.GetExtension(fuFather.FileName);
                if (fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".gif")
                {
                    if (ViewState["FPhoto"] != null)
                    {
                        File.Delete(Server.MapPath("../FatherPhoto/" + ViewState["FPhoto"].ToString()));
                        finfoevent = new FileInfo(ViewState["FPhoto"].ToString());
                        finfoevent.Delete();
                    }
                    string filename = Path.GetFileName(fuFather.PostedFile.FileName);
                    string path = Server.MapPath("../FatherPhoto/");
                    fuFather.SaveAs(Server.MapPath("../FatherPhoto/" + idStudent + filename));
                    param[30] = new SqlParameter("@UploadFatherPhoto", idStudent + filename);
                }
                else
                {
                    param[30] = new SqlParameter("@UploadFatherPhoto", lblFather.Text);
                }
            }
            else
            {
                param[30] = new SqlParameter("@UploadFatherPhoto", lblFather.Text);
            }
            param[31] = new SqlParameter("@FPhoneNo", txtFPhone.Text.Trim());
            param[32] = new SqlParameter("@FMobileNo", txtFMobile.Text.Trim());
            param[33] = new SqlParameter("@FEmail", txtFEmailid.Text.Trim());
            //-----------Mother Details-----------//

            param[34] = new SqlParameter("@MfirstName", txtMFname.Text.Trim());
            param[35] = new SqlParameter("@MMiddleName", txtMMname.Text.Trim());
            param[36] = new SqlParameter("@MLastName", txtMLname.Text.Trim());
            param[37] = new SqlParameter("@MDateOfBirth", "1-1-1990");
            param[38] = new SqlParameter("@MNationality", txtMNation.Text.Trim());
            param[39] = new SqlParameter("@MQualification", DropDownList1.SelectedItem.Text.Trim());
            param[40] = new SqlParameter("@MOccupation", txtMOccup.Text.Trim());
            param[41] = new SqlParameter("@MDesignation", txtMDesig.Text.Trim());
            param[42] = new SqlParameter("@MNameOfOrganisation", txtMON.Text.Trim());
            param[43] = new SqlParameter("@MBusinessAddress", txtAddressM.Text.Trim());
            param[44] = new SqlParameter("@MPhoneNo", txtMPhone.Text.Trim());
            param[45] = new SqlParameter("@MMobileNo", txtMMobile.Text.Trim());
            if (FileUpload1.HasFile)
            {
                string fileexe = Path.GetExtension(FileUpload1.FileName);
                if (fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".gif")
                {
                    if (ViewState["MPhoto"] != null)
                    {
                        File.Delete(Server.MapPath("../MotherPhoto/" + ViewState["MPhoto"].ToString()));
                        finfoevent = new FileInfo(ViewState["MPhoto"].ToString());
                        finfoevent.Delete();
                    }
                    string filename = Path.GetFileName(FileUpload1.PostedFile.FileName);
                    string path = Server.MapPath("../MotherPhoto/");
                    FileUpload1.SaveAs(Server.MapPath("../MotherPhoto/" + idStudent + filename));
                    param[46] = new SqlParameter("@UploadMotherPhoto", idStudent + filename);
                }
                else
                {
                    param[46] = new SqlParameter("@UploadMotherPhoto", lblmother.Text);
                }
            }
            else
            {
                param[46] = new SqlParameter("@UploadMotherPhoto", lblmother.Text);
            }

            param[47] = new SqlParameter("@MEmail", txtMEmailid.Text.Trim());

            //-------Guardian Details---------//
            param[48] = new SqlParameter("@LfirstName", TextBox1.Text.Trim());
            param[49] = new SqlParameter("@LMiddleName", txtmidnameg.Text.Trim());
            param[50] = new SqlParameter("@LLastName", txtlastg.Text);
            param[51] = new SqlParameter("@LDateOfBirth", "1-1-1990");
            param[52] = new SqlParameter("@LNationality", TextBox3.Text.Trim());
            param[53] = new SqlParameter("@LQualification", DropDownList2.SelectedItem.Text.Trim());
            param[54] = new SqlParameter("@LOccupation", TextBox4.Text.Trim());
            param[55] = new SqlParameter("@LDesignation", TextBox5.Text.Trim());
            param[56] = new SqlParameter("@LNameOfOrganisation", TextBox6.Text.Trim());
            param[57] = new SqlParameter("@LBusinessAddress", TextBox7.Text.Trim());
            param[58] = new SqlParameter("@LPhoneNo", TextBox8.Text.Trim());
            param[59] = new SqlParameter("@LMobileNo", TextBox9.Text.Trim());
            param[60] = new SqlParameter("@LEmail", TextBox10.Text.Trim());

            //------Address Details-------//
            param[61] = new SqlParameter("@Address", txtPAddress.Text.Trim());
            param[62] = new SqlParameter("@countryid", ddlCountry1.SelectedItem.Value);
            param[63] = new SqlParameter("@countryname", ddlCountry1.SelectedItem.Text.Trim());
            param[64] = new SqlParameter("@stateid", ddlState1.SelectedItem.Value);
            param[65] = new SqlParameter("@statename", ddlState1.SelectedItem.Text.Trim());
            param[66] = new SqlParameter("@cityid", ddlCity1.SelectedItem.Value);
            param[67] = new SqlParameter("@cityname", ddlCity1.SelectedItem.Text.Trim());
            param[68] = new SqlParameter("@pincodeP", txtPZIP.Text.Trim());

            //-------Temp Address-----//
            param[69] = new SqlParameter("@TAddress", txtTAddress.Text.Trim());
            param[70] = new SqlParameter("@Tcountryid", ddlcountry2.SelectedItem.Value);
            param[71] = new SqlParameter("@Tcountryname", ddlcountry2.SelectedItem.Text.Trim());
            param[72] = new SqlParameter("@Tstateid", ddlState2.SelectedItem.Value);
            param[73] = new SqlParameter("@Tstatename", ddlState2.SelectedItem.Text.Trim());
            param[74] = new SqlParameter("@Tcityid", ddlCity2.SelectedItem.Value);
            param[75] = new SqlParameter("@Tcityname", ddlCity2.SelectedItem.Text.Trim());
            param[76] = new SqlParameter("@pincodeT", txtTZIP.Text);

            //------Previous School Details----//
            param[77] = new SqlParameter("@Preschoolname", txtPreSchool.Text.Trim());
            if (ddlcurrentclass.SelectedValue == "0")
            {
                param[78] = new SqlParameter("@Preclassname", "");
            }
            else
            {
                param[78] = new SqlParameter("@Preclassname", ddlcurrentclass.SelectedItem.Text.Trim());
            }
            param[79] = new SqlParameter("@Academicyear", txtAcaYear.Text.Trim());
            param[80] = new SqlParameter("@totalpercentage", ddlPErcentage.SelectedItem.Text.Trim());
            param[81] = new SqlParameter("@Reasonforleaving", txtReason.Text);
            if (fuProcard.HasFile)
            {
                using (var zip = new ZipFile())
                {
                    if (ViewState["Doc"] != null)
                    {
                        File.Delete(Server.MapPath("../StudentDocument/" + ViewState["Doc"].ToString()));
                        finfoevent = new FileInfo(ViewState["Doc"].ToString());
                        finfoevent.Delete();
                    }
                    string filename = Path.GetFileName(fuProcard.PostedFile.FileName);
                    string filenameWitoutextension = Path.GetFileNameWithoutExtension(fuProcard.FileName);
                    int spacecount = filenameWitoutextension.IndexOf(' ');
                    if (spacecount == -1)
                    {
                        filenameWitoutextension = filenameWitoutextension.Trim();
                    }
                    else
                    {
                        filenameWitoutextension = filenameWitoutextension.Substring(0, spacecount);
                    }
                    string destdir = Server.MapPath(("../StudentDocument/" + idStudent + filenameWitoutextension + ".Zip"));
                    zip.Save(destdir);
                    param[82] = new SqlParameter("@uploadletestreportCard", idStudent + filenameWitoutextension + ".Zip");
                }
            }
            else
            {
                param[82] = new SqlParameter("@uploadletestreportCard", lblReport.Text);
            }

            //------Ex Student Details-----//
            if (ddlExStudent.SelectedValue == "1")
            {
                param[83] = new SqlParameter("@parentExstudent", ddlExStudent.SelectedValue);
                param[84] = new SqlParameter("@PAcademicyear", txtPPyear.Text.Trim());
                param[85] = new SqlParameter("@Pbranchname", txtPEBRAddress.Text.Trim());
            }
            else
            {
                param[83] = new SqlParameter("@parentExstudent", 0);
                param[84] = new SqlParameter("@PAcademicyear", "");
                param[85] = new SqlParameter("@Pbranchname", "");
            }
            param[86] = new SqlParameter("@ifstaffchild", Convert.ToInt32(rbStaff.SelectedItem.Value));
            if (rbStaff.SelectedItem.Text == "Yes")
            {
                param[86] = new SqlParameter("@ifstaffchild", Convert.ToInt32(rbStaff.SelectedItem.Value));
                param[87] = new SqlParameter("@membername", txtStaffMem.Text);
            }
            else
            {
                param[86] = new SqlParameter("@ifstaffchild", 0);
                param[87] = new SqlParameter("@membername", "");
            }
            param[88] = new SqlParameter("@ifsibling", Convert.ToInt32(rblSibling.SelectedValue));
            if (rblSibling.SelectedItem.Text == "Yes")
            {
                param[88] = new SqlParameter("@ifsibling", Convert.ToInt32(rblSibling.SelectedValue));
                if (txtCSsibling.SelectedValue != "0")
                {
                    param[89] = new SqlParameter("@name", txtsibling.Text);
                    param[90] = new SqlParameter("@SiblingClass", txtCSsibling.SelectedItem.Text.Trim());
                    param[91] = new SqlParameter("@SiblingClassid", Convert.ToInt32(txtCSsibling.SelectedValue));
                    param[92] = new SqlParameter("@SiblingSection", DropDownList3.SelectedItem.Text.Trim());
                    param[93] = new SqlParameter("@SiblingSectionid", Convert.ToInt32(DropDownList3.SelectedValue));
                }
                else
                {
                    param[89] = new SqlParameter("@name", "");
                    param[90] = new SqlParameter("@SiblingClass", "");
                    param[91] = new SqlParameter("@SiblingClassid", 0);
                    param[92] = new SqlParameter("@SiblingSection", "");
                    param[93] = new SqlParameter("@SiblingSectionid", 0);
                }
            }
            else
            {
                param[88] = new SqlParameter("@ifsibling", 0);
                param[89] = new SqlParameter("@name", "");
                param[90] = new SqlParameter("@SiblingClass", "");
                param[91] = new SqlParameter("@SiblingClassid", 0);
                param[92] = new SqlParameter("@SiblingSection", "");
                param[93] = new SqlParameter("@SiblingSectionid", 0);
            }

            //--------------//
            param[94] = new SqlParameter("@status", 0);
            param[95] = new SqlParameter("@adid", idStudent);

            param[96] = new SqlParameter("@intResult", Convert.ToInt32("0"));
            param[96].Direction = ParameterDirection.Output;

            int count = objdut.ExecuteSqlSP(param, pname);
            if (count == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Admission completed successfully.");
                Response.Write("<script>alert('The update was successful!');window.location='studentadmissionlistaspx.aspx';</script>");
                //Response.Redirect("studentadmissionlistaspx.aspx");
            }
            else
            {
                //Response.Redirect("RegList.aspx");
                Utility.ViewAlertMessage(this.Master.Page, "There was an error updating the record. Redirecting you to the original page.");
                return;
            }
        }
    }

    public bool checkValidation()
    {
        //STUDENT DETAILS
        if (TextBox2.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please enter first name.");
            return false;
        }
        if (txtLName.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please enter last name.");
            return false;
        }

        if (txtToDate.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select date of birth.");
            return false;
        }

        if (ddlClass.SelectedItem.Value == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select the class applying for.");
            return false;
        }

        if (txtFFname.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please enter father's first name.");
            return false;
        }

        if (txtFLname.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please enter father's last name.");
            return false;
        }

        //if (txtMFname.Text == "")
        //{
        //    Utility.ViewAlertMessage(this.Master.Page, "Please enter mother's first name.");
        //    return false;
        //}
        //if (txtMLname.Text == "")
        //{
        //    Utility.ViewAlertMessage(this.Master.Page, "Please enter mother's last name.");
        //    return false;
        //}

        if (txtPAddress.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please enter permanent address details.");
            return false;
        }
        if (ddlCountry1.SelectedItem.Value == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select country in permanent address details.");
            return false;
        }
        if (ddlState1.SelectedItem.Value == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select state in permanent address details.");
            return false;
        }
        if (ddlCity1.SelectedItem.Value == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select city in permanent address details.");
            return false;
        }
        if (txtPZIP.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please enter the PIN code in permanent address details.");
            return false;
        }

        //if (txtCSsibling.SelectedItem.Value == "0")
        //{
        //    Utility.ViewAlertMessage(this.Master.Page, "Please enter class of siblings.");
        //    return false;
        //}

        //if (ddlcurrentclass.SelectedItem.Value == "0")
        //{
        //    Utility.ViewAlertMessage(this.Master.Page, "Please enter current class.");
        //    return false;
        //}

        return true;
    }

    protected void txtMEmailid_TextChanged(object sender, EventArgs e)
    {
        if (txtMEmailid.Text != "")
        {
            if (!Utility.isValidEmail(txtMEmailid.Text))
            {
                lblMemail.Visible = true;
                lblMemail.Text = "Please Enter Valid e-Mail Id !! ";
                txtMEmailid.Text = "";
                txtMEmailid.Focus();
                return;
            }
        }
        lblMemail.Visible = false;
    }

    protected void TextBox10_TextChanged(object sender, EventArgs e)
    {
        if (TextBox10.Text != "")
        {
            if (!Utility.isValidEmail(TextBox10.Text))
            {
                lblGemail.Visible = true;
                lblGemail.Text = "Please Enter Valid e-Mail Id !! ";
                TextBox10.Text = "";
                TextBox10.Focus();
                return;
            }
        }
        lblGemail.Visible = false;
    }

    protected void txtFEmailid_TextChanged(object sender, EventArgs e)
    {
        if (txtFEmailid.Text != "")
        {
            if (!Utility.isValidEmail(txtFEmailid.Text))
            {
                lblFemail.Visible = true;
                lblFemail.Text = "Please Enter Valid e-Mail Id !! ";
                txtFEmailid.Text = "";
                txtFEmailid.Focus();
                return;
            }
        }
        lblFemail.Visible = false;
    }

    protected void lbPRogress_Click(object sender, EventArgs e)
    {
        string filepath = ViewState["Doc"].ToString();
        Response.ContentType = "application/octet-stream";
        Response.AppendHeader("Content-Disposition", "attachment;filename=" + filepath);
        string aaa = Server.MapPath("../StudentDocument/" + filepath);
        Response.TransmitFile(Server.MapPath("../StudentDocument/" + filepath));
        Response.End();
    }

    protected void lbCertificate_Click(object sender, EventArgs e)
    {
        string filepath = ViewState["Cer"].ToString();
        Response.ContentType = "application/octet-stream";
        Response.AppendHeader("Content-Disposition", "attachment;filename=" + filepath);
        string aaa = Server.MapPath("../StudentDocument/" + filepath);
        Response.TransmitFile(Server.MapPath("../StudentDocument/" + filepath));
        Response.End();
    }

    protected void txtCSsibling_SelectedIndexChanged(object sender, EventArgs e)
    {
        string querySection = "select cwsid,sectionname from classwithsection where branchid=" + Convert.ToDouble(Session["BrBrid"]) + " and status=1 and classname='" + txtCSsibling.SelectedItem.Text + "'";
        DropDownList3.DataSource = CommonClass.ABC("sectiondll", Convert.ToInt32(txtCSsibling.SelectedValue), Convert.ToInt32(Session["BrBrid"]));
        DropDownList3.DataTextField = "sectionname";
        DropDownList3.DataValueField = "cwsid";
        DropDownList3.DataBind();
        ListItem li = new ListItem("--Select Section--", "0");
        DropDownList3.Items.Insert(0, li);
    }

    protected void ClearGuardian()
    {
        l1.Visible = false;
        l2.Visible = false;
        l3.Visible = false;
        l4.Visible = false;
        l5.Visible = false;
        l6.Visible = false;
        l7.Visible = false;
        l8.Visible = false;
        l9.Visible = false;
        l10.Visible = false;
        TextBox1.Visible = false;
        TextBox3.Visible = false;
        TextBox4.Visible = false;
        TextBox5.Visible = false;
        TextBox6.Visible = false;
        TextBox7.Visible = false;
        TextBox8.Visible = false;
        TextBox9.Visible = false;
        TextBox10.Visible = false;
        txtmidnameg.Visible = false;
        txtlastg.Visible = false;
        DropDownList2.Visible = false;
        txtGISD.Visible = false;
    }
}