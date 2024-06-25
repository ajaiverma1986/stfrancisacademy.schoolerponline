using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_daily_wise_attendance_report : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private static int fyid = 2;
    private string year, month;

    protected void Page_Load(object sender, EventArgs e)
    {
        fyid = CommonClass.Scaler("ActiveAcademicYear");

        if (!IsPostBack)
        {
            bind_gvdetails();
            year = ddlfinancialyear.SelectedValue;
            month = ddlmonth.SelectedValue;
            BindMainGrid();
        }
    }

    protected void bind_gvdetails()
    {
        DataTable Dtdetails = new DataTable();
        Dtdetails.Columns.Add("Number", typeof(string));
        Dtdetails.Columns.Add("RefNo", typeof(string));
        Dtdetails.Columns.Add("Name", typeof(string));
        Dtdetails.Columns.Add("Date", typeof(string));
        Dtdetails.Columns.Add("present", typeof(string));
        Dtdetails.Columns.Add("Intime", typeof(string));
        Dtdetails.Columns.Add("Outtime", typeof(string));
        Dtdetails.Columns.Add("islate", typeof(string));
        Dtdetails.Columns.Add("ishalfday", typeof(string));
        Dtdetails.Columns.Add("paidleave", typeof(string));
        Dtdetails.Columns.Add("unpaidleave", typeof(string));

        DataRow Dr = Dtdetails.NewRow();
        Dr["Number"] = "1";
        Dr["RefNo"] = "AWS11234";
        Dr["Name"] = "Amit Sharma";
        Dr["Date"] = "2000-01-01";
        Dr["present"] = "yes";
        Dr["Intime"] = "yes";
        Dr["Outtime"] = "yes";
        Dr["islate"] = "no";
        Dr["ishalfday"] = "no";
        Dr["paidleave"] = "1";
        Dr["unpaidleave"] = "1";
        Dtdetails.Rows.Add(Dr);

        gvdetails.DataSource = Dtdetails;
        gvdetails.DataBind();

        DateTime moment = DateTime.Now;

        ddlfinancialyear.DataSource = CommonClass.ABC("DdlFinancialyear");
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataValueField = "FYID";
        ddlfinancialyear.DataBind();
        ddlfinancialyear.SelectedValue = fyid.ToString();

        ddlmonth.DataSource = CommonClass.ABC("DdlMonthinDatePicker");
        ddlmonth.DataTextField = "Month_Name";
        ddlmonth.DataValueField = "Month_Id";
        ddlmonth.DataBind();
        ddlmonth.SelectedValue = moment.Month.ToString();
    }

    protected void BindMainGrid()
    {
        DataSet ds = new DataSet();
        SqlParameter[] param = new SqlParameter[6];

        param[0] = new SqlParameter("@fromDate", txtattendancedate.Text);

        param[1] = new SqlParameter("@ToDate", txtattendancetodate.Text);

        param[2] = new SqlParameter("@pagesize", 30);

        param[3] = new SqlParameter("@pageno", 1);

        param[4] = new SqlParameter("@fyid", year);

        param[5] = new SqlParameter("@month", month);

        ds = objdut.GetDataSetSP(param, "[usp_overallattendancereport]");

        if (ds.Tables[0].Rows.Count > 0)
        {
            maingridviewforreport.DataSource = ds.Tables[0];
            hfpages.Value = ds.Tables[1].Rows[0]["pages"].ToString();
            lbltotalfornoofpresent.Text = (from row in ds.Tables[0].AsEnumerable() select row.Field<int>("NoOfPresent")).Sum().ToString();
            lbltotalfornoofabsent.Text = (from row in ds.Tables[0].AsEnumerable() select row.Field<int>("NoofAbsent")).Sum().ToString();
            lbltotalfornooflate.Text = (from row in ds.Tables[0].AsEnumerable() select row.Field<int>("NoofLate")).Sum().ToString();
            lbltotalfortotal.Text = (from row in ds.Tables[0].AsEnumerable() select row.Field<int>("Total")).Sum().ToString();
            maingridviewforreport.DataBind();
            divfornoofpresenttotal.Style.Add("display", "block");
            divforpagging.Style.Add("display", "block");
        }
        else
        {
            DataTable Dtmain = new DataTable();
            Dtmain.Columns.Add("RowNumber", typeof(string));
            Dtmain.Columns.Add("Date", typeof(string));
            Dtmain.Columns.Add("NoOfPresent", typeof(string));
            Dtmain.Columns.Add("NoofAbsent", typeof(string));
            Dtmain.Columns.Add("NoofLate", typeof(string));
            Dtmain.Columns.Add("Total", typeof(string));

            DataRow Dr = Dtmain.NewRow();
            Dr["RowNumber"] = "10";
            Dr["Date"] = "2000-01-01";
            Dr["NoOfPresent"] = "10";
            Dr["NoofAbsent"] = "2000-01-01";
            Dr["NoofLate"] = "10";
            Dr["Total"] = "100";
            Dtmain.Rows.Add(Dr);

            maingridviewforreport.DataSource = Dtmain;
            maingridviewforreport.DataBind();
            lblmsgformaingrid.Style.Add("display", "block");
            lblmsgformaingrid.Text = "No attendance report available according to your selection.";
            divfornoofpresenttotal.Style.Add("display", "none");
            divforpagging.Style.Add("display", "none");
            onlygrid.Style.Add("display", "none");
        }
    }

    //=============================This code is binding the main grid================================================
    [WebMethod]
    public static attendancereport[] BindMainGrid(string datefrom, string dateto, string financialid, string monthid, int pagesize, int pageno)
    {
        DataSet ds = new DataSet();

        List<attendancereport> details = new List<attendancereport>();

        SqlParameter[] param = new SqlParameter[6];

        param[0] = new SqlParameter("@fyid", financialid);

        param[1] = new SqlParameter("@month", monthid);

        param[2] = new SqlParameter("@pagesize", pagesize);

        param[3] = new SqlParameter("@pageno", pageno);

        param[4] = new SqlParameter("@fromDate", datefrom);

        param[5] = new SqlParameter("@ToDate", dateto);

        DataUtility ObjUTL = new DataUtility();

        ds = ObjUTL.GetDataSetSP(param, "usp_overallattendancereport");

        foreach (DataRow dtrow in ds.Tables[0].Rows)
        {
            attendancereport user = new attendancereport();

            user.RowNumber = dtrow["RowNumber"].ToString();
            if (dtrow["Date"].ToString() != "")
            {
                DateTime dte = Convert.ToDateTime(dtrow["Date"]);
                user.Date = dte.ToString("MMM dd yyyy");
            }
            else
            {
                user.Date = "";
            }
            user.NoOfPresent = dtrow["NoOfPresent"].ToString();

            user.totalnoOfPresent += Convert.ToInt32(user.NoOfPresent);

            user.NoofAbsent = dtrow["NoofAbsent"].ToString();
            user.NoofLate = dtrow["NoofLate"].ToString();
            user.Total = dtrow["Total"].ToString();
            user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString();
            details.Add(user);
        }
        return details.ToArray();
    }

    public class attendancereport
    {
        public string RowNumber { get; set; }

        public string Date { get; set; }

        public string NoOfPresent { get; set; }

        public string NoofAbsent { get; set; }

        public string NoofLate { get; set; }

        public string Total { get; set; }

        public string totalnoOfPresent { set; get; }

        public string pagecount { get; set; }
    }

    //=========================================this code is for binding details grid view===================================
    [WebMethod]
    public static attendanceclass[] bindattendancedetails(string date, string name)
    {
        DataSet ds = new DataSet();
        List<attendanceclass> details = new List<attendanceclass>();

        SqlParameter[] p = new SqlParameter[5];

        p[0] = new SqlParameter("@brid", SqlDbType.Int);
        p[0].Value = Convert.ToInt32(HttpContext.Current.Session["BrBrid"]);

        p[1] = new SqlParameter("@FromDate", SqlDbType.VarChar, 200);
        p[1].Value = date;

        p[2] = new SqlParameter("@ToDate", SqlDbType.VarChar, 200);
        p[2].Value = "";

        p[3] = new SqlParameter("@eid", 0);

        p[4] = new SqlParameter("@name", SqlDbType.VarChar, 200);
        p[4].Value = name;

        DataUtility ObjUTL = new DataUtility();
        ds = ObjUTL.GetDataSetSP(p, "usp_AttendanceReport_DayWise");

        foreach (DataRow dtrow in ds.Tables[0].Rows)
        {
            attendanceclass user = new attendanceclass();
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

    public class attendanceclass
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