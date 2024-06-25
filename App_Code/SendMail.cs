using System.Net.Mail;

/// <summary>
/// To Send Mail
/// </summary>
public class SendMail
{
    public SendMail()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    /// <summary>
    /// if you want to mail in to more than one recipent in TO account use ',' as a seperator
    ///  if you want to mail in to more than one recipent in CC account use ',' as a seperator
    ///  if you want to mail in to more than one recipent in BCC account use ',' as a seperator
    /// </summary>
    /// <param name="from"></param>
    /// <param name="to"></param>
    /// <param name="cc"></param>
    /// <param name="bcc"></param>
    /// <param name="subject"></param>
    /// <param name="body"></param>
    /// <returns></returns>
    public static string Send(string from, string to, string cc, string bcc, string subject, string body)
    {
        string username = "info@jaisiyaram.com";
        string pass = "anima1971";
        string host = "mail.jaisiyaram.org";
        string strret = "";
        //System.Net.Mail.MailMessage MyMailMessage = new System.Net.Mail.MailMessage(from, to);
        System.Net.Mail.MailMessage MyMailMessage = new System.Net.Mail.MailMessage();
        MyMailMessage.Subject = subject;
        MyMailMessage.Body = body;
        MyMailMessage.From = new MailAddress(from);

        if (to != "")
        {
            string[] toMailid = to.Split(new char[] { ',' });
            for (int i = 0; i < toMailid.Length; i++)
            {
                MyMailMessage.To.Add(toMailid[i]);
            }
        }
        if (cc != "")
        {
            string[] ccMailid = cc.Split(new char[] { ',' });
            for (int i = 0; i < ccMailid.Length; i++)
            {
                MyMailMessage.CC.Add(ccMailid[i]);
            }
        }
        if (bcc != "")
        {
            string[] bccMailid = bcc.Split(new char[] { ',' });
            for (int i = 0; i < bccMailid.Length; i++)
            {
                MyMailMessage.Bcc.Add(bccMailid[i]);
            }
        }
        System.Net.Mail.MailAddress ad = new System.Net.Mail.MailAddress(from);
        MyMailMessage.ReplyTo = ad;
        MyMailMessage.IsBodyHtml = true;
        System.Net.NetworkCredential mailAuthentication = new System.Net.NetworkCredential(username, pass);
        System.Net.Mail.SmtpClient mailClient = new System.Net.Mail.SmtpClient(host);
        mailClient.UseDefaultCredentials = false;
        mailClient.Credentials = mailAuthentication;
        //------------------
        //System.Net.Mail.Attachment at = new System.Net.Mail.Attachment("http://jaisiyaram.com/aspx/photo/monnaelisa@hotmail.com/10.02.2008%20(14).JPG");
        //MyMailMessage.Attachments.Add(at);
        try
        {
            mailClient.Send(MyMailMessage);
            return strret;
            // SmtpMail.Send(Email);
        }
        catch (System.Exception ex)
        {
            strret = ex.Message.ToString();
            return strret;
            // Response.Write(ex.Message);
            // Response.Write(ex.Source);
        }
        // MailMessage Email = new MailMessage(from,to);//("dev@yahoo.com","chhavi@alpssoftware.in");
        // //Email.To = to;
        // //Email.Bcc = bcc;
        // //Email.Cc = cc;
        // //Email.Bcc = "avnish@alpssoftware.in";
        // Email.IsBodyHtml=true;
        // Email.Body =body;
        // Email.Subject =subject;
        //// Email.From = from;
        //// Email.Priority = MailPriority.High;
        // try
        // {
        //     SmtpClient sm = new SmtpClient("localhost");
        //       sm.Send(Email);
        //       return "";
        // }
        // catch (System.Exception ex)
        // {
        //     return ex.Message;
        //     // Response.Write(ex.Message);
        //     //  Response.Write(ex.Source);
        // }
    }
    public static string SendDemo(string from = "", string to = "", string cc = "", string bcc = "", string subject = "", string body = "", string pass = "", string host = "")
    {
        string strret = "";
        try
        {
            string username = from.ToString();

            System.Net.Mail.MailMessage MyMailMessage = new System.Net.Mail.MailMessage();
            MyMailMessage.Subject = subject;
            MyMailMessage.Body = body;
            MyMailMessage.From = new MailAddress(from);

            if (to != "")
            {
                string[] toMailid = to.Split(new char[] { ',' });
                for (int i = 0; i < toMailid.Length; i++)
                {
                    MyMailMessage.To.Add(toMailid[i]);
                }
            }
            if (cc != "")
            {
                string[] ccMailid = cc.Split(new char[] { ',' });
                for (int i = 0; i < ccMailid.Length; i++)
                {
                    MyMailMessage.CC.Add(ccMailid[i]);
                }
            }
            if (bcc != "")
            {
                string[] bccMailid = bcc.Split(new char[] { ',' });
                for (int i = 0; i < bccMailid.Length; i++)
                {
                    MyMailMessage.Bcc.Add(bccMailid[i]);
                }
            }

            System.Net.Mail.MailAddress ad = new System.Net.Mail.MailAddress(from);
            MyMailMessage.IsBodyHtml = true;
            System.Net.NetworkCredential mailAuthentication = new System.Net.NetworkCredential(username, pass);
            System.Net.Mail.SmtpClient mailClient = new System.Net.Mail.SmtpClient(host);
            mailClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            mailClient.UseDefaultCredentials = false;
            mailClient.Credentials = mailAuthentication;
            mailClient.EnableSsl = false;
            try
            {
                mailClient.Send(MyMailMessage);
                return strret;
            }
            catch (System.Exception ex)
            {
                strret = ex.Message.ToString();

                return strret;
            }
        }
        catch (System.Exception ex)
        {
            strret = ex.Message.ToString();
            return strret;
        }
    }
}