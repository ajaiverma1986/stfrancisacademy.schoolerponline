using System;

public partial class BranchPanel_MasterTime : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();
    private CommonClass CommonClass = new CommonClass();
    private Utility objUT = new Utility();
    private string PageName = "", url = "", type;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        PageName = Utility.GetCurrentPagename();
        if (!objUT.isAccessible(((User)Session["BrUser"]).UserID, PageName))
        {
            Response.Redirect("~/Login.aspx");
        }
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        Response.Redirect("classschedule.aspx");
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
        Response.Redirect("teacherschedule.aspx");
    }
}