using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_Exams_exam_edit : System.Web.UI.Page
{
    private DataUtility objDut = new DataUtility();
    private DataTable dt, dt_class, dt_t, dt_sub, dt1;
    private string query = "", url = "";
    private string batchid = "", topicid = "";

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
            filltestname();
            filltestdetails();
            fillMultipleschedule();
        }
    }

    private void filltestname()
    {
        dt_t = CommonClass.examMaster("testmaster");
        if (dt_t.Rows.Count > 0)
        {
            ddltest.DataValueField = "testid";
            ddltest.DataTextField = "testname";
            ddltest.DataSource = dt_t;
            ddltest.DataBind();
            ddltest.Items.Insert(0, new ListItem("--Select Test", "0"));
        }

        dt1 = CommonClass.examMaster("classdll");
        if (dt1.Rows.Count > 0)
        {
            ddlcourse.DataSource = dt1;
            ddlcourse.DataTextField = "Classname";
            ddlcourse.DataValueField = "ID";
            ddlcourse.DataBind();
            ddlcourse.Items.Insert(0, new ListItem("--Select Class--", "0"));
            ddlsubject.Items.Insert(0, new ListItem("--Select Subject--", "0"));
        }
    }

    private void fillclass(int a)
    {
    }

    private void fillsubject(int courseID)
    {
        DataTable dts = CommonClass.examMaster("coursedll", courseID);
        if (dts.Rows.Count > 0)
        {
            ddlsubject.DataSource = dts;
            ddlsubject.DataTextField = "subjectname";
            ddlsubject.DataValueField = "subjectid";
            ddlsubject.DataBind();
            ddlsubject.Items.Insert(0, new ListItem("--Select Subject--", "0"));
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "No subject for this course has been added.");
            ddlcourse.SelectedValue = "0";
            //l1.Visible = true;
            return;
        }
    }

    private void filltestdetails()
    {
        dt = CommonClass.examMaster("testdetail1", Convert.ToInt32(Session["tid"]));

        if (dt.Rows.Count > 0)
        {
            ddltest.SelectedValue = dt.Rows[0]["testmasterid"].ToString();
            ddlcourse.SelectedValue = dt.Rows[0]["classid"].ToString();
            ddlftime.SelectedIndex = Convert.ToInt16(dt.Rows[0]["testime1id"].ToString());
            ddltotime.SelectedIndex = Convert.ToInt16(dt.Rows[0]["testime2id"].ToString());
            fillclass(Convert.ToInt32(ddlcourse.SelectedValue));
            txtToDate.Text = Convert.ToDateTime(dt.Rows[0]["testdate"]).ToString("MM/dd/yyyy");
            txtmarksp.Text = dt.Rows[0]["passingmarks"].ToString();
            txttotalmarks.Text = dt.Rows[0]["totalmarks"].ToString();
            ddlsubject.SelectedValue = dt.Rows[0]["subid"].ToString();
            fillsubject(Convert.ToInt32(ddlcourse.SelectedValue));
            ddltest.Enabled = false;
            ddlcourse.Enabled = false;
            ddlsubject.Enabled = false;
        }
    }

    private void fillMultipleschedule()
    {
        string Query = "select did,dayname from days where status=1";
        DataTable dt_day = objDut.GetDataTable(Query);
        if (dt_day.Rows.Count > 0)
        {
            ddlftime.DataSource = GetTimeIntervals();
            ddlftime.DataBind();
            ddltotime.DataSource = GetTimeIntervals();
            ddltotime.DataBind();
        }
    }

    public List<string> GetTimeIntervals()
    {
        List<string> timeIntervals = new List<string>();
        DateTime date = DateTime.MinValue.AddHours(6); // start at 6am
        DateTime endDate = DateTime.MinValue.AddDays(1).AddHours(6); // end at 5:45am (< 6am)

        while (date < endDate)
        {
            timeIntervals.Add(date.ToShortTimeString());
            date = date.AddMinutes(5);
        }
        return timeIntervals;
    }

    protected void ddlcourse_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlsubject.Items.Clear();
        ddlsubject.Items.Insert(0, new ListItem("--Select Subject--", "0"));

        if (ddlcourse.SelectedValue != "0")
        {
            fillsubject(Convert.ToInt32(ddlcourse.SelectedValue));
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select course first.");
            return;
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (ddltest.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select Test Name!");
            return;
        }

        SqlParameter[] param;
        param = new SqlParameter[16];
        param[0] = new SqlParameter("@classid", ddlcourse.SelectedValue);
        param[1] = new SqlParameter("@classname", ddlcourse.SelectedItem.Text);
        param[2] = new SqlParameter("@subname", ddlsubject.SelectedItem.Text);
        param[3] = new SqlParameter("@subid", ddlsubject.SelectedValue);
        param[4] = new SqlParameter("@testdate", txtToDate.Text.Trim());
        param[5] = new SqlParameter("@testtime1", ddlftime.SelectedItem.Text);
        param[6] = new SqlParameter("@testtime2", ddltotime.SelectedItem.Text);
        param[7] = new SqlParameter("@testtime1id", ddlftime.SelectedIndex);
        param[8] = new SqlParameter("@tetstime2id", ddltotime.SelectedIndex);
        param[9] = new SqlParameter("@passingMarks", txtmarksp.Text.Trim());
        param[10] = new SqlParameter("@totalmarks", txttotalmarks.Text.Trim());
        param[11] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
        param[12] = new SqlParameter("@status", 1);
        param[13] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[13].Direction = ParameterDirection.Output;
        param[14] = new SqlParameter("@testname", ddltest.SelectedItem.Text);
        param[15] = new SqlParameter("@testmid", ddltest.SelectedValue);
        param[16] = new SqlParameter("@testid", Convert.ToInt32(Session["tid"]));

        int result = objDut.ExecuteSqlSP(param, "usp_ExamMasterupdate");
        if (result == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Test Added Successfully!");
            Response.Redirect("testlist.aspx");
            //reset();
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Error.......!");
            return;
        }
    }

    protected void ddlsubject_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
}