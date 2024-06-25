using System;

public partial class BranchPanel_admissioncontrol : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnstudentlist_Click(object sender, EventArgs e)
    {
        Response.Redirect("studentadmissionlistaspx.aspx");
    }

    protected void btnadmission_Click(object sender, EventArgs e)
    {
        Response.Redirect("student-admission-form.aspx");
    }
}