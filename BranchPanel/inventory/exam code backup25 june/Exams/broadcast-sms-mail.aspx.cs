using System;

public partial class BranchPanel_Exams_broadcast_sms_mail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["tid"] == null)
        {
            Response.Redirect("testlist.aspx");
        }
    }
}