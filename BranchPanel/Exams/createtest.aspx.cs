using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_Exam_createtest : System.Web.UI.Page
{
    private Utility objUT = new Utility();
    private string url = "", query, query1, query2, query3;
    private DataTable dt, dt_t;
    private string batchid = "", topicid = "";
    private int fyid = 0;
    private DataUtility objDut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        fyid = CommonClass.Scaler("ActiveAcademicYear");
        if (!IsPostBack == true)
        {
            filltest();
            Button1.Enabled = true;
            Fillcourse();
            //l1.Visible = false;
            //Div1.Visible = false;
            fillMultipleschedule();
        }
    }
    
    private void filltest()
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
    }

    protected void Fillcourse()
    {
        dt = CommonClass.examMaster("classdll",Convert.ToInt32(Session["BrBrid"]));
        if (dt.Rows.Count > 0)
        {
            ddlcourse.DataSource = dt;
            ddlcourse.DataTextField = "Classname";
            ddlcourse.DataValueField = "ID";
            ddlcourse.DataBind();
            ddlcourse.Items.Insert(0, new ListItem("--Select Class--", "0"));
            ddlsubject.Items.Insert(0, new ListItem("--Select Subject--", "0"));
            // ddlTopic.Items.Insert(0, new ListItem("--Select Topic--", "0"));
        }
    }

    private void fillsubject(int courseID)
    {
        DataTable dt = CommonClass.examMaster("coursedll", courseID);
        if (dt.Rows.Count > 0)
        {
            ddlsubject.DataSource = dt;
            ddlsubject.DataTextField = "subjectname";
            ddlsubject.DataValueField = "subjectid";
            ddlsubject.DataBind();
            ddlsubject.Items.Insert(0, new ListItem("--Select Subject--", "0"));
            //fillBatch(courseID);
            dt.Clear();
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "No subject for this Class has been added.");
            ddlcourse.SelectedValue = "0";
            // l1.Visible = true;
            return;
        }
    }

    //private void fillTopic()
    //{
    //    if (ddlsubject.SelectedValue != "0")
    //    {
    //        DataTable dt;
    //        dt = CommonClass.examMaster("topicmaster", Convert.ToInt32(ddlsubject.SelectedValue), Convert.ToInt32(ddlcourse.SelectedValue));
    //        if (dt.Rows.Count > 0)
    //        {
    //            Div1.Visible = true;
    //            grdtopic.DataSource = dt;
    //            grdtopic.DataBind();
    //        }
    //        else
    //        {
    //            Utility.ViewAlertMessage(this.Master.Page, "No topic for this subject has been added! You cannot create a test without selecting a topic.");
    //            Button1.Enabled = false;
    //            return;
    //        }
    //    }
    //    else
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Please select a subject");
    //    }
    //}

    //private void fillBatch(int CouID)
    //{
    //    DataTable dt1;
    //    dt1 = CommonClass.examMaster("batchmaster", Convert.ToInt32(Session["BrBrid"]), CouID);
    //    if (dt1.Rows.Count > 0)
    //    {
    //        l1.Visible = true;
    //        GridView1.DataSource = dt1;
    //        GridView1.DataBind();
    //        dt1.Clear();
    //    }
    //    else
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "No batches for this course have been added.");
    //        GridView1.DataSource = null;
    //        GridView1.DataBind();
    //        return;
    //    }
    //}

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        int count = Convert.ToInt32(objDut.GetScalar("select count(*) from tbl_admission where classid=" + ddlcourse.SelectedValue + "and brid=" + Convert.ToInt32(Session["BrBrid"])));
        if (count == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "No student in respective class please select other .");
            return;
        }

        if (ddltest.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select Test Name!");
            return;
        }
        else if (ddlcourse.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select Class!");
            return;
        }
        else if (ddlsubject.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select Subject!");
            return;
        }
        else if (txtToDate.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter date!");
            return;
        }
        else if (txtmarksp.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter passing marks!");
            return;
        }
        else if (txttotalmarks.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Max marks!");
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

        int result = objDut.ExecuteSqlSP(param, "usp_ExamMaster");
        if (result == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Test Added Successfully!");
            //string url = "~/BranchPanel/Exams/createtest.aspx";
            //int status = Convert.ToInt32(objDut.GetScalar("select isactive from tbl_MailPermission where url='" + url + "'"));
            //ViewState["outtestid"] = Convert.ToInt32(param[20].Value);
            //if (status == 1)
            //{
            //    sendmail();
            //}
            //else
            //{
            //}
            Response.Redirect("testlist.aspx");
            reset();
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Error.......!");
            return;
        }
    }

    protected void sendmail()
    {
        string email = "";
        string topic = "";
        string batch = "";
        string test = "", date = "", time = "", time1 = "", name = "";
        string details = @"select distinct em.testtime2 as time1,em.testtime1 as time,convert(varchar(13),em.testdate,106) as date, em.testname as test,em.batchname as batch,em.topic as topic,sm.roll_no,(sm.fname+' '+sm.Lname)as name,sm.mobile,sm.email as mail
                         from studentexam_master sem inner join student_master sm  on sem.sturegno=sm.sturegno
                         INNER JOIN exam_Master em on em.tid=sem.testid where sem.testid=" + Convert.ToInt32(ViewState["outtestid"]) + " and em.tid=" + Convert.ToInt32(ViewState["outtestid"]);
        dt = objDut.GetDataTable(details);

        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                email = dt.Rows[i]["mail"].ToString();
                topic = dt.Rows[i]["topic"].ToString();
                batch = dt.Rows[i]["batch"].ToString();
                test = dt.Rows[i]["test"].ToString();
                date = dt.Rows[i]["date"].ToString();
                time = dt.Rows[i]["time"].ToString();
                time1 = dt.Rows[i]["time1"].ToString();
                name = dt.Rows[i]["name"].ToString();
                string str = SendMail.Send("satyam@awapalsolutions.com", email.ToString(), "", "",
                    " Your Exam Details", "Dear" + " " + name.ToString() + "<br/>" + "<br/>" + "SSC Batch Exam Detail:" + "<br/>" + "<br/>" +
                    "Batch Name:" + batch.ToString() + "<br/>" + "Test Name:" + test.ToString() + "<br/>" +
                    "Topic Name:" + topic.ToString() + "<br/>" + "Test Start Time:" + time.ToString() + "<br/>" +
                    "Test End Time:" + time1.ToString() + "<br/>" + "Test Date:" + date.ToString() + "<br/>" +
                    "<br/>" + "<br/>" + "<br/>" + "<br/>" + "<br/>" + "<br/>" + "<br/>" + "Thanx & regards"
                    );
            }
        }
    }

    private void reset()
    {
        ddlsubject.SelectedIndex = 0;
        ddlcourse.SelectedIndex = 0;
        txtmarksp.Text = "";

        txtToDate.Text = "";
        txttotalmarks.Text = "";
        ddlftime.SelectedIndex = 0;
        ddltotime.SelectedIndex = 0;
        lblcourse.Text = "";
        //foreach (GridViewRow gvrow in GridView1.Rows)
        //{
        //    CheckBox txtfee = (CheckBox)gvrow.FindControl("chk1");
        //    txtfee.Checked = false;
        //}

        //foreach (GridViewRow gvrow in grdtopic.Rows)
        //{
        //    CheckBox txtfee = (CheckBox)gvrow.FindControl("chk2");
        //    txtfee.Checked = false;
        //}

        //DataTable dt5;
        //dt5 = CommonClass.examMaster("batchmaster1", Convert.ToInt32(Session["BrBrid"]), Convert.ToInt32(ddlsubject.SelectedValue));
        //GridView1.DataSource = null;
        //GridView1.DataBind();
        // grdtopic.DataSource = null;
        //grdtopic.DataBind();
    }

    //protected void chk2_CheckedChanged(object sender, EventArgs e)
    //{
    //    lbltopic.Text = "";
    //    topicid = "";
    //    int NoOfCourse = 0;
    //    foreach (GridViewRow gvrow in grdtopic.Rows)
    //    {
    //        CheckBox txtfee = (CheckBox)gvrow.FindControl("chk2");
    //        if (txtfee.Checked)
    //        {
    //            Label Course = ((Label)(gvrow.FindControl("lblcourse1"))) as Label;

    //            HiddenField hd3 = (HiddenField)gvrow.FindControl("hd3");

    //            lbltopic.Text = lbltopic.Text + "," + Course.Text;

    //            topicid = topicid + "," + Convert.ToString(hd3.Value);
    //            NoOfCourse = NoOfCourse + 1;
    //        }
    //    }

    //    if (lbltopic.Text != "")
    //        lbltopic.Text = lbltopic.Text.Remove(0, 1);
    //    if (!string.IsNullOrEmpty(topicid))
    //        topicid = topicid.Remove(0, 1);
    //    ViewState["topicod"] = topicid;
    //}

    //protected void chk1_CheckedChanged(object sender, EventArgs e)
    //{
    //    lblcourse.Text = "";
    //    batchid = "";
    //    int NoOfCourse = 0;
    //    foreach (GridViewRow gvrow in GridView1.Rows)
    //    {
    //        CheckBox txtfee = (CheckBox)gvrow.FindControl("chk1");
    //        if (txtfee.Checked)
    //        {
    //            Label Course = ((Label)(gvrow.FindControl("lblcourse"))) as Label;
    //            HiddenField hd2 = (HiddenField)gvrow.FindControl("hd2");
    //            ViewState["batchid"] = hd2.Value;
    //            callfun(ViewState["batchid"]);
    //            lblcourse.Text = lblcourse.Text + "," + Course.Text;
    //            batchid = batchid + "," + Convert.ToString(hd2.Value);
    //            NoOfCourse = NoOfCourse + 1;
    //        }
    //    }

    //    if (lblcourse.Text != "")
    //        lblcourse.Text = lblcourse.Text.Remove(0, 1);
    //    if (!string.IsNullOrEmpty(batchid))
    //        batchid = batchid.Remove(0, 1);
    //    ViewState["batchid1"] = batchid;
    //}

    private void callfun(object p)
    {
        int countstu = Convert.ToInt32(objDut.GetScalar("select noofstudents from batch_master where classid=" + ddlcourse.SelectedValue + " and batchid=" + p));
        if (countstu == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "There is no any student.!!");
            reset();
        }
    }

    protected void ddlcourse_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblcourse.Text = "";
        lbltopic.Text = "";
        ddlsubject.Items.Clear();
        ddlsubject.Items.Insert(0, new ListItem("--Select Subject--", "0"));

        // GridView1.DataSource = null;
        // GridView1.DataBind();

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

    protected void ddlsubject_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblcourse.Text = "";
        lbltopic.Text = "";
        if (ddlsubject.SelectedValue != "0")
        {
            // Div1.Visible = true;
            //ddlTopic.Items.Clear();
            //fillTopic();
        }
        else
        {
            // grdtopic.DataSource = null;
            //grdtopic.DataBind();
            //Div1.Visible = false;
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
}