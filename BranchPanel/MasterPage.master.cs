 using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;

public partial class AdminPanel_MasterPage : System.Web.UI.MasterPage
{
    private DataUtility objDUT = new DataUtility();
    private SqlParameter[] param = new SqlParameter[1];

    protected void Page_Init(object sender, EventArgs e)
    {
        //Session["BrBrid"]
        string imgsrc = HomeMasterPage.MasterMethod("BindLogo");
        if (imgsrc != "")
        {
            string[] data = imgsrc.Split('^');
            if (data.Length > 0)
            {
                logo.ImageUrl = "~/images/" + data[0];
                logo.Style.Add("background", data[1]);
                favicon.Href = "~/images/" + data[2];
            }
            else
            {
                logo.ImageUrl = "~/images/9update.png";
                favicon.Href = "~/images/9update.png";
            }
        }
        else
        {
            logo.ImageUrl = "~/images/9update.png";
            favicon.Href = "~/images/9update.png";
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        string imgsrc = "";
        if (Session["brbrid"] != null)
        {
            if (Session["BRADID"] != null)
            {
                imgsrc = Convert.ToString(objDUT.GetScalar("select photo from tblEmployee where eid =" + Session["BRADID"]));

                if (imgsrc != "")
                {
                    btnprofilelogin.ImageUrl = "images/" + imgsrc;
                    imgsrc = Server.MapPath("../images/" + imgsrc);
                }
                else
                {
                    btnprofilelogin.ImageUrl = "~/BranchPanel/images/9update.png";
                    imgsrc = "~/BranchPanel/images/9update.png";
                }

                string imgsrc1 = Convert.ToString(objDUT.GetScalar("select photo from Branch_master where brid=" + Session["BrBrid"]));
                if (imgsrc1 != "")
                {
                    logo.ImageUrl = "~/BranchPanel/images/" + imgsrc1;
                }
                else
                {
                    logo.ImageUrl = "~/BranchPanel/images/9update.png";
                }
            }
            else
            {
                btnprofilelogin.ImageUrl = "~/BranchPanel/images/9update.png";
                imgsrc = "~/BranchPanel/images/9update.png";
            }
        }
        if (Session["BrRoleID"] == null)
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
            Session["RootNodeBr"] = null;
            int fyid = Convert.ToInt32(objDUT.GetScalar("select fyid from financial_Year where isActive=1 and isClosed=0"));
            ViewState["fyid"] = fyid;
            lblAdmin.Text = Session["Brusername"].ToString();
            adprofile.HRef = "Common/SchoolProfile.aspx?eid=" + Session["BrADID"].ToString() + "&mode=1";
            divMenu.InnerHtml = RenderMenu(Session["BrADID"].ToString());
        }
    }

    /// <summary>
    /// This is For Generate Menu By User Id.
    /// </summary>
    public string RenderMenu(string userId)
    {
        StringBuilder content = new StringBuilder();
        content.AppendFormat(@"<ul class='nav'><li class='active'><a href='../Common/Default.aspx'><i class='fa fa-dashboard icon'><b class='bg-danger'></b>
                            </i><span>Dashboard</span></a></li>");
        DataTable dt = new DataTable();

        if (Session["RootNodeBr"] != null)
        {
            dt = (DataTable)Session["RootNodeBr"];
        }
        else
        {
            DataColumn[] dcPk = new DataColumn[1];

            SqlParameter[] RootParam = new SqlParameter[2];
            RootParam[0] = new SqlParameter("@UserID", userId);
            RootParam[1] = new SqlParameter("@QueryType", "GetMenuByUserId");
            dt = objDUT.GetDataSetSP(RootParam, "[uspLogin]").Tables[0];
            Session["RootNodeBr"] = dt;
        }

        IEnumerable query = from d in dt.AsEnumerable() where d.Field<int>("ParentId") == 0 select d;
        int count = 0;
        foreach (DataRow dr in query)
        {
            if (count != 0)
            {
                content.AppendFormat(@"<li><a href='#'><i class=""{0}""><b class=""{1}""></b></i><span class='pull-right'><i class='fa fa-angle-down text'>
                             </i><i class='fa fa-angle-up text-active'></i></span><span>{2}</span> </a><ul class='nav lt'>",
                             dr["imageurl"].ToString(), dr["MenuClass"].ToString(), dr["title"].ToString() + "");
                count++;
            }
            else
            {
                content.AppendFormat(@"<li><a href='#'><i class=""{0}""><b class=""{1}""></b></i><span class='pull-right'><i class='fa fa-angle-down text'>
                             </i><i class='fa fa-angle-up text-active'></i></span><span>{2}</span> </a><ul class='nav lt'>",
                            dr["imageurl"].ToString(), dr["MenuClass"].ToString(), dr["title"].ToString() + "");
            }
            IEnumerable childNode = from d in dt.AsEnumerable() where d.Field<int>("ParentId") == int.Parse(dr["id"].ToString()) select d;
            foreach (DataRow drChildNode in childNode)
            {
                string url = drChildNode["Url"].ToString();
                url = ResolveUrl(url);
                content.AppendFormat(@"<li><a href=""{0}""><i class='fa fa-angle-right'></i><span>{1}</span> </a></li>", url, drChildNode["title"].ToString());
            }
            content.AppendFormat(@"</ul></li>");
        }
        content.AppendFormat(@"</ul>");
        return content.ToString();
    }
}