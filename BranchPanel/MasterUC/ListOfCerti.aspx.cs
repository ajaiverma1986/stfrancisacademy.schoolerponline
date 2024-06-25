using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_MasterUC_ListOfCerti : System.Web.UI.Page
{
    int RID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["RID"] != null)
        {
            RID = Convert.ToInt32(Request.QueryString["RID"]);
            GetCert(RID);
        }
    }
    public void GetCert(int RID)
    {
        Cert1.HRef = "../Certificates/BonafideCert.aspx?RID=" + RID;
        Cert2.HRef = "../Student-Registration/AddCertificate.aspx?RID=" + RID;
        Cert3.HRef = "../Certificates/characterCertt.aspx?RID=" + RID;
        Cert3.HRef = "../Certificates/characterCertt.aspx?RID=" + RID;
        Cert5.HRef = "../Certificates/CharacterCertificate.aspx?RID=" + RID;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BranchPanel/MasterUC/mst_Certificates.aspx");
    }
}

      