using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_default_view_timetable : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private static int fyid = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fyid = CommonClass.Scaler("ActiveAcademicYear");
            BindDayList();
        }
    }

    protected void BindGrid()
    {
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@dayid", Convert.ToInt32(ddlday.SelectedValue));
        param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        param[2] = new SqlParameter("@fyid", fyid);
        dt = objdut.GetDataTableSP(param, "[usp_default_timetable]");
        if (dt.Rows.Count > 0)
        {
            gridtimetabledetails.DataSource = dt;
            gridtimetabledetails.DataBind();
        }
        dt.Dispose();
    }

    protected void BindDayList()
    {
        string Query = "select wdid,dayname from workingdays where status=1 order by wdid asc";
        dt = objdut.GetDataTable(Query);
        if (dt.Rows.Count > 0)
        {
            ddlday.DataSource = dt;
            ddlday.DataTextField = "dayname";
            ddlday.DataValueField = "wdid";
            ddlday.DataBind();
            ddlday.Items.Insert(0, new ListItem("Select Day", "0"));
            setCurrentDay();
            BindGrid();
        }
        dt.Dispose();
    }

    protected void setCurrentDay()
    {
        string day = DateTime.Now.DayOfWeek.ToString();
        if (day == "Monday")
        {
            ddlday.SelectedValue = "1";
        }
        else if (day == "Tuesday")
        {
            ddlday.SelectedValue = "2";
        }
        else if (day == "Wednesday")
        {
            ddlday.SelectedValue = "3";
        }
        else if (day == "Thursday")
        {
            ddlday.SelectedValue = "4";
        }
        else if (day == "Friday")
        {
            ddlday.SelectedValue = "5";
        }
        else if (day == "Saturday")
        {
            ddlday.SelectedValue = "6";
        }
    }

    [WebMethod]
    public static defaulttimetable[] BindDefaultGrid(string dayid)
    {
        DataSet ds = new DataSet();
        List<defaulttimetable> details = new List<defaulttimetable>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_default_timetable]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[3];

                param[0] = new SqlParameter("@dayid", Convert.ToInt32(dayid));
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
                        defaulttimetable defaultdetails = new defaulttimetable();

                        defaultdetails.Rownumber = dtrow["RowNumber"].ToString();

                        defaultdetails.Lectureid = dtrow["Lectureid"].ToString();

                        defaultdetails.LectureName = dtrow["LectureName"].ToString();

                        defaultdetails.Fromtime = dtrow["Fromtime"].ToString();

                        defaultdetails.Totime = dtrow["Totime"].ToString();

                        defaultdetails.Lkgsubjectseca = dtrow["Lkgsubjectseca"].ToString();

                        defaultdetails.Lkgteacherseca = dtrow["Lkgteacherseca"].ToString();

                        defaultdetails.Lkgsubjectsecb = dtrow["Lkgsubjectsecb"].ToString();

                        defaultdetails.Lkgteachersecb = dtrow["Lkgteachersecb"].ToString();

                        defaultdetails.Lkgsubjectsecc = dtrow["Lkgsubjectsecc"].ToString();

                        defaultdetails.Lkgteachersecc = dtrow["Lkgteachersecc"].ToString();

                        defaultdetails.Ukgsubjectseca = dtrow["Ukgsubjectseca"].ToString();

                        defaultdetails.Ukgteacherseca = dtrow["Ukgteacherseca"].ToString();

                        defaultdetails.Ukgsubjectsecb = dtrow["Ukgsubjectsecb"].ToString();

                        defaultdetails.Ukgteachersecb = dtrow["Ukgteachersecb"].ToString();

                        defaultdetails.Ukgsubjectsecc = dtrow["Ukgsubjectsecc"].ToString();

                        defaultdetails.Ukgteachersecc = dtrow["Ukgteachersecc"].ToString();

                        defaultdetails.firstsubjectseca = dtrow["firstsubjectseca"].ToString();

                        defaultdetails.firstteacherseca = dtrow["firstteacherseca"].ToString();

                        defaultdetails.firstsubjectsecb = dtrow["firstsubjectsecb"].ToString();

                        defaultdetails.firstteachersecb = dtrow["firstteachersecb"].ToString();

                        defaultdetails.firstsubjectsecc = dtrow["firstsubjectsecc"].ToString();

                        defaultdetails.firstteachersecc = dtrow["firstteachersecc"].ToString();

                        defaultdetails.secondsubjectaseca = dtrow["secondsubjectaseca"].ToString();

                        defaultdetails.secondteacheraseca = dtrow["secondteacheraseca"].ToString();

                        defaultdetails.secondsubjectsecb = dtrow["secondsubjectsecb"].ToString();

                        defaultdetails.secondteachersecb = dtrow["secondteachersecb"].ToString();

                        defaultdetails.secondsubjectsecc = dtrow["secondsubjectsecc"].ToString();

                        defaultdetails.secondteachersecc = dtrow["secondteachersecc"].ToString();

                        defaultdetails.thirdsubjectseca = dtrow["thirdsubjectseca"].ToString();

                        defaultdetails.thirdteacherseca = dtrow["thirdteacherseca"].ToString();

                        defaultdetails.thirdsubjectsecb = dtrow["thirdsubjectsecb"].ToString();

                        defaultdetails.thirdteachersecb = dtrow["thirdteachersecb"].ToString();

                        defaultdetails.thirdsubjectsecc = dtrow["thirdsubjectsecc"].ToString();

                        defaultdetails.thirdteachersecc = dtrow["thirdteachersecc"].ToString();

                        defaultdetails.forthsubjectseca = dtrow["forthsubjectseca"].ToString();

                        defaultdetails.forthteacherseca = dtrow["forthteacherseca"].ToString();

                        defaultdetails.forthsubjectsecb = dtrow["forthsubjectsecb"].ToString();

                        defaultdetails.forthteachersecb = dtrow["forthteachersecb"].ToString();

                        defaultdetails.forthsubjectsecc = dtrow["forthsubjectsecc"].ToString();

                        defaultdetails.forthteachersecc = dtrow["forthteachersecc"].ToString();

                        defaultdetails.fifthsubjectseca = dtrow["fifthsubjectseca"].ToString();

                        defaultdetails.fifthteacherseca = dtrow["fifthteacherseca"].ToString();

                        defaultdetails.fifthsubjectsecb = dtrow["fifthsubjectsecb"].ToString();

                        defaultdetails.fifthteachersecb = dtrow["fifthteachersecb"].ToString();

                        defaultdetails.fifthsubjectsecc = dtrow["fifthsubjectsecc"].ToString();

                        defaultdetails.fifthteachersecc = dtrow["fifthteachersecc"].ToString();

                        defaultdetails.sixsubjectseca = dtrow["sixsubjectseca"].ToString();

                        defaultdetails.sixteacherseca = dtrow["sixteacherseca"].ToString();

                        defaultdetails.sixsubjectsecb = dtrow["sixsubjectsecb"].ToString();

                        defaultdetails.sixteachersecb = dtrow["sixteachersecb"].ToString();

                        defaultdetails.sixsubjectsecc = dtrow["sixsubjectsecc"].ToString();

                        defaultdetails.sixteachersecc = dtrow["sixteachersecc"].ToString();

                        defaultdetails.sevensubjectseca = dtrow["sevensubjectseca"].ToString();

                        defaultdetails.seventeacherseca = dtrow["seventeacherseca"].ToString();

                        defaultdetails.sevensubjectsecb = dtrow["sevensubjectsecb"].ToString();

                        defaultdetails.seventeachersecb = dtrow["seventeachersecb"].ToString();

                        defaultdetails.sevensubjectsecc = dtrow["sevensubjectsecc"].ToString();

                        defaultdetails.seventeachersecc = dtrow["seventeachersecc"].ToString();

                        defaultdetails.eightsubjectseca = dtrow["eightsubjectseca"].ToString();

                        defaultdetails.eightteacherseca = dtrow["eightteacherseca"].ToString();

                        defaultdetails.eightsubjectsecb = dtrow["eightsubjectsecb"].ToString();

                        defaultdetails.eightteachersecb = dtrow["eightteachersecb"].ToString();

                        defaultdetails.eightsubjectsecc = dtrow["eightsubjectsecc"].ToString();

                        defaultdetails.eightteachersecc = dtrow["eightteachersecc"].ToString();

                        defaultdetails.ninesubjectseca = dtrow["ninesubjectseca"].ToString();

                        defaultdetails.nineteacherseca = dtrow["nineteacherseca"].ToString();

                        defaultdetails.ninesubjectsecb = dtrow["ninesubjectsecb"].ToString();

                        defaultdetails.nineteachersecb = dtrow["nineteachersecb"].ToString();

                        defaultdetails.ninesubjectsecc = dtrow["ninesubjectsecc"].ToString();

                        defaultdetails.nineteachersecc = dtrow["nineteachersecc"].ToString();

                        defaultdetails.tensubjectseca = dtrow["tensubjectseca"].ToString();

                        defaultdetails.tenteacherseca = dtrow["tenteacherseca"].ToString();

                        defaultdetails.tensubjectsecb = dtrow["tensubjectsecb"].ToString();

                        defaultdetails.tenteachersecb = dtrow["tenteachersecb"].ToString();

                        defaultdetails.tensubjectsecc = dtrow["tensubjectsecc"].ToString();

                        defaultdetails.tenteachersecc = dtrow["tenteachersecc"].ToString();

                        details.Add(defaultdetails);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class defaulttimetable
    {
        public string Rownumber { get; set; }

        public string Lectureid { get; set; }

        public string LectureName { get; set; }

        public string Fromtime { get; set; }

        public string Totime { get; set; }

        public string Lkgsubjectseca { get; set; }

        public string Lkgteacherseca { get; set; }

        public string Lkgsubjectsecb { get; set; }

        public string Lkgteachersecb { get; set; }

        public string Lkgsubjectsecc { get; set; }

        public string Lkgteachersecc { get; set; }

        public string Ukgsubjectseca { get; set; }

        public string Ukgteacherseca { get; set; }

        public string Ukgsubjectsecb { get; set; }

        public string Ukgteachersecb { get; set; }

        public string Ukgsubjectsecc { get; set; }

        public string Ukgteachersecc { get; set; }

        public string firstsubjectseca { get; set; }

        public string firstteacherseca { get; set; }

        public string firstsubjectsecb { get; set; }

        public string firstteachersecb { get; set; }

        public string firstsubjectsecc { get; set; }

        public string firstteachersecc { get; set; }

        public string secondsubjectaseca { get; set; }

        public string secondteacheraseca { get; set; }

        public string secondsubjectsecb { get; set; }

        public string secondteachersecb { get; set; }

        public string secondsubjectsecc { get; set; }

        public string secondteachersecc { get; set; }

        public string thirdsubjectseca { get; set; }

        public string thirdteacherseca { get; set; }

        public string thirdsubjectsecb { get; set; }

        public string thirdteachersecb { get; set; }

        public string thirdsubjectsecc { get; set; }

        public string thirdteachersecc { get; set; }

        public string forthsubjectseca { get; set; }

        public string forthteacherseca { get; set; }

        public string forthsubjectsecb { get; set; }

        public string forthteachersecb { get; set; }

        public string forthsubjectsecc { get; set; }

        public string forthteachersecc { get; set; }

        public string fifthsubjectseca { get; set; }

        public string fifthteacherseca { get; set; }

        public string fifthsubjectsecb { get; set; }

        public string fifthteachersecb { get; set; }

        public string fifthsubjectsecc { get; set; }

        public string fifthteachersecc { get; set; }

        public string sixsubjectseca { get; set; }

        public string sixteacherseca { get; set; }

        public string sixsubjectsecb { get; set; }

        public string sixteachersecb { get; set; }

        public string sixsubjectsecc { get; set; }

        public string sixteachersecc { get; set; }

        public string sevensubjectseca { get; set; }

        public string seventeacherseca { get; set; }

        public string sevensubjectsecb { get; set; }

        public string seventeachersecb { get; set; }

        public string sevensubjectsecc { get; set; }

        public string seventeachersecc { get; set; }

        public string eightsubjectseca { get; set; }

        public string eightteacherseca { get; set; }

        public string eightsubjectsecb { get; set; }

        public string eightteachersecb { get; set; }

        public string eightsubjectsecc { get; set; }

        public string eightteachersecc { get; set; }

        public string ninesubjectseca { get; set; }

        public string nineteacherseca { get; set; }

        public string ninesubjectsecb { get; set; }

        public string nineteachersecb { get; set; }

        public string ninesubjectsecc { get; set; }

        public string nineteachersecc { get; set; }

        public string tensubjectseca { get; set; }

        public string tenteacherseca { get; set; }

        public string tensubjectsecb { get; set; }

        public string tenteachersecb { get; set; }

        public string tensubjectsecc { get; set; }

        public string tenteachersecc { get; set; }
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
    public static int InsertTimeTable(string classid, string sectionid, string subjectid, string teacherid, string dayid, string lectureid, string mode, string updatemode)
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

                param[4] = new SqlParameter("@dayid", Convert.ToInt32(dayid));

                param[5] = new SqlParameter("@fyid", fyid);

                param[6] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));

                param[7] = new SqlParameter("@Lectureid", Convert.ToInt32(lectureid));

                param[8] = new SqlParameter("@mode", Convert.ToInt32(mode));

                param[9] = new SqlParameter("@intresult", SqlDbType.Int);
                param[9].Direction = ParameterDirection.Output;

                param[10] = new SqlParameter("@updatemode", Convert.ToInt32(updatemode));

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
                cmd.Parameters.Add(param[10]);
                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }

    [WebMethod]
    public static Bindselected[] Bindselectedsubjectteacher(string classid, string sectionid, string lectureid, string Dayid)
    {
        List<Bindselected> detailsobj = new List<Bindselected>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select TempSubJectId,TempTeacherID,TempStatus,subjectid,teacherid from tbl_timetablemaster where secetionid=" + Convert.ToInt32(sectionid) + " and Lectureid=" + Convert.ToInt32(lectureid) + " and dayid=" + Convert.ToInt32(Dayid) + " and classid=" + Convert.ToInt32(classid) + " and status=1 and fyid=" + fyid + " and brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + "", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    Bindselected Bindselectedobj = new Bindselected();

                    if (Convert.ToString(dt.Rows[0]["TempStatus"]) == "0")
                    {
                        Bindselectedobj.subjectid = Convert.ToString(dt.Rows[0]["subjectid"]);
                        Bindselectedobj.teacherid = Convert.ToString(dt.Rows[0]["teacherid"]);
                    }
                    else
                    {
                        Bindselectedobj.subjectid = Convert.ToString(dt.Rows[0]["TempSubJectId"]);
                        Bindselectedobj.teacherid = Convert.ToString(dt.Rows[0]["TempTeacherID"]);
                    }

                    cmd.CommandText = "select count(status) as status from EmpAttendance_Master where Date=Convert(date,getutcdate()) and eid=" + Convert.ToInt32(Bindselectedobj.teacherid) + " and status=1";
                    Bindselectedobj.attendstatus = Convert.ToInt32(cmd.ExecuteScalar());
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

        public int attendstatus { get; set; }
    }
}