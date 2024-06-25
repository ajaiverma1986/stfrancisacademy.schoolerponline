using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class EmployeePanel_daily_work_report : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();

    private DataTable Dt;
    private static int fyid = 2;
    public string empid = "0", status = "0", payid = "0";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGrid();

            DateTime dte = DateTime.Now;

            txtdate.Text = dte.ToString("dd/MM/yyyy");
            txtdateforreport.Text = dte.ToString("dd/MM/yyyy");
            Bind_report_Grid(txtdateforreport.Text);
        }
    }

    protected void Bind_report_Grid(string date)
    {
        SqlParameter[] param = new SqlParameter[3];

        string dte = date;
        string[] Doidate = dte.Split('/');
        dte = Doidate[2] + '-' + Doidate[1] + '-' + Doidate[0];

        param[0] = new SqlParameter("@date", dte);
        param[1] = new SqlParameter("@eid", Convert.ToInt32(Session["eid"]));
        param[2] = new SqlParameter("@brid", Convert.ToInt32(Session["brbrid"]));

        DataTable dt = objdut.GetDataTableSP(param, "usp_get_emp_daily_workreport");

        if (dt.Rows.Count > 0)
        {
            divforreportgrid.Style.Add("display", "block");
            trformsg.Style.Add("display", "none");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
        {
            DataTable dt2 = new DataTable();
            DataColumn[] dtarray = new DataColumn[10];
            dtarray[0] = new DataColumn("Rownumber", typeof(int));
            dtarray[1] = new DataColumn("topiclecture", typeof(string));
            dtarray[2] = new DataColumn("Classname", typeof(string));
            dtarray[3] = new DataColumn("sectionname", typeof(string));
            dtarray[4] = new DataColumn("subjectname", typeof(string));
            dtarray[5] = new DataColumn("unitname", typeof(string));
            dtarray[6] = new DataColumn("topic", typeof(string));
            dtarray[7] = new DataColumn("classwork", typeof(string));
            dtarray[8] = new DataColumn("homework", typeof(string));
            dtarray[9] = new DataColumn("file_upload", typeof(string));
            dt2.Columns.AddRange(dtarray);
            DataRow dr = dt2.NewRow();
            dr["Rownumber"] = 1;
            dr["topiclecture"] = "Period";
            dr["Classname"] = "Classname";
            dr["sectionname"] = "sectionname";
            dr["subjectname"] = "subjectname";
            dr["unitname"] = "unitname";
            dr["topic"] = "topic";
            dr["classwork"] = "classwork";
            dr["homework"] = "homework";
            dr["file_upload"] = "file upload";
            dt2.Rows.Add(dr);
            divforreportgrid.Style.Add("display", "none");
            trformsg.Style.Add("display", "block");
            GridView1.DataSource = dt2;
            GridView1.DataBind();
        }
    }

    protected void BindGrid()
    {
        string query = "select ROW_NUMBER() OVER (ORDER BY pid) AS rownumber, pid,LectureName from timeperiod where pid not in(1,6)";
        Dt = objdut.GetDataTable(query);
        if (Dt.Rows.Count > 0)
        {
            gridmain.DataSource = Dt;
            gridmain.DataBind();
        }
    }

    [WebMethod]
    public static List<string> GetClassname(string classname)
    {
        List<string> details = new List<string>();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_get_class_info", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@classname", classname);
                cmd.Parameters.Add("@mode", "classname");
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    details.Add(string.Format("{0},{1}", reader["id"], reader["Classname"]));
                }
                con.Close();
                reader.Close();
            }
        }
        return details;
    }

    [WebMethod]
    public static List<string> GetSection(string classid, string section)
    {
        List<string> details = new List<string>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_get_class_info", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@classid", classid);
                cmd.Parameters.Add("@section", section);
                cmd.Parameters.Add("@mode", "sectionname");
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    details.Add(string.Format("{0},{1}", reader["cwsid"], reader["sectionname"]));
                }
                con.Close();
                reader.Close();
            }
        }
        return details;
    }

    [WebMethod]
    public static List<string> GetSubjectName(string classid, string subject)
    {
        List<string> details = new List<string>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_get_class_info", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@classid", classid);
                cmd.Parameters.Add("@subjectname", subject);
                cmd.Parameters.Add("@mode", "subjectname");
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    details.Add(string.Format("{0},{1}", reader["subjectid"], reader["subjectname"]));
                }
                con.Close();
                reader.Close();
            }
        }
        return details;
    }

    [WebMethod]
    public static List<string> GetUnitName(string classid, string subjectid, string unitname)
    {
        List<string> details = new List<string>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_get_class_info", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@classid", classid);
                cmd.Parameters.Add("@sujectid", subjectid);
                cmd.Parameters.Add("@unitnm", unitname);
                cmd.Parameters.Add("@brid", Convert.ToInt32(HttpContext.Current.Session["brbrid"]));
                cmd.Parameters.Add("@mode", "unitname");
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    details.Add(string.Format("{0},{1}", reader["slbid"], reader["sub_topic"]));
                }
                con.Close();
                reader.Close();
            }
        }
        return details;
    }

    [WebMethod]
    public static List<string> GetTopicName(string unitid, string topicname)
    {
        List<string> details = new List<string>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_get_class_info", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@unitid", unitid);
                cmd.Parameters.Add("@topicname", topicname);
                cmd.Parameters.Add("@mode", "topicname");
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    details.Add(string.Format("{0},{1}", reader["ctid"], reader["classtopic"]));
                }
                con.Close();
                reader.Close();
            }
        }
        return details;
    }

    //===========Function is for adding daily work report======================
    [WebMethod]
    public static int add_daily_workreport(string classid, string sectionid, string subjectid, string unitid, string unitname, string topicid, string topicname, string description, string pid, string periodname, string filename, string homework, string date, string ImageLogoByteCode)
    {
        string ImageExt = "";
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_add_empworkdailyreport", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@eid", Convert.ToInt32(HttpContext.Current.Session["eid"]));
                cmd.Parameters.Add("@brid", Convert.ToInt32(HttpContext.Current.Session["brbrid"]));
                cmd.Parameters.Add("@classid", classid);
                cmd.Parameters.Add("@sectionid", sectionid);
                cmd.Parameters.Add("@subjectid", subjectid);
                cmd.Parameters.Add("@topicid", topicid);
                cmd.Parameters.Add("@topic", topicname);
                cmd.Parameters.Add("@periodid", pid);
                cmd.Parameters.Add("@topiclectur", periodname);
                cmd.Parameters.Add("@description", description);
                cmd.Parameters.Add("@homework", homework);
                cmd.Parameters.Add("@unitid", unitid);
                cmd.Parameters.Add("@unitname", unitname);

                string dte = date;
                string[] Doidate = dte.Split('/');
                dte = Doidate[2] + '-' + Doidate[1] + '-' + Doidate[0];
                cmd.Parameters.Add("@date", dte);

                if (filename != "")
                {
                    if (ImageLogoByteCode.Contains("base64,"))
                    {
                        int IndexNo = ImageLogoByteCode.IndexOf("/") + 1;
                        int lastIndexNo = ImageLogoByteCode.IndexOf(";");
                        ImageExt = ImageLogoByteCode.Substring(IndexNo, (lastIndexNo - IndexNo));
                        int IndexNo1 = ImageLogoByteCode.IndexOf(",") + 1;
                        int Pathlength1 = ImageLogoByteCode.Length;
                        ImageLogoByteCode = ImageLogoByteCode.Substring(IndexNo1, (Pathlength1 - IndexNo1));
                    }

                    byte[] b = Convert.FromBase64String(ImageLogoByteCode);
                    MemoryStream ms = new MemoryStream(b);
                    FileStream fs = new FileStream(System.Web.Hosting.HostingEnvironment.MapPath("~/EmployeeWorkReport/") + dte + "~" + filename, FileMode.Create);
                    ms.WriteTo(fs);
                    ms.Close();
                    fs.Close();
                    fs.Dispose();

                    cmd.Parameters.Add("@file_upload", dte + "~" + filename);
                }
                else
                {
                    cmd.Parameters.Add("@file_upload", "");
                }

                cmd.Parameters.Add("@intresult", 0);
                cmd.Parameters["@intresult"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);
                con.Close();
                return result;
            }
        }
    }

    [WebMethod]
    public static employeereport[] Get_Emp_workreport(string dateforreport)
    {
        List<employeereport> details = new List<employeereport>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_get_emp_daily_workreport", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;

                string dte = dateforreport;
                string[] Doidate = dte.Split('/');
                dte = Doidate[2] + '-' + Doidate[1] + '-' + Doidate[0];

                cmd.Parameters.Add("@date", dte);
                cmd.Parameters.Add("@eid", Convert.ToInt32(HttpContext.Current.Session["eid"]));
                cmd.Parameters.Add("@brid", Convert.ToInt32(HttpContext.Current.Session["brbrid"]));

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        employeereport empreport = new employeereport();

                        empreport.Rownumber = row["Rownumber"].ToString();
                        empreport.topiclecture = row["topiclecture"].ToString();
                        empreport.Classname = row["Classname"].ToString();

                        empreport.sectionname = row["sectionname"].ToString();
                        empreport.subjectname = row["subjectname"].ToString();
                        empreport.unitname = row["unitname"].ToString();
                        empreport.topic = row["topic"].ToString();
                        empreport.classwork = row["classwork"].ToString();
                        empreport.homework = row["homework"].ToString();

                        details.Add(empreport);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class employeereport
    {
        public string Rownumber { get; set; }

        public string topiclecture { get; set; }

        public string Classname { get; set; }

        public string sectionname { get; set; }

        public string subjectname { get; set; }

        public string unitname { get; set; }

        public string topic { get; set; }

        public string classwork { get; set; }

        public string homework { get; set; }

        public string file_upload { get; set; }
    }

    protected void lnkbtnfordownload_Click(object sender, EventArgs e)
    {
        try
        {
            ImageButton lnkbtn = sender as ImageButton;
            GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
            Label lbl = (Label)GridView1.Rows[gvrow.RowIndex].FindControl("lblforfordownload");
            string filepath = lbl.Text;

            filepath = "~/EmployeeWorkReport/" + filepath;
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filepath));
            Response.WriteFile(filepath);
            Response.End();
        }
        catch (Exception ex)
        {
        }
    }
}