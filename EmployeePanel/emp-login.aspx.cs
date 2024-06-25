using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
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
        Session.Remove("eid");
        if (!Page.IsPostBack)
        {
            divLogin.Visible = true;
            divOtp.Visible = false;
            btnOtp.Visible = false;
            LoginButton.Visible = true;
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
            Session["BrUser"] = null;

            Query = @"Select RID,SturegNo,Brid,Registration_No,Password,Classid,Sectionid,'SAMID' = (Select ISNULL(SAMID,0) SAMID from tbl_StudentMaster SM 		
                    inner join tbl_StudentAdmissionMaster SA on SM.StuRegNo = SA.StuRegNo where SM.Registration_No=@loginid) From tbl_studentmaster where Registration_No=@loginid and password=@password and status=1";

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
                    User user = null;
                    user = new User();
                    user.UserID = Convert.ToInt32(sdr["SturegNo"].ToString());
                    user.UserName = uid.ToString();                   
                    user.brid = Convert.ToInt32(sdr["Brid"].ToString());

                    Session["BrUser"] = user;
                    Session["SAMID"] = sdr["SAMID"];
                    Session["RID"] = sdr["RID"];
                    Session["SturegNo"] = sdr["SturegNo"];
                    Session["eid"] = sdr["SturegNo"];
                    Session["loginid"] = sdr["Registration_No"];
                    Session["brbrid"] = sdr["Brid"];
                    Session["Password"] = sdr["Password"];
                    Session["Classid"] = sdr["Classid"];
                    Session["Sectionid"] = sdr["Sectionid"];
                    //string str = "update tbl_studentmaster set lastlogin = '" + DateTime.Now.ToString("yyyy-MM-dd") + "', IPAddress='" + Convert.ToString(HttpContext.Current.Request.UserHostAddress) + "' where Registration_No='" + UserName.Text.Trim() + "'";
                    //objDUT.ExecuteSql(str);
                    //x = 0;
                    //int res = objDUT.ExecuteSql(str);
                    if (Request.Params["ReturnUrl"] != null)
                    {
                        FormsAuthentication.RedirectFromLoginPage(UserName.Text, false);
                    }
                    else
                    {
                        FormsAuthentication.SetAuthCookie(UserName.Text, false);
                        Response.Redirect("EmployeePanel/employee-panel-home-page.aspx", false);
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

    public static int otpResult = 0;    
    protected void LoginButton_Click1(object sender, EventArgs e)
    {
        // LoginCheck(UserName.Text.Trim(), Password.Text.Trim());
        DataUtility Objdut = new DataUtility();
        string phoneNumber = Convert.ToString(Objdut.GetScalar("select PrimaryMobileNo from tbl_studentregistration where Registration_No = '" + UserName.Text.Trim()+"'"));
        string Otp = RandomString();
        Session["OTP"] = Otp;
        Session["Password"] = Password.Text.Trim();
        otpResult = OtpSend(phoneNumber, "Your confidential Login OTP is " + Otp + ".");
        if (otpResult > 0)
        {
            divLogin.Visible = false;
            divOtp.Visible = true;
                       
            btnOtp.Visible = true;
            LoginButton.Visible = false;            
        }
        else
        {
            divOtp.Visible = false;
            divLogin.Visible = true;
            btnOtp.Visible = false;
            LoginButton.Visible = true;
        }
    }

    protected void btnOtp_Click(object sender, EventArgs e)
    {
        if (otpResult > 0)
        {
            if (Convert.ToString(Session["OTP"]) == txtOtp.Text.Trim())
            {
                LoginCheck(UserName.Text.Trim(), Convert.ToString(Session["Password"]));
            }
            else
            {
                divOtp.Visible = false;
                divLogin.Visible = true;
                btnOtp.Visible = false;
                LoginButton.Visible = true;
            }
        }
    }

    private static Random random = new Random();
    public static string RandomString()
    {
        const string chars = "0123456789";
        return new string(Enumerable.Repeat(chars, 6)
          .Select(s => s[random.Next(s.Length)]).ToArray());
    }

    public static int OtpSend(string smsTo, string smsOriginalMessage)
    {
        DataUtility objDut = new DataUtility();
        int result = 0;
        try
        {            
           string api = "https://admagister.net/api/mt/SendSMS?user=avrpublic&password=123456&senderid=AVRPSG&channel=Trans&DCS=0&flashsms=0&number=" + smsTo + "&text=" + smsOriginalMessage + "&route=11";
           
            HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(api);
            HttpWebResponse myResp = (HttpWebResponse)myReq.GetResponse();
            System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
            string responseString = respStreamReader.ReadToEnd();
            respStreamReader.Close();
            myResp.Close();
            result = 1;
        }
        catch
        {
            result = 0;
        }       
        return result;
    }
}