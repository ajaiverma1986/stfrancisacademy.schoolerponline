using System;
using System.Data;

public partial class BranchPanel_Exam_exam : System.Web.UI.UserControl
{
    private DataUtility objDut = new DataUtility();
    private DataTable dt;
    private string url = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (Session["tid"] == null)
        {
            Response.Redirect("testlist.aspx");
        }
        if (!IsPostBack)
        {
            int show = Convert.ToInt32(objDut.GetScalar(" select  count(*) from tbl_StudentExamAttendance where testid=" + Session["tid"]));

            if (show == 0)
            {
                hidebutton();
            }
            dt = CommonClass.examMaster("examus", Convert.ToInt32(Session["tid"]), Convert.ToInt32(Session["BrBrid"]));
            if (dt.Rows.Count > 0)
            {
                lblsub.Text = dt.Rows[0]["subname"].ToString();
                lbldate.Text = dt.Rows[0]["testdate"].ToString();
                lblmax.Text = dt.Rows[0]["Totalmarks"].ToString();
                lblmin.Text = dt.Rows[0]["passingMarks"].ToString();
                //lblroll.Text = dt.Rows[0]["batchname"].ToString();
                lblall.Text = dt.Rows[0]["ss"].ToString();
            }
        }
    }

    private void hidebutton()
    {
        Marklist.Visible = false;
        btnreport.Visible = false;
    }

    protected void btnSchedules_Click(object sender, EventArgs e)
    {
        Response.Redirect("stuexammaster.aspx");
    }

    protected void btnStudents_Click(object sender, EventArgs e)
    {
        Response.Redirect("mark-attndnce.aspx");
    }

    protected void btnTopics_Click(object sender, EventArgs e)
    {
        Response.Redirect("markslist.aspx");
    }

    protected void btnTopics1_Click(object sender, EventArgs e)
    {
        Response.Redirect("studentmarkreport.aspx");
    }
}