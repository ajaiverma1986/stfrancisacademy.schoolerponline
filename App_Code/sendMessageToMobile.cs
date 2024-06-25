using System;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;

public class sendMessageToMobile
{
    private static int ret = 0;

    public sendMessageToMobile()
    {
        //

        // TODO: Add constructor logic here
        //
    }
    public static int SMSsendForSend(string Mobile_No, string Message_Content, string Api)
    {
        int result = sendMessageToMobile.SMSSend(Mobile_No, Message_Content, Api);
        return result;
    }
    public static int SMSSend(string smsTo, string smsOriginalMessage, string api)
    {
        int i = 0;
        DataUtility objDut = new DataUtility();
        int C = 0;
        string strMsgToSend;
        string[] apichange;
        int cnt = smsOriginalMessage.Length;
        try
        {
            if (cnt > 140)
            {
                strMsgToSend = smsOriginalMessage.Substring(0, 140);
                cnt = cnt - 140;
            }
            else
            {
                strMsgToSend = smsOriginalMessage;
            }
            //if (api != "" && strMsgToSend.Length > 0)
            //{
            //    if (Regex.IsMatch(api, @"transmsg"))
            //    {
		
				//http://smsapple.in/api/swsend.asp?username=sxhsblp&password=school@2121&sender=XAVIER&sendto="1111111111+"&text="Dummy Text"
				
		   api = "https://admagister.net/api/mt/SendSMS?user=stfrancis&password=123456&senderid=FRNCIS&channel=Trans&DCS=0&flashsms=0&number=" + smsTo + "&text=" + smsOriginalMessage + "&route=11";
			
           
            //api = "http://sendsms.sabkuchhservices.com/api/mt/SendSMS?APIKey=SABKUCHH&senderid=PYTOPD&channel=2&DCS=0&flashsms=0&number=" + smsTo + "&text=" + smsOriginalMessage + "&route=1";
            HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(api);
            HttpWebResponse myResp = (HttpWebResponse)myReq.GetResponse();
            System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
            string responseString = respStreamReader.ReadToEnd();
            respStreamReader.Close();
            myResp.Close();
            i = 1;
            //}
            //else
            //{ 
            //    apichange = Regex.Split(api, "\"");
            //    api = apichange[0].ToString();
            //    api = api + smsTo + apichange[2].ToString() + smsOriginalMessage + apichange[4].ToString();
            //    //http://sendsms.jupitersms.in/api/mt/SendSMS?user=Ashish Kumar&password=123456&senderid=IASSWN&channel=trans&DCS=0&flashsms=0&number="~ + "&text=" ~ "&route=3
            //    HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(api);
            //    HttpWebResponse myResp = (HttpWebResponse)myReq.GetResponse();
            //    System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
            //    string responseString = respStreamReader.ReadToEnd();
            //    respStreamReader.Close();
            //    myResp.Close();
            //    i = 1;
            //}
            //}
            //else
            //{
            //    i = 0;
            //}
        }
        catch
        {
            i = 0;
        }

        C = i;
        return C;
    }
    //public static int SMSSend(string smsTo, string smsOriginalMessage, string api)
    //{
    //    int i = 0;
    //    DataUtility objDut = new DataUtility();
    //    int C = 0;
    //    string strMsgToSend;
    //    string[] apichange;
    //    int cnt = smsOriginalMessage.Length;
    //    try
    //    {
    //        if (cnt > 140)
    //        {
    //            strMsgToSend = smsOriginalMessage.Substring(0, 140);
    //            cnt = cnt - 140;
    //        }
    //        else
    //        {
    //            strMsgToSend = smsOriginalMessage;                
    //        }
    //        if (api != "" && strMsgToSend.Length > 0)
    //        {                
    //            if (Regex.IsMatch(api, @"transmsg"))
    //            {
    //                api = "http://sendsms.sabkuchhservices.com/api/mt/SendSMS?APIKey=SABKUCHH&senderid=PYTOPD&channel=2&DCS=0&flashsms=0&number="+ smsTo + "&text=" + smsOriginalMessage + "&route=1";
    //                HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(api);
    //                HttpWebResponse myResp = (HttpWebResponse)myReq.GetResponse();
    //                System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
    //                string responseString = respStreamReader.ReadToEnd();
    //                respStreamReader.Close();
    //                myResp.Close();
    //                i = 1;
    //            }
    //            else
    //            {  
    //                apichange = Regex.Split(api, "\"");
    //                api = apichange[0].ToString();
    //                api = api + smsTo + apichange[2].ToString() + smsOriginalMessage + apichange[4].ToString();
    //                //http://sendsms.jupitersms.in/api/mt/SendSMS?user=Ashish Kumar&password=123456&senderid=IASSWN&channel=trans&DCS=0&flashsms=0&number="~ + "&text=" ~ "&route=3
    //                HttpWebRequest myReq = (HttpWebRequest)WebRequest.Create(api);
    //                HttpWebResponse myResp = (HttpWebResponse)myReq.GetResponse();
    //                System.IO.StreamReader respStreamReader = new System.IO.StreamReader(myResp.GetResponseStream());
    //                string responseString = respStreamReader.ReadToEnd();
    //                respStreamReader.Close();
    //                myResp.Close();
    //                i = 1;
    //            }                
    //        }
    //        else 
    //        {
    //            i = 0;
    //        }
    //    }
    //    catch
    //    {
    //        i = 0;
    //    }                     
       
    //    C = i;
    //    return C; 
    //}
    public static int SMSSend(string mobileNo, string sender, string message, int ApiType = 0, int IsFranchisee = 0)
    {
        if (message == "Api Check")
        {
            if (mobileNo != "")
            {
                try
                {
                    string Baseurl = mobileNo;
                    HttpWebRequest ht = WebRequest.Create(Baseurl) as HttpWebRequest;
                    WebResponse wb = ht.GetResponse();
                    ret = 1;
                }
                catch (Exception ex)
                {
                    ret = 0;
                }
            }
            return ret;
        }
        else
        {
            DataUtility objdut = new DataUtility();
            string api = "";
            if (Convert.ToInt32(IsFranchisee) == 0)
            {
                if (ApiType == 0)
                    api = Convert.ToString(objdut.GetScalar("select sms_api from tbl_smsapisetting where api_type=1 and status=1 and Brid=0 "));
                else
                    api = Convert.ToString(objdut.GetScalar("select sms_api from tbl_smsapisetting where api_type=2 and status=1 and Brid=0 "));
            }
            else
            {
                if (ApiType == 0)
                    api = Convert.ToString(objdut.GetScalar("select sms_api from tbl_smsapisetting where api_type=1 and status=1 and Brid=" + HttpContext.Current.Session["BrBrid"] + " "));
                else
                    api = Convert.ToString(objdut.GetScalar("select sms_api from tbl_smsapisetting where api_type=2 and status=1 and Brid=" + HttpContext.Current.Session["BrBrid"] + " "));
            }
            if (api != "")
            {
                string[] apimessage = api.Split('~');
                ret = 0;
                try
                {
                    if (apimessage.Length > 0)
                    {
                        string baseurl = apimessage[0] + mobileNo + apimessage[1] + message + apimessage[2];
                        HttpWebRequest ht = WebRequest.Create(baseurl) as HttpWebRequest;
                        WebResponse wb = ht.GetResponse();
                        ret = 1;
                    }
                }
                catch (Exception ex)
                {
                    ret = 0;
                }
            }
            else
            {
                ret = 1;
            }
            return ret;
        }
    }
}