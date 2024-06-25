using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_common : System.Web.UI.Page
{
    private static int city;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static ProductMasterDetails[] bindstate(string cid)
    {
        List<ProductMasterDetails> details = new List<ProductMasterDetails>();
        DataTable dt = new DataTable();
        HttpContext.Current.Session["cid"] = cid;
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select SID, statename from state  where sActive=1 and CID=" + HttpContext.Current.Session["cid"] + " order by statename asc", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                ProductMasterDetails objProductMasterDetails0 = new ProductMasterDetails();
                objProductMasterDetails0.SID = Convert.ToInt32("0");
                objProductMasterDetails0.statename = "-Select State-";
                details.Add(objProductMasterDetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    ProductMasterDetails objProductMasterDetails = new ProductMasterDetails();
                    objProductMasterDetails.SID = Convert.ToInt32(dtrow["SID"].ToString());
                    objProductMasterDetails.statename = dtrow["statename"].ToString();
                    details.Add(objProductMasterDetails);
                }
            }
        }
        return details.ToArray();
    }

    public class ProductMasterDetails
    {
        public int SID { get; set; }

        public string statename { get; set; }
    }

    [WebMethod]
    public static citymaster[] bindcity(string sid)
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

    //===========================================this code is for getting student List or searching on Registration purpose==================================
    [WebMethod(EnableSession = true)]
    public static studentdetails[] BindDatatable(string status, string datefrom, string dateto, string classid, string mobileno, string regno, string name, string studentstatus, int pagesize, int pageno, string fyid)
    {
        DataSet ds = new DataSet();
        List<studentdetails> details = new List<studentdetails>();

        SqlParameter[] p = new SqlParameter[12];

        p[0] = new SqlParameter("@branchID", SqlDbType.VarChar, 50);
        p[0].Value = HttpContext.Current.Session["BrBrid"].ToString();

        p[1] = new SqlParameter("@status", SqlDbType.VarChar, 50);
        p[1].Value = status;

        p[2] = new SqlParameter("@datefrom", SqlDbType.VarChar, 100);
        p[2].Value = datefrom;

        p[3] = new SqlParameter("@dateto", SqlDbType.VarChar, 100);
        p[3].Value = dateto;

        p[4] = new SqlParameter("@classid", SqlDbType.VarChar, 50);
        p[4].Value = classid;

        p[5] = new SqlParameter("@mobileno", SqlDbType.VarChar, 100);
        p[5].Value = mobileno;

        p[6] = new SqlParameter("@regno", SqlDbType.VarChar, 100);
        p[6].Value = regno;

        p[7] = new SqlParameter("@name", SqlDbType.VarChar, 200);
        p[7].Value = name;

        p[8] = new SqlParameter("@studentstatus", SqlDbType.VarChar, 50);
        if (studentstatus != "")
        {
            p[8].Value = studentstatus;
        }
        else
        {
            p[8].Value = "";
        }
        p[9] = new SqlParameter("@pagesize", SqlDbType.Int);
        p[9].Value = pagesize;

        p[10] = new SqlParameter("@pageno", SqlDbType.Int);
        p[10].Value = pageno;

        p[11] = new SqlParameter("@fyid", SqlDbType.VarChar, 10);
        p[11].Value = fyid;

        DataUtility ObjDUT = new DataUtility();
        ds = ObjDUT.GetDataSetSP(p, "usp_Get_Student_List");

        foreach (DataRow dtrow in ds.Tables[0].Rows)
        {
            studentdetails user = new studentdetails();

            user.RowNumber = dtrow["RowNumber"].ToString();
            user.Registrationno = dtrow["Registrationno"].ToString();
            user.name = dtrow["name"].ToString();

            user.Fname = dtrow["Fname"].ToString();
            user.registrationdate = dtrow["registrationdate"].ToString();
            user.Rid = dtrow["Rid"].ToString();
            user.applyclass = dtrow["applyclass"].ToString();
            user.Fmobile = dtrow["FMobileNo"].ToString();
            user.status = dtrow["status"].ToString();
            user.stustatus = dtrow["stustatus"].ToString();
            user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString();
            details.Add(user);
        }

        return details.ToArray();
    }

    public class studentdetails
    {
        public string RowNumber { get; set; }

        public string registrationdate { get; set; }

        public string Registrationno { get; set; }

        public string name { get; set; }

        public string Fname { get; set; }

        public string Fmobile { get; set; }

        public string Rid { get; set; }

        public string applyclass { get; set; }

        public string status { get; set; }

        public string stustatus { get; set; }

        public string pagecount { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public static string chkfordiscount(string regno)
    {
        // List<classmaster> details = new List<classmaster>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select isnull(studentid,0) from DiscountedStudent_Info where registrationno='" + regno + "'", con))
            {
                con.Open();
                string chk = cmd.ExecuteScalar().ToString();
                con.Close();
                return chk;
            }
        }
    }
}