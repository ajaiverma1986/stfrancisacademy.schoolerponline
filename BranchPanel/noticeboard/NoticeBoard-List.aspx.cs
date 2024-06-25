using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_commonpage_NoticeBoard_List : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static int SubmitNotice(string noticeid, string message, string fromdate, string todate, string active,
        string broadcastsms, string broadcastemail, string valuefortype, string mode, string nid, string broadcastpanel)
    {
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[13];
        int brid = Convert.ToInt32(HttpContext.Current.Session["BrBrid"]);
        param[0] = new SqlParameter("@noticetypeid", noticeid);
        param[1] = new SqlParameter("@message", message.Replace("~","'"));
        param[2] = new SqlParameter("@fromdate", fromdate);
        param[3] = new SqlParameter("@todate", todate);
        param[4] = new SqlParameter("@active", active);
        param[5] = new SqlParameter("@sms", broadcastsms);
        param[6] = new SqlParameter("@email", broadcastemail);
        param[7] = new SqlParameter("@intresult", SqlDbType.Int);
        param[7].Direction = ParameterDirection.Output;
        param[8] = new SqlParameter("@valuefortype", valuefortype);
        param[9] = new SqlParameter("@mode", mode);
        param[10] = new SqlParameter("@nid", nid);
        param[11] = new SqlParameter("@brid", brid);
        param[12] = new SqlParameter("@panelshow", broadcastpanel);
        int result = ObjDUT.ExecuteSqlSP(param, "Usp_NoticeBoard");
        return result;
    }

    public class GetNoticeType
    {
        public int Id { get; set; }

        public string NoticeType { get; set; }
    }

    [WebMethod]
    public static GetNoticeType[] NoticeType()
    {
        List<GetNoticeType> Details = new List<GetNoticeType>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        Dt = Objdut.GetDataTable("select id,NoticType from tbl_Notice_Master where Status = 1");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                GetNoticeType obj = new GetNoticeType();
                obj.Id = Convert.ToInt32(Dt.Rows[i]["id"]);
                obj.NoticeType = Convert.ToString(Dt.Rows[i]["NoticType"]);
                Details.Add(obj);
            }
        }
        return Details.ToArray();
    }

    public class GetClasses
    {
        public int classID { get; set; }

        public string CLassname { get; set; }
    }

    [WebMethod]
    public static GetClasses[] ClassList()
    {
        List<GetClasses> Details = new List<GetClasses>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 1);
        param[1] = new SqlParameter("@brid", Convert.ToString(HttpContext.Current.Session["Brbrid"]));
        Dt = Objdut.GetDataTableSP(param, "Usp_NoticeBoard");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                GetClasses obje = new GetClasses();
                obje.classID = Convert.ToInt32(Dt.Rows[i]["classid"]);
                obje.CLassname = Convert.ToString(Dt.Rows[i]["classname"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }

    public class GetCourse
    {
        public int courseID { get; set; }

        public string courseName { get; set; }
    }

    [WebMethod]
    public static GetCourse[] CourseList()
    {
        List<GetCourse> Details = new List<GetCourse>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        int brid = Convert.ToInt32(HttpContext.Current.Session["BrBrid"]);
        Dt = Objdut.GetDataTable("Select courseID,courseName From new_course_master where courseID In(select Courseid From Coursebranch_master where branchid=" + brid + " and is_deleted=0) and  is_deleted=0 and status=1");
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtRow in Dt.Rows)
            {
                GetCourse obj = new GetCourse();
                obj.courseID = Convert.ToInt32(dtRow["courseID"]);
                obj.courseName = Convert.ToString(dtRow["courseName"]);
                Details.Add(obj);
            }
        }
        return Details.ToArray();
    }

    public class GetEmp
    {
        public int empid { get; set; }

        public string empname { get; set; }
    }

    [WebMethod]
    public static GetEmp[] emplist()
    {
        List<GetEmp> Details = new List<GetEmp>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@brid", Convert.ToString(HttpContext.Current.Session["Brbrid"]));
        Dt = Objdut.GetDataTableSP(param, "Usp_NoticeBoard");
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtRow in Dt.Rows)
            {
                GetEmp obj = new GetEmp();
                obj.empid = Convert.ToInt32(dtRow["empid"]);
                obj.empname = Convert.ToString(dtRow["empname"]);
                Details.Add(obj);
            }
        }
        return Details.ToArray();
    }

    public class GetStudent
    {
        public int StudentId { get; set; }

        public string Name { get; set; }

        public string Roll_No { get; set; }
    }

    [WebMethod]
    public static GetStudent[] StudentList(string studentname)
    {
        List<GetStudent> Details = new List<GetStudent>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        int brid = Convert.ToInt32(HttpContext.Current.Session["BrBrid"]);
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@studentname", studentname);
        param[1] = new SqlParameter("@brid", brid);
        Dt = Objdut.GetDataTableSP(param, "[Usp_BindStudent]");
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtRow in Dt.Rows)
            {
                GetStudent obj = new GetStudent();
                obj.StudentId = Convert.ToInt32(dtRow["StudentId"]);
                obj.Roll_No = dtRow["Roll_No"].ToString();
                obj.Name = Convert.ToString(dtRow["Name"]);
                Details.Add(obj);
            }
        }
        return Details.ToArray();
    }

    [WebMethod]
    public static int Sendsms(string noticeid, string message, string valuefortype)
    {
        int result = 0;
        DataUtility ObjDUT = new DataUtility();
        DataTable Dt = new DataTable();
        int len = message.Length;
        if (len <= 160)
        {
            int brid = Convert.ToInt32(HttpContext.Current.Session["BrBrid"]);
            int userid = Convert.ToInt32(HttpContext.Current.Session["BrADID"]);
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@noticeid", noticeid);
            param[1] = new SqlParameter("@valueforNoticetype", valuefortype);
            param[2] = new SqlParameter("@brid", brid);
            param[3] = new SqlParameter("@intresult", SqlDbType.Int);
            param[3].Direction = ParameterDirection.Output;
            Dt = ObjDUT.GetDataTableSP(param, "Usp_GetStudentInfo");
            if (HttpContext.Current.Session["brbrid"].ToString() != "")
            {
                result = sendMessageToMobile.SMSSend(Convert.ToString(Dt.Rows[0]["Mobile"]),message, HttpContext.Current.Session["BrBrid"].ToString());
            } 
            //result = sendMessageToMobile.SMSSend(Convert.ToString(Dt.Rows[0]["Mobile"]), "AWS", message, 1);
            //string query = "insert into tbl_sms_history values(getdate(),CONVERT (time, SYSDATETIME()),'" + message + "',1,'" + Dt.Rows[0]["Mobile"] + "'," + idStudent + ",1,0," + userid + ")";
            //ObjDUT.ExecuteSql(query);
        }
        else
        {
            return 2;
        }
        return result;
    }

    [WebMethod]
    public static int updatestatuspanel(int changepanelid, int noticetid)
    {
        int ret = 0;
        DataUtility Objdut = new DataUtility();
        if (changepanelid == 0)
        {
            ret = Objdut.ExecuteSql("update tbl_NoticeBoard set IsPanelShow = 1 where nid=" + noticetid + "");
        }
        else
        {
            ret = Objdut.ExecuteSql("update tbl_NoticeBoard set IsPanelShow = 0 where nid=" + noticetid + "");
        }
        return ret;
    }

    [WebMethod]
    public static string Sendemail(string noticeid, string message, string valuefortype)
    {
        string result = "";
        string mailid = "";
        DataUtility ObjDUT = new DataUtility();
        DataTable Dt = new DataTable();
        int brid = Convert.ToInt32(HttpContext.Current.Session["BrBrid"]);
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@noticeid", noticeid);
        param[1] = new SqlParameter("@valueforNoticetype", valuefortype);
        param[2] = new SqlParameter("@brid", brid);
        param[3] = new SqlParameter("@intresult", SqlDbType.Int);
        param[3].Direction = ParameterDirection.Output;
        Dt = ObjDUT.GetDataTableSP(param, "Usp_GetStudentInfo");
        if (Dt.Rows.Count > 0)
        {
            mailid = Convert.ToString(Dt.Rows[0]["Email"]);
            if (mailid != "")
            {
                mailid = mailid.Remove(0, 1);
            }
        }
        //for geting info for host
        DataTable dt1 = new DataTable();
        dt1 = ObjDUT.GetDataTable("select (module_hostname)as hostname,(emialid_for_module)as emailid,(password_of_email)as password,(email_subject)as subject from tbl_email_sms_send_master where moduleid=17");
        if (dt1.Rows.Count > 0)
        {
            string hostname = dt1.Rows[0]["hostname"].ToString();
            string emailid = dt1.Rows[0]["emailid"].ToString();
            string password = dt1.Rows[0]["password"].ToString();
            string subject = dt1.Rows[0]["subject"].ToString();
            int status = Convert.ToInt32(ObjDUT.GetScalar("select status from tbl_emailsettingcenter where emailid = 13"));
            if (status > 0)
            {
                try
                {
                    result = (SendMail.SendDemo(emailid, mailid, "", "", subject, message, password, hostname));
                }
                catch
                {
                    result = "0";
                }
            }
            else
            {
                result = "2";
            }
        }
        return result;
    }

    public class NoticeBoarList
    {
        public string Nid { get; set; }
        public string NoticeType { get; set; }
        public string Message { get; set; }
        public string FullMessage { get; set; }
        public string MessageStatus { get; set; }
        public string EmailStatus { get; set; }
        public string PanelStatus { get; set; }
        public string fromdate { get; set; }
        public string todate { get; set; }
        public string panactid { get; set; }
        public string activepanel { get; set; }
    }

    [WebMethod]
    public static NoticeBoarList[] NoticeList()
    {
        List<NoticeBoarList> Details = new List<NoticeBoarList>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        int brid = Convert.ToInt32(HttpContext.Current.Session["BrBrid"]);
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@brid", brid);
        Dt = Objdut.GetDataTableSP(param, "[Usp_BindNoticeBoardList]");
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtRow in Dt.Rows)
            {
                NoticeBoarList obj = new NoticeBoarList();
                obj.Nid = dtRow["Nid"].ToString();
                obj.NoticeType = dtRow["notictype"].ToString();
                obj.Message = dtRow["Message"].ToString();
                obj.FullMessage = dtRow["FullMessage"].ToString();
                obj.MessageStatus = dtRow["MessageStatus"].ToString();
                obj.EmailStatus = dtRow["EmailStatus"].ToString();
                obj.PanelStatus = dtRow["PanelStatus"].ToString();
                obj.fromdate = dtRow["fromdate"].ToString();
                obj.todate = dtRow["todate"].ToString();
                obj.panactid = dtRow["panact"].ToString();
                obj.activepanel = dtRow["activepanel"].ToString();
                Details.Add(obj);
            }
        }
        return Details.ToArray();
    }

    [WebMethod]
    public static int DeleteNoticeList(string nid)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@nid", nid);
        param[1] = new SqlParameter("@mode", 4);
        param[2] = new SqlParameter("@intresult", SqlDbType.Int);
        param[2].Direction = ParameterDirection.Output;
        int result = Objdut.ExecuteSqlSP(param, "Usp_NoticeBoard");
        return result;
    }

    public class Notice
    {
        public string NoticeTypeid { get; set; }

        public string Message { get; set; }

        public string ActiveFrom { get; set; }

        public string ActiveTo { get; set; }

        public string valueforNoticetype { get; set; }
    }

    [WebMethod]
    public static Notice[] GetNoticeList(string nid)
    {
        DataUtility Objdut = new DataUtility();
        DataTable Dt = new DataTable();
        List<Notice> Details = new List<Notice>();
        string Query = "select NoticeTypeid,Message,CONVERT(varchar(20),ActiveFrom,103)as ActiveFrom,CONVERT(varchar(20),ActiveTo,103)as ActiveTo,valueforNoticetype from tbl_NoticeBoard where Nid=" + nid + "";
        Dt = Objdut.GetDataTable(Query);
        if (Dt.Rows.Count > 0)
        {
            Notice obj = new Notice();
            obj.NoticeTypeid = Dt.Rows[0]["NoticeTypeid"].ToString();
            obj.Message = Dt.Rows[0]["Message"].ToString();
            obj.ActiveFrom = Dt.Rows[0]["ActiveFrom"].ToString();
            obj.ActiveTo = Dt.Rows[0]["ActiveTo"].ToString();
            obj.valueforNoticetype = Dt.Rows[0]["valueforNoticetype"].ToString();
            Details.Add(obj);
        }
        return Details.ToArray();
    }

    public class NoticeInfo
    {
        public string NoticeTypeid { get; set; }

        public string Message { get; set; }

        public string valueforNoticetype { get; set; }

        public string IsBroadCastedSms { get; set; }

        public string IsBroadCatedEmail { get; set; }

        public string IsPanelShow { get; set; }
    }

    [WebMethod]
    public static NoticeInfo[] GetNoticeDetail(string nid)
    {
        DataUtility Objdut = new DataUtility();
        DataTable Dt = new DataTable();
        List<NoticeInfo> Details = new List<NoticeInfo>();
        string Query = "select * from tbl_NoticeBoard where Nid=" + nid + "";
        Dt = Objdut.GetDataTable(Query);
        if (Dt.Rows.Count > 0)
        {
            NoticeInfo obj = new NoticeInfo();
            obj.NoticeTypeid = Dt.Rows[0]["NoticeTypeid"].ToString();
            obj.Message = Dt.Rows[0]["Message"].ToString();
            obj.valueforNoticetype = Dt.Rows[0]["valueforNoticetype"].ToString();
            obj.IsBroadCastedSms = Dt.Rows[0]["IsBroadCastedSms"].ToString();
            obj.IsBroadCatedEmail = Dt.Rows[0]["IsBroadCatedEmail"].ToString();
            obj.IsPanelShow = Dt.Rows[0]["IsPanelShow"].ToString();
            Details.Add(obj);
        }
        return Details.ToArray();
    }

    [WebMethod]
    public static int UpdateNoticeStatus(string nid, string broadcastsms, string broadcastemail, string ispanel, string valuefortype, string noticeid, string active)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[10];
        param[0] = new SqlParameter("@nid", nid);
        param[1] = new SqlParameter("@sms", broadcastsms);
        param[2] = new SqlParameter("@email", broadcastemail);
        param[3] = new SqlParameter("@valuefortype", valuefortype);
        param[4] = new SqlParameter("@panelshow", ispanel);
        param[5] = new SqlParameter("@mode", 3);
        param[6] = new SqlParameter("@intresult", SqlDbType.Int);
        param[6].Direction = ParameterDirection.Output;
        param[7] = new SqlParameter("@noticetypeid", noticeid);
        param[8] = new SqlParameter("@Brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        param[9] = new SqlParameter("@active", active);
        int result = Objdut.ExecuteSqlSP(param, "Usp_NoticeBoard");
        return result;
    }

}