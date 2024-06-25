using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class ParentPanel_dayworkreport : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("topiclecture");
        dt.Columns.Add("classwork");
        dt.Columns.Add("homework");
        dt.Columns.Add("name");
        dt.Columns.Add("mobile");
        dt.Columns.Add("SubjectName");
        dt.Rows.Add();
        grdclass.DataSource = dt;
        grdclass.DataBind();
    }

    [WebMethod]
    public static getclasswork[] getclassworkdetails()
    {
        DataSet ds = new DataSet();
        List<getclasswork> details = new List<getclasswork>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_addmasterentry]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@mode", 4);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getclasswork user = new getclasswork();
                        user.topiclecture = dtrow["topiclecture"].ToString();
                        user.classwork = dtrow["classwork"].ToString();
                        user.homework = dtrow["homework"].ToString();
                        user.name = dtrow["name"].ToString();
                        user.mobile = dtrow["mobile"].ToString();
                        user.SubjectName = dtrow["SubjectName"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getclasswork
    {
        public string topiclecture { get; set; }

        public string classwork { get; set; }

        public string homework { get; set; }

        public string name { get; set; }

        public string mobile { get; set; }

        public string SubjectName { get; set; }
    }
}