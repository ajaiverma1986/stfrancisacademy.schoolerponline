using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Web;
using System.IO;
using System.Globalization;

public partial class BranchPanel_StudentManagement_student_profile_details : System.Web.UI.Page
{
    private string url = "", filename, Query="";
    private int IdStudent = 0, RID = 0;
    DataUtility Objdut = new DataUtility();
    private int StdFyid = 0;
    protected void Page_Load(object sender, EventArgs e)                                
    {
        if (!IsPostBack)
        {
            if (Session["StuRegNo"] != null)
            {
                BindAllDDLOfPage();
                FillDetails();
            }
            else
                BindAllDDLOfPage();
        }
        
    }
    void BindAllDDLOfPage()
    {
        BindSessionDDL();
        //BindClass();
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
        ddlregistrationsession.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    public void BindClass()
    {
        DataTable Dt = new DataTable();
        CommonClass CommonClass = new CommonClass();
        if (StdFyid == 0)
        {
            int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
            Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ActiveFinancialyear), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        }
        else{
            Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(StdFyid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        }
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
    public void FillDetails()
    {
        Query = "select sm.RID from tbl_StudentMaster sm  INNER JOIN tbl_StudentAdmissionMaster sa ON sm.SturegNo=sa.StuRegNo  where sm.IsActive=1 and sm.SturegNo=" + Session["StuRegNo"] + " and  sm.brid=" + Session["BrBrid"];
        DataTable dt = Objdut.GetDataTable(Query);
        dt.Rows[0]["RID"].ToString();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@studenregistrationid",  dt.Rows[0]["RID"].ToString());
        DataTable Dt = Objdut.GetDataTableSP(param, "usp_studentregistrationlist");
        if (Dt.Rows.Count > 0)
        {
            BindAllDDLOfPage();
            if (!string.IsNullOrWhiteSpace(Convert.ToString(Dt.Rows[0]["Fyid"])))
            {
                StdFyid = Convert.ToInt32(Dt.Rows[0]["Fyid"]);
            }
            BindClass(); 
            
            if (Convert.ToString(Dt.Rows[0]["IsHostel"]) == "True")
            {
                rbtnlistHostal.SelectedValue = "1";
            }
            else
            {
                rbtnlistHostal.SelectedValue = "0";
            }
            txtregistrationdate.Text = Convert.ToString(Dt.Rows[0]["AdmissionDate"]);
			txtOldRegNo.Text = Convert.ToString(Dt.Rows[0]["RegNewNo"]);
            ddlregistrationsession.SelectedValue = Convert.ToString(Dt.Rows[0]["Fyid"]);
            ddlregistrationsession.Enabled = false;  
            ddlHouse.SelectedValue = Convert.ToString(Dt.Rows[0]["HouseID"]);
            txtadmissionreferenceno.Text = Convert.ToString(Dt.Rows[0]["RefrenceAdmissionNo"]);
            txtstudentfirstname.Text = Convert.ToString(Dt.Rows[0]["StudentFirstName"]);
            txtstudentmiddlename.Text = Convert.ToString(Dt.Rows[0]["StudentMiddleName"]);
            txtstudentlastname.Text = Convert.ToString(Dt.Rows[0]["StudentLastName"]);
            txtstudentdob.Text = Convert.ToString(Dt.Rows[0]["StudentDOB"]);
            rbtnlistgender.SelectedValue = Convert.ToString(Dt.Rows[0]["Gender"]);
            txtstudentUid.Text = Convert.ToString(Dt.Rows[0]["StudentUID"]);
            rbtnlistnationality.SelectedValue = Convert.ToString(Dt.Rows[0]["Nationality"]);
            txtbirthplace.Text = Convert.ToString(Dt.Rows[0]["BirthPlace"]);
            txtreligion.Text = Convert.ToString(Dt.Rows[0]["Religion"]);
            txtmothertongue.Text = Convert.ToString(Dt.Rows[0]["MotherTongue"]);
            txtnoofsibbling.Text = Convert.ToString(Dt.Rows[0]["NoOfSiblings"]);
            rbtnlistcast.SelectedValue = Convert.ToString(Dt.Rows[0]["CastCategoryId"]);
            ddlapplyingforclass.SelectedValue = Convert.ToString(Dt.Rows[0]["ApplyingForClass"]);
            ////Class Management Start Here
            DataTable DtForSection = BindSectionDDL(Convert.ToString(Dt.Rows[0]["ApplyingForClass"]));
            if (DtForSection.Rows.Count > 0)
            {
                ddlsection.DataSource = DtForSection;
                ddlsection.DataTextField = "Sectionname";
                ddlsection.DataValueField = "Cwsid";
                ddlsection.DataBind();
                ListItem li = new ListItem("--Select Section--", "0");
                ddlsection.Items.Insert(0, li);
            }
            ddlsection.SelectedValue = Convert.ToString(Dt.Rows[0]["SectionID"]);
            ////Class Management End Here
            //ddlapplyingforclass.Enabled = false;
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
        }



        else
        {
            Response.Redirect("student-registration-list.aspx");
        }
    }


    protected void btnforupdateorsave_Click(object sender, EventArgs e)
    {
        string DOB="";
        string Registration_NoForAdmissionORUpdate="";
        string PrimaryParentDOB = "";
        string SecondaryParentDOB = "";

        DOB = (Convert.ToDateTime(txtstudentdob.Text.Trim())).ToString("yyyy-MM-dd");
        //PrimaryParentDOB = (Convert.ToDateTime(txtparentdateofbirth.Text.Trim().ToString().Trim())).ToString("yyyy-MM-dd");
       // SecondaryParentDOB = (Convert.ToDateTime(txtsecondaryparentdateofbirth.Text.Trim().ToString().Trim())).ToString("yyyy-MM-dd");        

        IdStudent = Convert.ToInt16(Objdut.GetScalar("select Isnull(MAX(RID),0)+1 from tbl_studentregistration where Brid=" + Convert.ToInt16(Session["BrBrid"])));
        
        SqlParameter[] Param = new SqlParameter[97];
        Param[00] = new SqlParameter("@Fyid", ddlregistrationsession.SelectedValue);      
        Param[01] = new SqlParameter("@RefrenceAdmissionNo", txtadmissionreferenceno.Text.Trim());
        Param[02] = new SqlParameter("@StudentFirstName", txtstudentfirstname.Text.Trim());
        Param[03] = new SqlParameter("@StudentMiddleName", txtstudentmiddlename.Text.Trim());
        Param[04] = new SqlParameter("@StudentLastName", txtstudentlastname.Text.Trim());
        Param[05] = new SqlParameter("@StudentDOB", Convert.ToString(DOB));
        Param[06] = new SqlParameter("@Gender", rbtnlistgender.SelectedValue);
        Param[07] = new SqlParameter("@Nationality", rbtnlistnationality.SelectedValue);
        Param[08] = new SqlParameter("@CountryName", txtcountryname.Text.Trim());
        Param[09] = new SqlParameter("@BirthPlace", txtbirthplace.Text.Trim());
        Param[10] = new SqlParameter("@Religion", txtreligion.Text.Trim());
        Param[11] = new SqlParameter("@MotherTongue", txtmothertongue.Text.Trim());
        Param[12] = new SqlParameter("@NoOfSiblings", txtnoofsibbling.Text.Trim());
        Param[13] = new SqlParameter("@CastCategoryId", rbtnlistcast.SelectedValue);
        Param[14] = new SqlParameter("@CastCategoryName", rbtnlistcast.SelectedItem.Text.Trim());
        Param[15] = new SqlParameter("@ApplyingForClass", ddlapplyingforclass.SelectedValue);
        Param[16] = new SqlParameter("@TransportationRequired", rbtntransportationrequired.SelectedValue);
        if (fileuploaderofstudentphotograph.HasFile)
        {
            fileuploaderofstudentphotograph.PostedFile.SaveAs(Server.MapPath("~/BranchPanel/Student-Registration/student-registration-document/" + Convert.ToString(IdStudent) + fileuploaderofstudentphotograph.FileName));
            Param[17] = new SqlParameter("@StudentPhotograph",Convert.ToString(IdStudent) + fileuploaderofstudentphotograph.FileName);
        }
        else
        {
            Param[17] = new SqlParameter("@StudentPhotograph", lblStudentPhotograph.Text);
        }
        if (fileuploaderofbirthcertificate.HasFile)
        {

            fileuploaderofbirthcertificate.PostedFile.SaveAs(Server.MapPath("~/BranchPanel/Student-Registration/student-registration-document/" + fileuploaderofbirthcertificate.FileName + Convert.ToString(IdStudent)));
            Param[18] = new SqlParameter("@BirthCertificate", fileuploaderofbirthcertificate.FileName + Convert.ToString(IdStudent));
        }
        else
        {
            Param[18] = new SqlParameter("@BirthCertificate", lblStudentcertificate.Text);
        }
        Param[19] = new SqlParameter("@DocumentSubmitted", txttotalsubmiteddocument.InnerText.Trim());
        Param[20] = new SqlParameter("@AdditionalInformation", txtadditionalinformation.InnerText.Trim());
        Param[21] = new SqlParameter("@Address", txtaddress.InnerText.Trim());
        Param[22] = new SqlParameter("@City", txtcity.Text.Trim());
        Param[23] = new SqlParameter("@State", txtstate.Text.Trim());
        Param[24] = new SqlParameter("@Pin", txtpiorzipcode.Text.Trim());
        Param[25] = new SqlParameter("@Country", txtcountry.Text.Trim());
        Param[26] = new SqlParameter("@BloodGroup", ddlbloodgroup.SelectedValue);
        Param[27] = new SqlParameter("@SchoolName", txtschoolname.Text.Trim());
        Param[28] = new SqlParameter("@SchoolBoard", txtboard.Text.Trim());
        Param[29] = new SqlParameter("@SchoolMedium", txtmedium.Text.Trim());
        Param[30] = new SqlParameter("@SchoolPreviousClassName", txtclassname.Text.Trim());
        Param[31] = new SqlParameter("@SchoolPercentageInPreviousClass", txtpreviusclsspercentage.Text.Trim());
        Param[32] = new SqlParameter("@SchoolAddress", txtschooladdress.InnerText.Trim());
        Param[33] = new SqlParameter("@SchoolContactNo", txtcontactno.Text.Trim());
        Param[34] = new SqlParameter("@SchoolAlternateContactNo", txtalternatecontactno.Text.Trim());
        Param[35] = new SqlParameter("@SchoolWebsite", txtwesite.Text.Trim());
        Param[36] = new SqlParameter("@PrimarySelectParentType", Request.Form[ddlparenttype.UniqueID]);
        Param[37] = new SqlParameter("@PrimaryParentFirstName", txtparentfirstname.Text.Trim());
        Param[38] = new SqlParameter("@PrimaryParentMiddleName", txtparentmiddlename.Text.Trim());
        Param[39] = new SqlParameter("@PrimaryParentLastName", txtparentlastname.Text.Trim());
        Param[40] = new SqlParameter("@PrimaryParentDOB", PrimaryParentDOB);
        Param[41] = new SqlParameter("@TotalAge", 0);
        Param[42] = new SqlParameter("@PrimaryParentNationality", txtparentnationality.Text.Trim());
        Param[43] = new SqlParameter("@PrimaryHighestQualification", ddlparentqualification.SelectedValue);
        Param[44] = new SqlParameter("@PrimaryParentOccupation", txtparentoccupation.Text.Trim());
        Param[45] = new SqlParameter("@PrimaryDesignation", txtparentdesignation.Text.Trim());
        Param[46] = new SqlParameter("@PrimaryNameOfOrganization", txtparentorganization.Text.Trim());
        Param[47] = new SqlParameter("@PrimaryAddressOfOfficeBusiness", txtofficeaddress.Text.Trim());
        Param[48] = new SqlParameter("@PrimaryParentAnnualIncome", txtannualincome.Text.Trim() == "" ? "0.00" : txtannualincome.Text.Trim());
        Param[49] = new SqlParameter("@PrimaryAddress", txtparentaddress.InnerText.Trim());
        Param[50] = new SqlParameter("@PrimaryCity", txtparentcity.Text.Trim());
        Param[51] = new SqlParameter("@PrimaryState", txtparentstate.Text.Trim());
        Param[52] = new SqlParameter("@PrimaryPinZipCode", txtparentpincodeorzipcode.Text.Trim());
        Param[53] = new SqlParameter("@PrimaryCountry", txtparentcountry.Text.Trim());
        Param[54] = new SqlParameter("@PrimaryPhoneNo", txtparentphoneno.Text.Trim());
        Param[55] = new SqlParameter("@PrimaryMobileNo", txtparentmobileno.Text.Trim());
        Param[56] = new SqlParameter("@PrimaryEmailId", txtparentemailid.Text.Trim());
        if (fileuploaderofparentphotograph.HasFile)
        {
            fileuploaderofparentphotograph.PostedFile.SaveAs(Server.MapPath("~/BranchPanel/Student-Registration/student-registration-document/" + fileuploaderofparentphotograph.FileName + Convert.ToString(IdStudent)));
            Param[57] = new SqlParameter("@PrimaryUploadParentPhotograph", fileuploaderofparentphotograph.FileName + Convert.ToString(IdStudent));
        }
        else
        {
            Param[57] = new SqlParameter("@PrimaryUploadParentPhotograph", lblparentfirstphoto.Text);
        }
        Param[58] = new SqlParameter("@SecondarySelectParentType", ddlsecondaryparenttype.SelectedValue);
        Param[59] = new SqlParameter("@SecondaryParentFirstName", txtsecondaryparentfirstname.Text.Trim());
        Param[60] = new SqlParameter("@SecondaryParentMiddleName", txtsecondaryparentmiddlename.Text.Trim());
        Param[61] = new SqlParameter("@SecondaryParentLastName", txsecondaryparentlastname.Text.Trim());
        Param[62] = new SqlParameter("@SecondaryParentDOB", SecondaryParentDOB);
        Param[63] = new SqlParameter("@SecondaryParentNationality", txtsecondaryparentnationality.Text.Trim());
        Param[64] = new SqlParameter("@SecondaryHighestQualification", ddlsecondaryparenthighestqualification.SelectedValue);
        Param[65] = new SqlParameter("@SecondaryParentOccupation", txtsecondaryparentoccupation.Text.Trim());
        Param[66] = new SqlParameter("@SecondaryDesignation", txtsecondaryparentdesignation.Text.Trim());
        Param[67] = new SqlParameter("@SecondaryNameOfOrganization", txtnameoforganizationofsecondayparent.Text.Trim());
        Param[68] = new SqlParameter("@SecondaryAddressOfOfficeBusiness", txtbusinessorofficeaddressofsecondayparent.InnerText.Trim());
        Param[69] = new SqlParameter("@SecondaryParentAnnualIncome", txtsecondaryparentannualincome.Text.Trim() == "" ? "0.00" : txtsecondaryparentannualincome.Text.Trim());
        Param[70] = new SqlParameter("@SecondaryAddress", txsecondayparentaddress.InnerText.Trim());
        Param[71] = new SqlParameter("@SecondaryCity", txtsecondaryparentcity.Text.Trim());
        Param[72] = new SqlParameter("@SecondaryState", txtsecondaryparentstate.Text.Trim());
        Param[73] = new SqlParameter("@SecondaryPinZipCode", txtsecondayparentpinorzipcode.Text.Trim());
        Param[74] = new SqlParameter("@SecondaryCountry", txsecondaryparentcountry.Text.Trim());
        Param[75] = new SqlParameter("@SecondaryPhoneNo", txtsecondaryparentphoneno.Text.Trim());
        Param[76] = new SqlParameter("@SecondaryMobileNo", txtsecondaryparentmobileno.Text.Trim());
        Param[77] = new SqlParameter("@SecondaryEmailId", txtsecondaryparentemailid.Text.Trim());
        if (fileuploadforsecondaryparentphotograph.HasFile)
        {
            fileuploadforsecondaryparentphotograph.PostedFile.SaveAs(Server.MapPath("~/BranchPanel/Student-Registration/student-registration-document/" + fileuploadforsecondaryparentphotograph.FileName + Convert.ToString(IdStudent)));
            Param[78] = new SqlParameter("@SecondaryUploadParentPhotograph", fileuploadforsecondaryparentphotograph.FileName + Convert.ToString(IdStudent));
        }
        else
        {
            Param[78] = new SqlParameter("@SecondaryUploadParentPhotograph", lblparentsecondphoto.Text);
        }
        Param[79] = new SqlParameter("@EmergencyName", txtnameofcontactpersonincaseofemergency.Text.Trim());
        Param[80] = new SqlParameter("@EmergencyMobileNo", txtemergencymobileno.Text.Trim());
        Param[81] = new SqlParameter("@EmergencyAlternateMobileNo", txtemergencyalternatemobileno.Text.Trim());
        Param[82] = new SqlParameter("@EmergencyPhoneNo", txtemegencycontactpersonphoneno.Text.Trim());
        Param[83] = new SqlParameter("@EmergencyAddress", txtemergencycontactpersonaddress.InnerText.Trim());
        Param[84] = new SqlParameter("@EmergencyCity", txtemergencycontactpersoncity.Text.Trim());
        Param[85] = new SqlParameter("@EmergencyState", txtemergencycontactpersonstate.Text.Trim());
        Param[86] = new SqlParameter("@EmergencyPinZipCode", txtemergencycontactpersonpinorzipcode.Text.Trim());
        Param[87] = new SqlParameter("@EmergencyCountry", txtemergencycontactpersoncountry.Text.Trim());
        Registration_NoForAdmissionORUpdate = Convert.ToString(Objdut.GetScalar("select Registration_No From tbl_studentmaster Where Sturegno=" + Session["StuRegNo"]));
        Param[88] = new SqlParameter("@Registration_NoForAdmissionORUpdate", Registration_NoForAdmissionORUpdate);
        Param[89] = new SqlParameter("@Section_Id", ddlsection.SelectedValue);
        Param[90] = new SqlParameter("@StudentUID", txtstudentUid.Text.Trim()); 
        Param[91] = new SqlParameter("@intresult", Convert.ToInt32("0"));
        Param[91].Direction = ParameterDirection.Output;
        Param[92] = new SqlParameter("@IsHostel", Convert.ToInt32(rbtnlistHostal.SelectedValue));
        Param[93] = new SqlParameter("@Brid", Convert.ToInt32(Session["BrBrid"]));
        Param[94] = new SqlParameter("@RegNewNo", txtOldRegNo.Text.ToString());
        Param[95] = new SqlParameter("@HouseID", Convert.ToInt32(ddlHouse.SelectedValue));
		Param[96] = new SqlParameter("@AdmissionDate", txtregistrationdate.Text.Trim());
         

        int intresult = Objdut.ExecuteSqlSP(Param, "[usp_StudentRegistration]");       
        if (intresult == 1)
        {
            savestudentitem objsave = new savestudentitem();
            objsave.updateORinsertHostelFee(Registration_NoForAdmissionORUpdate, Convert.ToInt32(Session["BrBrid"]), txtstudentfirstname.Text.Trim(), Convert.ToInt32(rbtnlistHostal.SelectedValue));

            Utility.ViewAlertMessage(this, "Student registration update successfully.");
            Response.Redirect("student-profile-details.aspx");
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

    public DataTable BindSectionDDL(string Classid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("sectiondll", Convert.ToInt32(Classid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        return Dt;
    }
	
	[WebMethod]
    public static List<SECTION> BindSectionDDL1(string Classid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("sectiondll", Convert.ToInt32(Classid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        List<SECTION> sec = new List<SECTION>();
        foreach(DataRow dr in Dt.Rows)
        {
            SECTION section = new SECTION();
            section.SECTIONID = Convert.ToString(dr["cwsid"]);
            section.SECTIONNAME = Convert.ToString(dr["SECTIONNAME"]);
            sec.Add(section);
        }
        return sec;
    }
    public class SECTION
    {
        public string SECTIONID { get; set; }
        public string SECTIONNAME { get; set; }
    }
}