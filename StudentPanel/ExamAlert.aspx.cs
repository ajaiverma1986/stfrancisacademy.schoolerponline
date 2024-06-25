using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class StudentPanel_ExamAlert : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
            if (Session["StuRegNo"] == null)
            {
                Response.Redirect("../user-login.aspx");
            }
       
       
    }

    public class ExamAlert
    {
        public string Testname { get; set; }

        public string testdate { get; set; }

        public string subname { get; set; }

        public string topic { get; set; }

        public string testtime1 { get; set; }

        public string testtime2 { get; set; }
    }

    [WebMethod]
    public static ExamAlert[] BindExamList()
    {
        DataSet Ds = new DataSet();
        List<ExamAlert> LectureAttendenceList = new List<ExamAlert>();
        DataUtility Objdut = new DataUtility();
        int id = Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]);
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@sturegno", id);
        Ds = Objdut.GetDataSetSP(param, "Usp_BindExamAlertList");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ExamAlert user = new ExamAlert();
                user.Testname = dtrow["Testname"].ToString();
                user.testdate = dtrow["testdate"].ToString();
                user.subname = dtrow["subname"].ToString();
                user.topic = dtrow["topic"].ToString();
                user.testtime1 = dtrow["testtime1"].ToString();
                user.testtime2 = dtrow["testtime2"].ToString();
                LectureAttendenceList.Add(user);
            }
        }
        return LectureAttendenceList.ToArray();
    }

   
}