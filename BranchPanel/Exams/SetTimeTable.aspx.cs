using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
using System.Data.OleDb;

public partial class BranchPanel_Exams_SetTimeTable : System.Web.UI.Page
{
    private DataUtility objDut = new DataUtility();
    private DataTable Dt;
    private string Query = "";
    private int fyid = 0;
    private int brid = 0;
    DataTable dtSubjectMarks;
    DataTable dtSubjectMark = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["BrUser"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
            if (Convert.ToInt64(Session["BrBrid"]) != 0 && Session["BrBrid"] != null)
            {
                brid = Convert.ToInt32(Session["BrBrid"]);
            }

            fyid = CommonClass.Scaler("ActiveAcademicYear");

            if (!IsPostBack)
            {
                //CreateRepeater();
                //FillAllDropDownList(0, 0);
                //fill_Dropdown_Result(0);

                if (Request.QueryString.Count == 1)
                {
                    int eid = Convert.ToInt32(Request.QueryString[0]);

                    string maxmarks = objDut.GetScalar("select maxmarks from exam_name where eid=" + eid + "").ToString();
                    hfmaxmarks.Value = maxmarks;

                    //ddlexam.SelectedValue = Convert.ToString(eid);
                    ddlcourse.Enabled = true;
                    Query = "select classid,classname from exam_class where examid=" + eid + " and status=" + 1 + "";
                    Dt = objDut.GetDataTable(Query);
                    ddlcourse.DataSource = Dt;
                    ddlcourse.DataTextField = "classname";
                    ddlcourse.DataValueField = "classid";
                    ddlcourse.DataBind();
                    System.Web.UI.WebControls.ListItem licourse = new System.Web.UI.WebControls.ListItem("Select Class", "0");
                    ddlcourse.Items.Insert(0, licourse);
                }

            }
            //if (ddlsubject.SelectedValue != "0")
            //{
            //    ddlsubject_SelectedIndexChanged(null, null);
            //}
        }
        catch (Exception ex)
        {
        }
    }


    public bool Validate()
    {
        if (ddlTerm.SelectedValue != "0" && ddlcourse.SelectedValue != "0")
        {
            int intResult = Convert.ToInt32(objDut.GetScalar("Select ISNULL(Count(examid),0) from exam_class where status=1 and brid=" + Session["brBrid"] +
                           " and classid=" + ddlcourse.SelectedValue + ""));
            if (ddlTerm.SelectedValue == "1")
            {
                if (intResult < 4)
                {
                    Utility.ViewAlertMessage(Page, "Please config exam to class for Ist Term");
                    return false;
                }
            }
            else if (ddlTerm.SelectedValue == "2")
            {
                if (intResult < 8)
                {
                    Utility.ViewAlertMessage(Page, "Please config exam to class for IInd Term");
                    return false;
                }
            }
            else if (ddlTerm.SelectedValue == "3")
            {
                if (intResult < 12)
                {
                    Utility.ViewAlertMessage(Page, "Please config exam to class for IIIrd Term");
                    return false;
                }
            }
        }
        return true;
    }
    protected void ddlcourse_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (Validate())
            {
                if (ddlcourse.SelectedIndex > 0)
                {
                    Query = "select Distinct cwsid,sectionname from classwithsection where branchid=" + Session["brBrid"] + " and classid=" + ddlcourse.SelectedValue + "";
                    Dt = objDut.GetDataTable(Query);
                    ddlsection.DataSource = Dt;
                    ddlsection.DataTextField = "sectionname";
                    ddlsection.DataValueField = "cwsid";
                    ddlsection.DataBind();
                    System.Web.UI.WebControls.ListItem listsection = new System.Web.UI.WebControls.ListItem("Select Section", "0");
                    ddlsection.Items.Insert(0, listsection);

                    ddlsection.Enabled = true;
                    ddlsection.SelectedIndex = 0;
                    ddlsubject.SelectedIndex = 0;
                }
                else
                {
                    ddlcourse.Enabled = false;
                    ddlsection.Enabled = false;
                    ddlsubject.Enabled = false;
                    ddlcourse.SelectedIndex = 0;
                    ddlsection.SelectedIndex = 0;
                    ddlsubject.SelectedIndex = 0;
                }
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void ddlsection_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlsection.SelectedIndex > 0)
        {
            string StrStr = " where Subject_Master.fyid=" + fyid + " and SEM.branchid=" + Convert.ToInt64(Session["BrBrid"]) + " and SEM.classid=" + ddlcourse.SelectedValue + " and SEM.Status=1";
            DataUtility objDut = new DataUtility();
            string strSubject = " Select DISTINCT Subject_Master.id,Subject_Master.SubjectName from SubjectBranch_master SEM " +
                                " inner join Subject_Master on Subject_Master.id = SEM.subjectid " + StrStr + " and Subject_Master.SubjectName NOT IN('Health & Physical Education','Work Education','Discipline','Art Education')";
            DataTable dtSubject = objDut.GetDataTable(strSubject);
            if (dtSubject.Rows.Count > 0)
            {
                //Bind_student_marks(Convert.ToInt32(ddlexam.SelectedValue), Convert.ToInt32(ddlcourse.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue));
                ddlsubject.DataSource = dtSubject;
                ddlsubject.DataValueField = "id";
                ddlsubject.DataTextField = "SubjectName";
                ddlsubject.DataBind();
                System.Web.UI.WebControls.ListItem listsection = new System.Web.UI.WebControls.ListItem("Select Subject", "0");
                ddlsubject.Items.Insert(0, listsection);
                ddlsubject.Enabled = true;
                ddlsubject.SelectedIndex = 0;

            }
            else
            {
                ddlsection.Enabled = false;
                ddlsubject.Enabled = false;
                ddlsection.SelectedIndex = 0;
                ddlsubject.SelectedIndex = 0;

                Utility.ViewAlertMessage(Page, "Please Config Subject to Class");
            }
        }
    }

    protected void ddlsubject_SelectedIndexChanged(object sender, EventArgs e)
    {
        datepicker.Text = "";
        txtDay.Text = "";
        showdata();
    }

    public void showdata()
    {
        SqlParameter[] param = new SqlParameter[11];
        param[0] = new SqlParameter("@termid", SqlDbType.BigInt);
        param[0].Value = ddlTerm.SelectedValue;

        param[1] = new SqlParameter("@classid", SqlDbType.BigInt);
        param[1].Value = ddlcourse.SelectedValue;

        param[2] = new SqlParameter("@subjectid", SqlDbType.BigInt);
        param[2].Value = ddlsubject.SelectedValue;

        param[3] = new SqlParameter("@sectionid", SqlDbType.BigInt);
        param[3].Value = ddlsection.SelectedValue;

        param[4] = new SqlParameter("@examdate", SqlDbType.Date);
        if (datepicker.Text == "")
        {
            param[4].Value = DBNull.Value;
        }
        else
        {
            param[4].Value = DateTime.ParseExact(datepicker.Text, "dd-MM-yyyy", null);
        }


        param[5] = new SqlParameter("@examday", SqlDbType.VarChar);

        param[5].Value = txtDay.Text;


        param[6] = new SqlParameter("@fromtime", SqlDbType.VarChar);
        param[6].Value = timepicker1.Text;
        param[7] = new SqlParameter("@totime", SqlDbType.VarChar);
        param[7].Value = timepicker2.Text;
        param[8] = new SqlParameter("@brid", SqlDbType.BigInt);
        param[8].Value = Convert.ToInt64(Session["BrBrid"]);
        fyid = CommonClass.Scaler("ActiveAcademicYear");
        param[9] = new SqlParameter("@fyid", SqlDbType.Int);
        param[9].Value = fyid;

        param[10] = new SqlParameter("@mode", SqlDbType.BigInt);
        param[10].Value = Convert.ToInt32(0);

        //int result = objDut.ExecuteSqlSP(param, "sp_InsertUpdateExamDateTime");

        DataTable dt = objDut.GetDataTableSP(param, "sp_InsertUpdateExamDateTime");
        if (dt != null && dt.Rows.Count > 0)
        {
            datepicker.Text = Convert.ToDateTime(dt.Rows[0]["examdate"]).ToString("dd-MM-yyyy");
            txtDay.Text = Convert.ToString(dt.Rows[0]["examday"]);
            timepicker1.Text = Convert.ToString(dt.Rows[0]["fromtime"]);
            timepicker2.Text = Convert.ToString(dt.Rows[0]["totime"]);
        }

    }
    protected void ddlTerm_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlTerm.SelectedValue != "0")
        {
            Query = " Select Distinct cm.id as classid,cm.Classname from classwithsection cws " +
                            " left outer join Class_Master cm on cws.classid=cm.id " +
                //" inner join exam_class ec on ec.brid = cws.branchid " +
                            " where cm.status=1 and cws.branchid=" + Session["brBrid"] + " and cm.fyid=" + fyid; //+ "" +
            //" and ec.examid =" + examid;
            Dt = objDut.GetDataTable(Query);
            ddlcourse.Enabled = true;
            ddlcourse.DataSource = Dt;
            ddlcourse.DataTextField = "classname";
            ddlcourse.DataValueField = "classid";
            ddlcourse.DataBind();
            System.Web.UI.WebControls.ListItem licourse = new System.Web.UI.WebControls.ListItem("Select Class", "0");
            ddlcourse.Items.Insert(0, licourse);
        }
    }


    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }



  
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string dt = Request.Form[datepicker.UniqueID];
        string time1 = Request.Form[timepicker1.UniqueID];
        string time2 = Request.Form[timepicker2.UniqueID];
        string day = Request.Form[txtDay.UniqueID];
        if (string.IsNullOrWhiteSpace(dt) || string.IsNullOrWhiteSpace(time1) || string.IsNullOrWhiteSpace(time2) || string.IsNullOrWhiteSpace(day))
        {
            Utility.ViewAlertMessage(Page, "fill all values correctly");
            return;
        }
        SqlParameter[] param = new SqlParameter[12];
        param[0] = new SqlParameter("@termid", SqlDbType.BigInt);
        param[0].Value = ddlTerm.SelectedValue;

        param[1] = new SqlParameter("@classid", SqlDbType.BigInt);
        param[1].Value = ddlcourse.SelectedValue;

        param[2] = new SqlParameter("@subjectid", SqlDbType.BigInt);
        param[2].Value = ddlsubject.SelectedValue;

        param[3] = new SqlParameter("@sectionid", SqlDbType.BigInt);
        param[3].Value = ddlsection.SelectedValue;

        param[4] = new SqlParameter("@examdate", SqlDbType.Date);
        
        datepicker.Text = dt;
        param[4].Value = DateTime.ParseExact(datepicker.Text, "dd-MM-yyyy", null);
        
        param[5] = new SqlParameter("@examday", SqlDbType.VarChar);

        param[5].Value = day;


        param[6] = new SqlParameter("@fromtime", SqlDbType.VarChar);
        param[6].Value = time1;
        param[7] = new SqlParameter("@totime", SqlDbType.VarChar);
        param[7].Value = time2;
        param[8] = new SqlParameter("@brid", SqlDbType.BigInt);
        param[8].Value = Convert.ToInt64(Session["BrBrid"]);
        fyid = CommonClass.Scaler("ActiveAcademicYear");
        param[9] = new SqlParameter("@fyid", SqlDbType.Int);
        param[9].Value = fyid;

        param[10] = new SqlParameter("@mode", SqlDbType.BigInt);
        param[10].Value = Convert.ToInt32(1);
        param[11] = new SqlParameter("@intResult", SqlDbType.BigInt);
        param[11].Direction = ParameterDirection.Output;

        int result = objDut.ExecuteSqlSP(param, "sp_InsertUpdateExamDateTime");
        if(result>0)
        {
            Utility.ViewAlertMessage(Page, "Exam date and time has been saved");
            showdata();
        }
        
    }
}