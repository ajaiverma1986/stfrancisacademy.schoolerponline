using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for admissionwebservice
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
// [System.Web.Script.Services.ScriptService]
public class admissionwebservice : System.Web.Services.WebService
{
    public admissionwebservice()
    {
        //Uncomment the following line if using designed components
        //InitializeComponent();
    }

    [WebMethod]
    public static int monthdetails(string mid)
    {
        Utility objut = new Utility();
        DataUtility objdut = new DataUtility();
        // BranchPanel_admissionshort onb = new BranchPanel_admissionshort();
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

    public class Admission
    {
        public string firstname { get; set; }

        public string middlename { get; set; }

        public string lastname { get; set; }

        public string imagename { get; set; }

        public string gender { get; set; }

        public string nationality { get; set; }

        public string dateofbirth { get; set; }

        public string height { get; set; }

        public string weight { get; set; }

        public string houseno { get; set; }

        public string buildingname { get; set; }

        public string street { get; set; }

        public string landmark { get; set; }

        public string pincode { get; set; }

        public string languagespeaks { get; set; }

        public string fathername { get; set; }

        public int Fqualification { get; set; }

        public string Fprofession { get; set; }

        public string Forganisation { get; set; }

        public string FTResidentialphno { get; set; }

        public string FTofficephno { get; set; }

        public string FMobileno { get; set; }

        public string FEmail { get; set; }

        public string mothername { get; set; }

        public int Mqualification { get; set; }

        public string Mprofession { get; set; }

        public string Morganisation { get; set; }

        public string MTResidentialphno { get; set; }

        public string MTofficephno { get; set; }

        public string MMobileno { get; set; }

        public string MEmail { get; set; }

        public int previous_schooling { get; set; }

        public string previous_detail { get; set; }

        public string fSiblingdetail_name { get; set; }

        public string fSiblingdetail_Age { get; set; }

        public string fSiblingdetail_school { get; set; }

        public string mSiblingdetail_name { get; set; }

        public string mSiblingdetail_Age { get; set; }

        public string mSiblingdetail_school { get; set; }

        public string lSiblingdetail_name { get; set; }

        public string lSiblingdetail_age { get; set; }

        public string lSiblingdetail_school { get; set; }

        public int LittleIllusionsid { get; set; }

        public int bloodgroupid { get; set; }

        public string vacination { get; set; }

        public string specific_suffered_in_Past { get; set; }

        public string Surgery_undergone { get; set; }

        public string Allergies { get; set; }

        public int regular_medication { get; set; }

        public string regular_medicationdetail { get; set; }

        public int phobias { get; set; }

        public string phobiasdetail { get; set; }

        public string specificinstruction { get; set; }

        public string EMERGENCY_CONTACT_fname { get; set; }

        public string EMERGENCY_CONTACT_fMobile { get; set; }

        public string EMERGENCY_CONTACT_sname { get; set; }

        public string EMERGENCY_CONTACT_sMobile { get; set; }

        public string signature { get; set; }

        public string nameofsignnee { get; set; }

        public string Relationchild { get; set; }

        public string dateofdeclaration { get; set; }   // total parameter 61
    }

    public class UserDetails
    {
        public string feename { get; set; }

        public string fees { get; set; }

        public double cfid { get; set; }
    }

    public class Binfeedata
    {
        public string feename { get; set; }

        public string fees { get; set; }

        public string month { get; set; }
    }

    public class Binfeedata1
    {
        public string fees { get; set; }

        public string month { get; set; }

        public string monthid { get; set; }
    }

    [WebMethod]
    public static Binfeedata[] Bindfeestructure(string classid)
    {
        DataSet ds = new DataSet();
        List<Binfeedata> details = new List<Binfeedata>();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_FeeShow_admissionTime]", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);
                param[1] = new SqlParameter("@classid", classid);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                con.Open();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        Binfeedata user = new Binfeedata();
                        user.feename = dtrow["transtype"].ToString();
                        user.fees = dtrow["credit"].ToString();
                        user.month = dtrow["monthname"].ToString();

                        details.Add(user);
                    }
                }
            }
        }

        return details.ToArray();
    }

    [WebMethod]
    public static Binfeedata1[] bindpay(string classid)
    {
        DataSet ds = new DataSet();
        List<Binfeedata1> details = new List<Binfeedata1>();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_FeeShow_admissionTimePay]", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);
                param[1] = new SqlParameter("@classid", classid);

                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                con.Open();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        Binfeedata1 user = new Binfeedata1();

                        user.fees = dtrow["credit"].ToString();
                        user.month = dtrow["monthname"].ToString();
                        user.monthid = dtrow["paymonth"].ToString();

                        details.Add(user);
                    }
                }
            }
        }

        return details.ToArray();
    }

    [WebMethod]
    public static UserDetails[] BindDatatable(string classid)
    {
        DataTable dt = new DataTable();
        List<UserDetails> details = new List<UserDetails>();
        string query = @"select  t1.cfid,t1.feename,t1.fees,t3.Feename as feecategory,t3.id,case when t3.id=1 then fees*1 when t3.id=2 then fees*1 when t3.id=3 then fees*2 when t3.id=4 then fees*4 when t3.id=5 then fees*12 end as totalfee from classfee_master t1 left outer
 join feestructure t2  on t2.id=t1.Feeid and t1.fyid=" + CommonClass.Scaler("ActiveAcademicYear") + " join  feestructure t3 on t2.Feesubtype=t3.id  where Brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + @" and Classid=" + classid + @"  and t1.status=1 and Feeid
      not in(select id from feestructure where Feesubtype=0)";
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    UserDetails user = new UserDetails();
                    user.feename = dtrow["feename"].ToString();
                    user.fees = dtrow["fees"].ToString();
                    user.cfid = Convert.ToDouble(dtrow["cfid"]);
                    details.Add(user);
                }
            }
        }

        return details.ToArray();
    }
}