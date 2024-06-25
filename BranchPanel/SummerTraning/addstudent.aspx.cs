using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_SummerTraning_addstudent : System.Web.UI.Page
{
    DataUtility obj = new DataUtility();
    CommonClass CommonClass = new CommonClass();
    int id = 0;
    int mode = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDDl();
            if (Request.QueryString.Count > 0)
            {
                id = Convert.ToInt32(Request.QueryString[0]);
                SSCID.Value = id.ToString();
                FillStudentData(id);
            }
            else
            {
                SSCID.Value = "0";
            }
        }        
    }

    protected void txtregistrationno_TextChanged(object sender, EventArgs e)
    {
        if (txtregistrationno.Text.Trim() != "")
        {
            int studenregistrationid = Convert.ToInt32(obj.GetScalar("Select RID From tbl_StudentRegistration Where Registration_No='" + txtregistrationno.Text.Trim() + "'                  and IsAdmissionTaken=0 and Status=1"));
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
    public void FillDetails(int studenregistrationid)
    {
        DataTable Dt1 = new DataTable();
        CommonClass CommonClass = new CommonClass();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        Dt1 = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ddlsession.SelectedValue), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));

        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 4);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@studenregistrationid", studenregistrationid);
        DataTable Dt = obj.GetDataTableSP(param, "usp_studentregistrationlist");
        if (Dt.Rows.Count > 0)
        {
            // BindAllDDLOfPage();
            if (Dt1.Rows.Count > 0)
            {
                ddlclass.DataSource = Dt1;
                ddlclass.DataTextField = "Classname";
                ddlclass.DataValueField = "classid";
                ddlclass.DataBind();
                ListItem li = new ListItem("--Select Class--", "0");
                ddlclass.Items.Insert(0, li);
            }
            //rbtnlistHostal.SelectedValue = Convert.ToString(Dt.Rows[0]["IsHostel"]);
            //ddlHouse.SelectedValue = Convert.ToString(Dt.Rows[0]["HouseID"]);
            //txtOldRegNo.Text = Convert.ToString(Dt.Rows[0]["RegNewNo"]);
            //ddlregistrationsession.SelectedValue = Convert.ToString(Dt.Rows[0]["Fyid"]);
            txtadmissionreferenceno.Text = Convert.ToString(Dt.Rows[0]["RefrenceAdmissionNo"]);
            txtstudentfirstname.Text = Convert.ToString(Dt.Rows[0]["StudentFirstName"]);
            txtstudentmiddlename.Text = Convert.ToString(Dt.Rows[0]["StudentMiddleName"]);
            txtstudentlastname.Text = Convert.ToString(Dt.Rows[0]["StudentLastName"]);
            txtstudentdob.Text = Convert.ToString(Dt.Rows[0]["StudentDOB"]);
            // txtstudentUid.Text = Convert.ToString(Dt.Rows[0]["StudentUID"]);
            rbtnlistgender.SelectedValue = Convert.ToString(Dt.Rows[0]["Gender"]);
            //rbtnlistnationality.SelectedValue = Convert.ToString(Dt.Rows[0]["Nationality"]);
            //txtbirthplace.Text = Convert.ToString(Dt.Rows[0]["BirthPlace"]);
            //txtreligion.Text = Convert.ToString(Dt.Rows[0]["Religion"]);
            //txtmothertongue.Text = Convert.ToString(Dt.Rows[0]["MotherTongue"]);
            //txtnoofsibbling.Text = Convert.ToString(Dt.Rows[0]["NoOfSiblings"]);
            //rbtnlistcast.SelectedValue = Convert.ToString(Dt.Rows[0]["CastCategoryId"]);
            ddlclass.SelectedValue = Convert.ToString(Dt.Rows[0]["ApplyingForClass"]);
            //rbtntransportationrequired.SelectedValue = Convert.ToString(Dt.Rows[0]["TransportationRequired"]);
            //txttotalsubmiteddocument.InnerText = Convert.ToString(Dt.Rows[0]["DocumentSubmitted"]);
            //txtadditionalinformation.InnerText = Convert.ToString(Dt.Rows[0]["AdditionalInformation"]);
            txtaddress.InnerText = Convert.ToString(Dt.Rows[0]["Address"]);
            txtcity.Text = Convert.ToString(Dt.Rows[0]["City"]);
            txtstate.Text = Convert.ToString(Dt.Rows[0]["State"]);
            txtpiorzipcode.Text = Convert.ToString(Dt.Rows[0]["Pin"]);
            txtcountry.Text = Convert.ToString(Dt.Rows[0]["Country"]);
            //ddlbloodgroup.SelectedValue = Convert.ToString(Dt.Rows[0]["BloodGroup"]);
            //txtschoolname.Text = Convert.ToString(Dt.Rows[0]["SchoolName"]);
            //txtboard.Text = Convert.ToString(Dt.Rows[0]["SchoolBoard"]);
            //txtmedium.Text = Convert.ToString(Dt.Rows[0]["SchoolMedium"]);
            //txtclassname.Text = Convert.ToString(Dt.Rows[0]["SchoolPreviousClassName"]);
            //txtpreviusclsspercentage.Text = Convert.ToString(Dt.Rows[0]["SchoolPercentageInPreviousClass"]);
            //txtschooladdress.InnerText = Convert.ToString(Dt.Rows[0]["SchoolAddress"]);
            //txtcontactno.Text = Convert.ToString(Dt.Rows[0]["SchoolContactNo"]);
            //txtalternatecontactno.Text = Convert.ToString(Dt.Rows[0]["SchoolAlternateContactNo"]);
            //txtwesite.Text = Convert.ToString(Dt.Rows[0]["SchoolWebsite"]);
            //ddlparenttype.SelectedValue = Convert.ToString(Dt.Rows[0]["PrimarySelectParentType"]);
            txtpname.Text = Convert.ToString(Dt.Rows[0]["PrimaryParentFirstName"]) + " " + Convert.ToString(Dt.Rows[0]["PrimaryParentMiddleName"]) + " " + Convert.ToString(Dt.Rows[0]["PrimaryParentLastName"]);
            //txtparentmiddlename.Text = Convert.ToString(Dt.Rows[0]["PrimaryParentMiddleName"]);
            //txtparentlastname.Text = Convert.ToString(Dt.Rows[0]["PrimaryParentLastName"]);
            //txtparentdateofbirth.Text = Convert.ToString(Dt.Rows[0]["PrimaryParentDOB"]);
            //txtparentnationality.Text = Convert.ToString(Dt.Rows[0]["PrimaryParentNationality"]);
            //ddlparentqualification.SelectedValue = Convert.ToString(Dt.Rows[0]["PrimaryHighestQualification"]);
            //txtparentoccupation.Text = Convert.ToString(Dt.Rows[0]["PrimaryParentOccupation"]);
            //txtparentdesignation.Text = Convert.ToString(Dt.Rows[0]["PrimaryDesignation"]);
            //txtparentorganization.Text = Convert.ToString(Dt.Rows[0]["PrimaryNameOfOrganization"]);
            //txtofficeaddress.Text = Convert.ToString(Dt.Rows[0]["PrimaryAddressOfOfficeBusiness"]);
            //txtannualincome.Text = Convert.ToString(Dt.Rows[0]["PrimaryParentAnnualIncome"]);
            //txtparentaddress.InnerText = Convert.ToString(Dt.Rows[0]["PrimaryAddress"]);
            //txtparentcity.Text = Convert.ToString(Dt.Rows[0]["PrimaryCity"]);
            //txtparentstate.Text = Convert.ToString(Dt.Rows[0]["PrimaryState"]);
            //txtparentpincodeorzipcode.Text = Convert.ToString(Dt.Rows[0]["PrimaryPinZipCode"]);
            //txtparentcountry.Text = Convert.ToString(Dt.Rows[0]["PrimaryCountry"]);
            //txtparentphoneno.Text = Convert.ToString(Dt.Rows[0]["PrimaryPhoneNo"]);
            txtpmobile.Text = Convert.ToString(Dt.Rows[0]["PrimaryMobileNo"]);
            //txtparentemailid.Text = Convert.ToString(Dt.Rows[0]["PrimaryEmailId"]);
            //txtsecondaryparentfirstname.Text = Convert.ToString(Dt.Rows[0]["SecondaryParentFirstName"]);
            //txtsecondaryparentmiddlename.Text = Convert.ToString(Dt.Rows[0]["SecondaryParentMiddleName"]);
            //txsecondaryparentlastname.Text = Convert.ToString(Dt.Rows[0]["SecondaryParentLastName"]);
            //txtsecondaryparentdateofbirth.Text = Convert.ToString(Dt.Rows[0]["SecondaryParentDOB"]);
            //txtsecondaryparentnationality.Text = Convert.ToString(Dt.Rows[0]["SecondaryParentNationality"]);
            //ddlsecondaryparenthighestqualification.SelectedValue = Convert.ToString(Dt.Rows[0]["SecondaryHighestQualification"]);
            //txtsecondaryparentoccupation.Text = Convert.ToString(Dt.Rows[0]["SecondaryParentOccupation"]);
            //txtsecondaryparentdesignation.Text = Convert.ToString(Dt.Rows[0]["SecondaryDesignation"]);
            //txtnameoforganizationofsecondayparent.Text = Convert.ToString(Dt.Rows[0]["SecondaryNameOfOrganization"]);
            //txtbusinessorofficeaddressofsecondayparent.InnerText = Convert.ToString(Dt.Rows[0]["SecondaryAddressOfOfficeBusiness"]);
            //txtsecondaryparentannualincome.Text = Convert.ToString(Dt.Rows[0]["SecondaryParentAnnualIncome"]);
            //txsecondayparentaddress.InnerText = Convert.ToString(Dt.Rows[0]["SecondaryAddress"]);
            //txtsecondaryparentcity.Text = Convert.ToString(Dt.Rows[0]["SecondaryCity"]);
            //txtsecondaryparentstate.Text = Convert.ToString(Dt.Rows[0]["SecondaryState"]);
            //txtsecondayparentpinorzipcode.Text = Convert.ToString(Dt.Rows[0]["SecondaryPinZipCode"]);
            //txsecondaryparentcountry.Text = Convert.ToString(Dt.Rows[0]["SecondaryCountry"]);
            //txtsecondaryparentphoneno.Text = Convert.ToString(Dt.Rows[0]["SecondaryPhoneNo"]);
            //txtsecondaryparentmobileno.Text = Convert.ToString(Dt.Rows[0]["SecondaryMobileNo"]);
            //txtsecondaryparentemailid.Text = Convert.ToString(Dt.Rows[0]["SecondaryEmailId"]);
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
        }
    }
    protected void BindDDl()
    {
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlsession.DataSource = Dt;
        ddlsession.DataValueField = "fyid";
        ddlsession.DataTextField = "FYName";
        ddlsession.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlsession.SelectedValue = Convert.ToString(ActiveFinancialyear);
        BindClass();
    }
    protected void BindClass() 
    {
        ddlclass.Items.Clear();
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@brid", Session["BrBrid"]);
        param[2] = new SqlParameter("@fyid", ddlsession.SelectedValue);
        dt = obj.GetDataTableSP(param, "Usp_Class");
        if (dt.Rows.Count > 0)
        {
            ddlclass.DataSource = dt;
            ddlclass.DataValueField = "classid";
            ddlclass.DataTextField = "Classname";
            ddlclass.DataBind();
        }
        ddlclass.Items.Insert(0, new ListItem("--Select Class--", "0"));
    }
    protected void btnforupdateorsave_Click(object sender, EventArgs e)
    {
        if (btnforupdateorsave.Text == "Update")
        {
            mode = 4;
        }
        else
        {
            mode = 1;
        }
        DataUtility objDut=new DataUtility();
        SqlParameter[] param = new SqlParameter[39];
        param[0] = new SqlParameter("@Brid",Session["BrBrid"]);
        param[1] = new SqlParameter("@Fyid",ddlsession.SelectedValue);
        param[2] = new SqlParameter("@classid",ddlclass.SelectedValue);
        param[3] = new SqlParameter("@AdmissionNo",txtadmissionreferenceno.Text);
        param[4] = new SqlParameter("@StudentFirstName",txtstudentfirstname.Text);
        param[5] = new SqlParameter("@StudentMiddleName",txtstudentmiddlename.Text);
        param[6] = new SqlParameter("@StudentLastName",txtstudentlastname.Text);
        param[7] = new SqlParameter("@StudentDOB", txtstudentdob.Text);
        param[8] = new SqlParameter("@Gender", rbtnlistgender.SelectedValue);
        param[9] = new SqlParameter("@ParentName", txtpname.Text);
        param[10] = new SqlParameter("@ParentMobile",txtpmobile.Text);
        param[11] = new SqlParameter("@StudentAddress", txtaddress.InnerText);
        param[12] = new SqlParameter("@StudentCity",txtcity.Text);
        param[13] = new SqlParameter("@StudentState",txtstate.Text);
        param[14] = new SqlParameter("@StudentPinCode",txtpiorzipcode.Text);
        param[15] = new SqlParameter("@studentCountry",txtcountry.Text);
        param[16] = new SqlParameter("@PersonName", txtnameofcontactpersonincaseofemergency.Text);
        param[17] = new SqlParameter("@PersonMobile", txtemergencymobileno.Text);
        param[18] = new SqlParameter("@PersonAltMobile",txtemergencyalternatemobileno.Text);
        param[19] = new SqlParameter("@PersonPhone", txtemegencycontactpersonphoneno.Text);
        param[20] = new SqlParameter("@PersonAddress", txtemergencycontactpersonaddress.InnerText);
        param[21] = new SqlParameter("@PersonCity", txtemergencycontactpersoncity.Text);
        param[22] = new SqlParameter("@PersonState", txtemergencycontactpersonstate.Text);
        param[23] = new SqlParameter("@PersonPin", txtemergencycontactpersonpinorzipcode.Text);
        param[24] = new SqlParameter("@PersonCountry", txtemergencycontactpersoncountry.Text);
        param[25] = new SqlParameter("@Comment", txtcomment.InnerText);
        param[26] = new SqlParameter("@Userid",Session["BrADID"]);
        param[27] = new SqlParameter("@intresult",SqlDbType.Int);
        param[27].Direction = ParameterDirection.Output;
        param[28] = new SqlParameter("@mode", mode);
        param[29] = new SqlParameter("@PaidFee", txtregistrationfee.Text);
        param[30] = new SqlParameter("@PaymentModeId", ddlpaymentmode.SelectedValue);
        param[31] = new SqlParameter("@PaymentModeName", ddlpaymentmode.SelectedItem.Text);
        param[32] = new SqlParameter("@BankName", txtchkddneftbankname.Text);
        param[33] = new SqlParameter("@BranchName", txtchkddneftbranchname.Text);
        param[34] = new SqlParameter("@CHKREFDDREFNo", txtchkddneftrefno.Text);
        param[35] = new SqlParameter("@CHKREFDDDate", txtchkddneftrefdate.Text);
        param[36] = new SqlParameter("@sscid", Convert.ToInt32(SSCID.Value));
        param[37] = new SqlParameter("@ACTIVITYDATE", txtregistrationdate.Text.ToString());
        param[38] = new SqlParameter("@FeeType", ddlFeeType.SelectedValue);
        int result = objDut.ExecuteSqlSP(param, "Usp_SummerCamp");
        if (result == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Student Added Successfully.");
        }
        if (result == 2)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Student Updated Successfully.");
        }
    }

    protected void ddlsession_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindClass();
    }
    protected void FillStudentData(int id)
    {
        btnforupdateorsave.Text = "Update";
        ddlsession.Enabled = false;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        DataTable Dt = new DataTable();
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@sscid", id);
        Dt = objdut.GetDataTableSP(param, "Usp_SummerCamp");
        if (Dt.Rows.Count > 0)
        {
            ddlsession.SelectedValue = Dt.Rows[0]["Fyid"].ToString();
            ddlclass.SelectedValue = Dt.Rows[0]["Classid"].ToString();
            txtadmissionreferenceno.Text = Dt.Rows[0]["AdmissionNo"].ToString();
            txtstudentfirstname.Text = Dt.Rows[0]["StudentFirstName"].ToString();
            txtstudentmiddlename.Text = Dt.Rows[0]["StudentMiddleName"].ToString();
            txtstudentlastname.Text = Dt.Rows[0]["StudentLastName"].ToString();
            txtstudentdob.Text = Dt.Rows[0]["StudentDOB"].ToString();
            rbtnlistgender.SelectedValue = Dt.Rows[0]["Gender"].ToString();
            txtpname.Text = Dt.Rows[0]["ParentName"].ToString();
            txtpmobile.Text = Dt.Rows[0]["ParentMobile"].ToString();
            txtaddress.InnerText = Dt.Rows[0]["ParentAddress"].ToString();
            txtcity.Text = Dt.Rows[0]["ParentCity"].ToString();
            txtstate.Text = Dt.Rows[0]["ParentState"].ToString();
            txtpiorzipcode.Text = Dt.Rows[0]["ParentPinCode"].ToString();
            txtcountry.Text = Dt.Rows[0]["ParentCountry"].ToString();
            txtnameofcontactpersonincaseofemergency.Text = Dt.Rows[0]["Personname"].ToString();
            txtemergencymobileno.Text = Dt.Rows[0]["PersonMobile"].ToString();
            txtemergencyalternatemobileno.Text = Dt.Rows[0]["PersonAltMobile"].ToString();
            txtemegencycontactpersonphoneno.Text = Dt.Rows[0]["PersonPhone"].ToString();
            txtemergencycontactpersonaddress.InnerText = Dt.Rows[0]["PersonAddress"].ToString();
            txtemergencycontactpersoncity.Text = Dt.Rows[0]["PersonCity"].ToString();
            txtemergencycontactpersonstate.Text = Dt.Rows[0]["PersonState"].ToString();
            txtemergencycontactpersonpinorzipcode.Text = Dt.Rows[0]["PersonPin"].ToString();
            txtemergencycontactpersoncountry.Text = Dt.Rows[0]["PersonCountry"].ToString();
            txtcomment.InnerText = Dt.Rows[0]["Comment"].ToString();
            txtregistrationdate.Text = Dt.Rows[0]["ActivityDate"].ToString();

            //payment detailts
            txtregistrationfee.Text = Dt.Rows[0]["PaidFee"].ToString();
            ddlpaymentmode.SelectedValue = Dt.Rows[0]["PaymentModeId"].ToString();
            txtchkddneftbankname.Text = Dt.Rows[0]["BankName"].ToString();
            txtchkddneftbranchname.Text = Dt.Rows[0]["BranchName"].ToString();
            txtchkddneftrefno.Text = Dt.Rows[0]["CHKREFDDREFNo"].ToString();
            txtchkddneftrefdate.Text = Dt.Rows[0]["CHKREFDDDate"].ToString();
            ddlFeeType.SelectedValue = Dt.Rows[0]["FeeType"].ToString();

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "BindPaymentMode('"+ ddlpaymentmode.SelectedValue + "');", true);
        }
    }


    [WebMethod]
    public static float ClassSummerCampFee(string Classid, string Fyid)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", 5);
        param[1] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[2] = new SqlParameter("@classid", Classid);
        param[3] = new SqlParameter("@Fyid", Fyid);
        float result = Convert.ToSingle(Objdut.GetScalerSP(param, "Usp_SummerCamp"));
        return result;
    }
}