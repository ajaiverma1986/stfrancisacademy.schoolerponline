using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class branchpanel_enquiry_details_contact_enquiry : System.Web.UI.Page
{

    private DataUtility objdut = new DataUtility();
    private Utility objUT = new Utility();
    private SqlParameter[] param = new SqlParameter[0];
    private int totalpage = 0, fyid = 0;
    private CommonClass comm = new CommonClass();
    private string url = "", PageName, query = "", searchvalue = "", fdate, tdate, enqid, eproid = "", duserid = "";
    private int searchitem = 0, count1 = 0;
    private static int branchid = 0;
    DataTable dt, dt1, dt_day, dt23;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                divaftersearching.Visible = false;
                fillgrid();
                BindAllDropDownList();
                getemplist();
                getgrid();
            }
        }
        catch (Exception exp)
        {
            Utility.ViewAlertMessage(this, exp.Message);
        }
    }

    private void getgrid()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("empcode");
        dt.Columns.Add("empname");
        dt.Columns.Add("eid");
        dt.Columns.Add("rowenquiry");
        dt.Columns.Add("leadnequiry");
        dt.Columns.Add("archive");
        dt.Rows.Add();
        grdtrasferdetails.DataSource = dt;
        grdtrasferdetails.DataBind();

    }
    private void getemplist()
    {
        DataTable dtemplist = new DataTable();
        dtemplist.Columns.Add("status");
        dtemplist.Columns.Add("name");
        dtemplist.Columns.Add("refno");
        dtemplist.Rows.Add();
        grdemplist.DataSource = dtemplist;
        grdemplist.DataBind();

    }


    private void fillgrid()
    {
        try
        {
            DataSet ds = objdut.GetDataSetSP("usp_getallenquiry");
            if (ds.Tables.Count > 0)
            {
                gridenquirylist.DataSource = ds.Tables[0];
                gridenquirylist.DataBind();
                lblNoofEnquiury.Text = Convert.ToString(ds.Tables[1].Rows[0]["SumtotEnquiry"]);
                lblRawenqnotdis.Text = Convert.ToString(ds.Tables[1].Rows[0]["SumnotAttenNotDis"]);
                lblRawenqdis.Text = Convert.ToString(ds.Tables[1].Rows[0]["SumnotAttenDis"]);
                lblleadnotdis.Text = Convert.ToString(ds.Tables[1].Rows[0]["SumleadNotDis"]);
                lblleaddis.Text = Convert.ToString(ds.Tables[1].Rows[0]["SumleadDis"]);
                lblApprove.Text = Convert.ToString(ds.Tables[1].Rows[0]["Sumapprove"]);
                lblArchive.Text = Convert.ToString(ds.Tables[1].Rows[0]["Sumarchive"]);
            }
        }
        catch (Exception ex)
        {
        }
    }

    private void fillEnquiry(string product)
    {
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@searbyproduct", product);
        param[1] = new SqlParameter("@pagesize", 150);
        param[2] = new SqlParameter("@pageno", Convert.ToInt32(1));
        gridenquiry.DataSource = objdut.GetDataTableSP(param, "usp_GetenquiryDetails");
        gridenquiry.DataBind();
        //Session["product"] = product;
    }


    protected void gridenquirylist_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "product")
        {
            string product = Convert.ToString(e.CommandArgument);
            divaftersearching.Visible = true;
            divFirst.Visible = false;
            fillEnquiry(product);
        }
    }
    protected void btnBack_Click1(object sender, EventArgs e)
    {
        divaftersearching.Visible = false;
        divFirst.Visible = true;
    }
    protected void BindAllDropDownList()
    {
        DataTable dtcntry = objdut.GetDataTableSP("[usp_getddllist]");
        dtcntry = objdut.GetDataTable("select EnquirySource from EnquirySource_Master where status=1");
        if (dtcntry.Rows.Count > 0)
        {
            ddlenquirysource.DataSource = dtcntry;
            ddlenquirysource.DataValueField = "EnquirySource";
            ddlenquirysource.DataTextField = "EnquirySource";
            ddlenquirysource.DataBind();
            ListItem li = new ListItem("Search By Enquiry Source", "0");
            ddlenquirysource.Items.Insert(0, li);
        }
    }

    [WebMethod]
    public static UserDetails[] BindDatatable(int catid)
    {
        DataSet ds = new DataSet();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_enquirygenraldetails", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter adp = new SqlDataAdapter(cmd);
                cmd.Parameters.Add("@mode", 8);
                cmd.Parameters.Add("@catid", catid);
                adp.Fill(ds);
                DataTable dt = ds.Tables[0];
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.refno = dtrow["refNo"].ToString();
                        user.name = dtrow["name"].ToString();
                        user.eid = dtrow["eid"].ToString();
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
        public string name { get; set; }
        public string eid { get; set; }
    }

    [WebMethod]
    public static UserDetailsauto[] BindDatatableauto(int catid)
    {
        DataSet ds = new DataSet();
        List<UserDetailsauto> details = new List<UserDetailsauto>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_enquirygenraldetails", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter adp = new SqlDataAdapter(cmd);
                cmd.Parameters.Add("@mode", 8);
                cmd.Parameters.Add("@catid", catid);
                cmd.Parameters.Add("@isauto", 1);
                adp.Fill(ds);
                DataTable dt = ds.Tables[0];
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetailsauto user = new UserDetailsauto();
                        user.refno = dtrow["refNo"].ToString();
                        user.name = dtrow["name"].ToString();
                        user.eid = dtrow["eid"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }
    public class UserDetailsauto
    {
        public string refno { get; set; }
        public string name { get; set; }
        public string eid { get; set; }
    }


    [WebMethod]
    public static int distribute(string totalenquiry, string productid,string mode,string userid)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_distributoldenquiry]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@productid", productid);
                cmd.Parameters.Add("@userid", userid);
                cmd.Parameters.Add("@totalenquiry", totalenquiry);
                cmd.Parameters.Add("@mode", mode);
                int result = cmd.ExecuteNonQuery();
                return result;
            }
        }
    }

    [WebMethod]
    public static emplistdetails[] getEnqtransferlist(int catid)
    {
        DataSet ds = new DataSet();
        List<emplistdetails> details = new List<emplistdetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_tranferenquirydeatils", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter adp = new SqlDataAdapter(cmd);
                cmd.Parameters.Add("@productId", catid);
                adp.Fill(ds);
                DataTable dt = ds.Tables[0];
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        emplistdetails user = new emplistdetails();
                        user.eid = dtrow["eid"].ToString();
                        user.empname = dtrow["empname"].ToString();
                        user.empcode = dtrow["empcode"].ToString();
                        user.rowenquiry = dtrow["rowenquiry"].ToString();
                        user.leadnequiry = dtrow["leadnequiry"].ToString();
                        user.archive = dtrow["archive"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }
    public class emplistdetails
    {
        public string eid { get; set; }
        public string empname { get; set; }
        public string empcode { get; set; }
        public string rowenquiry { get; set; }
        public string leadnequiry { get; set; }
        public string archive { get; set; }

    }

    //[WebMethod]
    //public static UserDetails[] BindDatasubtable(string product)
    //{
    //    DataSet ds = new DataSet();
    //    List<UserDetails> details = new List<UserDetails>();
    //    using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
    //    {
    //        using (SqlCommand cmd = new SqlCommand("usp_GetenquiryDetails", con))
    //        {
    //            cmd.CommandType = CommandType.StoredProcedure;
    //            SqlParameter[] param = new SqlParameter[11];
    //            param[0] = new SqlParameter("@searchbydatetype", "enquirydate");
    //            param[1] = new SqlParameter("@searbyproduct", product);
    //            param[2] = new SqlParameter("@pagesize", 150);
    //            param[3] = new SqlParameter("@pageno", Convert.ToInt32(1));
              

    //            cmd.Parameters.Add(param[0]);
    //            cmd.Parameters.Add(param[1]);
    //            cmd.Parameters.Add(param[2]);
    //            cmd.Parameters.Add(param[3]);
               
    //            SqlDataAdapter da = new SqlDataAdapter(cmd);
    //            con.Open();
    //            da.Fill(ds);
    //            if (ds.Tables[0].Rows.Count > 0)
    //            {
    //                foreach (DataRow dtrow in ds.Tables[0].Rows)
    //                {
    //                    UserDetails user = new UserDetails();
    //                    user.RowNumber = Convert.ToInt32(dtrow["rownumber"]);
    //                    user.real_Enqiry_Id = dtrow["real_Enqiry_Id"].ToString();
    //                    user.enquirydate = dtrow["enquirydate"].ToString();
    //                    user.enquirysource = dtrow["enquirysource"].ToString();
    //                    user.enqtype = dtrow["enqtype"].ToString();
    //                    user.name = dtrow["name"].ToString();
    //                    user.mobile = dtrow["mobile"].ToString();
    //                    user.City = dtrow["City"].ToString();
    //                    user.statusname = dtrow["statusname"].ToString();
    //                    user.followupdate = dtrow["followupdate"].ToString();
    //                    user.enquiryid = Convert.ToInt32(dtrow["enquiryid"]);
    //                    user.contactby = dtrow["contactedby"].ToString();
    //                    user.contactdate = dtrow["contacteddate"].ToString();
    //                    details.Add(user);
    //                }
    //            }
    //        }
    //    }
    //    return details.ToArray();
    //}


    //public class UserDetails1
    //{
    //    public int RowNumber { get; set; }

    //    public string real_Enqiry_Id { get; set; }

    //    public string enquirydate { get; set; }

    //    public string enquirysource { get; set; }

    //    public string enqtype { get; set; }

    //    public string name { get; set; }

    //    public string City { get; set; }

    //    public string mobile { get; set; }

    //    public string statusname { get; set; }

    //    public string followupdate { get; set; }

    //    public string contactdate { get; set; }

    //    public string contactby { get; set; }

    //    public int enquiryid { get; set; }

    //}
}

   