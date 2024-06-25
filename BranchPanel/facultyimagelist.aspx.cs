using System;
using System.Data;

public partial class BranchPanel_facultyimagelist : System.Web.UI.Page
{
    private Utility objUT = new Utility();
    private DataUtility objDUT = new DataUtility();
    private string url = "", query, query2, query3, pp, PageName, pname, query4, query5;
    private DataTable dt;
    private string Classname = string.Empty;
    private string classid = string.Empty;
    private int count = 0, eid;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!IsPostBack)
        {
            bindgrid();
        }
    }

    public void bindgrid()
    {
        string srt = @"select  tm.fname,tm.mobile,(case tf.fname when '' then '~/images/9update.png' else
                      ('~/Teacherloginpanel/teacherdocument/'+tf.fname) end ) as photo,tf.fid from teacher_files tf join tblEmp_Master tm on tf.empid=tm.eid where tf.status=1 order by tf.fid desc";
        dt = objDUT.GetDataTable(srt);
        if (dt.Rows.Count > 0)
        {
            grdfiles.DataSource = dt;
            grdfiles.DataBind();
        }
        else
        {
            grdfiles.EmptyDataText = "No Record Found.!";
            grdfiles.DataBind();
        }
    }
}