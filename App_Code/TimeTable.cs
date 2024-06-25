using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;

/// <summary>
/// Summary description for TimeTable
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
[System.Web.Script.Services.ScriptService]
public class TimeTable : System.Web.Services.WebService
{
    public TimeTable()
    {
        //Uncomment the following line if using designed components
        //InitializeComponent();
    }

    [WebMethod]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = System.Web.Script.Services.ResponseFormat.Json)]
    public string[] GetCourseName(string prefix)
    {
        List<string> customers = new List<string>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                string sr = "select adno,name from tbl_Library_card_Master where name like @SearchText + '%'";
                cmd.CommandText = sr;
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Connection = con;
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}-{1}", sdr["name"], sdr["adno"]));
                    }
                }
                con.Close();
            }
            return customers.ToArray();
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string[] GetTeacher(string prefix, int classid, int brid, int subjectid)
    {
        List<string> customers = new List<string>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select eid,UPPER((fname+' '+ISNULL(MName,'')+' '+lname))as fname from tblEmp_Master where desigtype=2 and status=1 " +
                                  "and brid=" + brid + " and eid in (select eid from tblTeacherSubjectMapping where status=1 and brid=" + brid + " and classid=" + classid + " and subjectID=" + subjectid + ") " +
                                  " and fName like  @SearchText +'%'";
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Connection = con;
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}-{1}", sdr["fname"], sdr["eid"]));
                    }
                }
                con.Close();
            }
            return customers.ToArray();
        }
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string[] GetSubject(string prefix, int classid)
    {
        List<string> customers = new List<string>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = "select subjectname,subjectid from classsubject_master where status=1 and classid=" + classid + "" +
                                  " and SubjectName like @searchtext +'%'";
                cmd.Parameters.AddWithValue("@SearchText", prefix);
                cmd.Connection = con;
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}-{1}", sdr["SubjectName"], sdr["Subjectid"]));
                    }
                }
                con.Close();
            }
            return customers.ToArray();
        }
    }

    [WebMethod]
    public string[] getstudentdashboard(string prefix, int brid)
    {
        List<string> customers = new List<string>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
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
    public string[] admissionsearch(string prefix, int brid)
    {
        List<string> customers = new List<string>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "usp_search_student";
                cmd.Parameters.AddWithValue("@character1", prefix);
                cmd.Parameters.AddWithValue("@brid", brid);
                cmd.Connection = con;
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}", sdr["adno"]));
                    }
                }
                con.Close();
            }
            return customers.ToArray();
        }
    }
    [WebMethod]
    public string[] searchlibrarycard(string prefix, int brid)
    {
        List<string> customers = new List<string>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "usp_search_libcode";
                cmd.Parameters.AddWithValue("@character1", prefix);
                cmd.Parameters.AddWithValue("@brid", brid);
                cmd.Connection = con;
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}", sdr["LibraryCode"]));
                    }
                }
                con.Close();
            }
            return customers.ToArray();
        }
    }

    [WebMethod]
    public string[] searchclass(string prefix, int brid)
    {
        List<string> customers = new List<string>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.CommandText = "usp_search_class";
                cmd.Parameters.AddWithValue("@character1", prefix);
                cmd.Parameters.AddWithValue("@brid", brid);
                cmd.Connection = con;
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(string.Format("{0}-{1}", sdr["Classname"], sdr["classid"]));
                    }
                }
                con.Close();
            }
            return customers.ToArray();
        }
    }
}