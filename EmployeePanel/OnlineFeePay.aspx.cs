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
using System.Web.Security;

public partial class OnlineFeePay : System.Web.UI.Page
{
    int SchoolID = 0;
    string StdRegNo;
    string StdAdmNo;
    private Utility objUT = new Utility();
    private DataUtility objDUT = new DataUtility();
    private SqlCommand cmd, cmd1;
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
    private SqlDataReader sdr;
    private string Query;
    private string userid, pass;
    private int x;
    Service objService = new Service();
    private Boolean IsPageRefresh = false;   
    private int eid = 0;
    private DataTable dt;
    private int idStudent = 0;
    int ID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            checkLogin(Request.QueryString["SturegNo"].ToString());
        }
        ShowLogo();
        string mmp_txn = "", mer_txn = "", amt = "", prod = "", date = "", bank_txn = "", f_code = "", clientcode = "", bank_name = "",
        auth_code = "", ipg_txn_id = "", merchant_id = "", desc = "", discriminator = "", surcharge = "", CardNumber = "", SAMID = ""; ;
        txtpaydate.Text = DateTime.Now.ToString("dd/MM/yyyy");
        try
        {
            if (Request.QueryString["SturegNo"] != null)
                {
                    int i;
                    bool success = int.TryParse(Request.QueryString["SturegNo"].ToString(), out i);
                    if (success == true)
                    {                       
                        if (Session["SturegNo"] == null)
                        {
                            ID = Convert.ToInt32(Request.QueryString["SturegNo"]);
                        }
                        else 
                        {
                            ID = Convert.ToInt32(Session["SturegNo"]);
                        }
                        if (Convert.ToInt32(Request.QueryString["SturegNo"]) != 0 && Convert.ToInt32(Request.QueryString["SturegNo"]) == ID)
                        {
                            SAMID = objDUT.GetScalar(" select ISNULL(SAMID,'') SAMID from tbl_StudentAdmissionMaster where StuRegNo =" + ID.ToString() + "").ToString();
                            Session["nvc"] = null;
                            if (!IsPostBack)
                            {
                                NameValueCollection nvc = Request.Form;
                                if (nvc.Count > 0)
                                {
                                    Session["nvc"] = nvc;
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
                                    string sturReg = HttpContext.Current.Session["SturegNo"].ToString();
                                    string[] FeeDetail = (string[])(Session["FeeDetail"]);                                    
                                    if (f_code == "Ok")
                                    {
                                        string StdAdmNo = objDUT.GetScalar(" select ISNULL(AdmissionNo,'') AdmissionNo from tbl_StudentAdmissionMaster where StuRegNo =" + ID.ToString() + "").ToString();
                                        int SchoolID = Convert.ToInt32(objDUT.GetScalar(" select ISNULL(SchoolID,0) SchoolID from tblProductName where Brid =" + Session["brbrid"].ToString() + ""));

                                        string PAYMENTDATE = "";
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

                                            paymneCount = Convert.ToInt32(objService.DepositFee1("0",FeeDetail[0].ToString(), "6", bank_name, "", "", "", FeeDetail[1].ToString(), PAYMENTDATE, FeeDetail[3].ToString(), FeeDetail[4].ToString(), RemaingAmountDueDate, FeeDetail[6].ToString())); 
                                            string msg1 = "", msg2 = "", msg3 = "";
                                            transCount = Convert.ToInt32(objService.transPayment(FeeDetail[0].ToString(), sturReg, mmp_txn.ToString(), mer_txn.ToString(), amt, prod.ToString(), PAYMENTDATE, bank_txn.ToString(), f_code.ToString(), clientcode.ToString(), bank_name.ToString(), auth_code.ToString(), merchant_id.ToString(), desc.ToString(), discriminator.ToString(), surcharge, CardNumber.ToString()));

                                            msg1 = "'Hi ";
                                            msg2 = " ,Fee Amount of Rs." + FeeDetail[4].ToString() + " Successfully Received with Recipt No : " + FeeDetail[1].ToString() + " on " + DateTime.Today.ToString("dd/MM/yyyy") + ".";
                                            if (RemaingAmountDueDate.ToString() != "")
                                            {
                                                msg3 = "Next Due Fee Date is " + RemaingAmountDueDate + ". Thanks.";
                                            }
                                            else
                                            {
                                                msg3 = "Thanks";
                                            }
                                            CommonClass.getStudentMobileNo(Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), Convert.ToDecimal(sturReg), Convert.ToInt32(CommonClass.Scaler("ActiveAcademicYear")), msg1, msg2, msg3);
                                        }
                                        string url1 = "http://www.schoolerponline.in/BranchPanel/Fee%20Management/feereceipt.aspx?sid=" + FeeDetail[0].ToString() + "";
                                        string script = string.Format("window.open('{0}');", url1);
                                        Page.ClientScript.RegisterStartupScript(this.GetType(), "newPage" + UniqueID, script, true);

                                        string message = "";
                                        if (paymneCount == 0 && transCount == 0)
                                        {
                                            message = "alert('Your TxnID is " + bank_txn + " but Not update in School Database, Please Contact School !!!')";                                           
                                        }
                                        else
                                        {
                                            message = "Fee Deposite Succesfully with TxnID " + bank_txn + ", Thanks !!!')";                                           
                                        }
                                        
                                        ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alert", message, true);                                      
                                    }
                                    else
                                    {
                                        transCount = Convert.ToInt32(objService.transPayment(FeeDetail[0].ToString(), sturReg, mmp_txn.ToString(), mer_txn.ToString(), amt, prod.ToString(), date, bank_txn.ToString(), f_code.ToString(), clientcode.ToString(), bank_name.ToString(), auth_code.ToString(), merchant_id.ToString(), desc.ToString(), discriminator.ToString(), surcharge, CardNumber.ToString()));
                                        string message = "alert('Error in Online Payment,Please Try again !!')";
                                        ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alert", message, true);                                      
                                    }                                    
                                }                                                                
                                showDetails(Convert.ToInt32(Request.QueryString["SturegNo"].ToString()));
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "myfunction", "<script type='text/javascript'>BindFeeDetaisList(" + SAMID.ToString() + ");</script>", false);
                            }
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "df", "alert('Please Enter Registration No again, Try again');window.location ='http://paytopaid.com/OnlineFeePayment.aspx'", true);
                        }                     
                            
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "df", "alert('No Record Found or Invalid Details, Try again');window.location ='http://paytopaid.com/OnlineFeePayment.aspx'", true);
                    }
                }
            
        }
        catch
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "df", "alert('No Record Found or Invalid Details, Try again');window.location ='http://paytopaid.com/OnlineFeePayment.aspx'", true);
        }
    }
    public void ShowLogo()
    {
        string imgsrc = "";
        if (Session["brbrid"] != null)
        {
            string imgsrc1 = Convert.ToString(objDUT.GetScalar("select photo from Branch_master where brid=" + Session["brbrid"]));
            if (imgsrc1 != "")
            {
                imgPP.ImageUrl = "../BranchPanel/images/" + imgsrc1;
            }
            else
            {
                imgPP.ImageUrl = "../BranchPanel/images/9update.png";
            }
        }
        else
        {
            imgPP.ImageUrl = "../BranchPanel/images/9update.png";
        }
    }
    [WebMethod]
    public static string BindPayNow(int ASAID)
    {
        DataSet Ds = new DataSet();
        try
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand("[StudentsAllDetails]", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter[] param = new SqlParameter[3];
                    param[0] = new SqlParameter("@Mode", 3);
                    param[1] = new SqlParameter("@ASAID", ASAID);
                    param[2] = new SqlParameter("@Brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
                    cmd.Parameters.Add(param[0]);
                    cmd.Parameters.Add(param[1]);
                    cmd.Parameters.Add(param[2]);
                    SqlDataAdapter Da = new SqlDataAdapter(cmd);
                    Da.Fill(Ds);
                }
            }
        }
        catch (Exception e)
        {
            throw e;
        }
        return Ds.GetXml().ToString();
    }
    protected void showDetails(int id)
    {
        dt = CommonClass.ABC("stuDentDetails", id, Convert.ToInt32(Session["brbrid"]));

        if (dt.Rows.Count > 0)
        {
            if (!string.IsNullOrEmpty(dt.Rows[0]["StudentPhotograph"].ToString()))
            {

                ViewState["pic"] = dt.Rows[0]["StudentPhotograph"].ToString();
                img1.ImageUrl = "../BranchPanel/Student-Registration/student-registration-document/" + ViewState["pic"].ToString();
            }
            else
            {
                ViewState["pic"] = null;
                img1.ImageUrl = "~/images/9update.png";
            }
            lblRollno.InnerText = "";
            lblname.InnerText = dt.Rows[0]["StudentFirstName"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["StudentMiddleName"].ToString()))
            {
                lblname.InnerText = lblname.InnerText + dt.Rows[0]["StudentMiddleName"].ToString();
            }
            else
            {
                lblname.InnerText = lblname.InnerText + "";
            }

            if (!string.IsNullOrEmpty(dt.Rows[0]["SchoolBoard"].ToString()) && dt.Rows[0]["SchoolBoard"].ToString() != "Select Board")
            {
                lblBoard.InnerText = dt.Rows[0]["SchoolBoard"].ToString();
            }
            else
            {
                lblBoard.InnerText = "NA";
            }
            //if (!string.IsNullOrEmpty(dt.Rows[0]["SchoolMediam"].ToString()) && dt.Rows[0]["SchoolMediam"].ToString() != "Select Medium")
            //{
            //    lblMedium.InnerText = dt.Rows[0]["SchoolMediam"].ToString();
            //}
            //else
            //{
            //    lblMedium.InnerText = "NA";
            //}
            lblMedium.InnerText = "NA";
            lblname.InnerText = lblname.InnerText + " " + dt.Rows[0]["StudentLastName"].ToString();
            if (Convert.ToBoolean(dt.Rows[0]["Gender"]))
            {
                lblGender.InnerText = "Male";
            }
            else
            {
                lblGender.InnerText = "Female";
            }
            lblDOB.InnerText = (Convert.ToDateTime(dt.Rows[0]["StudentDOB"])).ToString("dd/MM/yyyy");
            if (!string.IsNullOrEmpty(dt.Rows[0]["Address"].ToString()))
            {
                lblAddress.InnerText = dt.Rows[0]["Address"].ToString();
            }
            else
            {
                lblAddress.InnerText = "NA";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["SchoolName"].ToString()) && dt.Rows[0]["SchoolName"].ToString() != "--Select School--")
            {
                lblschool.InnerText = dt.Rows[0]["SchoolName"].ToString();
            }
            else
            {
                lblschool.InnerText = "NA";
            }
            lblMobileno.InnerText = dt.Rows[0]["PrimaryMobileNo"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["PrimaryEmailId"].ToString()))
            {
                lblemailid.InnerText = dt.Rows[0]["PrimaryEmailId"].ToString();
            }
            else
            {
                lblemailid.InnerText = "NA";
            }
            //if (!string.IsNullOrEmpty(dt.Rows[0]["SoureType"].ToString()))
            //{
            //    lblstudentsource.InnerText = dt.Rows[0]["SoureType"].ToString();
            //}
            //else
            //{
            //    lblstudentsource.InnerText = "NA";
            //}
            lblstudentsource.InnerText = "NA";
            lblLandlineno.InnerText = "NA";
            ////if (!string.IsNullOrEmpty(dt.Rows[0]["landline"].ToString()))
            ////{
            ////    lblLandlineno.InnerText = dt.Rows[0]["landline"].ToString();
            ////}
            ////else
            ////{
            ////    lblLandlineno.InnerText = "NA";
            ////}
            //if (!string.IsNullOrEmpty(dt.Rows[0]["Gphoto"].ToString()))
            //{
            //    ViewState["fpic"] = dt.Rows[0]["Gphoto"].ToString();
            //    Img2.ImageUrl = "../StudentPhoto/" + ViewState["fpic"].ToString();
            //}
            //else
            //{
            //    ViewState["fpic"] = null;
            //    Img2.ImageUrl = "~/images/9update.png";
            //}
            //Img2.ImageUrl = "~/images/9update.png";
            //if (!string.IsNullOrEmpty(dt.Rows[0]["PrimaryParentFirstName"].ToString()))
            //{
            //    lblGName.InnerText = dt.Rows[0]["PrimaryParentFirstName"].ToString();
            //}
            //else
            //{
            //    lblGName.InnerText = "NA";
            //}
            //if (!string.IsNullOrEmpty(dt.Rows[0]["PrimarySelectParentType"].ToString()))
            //{
            //    if (dt.Rows[0]["PrimarySelectParentType"].ToString() == "--Select Relation--")
            //    {
            //        lblRelation.InnerText = "NA";
            //    }
            //    else
            //    {
            //        lblRelation.InnerText = dt.Rows[0]["PrimarySelectParentType"].ToString();
            //    }
            //}
            //else
            //{
            //    lblRelation.InnerText = "NA";
            //}

            ////if (!string.IsNullOrEmpty(dt.Rows[0]["GuardianPhone"].ToString()))
            ////{
            ////    lblGMobileno.InnerText = dt.Rows[0]["GuardianPhone"].ToString();
            ////}
            ////else
            ////{
            ////    lblGMobileno.InnerText = "NA";
            ////}

            //lblGemailid.InnerText = "NA";
            //lblGMobileno.InnerText = "NA";
            ////if (!string.IsNullOrEmpty(dt.Rows[0]["Gmail"].ToString()))
            ////{
            ////    lblGemailid.InnerText = dt.Rows[0]["Gmail"].ToString();
            ////}
            ////else
            ////{
            ////    lblGemailid.InnerText = "NA";
            ////}
            ////if (!string.IsNullOrEmpty(dt.Rows[0]["Gaddress"].ToString()))
            ////{
            ////    lblGAddress.InnerText = dt.Rows[0]["Gaddress"].ToString();
            ////}
            ////else
            ////{
            ////    lblGAddress.InnerText = "NA";
            ////}
            //lblGAddress.InnerText = "NA";
        }       
    }
    protected void SendPostRequestNew(string ASAID, string RECEIPTNO, string ALLASAID)
    {
        try
        {
            CommonClass ObjCommon = new CommonClass();
            string now = DateTime.Now.ToString("dd/mm/yyyy hh:mm:ss").Replace("-", "/");
            Service objService = new Service();
            DataTable dsCameraDetails = new DataTable();
            DataTable dtProductDetails = new DataTable();
            dsCameraDetails = ObjCommon.JsonStringToDataTable(objService.GetStudentDetails(Session["brbrid"].ToString(), Session["RID"].ToString()));

            string Name = "";
            string EmailID = "";
            string MobileNo = "";

            if (dsCameraDetails.Rows.Count > 0)
            {
                DataRow dr1 = dsCameraDetails.Rows[0];
                Name = dr1["name"].ToString();
                EmailID = dr1["studentEmailID"].ToString();
                MobileNo = dr1["mobile"].ToString();
            }
            string login = "";
            string Url = "";
            string pass = "";
            string ttype = "NBFundTransfer";
            string prodid = "i";
            string amt = txtAmount.Text;
            string txncurr = "INR";
            string txnscamt = "0";
            string clientcode = "007";
            string txnid = "PYTOPD" + (Convert.ToInt32(objDUT.GetScalar("select COunt(*) from tblFeeTransDetail")) + 1).ToString();
            string date = now;
            string custacc = "1234567890";
            string ReturnURL = "http://www.schoolerponline.in/EmployeePanel/OnlineFeePay.aspx?SturegNo=" + ID + "";
            string LastURL = "&ru=" + ReturnURL + "";
            //&mprod=<products><product><id>1</id><name>One</name><amount>" + Convert.ToDecimal(ProductID1amt) + "</amount></product><product><id>2</id><name>Two</name><amount>" + Convert.ToDecimal(ProductID2amt) + "</amount></product></products>";

            dtProductDetails = objDUT.GetDataTable("select isnull(UserID,'') UserID,isnull(Password,'') Password,isnull(ProductID,'') ProductID from tblProductName where Brid = " + Session["brbrid"] + "");
            if (dtProductDetails.Rows.Count > 0)
            {
                DataRow dr = dtProductDetails.Rows[0];
                login = dr["UserID"].ToString();
                pass = dr["Password"].ToString();
                prodid = dr["ProductID"].ToString();
                Url = "payment";
                custacc = "1234567890";
            }
            else
            {
                login = "160";
                pass = "Test@123";
                prodid = "NSE";
                Url = "paynetzuat";
                custacc = "123456789";
            }
            if (login != "" && pass != "" && prodid != "" && Url != "")
            {

                HttpWebRequest request = (HttpWebRequest)WebRequest.Create("https://" + Url + ".atomtech.in/paynetz/epi/fts");

                request.Method = "POST";

                request.ContentType = "application/x-www-form-urlencoded";
                request.UserAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; CK={CVxk71YSfgiE6+6P6ftT7lWzblrdvMbRqavYf/6OcMIH8wfE6iK7TNkcwFAsxeChX7qRAlQhvPWso3KI6Jthvnvls9scl+OnAEhsgv+tuvs=}; .NET CLR 1.1.4322; .NET CLR 2.0.50727)";

                string postData = "login=" + login + "&pass=" + pass + "&ttype=" + ttype + "&prodid=" + prodid + "&amt=" + amt + "&txncurr=" + txncurr + "&txnscamt=" + txnscamt + "&clientcode=" + clientcode + "&txnid=" + txnid + "&date=" + date + "&custacc=" + custacc + "&udf1=" + RECEIPTNO + "" +
          "&udf3=" + MobileNo + "&udf4=1&udf5=" + ASAID + "&udf9=" + ID.ToString() + LastURL;

                byte[] byteArray = Encoding.UTF8.GetBytes(postData);

                request.ContentType = "application/x-www-form-urlencoded";

                request.ContentLength = byteArray.Length;
                request.AllowAutoRedirect = true;

                request.Proxy.Credentials = CredentialCache.DefaultCredentials;

                Stream dataStream = request.GetRequestStream();

                dataStream.Write(byteArray, 0, byteArray.Length);

                dataStream.Close();

                WebResponse response = request.GetResponse();

                XmlDocument objXML = new XmlDocument();

                dataStream = response.GetResponseStream();

                objXML.Load(dataStream);

                string TxnId = objXML.DocumentElement.ChildNodes[0].ChildNodes[0].ChildNodes[2].InnerText;

                string Token = objXML.DocumentElement.ChildNodes[0].ChildNodes[0].ChildNodes[3].InnerText;
                string txnData = "ttype=NBFundTransfer&txnStage=1&tempTxnId=" + TxnId + "&token=" + Token;

                dataStream.Close();
                response.Close();
                Response.Redirect("https://" + Url + ".atomtech.in/paynetz/epi/fts?" + txnData);
            }
        }
        catch
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "df", "alert('No Record Found or Invalid Details, Try again');window.location ='http://localhost:38630/Payment.aspx'", true);
        }
    }

    private static string EncodeTo64UTF8(String str)
    {
        byte[] toEncode2Bytes = System.Text.Encoding.UTF8.GetBytes(str);
        string sReturnValue = System.Convert.ToBase64String(toEncode2Bytes);
        return sReturnValue;
    }

    private bool Validate()
    {
        try
        {
            if (txtAmount.Text == "")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Please Enter Amount');", true);
                txtAmount.Focus();
                return false;
            }

            if (txtpaydate.Text == "")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Please Enter Payment Date');", true);
                txtpaydate.Focus();
                return false;
            }
            //int SchoolID = Convert.ToInt32(objDUT.GetScalar(" select ISNULL(SchoolID,0) SchoolID from tblProductName where Brid =" + Session["brbrid"].ToString() + ""));
            //if (SchoolID == 0)
            //{
            //    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Please configure School A/c No.');", true);
            //    txtpaydate.Focus();
            //    return false;
            //}

        }
        catch
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "df", "alert('No Record Found or Invalid Details, Try again');window.location ='http://localhost:38630/Payment.aspx'", true);
            return false;
        }

        return true;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["SturegNo"] != null)
            {                
                if (Validate())
                {
                    StdAdmNo = "";

                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "df", "<script type='text/javascript'>FillFieldForPay();</script>", false);

                    Session["FeeDetail"] = null;
                    string[] FeeDetail = new string[7];
                    FeeDetail[0] = hfforasaid.Value.ToString();
                    FeeDetail[1] = txtfeerecipt.Text.ToString();
                    FeeDetail[2] = txtpaydate.Text.ToString();
                    FeeDetail[3] = txtareacomment.Text.ToString();
                    FeeDetail[4] = txtAmount.Text.ToString();
                    FeeDetail[5] = txtDate.Text.ToString();
                    FeeDetail[6] = SelectedASID.Value.ToString();
                    Session["FeeDetail"] = FeeDetail;

                    SendPostRequestNew(hfforasaid.Value.ToString(), txtfeerecipt.Text.ToString(), SelectedASID.Value.ToString());
                }
            }
        }
        catch
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "df", "alert('No Record Found or Invalid Details, Try again');window.location ='http://localhost:38630/Payment.aspx'", true);
        }
    }
    public void checkLogin(string RegNo)
    {
        try
        {
            if (RegNo != "")
            {                
                int x = 0;
                Utility objUT = new Utility();
                DataUtility objDUT = new DataUtility();
                SqlCommand cmd, cmd1;
                SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
                SqlDataReader sdr;
                string Query = "";                
                Query = "Select * From tbl_studentmaster where SturegNo='" + RegNo + "' and status=1";
                cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = Query;
                con.Open();
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows)
                {
                    while (sdr.Read())
                    {
                        HttpContext.Current.Session["BrUser"] = 1;
                        User user = null;
                        user = new User();
                        user.UserID = Convert.ToInt32(sdr["SturegNo"].ToString());
                        user.UserName = RegNo.ToString();
                        user.brid = Convert.ToInt32(sdr["Brid"].ToString());

                        HttpContext.Current.Session["BrUser"] = user;

                        HttpContext.Current.Session["SturegNo"] = sdr["SturegNo"];
                        HttpContext.Current.Session["eid"] = sdr["RID"];
                        HttpContext.Current.Session["RID"] = sdr["RID"];
                        HttpContext.Current.Session["loginid"] = sdr["Registration_No"];
                        HttpContext.Current.Session["brbrid"] = sdr["Brid"];
                        HttpContext.Current.Session["BrBrid"] = sdr["Brid"];
                        HttpContext.Current.Session["Password"] = sdr["Password"];
                        HttpContext.Current.Session["Classid"] = sdr["Classid"];
                        HttpContext.Current.Session["Sectionid"] = sdr["Sectionid"];                        

                        //if (HttpContext.Current.Request.Params["ReturnUrl"] != null)
                        //{
                        //    FormsAuthentication.RedirectFromLoginPage(RegNo, false);
                        //}
                        //else
                        //{
                        //    FormsAuthentication.SetAuthCookie(RegNo, false);
                        //    //HttpContext.Current.Response.Redirect("OnlineFeePay.aspx?stdRegNo='" + RegNo + "'", false);                            
                        //}
                    } 
                }                
            }            
        }
        catch
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "df", "alert('No Record Found or Invalid Details, Try again');window.location ='http://paytopaid.com/OnlineFeePayment.aspx'", true);
        }
    }
}