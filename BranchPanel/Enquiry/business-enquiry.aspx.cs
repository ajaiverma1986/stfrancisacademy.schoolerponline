﻿using System;
using System.IO;
using System.Data;
using System.Web.UI;
using System.Web.Services;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Web.UI.HtmlControls;


public partial class branchpanel_business_enquiry : System.Web.UI.Page

{
    private DataUtility objdut = new DataUtility();
    private Utility objUT = new Utility();
    private SqlParameter[] param = new SqlParameter[1];
    private SqlParameter[] param1 = new SqlParameter[6];
    private int totalpage = 0, fyid = 0;
    private CommonClass comm = new CommonClass();
    private string url = "", PageName, query = "", searchvalue = "", fdate, tdate, enqid;
    private int searchitem = 0, count1 = 0;
    private static int branchid = 0;
    DataTable dt, dt1, dt_day, dt23;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {           
            branchid = Convert.ToInt16(Session["BrBrid"]);       
            if (!IsPostBack)
            {
                SendInArchive();
                fillgrid();
                BindAllDropDownList();
                fyid = comm.financialyear("financialyear");
                ViewState["fyid"] = fyid;
                ViewState["noofrecord"] = 50;
                ViewState["PageNo"] = 1;
                fillsource();
                fillMultipleschedule();
                fillMultipleschedule1();
            }
        }
        catch (Exception exp)
        {
            Utility.ViewAlertMessage(this, exp.Message);
        }
    }

    protected void SendInArchive()
    {
        SqlParameter[] paramforarchive = new SqlParameter[2];

        paramforarchive[0] = new SqlParameter("@noofdays", 90);
        paramforarchive[1] = new SqlParameter("@intResult", Convert.ToInt32("0"));

        int result = objdut.ExecuteSqlSP(paramforarchive, "ForSendInArchive");
    
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("enquiry.aspx");
    }

    private void fillgrid()
    {
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@gridtype", "businessgrid");

        param[1] = new SqlParameter("@pagesize", SqlDbType.Int);
        param[1].Value = 100;

        param[2] = new SqlParameter("@pageno", SqlDbType.Int);
        param[2].Value = 1;

        DataSet Ds = objdut.GetDataSetSP(param, "usp_GetenquiryDetails");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            gridenquiry.DataSource = Ds.Tables[0];
            gridenquiry.DataBind();
            trforimagepagging.Style.Add("display", "block");
            hfpages.Value = Ds.Tables[1].Rows[0]["pages"].ToString();
        }
        else
        {
            gridenquiry.EmptyDataText = "No employee list found.";
            trforimagepagging.Style.Add("display", "none");
            gridenquiry.DataBind();
        }
    }

 

    protected void btnAdd1_Click(object sender, EventArgs e)
    {
        Response.Redirect("send-sms.aspx");
    }
    protected void btnAdd13_Click(object sender, EventArgs e)
    {
        Response.Redirect("upload-enquiries.aspx");
    }

    protected void Button5_Click(object sender, EventArgs e)
    {
        Response.Redirect("equdistribution.aspx");
    }

    protected void img_pdffile_Click(object sender, ImageClickEventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
    }


      
    
    [WebMethod]
    public static enquirydetails[] GetEnquiryDetails(int eid)
    {
        DataTable dt = new DataTable();
        List<enquirydetails> result = new List<enquirydetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("MasterProc", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();

                cmd.Parameters.AddWithValue("@whyCall", "getallEnquiry");
                cmd.Parameters.AddWithValue("@BranchId", branchid);
                cmd.Parameters.AddWithValue("@enqid", eid);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    enquirydetails user = new enquirydetails();
                    user.Real_Enqiry_Id = dtrow["Real_Enqiry_Id"].ToString();
                    user.enquirydate = dtrow["enquirydate"].ToString();
                    user.name = dtrow["name"].ToString();
                    if (dtrow["enqtime"].ToString() != "")
                    {
                        user.ddleh1 = dtrow["enqtime"].ToString();
                    }
                    else
                    {
                        user.ddleh1 = "6:00 AM";
                    }

                    user.sourceid = dtrow["sourceid"].ToString();
                    if (dtrow["enqtypeid"].ToString() != "0")
                    {
                        user.enqtypeid = dtrow["enqtypeid"].ToString();
                    }
                    user.name = dtrow["name"].ToString();

                    user.mobile = dt.Rows[0]["mobile"].ToString();

                    if (dtrow["mob2"].ToString() != "")
                    {
                        user.mob2 = dtrow["mob2"].ToString();

                    }
                    else
                    {
                        user.mob2 = "";

                    }

                    if (dtrow["mob3"].ToString() != "")
                    {
                        user.mob3 = dtrow["mob3"].ToString();

                    }
                    else
                    {
                        user.mob3 = "";

                    }
                    user.emailid = dtrow["emailid"].ToString();
                    user.email2 = dtrow["email2"].ToString();
                    user.email3 = dtrow["email3"].ToString();

                    user.city = dtrow["city"].ToString();
                    user.msg = dtrow["messge"].ToString();

                    if (dtrow["contacteddate"].ToString() != "")
                    {
                        if (!string.IsNullOrEmpty(dt.Rows[0]["contacteddate"].ToString()))
                        {
                            if (dt.Rows[0]["contacteddate"].ToString() == "1900-01-01 00:00:00.000")
                            {
                                user.contacteddate = DateTime.Now.ToShortDateString();
                            }
                            else
                            {
                                user.contacteddate = DateTime.Now.ToShortDateString();
                            }
                        }
                    }
                    else
                    {
                        user.contacteddate = DateTime.Now.ToShortDateString();
                    }

                    if (dtrow["contacttimeid"].ToString() != "")
                    {

                        user.contacttimeid = DateTime.Now.ToShortTimeString();
                    }
                    else
                    {
                        user.contacttimeid = "0";
                    }
                    if (dtrow["contactedby"].ToString() != "")
                    {
                        user.contactedby = dtrow["contactedby"].ToString();
                    }
                    else
                    {
                        user.contactedby = "";
                    }
                    if (dtrow["followupdate"].ToString() != "")
                    {
                        user.followupdate = DateTime.Now.ToShortDateString();
                    }
                    else
                    {
                        user.followupdate = DateTime.Now.ToShortDateString();
                    }
                    if (dtrow["followuptimeid"].ToString() != "")
                    {
                        user.followuptimeid = DateTime.Now.ToShortTimeString();
                    }
                    else
                    {
                        user.followuptimeid = DateTime.Now.ToShortTimeString();
                    }
                    if (dtrow["remarks"].ToString() != "")
                    {
                        user.remarks = dtrow["remarks"].ToString();
                    }
                    else
                    {
                        user.remarks = "";
                    }
                    if (dtrow["quoation"].ToString() == Convert.ToString(1))
                    {
                        user.quoation = "true";

                    }
                    else
                    {
                        user.quoation = "false";
                    }
                    user.status = dtrow["status"].ToString();


                    result.Add(user);
                }
            }
        }
        return result.ToArray();
    }

    public class enquirydetails
    {
        public string Real_Enqiry_Id { get; set; }
        public string enquirydate { get; set; }
        public string ddleh1 { get; set; }
        public string name { get; set; }
        public string sourceid { get; set; }
        public string enqtypeid { get; set; }
        public string mobile { get; set; }
        public string mob2 { get; set; }
        public string mob3 { get; set; }
        public string emailid { get; set; }
        public string email2 { get; set; }
        public string email3 { get; set; }
        public string city { get; set; }
        public string msg { get; set; }
        public string contacteddate { get; set; }
        public string contacttimeid { get; set; }
        public string contactedby { get; set; }
        public string followupdate { get; set; }
        public string followuptimeid { get; set; }
        public string remarks { get; set; }
        public string quoation { get; set; }
        public string status { get; set; }

    }



    private void fillsource()
    {
        string q1 = "usp_bindsourceProductstatus";
        DataSet ds = objdut.GetDataSetSP(q1);
        dt = ds.Tables[0];
        if (dt.Rows.Count > 0)
        {
            ddlenquiry.DataSource = dt;
            ddlenquiry.DataTextField = "EnquirySource";
            ddlenquiry.DataValueField = "id";
            ddlenquiry.DataBind();
            ddlenquiry.Items.Insert(0, new ListItem("--Select Status--", "0"));
        }



        dt23 = ds.Tables[1];
        if (dt23.Rows.Count > 0)
        {
            ddlstatus.DataSource = dt23;
            ddlstatus.DataTextField = "statusname";
            ddlstatus.DataValueField = "esid";
            ddlstatus.DataBind();
            ddlstatus.Items.Insert(0, new ListItem("--Select Status--", "0"));
        }


        DataTable dtcntry = objdut.GetDataTable("select classid,Classname from ClassBranch_master where BranchId=1 and status =1");
        ddlproduct.DataSource = dtcntry;
        ddlproduct.DataValueField = "Classname";
        ddlproduct.DataTextField = "Classname";
        ddlproduct.DataBind();
        ListItem li = new ListItem("--Select Class--", "0");
        ddlproduct.Items.Insert(0, li);
    }
    public List<string> GetTimeIntervals()
    {
        List<string> timeIntervals = new List<string>();
        DateTime date = DateTime.MinValue.AddHours(6); // start at 6am
        DateTime endDate = DateTime.MinValue.AddDays(1).AddHours(6); // end at 5:45am (< 6am)

        while (date < endDate)
        {
            timeIntervals.Add(date.ToShortTimeString());
            date = date.AddMinutes(1);
        }

        return timeIntervals;
    }
    private void fillMultipleschedule()
    {
        ddlsh.DataSource = GetTimeIntervals();
        ddlsh.DataBind();
      //  ddlsh.DataSource = GetTimeIntervals();
      //  ddlsh.DataBind();

        ddleh1.DataSource = GetTimeIntervals();
        ddleh1.DataBind();
      //  ddleh1.DataSource = GetTimeIntervals();
      //  ddleh1.DataBind();
    }

    private void fillMultipleschedule1()
    {
        //ddleh.DataSource = GetTimeIntervals();
        //ddleh.DataBind();
       // ddleh.DataSource = GetTimeIntervals();
       // ddleh.DataBind();
    }

    protected void BindAllDropDownList()
    {
       
        DataTable dtcntry = objdut.GetDataTable("select classid,Classname from ClassBranch_master where BranchId=1 and status =1");
        ddlproduct.DataSource = dtcntry;
        ddlproduct.DataValueField = "Classname";
        ddlproduct.DataTextField = "Classname";
        ddlproduct.DataBind();
        ListItem li = new ListItem("--Select Class--", "0");
        ddlproduct.Items.Insert(0, li);
        dtcntry.Dispose();
        dtcntry = objdut.GetDataTable("select EnquirySource from EnquirySource_Master where status=1");

        if (dtcntry.Rows.Count > 0)
        {
            ddlenquirysource.DataSource = dtcntry;
            ddlenquirysource.DataValueField = "EnquirySource";
            ddlenquirysource.DataTextField = "EnquirySource";
            ddlenquirysource.DataBind();
            ddlenquirysource.Items.Insert(0, new ListItem("--Enquiry--", "0"));
            
        }


        dtcntry = objdut.GetDataTable("select statusname from tbl_enquirystatusmaster where status=1");

        if (dtcntry.Rows.Count > 0)
        {
            ddlsearchingstatus.DataSource = dtcntry;
            ddlsearchingstatus.DataValueField = "statusname";
            ddlsearchingstatus.DataTextField = "statusname";
            ddlsearchingstatus.DataBind();
            ListItem li1 = new ListItem("Search By Status", "0");
            ddlsearchingstatus.Items.Insert(0, li1);
        }
    }
}

   