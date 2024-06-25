using System;
using System.Collections.Generic;
using System.Collections.Specialized;
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

public partial class EmployeePanel_PayTransportFee : System.Web.UI.Page
{
    int SchoolID = 0;
    string StdRegNo;
    string Fyid="0";
    string Brid="0";
    string StdAdmNo;
    string ASAID;
    DataUtility Objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        string mmp_txn = "", mer_txn = "", amt = "", prod = "", date = "", bank_txn = "", f_code = "", clientcode = "", bank_name = "",
        auth_code = "", ipg_txn_id = "", merchant_id = "", desc = "", discriminator = "", surcharge = "", CardNumber = "";
        txtPaidDate.Text = DateTime.Now.ToString("dd MMM yyyy");
        if (!IsPostBack)
        {
            if (Session["Fyid"] != null)
            {
                TextBox1.Text = Session["Fyid"].ToString();
            }
            if (Session["brbrid"] != null)
            {
                hdfBrid.Value = Session["brbrid"].ToString();
            }
            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "df", "<script type='text/javascript'>FileDate();</script>", false);
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
                    string PAYMENTDATE = "";
                    int paymneCount = 0;
                    int transCount = 0;
                    DateTime.Today.ToString("dd/MM/yyyy");

                    string str1 = "SELECT [Brid],[StuRegNo],[ASAID] FROM tmpOnline";
                    DataTable dtStdDT = Objdut.GetDataTable(str1);
                    if (dtStdDT.Rows.Count > 0)
                    {
                        StdRegNo = dtStdDT.Rows[0]["StuRegNO"].ToString();
                        Brid = dtStdDT.Rows[0]["Brid"].ToString();                       
                        ASAID = dtStdDT.Rows[0]["ASAID"].ToString();
                    }
                    if (!string.IsNullOrEmpty(StdRegNo.ToString()))
                    {
                        string StdAdmNo = Objdut.GetScalar(" select ISNULL(AdmissionNo,'') AdmissionNo from tbl_StudentAdmissionMaster where StuRegNo =" + StdRegNo + "").ToString();
                        int SchoolID = Convert.ToInt32(Objdut.GetScalar(" select ISNULL(SchoolID,0) SchoolID from tblProductName where Brid =" + Brid + ""));
                        string[] FeeDetail = (string[])(Session["FeeDetail"]);
                        PAYMENTDATE = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
                        if (FeeDetail.Length > 0)
                        {
                            string ASAID = nvc["udf5"].ToString();
                            string str = "SELECT [PayAmtID],[ASAID],[Brid],[Fyid],[StuRegNo],[Payment_Date],[FeeAmount],[PayStatus],[RouteID],[ReceiptNo],[UserName] FROM [tbl_TransFee] WHERE ASAID=" + ASAID;
                            string RECIPTNO = "";
                            DataTable dtFeeDetail = Objdut.GetDataTable(str);
                            if (dtFeeDetail.Rows.Count > 0)
                            {
                                Fyid = dtFeeDetail.Rows[0]["Fyid"].ToString();
                                RECIPTNO = dtFeeDetail.Rows[0]["ReceiptNo"].ToString();
                            }
                            if (f_code == "Ok")
                            {
                                paymneCount = Convert.ToInt32(Deposite(PAYMENTDATE, ASAID, StdRegNo, Brid, Fyid));
                                transCount = Convert.ToInt32(transPayment(ASAID.ToString(), StdRegNo, mmp_txn.ToString(), mer_txn.ToString(), amt, prod.ToString(), PAYMENTDATE, bank_txn.ToString(), f_code.ToString(), clientcode.ToString(), bank_name.ToString(), auth_code.ToString(), merchant_id.ToString(), desc.ToString(), discriminator.ToString(), surcharge, CardNumber.ToString()));

                                string url1 = "http://stfrancisacademy.schoolerponline.in/EmployeePanel/TransDoublePay.aspx?ASAID=" + ASAID.ToString() + "";
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
                                CommonClass.getStudentMobileNo(Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), Convert.ToDecimal(StdRegNo), Convert.ToInt32(CommonClass.Scaler("ActiveAcademicYear")), msg1, msg2, msg3);
                                ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alert", "alert('" + msg2 + "')", true);
                            }
                            else
                            {
                                transCount = Convert.ToInt32(objService.transPayment(FeeDetail[0].ToString(), StdRegNo, mmp_txn.ToString(), mer_txn.ToString(), amt, prod.ToString(), date, bank_txn.ToString(), f_code.ToString(), clientcode.ToString(), bank_name.ToString(), auth_code.ToString(), merchant_id.ToString(), desc.ToString(), discriminator.ToString(), surcharge, CardNumber.ToString()));
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
            Objdut.ExecuteSql("TRUNCATE TABLE tmpOnline");
        }
    }
    protected void SendPostRequestNew(string ASAID)
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
        string amt = txtPayAmt.Text;
        string txncurr = "INR";
        string txnscamt = "0";
        string clientcode = "007";
        string txnid = Convert.ToString(Convert.ToInt32(Objdut.GetScalar("select COunt(*) from tblTransPortFeeTransDetail")) + 1);
        string date = now;
        string custacc = "";
        string ReturnURL = "http://stfrancisacademy.schoolerponline.in/EmployeePanel/PayTransportFee.aspx";
        string LastURL = "&ru=" + ReturnURL + "";
        //&mprod=<products><product><id>1</id><name>One</name><amount>" + Convert.ToDecimal(ProductID1amt) + "</amount></product><product><id>2</id><name>Two</name><amount>" + Convert.ToDecimal(ProductID2amt) + "</amount></product></products>";

        //string strProd = @"Select DISTINCT SchoolID,Brid,tbl_Pay.ClassID,SchoolName,AccountNo,tbl_Pay.IsActive,tbl_Prod.UserID,Password,ProductID,HashRequestKey 
        //                    from tblProductName tbl_Prod
        //                    INNER JOIN tbl_PaymentApiToClass tbl_Pay on tbl_prod.SchoolID = tbl_Pay.ApiID" +
        //                    " WHERE tbl_Pay.IsActive =1 and tbl_Pay.ClassID=" + ClassID;
        //dtProductDetails = Objdut.GetDataTable(strProd);
        //dtProductDetails = Objdut.GetDataTable("select isnull(UserID,'') UserID,isnull(Password,'') Password,isnull(ProductID,'') ProductID from tblProductName where Brid = " + Session["brbrid"] + " and ClassID=" + ClassID);

        dtProductDetails = getPaymentProdId();
        
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
        //    //login = "160";
        //    //pass = "Test@123";
        //    //prodid = "NSE";
        //    //Url = "paynetzuat";
        //    //custacc = "123456789";
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
                strURL = strURL + "login=" + login + "&pass=" + pass + "&ttype=" + ttype + "&prodid=" + prodid + "&amt=" + Convert.ToDecimal(txtPayAmt.Text.Trim()) + "&txncurr=" + txncurr + "";
                strURL = strURL + "&txnscamt=" + txnscamt + "&clientcode=" + clientcode + "&txnid=" + txnid + "&date=" + date + "&custacc=" + custacc + "";
                strURL = strURL + "&udf1=0&udf2=No&udf3=" + MobileNo + "&udf4=1&udf5=" + ASAID + "&udf9=" + Session["eid"].ToString() + LastURL;

                string signature = "";
                string strsignature = login + pass + ttype + prodid + txnid + txtPayAmt.Text.Trim() + txncurr;
                byte[] bytes = Encoding.UTF8.GetBytes(respHashKey);
                byte[] bt = new System.Security.Cryptography.HMACSHA512(bytes).ComputeHash(Encoding.UTF8.GetBytes(strsignature));
                signature = byteToHexString(bt).ToLower();
                strURL = strURL.Replace("[signature]", signature);
                signature = "&signature=" + signature;

                strURL = strURL + signature;
                string filePath = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
                string extension = ".txt";
                filePath += @"\Error_Log" + extension;
                

                Objdut.ExecuteSql("TRUNCATE TABLE tmpOnline");

                string dte = "INSERT INTO tmpOnline VALUES(" + Session["brbrid"] + "," + Session["eid"] + "," + ASAID + ")";
               // strURL = strURL + dte;
                File.WriteAllText(filePath, strURL);

                Objdut.ExecuteSql(dte);              


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

    private DataTable getPaymentProdId()
    {
        DataTable dtProd = new DataTable();
        dtProd.Columns.Add("UserID");
        dtProd.Columns.Add("Password");
        dtProd.Columns.Add("ProductID");
        dtProd.Columns.Add("HashRequestKey");
        if (!(string.IsNullOrEmpty(TextBox1.Text) && string.IsNullOrEmpty(hdfBrid.Value)))
        {
            string str = @"Select ISNULL(VM.VehicleRegID,0) from tbl_vehicleroutemap_StudentDetails TSD
                            INNER JOIN tbl_vehicle_route_map VM ON VM.VehicleRouteMapID = tsd.VechileRouteMapId and vm.RouteID = TSD.RouteID
                            INNER JOIN tbl_StudentMaster SM on SM.StuRegNo = TSD.StuRegNo and SM.Brid = TSD.Brid 
                            where SM.StuRegNo=" + Session["eid"] + " and SM.brid=" + hdfBrid.Value + " and SM.fyid=" + TextBox1.Text + "";

            var VechileRouteMapId = Convert.ToInt32(Objdut.GetScalar(str));
            if (VechileRouteMapId > 0)
            {
                DataRow dr = dtProd.NewRow();
                if (VechileRouteMapId == 8 || VechileRouteMapId == 9)
                {                   
                    dr["UserID"] = "105946";
                    dr["Password"] = "939bd6b2";
                    dr["ProductID"] = "FRANCIS";
                    dr["HashRequestKey"] = "a47b59ad31722ed17b";
                }
                else if (VechileRouteMapId == 1 || VechileRouteMapId == 2 || VechileRouteMapId == 3 || VechileRouteMapId == 4 || VechileRouteMapId == 6 || VechileRouteMapId == 7)
                {
                    dr["UserID"] = "106337";
                    dr["Password"] = "3c64a4da";
                    dr["ProductID"] = "CAPUCHIN";
                    dr["HashRequestKey"] = "31cfb6ccc2622960da";
                }
                dtProd.Rows.Add(dr);
                dtProd.AcceptChanges();
            }
        }
        return dtProd;
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
        if (txtPaidDate.Text == "")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Please Enter Payment Date');", true);
            txtPaidDate.Focus();
            return false;
        }
        return true;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Validate())
        {
            StdAdmNo = "";

            // ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "df", "<script type='text/javascript'>FillFieldForPay();</script>", false);
            if (txtPaidDate.Text != "")
            {
                string DateOfDueAmount = Convert.ToDateTime(txtPaidDate.Text.ToString()).ToString("yyyy-MM-dd");
            }
            Session["FeeDetail"] = null;
            string[] FeeDetail = new string[3];
            FeeDetail[0] = fdASAID.Value.ToString();
            FeeDetail[1] = txtPaidDate.Text.ToString();
            FeeDetail[2] = txtPayAmt.Text.ToString();
            Session["FeeDetail"] = FeeDetail;

            SendPostRequestNew(fdASAID.Value.ToString());
        }
    }

    [WebMethod]
    public static int Deposite(string PaymentDate, string ASAID, string sTUREGNO, string brid, string Fyid)
    {
        string[] AsaidList = ASAID.Split(',');
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[9];
        param[0] = new SqlParameter("@Brid", brid);
        param[1] = new SqlParameter("@Fyid", Convert.ToInt32(Fyid));
        param[2] = new SqlParameter("@Mode", 1);
        param[3] = new SqlParameter("@StuRegNo", sTUREGNO);
        param[4] = new SqlParameter("@PaymentDate", Convert.ToDateTime(PaymentDate));
        param[5] = new SqlParameter("@AllAsaid", ASAID);
        param[6] = new SqlParameter("@UserName", "");
        param[7] = new SqlParameter("@intResult", SqlDbType.Int);
        param[7].Direction = ParameterDirection.Output;
        param[8] = new SqlParameter("@PayMode", Convert.ToInt32(2));
        Objdut.ExecuteSqlSP(param, "[USP_DEPOSITE_TRANSFEE]");
        int intresult = Convert.ToInt32(param[7].Value);
        return intresult;
    }
    [WebMethod]
    public int transPayment(string ASAID, string STDREGNO, string MMP_TXN, string MER_TXN, string AMT, string PROD, string DATE, string BANK_TXN, string F_CODE, string CLIENTCODE, string BANK_NAME, string AUTH_CODE, string MERCHANT_ID, string DESC, string DISCRIMINATOR, string SURCHARGE, string CARDNUMBER)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] Param1 = new SqlParameter[18];
        Param1[0] = new SqlParameter("@StdRegNo", Convert.ToDecimal(STDREGNO));
        Param1[1] = new SqlParameter("@mmp_txn", MMP_TXN.ToString());
        Param1[2] = new SqlParameter("@mer_txn", MER_TXN.ToString());
        Param1[3] = new SqlParameter("@amt", Convert.ToDecimal(AMT));
        Param1[4] = new SqlParameter("@prod", PROD.ToString());
        Param1[5] = new SqlParameter("@date", DATE);
        Param1[6] = new SqlParameter("@bank_txn", BANK_TXN.ToString());
        Param1[7] = new SqlParameter("@f_code", F_CODE.ToString());
        Param1[8] = new SqlParameter("@cliendcode", CLIENTCODE.ToString());
        Param1[9] = new SqlParameter("@bank_name", BANK_NAME.ToString());
        Param1[10] = new SqlParameter("@auth_code", AUTH_CODE.ToString());
        Param1[11] = new SqlParameter("@merchant_id", MERCHANT_ID.ToString());
        Param1[12] = new SqlParameter("@desc", DESC.ToString());
        Param1[13] = new SqlParameter("@discriminator", DISCRIMINATOR.ToString());
        Param1[14] = new SqlParameter("@surcharge", Convert.ToDecimal(SURCHARGE));
        Param1[15] = new SqlParameter("@ASAID", ASAID.ToString());
        Param1[16] = new SqlParameter("@CardNumber", CARDNUMBER.ToString());
        Param1[17] = new SqlParameter("@Intresult", SqlDbType.Int);
        Param1[17].Direction = ParameterDirection.Output;
        int result = Objdut.ExecuteSqlSP(Param1, "usp_TransportFeeOnlinePayDT");
        return (result);
    }
    public class studentregistration2
    {
        public string ASAID { get; set; }
        public string SAMID { get; set; }
        public string Fyid { get; set; }
        public string AdmissionDate { get; set; }
        public string AdmissionNo { get; set; }
        public string RefAdmNo { get; set; }
        public string RID { get; set; }
        public string StuRegNo { get; set; }
        public string RegistrationDate { get; set; }
        public string Registration_No { get; set; }
        public string studentFname { get; set; }
        public string studentMname { get; set; }
        public string studentLname { get; set; }
        public string StudentUID { get; set; }
        public string Classname { get; set; }
        public string ClassID { get; set; }
        public string SectionID { get; set; }
        public string Sectionname { get; set; }
        public string DOB { get; set; }
        public string Status { get; set; }
        public string FeeAmount { get; set; }
        public string fatherFname { get; set; }
        public string fatherMname { get; set; }
        public string fatherLname { get; set; }
        public string PrimaryMobileNo { get; set; }
        public string PrimarySelectParentType { get; set; }
        public string PrimaryParentDOB { get; set; }
        public string PrimaryParentOccupation { get; set; }
        public string PrimaryEmailId { get; set; }

        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Pin { get; set; }
        public string Country { get; set; }

        public string Comment { get; set; }
        public string pagecount { get; set; }
        public string PayStatus { get; set; }
        public string Month { get; set; }
        public string TotalFee { get; set; }
        public string PaidFee { get; set; }
        public string BalFee { get; set; }

    }
}