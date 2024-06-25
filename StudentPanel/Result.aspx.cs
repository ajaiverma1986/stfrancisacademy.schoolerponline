using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.Services;

public partial class StudentPanel_Result : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
            if (Session["StuRegNo"] == null)
            {
                Response.Redirect("../user-login.aspx");
            }
      
       
    }

    public class ExamResult
    {
        public string Testname { get; set; }

        public string testdate { get; set; }

        public string SubjectName { get; set; }

        public string marks { get; set; }
    }

    [WebMethod]
    public static ExamResult[] BindExamResultList()
    {
        DataTable Dt = new DataTable();
        List<ExamResult> ExamResultList = new List<ExamResult>();
        DataUtility Objdut = new DataUtility();
        int id = Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]);
        Dt = CommonClass.rollnumber("sturesult", id);
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in Dt.Rows)
            {
                ExamResult user = new ExamResult();
                user.Testname = dtrow["Testname"].ToString();
                user.testdate = dtrow["testdate"].ToString();
                user.SubjectName = dtrow["SubjectName"].ToString();
                user.marks = dtrow["marks"].ToString();
                ExamResultList.Add(user);
            }
        }
        return ExamResultList.ToArray();
    }

  
}