using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class StudentPanel_my_test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["StuRegNo"] == null)
        {
            Response.Redirect("../user-login.aspx");
        }
    }

    [WebMethod]
    public static string check_Online()
    {
        string str = "";
        if (Convert.ToString(HttpContext.Current.Session["RID"]) != "")
        {
            DataUtility_SH Obj_SH = new DataUtility_SH();
            str = Convert.ToString(Obj_SH.GetScalar("Select ISNULL(EXAMMODE,0) from tbl_StudentRegistration sr " +
                         " inner join Class_Master cm on sr.ApplyingForClass = cm.id " +
                         "where sr.RID=" + HttpContext.Current.Session["RID"] + " and Sr.Brid=" + HttpContext.Current.Session["Brid_SH"] + ""));
        }
        else {
            str = "0";
        }
        return str;
    }

    [WebMethod]
    public static string GetGridData(string Examid, string Mode)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@ExamId", Examid);
        param[1] = new SqlParameter("@Mode", Mode);      
        DataTable Dt = Objdut.GetDataTableSP(param, "[Usp_BindExamList]");
        return (Dt.Rows[0]["AllDataForBind"].ToString());
    }

    [WebMethod]
    public static BinAppearedStudentList[] BindGrid(string Examid)
    {
        DataSet Ds = new DataSet();
        List<BinAppearedStudentList> StudentList = new List<BinAppearedStudentList>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@Sturegno", HttpContext.Current.Session["StuRegNo"]);
        param[1] = new SqlParameter("@Examid", Examid);
        Ds = Objdut.GetDataSetSP(param, "[usp_AppearedStudentList]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow Dtrow in Ds.Tables[0].Rows)
            {
                BinAppearedStudentList user = new BinAppearedStudentList();
                user.RowNumber = Dtrow["RowNumber"].ToString();
                user.Sturegno = Dtrow["Sturegno"].ToString();
                user.StudentName = Dtrow["StudentName"].ToString();
                user.Course = Dtrow["Course"].ToString();
                user.ExamName = Dtrow["ExamName"].ToString();
                user.Rank = Dtrow["Rank"].ToString();
                user.Details = Dtrow["ImageUrl"].ToString();
                user.ExamId = Dtrow["ExamId"].ToString();
                user.TotalQuestion = Dtrow["TotalQuestion"].ToString();
                user.TotalRight = Dtrow["TotalRight"].ToString();
                user.TotalWrong = Dtrow["TotalWrong"].ToString();
                user.TotalBlank = Dtrow["TotalBlank"].ToString();
                user.TotalMarks = Dtrow["TotalMarks"].ToString();
                user.Percentage = Dtrow["Percentage"].ToString();
                StudentList.Add(user);
            }
        }
        return StudentList.ToArray();
    }

    public class BinAppearedStudentList
    {
        public string RowNumber { get; set; }

        public string Sturegno { get; set; }

        public string StudentName { get; set; }

        public string Course { get; set; }

        public string ExamName { get; set; }

        public string Rank { get; set; }

        public string Details { get; set; }

        public string ExamId { get; set; }

        public string TotalQuestion { get; set; }

        public string TotalRight { get; set; }

        public string TotalWrong { get; set; }

        public string TotalBlank { get; set; }

        public string TotalMarks { get; set; }

        public string Percentage { get; set; }
    }

    [WebMethod]
    public static BinModuleList[] BindGridForDetails(string Sturegno, string Examid)
    {
        DataSet Ds = new DataSet();
        List<BinModuleList> ModuleList = new List<BinModuleList>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@Sturegno", Sturegno);
        param[1] = new SqlParameter("@Examid", Examid);
        Ds = Objdut.GetDataSetSP(param, "[usp_AppearedStudentModuleListExamWise]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow Dtrow in Ds.Tables[0].Rows)
            {
                BinModuleList user = new BinModuleList();
                user.RowNumber = Dtrow["RowNumber"].ToString();
                user.ModuleName = Dtrow["module_name"].ToString();
                user.ModuleId = Dtrow["ModuleId"].ToString();
                user.TotalQuestion = Dtrow["TotalQuestion"].ToString();
                user.TotalRight = Dtrow["TotalRight"].ToString();
                user.TotalWrong = Dtrow["TotalWrong"].ToString();
                user.TotalBlank = Dtrow["TotalBlank"].ToString();
                user.TotalMarks = Dtrow["TotalMarks"].ToString();
                user.Percentage = Dtrow["Percentage"].ToString();
                user.Rank = Dtrow["Rank"].ToString();
                ModuleList.Add(user);
            }
        }
        return ModuleList.ToArray();
    }

    public class BinModuleList
    {
        public string RowNumber { get; set; }

        public string ModuleName { get; set; }

        public string ModuleId { get; set; }

        public string TotalQuestion { get; set; }

        public string TotalRight { get; set; }

        public string TotalWrong { get; set; }

        public string TotalBlank { get; set; }

        public string TotalMarks { get; set; }

        public string Percentage { get; set; }

        public string Rank { get; set; }
    }

    [WebMethod]
    public static GetPastExamDetails[] BindPastGridByJs()
    {
        DataSet Ds = new DataSet();
        List<GetPastExamDetails> ExamDetails = new List<GetPastExamDetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@sturegno", HttpContext.Current.Session["StuRegNo"]);
        Ds = Objdut.GetDataSetSP(param, "[Usp_GetPastExamList]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                GetPastExamDetails user = new GetPastExamDetails();
                user.RowNumber = dtrow["RowNumber"].ToString();
                user.exam_id = dtrow["exam_id"].ToString();
                user.exam_name = dtrow["exam_name"].ToString();
                user.ModuleName = dtrow["ModuleName"].ToString();
                user.DateAndTime = dtrow["DateAndTime"].ToString();
                ExamDetails.Add(user);
            }
        }
        return ExamDetails.ToArray();
    }

    public class GetPastExamDetails
    {
        public string RowNumber { get; set; }

        public string exam_id { get; set; }

        public string exam_name { get; set; }

        public string ModuleName { get; set; }

        public string DateAndTime { get; set; }
    }

    [WebMethod]
    public static GetExamDetails[] BindGridByJs()
    {
        DataSet Ds = new DataSet();
        List<GetExamDetails> ExamDetails = new List<GetExamDetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@sturegno", HttpContext.Current.Session["StuRegNo"]);
        Ds = Objdut.GetDataSetSP(param, "[Usp_GetExamList]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                GetExamDetails user = new GetExamDetails();
                user.RowNumber = dtrow["RowNumber"].ToString();
                user.exam_id = dtrow["exam_id"].ToString();
                user.exam_name = dtrow["exam_name"].ToString();
                user.ModuleName = dtrow["ModuleName"].ToString();
                user.DateAndTime = dtrow["DateAndTime"].ToString();
                ExamDetails.Add(user);
            }
        }
        return ExamDetails.ToArray();
    }

    public class GetExamDetails
    {
        public string RowNumber { get; set; }

        public string exam_id { get; set; }

        public string exam_name { get; set; }

        public string ModuleName { get; set; }

        public string DateAndTime { get; set; }
    }

    [WebMethod]
    public static int FillSession(string Examid)
    {
        string Query = @"select Count(1) from tbl_Onlineexammaster where Convert(Time,DATEADD(MINUTE, 330,GetUTCDATE())) >= exam_from_time
and Convert(Time,DATEADD(MINUTE, 330,GetUTCDATE()))<= exam_to_time and status=1
and Convert(Date,GETDATE()) >= exam_from_date and Convert(Date,GETDATE())<= exam_to_date  and exam_id=" + Examid;
        DataUtility Objdut = new DataUtility();
        int IsActiveExam = Convert.ToInt32(Objdut.GetScalar(Query));
        if (Convert.ToInt32(IsActiveExam) == 0)
        {
            Query = @"select Count(1) from tbl_Onlineexammaster where status=1 and is_time_boundry=0
            and Convert(Date,GETDATE()) Between exam_from_date and exam_to_date  and exam_id=" + Examid;
            Objdut = new DataUtility();
            IsActiveExam = Convert.ToInt32(Objdut.GetScalar(Query));
        }
        if (Convert.ToInt32(Examid) != 0 && IsActiveExam == 1)
        {
            HttpContext.Current.Session["Examid"] = Examid;
            return (1);
        }
        else
        {
            return (IsActiveExam);
        }
    }

    [WebMethod]
    public static int CheckExamGivenOrNot(string Examid)
    {
        string Query = @"select Count(1) from [tbl_Studentonlineexammaster] where Exam_Status=1 and Sturegno=" + Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]) + " and           isnull(is_Done,0)=1 and Exam_id=" + Examid;
        DataUtility Objdut = new DataUtility();
        int IsExamGiven = Convert.ToInt32(Objdut.GetScalar(Query));
        if (Convert.ToInt32(Examid) != 0 && IsExamGiven == 1)
        {
            return (1);
        }
        else
        {
            return (IsExamGiven);
        }
    }

    [WebMethod]
    public static string BindQuestion()
    {
        DataSet Ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_GetQuestionListExamWise]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Examid", Convert.ToInt32(HttpContext.Current.Session["Examid"]));
                param[1] = new SqlParameter("@StuRegNo", Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]));
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                SqlDataAdapter Da = new SqlDataAdapter(cmd);
                Da.Fill(Ds);
            }
        }
        return Ds.GetXml().ToString();
    }

    [WebMethod]
    public static string BindGeneralDetails()
    {
        DataSet Ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_GetGeneralDetails]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Examid", Convert.ToInt32(HttpContext.Current.Session["Examid"]));
                param[1] = new SqlParameter("@StuRegNo", Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]));
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                SqlDataAdapter Da = new SqlDataAdapter(cmd);
                Da.Fill(Ds);
            }
        }
        return Ds.GetXml().ToString();
    }

    [WebMethod]
    public static int SubmitAnswer(string GivenAnserId, string GivenAnswerOfQuestionId, string Mode)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[GiveAnswer]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[6];

                param[0] = new SqlParameter("@ExamId", Convert.ToInt32(HttpContext.Current.Session["Examid"]));

                param[1] = new SqlParameter("@SturegNo", Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]));

                param[2] = new SqlParameter("@GivenAnswerOfQuestionId", Convert.ToInt32(GivenAnswerOfQuestionId));

                param[3] = new SqlParameter("@GivenAnserId", Convert.ToInt32(GivenAnserId));

                param[4] = new SqlParameter("@mode", Convert.ToInt32(Mode));

                param[5] = new SqlParameter("@intresult", SqlDbType.Int);

                param[5].Direction = ParameterDirection.Output;

                cmd.Parameters.Add(param[0]);

                cmd.Parameters.Add(param[1]);

                cmd.Parameters.Add(param[2]);

                cmd.Parameters.Add(param[3]);

                cmd.Parameters.Add(param[4]);

                cmd.Parameters.Add(param[5]);

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }

    [WebMethod]
    public static string GetTimer()
    {
        DataSet Ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_GetTimer]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Examid", Convert.ToInt32(HttpContext.Current.Session["Examid"]));
                param[1] = new SqlParameter("@StuRegNo", Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]));
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                SqlDataAdapter Da = new SqlDataAdapter(cmd);
                Da.Fill(Ds);
            }
        }
        return Ds.GetXml().ToString();
    }

    [WebMethod]
    public static int GetAnswer(string Qid)
    {
        DataUtility Objdut = new DataUtility();
        int AnswerId = 0;
        string Query = @"Select GivenAnswerId From tbl_studentexamdetailmaster where
                       Sturegno=" + Convert.ToString(HttpContext.Current.Session["StuRegNo"]) + " and ExamId=" + Convert.ToString(HttpContext.Current.Session["Examid"]) + "                               and QuestionId=" + Qid + "";
        AnswerId = Convert.ToInt32(Objdut.GetScalar(Query));
        return AnswerId;
    }

    [WebMethod]
    public static int SubmitExam()
    {
        DataUtility Objdut = new DataUtility();
        string Query = @"Update tbl_Studentonlineexammaster Set Is_Done=1 where Exam_id=" + Convert.ToString(HttpContext.Current.Session["Examid"]) + " and Sturegno=" + Convert.ToString(HttpContext.Current.Session["StuRegNo"]) + "";
        Objdut.ExecuteSql(Query);
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@ExamId", Convert.ToString(HttpContext.Current.Session["Examid"]));
        param[1] = new SqlParameter("@Sturegno", Convert.ToString(HttpContext.Current.Session["StuRegNo"]));
        param[2] = new SqlParameter("@intresult", SqlDbType.Int);
        param[2].Direction = ParameterDirection.Output;
        int result = Objdut.ExecuteSqlSP(param, "[Usp_PrepareResult]");
        SendMail_CourseStructure();
        HttpContext.Current.Session["Examid"] = 0;
        return 1;
    }

    [WebMethod]
    public static string SendMail_CourseStructure()
    {
        DataUtility ObjDut = new DataUtility();
        DataTable dt = new DataTable();
        string MailContent = "";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@Exam_Id", Convert.ToInt32(HttpContext.Current.Session["Examid"]));
        param[1] = new SqlParameter("@Sturegno", Convert.ToString(HttpContext.Current.Session["StuRegNo"]));
        dt = ObjDut.GetDataTableSP(param, "usp_DataForOnlineExam");
        if (dt.Rows.Count > 0)
        {
            MailContent = "<html><head><title>Online Exam Report Card</title></head><body>" +
          "<div style='color:#000; background-color:#fff; font-family:garamond, new york, times, serif;font-size:14px'>" +
          "<div><span></span></div><div></div><div id='yui_3_16_0_1_1450081753132_15631'>&nbsp;</div>" +
          "<h3 style='font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Grande', sans-serif;'>" +
          "Dear Dr. " + dt.Rows[0]["StudentName"].ToString() + ",</h3><h3  style='font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Grande', sans-serif;'>" +
         "Greetings from AIMS!</h3><h2 style='font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Grande', sans-serif;'>" +
         "Subject: Result of Exam " + dt.Rows[0]["ExamName"].ToString() + " taken on " + dt.Rows[0]["ExamTakenDate"].ToString() + " of " + dt.Rows[0]["Email"].ToString() + "" +
         "</h2><h2 style='font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Grande', sans-serif;'>" +
         "Result of Exam : '" + dt.Rows[0]["ExamName"].ToString() + "'</h2><ul  style='font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Grande', sans-serif; font-size: 13px;'><li  style='font-size: 16px; font-weight: bold; color: rgb(102, 102, 255);'>" +
         "Attempted Answers : " + (Convert.ToInt32(dt.Rows[0]["TotalRight"]) +Convert.ToInt32(dt.Rows[0]["TotalWrong"])) + "</li><li style='font-size: 16px; font-weight: bold; color: rgb(0, 153, 51);'>" +
         "Correct Answers : " + Convert.ToInt32(dt.Rows[0]["TotalRight"]) + "</li><li style='font-size: 16px; font-weight: bold; color: rgb(204, 36, 36);'>" +
         "Wrong Answers : " + Convert.ToInt32(dt.Rows[0]["TotalWrong"]) + "</li><li style='font-size: 16px; font-weight: bold; color: rgb(102, 102, 255);'>" +
         "Un Attempted Questions : " + Convert.ToInt32(dt.Rows[0]["TotalBlank"]) + "</li><li style='font-size: 16px; font-weight: bold; color: rgb(184, 134, 11);'>" +
         "Score : " + Convert.ToInt32(dt.Rows[0]["TotalMarks"]) + "</li><li  style='font-size: 16px; font-weight: bold; color: rgb(184, 134, 11);'>" +
         "Percentage : " + dt.Rows[0]["Percentage"].ToString() + "%</li></ul><h4  style='font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Grande', sans-serif; font-size: 13px;'>" +
         "All The Best for your Next Exam</h4><br style='font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Grande', sans-serif; font-size: 13px;'><div  style='margin-top: 0px; margin-bottom: 0px; font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Grande', sans-serif;'>" +
         "We thank you for your interest in our Online Examination Systems.</div><br style='font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Grande', sans-serif; font-size: 13px;'><div  style='margin-top: 0px; margin-bottom: 0px; font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Grande', sans-serif;' dir='ltr'>" +
         "If you have any question or concern then do write to&nbsp;<a rel='nofollow' ymailto='mailto:info@aimspg.com' target='_blank' href='mailto:info@aimspg.com' style='color: rgb(25, 106, 212);'>info@aimspg.com</a></div><div  style='margin-top: 0px; margin-bottom: 0px; font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Grande', sans-serif;' dir='ltr'><br></div><div class='signature'><div></div></div></div></body></html>";
            if (dt.Rows[0]["Email"].ToString() != "")
            {
                try
                {
                    System.Threading.Thread ThreadUpdateGrowthMocha = new System.Threading.Thread(delegate()
                    {
                        string res = SendMail.SendDemo("admin@onlinetest.aimspg.com", dt.Rows[0]["Email"].ToString(), "", "", "Online Exam Result", MailContent, "", "webmail.awapal.com");
                    });
                    ThreadUpdateGrowthMocha.Start();
                }
                catch (Exception e1)
                {
                }
               
               
            }
        }
        return "";
    }

    [WebMethod]
    public static BindAnserKey[] BindGridOfAnswerKey(string Examid, string ModuleId)
    {
        DataSet Ds = new DataSet();
        List<BindAnserKey> Questinlist = new List<BindAnserKey>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@Sturegno", HttpContext.Current.Session["StuRegNo"]);
        param[1] = new SqlParameter("@Examid", Examid);
        param[2] = new SqlParameter("@ModuleId", ModuleId);
        Ds = Objdut.GetDataSetSP(param, "[Usp_answerkey]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow Dtrow in Ds.Tables[0].Rows)
            {
                BindAnserKey user = new BindAnserKey();
                user.RowNumber = Dtrow["RowNumber"].ToString();
                user.Module_Name = Dtrow["Module_Name"].ToString();
                user.Question_Code = Dtrow["Question_Code"].ToString();
                user.Classname = Dtrow["Classname"].ToString();
                user.SubjectName = Dtrow["SubjectName"].ToString();
                user.TopicName = Dtrow["TopicName"].ToString();
                user.ActualAnswer = Dtrow["ActualAnswer"].ToString();
                user.GivenAnswer = Dtrow["GivenAnswer"].ToString();
                user.AttemtedStatus = Dtrow["AttemtedStatus"].ToString();
                user.Question_Id = Dtrow["Question_Id"].ToString();
                Questinlist.Add(user);
            }
        }
        return Questinlist.ToArray();
    }

    public class BindAnserKey
    {
        public string RowNumber { get; set; }

        public string Module_Name { get; set; }

        public string Question_Code { get; set; }

        public string Classname { get; set; }

        public string SubjectName { get; set; }

        public string TopicName { get; set; }

        public string ActualAnswer { get; set; }

        public string GivenAnswer { get; set; }

        public string AttemtedStatus { get; set; }

        public string Question_Id { get; set; }
    }

    [WebMethod]
    public static string BindAnswerKeyForBind(string Questionid)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[1];
        Param[0] = new SqlParameter("@Question_Id", Questionid);
        string DatForBing = Convert.ToString(Objdut.GetScalerSP(Param, "[Usp_AnswerKeyDetails]"));
        return DatForBing;
    }
}