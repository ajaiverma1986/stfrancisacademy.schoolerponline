//***************************************************
//  Creator Name    : Devendra Kumar Singh
//  Creation Date   : 22/11/2011
//  Reason          : To create all BL generic methods.
//  Updated By      :
//  Update Date     :
//***************************************************

using System;
using System.IO;
using System.Net.Mail;
using System.Web.UI;

namespace CommonUtility
{
    /// <summary>
    /// Summary description for CommonUtility
    /// </summary>
    public class CommonUtility
    {
        private static string subject;

        public CommonUtility()
        {
            //
            // TODO: Add constructor logic here
            //
        }        

        public static void showAlertMessage(Page page, string msg)
        {
            ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "Key", "<script language='javascript'>alert('" + msg + "');</script>", false);
        }

        public static int SendMail(string name, string email, string hostname, string emailforhost, string password, int module, string pagename, string username = "", string pass = "")
        {
            try
            {
                int send = 0;
                string emailid = email, myString = "";
                subject = "Email Confirmation";
                email = emailid;

                if (send == 0)
                {
                    // MailMessage mm = new MailMessage("noreply@qlook.bz", email);
                    MailMessage mm = new MailMessage(emailforhost, email);
                    mm.IsBodyHtml = true;

                    if (pagename == "offer")
                    {
                        StreamReader reader = new StreamReader(System.Web.HttpContext.Current.Server.MapPath("sendmail.html"));
                        string readFile = reader.ReadToEnd();
                        myString = readFile;
                        myString = myString.Replace("$$name$$", name);
                        mm.Subject = "Offer Letter Confirmation Mail";
                    }
                    if (pagename == "appoint")
                    {
                        StreamReader reader = new StreamReader(System.Web.HttpContext.Current.Server.MapPath("appointment.html"));
                        string readFile = reader.ReadToEnd();
                        myString = readFile;
                        myString = myString.Replace("$$name$$", name);
                        myString = myString.Replace("$$username$$", username);
                        myString = myString.Replace("$$pass$$", pass);
                        mm.Subject = "Appointment Confirmation Mail";
                    }

                    mm.Body = myString;
                    System.Net.NetworkCredential webmail = new System.Net.NetworkCredential(emailforhost, password);
                    System.Net.Mail.SmtpClient ms = new SmtpClient(hostname);
                    ms.UseDefaultCredentials = true;
                    ms.Credentials = webmail;
                    if (send == 0)
                    {
                        ms.Send(mm);
                        send = 1;
                    }
                    return send;
                }
                else
                {
                    return 0;
                }
            }
            catch (Exception exx)
            {
                return 3;
            }
        }
    }
}