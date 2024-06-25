using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_enquiry_enquiry : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
         if (Convert.ToInt32(Session["BrRoleID"]) != 3)
        {
          //btnatten.Visible = false;
        }
    }
}