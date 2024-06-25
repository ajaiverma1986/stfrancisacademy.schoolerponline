using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class Teacherpanel_event_Calender : System.Web.UI.Page
{
    private CommonClass commonOBJ = new CommonClass();
    private static int fyid = 2;
    private DataUtility objDUT = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        fyid = CommonClass.Scaler("ActiveAcademicYear");
        if (!IsPostBack)
        {
            BindCalender();
            FillDDLAll();
        }
    }

    protected void FillDDLAll()
    {
        DateTime moment = DateTime.Now;
        ddlmonth.DataSource = CommonClass.ABC("DdlMonthinDatePicker");
        ddlmonth.DataTextField = "Month_Name";
        ddlmonth.DataValueField = "Month_Id";
        ddlmonth.DataBind();
        ddlmonth.SelectedValue = moment.Month.ToString();
    }

    protected void BindCalender()
    {
        DateTime moment = DateTime.Now;
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@fyid", fyid);
        param[1] = new SqlParameter("@Month", moment.Month.ToString());
        DataTable Dt = objDUT.GetDataTableSP(param, "[usp_listofholiday]");
        if (Dt.Rows.Count > 0)
        {
            Grid_Calender.DataSource = Dt;
            Grid_Calender.DataBind();
        }
    }

    [WebMethod]
    public static getmonths[] BindDbDatePicker(string month)
    {
        DataSet ds = new DataSet();
        List<getmonths> details = new List<getmonths>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_listofholiday]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@fyid", fyid);
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
    }
}