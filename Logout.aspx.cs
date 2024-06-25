using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;

public partial class Login : System.Web.UI.Page
{
    private SqlCommand cmd = new SqlCommand();
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
    private SqlDataReader sdr;
    private string Query;
    private string userid, pass;

    protected void Page_Init(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
        Response.Cache.SetNoStore();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["s"] != null)
        {
            Query = Request.QueryString["s"].ToString();
            Session.Remove(Query);
            Session.Remove("BrBrid");
            Session.Remove("RoleID");
        }
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //Response.Cache.SetAllowResponseInBrowserHistory(false);
        //Session.RemoveAll();
        //Session.Abandon();
        //FormsAuthentication.SignOut();
        if (Session[Query] == null)
        {
            Response.Redirect("~/User-Login.aspx");
        }
    }
}