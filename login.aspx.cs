using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.NetworkInformation;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Linq;

public partial class MemeberPanel_Login : System.Web.UI.Page
{
    private DataUtility objut = new DataUtility();
    private string userid, pass;
    private SqlCommand cmd = new SqlCommand();
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
    private SqlParameter[] param = new SqlParameter[2];
    private CommonClass commonOBJ = new CommonClass();
    private int fyid = 0;
    private static string emailforhost = "", hostname = "", password = "";

    protected void Page_PreInit(object sender, EventArgs e)
    {
        string imgsrc = HomeMasterPage.MasterMethod("BindLogo");
        if (imgsrc != "")
        {
            string[] data = imgsrc.Split('^');
            if (data.Length > 0)
            {
                logo.ImageUrl = "images/" + data[0];
                favicon.Href = "images/" + data[2];
            }
            else
            {
                logo.ImageUrl = "images/icons/login_icon_1.gif";
                favicon.Href = "images/icons/login_icon_1.gif";
            }
        }
        else
        {
            logo.ImageUrl = "images/icons/login_icon_1.gif";
            favicon.Href = "images/icons/login_icon_1.gif";
        }
        if (Request.QueryString.Count > 0)
        {
            if (Request.QueryString[0].ToString()!="")
            {
                if (Session["BrBrid"] != null)
                {
                    int iCount = Regex.Matches(Request.QueryString[0].ToString(), @"[a-zA-Z]").Count;
                    if (iCount == 0)
                    {
                        if ((Convert.ToInt32(Request.QueryString[0]) != Convert.ToInt32(Session["BrBrid"])))
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(),
                            "script", @"var a=alert('You cant not open more Branch at a time. Please first logout the open branch');
                        if (a==true) {location.replace('BranchPanel/Common/Default.aspx');}
                        else{location.replace('BranchPanel/Common/Default.aspx');}", true);
                            return;
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(),
                                                   "script", @"var a=alert('Already Login');
                        if (a==true) {location.replace('BranchPanel/Common/Default.aspx');}
                        else{location.replace('BranchPanel/Common/Default.aspx');}", true);
                            return;
                        }
                    }
                }
            }
        }
        if (Request.QueryString.Count > 0)
        {
            if (Convert.ToString(Session["User"]) != "")
            {
                if (Session["RootNodeBr"] != null)
                {
                    Session["RootNodeBr"] = null;
                }
                if (Request.QueryString["brid"] != null)
                {
                    DataUtility Du = new DataUtility();
                    DataTable dt = new DataTable();
                    dt = Du.GetDataTable("select BrCode,Password from Branch_master where Brid=" + Request.QueryString["brid"]);
                    if (dt.Rows.Count > 0)
                    {
                        userid = dt.Rows[0]["BrCode"].ToString();
                        pass = dt.Rows[0]["Password"].ToString();
                        FillSessionAfterCheck(userid.Trim(), pass.Trim());
                    }
                }
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PayIDCheck();
            bool isvalid = true;
            if (isvalid == true)
            {
                fyid = CommonClass.Scaler("ActiveAcademicYear");
            }
            if (Session["uid"] != null)
            {
                Panelotp.Style.Add("display", "none");
                Panellogin.Style.Add("display", "block");
            }
            else
            {
                Panelotp.Style.Add("display", "block");
                Panellogin.Style.Add("display", "none");
            }
        }
    }

    protected void PayIDCheck()
    {
        int fyid = Convert.ToInt32(objut.GetScalar("select fyid from financial_Year where isActive=1 and isClosed=0"));
        string Query = "select convert(Date,enddate) from tbl_MonthlySalaryMaster where status=1";
        DateTime enddate = Convert.ToDateTime(objut.GetScalar(Query));
        string sdd = enddate.ToString();
        DateTime currenttime = Convert.ToDateTime(objut.GetScalar("select convert(date,getdate())"));
        if (sdd != "1/1/0001 12:00:00 AM")
        {
            if (currenttime > enddate)
            {
                SqlParameter[] pa = new SqlParameter[1];
                pa[0] = new SqlParameter("@intresult", 0);
                pa[0].Direction = ParameterDirection.Output;
                int count = objut.ExecuteSqlSP(pa, "usp_IncrementPayId");
                if (count == 1)
                {
                }
            }
        }
    }

    private void LoginCheck(string uid, string pas, string Type)
    {
        #region
        //This Block Of Code Is For Send Otp Or ODP Start Here
        string Query = "select Otp_Or_OdpStatus,SendMail,SendSms,IsIpCheck,IpAdressForLogin,IsMacCheck,REPLACE(MacAdressForLogin,'-','')as MacAdressForLogin from tbluser where             username='" + uid.Trim() + "' and password ='" + pas + "'";
        DataTable DtForOtpOdp = objut.GetDataTable(Query);
        if (DtForOtpOdp.Rows.Count > 0)
        {
            if (Convert.ToString(DtForOtpOdp.Rows[0]["IpAdressForLogin"]) != "" && Convert.ToInt32(DtForOtpOdp.Rows[0]["IsIpCheck"]) == 1)
            {
                if (!Convert.ToString(DtForOtpOdp.Rows[0]["IpAdressForLogin"]).Contains(GetIpAddress()))
                {
                    Utility.ViewAlertMessage(this, "Your IP Address Is Not Integrated With Your LoginId So Please Contact To Admin.");
                    return;
                }                
            }
            else
            {
                if (Convert.ToString(DtForOtpOdp.Rows[0]["MacAdressForLogin"]) != "" && Convert.ToInt32(DtForOtpOdp.Rows[0]["IsMacCheck"]) == 1)
                {
                    bool flag = false;
                    List<string> lst = GetMACAddress();
                    if (Convert.ToString(DtForOtpOdp.Rows[0]["MacAdressForLogin"]).Contains(","))
                    {
                        string[] arr = Convert.ToString(DtForOtpOdp.Rows[0]["MacAdressForLogin"]).Split(',');
                        foreach (string a in arr)
                        {
                            if (!string.IsNullOrWhiteSpace(a))
                            {
                                if (lst.Any(x => x == a))
                                {
                                    flag = true;
                                }
                            }

                        }
                    }
                    else
                    {
                        flag = lst.Any(x => x == Convert.ToString(DtForOtpOdp.Rows[0]["MacAdressForLogin"]));
                    }


                    if (!flag)
                    {
                        Utility.ViewAlertMessage(this, "Your MAC Address Is Not Integrated With Your LoginId So Please Contact To Admin.");
                        return;
                    }
                }
            }
        }
        if (DtForOtpOdp.Rows.Count > 0)
        {
            //This Block Of Code Is For Send OTP
            if (Convert.ToString(DtForOtpOdp.Rows[0]["Otp_Or_OdpStatus"]) == "1" || Convert.ToString(DtForOtpOdp.Rows[0]["Otp_Or_OdpStatus"]) == "2")
            {
                string message = "", mailtext = "";
                SqlParameter[] otpparam = new SqlParameter[2];
                otpparam[0] = new SqlParameter("@username", uid);
                otpparam[1] = new SqlParameter("@password", pas);
                DataTable Dt = objut.GetDataTableSP(otpparam, "[usp_manageotp]");
                string Str = Dt.Rows[0]["ReturnOutPut"].ToString();
                string[] words = Str.Split(',');
                if (Convert.ToString(DtForOtpOdp.Rows[0]["Otp_Or_OdpStatus"]) == "1")
                {
                    message = "Your OTP: " + words[1];
                }
                if (Convert.ToString(DtForOtpOdp.Rows[0]["Otp_Or_OdpStatus"]) == "2")
                {
                    message = "Your ODP: " + words[1];
                }
                Session["uid"] = uid.ToString();
                Session["pas"] = pas.ToString();
                Session["OTP"] = words[1].ToString();
                string emailforsend = Dt.Rows[0]["mailid"].ToString();
                Session["username"] = uid;
                Session["password"] = pas;
                //This Block Of Code Is For Send Mail Yes
                if (Dt.Rows[0]["otpodptype"].ToString() != "2")
                {
                    if (Convert.ToString(DtForOtpOdp.Rows[0]["SendMail"]) == "1")
                    {
                        DataTable dtformail = objut.GetDataTable("select module_hostname,emialid_for_module,password_of_email from tbl_email_sms_send_master where                                       ModuleId=10");
                        if (dtformail.Rows.Count > 0)
                        {
                            emailforhost = dtformail.Rows[0]["emialid_for_module"].ToString();
                            hostname = dtformail.Rows[0]["module_hostname"].ToString();
                            password = dtformail.Rows[0]["password_of_email"].ToString();

                            System.Threading.Thread emailThread = new System.Threading.Thread(delegate()
                            {
                                if (Convert.ToString(DtForOtpOdp.Rows[0]["Otp_Or_OdpStatus"]) == "1")
                                {
                                    mailtext = "Your OTP is: <span style='font-weight:bold'>" + words[1].Trim() + "</spn>";
                                }
                                if (Convert.ToString(DtForOtpOdp.Rows[0]["Otp_Or_OdpStatus"]) == "2")
                                {
                                    mailtext = "Your ODP is: <span style='font-weight:bold'>" + words[1].Trim() + "</spn>";
                                }
                                SendMail.SendDemo(emailforhost, emailforsend, "", "", "OTP", mailtext, password, hostname);
                            });
                            emailThread.Start();
                        }
                    }
                    //This Block Of Code Is For Send SMS Yes
                    if (Convert.ToString(DtForOtpOdp.Rows[0]["SendSms"]) == "1")
                    {
                        sendsmsonmobile(words[0], message);
                    }
                }
                Panelotp.Style.Add("display", "none");
                Panellogin.Style.Add("display", "block");
            }
            else
            {
                FillSessionAfterCheck(uid, pas);
            }
        }
        else
        {
            Utility.ViewAlertMessage(this, "Invalid Login Details.");
        }
        //This Block Of Code Is For Send Otp Or ODP End Here
        #endregion
    }

    protected void LoginButton_Click(object sender, EventArgs e)
    {
        //Utility.ViewAlertMessage(this, Request.UserHostAddress);
        LoginCheck(UserName.Text.Trim(), Password.Text.Trim(), "");
    }

    public static int sendsmsonmobile(string mobile, string msg)
    {
        string mobileno = mobile;
        string message = msg;
        int result = 0;
        result = sendMessageToMobile.SMSSend(mobileno, message,"");
        return result;
    }

    public void KillSession()
    {
        Session.RemoveAll();
        Session.Abandon();
        FormsAuthentication.SignOut();
        Panelotp.Style.Add("display", "block");
        Panellogin.Style.Add("display", "none");
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        KillSession();
    }

    protected void btnotpsend_Click(object sender, EventArgs e)
    {
        ClickOnOtpSubmit();
    }

    public void ClickOnOtpSubmit()
    {
        string otp = txtotp.Text;
        if (!string.IsNullOrEmpty(otp))
        {
            if (Session["OTP"].ToString().Trim() == otp.Trim())
            {
                FillSessionAfterCheck(Session["username"].ToString(), Session["password"].ToString());
            }
            else
            {
                Utility.ViewAlertMessage(this, "Please Enter Valid Otp.");
            }
        }
    }

    protected void btnresend_Click(object sender, EventArgs e)
    {
        string Query = "select Otp_Or_OdpStatus,SendMail,SendSms from tbluser where username='" + Session["uid"].ToString().Trim() + "'";
        DataTable DtForOtpOdp = objut.GetDataTable(Query);
        if (DtForOtpOdp.Rows.Count > 0)
        {
            //This Block Of Code Is For Send OTP
            if (Convert.ToString(DtForOtpOdp.Rows[0]["Otp_Or_OdpStatus"]) == "1" || Convert.ToString(DtForOtpOdp.Rows[0]["Otp_Or_OdpStatus"]) == "2")
            {
                string mailtext = "", message = "";
                SqlParameter[] otpparam = new SqlParameter[3];
                otpparam[0] = new SqlParameter("@username", Session["uid"].ToString());
                otpparam[1] = new SqlParameter("@password", Session["pas"].ToString());
                otpparam[2] = new SqlParameter("@isresend", 1);
                DataTable Dt = objut.GetDataTableSP(otpparam, "[usp_manageotp]");
                string Str = Dt.Rows[0]["ReturnOutPut"].ToString();
                string[] words = Str.Split(',');
                if (Convert.ToString(DtForOtpOdp.Rows[0]["Otp_Or_OdpStatus"]) == "1")
                {
                    message = "Your OTP:=> " + words[1];
                }
                if (Convert.ToString(DtForOtpOdp.Rows[0]["Otp_Or_OdpStatus"]) == "2")
                {
                    message = "Your ODP:=> " + words[1];
                }
                Session["uid"] = Session["uid"].ToString();
                Session["pas"] = Session["pas"].ToString();
                Session["OTP"] = words[1].ToString();
                string emailforsend = Dt.Rows[0]["mailid"].ToString();
                Session["username"] = Session["uid"];
                Session["password"] = Session["pas"];
                //This Block Of Code Is For Send Mail Yes
                if (Convert.ToString(DtForOtpOdp.Rows[0]["SendMail"]) == "1")
                {
                    DataTable dtformail = objut.GetDataTable("select module_hostname,emialid_for_module,password_of_email from tbl_email_sms_send_master where ModuleId=10");
                    if (dtformail.Rows.Count > 0)
                    {
                        emailforhost = dtformail.Rows[0]["emialid_for_module"].ToString();
                        hostname = dtformail.Rows[0]["module_hostname"].ToString();
                        password = dtformail.Rows[0]["password_of_email"].ToString();
                    }
                    System.Threading.Thread emailThread = new System.Threading.Thread(delegate()
                    {
                        if (Convert.ToString(DtForOtpOdp.Rows[0]["Otp_Or_OdpStatus"]) == "1")
                        {
                            mailtext = "Your OTP is: <span style='font-weight:bold'>" + words[1].Trim() + "</span>";
                        }
                        if (Convert.ToString(DtForOtpOdp.Rows[0]["Otp_Or_OdpStatus"]) == "2")
                        {
                            mailtext = "Your ODP is: <span style='font-weight:bold'>" + words[1].Trim() + "</span>";
                        }
                        SendMail.SendDemo(emailforhost, emailforsend, "", "", "OTP", mailtext, password, hostname);
                    });
                    emailThread.Start();
                }
                //This Block Of Code Is For Send SMS Yes
                if (Convert.ToString(DtForOtpOdp.Rows[0]["SendSms"]) == "1")
                {
                    sendsmsonmobile(words[0], message);
                }
                Panelotp.Style.Add("display", "none");
                Panellogin.Style.Add("display", "block");
            }
        }
    }

    public void FillSessionAfterCheck(string uid, string pas)
    {
        User user = new User();
        UserManager objUserManager = new UserManager();
        user = objUserManager.GetUserDetails(uid, pas);
        #region
        if (user != null)
        {
            //This Block Is Code For The Ho Login
            if (Convert.ToInt32(user.brid) == 0)
            {
                Session["User"] = user;
                Session["RoleID"] = user.RoleID.ToString();
                Session["ADID"] = user.UserID.ToString();
                Session["username"] = user.UserName;
				Session["UIdName"]=user.UserName;
                Session["Brid"] = user.brid.ToString();
                //Session["LLogin"] = user.LastLogOn.ToString();
                //string str = "update tblUser set LastLogOn = '" + IndianTime.GetIndianTime() + "' where userID='" + user.UserID + "'";
                //int res = objut.ExecuteSql(str);

                string redirectUrl = Request.QueryString["redirectUrl"];

                if (string.IsNullOrEmpty(redirectUrl))
                {
                    FormsAuthentication.SetAuthCookie(uid, true);
                    Response.Redirect("~/Common/Default.aspx", false);
                }
                else
                {
                    Response.Redirect(redirectUrl, false);
                }
            }
        #endregion
            #region
            //This Block Is Code For The Branch Login
            else if (Convert.ToInt32(user.brid) > 0)
            {

                Session["BrUser"] = user;
                Session["BrRoleID"] = user.RoleID.ToString();
                Session["BrADID"] = user.UserID.ToString();
                Session["Brusername"] = user.UserName;
				Session["UIdName"]=user.UserName;
                Session["BrBrid"] = user.brid.ToString();
                //Session["BrLLogin"] = user.LastLogOn.ToString();
                //string str = "update tblUser set LastLogOn = '" + IndianTime.GetIndianTime() + "' where userID='" + user.UserID + "'";
                //int res = objut.ExecuteSql(str);
                string redirectUrl = Request.QueryString["redirectUrl"];
                if (string.IsNullOrEmpty(redirectUrl))
                {
                    FormsAuthentication.SetAuthCookie(uid, true);
                    Response.Redirect("BranchPanel/Common/Default.aspx", false);
                }
                else
                {
                    Response.Redirect(redirectUrl, false);
                }
            }
            #endregion
        }
        else
        {
            Utility.ViewAlertMessage(this, "Contact To Admin For Login.Bcz Your Account Is Deactivated By Admin Sorry.");
        }
    }

    //For Get Ip Adress Of System Start Here
    public string GetIpAddress()
    {        
        string IpAddress = "";
        try
        {
            IpAddress = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (string.IsNullOrEmpty(IpAddress))
            {
                IpAddress = Request.ServerVariables["REMOTE_ADDR"];
                // IpAddress = "122.177.111.93";
            }            
            if (IpAddress.Contains(","))
            {
                int indexof = IpAddress.IndexOf(",");
                IpAddress = IpAddress.Substring(0, indexof);
            }
        }
        catch
        {
        }
        Utility.ViewAlertMessage(this, IpAddress);
        return IpAddress;
    }
    //public string GetIpAddress()
    //{
    //    string ipaddr = "";
    //    IPHostEntry Host = default(IPHostEntry);
    //    string Hostname = null;
    //    Hostname = System.Environment.MachineName;
    //    Host = Dns.GetHostEntry(Hostname);
    //    foreach (IPAddress IP in Host.AddressList)
    //    {
    //        if (IP.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork)
    //        {
    //            ipaddr = Convert.ToString(IP);
    //        }
    //    }
    //    Utility.ViewAlertMessage(this,ipaddr);
    //    return ipaddr;
    //}
    //For Get Mac Adress  Of System Start Here
    public List<string> GetMACAddress()
    {
        NetworkInterface[] nics = NetworkInterface.GetAllNetworkInterfaces();
        String sMacAddress = string.Empty;
        List<string> lst = new List<string>();
        foreach (NetworkInterface adapter in nics)
        {
            IPInterfaceProperties properties = adapter.GetIPProperties();
            sMacAddress = adapter.GetPhysicalAddress().ToString();
            lst.Add(sMacAddress);
            
        }
       // Utility.ViewAlertMessage(this, string.Join(",",lst));
        return lst;
    }
}