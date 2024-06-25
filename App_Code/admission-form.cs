using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for admission_form
/// </summary>

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
[System.Web.Script.Services.ScriptService]
public class admission_form : System.Web.Services.WebService
{
    DataTable dthead = new DataTable();
    decimal RegistrationNo = 0;
    public admission_form()
    {
        //Uncomment the following line if using designed components
        //InitializeComponent();
    }

    [WebMethod(EnableSession = true)]
    public string checkdiscountisgevinornot(string sfname, string smname, string slname, string ffname, string fmname, string flname, string dob, int classid, string mobileno)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select count(1) from tbl_StudentRegistration where registrationno='" + 1 + "' and Brid=" + Convert.ToDouble(HttpContext.Current.Session["BrBrid"]) + " and status=0", con))
            {
                con.Open();
                string chk = cmd.ExecuteScalar().ToString();
                con.Close();
                return chk;
            }
        }
    }

    public class DiscountDtataInsert
    {
        public string refnno { get; set; }

        public string sfname { get; set; }

        public string smname { get; set; }

        public string slname { get; set; }

        public DateTime dob { get; set; }

        public DateTime discountdate { get; set; }

        public string ffname { get; set; }

        public string fmname { get; set; }

        public string flname { get; set; }

        public string classid { get; set; }

        public string mobileno { get; set; }

        public string cfid { get; set; }

        public string cfeename { get; set; }

        public string actualfee { get; set; }

        public string discountfee { get; set; }

        public string netamount { get; set; }

        public string transport { get; set; }

        public string checkvalue { get; set; }

        public string feecatgry { get; set; }

        public int fyid { get; set; }

        public string allexamid { get; set; }

        public string allmonthsdevelopment { get; set; }

        public string allmonthoftuitionfee { get; set; }

        public string allmonthoftransportfee { get; set; }

        public string allmonthsdevelopment11 { get; set; }
    }

    public string insertdiscountInfo(Datainsert theData)
    {
        int result1 = 0;
        DataUtility objdut = new DataUtility();
        SqlCommand cmd;
        string Discount = "";
        Discount = Convert.ToString(objdut.GetScalar("Select DiscountCode from DiscountedStudent_Info where Brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + "" +
                        " and Registration_No='" + theData.RegNo + "' and Fyid=" + theData.Fyid + " and ClassId=" + theData.Applyclass + ""));

        if (Discount != "")
        {
            string str2 = "delete from Discount_student_master where DiscountCode = " + Discount + "";
            int resut = objdut.ExecuteSql(str2);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
            {

                string[] DisFee = theData.FeeStructure.Split('~');
                for (int i = 0; i < DisFee.Length; i++)
                {
                    con.Open();
                    string[] DisFeeHeadBy = DisFee[i].Split(',');
                    //for (int j = 0; j < DisFeeHeadBy.Length; j++)
                    //{
                    string FeeTypeName = "";
                    string FeeHeadName = "";
                    int FeeHeadID = 0;
                    decimal ActualFeeBeforeDiscount = 0;
                    decimal ActualFeeAfterDiscount = 0;
                    decimal TotalDiscount = 0;
                    decimal Discountamt = 0;
                    int MonthID = 0;
                    string MonthName = "";
                    string AllMonthName = "";
                    AllMonthName = DisFeeHeadBy[3].ToString();

                    FeeTypeName = Convert.ToString(objdut.GetScalar("Select isnull(Feename,'') Feename from Feestructure where id =" + DisFeeHeadBy[1] + ""));
                    FeeHeadName = Convert.ToString(objdut.GetScalar("Select ISNULL(FeeName,'') FeeName from Classfee_master where CFid = " + DisFeeHeadBy[0] + ""));
                    FeeHeadID = Convert.ToInt32(objdut.GetScalar("Select ISNULL(Feeid,0) FeeName from Classfee_master where CFid = " + DisFeeHeadBy[0] + ""));
                    ActualFeeBeforeDiscount = Convert.ToDecimal(objdut.GetScalar("Select isnull(T1.Fees,0) Fees From Classfee_master T1 " +
                                    " Left Outer Join feestructure T2  On T2.id=T1.Feeid And T1.fyid=" + theData.Fyid + "" +
                                    " Join  Feestructure T3 On T2.Feesubtype=T3.id  where Brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + " and Classid=" + theData.Applyclass + "" +
                                    " And T1.status=1  And CFid = " + DisFeeHeadBy[0] + ""));
                    Discountamt = Convert.ToDecimal(DisFeeHeadBy[4]);
                    ActualFeeAfterDiscount = ActualFeeBeforeDiscount - Discountamt;

                    TotalDiscount += Convert.ToDecimal(DisFeeHeadBy[4]);
                    using (cmd = new SqlCommand("usp_StudentDiscount", con))
                    {
                        string[] MOnthID = AllMonthName.Split('@');
                        for (int k = 0; k < MOnthID.Length; k++)
                        {
                            TotalDiscount += Convert.ToDecimal(DisFeeHeadBy[4]);
                            using (cmd = new SqlCommand("usp_StudentDiscount", con))
                            {
                                if (MOnthID.Length > 0)
                                {
                                    MonthID = Convert.ToInt32(MOnthID[k]);
                                    MonthName = Convert.ToString(objdut.GetScalar("select isnull(Month_Name,'') Month_Name from Month where Month_Id = " + MonthID + ""));

                                    cmd.CommandType = CommandType.StoredProcedure;
                                    cmd.CommandText = "usp_StudentDiscount";
                                    cmd.Parameters.AddWithValue("@DiscountCode", Discount.ToString());
                                    cmd.Parameters.AddWithValue("@FeeCategoryId", Convert.ToInt32(DisFeeHeadBy[1]));
                                    cmd.Parameters.AddWithValue("@FeeCategoryName", FeeTypeName);
                                    cmd.Parameters.AddWithValue("@FeeHeadId", FeeHeadID);
                                    cmd.Parameters.AddWithValue("@FeeHeadName", FeeHeadName);
                                    cmd.Parameters.AddWithValue("@DiscountTypeId", DisFeeHeadBy[2]);
                                    if (DisFeeHeadBy[2].ToString() == "1")
                                    {
                                        cmd.Parameters.AddWithValue("@DiscountName", "One Time");
                                    }
                                    else if (DisFeeHeadBy[2].ToString() == "2")
                                    {
                                        cmd.Parameters.AddWithValue("@DiscountName", "Recurring");
                                    }
                                    else
                                    {
                                        cmd.Parameters.AddWithValue("@DiscountName", "N");
                                    }
                                    cmd.Parameters.AddWithValue("@DiscountInMonthId", MonthID);
                                    cmd.Parameters.AddWithValue("@DiscountInMonthName", MonthName.ToString());
                                    cmd.Parameters.AddWithValue("@ActualFeeBeforeDiscount", Convert.ToDecimal(ActualFeeBeforeDiscount));
                                    cmd.Parameters.AddWithValue("@Discount", Discountamt.ToString());
                                    cmd.Parameters.AddWithValue("@FeeAfterDiscount", Convert.ToDecimal(ActualFeeAfterDiscount));
                                    cmd.Parameters.AddWithValue("@Status", 1);
                                    cmd.Parameters.AddWithValue("@Isactive", 1);
                                    cmd.Parameters.AddWithValue("@TotalDiscount", TotalDiscount);
                                    cmd.Parameters.Add("@intResult", SqlDbType.NVarChar, 400, "");
                                    cmd.Parameters["@intResult"].Direction = ParameterDirection.Output;
                                    cmd.ExecuteNonQuery();
                                    string intResult = "";
                                    intResult = Convert.ToString(cmd.Parameters["@intResult"].Value);
                                }
                            }
                        }
                    }
                    //}
                    con.Close();
                }
            }
            DataTable dtFeeinstallMent = new DataTable();

            string getInstallementFee = "select * from tbl_StudentAdmissionInstallment where SturegNo = " + RegistrationNo + "" +
                                        " and Fyid=" + theData.Fyid + " and Brid = " + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + "" +
                                        " and PaymentStatusId <> 2";
            dtFeeinstallMent = objdut.GetDataTable(getInstallementFee);
            string strupdate = "";
            string strupdate1 = "";
            if (dtFeeinstallMent.Rows.Count > 0)
            {
                foreach (DataRow dr in dtFeeinstallMent.Rows)
                {
                    string DiscountDescription = "";
                    decimal discountAmount = 0;
                    string strMonth = "";
                    if (dr["MonthId"].ToString() == "4")
                    {
                        strMonth = ",0";
                    }
                    string str = "Select FeeHeadName,Discount from Discount_student_master DM " +
                                " inner join DiscountedStudent_Info Di on DM.DiscountCode = Di.DiscountCode " +
                                " where DiscountInMonthId IN (" + dr["MonthId"] + strMonth + ") and Di.DiscountCode = " + Discount + " and Registration_No = '" + theData.RegNo + "'" +
                                " and Di.Fyid = " + theData.Fyid + " and Di.Brid =" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + " ";

                    DataTable dtDiscountMonthWise = objdut.GetDataTable(str);

                    if (dtDiscountMonthWise.Rows.Count > 0)
                    {
                        for (int k = 0; k < dtDiscountMonthWise.Rows.Count; k++)
                        {
                            string strDiscountDescription = "";
                            decimal discountAmount1 = 0;
                            strDiscountDescription = dtDiscountMonthWise.Rows[k]["FeeHeadName"].ToString() + " : " + dtDiscountMonthWise.Rows[k]["Discount"].ToString();
                            discountAmount1 = Convert.ToDecimal(dtDiscountMonthWise.Rows[k]["Discount"]);
                            if (DiscountDescription == "")
                            {
                                DiscountDescription = strDiscountDescription;
                            }
                            else
                            {
                                DiscountDescription = DiscountDescription + "~" + strDiscountDescription;
                            }
                            discountAmount += discountAmount1;
                        }
                    }

                    strupdate = "Update tbl_StudentAdmissionInstallment set DiscountDescription = '" + DiscountDescription + "',DiscountOnInstallment = " + discountAmount + "" +
                                 " where SturegNo = " + RegistrationNo + " and Fyid=" + theData.Fyid + " and Brid = " + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + "" +
                                 " and PaymentStatusId <> 2 and MonthId = " + dr["MonthId"] + "";
                    int result3 = objdut.ExecuteSql(strupdate);
                }

                string strTotalDisCount = "";
                strTotalDisCount = "Select Sum(DiscountOnInstallment) from tbl_StudentAdmissionInstallment where SturegNo = " + RegistrationNo + " and Fyid=" + theData.Fyid + " and Brid = " + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + " and PaymentStatusId <> 2";
                decimal TotalDiscount1 = Convert.ToDecimal(objdut.GetScalar(strTotalDisCount));

                strupdate1 = "Update tbl_StudentAdmissionMaster set DiscountCode = " + Discount + "" +
                                 " where SturegNo = " + RegistrationNo + " and Fyid=" + theData.Fyid + " and Brid = " + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + "";

                int result2 = objdut.ExecuteSql(strupdate1);
            }
        }
        return Discount;
    }
    [WebMethod(EnableSession = true)]
    public bindclass[] binclass()
    {
        List<bindclass> details = new List<bindclass>();
        DataTable dt = new DataTable();
        CommonClass CommonClass = new CommonClass();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        //dt = BLL.getclass(Convert.ToInt16(HttpContext.Current.Session["BrBrid"]));
        dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ActiveFinancialyear), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));

        bindclass objProductMasterDetails0 = new bindclass();
        objProductMasterDetails0.SID = Convert.ToInt32("0");
        objProductMasterDetails0.statename = "---Select Class---";
        details.Add(objProductMasterDetails0);

        foreach (DataRow dtrow in dt.Rows)
        {
            bindclass objProductMasterDetails = new bindclass();
            objProductMasterDetails.SID = Convert.ToInt32(dtrow["classid"].ToString());
            objProductMasterDetails.statename = dtrow["Classname"].ToString();
            details.Add(objProductMasterDetails);
        }

        return details.ToArray();
    }

    public class bindclass
    {
        public int SID { get; set; }

        public string statename { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public UserDetails[] BindDatatable(string classid, int transport)
    {
        DataTable dt = new DataTable();
        List<UserDetails> details = new List<UserDetails>();

        dt = BLL.getclassfeestructure(Convert.ToInt32(classid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        foreach (DataRow dtrow in dt.Rows)
        {
            UserDetails user = new UserDetails();
            user.feename = dtrow["feename"].ToString();
            user.fees = dtrow["fees"].ToString();
            user.cfid = Convert.ToDouble(dtrow["cfid"]);
            details.Add(user);
        }

        return details.ToArray();
    }

    [WebMethod(EnableSession = true)]
    public regdetails[] BindStudentdetail(string classid)
    {
        DataUtility objdut = new DataUtility();
        Utility objut = new Utility();
        DataTable dt = new DataTable();
        List<regdetails> details = new List<regdetails>();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            HttpContext.Current.Session["regno"] = classid;
            string var = Convert.ToString(HttpContext.Current.Session["regno"]);
            long rid = objut.GetRegistrationNo(var);
            using (SqlCommand cmd = new SqlCommand(@"select rid,Registrationno,firstname,isnull(middlename,'')as middlename,convert(varchar,GETDATE(),104) as                                           currentdate ,lastname,convert(varchar(12),dateofbirth,121) as dateofbirth ,ffirstname,isnull(fmiddlename,'')as fmiddlename,
                    flastname,mfirstname,isnull(MmiddleName,'')as mmiddlename,mlastname,gender,classid,Address,countryid,stateid,cityid,pincode,Fmobileno,
                    isnull(uploadletestreportcard,'') as ulrc,isnull(uploadmotherphoto,'') as ump,isnull(uploadfatherphoto,'') as ufp,isnull(uploadbirthcirtificate,'') as ubc,
                    isnull(uploadchildphoto,'') as usp from tbl_StudentRegistration where rid=" + rid + " and status in (2,0,5)", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                HttpContext.Current.Session["rid"] = rid;
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    regdetails user = new regdetails();

                    user.rid = dtrow["rid"].ToString();
                    user.firstname = dtrow["firstname"].ToString();
                    user.middlename = dtrow["middlename"].ToString();
                    user.lastname = dtrow["lastname"].ToString();
                    user.dateofbirth = dtrow["dateofbirth"].ToString();
                    user.ffirstname = dtrow["ffirstname"].ToString();
                    user.fmiddlename = dtrow["fmiddlename"].ToString();
                    user.flastname = dtrow["flastname"].ToString();
                    user.mfirstname = dtrow["mfirstname"].ToString();
                    user.MmiddleName = dtrow["MmiddleName"].ToString();
                    user.mlastname = dtrow["mlastname"].ToString();
                    user.gender = dtrow["gender"].ToString();
                    user.classid = dtrow["classid"].ToString();
                    user.Address = dtrow["Address"].ToString();
                    user.countryid = dtrow["countryid"].ToString();
                    user.stateid = dtrow["stateid"].ToString();
                    user.cityid = dtrow["cityid"].ToString();
                    user.pincode = dtrow["pincode"].ToString();
                    user.Fmobileno = dtrow["Fmobileno"].ToString();
                    details.Add(user);
                }
            }
        }
        return details.ToArray();
    }

    public class regdetails
    {
        public string rid { get; set; }

        public string firstname { get; set; }

        public string middlename { get; set; }

        public string lastname { get; set; }

        public string dateofbirth { get; set; }

        public string ffirstname { get; set; }

        public string fmiddlename { get; set; }

        public string flastname { get; set; }

        public string mfirstname { get; set; }

        public string MmiddleName { get; set; }

        public string mlastname { get; set; }

        public string gender { get; set; }

        public string classid { get; set; }

        public string Address { get; set; }

        public string countryid { get; set; }

        public string stateid { get; set; }

        public string cityid { get; set; }

        public string pincode { get; set; }

        public string Fmobileno { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public ProductMasterDetails[] bindsection(string sid)
    {
        List<ProductMasterDetails> details = new List<ProductMasterDetails>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select cwsid,sectionname from classwithsection where BranchId=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + " and status=1 and classid=" + sid, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                ProductMasterDetails objProductMasterDetails0 = new ProductMasterDetails();
                objProductMasterDetails0.SID = Convert.ToInt32("0");
                objProductMasterDetails0.sectionname = "-Select section-";
                details.Add(objProductMasterDetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    ProductMasterDetails objProductMasterDetails = new ProductMasterDetails();
                    objProductMasterDetails.SID = Convert.ToInt32(dtrow["cwsid"].ToString());
                    objProductMasterDetails.sectionname = dtrow["sectionname"].ToString();
                    details.Add(objProductMasterDetails);
                }
            }
        }
        return details.ToArray();
    }

    [WebMethod(EnableSession = true)]
    public string checkregitartion(string regist)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select count(1) from tbl_StudentRegistration where registrationno='" + regist + "' and Brid=" + Convert.ToDouble(HttpContext.Current.Session["BrBrid"]) + " and status in (0,2,5)", con))
            {
                con.Open();
                string chk = cmd.ExecuteScalar().ToString();
                con.Close();
                return chk;
            }
        }
    }

    public class ProductMasterDetails
    {
        public int SID { get; set; }

        public string sectionname { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public UserDetails[] getfeeheads(string classid, int transport, int monthid, string sfname, string smname, string slname, DateTime sdob, string ffname, string ffmane, string flname, string contactno, string discountcode)
    {
        DataTable dt = new DataTable();
        List<UserDetails> details = new List<UserDetails>();

        dt = BLL.getclassfee(Convert.ToInt32(classid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), transport, monthid, sfname, smname, slname, sdob, ffname, ffmane, flname, contactno, discountcode);
        foreach (DataRow dtrow in dt.Rows)
        {
            UserDetails user = new UserDetails();
            user.feename = dtrow["feename"].ToString();
            user.fees = dtrow["fees"].ToString();
            details.Add(user);
        }

        return details.ToArray();
    }

    [WebMethod(EnableSession = true)]
    public UserDetails[] getfeeheadsnew(int classid, int transport, int fyid)
    {
        DataTable dt = new DataTable();
        List<UserDetails> details = new List<UserDetails>();

        dt = BLL.getclassfeenew(classid, Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), transport, fyid);
        foreach (DataRow dtrow in dt.Rows)
        {
            UserDetails user = new UserDetails();
            user.feename = dtrow["feename"].ToString();
            user.fees = dtrow["fees"].ToString();
            details.Add(user);
        }

        return details.ToArray();
    }

    public class UserDetails
    {
        public string feename { get; set; }

        public string fees { get; set; }

        public double cfid { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public feetotaldetaildeawise[] getfeeheadstotalwise(string classid, int transport, int fyid)
    {
        //DataTable dt = new DataTable();
        List<feetotaldetaildeawise> details = new List<feetotaldetaildeawise>();

        dthead = BLL.getclassfee1(Convert.ToInt32(classid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), transport, fyid);
        foreach (DataRow dtrow in dthead.Rows)
        {
            if (Convert.ToInt32(dtrow["FeeHeadId"]) != 6)
            {
                feetotaldetaildeawise user = new feetotaldetaildeawise();
                user.feename = dtrow["feename"].ToString();
                user.fees = dtrow["fees"].ToString();
                user.cfid = Convert.ToDouble(dtrow["cfid"]);
                user.feecatgry = dtrow["feecategory"].ToString();
                user.feecatgryId = Convert.ToInt32(dtrow["id"]);
                details.Add(user);
            }
        }

        return details.ToArray();
    }

    public class feetotaldetaildeawise
    {
        public string feename { get; set; }

        public string fees { get; set; }

        public double cfid { get; set; }

        public string feecatgry { get; set; }

        public int feecatgryId { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public int monthdays(string mid)
    {
        Utility objut = new Utility();
        DataUtility objdut = new DataUtility();

        DataTable dt = new DataTable();
        CommonClass CommonClass = new CommonClass();
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

    [WebMethod(EnableSession = true)]
    public feemonth[] getmonthwithfee(string classid, int transport, int monthid, string sfname, string smname, string slname, DateTime sdob, string ffname, string ffmane, string flname, string contactno, string discountcode)
    {
        List<feemonth> details = new List<feemonth>();
        DataTable dt = BLL.bindpayfee(Convert.ToInt32(classid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), transport, monthid, sfname, smname, slname, sdob, ffname, ffmane, flname, contactno, discountcode);
        foreach (DataRow dtrow in dt.Rows)
        {
            feemonth user = new feemonth();

            user.fees = Convert.ToDouble(dtrow["credit"].ToString());
            user.month = dtrow["monthname"].ToString();
            user.monthid = (dtrow["paymonth"].ToString());

            details.Add(user);
        }
        return details.ToArray();
    }

    public class feemonth
    {
        public string month { get; set; }

        public double fees { get; set; }

        public string monthid { get; set; }
    }

    [WebMethod]
    public string checkdiscountcode(string discode)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select count(1) from DiscountedStudent_Info where studentid='" + discode + "' and status=1", con))
            {
                con.Open();
                string chk = cmd.ExecuteScalar().ToString();
                con.Close();
                return chk;
            }
        }
    }

    [WebMethod]
    public regdetails12[] retrieveclassid(string discode)
    {
        DataTable dt = new DataTable();
        List<regdetails12> details = new List<regdetails12>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand(@"select classid,fyid,registrationno,sfname,smname,slname,fname,fmname,flname,mobileno,convert(varchar(12), dob, 101) as dob from DiscountedStudent_Info where studentid='" + discode + "'", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    regdetails12 user = new regdetails12();

                    user.classid = dtrow["classid"].ToString();
                    user.firstname = dtrow["sfname"].ToString();
                    user.middlename = dtrow["smname"].ToString();
                    user.lastname = dtrow["slname"].ToString();
                    user.ffirstname = dtrow["fname"].ToString();
                    user.fmddname = dtrow["fmname"].ToString();
                    user.flastname = dtrow["flname"].ToString();
                    user.dateofbirth = dtrow["dob"].ToString();
                    user.mobileno = dtrow["mobileno"].ToString();
                    user.regno = dtrow["registrationno"].ToString();
                    user.fyid = Convert.ToInt16(dtrow["fyid"]);

                    details.Add(user);
                }
            }
        }

        return details.ToArray();
    }

    public class regdetails12
    {
        public string classid { get; set; }

        public string firstname { get; set; }

        public string middlename { get; set; }

        public string lastname { get; set; }

        public string dateofbirth { get; set; }

        public string ffirstname { get; set; }

        public string fmddname { get; set; }

        public string flastname { get; set; }

        public string mobileno { get; set; }

        public string regno { get; set; }

        public int fyid { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public Binfeedata[] Bindfeestructure(string classid, int transport, int monthid, string sfname, string smname, string slname, DateTime sdob, string ffname, string ffmane, string flname, string contactno, string discountcode)
    {
        List<Binfeedata> details = new List<Binfeedata>();
        DataTable dt = BLL.bindfeestructure(Convert.ToInt32(classid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), transport, monthid, sfname, smname, slname, sdob, ffname, ffmane, flname, contactno, discountcode);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in dt.Rows)
            {
                Binfeedata user = new Binfeedata();
                user.feename = dtrow["transtype"].ToString();
                user.fees = dtrow["credit"].ToString();
                user.month = dtrow["monthname"].ToString();
                user.monthid = dtrow["paymonth"].ToString();

                details.Add(user);
            }
        }
        dt.Clear();
        return details.ToArray();
    }

    public class Binfeedata
    {
        public string feename { get; set; }

        public string fees { get; set; }

        public string month { get; set; }

        public string monthid { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public Binfeedata2[] bindpaystructure(int adid)
    {
        List<Binfeedata2> details = new List<Binfeedata2>();

        DataTable dt = BLL.bindpaystructure(adid);

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in dt.Rows)
            {
                Binfeedata2 user = new Binfeedata2();
                user.feename = dtrow["transtype"].ToString();
                user.fees = dtrow["credit"].ToString();
                user.month = dtrow["monthname"].ToString();
                user.monthid = dtrow["paymonth"].ToString();

                details.Add(user);
            }
        }
        dt.Clear();
        return details.ToArray();
    }

    public class Binfeedata2
    {
        public string feename { get; set; }

        public string fees { get; set; }

        public string month { get; set; }

        public string monthid { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public static ProductMasterDetails1[] bindstate(string cid)
    {
        List<ProductMasterDetails1> details = new List<ProductMasterDetails1>();
        DataTable dt = new DataTable();
        HttpContext.Current.Session["cid"] = cid;
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select SID, statename from state  where sActive=1 and CID=" + HttpContext.Current.Session["cid"] + " order by statename asc", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                ProductMasterDetails1 objProductMasterDetails0 = new ProductMasterDetails1();
                objProductMasterDetails0.SID = Convert.ToInt32("0");
                objProductMasterDetails0.statename = "-Select State-";
                details.Add(objProductMasterDetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    ProductMasterDetails1 objProductMasterDetails = new ProductMasterDetails1();
                    objProductMasterDetails.SID = Convert.ToInt32(dtrow["SID"].ToString());
                    objProductMasterDetails.statename = dtrow["statename"].ToString();
                    details.Add(objProductMasterDetails);
                }
            }
        }
        return details.ToArray();
    }

    public class ProductMasterDetails1
    {
        public int SID { get; set; }

        public string statename { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public citymaster[] bindcity(string sid)
    {
        List<citymaster> details = new List<citymaster>();
        DataTable dtcity = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select CTID,cityName from CITY where Active=1 and SID=" + sid, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dtcity);
                citymaster objProductMasterDetails0 = new citymaster();
                objProductMasterDetails0.CTID = Convert.ToInt32("0");
                objProductMasterDetails0.cityName = "-Select City-";
                details.Add(objProductMasterDetails0);

                foreach (DataRow dtrow in dtcity.Rows)
                {
                    citymaster citymasterobj = new citymaster();
                    citymasterobj.CTID = Convert.ToInt32(dtrow["CTID"].ToString());
                    citymasterobj.cityName = dtrow["cityName"].ToString();
                    details.Add(citymasterobj);
                }
            }
        }
        return details.ToArray();
    }

    public class citymaster
    {
        public int CTID { get; set; }

        public string cityName { get; set; }
    }

    public class Datainsert
    {
        public string RegNo { get; set; }

        public string Fyid { get; set; }

        public string Sfname { get; set; }

        public string Smname { get; set; }

        public string Slname { get; set; }

        public string Sdob { get; set; }

        public string Applyclass { get; set; }

        public string Pfname { get; set; }

        public string Pmname { get; set; }

        public string Plname { get; set; }

        public string Address { get; set; }

        public string Mobile { get; set; }

        public string DiscountDate { get; set; }

        public string FeeStructure { get; set; }

        public string CommentORRemark { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public string InsertDiscountData(Datainsert theData)
    {
        DataUtility objdut = new DataUtility();
        int count = 0;
        count = (int)(Convert.ToDecimal(objdut.GetScalar("select Count(*) from tbl_StudentMaster where Registration_No ='" + theData.RegNo + "' and brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + "")));
        if(count == 0)
        {
            return "Please Enter Valid Registration No  Of Student.";
        }
        else
        {
            SqlParameter[] Param = new SqlParameter[19];
            Param[0] = new SqlParameter("@Registration_No", theData.RegNo);
            Param[1] = new SqlParameter("@Fyid", Convert.ToInt32(theData.Fyid));
            Param[2] = new SqlParameter("@Brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
            Param[3] = new SqlParameter("@Sfname", theData.Sfname);
            Param[4] = new SqlParameter("@Smname", theData.Smname);
            Param[5] = new SqlParameter("@Slname", theData.Slname);
            Param[6] = new SqlParameter("@DOB", theData.Sdob);
            Param[7] = new SqlParameter("@ClassId", Convert.ToInt32(theData.Applyclass));
            Param[8] = new SqlParameter("@Pfname", theData.Pfname);
            Param[9] = new SqlParameter("@Pmname", theData.Pmname);
            Param[10] = new SqlParameter("@Plname", theData.Plname);
            Param[11] = new SqlParameter("@PmobileNo", theData.Mobile);
            Param[12] = new SqlParameter("@Paddress", theData.Address);
            Param[13] = new SqlParameter("@DiscountDate", theData.DiscountDate);
            Param[14] = new SqlParameter("@FeeStructureOnTheBehlafOfCFID", theData.FeeStructure);
            Param[15] = new SqlParameter("@UserId", Convert.ToInt32(HttpContext.Current.Session["BrADID"]));
            Param[16] = new SqlParameter("@intresult", Convert.ToInt32(0));
            Param[16].Direction = ParameterDirection.Output;
            Param[17] = new SqlParameter("@CommentORRemark", theData.CommentORRemark);
            Param[18] = new SqlParameter("@IsImplemented", 1);
            int intresult = objdut.ExecuteSqlSP(Param, "Usp_DiscountManagement");
            string Discount = "";
            int result2 = 0;
            if (intresult == 1 || intresult == 2)
            {
                RegistrationNo = Convert.ToDecimal(objdut.GetScalar("select ISNULL(SturegNo,0) SturegNo from tbl_StudentMaster where Registration_No ='" + theData.RegNo + "' and brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + ""));
                Discount = insertdiscountInfo(theData);
                if (Discount != "")
                {
                    string strupdate = "Update tbl_StudentAdmissionMaster set DiscountCode = " + Discount + "" +
                                       " where SturegNo = " + RegistrationNo + " and Fyid=" + theData.Fyid + " and " +
                                       " Brid = " + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + "";
                    result2 = objdut.ExecuteSql(strupdate);

                    if (intresult == 1)
                    {
                        return "Discount Given Successfully";
                    }
                    else
                    {
                       return "Discount Update Successfully";
                    }
                }
                else
                {
                    string strupdate = "Delete from Discount_student_master where DiscountCode = " + Discount + "";
                    result2 = objdut.ExecuteSql(strupdate);

                    return "Some Error Occur While Giving The Discount";
                }
            }
            else
            {
                string strupdate = "Delete from Discount_student_master where DiscountCode = " + Discount + "";
                objdut.ExecuteSql(strupdate);
                return "Some Error Occur While Giving The Discount";
            }  
        }      
    }


    [WebMethod(EnableSession = true)]
    public string GetDetailsOnTheBehalfOfRegistrationNo(string Registration_No)
    {
        DataSet Ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_studentregistrationlist]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@registrationno", Registration_No);
                param[1] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
                param[2] = new SqlParameter("@Mode", 2);              
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                SqlDataAdapter Da = new SqlDataAdapter(cmd);
                Da.Fill(Ds);
            }
        }
        return Ds.GetXml().ToString();
    }



    [WebMethod(EnableSession = true)]
    public bindmonths[] bindmonth()
    {
        List<bindmonths> details = new List<bindmonths>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select monthid,monthname from month_name Order By DisplayOrder Asc", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    bindmonths objProductMasterDetails = new bindmonths();
                    objProductMasterDetails.mid = Convert.ToInt32(dtrow["monthid"]);
                    objProductMasterDetails.monthname = dtrow["monthname"].ToString();
                    details.Add(objProductMasterDetails);
                }
            }
        }
        return details.ToArray();
    }

    public class bindmonths
    {
        public int mid { get; set; }

        public string monthname { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public UserDetails1[] binddiscountfeeheadwise(string dstudentid)
    {
        DataTable dt = new DataTable();
        List<UserDetails1> details = new List<UserDetails1>();

        dt = BLL.discountfeeheadwise(dstudentid);

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in dt.Rows)
            {
                UserDetails1 user = new UserDetails1();
                user.cfeename = dtrow["cfeename"].ToString();
                user.actualfee = Convert.ToDouble(dtrow["actualfee"]);
                user.discountedFee = Convert.ToDouble(dtrow["discountedFee"]);
                user.netfee = Convert.ToDouble(dtrow["netfee"]);
                user.cmonthname = dtrow["cmonthname"].ToString();
                user.overallactualfee = Convert.ToDouble(dtrow["overallactualfee"]);
                user.overalldiscountfee = Convert.ToDouble(dtrow["overalldiscountfee"]);
                user.overallnetfee = Convert.ToDouble(dtrow["overallnetfee"]);

                details.Add(user);
            }
        }
        dt.Clear();
        return details.ToArray();
    }

    public class UserDetails1
    {
        public string cfeename { get; set; }

        public double actualfee { get; set; }

        public double discountedFee { get; set; }

        public double netfee { get; set; }

        public string cmonthname { get; set; }

        public double overallactualfee { get; set; }

        public double overalldiscountfee { get; set; }

        public double overallnetfee { get; set; }
    }
}