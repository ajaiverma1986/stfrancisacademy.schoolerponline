using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;

/// <summary>
/// Summary description for Service_CS
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
//To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
[System.Web.Script.Services.ScriptService]
public class Service : System.Web.Services.WebService
{
    public Service()
    {
        //Uncomment the following line if using designed components
        //InitializeComponent();
    }
    [WebMethod]
    public static int monthdetails(string mid)
    {
        Utility objut = new Utility();
        DataUtility objdut = new DataUtility();
        //BranchPanel_admissionshort onb = new BranchPanel_admissionshort();
        DataTable dt = new DataTable();
        CommonClass CommonClass = new CommonClass();
        //  List<mondetails> detail = new List<mondetails>();
        int currentYear;

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            HttpContext.Current.Session["regno"] = mid;

            Int32 days = Convert.ToInt32(CommonClass.Scaler("getdays", Convert.ToInt32(HttpContext.Current.Session["regno"])));

            if (Convert.ToInt32(HttpContext.Current.Session["regno"]) <= 9)
            {
                currentYear = Convert.ToInt32(objdut.GetScalar("select startingyear from financial_year where isActive=1 and isClosed=0"));
            }
            else
            {
                currentYear = Convert.ToInt32(objdut.GetScalar("select endyear from financial_year where isActive=1 and isClosed=0"));
            }
            if (objut.isLeapYear(currentYear))
            {
                if (HttpContext.Current.Session["regno"] == "11")
                {
                    days = 29;
                }
            }

            return days;
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string[] GetCustomers(string prefix)
    {
        List<string> customers = new List<string>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            //conn.ConnectionString = ConfigurationManager
            //        .ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select brname, brid from Branch_master where isactive=1 and " +
                "brname like @SearchText + '%'";
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Connection = con;
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}-{1}", sdr["brname"], sdr["brid"]));
                    }
                }
                con.Close();
            }
            return customers.ToArray();
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetLogin(string loginid, string pass)
    {
        string api = "";
        DataTable dtProductDetails = new DataTable();
        DataUtility objDut = new DataUtility();
        List<AdminLogin> ObjAdminLogin = new List<AdminLogin>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            //conn.ConnectionString = ConfigurationManager
            //        .ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                string login = "";
                string Url = "";
                string pass1 = "";
                string prodid = "";
                string custacc = "";

                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "usp_loginapp";
                cmd.Parameters.AddWithValue("@loginid", loginid);
                cmd.Parameters.AddWithValue("@password", pass);
                cmd.Connection = con;
                con.Open();
                SqlDataReader Rd;
                Rd = cmd.ExecuteReader();
                if (Rd.Read())
                {
                    api = (string)(objDut.GetScalar("select isnull(sms_api,'') sms_api from tbl_smsapisetting where Brid=" + Convert.ToInt32(Rd["brid"]) + " and status=1"));

                    dtProductDetails = objDut.GetDataTable("select isnull(UserID,'') UserID,isnull(Password,'') Password,isnull(ProductID,'') ProductID from tblProductName where Brid = " + Convert.ToInt32(Rd["brid"]) + "");
                    if (dtProductDetails.Rows.Count > 0)
                    {
                        DataRow dr = dtProductDetails.Rows[0];
                        login = dr["UserID"].ToString();
                        pass1 = dr["Password"].ToString();
                        prodid = dr["ProductID"].ToString();
                        Url = "payment";
                        custacc = "1234567890";
                    }
                    else
                    {
                        login = "160";
                        pass1 = "Test@123";
                        prodid = "NSE";
                        Url = "paynetzuat";
                        custacc = "123456789";
                    }

                    AdminLogin Obj = new AdminLogin();
                    Obj.Brid = Convert.ToInt32(Rd["brid"]);
                    Obj.UserId = Convert.ToString(Rd["eid"]);
                    Obj.UserName = Convert.ToString(Rd["UserName"]);
                    Obj.SAMID = Convert.ToInt32(Rd["samid"]);
                    Obj.Api = api.ToString();
                    Obj.login = login.ToString();
                    Obj.pass1 = pass1.ToString();
                    Obj.prodid = prodid.ToString();
                    Obj.Url = Url.ToString();
                    Obj.custacc = custacc.ToString();
                    ObjAdminLogin.Add(Obj);
                }
                con.Close();
            }
            return new JavaScriptSerializer().Serialize(ObjAdminLogin);
        }
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetStudentDetails(string brid, string eid)
    {
        List<StudentDetails> ObjAdminLogin = new List<StudentDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            //conn.ConnectionString = ConfigurationManager
            //        .ConnectionStrings["ConnectionString"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                // ../../BranchPanel/Student-Registration/student-registration-document/110Obtain-a-Free-Online-Insurance-Quote-Quickly-Step-4.jpg
                //                cmd.CommandText = @"select studentFirstName+' '+isnull(studentMiddleName,'')+' '+isnull(studentLastName,'') as name
                //                                  ,convert(varchar(12),studentdob,105)as dob,isnull(PrimaryParentFirstName,'') father,
                //                                    address,PrimaryMobileNo as mobile,'http://paytopaidnew.schoolerponline.in/BranchPanel/Student-Registration/student-registration-document/'+''+isnull(StudentPhotograph,'images/noimage.jpg') as photo,
                //                                   (select Brname from Branch_master where Brid=@brid) as CollegeName,
                //                                   (select top 1 FYName from financial_Year where isactive=1) as sessionYear,
                //                                   (select isnull(Applyingforclass,'')  Applyingforclass from tbl_studentregistration where rid=@eid and brid=@brid) as className
                //                                  from tbl_StudentRegistration where brid=@brid and RID=@eid";

                cmd.CommandText = @"select DISTINCT Case when PrimaryEmailid = '' then SecondaryEmailId Else PrimaryEmailid End as studentEmailID,studentFirstName+' '+isnull(studentMiddleName,'')+' '+isnull(studentLastName,'') as name
                               ,convert(varchar(12),studentdob,105)as dob,isnull(PrimaryParentFirstName,'') father,
	                                 address,PrimaryMobileNo as mobile,
	                         case when StudentPhotograph!='' then
	                               'http://www.schoolerponline.in/BranchPanel/Student-Registration/student-registration-document/'+''+StudentPhotograph
	                        else 'http://www.schoolerponline.in/BranchPanel/Student-Registration/student-registration-document/images/noimage.jpg' end photo,
                         (select Brname from Branch_master where Brid=@brid) as CollegeName,
                          (select top 1 FYName from financial_Year where isactive=1) as sessionYear,
                            (select isnull(Class_Master.Classname,'')  Applyingforclass 
                            from tbl_studentregistration inner join Class_Master on tbl_studentregistration.ApplyingForClass = Class_Master.id where rid=@eid and brid=@brid) as className,classwithsection.sectionname
                                from tbl_StudentRegistration inner join tbl_StudentMaster on tbl_StudentRegistration.RID = tbl_StudentMaster.RID
                                inner join tbl_StudentAdmissionMaster on tbl_StudentAdmissionMaster.StuRegNo = tbl_StudentMaster.SturegNo
                                inner join classwithsection on classwithsection.classid = tbl_StudentAdmissionMaster.classid
							    and classwithsection.branchid = tbl_StudentAdmissionMaster.Brid
                                where tbl_StudentRegistration.Brid=@brid and tbl_StudentRegistration.RID=@eid";
                cmd.Parameters.AddWithValue("@brid", brid);
                cmd.Parameters.AddWithValue("@eid", eid);

                cmd.Connection = con;
                con.Open();
                SqlDataReader Rd;
                Rd = cmd.ExecuteReader();
                if (Rd.Read())
                {
                    StudentDetails Obj = new StudentDetails();
                    Obj.Name = Convert.ToString(Rd["name"]);
                    Obj.Dob = Convert.ToString(Rd["dob"]);
                    Obj.fathername = Convert.ToString(Rd["father"]);
                    Obj.address = Convert.ToString(Rd["address"]);
                    Obj.mobile = Convert.ToString(Rd["mobile"]);
                    Obj.photo = Convert.ToString(Rd["photo"]);
                    Obj.CollegeName = Convert.ToString(Rd["CollegeName"]);
                    Obj.sessionYear = Convert.ToString(Rd["sessionYear"]);
                    Obj.className = Convert.ToString(Rd["className"]);
                    Obj.studentEmailID = Rd["studentEmailID"].ToString();
                    Obj.SectionId = Convert.ToString(Rd["sectionname"]);

                    ObjAdminLogin.Add(Obj);
                }
                con.Close();
            }
            return new JavaScriptSerializer().Serialize(ObjAdminLogin);
        }
    }

    public string[] GetTopicDetail1(string prefix, int brid)
    {
        List<string> customers = new List<string>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "usp_search_student_dashboard";
                cmd.Parameters.AddWithValue("@character1", prefix);
                cmd.Parameters.AddWithValue("@brid", brid);
                cmd.Connection = con;
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}-{1}", sdr["name"], sdr["sturegno"]));
                    }
                }
                con.Close();
            }
            return customers.ToArray();
        }
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetCheckogin(string loginid)
    {
        List<StudentDetails> ObjAdminLogin = new List<StudentDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "usp_logincheck";
                cmd.Parameters.AddWithValue("@loginid", loginid);

                cmd.Connection = con;
                con.Open();
                using (SqlDataReader Rd = cmd.ExecuteReader())
                {
                    while (Rd.Read())
                    {
                        StudentDetails Obj = new StudentDetails();
                        Obj.userid = Convert.ToString(Rd["loginid"]);
                        Obj.Name = Convert.ToString(Rd["name"]);
                        Obj.password = Convert.ToString(Rd["pass"]);

                        Obj.CollegeName = Convert.ToString(Rd["collegeName"]);
                        ObjAdminLogin.Add(Obj);
                    }
                }
                con.Close();
            }
            return new JavaScriptSerializer().Serialize(ObjAdminLogin);
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetLoginDetailSave(string loginid, string name, string password, string collegeName)
    {
        List<ResultSuccess> ObjAdminLogin = new List<ResultSuccess>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "usp_saveLogindeatils";
                cmd.Parameters.AddWithValue("@loginid", loginid);
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@password", password);
                cmd.Parameters.AddWithValue("@collegeName", collegeName);

                cmd.Connection = con;
                con.Open();
                using (SqlDataReader Rd = cmd.ExecuteReader())
                {
                    while (Rd.Read())
                    {
                        ResultSuccess Obj = new ResultSuccess();
                        Obj.result = Convert.ToString(Rd["result"]);
                        ObjAdminLogin.Add(Obj);
                    }
                }
                con.Close();
            }
            return new JavaScriptSerializer().Serialize(ObjAdminLogin);
        }
    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string BindFeeDetails(string SAMID)
    { 
        DataSet Ds = new DataSet();
        if (SAMID != "")
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand("[StudentsAllDetails]", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter[] param = new SqlParameter[2];
                    param[0] = new SqlParameter("@Mode", 2);
                    param[1] = new SqlParameter("@SAMID", Convert.ToInt32(SAMID));
                    cmd.Parameters.Add(param[0]);
                    cmd.Parameters.Add(param[1]);
                    SqlDataAdapter Da = new SqlDataAdapter(cmd);
                    Da.Fill(Ds);
                }
            }
        }
        return Ds.GetXml().ToString();
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string BindAttensance(string Date ,string ToDate, string brid, string studentregno)
    {
        DataSet Ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_TakeAttendance]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[5];

                param[0] = new SqlParameter("@Date", Date);
                param[1] = new SqlParameter("@ToDate1", ToDate);
                param[2] = new SqlParameter("@Mode", 11);
                param[3] = new SqlParameter("@Brid", Convert.ToInt32(brid));              
                param[4] = new SqlParameter("@Sturegno", Convert.ToInt32(studentregno));
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);

                SqlDataAdapter Da = new SqlDataAdapter(cmd);
                Da.Fill(Ds);
            }
        }
        return Ds.GetXml().ToString();

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string BindAssignment(string brid, string studentregno)
    {
        DataSet Ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_assignment_app]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];


                param[0] = new SqlParameter("@Brid", Convert.ToInt32(brid));

                param[1] = new SqlParameter("@Sturegno", Convert.ToInt32(studentregno));
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);


                SqlDataAdapter Da = new SqlDataAdapter(cmd);
                Da.Fill(Ds);
            }
        }
        return Ds.GetXml().ToString();

    }


    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string BindPayNow(string ASAID)
    {
        DataSet Ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[StudentsAllDetails]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Mode", 3);
                param[1] = new SqlParameter("@ASAID", Convert.ToInt32(ASAID));
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                SqlDataAdapter Da = new SqlDataAdapter(cmd);
                Da.Fill(Ds);
            }
        }
        return Ds.GetXml().ToString();

    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static int DepositFee(string ASAID, string PAYMENTMODE, string BANKNAME, string BRANCHNAME, string CHKREFDDNEFTREFRENCENO, string CHKREFDDNEFTDATE, string RECIPTNO, string PAYMENTDATE, string RemarkOrComment, string PaidAmount, string DateOfDueAmount, string SelectedASID)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[14];
        Param[0] = new SqlParameter("@ASAID", Convert.ToInt32(ASAID));
        Param[1] = new SqlParameter("@PAYMENTMODE", Convert.ToInt32(PAYMENTMODE));
        Param[2] = new SqlParameter("@BANKNAME", BANKNAME);
        Param[3] = new SqlParameter("@BRANCHNAME", BRANCHNAME);
        Param[4] = new SqlParameter("@CHKREFDDNEFTREFRENCENO", CHKREFDDNEFTREFRENCENO);
        Param[5] = new SqlParameter("@CHKREFDDNEFTDATE", CHKREFDDNEFTDATE);
        Param[6] = new SqlParameter("@RECIPTNO", RECIPTNO);
        Param[7] = new SqlParameter("@PAYMENTDATE", DateTime.Now.ToString("yyyy-MM-dd"));
        Param[8] = new SqlParameter("@RemarkOrComment", RemarkOrComment);
        // Param[9] = new SqlParameter("@UserId", HttpContext.Current.Session["BrAdid"]);
        Param[9] = new SqlParameter("@UserId", Convert.ToInt32(5));
        Param[10] = new SqlParameter("@PaidAmount", Convert.ToDecimal(PaidAmount));
        Param[11] = new SqlParameter("@RemaingAmountDueDate", DateOfDueAmount);
        Param[12] = new SqlParameter("@SelectedASID", SelectedASID);
        Param[13] = new SqlParameter("@Intresult", SqlDbType.Int);
        Param[13].Direction = ParameterDirection.Output;
        int result = Objdut.ExecuteSqlSP(Param, "usp_submitinstallment");
        return (result);
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string DepositFee1(string FineAmount, string ASAID, string PAYMENTMODE, string BANKNAME, string BRANCHNAME, string CHKREFDDNEFTREFRENCENO, string CHKREFDDNEFTDATE, string RECIPTNO, string PAYMENTDATE, string RemarkOrComment, string PaidAmount, string DateOfDueAmount, string SelectedASID)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[15];
        Param[0] = new SqlParameter("@ASAID", Convert.ToInt32(ASAID));
        Param[1] = new SqlParameter("@PAYMENTMODE", Convert.ToInt32(PAYMENTMODE));
        Param[2] = new SqlParameter("@BANKNAME", BANKNAME);
        Param[3] = new SqlParameter("@BRANCHNAME", BRANCHNAME);
        Param[4] = new SqlParameter("@CHKREFDDNEFTREFRENCENO", CHKREFDDNEFTREFRENCENO);
        Param[5] = new SqlParameter("@CHKREFDDNEFTDATE", CHKREFDDNEFTDATE);
        Param[6] = new SqlParameter("@RECIPTNO", RECIPTNO);
        Param[7] = new SqlParameter("@PAYMENTDATE", DateTime.Now.ToString("yyyy-MM-dd"));
        Param[8] = new SqlParameter("@RemarkOrComment", RemarkOrComment);
        Param[9] = new SqlParameter("@FeeFine", FineAmount);
        Param[10] = new SqlParameter("@UserId", 0);
        Param[11] = new SqlParameter("@PaidAmount", Convert.ToDecimal(PaidAmount));
        Param[12] = new SqlParameter("@RemaingAmountDueDate", DateOfDueAmount);
        Param[13] = new SqlParameter("@SelectedASID", SelectedASID);
        Param[14] = new SqlParameter("@Intresult", SqlDbType.Int);
        Param[14].Direction = ParameterDirection.Output;
        string result = Objdut.ExecuteSqlSP(Param, "usp_submitinstallment").ToString();
        return (result);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public int transPayment(string ASAID, string STDREGNO, string MMP_TXN, string MER_TXN, string AMT, string PROD, string DATE, string BANK_TXN, string F_CODE, string CLIENTCODE, string BANK_NAME, string AUTH_CODE, string MERCHANT_ID, string DESC, string DISCRIMINATOR, string SURCHARGE, string CARDNUMBER)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] Param1 = new SqlParameter[18];
        Param1[0] = new SqlParameter("@StdRegNo", Convert.ToDecimal(STDREGNO));
        Param1[1] = new SqlParameter("@mmp_txn", MMP_TXN.ToString());
        Param1[2] = new SqlParameter("@mer_txn", MER_TXN.ToString());
        Param1[3] = new SqlParameter("@amt", Convert.ToDecimal(AMT));
        Param1[4] = new SqlParameter("@prod", PROD.ToString());
        Param1[5] = new SqlParameter("@date", DATE);
        Param1[6] = new SqlParameter("@bank_txn", BANK_TXN.ToString());
        Param1[7] = new SqlParameter("@f_code", F_CODE.ToString());
        Param1[8] = new SqlParameter("@cliendcode", CLIENTCODE.ToString());
        Param1[9] = new SqlParameter("@bank_name", BANK_NAME.ToString());
        Param1[10] = new SqlParameter("@auth_code", AUTH_CODE.ToString());
        Param1[11] = new SqlParameter("@merchant_id", MERCHANT_ID.ToString());
        Param1[12] = new SqlParameter("@desc", DESC.ToString());
        Param1[13] = new SqlParameter("@discriminator", DISCRIMINATOR.ToString());
        Param1[14] = new SqlParameter("@surcharge", Convert.ToDecimal(SURCHARGE));
        Param1[15] = new SqlParameter("@ASAID", ASAID.ToString());
        Param1[16] = new SqlParameter("@CardNumber", CARDNUMBER.ToString());
        Param1[17] = new SqlParameter("@Intresult", SqlDbType.Int);
        Param1[17].Direction = ParameterDirection.Output;
        int result = Objdut.ExecuteSqlSP(Param1, "usp_FeeTransactionInsert");
        return (result);
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getTransPayDetails(string ASAID, string SAMID)
    {
        DataSet Ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[StudentsAllDetails]", con))
            {
                if (SAMID != "")
                {
                    con.Open();
                    cmd.CommandText = @"select distinct FT.ID,FT.ASAID,FT.StdAdmNo,FT.StdRegNo,FT.mmp_txn,FT.mer_txn,FT.amt,FT.prod,FT.date,FT.bank_name,FT.f_code,FT.cliendcode
                        ,FT.bank_name,FT.auth_code,FT.merchant_id,FT.[desc],FT.discriminator,FT.surcharge,FT.CardNumber
                         from tbl_StudentAdmissionInstallment SAI
                        inner join tblFeeTransDetail FT on FT.ASAID = SAI.ASAID
                        where SAI.SAMID=" + SAMID + "";
                    if (Convert.ToInt32(ASAID) > 0)
                    {
                        cmd.CommandText += " and FT.ASAID=" + ASAID;
                    }
                    SqlDataAdapter Da = new SqlDataAdapter(cmd);
                    Da.Fill(Ds);
                }
            }
        }
        return Ds.GetXml().ToString();
    }
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string getAllFeeDetails(string SAMID)
    {
        DataSet Ds = new DataSet();
        if (SAMID != "")
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand("[StudentsAllDetails]", con))
                {
                    con.Open();
                    cmd.CommandText = @"Select * from tbl_StudentAdmissionInstallment 
                                    left outer join tblFeeTransDetail on tbl_StudentAdmissionInstallment.ASAID = tblFeeTransDetail.ASAID 
                                    where tbl_StudentAdmissionInstallment.SAMID=" + SAMID + "";
                    SqlDataAdapter Da = new SqlDataAdapter(cmd);
                    Da.Fill(Ds);
                }
            }
        }
        return Ds.GetXml().ToString();
    }
}