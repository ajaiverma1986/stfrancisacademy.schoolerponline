using System;
using System.Data;
using System.Data.SqlClient;
using System.Net;

public partial class ForgotPassword : System.Web.UI.Page
{
    private Utility objut = new Utility();
    private CommonClass objCom = new CommonClass();
    private DataUtility objdut = new DataUtility();
    //SendMail sm = new SendMail();
    string name = "";
    string msg = "";
    string EID = "";
    string query="";
    string TempBrName = "";

    private DataTable dt1;

    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void SearchButton_Click(object sender, EventArgs e)
    {
        try
        {
            EID = Session["EID"].ToString();
            name = Session["name"].ToString();
            if (EID != "")
            {
                if (txtpwd.Text.Trim() == cpwd.Text.Trim())
                {
                    query = @"update tblUser set Password = '" + txtpwd.Text + "' where EID =" + EID + "";
                    int result1 = objdut.ExecuteSql(query);
                    if (result1 == 1)
                    {
                        TempBrName = (string)(objdut.GetScalar("Select isnull(UserName,'') UserName FROM tblUser where EID =" + EID + ""));
                        if (TempBrName != "")
                        {
                            string strq = "UPDATE Branch_master SET Password='" + txtpwd.Text + "' where BrCode='" + TempBrName + "'";
                            int result2 = objdut.ExecuteSql(strq);
                        }
                        msg = "Dear " + name + ", Your Login Password is " + txtpwd.Text + "";
                        //string api = "http://login.jupitersms.in/api/send_http.php?username=PAYTOPAID&password=9934226350&mobiles=" + Mobile.Text + "&message=" + msg + "&sender=PYTOPD&route=B";
                        //HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(api);
                        //HttpWebResponse myResp = (HttpWebResponse)myReq.GetResponse();
                        //System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
                        //string responseString = respStreamReader.ReadToEnd();
                        //respStreamReader.Close();
                        //myResp.Close();
                        ////DataTable dt = objCom.JsonStringToDataTable(responseString);
                        //string respo = responseString.ToString();
                        int result = sendMessageToMobile.SMSSend(Mobile.Text, msg, "transmsg");
                        if (result>0)
                        {
                            lblMsg.Text = "Password Details Sent to your Mobile No. Please go Login Page";
                            alogin.Visible = true;
                        }
                        else
                        {
                            lblMsg.Text = "Password Details not Sent to your Mobile No.";
                        }
                    }
                    else
                    {
                        lblMsg.Text = "Error during change password. Try again";
                    }
                }
                else
                {
                    lblMsg.Text = "Password Does not Match. Try again";
                }
            }
            else
            {
                lblMsg.Text = "Error during change password.";
            }
        }
        catch (SqlException ex)
        {
            lblMsg.Text = "Something went Wrong.... ";
        }
        finally
        {
            lblMsg.Text = "";
        }
    }
    protected void SearchButton_Click1(object sender, EventArgs e)
    {      
        try
        {
            string query = @"select e.EID,e.Name,e.mobileno,e.mailid, u.Password from tblEmployee e , tblUser u where e.EID=u.EID and u.UserName='" + UserName.Text + "' and e.mobileno='" + Mobile.Text + "'";
            dt1 = objdut.GetDataTable(query);
            if (dt1.Rows.Count > 0)
            {
                SearchButton.Visible = false;
                Button1.Visible = true;
                pwd.Visible = true;
                Session["EID"] = dt1.Rows[0]["EID"].ToString();
                Session["name"] = dt1.Rows[0]["Name"].ToString();
                
                //string emailfrom = "info@awapalsolutions.com";

                //SendMail.Send(emailfrom, lblEmail.Text, lblEmail.Text, lblEmail.Text, "Your Password Details", "Hi, <br/>Please check your Login Detailss<br/><br/>Your Password: " + lblPassword.Text + "<br/><br/>");

                ////string Email="Awapal Solutions";

                //MailMessage Msg = new MailMessage();
                //Msg.From = new MailAddress(lblEmail.Text);
                //Msg.To.Add(lblEmail.Text);
                //Msg.Subject = "Your Password Details";
                //Msg.Body = "Hi, <br/>Please check your Login Detailss<br/><br/>Your Password: " + dt1.Rows[0]["Password"] + "<br/><br/>";
                //Msg.IsBodyHtml = true;
                //SmtpClient smtp = new SmtpClient();
                //smtp.Host = "smtp.gmail.com";
                //smtp.Port = 587;
                //smtp.Credentials = new System.Net.NetworkCredential("yourusername@gmail.com", "yourpassword");
                //smtp.EnableSsl = true;
                //smtp.Send(Msg);
                
            }
            else
            {
                SearchButton.Visible = true;
                Button1.Visible = false;
                pwd.Visible = false;
                lblMsg.Text = "Record Not Found..Ask Admin to create your account.. ";
            }
        }
        catch (SqlException ex)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Something went Wrong.... ");
        }
    }

    protected void dfds_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }

    protected void UserName_TextChanged(object sender, EventArgs e)
    {
    }
}