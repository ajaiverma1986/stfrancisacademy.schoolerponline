using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;

public partial class LoginT : System.Web.UI.Page
{
    private Utility objUT = new Utility();
    private DataUtility objDUT = new DataUtility();
    private SqlCommand cmd, cmd1;
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
    private SqlDataReader sdr;
    private string Query;
    private string userid, pass;
    private int x;

    protected void Page_Load(object sender, EventArgs e)
    {
        Session.Remove("empid");
        if (!Page.IsPostBack)
        {
            Response.Cookies["x"].Value = Convert.ToString(0);
        }
        if (Request.Cookies["loginid"] != null && Request.Cookies["Password"] != null)
        {
            userid = Request.Cookies["loginid"].Value;
            pass = Request.Cookies["Password"].Value;
            LoginCheck(userid, pass);
        }
    }

    private void LoginCheck(string uid, string pas)
    {
        try
        {
            Query = "Select * From Employee_login where username=@loginid and password=@password and status=1";

            cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = Query;
            cmd.Parameters.AddWithValue("@loginid", uid);
            cmd.Parameters.AddWithValue("@password", pas);
            con.Open();
            sdr = cmd.ExecuteReader();
            if (sdr.HasRows)
            {
                while (sdr.Read())
                {
                    Session["eid"] = sdr["eid"];
                    Session["loginid"] = sdr["username"];
                    Session["brbrid"] = sdr["brid"];
                    string str = "update Employee_login set lastlogin = '" + DateTime.Now.ToString("yyyy-MM-dd") + "', IPAddress='" + Convert.ToString(HttpContext.Current.Request.UserHostAddress) + "' where username='" + UserName.Text.Trim() + "'";
                    objDUT.ExecuteSql(str);
                    x = 0;
                    int res = objDUT.ExecuteSql(str);
                    if (Request.Params["ReturnUrl"] != null)
                    {
                        FormsAuthentication.RedirectFromLoginPage(UserName.Text, false);
                    }
                    else
                    {
                        FormsAuthentication.SetAuthCookie(UserName.Text, false);
                        Response.Redirect("Teacherpanel/employee-panel-home-page.aspx", false);
                    }
                }
            }
            else
            {
                lblMsg.Text = "Please provide correct details.";
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message;
        }
    }

    protected void LoginButton_Click1(object sender, EventArgs e)
    {
        LoginCheck(UserName.Text.Trim(), Password.Text.Trim());
    }
}