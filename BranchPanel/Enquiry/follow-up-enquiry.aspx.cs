using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class branchpanel_follow_up : System.Web.UI.Page
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
    private DataTable dt, dt1, dt_day, dt23, dt231;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            branchid = Convert.ToInt16(Session["BrBrid"]); 
            if (!IsPostBack)
            {
                fyid = comm.financialyear("financialyear");
                ViewState["fyid"] = fyid;
                ViewState["noofrecord"] = 50;
                ViewState["PageNo"] = 1;
                fillgrid();
                SendInArchive();
                fillsource();
                
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

    private void fillgrid()
    {
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@gridtype", "followupgrid");

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
            gridenquiry.EmptyDataText = "OOPS!! There is not any enquiry for followup";
            trforimagepagging.Style.Add("display", "none");
            gridenquiry.DataBind();
        }

    }

    [WebMethod]
    public static int sendsmsonmobile(string mobile, string msg)
    {
        string mobileno = mobile;
        string sender = "Awapal Office";
        string message = msg;
        if (HttpContext.Current.Session["brbrid"].ToString() != "")
        {
            result1 = sendMessageToMobile.SMSSend(mobileno, sender, HttpContext.Current.Session["brbrid"].ToString());
        }
        return result1;
    }

    //protected void btnAdd1_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("send-sms.aspx");
    //}

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        gridenquiry.AllowPaging = false;
        gridenquiry.Columns[11].Visible = false;
        PrepareGridViewForExport(gridenquiry);
        ExportGridView();
        
    }
   public override void VerifyRenderingInServerForm(Control control)
    {
        return;
    }
    private void PrepareGridViewForExport(Control gv)
    {
        Label lb = new Label();
        Literal l = new Literal();
        string name = String.Empty;
        for (int i = 0; i < gv.Controls.Count; i++)
        {
            if (gv.Controls[i].GetType() == typeof(Label))
            {
                l.Text = (gv.Controls[i] as Label).Text;
                gv.Controls.Remove(gv.Controls[i]);
                gv.Controls.AddAt(i, l);
            }
            if (gv.Controls[i].HasControls())
            {
                PrepareGridViewForExport(gv.Controls[i]);
            }
        }
    }
    private void ExportGridView()
    {
        string attachment = "attachment; filename=viewenquiry.xls";
        Response.Clear();
        Response.ClearContent();
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.AddHeader("content-disposition", attachment);
        Response.ContentEncoding = System.Text.Encoding.Default;
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        // Create a form to contain the grid      
        HtmlForm frm = new HtmlForm();
        gridenquiry.Parent.Controls.Add(frm);
        frm.Attributes["runat"] = "server";
        frm.Controls.Add(gridenquiry);
        frm.RenderControl(htw);
        // StateGrid.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }

    //protected void btnAdd13_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("upload-enquiries.aspx");
    //}

    //protected void Button5_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("equdistribution.aspx");
    //}

    //protected void img_pdffile_Click(object sender, ImageClickEventArgs e)
    //{
    //}

    //protected void btnSubmit_Click(object sender, EventArgs e)
    //{
    //}

    [WebMethod]
    public static int UpdateEnquiry(string enquirydate, string source, int sourceid, string name, string femail, string fmobile, string statustxt,
        int statusid, string contactdate, string followuptime, int followuptimeid, string contactby, string followupdate, string contacttime, int contacttimeid
        , string remark, string landlineno, string city, string msg, string email2, string email3, string mob2, string mob3, int enquirytypeid, string enquirytypetxt, int eid)
    {
        DataUtility Objutl = new DataUtility();

        SqlParameter[] param = new SqlParameter[31];
        param[0] = new SqlParameter("@mode", "updateenquiry");
        param[1] = new SqlParameter("@enquirydate", enquirydate.Trim());
        param[2] = new SqlParameter("@source", source.Trim());

        param[3] = new SqlParameter("@sourceid", sourceid);
        param[4] = new SqlParameter("@name", name.Trim());

        param[5] = new SqlParameter("@emailid", femail.Trim());
        param[6] = new SqlParameter("@mobileno", fmobile.Trim());

        param[7] = new SqlParameter("@brid", branchid);

        if (statusid != 0)
        {
            param[8] = new SqlParameter("@status", statustxt);
            param[9] = new SqlParameter("@statusid", statusid);
        }
        else
        {
            param[8] = new SqlParameter("@status", "");
            param[9] = new SqlParameter("@statusid", 0);
        }
        param[10] = new SqlParameter("@contacteddate", contactdate.Trim());

        if (followuptimeid != 0)
        {
            param[11] = new SqlParameter("@followuptime", followuptime);
            param[12] = new SqlParameter("@followuptimeid", followuptimeid);
        }
        else
        {
            param[11] = new SqlParameter("@followuptime", "");
            param[12] = new SqlParameter("@followuptimeid", followuptimeid);
        }

        param[13] = new SqlParameter("@contactdey", contactby.Trim());

        if (followupdate.Trim() == "")
        {
            param[14] = new SqlParameter("@followupdate", "");
        }
        else
        {
            param[14] = new SqlParameter("@followupdate", followupdate.Trim());
        }

        if (contacttimeid != 0)
        {
            param[15] = new SqlParameter("@contacttime", contacttime);
            param[16] = new SqlParameter("@contacttimeid", contacttimeid);
        }
        else
        {
            param[15] = new SqlParameter("@contacttime", "");
            param[16] = new SqlParameter("@contacttimeid", contacttimeid);
        }

        param[17] = new SqlParameter("@remarks", remark.Trim());
        param[18] = new SqlParameter("@enquiryid", eid);
        param[19] = new SqlParameter("@landlineno", landlineno);
        param[20] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[20].Direction = ParameterDirection.Output;
        param[21] = new SqlParameter("@city", city.Trim());
        param[22] = new SqlParameter("@msg", msg.Trim());

        if (email2 != "")
        {
            param[23] = new SqlParameter("@email2", email2.Trim());
        }
        else
        {
            param[23] = new SqlParameter("@email2", "");
        }

        if (email3 != "")
        {
            param[24] = new SqlParameter("@email3", email3.Trim());
        }
        else
        {
            param[24] = new SqlParameter("@email3", "");
        }

        if (mob2 != "")
        {
            param[25] = new SqlParameter("@mob2", mob2.Trim());
        }
        else
        {
            param[25] = new SqlParameter("@mob2", "");
        }

        if (mob3 != "")
        {
            param[26] = new SqlParameter("@mob3", mob3.Trim());
        }
        else
        {
            param[26] = new SqlParameter("@mob3", "");
        }

        param[27] = new SqlParameter("@quoation", 1);
        param[30] = new SqlParameter("@isfollowup", 1);

        param[28] = new SqlParameter("@enqproid", enquirytypeid);

        if (enquirytypeid != 0)
        {
            param[29] = new SqlParameter("@enqprotext", enquirytypetxt);
        }
        else
        {
            param[29] = new SqlParameter("@enqprotext", "");
        }

        int result = Objutl.ExecuteSqlSP(param, "usp_updateenquiry");

        if (result == 1)
        {
            return 1;
        }
        else
        {
            return 0;
        }
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
                cmd.Parameters.AddWithValue("@BranchId", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
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
                                user.contacteddate = dt.Rows[0]["contacteddate"].ToString();
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
                        user.followupdate = dtrow["followupdate"].ToString();
                    }
                    else
                    {
                        user.followupdate = DateTime.Now.ToShortDateString();
                    }
                    if (dtrow["followuptimeid"].ToString() != "")
                    {
                        user.followuptimeid = dtrow["followuptimeid"].ToString();
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

        dt23 = ds.Tables[4];
        if (dt23.Rows.Count > 0)
        {
            ddlstatus.DataSource = dt23;
            ddlstatus.DataTextField = "statusname";
            ddlstatus.DataValueField = "esid";
            ddlstatus.DataBind();
            ddlstatus.Items.Insert(0, new ListItem("--Select Status--", "0"));
        }

        dt1 = objdut.GetDataTableSP("[usp_getddllist]");

        if (dt1.Rows.Count > 0)
        {
            ddlenqtype.DataSource = dt1;
            ddlenqtype.DataTextField = "productname";
            ddlenqtype.DataValueField = "id";
            ddlenqtype.DataBind();
            
        }

        dt231 = ds.Tables[5];

        if (dt231.Rows.Count > 0)
        {
            ddlRejectedstatus.DataSource = dt231;
            ddlRejectedstatus.DataTextField = "statusname";
            ddlRejectedstatus.DataValueField = "esid";
            ddlRejectedstatus.DataBind();
            ddlRejectedstatus.Items.Insert(0, new ListItem("--Select Reject Status--", "0"));
        }

        ////-------------bind ddl ------------
        DataTable dtcntry = objdut.GetDataTable("select classid,Classname from ClassBranch_master where BranchId=1 and status =1");
        ddlproduct.DataSource = dtcntry;
        ddlproduct.DataValueField = "Classname";
        ddlproduct.DataTextField = "Classname";
        ddlproduct.DataBind();
        ListItem li = new ListItem("--Select Class--", "0");
        ddlproduct.Items.Insert(0, li);

        dtcntry = objdut.GetDataTable("select * from EnquirySource_Master where status=1");

        if (dtcntry.Rows.Count > 0)
        {
            ddlenquirysource.DataSource = dtcntry;
            ddlenquirysource.DataValueField = "EnquirySource";
            ddlenquirysource.DataTextField = "EnquirySource";
            ddlenquirysource.DataBind();
            ListItem li3 = new ListItem("-Enquiry Source-", "0");
            ddlenquirysource.Items.Insert(0, li3);
        }

        dtcntry = ds.Tables[4];

        if (dtcntry.Rows.Count > 0)
        {
            ddlsearchingstatus.DataSource = dtcntry;
            ddlsearchingstatus.DataValueField = "statusname";
            ddlsearchingstatus.DataTextField = "statusname";
            ddlsearchingstatus.DataBind();
            ListItem li1 = new ListItem("-Status-", "0");
            ddlsearchingstatus.Items.Insert(0, li1);
        }

        ////--------------bind time ddl-----------
        ddlsh.DataSource = GetTimeIntervals();
        ddlsh.DataBind();

        ddleh1.DataSource = GetTimeIntervals();
        ddleh1.DataBind();

        ddleh.DataSource = GetTimeIntervals();
        ddleh.DataBind();
        ddleh.DataSource = GetTimeIntervals();
        ddleh.DataBind();
        ListItem li2 = new ListItem("-Time-", "0");
        ddleh.Items.Insert(0, li2);


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

    //private void fillMultipleschedule()
    //{
       
      
    //}

    //private void fillMultipleschedule1()
    //{
      
    //}

    //protected void BindAllDropDownList()
    //{
      
    //}
}