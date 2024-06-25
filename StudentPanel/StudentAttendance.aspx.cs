using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class StudentPanel_StudentAttendance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["StuRegNo"] == null)
        {
            Response.Redirect("../user-login.aspx");
        }
       
    }

    public class LectureAttendence
    {
        public string sbid { get; set; }

        public string sbName { get; set; }

        public string total { get; set; }

        public string present { get; set; }

        public string absent { get; set; }

        public string percentage { get; set; }

        public string lecid { get; set; }
    }

    [WebMethod]
    public static LectureAttendence[] BindLectureAttendence()
    {
        DataTable Dt = new DataTable();
        List<LectureAttendence> LectureAttendenceList = new List<LectureAttendence>();
        DataUtility Objdut = new DataUtility();
        int id = Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]);
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@stuRegNo", id);
        param[1] = new SqlParameter("@intresult", SqlDbType.Int);
        param[1].Direction = ParameterDirection.Output;
        Dt = Objdut.GetDataTableSP(param, "Usp_AllLectureScheduleAttendence");
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in Dt.Rows)
            {
                LectureAttendence user = new LectureAttendence();
                user.sbid = dtrow["sbid"].ToString();
                user.sbName = dtrow["sbName"].ToString();
                user.total = dtrow["total"].ToString();
                user.present = dtrow["present"].ToString();
                user.absent = dtrow["absent"].ToString();
                user.percentage = dtrow["percentage"].ToString();
                user.lecid = dtrow["lecid"].ToString();
                LectureAttendenceList.Add(user);
            }
        }
        return LectureAttendenceList.ToArray();
    }

    public class SubjectDetail
    {
        public string Data { get; set; }

        public string Time { get; set; }

        public string Topic { get; set; }

        public string status { get; set; }
    }

    [WebMethod]
    public static SubjectDetail[] BindSujectDetail(string subid)
    {
        DataTable Dt = new DataTable();
        List<SubjectDetail> SubjectDetailList = new List<SubjectDetail>();
        DataUtility Objdut = new DataUtility();
        int id = Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]);
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@stuRegNo", id);
        param[1] = new SqlParameter("@subid", subid);
        Dt = Objdut.GetDataTableSP(param, "Usp_BindSubjectDetail");
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in Dt.Rows)
            {
                SubjectDetail user = new SubjectDetail();
                user.Data = dtrow["Data"].ToString();
                user.Time = dtrow["Time"].ToString();
                user.Topic = dtrow["Topic"].ToString();
                user.status = dtrow["status"].ToString();
                SubjectDetailList.Add(user);
            }
        }
        return SubjectDetailList.ToArray();
    }

   
}