using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.Services;
using System.Web.UI;

public partial class BranchPanel_Common_SchoolProfile : System.Web.UI.Page
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
    protected void lbtngotolist_Click(object sender, EventArgs e)
    {
        Response.Redirect("../common/Default.aspx");
    }
}
   