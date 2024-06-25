using System;
using System.Web.Security;
using System.Web.UI;

public partial class ParentPanel_MasterPage : System.Web.UI.MasterPage
{
    private DataUtility objDUT = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["ADID4"] == null)
        {
            Response.Redirect("~/LoginP.aspx");
        }
        else
        {
            Response.ClearHeaders();
            Response.AddHeader("Cache-Control", "no-cache, no-store, max-age=0, must-revalidate");
            Response.AddHeader("Pragma", "no-cache");
            //lblUserName.Text = Convert.ToString(Session["UserName"]);
        }
        if (!Page.IsPostBack)
        {
            lbluser.Text = Session["loginidp"].ToString();
            filname();
            //divMenu.InnerHtml = RenderMenu(Session["ADID"].ToString());
        }
    }

    private void filname()
    {
        string name = Convert.ToString(objDUT.GetScalar("select isnull(FirstName,'') from student_master sm left join tbl_Admission ta on sm.sturegno=ta.sturegno where adid=" + Session["ADID4"] + " and sm.status=1"));
        lbname.Text = "Welcome-'" + name + "'";
    }

    protected void lbkInbox_Click(object sender, EventArgs e)
    {
    }

    protected void lnkMyHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/ParentPanel/Default.aspx");
    }

    protected void lnklogout_Click(object sender, EventArgs e)
    {
        Session.Remove("stregno");
        Session.Remove("ADID4");
        Session.Remove("Branchid");
        Session.Remove("transptype");
        Session.Remove("loginidp");
        Session.Remove("LLogin");
        Session.Remove("empid");
        Session.Remove("loginid");
        Session.Remove("brid1");

        // Session.RemoveAll();
        // Session.Abandon();
        FormsAuthentication.SignOut();
        Response.Redirect("~/LoginP.aspx");
    }

    //public string RenderMenu(string userId)
    //{
    //    StringBuilder content = new StringBuilder();
    //    content.AppendFormat(@"<div style=""float: left"" id=""my_menu1"" class=""{0}"">", "sdmenu");
    //    DataTable dt = new DataTable();
    //    string Menuquery = "select * from tblmenu_Parent where isactive=1 order by id";
    //    dt = objDUT.GetDataTable(Menuquery);
    //    Session["RootNode"] = dt;
    //    IEnumerable query = from d in dt.AsEnumerable() where d.Field<int>("ParentId") == 0 select d;
    //    int count = 0;
    //    foreach (DataRow dr in query)
    //    {
    //        if (count != 0)
    //        {
    //            content.AppendFormat(@"<div class=""""><span>{0}</span>", dr["title"].ToString());
    //            count++;
    //        }
    //        else
    //        {
    //            content.AppendFormat(@"<div class=""collapsed""><span>{0}</span>", dr["title"].ToString());
    //        }
    //        IEnumerable childNode = from d in dt.AsEnumerable() where d.Field<int>("ParentId") == int.Parse(dr["id"].ToString()) select d;
    //        foreach (DataRow drChildNode in childNode)
    //        {
    //            string url = drChildNode["Url"].ToString();
    //            url = ResolveUrl(url);
    //            content.AppendFormat(@"<a href=""{0}"">{1}</a>", url, drChildNode["title"].ToString());
    //        }
    //        content.AppendFormat(@"</div>");
    //    }
    //    content.AppendFormat(@"</div>");
    //    return content.ToString();
    //}
}