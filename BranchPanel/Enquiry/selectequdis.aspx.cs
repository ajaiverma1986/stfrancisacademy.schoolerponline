using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;

public partial class BranchPanel_enquiry_details_selectequdis : System.Web.UI.Page
{
    private string url, quer = "", quer1 = "";
    private DataUtility objdut = new DataUtility();
    private DataUtility objdataut = new DataUtility();

    private DataTable dt1, dt2,dt3;
    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!IsPostBack)
        {
            bindgrid();
            fillDll();
            fillproduct();
            DataTable dt = new DataTable();
            dt.Columns.Add("refNo");
            dt.Columns.Add("username");
            dt.Columns.Add("department");
            dt.Columns.Add("MLM");
            dt.Columns.Add("MLMcount");
            dt.Columns.Add("ERP");
            dt.Columns.Add("ERPcount");
            dt.Columns.Add("WEbportal");
            dt.Columns.Add("WEbcount");
            dt.Columns.Add("onlinemarket");
            dt.Columns.Add("onlincount");
            dt.Columns.Add("Otherstatus");
            dt.Columns.Add("Othercount");
            dt.Columns.Add("status");
            dt.Rows.Add();
            grdNoRight.DataSource = dt;
            grdNoRight.DataBind();

            DataTable dttotalenquiry = new DataTable();
            dttotalenquiry.Columns.Add("noofenquiry");
            dttotalenquiry.Columns.Add("ecatid");
            dttotalenquiry.Columns.Add("pid");
            dttotalenquiry.Rows.Add();
            GridView1.DataSource = dttotalenquiry;
            GridView1.DataBind();

            DataTable dtactdeact = new DataTable();
            dtactdeact.Columns.Add("ecatname");
            dtactdeact.Columns.Add("eqid");
            dtactdeact.Columns.Add("productid");
            dtactdeact.Rows.Add();
            grdactdeactuser.DataSource = dtactdeact;
            grdactdeactuser.DataBind();


            DataTable dtforfit = new DataTable();
            dtforfit.Columns.Add("catid");
            dtforfit.Columns.Add("catname");
            dtforfit.Columns.Add("totalcount");
            dtforfit.Rows.Add();
            grdforfitenquiry.DataSource = dtforfit;
            grdforfitenquiry.DataBind();


            DataTable dtdeactivecatlist = new DataTable();
            dtdeactivecatlist.Columns.Add("catname");
            dtdeactivecatlist.Columns.Add("deacatid");
            dtdeactivecatlist.Rows.Add();
            grddeactivecatlist.DataSource = dtdeactivecatlist;
            grddeactivecatlist.DataBind();

            DataTable dtsungrid = new DataTable();
            dtsungrid.Columns.Add("real_Enqiry_Id");
            dtsungrid.Columns.Add("enquirydate");
            dtsungrid.Columns.Add("name");
            dtsungrid.Columns.Add("mobile");
            dtsungrid.Columns.Add("enquirysource");
            dtsungrid.Columns.Add("statusname");
            dtsungrid.Columns.Add("city");
            dtsungrid.Columns.Add("assigndate");
            dtsungrid.Rows.Add();
            gridsubenquiry.DataSource = dtsungrid;
            gridsubenquiry.DataBind();

        }
    }

    private void fillproduct()
    {
        DataTable dtcntry = objdut.GetDataTableSP("[usp_getddllist]");
        if (dtcntry.Rows.Count > 0)
        {
            ddlproduct.DataSource = dtcntry;
            ddlproduct.DataValueField = "productname";
            ddlproduct.DataTextField = "productname";
            ddlproduct.DataBind();
            ListItem li = new ListItem("--Select Product--", "0");
            ddlproduct.Items.Insert(0, li);
        }
    }

  
    public void fillDll()
    {
        DataTable dt = objdataut.GetDataTableSP("usp_getEmployee");
        if (dt.Rows.Count > 0)
        {
            ddluser.DataSource = dt;
            ddluser.DataValueField = "userid";
            ddluser.DataTextField = "name";
            ddluser.DataBind();
        }
    }

  

    [WebMethod]
    public static UserDetails[] BindDatatable(int mode)
    {
        DataSet ds = new DataSet();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_EmpEnqReport", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter adp = new SqlDataAdapter(cmd);
                cmd.Parameters.Add("@mode", mode);
                adp.Fill(ds);
                DataTable dt = ds.Tables[0];
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.refno = dtrow["refno"].ToString(); 
                        user.username = dtrow["username"].ToString();
                        user.department = dtrow["department"].ToString();
                        user.MLM = dtrow["MLMstatus"].ToString();
                        user.MLMcount = dtrow["MLMcount"].ToString();
                        user.ERP = dtrow["ERPstatus"].ToString();
                        user.ERPcount = dtrow["ERPcount"].ToString();
                        user.WebPortal = dtrow["Webstatus"].ToString();
                        user.Webcount = dtrow["Webcount"].ToString();
                        user.onlinemarket = dtrow["onlinestatus"].ToString();
                        user.onlincount = dtrow["onlincount"].ToString();
                        user.Otherstatus = dtrow["Otherstatus"].ToString();
                        user.Othercount = dtrow["Othercount"].ToString();
                        user.userid = dtrow["userid"].ToString();
                        user.status = dtrow["status"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }
    public class UserDetails
    {
        public string refno { get; set; }

        public string userid { get; set; }

        public string username { get; set; }

        public string department { get; set; }

        public string MLM { get; set; }

        public string MLMcount { get; set; }

        public string ERP { get; set; }

        public string ERPcount { get; set; }

        public string WebPortal { get; set; }

        public string onlinemarket { get; set; }
        public string onlincount { get; set; }

        public string Webcount { get; set; }

        public string Otherstatus { get; set; }

        public string Othercount { get; set; }

        public string status { get; set; }
       
    }

    public void bindgrid()
    {
        string a = @"select id,ecatname from tbl_enquiryproductcategory";  //eq.userid=" + Session["equid"] + " and
        DataTable dt = objdut.GetDataTable(a);
        if (dt.Rows.Count > 0)
        {
            grd1.DataSource = dt;
            grd1.DataBind();
        }
    }

    [WebMethod]
    public static getproduct[] getproductslist(string eid)
    {
        DataSet ds = new DataSet();
        List<getproduct> details = new List<getproduct>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_enquirygenraldetails]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@eid ", eid);
                cmd.Parameters.AddWithValue("@mode", 1);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getproduct user = new getproduct();
                        user.ecatname = dtrow["ecatname"].ToString();
                        user.status = dtrow["status"].ToString();
                        user.id = dtrow["id"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getproduct
    {
        public string ecatname { get; set; }
        public string status { get; set; }
        public string id { get; set; }
    }

    [WebMethod]
    public static gettotalenquirys[] gettotalenquiry(string eid)
    {
        DataSet ds = new DataSet();
        List<gettotalenquirys> details = new List<gettotalenquirys>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_enquirygenraldetails]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@eid ", eid);
                cmd.Parameters.AddWithValue("@mode", 2);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        gettotalenquirys user = new gettotalenquirys();
                        user.noofenquiry = dtrow["noofenquiry"].ToString();
                        user.pid = dtrow["pid"].ToString();
                        user.ecatid = dtrow["ecatid"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class gettotalenquirys
    {
        public string noofenquiry { get; set; }
        public string pid { get; set; }
        public string ecatid { get; set; }
        
    }

    [WebMethod]
    public static int addremoveuser(string productid, string userid)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_giveandtakeenquirypermission]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@userid", userid);
                cmd.Parameters.Add("@ecatid", productid);
                cmd.Parameters.Add("@mode", 1);
                int result = cmd.ExecuteNonQuery();
                return result;
            }
        }
    }

    [WebMethod]
    public static getcategorydetails[] getcategory(string eid)
    {
        DataSet ds = new DataSet();
        List<getcategorydetails> details = new List<getcategorydetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_giveandtakeenquirypermission]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@userid", eid);
                cmd.Parameters.AddWithValue("@mode", 3);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getcategorydetails user = new getcategorydetails();
                        user.ecatname = dtrow["ecatname"].ToString();
                        user.userid = dtrow["eqid"].ToString();
                        user.productid = dtrow["ecatid"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }
    public class getcategorydetails
    {
        public string ecatname { get; set; }
        public string userid { get; set; }
        public string productid { get; set; }
    }
    [WebMethod]
    public static int activeusercategory(string productid, string enquiryque)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_giveandtakeenquirypermission]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@enquiryque", enquiryque);
                cmd.Parameters.Add("@ecatid", productid);
                cmd.Parameters.Add("@mode", 2);
                int result = cmd.ExecuteNonQuery();
                return result;
            }
        }
    }
    [WebMethod]
    public static int changepermission(string enquiryque, string isboth)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_giveandtakeenquirypermission]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@enquiryque", enquiryque);
                cmd.Parameters.Add("@mode", 6);
                cmd.Parameters.Add("@isboth", isboth);
                int result = cmd.ExecuteNonQuery();
                return result;
            }
        }
    }
    [WebMethod]
    public static getremovecatlist[] gerremovecatnames(string eid)
    {
        DataSet ds = new DataSet();
        List<getremovecatlist> details = new List<getremovecatlist>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_giveandtakeenquirypermission]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@userid", eid);
                cmd.Parameters.AddWithValue("@mode", 4);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getremovecatlist user = new getremovecatlist();
                        user.product = dtrow["product"].ToString();
                        user.totalcount = dtrow["totalcount"].ToString();
                        user.catid = dtrow["catid"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }
    public class getremovecatlist
    {
        public string product { get; set; }
        public string totalcount { get; set; }
        public string catid { get; set; }
    }

    [WebMethod]
    public static deactusercat[] deactiveusercategory(string eid)
    {
        DataSet ds = new DataSet();
        List<deactusercat> details = new List<deactusercat>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_giveandtakeenquirypermission]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@userid", eid);
                cmd.Parameters.AddWithValue("@mode", 5);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        deactusercat user = new deactusercat();
                        user.deactivecatname = dtrow["ecatname"].ToString();
                        user.deacatid = dtrow["eqid"].ToString();
                        user.activestatus = dtrow["is_autodist"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }
    public class deactusercat
    {
        public string deactivecatname { get; set; }
        public string deacatid { get; set; }
        public string activestatus { get; set; }
    }

    [WebMethod]
    public static int forefitenquiry(string eid, string enquiryque)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_giveandtakeenquirypermission]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@enquiryque", enquiryque);
                cmd.Parameters.Add("@userid", eid);
                cmd.Parameters.Add("@mode", 7);
                int result = cmd.ExecuteNonQuery();
                return result;
            }
        }
    }

    [WebMethod]
    public static getsubenquiryproduct[] getsubenquiry(string eid,string catid,string productid,string pageno)
    {
        DataSet ds = new DataSet();
        List<getsubenquiryproduct> details = new List<getsubenquiryproduct>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_enquirygenraldetails]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@eid ", eid);
                cmd.Parameters.AddWithValue("@mode", 9);
                cmd.Parameters.AddWithValue("@catid", catid);
                cmd.Parameters.AddWithValue("@productid", productid);
                cmd.Parameters.AddWithValue("@pageno", Convert.ToInt32(pageno));
                cmd.Parameters.AddWithValue("@pagesize", 50);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[1].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[1].Rows)
                    {
                        getsubenquiryproduct user = new getsubenquiryproduct();
                        user.Real_Enqiry_Id = dtrow["Real_Enqiry_Id"].ToString();
                        user.enquirydate = dtrow["enquirydate"].ToString();
                        user.name = dtrow["name"].ToString();
                        user.mobile = dtrow["mobile"].ToString();
                        user.enquirysource = dtrow["enquirysource"].ToString();
                        user.city = dtrow["city"].ToString();
                        user.statusname = dtrow["statusname"].ToString();
                        user.assigndate = dtrow["assigndate"].ToString();
                        user.enquiryid = dtrow["enquiryid"].ToString();
                        user.pagecount = ds.Tables[2].Rows[0]["pages"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getsubenquiryproduct
    {
        public string enquiryid { get; set; }
        public string Real_Enqiry_Id { get; set; }
        public string enquirydate { get; set; }
        public string name   { get; set; }
        public string mobile { get; set; }
        public string enquirysource { get; set; }
        public string city { get; set; }
        public string statusname { get; set; }
        public string assigndate { get; set; }
        public string pagecount { get; set; }

    }

    [WebMethod]
    public static getproducts[] getproductname(string catid)
    {
        DataSet ds = new DataSet();
        List<getproducts> details = new List<getproducts>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_enquirygenraldetails]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@mode", 9);
                cmd.Parameters.AddWithValue("@catid", catid);
                cmd.Parameters.AddWithValue("@eid",1);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                getproducts objdeg = new getproducts();
                objdeg.productid = "0";
                objdeg.productname = "-Select Product -";
                details.Add(objdeg);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getproducts user = new getproducts();
                        user.productid = dtrow["id"].ToString();
                        user.productname = dtrow["productname"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }
    public class getproducts
    {
        public string productid { get; set; }
        public string productname { get; set; }
    }

    [WebMethod]
    public static getenquirydetails[] getperformance(string eid, string catid)
    {
        DataSet ds = new DataSet();
        List<getenquirydetails> details = new List<getenquirydetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_getEnquiryStatusEmployee]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("eid", eid);
                param[1] = new SqlParameter("@catid", catid);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getenquirydetails user = new getenquirydetails();
                        user.rowEnquiry = dtrow["rowEnquiry"].ToString();
                        user.leadEnquiry = dtrow["leadEnquiry"].ToString();
                        user.approveEnquiry = dtrow["approveEnquiry"].ToString();
                        user.archiveEnquiry = dtrow["archiveEnquiry"].ToString();
                        user.empname = dtrow["empname"].ToString();
                       
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }
    public class getenquirydetails
    {
        public string rowEnquiry { get; set; }
        public string leadEnquiry { get; set; }
        public string approveEnquiry { get; set; }
        public string archiveEnquiry { get; set; }
        public string empname { get; set; }
       
    }
}
