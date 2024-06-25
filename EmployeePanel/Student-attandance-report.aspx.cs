using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class EmployeePanel_emp_attandance_report : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private CommonClass commonOBJ = new CommonClass();
    public static int fyid = 2;
    public static int payid = 1;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillgrid();         
        }
    }
    private void fillgrid()    
    {
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@brid", SqlDbType.Int);
        param[0].Value = Convert.ToInt32(Session["BrBrid"]);
        param[1] = new SqlParameter("@ClassId", SqlDbType.Int);
        param[1].Value = Convert.ToInt32(Session["Classid"]);
        param[2] = new SqlParameter("@Sectionid", SqlDbType.Int);
        if (Session["Sectionid"].ToString() == "")
        {
            param[2].Value = 1;
        }
        else
        {
            param[2].Value = Convert.ToInt32(Session["Sectionid"]);
        }
        param[3] = new SqlParameter("@studentid", SqlDbType.Int);
        param[3].Value = Convert.ToInt32(Session["eid"]);

        param[4] = new SqlParameter("@FromDate", SqlDbType.Text);
        param[4].Value = txtFromDate.Text;
        param[5] = new SqlParameter("@ToDate", SqlDbType.Text);
        param[5].Value = txtToDate.Text;

        
        DataTable Dt = objdut.GetDataTableSP(param, "usp_studentattendanceMaster");
        if (Dt.Rows.Count > 0)
        {
            tabledetails.Style.Add("display", "block");
            gvDetails.DataSource = Dt;
            gvDetails.DataBind();
           
        }
        else
        {
          
            gvDetails.EmptyDataText = "No attendance report found.";
            
            gvDetails.DataBind();
        }
    }

    [WebMethod]
    public static getmonthsreport[] BindGridByJs(string fyid, string payid, string fromdate, string todate)
    {
        DataSet ds = new DataSet();
        List<getmonthsreport> details = new List<getmonthsreport>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_AttendanceReport_DayWise_inemplopyeepanel]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[6];
                param[0] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);
                param[1] = new SqlParameter("@fyid", fyid);
                param[2] = new SqlParameter("@payid", payid);
                param[3] = new SqlParameter("@FromDate", fromdate);
                param[4] = new SqlParameter("@ToDate", todate);
                param[5] = new SqlParameter("@eid", HttpContext.Current.Session["eid"]);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getmonthsreport user = new getmonthsreport();
                        user.Number = dtrow["Number"].ToString();
                        user.Date = dtrow["Date"].ToString();
                        user.present = dtrow["present"].ToString();
                        user.Intime = dtrow["Intime"].ToString();
                        user.Outtime = dtrow["Outtime"].ToString();
                        user.islate = dtrow["islate"].ToString();
                        user.ishalfday = dtrow["ishalfday"].ToString();
                        user.paidleave = dtrow["paidleave"].ToString();
                        user.unpaidleave = dtrow["unpaidleave"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getmonthsreport
    {
        public string Number { get; set; }

        public string Date { get; set; }

        public string present { get; set; }

        public string Intime { get; set; }

        public string Outtime { get; set; }

        public string islate { get; set; }

        public string ishalfday { get; set; }

        public string paidleave { get; set; }

        public string unpaidleave { get; set; }
    }

    [WebMethod]
    public static getyearreport[] BindMainGridByJs(string fyid, string payid)
    {
        DataSet ds = new DataSet();
        List<getyearreport> details = new List<getyearreport>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_ShowAttendanceDetails]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);
                param[1] = new SqlParameter("@fyid", fyid);
                param[2] = new SqlParameter("@empid", HttpContext.Current.Session["eid"]);
                param[3] = new SqlParameter("@emppayid", payid);

                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getyearreport user = new getyearreport();
                        user.RowNumber = dtrow["RowNumber"].ToString();
                        user.Month = dtrow["Month"].ToString();
                        user.Noofworkingdays = dtrow["Noofworkingdays"].ToString();
                        user.Noofpresentdays = dtrow["Noofpresentdays"].ToString();
                        user.NoofLateCome = dtrow["NoofLateCome"].ToString();
                        user.NoofHalfDays = dtrow["NoofHalfDays"].ToString();
                        user.NoofPaidLeave = dtrow["NoofPaidLeave"].ToString();
                        user.Noofunpaidleave = dtrow["Noofunpaidleave"].ToString();
                        user.Noofabsentdays = dtrow["Noofabsentdays"].ToString();
                        user.payid = dtrow["payid"].ToString();
                        user.TotalNoofworkingdays = dtrow["TotalNoofworkingdays"].ToString();
                        user.TotalNoofpresentdays = dtrow["TotalNoofpresentdays"].ToString();
                        user.TotalNoofLateCome = dtrow["TotalNoofLateCome"].ToString();
                        user.TotalNoofHalfDays = dtrow["TotalNoofHalfDays"].ToString();
                        user.TotalNoofPaidLeave = dtrow["TotalNoofPaidLeave"].ToString();
                        user.TotalNoofunpaidleave = dtrow["TotalNoofunpaidleave"].ToString();
                        user.TotalNoofabsentdays = dtrow["TotalNoofabsentdays"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getyearreport
    {
        public string RowNumber { get; set; }

        public string Month { get; set; }

        public string Noofworkingdays { get; set; }

        public string Noofpresentdays { get; set; }

        public string NoofLateCome { get; set; }

        public string NoofHalfDays { get; set; }

        public string NoofPaidLeave { get; set; }

        public string Noofunpaidleave { get; set; }

        public string Noofabsentdays { get; set; }

        public string payid { get; set; }

        public string TotalNoofworkingdays { get; set; }

        public string TotalNoofpresentdays { get; set; }

        public string TotalNoofLateCome { get; set; }

        public string TotalNoofHalfDays { get; set; }

        public string TotalNoofPaidLeave { get; set; }

        public string TotalNoofunpaidleave { get; set; }

        public string TotalNoofabsentdays { get; set; }
    }
    protected void gvDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField status = (HiddenField)e.Row.FindControl("HiddenField1");
            Label Attendance = (Label)e.Row.FindControl("lblattendancesttatus");
            if (status.Value.ToString() != "")
            {
                if (status.Value.ToString() == "A")
                {
                    Attendance.Text = "Absent";
                }
                else
                {
                    Attendance.Text = "Present";
                }
            }
        }
    }
    protected void btnfind_Click(object sender, EventArgs e)
    {
        if (Validate())
        {
            fillgrid();
        }
    }
    public bool Validate()
    {
        if (txtFromDate.Text.Trim() == "")
        {
            Utility.ViewAlertMessage(this, "Please Enter From Date..");
            return false;
        }
        if (txtToDate.Text.Trim() == "")
        {
            Utility.ViewAlertMessage(this, "Please Enter To Date.. ");
            return false;
        }
        return true;
    }
}