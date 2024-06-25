using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI;
public partial class BranchPanel_UserManager_add_new_branch_user : System.Web.UI.Page
{
    private string url1;
    private string PageName;
    private Utility objut = new Utility();
    private DataUtility objDUT = new DataUtility();
    private int result = 0;
    private Utility objUT = new Utility();
    private string brCode = string.Empty, pageName = string.Empty, url = string.Empty;
    private string strSqlCountry, finalfilename = "", finalpicname = "", multifile = "", filename = "";
    private FileInfo finfoevent;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {
                if (Request.QueryString.Count > 0)
                {
                    int eid = Convert.ToInt32(Request.QueryString[0]);
                    ViewState["usercode"] = eid;
                    if (Convert.ToInt32(Request.QueryString["mode"]) > 0)
                    {
                        divforradio.Visible = false;
                        divforidentifyuserbyIp.Visible = false;
                        divforidentifyuserbymac.Visible = false;
                        divforactive.Visible = false;
                        divforsendemail.Visible = false;
                        divforsendsms.Visible = false;
                        divsponserid.Visible = false;
                    }
                    fillField(eid);
                }
                else
                {
                    string password = Convert.ToString(objDUT.GetScalar("SELECT CAST(RAND() * 1000000 AS INT) AS [RandomNumber]"));
                    txtPass.Attributes.Add("value", password);
                    txtRePass.Attributes.Add("value", password);
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
    public void fillField(int eid)
    {
        DataTable Dt;
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@employeeid", eid);
        Dt = objDUT.GetDataTableSP(param, "[usp_getbranchuserdetails]");
        if (Dt.Rows.Count > 0)
        {
            txtFName.Text = Convert.ToString(Dt.Rows[0]["name"]);
            txtMName.Text = Convert.ToString(Dt.Rows[0]["mname"]);
            txtLName.Text = Convert.ToString(Dt.Rows[0]["lname"]);
            rdGender.SelectedValue = Convert.ToString(Dt.Rows[0]["gender"]);
            radiobuttonlistformanageotpodp.SelectedValue = Convert.ToString(Dt.Rows[0]["Otp_Or_OdpStatus"]);
            radioformailcheck.SelectedValue = Convert.ToString(Dt.Rows[0]["SendMail"]);
            radiobuttonforsmscheck.SelectedValue = Convert.ToString(Dt.Rows[0]["SendSms"]);
            if (Convert.ToString(Dt.Rows[0]["Otp_Or_OdpStatus"]) == "3")
            {
                divforsendemail.Style.Add("display", "none");
                divforsendsms.Style.Add("display", "none");
            }
            else
            {
                divforsendemail.Style.Add("display", "block");
                divforsendsms.Style.Add("display", "block");
            }
            txtemailaddress.Text = Convert.ToString(Dt.Rows[0]["mailid"]);
            txtmobile.Text = Convert.ToString(Dt.Rows[0]["mobileno"]);
            txtcountry.Text = Convert.ToString(Dt.Rows[0]["country"]);
            txtstate.Text = Convert.ToString(Dt.Rows[0]["state"]);
            txtcity.Text = Convert.ToString(Dt.Rows[0]["city"]);
            txtaddress.Text = Convert.ToString(Dt.Rows[0]["permamentAddress"]);
            txtPinCode.Text = Convert.ToString(Dt.Rows[0]["pincode"]);
            txtUserName.Text = Convert.ToString(Dt.Rows[0]["UserName"]);
            txtPass.Attributes.Add("value", Convert.ToString(Dt.Rows[0]["Password"]));
            txtPass.ToolTip = Convert.ToString(Dt.Rows[0]["Password"]);
            txtRePass.Attributes.Add("value", Convert.ToString(Dt.Rows[0]["Password"]));
            txtRePass.ToolTip = Convert.ToString(Dt.Rows[0]["Password"]);
            txtsponserid.Text = Convert.ToString(Dt.Rows[0]["Sponserid"]);
            if (Convert.ToInt32(Dt.Rows[0]["IsActive"]) == 1)
            {
                chkActive.Checked = true;
            }
            if (!string.IsNullOrEmpty(Dt.Rows[0]["photo"].ToString()))
            {
                ViewState["pic"] = Dt.Rows[0]["photo"].ToString();
                img.ImageUrl = "~/BranchPanel/images/" + ViewState["pic"].ToString();
            }
            else
            {
                ViewState["pic"] = null;
                img.ImageUrl = "~/images/9update.png";
            }
            if (Convert.ToInt32(Dt.Rows[0]["IsIpCheck"]) == 1)
            {
                string ContentForDivIp = "";
                string[] IpForCheck = Convert.ToString(Dt.Rows[0]["IpAdressForLogin"]).Split(',');
                for (int i = 0; i < IpForCheck.Length; i++)
                {
                    if (i == 0)
                    {
                        ContentForDivIp = ContentForDivIp + @"<div class='for_sigle_row_form'><label style='padding-top: 1px;'>
                                 Identify User By IP</label>
                                 <input type='text' class='txtipforlogin' placeholder='Enter The IP Adress Please'  value='" + Convert.ToString(IpForCheck[i]) + "' />" +
                                 "<input type='checkbox' class='chkforip' checked='checked' />" +
                                 "<img class='imgforaddip' alt='No Image' style='width: 16px; cursor: pointer; margin-top: -6px' src='../../images/add.png' /></div>";
                    }
                    else
                    {
                        ContentForDivIp = ContentForDivIp + @"<div class='for_sigle_row_form'><label style='padding-top: 1px;'>
                                 Identify User By IP</label>
                                 <input type='text' class='txtipforlogin' placeholder='Enter The IP Adress Please' value='" + Convert.ToString(IpForCheck[i]) + "' />" +
                                 "<img class='imgsubforip' alt='No Image' style='width: 16px; cursor: pointer; margin-top: -6px' src='../../images/minus.png' /></div>";
                    }
                }
                divforidentifyuserbyIp.InnerHtml = ContentForDivIp;
            }
            if (Convert.ToInt32(Dt.Rows[0]["IsMacCheck"]) == 1)
            {
                string ContentForDivMac = "";
                string[] MacForCheck = Convert.ToString(Dt.Rows[0]["MacAdressForLogin"]).Split(',');
                for (int i = 0; i < MacForCheck.Length; i++)
                {
                    if (i == 0)
                    {
                        ContentForDivMac = ContentForDivMac + @"<div class='for_sigle_row_form'><label style='padding-top: 1px;'>
                                 Identify User By MAC</label>
                                 <input type='text' class='txtmacforlogin' placeholder='Enter The MAC Adress Please' value='" + Convert.ToString(MacForCheck[i]) + "' />" +
                                " <input type='checkbox' class='chkformac' checked='checked' />" +
                                 "<img class='imgfroaddmac' alt='No Image' style='width: 16px; cursor: pointer; margin-top: -6px' src='../../images/add.png' /></div>";
                    }
                    else
                    {
                        ContentForDivMac = ContentForDivMac + @"<div class='for_sigle_row_form'><label style='padding-top: 1px;'>
                                 Identify User By MAC</label>
                                 <input type='text' class='txtmacforlogin' placeholder='Enter The MAC Adress Please'  value='" + Convert.ToString(MacForCheck[i]) + "' />" +
                                "<img class='imgsubformac' alt='No Image' style='width: 16px; cursor: pointer; margin-top: -6px' src='../../images/minus.png' /></div>";
                    }
                }

                divforidentifyuserbymac.InnerHtml = ContentForDivMac;
            }
            divforupdate.Style.Add("display", "none");
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        CreateOrUpdateUser(Convert.ToInt32(ViewState["usercode"]));
    }
    public void CreateOrUpdateUser(int eid)
    {
        string Fname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtFName.Text.Trim());
        string mname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtMName.Text.Trim());
        string lastname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtLName.Text.Trim());
        int limit = Convert.ToInt32(objDUT.GetScalar("select LIMITS from settings where sid=4"));
        SqlParameter[] param = new SqlParameter[32];
        param[0] = new SqlParameter("@EmployeeID", Convert.ToString(txtrefno.Text));
        param[1] = new SqlParameter("@Name", Fname);

        //This Code is used for upload image file
        if (fileuploadforpic.HasFile)
        {
            if (fileuploadforpic.PostedFile.ContentLength <= 5242880)
            {
                string fileexe = Path.GetExtension(fileuploadforpic.FileName);
                if (fileexe.ToUpper() == ".JPG" || fileexe.ToUpper() == ".JPEG" || fileexe.ToUpper() == ".PNG" || fileexe.ToUpper() == ".GIF")
                {
                    if (ViewState["pic"] != null)
                    {
                        File.Delete(Server.MapPath("~/BranchPanel/images/" + ViewState["pic"].ToString()));
                        finfoevent = new FileInfo(ViewState["pic"].ToString());
                        finfoevent.Delete();
                    }
                    int iLen = fileuploadforpic.PostedFile.ContentLength;
                    byte[] b = new byte[iLen];
                    fileuploadforpic.PostedFile.InputStream.Read(b, 0, iLen);
                    string Extension = Path.GetExtension(fileuploadforpic.FileName);
                    string FileName = Path.GetFileName(fileuploadforpic.PostedFile.FileName);
                    string pathforsaveimage = Server.MapPath(("~/BranchPanel/images/" + eid + FileName));
                    MasterImageUpload.CreateImage(b, FileName, Extension, pathforsaveimage);
                    param[2] = new SqlParameter("@photo", eid + FileName);
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Only image files can be uploaded!!!");
                    fileuploadforpic.Focus();
                    return;
                }
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "File size greater than 5 mb!!!");
                fileuploadforpic.Focus();
                return;
            }
        }
        else
        {
            if (ViewState["pic"] != null)
            {
                param[2] = new SqlParameter("@photo", ViewState["pic"].ToString());
            }
            else
            {
                param[2] = new SqlParameter("@photo", "");
            }
        }
        //--------End Here------------
        param[3] = new SqlParameter("@AssociatedToID", 0);
        param[4] = new SqlParameter("@EID", eid);
        param[5] = new SqlParameter("@UserName", txtUserName.Text.Trim());
        param[6] = new SqlParameter("@Password", txtPass.Text.Trim());
        param[7] = new SqlParameter("@RoleId", Convert.ToInt32(0));
        param[8] = new SqlParameter("@CreatedByID", Convert.ToInt32(((User)Session["BrUser"]).UserID));
        param[9] = new SqlParameter("@isActive", Convert.ToBoolean(chkActive.Checked));
        param[10] = new SqlParameter("@brID", SqlDbType.Int);
        if (Convert.ToInt32(Session["BrBrid"]) > 0)
        {
            param[10].Value = Convert.ToInt32(Session["BrBrid"]);
        }
        else
        { param[10].Value = 0; }

        param[11] = new SqlParameter("@intResult", SqlDbType.Int);
        param[11].Direction = ParameterDirection.Output;
        param[12] = new SqlParameter("@mobileno", txtmobile.Text.Trim());
        param[13] = new SqlParameter("@mailid", txtemailaddress.Text.Trim());
        param[14] = new SqlParameter("@address", txtaddress.Text.Trim());
        param[15] = new SqlParameter("@pincode", txtPinCode.Text.Trim());
        param[16] = new SqlParameter("@state", txtstate.Text.Trim());
        param[17] = new SqlParameter("@city", txtcity.Text.Trim());
        param[18] = new SqlParameter("@country", txtcountry.Text.Trim());
        param[19] = new SqlParameter("@phone", "");
        param[20] = new SqlParameter("@mname", mname);
        param[21] = new SqlParameter("@lname", lastname);
        param[22] = new SqlParameter("@gender", rdGender.SelectedValue);
        param[23] = new SqlParameter("@Otp_Or_OdpStatus", radiobuttonlistformanageotpodp.SelectedValue);
        if (radiobuttonlistformanageotpodp.SelectedValue == "3")
        {
            param[24] = new SqlParameter("@SendMail", "0");
            param[25] = new SqlParameter("@SendSms", "0");
        }
        else
        {
            param[24] = new SqlParameter("@SendMail", radioformailcheck.SelectedValue);
            param[25] = new SqlParameter("@SendSms", radiobuttonforsmscheck.SelectedValue);
        }
        param[26] = new SqlParameter("@Introducerid", Convert.ToInt32(Session["BrADID"]));
        int sponserid = Convert.ToInt32(objDUT.GetScalar("select userid from tbluser where username='" + txtsponserid.Text.Trim() + "'"));
        param[27] = new SqlParameter("@Sponserid", sponserid);

        string IpAdressForLogin = Request.Form[hfforipaddress.UniqueID];
        string MacAdressForLogin = Request.Form[hfformacaddress.UniqueID];
        if (IpAdressForLogin != "")
        {
            param[28] = new SqlParameter("@IpAdressForLogin", IpAdressForLogin.Trim());
            param[29] = new SqlParameter("@IsIpCheck", 1);
        }
        else
        {
            param[28] = new SqlParameter("@IpAdressForLogin", "");
            param[29] = new SqlParameter("@IsIpCheck", 0);
        }
        if (MacAdressForLogin != "")
        {
            param[30] = new SqlParameter("@MacAdressForLogin", MacAdressForLogin.Trim());
            param[31] = new SqlParameter("@IsMacCheck", 1);
        }
        else
        {
            param[30] = new SqlParameter("@MacAdressForLogin", "");
            param[31] = new SqlParameter("@IsMacCheck", 0);
        }

        result = objDUT.ExecuteSqlSP(param, "add_new_branch_user");

        if (result == 1)
        {
            sendsms();
            Emailsend();
            reset();
            ViewState["usercode"] = 0;
            if (Convert.ToInt32(Request.QueryString["mode"]) == 0)
            {
                Response.Redirect("branch-user-list.aspx");
            }
            else
            {
                Response.Redirect("../common/Default.aspx");
            }
        }
        else if (result == 2)
        {
            Utility.ViewAlertMessage(this, "User Already Exists.");
        }
        else if (result == 0)
        {
            Utility.ViewAlertMessage(this, "Some Error Occur While Inserting The Record");
        }
    }
    private void reset()
    {
        txtPass.Attributes.Add("value", "");
        txtRePass.Attributes.Add("value", "");
        txtcountry.Text = "";
        txtstate.Text = "";
        txtcity.Text = "";
        txtUserName.Text = "";
        txtFName.Text = "";
        txtMName.Text = "";
        txtLName.Text = "";
        txtmobile.Text = "";
        txtaddress.Text = "";
        txtemailaddress.Text = "";
        txtPinCode.Text = "";
        txtPass.Text = "";
        txtRePass.Text = "";
        chkActive.Checked = false;
    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        reset();
    }
    [WebMethod]
    public static GetUserDetails[] BindGridByJs(string RefNo)
    {
        string PreQuery = "select 1 from tbluser where EmployeeCode='" + RefNo + "'";
        string Query = @"select fName,mName,lName,gender,phone,mobile,emailAlloted,cid,sid,ctid,address,pinCode from tblEmp_Master where refNo='" + RefNo + "'";
        DataTable Dt = new DataTable();
        List<GetUserDetails> AppraisalDetails = new List<GetUserDetails>();
        DataUtility Objdut = new DataUtility();
        int returnresult = Convert.ToInt32(Objdut.GetScalar(PreQuery));
        if (returnresult != 1)
        {
            Dt = Objdut.GetDataTable(Query);
            if (Dt.Rows.Count > 0)
            {
                for (int i = 0; i < Dt.Rows.Count; i++)
                {
                    GetUserDetails user = new GetUserDetails();
                    user.fName = Convert.ToString(Dt.Rows[i]["fName"]);
                    user.mName = Convert.ToString(Dt.Rows[i]["mName"]);
                    user.lName = Convert.ToString(Dt.Rows[i]["lName"]);
                    user.gender = Convert.ToString(Dt.Rows[i]["gender"]);
                    user.phone = Convert.ToString(Dt.Rows[i]["phone"]);
                    user.mobile = Convert.ToString(Dt.Rows[i]["mobile"]);
                    user.emailID = Convert.ToString(Dt.Rows[i]["emailAlloted"]);
                    user.cid = Convert.ToString(Dt.Rows[i]["country"]);
                    user.sid = Convert.ToString(Dt.Rows[i]["state"]);
                    user.ctid = Convert.ToString(Dt.Rows[i]["city"]);
                    user.address = Convert.ToString(Dt.Rows[i]["address"]);
                    user.pinCode = Convert.ToString(Dt.Rows[i]["pinCode"]);
                    user.alreadyexists = "0";
                    AppraisalDetails.Add(user);
                }
            }
        }
        else
        {
            GetUserDetails user = new GetUserDetails();
            user.alreadyexists = "5";
            AppraisalDetails.Add(user);
        }
        return AppraisalDetails.ToArray();
    }
    public class GetUserDetails
    {
        public string fName { get; set; }

        public string mName { get; set; }

        public string lName { get; set; }

        public string gender { get; set; }

        public string phone { get; set; }

        public string mobile { get; set; }

        public string emailID { get; set; }

        public string cid { get; set; }

        public string sid { get; set; }

        public string ctid { get; set; }

        public string address { get; set; }

        public string pinCode { get; set; }

        public string alreadyexists { get; set; }
    }
    [WebMethod]
    public static int Checksponserno(string Sponserid)
    {
        string PreQuery = "select 1 from tbluser where username='" + Sponserid + "' and isactive=1";
        DataUtility Objdut = new DataUtility();
        int returnresult = Convert.ToInt32(Objdut.GetScalar(PreQuery));
        if (returnresult == 1)
        {
            SqlParameter[] paran = new SqlParameter[2];
            paran[0] = new SqlParameter("@userid", Convert.ToInt32(HttpContext.Current.Session["BrADID"]));
            paran[1] = new SqlParameter("@sponserid", Sponserid);
            int mainresult = Convert.ToInt32(Objdut.GetScalerSP(paran, "[ValidSponser]"));
            if (mainresult == 0)
                returnresult = 2;
            else
                returnresult = mainresult;
        }
        return returnresult;
    }
    public int sendsms()
    {
        //string name = (txtFName.Text.Trim() + "" + txtMName.Text.Trim() + "" + txtLName.Text.Trim()), mobile = txtmobile.Text.Trim();
        //try
        //{
        //    string message = "";
        //    int status = 0, apitype = 0;
        //    DataSet ds = new DataSet();
        //    DataUtility objdut = new DataUtility();
        //    SqlParameter[] param1 = new SqlParameter[3];
        //    param1[0] = new SqlParameter("@mode", 2);
        //    param1[1] = new SqlParameter("@permissionid", 7);
        //    param1[2] = new SqlParameter("@smsid", 9);
        //    ds = objdut.GetDataSetSP(param1, "[usp_Bindsmsdata]");
        //    if (ds.Tables[0].Rows.Count > 0)
        //    {
        //        System.Threading.Thread ThreadEmailMsgOnRegister = new System.Threading.Thread(delegate()
        //        {
        //            foreach (DataRow dtrow in ds.Tables[0].Rows)
        //            {
        //                status = Convert.ToInt32(dtrow["status"].ToString());
        //                message = ds.Tables[1].Rows[0]["message"].ToString();
        //                apitype = Convert.ToInt32(ds.Tables[1].Rows[0]["apitype"].ToString());
        //                if (status > 0)
        //                {
        //                    string[] apprymessage = message.Split('~');
        //                    int resultsms = sendMessageToMobile.SMSSend(mobile,apprymessage[0] + " " + name.ToString() + ", " + apprymessage[1], apitype);
        //                    if (resultsms > 0)
        //                    {
        //                        //int MaintainHistory = sendMessageToMobile.ManageSmsOrEmailHistory(message, mobile, "", 0, 1, Convert.ToInt32(HttpContext.Current.Session["BRADID"]), 1);
        //                    }
        //                }
        //            }
        //        });
        //        ThreadEmailMsgOnRegister.Start();
        //    }
        //}
        //catch
        //{
        //}
        return 1;
    }
    public int Emailsend()
    {
        string result = "";
        try
        {
            DataUtility objdut = new DataUtility();
            string email = txtemailaddress.Text.Trim();
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@mode", 9);
            param[1] = new SqlParameter("@emailsmsid", 9);
            DataTable dt = objdut.GetDataTableSP(param, "[usp_general_master_setting]");
            if (dt.Rows.Count > 0)
            {
                System.Threading.Thread ThreadEmailMsgOnRegister = new System.Threading.Thread(delegate()
                {
                    string message = dt.Rows[0]["message"].ToString();
                    string hostname = dt.Rows[0]["hostname"].ToString();
                    string emailh = dt.Rows[0]["emailh"].ToString();
                    string password = dt.Rows[0]["password"].ToString();
                    string subject = dt.Rows[0]["email_subject"].ToString();
                    int status = Convert.ToInt32(objDUT.GetScalar("select status from tbl_emailsettingcenter where emailid = 9"));
                    if (status > 0)
                    {
                        result = SendMail.SendDemo(emailh, email, "", "", subject, message, password, hostname);
                    }
                });
                ThreadEmailMsgOnRegister.Start();
            }
        }
        catch
        {
        }
        return 0;
    }
    [WebMethod]
    public static int checkUser(string userName, string eid)
    {
        DataUtility ObjDUT = new DataUtility();
        string q = "select COUNT(1) from tbluser where username= '" + userName + "' and eid!=" + eid;
        int count = Convert.ToInt32(ObjDUT.GetScalar(q));
        return count;
    }
    protected void lbtngotolist_Click(object sender, EventArgs e)
    {
        if (Convert.ToInt32(Request.QueryString["mode"]) == 0)
        {
            Response.Redirect("branch-user-list.aspx");
        }
        else
        {
            Response.Redirect("../common/Default.aspx");
        }
    }
}