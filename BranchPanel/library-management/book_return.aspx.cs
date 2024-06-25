using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_library_management_book_return : System.Web.UI.Page
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

        ds = ObjDUT.GetDataSetSP(param, "[Usp_Book_Return]");
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
        public string student_image { get; set; }
        public string student_name { get; set; }
        public string mobile { get; set; }
        public string classname { get; set; }
        public string membership { get; set; }
        public string classid { get; set; }
        public string sturegno { get; set; }
        public string AdmissionNo { get; set; }
        public string section { get; set; }

    }

    //*************************************************get details of already taken book************************************************************

    [WebMethod]
    public static takenbookdetail[] getdatadetailtakenbook(string library_card_no, string Returndateofbook)
    {
        DataUtility objdut = new DataUtility();
        List<takenbookdetail> result = new List<takenbookdetail>();
        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@librarycardno", library_card_no);
        param[2] = new SqlParameter("@brid", HttpContext.Current.Session["Brbrid"]);
        param[3] = new SqlParameter("@returneddate", Returndateofbook);
        param[4] = new SqlParameter("@intResult", 0);
        param[4].Direction = ParameterDirection.Output;
        DataTable dt = objdut.GetDataTableSP(param, "[Usp_Book_Return]");
        foreach (DataRow dtrow in dt.Rows)
        {
            takenbookdetail user = new takenbookdetail();
            user.Bookid = dtrow["Book_id"].ToString();
            user.ISBN = dtrow["ISBN"].ToString();
            user.Booktitle = dtrow["Book_Title"].ToString();
            user.issuedate = dtrow["Issue_Date"].ToString();
            user.returndate = dtrow["Return_Date"].ToString();
            user.Latefine = dtrow["Late_fine"].ToString();
            user.lateday = dtrow["nooflateday"].ToString();
            user.totalfine = dtrow["totalfine"].ToString();
            result.Add(user);
        }
        return result.ToArray();
    }

    public class takenbookdetail
    {
        public string Bookid { get; set; }
        public string ISBN { get; set; }
        public string Booktitle { get; set; }
        public string issuedate { get; set; }
        public string returndate { get; set; }
        public string Latefine { get; set; }
        public string lateday { get; set; }
        public string totalfine { get; set; }

    }
    //*************************************************save data for return book******************************************************
    [WebMethod]
    public static int savedataforreturnbook(string librarycard, string returndate, string bookid, string Isbn, string totalfine, string paidamount, string Grandtotal, string discountamt)
    {

        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[11];
        param[0] = new SqlParameter("@librarycardno", librarycard.Trim());
        param[1] = new SqlParameter("@returndate", returndate.Trim());
        param[2] = new SqlParameter("@bookid", bookid.Trim());
        param[3] = new SqlParameter("@isbn", Isbn.Trim());
        param[4] = new SqlParameter("@totalfine", Convert.ToString(totalfine));
        param[5] = new SqlParameter("@Paidamount", Convert.ToInt32(paidamount.Trim()));
        param[6] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));      
        param[7] = new SqlParameter("@userid", Convert.ToInt32(HttpContext.Current.Session["BrADID"]));
        param[8] = new SqlParameter("@mastertotal", Convert.ToInt32(Grandtotal.Trim()));
        param[9] = new SqlParameter("@INTRESULT", SqlDbType.Int);
        param[9].Direction = ParameterDirection.Output;
        param[10] = new SqlParameter("@Discountfine", Convert.ToInt32(discountamt.Trim()));
        int result = objdut.ExecuteSqlSP(param, "USP_ReturnBook_Manage");
        return result;
    }
}