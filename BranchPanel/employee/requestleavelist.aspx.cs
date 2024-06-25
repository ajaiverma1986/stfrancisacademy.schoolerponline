using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class branchpanel_employee_requestleavelist : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private string url = "";
    private DataSet ds;
    private static string myString = "", emailforhost = "", hostname = "", password = "", userid = "";
    public static int pagesize = 50;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!IsPostBack)
        {
            getleaveslist();
            fillleavetypes();
            //userid = Session["BrADID"].ToString();
        }
    }

    protected void fillleavetypes()
    {
        string query = "select Leave_Type,Ltid  from tbl_leavetype where Status = 1 order by Leave_Type";
        DataTable dtdept = objdut.GetDataTable(query);
        if (dtdept.Rows.Count > 0)
        {
            ddlleavetype.DataSource = dtdept;
            ddlleavetype.DataTextField = "Leave_Type";
            ddlleavetype.DataValueField = "Ltid";
            ddlleavetype.DataBind();
            ddlleavetype.Items.Insert(0, new ListItem("Leave Type", "0"));
        }
    }

    private void getleaveslist()
    {
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@empname", "");
        param[1] = new SqlParameter("@leavefromdate", "");
        param[2] = new SqlParameter("@leaveapplieddate", "");
        param[3] = new SqlParameter("@mode", 2);
        param[4] = new SqlParameter("@pageno", 1);
        param[5] = new SqlParameter("@pagesize", 50);
        DataTable dt = objdut.GetDataTableSP(param, "[usp_searchProcDemo]");
        gvleavedetails.DataSource = dt;
        gvleavedetails.DataBind();

        gvempleavedetails.DataSource = dt;
        gvempleavedetails.DataBind();

        gvtlcomments.DataSource = dt;
        gvtlcomments.DataBind();
    }

    [WebMethod]
    public static getleavedetails[] getleavesdetailss(int leaveid)
    {
        List<getleavedetails> details = new List<getleavedetails>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_leavehistory]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@leaveid", leaveid);
                cmd.Parameters.AddWithValue("@mode", 10);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    getleavedetails objleavedetails = new getleavedetails();
                    objleavedetails.name = dtrow["name"].ToString();
                    objleavedetails.empid = dtrow["refNo"].ToString();
                    objleavedetails.leaveapplydate = dtrow["Leave_Apply_Date"].ToString();
                    objleavedetails.lastleave = dtrow["Last_Leave_Date"].ToString();
                    objleavedetails.leavefrom = dtrow["Leave_Start_From"].ToString();
                    objleavedetails.leaveto = dtrow["Leave_End_date"].ToString();
                    objleavedetails.leavereson = dtrow["Reason"].ToString();
                    objleavedetails.leavestatus = dtrow["leave_status"].ToString();
                    objleavedetails.adminremark = dtrow["Admin_Remark"].ToString();
                    objleavedetails.leavetype = dtrow["Leave_Type"].ToString();

                    details.Add(objleavedetails);
                }
            }
        }
        return details.ToArray();
    }

    public class getleavedetails
    {
        public string name { get; set; }

        public string empid { get; set; }

        public string lastleave { get; set; }

        public string leavefrom { get; set; }

        public string leaveto { get; set; }

        public string leavereson { get; set; }

        public string leavestatus { get; set; }

        public string adminremark { get; set; }

        public string leaveapplydate { get; set; }

        public string leavetype { get; set; }
    }

    [WebMethod]
    public static getempleave[] getempleavedetails(string fromdate, string todate)
    {
        DataSet ds = new DataSet();
        List<getempleave> details = new List<getempleave>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[getleavesates]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@fromDate", fromdate);
                cmd.Parameters.AddWithValue("@toDate", todate);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getempleave user = new getempleave();
                        user.date = dtrow["date"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getempleave
    {
        public string date { get; set; }
    }

    [WebMethod]
    public static int saveleave(string date, string empcode, string ispaid, string approve, string leaveid, string leavetype)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_leavehistory]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@date", date);
                cmd.Parameters.Add("@empcode", empcode);
                cmd.Parameters.Add("@ispaid", ispaid);
                cmd.Parameters.Add("@mode", 1);
                cmd.Parameters.Add("@approve", approve);
                cmd.Parameters.Add("@leaveid", leaveid);
                cmd.Parameters.Add("@leavetype", leavetype);

                int result = cmd.ExecuteNonQuery();
                return result;
            }
        }
    }

    [WebMethod]
    public static int saveleaverequest(string totalpaid, string totalconfirm, string totalunpaid, string leaveid, string leavestatus, string adminremark)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_leavehistory]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@approveleave", totalconfirm);
                cmd.Parameters.Add("@paidleave", totalpaid);
                cmd.Parameters.Add("@unpaidleave", totalunpaid);
                cmd.Parameters.Add("@leaveid", leaveid);
                cmd.Parameters.Add("@mode", 2);
                cmd.Parameters.Add("@leavestatus", leavestatus);
                cmd.Parameters.Add("@adminremark", adminremark);
                cmd.Parameters.Add("@adminuserid", userid);

                int result = cmd.ExecuteNonQuery();
                return result;
            }
        }
    }

    [WebMethod]
    public static gettotal[] gettotalleave(string empcode)
    {
        DataSet ds = new DataSet();
        List<gettotal> details = new List<gettotal>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_leavehistory]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@mode", 3);
                cmd.Parameters.AddWithValue("@empcode", empcode);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        gettotal user = new gettotal();
                        user.totalleave = dtrow["Totalleave"].ToString();
                        user.totalpaid = dtrow["Totalpaid"].ToString();
                        user.totalunpaid = dtrow["Totalunpaid"].ToString();
                        user.totalreject = dtrow["Totalreject"].ToString();
                        user.Available = dtrow["Available"].ToString();
                        user.Earnpaid = dtrow["Earnpaid"].ToString();
                        user.emailid = dtrow["empemail"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class gettotal
    {
        public string totalleave { get; set; }

        public string totalpaid { get; set; }

        public string totalunpaid { get; set; }

        public string totalreject { get; set; }

        public string Available { get; set; }

        public string Earnpaid { get; set; }

        public string emailid { get; set; }
    }

    [WebMethod]
    public static gettlcmt[] tlcomment(string leaveid)
    {
        DataSet ds = new DataSet();
        List<gettlcmt> details = new List<gettlcmt>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_leaverequest]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@mode", 5);
                cmd.Parameters.AddWithValue("@leaveid", leaveid);
                cmd.Parameters.AddWithValue("@intResult", 0);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        gettlcmt user = new gettlcmt();
                        user.comment = dtrow["tlreview"].ToString();
                        user.projname = dtrow["proj_name"].ToString();
                        user.tlname = dtrow["proj_head"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class gettlcmt
    {
        public string comment { get; set; }

        public string projname { get; set; }

        public string tlname { get; set; }
    }

    [WebMethod]
    public static getaproveleaves[] getapprovedleavedetails(string leaveid)
    {
        List<getaproveleaves> details = new List<getaproveleaves>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand(@"select noofapproveleave,noofpaidleave,noofunpaidleave,tottalleave from tbl_leaveRequest
                                                      where Leaveid='" + leaveid + "'", con))
            {
                cmd.CommandType = CommandType.Text;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    getaproveleaves objleavedetails = new getaproveleaves();
                    objleavedetails.appyleave = dtrow["tottalleave"].ToString();
                    objleavedetails.approve = dtrow["noofapproveleave"].ToString();
                    objleavedetails.paid = dtrow["noofpaidleave"].ToString();
                    objleavedetails.unpaid = dtrow["noofunpaidleave"].ToString();
                    details.Add(objleavedetails);
                }
            }
        }
        return details.ToArray();
    }

    public class getaproveleaves
    {
        public string appyleave { get; set; }

        public string approve { get; set; }

        public string paid { get; set; }

        public string unpaid { get; set; }
    }

    protected void btnback_Click(object sender, EventArgs e)
    {
        Response.Redirect("requestleavelist.aspx");
    }

    [WebMethod]
    public static int getleaverequest()
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_getlivedata]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@eid", 0);
                cmd.Parameters.Add("@mode", 2);
                cmd.Parameters.Add("@intResult", 0);
                cmd.Parameters["@intResult"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int result = Convert.ToInt32(cmd.Parameters["@intResult"].Value);
                return result;
            }
        }
    }

    protected void gvleavedetails_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        gvleavedetails.PageIndex = e.NewPageIndex;
        getleaveslist();
    }

    [WebMethod]
    public static string setvalue(string eid)
    {
        HttpContext.Current.Session["empid"] = eid;
        return HttpContext.Current.Session["empid"].ToString();
    }

    //Method to get list of holidays
    [WebMethod]
    public static getholidays[] getholidaysdate()
    {
        List<getholidays> details = new List<getholidays>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand(@"select Convert(varchar(50),Date,103)as date from tbl_setholiday where status = 1", con))
            {
                cmd.CommandType = CommandType.Text;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    getholidays objleavedetails = new getholidays();
                    objleavedetails.holidaydate = dtrow["Date"].ToString();
                    details.Add(objleavedetails);
                }
            }
        }
        return details.ToArray();
    }

    public class getholidays
    {
        public string holidaydate { get; set; }
    }

    //[WebMethod] //send Leave update from email to Employee
    //public static int SendMailemp(string emailid, string subject, string msg)
    //{
    //    int send = 0;
    //    DataUtility objUTL = new DataUtility();
    //    DataTable dtformail = objUTL.GetDataTable("select module_hostname,emialid_for_module,password_of_email from tbl_email_sms_send_master where ModuleId=4");
    //    if (dtformail.Rows.Count > 0)
    //    {
    //        emailforhost = dtformail.Rows[0]["emialid_for_module"].ToString();
    //        hostname = dtformail.Rows[0]["module_hostname"].ToString();
    //        password = dtformail.Rows[0]["password_of_email"].ToString();
    //    }
    //    if (send == 0)
    //    {
    //        MailMessage mm = new MailMessage("shourya@awapalsolutions.com", "jaikey@awapalsolutions.com");
    //        mm.IsBodyHtml = true;

    //        StreamReader reader = new StreamReader(System.Web.HttpContext.Current.Server.MapPath("sendmailfromgrid.html"));
    //        string readFile = reader.ReadToEnd();
    //        myString = readFile;
    //        myString = myString.Replace("$$to$$", emailid);
    //        myString = myString.Replace("$$subject$$", subject);
    //        myString = myString.Replace("$$msg$$", msg);
    //        mm.Subject = subject;
    //        mm.Body = myString;
    //        if (send == 0)
    //        {
    //            string str = SendMail.SendDemo("", emailid, "", "", subject.ToString(), myString.ToString());
    //            send = 1;
    //        }
    //    }
    //    return send;
    //}

    [WebMethod]
    public static UserDetails[] BindDatatable(string fname, string datefirst, string datesecond, string leavetype, string pageno)
    {
        DataSet ds = new DataSet();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_searchProcDemo]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[7];
                param[0] = new SqlParameter("@empname", fname);
                param[1] = new SqlParameter("@leavefromdate", datefirst);
                param[2] = new SqlParameter("@leaveapplieddate", datesecond);
                param[3] = new SqlParameter("@leavetype", leavetype);
                param[4] = new SqlParameter("@mode", 2);
                param[5] = new SqlParameter("@pageno", pageno);
                param[6] = new SqlParameter("@pagesize", pagesize);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);
                cmd.Parameters.Add(param[6]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.refNo = dtrow["refNo"].ToString();
                        user.name = dtrow["name"].ToString();
                        user.Leave_Start_From = dtrow["Leave_Start_From"].ToString();
                        user.Leave_Apply_Date = dtrow["Leave_Apply_Date"].ToString();
                        user.Leave_Type = dtrow["Leave_Type"].ToString();
                        user.leave_status = dtrow["leave_status"].ToString();
                        user.leaveid = dtrow["Leaveid"].ToString();
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
        public string refNo { get; set; }

        public string name { get; set; }

        public string Leave_Start_From { get; set; }

        public string Leave_Apply_Date { get; set; }

        public string Leave_Type { get; set; }

        public string leave_status { get; set; }

        public string leaveid { get; set; }

        public string eid { get; set; }
    }

    [WebMethod]
    public static getempdetails[] getempcutomsontrol(string eid)
    {
        List<getempdetails> details = new List<getempdetails>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand(@"select (fname+' '+lname) as name,mobile,department,designation from tblEmp_Master where eid='" + eid + "'", con))
            {
                cmd.CommandType = CommandType.Text;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    getempdetails objleavedetails = new getempdetails();
                    objleavedetails.name = dtrow["name"].ToString();
                    objleavedetails.mobile = dtrow["mobile"].ToString();
                    objleavedetails.department = dtrow["department"].ToString();
                    objleavedetails.designation = dtrow["designation"].ToString();
                    details.Add(objleavedetails);
                }
            }
        }
        return details.ToArray();
    }

    public class getempdetails
    {
        public string name { get; set; }

        public string mobile { get; set; }

        public string department { get; set; }

        public string designation { get; set; }
    }

    [WebMethod]
    public static getsandwichleaves[] getsandwichleave(string fromdate, string todate)
    {
        DataSet ds = new DataSet();
        List<getsandwichleaves> details = new List<getsandwichleaves>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[getsandwichleave]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@fromDate", fromdate);
                cmd.Parameters.AddWithValue("@toDate", todate);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getsandwichleaves user = new getsandwichleaves();
                        user.holidaydate = dtrow["checkdate"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getsandwichleaves
    {
        public string holidaydate { get; set; }
    }
}