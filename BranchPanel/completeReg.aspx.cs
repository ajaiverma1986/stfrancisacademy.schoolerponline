using Ionic.Zip;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

public partial class BranchPanel_comRegistration : System.Web.UI.Page
{
    private string url;

    private DataUtility objdut = new DataUtility();
    private CommonClass commonobj = new CommonClass();
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
            fillclass();
            if (Request.QueryString.Count > 0)
            {
                txtOfficer.Text = Convert.ToString(Session["Brusername"]);
                int stuRegID = Convert.ToInt32(Request.QueryString[0]);
                int studentadno = Convert.ToInt32(Request.QueryString[0]);
                ViewState["StuID"] = stuRegID;

                ViewState["stuadno"] = studentadno;
                showdetails();
            }
        }
    }

    public void getdate()
    {
        string date = (DateTime.Today.Date).ToShortDateString();
        txtAdmDate.Text = date;
    }

    protected void showdetails()
    {
        int idStudent = Convert.ToInt32(ViewState["StuID"]);
        string query = "Select * from tbl_StudentRegistration where Rid=" + idStudent;
        SqlDataReader dr = objdut.GetDataReader(query);
        dr.Read();
        if (dr.HasRows)
        {
            //-----Student Details--------//
            txtRegNo.Text = dr["RegistrationNo"].ToString();
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
                lblStuPhoto.Text = "";
                ViewState["studPhoto"] = null;
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
            if (!string.IsNullOrEmpty(dr["FQualification"].ToString()))
            {
                ddlQualifiaction1.SelectedItem.Text = dr["FQualification"].ToString();
            }
            else
            {
                ddlQualifiaction1.SelectedValue = "0";
            }

            txtincome.Text = string.Format("{0:n}", dr["parentincome"]);
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
                lblFather.Text = "fatherdemo.png";
                ViewState["FPhoto"] = lblFather.Text;
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
            if (!string.IsNullOrEmpty(dr["MQualification"].ToString()))
            {
                DropDownList1.SelectedItem.Text = dr["MQualification"].ToString();
            }
            else
            {
                DropDownList1.SelectedValue = "0";
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
                l1.Visible = true;
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
                l1.Visible = true;
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
            if (dr["LQualification"].ToString() != "")
            {
                DropDownList2.Visible = true;
                l3.Visible = true;
                DropDownList2.SelectedItem.Text = dr["LQualification"].ToString();
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
            txtcountry.Text = dr["countryname"].ToString();
            txtstate.Text = dr["statename"].ToString();
            txtcity.Text = dr["cityname"].ToString();
            txtPZIP.Text = dr["PINCode"].ToString();
            //----------Temporary Address----------//
            txtTAddress.Text = dr["TAddress"].ToString();
            ttxtcountry.Text = dr["Tcountryname"].ToString();
            ttxtstate.Text = dr["Tstatename"].ToString();
            ttxtcity.Text = dr["Tcityname"].ToString();
            txtTZIP.Text = dr["PINCodeT"].ToString();
            //--------Previous History-------//
            txtPreSchool.Text = dr["Preschoolname"].ToString();
            if (string.IsNullOrEmpty(dr["preclassname"].ToString()))
            {
                ddlcurrentclass.SelectedItem.Text = "Select Class";
            }
            else
            {
                ddlcurrentclass.SelectedItem.Text = dr["preclassname"].ToString();
            }
            txtAcaYear.Text = dr["Academicyear"].ToString();
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
                DropDownList3.DataSource = commonobj.Dll("sectiondll", Convert.ToInt32(dr["SiblingClassid"].ToString()), Convert.ToInt32(Session["BrBrid"]));
                DropDownList3.DataTextField = "sectionname";
                DropDownList3.DataValueField = "cwsid";
                DropDownList3.DataBind();
                ListItem liS1 = new ListItem("Select section", "0");
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
            txtadmNo.Text = dr["RegistrationNo"].ToString();
            txtClassSec.Text = ddlClass.SelectedItem.Text;

            //Displaying Images
            if (dr["UploadChildPhoto"].ToString() != "")
            {
                imgStudent.ImageUrl = "~/StudentPhoto/" + dr["UploadChildPhoto"].ToString();
            }
            if (dr["UploadFatherPhoto"].ToString() != "")
            {
                imgFather.ImageUrl = "~/FatherPhoto/" + dr["UploadFatherPhoto"].ToString();
            }
            if (dr["UploadMotherPhoto"].ToString() != "")
            {
                imgMother.ImageUrl = "~/MotherPhoto/" + dr["UploadMotherPhoto"].ToString();
            }
            dr.Close();
        }
        else
        {
            dr.Close();
            lblMsg.Text = "Error in code";
        }
    }
    public void fillclass()
    {
        string query = "Select * from ClassBranch_master where BranchId=" + Convert.ToDouble(Session["BrBrid"]) + " and status=1";
        ddlClass.DataSource = objdut.GetDataTable(query);
        ddlClass.DataTextField = "Classname";
        ddlClass.DataValueField = "classid";
        ddlClass.DataBind();
        ListItem li = new ListItem("Select Class", "0");
        ddlClass.Items.Insert(0, li);
        txtCSsibling.DataSource = objdut.GetDataTable(query);
        txtCSsibling.DataTextField = "Classname";
        txtCSsibling.DataValueField = "classid";
        txtCSsibling.DataBind();
        ListItem li1 = new ListItem("Select Class", "0");
        txtCSsibling.Items.Insert(0, li1);

        ListItem liS1 = new ListItem("Select section", "0");
        DropDownList3.Items.Insert(0, liS1);
    }

    protected void rblSibling_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rblSibling.SelectedItem.Text == "Yes")
        {
            sib1.Visible = true;
            sib2.Visible = true;
            txtCSsibling.Visible = true;
            txtsibling.Visible = true;
            Label1.Visible = true;
            DropDownList3.Visible = true;
        }
        else
        {
            sib1.Visible = false;
            sib2.Visible = false;
            txtCSsibling.Visible = false;
            txtsibling.Visible = false;
            Label1.Visible = false;
            DropDownList3.Visible = false;
        }
    }

    protected void cb1_CheckedChanged(object sender, EventArgs e)
    {
        if (cb1.Checked)
        {
            txtTAddress.Text = txtPAddress.Text;
            ttxtcountry.Text = txtcountry.Text.Trim();
            ttxtstate.Text = txtstate.Text.Trim();
            ttxtcity.Text = txtcity.Text.Trim();
            txtTZIP.Text = txtPZIP.Text;
        }
        else
        {      
            txtTAddress.Text = "";
            txtTZIP.Text = "";
            ttxtcountry.Text = "";
            ttxtstate.Text = "";
            ttxtcity.Text = "";
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

    public void reset()
    {
        TextBox2.Text = "";
        TextBox1.Text = "";
        TextBox3.Text = "";
        TextBox4.Text = "";
        TextBox5.Text = "";
        TextBox6.Text = "";
        TextBox7.Text = "";
        TextBox8.Text = "";
        TextBox9.Text = "";
        TextBox10.Text = "";
        TextBox11.Text = "";
        txtAcaYear.Text = "";
        txtAddInfo.Text = "";
        txtAddressF.Text = "";
        txtAddressM.Text = "";
        txtAdmDate.Text = "";
        txtadmNo.Text = "";
        txtBirthPlace.Text = "";
        txtClassSec.Text = "";
        txtCSsibling.Text = "";
        txtToDate.Text = "";
        txtDocSubmitted.Text = "";
        txtFDesig.Text = "";
        txtDate.Text = "";
        txtFEmailid.Text = "";
        txtFFname.Text = "";
        txtFLname.Text = "";
        txtFMname.Text = "";
        txtFMobile.Text = "";
        txtFNation.Text = "";
        txtFOccup.Text = "";
        txtFON.Text = "";
        txtFPhone.Text = "";
        txtLName.Text = "";
        txtMDesig.Text = "";
        txtMDOB.Text = "";
        txtMEmailid.Text = "";
        txtMFname.Text = "";
        txtMLname.Text = "";
        txtMMname.Text = "";
        txtMMobile.Text = "";
        txtMNation.Text = "";
        txtMOccup.Text = "";
        txtMON.Text = "";
        txtMotherTongue.Text = "";
        txtMPhone.Text = "";
        txtNation.Text = "";
        txtOfficer.Text = "";
        txtPAddress.Text = "";
        txtPEBRAddress.Text = "";
        txtPPyear.Text = "";
        txtPreSchool.Text = "";
        txtPZIP.Text = "";
        txtReason.Text = "";
        txtRegNo.Text = "";
        txtReligion.Text = "";
        txtsibling.Text = "";
        txtTAddress.Text = "";
        txtTZIP.Text = "";
        DropDownList1.SelectedValue = "0";
        DropDownList2.SelectedValue = "0";
        ddlBloodGroup.SelectedValue = "0";
        ddlCategory.SelectedValue = "0";
        ddlClass.SelectedValue = "0";
        ddlcurrentclass.SelectedValue = "0";
        ddlExStudent.SelectedValue = "0";
        ddlPErcentage.SelectedValue = "0";
        ddlQualifiaction1.SelectedValue = "0";
        rbStaff.SelectedValue = "1";
        rbgender.SelectedValue = "0";
        rbTransport.SelectedValue = "0";
        cb1.Checked = false;
        CheckBox1.Checked = false;
        txtcountry.Text = "";
        txtstate.Text = "";
        txtcity.Text = "";
        ttxtcountry.Text = "";
        ttxtstate.Text = "";
        ttxtcity.Text = "";
    }

    public bool checkValidation()
    {
        //STUDENT DETAILS
        if (TextBox2.Text == "")
        {
            Utility.ViewAlertMessage(this, "Please enter first name.");
            return false;
        }
        if (txtLName.Text == "")
        {
            Utility.ViewAlertMessage(this, "Please enter last name.");
            return false;
        }
        //if (txtNation.Text == "")
        //{
        //    Utility.ViewAlertMessage(this, "Please enter nationality.");
        //    return false;
        //}
        //if (txtBirthPlace.Text == "")
        //{
        //    Utility.ViewAlertMessage(this, "Please enter place of birth.");
        //    return false;
        //}
        if (txtToDate.Text == "")
        {
            Utility.ViewAlertMessage(this, "Please select date of birth.");
            return false;
        }

        if (ddlClass.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(this, "Please select the class applying for.");
            return false;
        }

        if (txtFFname.Text == "")
        {
            Utility.ViewAlertMessage(this, "Please enter father's first name.");
            return false;
        }

        if (txtFLname.Text == "")
        {
            Utility.ViewAlertMessage(this, "Please enter father's last name.");
            return false;
        }

        if (txtMFname.Text == "")
        {
            Utility.ViewAlertMessage(this, "Please enter mother's first name.");
            return false;
        }
        if (txtMLname.Text == "")
        {
            Utility.ViewAlertMessage(this, "Please enter mother's last name.");
            return false;
        }

        if (txtPAddress.Text == "")
        {
            Utility.ViewAlertMessage(this, "Please enter permanent address details.");
            return false;
        }
        if (txtcountry.Text.Trim()=="")
        {
            Utility.ViewAlertMessage(this, "Please enter country in permanent address details.");
            return false;
        }
        if (txtstate.Text.Trim()=="")
        {
            Utility.ViewAlertMessage(this, "Please enter state in permanent address details.");
            return false;
        }
        if (txtcity.Text.Trim()=="")
        {
            Utility.ViewAlertMessage(this, "Please enter city in permanent address details.");
            return false;
        }
        if (txtPZIP.Text == "")
        {
            Utility.ViewAlertMessage(this, "Please enter the PIN code in permanent address details.");
            return false;
        }

        return true;
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (checkValidation())
        {
            int idStudent = Convert.ToInt32(ViewState["StuID"]);
            string brusername = (string)Session["Brusername"];
            double brID = Convert.ToDouble(Session["BrBrid"]);
            string pname = "usp_studentRegistration";
            SqlParameter[] param = new SqlParameter[99];
            param[0] = new SqlParameter("@brid", brID);
            param[1] = new SqlParameter("@branchname", brusername);
            param[2] = new SqlParameter("@registrationdate", "");
            param[3] = new SqlParameter("@firstname", TextBox2.Text);
            param[4] = new SqlParameter("@middlename", TextBox11.Text);
            param[5] = new SqlParameter("@lastname", txtLName.Text);
            param[6] = new SqlParameter("@dateofbirth", txtToDate.Text);
            param[7] = new SqlParameter("@gender", rbgender.SelectedValue);
            param[8] = new SqlParameter("@nationality", txtNation.Text);
            param[9] = new SqlParameter("@birthplace", txtBirthPlace.Text);
            param[10] = new SqlParameter("@religion", txtReligion.Text);
            param[11] = new SqlParameter("@mothertongue", txtMotherTongue.Text.Trim());
            if (ddlBloodGroup.SelectedValue != "0")
            {
                param[12] = new SqlParameter("@bloodgroup", ddlBloodGroup.SelectedItem.Text);
            }
            else
            {
                param[12] = new SqlParameter("@bloodgroup", "");
            }
            param[13] = new SqlParameter("@category", ddlCategory.SelectedItem.Text);
            param[14] = new SqlParameter("@applyclass", ddlClass.SelectedItem.Text);
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
            param[18] = new SqlParameter("@DocumentsSubmitted", txtDocSubmitted.Text);
            param[19] = new SqlParameter("@Comments", txtAddInfo.Text);
            //----------Father Details----------//
            param[20] = new SqlParameter("@FfirstName", txtFFname.Text);
            param[21] = new SqlParameter("@FMiddleName", txtFMname.Text);
            param[22] = new SqlParameter("@FLastName", txtFLname.Text);
            param[23] = new SqlParameter("@FDateOfBirth", txtDate.Text);
            param[24] = new SqlParameter("@FNationality", txtFNation.Text);
            param[25] = new SqlParameter("@FQualification", ddlQualifiaction1.SelectedItem.Text);
            param[26] = new SqlParameter("@FOccupation", txtFOccup.Text);
            param[27] = new SqlParameter("@FDesignation", txtFDesig.Text);
            param[28] = new SqlParameter("@FNameOfOrganisation", txtFON.Text);
            param[29] = new SqlParameter("@FBusinessAddress", txtAddressF.Text);

            if (fuFather.HasFile)
            {
                string fileexe = Path.GetExtension(fuPhoto.FileName);
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
            param[31] = new SqlParameter("@FPhoneNo", txtFPhone.Text);
            param[32] = new SqlParameter("@FMobileNo", txtFMobile.Text);
            param[33] = new SqlParameter("@FEmail", txtFEmailid.Text);
            //-----------Mother Details-----------//

            param[34] = new SqlParameter("@MfirstName", txtMFname.Text);
            param[35] = new SqlParameter("@MMiddleName", txtMMname.Text);
            param[36] = new SqlParameter("@MLastName", txtMLname.Text);
            param[37] = new SqlParameter("@MDateOfBirth", txtMDOB.Text);
            param[38] = new SqlParameter("@MNationality", txtMNation.Text);
            param[39] = new SqlParameter("@MQualification", DropDownList1.SelectedItem.Text);
            param[40] = new SqlParameter("@MOccupation", txtMOccup.Text);
            param[41] = new SqlParameter("@MDesignation", txtMDesig.Text);
            param[42] = new SqlParameter("@MNameOfOrganisation", txtMON.Text);
            param[43] = new SqlParameter("@MBusinessAddress", txtAddressM.Text);
            if (FileUpload1.HasFile)
            {
                string fileexe = Path.GetExtension(fuPhoto.FileName);
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
                    param[44] = new SqlParameter("@UploadMotherPhoto", idStudent + filename);
                }
                else
                {
                    param[44] = new SqlParameter("@UploadMotherPhoto", lblmother.Text);
                }
            }
            else
            {
                param[44] = new SqlParameter("@UploadMotherPhoto", lblmother.Text);
            }
            param[45] = new SqlParameter("@MPhoneNo", txtMPhone.Text);
            param[46] = new SqlParameter("@MMobileNo", txtMMobile.Text);
            param[47] = new SqlParameter("@MEmail", txtMEmailid.Text);

            //-------Guardian Details---------//
            param[48] = new SqlParameter("@LfirstName", TextBox1.Text);
            param[49] = new SqlParameter("@LMiddleName", txtmidnameg.Text);
            param[50] = new SqlParameter("@LLastName", txtlastg.Text);
            param[51] = new SqlParameter("@LDateOfBirth", "");
            param[52] = new SqlParameter("@LNationality", TextBox3.Text);
            param[53] = new SqlParameter("@LQualification", DropDownList2.SelectedItem.Text);
            param[54] = new SqlParameter("@LOccupation", TextBox4.Text);
            param[55] = new SqlParameter("@LDesignation", TextBox5.Text);
            param[56] = new SqlParameter("@LNameOfOrganisation", TextBox6.Text);
            param[57] = new SqlParameter("@LBusinessAddress", TextBox7.Text);
            param[58] = new SqlParameter("@LPhoneNo", TextBox8.Text);
            param[59] = new SqlParameter("@LMobileNo", TextBox9.Text);
            param[60] = new SqlParameter("@LEmail", TextBox10.Text);

            //------Address Details-------//
            param[61] = new SqlParameter("@Address", txtPAddress.Text);
            param[62] = new SqlParameter("@countryname", txtcountry.Text.Trim());
            param[63] = new SqlParameter("@statename", txtstate.Text.Trim());
            param[64] = new SqlParameter("@cityname", txtcity.Text.Trim());
            param[65] = new SqlParameter("@pincodeP", txtPZIP.Text);

            //-------Temp Address-----//
            param[66] = new SqlParameter("@TAddress", txtTAddress.Text);
            param[67] = new SqlParameter("@Tcountryname", ttxtcountry.Text.Trim());
            param[68] = new SqlParameter("@Tstatename", ttxtstate.Text.Trim());
            param[69] = new SqlParameter("@Tcityname", ttxtcity.Text.Trim());
            param[70] = new SqlParameter("@pincodeT", txtTZIP.Text);
            //------Previous School Details----//
            param[71] = new SqlParameter("@schoolname", txtPreSchool.Text);
            if (ddlcurrentclass.SelectedItem.Text == "Select Class")
            {
                param[72] = new SqlParameter("@classname", "");
            }
            else
            {
                param[72] = new SqlParameter("@classname", ddlcurrentclass.SelectedItem.Text);
            }
            param[73] = new SqlParameter("@Academicyear", txtAcaYear.Text);
            param[74] = new SqlParameter("@totalpercentage", ddlPErcentage.SelectedItem.Text);
            param[75] = new SqlParameter("@Reasonforleaving", txtReason.Text);
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
                    param[76] = new SqlParameter("@uploadletestreportCard", idStudent + filenameWitoutextension + ".Zip");
                }
            }
            else
            {
                param[76] = new SqlParameter("@uploadletestreportCard", lblReport.Text);
            }

            //------Ex Student Details-----//
            if (ddlExStudent.SelectedValue == "1")
            {
                param[77] = new SqlParameter("@parentExstudent", ddlExStudent.SelectedValue);
                param[78] = new SqlParameter("@PAcademicyear", txtPPyear.Text);
                param[79] = new SqlParameter("@Pbranchname", txtPEBRAddress.Text);
            }
            else
            {
                param[77] = new SqlParameter("@parentExstudent", 0);
                param[78] = new SqlParameter("@PAcademicyear", "");
                param[79] = new SqlParameter("@Pbranchname", "");
            }
            if (rbStaff.SelectedItem.Text == "Yes")
            {
                param[80] = new SqlParameter("@ifstaffchild", Convert.ToInt32(rbStaff.SelectedItem.Value));
                param[81] = new SqlParameter("@membername", txtStaffMem.Text);
            }
            else
            {
                param[80] = new SqlParameter("@ifstaffchild", 0);
                param[81] = new SqlParameter("@membername", "");
            }
            if (rblSibling.SelectedItem.Text == "Yes")
            {
                param[82] = new SqlParameter("@ifsibling", Convert.ToInt32(rblSibling.SelectedValue));
                if (txtCSsibling.SelectedValue != "0")
                {
                    param[83] = new SqlParameter("@name", txtsibling.Text);
                    param[84] = new SqlParameter("@SiblingClass", txtCSsibling.SelectedItem.Text);
                    param[85] = new SqlParameter("@SiblingClassid", Convert.ToInt32(txtCSsibling.SelectedValue));
                    param[86] = new SqlParameter("@SiblingSection", DropDownList3.SelectedItem.Text);
                    param[87] = new SqlParameter("@SiblingSectionid", Convert.ToInt32(DropDownList3.SelectedValue));
                }
                else
                {
                    param[83] = new SqlParameter("@name", "");
                    param[84] = new SqlParameter("@SiblingClass", "");
                    param[85] = new SqlParameter("@SiblingClassid", 0);
                    param[86] = new SqlParameter("@SiblingSection", "");
                    param[87] = new SqlParameter("@SiblingSectionid", 0);
                }
            }
            else
            {
                param[82] = new SqlParameter("@ifsibling", 0);
                param[83] = new SqlParameter("@name", "");
                param[84] = new SqlParameter("@SiblingClass", "");
                param[85] = new SqlParameter("@SiblingClassid", 0);
                param[86] = new SqlParameter("@SiblingSection", "");
                param[87] = new SqlParameter("@SiblingSectionid", 0);
            }

            //--------------//
            param[88] = new SqlParameter("@status", 0);
            param[89] = new SqlParameter("@slipNo", "");
            param[90] = new SqlParameter("@slipid", Convert.ToInt32("0"));
            param[91] = new SqlParameter("@bloodid", ddlBloodGroup.SelectedValue);
            param[92] = new SqlParameter("@rid", idStudent);
            param[93] = new SqlParameter("@classid", ddlClass.SelectedValue);
            param[94] = new SqlParameter("@categoryid", ddlCategory.SelectedValue);
            if (ddlQualifiaction1.SelectedItem.Text != "" && DropDownList1.SelectedItem.Text != "")
            {
                int str1 = Convert.ToInt32(objdut.GetScalar("select priority from parentqualification where pqualification='" + ddlQualifiaction1.SelectedItem.Text + "'"));
                int str2 = Convert.ToInt32(objdut.GetScalar("select priority from parentqualification where pqualification='" + DropDownList1.SelectedItem.Text + "'"));
                if (str1 <= str2)
                {
                    param[95] = new SqlParameter("@Fpriority", str1);
                }
                else
                {
                    param[95] = new SqlParameter("@Fpriority", str2);
                }
            }

            if (ddlQualifiaction1.SelectedItem.Text != "" && DropDownList1.SelectedItem.Text == "")
            {
                int str1 = Convert.ToInt32(objdut.GetScalar("select priority from parentqualification where pqualification='" + ddlQualifiaction1.SelectedItem.Text + "'"));
                param[96] = new SqlParameter("@Fquali", str1);
            }

            else if (ddlQualifiaction1.SelectedItem.Text == "" && DropDownList1.SelectedItem.Text != "")
            {
                int str2 = Convert.ToInt32(objdut.GetScalar("select priority from parentqualification where pqualification='" + DropDownList1.SelectedItem.Text + "'"));
                param[96] = new SqlParameter("@Fquali", str2);
            }
            else
            {
                param[96] = new SqlParameter("@Fquali", 0);
            }

            if (string.IsNullOrEmpty(txtincome.Text))
            {
                param[97] = new SqlParameter("@Pincome", Convert.ToDouble(0));
            }
            else
            {
                param[97] = new SqlParameter("@Pincome", txtincome.Text.Trim());
            }
            param[98] = new SqlParameter("@intresult", Convert.ToInt32("0"));
            param[98].Direction = ParameterDirection.Output;
            int count = objdut.ExecuteSqlSP(param, pname);
            if (count == 1)
            {
                Utility.ViewAlertMessage(this, "Record updated successfully.");
                Response.Redirect("registration-list.aspx");
            }
            else
            {
                Utility.ViewAlertMessage(this, "There was an error updating the record. Redirecting you to the original page.");
                return;
            }
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

    protected void txtFEmailid_TextChanged(object sender, EventArgs e)
    {
        if (txtFEmailid.Text != "")
        {
            if (!Utility.isValidEmail(txtFEmailid.Text))
            {
                lblFemail.Visible = true;
                lblFemail.Text = "Please Enter Valid e-Mail Id.";
                txtFEmailid.Text = "";
                txtFEmailid.Focus();
                return;
            }
        }
        lblFemail.Visible = false;
    }

    protected void txtMEmailid_TextChanged(object sender, EventArgs e)
    {
        if (txtMEmailid.Text != "")
        {
            if (!Utility.isValidEmail(txtMEmailid.Text))
            {
                lblMemail.Visible = true;
                lblMemail.Text = "Please Enter Valid e-Mail Id.";
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
                lblGemail.Text = "Please Enter Valid e-Mail Id.";
                TextBox10.Text = "";
                TextBox10.Focus();
                return;
            }
        }
        lblGemail.Visible = false;
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

    protected void txtCSsibling_SelectedIndexChanged(object sender, EventArgs e)
    {
        string querySection = "select cwsid,sectionname from classwithsection where branchid=" + Convert.ToDouble(Session["BrBrid"]) + " and status=1 and classname='" + txtCSsibling.SelectedItem.Text + "'";
        DropDownList3.DataSource = objdut.GetDataTable(querySection);
        DropDownList3.DataTextField = "sectionname";
        DropDownList3.DataValueField = "cwsid";
        DropDownList3.DataBind();
        ListItem li = new ListItem("--Select Section--", "0");
        DropDownList3.Items.Insert(0, li);
    }

    //Downloading Documents
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
}