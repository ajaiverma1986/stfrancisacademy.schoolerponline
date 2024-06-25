using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AdmissionBeforeLogin_AdmissionHome : System.Web.UI.Page
{
    private int IdStudent = 0;
    private DataUtility Objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindAllDDLOfPage();
        }
    }
    private void BindAllDDLOfPage()
    {
        BindSessionDDL();
        BindBranchDDL();
        BindBloodGroup();
        BindParentType();
        BindQualification();
        BindHouse();
    }

    public void BindBranchDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlBranchID.DataSource = CommonClass.Dll("BranchDll");
        ddlBranchID.DataValueField = "BrID";
        ddlBranchID.DataTextField = "BrName";
        ddlBranchID.DataBind();
    }

    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlregistrationsession.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlregistrationsession.DataValueField = "Fyid";
        ddlregistrationsession.DataTextField = "FYName";
        ddlregistrationsession.DataBind();
    }

    [WebMethod]
    public static BIndClass[] BindClassDDL(string Fyid, string Brid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(Fyid), Convert.ToInt32(Brid));
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

    [WebMethod]
    public static BindSection[] BindSectionDDL(string Classid, string Brid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("sectiondll", Convert.ToInt32(Classid), Convert.ToInt32(Brid));
        List<BindSection> BindObj = new List<BindSection>();
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            BindSection Obj = new BindSection();
            Obj.SECTIONID = Dt.Rows[i]["cwsid"].ToString();
            Obj.SECTIONNAME = Dt.Rows[i]["sectionname"].ToString();
            BindObj.Add(Obj);
        }
        return BindObj.ToArray();
    }
    public class BindSection
    {
        public string SECTIONID { get; set; }
        public string SECTIONNAME { get; set; }
    }

    public class BIndClass
    {
        public string ID { get; set; }

        public string ClassName { get; set; }
    }

    public void BindClass()
    {
        DataTable Dt = new DataTable();
        CommonClass CommonClass = new CommonClass();
        Dt = CommonClass.ABC("GetMasterClassDDL");
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
            ddlsecondaryparenttype.DataSource = Dt;
            ddlsecondaryparenttype.DataTextField = "Relation";
            ddlsecondaryparenttype.DataValueField = "Id";
            ddlsecondaryparenttype.DataBind();
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
    public void BindHouse()
    {
        CommonClass CommonClass = new CommonClass();
        ddlHouse.DataSource = CommonClass.Dll("GetHouse", Convert.ToInt32(ddlBranchID.SelectedValue));
        ddlHouse.DataValueField = "HouseID";
        ddlHouse.DataTextField = "Housename";
        ddlHouse.DataBind();
        ListItem li = new ListItem("--Select House Name--", "0");
        ddlHouse.Items.Insert(0, li);
    }

    public void EmptyAllControls()
    {
        rbtnlistHostal.SelectedValue = "0";
        ddlHouse.SelectedValue = "0";
        txtOldRegNo.Text = "";
        ddlregistrationsession.SelectedValue = "0";
        txtadmissionreferenceno.Text = "";
        txtstudentfirstname.Text = "";
        txtstudentmiddlename.Text = "";
        txtstudentlastname.Text = "";
        txtstudentdob.Text = "";
        txtstudentUid.Text = "";
        rbtnlistgender.SelectedValue = "0";
        rbtnlistnationality.SelectedValue = "0";
        txtbirthplace.Text = "";
        txtreligion.Text = "";
        txtmothertongue.Text = "";
        txtnoofsibbling.Text = "";
        rbtnlistcast.SelectedValue = "0";
        ddlapplyingforclass.SelectedValue = "0";
        rbtntransportationrequired.SelectedValue = "0";
        txttotalsubmiteddocument.InnerText = "";
        txtadditionalinformation.InnerText = "";
        txtaddress.InnerText = "";
        txtcity.Text = "";
        txtstate.Text = "";
        txtpiorzipcode.Text = "";
        txtcountry.Text = "";
        ddlbloodgroup.SelectedValue = "0";
        txtschoolname.Text = "";
        txtboard.Text = "";
        txtmedium.Text = "";
        txtclassname.Text = "";
        txtpreviusclsspercentage.Text = "";
        txtschooladdress.InnerText = "";
        txtcontactno.Text = "";
        txtalternatecontactno.Text = "";
        txtwesite.Text = "";
        ddlparenttype.SelectedValue = "0";
        txtparentfirstname.Text = "";
        txtparentmiddlename.Text = "";
        txtparentlastname.Text = "";
        txtparentdateofbirth.Text = "";
        txtparentnationality.Text = "";
        ddlparentqualification.SelectedValue = "0";
        txtparentoccupation.Text = "";
        txtparentdesignation.Text = "";
        txtparentorganization.Text = "";
        txtofficeaddress.Text = "";
        txtannualincome.Text = "";
        txtparentaddress.InnerText = "";
        txtparentcity.Text = "";
        txtparentstate.Text = "";
        txtparentpincodeorzipcode.Text = "";
        txtparentcountry.Text = "";
        txtparentphoneno.Text = "";
        txtparentmobileno.Text = "";
        txtparentemailid.Text = "";
        txtsecondaryparentfirstname.Text = "";
        txtsecondaryparentmiddlename.Text = "";
        txsecondaryparentlastname.Text = "";
        txtsecondaryparentdateofbirth.Text = "";
        txtsecondaryparentnationality.Text = "";
        ddlsecondaryparenthighestqualification.SelectedValue = "0";
        txtsecondaryparentoccupation.Text = "";
        txtsecondaryparentdesignation.Text = "";
        txtnameoforganizationofsecondayparent.Text = "";
        txtbusinessorofficeaddressofsecondayparent.InnerText = "";
        txtsecondaryparentannualincome.Text = "";
        txsecondayparentaddress.InnerText = "";
        txtsecondaryparentcity.Text = "";
        txtsecondaryparentstate.Text = "";
        txtsecondayparentpinorzipcode.Text = "";
        txsecondaryparentcountry.Text = "";
        txtsecondaryparentphoneno.Text = "";
        txtsecondaryparentmobileno.Text = "";
        txtsecondaryparentemailid.Text = "";
        txtnameofcontactpersonincaseofemergency.Text = "";
        txtemergencymobileno.Text = "";
        txtemergencyalternatemobileno.Text = "";
        txtemegencycontactpersonphoneno.Text = "";
        txtemergencycontactpersonaddress.InnerText = "";
        txtemergencycontactpersoncity.Text = "";
        txtemergencycontactpersonstate.Text = "";
        txtemergencycontactpersonpinorzipcode.Text = "";
        txtemergencycontactpersoncountry.Text = "";
        txtcomment.InnerText = "";
        lblStudentPhotograph.Text = "";
        txtdiscountcode.Text = "";
        imguser.Visible = false;
        lblStudentcertificate.Text = "";
        Image1.Visible = false;
        lblparentfirstphoto.Text = "";
        Image2.Visible = false;
        lblparentsecondphoto.Text = "";
        Image3.Visible = false;
    }

    public void FillDetails(int studenregistrationid)
    {
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 4);
        param[1] = new SqlParameter("@Brid", ddlBranchID.SelectedValue.ToString());
        param[2] = new SqlParameter("@studenregistrationid", studenregistrationid);
        DataTable Dt = Objdut.GetDataTableSP(param, "usp_studentregistrationlist");
        if (Dt.Rows.Count > 0)
        {
            BindAllDDLOfPage();
            rbtnlistHostal.SelectedValue = Convert.ToString(Dt.Rows[0]["IsHostel"]);
            ddlHouse.SelectedValue = Convert.ToString(Dt.Rows[0]["HouseID"]);
            txtOldRegNo.Text = Convert.ToString(Dt.Rows[0]["RegNewNo"]);
            ddlregistrationsession.SelectedValue = Convert.ToString(Dt.Rows[0]["Fyid"]);
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
            txtcomment.InnerText = Convert.ToString(Dt.Rows[0]["Comment"]);
            lblStudentPhotograph.Text = Dt.Rows[0]["StudentPhotograph"].ToString();
            txtdiscountcode.Text = "";
            if (lblStudentPhotograph.Text != "")
            {
                imguser.Style.Add("display", "block");
                imguser.ImageUrl = "~/BranchPanel/Student-Registration/student-registration-document/" + Dt.Rows[0]["StudentPhotograph"].ToString();
            }
            else
            {
                imguser.Visible = false;
            }
            lblStudentcertificate.Text = Dt.Rows[0]["BirthCertificate"].ToString();
            if (lblStudentcertificate.Text != "")
            {
                Image1.Style.Add("display", "block");
                Image1.ImageUrl = "~/BranchPanel/Student-Registration/student-registration-document/" + Dt.Rows[0]["BirthCertificate"].ToString();
            }
            else
            {
                Image1.Visible = false;
            }
            lblparentfirstphoto.Text = Dt.Rows[0]["PrimaryUploadParentPhotograph"].ToString();
            if (lblparentfirstphoto.Text != "")
            {
                Image2.Style.Add("display", "block");
                Image2.ImageUrl = "~/BranchPanel/Student-Registration/student-registration-document/" + Dt.Rows[0]["PrimaryUploadParentPhotograph"].ToString();
            }
            else
            {
                Image2.Visible = false;
            }
            lblparentsecondphoto.Text = Dt.Rows[0]["SecondaryUploadParentPhotograph"].ToString();
            if (lblparentsecondphoto.Text != "")
            {
                Image3.Style.Add("display", "block");
                Image3.ImageUrl = "~/BranchPanel/Student-Registration/student-registration-document/" + Dt.Rows[0]["SecondaryUploadParentPhotograph"].ToString();
            }
            else
            {
                Image3.Visible = false;
            }
        }
        else
        {
            Response.Redirect("student-list.aspx");
        }
    }
    protected void txtregistrationno_TextChanged(object sender, EventArgs e)
    {
        if (txtregistrationno.Text.Trim() != "")
        {
            int studenregistrationid = Convert.ToInt32(Objdut.GetScalar("Select RID From tbl_StudentRegistration Where Registration_No='" + txtregistrationno.Text.Trim() + "'                  and IsAdmissionTaken=0 and Status=1"));
            if (studenregistrationid > 0)
            {
                FillDetails(studenregistrationid);
            }
            else
            {
                Utility.ViewAlertMessage(this, "Sorry....!!!!!! Invalid Registration No.Please enter Valid One.");
                txtregistrationno.Text = "";
            }
        }
    }
    protected void txtdiscountcode_TextChanged(object sender, EventArgs e)
    {
        if (txtdiscountcode.Text.Trim() != "")
        {
            string DiscountCode = Convert.ToString(Objdut.GetScalar("Select DiscountCode From DiscountedStudent_Info Where DiscountCode='" + txtdiscountcode.Text.Trim() + "' and               IActive=1 And IsDiscountImplemented=0"));
            if (DiscountCode != "")
            {
                FillDetailsOnTheBehalfOfDiscount(DiscountCode);
            }
            else
            {
                Utility.ViewAlertMessage(this, "Sorry....!!!!!! Invalid Discount Code.Please enter Valid One.");
                txtdiscountcode.Text = "";
            }
        }
    }
    public void FillDetailsOnTheBehalfOfDiscount(string DiscountCode)
    {
        string Query = @"Select Registration_No,Fyid,Sfname,Smname,Slname,Convert(Varchar(11),DOB,106) As DOB,ClassId,Pfname,Pmname,Plname,PmobileNo,Paddress 
        From DiscountedStudent_Info Where DiscountCode='" + DiscountCode + "' And IsDiscountImplemented=0 And IActive=1";
        DataTable DT;
        DT = Objdut.GetDataTable(Query);
        if (DT.Rows.Count > 0)
        {
            txtregistrationno.Text = Convert.ToString(DT.Rows[0]["Registration_No"]);
            ddlregistrationsession.SelectedValue = Convert.ToString(DT.Rows[0]["Fyid"]);
            txtstudentfirstname.Text = Convert.ToString(DT.Rows[0]["Sfname"]);
            txtstudentmiddlename.Text = Convert.ToString(DT.Rows[0]["Smname"]);
            txtstudentlastname.Text = Convert.ToString(DT.Rows[0]["Slname"]);
            txtstudentdob.Text = Convert.ToString(DT.Rows[0]["DOB"]);
            ddlapplyingforclass.SelectedValue = Convert.ToString(DT.Rows[0]["ClassId"]);
            txtparentfirstname.Text = Convert.ToString(DT.Rows[0]["Pfname"]);
            txtparentmiddlename.Text = Convert.ToString(DT.Rows[0]["Pmname"]);
            txtparentlastname.Text = Convert.ToString(DT.Rows[0]["Plname"]);
            txtparentaddress.InnerText = Convert.ToString(DT.Rows[0]["Paddress"]);
            txtparentmobileno.Text = Convert.ToString(DT.Rows[0]["PmobileNo"]);
        }
    }

    protected void btnforupdateorsave_Click1(object sender, EventArgs e)
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
        if (Count == 0)
        {
            IdStudent = Convert.ToInt16(Objdut.GetScalar("select Isnull(MAX(RID),0)+1 from tbl_studentregistration where fyid=" + ddlregistrationsession.SelectedValue));
            SqlParameter[] Param = new SqlParameter[112];
            Param[00] = new SqlParameter("@Brid", ddlBranchID.SelectedValue);
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
                string FileName = Convert.ToString(IdStudent) + fileuploaderofstudentphotograph.FileName;
                fileuploaderofstudentphotograph.PostedFile.SaveAs(Server.MapPath("~/BranchPanel/Student-Registration/student-registration-document/" + FileName));
                Param[19] = new SqlParameter("@StudentPhotograph", FileName);
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
            Param[90] = new SqlParameter("@RegistrationFee", "0.00");
            Param[91] = new SqlParameter("@PaymentMode", "1");
            Param[92] = new SqlParameter("@BankName", "");
            Param[93] = new SqlParameter("@BranchName", "");
            Param[94] = new SqlParameter("@ChkRefNo", "");
            Param[95] = new SqlParameter("@ChkRefDate", "");
            Param[96] = new SqlParameter("@RegistrationDate", txtregistrationdate.Text.Trim());
            Param[97] = new SqlParameter("@Comment", txtcomment.InnerText.Trim());
            Param[98] = new SqlParameter("@DiscountCode", txtdiscountcode.Text.Trim());
            Param[99] = new SqlParameter("@Registration_NoForAdmissionORUpdate", txtregistrationno.Text.Trim());
            Param[100] = new SqlParameter("@IsComeFromAdmission", 1);
            Param[101] = new SqlParameter("@Section_Id", Request.Form[ddlsection.UniqueID]);
            Param[102] = new SqlParameter("@intresult", Convert.ToInt32("0"));
            Param[102].Direction = ParameterDirection.Output;
            Param[103] = new SqlParameter("@StudentUID", txtstudentUid.Text.Trim());
            Param[104] = new SqlParameter("@RegNewNo", txtOldRegNo.Text.Trim());
            Param[105] = new SqlParameter("@IsHostel", Convert.ToInt32(rbtnlistHostal.SelectedValue));
            Param[106] = new SqlParameter("@HouseID", Convert.ToInt32(ddlHouse.SelectedValue));

            if (chkAadharCard.Checked) { Param[107] = new SqlParameter("@Aadhar_Card", 1); } else { Param[107] = new SqlParameter("@Aadhar_Card", 0); }
            if (ChkBirthCertificate.Checked) { Param[108] = new SqlParameter("@Birth_Certificate", 1); } else { Param[108] = new SqlParameter("@Birth_Certificate", 0); }
            if (chkMigrationCertificate.Checked) { Param[109] = new SqlParameter("@Migration_Certificate", 1); } else { Param[109] = new SqlParameter("@Migration_Certificate", 0); }
            if (chkCasteCertificate.Checked) { Param[110] = new SqlParameter("@Caste_Certificate", 1); } else { Param[110] = new SqlParameter("@Caste_Certificate", 0); }
            if (chkLastYearMarksheet.Checked) { Param[111] = new SqlParameter("@LastYear_Marksheet", 1); } else { Param[111] = new SqlParameter("@LastYear_Marksheet", 0); }

            int intresult = Objdut.ExecuteSqlSP(Param, "[usp_StudentRegistration]");
            if (intresult == 1)
            {
                savestudentitem objsave = new savestudentitem();
                string RegNo = objsave.updateORinsertHostelFee(txtregistrationno.Text.Trim(), Convert.ToInt32(ddlBranchID.SelectedValue), txtstudentfirstname.Text.Trim(), Convert.ToInt32(rbtnlistHostal.SelectedValue)).ToString();
                int RIDNEW = Convert.ToInt32(Objdut.GetScalar("Select isnull(rid,0) from tbl_StudentRegistration where  Registration_No='" + RegNo + "' and Brid=" + Convert.ToInt32(ddlBranchID.SelectedValue) + ""));
                int result = sendFeeRemainder(RIDNEW.ToString());
                if (result == 5)
                {
                    Utility.ViewAlertMessage(this, "Admission successfully done and Send SMS to Mobile.");
                }
                else
                {
                    Utility.ViewAlertMessage(this, "Admission successfully done But not Send SMS to Mobile.");
                }
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup();", true);
                return;
            }
            else if (intresult == 2)
            {
                Utility.ViewAlertMessage(this, "Please Fill All The Manedatery Field.");
                return;
            }
            else if (intresult == 2)
            {
                Utility.ViewAlertMessage(this, "Please Enter Date In Valid Format.");
                return;
            }
            else if (intresult == 0)
            {
                Utility.ViewAlertMessage(this, "Some Error Occur While Inserting The Record.");
                return;
            }
            EmptyAllControls();
        }
    }
    protected void btnforcancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("student-list.aspx");
    }

    public static int getStudentMobileNoForShorlist(string MobileNo, int rid, string msg1, string msg2, string msg3,int brid)
    {
        try
        {
            DataUtility Objdut = new DataUtility();
            string api = "";
            if (Convert.ToInt32(brid) > 0)
            {
                api = (string)(Objdut.GetScalar("select isnull(sms_api,'') sms_api from tbl_smsapisetting where Brid=" + brid + " and status=1"));
            }

            string Name = Objdut.GetScalar("select DISTINCT sr.StudentFirstName as studentname " +
                        " from tbl_StudentRegistration sr where sr.RID =" + rid + " and Brid=" + brid + "").ToString();
            if (MobileNo.Length > 9)
            {
                string msg = msg1 + (Name.ToString()) + msg2 + msg3;                
                int result = sendMessageToMobile.SMSSend(MobileNo, msg, api);
                return 5;
            }
            return 1;
        }
        catch
        {
            return 0;
        }
        finally
        {
            MobileNo = "";
        }
    }

    public int sendFeeRemainder(string RID)
    {
        int result = 0;
        DataTable DtFeeRemind = new DataTable();
        CommonClass ObjClass = new CommonClass();
        if (RID != "")
        {
            string[] ID = RID.Split(',');
            if (ID.Length > 0)
            {
                for (int i = 0; i < ID.Length; i++)
                {
                    DtFeeRemind = CommonClass.recentfee("MasterAdm_Mobile", 0, Convert.ToInt32(ID[i]));
                    if (DtFeeRemind.Rows.Count > 0)
                    {
                        if (DtFeeRemind.Rows[0]["MobileNO"].ToString().Length > 9)
                        {
                            string msg1 = "", msg2 = "", msg3 = "";
                            msg1 = "Welcome Message ! Dear ";
                            msg2 = " , Admission process is done. your Student ID-'" + DtFeeRemind.Rows[0]["Registration_No"].ToString() + ". 'To Pay fee online goto http://sanskaarint.schoolerponline.in/emp-login.aspx. ";

                            msg3 = "Your loginid and passowrd are " + DtFeeRemind.Rows[0]["Registration_No"].ToString() + " and " + DtFeeRemind.Rows[0]["Password"].ToString();

                            result = getStudentMobileNoForShorlist(DtFeeRemind.Rows[0]["MobileNO"].ToString(), Convert.ToInt32(ID[i]), msg1, msg2, msg3, Convert.ToInt32(ddlBranchID.SelectedValue));

                            string Name = Objdut.GetScalar("select DISTINCT sr.StudentFirstName as studentname " +
                                    " from tbl_StudentRegistration sr where sr.Registration_No ='" + DtFeeRemind.Rows[0]["Registration_No"].ToString() + "'").ToString();

                            lblLoginID.Text = msg1 + (Name.ToString()) + msg2 + msg3; ;
                        }
                    }
                }
            }
        }

        return result;
    }
}