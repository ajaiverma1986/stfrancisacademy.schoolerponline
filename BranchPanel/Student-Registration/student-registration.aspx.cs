using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_student_registration : System.Web.UI.Page
{
    private string url = "", filename;
    private int IdStudent = 0, RID = 0;
    private DataUtility Objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {            
            if (Request.QueryString["RID"] != null)
            {
                BindAllDDLOfPage();
                RID = Convert.ToInt32(Request.QueryString["RID"]);
                FillDetails();
            }
            else
                BindAllDDLOfPage();
        }
    }

    [WebMethod]
    public static List<GetPermittedCheckBoxForCheck> CheckCheckboxOnTheBehalfOfPermission()
    {
        DataTable Dt;
        DataUtility Objdut = new DataUtility();
        List<GetPermittedCheckBoxForCheck> Details = new List<GetPermittedCheckBoxForCheck>();
        using (Dt = Objdut.GetDataTable("Select Field_Id_Or_Name,(Case When Isactive=1 Then 'block' Else 'none' End)As Status from tbl_registrationsettings where Status=1"))
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                GetPermittedCheckBoxForCheck obje = new GetPermittedCheckBoxForCheck();
                obje.DivName = Convert.ToString(Dt.Rows[i]["Field_Id_Or_Name"]);
                obje.Displaystatus = Convert.ToString(Dt.Rows[i]["Status"]);
                Details.Add(obje);
            }
        }
        return Details;
    }

    public class GetPermittedCheckBoxForCheck
    {
        public string DivName { get; set; }

        public string Displaystatus { get; set; }
    }

    protected void btnforupdateorsave_Click(object sender, EventArgs e)
    {
        int Count = 0;
        if (txtOldRegNo.Text.Trim() != "")
        {
            string Query = "Select Count(*) from tbl_StudentRegistration where RegNewNo='" + txtOldRegNo.Text.Trim() + "'";
            Count = Convert.ToInt32(Objdut.GetScalar(Query));
            if (Count > 0)
            {
                Utility.ViewAlertMessage(this, "Entered Old Admission No already Exists. please Enter Other");
                return;
            }
        }
        if (Count==0)
        {
            IdStudent = Convert.ToInt16(Objdut.GetScalar("select Isnull(MAX(RID),0)+1 from tbl_studentregistration where Brid=" + Convert.ToInt16(Session["BrBrid"])));
            SqlParameter[] Param = new SqlParameter[115];
            Param[00] = new SqlParameter("@Brid", Convert.ToInt32(Session["BrBrid"]));
            Param[01] = new SqlParameter("@Fyid", ddlregistrationsession.SelectedValue);
            Param[02] = new SqlParameter("@Registration_No", "");
            Param[03] = new SqlParameter("@RefrenceAdmissionNo", txtadmissionreferenceno.Text.Trim());
            Param[04] = new SqlParameter("@StudentFirstName", txtstudentfirstname.Text.Trim());
            Param[05] = new SqlParameter("@StudentMiddleName", txtstudentmiddlename.Text.Trim());
            Param[06] = new SqlParameter("@StudentLastName", txtstudentlastname.Text.Trim());
            Param[07] = new SqlParameter("@StudentDOB", txtstudentdob.Text.Trim());
            Param[08] = new SqlParameter("@Gender", rbtnlistgender.SelectedValue);
            Param[09] = new SqlParameter("@Nationality", rbtnlistnationality.SelectedValue);
            Param[10] = new SqlParameter("@CountryName", txtcountryname.Text.Trim());
            Param[11] = new SqlParameter("@BirthPlace", txtbirthplace.Text.Trim());
            Param[12] = new SqlParameter("@Religion", txtreligion.Text.Trim());
            Param[13] = new SqlParameter("@MotherTongue", txtmothertongue.Text.Trim());
            Param[14] = new SqlParameter("@NoOfSiblings", txtnoofsibbling.Text.Trim());
            Param[15] = new SqlParameter("@CastCategoryId", rbtnlistcast.SelectedValue);
            Param[16] = new SqlParameter("@CastCategoryName", rbtnlistcast.SelectedItem.Text.Trim());
            Param[17] = new SqlParameter("@ApplyingForClass", Request.Form[ddlapplyingforclass.UniqueID]);
            Param[18] = new SqlParameter("@TransportationRequired", rbtntransportationrequired.SelectedValue);
            if (fileuploaderofstudentphotograph.HasFile)
            {
                fileuploaderofstudentphotograph.PostedFile.SaveAs(Server.MapPath("~/BranchPanel/Student-Registration/student-registration-document/" + Convert.ToString(IdStudent) + fileuploaderofstudentphotograph.FileName));
                Param[19] = new SqlParameter("@StudentPhotograph", Convert.ToString(IdStudent) + fileuploaderofstudentphotograph.FileName);
            }
            else
            {
                Param[19] = new SqlParameter("@StudentPhotograph", "");
            }
            if (fileuploaderofbirthcertificate.HasFile)
            {
                fileuploaderofbirthcertificate.PostedFile.SaveAs(Server.MapPath("~/BranchPanel/Student-Registration/student-registration-document/" + fileuploaderofbirthcertificate.FileName + Convert.ToString(IdStudent)));
                Param[20] = new SqlParameter("@BirthCertificate", fileuploaderofbirthcertificate.FileName + Convert.ToString(IdStudent));
            }
            else
            {
                Param[20] = new SqlParameter("@BirthCertificate", "");
            }
            Param[21] = new SqlParameter("@DocumentSubmitted", txttotalsubmiteddocument.InnerText.Trim());
            Param[22] = new SqlParameter("@AdditionalInformation", txtadditionalinformation.InnerText.Trim());
            Param[23] = new SqlParameter("@Address", txtaddress.InnerText.Trim());
            Param[24] = new SqlParameter("@City", txtcity.Text.Trim());
            Param[25] = new SqlParameter("@State", txtstate.Text.Trim());
            Param[26] = new SqlParameter("@Pin", txtpiorzipcode.Text.Trim());
            Param[27] = new SqlParameter("@Country", txtcountry.Text.Trim());
            Param[28] = new SqlParameter("@BloodGroup", ddlbloodgroup.SelectedValue);
            Param[29] = new SqlParameter("@SchoolName", txtschoolname.Text.Trim());
            Param[30] = new SqlParameter("@SchoolBoard", txtboard.Text.Trim());
            Param[31] = new SqlParameter("@SchoolMedium", txtmedium.Text.Trim());
            Param[32] = new SqlParameter("@SchoolPreviousClassName", txtclassname.Text.Trim());
            Param[33] = new SqlParameter("@SchoolPercentageInPreviousClass", txtpreviusclsspercentage.Text.Trim());
            Param[34] = new SqlParameter("@SchoolAddress", txtschooladdress.InnerText.Trim());
            Param[35] = new SqlParameter("@SchoolContactNo", txtcontactno.Text.Trim());
            Param[36] = new SqlParameter("@SchoolAlternateContactNo", txtalternatecontactno.Text.Trim());
            Param[37] = new SqlParameter("@SchoolWebsite", txtwesite.Text.Trim());
            Param[38] = new SqlParameter("@PrimarySelectParentType", Request.Form[ddlparenttype.UniqueID]);
            Param[39] = new SqlParameter("@PrimaryParentFirstName", txtparentfirstname.Text.Trim());
            Param[40] = new SqlParameter("@PrimaryParentMiddleName", txtparentmiddlename.Text.Trim());
            Param[41] = new SqlParameter("@PrimaryParentLastName", txtparentlastname.Text.Trim());
            Param[42] = new SqlParameter("@PrimaryParentDOB", txtparentdateofbirth.Text.Trim());
            Param[43] = new SqlParameter("@TotalAge", 0);
            Param[44] = new SqlParameter("@PrimaryParentNationality", txtparentnationality.Text.Trim());
            Param[45] = new SqlParameter("@PrimaryHighestQualification", ddlparentqualification.SelectedValue);
            Param[46] = new SqlParameter("@PrimaryParentOccupation", txtparentoccupation.Text.Trim());
            Param[47] = new SqlParameter("@PrimaryDesignation", txtparentdesignation.Text.Trim());
            Param[48] = new SqlParameter("@PrimaryNameOfOrganization", txtparentorganization.Text.Trim());
            Param[49] = new SqlParameter("@PrimaryAddressOfOfficeBusiness", txtofficeaddress.Text.Trim());
            Param[50] = new SqlParameter("@PrimaryParentAnnualIncome", txtannualincome.Text.Trim() == "" ? "0.00" : txtannualincome.Text.Trim());
            Param[51] = new SqlParameter("@PrimaryAddress", txtparentaddress.InnerText.Trim());
            Param[52] = new SqlParameter("@PrimaryCity", txtparentcity.Text.Trim());
            Param[53] = new SqlParameter("@PrimaryState", txtparentstate.Text.Trim());
            Param[54] = new SqlParameter("@PrimaryPinZipCode", txtparentpincodeorzipcode.Text.Trim());
            Param[55] = new SqlParameter("@PrimaryCountry", txtparentcountry.Text.Trim());
            Param[56] = new SqlParameter("@PrimaryPhoneNo", txtparentphoneno.Text.Trim());
            Param[57] = new SqlParameter("@PrimaryMobileNo", txtparentmobileno.Text.Trim());
            Param[58] = new SqlParameter("@PrimaryEmailId", txtparentemailid.Text.Trim());
            if (fileuploaderofparentphotograph.HasFile)
            {
                fileuploaderofparentphotograph.PostedFile.SaveAs(Server.MapPath("~/BranchPanel/Student-Registration/student-registration-document/" + fileuploaderofparentphotograph.FileName + Convert.ToString(IdStudent)));
                Param[59] = new SqlParameter("@PrimaryUploadParentPhotograph", fileuploaderofparentphotograph.FileName + Convert.ToString(IdStudent));
            }
            else
            {
                Param[59] = new SqlParameter("@PrimaryUploadParentPhotograph", "");
            }
            Param[60] = new SqlParameter("@SecondarySelectParentType", ddlsecondaryparenttype.SelectedValue);
            Param[61] = new SqlParameter("@SecondaryParentFirstName", txtsecondaryparentfirstname.Text.Trim());
            Param[62] = new SqlParameter("@SecondaryParentMiddleName", txtsecondaryparentmiddlename.Text.Trim());
            Param[63] = new SqlParameter("@SecondaryParentLastName", txsecondaryparentlastname.Text.Trim());
            Param[64] = new SqlParameter("@SecondaryParentDOB", txtsecondaryparentdateofbirth.Text.Trim());
            Param[65] = new SqlParameter("@SecondaryParentNationality", txtsecondaryparentnationality.Text.Trim());
            Param[66] = new SqlParameter("@SecondaryHighestQualification", ddlsecondaryparenthighestqualification.SelectedValue);
            Param[67] = new SqlParameter("@SecondaryParentOccupation", txtsecondaryparentoccupation.Text.Trim());
            Param[68] = new SqlParameter("@SecondaryDesignation", txtsecondaryparentdesignation.Text.Trim());
            Param[69] = new SqlParameter("@SecondaryNameOfOrganization", txtnameoforganizationofsecondayparent.Text.Trim());
            Param[70] = new SqlParameter("@SecondaryAddressOfOfficeBusiness", txtbusinessorofficeaddressofsecondayparent.InnerText.Trim());
            Param[71] = new SqlParameter("@SecondaryParentAnnualIncome", txtsecondaryparentannualincome.Text.Trim() == "" ? "0.00" : txtsecondaryparentannualincome.Text.Trim());
            Param[72] = new SqlParameter("@SecondaryAddress", txsecondayparentaddress.InnerText.Trim());
            Param[73] = new SqlParameter("@SecondaryCity", txtsecondaryparentcity.Text.Trim());
            Param[74] = new SqlParameter("@SecondaryState", txtsecondaryparentstate.Text.Trim());
            Param[75] = new SqlParameter("@SecondaryPinZipCode", txtsecondayparentpinorzipcode.Text.Trim());
            Param[76] = new SqlParameter("@SecondaryCountry", txsecondaryparentcountry.Text.Trim());
            Param[77] = new SqlParameter("@SecondaryPhoneNo", txtsecondaryparentphoneno.Text.Trim());
            Param[78] = new SqlParameter("@SecondaryMobileNo", txtsecondaryparentmobileno.Text.Trim());
            Param[79] = new SqlParameter("@SecondaryEmailId", txtsecondaryparentemailid.Text.Trim());
            if (fileuploadforsecondaryparentphotograph.HasFile)
            {
                fileuploadforsecondaryparentphotograph.PostedFile.SaveAs(Server.MapPath("~/BranchPanel/Student-Registration/student-registration-document/" + fileuploadforsecondaryparentphotograph.FileName + Convert.ToString(IdStudent)));
                Param[80] = new SqlParameter("@SecondaryUploadParentPhotograph", fileuploadforsecondaryparentphotograph.FileName + Convert.ToString(IdStudent));
            }
            else
            {
                Param[80] = new SqlParameter("@SecondaryUploadParentPhotograph", "");
            }
            Param[81] = new SqlParameter("@EmergencyName", txtnameofcontactpersonincaseofemergency.Text.Trim());
            Param[82] = new SqlParameter("@EmergencyMobileNo", txtemergencymobileno.Text.Trim());
            Param[83] = new SqlParameter("@EmergencyAlternateMobileNo", txtemergencyalternatemobileno.Text.Trim());
            Param[84] = new SqlParameter("@EmergencyPhoneNo", txtemegencycontactpersonphoneno.Text.Trim());
            Param[85] = new SqlParameter("@EmergencyAddress", txtemergencycontactpersonaddress.InnerText.Trim());
            Param[86] = new SqlParameter("@EmergencyCity", txtemergencycontactpersoncity.Text.Trim());
            Param[87] = new SqlParameter("@EmergencyState", txtemergencycontactpersonstate.Text.Trim());
            Param[88] = new SqlParameter("@EmergencyPinZipCode", txtemergencycontactpersonpinorzipcode.Text.Trim());
            Param[89] = new SqlParameter("@EmergencyCountry", txtemergencycontactpersoncountry.Text.Trim());
            Param[90] = new SqlParameter("@RegistrationFee", txtregistrationfee.Text.Trim() == "" ? "300.00" : txtregistrationfee.Text.Trim());
            Param[91] = new SqlParameter("@PaymentMode", ddlpaymentmode.SelectedValue);
            Param[92] = new SqlParameter("@BankName", txtchkddneftbankname.Text.Trim());
            Param[93] = new SqlParameter("@BranchName", txtchkddneftbranchname.Text.Trim());
            Param[94] = new SqlParameter("@ChkRefNo", txtchkddneftrefno.Text.Trim());
            Param[95] = new SqlParameter("@ChkRefDate", txtchkddneftrefdate.Text.Trim());
            Param[96] = new SqlParameter("@RegistrationDate", txtregistrationdate.Text.Trim());
            Param[97] = new SqlParameter("@Comment", txtcomment.InnerText.Trim());
            Param[98] = new SqlParameter("@intresult", Convert.ToInt32("0"));
            Param[98].Direction = ParameterDirection.Output;
            if (Request.QueryString["RID"] != null)
            {
                string sturegno = Convert.ToString(Objdut.GetScalar("select Registration_No from tbl_StudentRegistration where RID=" + Request.QueryString["RID"]));
                Param[99] = new SqlParameter("@Registration_NoForAdmissionORUpdate", sturegno);
            }
            else
            {
                Param[99] = new SqlParameter("@Registration_NoForAdmissionORUpdate", "");
            }
            Param[100] = new SqlParameter("@Registration_NoForSMS", SqlDbType.VarChar, -1);
            Param[100].Direction = ParameterDirection.Output;
            Param[101] = new SqlParameter("@StudentUID", txtstudentUid.Text.Trim());
            Param[102] = new SqlParameter("@RegNewNo", txtOldRegNo.Text.Trim());
            Param[103] = new SqlParameter("@IsHostel", rbtnlistHostal.SelectedValue);
            Param[104] = new SqlParameter("@HouseID", Convert.ToInt32(ddlHouse.SelectedValue));

            if (Request.QueryString["RID"] != null)
            {
                Param[105] = new SqlParameter("@ExamDate", txtExamDate.Text.Trim());
                Param[106] = new SqlParameter("@ExamTime", txtExamTime.Text.Trim());
                Param[107] = new SqlParameter("@TotalMax", Convert.ToInt32(txtMaxMarks.Text));
                Param[108] = new SqlParameter("@TotalObtn", Convert.ToInt32(txtObtainedMarks.Text));
                Param[109] = new SqlParameter("@ExamResult", Convert.ToString(txtResult.Text));
            }
            else 
            {
                Param[105] = new SqlParameter("@ExamDate", "");
                Param[106] = new SqlParameter("@ExamTime", "");
                Param[107] = new SqlParameter("@TotalMax", Convert.ToInt32(0));
                Param[108] = new SqlParameter("@TotalObtn", Convert.ToInt32(0));
                Param[109] = new SqlParameter("@ExamResult", "");
            }

            if (chkAadharCard.Checked) { Param[110] = new SqlParameter("@Aadhar_Card", 1); } else { Param[110] = new SqlParameter("@Aadhar_Card", 0); }
            if (ChkBirthCertificate.Checked) { Param[111] = new SqlParameter("@Birth_Certificate", 1); } else { Param[111] = new SqlParameter("@Birth_Certificate", 0); }
            if (chkMigrationCertificate.Checked) { Param[112] = new SqlParameter("@Migration_Certificate", 1); } else { Param[112] = new SqlParameter("@Migration_Certificate", 0); }
            if (chkCasteCertificate.Checked) { Param[113] = new SqlParameter("@Caste_Certificate", 1); } else { Param[113] = new SqlParameter("@Caste_Certificate", 0); }
            if (chkLastYearMarksheet.Checked) { Param[114] = new SqlParameter("@LastYear_Marksheet", 1); } else { Param[114] = new SqlParameter("@LastYear_Marksheet", 0); }

            int intresult = Objdut.ExecuteSqlSP(Param, "[usp_StudentRegistration]");
            if (intresult == 1)
            {
                Utility.ViewAlertMessage(this, "Student registration successfully done.");
                SqlParameter[] ParamForSms = new SqlParameter[2];
                ParamForSms[0] = new SqlParameter("@RegistrationNo", Convert.ToString(Param[100].Value));
                ParamForSms[1] = new SqlParameter("@Mode", 1);
                DataTable Dt = Objdut.GetDataTableSP(ParamForSms, "Usp_CommanprocforSendSMS");
                if (Dt.Rows.Count > 0)
                {
                    try
                    {
                        System.Threading.Thread ThreadUpdateGrowthMocha = new System.Threading.Thread(delegate()
                        {
                            if (Convert.ToString(Param[100].Value) != "")
                            {
                                sendMessageToMobile.SMSsendForSend(Convert.ToString(Dt.Rows[0]["Mobile"]), Convert.ToString(Dt.Rows[0]["SmsContent"]), Session["BrBrid"].ToString());
                            }
                        });
                        ThreadUpdateGrowthMocha.Start();
                    }
                    catch (Exception expformessage)
                    {
                        Utility.ViewAlertMessage(this, expformessage.Message);
                    }
                }
                if (chkReceipt.Checked)
                {
                    string url = "../Fee%20Management/Register_receipt.aspx?RID=" + Convert.ToString(Param[100].Value) + "";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('" + url + "','_newtab');", true);
                }
                //Response.Redirect("student-registration-list.aspx");
                return;
            }
            else if (intresult == 2)
            {
                Utility.ViewAlertMessage(this, "Please fill all the manedatery field.");
                return;
            }
            else if (intresult == 2)
            {
                Utility.ViewAlertMessage(this, "Please enter date in valid format.");
                return;
            }
            else if (intresult == 0)
            {
                Utility.ViewAlertMessage(this, "Some error occur while inserting the record.");
                return;
            }
        }
    }

    protected void btnforcancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("student-registration-list.aspx");
    }

    private void BindAllDDLOfPage()
    {
        BindSessionDDL();
        BindClass();
        BindBloodGroup();
        BindParentType();
        BindsecondaryParentType();
        BindQualification();
        BindHouse();
    }
    public void BindHouse()
    {
        CommonClass CommonClass = new CommonClass();
        ddlHouse.DataSource = CommonClass.Dll("GetHouse", Convert.ToInt32(Session["BrBrid"]));
        ddlHouse.DataValueField = "HouseID";
        ddlHouse.DataTextField = "Housename";
        ddlHouse.DataBind();
        ListItem li = new ListItem("--Select House Name--", "0");
        ddlHouse.Items.Insert(0, li);
    }
    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlregistrationsession.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlregistrationsession.DataValueField = "Fyid";
        ddlregistrationsession.DataTextField = "FYName";
        ddlregistrationsession.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlregistrationsession.SelectedValue = Convert.ToString(ActiveFinancialyear );
    }

    public void BindClass()
    {
        DataTable Dt = new DataTable();
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ddlregistrationsession.SelectedValue), Convert.ToInt32(Session["BrBrid"]));
        if (Dt.Rows.Count > 0)
        {
            ddlapplyingforclass.DataSource = Dt;
            ddlapplyingforclass.DataTextField = "Classname";
            ddlapplyingforclass.DataValueField = "classid";
            ddlapplyingforclass.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlapplyingforclass.Items.Insert(0, li);
        }
    }

    public void BindBloodGroup()
    {
        CommonClass CommonClass = new CommonClass();
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetBloodGroupDDL");
        if (Dt.Rows.Count > 0)
        {
            ddlbloodgroup.DataSource = Dt;
            ddlbloodgroup.DataTextField = "Bgname";
            ddlbloodgroup.DataValueField = "Bgid";
            ddlbloodgroup.DataBind();
            ListItem li = new ListItem("--Select Blood Group--", "0");
            ddlbloodgroup.Items.Insert(0, li);
            Dt.Dispose();
        }
    }

    public void BindParentType()
    {
        CommonClass CommonClass = new CommonClass();
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetParentType");
        if (Dt.Rows.Count > 0)
        {
            ddlparenttype.DataSource = Dt;
            ddlparenttype.DataTextField = "Relation";
            ddlparenttype.DataValueField = "Id";
            ddlparenttype.DataBind();
            ListItem li = new ListItem("--Select Parent Type--", "0");
            ddlparenttype.Items.Insert(0, li);
            Dt.Dispose();
        }
    }

    public void BindsecondaryParentType()
    {
        CommonClass CommonClass = new CommonClass();
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetParentType");
        if (Dt.Rows.Count > 0)
        {
            ddlsecondaryparenttype.DataSource = Dt;
            ddlsecondaryparenttype.DataTextField = "Relation";
            ddlsecondaryparenttype.DataValueField = "Id";
            ddlsecondaryparenttype.DataBind();
            ListItem li = new ListItem("--Select Parent Type--", "0");
            ddlsecondaryparenttype.Items.Insert(0, li);
            Dt.Dispose();
        }
    }

    public void BindQualification()
    {
        CommonClass CommonClass = new CommonClass();
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetQualificationDDL");
        if (Dt.Rows.Count > 0)
        {
            ddlparentqualification.DataSource = Dt;
            ddlparentqualification.DataTextField = "Name";
            ddlparentqualification.DataValueField = "Qid";
            ddlparentqualification.DataBind();
            ListItem li = new ListItem("--Select Highest Qualification--", "0");
            ddlparentqualification.Items.Insert(0, li);
            ddlsecondaryparenthighestqualification.DataSource = Dt;
            ddlsecondaryparenthighestqualification.DataTextField = "Name";
            ddlsecondaryparenthighestqualification.DataValueField = "Qid";
            ddlsecondaryparenthighestqualification.DataBind();
            ddlsecondaryparenthighestqualification.Items.Insert(0, li);
            Dt.Dispose();
        }
    }

    [WebMethod]
    public static string ProcessIT(int ClassId, int Fyid)
    {
        DataUtility Objdut = new DataUtility();
        string Query = "Select Convert(Decimal(10,2),Fees) From classfee_master Where Brid=" + HttpContext.Current.Session["BrBrid"] + " And Fyid=" + Fyid + " And Status=1 And FeeId=(Select Id From feestructure Where Fyid=" + Fyid + " And Status=1 And Id=6)";
        return (Convert.ToString(Objdut.GetScalar(Query)));
    }
    [WebMethod]
    public static int checkOldAdmNo(string RefAdmNo)
    {
        DataUtility Objdut = new DataUtility();
        string Query = "Select Count(*) from tbl_StudentRegistration where RegNewNo='" + RefAdmNo + "'";
        return (Convert.ToInt32(Objdut.GetScalar(Query)));
    }

    public void FillDetails()
    {
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@studenregistrationid", RID);
        DataTable Dt = Objdut.GetDataTableSP(param, "usp_studentregistrationlist");
        if (Dt.Rows.Count > 0)
        {
            BindAllDDLOfPage(); ;
            ddlregistrationsession.SelectedValue = Convert.ToString(Dt.Rows[0]["Fyid"]);
            ddlregistrationsession.Enabled = false;
            if (Convert.ToString(Dt.Rows[0]["ExamDate"]) != "")
            {
                txtExamDate.Text = Convert.ToDateTime(Dt.Rows[0]["ExamDate"]).ToString("dd MMMM yyyy");
            }
            else 
            {
                txtExamDate.Text = "";
            }
            txtExamTime.Text = Convert.ToString(Dt.Rows[0]["ExamTime"]);           
            txtMaxMarks.Text = Convert.ToString(Dt.Rows[0]["MaxMarks"]);
            txtObtainedMarks.Text = Convert.ToString(Dt.Rows[0]["ObtainMarks"]);
            txtResult.Text = Convert.ToString(Dt.Rows[0]["Result"]);


            ddlHouse.SelectedValue = Convert.ToString(Dt.Rows[0]["HouseID"]);
            txtadmissionreferenceno.Text = Convert.ToString(Dt.Rows[0]["RefrenceAdmissionNo"]);
            txtstudentfirstname.Text = Convert.ToString(Dt.Rows[0]["StudentFirstName"]);
            txtstudentmiddlename.Text = Convert.ToString(Dt.Rows[0]["StudentMiddleName"]);
            txtstudentlastname.Text = Convert.ToString(Dt.Rows[0]["StudentLastName"]);
            txtstudentdob.Text = Convert.ToString(Dt.Rows[0]["StudentDOB"]);
            txtstudentUid.Text = Convert.ToString(Dt.Rows[0]["StudentUID"]);
            rbtnlistgender.SelectedValue = Convert.ToString(Dt.Rows[0]["Gender"]);
            rbtnlistnationality.SelectedValue = Convert.ToString(Dt.Rows[0]["Nationality"]);
            txtbirthplace.Text = Convert.ToString(Dt.Rows[0]["BirthPlace"]);
            txtreligion.Text = Convert.ToString(Dt.Rows[0]["Religion"]);
            txtmothertongue.Text = Convert.ToString(Dt.Rows[0]["MotherTongue"]);
            txtnoofsibbling.Text = Convert.ToString(Dt.Rows[0]["NoOfSiblings"]);
            rbtnlistcast.SelectedValue = Convert.ToString(Dt.Rows[0]["CastCategoryId"]);
            ddlapplyingforclass.SelectedValue = Convert.ToString(Dt.Rows[0]["ApplyingForClass"]);
            rbtntransportationrequired.SelectedValue = Convert.ToString(Dt.Rows[0]["TransportationRequired"]);
            txttotalsubmiteddocument.InnerText = Convert.ToString(Dt.Rows[0]["DocumentSubmitted"]);
            txtadditionalinformation.InnerText = Convert.ToString(Dt.Rows[0]["AdditionalInformation"]);
            txtaddress.InnerText = Convert.ToString(Dt.Rows[0]["Address"]);
            txtcity.Text = Convert.ToString(Dt.Rows[0]["City"]);
            txtstate.Text = Convert.ToString(Dt.Rows[0]["State"]);
            txtpiorzipcode.Text = Convert.ToString(Dt.Rows[0]["Pin"]);
            txtcountry.Text = Convert.ToString(Dt.Rows[0]["Country"]);
            ddlbloodgroup.SelectedValue = Convert.ToString(Dt.Rows[0]["BloodGroup"]);
            txtschoolname.Text = Convert.ToString(Dt.Rows[0]["SchoolName"]);
            txtboard.Text = Convert.ToString(Dt.Rows[0]["SchoolBoard"]);
            txtmedium.Text = Convert.ToString(Dt.Rows[0]["SchoolMedium"]);
            txtclassname.Text = Convert.ToString(Dt.Rows[0]["SchoolPreviousClassName"]);
            txtpreviusclsspercentage.Text = Convert.ToString(Dt.Rows[0]["SchoolPercentageInPreviousClass"]);
            txtschooladdress.InnerText = Convert.ToString(Dt.Rows[0]["SchoolAddress"]);
            txtcontactno.Text = Convert.ToString(Dt.Rows[0]["SchoolContactNo"]);
            txtalternatecontactno.Text = Convert.ToString(Dt.Rows[0]["SchoolAlternateContactNo"]);
            txtwesite.Text = Convert.ToString(Dt.Rows[0]["SchoolWebsite"]);
            ddlparenttype.SelectedValue = Convert.ToString(Dt.Rows[0]["PrimarySelectParentType"]);
            txtparentfirstname.Text = Convert.ToString(Dt.Rows[0]["PrimaryParentFirstName"]);
            txtparentmiddlename.Text = Convert.ToString(Dt.Rows[0]["PrimaryParentMiddleName"]);
            txtparentlastname.Text = Convert.ToString(Dt.Rows[0]["PrimaryParentLastName"]);
            txtparentdateofbirth.Text = Convert.ToString(Dt.Rows[0]["PrimaryParentDOB"]);
            txtparentnationality.Text = Convert.ToString(Dt.Rows[0]["PrimaryParentNationality"]);
            ddlparentqualification.SelectedValue = Convert.ToString(Dt.Rows[0]["PrimaryHighestQualification"]);
            txtparentoccupation.Text = Convert.ToString(Dt.Rows[0]["PrimaryParentOccupation"]);
            txtparentdesignation.Text = Convert.ToString(Dt.Rows[0]["PrimaryDesignation"]);
            txtparentorganization.Text = Convert.ToString(Dt.Rows[0]["PrimaryNameOfOrganization"]);
            txtofficeaddress.Text = Convert.ToString(Dt.Rows[0]["PrimaryAddressOfOfficeBusiness"]);
            txtannualincome.Text = Convert.ToString(Dt.Rows[0]["PrimaryParentAnnualIncome"]);
            txtparentaddress.InnerText = Convert.ToString(Dt.Rows[0]["PrimaryAddress"]);
            txtparentcity.Text = Convert.ToString(Dt.Rows[0]["PrimaryCity"]);
            txtparentstate.Text = Convert.ToString(Dt.Rows[0]["PrimaryState"]);
            txtparentpincodeorzipcode.Text = Convert.ToString(Dt.Rows[0]["PrimaryPinZipCode"]);
            txtparentcountry.Text = Convert.ToString(Dt.Rows[0]["PrimaryCountry"]);
            txtparentphoneno.Text = Convert.ToString(Dt.Rows[0]["PrimaryPhoneNo"]);
            txtparentmobileno.Text = Convert.ToString(Dt.Rows[0]["PrimaryMobileNo"]);
            txtparentemailid.Text = Convert.ToString(Dt.Rows[0]["PrimaryEmailId"]);
            ddlsecondaryparenttype.SelectedValue = Convert.ToString(Dt.Rows[0]["SecondarySelectParentType"]);
            txtsecondaryparentfirstname.Text = Convert.ToString(Dt.Rows[0]["SecondaryParentFirstName"]);
            txtsecondaryparentmiddlename.Text = Convert.ToString(Dt.Rows[0]["SecondaryParentMiddleName"]);
            txsecondaryparentlastname.Text = Convert.ToString(Dt.Rows[0]["SecondaryParentLastName"]);
            txtsecondaryparentdateofbirth.Text = Convert.ToString(Dt.Rows[0]["SecondaryParentDOB"]);
            txtsecondaryparentnationality.Text = Convert.ToString(Dt.Rows[0]["SecondaryParentNationality"]);
            ddlsecondaryparenthighestqualification.SelectedValue = Convert.ToString(Dt.Rows[0]["SecondaryHighestQualification"]);
            txtsecondaryparentoccupation.Text = Convert.ToString(Dt.Rows[0]["SecondaryParentOccupation"]);
            txtsecondaryparentdesignation.Text = Convert.ToString(Dt.Rows[0]["SecondaryDesignation"]);
            txtnameoforganizationofsecondayparent.Text = Convert.ToString(Dt.Rows[0]["SecondaryNameOfOrganization"]);
            txtbusinessorofficeaddressofsecondayparent.InnerText = Convert.ToString(Dt.Rows[0]["SecondaryAddressOfOfficeBusiness"]);
            txtsecondaryparentannualincome.Text = Convert.ToString(Dt.Rows[0]["SecondaryParentAnnualIncome"]);
            txsecondayparentaddress.InnerText = Convert.ToString(Dt.Rows[0]["SecondaryAddress"]);
            txtsecondaryparentcity.Text = Convert.ToString(Dt.Rows[0]["SecondaryCity"]);
            txtsecondaryparentstate.Text = Convert.ToString(Dt.Rows[0]["SecondaryState"]);
            txtsecondayparentpinorzipcode.Text = Convert.ToString(Dt.Rows[0]["SecondaryPinZipCode"]);
            txsecondaryparentcountry.Text = Convert.ToString(Dt.Rows[0]["SecondaryCountry"]);
            txtsecondaryparentphoneno.Text = Convert.ToString(Dt.Rows[0]["SecondaryPhoneNo"]);
            txtsecondaryparentmobileno.Text = Convert.ToString(Dt.Rows[0]["SecondaryMobileNo"]);
            txtsecondaryparentemailid.Text = Convert.ToString(Dt.Rows[0]["SecondaryEmailId"]);
            txtnameofcontactpersonincaseofemergency.Text = Convert.ToString(Dt.Rows[0]["EmergencyName"]);
            txtemergencymobileno.Text = Convert.ToString(Dt.Rows[0]["EmergencyMobileNo"]);
            txtemergencyalternatemobileno.Text = Convert.ToString(Dt.Rows[0]["EmergencyAlternateMobileNo"]);
            txtemegencycontactpersonphoneno.Text = Convert.ToString(Dt.Rows[0]["EmergencyPhoneNo"]);
            txtemergencycontactpersonaddress.InnerText = Convert.ToString(Dt.Rows[0]["EmergencyAddress"]);
            txtemergencycontactpersoncity.Text = Convert.ToString(Dt.Rows[0]["EmergencyCity"]);
            txtemergencycontactpersonstate.Text = Convert.ToString(Dt.Rows[0]["EmergencyState"]);
            txtemergencycontactpersonpinorzipcode.Text = Convert.ToString(Dt.Rows[0]["EmergencyPinZipCode"]);
            txtemergencycontactpersoncountry.Text = Convert.ToString(Dt.Rows[0]["EmergencyCountry"]);
            txtregistrationfee.Text = Convert.ToString(Dt.Rows[0]["RegistrationFee"]);
            ddlpaymentmode.SelectedValue = Convert.ToString(Dt.Rows[0]["PaymentMode"]);
            int mode = Convert.ToInt32(Dt.Rows[0]["PaymentMode"]);
            if (mode > 1)
            {
                divbankname.Style.Add("display", "block");
                divbranchname.Style.Add("display", "block");
                divrefnumber.Style.Add("display", "block");
                divrefdate.Style.Add("display", "block");
            }
            else
            {
                divbankname.Style.Add("display", "none");
                divbranchname.Style.Add("display", "none");
                divrefnumber.Style.Add("display", "none");
                divrefdate.Style.Add("display", "none");
            }
            txtchkddneftbankname.Text = Convert.ToString(Dt.Rows[0]["BankName"]);
            txtchkddneftbranchname.Text = Convert.ToString(Dt.Rows[0]["BranchName"]);
            txtchkddneftrefno.Text = Convert.ToString(Dt.Rows[0]["ChkRefNo"]);
            txtchkddneftrefdate.Text = Convert.ToString(Dt.Rows[0]["ChkRefDate"]);
            txtregistrationdate.Text = Convert.ToString(Dt.Rows[0]["RegistrationDate"]);
            txtcomment.InnerText = Convert.ToString(Dt.Rows[0]["Comment"]);
            lblStudentPhotograph.Text = Dt.Rows[0]["StudentPhotograph"].ToString();
            if (lblStudentPhotograph.Text != "")
            {
                stuphotograph.Style.Add("display", "block");
                imguser.ImageUrl = "~/BranchPanel/Student-Registration/student-registration-document/" + Dt.Rows[0]["StudentPhotograph"].ToString();
            }
            else
            {
                stuphotograph.Style.Add("display", "none");
            }
            lblStudentcertificate.Text = Dt.Rows[0]["BirthCertificate"].ToString();
            if (lblStudentcertificate.Text != "")
            {
                stucertifiacte.Style.Add("display", "block");
                Image1.ImageUrl = "~/BranchPanel/Student-Registration/student-registration-document/" + Dt.Rows[0]["BirthCertificate"].ToString();
            }
            else
            {
                stucertifiacte.Style.Add("display", "none");
            }
            lblparentfirstphoto.Text = Dt.Rows[0]["PrimaryUploadParentPhotograph"].ToString();
            if (lblparentfirstphoto.Text != "")
            {
                parentfirstphoto.Style.Add("display", "block");
                Image2.ImageUrl = "~/BranchPanel/Student-Registration/student-registration-document/" + Dt.Rows[0]["PrimaryUploadParentPhotograph"].ToString();
            }
            else
            {
                parentfirstphoto.Style.Add("display", "none");
            }
            lblparentsecondphoto.Text = Dt.Rows[0]["SecondaryUploadParentPhotograph"].ToString();
            if (lblparentsecondphoto.Text != "")
            {
                secondaryparentphoto.Style.Add("display", "block");
                Image3.ImageUrl = "~/BranchPanel/Student-Registration/student-registration-document/" + Dt.Rows[0]["SecondaryUploadParentPhotograph"].ToString();
            }
            else
            {
                secondaryparentphoto.Style.Add("display", "none");
            }
            not_editable.Visible = false;
            ExamDetail.Visible = true;
        }
        else
        {
            Response.Redirect("student-registration-list.aspx");
        }
    }

    [WebMethod]
    public static BIndClass[] BindClassDDL(string Fyid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(Fyid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        List<BIndClass> BindObj = new List<BIndClass>();
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            BIndClass Obj = new BIndClass();
            Obj.ID = Dt.Rows[i]["classid"].ToString();
            Obj.ClassName = Dt.Rows[i]["Classname"].ToString();
            BindObj.Add(Obj);
        }
        return BindObj.ToArray();
    }

    public class BIndClass
    {
        public string ID { get; set; }

        public string ClassName { get; set; }
    }

    [WebMethod]
    public static int IsReadyForAction(string Date, int Fyid)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[3];
        Param[0] = new SqlParameter("@ActivityDate", Date);
        Param[1] = new SqlParameter("@Fyid", Fyid);
        Param[2] = new SqlParameter("@Mode", 1);
        int ScalerValue = Convert.ToInt32(Objdut.GetScalerSP(Param, "[Usp_PreAdmissionSettings]"));
        return ScalerValue;
    }

    [WebMethod]
    public static string GetYearMonthDate(string Date)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@Date", Date);
        DataTable Dt = objdut.GetDataTableSP(param, "[usp_GetNoOfDaysMonthYear]");
        return (Dt.Rows[0]["Date"].ToString());
    }
    protected void lnbFillTime_Click(object sender, EventArgs e)
    {
        txtExamTime.Text = DateTime.Now.ToString("hh:mm tt");
    }
    protected void lnkFillDate_Click(object sender, EventArgs e)
    {

    }
}