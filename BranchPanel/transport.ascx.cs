using System;

public partial class BranchPanel_transport : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnbus_Click(object sender, EventArgs e)
    {
        Response.Redirect("bustoroute.aspx");
    }

    protected void btnprofile_Click(object sender, EventArgs e)
    {
        Response.Redirect("Addarea.aspx");
    }
}