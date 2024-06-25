using System;
using System.Data;

public partial class branchpanel_employee_password_request : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private string url = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        if (!IsPostBack)
        {
            getleaveslist();
        }
    }

    private void getleaveslist()
    {
        string qery = @"select username,empname,password,contact_number,email_address from tbl_resetpass";
        DataTable dt = objdut.GetDataTable(qery);
        gvleavedetails.DataSource = dt;
        gvleavedetails.DataBind();
    }

    protected void gvleavedetails_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        gvleavedetails.PageIndex = e.NewPageIndex;
        getleaveslist();
    }
}