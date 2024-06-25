using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_attendance_report_monthly_wise : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    public int eid, payid;
    private static int fyid = 0, currentpayid = 0;

    protected void Page_Load(object sender, System.EventArgs e)
    {
        fyid = CommonClass.Scaler("ActiveAcademicYear");
        currentpayid = CommonClass.Scaler("getpayid", fyid);

        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        if (!IsPostBack)
        {
            BindDDLpayid();
            if (currentpayid > 0)
            {
                ddlpayid.SelectedValue = currentpayid.ToString();
                fillgrid(Convert.ToInt32(ddlpayid.SelectedValue));
            }
            bind_gvdetails();
        }
    }

    protected void BindDDLpayid()
    {
        DataTable dt;
        string query = "select DATENAME(month, monthid) AS payname,payid from tbl_MonthlySalaryMaster";
        dt = objdut.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            ddlpayid.DataSource = dt;
            ddlpayid.DataTextField = "payname";
            ddlpayid.DataValueField = "payid";
            ddlpayid.DataBind();
        }
        dt.Dispose();
    }

    private void fillgrid(int payid)
    {
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@brid", SqlDbType.Int);
        param[0].Value = Convert.ToInt32(Session["BrBrid"]);

        param[1] = new SqlParameter("@fyid", SqlDbType.Int);
        param[1].Value = fyid;

        param[2] = new SqlParameter("@payoutid", SqlDbType.Int);
        param[2].Value = currentpayid;

        DataTable dt = objdut.GetDataTableSP(param, "[usp_ShowAllAttendanceDetails]");
        if (dt.Rows.Count > 0)
        {
            tabledescription.Style.Add("display", "none");
            tabledetails.Style.Add("display", "block");
            gvdetails.DataSource = dt;

            lblwork.Text = (from row in dt.AsEnumerable() select row.Field<int>("Noofworkingdays")).Sum().ToString();
            lblPresent.Text = (from row in dt.AsEnumerable() select row.Field<int>("Noofpresentdays")).Sum().ToString();
            lblLate.Text = (from row in dt.AsEnumerable() select row.Field<int>("NoofLateCome")).Sum().ToString();
            lblHalf.Text = (from row in dt.AsEnumerable() select row.Field<int>("NoofHalfDays")).Sum().ToString();
            lblPaid.Text = (from row in dt.AsEnumerable() select row.Field<int>("NoofPaidLeave")).Sum().ToString();
            lblUnpaid.Text = (from row in dt.AsEnumerable() select row.Field<int>("Noofunpaidleave")).Sum().ToString();
            lblAbsent.Text = (from row in dt.AsEnumerable() select row.Field<int>("Noofabsentdays")).Sum().ToString();

            gvdetails.DataBind();
        }
        else
        {
            gvdetails.EmptyDataText = "No attendance report found.";
            gvdetails.DataBind();
        }
    }

    [WebMethod]
    public static attendanceclass[] bindattendancedetails(int payid, string refno, string name)
    {
        DataSet ds = new DataSet();
        List<attendanceclass> details = new List<attendanceclass>();
        SqlParameter[] p = new SqlParameter[5];

        p[0] = new SqlParameter("@brid", SqlDbType.Int);
        p[0].Value = Convert.ToInt32(HttpContext.Current.Session["BrBrid"]);

        p[1] = new SqlParameter("@fyid", SqlDbType.Int);
        p[1].Value = fyid;

        p[2] = new SqlParameter("@payoutid", SqlDbType.VarChar, 200);
        p[2].Value = payid;

        p[3] = new SqlParameter("@refno", SqlDbType.VarChar, 200);
        p[3].Value = refno;

        p[4] = new SqlParameter("@name", SqlDbType.VarChar, 200);
        p[4].Value = name;

        DataUtility ObjUTL = new DataUtility();
        ds = ObjUTL.GetDataSetSP(p, "[usp_ShowAllAttendanceDetails]");

        if (ds.Tables.Count > 0)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dtrow in ds.Tables[0].Rows)
                {
                    attendanceclass user = new attendanceclass();

                    user.RowNumber = dtrow["RowNumber"].ToString();

                    user.RefNo = dtrow["RefNo"].ToString();

                    user.Name = dtrow["Name"].ToString();

                    user.Noofworkingdays = dtrow["Noofworkingdays"].ToString();

                    user.Noofpresentdays = dtrow["Noofpresentdays"].ToString();

                    user.NoofLateCome = dtrow["NoofLateCome"].ToString();

                    user.NoofHalfDays = dtrow["NoofHalfDays"].ToString();

                    user.NoofPaidLeave = dtrow["NoofPaidLeave"].ToString();

                    user.Noofunpaidleave = dtrow["Noofunpaidleave"].ToString();

                    user.Noofabsentdays = dtrow["Noofabsentdays"].ToString();
                    user.eid = dtrow["eid"].ToString();
                    details.Add(user);
                }
            }
        }
        return details.ToArray();
    }

    public class attendanceclass
    {
        public string RowNumber { get; set; }

        public string RefNo { get; set; }

        public string Name { get; set; }

        public string Noofworkingdays { get; set; }

        public string Noofpresentdays { get; set; }

        public string NoofLateCome { get; set; }

        public string NoofHalfDays { get; set; }

        public string NoofPaidLeave { get; set; }

        public string Noofunpaidleave { get; set; }

        public string Noofabsentdays { get; set; }

        public string eid { get; set; }
    }

    protected void bind_gvdetails()
    {
        DataTable dt = new DataTable();

        dt.Columns.Add("Number", typeof(string));
        dt.Columns.Add("RefNo", typeof(string));
        dt.Columns.Add("Name", typeof(string));
        dt.Columns.Add("Date", typeof(string));
        dt.Columns.Add("present", typeof(string));
        dt.Columns.Add("Intime", typeof(string));
        dt.Columns.Add("Outtime", typeof(string));
        dt.Columns.Add("islate", typeof(string));
        dt.Columns.Add("ishalfday", typeof(string));
        dt.Columns.Add("paidleave", typeof(string));
        dt.Columns.Add("unpaidleave", typeof(string));

        DataRow r = dt.NewRow();
        r["Number"] = "1";
        r["RefNo"] = "aaa";
        r["Name"] = "aaa";
        r["Date"] = "2000-01-01";
        r["present"] = "yes";
        r["Intime"] = "yes";
        r["Outtime"] = "yes";
        r["islate"] = "no";
        r["ishalfday"] = "no";
        r["paidleave"] = "1";
        r["unpaidleave"] = "1";

        dt.Rows.Add(r);

        gridfordailyattreport.DataSource = dt;
        gridfordailyattreport.DataBind();

        DateTime moment = DateTime.Now;
    }

    [WebMethod]
    public static attendancedetails[] BindDetailsGrid(int eid, string fromdate, string todate, string payid)
    {
        DataSet ds = new DataSet();
        List<attendancedetails> details = new List<attendancedetails>();

        SqlParameter[] param = new SqlParameter[6];

        param[0] = new SqlParameter("@brid", SqlDbType.Int);
        param[0].Value = Convert.ToInt32(HttpContext.Current.Session["BrBrid"]);

        param[1] = new SqlParameter("@fyid", SqlDbType.Int);
        param[1].Value = fyid;

        param[2] = new SqlParameter("@payid", SqlDbType.Int);
        param[2].Value = Convert.ToInt32(payid);

        param[3] = new SqlParameter("@eid", SqlDbType.Int);
        param[3].Value = eid;

        param[4] = new SqlParameter("@FromDate", SqlDbType.VarChar, 100);
        param[4].Value = fromdate;

        param[5] = new SqlParameter("@ToDate", SqlDbType.VarChar, 100);
        param[5].Value = todate;

        DataUtility ObjUTL = new DataUtility();
        ds = ObjUTL.GetDataSetSP(param, "[usp_AttendanceReport_DayWise]");

        foreach (DataRow dtrow in ds.Tables[0].Rows)
        {
            attendancedetails user = new attendancedetails();

            user.Number = dtrow["Number"].ToString();

            user.RefNo = dtrow["RefNo"].ToString();

            user.Name = dtrow["Name"].ToString();

            if (dtrow["Date"].ToString() != "")
            {
                DateTime dte = Convert.ToDateTime(dtrow["Date"]);
                user.Date = dte.ToString("dd/MM/yyyy");
            }
            else
            {
                user.Date = "";
            }

            user.present = dtrow["present"].ToString();

            user.Intime = dtrow["Intime"].ToString();

            user.Outtime = dtrow["Outtime"].ToString();

            user.islate = dtrow["islate"].ToString();

            user.ishalfday = dtrow["ishalfday"].ToString();
            user.paidleave = dtrow["paidleave"].ToString();
            user.unpaidleave = dtrow["unpaidleave"].ToString();

            details.Add(user);
        }
        return details.ToArray();
    }

    public class attendancedetails
    {
        public string Number { get; set; }

        public string RefNo { get; set; }

        public string Name { get; set; }

        public string Date { get; set; }

        public string present { get; set; }

        public string Intime { get; set; }

        public string Outtime { get; set; }

        public string islate { get; set; }

        public string ishalfday { get; set; }

        public string paidleave { get; set; }

        public string unpaidleave { get; set; }
    }
}