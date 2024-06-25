using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for transport_service
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
[System.Web.Script.Services.ScriptService]
public class transport_service : System.Web.Services.WebService
{
    public transport_service()
    {
        //Uncomment the following line if using designed components
        //InitializeComponent();
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }

    public class UserDetails
    {
        public string routeno { get; set; }

        public string stopagename { get; set; }

        public string busno { get; set; }

        public string drivername { get; set; }

        public string drivecontactno { get; set; }

        public string status { get; set; }

        public string classid { get; set; }

        public string name { get; set; }

        public string adno { get; set; }

        public string tractive { get; set; }

        public string trdeactive { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public UserDetails[] bindtransportdetail(string mode)
    {
        DataTable dt = new DataTable();
        List<UserDetails> details = new List<UserDetails>();

        dt = BLL.getstudenttransport_detail(Convert.ToString(HttpContext.Current.Session["stue"]), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), mode);

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in dt.Rows)
            {
                UserDetails user = new UserDetails();
                user.routeno = dtrow["routeno"].ToString();
                user.stopagename = dtrow["stopagename"].ToString();
                user.busno = dtrow["busno"].ToString();
                user.drivername = dtrow["drivername"].ToString();
                user.status = dtrow["trstatus"].ToString();
                user.classid = dtrow["classid"].ToString();
                user.name = dtrow["studentname"].ToString();
                user.adno = dtrow["studentAdmissionnNo"].ToString();
                user.tractive = dtrow["tractivedate"].ToString();
                user.trdeactive = dtrow["trdeactivedate"].ToString();

                details.Add(user);
            }
        }
        dt.Clear();
        return details.ToArray();
    }

    [WebMethod(EnableSession = true)]
    public int updatetransport()
    {
        int intResult = 0;
        string monthidfde = "";
        string adid = "";
        DataUtility objdut = new DataUtility();
        DateTime date = Convert.ToDateTime(objdut.GetScalar("select getdate()"));

        int monthid12 = Convert.ToInt32(objdut.GetScalar("select DATEPART(month,getdate())"));

        adid = Convert.ToString(objdut.GetScalar("select adid from tbl_admission where adid='" + Convert.ToString(HttpContext.Current.Session["stue"]) + "'"));

        int monthid = 0;

        if (monthid12 == 1)
        {
            monthid = 10;
        }
        else if (monthid12 == 2)
        {
            monthid = 11;
        }
        else if (monthid12 == 3)
        {
            monthid = 12;
        }
        else if (monthid12 == 4)
        {
            monthid = 1;
        }
        else if (monthid12 == 5)
        {
            monthid = 2;
        }
        else if (monthid12 == 6)
        {
            monthid = 3;
        }
        else if (monthid12 == 7)
        {
            monthid = 4;
        }
        else if (monthid12 == 8)
        {
            monthid = 5;
        }
        else if (monthid12 == 9)
        {
            monthid = 6;
        }
        else if (monthid12 == 10)
        {
            monthid = 7;
        }
        else if (monthid12 == 11)
        {
            monthid = 8;
        }
        else if (monthid12 == 12)
        {
            monthid = 9;
        }

        int monthidfordeactive;

        if (monthid == 12)
        {
            monthidfordeactive = 0;
        }
        else
        {
            monthidfordeactive = monthid + 1;

            for (int i = monthidfordeactive; i <= 12; i++)
            {
                monthidfde = monthidfde + "," + Convert.ToString(i);
            }
        }

        monthidfde = monthidfde.Remove(0, 1);

        string srt = "update tbl_Admission_student_Account set transport_status=0  where transtype='Monthly-Transport Fee' and studentid=" + adid + " and brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + " and paymonth in(" + monthidfde + ")";
        string srt1 = "update tbl_addbusforstudent set trstatus=0 ,trdeactivedate='" + date + "' where adid=" + adid + "";

        intResult = objdut.ExecuteSql(srt);
        intResult = objdut.ExecuteSql(srt1);

        if (intResult > 0)
        {
        }
        double tfee = Convert.ToDouble(objdut.GetScalar("select isnull(sum(credit),0) from tbl_Admission_student_Account where studentid=" + adid + " and brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + " and  transport_status!=0"));
        double payfee = Convert.ToDouble(objdut.GetScalar("select isnull(sum(payfee),0) from tbl_payfee where  studentid=" + adid + " and  brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"])));
        double balc = tfee - payfee;

        string str3 = "update tbl_Admission set totalfee=" + tfee + ",paid=" + payfee + ",balance=" + balc + " where  adid=" + adid + " and brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]);
        intResult = objdut.ExecuteSql(str3);

        return intResult;
    }

    [WebMethod(EnableSession = true)]
    public bindclasses_new[] bindarea(string ddlzoneid)
    {
        List<bindclasses_new> details = new List<bindclasses_new>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select areaid,areaname from tbl_addarea where zoneid=" + ddlzoneid, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                bindclasses_new objProductMasterDetails0 = new bindclasses_new();
                objProductMasterDetails0.SID = Convert.ToInt32("0");
                objProductMasterDetails0.statename = "-Select Society-";
                details.Add(objProductMasterDetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    bindclasses_new objProductMasterDetails = new bindclasses_new();
                    objProductMasterDetails.SID = Convert.ToInt32(dtrow["areaid"].ToString());
                    objProductMasterDetails.statename = dtrow["areaname"].ToString();
                    details.Add(objProductMasterDetails);
                }
            }
        }
        return details.ToArray();
    }

    public class bindclasses_new
    {
        public int SID { get; set; }

        public string statename { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public bindarea_new[] bindbus(string areaid)
    {
        List<bindarea_new> details = new List<bindarea_new>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select distinct isnull(busno,'-') as  busno, ROW_NUMBER() OVER(ORDER BY busno ASC) as rowNumber  from tbl_stopage group by busno,Areaid having Areaid=" + areaid + " and busno is not NULL", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                bindarea_new objProductMasterDetails0 = new bindarea_new();
                objProductMasterDetails0.areaid = Convert.ToInt32("0");
                objProductMasterDetails0.areaname = "-Select Bus-";
                details.Add(objProductMasterDetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    bindarea_new objProductMasterDetails = new bindarea_new();
                    objProductMasterDetails.areaid = Convert.ToInt32(dtrow["rowNumber"].ToString());
                    objProductMasterDetails.areaname = dtrow["busno"].ToString();
                    details.Add(objProductMasterDetails);
                }
            }
        }
        return details.ToArray();
    }

    public class bindarea_new
    {
        public int areaid { get; set; }

        public string areaname { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public binstoppage[] binstopage(string busid)
    {
        List<binstoppage> details = new List<binstoppage>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select stopagename,stopageid from tbl_stopage where busno='" + busid + "'", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                binstoppage objProductMasterDetails0 = new binstoppage();
                objProductMasterDetails0.stopid = Convert.ToInt32("0");
                objProductMasterDetails0.stopname = "-Select Stoppage-";
                details.Add(objProductMasterDetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    binstoppage objProductMasterDetails = new binstoppage();
                    objProductMasterDetails.stopid = Convert.ToInt32(dtrow["stopageid"].ToString());
                    objProductMasterDetails.stopname = dtrow["stopagename"].ToString();
                    details.Add(objProductMasterDetails);
                }
            }
        }
        return details.ToArray();
    }

    public class binstoppage
    {
        public int stopid { get; set; }

        public string stopname { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public int findseat(string busid)
    {
        DataUtility objdut = new DataUtility();
        CommonClass CommonClass = new CommonClass();
        Utility objUT = new Utility();
        DataSet ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            int q2 = Convert.ToInt32(objdut.GetScalar("select count(1) from tbl_addbusforstudent where busno='" + busid + "' and trstatus=1"));
            int q3 = Convert.ToInt32(objdut.GetScalar("select noofseats from tbl_vehicleinfo where registrationno='" + busid + "'"));
            int m1 = Convert.ToInt32(q3 - q2);
            return m1;
        }
    }

    [WebMethod(EnableSession = true)]
    public transportdetail[] filldata(string adno)
    {
        List<transportdetail> details = new List<transportdetail>();
        DataUtility objdut = new DataUtility();
        DataTable dt = new DataTable();
        CommonClass CommonClass = new CommonClass();
        Utility objUT = new Utility();
        DataSet ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select zoneid,areaid,busno,stopoageid from  tbl_addbusforstudent where studentAdmissionnNo='" + adno + "'and trstatus=1", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    transportdetail user = new transportdetail();

                    user.zoneid = dt.Rows[0]["zoneid"].ToString();
                    user.areaid = dt.Rows[0]["areaid"].ToString();
                    user.busno = dt.Rows[0]["busno"].ToString();
                    user.stopage = dt.Rows[0]["stopoageid"].ToString();
                    details.Add(user);
                }
            }
        }

        return details.ToArray();
    }

    public class transportdetail
    {
        public string zoneid { get; set; }

        public string areaid { get; set; }

        public string busno { get; set; }

        public string stopage { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public int insertdata(string adno, string sname, string classnm, int zoneid, int areaid, int busid, string busno, int stoppageid)
    {
        DataUtility objdut = new DataUtility();
        DataTable dt = new DataTable();
        string monthidfde = "";
        DateTime date = Convert.ToDateTime(objdut.GetScalar("select getdate()"));

        int monthid12 = Convert.ToInt32(objdut.GetScalar("select DATEPART(month,getdate())"));

        int monthid = 0;

        if (monthid12 == 1)
        {
            monthid = 10;
        }
        else if (monthid12 == 2)
        {
            monthid = 11;
        }
        else if (monthid12 == 3)
        {
            monthid = 12;
        }
        else if (monthid12 == 4)
        {
            monthid = 1;
        }
        else if (monthid12 == 5)
        {
            monthid = 2;
        }
        else if (monthid12 == 6)
        {
            monthid = 3;
        }
        else if (monthid12 == 7)
        {
            monthid = 4;
        }
        else if (monthid12 == 8)
        {
            monthid = 5;
        }
        else if (monthid12 == 9)
        {
            monthid = 6;
        }
        else if (monthid12 == 10)
        {
            monthid = 7;
        }
        else if (monthid12 == 11)
        {
            monthid = 8;
        }
        else if (monthid12 == 12)
        {
            monthid = 9;
        }

        int monthidfordeactive;

        if (monthid == 12)
        {
            monthidfordeactive = 0;
        }
        else
        {
            monthidfordeactive = monthid;

            for (int i = monthidfordeactive; i <= 12; i++)
            {
                monthidfde = monthidfde + "," + Convert.ToString(i);
            }
        }

        monthidfde = monthidfde.Remove(0, 1);

        string q = Convert.ToString(objdut.GetScalar("select RouteName from tbl_stopage where busno='" + busno + "'"));

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            con.Open();
            using (SqlCommand cmd = new SqlCommand("usp_addbusfrostudent", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@mode", "addbusforstudent");
                cmd.Parameters.AddWithValue("@studenAdmissionNo", adno);
                cmd.Parameters.AddWithValue("@studentname", sname);
                cmd.Parameters.AddWithValue("@class1", classnm);
                cmd.Parameters.AddWithValue("@zoneid", zoneid);
                cmd.Parameters.AddWithValue("@areaid", areaid);
                cmd.Parameters.AddWithValue("@busid", busid);
                cmd.Parameters.AddWithValue("@busno", busno);
                cmd.Parameters.AddWithValue("@stopageid", stoppageid);
                cmd.Parameters.AddWithValue("@branchid", HttpContext.Current.Session["BrBrid"]);
                cmd.Parameters.AddWithValue("@routeno", q);
                cmd.Parameters.AddWithValue("@updatemonth", monthidfde);
                cmd.Parameters.Add("@intResult", SqlDbType.NVarChar, 100, "");
                cmd.Parameters["@intResult"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int intResult = Convert.ToInt32(cmd.Parameters["@intResult"].Value);

                con.Close();

                if (intResult == 1)
                {
                    return intResult;
                }
                else
                {
                    return intResult;
                }
            }
        }
    }
}