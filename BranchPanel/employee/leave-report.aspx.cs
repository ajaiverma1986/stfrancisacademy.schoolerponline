using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class branchpanel_employee_leave_report : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private static int eid = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        eid = Convert.ToInt32(Session["empid"]);
        if (Session["empid"] == null)
        {
            Response.Redirect("~/emp-login.aspx");
        }
        if (!IsPostBack)
        {
            fillleavetypes();
            fillleavegrid();
            getlastleave();
            getdatewiseleavedetails();
        }
    }

    private void getlastleave()
    {
        DateTime getdate = Convert.ToDateTime(objdut.GetScalar("select ISNULL(MAX(Leave_End_date),'') as Last_Leave_Date  from tbl_leaveRequest where Empid ='" + Session["empid"] + "' and Leave_Status = 2").ToString());
        txtlastleave.Text = getdate.ToString("dd MMMM yyyy");
        if (txtlastleave.Text == "01 January 1900")
        {
            DateTime newdate = Convert.ToDateTime(DateTime.Now.ToString());
            txtlastleave.Text = newdate.ToString("dd MMMM yyyy");
        }

        //Getting emp code to get leave history before Apply
        string empcode = objdut.GetScalar("select  refNo  from tblEmp_Master where eid=" + Session["empid"]).ToString();
        hfempcode.Value = empcode.ToString();
    }

    private void fillleavegrid()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@eid", Session["empid"]);
        DataTable dt = objdut.GetDataTableSP(param, "[usp_leavemployeesearch]");
        gvleavedetails.DataSource = dt;
        gvleavedetails.DataBind();
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
        param[0] = new SqlParameter("@empid", Session["empid"]);
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
            Response.Write("<script type='text/javascript'> alert('Leave Applied Successfully')</script>");
            sendmail();
        }
    }

    protected void sendmail()
    {
        System.IO.StreamReader reader = new System.IO.StreamReader(Server.MapPath("../branchpanel/employee/sendmailfromgrid.html"));
        string readFile = reader.ReadToEnd();
        string myString = "";
        myString = readFile;
        myString = myString.Replace("$$memName$$", Request.Form[txtname.UniqueID]);
        myString = myString.Replace("$$loginID$$", "AWS11390");
        myString = myString.Replace("$$password$$", "23102014");

        string str = SendMail.SendDemo("dharmendra@awapalsolutions.com", "shourya@awapalsolutions.com", "shourya@awapalsolutions.com", "shourya@awapalsolutions.com", "New Leave Applied", myString.ToString());
        if (str == "")
        {
            Response.Write("<script type='text/javascript'>alert('Email Sent')</script>");
        }
        else
        {
            Response.Write("<script type='text/javascript'>alert('Error During Sending Mail !')</script>");
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        submitLeaveReq();
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

    protected void gvleavedetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblstatus = e.Row.FindControl("lblleavestatus") as Label;
            ImageButton imgbutton = e.Row.FindControl("linkedit") as ImageButton;
            if (lblstatus.Text != "Pending")
            {
                imgbutton.Visible = false;
            }
        }
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

                param[0] = new SqlParameter("@eid", eid);
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
}