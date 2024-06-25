using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Teacherpanel_ExamUtility : System.Web.UI.Page
{
    private string query;
    private DataTable dt;
    private DataUtility objdut = new DataUtility();
    private string url = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["eid"] == null)
        {
            Response.Redirect("~/Teacher-Login.aspx?redirectUrl=" + url);
        }
        if (!IsPostBack)
        {
            Exam_Sechudle();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("createtest.aspx");
    }

    protected void gridenquiry_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int examid = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "ed")
        {
            if (examid > 1)
            {
                int finalexamid = examid - 1;
                int status = Convert.ToInt32(objdut.GetScalar("select distinct ExamStatus from exam_SchemReport where eid=" + finalexamid + " and brid=" + Convert.ToInt64(Session["BrBrid"]) + " and status=1"));
                if (status == 1)
                {
                }
                else
                {
                    Utility.ViewAlertMessage(Page, "You can not set marks for this session");

                    return;
                }
            }

            Response.Redirect("setmarks.aspx?eid=" + examid);
        }

        if (e.CommandName == "marksdetails")
        {
            Response.Redirect("setmarks.aspx?eid=" + examid + "&type=conducted");
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        DataTable dy;

        if (ddlEnquirySource.SelectedIndex == 1)
        {
            dy = CommonClass.examMaster("examstatus", Convert.ToInt32(Session["BrBrid"]));
            if (dy.Rows.Count > 0)
            {
                gridenquiry.DataSource = dy;
                gridenquiry.DataBind();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No test Conducted!");
                return;
            }
        }
        else
        {
            dy = CommonClass.examMaster("examstatuspendind", Convert.ToInt32(Session["BrBrid"]));
            if (dy.Rows.Count > 0)
            {
                gridenquiry.DataSource = dy;
                gridenquiry.DataBind();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No test Pending!");
                return;
            }
        }
    }

    protected void btnAdd_Click1(object sender, EventArgs e)
    {
        Response.Redirect("examsession.aspx");
    }

    protected void btnAdd_Click2(object sender, EventArgs e)
    {
        Response.Redirect("room-allotment.aspx");
    }

    protected void btnAdd_Click3(object sender, EventArgs e)
    {
        Response.Redirect("exam-report.aspx");
    }

    protected void ddlEnquirySource_SelectedIndexChanged(object sender, EventArgs e)
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@status", SqlDbType.Int);
        param[0].Value = Convert.ToInt32(ddlEnquirySource.SelectedValue);
        param[1] = new SqlParameter("@mode", SqlDbType.Int);
        param[1].Value = 1;
        DataTable dt = objdut.GetDataTableSP(param, "[dbo].[usp_Exam_sechudle]");
        gridenquiry.DataSource = dt;
        gridenquiry.DataBind();
    }

    protected void btnsetmarks_Click(object sender, EventArgs e)
    {
        Response.Redirect("set-marks.aspx");
    }

    protected void Exam_Sechudle()
    {
        DataTable gridexamsechudlereport = objdut.GetDataTableSP("[dbo].[usp_Exam_sechudle]");
        gridenquiry.DataSource = gridexamsechudlereport;
        gridenquiry.DataBind();
    }

    protected void gridenquiry_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton lnkstatus = e.Row.FindControl("lbtnstatus") as LinkButton;
            LinkButton lnktestname = e.Row.FindControl("lbltestname") as LinkButton;

            if (lnkstatus.Text == "Not Conducted")
            {
                lnkstatus.ForeColor = System.Drawing.Color.Black;
                lnkstatus.Enabled = false;
            }
            if (lnkstatus.Text == "Conducted")
            {
                lnktestname.ForeColor = System.Drawing.Color.Black;
                lnktestname.Enabled = false;
            }
        }
    }
    protected void Button5_Click(object sender, EventArgs e)
    {
        Response.Redirect("Co-Schoolistic.aspx");
    }
    protected void Button6_Click(object sender, EventArgs e)
    {
        Response.Redirect("ViewResult.aspx");
    }
}