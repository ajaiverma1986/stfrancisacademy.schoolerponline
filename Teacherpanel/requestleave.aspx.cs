using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class EmployeePanel_requestleave : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private static int eid = 0;

    protected void Page_Init(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
        Response.Cache.SetExpires(System.DateTime.UtcNow.AddSeconds(-1));
        Response.Cache.SetNoStore();
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["update"] = Session["update"];
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["eid"] == null)
        {
            Response.Redirect("~/emp-login.aspx");
        }

        if (!IsPostBack)
        {
            Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString());
            eid = Convert.ToInt32(Session["eid"]);
            fillleavetypes();
            fillleavegrid();
            getlastleave();
            getdatewiseleavedetails();
            gethalfday();
        }
    }

    private void getlastleave()
    {
        DateTime getdate = Convert.ToDateTime(objdut.GetScalar("select ISNULL(MAX(Leave_End_date),'') as Last_Leave_Date  from tbl_leaveRequest where Empid ='" + Session["eid"] + "' and Leave_Status = 2").ToString());
        txtlastleave.Text = getdate.ToString("dd MMMM yyyy");

        //Getting emp code to get leave history before Apply
        string empcode = objdut.GetScalar("select  refNo  from tblEmp_Master where eid=" + Session["eid"]).ToString();
        hfempcode.Value = empcode.ToString();
    }

    private void fillleavegrid()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@eid", Session["eid"]);
        DataTable dt = objdut.GetDataTableSP(param, "[usp_leavemployeesearch]");
        gvleavedetails.DataSource = dt;
        gvleavedetails.DataBind();
    }

    private void gethalfday()
    {
        SqlParameter[] param1 = new SqlParameter[3];
        param1[0] = new SqlParameter("@mode", 7);
        param1[1] = new SqlParameter("@empid", Session["eid"]);
        param1[2] = new SqlParameter("@intResult", 0);
        param1[2].Direction = ParameterDirection.Output;
        DataTable dt1 = objdut.GetDataTableSP(param1, "[usp_leaverequest]");
        grdhalfday.DataSource = dt1;
        grdhalfday.DataBind();
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
            ddlleavetype.Items.Insert(0, new ListItem("--Select Leave Type--", "0"));

            ddlleavetypes.DataSource = dtdept;
            ddlleavetypes.DataTextField = "Leave_Type";
            ddlleavetypes.DataValueField = "Ltid";
            ddlleavetypes.DataBind();
            ddlleavetypes.Items.Insert(0, new ListItem("Leave Type", "0"));
        }
    }

    private void submitLeaveReq()
    {
        SqlParameter[] param = new SqlParameter[11];
        param[0] = new SqlParameter("@empid", Session["eid"]);
        param[1] = new SqlParameter("@tlid", 1);
        param[2] = new SqlParameter("@contact", txtmobile.Text);
        param[3] = new SqlParameter("@lastleave", Request.Form[txtlastleave.UniqueID]);
        param[4] = new SqlParameter("@leavestartfrom", Request.Form[txtleavestart.UniqueID]);
        param[5] = new SqlParameter("@leaveend", Request.Form[txtresume.UniqueID]);
        param[6] = new SqlParameter("@leavetype", ddlleavetype.SelectedValue);
        param[7] = new SqlParameter("@reson", txtreson.Text.Trim());
        param[8] = new SqlParameter("@address", txtaddress.Text.Trim());
        param[9] = new SqlParameter("@mode", 1);
        param[10] = new SqlParameter("@intResult", Convert.ToInt16(0));
        param[10].Direction = ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, "usp_leaverequest");
        if (result > 0)
        {
            fillleavegrid();
            //Response.Write("<script type='text/javascript'>alert('Leave Applied Successfully')</script>");
            Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString());
        }
    }

    private void submithalfday()
    {
        SqlParameter[] param = new SqlParameter[7];
        param[0] = new SqlParameter("@empid", Session["eid"]);
        param[1] = new SqlParameter("@hd_date", Request.Form[txthddate.UniqueID]);
        param[2] = new SqlParameter("@hd_half", Convert.ToInt32(ddlhd.SelectedValue));
        param[3] = new SqlParameter("@contact", txthdcontact.Text);
        param[4] = new SqlParameter("@mode", 6);
        param[5] = new SqlParameter("@reson", txthdreason.Text);
        param[6] = new SqlParameter("@intResult", Convert.ToInt16(0));
        param[6].Direction = ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, "usp_leaverequest");
        if (result > 0)
        {
            gethalfday();
            Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString());
        }
    }

    protected void btnapplyhalfday_Click(object sender, EventArgs e)
    {
        if (Session["update"].ToString() == ViewState["update"].ToString())
        {
            submithalfday();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Session["update"].ToString() == ViewState["update"].ToString())
        {
            submitLeaveReq();
        }
    }

    protected void updateleave()
    {
        SqlParameter[] param = new SqlParameter[9];
        param[0] = new SqlParameter("@contact", txtmobile.Text);
        param[1] = new SqlParameter("@leavestartfrom", Request.Form[txtleavestart.UniqueID]);
        param[2] = new SqlParameter("@leaveend", Request.Form[txtresume.UniqueID]);
        param[3] = new SqlParameter("@leavetype", ddlleavetype.SelectedValue);
        param[4] = new SqlParameter("@reson", txtreson.Text.Trim());
        param[5] = new SqlParameter("@address", txtaddress.Text.Trim());
        param[6] = new SqlParameter("@mode", 2);
        param[7] = new SqlParameter("@leaveid", hfleaveid.Value);
        param[8] = new SqlParameter("@intResult", Convert.ToInt16(0));
        param[8].Direction = ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, "usp_leaverequest");
        if (result > 0)
        {
            fillleavegrid();
        }
    }

    protected void gvleavedetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvleavedetails.PageIndex = e.NewPageIndex;
        fillleavegrid();
    }

    [WebMethod]
    public static getleavedetails[] getleavesdetailss(int leaveid)
    {
        List<getleavedetails> details = new List<getleavedetails>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand(@"select CONVERT(varchar(30), Leave_Start_From, 106) as Leave_Start_From, CONVERT(varchar(30),Leave_End_date,106) as
                                                     Leave_End_date,Reason,Communication_Address, Leave_Apply_Date,noofapproveleave,noofpaidleave,noofunpaidleave,
                                                     tottalleave, (tottalleave - noofapproveleave) as reject ,Admin_Remark,leave_status, Leave_Type from tbl_leaveRequest where Leaveid='" + leaveid + "'", con))
            {
                cmd.CommandType = CommandType.Text;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    getleavedetails objleavedetails = new getleavedetails();
                    objleavedetails.leaveappy = dtrow["Leave_Apply_Date"].ToString();
                    objleavedetails.noofleave = dtrow["tottalleave"].ToString();
                    objleavedetails.noofapproveleave = dtrow["noofapproveleave"].ToString();
                    objleavedetails.noofpl = dtrow["noofpaidleave"].ToString();
                    objleavedetails.nooflwp = dtrow["noofunpaidleave"].ToString();
                    objleavedetails.adminremark = dtrow["Admin_Remark"].ToString();
                    objleavedetails.status = dtrow["leave_status"].ToString();
                    objleavedetails.reject = dtrow["reject"].ToString();

                    objleavedetails.startdate = dtrow["Leave_Start_From"].ToString();
                    objleavedetails.resumedate = dtrow["Leave_End_date"].ToString();
                    objleavedetails.lttype = dtrow["Leave_Type"].ToString();
                    objleavedetails.contactaddress = dtrow["Communication_Address"].ToString();
                    objleavedetails.reson = dtrow["Reason"].ToString();
                    objleavedetails.leaveid = leaveid.ToString();

                    details.Add(objleavedetails);
                }
            }
        }
        return details.ToArray();
    }

    public class getleavedetails
    {
        public string leaveappy { get; set; }

        public string noofleave { get; set; }

        public string noofapproveleave { get; set; }

        public string noofpl { get; set; }

        public string nooflwp { get; set; }

        public string adminremark { get; set; }

        public string status { get; set; }

        public string startdate { get; set; }

        public string resumedate { get; set; }

        public string lttype { get; set; }

        public string contactaddress { get; set; }

        public string reson { get; set; }

        public string leaveid { get; set; }

        public string reject { get; set; }
    }

    protected void btnupdate_Click(object sender, EventArgs e)
    {
        updateleave();
    }

    private void getdatewiseleavedetails()
    {
        string qery = "select date,ispaid,approve from tbl_empleavehistory where leaveid=1";
        DataTable dt = objdut.GetDataTable(qery);
        gvempleavedetails.DataSource = dt;
        gvempleavedetails.DataBind();
    }

    [WebMethod]
    public static getempleave[] getempleavedetails(string leaveid)
    {
        DataSet ds = new DataSet();
        List<getempleave> details = new List<getempleave>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_leaverequest]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@leaveid", leaveid);
                cmd.Parameters.AddWithValue("@mode", 3);
                cmd.Parameters.AddWithValue("@intResult", 0);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getempleave user = new getempleave();
                        user.date = dtrow["date"].ToString();
                        user.ispaid = dtrow["ispaid"].ToString();
                        user.approve = dtrow["approve"].ToString();
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

        public string ispaid { get; set; }

        public string approve { get; set; }
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
    }

    [WebMethod]
    public static chkapplyleave[] getapplyedleavestatus()
    {
        DataSet ds = new DataSet();
        List<chkapplyleave> details = new List<chkapplyleave>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_leavehistory]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@mode", 4);
                cmd.Parameters.AddWithValue("@empid", eid);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        chkapplyleave user = new chkapplyleave();
                        user.chkleave = dtrow["applyleave"].ToString();

                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class chkapplyleave
    {
        public string chkleave { get; set; }
    }

    [WebMethod]
    public static UserDetails[] BindDatatable(string lastleave, string datefirst, string datesecond, string leavetype)
    {
        DataSet ds = new DataSet();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_leavemployeesearch]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[5];
                param[0] = new SqlParameter("@eid", HttpContext.Current.Session["eid"]);
                param[1] = new SqlParameter("@leavefromdate", datefirst);
                param[2] = new SqlParameter("@leaveapplieddate", datesecond);
                param[3] = new SqlParameter("@leavetype", leavetype);
                param[4] = new SqlParameter("@lastleave", lastleave);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.Last_Leave_Date = dtrow["Last_Leave_Date"].ToString();
                        user.Leave_Start_From = dtrow["Leave_Start_From"].ToString();
                        user.Leave_End_date = dtrow["Leave_End_date"].ToString();
                        user.Leave_Apply_Date = dtrow["Leave_Apply_Date"].ToString();
                        user.Leave_Type = dtrow["Leave_Type"].ToString();
                        user.leave_status = dtrow["leave_status"].ToString();
                        user.leaveid = dtrow["leaveid"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string Last_Leave_Date { get; set; }

        public string Leave_Start_From { get; set; }

        public string Leave_End_date { get; set; }

        public string Leave_Apply_Date { get; set; }

        public string Leave_Type { get; set; }

        public string leave_status { get; set; }

        public string leaveid { get; set; }
    }

    [WebMethod]
    public static getholiday[] gethalidays(string fromdate, string todate)
    {
        DataSet ds = new DataSet();
        List<getholiday> details = new List<getholiday>();
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
                        getholiday user = new getholiday();
                        user.holidaydate = dtrow["checkdate"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getholiday
    {
        public string holidaydate { get; set; }
    }

    [WebMethod]
    public static checkenrollmentdate[] getenrollmentdate()
    {
        DataSet ds = new DataSet();
        List<checkenrollmentdate> details = new List<checkenrollmentdate>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_checkenrollmentdate]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        checkenrollmentdate user = new checkenrollmentdate();
                        user.status = dtrow["status"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class checkenrollmentdate
    {
        public string status { get; set; }
    }
}