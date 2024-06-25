using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class StudentPanel_StudentBatch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["StuRegNo"] == null)
        {
            Response.Redirect("../user-login.aspx");
        }
        
    }

    public class BindBatchlist
    {
        public string batchname { get; set; }

        public string joindate { get; set; }

        public string status { get; set; }

        public string LectureName { get; set; }

        public string totalschedule { get; set; }

        public string conducted { get; set; }

        public string attended { get; set; }
    }

    [WebMethod]
    public static BindBatchlist[] BindGridByJs()
    {
        DataTable Dt = new DataTable();
        List<BindBatchlist> BatchList = new List<BindBatchlist>();
        DataUtility Objdut = new DataUtility();
        int id = Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]);
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@sturegno", id);
        Dt = Objdut.GetDataTableSP(param, "Usp_BindBatchlistofstudent");
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in Dt.Rows)
            {
                BindBatchlist user = new BindBatchlist();
                user.batchname = dtrow["batchname"].ToString();
                user.joindate = dtrow["joindate"].ToString();
                user.status = dtrow["status"].ToString();
                user.LectureName = dtrow["LectureName"].ToString();
                user.totalschedule = dtrow["totalschedule"].ToString();
                user.conducted = dtrow["conducted"].ToString();
                user.attended = dtrow["attended"].ToString();
                BatchList.Add(user);
            }
        }
        return BatchList.ToArray();
    }

    public class LectureSchedule
    {
        public string time { get; set; }

        public string date { get; set; }

        public string facultyname { get; set; }

        public string SubName { get; set; }

        public string topicname { get; set; }

        public string status { get; set; }

        public string mesg { get; set; }
    }

    [WebMethod]
    public static LectureSchedule[] BindLectureSchedule()
    {
        DataTable Dt = new DataTable();
        List<LectureSchedule> BatchLectureList = new List<LectureSchedule>();
        DataUtility Objdut = new DataUtility();
        int id = Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]);
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@sturegno", id);
        param[1] = new SqlParameter("@msg", SqlDbType.VarChar, 200);
        param[1].Direction = ParameterDirection.Output;
        Dt = Objdut.GetDataTableSP(param, "Usp_BindLectureSchedule");
        string msg = Convert.ToString(param[1].Value);
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in Dt.Rows)
            {
                LectureSchedule user = new LectureSchedule();
                user.time = dtrow["time"].ToString();
                user.date = dtrow["date"].ToString();
                user.status = dtrow["status"].ToString();
                user.facultyname = dtrow["facultyname"].ToString();
                user.SubName = dtrow["SubName"].ToString();
                user.topicname = dtrow["topicname"].ToString();
                user.status = dtrow["status"].ToString();
                BatchLectureList.Add(user);
            }
        }
        if (msg != "")
        {
            LectureSchedule user = new LectureSchedule();
            user.mesg = msg;
            BatchLectureList.Add(user);
        }
        return BatchLectureList.ToArray();
    }

   
}