using System;
using System.Data;

public partial class facultypath : System.Web.UI.UserControl
{
    private string query = "", url = "";
    private DataUtility obJdut = new DataUtility();
    private DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!IsPostBack)
        {
            filldetail();
        }
    }

    private void filldetail()
    {
        string str = "select mobile,(fName+' '+isnull(mName,'')+''+lName) as name,photo from tblEmp_Master where brid=" + Convert.ToInt16(Session["BrBrid"]) + " and status=1 and eid=" + Session["facID"];
        DataTable dt = obJdut.GetDataTable(str);
        lblname.Text = dt.Rows[0]["name"].ToString();
        lblmobile.Text = dt.Rows[0]["mobile"].ToString();
        if (string.IsNullOrEmpty(dt.Rows[0]["photo"].ToString()))
        {
            imgstu.ImageUrl = "~/images/9update.png";
        }
        else
        {
            imgstu.ImageUrl = "~/facultyimage/" + dt.Rows[0]["photo"].ToString();
        }
    }
}