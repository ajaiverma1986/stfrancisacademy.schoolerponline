using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_library_management_AddBook : System.Web.UI.Page
{
    private string query;
    private int cid;

    private int count;

    private DataUtility objdut = new DataUtility();
    private SqlParameter[] param = new SqlParameter[20];
    private DataTable dt;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
//**********************************************bindcategory************************************************************
[WebMethod]
    public static getcategory[] Bindcategory()
    {
        List<getcategory> Details = new List<getcategory>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode",1);
        param[1] = new SqlParameter("@intResult", 0);
        param[1].Direction = ParameterDirection.Output;
        Dt = Objdut.GetDataTableSP(param, "[Usp_Addbook]");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                getcategory obje = new getcategory();
                obje.categoryid = Convert.ToInt32(Dt.Rows[i]["Id"]);
                obje.categoryname = Convert.ToString(Dt.Rows[i]["catename"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }

    public class getcategory
    {
        public int categoryid { get; set; }
        public string categoryname { get; set; }
    }
  //*************************************************bind subcategory************************************************
    [WebMethod]
    public static getsubcategory[] getsubcategoryfun(string categoryid)
    {
        List<getsubcategory> Details = new List<getsubcategory>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@intResult", 0);
        param[1].Direction = ParameterDirection.Output;
        param[2] = new SqlParameter("@categoryid", categoryid);
        Dt = Objdut.GetDataTableSP(param, "[Usp_Addbook]");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                getsubcategory obje = new getsubcategory();
                obje.subcategoryid = Convert.ToInt32(Dt.Rows[i]["subcategoryid"]);
                obje.subcategoryname = Convert.ToString(Dt.Rows[i]["Subcategory_name"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }

    public class getsubcategory
    {
        public int subcategoryid { get; set; }
        public string subcategoryname { get; set; }
    }
    //*************************************************bind publisher************************************************
    [WebMethod]
    public static getpublisher[] getpublisherfun()
    {
        List<getpublisher> Details = new List<getpublisher>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@intResult", 0);
        param[1].Direction = ParameterDirection.Output;
        Dt = Objdut.GetDataTableSP(param, "[Usp_Addbook]");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                getpublisher obje = new getpublisher();
                obje.publisherid = Convert.ToString(Dt.Rows[i]["Pub_ID"]);
                obje.publishername = Convert.ToString(Dt.Rows[i]["Pub_Name"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }

    public class getpublisher
    {
        public string publisherid { get; set; }
        public string publishername { get; set; }
    }
    //*************************************************bind Author************************************************
    [WebMethod]
    public static getauthor[] getauthorfun()
    {
        List<getauthor> Details = new List<getauthor>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 4);
        param[1] = new SqlParameter("@intResult", 0);
        param[1].Direction = ParameterDirection.Output;
        Dt = Objdut.GetDataTableSP(param, "[Usp_Addbook]");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                getauthor obje = new getauthor();
                obje.authorid = Convert.ToString(Dt.Rows[i]["Au_ID"]);
                obje.authorname = Convert.ToString(Dt.Rows[i]["Au_Name"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }

    public class getauthor
    {
        public string authorid { get; set; }
        public string authorname { get; set; }
    }
    ////*************************************************check isbn number*********************************************
    [WebMethod]
    public static string checkisbn(string isbn)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select count(1) from tbl_Book_detail where Book_status=1 and ISBN='" + isbn + "' ", con))
            {
                con.Open();
                string chk = cmd.ExecuteScalar().ToString();
                con.Close();
                return chk;
            }
        }
    }
    //*********************************************add Book********************************************
    [WebMethod]
    public static int saveBookdetail(string bookcategory, string booksubcategory, string publisher, string author, string noofbook, string isbn, string price, string purchasedate, string keywords, string title, string description, string notissue, string booksrc, string imagebookdata, string bookExtension, string fyid)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[18];
        param[0] = new SqlParameter("@Category_Id", bookcategory);
        param[1] = new SqlParameter("@Subcategory_Id", booksubcategory);
        param[2] = new SqlParameter("@Publisher_Id", publisher);
        param[3] = new SqlParameter("@Author_Id", author);
        param[4] = new SqlParameter("@NoofBook", noofbook.Replace("~", "'"));
        param[5] = new SqlParameter("@isbnno", isbn.Replace("~", "'"));
        param[6] = new SqlParameter("@Price", price.Replace("~", "'"));
        param[7] = new SqlParameter("@Purchase_Date", purchasedate);
        param[8] = new SqlParameter("@KeywordsofBook", keywords.Replace("~", "'"));
        param[9] = new SqlParameter("@Book_Title", title.Replace("~", "'"));
        param[10] = new SqlParameter("@Book_Description", description.Replace("~", "'"));
        param[11] = new SqlParameter("@Book_Notissue_Status", notissue);
       
        if (booksrc != "")
        {
            if (booksrc.Contains("base64,"))
            {
                int IndexNo = booksrc.IndexOf("/") + 1;
                int lastIndexNo = booksrc.IndexOf(";");
                int IndexNo1 = booksrc.IndexOf(",") + 1;
                int Pathlength1 = booksrc.Length;
                booksrc = booksrc.Substring(IndexNo1, (Pathlength1 - IndexNo1));
                byte[] vb = Convert.FromBase64String(booksrc);
                string vpathforsaveimage = HttpContext.Current.Request.MapPath("bookimage/") + imagebookdata;
                MasterImageUpload.CreateImage(vb, imagebookdata, bookExtension, vpathforsaveimage, 5);
            }
        }
        param[12] = new SqlParameter("@Book_Image", imagebookdata);
        param[13] = new SqlParameter("@intResult", 0);
        param[13].Direction = ParameterDirection.Output;
        param[14] = new SqlParameter("@mode", 5);
        param[15] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        param[16] = new SqlParameter("@Fyid", fyid);
        param[17] = new SqlParameter("@Userid", HttpContext.Current.Session["BrADID"]);
        int result = objdut.ExecuteSqlSP(param, "Usp_Addbook");
        return result;
    }
    //*******************************************************for session or fyid**********************************************************************
    [WebMethod]
    public static getsession[] bindsession()
    {
        List<getsession> Details = new List<getsession>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@whyCall", "GetAcademicYearDDL");
        Dt = Objdut.GetDataTableSP(param, "MasterProc");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                getsession obje = new getsession();
                obje.id = Convert.ToInt32(Dt.Rows[i]["fyid"]);
                obje.session = Convert.ToString(Dt.Rows[i]["FYName"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }

    public class getsession
    {
        public int id { get; set; }

        public string session { get; set; }
    }
    //********************************************web method for edit*******************************************
    [WebMethod]
    public static bookedit[] Editdetail(string IbForUpdate)
    {
        DataSet ds = new DataSet();
        List<bookedit> details = new List<bookedit>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", 8);
        param[1] = new SqlParameter("@Book_Id", IbForUpdate);
        param[2] = new SqlParameter("@intResult", 0);
        param[2].Direction = ParameterDirection.Output;
        param[3] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        ds = ObjDUT.GetDataSetSP(param, "Usp_Addbook");
        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                bookedit user = new bookedit();
                user.session = dtrow["Fyid"].ToString();
                user.category = dtrow["Category_id"].ToString();
                user.subcategory = dtrow["Subcategory_id"].ToString();
                user.publisher = dtrow["Publisher_id"].ToString();
                user.author = dtrow["Author_id"].ToString();
                user.price = dtrow["Price"].ToString();
                user.purchasedate = dtrow["Purchase_Date"].ToString();
                user.keywords = dtrow["keywordsofBook"].ToString();
                user.Title = dtrow["Book_Title"].ToString();
                user.Description = dtrow["Book_Description"].ToString();
                user.Imagebookname = dtrow["Book_Image"].ToString();
                user.notforissue = dtrow["Book_Notissue_Status"].ToString();
                user.ISBN = dtrow["ISBN"].ToString();
                user.Noofbook = dtrow["NoofBook"].ToString();
                details.Add(user);
            }
        }
        return details.ToArray();
    }
    public class bookedit
    {
        public string session{ get; set; }
        public string category { get; set; }
        public string subcategory { get; set; }
        public string publisher { get; set; }
        public string author { get; set; }
        public string price { get; set; }
        public string purchasedate { get; set; }
        public string keywords { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
        public string Imagebookname { get; set; }
        public string notforissue { get; set; }
        public string ISBN { get; set; }
        public string Noofbook { get; set; }
     
 }
    [WebMethod]
    public static int updatebook(string bookcategory, string booksubcategory, string publisher, string author, string price, string purchasedate, string keywords, string title, string description, string notissue, string fyid, string isbn, string IbForUpdate, string booksrc, string imagebookdata, string bookExtension)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[18];
        param[0] = new SqlParameter("@Category_Id", bookcategory);
        param[1] = new SqlParameter("@Subcategory_Id", booksubcategory);
        param[2] = new SqlParameter("@Publisher_Id", publisher);
        param[3] = new SqlParameter("@Author_Id", author);
        param[4] = new SqlParameter("@Price", price.Replace("~", "'"));
        param[5] = new SqlParameter("@intResult", "0");
        param[5].Direction = ParameterDirection.Output;
        param[6] = new SqlParameter("@mode", 9);
        param[7] = new SqlParameter("@Purchase_Date", purchasedate);
        param[8] = new SqlParameter("@KeywordsofBook", keywords.Replace("~", "'"));
        param[9] = new SqlParameter("@Book_Title", title.Replace("~", "'"));
        param[10] = new SqlParameter("@Book_Description", description.Replace("~", "'"));
        param[11] = new SqlParameter("@Book_Notissue_Status", notissue);
        param[12] = new SqlParameter("@Fyid", fyid);
        param[13] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        param[14] = new SqlParameter("@Book_Id", IbForUpdate);
        param[15] = new SqlParameter("@isbnno", isbn.Replace("~", "'"));
        if (booksrc != "")
        {
            if (booksrc.Contains("base64,"))
            {
                int IndexNo = booksrc.IndexOf("/") + 1;
                int lastIndexNo = booksrc.IndexOf(";");
                int IndexNo1 = booksrc.IndexOf(",") + 1;
                int Pathlength1 = booksrc.Length;
                booksrc = booksrc.Substring(IndexNo1, (Pathlength1 - IndexNo1));
                byte[] vb = Convert.FromBase64String(booksrc);
                string vpathforsaveimage = HttpContext.Current.Request.MapPath("bookimage/") + imagebookdata;
                MasterImageUpload.CreateImage(vb, imagebookdata, bookExtension, vpathforsaveimage, 5);
            }
        }
        param[16] = new SqlParameter("@Book_Image", imagebookdata);
        param[17] = new SqlParameter("@Userid", HttpContext.Current.Session["BrADID"]);
        int result = objdut.ExecuteSqlSP(param, "Usp_Addbook");
        return result;
    }

}