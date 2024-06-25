using System;

public partial class BranchPanel_feereport : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnreport_Click(object sender, EventArgs e)
    {
        Response.Redirect("stufeereport.aspx");
    }
}