using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;
public partial class BranchPanel_commonpage_holiday_management : System.Web.UI.Page
{
    
    private CommonClass commonOBJ = new CommonClass();
    CommonClass CommonClass = new CommonClass();
    private static int fyid = 2;
    private DataUtility objDUT = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {    
        fyid = CommonClass.GetActiveAcedmicYear();
        if (!IsPostBack)
        {
            BindReapeter();
            maindivforgriddemo.Style.Add("display", "block");
            DateTime now = DateTime.Now;
            ddlforstate.SelectedValue = now.Month.ToString();
            
        }
    }
    protected void BindReapeter()
    {
        DateTime now = DateTime.Now;
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@monthid", Convert.ToInt32(now.Month.ToString()));
        param[1] = new SqlParameter("@fyid", fyid);
        DataTable dt = objDUT.GetDataTableSP(param, "[Current_Month_Days]");
        if (dt.Rows.Count > 0)
        {
            dlsponserad.DataSource = dt;
            dlsponserad.DataBind();
        }
        else
        {
            dlsponserad.Dispose();
        }
    }
    [WebMethod]
    public static UserDetails[] BindDatatable(string monthid)
    {
        DataSet ds = new DataSet();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Current_Month_Days]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@monthid", monthid);
                param[1] = new SqlParameter("@fyid", fyid);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.Dayid = dtrow["Dayid"].ToString();
                        DateTime datetime = Convert.ToDateTime(dtrow["Date"].ToString());
                        user.Date = datetime.ToString("MMM dd, yyyy");
                        user.Dayname = dtrow["Dayname"].ToString();
                        user.Monthname = dtrow["Monthname"].ToString();
                        user.Monthid = dtrow["Monthid"].ToString();
                        user.chkstatus = dtrow["chkstatus"].ToString();
                        user.reason = dtrow["reason"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }
    public class UserDetails
    {
        public string Dayid { get; set; }

        public string Date { get; set; }

        public string Dayname { get; set; }

        public string Monthname { get; set; }
        public string reason { get; set; }
        public string Monthid { get; set; }
        public string chkstatus { get; set; }
    }
    [WebMethod]
    public static int InsertHoliday(string year, string month, string day, string reason, int status)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_Insert_Holiday]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[8];
                param[0] = new SqlParameter("@year", year);
                param[1] = new SqlParameter("@month", month);
                param[2] = new SqlParameter("@Day", day);
                param[3] = new SqlParameter("@fyid", fyid);
                param[4] = new SqlParameter("@reason", reason);
                param[5] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
                param[6] = new SqlParameter("@intresult", SqlDbType.Int);
                param[6].Direction = ParameterDirection.Output;
                param[7] = new SqlParameter("@status", status);
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
}