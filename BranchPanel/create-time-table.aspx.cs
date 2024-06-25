using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_create_time_table : System.Web.UI.Page
{
    private string qry, qry1, qry2, pname, url;
    private DataTable dt, dt2, dt3;
    private string studname = string.Empty;
    private string stuid = string.Empty;
    private SqlParameter[] param1 = new SqlParameter[6];
    private DataUtility objdut = new DataUtility();
    private static string subject = "";
    private static string strforemail = "";
    private static int send = 0;
    private static int fyid = 2;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        fyid = CommonClass.Scaler("ActiveAcademicYear");

        if (!IsPostBack)
        {
            FillClass(Convert.ToInt32(Session["BrBrid"]));
           
            Fill_Grid();
            BindMainGrid();
        }
    }

    protected void FillClass(int brid)
    {
        string Query = "select classid,Classname from ClassBranch_master where branchid=" + Session["BrBrid"] + " and status=1";
        dt = objdut.GetDataTable(Query);
        if (dt.Rows.Count > 0)
        {
            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "classname";
            ddlClass.DataValueField = "classid";
            ddlClass.DataBind();
            ddlClass.Items.Insert(0, new ListItem("Select Class", "0"));
        }
        dt.Dispose();
    }

    private void Fill_Grid()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@classid", SqlDbType.Int, 4);
        param[0].Value = 1;

        dt = objdut.GetDataTableSP(param, "[usp_classsubjectfaculty]");

        if (dt.Rows.Count > 0)
        {
            getfacultydetailswithclassandsubject.DataSource = dt;
            getfacultydetailswithclassandsubject.DataBind();
        }
        else
        {
            getfacultydetailswithclassandsubject.EmptyDataText = "No Record Found.";
            getfacultydetailswithclassandsubject.DataBind();
        }

        tablemaingridview.Style.Add("display", "none");
    }

    [WebMethod]
    public static ProductMasterDetails[] BindSection(string classid)
    {
        List<ProductMasterDetails> details = new List<ProductMasterDetails>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select cwsid,sectionname from classwithsection where classid=" + Convert.ToInt32(classid) + " and status=1 and branchid=" + HttpContext.Current.Session["BrBrid"], con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                ProductMasterDetails objProductMasterDetails0 = new ProductMasterDetails();
                objProductMasterDetails0.sectionid = Convert.ToInt32("0");
                objProductMasterDetails0.sectionname = "Select Section";
                details.Add(objProductMasterDetails0);
                foreach (DataRow dtrow in dt.Rows)
                {
                    ProductMasterDetails objProductMasterDetails = new ProductMasterDetails();
                    objProductMasterDetails.sectionid = Convert.ToInt32(dtrow["cwsid"].ToString());
                    objProductMasterDetails.sectionname = dtrow["sectionname"].ToString();
                    details.Add(objProductMasterDetails);
                }
            }
        }
        return details.ToArray();
    }

    public class ProductMasterDetails
    {
        public int sectionid { get; set; }

        public string sectionname { get; set; }
    }

    [WebMethod]
    public static Bindselected[] Bindselectedsubjectteacher(string classid, string sectionid, string lectureid, string Dayid)
    {
        List<Bindselected> detailsobj = new List<Bindselected>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select subjectid,teacherid from tbl_timetablemaster where secetionid=" + Convert.ToInt32(sectionid) + " and Lectureid=" + Convert.ToInt32(lectureid) + " and dayid=" + Convert.ToInt32(Dayid) + " and classid=" + Convert.ToInt32(classid) + " and status=1 and fyid=" + fyid + " and brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + "", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    Bindselected Bindselectedobj = new Bindselected();
                    Bindselectedobj.subjectid = Convert.ToString(dt.Rows[0]["subjectid"]);
                    Bindselectedobj.teacherid = Convert.ToString(dt.Rows[0]["teacherid"]);
                    detailsobj.Add(Bindselectedobj);
                }
            }
        }
        return detailsobj.ToArray();
    }

    public class Bindselected
    {
        public string subjectid { get; set; }

        public string teacherid { get; set; }
    }

    [WebMethod]
    public static UserDetails[] BindDatatable(string classid, string sectionid)
    {
        DataSet ds = new DataSet();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_classsubjectfaculty]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[12];

                param[0] = new SqlParameter("@classid", Convert.ToInt32(classid));
                param[1] = new SqlParameter("@sectionid", Convert.ToInt32(sectionid));
                param[2] = new SqlParameter("@Brid",HttpContext.Current.Session["BrBrid"]);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.RowNumber = dtrow["RowNumber"].ToString();
                        user.Classname = dtrow["Classname"].ToString();
                        user.subjectname = dtrow["subjectname"].ToString();
                        user.teachername = dtrow["teachername"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string RowNumber { get; set; }

        public string Classname { get; set; }

        public string subjectname { get; set; }

        public string teachername { get; set; }
    }

    protected void BindMainGrid()
    {
        string Query = "select (dayname) as Day,(wdid) as Dayid from workingdays where status=1";
        dt = objdut.GetDataTable(Query);
        if (dt.Rows.Count > 0)
        {
            gridcreatetimetable.DataSource = dt;
            gridcreatetimetable.DataBind();
            tablecreatetimetable.Style.Add("display", "none");
        }
        else
        {
            gridcreatetimetable.EmptyDataText = "No Record Found.";
            gridcreatetimetable.DataBind();
        }
    }

    //@@@@@@@@@@@@@@@@  For Binding Time Table Grid View @@@@@@@@@@@@@@@@@@@@@@
    [WebMethod]
    public static timetable[] timetablegrid(string classid, string sectionid)
    {
        DataSet ds = new DataSet();
        List<timetable> details = new List<timetable>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_fillclasstimetableforcreate]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[4];

                param[0] = new SqlParameter("@classid", Convert.ToInt32(classid));
                param[1] = new SqlParameter("@sectionid", Convert.ToInt32(sectionid));
                param[2] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
                param[3] = new SqlParameter("@fyid", fyid);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        timetable defaultdetails = new timetable();
                        defaultdetails.RowNumber = dtrow["RowNumber"].ToString();
                        defaultdetails.Dayid = dtrow["Dayid"].ToString();
                        defaultdetails.Day = dtrow["Day"].ToString();
                        defaultdetails.Assembly = dtrow["Assembly"].ToString();
                        defaultdetails.FirstLecture = dtrow["FirstLecture"].ToString();
                        defaultdetails.SecondLecture = dtrow["SecondLecture"].ToString();
                        defaultdetails.ThirdLecture = dtrow["ThirdLecture"].ToString();
                        defaultdetails.FourthLecture = dtrow["FourthLecture"].ToString();
                        defaultdetails.Lunch = dtrow["Lunch"].ToString();
                        defaultdetails.FifthLecture = dtrow["FifthLecture"].ToString();
                        defaultdetails.SixthLecture = dtrow["SixthLecture"].ToString();
                        defaultdetails.SeventhLecture = dtrow["SeventhLecture"].ToString();
                        defaultdetails.EightthLecture = dtrow["EightthLecture"].ToString();
                        details.Add(defaultdetails);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class timetable
    {
        public string RowNumber { get; set; }

        public string Dayid { get; set; }

        public string Day { get; set; }

        public string Assembly { get; set; }

        public string FirstLecture { get; set; }

        public string SecondLecture { get; set; }

        public string ThirdLecture { get; set; }

        public string FourthLecture { get; set; }

        public string Lunch { get; set; }

        public string FifthLecture { get; set; }

        public string SixthLecture { get; set; }

        public string SeventhLecture { get; set; }

        public string EightthLecture { get; set; }
    }

    //@@@@@@@@@@@@@@@ For Subject Drop Down @@@@@@@@@@@@@@@@@@@@@@@@@@@
    [WebMethod]
    public static subjectdetails[] BindSubject(string classid)
    {
        List<subjectdetails> details = new List<subjectdetails>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select subjectid,subjectname from classsubject_master where classid=" + Convert.ToInt32(classid) + " and status=1", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                subjectdetails subjectdetails0 = new subjectdetails();
                subjectdetails0.subjectid = Convert.ToInt32("0");
                subjectdetails0.subjectname = "Select Subject";
                details.Add(subjectdetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    subjectdetails subjectdetails = new subjectdetails();
                    subjectdetails.subjectid = Convert.ToInt32(dtrow["subjectid"].ToString());
                    subjectdetails.subjectname = dtrow["subjectname"].ToString();
                    details.Add(subjectdetails);
                }
            }
        }
        return details.ToArray();
    }

    public class subjectdetails
    {
        public int subjectid { get; set; }

        public string subjectname { get; set; }
    }

    //@@@@@@@@@@@@@@@@@@@@@@@@@@@@ For Teacher Drop Down @@@@@@@@@@@@@@@@@@@@@
    [WebMethod]
    public static teacherdetails[] BindTeacher(string subjectid, string classid)
    {
        List<teacherdetails> details = new List<teacherdetails>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select eid,(Title+' '+ fName+' '+mName+' '+lName)as fName from tblEmp_Master where eid in(select eid from tblTeacherSubjectMapping where subjectID=" + Convert.ToInt32(subjectid) + " and classID=" + Convert.ToInt32(classid) + " and status=1)", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                teacherdetails teacherdetail0 = new teacherdetails();
                teacherdetail0.eid = Convert.ToInt32("0");
                teacherdetail0.fName = "Select Teacher";
                details.Add(teacherdetail0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    teacherdetails teacherdetail = new teacherdetails();
                    teacherdetail.eid = Convert.ToInt32(dtrow["eid"].ToString());
                    teacherdetail.fName = dtrow["fName"].ToString();
                    details.Add(teacherdetail);
                }
            }
        }
        return details.ToArray();
    }

    public class teacherdetails
    {
        public int eid { get; set; }

        public string fName { get; set; }
    }

    [WebMethod]
    public static int InsertTimeTable(string classid, string sectionid, string subjectid, string teacherid, string wdid, string lectureid, string mode)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_CreateTimeTable", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[11];

                param[0] = new SqlParameter("@classid", Convert.ToInt32(classid));
                param[1] = new SqlParameter("@sectionid", Convert.ToInt32(sectionid));

                param[2] = new SqlParameter("@subjectid", Convert.ToInt32(subjectid));

                param[3] = new SqlParameter("@teacherid", Convert.ToInt32(teacherid));

                param[4] = new SqlParameter("@dayid", Convert.ToInt32(wdid));

                param[5] = new SqlParameter("@fyid", fyid);

                param[6] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));

                param[7] = new SqlParameter("@Lectureid", Convert.ToInt32(lectureid));

                param[8] = new SqlParameter("@mode", Convert.ToInt32(mode));

                param[9] = new SqlParameter("@intresult", SqlDbType.Int);
                param[9].Direction = ParameterDirection.Output;

                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);

                cmd.Parameters.Add(param[3]);

                cmd.Parameters.Add(param[4]);

                cmd.Parameters.Add(param[5]);

                cmd.Parameters.Add(param[6]);

                cmd.Parameters.Add(param[7]);
                cmd.Parameters.Add(param[8]);
                cmd.Parameters.Add(param[9]);

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }
}