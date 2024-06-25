using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class HO_add_syllabus : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillBranch();
        }

        DataTable dt = new DataTable();
        dt.Columns.Add("slbid");
        dt.Columns.Add("sub_topic");
        dt.Columns.Add("topic_lecture");
        dt.Rows.Add();
        gvdetails.DataSource = dt;
        gvdetails.DataBind();
    }

    public void fillBranch()
    {
        DDlBranch.DataSource = CommonClass.Dll("BranchDll");
        DDlBranch.DataTextField = "Brname";
        DDlBranch.DataValueField = "BrId";
        DDlBranch.DataBind();

        ListItem li = new ListItem("--Select Branch--", "0");
        DDlBranch.Items.Insert(0, li);

        ListItem li1 = new ListItem("--Select Class--", "0");
        ddlClass.Items.Insert(0, li1);
    }

    public class getdesignation
    {
        public int id { get; set; }

        public string classname { get; set; }
    }

    [WebMethod]
    public static getdesignation[] getclassname(string branchid)
    {
        List<getdesignation> details = new List<getdesignation>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select Classname,id from ClassBranch_master where Status = 1 and BranchId =" + branchid, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                getdesignation objdeg = new getdesignation();
                objdeg.id = Convert.ToInt32("0");
                objdeg.classname = "-Select Class-";
                details.Add(objdeg);
                foreach (DataRow dtrow in dt.Rows)
                {
                    getdesignation objdesignation = new getdesignation();
                    objdesignation.id = Convert.ToInt32(dtrow["id"].ToString());
                    objdesignation.classname = dtrow["Classname"].ToString();
                    details.Add(objdesignation);
                }
            }
        }
        return details.ToArray();
    }

    public class getsubjectname
    {
        public int subid { get; set; }

        public string subjectname { get; set; }
    }

    [WebMethod]
    public static getsubjectname[] getsubject(string classid)
    {
        List<getsubjectname> details = new List<getsubjectname>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select subjectid,subjectname from classsubject_master where status = 1 and classid =" + classid, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                getsubjectname objdeg = new getsubjectname();
                objdeg.subid = Convert.ToInt32("0");
                objdeg.subjectname = "-Select Subject-";
                details.Add(objdeg);
                foreach (DataRow dtrow in dt.Rows)
                {
                    getsubjectname objdesignation = new getsubjectname();
                    objdesignation.subid = Convert.ToInt32(dtrow["subjectid"].ToString());
                    objdesignation.subjectname = dtrow["subjectname"].ToString();
                    details.Add(objdesignation);
                }
            }
        }
        return details.ToArray();
    }

    [WebMethod]
    public static int addsyllabus(string branchid, string classid, string subjectid, string topic)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_addmasterentry]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@subjectid", subjectid);
                cmd.Parameters.Add("@classid", classid);
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@sub_topic", topic);
                cmd.Parameters.Add("@mode", 1);
                int result = cmd.ExecuteNonQuery();
                return result;
            }
        }
    }

    [WebMethod]
    public static int updatesyllabus(string topicid, string topiclesson)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_addmasterentry]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@slbid", topicid);
                cmd.Parameters.Add("@leacture", topiclesson);
                cmd.Parameters.Add("@mode", 3);
                int result = cmd.ExecuteNonQuery();
                return result;
            }
        }
    }

    [WebMethod]
    public static getsyllabus[] gettotalsyllabus(string subjectid, string classid)
    {
        DataSet ds = new DataSet();
        List<getsyllabus> details = new List<getsyllabus>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_addmasterentry]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@subjectid", subjectid);
                cmd.Parameters.AddWithValue("@classid", classid);
                cmd.Parameters.AddWithValue("@mode", 2);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getsyllabus user = new getsyllabus();
                        user.slbid = dtrow["slbid"].ToString();
                        user.sub_topic = dtrow["sub_topic"].ToString();
                        user.topic_lecture = dtrow["topic_lecture"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getsyllabus
    {
        public string slbid { get; set; }

        public string sub_topic { get; set; }

        public string topic_lecture { get; set; }
    }

    [WebMethod]
    public static getlessonupdate[] getlessonforupdate(string topicid)
    {
        DataSet ds = new DataSet();
        List<getlessonupdate> details = new List<getlessonupdate>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_addmasterentry]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@slbid", topicid);
                cmd.Parameters.AddWithValue("@mode", 5);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getlessonupdate user = new getlessonupdate();
                        user.ctid = dtrow["ctid"].ToString();
                        user.classtopic = dtrow["classtopic"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getlessonupdate
    {
        public string ctid { get; set; }

        public string classtopic { get; set; }
    }
}