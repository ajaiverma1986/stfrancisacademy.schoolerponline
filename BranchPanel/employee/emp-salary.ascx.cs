using System;
using System.Data;

public partial class HO_emp_salary : System.Web.UI.UserControl
{
    private DataTable dt;
    private string url = "";
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (Session["empidkhan"] == null)
        {
            Response.Redirect("emplist.aspx");
        }
        if (!IsPostBack)
        {
            filldetail();
        }
    }

    private void filldetail()
    {
        dt = objdut.GetDataTable(@"select(title+' '+fname+' '+mname+' '+lname) as name,mobile,photo,department,depid,designation,desigid,isnull(empcode,'') as empcode from OfficeEmployee_Master where eid=" + Convert.ToInt32(Session["empidkhan"]));

        if (dt.Rows.Count > 0)
        {
            lblname.Text = dt.Rows[0]["name"].ToString();
            lblmobile.Text = dt.Rows[0]["mobile"].ToString();
            lblempcode.Text = dt.Rows[0]["empcode"].ToString();
            if (string.IsNullOrEmpty(dt.Rows[0]["photo"].ToString()))
            {
                imgstu.ImageUrl = "~/images/9update.png";
            }
            else
            {
                imgstu.ImageUrl = "~/branchpanel/employee/EmpDocument/" + dt.Rows[0]["photo"].ToString();
            }

            if (dt.Rows[0]["depid"].ToString() == "0")
            {
                lbldept.Text = "N/A";
            }
            else
            {
                lbldept.Text = dt.Rows[0]["department"].ToString();
            }
            if (dt.Rows[0]["desigid"].ToString() == "0")
            {
                lbldesig.Text = "N/A";
            }
            else
            {
                lbldesig.Text = dt.Rows[0]["designation"].ToString();
            }
        }
    }

    protected void btnprofile_Click(object sender, EventArgs e)
    {
        Response.Redirect("emp-profile.aspx");
    }

    protected void btnEnrollment_Click(object sender, EventArgs e)
    {
        Response.Redirect("emp-performance.aspx?id=" + Session["empidkhan"] + "");
    }

    //protected void btnadmission_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("emp-pay.aspx");
    //}
    protected void btnadmission_Click(object sender, EventArgs e)
    {
        Response.Redirect("viewdetails.aspx");
    }
}