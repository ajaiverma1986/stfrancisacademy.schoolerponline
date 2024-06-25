using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_library_management_bookinformation : System.Web.UI.Page
{
    //private string query;
    private int count;

    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
   // private SqlParameter[] param = new SqlParameter[19];
    private DataTable dt;
    private static int academicyear = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
    //************************************************************bind grid*******************************************************************************
    [WebMethod]
    public static bookimagedata[] fillbookinfo(string bookid)
    {
        DataSet ds = new DataSet();
        List<bookimagedata> details = new List<bookimagedata>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", 1);
        param[1] = new SqlParameter("@intResult", 0);
        param[1].Direction = ParameterDirection.Output;
        param[2] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        param[3] = new SqlParameter("@Book_Id", bookid);
        ds = ObjDUT.GetDataSetSP(param, "Usp_book_search");

        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                bookimagedata user = new bookimagedata();
                user.Book_Imagename = dtrow["Book_Image"].ToString();
                user.Book_Title = dtrow["Book_Title"].ToString();
                user.Author_Name = dtrow["Author_Name"].ToString();
                user.Noofbook = dtrow["NoofBook"].ToString();
                user.Status = dtrow["Book_Notissue_Status"].ToString();
                user.Description = dtrow["Book_Description"].ToString();
                user.Book_id = dtrow["Book_Id"].ToString();
                user.Publisher_Name = dtrow["Publisher_Name"].ToString();
                details.Add(user);
            }
        }
        return details.ToArray();
    }

    public class bookimagedata
    {
        public string Book_Imagename { get; set; }
        public string Book_Title { get; set; }
        public string Publisher_Name { get; set; }
        public string Author_Name { get; set; }
        public string Noofbook { get; set; }
        public string Status { get; set; }
        public string Description { get; set; }
        public string Book_id { get; set; }
    }

    [WebMethod]
    public static similarbookimagedata[] fillsimilarbookinfo(string categoryid)
    {
        DataSet ds = new DataSet();
        List<similarbookimagedata> details = new List<similarbookimagedata>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@intResult", 0);
        param[1].Direction = ParameterDirection.Output;
        param[2] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        param[3] = new SqlParameter("@category_id", categoryid);
        ds = ObjDUT.GetDataSetSP(param, "Usp_book_search");

        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                similarbookimagedata user = new similarbookimagedata();
                user.Book_Imagename = dtrow["Book_Image"].ToString();
                user.Book_Title = dtrow["Book_Title"].ToString();
                user.Author_Name = dtrow["Author_Name"].ToString();
                user.Status = dtrow["Book_Notissue_Status"].ToString();
                user.Description = dtrow["Book_Description"].ToString();
                user.Publisher_Name = dtrow["Publisher_Name"].ToString();
                user.category_id = dtrow["Category_id"].ToString();
                user.book_id = dtrow["Book_Id"].ToString();
                details.Add(user);
            }
        }
        return details.ToArray();
    }

    public class similarbookimagedata
    {
        public string Book_Imagename { get; set; }
        public string Book_Title { get; set; }
        public string Publisher_Name { get; set; }
        public string Author_Name { get; set; }
         public string Status { get; set; }
        public string Description { get; set; }
        public string category_id { get; set; }
        public string book_id { get; set; }
       
    }
}