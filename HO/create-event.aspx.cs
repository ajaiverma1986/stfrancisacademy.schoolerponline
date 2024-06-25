using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HO_create_event : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
     [WebMethod]
    public static Geteventdetails[] BindGridByschool()
    {
        DataSet Ds = new DataSet();
        List<Geteventdetails> SourceDetails = new List<Geteventdetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 2);
        Ds = Objdut.GetDataSetSP(param, "[usp_schooleventcalendar]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                Geteventdetails user = new Geteventdetails();
                user.event_id = dtrow["event_id"].ToString();
                user.eventdate = dtrow["eventdate"].ToString();
                user.eventdescription = dtrow["eventdescription"].ToString();
                SourceDetails.Add(user);
            }
        }
        return SourceDetails.ToArray();
    }
    public class Geteventdetails
    {
        public string event_id { get; set; }
        public string eventdate { get; set; }
        public string eventdescription { get; set; }
    }
  
    [WebMethod]
    public static int AddEvents(string EventDate, string Mode, string EventDescription, string updateid)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@eventdate", EventDate);
        param[1] = new SqlParameter("@eventdescription", EventDescription.Replace("`", "'"));
        param[2] = new SqlParameter("@mode", Mode);
        param[3] = new SqlParameter("@updateid", updateid);
        param[4] = new SqlParameter("@intResult", SqlDbType.Int);
        param[4].Direction = ParameterDirection.Output;
        int result = Convert.ToInt32(param[4].Value);
        result = Objdut.ExecuteSqlSP(param, "usp_schooleventcalendar");
        return result;
    }
    [WebMethod]
    public static int DeleteStatusEvents(string eventdeleteid)
    {
        DataUtility Objdut = new DataUtility();
        int ret = Objdut.ExecuteSql("update tbl_schoolevent set status = 0 where event_id=" + eventdeleteid + "");
        return ret;
    }

}