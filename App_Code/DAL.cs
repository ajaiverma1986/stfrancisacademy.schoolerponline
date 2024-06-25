using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;

/// <summary>
/// Summary description for DAL
/// </summary>
public class DAL
{
    private DataUtility objdut = new DataUtility();
    private double maxstudentid = 0;
    private SqlParameter[] param;
    private DataTable dt;
    private string query;

    public DAL()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static DataTable getclassfee(int p1, int p2, int p3, int p4, string sfname, string smname, string slname, DateTime sdob, string ffname, string ffmane, string flname,        string contactno, string discountcode)
    {
        DataUtility objdut = new DataUtility();
        DataTable dt = null;
        string proc = "Usp_FeeShow_1";
        SqlParameter[] param = new SqlParameter[13];
        param[0] = new SqlParameter("@brid", p2);
        param[1] = new SqlParameter("@classid", p1);
        param[2] = new SqlParameter("@mode", p3);
        param[3] = new SqlParameter("@monthid", p4);
        param[4] = new SqlParameter("@sfname", sfname);
        param[5] = new SqlParameter("@smname", smname);
        param[6] = new SqlParameter("@slname", slname);
        param[7] = new SqlParameter("@dob", sdob);
        param[8] = new SqlParameter("@ffname", ffname);
        param[9] = new SqlParameter("@fmname", ffmane);
        param[10] = new SqlParameter("@flname", flname);
        param[11] = new SqlParameter("@contactno", contactno);
        param[12] = new SqlParameter("@studentid", discountcode);
        dt = objdut.GetDataTableSP(param, proc);
        return dt;
    }

    public static DataTable getclassfee1(int p1, int p2, int p3, int p4)
    {
        string query = "";
        if (p3 != 0)
        {
            query = (@"select  t1.cfid,t1.feename,t1.fees,t3.Feename as feecategory,t3.id,case when t3.id=1 then fees*1 when t3.id=2 then fees*1 when t3.id=3 then fees*2 when t3.id=4 then fees*4 when t3.id=5 then fees*12 end as totalfee from classfee_master t1 left outer
          join feestructure t2  on t2.id=t1.Feeid and t1.fyid=" + CommonClass.Scaler("ActiveAcademicYear") + " join  feestructure t3 on t2.Feesubtype=t3.id  where Brid=" + p2 + @" and Classid=" + p1 + @"  and t1.status=1 and t1.feename!='Registration Fee' and Feeid
             not in(select id from feestructure where Feesubtype=0)");
        }
        else
        {
            query = (@"select  t1.cfid,t1.feename,t1.fees,t3.Feename as feecategory,t3.id,case when t3.id=1 then fees*1 when t3.id=2 then fees*1 when t3.id=3 then fees*2 when t3.id=4 then fees*4 when t3.id=5 then fees*12 end as totalfee from classfee_master t1 left outer
                       join feestructure t2  on t2.id=t1.Feeid and t1.fyid=" + CommonClass.Scaler("ActiveAcademicYear") + " join  feestructure t3 on t2.Feesubtype=t3.id  where Brid=" + p2 + @" and Classid=" + p1 + @"  and t1.status=1 and t1.feename!='Registration Fee' and Feeid
                     not in(select id from feestructure where Feesubtype=0) and t1.Feename!='Transport Fee'");
        }
        DataUtility objdut = new DataUtility();
        DataTable dt = objdut.GetDataTable(query);
        return dt;
    }
    public double Getstudentmaxid()
    {
        maxstudentid = Convert.ToDouble(objdut.GetScalar("select isnull(max(admiid),0) from student_master where brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + "       and fyid=" + CommonClass.Scaler("ActiveAcademicYear")));
        maxstudentid++;
        return maxstudentid;
    }

    public double InsertstUdentInformation(BEL objUserDetails)
    {
        string proc = "usp_StuAdmission";
        param = new SqlParameter[93];
        param[0] = new SqlParameter("@brid", objUserDetails.brid);
        param[1] = new SqlParameter("@branchname", objUserDetails.branchname);
        param[2] = new SqlParameter("@firstname", objUserDetails.student_first_name);
        param[3] = new SqlParameter("@middlename", objUserDetails.student_mid_name);
        param[4] = new SqlParameter("@lastname", objUserDetails.student_Last_name);

        param[5] = new SqlParameter("@AdmissionDate", objUserDetails.admission_Date);
        param[6] = new SqlParameter("@dateofbirth", objUserDetails.date_of_Birth);

        param[7] = new SqlParameter("@gender", objUserDetails.gender);
        param[8] = new SqlParameter("@height", objUserDetails.height);
        param[9] = new SqlParameter("@weight", objUserDetails.weight);
        param[10] = new SqlParameter("@applyclass", objUserDetails.applyclass);
        param[11] = new SqlParameter("@classid", objUserDetails.classid);
        param[12] = new SqlParameter("@uploadchildphoto", objUserDetails.upload_student_image);
        param[13] = new SqlParameter("@age", "");
        param[14] = new SqlParameter("@transportaion", objUserDetails.transportation);
        param[15] = new SqlParameter("@nationality", objUserDetails.nationality);

        param[16] = new SqlParameter("@houseno", objUserDetails.houseno);
        param[17] = new SqlParameter("@AppartmentName", objUserDetails.appartment);
        param[18] = new SqlParameter("@street", objUserDetails.street);
        param[19] = new SqlParameter("@landmark", objUserDetails.landmark);
        param[20] = new SqlParameter("@pincode", objUserDetails.pincode);
        param[21] = new SqlParameter("@LanguageSpoken", objUserDetails.languages_spoken);
        param[22] = new SqlParameter("@FName", objUserDetails.father_Name);

        param[23] = new SqlParameter("@FQualificationID", objUserDetails._father_QualificatioID);

        param[24] = new SqlParameter("@FOccupation", objUserDetails.father_Occupation);
        param[25] = new SqlParameter("@FNameOfOrganisation", objUserDetails.father_Organisation);
        param[26] = new SqlParameter("@FPhoneNoResidential", objUserDetails.father_PhoneNo_Residential);

        param[27] = new SqlParameter("@FPhoneNoOffice", objUserDetails.father_PhoneNo_Office);
        param[28] = new SqlParameter("@FMobileNo", objUserDetails.father_MobileNo);
        param[29] = new SqlParameter("@FEmail", objUserDetails.father_Email);

        param[30] = new SqlParameter("@MName", objUserDetails.mother_Name);
        param[31] = new SqlParameter("@MQualificationID", objUserDetails.mother_QualificatioID);
        param[32] = new SqlParameter("@MNameOfOrganisation", objUserDetails.mother_Organisation);
        param[33] = new SqlParameter("@MOccupation", objUserDetails.mother_Occupation);
        param[34] = new SqlParameter("@MPhoneNoResidential", objUserDetails.mother_PhoneNo_Residential);

        param[35] = new SqlParameter("@MPhoneNoOffice", objUserDetails.mother_PhoneNo_Office);
        param[36] = new SqlParameter("@MMobileNo", objUserDetails.mother_MobileNo);
        param[37] = new SqlParameter("@MEmail", objUserDetails.mother_Email);

        param[38] = new SqlParameter("@Sib_Name1", objUserDetails.SibName1);
        param[39] = new SqlParameter("@Sib_Age1", objUserDetails.Sibage1);
        param[40] = new SqlParameter("@Sib_School1", objUserDetails.Sibschool1);

        param[41] = new SqlParameter("@Sib_Name2", objUserDetails.SibName2);
        param[42] = new SqlParameter("@Sib_Age2", objUserDetails.Sibage2);
        param[43] = new SqlParameter("@Sib_School2", objUserDetails.Sibschool2);

        param[44] = new SqlParameter("@Sib_Name3", objUserDetails.SibName3);
        param[45] = new SqlParameter("@Sib_Age3", objUserDetails.Sibage3);
        param[46] = new SqlParameter("@Sib_School3", objUserDetails.Sibschool3);

        param[47] = new SqlParameter("@PreviousSchooling", objUserDetails.previous_schooling);
        param[48] = new SqlParameter("@PreviousSchooling_detail", objUserDetails.previous_schooling_details);

        param[49] = new SqlParameter("@studybefore", objUserDetails.studybefore);

        param[50] = new SqlParameter("@Bloodid", objUserDetails.bloodid);
        param[51] = new SqlParameter("@Specific_ailmentsSuffered", objUserDetails.Specific_ailments_Suffered);
        param[52] = new SqlParameter("@Surgery_undergone", objUserDetails.Surgery_undergone);

        param[53] = new SqlParameter("@allergy", objUserDetails.allergy);

        param[54] = new SqlParameter("@regular_medication_status", objUserDetails.regular_medication_status);
        param[55] = new SqlParameter("@regular_medication_Detial", objUserDetails.regular_medication_Detial);
        param[56] = new SqlParameter("@phobias_status", objUserDetails.phobias_status);
        param[57] = new SqlParameter("@phobias_Detial", objUserDetails.phobias_Detial);
        param[58] = new SqlParameter("@Any_specific_Instruction", objUserDetails.Any_specific_Instruction);

        param[59] = new SqlParameter("@EMERGENCY_CONTACT1", objUserDetails.EMERGENCY_CONTACT_name1);
        param[60] = new SqlParameter("@EMERGENCY_mobileno1", objUserDetails.EMERGENCY_mobileno1);

        param[61] = new SqlParameter("@EMERGENCY_CONTACT2", objUserDetails.EMERGENCY_CONTACT_name2);
        param[62] = new SqlParameter("@EMERGENCY_mobileno2", objUserDetails.EMERGENCY_mobileno2);
        param[63] = new SqlParameter("@Signature", objUserDetails.signature_upolad);

        param[64] = new SqlParameter("@Name_of_signee", objUserDetails.name_of_signee);
        param[65] = new SqlParameter("@Relation_to_child", objUserDetails.relation_to_child);
        param[66] = new SqlParameter("@date", objUserDetails.signaturedate);
        param[67] = new SqlParameter("@vaccination", objUserDetails.vaccination_id);
        param[68] = new SqlParameter("@vaccinationid", objUserDetails.vaccination_name);
        param[69] = new SqlParameter("@Feeid", objUserDetails.feeid);
        param[70] = new SqlParameter("@FeeName", objUserDetails.FeeName);
        param[71] = new SqlParameter("@FeeAmount", objUserDetails.FeeAmount);
        param[72] = new SqlParameter("@Discount", objUserDetails.Discount);

        param[73] = new SqlParameter("@ckdisid", objUserDetails.ckdisid);

        param[74] = new SqlParameter("@paymodeid", objUserDetails.paymodeid);

        param[75] = new SqlParameter("@bankname", objUserDetails.bankname);
        param[76] = new SqlParameter("@checkno", objUserDetails.checkno);

        param[77] = new SqlParameter("@payableamt", objUserDetails.payableamt);
        param[78] = new SqlParameter("@paynowamount", objUserDetails.paynowamount);
        param[79] = new SqlParameter("@monthids", objUserDetails.monthids);
        param[80] = new SqlParameter("@mode", "admissiontime");
        param[81] = new SqlParameter("@intresult", Convert.ToInt32("0"));
        param[81].Direction = ParameterDirection.Output;
        param[82] = new SqlParameter("@max_adid", Convert.ToInt32("0"));
        param[82].Direction = ParameterDirection.Output;
        param[83] = new SqlParameter("@Fqualification", objUserDetails.Fqualification_other);
        param[84] = new SqlParameter("@Mqualification", objUserDetails.mother_other);
        param[85] = new SqlParameter("@section", objUserDetails.section);
        param[86] = new SqlParameter("@sectionid", objUserDetails.sectionid);
        param[87] = new SqlParameter("@maxidli", Convert.ToInt32("0"));
        param[87].Direction = ParameterDirection.Output;
        param[88] = new SqlParameter("@emergencyaddress1", objUserDetails.emergency_address1);

        param[89] = new SqlParameter("@emergencyaddress2", objUserDetails.emergency_address2);
        param[90] = new SqlParameter("@payType", objUserDetails.paytypeID);

        param[91] = new SqlParameter("@paytypename", objUserDetails.paytypename);

        param[92] = new SqlParameter("@feepaynow", objUserDetails.feepaynow);

        int count = objdut.ExecuteSqlSP(param, proc);

        if (count == 1)
        {
            return Convert.ToDouble(param[82].Value);
        }
        else
        {
            return 0;
        }
    }

    public static DataTable getclass(int id)
    {
        string query = ("select classid,Classname from ClassBranch_master where BranchId=" + id + " and Status=1");
        DataUtility objdut = new DataUtility();
        DataTable dt = objdut.GetDataTable(query);
        return dt;
    }

    public static DataTable getmedicalvacination()
    {
        string query = ("select id,vaccination,age from Immunisation_master where status=1");
        DataUtility objdut = new DataUtility();
        DataTable dt = objdut.GetDataTable(query);
        return dt;
    }

    public DataTable bindfirst()
    {
        query = ("select CONVERT(varchar(100),'a') as transtype,0.00 as credit,CONVERT(varchar(100),'b') as monthname");

        dt = objdut.GetDataTable(query);
        return dt;
    }

    public DataTable bindfirstsecondgrid()
    {
        query = ("select 0 as cfid,CONVERT(varchar(100),'a') as feename,0.00 as fees");

        dt = objdut.GetDataTable(query);
        return dt;
    }

    public DataTable bindfirststhirdgrid()
    {
        query = ("select 0 as monthid,0.00 as credit,CONVERT(varchar(100),'b') as monthname");

        dt = objdut.GetDataTable(query);
        return dt;
    }

    public static DataTable getclassfeestructure(int classid, int brid)
    {
        string query = (@"select  t1.cfid,t1.feename,t1.fees,t3.Feename as feecategory,t3.id,case when t3.id=1 then fees*1 when t3.id=2 then fees*1 when t3.id=3 then fees*2 when t3.id=4 then fees*4 when t3.id=5 then fees*12 end as totalfee from classfee_master t1 left outer
 join feestructure t2  on t2.id=t1.Feeid and t1.fyid=" + CommonClass.Scaler("ActiveAcademicYear") + " join  feestructure t3 on t2.Feesubtype=t3.id  where Brid=" + brid + @" and Classid=" + classid + @"  and t1.status=1  and t1.FeeName!='Registration Fee' and Feeid
      not in(select id from feestructure where Feesubtype=0)");
        DataUtility objdut = new DataUtility();
        DataTable dt = objdut.GetDataTable(query);
        return dt;
    }

    public static DataTable bindpayfee(int p1, int p2, int transport, int monthid, string sfname, string smname, string slname, DateTime sdob, string ffname, string ffmane, string flname, string contactno, string discountcode)
    {
        DataUtility objdut = new DataUtility();
        DataTable dt = null;
        string proc = "Usp_FeeShow_admissionTimePay";
        SqlParameter[] param = new SqlParameter[13];

        param[0] = new SqlParameter("@brid", p2);
        param[1] = new SqlParameter("@classid", p1);
        param[2] = new SqlParameter("@mode", transport);
        param[3] = new SqlParameter("@monthid1", monthid);
        param[4] = new SqlParameter("@sfname", sfname);
        param[5] = new SqlParameter("@smname", smname);
        param[6] = new SqlParameter("@slname", slname);
        param[7] = new SqlParameter("@dob", sdob);
        param[8] = new SqlParameter("@ffname", ffname);
        param[9] = new SqlParameter("@fmname", ffmane);
        param[10] = new SqlParameter("@flname", flname);
        param[11] = new SqlParameter("@contactno", contactno);
        param[12] = new SqlParameter("@studentid", discountcode);

        dt = objdut.GetDataTableSP(param, proc);
        return dt;
    }

    public static DataTable bindfeestructure()
    {
        DataUtility objdut = new DataUtility();
        DataTable dt = null;
        string proc = "Usp_FeeShow_admissionTime";
        SqlParameter[] param = new SqlParameter[4];

        param[0] = new SqlParameter("@brid", BEL.branchid);
        param[1] = new SqlParameter("@classid", BEL.applyclassid);
        param[2] = new SqlParameter("@mode", BEL.modestatic);
        param[3] = new SqlParameter("@monthid", BEL.monthid);

        dt = objdut.GetDataTableSP(param, proc);
        return dt;
    }

    public DataTable bindqualification()
    {
        query = ("select pqualification,id from parentqualification");

        dt = objdut.GetDataTable(query);
        return dt;
    }

    public DataTable binddatalist5()
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@searchvalue1", BEL.searchvalue);
        param[1] = new SqlParameter("@brid", BEL.branchid);
        DataTable dt = objdut.GetDataTableSP(param, "usp_search_student_detailsspecific");

        return dt;
    }

    public DataTable binddatalist()
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@searchvalue1", BEL.searchvalue);
        param[1] = new SqlParameter("@brid", BEL.branchid);
        DataTable dt = objdut.GetDataTableSP(param, "usp_search_student_details");

        return dt;
    }

    public static DataTable bindmonthwisefee()
    {
        DataUtility objdut = new DataUtility();
        DataTable dt = null;
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@PageSize", BEL.pagesize);
        param[1] = new SqlParameter("@CurrentPage", BEL.currentpage);
        param[2] = new SqlParameter("@feetype", BEL.feetype);
        param[3] = new SqlParameter("@brid ", BEL.branchid);
        param[4] = new SqlParameter("@monthid", BEL.monthid);
        param[5] = new SqlParameter("@name1", BEL.searchbyName);
        dt = objdut.GetDataTableSP(param, "usp_monthfeedeatils");
        return dt;
    }

    public static DataTable bindstudentfeetotal()
    {
        DataUtility objdut = new DataUtility();
        DataTable dt = null;
        SqlParameter[] param = new SqlParameter[7];
        param[0] = new SqlParameter("@brid ", BEL.branchid);
        param[1] = new SqlParameter("@monthid", BEL.monthid);
        param[2] = new SqlParameter("@transType", BEL.feetype);
        param[6] = new SqlParameter("@name1", BEL.searchbyName);
        param[3] = new SqlParameter("@totalfee", BEL.totalfee);
        param[3].Direction = ParameterDirection.Output;

        param[4] = new SqlParameter("@receivefee", BEL.paidfee);
        param[4].Direction = ParameterDirection.Output;

        param[5] = new SqlParameter("@balancefee", BEL.balfee);
        param[5].Direction = ParameterDirection.Output;
        dt = objdut.GetDataTableSP(param, "usp_monthwisefees");
        return dt;
    }

    public static int countstudentwithType(string feetype)
    {
        int query = 0;
        DataUtility objdut = new DataUtility();
        if (feetype == "Transportation Fee")
        {
            query = CommonClass.scaler("countstudentwithtransport", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        }
        else
        {
            query = CommonClass.scaler("countstudentnotransport", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        }
        return query;
    }

    public DataTable bindstudentslist()
    {
        dt = null;

        param = new SqlParameter[8];
        param[0] = new SqlParameter("@PageSize ", BEL.pagesize);
        param[1] = new SqlParameter("@CurrentPage", BEL.currentpage);
        param[2] = new SqlParameter("@searchbyName", "");
        param[3] = new SqlParameter("@searchbyAdmissionNo", "");
        param[4] = new SqlParameter("@searchbyClass", "");

        param[5] = new SqlParameter("@searchtransport", "2");
        param[6] = new SqlParameter("@brid", BEL.branchid);

        param[7] = new SqlParameter("@count1", Convert.ToInt32("0"));
        param[7].Direction = ParameterDirection.Output;
        dt = objdut.GetDataTableSP(param, "usp_admissionsearch");
        BEL.countnoofStudents = Convert.ToInt32(param[7].Value);
        if (dt.Rows.Count > 0)
        {
        }
        return dt;
    }

    public static int counrecords()
    {
        SqlParameter[] param = new SqlParameter[6];
        DataUtility objdut = new DataUtility();
        param[0] = new SqlParameter("@transport ", BEL.searchtransport);
        param[1] = new SqlParameter("@admissionno", BEL.searchbyAdmissionNo);
        param[2] = new SqlParameter("@name", BEL.searchbyName);
        param[3] = new SqlParameter("@class", BEL.searchbyClass);
        param[5] = new SqlParameter("@mode", "studentsearch");

        param[4] = new SqlParameter("@brid", BEL.branchid);

        int countrecords = Convert.ToInt32(objdut.GetScalerSP(param, "Usp_countStudent"));
        return countrecords;
    }

    public static DataTable bindstudentsrecodrs()
    {
        DataUtility objdut = new DataUtility();
        DataTable dt = null;
        SqlParameter[] param = new SqlParameter[8];
        param[0] = new SqlParameter("@PageSize ", BEL.pagesize);
        param[1] = new SqlParameter("@CurrentPage", BEL.currentpage);
        param[2] = new SqlParameter("@searchbyName", BEL.searchbyName);
        param[3] = new SqlParameter("@searchbyAdmissionNo", BEL.searchbyAdmissionNo);
        param[4] = new SqlParameter("@searchbyClass", BEL.searchbyClass);

        param[5] = new SqlParameter("@searchtransport", BEL.searchtransport);
        param[6] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);

        dt = objdut.GetDataTableSP(param, "usp_admissionsearch");
        BEL.countnoofStudents = Convert.ToInt32(param[7].Value);
        return dt;
    }

    public static DataTable bindclasswisefee()
    {
        DataUtility objdut = new DataUtility();
        DataTable dt = null;
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@classid", BEL.applyclassid);
        param[1] = new SqlParameter("@brid ", BEL.branchid);
        param[2] = new SqlParameter("@monthid", BEL.monthid);
        param[3] = new SqlParameter("@PageSize", BEL.pagesize);
        param[4] = new SqlParameter("@CurrentPage", BEL.currentpage);
        param[5] = new SqlParameter("@studname", BEL.searchbyName);
        dt = objdut.GetDataTableSP(param, "usp_classfeedetails");
        return dt;
    }

    public static DataTable showfinepaytime()
    {
        DataUtility objdut = new DataUtility();
        DataTable dt = null;
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@studentid ", BEL.adid);
        param[1] = new SqlParameter("@intResult", Convert.ToDouble("0"));
        param[1].Direction = ParameterDirection.Output;
        dt = objdut.GetDataTableSP(param, "Usp_ShowFine_payTime");
        return dt;
    }

    public static DataTable recentfee()
    {
        DataTable dt;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@PageSize ", BEL.pagesize);
        param[1] = new SqlParameter("@CurrentPage", BEL.currentpage);
        param[2] = new SqlParameter("@searchvalue1", BEL.searchvalue);
        param[3] = new SqlParameter("@brid", BEL.branchid);
        dt = objdut.GetDataTableSP(param, "usp_search_recentfee");
        return dt;
    }

    public static DataTable recentfeeonpageload()
    {
        DataTable dt;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@PageSize ", BEL.pagesize);
        param[1] = new SqlParameter("@CurrentPage", BEL.currentpage);
        param[2] = new SqlParameter("@searchvalue1", BEL.searchvalue);
        param[3] = new SqlParameter("@classname", BEL.searchbyClass);
        param[4] = new SqlParameter("@brid", BEL.branchid);

        dt = objdut.GetDataTableSP(param, "usp_overallcollection");
        return dt;
    }

    public static DataTable bindstudentfeestruct()
    {
        DataTable dt;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@studentid ", BEL.adid);
        param[1] = new SqlParameter("@tansptype", BEL.modestatic);
        param[2] = new SqlParameter("@FeeType", BEL.feeTypeid);
        dt = objdut.GetDataTableSP(param, "dbo.usp_getstudentfees");
        return dt;
    }

    public static DataTable bindstudentmonthfeestruct()
    {
        DataTable dt;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@studentid ", BEL.adid);
        param[1] = new SqlParameter("@tansptype", BEL.modestatic);
        dt = objdut.GetDataTableSP(param, "usp_getstudentfeesmonthwise");
        return dt;
    }

    public static DataTable searchstudentdatalist()
    {
        DataTable dt;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@searchvalue1", BEL.searchbyName);
        param[1] = new SqlParameter("@classname", BEL.searchbyClass);
        param[2] = new SqlParameter("@brid", BEL.branchid);
        dt = objdut.GetDataTableSP(param, "usp_search_student_details");
        return dt;
    }

    public static int countrecentfee()
    {
        int countrecords = 0;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[6];

        param[0] = new SqlParameter("@searchvalue", BEL.searchvalue);
        param[1] = new SqlParameter("@class", BEL.searchbyClass);
        param[2] = new SqlParameter("@searchbyadno", BEL.searchbyAdmissionNo);
        param[3] = new SqlParameter("@searchbyname", BEL.searchbyName);

        param[4] = new SqlParameter("@brid", BEL.branchid);
        param[5] = new SqlParameter("@mode", "recentfee");
        countrecords = Convert.ToInt32(objdut.GetScalerSP(param, "usp_countstudent"));
        return countrecords;
    }

    public static int counttransaction()
    {
        int countrecords = 0;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[6];

        param[0] = new SqlParameter("@searchbyname", BEL.searchbyName);
        param[1] = new SqlParameter("@searchbyadno", BEL.searchbyAdmissionNo);
        param[2] = new SqlParameter("@searchbyclass", BEL.searchbyClass);
        param[3] = new SqlParameter("@searchbyfrmdate", BEL.searchbydate);
        param[4] = new SqlParameter("@searchbytodate", BEL.searchbydate2);

        param[5] = new SqlParameter("@brid", BEL.branchid);
        countrecords = Convert.ToInt32(objdut.GetScalerSP(param, "usp_counttransactions"));
        return countrecords;
    }

    public int insertpayfee(BEL objUserDetails)
    {
        string proc = "usp_submitfee";
        SqlParameter[] param = new SqlParameter[15];
        param[12] = new SqlParameter("@actualfine", objUserDetails.actualfine);
        param[10] = new SqlParameter("@mode", objUserDetails.mode);
        param[0] = new SqlParameter("@Adid", objUserDetails.adid2);
        param[1] = new SqlParameter("@brid", objUserDetails.brid);
        param[11] = new SqlParameter("@finepayornot", objUserDetails.finepayornot);
        param[2] = new SqlParameter("@debitAmt", objUserDetails.totalfine);
        param[9] = new SqlParameter("@setAmt", objUserDetails.payableamt);
        param[3] = new SqlParameter("@paymode", objUserDetails.paymodeid);
        param[4] = new SqlParameter("@BankName", objUserDetails.bankname);
        param[5] = new SqlParameter("@checkno", objUserDetails.checkno);

        param[13] = new SqlParameter("@bankbranch", objUserDetails.bankbranch);
        param[8] = new SqlParameter("@nextmonthid", Convert.ToInt32("0"));
        param[14] = new SqlParameter("@draftdate", objUserDetails.draftdate);
        param[6] = new SqlParameter("@intresult", Convert.ToInt32("0"));
        param[6].Direction = ParameterDirection.Output;
        param[7] = new SqlParameter("@monthids", objUserDetails.monthids);

        int count = objdut.ExecuteSqlSP(param, proc);

        if (count == 1)
        {
            return Convert.ToInt32(param[6].Value);
        }
        else
        {
            return 0;
        }
    }

    public DataTable bindmonthgrid()
    {
        query = ("select MonthId,MonthName,'notpaid' as paystatus,'1050.00' as payableamount,'3150' as paidamount from Month_name where days=28");

        dt = objdut.GetDataTable(query);
        return dt;
    }

    public DataTable bindmonthgrid2()
    {
        query = ("select MonthId,MonthName,'notpaid' as paystatus,'1050.00' as payableamount,'3150' as paidamount from Month_name where days=28");

        dt = objdut.GetDataTable(query);
        return dt;
    }

    public DataTable binddatalistsearch()
    {
        query = ("select 'image' as photo,'ac' as name,'12' as adid,'play' as applyclass,'ab' as fathername,'111' as ADNO from tbl_admission");

        dt = objdut.GetDataTable(query);
        return dt;
    }

    public static DataTable bindovercollection()
    {
        DataTable dt;
        DataUtility objdut = new DataUtility();

        SqlParameter[] param = new SqlParameter[11];
        param[0] = new SqlParameter("@PageSize ", BEL.pagesize);
        param[1] = new SqlParameter("@CurrentPage", BEL.currentpage);
        param[2] = new SqlParameter("@searchvalue1", BEL.searchvalue);
        param[3] = new SqlParameter("@classname", BEL.searchbyClass);
        param[4] = new SqlParameter("@searchbyadno", BEL.searchbyAdmissionNo);
        param[5] = new SqlParameter("@searchbyname", BEL.searchbyName);

        param[6] = new SqlParameter("@overallfee", 0);
        param[6].Direction = ParameterDirection.Output;

        param[7] = new SqlParameter("@receivedfee", 0);
        param[7].Direction = ParameterDirection.Output;

        param[8] = new SqlParameter("@nextbalance", 0);
        param[8].Direction = ParameterDirection.Output;
        param[9] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);

        param[10] = new SqlParameter("@discount", 0);
        param[10].Direction = ParameterDirection.Output;

        dt = objdut.GetDataTableSP(param, "usp_overallcollection");

        BEL.totalfee = Convert.ToDouble(param[6].Value);
        BEL.paidfee = Convert.ToDouble(param[7].Value);
        BEL.balfee = Convert.ToDouble(param[8].Value);
        BEL.discount = Convert.ToDouble(param[10].Value);

        return dt;
    }

    public static DataTable bindtransaction()
    {
        DataTable dt;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[7];
        param[0] = new SqlParameter("@PageSize", BEL.pagesize);
        param[1] = new SqlParameter("@CurrentPage", BEL.currentpage);
        param[2] = new SqlParameter("@searchbyname", BEL.searchbyName);
        param[3] = new SqlParameter("@searchbyadno", BEL.searchbyAdmissionNo);
        param[4] = new SqlParameter("@searchbyclass", BEL.searchbyClass);
        param[5] = new SqlParameter("@searchbyfrmdate", BEL.searchbydate);
        param[6] = new SqlParameter("@searchbytodate", BEL.searchbydate2);

        dt = objdut.GetDataTableSP(param, "usp_gettransactionreport");

        return dt;
    }

    public static DataTable bindpaystructure(int adid)
    {
        DataUtility objdut = new DataUtility();
        DataTable dt = null;
        string proc = "usp_showfee_paytime";
        SqlParameter[] param = new SqlParameter[1];

        param[0] = new SqlParameter("@adid", adid);

        dt = objdut.GetDataTableSP(param, proc);
        return dt;
    }

    public static DataTable bindstudent_transport_detial(string p1, int p2, string mode)
    {
        SqlParameter[] param = new SqlParameter[3];
        DataTable dt;
        DataUtility objdut = new DataUtility();
        param[0] = new SqlParameter("@studentregno", p1);
        param[1] = new SqlParameter("@brid", p2);
        if (mode == "deactivemode")
        {
            param[2] = new SqlParameter("@mode", "Deactiveintrans");
        }
        else
        {
            param[2] = new SqlParameter("@mode", "Activeintrans");
        }

        dt = objdut.GetDataTableSP(param, "usp_gettransportdetail");
        if (dt.Rows.Count > 0)
        {
        }
        return dt;
    }
    public static DataTable bindfeestructure(int p1, int p2, int transport, int monthid, string sfname, string smname, string slname, DateTime sdob, string ffname, string ffmane, string flname, string contactno, string discountcode)
    {
        DataUtility objdut = new DataUtility();
        DataTable dt = null;
        string proc = "Usp_FeeShow_admissionTime";
        SqlParameter[] param = new SqlParameter[13];

        param[0] = new SqlParameter("@brid", p2);
        param[1] = new SqlParameter("@classid", p1);
        param[2] = new SqlParameter("@mode", transport);
        param[3] = new SqlParameter("@monthid", monthid);
        param[4] = new SqlParameter("@sfname", sfname);
        param[5] = new SqlParameter("@smname", smname);
        param[6] = new SqlParameter("@slname", slname);
        param[7] = new SqlParameter("@dob", sdob);
        param[8] = new SqlParameter("@ffname", ffname);
        param[9] = new SqlParameter("@fmname", ffmane);
        param[10] = new SqlParameter("@flname", flname);
        param[11] = new SqlParameter("@contactno", contactno);
        param[12] = new SqlParameter("@studentid", discountcode);

        dt = objdut.GetDataTableSP(param, proc);
        return dt;
    }

    public static DataTable getclassfee1(int classid, int p, int transport,string fyid)
    {
            string query = "";
            query = (@"Select T1.Cfid,T1.Feeid FeeHeadId,T1.Feename,T1.Fees,T3.Feename As Feecategory,T3.id From Classfee_master T1 Left Outer Join feestructure T2  On T2.id=T1.Feeid And                     T1.fyid=" + fyid + " Join  Feestructure T3 On T2.Feesubtype=T3.id  where Brid=" + p + @" and Classid=" + classid + @"  And T1.status=1  And  " +
                " Feeid  Not In(select Id From Feestructure Where Feesubtype=0)");
            DataUtility objdut = new DataUtility();
            DataTable dt = objdut.GetDataTable(query);
            return dt;
    }

    public static DataTable discountfeeheadwise_detial(string dstudentid)
    {
        string quer = @"select cfeename,actualfee,discountedFee,netfee,cmonthname,feemonths,feetype,fee_status,overallactualfee,overalldiscountfee,overallnetfee from                       Discount_student_master where studentid=" + dstudentid;
        DataTable dt;
        DataUtility objdut = new DataUtility();
        dt = objdut.GetDataTable(quer);
        if (dt.Rows.Count > 0)
        {
        }
        return dt;
    }
}