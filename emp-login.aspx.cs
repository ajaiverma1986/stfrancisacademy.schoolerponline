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
        Session.Remove("eid");
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
            Session["BrUser"] = null;

            //Query = @"Select RID,SturegNo,Brid,Registration_No,Password,Classid,Sectionid,'SAMID' = (Select ISNULL(SAMID,0) SAMID from tbl_StudentMaster SM 		
            //        inner join tbl_StudentAdmissionMaster SA on SM.StuRegNo = SA.StuRegNo where SM.Registration_No=@loginid) 
            //        From tbl_studentmaster where Registration_No=@loginid and password=@password and status=1";

            Query = @"Select SR.RID,SturegNo,SR.RegNewNo,SR.Brid,SR.Registration_No,Password,Classid,Sectionid,
                        'SAMID' = (Select ISNULL(SAMID,0) SAMID from tbl_StudentMaster SM
                        inner join tbl_StudentAdmissionMaster SA on SM.StuRegNo = SA.StuRegNo where SM.Registration_No=@loginid
                        ) 
                        From tbl_studentmaster SM
                        INNER JOIN tbl_StudentRegistration SR  on SR.RID = SM.RID and SR.Brid = SM.Brid and SR.Fyid = SM.Fyid
                        where SR.Registration_No=@loginid and password=@password and SM.status=1";

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
                    Session["RegNewNo"] = sdr["RegNewNo"];
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

    protected void LoginButton_Click1(object sender, EventArgs e)
    {
        LoginCheck(UserName.Text.Trim(), Password.Text.Trim());
    }
}