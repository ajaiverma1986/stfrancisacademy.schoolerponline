using System;

public partial class AdminPanel_dashboard : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private Utility objut = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["User"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        PageName = Utility.GetCurrentPagename();

        if (!objut.isAccessible(((User)Session["User"]).UserID, PageName))
        {
            Response.Redirect("~/Login.aspx");
        }
    }
}