using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class HO_category_master : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static Getcategory[] BindGridByJs(string CategoryName)
    {
        DataSet Ds = new DataSet();
        List<Getcategory> TopicDetails = new List<Getcategory>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@CategoryName", CategoryName);
        Ds = Objdut.GetDataSetSP(param, "bind_category_master");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                Getcategory user = new Getcategory();
                user.CID = dtrow["CID"].ToString();
                user.CategoryName = dtrow["CategoryName"].ToString();
                user.satatus = dtrow["satatus"].ToString();
                TopicDetails.Add(user);
            }
        }
        return TopicDetails.ToArray();
    }

    public class Getcategory
    {
        public string CID { get; set; }

        public string CategoryName { get; set; }

        public string satatus { get; set; }

        public string SCID { get; set; }
    }

    [WebMethod]
    public static Getsubcategorymaster[] Bindsubcategory(int cid, int scid)
    {
        DataSet Ds = new DataSet();
        List<Getsubcategorymaster> TopicDetails = new List<Getsubcategorymaster>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@cid", cid);
        param[1] = new SqlParameter("@scid", scid);
        Ds = Objdut.GetDataSetSP(param, "[bind_sub_category]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                Getsubcategorymaster user = new Getsubcategorymaster();
                user.CID = dtrow["CID"].ToString();
                user.CategoryName = dtrow["CategoryName"].ToString();
                user.SCID = dtrow["SCID"].ToString();
                user.SubCategoryName = dtrow["SubCategoryName"].ToString();
                user.SubCategoryStatus = dtrow["SubCategoryStatus"].ToString();
                user.Isdeleted = dtrow["Isdeleted"].ToString();
                TopicDetails.Add(user);
            }
        }
        return TopicDetails.ToArray();
    }

    public class Getsubcategorymaster
    {
        public string CID { get; set; }

        public string CategoryName { get; set; }

        public string SCID { get; set; }

        public string SubCategoryName { get; set; }

        public string SubCategoryStatus { get; set; }

        public string Isdeleted { get; set; }
    }

    [WebMethod]
    public static GetProductDetails[] Bindproductdetail(int cid, int scid, int Pid)
    {
        DataSet Ds = new DataSet();
        List<GetProductDetails> TopicDetails = new List<GetProductDetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@cid", cid);
        param[1] = new SqlParameter("@scid", scid);
        param[2] = new SqlParameter("@Pid", Pid);
        Ds = Objdut.GetDataSetSP(param, "[product_bind]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                GetProductDetails user = new GetProductDetails();
                user.CategoryName = dtrow["CategoryName"].ToString();
                user.SubCategoryName = dtrow["SubCategoryName"].ToString();
                user.Pid = dtrow["Pid"].ToString();
                user.PName = dtrow["PName"].ToString();
                user.Pcode = dtrow["Pcode"].ToString();
                user.product_description = dtrow["product_description"].ToString();
                user.status = dtrow["status"].ToString();
                user.CategoryIsDeleted = dtrow["CategoryIsDeleted"].ToString();
                user.SubCategoryIsDeleted = dtrow["SubCategoryIsDeleted"].ToString();

                TopicDetails.Add(user);
            }
        }
        return TopicDetails.ToArray();
    }

    public class GetProductDetails
    {
        public string CategoryName { get; set; }

        public string SubCategoryName { get; set; }

        public string Pid { get; set; }

        public string PName { get; set; }

        public string Pcode { get; set; }

        public string product_description { get; set; }

        public string status { get; set; }

        public string CategoryIsDeleted { get; set; }

        public string SubCategoryIsDeleted { get; set; }
    }

    [WebMethod]
    public static int AddCategory(string CategoryName)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_categary]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[2];

                param[0] = new SqlParameter("@categoryname", CategoryName.Replace("~", "'"));

                param[1] = new SqlParameter("@intresult", SqlDbType.Int);

                param[1].Direction = ParameterDirection.Output;

                cmd.Parameters.Add(param[0]);

                cmd.Parameters.Add(param[1]);

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }

    [WebMethod]
    public static int AddSubCategory(string cid, string SubCategoryName)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_subcategary]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[3];

                param[0] = new SqlParameter("@cid", cid);

                param[1] = new SqlParameter("@subcategoryname", SubCategoryName.Replace("~","'"));

                param[2] = new SqlParameter("@intresult", SqlDbType.Int);

                param[2].Direction = ParameterDirection.Output;

                cmd.Parameters.Add(param[0]);

                cmd.Parameters.Add(param[1]);

                cmd.Parameters.Add(param[2]);

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }

    [WebMethod]
    public static int AddProduct(string cid, string scid, string PName, string Pcode, string product_description)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_product]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[6];

                param[0] = new SqlParameter("@catid", cid);

                param[1] = new SqlParameter("@subcatid", scid);

                param[2] = new SqlParameter("@productname", PName.Replace("~", "'"));
                param[3] = new SqlParameter("@productcode", Pcode.Replace("~", "'"));

                param[4] = new SqlParameter("@product_description", product_description.Replace("~", "'"));

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
    public static editsubcategory[] editsubcategory_by_ID(int SCID)
    {
        List<editsubcategory> details = new List<editsubcategory>();

        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@SCID", SCID);
        DataTable dts = ObjDUT.GetDataTableSP(param, "bind_sub_category_by_ID");
        foreach (DataRow dtrow in dts.Rows)
        {
            editsubcategory user = new editsubcategory();
            user.CID = dtrow["CID"].ToString();
            user.SubCategoryStatus = dtrow["SubCategoryStatus"].ToString();
            user.CategoryName = dtrow["CategoryName"].ToString();
            user.SubCategoryName = dtrow["SubCategoryName"].ToString();
            details.Add(user);
        }
        return details.ToArray();
    }

    public class editsubcategory
    {
        public string SCID { get; set; }

        public string CID { get; set; }

        public string SubCategoryName { get; set; }

        public string CategoryName { get; set; }

        public string SubCategoryStatus { get; set; }
    }

    [WebMethod]
    public static editcategory[] editcategory_by_ID(int CID)
    {
        List<editcategory> details = new List<editcategory>();

        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];

        param[0] = new SqlParameter("@CID", CID);

        DataTable dts = ObjDUT.GetDataTableSP(param, "bind_category_by_ID");
        foreach (DataRow dtrow in dts.Rows)
        {
            editcategory user = new editcategory();

            user.CategoryName = dtrow["CategoryName"].ToString();

            details.Add(user);
        }
        return details.ToArray();
    }

    public class editcategory
    {
        public string CID { get; set; }

        public string CategoryName { get; set; }
    }

    [WebMethod]
    public static editProduct[] editProduct_by_ID(int Pid)
    {
        List<editProduct> details = new List<editProduct>();

        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];

        param[0] = new SqlParameter("@Pid", Pid);

        DataTable dts = ObjDUT.GetDataTableSP(param, "bind_product_by_id");
        foreach (DataRow dtrow in dts.Rows)
        {
            editProduct user = new editProduct();
            user.CID = dtrow["CID"].ToString();
            user.CategoryName = dtrow["CategoryName"].ToString();
            user.SCID = dtrow["SCID"].ToString();
            user.SubCategoryName = dtrow["SubCategoryName"].ToString();
            user.PName = dtrow["PName"].ToString();
            user.Pcode = dtrow["Pcode"].ToString();
            user.product_description = dtrow["product_description"].ToString();
            details.Add(user);
        }
        return details.ToArray();
    }

    public class editProduct
    {
        public string Pid { get; set; }

        public string SCID { get; set; }

        public string CID { get; set; }

        public string SubCategoryName { get; set; }

        public string CategoryName { get; set; }

        public string PName { get; set; }

        public string Pcode { get; set; }

        public string product_description { get; set; }
    }

    [WebMethod]
    public static int Update_category(int CID, string CategoryName)
    {
        DataUtility ObjDUT = new DataUtility();

        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@CID", CID);
        param[1] = new SqlParameter("@CategoryName", CategoryName.Replace("~","'"));
        param[2] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[2].Direction = ParameterDirection.Output;
        int res = ObjDUT.ExecuteSqlSP(param, "update_category_master");
        return res;
    }

    [WebMethod]
    public static int Update_product(int Pid, int CID, int SCID, string PName, string Pcode, string product_description)
    {
        DataUtility ObjDUT = new DataUtility();

        SqlParameter[] param = new SqlParameter[7];
        param[0] = new SqlParameter("@Pid", Pid);
        param[1] = new SqlParameter("@CID", CID);
        param[2] = new SqlParameter("@SCID", SCID);
        param[3] = new SqlParameter("@PName", PName.Replace("~","'"));
        param[4] = new SqlParameter("@Pcode", Pcode.Replace("~","'"));
        param[5] = new SqlParameter("@product_description", product_description.Replace("~","'"));
        param[6] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[6].Direction = ParameterDirection.Output;
        int res = ObjDUT.ExecuteSqlSP(param, "update_product_master");
        return res;
    }

    [WebMethod]
    public static int Update_Subcategory(int SCID, int CID, string SubCategoryName)
    {
        DataUtility ObjDUT = new DataUtility();

        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@SCID", SCID);
        param[1] = new SqlParameter("@CID", CID);
        param[2] = new SqlParameter("@SubCategoryName", SubCategoryName.Replace("~","'"));
        param[3] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[3].Direction = ParameterDirection.Output;
        int res = ObjDUT.ExecuteSqlSP(param, "update_Subcategory");
        return res;
    }

    [WebMethod]
    public static int DeleteCategory(int CID)
    {
        DataUtility ObjDUT = new DataUtility();
        string q = "update tbl_category set IsDeleted=1,CategoryStatus=0 where CID=" + CID;
        int res = ObjDUT.ExecuteSql(q);
        return res;
    }

    [WebMethod]
    public static int DeleteSubCategory(int SCID)
    {
        DataUtility ObjDUT = new DataUtility();
        string t = "update tbl_SubCategory set IsDeleted=1,SubCategoryStatus=0 where SCID=" + SCID;
        int res = ObjDUT.ExecuteSql(t);
        return res;
    }

    [WebMethod]
    public static int Deleteproduct(int Pid)
    {
        DataUtility ObjDUT = new DataUtility();
        string l = "update Product_Master set IsDeleted=1 where Pid=" + Pid;
        int res = ObjDUT.ExecuteSql(l);
        return res;
    }

    [WebMethod]
    public static getcategory[] bindcategoryddl()
    {
        List<getcategory> details = new List<getcategory>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("Usp_BindCategoryList", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                getcategory objemp = new getcategory();

                foreach (DataRow dtrow in dt.Rows)
                {
                    getcategory obje = new getcategory();
                    obje.CID = Convert.ToInt32(dtrow["CID"].ToString());
                    obje.CategoryName = dtrow["CategoryName"].ToString();
                    details.Add(obje);
                }
            }
        }
        return details.ToArray();
    }

    public class getcategory
    {
        public int CID { get; set; }

        public string CategoryName { get; set; }
    }

    [WebMethod]
    public static Getsubcategory[] bindsubcategoryddl(int CID)
    {
        List<Getsubcategory> details = new List<Getsubcategory>();

        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select SCID,SubCategoryName from tbl_SubCategory where IsDeleted=0 and SubCategoryStatus=1 and CID=" + CID, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                Getsubcategory objemp = new Getsubcategory();

                foreach (DataRow dtrow in dt.Rows)
                {
                    Getsubcategory obje = new Getsubcategory();
                    obje.SCID = Convert.ToInt32(dtrow["SCID"].ToString());
                    obje.SubCategoryName = dtrow["SubCategoryName"].ToString();
                    details.Add(obje);
                }
            }
        }
        return details.ToArray();
    }

    public class Getsubcategory
    {
        public int SCID { get; set; }

        public string SubCategoryName { get; set; }
    }

    [WebMethod]
    public static getproductmaster[] bind_ddl_product(int SCID)
    {
        List<getproductmaster> details = new List<getproductmaster>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select Pid,PName from Product_Master where IsDeleted=0 and status=1 and SCID=" + SCID, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                getproductmaster objemp = new getproductmaster();

                foreach (DataRow dtrow in dt.Rows)
                {
                    getproductmaster obje = new getproductmaster();
                    obje.Pid = Convert.ToInt32(dtrow["Pid"].ToString());
                    obje.PName = dtrow["PName"].ToString();
                    details.Add(obje);
                }
            }
        }
        return details.ToArray();
    }

    public class getproductmaster
    {
        public int Pid { get; set; }

        public string PName { get; set; }
    }

    [WebMethod]
    public static Getcategory_ddl[] bindcategory_ddl()
    {
        List<Getcategory_ddl> details = new List<Getcategory_ddl>();

        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select CID,CategoryName from tbl_category where IsDeleted=0 and CategoryStatus=1", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                Getcategory_ddl objemp = new Getcategory_ddl();

                foreach (DataRow dtrow in dt.Rows)
                {
                    Getcategory_ddl obje = new Getcategory_ddl();
                    obje.CID = Convert.ToInt32(dtrow["CID"].ToString());
                    obje.CategoryName = dtrow["CategoryName"].ToString();
                    details.Add(obje);
                }
            }
        }
        return details.ToArray();
    }

    public class Getcategory_ddl
    {
        public int CID { get; set; }

        public string CategoryName { get; set; }
    }
}