using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.Services;
using System.Web.UI;

public partial class HO_add_ho_user : System.Web.UI.Page
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
                    int Branchid = Convert.ToInt32(Request.QueryString[0]);
                    ViewState["usercode"] = Branchid;
                    fillField(Branchid);
                    if (Convert.ToInt32(Request.QueryString["mode"]) > 0)
                    {
                        divforradio.Visible = false;
                        divforidentifyuserbyIp.Visible = false;
                        divforidentifyuserbymac.Visible = false;
                        divforactive.Visible = false;
                    }
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

    public void fillField(int Branchid)
    {
        DataTable Dt = new DataTable();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@BranchId", Branchid);
        Dt = objDUT.GetDataTableSP(param, "[usp_gethouserdetails]");
        if (Dt.Rows.Count > 0)
        {
            ViewState["employeecode"] = Convert.ToString(Dt.Rows[0]["EmployeeCode"]);
            txtcontactpersonname.Text = Convert.ToString(Dt.Rows[0]["Name"]);
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
            txtmobile.Text = Convert.ToString(Dt.Rows[0]["MobileNo"]);
            txtcountry.Text = Convert.ToString(Dt.Rows[0]["country"]);
            txtstate.Text = Convert.ToString(Dt.Rows[0]["state"]);
            txtcity.Text = Convert.ToString(Dt.Rows[0]["city"]);
            txtaddress.Text = Convert.ToString(Dt.Rows[0]["permamentAddress"]);
            txtPinCode.Text = Convert.ToString(Dt.Rows[0]["pincode"]);
            txtUserName.Text = Convert.ToString(Dt.Rows[0]["UserName"]);
            txtPass.Attributes.Add("value", Convert.ToString(Dt.Rows[0]["Password"]));
            txtPass.ToolTip = Convert.ToString(Dt.Rows[0]["password"]);
            txtRePass.Attributes.Add("value", Convert.ToString(Dt.Rows[0]["Password"]));
            txtRePass.ToolTip = Convert.ToString(Dt.Rows[0]["password"]);
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
                                 "<img class='imgforaddip' alt='No Image' style='width: 16px; cursor: pointer; margin-top: -6px' src='../images/add.png' /></div>";
                    }
                    else
                    {
                        ContentForDivIp = ContentForDivIp + @"<div class='for_sigle_row_form'><label style='padding-top: 1px;'>
                                 Identify User By IP</label>
                                 <input type='text' class='txtipforlogin' placeholder='Enter The IP Adress Please' value='" + Convert.ToString(IpForCheck[i]) + "' />" +
                                 "<img class='imgsubforip' alt='No Image' style='width: 16px; cursor: pointer; margin-top: -6px' src='../images/minus.png' /></div>";
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
                                 "<img class='imgfroaddmac' alt='No Image' style='width: 16px; cursor: pointer; margin-top: -6px' src='../images/add.png' /></div>";
                    }
                    else
                    {
                        ContentForDivMac = ContentForDivMac + @"<div class='for_sigle_row_form'><label style='padding-top: 1px;'>
                                 Identify User By MAC</label>
                                 <input type='text' class='txtmacforlogin' placeholder='Enter The MAC Adress Please'  value='" + Convert.ToString(MacForCheck[i]) + "' />" +
                                "<img class='imgsubformac' alt='No Image' style='width: 16px; cursor: pointer; margin-top: -6px' src='../images/minus.png' /></div>";
                    }
                }

                divforidentifyuserbymac.InnerHtml = ContentForDivMac;
            }
        }
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        CreateOrUpdateUser(Convert.ToInt32(ViewState["usercode"]));
    }

    public void CreateOrUpdateUser(int eid)
    {
        int limit = Convert.ToInt32(objDUT.GetScalar("select LIMITS from settings where sid=4"));
        SqlParameter[] param = new SqlParameter[23];
        param[0] = new SqlParameter("@Contactpersonname", txtcontactpersonname.Text.Trim());
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
                    param[1] = new SqlParameter("@photo", eid + FileName);
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
                param[1] = new SqlParameter("@photo", ViewState["pic"].ToString());
            }
            else
            {
                param[1] = new SqlParameter("@photo", "");
            }
        }
        //--------End Here------------

        param[2] = new SqlParameter("@phoneno", "");
        param[3] = new SqlParameter("@mobileno", txtmobile.Text.Trim());
        param[4] = new SqlParameter("@mailid", txtemailaddress.Text.Trim());
        param[5] = new SqlParameter("@country", txtcountry.Text.Trim());
        param[6] = new SqlParameter("@state", txtstate.Text.Trim());
        param[7] = new SqlParameter("@city", txtcity.Text.Trim());
        param[8] = new SqlParameter("@Adress", txtaddress.Text.Trim());
        param[9] = new SqlParameter("@pincode", txtPinCode.Text.Trim());
        param[10] = new SqlParameter("@loginid", txtUserName.Text.Trim());
        param[11] = new SqlParameter("@password", txtPass.Text.Trim());
        param[12] = new SqlParameter("@Dualauthentication", radiobuttonlistformanageotpodp.SelectedValue);
        if (radiobuttonlistformanageotpodp.SelectedValue == "3")
        {
            param[13] = new SqlParameter("@Sendmail", "0");
            param[14] = new SqlParameter("@sendmessage", "0");
        }
        else
        {
            param[13] = new SqlParameter("@Sendmail", radioformailcheck.SelectedValue);
            param[14] = new SqlParameter("@sendmessage", radiobuttonforsmscheck.SelectedValue);
        }
        if (Convert.ToBoolean(chkActive.Checked) == true)
        {
            param[15] = new SqlParameter("@Status", 1);
        }
        else
        {
            param[15] = new SqlParameter("@Status", 0);
        }
        if (Request.QueryString.Count > 0)
        {
            param[16] = new SqlParameter("@mode", 2);
            param[17] = new SqlParameter("@EmployeeCodeForUpdate", Convert.ToString(ViewState["employeecode"]));
        }
        else
        {
            param[16] = new SqlParameter("@mode", 1);
            param[17] = new SqlParameter("@EmployeeCodeForUpdate", "");
        }
        string IpAdressForLogin = Request.Form[hfforipaddress.UniqueID];
        string MacAdressForLogin = Request.Form[hfformacaddress.UniqueID];
        if (IpAdressForLogin != "")
        {
            param[18] = new SqlParameter("@IpAdressForLogin", IpAdressForLogin.Trim());
            param[19] = new SqlParameter("@IsIpCheck", 1);
        }
        else
        {
            param[18] = new SqlParameter("@IpAdressForLogin", "");
            param[19] = new SqlParameter("@IsIpCheck", 0);
        }
        if (MacAdressForLogin != "")
        {
            param[20] = new SqlParameter("@MacAdressForLogin", MacAdressForLogin.Trim());
            param[21] = new SqlParameter("@IsMacCheck", 1);
        }
        else
        {
            param[20] = new SqlParameter("@MacAdressForLogin", "");
            param[21] = new SqlParameter("@IsMacCheck", 0);
        }
        param[22] = new SqlParameter("@intResult", SqlDbType.Int);
        param[22].Direction = ParameterDirection.Output;
        result = objDUT.ExecuteSqlSP(param, "add_new_houser");
        if (result == 1)
        {
            reset();
            ViewState["usercode"] = 0;
            ViewState["employeecode"] = "";
            Response.Redirect("ho-user-list.aspx");
        }
        else if (result == 2)
        {
            Utility.ViewAlertMessage(this, "User Already Exists.");
        }
        else if (result == 3)
        {
            if (Convert.ToInt32(Request.QueryString["mode"]) == 0)
            {
                Response.Redirect("ho-user-list.aspx");
            }
            else
            {
                Response.Redirect("../Common/Default.aspx");
            }
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
        txtUserName.Text = "";
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
    public static int checkUser(string userName, string eid)
    {
        DataUtility ObjDUT = new DataUtility();
        string q = "select COUNT(1) from tbluser where username= '" + userName + "' and isdeleted=0 and eid!=" + eid;
        int count = Convert.ToInt32(ObjDUT.GetScalar(q));
        return count;
    }

    protected void lbtngotolist_Click(object sender, EventArgs e)
    {
        if (Convert.ToInt32(Request.QueryString["mode"]) == 0)
        {
            Response.Redirect("ho-user-list.aspx");
        }
        else
        {
            Response.Redirect("../Common/Default.aspx");
        }
    }
}