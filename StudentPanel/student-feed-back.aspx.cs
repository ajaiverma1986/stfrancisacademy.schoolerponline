using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class StudentPanel_student_feed_back : System.Web.UI.Page
{
    private DataTable dt1 = new DataTable();
    private DataUtility objdut = new DataUtility();
    private DataUtility OBJDut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString.Count == 0)
        {
            if (Session["StuRegNo"] == null)
            {
                Response.Redirect("../user-login.aspx");
            }
        }
        else
        {
            HtmlAnchor lbLogOut = (HtmlAnchor)this.Master.FindControl("lbLogOut");
            lbLogOut.Visible = false;
        }
        if (Request.QueryString.Count > 0)
        {
            if (!IsPostBack)
            {
                spanatotalsubmitedfeedback.InnerText = Convert.ToString(OBJDut.GetScalar("select count(Sturegno) from tbl_StudentsFeddback where Status=1 and StuRegNo=" + Request.QueryString[0] + " "));
            }
        }
        else
        {
            if (!IsPostBack)
            {
                spanatotalsubmitedfeedback.InnerText = Convert.ToString(OBJDut.GetScalar("select count(Sturegno) from tbl_StudentsFeddback where Status=1 and StuRegNo=" + Session["StuRegNo"] + " "));
            }
        }
    }

  

    [WebMethod]
    public static getcourse[] bindTeacher(int StuRegNo)
    {
        List<getcourse> Details = new List<getcourse>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 1);
        if (StuRegNo == 0)
            param[1] = new SqlParameter("@StuRegNo", HttpContext.Current.Session["StuRegNo"]);
        else
            param[1] = new SqlParameter("@StuRegNo", StuRegNo);
        Dt = Objdut.GetDataTableSP(param, "[Usp_Add_AllFeddbackDetails]");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                getcourse obje = new getcourse();
                obje.facultyid = Convert.ToInt32(Dt.Rows[i]["FacultyId"]);
                obje.name = Convert.ToString(Dt.Rows[i]["name"]);
                Details.Add(obje);
            }
        }
        Dt.Dispose();
        return Details.ToArray();
    }




    public class getcourse
    {
        public int facultyid { get; set; }

        public string name { get; set; }
    }

    [WebMethod]
    public static BindFeedbackType[] BindGridByJs(int ddlvalue = 0)
    {
        List<BindFeedbackType> Feedback = new List<BindFeedbackType>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            string Query = "select FeedbackTypeid,FeedbackTypeName from tbl_FeedbackType where status=1 and feedbacktypes=" + ddlvalue;
            using (SqlCommand cmd = new SqlCommand(Query, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    BindFeedbackType FeedbackType = new BindFeedbackType();
                    FeedbackType.FeedbackTypeid = Convert.ToInt32(dtrow["FeedbackTypeid"].ToString());
                    FeedbackType.FeedbackTypeName = dtrow["FeedbackTypeName"].ToString();
                    Feedback.Add(FeedbackType);
                }
            }
        }
        return Feedback.ToArray();
    }

    public class BindFeedbackType
    {
        public int FeedbackTypeid { get; set; }

        public string FeedbackTypeName { get; set; }
    }

    [WebMethod]
    public static int SubmitFeedbackStudentDetails(string Feedback_typeid, string feedbackSubject, string FeedbackDescription, int TeacherId, string TeacherName, string Status, string TeacherScore, int StuRegNo)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[10];
        param[0] = new SqlParameter("@Feedback_typeid", Convert.ToString(Feedback_typeid));
        param[1] = new SqlParameter("@feedbackContents", feedbackSubject.Replace(">", "'"));
        if (StuRegNo == 0)
            param[2] = new SqlParameter("@StuRegNo", Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]));
        else
            param[2] = new SqlParameter("@StuRegNo", StuRegNo);
        param[3] = new SqlParameter("@FeedbackDescription", FeedbackDescription.Replace(">", "'"));
        param[5] = new SqlParameter("@FacultyId", TeacherId);
        param[4] = new SqlParameter("@TeacherName", TeacherName);
        param[6] = new SqlParameter("@Status", Status);
        param[7] = new SqlParameter("@TeacherScore", TeacherScore);
        param[8] = new SqlParameter("@intresult", SqlDbType.Int);
        param[8].Direction = ParameterDirection.Output;
        param[9] = new SqlParameter("@mode", 3);
        int result = objdut.ExecuteSqlSP(param, "usp_Add_AllFeddbackDetails");
        return result;
    }
}