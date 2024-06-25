using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_teacher_view_timetable : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private static int fyid = 2;
    private CommonClass CommonClass = new CommonClass();

    protected void Page_Load(object sender, System.EventArgs e)
    {
        fyid = CommonClass.Scaler("ActiveAcademicYear");
        if (!IsPostBack)
        {
            BindGrid();
            BindTeacherList();
        }
    }

    protected void BindGrid()
    {
        string Query = "select eid from exam_name";
        dt = objdut.GetDataTable(Query);
        if (dt.Rows.Count > 0)
        {
            gridcreatetimetable.DataSource = dt;
            gridcreatetimetable.DataBind();
            tablecreatetimetable.Style.Add("display", "none");
        }
        dt.Dispose();
    }

    protected void BindTeacherList()
    {
        string Query = "select (title+' '+fname+' '+mname+' '+Lname) as Name,eid from tblEmp_Master";
        dt = objdut.GetDataTable(Query);
        if (dt.Rows.Count > 0)
        {
            ddlteacher.DataSource = dt;
            ddlteacher.DataTextField = "Name";
            ddlteacher.DataValueField = "eid";
            ddlteacher.DataBind();
            ddlteacher.Items.Insert(0, new ListItem("Select Teacher", "0"));
        }
        dt.Dispose();
    }

    [WebMethod]
    public static teachertimetable[] BindTeacherTimeTable(string teacherid)
    {
        DataSet ds = new DataSet();
        List<teachertimetable> details = new List<teachertimetable>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_teachertimetable]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[3];

                param[0] = new SqlParameter("@teacherid", Convert.ToInt32(teacherid));
                param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
                param[2] = new SqlParameter("@fyid", fyid);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        teachertimetable teachetdetails = new teachertimetable();
                        teachetdetails.RowNumber = dtrow["RowNumber"].ToString();
                        teachetdetails.Dayid = dtrow["Dayid"].ToString();
                        teachetdetails.Day = dtrow["Day"].ToString();
                        teachetdetails.FirstLectureClass = dtrow["FirstLectureClass"].ToString();
                        teachetdetails.FirstLectureSubject = dtrow["FirstLectureSubject"].ToString();
                        teachetdetails.SecondLectureClass = dtrow["SecondLectureClass"].ToString();
                        teachetdetails.SecondLectureSubject = dtrow["SecondLectureSubject"].ToString();
                        teachetdetails.ThirdLectureClass = dtrow["ThirdLectureClass"].ToString();
                        teachetdetails.ThirdLectureSubject = dtrow["ThirdLectureSubject"].ToString();
                        teachetdetails.FourthLectureClass = dtrow["FourthLectureClass"].ToString();
                        teachetdetails.FourthLectureSubject = dtrow["FourthLectureSubject"].ToString();
                        teachetdetails.FifthLectureClass = dtrow["FifthLectureClass"].ToString();
                        teachetdetails.FifthLectureSubject = dtrow["FifthLectureSubject"].ToString();
                        teachetdetails.SixthLectureClass = dtrow["SixthLectureClass"].ToString();
                        teachetdetails.SixthLectureSubject = dtrow["SixthLectureSubject"].ToString();
                        teachetdetails.SeventhLectureClass = dtrow["SeventhLectureClass"].ToString();
                        teachetdetails.SeventhLectureSubject = dtrow["SeventhLectureSubject"].ToString();
                        teachetdetails.EightthLectureClass = dtrow["EightthLectureClass"].ToString();
                        teachetdetails.EightthLectureSubject = dtrow["EightthLectureSubject"].ToString();
                        details.Add(teachetdetails);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class teachertimetable
    {
        public string RowNumber { get; set; }

        public string Dayid { get; set; }

        public string Day { get; set; }

        public string FirstLectureClass { get; set; }

        public string FirstLectureSubject { get; set; }

        public string SecondLectureClass { get; set; }

        public string SecondLectureSubject { get; set; }

        public string ThirdLectureClass { get; set; }

        public string ThirdLectureSubject { get; set; }

        public string FourthLectureClass { get; set; }

        public string FourthLectureSubject { get; set; }

        public string FifthLectureClass { get; set; }

        public string FifthLectureSubject { get; set; }

        public string SixthLectureClass { get; set; }

        public string SixthLectureSubject { get; set; }

        public string SeventhLectureClass { get; set; }

        public string SeventhLectureSubject { get; set; }

        public string EightthLectureClass { get; set; }

        public string EightthLectureSubject { get; set; }
    }

    [WebMethod]
    public static subjectdetails[] BindClass()
    {
        List<subjectdetails> details = new List<subjectdetails>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select id,Classname from Class_master where Status=1", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                subjectdetails subjectdetails0 = new subjectdetails();
                subjectdetails0.classid = Convert.ToInt32("0");
                subjectdetails0.classname = "Select Class";
                details.Add(subjectdetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    subjectdetails subjectdetails = new subjectdetails();
                    subjectdetails.classid = Convert.ToInt32(dtrow["id"].ToString());
                    subjectdetails.classname = dtrow["Classname"].ToString();
                    details.Add(subjectdetails);
                }
            }
        }
        return details.ToArray();
    }

    public class subjectdetails
    {
        public int classid { get; set; }

        public string classname { get; set; }
    }

    [WebMethod]
    public static Bindselected[] Bindselectedsubjectteacher(string teacherid, string lectureid, string Dayid)
    {
        List<Bindselected> detailsobj = new List<Bindselected>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select subjectid,classid,secetionid from tbl_timetablemaster where teacherid=" + Convert.ToInt32(teacherid) + " and  Lectureid=" + Convert.ToInt32(lectureid) + " and dayid=" + Convert.ToInt32(Dayid) + " and  status=1 and fyid=" + fyid + " and brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + "", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    Bindselected Bindselectedobj = new Bindselected();
                    Bindselectedobj.subjectid = Convert.ToString(dt.Rows[0]["subjectid"]);
                    Bindselectedobj.classid = Convert.ToString(dt.Rows[0]["classid"]);
                    Bindselectedobj.sectionid = Convert.ToString(dt.Rows[0]["secetionid"]);
                    detailsobj.Add(Bindselectedobj);
                }
            }
        }
        return detailsobj.ToArray();
    }

    public class Bindselected
    {
        public string subjectid { get; set; }

        public string classid { get; set; }

        public string sectionid { get; set; }
    }
}