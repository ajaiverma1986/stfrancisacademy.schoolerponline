using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HO_add_category : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    //*********************************************add category********************************************
    [WebMethod]
    public static int savecategory(string categoryname,string settingstatus)
    {

        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@categoryname", categoryname.Replace("~", "'"));
        param[1] = new SqlParameter("@category_status", settingstatus);
        param[2] = new SqlParameter("@intResult", 0);
        param[2].Direction = ParameterDirection.Output;
        param[3] = new SqlParameter("@mode", 5);
        int result = objdut.ExecuteSqlSP(param, "usp_Publisher_master");
        return result;
    }
    //******************************************************get categorylist***************************************

    [WebMethod]
    public static categorylist[] fillcategorylist()
    {
        DataSet ds = new DataSet();
        List<categorylist> details = new List<categorylist>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 6);
        param[1] = new SqlParameter("@intResult", 0);
        param[1].Direction = ParameterDirection.Output;
        ds = ObjDUT.GetDataSetSP(param, "usp_Publisher_master");
        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                categorylist user = new categorylist();
                user.categoryid = dtrow["CatId"].ToString();
                user.Categoryname = dtrow["CategoryName"].ToString();
                user.SubCategoryname = dtrow["SubCategoryName"].ToString();
                details.Add(user);
            }
        }
        return details.ToArray();
    }

    public class categorylist
    {
     
        public string categoryid { get; set; }
        public string Categoryname { get; set; }
       public string SubCategoryname { get; set; }

    }

    //**************************************************update category*************************************************
    [WebMethod]
    public static int updatecategory(string valuectegoryid, string categorydata)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@category_id", valuectegoryid);
        param[1] = new SqlParameter("@categoryname", categorydata.Replace("`", "'"));
        param[2] = new SqlParameter("@mode", 8);
        param[3] = new SqlParameter("@intResult", "0");
        param[3].Direction = ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, "usp_Publisher_master");
        return result;
    }

 //*******************************************************Bind category ddl for subcategory**********************************************************************
    [WebMethod]
    public static getcategoryforsubcategory[] bindcategory()
    {
        List<getcategoryforsubcategory> Details = new List<getcategoryforsubcategory>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 9);
        param[1] = new SqlParameter("@intResult", "0");
        param[1].Direction = ParameterDirection.Output;
        Dt = Objdut.GetDataTableSP(param, "usp_Publisher_master");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                getcategoryforsubcategory obje = new getcategoryforsubcategory();
                obje.id = Convert.ToInt32(Dt.Rows[i]["ID"]);
                obje.category = Convert.ToString(Dt.Rows[i]["catename"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }

    public class getcategoryforsubcategory
    {
        public int id { get; set; }

        public string category { get; set; }
    }
    //*********************************************add  sub category********************************************
    [WebMethod]
    public static int savesubcategory(string categoryidforsub, string subcategoryname, string settingstatusfoesubcat)
    {

        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@category_id", categoryidforsub);
        param[1] = new SqlParameter("@subcategory_name", subcategoryname.Replace("~", "'"));
        param[2] = new SqlParameter("@subcategory_status", settingstatusfoesubcat);
        param[3] = new SqlParameter("@intResult", 0);
        param[3].Direction = ParameterDirection.Output;
        param[4] = new SqlParameter("@mode", 10);
        int result = objdut.ExecuteSqlSP(param, "usp_Publisher_master");
        return result;
    }

    //******************************************************get subcategorycategorylist***************************************

    [WebMethod]
    public static subcategorylist[] fillsubcategorylist(string subcategorynamesearch, string categorydataid)
    {
        DataSet ds = new DataSet();
        List<subcategorylist> details = new List<subcategorylist>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode",11);
        param[1] = new SqlParameter("@intResult", 0);
        param[1].Direction = ParameterDirection.Output;
        param[2] = new SqlParameter("@subcategory_name", subcategorynamesearch.Replace("~", "'"));
        param[3] = new SqlParameter("@category_id", categorydataid);
        ds = ObjDUT.GetDataSetSP(param, "usp_Publisher_master");
        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                subcategorylist user = new subcategorylist();
                user.SubCateid = dtrow["subcategory_Id"].ToString();
                user.catid = dtrow["category_ID"].ToString();
                user.Catname = dtrow["catename"].ToString();
                user.SubCatname = dtrow["subcategoryname"].ToString();
                user.SubStatus = dtrow["subcategorystatus"].ToString();
                details.Add(user);
            }
        }
        return details.ToArray();
    }

    public class subcategorylist
    {
        public string SubCateid { get; set; }
        public string catid { get; set; }
        public string Catname { get; set; }
        public string SubCatname { get; set; }
        public string SubStatus { get; set; }

    }
    //********************************************web method for edit subcategory*******************************************
    [WebMethod]
    public static subcategoryedit[] Editdetailofsubcategory(string subcategoryid)
    {
        DataSet ds = new DataSet();
        List<subcategoryedit> details = new List<subcategoryedit>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode",12);
        param[1] = new SqlParameter("@subcategory_id", subcategoryid);
        param[2] = new SqlParameter("@intResult", 0);
        param[2].Direction = ParameterDirection.Output;
        ds = ObjDUT.GetDataSetSP(param, "usp_Publisher_master");
        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                subcategoryedit user = new subcategoryedit();
                user.categoryidforsub = dtrow["Category_id"].ToString();
                user.Subcatenameforedit = dtrow["Subcategory_name"].ToString();
                user.Subcatstatus = dtrow["subcategory_status"].ToString();
                user.Subcatid = dtrow["subcategoryid"].ToString();
                details.Add(user);
            }
        }
        return details.ToArray();
    }

    public class subcategoryedit
    {
        public string categoryidforsub { get; set; }
        public string Subcatenameforedit { get; set; }
        public string Subcatid { get; set; }
        public string Subcatstatus { get; set; }
    }
    //**************************************************update sub category*************************************************
    [WebMethod]
    public static int updatesubcategory(string ecatidforsucategory, string esubcategoryname, string esubsettingstatus, string subcategoryid)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@category_id", ecatidforsucategory);
        param[1] = new SqlParameter("@subcategory_name", esubcategoryname.Replace("~", "'"));
        param[2] = new SqlParameter("@subcategory_status", esubsettingstatus);
        param[3] = new SqlParameter("@intResult", "0");
        param[3].Direction = ParameterDirection.Output;
        param[4] = new SqlParameter("@mode",13);
        param[5] = new SqlParameter("@subcategory_id", subcategoryid);
        int result = objdut.ExecuteSqlSP(param, "usp_Publisher_master");
        return result;
    }
}