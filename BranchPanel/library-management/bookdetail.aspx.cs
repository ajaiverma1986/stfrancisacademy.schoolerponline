using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_library_management_bookdetail : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private SqlParameter[] param = new SqlParameter[19];
    private DataTable dt;
    private SqlParameter[] param1 = new SqlParameter[3];

    protected void Page_Load(object sender, EventArgs e)
    {
       
    }

    //******************************************************get booklist***************************************

    [WebMethod]
    public static booklistlist[] fillbooklist(string bookid, string isbn, string title, string category, string publisher, string author, string fyid, string subcategory, string keywords)
    {
        DataSet ds = new DataSet();
        List<booklistlist> details = new List<booklistlist>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[12];
        param[0] = new SqlParameter("@mode", 6);
        param[1] = new SqlParameter("@intResult", 0);
        param[1].Direction = ParameterDirection.Output;
        param[2] = new SqlParameter("@Book_Id", bookid.Replace("~", "'"));
        param[3] = new SqlParameter("@isbnno", isbn.Replace("~", "'"));
        param[4] = new SqlParameter("@Book_Title", title.Replace("~", "'"));
        param[5] = new SqlParameter("@Category_Id", category);
        param[6] = new SqlParameter("@Publisher_Id", publisher);
        param[7] = new SqlParameter("@Author_Id", author);
        param[8] = new SqlParameter("@Fyid", fyid);
        param[9] = new SqlParameter("@Subcategory_Id", subcategory);
        param[10] = new SqlParameter("@KeywordsofBook", keywords.Replace("~", "'"));
        param[11] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        ds = ObjDUT.GetDataSetSP(param, "Usp_Addbook");

        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                booklistlist user = new booklistlist();
                user.rownumber = dtrow["rownumber"].ToString();
                user.Bookid = dtrow["Book_Id"].ToString();
                user.ISBN = dtrow["ISBN"].ToString();
                user.Title = dtrow["Book_Title"].ToString();
                user.keywords = dtrow["KeywordsofBook"].ToString();
                details.Add(user);
            }
        }
        return details.ToArray();
    }

    public class booklistlist
    {
        public string rownumber{ get; set; }
        public string Bookid{ get; set; }
        public string ISBN{ get; set; }
        public string Title{ get; set; }
        public string keywords{ get; set; }
    }


    //**********************************************bindcategory************************************************************
    [WebMethod]
    public static getcategory[] Bindcategory()
    {
        List<getcategory> Details = new List<getcategory>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 1);
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
    //*******************************************************delete book*************************************************************************************

    [WebMethod]
    public static int deletebook(string bookidfordelete)
    {
        SqlParameter[] param = new SqlParameter[4];
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_Addbook]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                param[0] = new SqlParameter("@Book_Id", bookidfordelete);
                param[1] = new SqlParameter("@mode", 7);
                param[2] = new SqlParameter("@intresult",0);
                param[2].Direction = ParameterDirection.Output;
                param[3] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);

                for (int i = 0; i < param.Length; i++)
                {
                    cmd.Parameters.Add(param[i]);
                }
                cmd.ExecuteNonQuery();
                int ret = Convert.ToInt16(cmd.Parameters["@intresult"].Value);
                return ret;
            }
        }
    }

}