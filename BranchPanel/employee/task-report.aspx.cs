using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class branchpanel_employee_task_report : System.Web.UI.Page
{
    private string url, query, query1;
    private DataTable dt;
    private DataUtility objdut = new DataUtility();
    private int emptype = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["empid"] == null)
        {
            Response.Redirect("employee-list.aspx");
        }
        if (!IsPostBack)
        {
            //fillinfo();
        }
    }

    protected void fillinfo()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@eid", Session["empid"]);
        DataTable dt = objdut.GetDataTableSP(param, "[usp_tasksearch]");
        if (dt.Rows.Count > 0)
        {
            gvdetails.DataSource = dt;
            gvdetails.DataBind();
        }
        else
        {
            gvdetails.EmptyDataText = "No task report found.";
            gvdetails.DataBind();
        }
    }

    protected void gvdetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
        HiddenField hf1 = row.FindControl("hf1") as HiddenField;
        string emp = e.CommandArgument.ToString();
        string[] chkcommand = e.CommandArgument.ToString().Split(new char[] { ',' });
        string name = chkcommand[0].ToString();
        int taskid = Convert.ToInt32(chkcommand[1]);
        if (e.CommandName == "accept")
        {
            Response.Redirect("taskconversation.aspx?empname=" + name.ToString() + "&tid=" + taskid);
        }
    }

    protected void gvdetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label totaltime = e.Row.FindControl("lnkgettotaltime") as Label;
            string a = totaltime.Text;
            LinkButton AddComment = e.Row.FindControl("lkaccept") as LinkButton;
            if (totaltime.Text != "--")
            {
                AddComment.Text = "Completed";
                AddComment.ForeColor = System.Drawing.Color.Green;
                //AddComment.Enabled = false;
            }
            else
            {
                AddComment.Visible = true;
            }
        }
    }
}