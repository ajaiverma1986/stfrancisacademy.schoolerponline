using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class branchpanel_employee_halfday_list : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private string url = "";
    private static string userid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        if (!IsPostBack)
        {
            getleaveslist();
            userid = Session["BrADID"].ToString();
        }
    }

    private void getleaveslist()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 7);
        DataTable dt = objdut.GetDataTableSP(param, "[usp_leavehistory]");
        gvleavedetails.DataSource = dt;
        gvleavedetails.DataBind();
    }

    [WebMethod]
    public static int addhalfday(string hdid, string ispaid, string isapprove)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_leavehistory]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@hdid", hdid);
                cmd.Parameters.Add("@ispaid", ispaid);
                cmd.Parameters.Add("@approve", isapprove);
                cmd.Parameters.Add("@mode", 8);
                cmd.Parameters.Add("@adminuserid", userid);
                int result = cmd.ExecuteNonQuery();
                return result;
            }
        }
    }

    [WebMethod]
    public static UserDetails[] BindDatatable()
    {
        DataSet ds = new DataSet();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_leavehistory]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@mode", 7);
                cmd.Parameters.Add(param[0]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.refNo = dtrow["refNo"].ToString();
                        user.name = dtrow["name"].ToString();
                        user.hd_date = dtrow["hd_date"].ToString();
                        user.hdid = dtrow["hdid"].ToString();
                        user.eid = dtrow["eid"].ToString();
                        user.halfday = dtrow["halfday"].ToString();
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

        public string halfday { get; set; }

        public string hd_date { get; set; }

        public string hdid { get; set; }

        public string eid { get; set; }
    }
}