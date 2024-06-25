using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_set_attendence : System.Web.UI.Page
{
    private static int fyid = 2;
    private DataUtility objDUT = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        fyid = CommonClass.Scaler("ActiveAcademicYear");
        if (!IsPostBack)
        {
            BindCalender();
            BindGrid();
            FillDDLAll();
        }
    }

    protected void FillDDLAll()
    {
        DateTime moment = DateTime.Now;
        ddlyear.DataSource = CommonClass.ABC("DdlyearinDatePicker");
        ddlyear.DataTextField = "Year_Name";
        ddlyear.DataValueField = "Year_Name";
        ddlyear.DataBind();
        ddlyear.SelectedValue = moment.Year.ToString();

        ddlmonth.DataSource = CommonClass.ABC("DdlMonthinDatePicker");
        ddlmonth.DataTextField = "Month_Name";
        ddlmonth.DataValueField = "Month_Id";
        ddlmonth.DataBind();
        ddlmonth.SelectedValue = moment.Month.ToString();
    }

    protected void BindCalender()
    {
        DataTable Dt = objDUT.GetDataTableSP("[usp_Own_Date_Picker_ForAttendance]");
        if (Dt.Rows.Count > 0)
        {
            Grid_Calender.DataSource = Dt;
            Grid_Calender.DataBind();
        }
    }

    protected void BindGrid()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Number");
        dt.Columns.Add("Emp_No");
        dt.Columns.Add("eid");
        dt.Columns.Add("Name");
        dt.Columns.Add("intime");
        dt.Columns.Add("outtime");
        dt.Columns.Add("DesignationDepartment");
        dt.Rows.Add();
        trgrid.Style.Add("display", "none");
        divgrid.Style.Add("display", "none");
        gvdetails.DataSource = dt;
        gvdetails.DataBind();
    }

    [WebMethod]
    public static int InsertAttendance(string Date)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[TakeAllAttendance]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[4];

                param[0] = new SqlParameter("@Date", Date);

                param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));

                param[2] = new SqlParameter("@fyid", fyid);

                param[3] = new SqlParameter("@intresult", SqlDbType.Int);

                param[3].Direction = ParameterDirection.Output;

                cmd.Parameters.Add(param[0]);

                cmd.Parameters.Add(param[1]);

                cmd.Parameters.Add(param[2]);

                cmd.Parameters.Add(param[3]);

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }

    [WebMethod]
    public static UserDetails[] BindDatatable(string Date)
    {
        DataSet ds = new DataSet();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[BindAttenDanceGrid]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Date", Date);
                param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.Number = dtrow["Number"].ToString();
                        user.Emp_No = dtrow["Emp_No"].ToString();
                        user.eid = dtrow["eid"].ToString();
                        user.Name = dtrow["Name"].ToString();
                        user.intime = dtrow["intime"].ToString();
                        user.outtime = dtrow["outtime"].ToString();
                        user.DesignationDepartment = dtrow["DesignationDepartment"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string Number { get; set; }

        public string Emp_No { get; set; }

        public string eid { get; set; }

        public string Name { get; set; }

        public string intime { get; set; }

        public string outtime { get; set; }

        public string DesignationDepartment { get; set; }
    }

    [WebMethod]
    public static int UpdateAttendance(string Date, string eid, string intime, string outtime, string absent)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Insert_Attendance ]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[8];

                param[0] = new SqlParameter("@isabsent", Convert.ToInt32(absent));

                param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));

                param[2] = new SqlParameter("@fyid", fyid);

                param[3] = new SqlParameter("@Date", Date);

                param[4] = new SqlParameter("@eid", Convert.ToInt32(eid));

                param[5] = new SqlParameter("@intime", intime);

                param[6] = new SqlParameter("@outtime", outtime);

                param[7] = new SqlParameter("@intresult", SqlDbType.Int);

                param[7].Direction = ParameterDirection.Output;

                cmd.Parameters.Add(param[0]);

                cmd.Parameters.Add(param[1]);

                cmd.Parameters.Add(param[2]);

                cmd.Parameters.Add(param[3]);

                cmd.Parameters.Add(param[4]);

                cmd.Parameters.Add(param[5]);

                cmd.Parameters.Add(param[6]);

                cmd.Parameters.Add(param[7]);

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }

    [WebMethod]
    public static int CloseDay(string Date)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_Close_Today]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[2];

                param[0] = new SqlParameter("@Date", Date);

                param[1] = new SqlParameter("@intresult", SqlDbType.Int);

                param[1].Direction = ParameterDirection.Output;

                cmd.Parameters.Add(param[0]);

                cmd.Parameters.Add(param[1]);

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }

    [WebMethod]
    public static getmonths[] BindDbDatePicker(string month, string year)
    {
        DataSet ds = new DataSet();
        List<getmonths> details = new List<getmonths>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_Own_Date_Picker_ForAttendance]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Year", year);
                param[1] = new SqlParameter("@Month", month);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getmonths user = new getmonths();
                        user.mon = dtrow["Mon"].ToString();
                        user.tue = dtrow["Tue"].ToString();
                        user.wed = dtrow["Wed"].ToString();
                        user.thu = dtrow["Thr"].ToString();
                        user.fri = dtrow["Fri"].ToString();
                        user.sat = dtrow["Sat"].ToString();
                        user.sun = dtrow["Sun"].ToString();
                        user.hfsun = dtrow["HfSun"].ToString();
                        user.hfmon = dtrow["HfMon"].ToString();
                        user.hftue = dtrow["HfTue"].ToString();
                        user.hfwed = dtrow["HfWed"].ToString();
                        user.hfthu = dtrow["HfThr"].ToString();
                        user.hffri = dtrow["HfFri"].ToString();
                        user.hfsat = dtrow["HfSat"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getmonths
    {
        public string mon { get; set; }

        public string tue { get; set; }

        public string wed { get; set; }

        public string thu { get; set; }

        public string fri { get; set; }

        public string sat { get; set; }

        public string sun { get; set; }

        public string hfsun { get; set; }

        public string hfmon { get; set; }

        public string hftue { get; set; }

        public string hfwed { get; set; }

        public string hfthu { get; set; }

        public string hffri { get; set; }

        public string hfsat { get; set; }
    }
}