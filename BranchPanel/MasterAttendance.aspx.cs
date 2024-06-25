using System;

public partial class BranchPanel_MasterAttendance : System.Web.UI.Page
{
    private string PageName = "", url = "";
    private Utility objUT = new Utility();

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
        Response.Redirect("DaywiseAttendence.aspx");
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
        Response.Redirect("AttendanceReport2.aspx");
    }

    protected void btn3_Click(object sender, EventArgs e)
    {
        Response.Redirect("StudentReport.aspx");
    }
}