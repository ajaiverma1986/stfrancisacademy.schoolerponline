using System;
using System.Data;

public partial class BranchPanel_employee_panel : System.Web.UI.UserControl
{
    private string query = "", url = "";
    private DataUtility obJdut = new DataUtility();
    private DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["empid"] == null)
            {
                Response.Redirect("employee-list.aspx");
            }

            filldetail();
        }
    }

    private void filldetail()
    {
        string str = "select photo,jobTitle,mobile,department,(fname+' '+mName+' '+lname) as Name from tblEmp_Master where status=1 and brid=" + Convert.ToInt32(Session["BrBrid"]) + " and eid=" + Convert.ToInt32(Session["empid"]);
        dt = obJdut.GetDataTable(str);
        if (dt.Rows.Count > 0)
        {
            lblname.Text = dt.Rows[0]["Name"].ToString();
            lblmobile.Text = dt.Rows[0]["mobile"].ToString();
            lbldesignation.Text = dt.Rows[0]["jobTitle"].ToString();
            lbldepartment.Text = dt.Rows[0]["department"].ToString();
            if (dt.Rows[0]["photo"].ToString() != "")
            {
                imgstu.ImageUrl = "../../employeeimage/" + dt.Rows[0]["photo"].ToString();
            }
        }
    }
}