using System;
using System.Data;
using System.Web.UI;

public partial class BranchPanel_Exams_sessional_report_card : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    public long eid, fyid = 0, brid = 0, studentregno = 0;
    public double totalmarks = 0, percentage = 0, totalmaxmarks = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Session["User"] == null)
        //{
        //    Response.Redirect("~/Login.aspx");
        //}
        if (Request.QueryString.Count > 0)
        {
            studentregno = Convert.ToInt64(Request.QueryString[0]);
            eid = Convert.ToInt64(Request.QueryString[1]);
        }
        if (Convert.ToInt64(Session["BrBrid"]) != 0 && Session["BrBrid"] != null)
        {
            brid = Convert.ToInt64(Session["BrBrid"]);
            fyid = CommonClass.Scaler("ActiveAcademicYear");
        }
        if (!Page.IsPostBack)
        {
            try
            {
                BindMarks();
                BindRemainDetails();
            }
            catch (Exception ex)
            {
            }
        }
    }

    protected void BindMarks()
    {
        string Query = "select maxmarks,passingmarks from exam_name where eid=" + eid;
        DataTable Dtmaxminmarks = objdut.GetDataTable(Query);
        if (Dtmaxminmarks.Rows.Count > 0)
        {
            lblphysicsmaximummarks.Text = lblchemistrymaximummarks.Text = lblgkmaximummarks.Text = lblhindimaximummarks.Text = lblenglishmaximummarks.Text = lblsciencemaximummarks.Text = lblmathsmaximummarks.Text = lblsocialsciencemaxmarks.Text = lbldrawingmaximummarks.Text = Convert.ToString(Dtmaxminmarks.Rows[0]["maxmarks"]);
            lblgkpassingmarks.Text = lblchemistrypassingmarks.Text = lblphysicspassingmarks.Text = lbldrawingpassingmarks.Text = lblsocialsciencepassingmarks.Text = lblsciencepassingmarks.Text = lblmathpassingmarks.Text = lblenglishpassingmarks.Text = lblpassingmarkshindi.Text = Convert.ToString(Dtmaxminmarks.Rows[0]["passingmarks"]);
            totalmaxmarks = Convert.ToDouble(Dtmaxminmarks.Rows[0]["maxmarks"]);
        }

        Query = "select studentregno,examname,marks,subjectid from tbl_marks_master inner join exam_name on exam_name.eid=tbl_marks_master.examid where studentregno=" + studentregno + " and fyid=" + fyid + " and brid=" + brid + " and examid=" + eid + "";
        Dtmaxminmarks = objdut.GetDataTable(Query);
        totalmaxmarks = (totalmaxmarks * Dtmaxminmarks.Rows.Count);
        if (Dtmaxminmarks.Rows.Count > 0)
        {
            lblsessionalname.Text = lblsessional.Text = Convert.ToString(Dtmaxminmarks.Rows[0]["examname"]);
            for (int i = 0; i < Dtmaxminmarks.Rows.Count; i++)
            {
                totalmarks = totalmarks + Convert.ToInt32(Dtmaxminmarks.Rows[i]["marks"]);
                switch (Convert.ToInt32(Dtmaxminmarks.Rows[i]["subjectid"]))
                {
                    case 1:
                        trhindi.Visible = true;
                        lblstudentmarkshindi.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        break;

                    case 2:
                        trenglish.Visible = true;
                        lblenglishstudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        break;

                    case 3:
                        trmaths.Visible = true;
                        lblmathstudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        break;

                    case 4:
                        trscience.Visible = true;
                        lblsciencestudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        break;

                    case 5:
                        trsocialscience.Visible = true;
                        lblsocialstudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        break;

                    case 6:
                        trgk.Visible = true;
                        lblgkstudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        break;

                    case 7:
                        trchemistry.Visible = true;
                        lblchemistrystudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        break;

                    case 8:
                        trphysics.Visible = true;
                        lblphysicsstudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        break;

                    case 12:
                        trdrawing.Visible = true;
                        lbldrawingstudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        break;
                }
            }
        }

        lblgrandtotal.Text = Convert.ToString(totalmarks);
        percentage = ((Convert.ToInt32(lblgrandtotal.Text) * 100) / totalmaxmarks);
        lblpercentage.Text = Convert.ToString(Math.Round((decimal)percentage, 2)) + " %";
        //lblrank.Text = "";
        //lbldesignation.Text = "";
    }

    protected void BindRemainDetails()
    {
        DataTable Dtmaxminmarks;
        string Query = @"select (year(ta.admissionDAte)) as acedmicyear,ta.ApplyClass,ta.ADNO,ta.sturegno,(isnull(sm.FirstName,'')+' '+isnull(sm.MiddleName,'')+' '+isnull(sm.LastName,'')) as
        Name from tbl_Admission ta inner join student_master sm on ta.sturegno=sm.sturegno where ta.sturegno=" + studentregno + " and ta.fyid=" + fyid + " and ta.brid=" + brid + "";
        Dtmaxminmarks = objdut.GetDataTable(Query);
        lblstudentname.Text = Convert.ToString(Dtmaxminmarks.Rows[0]["Name"]);
        lblclass.Text = Convert.ToString(Dtmaxminmarks.Rows[0]["ApplyClass"]);
        lbladmission.Text = Convert.ToString(Dtmaxminmarks.Rows[0]["ADNO"]);
        lblroll.Text = Convert.ToString(Dtmaxminmarks.Rows[0]["sturegno"]);
        lblacedemicyear.Text = Convert.ToString(Convert.ToInt32(Dtmaxminmarks.Rows[0]["acedmicyear"]) - 1) + " - " + Convert.ToString(Dtmaxminmarks.Rows[0]["acedmicyear"]);
    }
}