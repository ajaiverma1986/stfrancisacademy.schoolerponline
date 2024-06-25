using System;

public partial class BranchPanel_advance_sallery : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["empid"] == null)
        {
            Response.Redirect("employee-list.aspx");
        }

        if (!IsPostBack)
        {
        }
    }

    protected void btnpay_Click(object sender, EventArgs e)
    {
    }
}