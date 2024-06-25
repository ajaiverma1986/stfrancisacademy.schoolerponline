using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;


public partial class BranchPanel_Student_Registration_UploadXLStudents : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //CultureInfo enGB = new CultureInfo("en-GB");
        //try
        //{
        //    if (fileuploaderofstudentexeclData.PostedFile != null && fileuploaderofstudentexeclData.PostedFile.ContentLength > 0)
        //    {
        //        UpLoadAndDisplay();
        //    }
        //}
        //catch (Exception ex)
        //{
           
        //}
    }
    private void UpLoadAndDisplay()
    {
        try
        {
            string filename = fileuploaderofstudentexeclData.FileName;
            fileuploaderofstudentexeclData.SaveAs(Server.MapPath(@"../DownloadFiles/ExcelFile/" + filename));
            Session["excelFileName"] = Server.MapPath(@"../DownloadFiles/ExcelFile/" + filename);
        }
        catch (Exception ex)
        {

        }
    }  
    protected void btnforupdateorsave_Click1(object sender, EventArgs e)
    {
        try
        {
            int Error = 0;
            int intresult = 0;
            string filename = fileuploaderofstudentexeclData.FileName;
            fileuploaderofstudentexeclData.SaveAs(Server.MapPath(@"../DownloadFiles/ExcelFile/" + filename));
            Session["excelFileName"] = Server.MapPath(@"../DownloadFiles/ExcelFile/" + filename);

            DataUtility Objdut = new DataUtility();
            if (Session["excelFileName"] != null && Session["excelFileName"].ToString() != "")
            {
                DataSet dsUnUpdated = CommonClass.ImportExcelXLS(Convert.ToString(Session["excelFileName"]), true);
                DataTable tblStudentDtl = new DataTable();
                if (dsUnUpdated != null)
                {
                    for (int i = 0; i < dsUnUpdated.Tables.Count; i++)
                    {
                        if (Convert.ToString(dsUnUpdated.Tables[i]).Contains("Sheet1"))
                        {
                            tblStudentDtl = dsUnUpdated.Tables[i];
                        }
                    }
                }
                else
                {
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "javascript:AlertMsg('Select StudentDtlExcel file.');", true);
                }
                if (tblStudentDtl.Rows.Count > 0)
                {
                    string finicialyear = Objdut.GetScalar("select Fyid from financial_Year where isActive = 1 and isClosed = 0").ToString();

                    for (int j = 0; j < tblStudentDtl.Rows.Count; j++)
                    {
                        if (Convert.ToString(tblStudentDtl.Rows[j]["First_Name"]) != "")
                        {
                            string Registration_NoForAdmissionORUpdate = "";
                            int RID = 0;
                            string StdFName = "";
                            string StdMName = "";
                            string StdLName = "";
                            string StdDOB = "";
                            string StdParentFName = "";
                            string StdParentMName = "";
                            string StdParentLName = "";
                            int StdGender = 0;
                            int StdParentType = 0;
                            string CastID = "";
                            string PrimaryParentDOB = "";
                            string SecondaryParentDOB = "";
                            string RegistrationDate = "";

                            StdFName = tblStudentDtl.Rows[j]["First_Name"].ToString().Trim();
                            StdMName = tblStudentDtl.Rows[j]["Middle_Name"].ToString().Trim();
                            StdLName = tblStudentDtl.Rows[j]["Last_Name"].ToString().Trim();

                            StdDOB = (Convert.ToDateTime(tblStudentDtl.Rows[j]["DOB"].ToString().Trim())).ToString("yyyy-MM-dd");
                            if (tblStudentDtl.Rows[j]["SecondaryParentDOB"].ToString() != "")
                            {
                                PrimaryParentDOB = (Convert.ToDateTime(tblStudentDtl.Rows[j]["PrimaryParentDOB"].ToString().Trim())).ToString("yyyy-MM-dd");
                            }
                            if (tblStudentDtl.Rows[j]["SecondaryParentDOB"].ToString() != "")
                            {
                                SecondaryParentDOB = (Convert.ToDateTime(tblStudentDtl.Rows[j]["SecondaryParentDOB"].ToString().Trim())).ToString("yyyy-MM-dd");
                            }
                            if (tblStudentDtl.Rows[j]["AdmissionDate"].ToString() != "")
                            {
                                RegistrationDate = (Convert.ToDateTime(tblStudentDtl.Rows[j]["AdmissionDate"].ToString().Trim())).ToString("yyyy-MM-dd");
                            }
                            else
                            {
                                RegistrationDate = Convert.ToDateTime(DateTime.Today.ToString("yyyy-MM-dd")).ToString();
                            }

                            StdParentFName = tblStudentDtl.Rows[j]["ParentFname"].ToString().Trim();
                            StdParentMName = tblStudentDtl.Rows[j]["ParentMName"].ToString().Trim();
                            StdParentLName = tblStudentDtl.Rows[j]["ParentLName"].ToString().Trim();
                            StdGender = Convert.ToInt32(tblStudentDtl.Rows[j]["Gender"].ToString().Trim());
                            StdParentType = Convert.ToInt32(tblStudentDtl.Rows[j]["ParentType"].ToString().Trim());
                            CastID = "";

                            CastID = tblStudentDtl.Rows[j]["CastCategoryId"].ToString().Trim();
                            int CLassID = Convert.ToInt32(tblStudentDtl.Rows[j]["ClassID"].ToString().Trim());
                            int SectionID = Convert.ToInt32(tblStudentDtl.Rows[j]["SectionId"].ToString().Trim());

                            Registration_NoForAdmissionORUpdate = tblStudentDtl.Rows[j]["RegNoForUpdate"].ToString().Trim();
                         
                            SqlParameter[] Param = new SqlParameter[94];
                            Param[00] = new SqlParameter("@Brid", Convert.ToInt32(Session["BrBrid"]));
                            Param[01] = new SqlParameter("@Fyid", Convert.ToInt32(finicialyear));
                            Param[02] = new SqlParameter("@Registration_No", "");
                            //Param[03] = new SqlParameter("@RefrenceAdmissionNo", txtadmissionreferenceno.Text.Trim());
                            Param[03] = new SqlParameter("@StudentFirstName", StdFName);
                            Param[04] = new SqlParameter("@StudentMiddleName", StdMName.Trim());
                            Param[05] = new SqlParameter("@StudentLastName", StdLName);
                            Param[06] = new SqlParameter("@StudentDOB", StdDOB);
                            Param[07] = new SqlParameter("@Gender", StdGender);
                            Param[08] = new SqlParameter("@Nationality", Convert.ToInt32(tblStudentDtl.Rows[j]["Nationality"].ToString().Trim()));
                            Param[09] = new SqlParameter("@CountryName", tblStudentDtl.Rows[j]["P-Country"].ToString().Trim());
                            Param[10] = new SqlParameter("@BirthPlace", tblStudentDtl.Rows[j]["BirthPlace"].ToString().Trim());
                            Param[11] = new SqlParameter("@Religion", tblStudentDtl.Rows[j]["Religion"].ToString().Trim());
                            Param[12] = new SqlParameter("@MotherTongue", tblStudentDtl.Rows[j]["MotherTongue"].ToString().Trim());
                            Param[13] = new SqlParameter("@NoOfSiblings", tblStudentDtl.Rows[j]["NoOfSiblings"].ToString().Trim());

                            string CastName = "";
                            Param[14] = new SqlParameter("@CastCategoryId", Convert.ToInt32(CastID));
                            if (CastID == "2")
                            {
                                CastName = "OBC";
                            }
                            else if (CastID == "3")
                            {
                                CastName = "SC";
                            }
                            else if (CastID == "4")
                            {
                                CastName = "ST";
                            }
                            else if (CastID == "5")
                            {
                                CastName = "Minority";
                            }
                            else
                            {
                                CastName = "General";
                            }
                            Param[15] = new SqlParameter("@CastCategoryName", CastName);
                            Param[16] = new SqlParameter("@ApplyingForClass", CLassID);
                            Param[17] = new SqlParameter("@Section_Id", SectionID);
                            Param[18] = new SqlParameter("@TransportationRequired", Convert.ToInt32(tblStudentDtl.Rows[j]["IsTransportRequired"].ToString().Trim()));

                            Param[19] = new SqlParameter("@Address", tblStudentDtl.Rows[j]["Address"].ToString().Trim());
                            Param[20] = new SqlParameter("@City", tblStudentDtl.Rows[j]["City"].ToString().Trim());
                            Param[21] = new SqlParameter("@State", tblStudentDtl.Rows[j]["State"].ToString().Trim());
                            Param[22] = new SqlParameter("@Pin", tblStudentDtl.Rows[j]["P-PinCode"].ToString().Trim());
                            Param[23] = new SqlParameter("@Country", tblStudentDtl.Rows[j]["P-Country"].ToString().Trim());
                            Param[24] = new SqlParameter("@BloodGroup", tblStudentDtl.Rows[j]["BloodGroup"].ToString().Trim());

                            Param[25] = new SqlParameter("@SchoolName", tblStudentDtl.Rows[j]["SchoolName"].ToString().Trim());
                            Param[26] = new SqlParameter("@SchoolBoard", tblStudentDtl.Rows[j]["SchoolBoard"].ToString().Trim());
                            Param[27] = new SqlParameter("@SchoolMedium", tblStudentDtl.Rows[j]["SchoolMedium"].ToString().Trim());
                            Param[28] = new SqlParameter("@SchoolPreviousClassName", tblStudentDtl.Rows[j]["SchoolPreviousClassName"].ToString().Trim());
                            Param[29] = new SqlParameter("@SchoolPercentageInPreviousClass", tblStudentDtl.Rows[j]["SchoolPercentageInPreviousClass"].ToString().Trim());
                            Param[30] = new SqlParameter("@SchoolAddress", tblStudentDtl.Rows[j]["SchoolAddress"].ToString().Trim());
                            Param[31] = new SqlParameter("@SchoolContactNo", tblStudentDtl.Rows[j]["SchoolContactNo"].ToString().Trim());
                            Param[32] = new SqlParameter("@SchoolAlternateContactNo", tblStudentDtl.Rows[j]["SchoolAlternateContactNo"].ToString().Trim());
                            Param[33] = new SqlParameter("@SchoolWebsite", tblStudentDtl.Rows[j]["SchoolWebsite"].ToString().Trim());

                            Param[34] = new SqlParameter("@PrimarySelectParentType", StdParentType);
                            Param[35] = new SqlParameter("@PrimaryParentFirstName", StdParentFName);
                            Param[36] = new SqlParameter("@PrimaryParentLastName", StdParentLName);
                            Param[37] = new SqlParameter("@PrimaryParentDOB", PrimaryParentDOB);
                            Param[38] = new SqlParameter("@TotalAge", 0);
                            Param[39] = new SqlParameter("@PrimaryParentNationality", tblStudentDtl.Rows[j]["PrimaryParentNationality"].ToString().Trim());
                            Param[40] = new SqlParameter("@PrimaryHighestQualification", tblStudentDtl.Rows[j]["PrimaryHighestQualification"].ToString().Trim());
                            Param[41] = new SqlParameter("@PrimaryParentOccupation", tblStudentDtl.Rows[j]["PrimaryParentOccupation"].ToString().Trim());
                            Param[42] = new SqlParameter("@PrimaryDesignation", tblStudentDtl.Rows[j]["PrimaryDesignation"].ToString().Trim());
                            Param[43] = new SqlParameter("@PrimaryNameOfOrganization", tblStudentDtl.Rows[j]["PrimaryNameOfOrganization"].ToString().Trim());
                            Param[44] = new SqlParameter("@PrimaryAddressOfOfficeBusiness", tblStudentDtl.Rows[j]["PrimaryAddressOfOfficeBusiness"].ToString().Trim());
                            Param[45] = new SqlParameter("@PrimaryParentAnnualIncome", tblStudentDtl.Rows[j]["PrimaryParentAnnualIncome"].ToString().Trim() == "" ? "0.00" : tblStudentDtl.Rows[j]["PrimaryParentAnnualIncome"].ToString().Trim());
                            Param[46] = new SqlParameter("@PrimaryAddress", tblStudentDtl.Rows[j]["PrimaryAddress"].ToString().Trim());
                            Param[47] = new SqlParameter("@PrimaryCity", tblStudentDtl.Rows[j]["PrimaryCity"].ToString().Trim());
                            Param[48] = new SqlParameter("@PrimaryState", tblStudentDtl.Rows[j]["PrimaryState"].ToString().Trim());
                            Param[49] = new SqlParameter("@PrimaryPinZipCode", tblStudentDtl.Rows[j]["PrimaryPinZipCode"].ToString().Trim());
                            Param[50] = new SqlParameter("@PrimaryCountry", tblStudentDtl.Rows[j]["PrimaryCountry"].ToString().Trim());
                            Param[51] = new SqlParameter("@PrimaryPhoneNo", tblStudentDtl.Rows[j]["PrimaryPhoneNo"].ToString().Trim());
                            Param[52] = new SqlParameter("@PrimaryMobileNo", tblStudentDtl.Rows[j]["ParentMobileNo"].ToString().Trim());
                            Param[53] = new SqlParameter("@PrimaryEmailId", tblStudentDtl.Rows[j]["PrimaryEmailId"].ToString().Trim());

                            Param[54] = new SqlParameter("@SecondarySelectParentType", tblStudentDtl.Rows[j]["SecondaryParentID"].ToString().Trim());
                            Param[55] = new SqlParameter("@SecondaryParentFirstName", tblStudentDtl.Rows[j]["SecondaryParentFirstName"].ToString().Trim());
                            Param[56] = new SqlParameter("@SecondaryParentMiddleName", tblStudentDtl.Rows[j]["SecondaryParentMiddleName"].ToString().Trim());
                            Param[57] = new SqlParameter("@SecondaryParentLastName", tblStudentDtl.Rows[j]["SecondaryParentLastName"].ToString().Trim());
                            Param[58] = new SqlParameter("@SecondaryParentDOB", SecondaryParentDOB);
                            Param[59] = new SqlParameter("@SecondaryParentNationality", tblStudentDtl.Rows[j]["SecondaryParentNationality"].ToString().Trim());
                            Param[60] = new SqlParameter("@SecondaryHighestQualification", tblStudentDtl.Rows[j]["SecondaryHighestQualification"].ToString().Trim());
                            Param[61] = new SqlParameter("@SecondaryParentOccupation", tblStudentDtl.Rows[j]["SecondaryParentOccupation"].ToString().Trim());
                            Param[62] = new SqlParameter("@SecondaryDesignation", tblStudentDtl.Rows[j]["SecondaryDesignation"].ToString().Trim());
                            Param[63] = new SqlParameter("@SecondaryNameOfOrganization", tblStudentDtl.Rows[j]["SecondaryNameOfOrganization"].ToString().Trim());
                            Param[64] = new SqlParameter("@SecondaryAddressOfOfficeBusiness", tblStudentDtl.Rows[j]["SecondaryAddressOfOfficeBusiness"].ToString().Trim());
                            Param[65] = new SqlParameter("@SecondaryParentAnnualIncome", tblStudentDtl.Rows[j]["SecondaryParentAnnualIncome"].ToString().Trim() == "" ? "0.00" : tblStudentDtl.Rows[j]["SecondaryParentAnnualIncome"].ToString().Trim());
                            Param[66] = new SqlParameter("@SecondaryAddress", tblStudentDtl.Rows[j]["SecondaryAddress"].ToString().Trim());
                            Param[67] = new SqlParameter("@SecondaryCity", tblStudentDtl.Rows[j]["SecondaryCity"].ToString().Trim());
                            Param[68] = new SqlParameter("@SecondaryState", tblStudentDtl.Rows[j]["SecondaryState"].ToString().Trim());
                            Param[69] = new SqlParameter("@SecondaryPinZipCode", tblStudentDtl.Rows[j]["SecondaryPinZipCode"].ToString().Trim());
                            Param[70] = new SqlParameter("@SecondaryCountry", tblStudentDtl.Rows[j]["SecondaryCountry"].ToString().Trim());
                            Param[71] = new SqlParameter("@SecondaryPhoneNo", tblStudentDtl.Rows[j]["SecondaryPhoneNo"].ToString().Trim());
                            Param[72] = new SqlParameter("@SecondaryMobileNo", tblStudentDtl.Rows[j]["SecondaryMobileNo"].ToString().Trim());
                            Param[73] = new SqlParameter("@SecondaryEmailId", tblStudentDtl.Rows[j]["SecondaryEmailId"].ToString().Trim());

                            Param[74] = new SqlParameter("@EmergencyName", tblStudentDtl.Rows[j]["EmergencyName"].ToString().Trim());
                            Param[75] = new SqlParameter("@EmergencyMobileNo", tblStudentDtl.Rows[j]["EmergencyMobileNo"].ToString().Trim());
                            Param[76] = new SqlParameter("@EmergencyAlternateMobileNo", tblStudentDtl.Rows[j]["EmergencyAlternateMobileNo"].ToString().Trim());
                            Param[77] = new SqlParameter("@EmergencyPhoneNo", tblStudentDtl.Rows[j]["EmergencyPhoneNo"].ToString().Trim());
                            Param[78] = new SqlParameter("@EmergencyAddress", tblStudentDtl.Rows[j]["EmergencyAddress"].ToString().Trim());
                            Param[79] = new SqlParameter("@EmergencyCity", tblStudentDtl.Rows[j]["EmergencyCity"].ToString().Trim());
                            Param[80] = new SqlParameter("@EmergencyState", tblStudentDtl.Rows[j]["EmergencyState"].ToString().Trim());
                            Param[81] = new SqlParameter("@EmergencyPinZipCode", tblStudentDtl.Rows[j]["EmergencyPinZipCode"].ToString().Trim());
                            Param[82] = new SqlParameter("@EmergencyCountry", tblStudentDtl.Rows[j]["EmergencyCountry"].ToString().Trim());

                            Param[83] = new SqlParameter("@RegistrationDate", RegistrationDate);
                            Param[84] = new SqlParameter("@Comment", tblStudentDtl.Rows[j]["Comment"].ToString().Trim());
                            Param[85] = new SqlParameter("@Registration_NoForAdmissionORUpdate", Registration_NoForAdmissionORUpdate);
                            Param[86] = new SqlParameter("@Registration_NoForSMS", SqlDbType.VarChar, -1);
                            Param[87] = new SqlParameter("@StudentUID", tblStudentDtl.Rows[j]["AadhaarNo"].ToString().Trim());
                            Param[88] = new SqlParameter("@intresult", Convert.ToInt32("0"));
                            Param[88].Direction = ParameterDirection.Output;
                            Param[89] = new SqlParameter("@IsComeFromAdmission", 1);
                            Param[90] = new SqlParameter("@DocumentSubmitted", tblStudentDtl.Rows[j]["DocumentSubmitted"].ToString().Trim());
                            Param[91] = new SqlParameter("@AdditionalInformation", tblStudentDtl.Rows[j]["AdditionalInformation"].ToString().Trim());
                            Param[92] = new SqlParameter("@RegNewNo", tblStudentDtl.Rows[j]["RegNewNo"].ToString().Trim());
                            Param[93] = new SqlParameter("@PrimaryParentMiddleName", StdParentMName.Trim());

                            intresult = Objdut.ExecuteSqlSP(Param, "[usp_StudentRegistration]");
                            if (intresult == 1)
                            {
                                int NewRID = (int)(Objdut.GetScalar(@"select ISNULL(SR.RID,0) RID from tbl_StudentRegistration SR
                                inner join tbl_StudentMaster sm  on SR.RID = sm.RID
                                INNER JOIN tbl_StudentAdmissionMaster sa ON sm.SturegNo=sa.StuRegNo  
                                where sm.IsActive=1 and SR.StudentFirstName='" + StdFName + "' and Sr.StudentLastName='" + StdLName + "' and SR.StudentDOB='" + StdDOB + "'" +
                                " and sr.CastCategoryId=" + CastID + " and sr.PrimaryParentFirstName='" + StdParentFName + "' and sr.PrimaryParentLastName='" + StdParentLName + "'" +
                                " and SR.PrimarySelectParentType=" + StdParentType + " and sr.ApplyingForClass=" + CLassID + " and sa.SectionId=" + SectionID + " and sm.brid=" + Session["BrBrid"]));
                                if (Registration_NoForAdmissionORUpdate == "")
                                {
                                    if (NewRID > 0)
                                    {
                                        int result = sendFeeRemainder(NewRID.ToString());
                                    }
                                }
                            }
                            else if (intresult == 0)
                            {
                                Error = 1;
                            }
                        }
                    }                    
                }
                if (intresult == 0)
                {
                    Utility.ViewAlertMessage(this, intresult.ToString());
                }
                else
                {
                    Utility.ViewAlertMessage(this, intresult.ToString());
                }
            }
            else
            {
                Utility.ViewAlertMessage(this, "Select StudentDtlExcel file.");
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {
            if (Session["excelFileName"] != null)
            {
                FileInfo File = new FileInfo(Session["excelFileName"].ToString());
                if (File.Exists)
                {
                    File.Delete();
                }
            }
            Session["excelFileName"] = "";
            Session["excelFileName"] = null;
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
                    DtFeeRemind = CommonClass.recentfee("Adm_Mobile", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), Convert.ToInt32(ID[i]));
                    if (DtFeeRemind.Rows.Count > 0)
                    {
                        if (DtFeeRemind.Rows[0]["MobileNO"].ToString().Length > 9)
                        {
                            string msg1 = "", msg2 = "", msg3 = "";
                            msg1 = "Welcome Message ! Dear ";
                            msg2 = " , Admission process is done. your Student ID-'" + DtFeeRemind.Rows[0]["Registration_No"].ToString() + ". 'To Pay fee online download 'PayToPaid' App from Playstore.";
                            result = CommonClass.getStudentMobileNoForShorlist(DtFeeRemind.Rows[0]["MobileNO"].ToString(), Convert.ToInt32(ID[i]), msg1, msg2, msg3);
                        }
                    }
                }
            }
        }

        return result;
    }
    protected void btnforcancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("UploadXLStudents.aspx");
    }
    protected void btnImportFormat_Click(object sender, EventArgs e)
    {
        string PathToExcelFile = "";
        PathToExcelFile = "student-registration-document/ImportStdData.xlsx";
        if (PathToExcelFile!="")
        {
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(PathToExcelFile));
            Response.WriteFile(PathToExcelFile);
            Response.End();
        }
        else
        {
            Response.Write("This file does not exist.");
        }
    }
}