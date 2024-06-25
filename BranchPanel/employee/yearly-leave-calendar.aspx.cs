using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class branchpanel_employee_yearly_leave_calendar : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
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