using System;

public partial class BranchPanel_MasterFee : System.Web.UI.Page
{
    private string url, PageName;
    private Utility objut = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        PageName = Utility.GetCurrentPagename();
        if (!objut.isAccessible(((User)Session["BrUser"]).UserID, PageName))
        {
            Response.Redirect("~/Login.aspx");
        }
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        Response.Redirect("RecentFee.aspx");
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
        Response.Redirect("MonthWiseFee.aspx");
    }

    protected void btn3_Click(object sender, EventArgs e)
    {
        Response.Redirect("ClassFee.aspx");
    }

    protected void btn4_Click(object sender, EventArgs e)
    {
        Response.Redirect("FeeDuration.aspx");
    }

    protected void btn5_Click(object sender, EventArgs e)
    {
        Response.Redirect("getDistID.aspx?type=FSR");
    }
}