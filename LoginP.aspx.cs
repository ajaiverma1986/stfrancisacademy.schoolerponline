using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;

public partial class LoginP : System.Web.UI.Page
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
        if (ddlselect.SelectedIndex == 1)
        {
            if (!Page.IsPostBack)
            {
                // ViewState["x"] = 0;
                Response.Cookies["x"].Value = Convert.ToString(0);
                //Session.Clear();
                //Session.Abandon();
            }
            if (Request.Cookies["loginid"] != null && Request.Cookies["Password"] != null)
            {
                userid = Request.Cookies["loginid"].Value;
                pass = Request.Cookies["Password"].Value;
                LoginCheck(userid, pass);
            }
        }
        else if (ddlselect.SelectedValue == "2")
        {
            Session.Remove("empid");
            if (!Page.IsPostBack)
            {
                // ViewState["x"] = 0;
                Response.Cookies["x"].Value = Convert.ToString(0);
                //Session.Clear();
                //Session.Abandon();
            }
            if (Request.Cookies["loginid"] != null && Request.Cookies["Password"] != null)
            {
                userid = Request.Cookies["loginid"].Value;
                pass = Request.Cookies["Password"].Value;
                LoginCheckteacher(userid, pass);
            }
        }
    }

    private void LoginCheck(string uid, string pas)
    {
        try
        {
            if (objUT.IsNumeric(UserName.Text))
            {
                Query = "Select P.*,sturegno,ta.transportaion From Parent_login P inner join tbl_Admission ta on ta.adid=p.adid where ta.adid=p.adid and P.username='" + uid + "' and P.password='" + pas + "' and P.isActive=1 ";
            }
            else
            {
                Query = "Select P.*,sturegno,ta.transportaion From Parent_login P inner join tbl_Admission ta on ta.adid=p.adid where ta.adid=p.adid and P.username='" + uid + "' and P.password='" + pas + "' and P.isActive=1 ";
            }

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
                    // RemoveSessions();

                    Session["stregno"] = sdr["sturegno"].ToString();

                    Session["ADID4"] = sdr["adid"].ToString();

                    Session["Branchid"] = sdr["brid"].ToString();

                    Session["transptype"] = sdr["transportaion"].ToString();

                    Session["loginidp"] = sdr["username"].ToString();

                    Session["LLogin"] = sdr["lastlogin"].ToString();

                    // Session["ADID"] = "0";
                    Session["Member"] = "1";

                    string str = "update Parent_login set lastlogin = '" + DateTime.Now + "', IPaddress='" + Convert.ToString(HttpContext.Current.Request.UserHostAddress) + "' where username='" + UserName.Text.Trim() + "'";

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
                        Response.Redirect("ParentPanel/studentviewinfo.aspx", false);
                    }
                }
            }
            else
            {
                //Response.Redirect("Index.html");
                lblMsg.Text = "Wrong login details.";
                Label1.Text = "Please provide correct details";
            }
        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message);
            lblMsg.Text = "Wrong login details.";
            Label1.Text = "Please provide correct details";
        }
    }

    private void LoginCheckteacher(string uid, string pas)
    {
        try
        {
            if (objUT.IsNumeric(UserName.Text))
            {
                Query = "Select L.* From teacher_login L where L.loginid=@loginid and L.Password=@password and L.Tactive=1 ";
            }
            else
            {
                Query = "Select L.* From teacher_login L where L.loginid=@loginid and L.Password=@password and L.Tactive=1 ";
            }

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
                    // RemoveSessions();
                    Session["empid"] = sdr["empid"].ToString();

                    Session["loginid"] = sdr["loginid"].ToString();

                    Session["LLogin"] = sdr["lastlogin"].ToString();
                    Session["brid1"] = sdr["brid"].ToString();

                    // Session["ADID"] = "0";
                    Session["Member"] = "1";

                    string str = "update teacher_login set lastlogin = '" + DateTime.Now + "', IP='" + Convert.ToString(HttpContext.Current.Request.UserHostAddress) + "' where loginid='" + UserName.Text.Trim() + "'";

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
                        Response.Redirect("Teacherloginpanel/Profile.aspx", false);
                    }
                }
            }
            else
            {
                lblMsg.Text = "Wrong login details.";
                Label1.Text = "Please provide correct details";
                //Response.Redirect("Index.html");
            }
        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message);
            lblMsg.Text = "Wrong login details.";
            Label1.Text = "Please provide correct details";
        }
    }

    protected void LoginButton_Click1(object sender, EventArgs e)
    {
        if (ddlselect.SelectedValue == "1")
        {
            LoginCheck(UserName.Text.Trim(), Password.Text.Trim());
        }
        else if (ddlselect.SelectedValue == "2")
        {
            LoginCheckteacher(UserName.Text.Trim(), Password.Text.Trim());
        }
    }
}