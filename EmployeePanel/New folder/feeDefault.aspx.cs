using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Collections.Specialized;

public partial class EmployeePanel_feeDefault : System.Web.UI.Page
{
    int SchoolID = 0;
    string StdRegNo;
    string StdAdmNo;
    DataUtility Objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        string mmp_txn = "", mer_txn = "", amt = "", prod = "", date = "", bank_txn = "", f_code = "", clientcode = "", bank_name = "",
        auth_code = "", ipg_txn_id = "", merchant_id = "", desc = "", discriminator = "", surcharge = "", CardNumber = "";
        txtpaydate.Text = DateTime.Now.ToString("dd MMM yyyy");
        if (!IsPostBack)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "df", "<script type='text/javascript'>FileDate();</script>", false);
            Session["nvc"] = null;
            NameValueCollection nvc = Request.Form;
            if (Request.Params["mmp_txn"] != null)
            {
                if (Convert.ToString(Request.Params["mmp_txn"]) != "0")
                {
                    Service objService = new Service();
                    Session["nvc"] = nvc;

                    //DataTable dt = objService.getTransPayDetails(nvc);
                    if (nvc["mmp_txn"] != null)
                    { mmp_txn = nvc["mmp_txn"].ToString(); }
                    if (nvc["mer_txn"] != null)
                    { mer_txn = nvc["mer_txn"].ToString(); }
                    if (nvc["amt"] != null)
                    { amt = nvc["amt"].ToString(); }
                    if (nvc["prod"] != null)
                    { prod = nvc["prod"].ToString(); }
                    if (nvc["date"] != null)
                    { date = nvc["date"].ToString(); }
                    if (nvc["bank_txn"] != null)
                    { bank_txn = nvc["bank_txn"].ToString(); }
                    if (nvc["f_code"] != null)
                    { f_code = nvc["f_code"].ToString(); }
                    if (nvc["clientcode"] != null)
                    { clientcode = nvc["clientcode"].ToString(); }
                    if (nvc["bank_name"] != null)
                    { bank_name = nvc["bank_name"].ToString(); }
                    if (nvc["auth_code"] != null)
                    { auth_code = nvc["auth_code"].ToString(); }
                    if (nvc["ipg_txn_id"] != null)
                    { ipg_txn_id = nvc["ipg_txn_id"].ToString(); }
                    if (nvc["merchant_id"] != null)
                    { merchant_id = nvc["merchant_id"].ToString(); }
                    if (nvc["desc"] != null)
                    { desc = nvc["desc"].ToString(); }
                    if (nvc["discriminator"] != null)
                    { discriminator = nvc["discriminator"].ToString(); }
                    if (nvc["surcharge"] != null)
                    { surcharge = nvc["surcharge"].ToString(); }
                    if (nvc["CardNumber"] != null)
                    { CardNumber = nvc["CardNumber"].ToString(); }

                    int paymneCount = 0;
                    int transCount = 0;
                    DateTime.Today.ToString("dd/MM/yyyy");

                    if (Session["eid"] != null)
                    {
                        StdRegNo = Session["eid"].ToString();
                        string StdAdmNo = Objdut.GetScalar(" select ISNULL(AdmissionNo,'') AdmissionNo from tbl_StudentAdmissionMaster where StuRegNo =" + Session["eid"].ToString() + "").ToString();
                        int SchoolID = Convert.ToInt32(Objdut.GetScalar(" select ISNULL(SchoolID,0) SchoolID from tblProductName where Brid =" + Session["brbrid"].ToString() + ""));
                        string[] FeeDetail = (string[])(Session["FeeDetail"]);
                        string PAYMENTDATE = "";
                        string sturReg = HttpContext.Current.Session["eid"].ToString();

                        if (FeeDetail.Length > 0)
                        {
                            PAYMENTDATE = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
                            string RemaingAmountDueDate = "";
                            if (FeeDetail[5] != "")
                            {
                                //RemaingAmountDueDate = FeeDetail[5].ToString();
                                RemaingAmountDueDate = Convert.ToDateTime(FeeDetail[5].ToString()).ToString("yyyy-MM-dd");
                                //RemaingAmountDueDate = RemaingAmountDueDate1[2] + "-" + RemaingAmountDueDate1[1] + "-" + RemaingAmountDueDate1[0];
                            }

                            string ASAID = nvc["udf5"].ToString();
                            string RECIPTNO = nvc["udf1"].ToString();
                            string STUREGNO = nvc["udf9"].ToString();

                            if (f_code == "Ok")
                            {
                                paymneCount = Convert.ToInt32(objService.DepositFee1(FeeDetail[7], FeeDetail[0].ToString(), "6", bank_name, "", "", "", FeeDetail[1].ToString(), PAYMENTDATE, FeeDetail[3].ToString(), FeeDetail[4].ToString(), RemaingAmountDueDate, FeeDetail[6].ToString()));
                                transCount = Convert.ToInt32(objService.transPayment(FeeDetail[0].ToString(), sturReg, mmp_txn.ToString(), mer_txn.ToString(), amt, prod.ToString(), PAYMENTDATE, bank_txn.ToString(), f_code.ToString(), clientcode.ToString(), bank_name.ToString(), auth_code.ToString(), merchant_id.ToString(), desc.ToString(), discriminator.ToString(), surcharge, CardNumber.ToString()));

                                string url1 = "https://stfrancisacademy.schoolerponline.in/BranchPanel/Fee%20Management/DoublePay.aspx?sid=B-" + ASAID.ToString() + "";
                                string script = string.Format("window.open('{0}');", url1);
                                Page.ClientScript.RegisterStartupScript(this.GetType(), "newPage" + UniqueID, script, true);

                                string InstallmentDate = Objdut.GetScalar("select ISNULL(InstallmentDate,'') InstallmentDate from tbl_StudentAdmissionInstallment where ASAID =" + ASAID + "").ToString();
                                string msg1 = "", msg2 = "", msg3 = "";

                                msg1 = "'Hi ";
                                msg2 = " Your Amount of Rs." + amt + " of Due Date : " + InstallmentDate + " Received Successfully on " + DateTime.Now.ToString("dd/mm/yyyy hh:mm:ss") + "";
                                if (paymneCount == 0 || transCount == 0)
                                {
                                    msg2 += " but Error During insertion in School Database,Thanks !!!";
                                }
                                else
                                {
                                    msg3 += " with Reciept No : " + RECIPTNO + " and TxnID " + bank_txn + ". Thanks !!!";
                                }
                                CommonClass.getStudentMobileNo(Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), Convert.ToDecimal(STUREGNO), Convert.ToInt32(CommonClass.Scaler("ActiveAcademicYear")), msg1, msg2, msg3);
                                ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alert", "alert('" + msg2 + "')", true);
                            }
                            else
                            {
                                transCount = Convert.ToInt32(objService.transPayment(FeeDetail[0].ToString(), sturReg, mmp_txn.ToString(), mer_txn.ToString(), amt, prod.ToString(), date, bank_txn.ToString(), f_code.ToString(), clientcode.ToString(), bank_name.ToString(), auth_code.ToString(), merchant_id.ToString(), desc.ToString(), discriminator.ToString(), surcharge, CardNumber.ToString()));
                                string message = "alert('Error in Online Payment,Please Try again !!')";
                                ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alert", message, true);
                            }
                        }
                        else
                        {
                            string message = "alert('Error in Online Payment,Please Try again !!')";
                            ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alert", message, true);
                        }
                    }
                }
            }
        }
    }

    protected void SendPostRequestNew(string ASAID, string RECEIPTNO, string ALLASAID)
    {
        CommonClass ObjCommon = new CommonClass();
        string now = DateTime.Now.ToString("dd/MM/yyyy").Replace("-", "/");
        Service objService = new Service();
        DataTable dsCameraDetails = new DataTable();
        DataTable dtProductDetails = new DataTable();
        dsCameraDetails = ObjCommon.JsonStringToDataTable(objService.GetStudentDetails(Session["brbrid"].ToString(), Session["RID"].ToString()));

        string Name = "";
        string EmailID = "";
        string MobileNo = "";
        string ClassID = "";

        if (dsCameraDetails.Rows.Count > 0)
        {
            DataRow dr1 = dsCameraDetails.Rows[0];
            Name = dr1["name"].ToString();
            EmailID = dr1["studentEmailID"].ToString();
            MobileNo = dr1["mobile"].ToString();
            ClassID = dr1["ClassID"].ToString();
        }
        string respHashKey = "";
        string login = "";
        string Url = "";
        string pass = "";
        string ttype = "NBFundTransfer";
        string prodid = "";
        string amt = txtAmount.Text;
        string txncurr = "INR";
        string txnscamt = "0";
        string clientcode = "007";
        string txnid = Convert.ToString(Convert.ToInt32(Objdut.GetScalar("select COunt(*) from tblFeeTransDetail")) + 1);
        string date = now;
        string custacc = "";
        string ReturnURL = "https://stfrancisacademy.schoolerponline.in/EmployeePanel/feeDefault.aspx";
        string LastURL = "&ru=" + ReturnURL + "";
        //&mprod=<products><product><id>1</id><name>One</name><amount>" + Convert.ToDecimal(ProductID1amt) + "</amount></product><product><id>2</id><name>Two</name><amount>" + Convert.ToDecimal(ProductID2amt) + "</amount></product></products>";

        string strProd = @"Select DISTINCT SchoolID,Brid,tbl_Pay.ClassID,SchoolName,AccountNo,tbl_Pay.IsActive,tbl_Prod.UserID,Password,ProductID,HashRequestKey 
                            from tblProductName tbl_Prod
                            INNER JOIN tbl_PaymentApiToClass tbl_Pay on tbl_prod.SchoolID = tbl_Pay.ApiID" +
                            " WHERE tbl_Pay.IsActive =1 and tbl_Pay.ClassID=" + ClassID;
        dtProductDetails = Objdut.GetDataTable(strProd);
        //dtProductDetails = Objdut.GetDataTable("select isnull(UserID,'') UserID,isnull(Password,'') Password,isnull(ProductID,'') ProductID from tblProductName where Brid = " + Session["brbrid"] + " and ClassID=" + ClassID);
        if (dtProductDetails.Rows.Count > 0)
        {
            DataRow dr = dtProductDetails.Rows[0];
            login = dr["UserID"].ToString();
            pass = dr["Password"].ToString();
            prodid = dr["ProductID"].ToString();
            Url = "payment";
            custacc = "1234567890";
            respHashKey = dr["HashRequestKey"].ToString();
        }
        //else
        //{
        //    login = "160";
        //    pass = "Test@123";
        //    prodid = "NSE";
        //    Url = "paynetzuat";
        //    custacc = "123456789";
        //}
        if (login != "" && pass != "" && prodid != "" && Url != "")
        {  
            string strURL, strClientCode, strClientCodeEncoded;
            byte[] b;
            string strResponse = "";
            try
            {
                b = Encoding.UTF8.GetBytes(clientcode);
                strClientCode = Convert.ToBase64String(b);
                strClientCodeEncoded = HttpUtility.UrlEncode(strClientCode);
                strURL = "https://payment.atomtech.in/paynetz/epi/fts?";
                strURL = strURL + "login=" + login + "&pass=" + pass + "&ttype=" + ttype + "&prodid=" + prodid + "&amt=" + Convert.ToDecimal(txtAmount.Text.Trim()) + "&txncurr=" + txncurr + "";
                strURL = strURL + "&txnscamt=" + txnscamt + "&clientcode=" + clientcode + "&txnid=" + txnid + "&date=" + date + "&custacc=" + custacc + "";
                strURL = strURL + "&udf1=" + RECEIPTNO + "&udf2=No&udf3=" + MobileNo + "&udf4=1&udf5=" + ASAID + "&udf9=" + Session["eid"].ToString() + LastURL;

                string signature = "";
                string strsignature = login + pass + ttype + prodid + txnid + txtAmount.Text.Trim() + txncurr;
                byte[] bytes = Encoding.UTF8.GetBytes(respHashKey);
                byte[] bt = new System.Security.Cryptography.HMACSHA512(bytes).ComputeHash(Encoding.UTF8.GetBytes(strsignature));
                signature = byteToHexString(bt).ToLower();
                strURL = strURL.Replace("[signature]", signature);
                signature = "&signature=" + signature;

                //string reqHashKey = "a47b59ad31722ed17b";
                //string signature = "";
                //string strsignature = login + pass + ttype + prodid + txnid + txtAmount.Text.Trim() + txncurr;
                //byte[] bytes = Encoding.UTF8.GetBytes(reqHashKey);
                //byte[] bt = new System.Security.Cryptography.HMACSHA512(bytes).ComputeHash(Encoding.UTF8.GetBytes(strsignature));
                //signature = byteToHexString(bt).ToLower();
                //strURL = strURL.Replace("[signature]", signature);

                ////string signature = "";
                //string strsignature = login + pass + ttype + prodid + txnid + txtAmount.Text.Trim() + txncurr;
                //byte[] bytes = Encoding.UTF8.GetBytes(reqHashKey);
                //byte[] bt = new System.Security.Cryptography.HMACSHA512(bytes).ComputeHash(Encoding.UTF8.GetBytes(strsignature));
                //// byte[] b = new HMACSHA512(bytes).ComputeHash(Encoding.UTF8.GetBytes(prodid));
               // signature = "&signature=" + byteToHexString(bt).ToLower();
                //ExceptionLogger.LogExceptionDetails(null, "[Log]" + signature);
                //signature = "&signature=d103f6a0a7a09c5c648bd90260b4b34e48d163d466fc9035e4758b0bea5dd9e56381e961f2c21a7e659f99d9b36d6d691389a555decbed5ba87795d59a139e4d";
                strURL = strURL + signature;
                string filePath = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
                string extension = ".txt";
                filePath += @"\Error_Log" + extension;
                File.WriteAllText(filePath,strURL);
                ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12; // comparable to modern browsers

                HttpContext.Current.Response.Redirect(strURL, false);

            }
            catch (Exception ex)
            {
                //ExceptionLogger.LogExceptionDetails(ex, null);
                throw ex;
            }
        }
    }
    public static string byteToHexString(byte[] byData)
    {
        StringBuilder sb = new StringBuilder((byData.Length * 2));
        for (int i = 0; (i < byData.Length); i++)
        {
            int v = (byData[i] & 255);
            if ((v < 16))
            {
                sb.Append('0');
            }

            sb.Append(v.ToString("X"));

        }

        return sb.ToString();
    }
    private static string EncodeTo64UTF8(String str)
    {
        byte[] toEncode2Bytes = System.Text.Encoding.UTF8.GetBytes(str);
        string sReturnValue = System.Convert.ToBase64String(toEncode2Bytes);
        return sReturnValue;
    }

    private bool Validate()
    {
        //if (txtAmount.Text == "0.00")
        //{
        //    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Please Enter Amount');", true);
        //    txtAmount.Focus();
        //    return false;
        //}
        //if (txtAmount.Text == "")
        //{
        //    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Please Enter Amount');", true);
        //    txtAmount.Focus();
        //    return false;
        //}
        //if (txtAmount.Text == "0")
        //{
        //    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Please Enter Amount');", true);
        //    txtAmount.Focus();
        //    return false;
        //}

        if (txtpaydate.Text == "")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Please Enter Payment Date');", true);
            txtpaydate.Focus();
            return false;
        }
        //int SchoolID = Convert.ToInt32(Objdut.GetScalar(" select ISNULL(SchoolID,0) SchoolID from tblProductName where Brid =" + Session["brbrid"].ToString() + ""));
        //if (SchoolID == 0)
        //{
        //    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Please configure School A/c No.');", true);
        //    txtpaydate.Focus();
        //    return false;
        //}


        return true;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Validate())
        {
            StdAdmNo = "";

           // ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "df", "<script type='text/javascript'>FillFieldForPay();</script>", false);
            if (txtDate.Text != "")
            {
                string DateOfDueAmount = Convert.ToDateTime(txtDate.Text.ToString()).ToString("yyyy-MM-dd");
            }
            Session["FeeDetail"] = null;
            string[] FeeDetail = new string[8];
            FeeDetail[0] = hfforasaid.Value.ToString();
            FeeDetail[1] = txtfeerecipt.Text.ToString();
            FeeDetail[2] = txtpaydate.Text.ToString();
            FeeDetail[3] = txtareacomment.Text.ToString();
            FeeDetail[4] = txtAmount.Text.ToString();
            FeeDetail[5] = txtDate.Text.ToString();
            FeeDetail[6] = SelectedASID.Value.ToString();
            FeeDetail[7] = txtfine.Text.ToString();
            Session["FeeDetail"] = FeeDetail;

            SendPostRequestNew(hfforasaid.Value.ToString(), txtfeerecipt.Text.ToString(), SelectedASID.Value.ToString());
        }
    }
}