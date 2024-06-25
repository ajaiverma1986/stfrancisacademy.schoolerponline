using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;


public partial class BranchPanel_viewenquiry : Page
{

    private DataUtility objdut = new DataUtility();
    private Utility objUT = new Utility();
    public static GridView GdDemo = new GridView();
    private int fyid = 0;
    private CommonClass comm = new CommonClass();
    private string url = "", PageName;
    private static int branchid = 0;
    DataTable dt, dt1, dt23, dt231;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            branchid = Convert.ToInt16(Session["BrBrid"]);
            if (!IsPostBack)
            {
                ddlsh.SelectedValue = Convert.ToString(objdut.GetScalar("SELECT FORMAT(dbo.fun_getCurrentDate(), 'h:mm tt')"));
                fyid = comm.financialyear("financialyear");
                ViewState["fyid"] = fyid;
                ViewState["noofrecord"] = 50;
                ViewState["PageNo"] = 1;
                fillgrid();
                fillsource();
            }
        }
        catch (Exception exp)
        {
            Utility.ViewAlertMessage(this, exp.Message);
        }
    }

    private void fillgrid()
    {
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@gridtype", "viewgrid");

        param[1] = new SqlParameter("@pagesize", SqlDbType.Int);
        param[1].Value = 50;

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

    protected static void SendInArchive()
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[ForSendInArchive]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@noofdays", 90);
                param[1] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.ExecuteNonQuery();
                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);
            }
        }

    }


    [WebMethod]
    public static int UpdateEnquiry(string enquirydate, string source, string sourceid, string name, string femail, string fmobile, string statustxt,
         string statusid, string contactdate, string followuptime, string followuptimeid, string contactby, string followupdate, string contacttime, string contacttimeid
         , string remark, string landlineno, string city, string msg, string email2, string email3, string mob2, string mob3, string leadstatusid, string enquirytypeid, string enquirytypetxt, string eid)
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

        if (Convert.ToInt32(statusid) != 0)
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

        if (Convert.ToInt32(followuptimeid) != 0)
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


        if (Convert.ToInt32(contacttimeid) != 0)
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

        param[27] = new SqlParameter("@quoation", Convert.ToInt16("0"));


        if (Convert.ToInt32(leadstatusid) == 7)
        {

            param[30] = new SqlParameter("@isfollowup", 1);
        }
        else
        {

            param[30] = new SqlParameter("@isfollowup", Convert.ToInt16("0"));
        }

        param[28] = new SqlParameter("@enqproid", enquirytypeid);

        if (enquirytypeid != "0")
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
            SendInArchive();
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

                    if (dtrow["Real_Enqiry_Id"].ToString() != "")
                    {
                        user.Real_Enqiry_Id = dtrow["Real_Enqiry_Id"].ToString();
                    }
                    else
                    {
                        user.Real_Enqiry_Id = "00000";
                    }
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
                        SqlCommand cmd1 = new SqlCommand("SELECT FORMAT(dbo.fun_getCurrentDate(), 'h:mm tt')", con);
                        user.contacttimeid = Convert.ToString(cmd1.ExecuteScalar());

                        //  user.contacttimeid = DateTime.Now.ToShortTimeString();
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

    [WebMethod]
    public static int sendsmsonmobile(string mobile, string msg)
    {
        string mobileno = mobile;
        string sender = "Awapal Office";
        string message = msg;
        int result1 = 0;
        if (HttpContext.Current.Session["brbrid"].ToString() != "")
        {
            result1 = sendMessageToMobile.SMSSend(mobileno, sender, HttpContext.Current.Session["brbrid"].ToString());
        }
        return result1;
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
        dt1 = objdut.GetDataTableSP("[usp_getddllist]");

       

        dt231 = ds.Tables[6];
        if (dt231.Rows.Count > 0)
        {
            ddlLeadStatus.DataSource = dt231;
            ddlLeadStatus.DataTextField = "statusname";
            ddlLeadStatus.DataValueField = "esid";
            ddlLeadStatus.DataBind();
            ddlLeadStatus.Items.Insert(0, new ListItem("--Select Lead Status--", "0"));
        }

        ///-----------------bind ddl
        DataTable dtcntry = objdut.GetDataTable("select classid,Classname from ClassBranch_master where BranchId=1 and status =1");
        ddlproduct.DataSource = dtcntry;
        ddlproduct.DataValueField = "Classname";
        ddlproduct.DataTextField = "Classname";
        ddlproduct.DataBind();
        ListItem li = new ListItem("--Select Class--", "0");
        ddlproduct.Items.Insert(0, li);

        ddlenqtype.DataSource = dtcntry;
        ddlenqtype.DataTextField = "Classname";
        ddlenqtype.DataValueField = "classid";
        ddlenqtype.DataBind();
        dtcntry.Dispose();

        dtcntry = objdut.GetDataTable("select EnquirySource from EnquirySource_Master where status=1");
        ddlenquirysource.DataSource = dtcntry;
        ddlenquirysource.DataValueField = "EnquirySource";
        ddlenquirysource.DataTextField = "EnquirySource";
        ddlenquirysource.DataBind();
        ListItem li1 = new ListItem("--Select Source--", "0");
        ddlenquirysource.Items.Insert(0, li1);


        ddlsh.DataSource = GetTimeIntervals();
        ddlsh.DataBind();

        ddleh1.DataSource = GetTimeIntervals();
        ddleh1.DataBind();

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

}
