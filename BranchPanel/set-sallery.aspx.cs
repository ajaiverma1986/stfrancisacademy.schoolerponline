using System;
using System.Data;

public partial class BranchPanel_set_sallery : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private double d;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["empid"] == null)
        {
            Response.Redirect("employee-list.aspx");
        }
        if (!IsPostBack)
        {
            ViewState["update"] = null;
            fillfaculty();
        }
    }

    private void fillfaculty()
    {
        dt = objdut.GetDataTable("select facname,amount,salarydesc from facultysalary_master where facid=" + Session["empid"]);
        if (dt.Rows.Count > 0)
        {
            txtemployeename.Text = dt.Rows[0]["facname"].ToString();
            txtsallerytype.Text = dt.Rows[0]["salarydesc"].ToString();
            txtsallery.Text = string.Format("{0:f}", dt.Rows[0]["amount"]);
            ViewState["update"] = true;
        }
        else
        {
            ViewState["update"] = false;
            txtemployeename.Text = Convert.ToString(objdut.GetScalar("select (fname+' '+mname+' '+lname) as Name from tblEmp_Master where eid=" + Session["empid"]));
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string query = "";
        int result = 0;
        if (Check())
        {
            if (!Convert.ToBoolean(ViewState["update"]))
            {
                query = @"insert into facultysalary_master (facid,facname,salarytype,salarydesc,amount,status)
                             values (" + Session["empid"] + ",'" + txtemployeename.Text + "'," + 1 + ",'" + txtsallerytype.Text + "'," + txtsallery.Text + ",1)";

                result = objdut.ExecuteSql(query);
            }
            else
            {
                query = "update facultysalary_master set amount=" + txtsallery.Text + " where facid=" + Session["empid"];
                result = objdut.ExecuteSql(query);
            }

            if (result > 0)
            {
                Response.Redirect("set-sallery.aspx");
            }
        }
    }

    private bool Check()
    {
        if (!double.TryParse(txtsallery.Text, out d))
        {
            Utility.ViewAlertMessage(Page, "please enter numeric value in salary.");
            txtsallery.Focus();
            return false;
        }
        return true;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("employee-list.aspx");
    }
}