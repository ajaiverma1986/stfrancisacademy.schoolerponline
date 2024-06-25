using System;

public partial class EmployeePanel_employee_panel_master : System.Web.UI.MasterPage
{
    private DataUtility objDUT = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["eid"] == null)
        {
            Response.Redirect("~/emp-login.aspx");
        }
        else
        {
            string imgsrc = "";
            if (Session["brbrid"] != null)
            {
                string imgsrc1 = Convert.ToString(objDUT.GetScalar("select photo from Branch_master where brid=" + Session["BrBrid"]));
                if (imgsrc1 != "")
                {
                    imgPP.ImageUrl = "~/BranchPanel/images/" + imgsrc1;
                }
                else
                {
                    imgPP.ImageUrl = "~/BranchPanel/images/9update.png";
                }
            }
            else
            {
                imgPP.ImageUrl = "~/BranchPanel/images/9update.png";
            }
        }
    }
}