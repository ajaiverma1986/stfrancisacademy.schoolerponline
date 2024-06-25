using System;
using System.Data;

public partial class BranchPanel_advance_sallery : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["empid"] == null)
        {
            Response.Redirect("employee-list.aspx");
        }

        if (!IsPostBack)
        {
            string str = "select photo,jobTitle,mobile,department,(fname+' '+mName+' '+lname) as Name from tblEmp_Master where status=1 and brid=" + Convert.ToInt32(Session["BrBrid"]) + " and eid=" + Convert.ToInt32(Session["empid"]);
            DataTable dt = objdut.GetDataTable(str);
            if (dt.Rows.Count > 0)
            {
                txtempname.Text = dt.Rows[0]["Name"].ToString();
            }
        }
    }

    protected void btnpay_Click(object sender, EventArgs e)
    {
    }
}