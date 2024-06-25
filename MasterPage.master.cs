using System;
using System.IO;
using System.Web;
using System.Web.Security;

public partial class AdminPanel_MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Init(object sender, EventArgs e)    
    {
        string imgsrc = HomeMasterPage.MasterMethod("BindLogo");
        if (imgsrc != "")
        {
            string[] data = imgsrc.Split('^');
            if (data.Length > 0)
            {
                logo.ImageUrl = "images/" + data[0];
                logobgcolor.Style.Add("background", data[1]);
                favicon.Href = "images/" + data[2];
            }
            else
            {
                logo.ImageUrl = "images/icons/login_icon_1.gif";
                favicon.Href = "images/icons/login_icon_1.gif";
            }
        }
        else
        {
            logo.ImageUrl = "images/icons/login_icon_1.gif";
            favicon.Href = "images/icons/login_icon_1.gif";
        }        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //try
        //{
        //    string[] pagename = HttpContext.Current.Request.RawUrl.ToLower().Split('/');
        //    int arraylength = pagename.Length;
        //    string pageurl = pagename[arraylength - 1];
        //    if (HttpContext.Current.Request.UrlReferrer == null)
        //    {
        //        Response.Redirect("~/login.aspx");
        //    }
        //}
        //catch
        //{
        //}
        if (Session["ADID"] != null)
        {
            DataUtility objDUT = new DataUtility();
            string imgsrc = Convert.ToString(HomeMasterPage.MasterMethod("UserImage", Convert.ToString(Session["ADID"])));
            btnprofilelogin.ImageUrl = "BranchPanel/images/" + imgsrc;
            imgsrc = Server.MapPath("../images/" + imgsrc);
            FileInfo file = new FileInfo(imgsrc);
            if (imgsrc == "")
            {
                btnprofilelogin.ImageUrl = "images/faculty-icon.png";
            }
        }
        if (Session["RoleID"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        else
        {
            Response.ClearHeaders();
            Response.AddHeader("Cache-Control", "no-cache, no-store, max-age=0, must-revalidate");
            Response.AddHeader("Pragma", "no-cache");
        }
        if (!Page.IsPostBack)
        {
            HttpContext.Current.Session["RootNode"] = null;
            HomeMasterPage HMP = new HomeMasterPage();
            divMenu.InnerHtml = HMP.RenderMenu(Session["ADID"].ToString());
            lblAdmin.Text = Convert.ToString(Session["avatar.jpg"]);
            if (Session[""] == null)
            {
                lblAdmin.Text = (Convert.ToString(Session["Brusername"]));
            }
            int fyid = 0;
            if (HomeMasterPage.MasterMethod("GetActiveFinancialYear") != "")
            {
                fyid = Convert.ToInt32(HomeMasterPage.MasterMethod("GetActiveFinancialYear"));
            }            
            ViewState["fyid"] = fyid;
            BindUserDetails();
        }
    }

    protected void BindUserDetails()
    {
        lblAdmin.Text = Session["username"].ToString();
        adprofile.HRef = "Ho/add-ho-user.aspx?eid=" + Session["ADID"].ToString() + "&mode=1";
    }

    protected void lnkMyHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Common/Default.aspx");
    }

    protected void lnkLogOut_Click(object sender, EventArgs e)
    {
        Session.RemoveAll();
        Session.Abandon();
        FormsAuthentication.SignOut();
        Response.Redirect("~/login.aspx");
    }
}