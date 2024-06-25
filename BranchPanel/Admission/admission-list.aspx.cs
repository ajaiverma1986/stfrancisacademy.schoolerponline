using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Services;
using System.IO;
using System.Web.UI.WebControls;
using System.Web;
using ClosedXML.Excel;
using System.Web.Script.Serialization;
using System.Net;
public partial class BranchPanel_Admission_student_list : System.Web.UI.Page
{
    string ClassID = "";
    string SectionID = "";
    DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindSessionDDL();
            if (Request.QueryString["ClassID"] != null)
            {
                ClassID = Request.QueryString["ClassID"].ToString();
            }
        }
    }

    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlfyear.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlfyear.DataValueField = "Fyid";
        ddlfyear.DataTextField = "FYName";
        ddlfyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
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
    public static StudentDetails[] FillDetailsOfStudent(int SAMID)
    {
        DataUtility Objdut = new DataUtility();
        List<StudentDetails> Details = new List<StudentDetails>();
        DataTable DtemployeeDetails = new DataTable();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@SAMID", SAMID);
        DtemployeeDetails = Objdut.GetDataTableSP(param, "usp_studentregistrationlist");
        StudentDetails StuDetails = new StudentDetails();


        StuDetails.AdmissionDate = Convert.ToString(DtemployeeDetails.Rows[0]["AdmissionDate"].ToString());
        StuDetails.AdmissionNo = Convert.ToString(DtemployeeDetails.Rows[0]["AdmissionNo"].ToString());
        StuDetails.RegistrationDate = Convert.ToString(DtemployeeDetails.Rows[0]["RegistrationDate"].ToString());
        StuDetails.Registration_No = Convert.ToString(DtemployeeDetails.Rows[0]["Registration_No"].ToString());
        StuDetails.RefrenceAdmissionNo = Convert.ToString(DtemployeeDetails.Rows[0]["RefrenceAdmissionNo"].ToString());
        StuDetails.studentname = Convert.ToString(DtemployeeDetails.Rows[0]["studentname"].ToString());
        StuDetails.Classname = Convert.ToString(DtemployeeDetails.Rows[0]["Classname"].ToString());
        StuDetails.Religion = Convert.ToString(DtemployeeDetails.Rows[0]["Religion"].ToString());
        StuDetails.CastCategoryName = Convert.ToString(DtemployeeDetails.Rows[0]["CastCategoryName"].ToString());
        StuDetails.StudentDOB = Convert.ToString(DtemployeeDetails.Rows[0]["StudentDOB"].ToString());
        StuDetails.StudentUID = Convert.ToString(DtemployeeDetails.Rows[0]["StudentUID"].ToString());
        StuDetails.Gender = Convert.ToString(DtemployeeDetails.Rows[0]["Gender"].ToString());
        StuDetails.Nationality = Convert.ToString(DtemployeeDetails.Rows[0]["Nationality"].ToString());
        StuDetails.BirthPlace = Convert.ToString(DtemployeeDetails.Rows[0]["BirthPlace"].ToString());
        StuDetails.NoOfSiblings = Convert.ToString(DtemployeeDetails.Rows[0]["NoOfSiblings"].ToString());
        StuDetails.TransportationRequired = Convert.ToString(DtemployeeDetails.Rows[0]["TransportationRequired"].ToString());
        StuDetails.StudentPhotograph = Convert.ToString(DtemployeeDetails.Rows[0]["StudentPhotograph"].ToString());


        StuDetails.BirthCertificate = Convert.ToString(DtemployeeDetails.Rows[0]["BirthCertificate"].ToString());
        StuDetails.DocumentSubmitted = Convert.ToString(DtemployeeDetails.Rows[0]["DocumentSubmitted"].ToString());
        StuDetails.AdditionalInformation = Convert.ToString(DtemployeeDetails.Rows[0]["AdditionalInformation"].ToString());
        StuDetails.Country = Convert.ToString(DtemployeeDetails.Rows[0]["Country"].ToString());
        StuDetails.State = Convert.ToString(DtemployeeDetails.Rows[0]["State"].ToString());
        StuDetails.City = Convert.ToString(DtemployeeDetails.Rows[0]["City"].ToString());
        StuDetails.Pin = Convert.ToString(DtemployeeDetails.Rows[0]["Pin"].ToString());
        StuDetails.Address = Convert.ToString(DtemployeeDetails.Rows[0]["Address"].ToString());
        StuDetails.BloodGroup = Convert.ToString(DtemployeeDetails.Rows[0]["BloodGroup"].ToString());
        StuDetails.SchoolName = Convert.ToString(DtemployeeDetails.Rows[0]["SchoolName"].ToString());
        StuDetails.SchoolBoard = Convert.ToString(DtemployeeDetails.Rows[0]["SchoolBoard"].ToString());
        StuDetails.SchoolMedium = Convert.ToString(DtemployeeDetails.Rows[0]["SchoolMedium"].ToString());
        StuDetails.SchoolPreviousClassName = Convert.ToString(DtemployeeDetails.Rows[0]["SchoolPreviousClassName"].ToString());
        StuDetails.SchoolPercentageInPreviousClass = Convert.ToString(DtemployeeDetails.Rows[0]["SchoolPercentageInPreviousClass"].ToString());
        StuDetails.SchoolAddress = Convert.ToString(DtemployeeDetails.Rows[0]["SchoolAddress"].ToString());
        StuDetails.SchoolContactNo = Convert.ToString(DtemployeeDetails.Rows[0]["SchoolContactNo"].ToString());



        StuDetails.SchoolAlternateContactNo = Convert.ToString(DtemployeeDetails.Rows[0]["SchoolAlternateContactNo"].ToString());
        StuDetails.SchoolWebsite = Convert.ToString(DtemployeeDetails.Rows[0]["SchoolWebsite"].ToString());
        StuDetails.PrimarySelectParentType = Convert.ToString(DtemployeeDetails.Rows[0]["PrimarySelectParentType"].ToString());
        StuDetails.PrimaryParentName = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryParentName"].ToString());
        StuDetails.PrimaryParentNationality = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryParentNationality"].ToString());
        StuDetails.PrimaryHighestQualification = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryHighestQualification"].ToString());
        StuDetails.PrimaryParentOccupation = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryParentOccupation"].ToString());
        StuDetails.PrimaryDesignation = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryDesignation"].ToString());
        StuDetails.PrimaryNameOfOrganization = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryNameOfOrganization"].ToString());
        StuDetails.PrimaryAddressOfOfficeBusiness = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryAddressOfOfficeBusiness"].ToString());
        StuDetails.PrimaryParentAnnualIncome = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryParentAnnualIncome"].ToString());
        StuDetails.PrimaryAddress = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryAddress"].ToString());
        StuDetails.PrimaryCity = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryCity"].ToString());
        StuDetails.PrimaryState = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryState"].ToString());
        StuDetails.PrimaryPinZipCode = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryPinZipCode"].ToString());
        StuDetails.PrimaryCountry = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryCountry"].ToString());


        StuDetails.PrimaryPhoneNo = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryPhoneNo"].ToString());
        StuDetails.PrimaryMobileNo = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryMobileNo"].ToString());
        StuDetails.PrimaryEmailId = Convert.ToString(DtemployeeDetails.Rows[0]["PrimaryEmailId"].ToString());
        StuDetails.SecondarySelectParentType = Convert.ToString(DtemployeeDetails.Rows[0]["SecondarySelectParentType"].ToString());
        StuDetails.SecondaryParentName = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryParentName"].ToString());
        StuDetails.SecondaryParentNationality = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryParentNationality"].ToString());
        StuDetails.SecondaryHighestQualification = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryHighestQualification"].ToString());
        StuDetails.SecondaryParentOccupation = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryParentOccupation"].ToString());
        StuDetails.SecondaryDesignation = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryDesignation"].ToString());
        StuDetails.SecondaryNameOfOrganization = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryNameOfOrganization"].ToString());
        StuDetails.SecondaryAddressOfOfficeBusiness = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryAddressOfOfficeBusiness"].ToString());
        StuDetails.SecondaryParentAnnualIncome = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryParentAnnualIncome"].ToString());
        StuDetails.SecondaryAddress = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryAddress"].ToString());
        StuDetails.SecondaryCity = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryCity"].ToString());
        StuDetails.SecondaryState = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryState"].ToString());
        StuDetails.SecondaryPinZipCode = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryPinZipCode"].ToString());


        StuDetails.SecondaryCountry = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryCountry"].ToString());
        StuDetails.SecondaryPhoneNo = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryPhoneNo"].ToString());
        StuDetails.SecondaryMobileNo = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryMobileNo"].ToString());
        StuDetails.SecondaryEmailId = Convert.ToString(DtemployeeDetails.Rows[0]["SecondaryEmailId"].ToString());
        StuDetails.EmergencyName = Convert.ToString(DtemployeeDetails.Rows[0]["EmergencyName"].ToString());
        StuDetails.EmergencyMobileNo = Convert.ToString(DtemployeeDetails.Rows[0]["EmergencyMobileNo"].ToString());
        StuDetails.EmergencyAlternateMobileNo = Convert.ToString(DtemployeeDetails.Rows[0]["EmergencyAlternateMobileNo"].ToString());
        StuDetails.EmergencyPhoneNo = Convert.ToString(DtemployeeDetails.Rows[0]["EmergencyPhoneNo"].ToString());
        StuDetails.EmergencyAddress = Convert.ToString(DtemployeeDetails.Rows[0]["EmergencyAddress"].ToString());
        StuDetails.EmergencyCity = Convert.ToString(DtemployeeDetails.Rows[0]["EmergencyCity"].ToString());
        StuDetails.EmergencyState = Convert.ToString(DtemployeeDetails.Rows[0]["EmergencyState"].ToString());
        StuDetails.EmergencyPinZipCode = Convert.ToString(DtemployeeDetails.Rows[0]["EmergencyPinZipCode"].ToString());
        StuDetails.EmergencyCountry = Convert.ToString(DtemployeeDetails.Rows[0]["EmergencyCountry"].ToString());

        Details.Add(StuDetails);
        return Details.ToArray();
    }

    [WebMethod]
    public static int UpdatePermission(string query_)
    {
        int result = 0;
        DataUtility Objdut = new DataUtility();
        result = (int)(Objdut.ExecuteSql(query_));
        return result;
    }

    [WebMethod]
    public static AdmissionPermission[] BindPermission()
    {
        DataUtility Objdut = new DataUtility();
        List<AdmissionPermission> Details = new List<AdmissionPermission>();
        DataTable dt = Objdut.GetDataTableSP("[SP_AdmissionReportpermission]");
        AdmissionPermission aa = new AdmissionPermission();
        aa.Registratio_No = (Boolean)dt.Rows[0]["Registratio_No"];
        aa.studentname = (Boolean)dt.Rows[0]["studentname"];
        aa.Classname = (Boolean)dt.Rows[0]["Classname"];
        aa.fathername = (Boolean)dt.Rows[0]["fathername"];
        aa.MobileNo = (Boolean)dt.Rows[0]["MobileNo"];
        aa.StudentDOB = (Boolean)dt.Rows[0]["StudentDOB"];
        aa.Gender = (Boolean)dt.Rows[0]["Gender"];
        aa.CountryName = (Boolean)dt.Rows[0]["CountryName"];
        aa.Religion = (Boolean)dt.Rows[0]["Religion"];
        aa.Address = (Boolean)dt.Rows[0]["Address"];
        aa.City = (Boolean)dt.Rows[0]["City"];
        aa.State = (Boolean)dt.Rows[0]["State"];
        aa.Pin = (Boolean)dt.Rows[0]["Pin"];
        aa.Country = (Boolean)dt.Rows[0]["Country"];
        aa.Aadhar_Card = (Boolean)dt.Rows[0]["Aadhar_Card"];
        aa.Birth_Certificate = (Boolean)dt.Rows[0]["Birth_Certificate"];
        aa.Migration_Certificate = (Boolean)dt.Rows[0]["Migration_Certificate"];
        aa.Caste_Certificate = (Boolean)dt.Rows[0]["Caste_Certificate"];
        aa.LastYear_Marksheet = (Boolean)dt.Rows[0]["LastYear_Marksheet"];

        Details.Add(aa);
        return Details.ToArray();
    }
    public class AdmissionPermission
    {
        public Boolean Registratio_No { get; set; }
        public Boolean studentname { get; set; }
        public Boolean Classname { get; set; }
        public Boolean fathername { get; set; }
        public Boolean MobileNo { get; set; }
        public Boolean StudentDOB { get; set; }
        public Boolean Gender { get; set; }
        public Boolean CountryName { get; set; }
        public Boolean Religion { get; set; }
        public Boolean Address { get; set; }
        public Boolean City { get; set; }
        public Boolean State { get; set; }
        public Boolean Pin { get; set; }
        public Boolean Country { get; set; }
        public Boolean Aadhar_Card { get; set; }
        public Boolean Birth_Certificate { get; set; }
        public Boolean Migration_Certificate { get; set; }
        public Boolean Caste_Certificate { get; set; }
        public Boolean LastYear_Marksheet { get; set; }
    }

    [WebMethod]
    public static AdmissionExcelPermission[] BindExcelPermission()
    {
        DataUtility Objdut = new DataUtility();
        List<AdmissionExcelPermission> Details = new List<AdmissionExcelPermission>();
        DataTable dt = Objdut.GetDataTableSP("[SP_AdmissionExcelpermission]");
        AdmissionExcelPermission aa = new AdmissionExcelPermission();

        aa.RID = (Boolean)dt.Rows[0]["RID"];
        aa.SAMID = (Boolean)dt.Rows[0]["SAMID"];
        aa.IsHostel = (Boolean)dt.Rows[0]["IsHostel"];
        aa.HouseID = (Boolean)dt.Rows[0]["HouseID"];
        aa.AdmissionDate = (Boolean)dt.Rows[0]["AdmissionDate"];
        aa.AdmissionNo = (Boolean)dt.Rows[0]["AdmissionNo"];
        aa.RegistrationDate = (Boolean)dt.Rows[0]["RegistrationDate"];
        aa.Registration_No = (Boolean)dt.Rows[0]["Registration_No"];
        aa.RefrenceAdmissionNo = (Boolean)dt.Rows[0]["RefrenceAdmissionNo"];
        aa.studentname = (Boolean)dt.Rows[0]["studentname"];
        aa.Classname = (Boolean)dt.Rows[0]["Classname"];
        aa.Sectionname = (Boolean)dt.Rows[0]["Sectionname"];
        aa.StudentUID = (Boolean)dt.Rows[0]["StudentUID"];
        aa.RegNewNo = (Boolean)dt.Rows[0]["RegNewNo"];
        aa.Religion = (Boolean)dt.Rows[0]["Religion"];
        aa.CastCategoryName = (Boolean)dt.Rows[0]["CastCategoryName"];
        aa.StudentDOB = (Boolean)dt.Rows[0]["StudentDOB"];
        aa.Gender = (Boolean)dt.Rows[0]["Gender"];
        aa.Nationality = (Boolean)dt.Rows[0]["Nationality"];
        aa.BirthPlace = (Boolean)dt.Rows[0]["BirthPlace"];
        aa.NoOfSiblings = (Boolean)dt.Rows[0]["NoOfSiblings"];
        aa.TransportationRequired = (Boolean)dt.Rows[0]["TransportationRequired"];
        aa.StudentPhotograph = (Boolean)dt.Rows[0]["StudentPhotograph"];
        aa.BirthCertificate = (Boolean)dt.Rows[0]["BirthCertificate"];
        aa.DocumentSubmitted = (Boolean)dt.Rows[0]["DocumentSubmitted"];
        aa.AdditionalInformation = (Boolean)dt.Rows[0]["AdditionalInformation"];
        aa.Country = (Boolean)dt.Rows[0]["Country"];
        aa.State = (Boolean)dt.Rows[0]["State"];
        aa.City = (Boolean)dt.Rows[0]["City"];
        aa.Pin = (Boolean)dt.Rows[0]["Pin"];
        aa.Address = (Boolean)dt.Rows[0]["Address"];
        aa.BloodGroup = (Boolean)dt.Rows[0]["BloodGroup"];
        aa.SchoolName = (Boolean)dt.Rows[0]["SchoolName"];
        aa.SchoolBoard = (Boolean)dt.Rows[0]["SchoolBoard"];
        aa.SchoolMedium = (Boolean)dt.Rows[0]["SchoolMedium"];
        aa.SchoolPreviousClassName = (Boolean)dt.Rows[0]["SchoolPreviousClassName"];
        aa.SchoolPercentageInPreviousClass = (Boolean)dt.Rows[0]["SchoolPercentageInPreviousClass"];
        aa.SchoolAddress = (Boolean)dt.Rows[0]["SchoolAddress"];
        aa.SchoolContactNo = (Boolean)dt.Rows[0]["SchoolContactNo"];
        aa.SchoolAlternateContactNo = (Boolean)dt.Rows[0]["SchoolAlternateContactNo"];
        aa.SchoolWebsite = (Boolean)dt.Rows[0]["SchoolWebsite"];
        aa.PrimarySelectParentType = (Boolean)dt.Rows[0]["PrimarySelectParentType"];
        aa.PrimaryParentName = (Boolean)dt.Rows[0]["PrimaryParentName"];
        aa.PrimaryParentNationality = (Boolean)dt.Rows[0]["PrimaryParentNationality"];
        aa.PrimaryHighestQualification = (Boolean)dt.Rows[0]["PrimaryHighestQualification"];
        aa.PrimaryParentOccupation = (Boolean)dt.Rows[0]["PrimaryParentOccupation"];
        aa.PrimaryDesignation = (Boolean)dt.Rows[0]["PrimaryDesignation"];
        aa.PrimaryNameOfOrganization = (Boolean)dt.Rows[0]["PrimaryNameOfOrganization"];
        aa.PrimaryAddressOfOfficeBusiness = (Boolean)dt.Rows[0]["PrimaryAddressOfOfficeBusiness"];
        aa.PrimaryParentAnnualIncome = (Boolean)dt.Rows[0]["PrimaryParentAnnualIncome"];
        aa.PrimaryAddress = (Boolean)dt.Rows[0]["PrimaryAddress"];
        aa.PrimaryCity = (Boolean)dt.Rows[0]["PrimaryCity"];
        aa.PrimaryState = (Boolean)dt.Rows[0]["PrimaryState"];
        aa.PrimaryPinZipCode = (Boolean)dt.Rows[0]["PrimaryPinZipCode"];
        aa.PrimaryCountry = (Boolean)dt.Rows[0]["PrimaryCountry"];
        aa.PrimaryPhoneNo = (Boolean)dt.Rows[0]["PrimaryPhoneNo"];
        aa.PrimaryMobileNo = (Boolean)dt.Rows[0]["PrimaryMobileNo"];
        aa.PrimaryEmailId = (Boolean)dt.Rows[0]["PrimaryEmailId"];
        aa.SecondarySelectParentType = (Boolean)dt.Rows[0]["SecondarySelectParentType"];
        aa.SecondaryParentName = (Boolean)dt.Rows[0]["SecondaryParentName"];
        aa.SecondaryParentNationality = (Boolean)dt.Rows[0]["SecondaryParentNationality"];
        aa.SecondaryHighestQualification = (Boolean)dt.Rows[0]["SecondaryHighestQualification"];
        aa.SecondaryParentOccupation = (Boolean)dt.Rows[0]["SecondaryParentOccupation"];
        aa.SecondaryDesignation = (Boolean)dt.Rows[0]["SecondaryDesignation"];
        aa.SecondaryNameOfOrganization = (Boolean)dt.Rows[0]["SecondaryNameOfOrganization"];
        aa.SecondaryAddressOfOfficeBusiness = (Boolean)dt.Rows[0]["SecondaryAddressOfOfficeBusiness"];
        aa.SecondaryParentAnnualIncome = (Boolean)dt.Rows[0]["SecondaryParentAnnualIncome"];
        aa.SecondaryAddress = (Boolean)dt.Rows[0]["SecondaryAddress"];
        aa.SecondaryCity = (Boolean)dt.Rows[0]["SecondaryCity"];
        aa.SecondaryState = (Boolean)dt.Rows[0]["SecondaryState"];
        aa.SecondaryPinZipCode = (Boolean)dt.Rows[0]["SecondaryPinZipCode"];
        aa.SecondaryCountry = (Boolean)dt.Rows[0]["SecondaryCountry"];
        aa.SecondaryPhoneNo = (Boolean)dt.Rows[0]["SecondaryPhoneNo"];
        aa.SecondaryMobileNo = (Boolean)dt.Rows[0]["SecondaryMobileNo"];
        aa.SecondaryEmailId = (Boolean)dt.Rows[0]["SecondaryEmailId"];
        aa.EmergencyName = (Boolean)dt.Rows[0]["EmergencyName"];
        aa.EmergencyMobileNo = (Boolean)dt.Rows[0]["EmergencyMobileNo"];
        aa.EmergencyAlternateMobileNo = (Boolean)dt.Rows[0]["EmergencyAlternateMobileNo"];
        aa.EmergencyPhoneNo = (Boolean)dt.Rows[0]["EmergencyPhoneNo"];
        aa.EmergencyAddress = (Boolean)dt.Rows[0]["EmergencyAddress"];
        aa.EmergencyCity = (Boolean)dt.Rows[0]["EmergencyCity"];
        aa.EmergencyState = (Boolean)dt.Rows[0]["EmergencyState"];
        aa.EmergencyPinZipCode = (Boolean)dt.Rows[0]["EmergencyPinZipCode"];
        aa.EmergencyCountry = (Boolean)dt.Rows[0]["EmergencyCountry"];

        Details.Add(aa);
        return Details.ToArray();
    }

    public class AdmissionExcelPermission
    {
        public Boolean RID { get; set; }
        public Boolean SAMID { get; set; }
        public Boolean IsHostel { get; set; }
        public Boolean HouseID { get; set; }
        public Boolean AdmissionDate { get; set; }
        public Boolean AdmissionNo { get; set; }
        public Boolean RegistrationDate { get; set; }
        public Boolean Registration_No { get; set; }
        public Boolean RefrenceAdmissionNo { get; set; }
        public Boolean studentname { get; set; }
        public Boolean Classname { get; set; }
        public Boolean Sectionname { get; set; }
        public Boolean StudentUID { get; set; }
        public Boolean RegNewNo { get; set; }
        public Boolean Religion { get; set; }
        public Boolean CastCategoryName { get; set; }
        public Boolean StudentDOB { get; set; }
        public Boolean Gender { get; set; }
        public Boolean Nationality { get; set; }
        public Boolean BirthPlace { get; set; }
        public Boolean NoOfSiblings { get; set; }
        public Boolean TransportationRequired { get; set; }
        public Boolean StudentPhotograph { get; set; }
        public Boolean BirthCertificate { get; set; }
        public Boolean DocumentSubmitted { get; set; }
        public Boolean AdditionalInformation { get; set; }
        public Boolean Country { get; set; }
        public Boolean State { get; set; }
        public Boolean City { get; set; }
        public Boolean Pin { get; set; }
        public Boolean Address { get; set; }
        public Boolean BloodGroup { get; set; }
        public Boolean SchoolName { get; set; }
        public Boolean SchoolBoard { get; set; }
        public Boolean SchoolMedium { get; set; }
        public Boolean SchoolPreviousClassName { get; set; }
        public Boolean SchoolPercentageInPreviousClass { get; set; }
        public Boolean SchoolAddress { get; set; }
        public Boolean SchoolContactNo { get; set; }
        public Boolean SchoolAlternateContactNo { get; set; }
        public Boolean SchoolWebsite { get; set; }
        public Boolean PrimarySelectParentType { get; set; }
        public Boolean PrimaryParentName { get; set; }
        public Boolean PrimaryParentNationality { get; set; }
        public Boolean PrimaryHighestQualification { get; set; }
        public Boolean PrimaryParentOccupation { get; set; }
        public Boolean PrimaryDesignation { get; set; }
        public Boolean PrimaryNameOfOrganization { get; set; }
        public Boolean PrimaryAddressOfOfficeBusiness { get; set; }
        public Boolean PrimaryParentAnnualIncome { get; set; }
        public Boolean PrimaryAddress { get; set; }
        public Boolean PrimaryCity { get; set; }
        public Boolean PrimaryState { get; set; }
        public Boolean PrimaryPinZipCode { get; set; }
        public Boolean PrimaryCountry { get; set; }
        public Boolean PrimaryPhoneNo { get; set; }
        public Boolean PrimaryMobileNo { get; set; }
        public Boolean PrimaryEmailId { get; set; }
        public Boolean SecondarySelectParentType { get; set; }
        public Boolean SecondaryParentName { get; set; }
        public Boolean SecondaryParentNationality { get; set; }
        public Boolean SecondaryHighestQualification { get; set; }
        public Boolean SecondaryParentOccupation { get; set; }
        public Boolean SecondaryDesignation { get; set; }
        public Boolean SecondaryNameOfOrganization { get; set; }
        public Boolean SecondaryAddressOfOfficeBusiness { get; set; }
        public Boolean SecondaryParentAnnualIncome { get; set; }
        public Boolean SecondaryAddress { get; set; }
        public Boolean SecondaryCity { get; set; }
        public Boolean SecondaryState { get; set; }
        public Boolean SecondaryPinZipCode { get; set; }
        public Boolean SecondaryCountry { get; set; }
        public Boolean SecondaryPhoneNo { get; set; }
        public Boolean SecondaryMobileNo { get; set; }
        public Boolean SecondaryEmailId { get; set; }
        public Boolean EmergencyName { get; set; }
        public Boolean EmergencyMobileNo { get; set; }
        public Boolean EmergencyAlternateMobileNo { get; set; }
        public Boolean EmergencyPhoneNo { get; set; }
        public Boolean EmergencyAddress { get; set; }
        public Boolean EmergencyCity { get; set; }
        public Boolean EmergencyState { get; set; }
        public Boolean EmergencyPinZipCode { get; set; }
        public Boolean EmergencyCountry { get; set; }
    }

    public class StudentDetails
    {
        public string AdmissionDate { get; set; }

        public string AdmissionNo { get; set; }

        public string RegistrationDate { get; set; }

        public string Registration_No { get; set; }

        public string RefrenceAdmissionNo { get; set; }

        public string studentname { get; set; }

        public string Classname { get; set; }
        public string StudentUID { get; set; }
        public string Religion { get; set; }

        public string CastCategoryName { get; set; }

        public string StudentDOB { get; set; }

        public string Gender { get; set; }

        public string Nationality { get; set; }

        public string BirthPlace { get; set; }

        public string NoOfSiblings { get; set; }

        public string TransportationRequired { get; set; }

        public string StudentPhotograph { get; set; }

        public string BirthCertificate { get; set; }

        public string DocumentSubmitted { get; set; }

        public string AdditionalInformation { get; set; }

        public string Country { get; set; }

        public string State { get; set; }


        public string City { get; set; }

        public string Pin { get; set; }

        public string Address { get; set; }

        public string BloodGroup { get; set; }

        public string SchoolName { get; set; }

        public string SchoolBoard { get; set; }

        public string SchoolMedium { get; set; }

        public string SchoolPreviousClassName { get; set; }

        public string SchoolPercentageInPreviousClass { get; set; }

        public string SchoolAddress { get; set; }

        public string SchoolContactNo { get; set; }

        public string SchoolAlternateContactNo { get; set; }

        public string SchoolWebsite { get; set; }

        public string PrimarySelectParentType { get; set; }

        public string PrimaryParentName { get; set; }

        public string PrimaryParentNationality { get; set; }

        public string PrimaryHighestQualification { get; set; }

        public string PrimaryParentOccupation { get; set; }

        public string PrimaryDesignation { get; set; }

        public string PrimaryNameOfOrganization { get; set; }

        public string PrimaryAddressOfOfficeBusiness { get; set; }




        public string PrimaryParentAnnualIncome { get; set; }

        public string PrimaryAddress { get; set; }

        public string PrimaryCity { get; set; }

        public string PrimaryState { get; set; }

        public string PrimaryPinZipCode { get; set; }

        public string PrimaryCountry { get; set; }

        public string PrimaryPhoneNo { get; set; }

        public string PrimaryMobileNo { get; set; }

        public string PrimaryEmailId { get; set; }

        public string SecondarySelectParentType { get; set; }

        public string SecondaryParentName { get; set; }

        public string SecondaryParentNationality { get; set; }

        public string SecondaryHighestQualification { get; set; }

        public string SecondaryParentOccupation { get; set; }

        public string SecondaryDesignation { get; set; }

        public string SecondaryNameOfOrganization { get; set; }

        public string SecondaryAddressOfOfficeBusiness { get; set; }

        public string SecondaryParentAnnualIncome { get; set; }

        public string SecondaryAddress { get; set; }

        public string SecondaryCity { get; set; }

        public string SecondaryState { get; set; }



        public string SecondaryPinZipCode { get; set; }

        public string SecondaryCountry { get; set; }

        public string SecondaryPhoneNo { get; set; }

        public string SecondaryMobileNo { get; set; }

        public string SecondaryEmailId { get; set; }

        public string EmergencyName { get; set; }

        public string EmergencyMobileNo { get; set; }

        public string EmergencyAlternateMobileNo { get; set; }

        public string EmergencyPhoneNo { get; set; }

        public string EmergencyAddress { get; set; }

        public string EmergencyCity { get; set; }

        public string EmergencyState { get; set; }

        public string EmergencyPinZipCode { get; set; }

        public string EmergencyCountry { get; set; }

    }
    protected void IBExcel_Click(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_studentregistrationlist]", con))
            {
                if (Session["AdmListFilter"] != null)
                {
                    dt = (DataTable)(Session["AdmListFilter"]);
                }
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[15];
                param[0] = new SqlParameter("@mode", 3);
                param[1] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"].ToString());
                param[2] = new SqlParameter("@FromDate", dt.Rows[0]["Fromdate"].ToString());
                param[3] = new SqlParameter("@ToDate", dt.Rows[0]["Todate"].ToString());
                param[4] = new SqlParameter("@registrationno", dt.Rows[0]["Registrationnumber"].ToString());
                param[5] = new SqlParameter("@Studentname", dt.Rows[0]["StudentName"].ToString());
                param[6] = new SqlParameter("@Parentname", dt.Rows[0]["Parentname"].ToString());
                param[7] = new SqlParameter("@ParentMobileNo", dt.Rows[0]["ParentMobileNo"].ToString());
                param[8] = new SqlParameter("@status", dt.Rows[0]["status"].ToString());
                param[9] = new SqlParameter("@applyingforclass", dt.Rows[0]["applyingforclass"].ToString());
                param[10] = new SqlParameter("@Fyid", dt.Rows[0]["Fyid"].ToString());
                param[11] = new SqlParameter("@AdmissionNo", dt.Rows[0]["AdmissionNo"].ToString());
                param[12] = new SqlParameter("@pagesize", 100000);
                param[13] = new SqlParameter("@pageno", 0);
                param[14] = new SqlParameter("@SectionID", dt.Rows[0]["SectionID"].ToString());
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);
                cmd.Parameters.Add(param[6]);
                cmd.Parameters.Add(param[7]);
                cmd.Parameters.Add(param[8]);
                cmd.Parameters.Add(param[9]);
                cmd.Parameters.Add(param[10]);
                cmd.Parameters.Add(param[11]);
                cmd.Parameters.Add(param[12]);
                cmd.Parameters.Add(param[13]);
                cmd.Parameters.Add(param[14]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        using (XLWorkbook wb = new XLWorkbook())
                        {
                            wb.Worksheets.Add(ds.Tables[0]);
                            Response.Clear();
                            Response.Buffer = true;
                            Response.Charset = "";
                            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                            Response.AddHeader("content-disposition", "attachment;filename=SqlExport.xlsx");
                            using (MemoryStream MyMemoryStream = new MemoryStream())
                            {
                                wb.SaveAs(MyMemoryStream);
                                MyMemoryStream.WriteTo(Response.OutputStream);
                                Response.Flush();
                                Response.End();
                            }
                        }
                    }
                }
            }
        }

    }

    protected void CustomExcel_Click(object sender, EventArgs e)
    {
        DataUtility Objdut = new DataUtility();
        DataTable dt = new DataTable();
        DataTable dtFilter = new DataTable();
        if (HttpContext.Current.Session["CUSTOMEXCELFORADMISSION"] != null)
        {
            dt = (DataTable)HttpContext.Current.Session["CUSTOMEXCELFORADMISSION"];
            if (dt.Rows.Count > 0)
            {
                dt.Columns.Remove("RowNumber");
                DataTable dtPermission = Objdut.GetDataTableSP("[SP_FilterCustomExcelPermission]");

                foreach (DataColumn column in dtPermission.Columns)
                {
                    dt.Columns.Remove(column.ColumnName);
                }

                dt.Columns.Add("Sl.No", typeof(System.Int32)).SetOrdinal(0);

                int i = 0;
                foreach (DataRow row in dt.Rows)
                {
                    //need to set value to NewColumn column
                    row["Sl.No"] = i + 1;   // or set it to some other value
                    i++;
                }

                using (XLWorkbook wb = new XLWorkbook())
                {
                    wb.Worksheets.Add(dt);
                    Response.Clear();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=CustomSqlExport.xlsx");
                    using (MemoryStream MyMemoryStream = new MemoryStream())
                    {
                        wb.SaveAs(MyMemoryStream);
                        MyMemoryStream.WriteTo(Response.OutputStream);
                        Response.Flush();
                        Response.End();
                    }
                }
            }
        }        
    }

   
}