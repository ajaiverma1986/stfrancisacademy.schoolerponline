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

public partial class BranchPanel_StudentManagement_pass_out_student_list_aspx : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindSessionDDL();
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
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
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

    public class StudentDetails
    {
        public string AdmissionDate { get; set; }

        public string AdmissionNo { get; set; }

        public string RegistrationDate { get; set; }

        public string Registration_No { get; set; }

        public string RefrenceAdmissionNo { get; set; }

        public string studentname { get; set; }

        public string Classname { get; set; }

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
    [WebMethod]
    public static studentregistration[] BindGridByJs(string Fromdate, string Todate, string Registrationnumber, string StudentName, string Parentname, string ParentMobileNo, int Status, int Applyingforclass, int Fyid, string Admissionnnumber)
    {
        DataSet ds = new DataSet();
        List<studentregistration> details = new List<studentregistration>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_studentadmisionlist]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[13];
                param[0] = new SqlParameter("@mode", 1);
                param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());              
                param[2] = new SqlParameter("@IsCompleted", 1);
                param[3] = new SqlParameter("@FromDate", Fromdate);
                param[4] = new SqlParameter("@ToDate", Todate);
                param[5] = new SqlParameter("@registrationno", Registrationnumber);
                param[6] = new SqlParameter("@Studentname", StudentName);
                param[7] = new SqlParameter("@Parentname", Parentname);
                param[8] = new SqlParameter("@ParentMobileNo", ParentMobileNo);
                param[9] = new SqlParameter("@status", Status);
                param[10] = new SqlParameter("@applyingforclass", Applyingforclass);
                param[11] = new SqlParameter("@Fyid", Fyid);
                param[12] = new SqlParameter("@AdmissionNo", Admissionnnumber);    
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
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dtrow in ds.Tables[0].Rows)
                        {
                            studentregistration user = new studentregistration();
                                user.SAMID = dtrow["SAMID"].ToString();
                                user.AdmissionDate = dtrow["AdmissionDate"].ToString();
                                user.AdmissionNo = dtrow["AdmissionNo"].ToString();
                                user.Registration_No = dtrow["Registration_No"].ToString();
                                user.studentname = dtrow["studentname"].ToString();
                                user.Classname = dtrow["Classname"].ToString();
                                user.fathername = dtrow["fathername"].ToString();
                                user.PrimaryMobileNo = dtrow["PrimaryMobileNo"].ToString();                          
                            details.Add(user);
                        }
                    }
                }
            }
        }
        return details.ToArray();
    }
    public class studentregistration
    {
        public string SAMID { get; set; }
        public string AdmissionDate { get; set; }
        public string AdmissionNo { get; set; }      
        public string Registration_No { get; set; }
        public string studentname { get; set; }
        public string Classname { get; set; }      
        public string fathername { get; set; }
        public string PrimaryMobileNo { get; set; }
    }
}