using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_library_management_book_issue : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    //************************************************************bind grid*******************************************************************************
    [WebMethod]
    public static studentpersonaldetails[] fillstudentinfo(string library_card_no)
    {
        DataSet ds = new DataSet();
        List<studentpersonaldetails> details = new List<studentpersonaldetails>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", 1);
        param[1] = new SqlParameter("@intResult", 0);
        param[1].Direction = ParameterDirection.Output;
        param[2] = new SqlParameter("@brid", HttpContext.Current.Session["Brbrid"]);
        param[3] = new SqlParameter("@librarycardno", library_card_no);

        ds = ObjDUT.GetDataSetSP(param, "[Usp_book_issue]");
        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dtrow in ds.Tables[0].Rows)
                {
                    studentpersonaldetails user = new studentpersonaldetails();
                    user.student_image = dtrow["StudentPhotograph"].ToString();
                    user.student_name = dtrow["Student_Name"].ToString();
                    user.mobile = dtrow["mobile"].ToString();
                    user.classname = dtrow["Classname"].ToString();
                    user.membership = dtrow["Membership_Status"].ToString();
                    user.classid = dtrow["Class_id"].ToString();
                    user.sturegno = dtrow["Stu_Regno"].ToString();
                    user.AdmissionNo = dtrow["Admission_No"].ToString();
                    user.section = dtrow["sectionname"].ToString();
                    details.Add(user);
                }
            }
        }
        return details.ToArray();
    }

    public class studentpersonaldetails
    {
        public string student_image{ get; set; }
        public string student_name{ get; set; }
        public string mobile { get; set; }
        public string classname { get; set; }
        public string membership { get; set; }
        public string classid { get; set; }
        public string sturegno { get; set; }
        public string AdmissionNo { get; set; }
        public string section { get; set; }
       
    }
    //*************************************************get details for book************************************************************

    [WebMethod]
    public static bookdetail[] getdatadetailofbook(string isuuedate, string sturegno, string library_card_no)
    {
        DataUtility objdut = new DataUtility();
        List<bookdetail> result = new List<bookdetail>();
        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@Mode", 1);
        param[1] = new SqlParameter("@LIbraryCardNo",library_card_no);
        param[2] = new SqlParameter("@SturegNo",sturegno);
        param[3] = new SqlParameter("@IssueDate",isuuedate);
        param[4] = new SqlParameter("@brid", HttpContext.Current.Session["Brbrid"]);
        DataTable dt = objdut.GetDataTableSP(param, "[Usp_ManageBookIssue]");
        foreach (DataRow dtrow in dt.Rows)
        {
            bookdetail user = new bookdetail();
           user.Issuedate = dtrow["IssueDate"].ToString();
            user.Returndate = dtrow["ReturnDate"].ToString();
            user.latefine = dtrow["FinePerDay"].ToString();
            user.maxnoofbook = dtrow["MaxIssueNoOfBook"].ToString();
            result.Add(user);
        }
        return result.ToArray();
    }

    public class bookdetail
    {
        public string Issuedate { get; set; }
        public string Returndate { get; set; }
        public string latefine { get; set; }
        public string maxnoofbook { get; set; }

    }
    //*************************************************get details of already taken book************************************************************

    [WebMethod]
    public static alreadybookdetail[] getdatadetailofalreadytakenbook(string library_card_no)
    {
        DataUtility objdut = new DataUtility();
        List<alreadybookdetail> result = new List<alreadybookdetail>();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@Mode",2);
        param[1] = new SqlParameter("@LIbraryCardNo", library_card_no);
        param[2] = new SqlParameter("@brid", HttpContext.Current.Session["Brbrid"]);
        DataTable dt = objdut.GetDataTableSP(param, "[Usp_ManageBookIssue]");
        foreach (DataRow dtrow in dt.Rows)
        {
            alreadybookdetail user = new alreadybookdetail();
            user.AlreadyBookid = dtrow["Book_id"].ToString();
            user.AlreadyISBN = dtrow["ISBN"].ToString();
            user.AlreadyBooktitle = dtrow["Book_Title"].ToString();
            user.Alreadyissuedate = dtrow["Issue_Date"].ToString();
            user.Alreadyreturndate = dtrow["Return_Date"].ToString();
            user.AlreadyLatefine = dtrow["Late_fine"].ToString();
            result.Add(user);
        }
        return result.ToArray();
    }

    public class alreadybookdetail
    {
        public string AlreadyBookid { get; set; }
        public string AlreadyISBN { get; set; }
        public string AlreadyBooktitle { get; set; }
        public string Alreadyissuedate { get; set; }
        public string Alreadyreturndate { get; set; }
        public string AlreadyLatefine { get; set; }

    }
    //*************************************************get title on the basis of bookid*********************************************

    [WebMethod]
    public static booktitledetail[] gettitle(string bookid)
    {
        DataUtility objdut = new DataUtility();
        List<booktitledetail> result = new List<booktitledetail>();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@Mode", 2);
        param[1] = new SqlParameter("@bookid", bookid);
        param[2] = new SqlParameter("@brid", HttpContext.Current.Session["Brbrid"]);
        param[3] = new SqlParameter("@INTRESULT", SqlDbType.Int);
        param[3].Direction = ParameterDirection.Output;
        DataTable dt = objdut.GetDataTableSP(param, "[Usp_book_issue]");
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in dt.Rows)
            {
                booktitledetail user = new booktitledetail();
                user.booktitle = dtrow["Book_Title"].ToString();
                user.isbn = dtrow["ISBN"].ToString();
                user.result = Convert.ToInt32(param[3].Value);
                result.Add(user);
            }
        }
        else
        {
            booktitledetail user = new booktitledetail();
            user.result = Convert.ToInt32(param[3].Value);
            result.Add(user);
 
        }
        return result.ToArray();
    }

    public class booktitledetail
    {
        public string booktitle { get; set; }
        public string isbn{ get; set; }
        public int result { get; set; }
       
    }
    //*************************************************get title on the basis of isbn*********************************************

    [WebMethod]
    public static booktitle[] getdata(string isbn)
    {
        DataUtility objdut = new DataUtility();
        List<booktitle> result = new List<booktitle>();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@Mode", 3);
        param[1] = new SqlParameter("@isbn", isbn);
        param[2] = new SqlParameter("@brid", HttpContext.Current.Session["Brbrid"]);
        param[3] = new SqlParameter("@INTRESULT", SqlDbType.Int);
        param[3].Direction = ParameterDirection.Output;
        DataTable dt = objdut.GetDataTableSP(param, "[Usp_book_issue]");
       if (dt.Rows.Count > 0)
        {
        foreach (DataRow dtrow in dt.Rows)
        {
            booktitle user = new booktitle();
            user.bookname = dtrow["Book_Title"].ToString();
            user.bookid = dtrow["Book_Id"].ToString();
            user.result = Convert.ToInt32(param[3].Value);
            result.Add(user);
        }
           }
       else
       {
           booktitle user = new booktitle();
           user.result = Convert.ToInt32(param[3].Value);
           result.Add(user);

       }
        return result.ToArray();
    }

    public class booktitle
    {
        public string bookname { get; set; }
        public string bookid { get; set; }
        public int result { get; set; }

    }
    //*************************************************save data for issue  book******************************************************
    [WebMethod]
    public static int savedataforissuebook(string librarycardno, string issuedate, string Book_id, string isbn, string Book_title, string returndate, string latefine)
    {

        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[10];
        param[0] = new SqlParameter("@librarycardno", librarycardno);
        param[1] = new SqlParameter("@Issuedate", issuedate);
        param[2] = new SqlParameter("@bookid", Book_id);
        param[3] = new SqlParameter("@isbn", isbn);
        param[4] = new SqlParameter("@Booktitle", Book_title);
        param[5] = new SqlParameter("@returndate", returndate);
        param[6] = new SqlParameter("@brid", Convert.ToString(HttpContext.Current.Session["BrBrid"]));
        param[7] = new SqlParameter("@latefine", latefine);
        param[8] = new SqlParameter("@INTRESULT", 0);
        param[8].Direction = ParameterDirection.Output;
        param[9] = new SqlParameter("@userid", HttpContext.Current.Session["BrADID"]);
        int result = objdut.ExecuteSqlSP(param, "USP_Issuebook_DetailSave");
        return result;
    }
}