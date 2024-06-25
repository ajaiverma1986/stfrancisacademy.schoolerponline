using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class BranchPanel_Exams_halfyearly_report : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    public long eid = 4, fyid = 2, brid = 1, studentregno = 103;
    public double totalmarks = 0, percentage = 0, totalmaxmarks = 0;
    public double sessionalpassingmarks = 0, sessionalmaximummarks = 0, halfyearmaxmarks = 0, halfyearlypassingmarks = 0;
    private CommonClass commonOBJ = new CommonClass();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        if (Request.QueryString.Count > 0)
        {
            studentregno = Convert.ToInt64(Request.QueryString[0]);
            eid = Convert.ToInt64(Request.QueryString[1]);
        }
        if (Convert.ToInt64(Session["BrBrid"]) != 0 && Session["BrBrid"] != null)
        {
            brid = Convert.ToInt64(Session["BrBrid"]);
            fyid = commonOBJ.Scaler("ActiveAcademicYear");
        }
        if (!Page.IsPostBack)
        {
        }
        try
        {
            sessionalmarks();
            BindMarks();
            BindRemainDetails();
        }
        catch (Exception ex)
        {
        }
    }

    protected void sessionalmarks()
    {
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@studentregno", SqlDbType.Int);
        param[0].Value = studentregno;
        param[1] = new SqlParameter("@fyid", SqlDbType.Int);
        param[1].Value = fyid;
        param[2] = new SqlParameter("@brid", SqlDbType.Int);
        param[2].Value = brid;
        param[3] = new SqlParameter("@eid", SqlDbType.Int);
        param[3].Value = eid;
        DataTable dt = objdut.GetDataTableSP(param, "[dbo].[usp_BestTwoSemester]");

        if (dt.Rows.Count > 0)
        {
            sessionalpassingmarks = Convert.ToDouble(dt.Rows[0]["passingmarks"]);
            sessionalmaximummarks = Convert.ToDouble(dt.Rows[0]["Maximummarks"]);
            lblsessionalmaxmarkshindi.Text = lblsessionalmaxmarksenglish.Text = lblsessionalmaxmarksmath.Text = lblsessionalsciencemaxmarks.Text = lblsessionalmaxmarkssocialscience.Text = lblsessionalmaxmarksHistory.Text = lblsessionalmaxmarksGK.Text = lblsessionalmaxmarkschemistry.Text = lblsessionalmaxmarksphysics.Text = Convert.ToString(Convert.ToDouble(dt.Rows[0]["Maximummarks"]) + Convert.ToDouble(dt.Rows[0]["Maximummarks"]));
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                totalmarks = totalmarks + Convert.ToDouble(dt.Rows[i]["Studentmarks"]);
                switch (Convert.ToInt32(dt.Rows[i]["subjectid"]))
                {
                    case 1:
                        lblsessionalstudentmarkshindi.Text = Convert.ToString(dt.Rows[i]["Studentmarks"]);
                        break;

                    case 2:
                        lblsessionalstudentmarksenglish.Text = Convert.ToString(dt.Rows[i]["Studentmarks"]);
                        break;

                    case 3:
                        lblsessionalpassingmarksmaths.Text = Convert.ToString(dt.Rows[i]["Studentmarks"]);
                        break;

                    case 4:
                        lblsessinalstudentmarksscience.Text = Convert.ToString(dt.Rows[i]["Studentmarks"]);
                        break;

                    case 5:
                        lblsessionalstudentmarkssocialscience.Text = Convert.ToString(dt.Rows[i]["Studentmarks"]);
                        break;

                    case 6:
                        lblsessionalstudentmarksGK.Text = Convert.ToString(dt.Rows[i]["Studentmarks"]);
                        break;

                    case 7:
                        lblsessionalstudentmarkschemistry.Text = Convert.ToString(dt.Rows[i]["Studentmarks"]);
                        break;

                    case 8:
                        lblphysicsstudentmarks.Text = Convert.ToString(dt.Rows[i]["Studentmarks"]);
                        break;

                    case 12:
                        trdrawing.Visible = true;
                        lblsessionalstudentmarksHistory.Text = Convert.ToString(dt.Rows[i]["Studentmarks"]);
                        break;
                }
            }
        }
    }

    protected void BindMarks()
    {
        string Query = "select maxmarks,passingmarks from exam_name where eid=" + eid;
        DataTable Dtmaxminmarks = objdut.GetDataTable(Query);
        if (Dtmaxminmarks.Rows.Count > 0)
        {
            halfyearlypassingmarks = Convert.ToDouble(Dtmaxminmarks.Rows[0]["passingmarks"]);
            halfyearmaxmarks = Convert.ToDouble(Dtmaxminmarks.Rows[0]["maxmarks"]);

            lbltotalmaxmarkshindi.Text = lbltotalmaxmarksenglish.Text = lbltotalmaxmarksmaths.Text = lbltotalmaxmarksscience.Text = lbltotalmaxmarkssocialscience.Text = lbltotalmaxmarksHistory.Text = lbltotalmaxmarksGK.Text = lbltotalmaxmarkschemistry.Text = lbltotalmaxmarksphysics.Text = Convert.ToString((sessionalmaximummarks + sessionalmaximummarks) + halfyearmaxmarks);
            lbltotalpassingmarkshindi.Text = lbltotalpassingmarksenglish.Text = lbltotalpassingmarksmaths.Text = lbltotalpassingmarksscience.Text = lbltotalpassingmarkssocialscience.Text = lbltotalpassingmarksHistory.Text = lbltotalpassingmarksGK.Text = lbltotalpassingmarkschemistry.Text = lbltotalpassingmarksphysics.Text = Convert.ToString((sessionalpassingmarks + sessionalpassingmarks) + halfyearlypassingmarks);

            lblphysicsmaximummarks.Text = lblchemistrymaximummarks.Text = lblgkmaximummarks.Text = lblhindimaximummarks.Text = lblenglishmaximummarks.Text = lblsciencemaximummarks.Text = lblmathsmaximummarks.Text = lblsocialsciencemaxmarks.Text = lbldrawingmaximummarks.Text = Convert.ToString(Dtmaxminmarks.Rows[0]["maxmarks"]);
            lblgkpassingmarks.Text = lblchemistrypassingmarks.Text = lblphysicspassingmarks.Text = lbldrawingpassingmarks.Text = lblsocialsciencepassingmarks.Text = lblsciencepassingmarks.Text = lblmathpassingmarks.Text = lblenglishpassingmarks.Text = lblpassingmarkshindi.Text = Convert.ToString(Dtmaxminmarks.Rows[0]["passingmarks"]);
            totalmaxmarks = Convert.ToDouble((sessionalmaximummarks + sessionalmaximummarks) + halfyearmaxmarks);
        }

        Query = "select studentregno,examname,marks,subjectid from tbl_marks_master inner join exam_name on exam_name.eid=tbl_marks_master.examid where studentregno=" + studentregno + " and fyid=" + fyid + " and brid=" + brid + " and examid=" + eid + "";
        Dtmaxminmarks = objdut.GetDataTable(Query);
        totalmaxmarks = (totalmaxmarks * Dtmaxminmarks.Rows.Count);
        if (Dtmaxminmarks.Rows.Count > 0)
        {
            for (int i = 0; i < Dtmaxminmarks.Rows.Count; i++)
            {
                totalmarks = totalmarks + Convert.ToDouble(Dtmaxminmarks.Rows[i]["marks"]);
                switch (Convert.ToInt32(Dtmaxminmarks.Rows[i]["subjectid"]))
                {
                    case 1:
                        trhindi.Visible = true;
                        lblstudentmarkshindi.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        lbltotalstudentmarkshindi.Text = Convert.ToString(Convert.ToDouble(lblstudentmarkshindi.Text) + Convert.ToDouble(lblsessionalstudentmarkshindi.Text));
                        break;

                    case 2:
                        trenglish.Visible = true;
                        lblenglishstudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        lbltotalstudentmarksenglish.Text = Convert.ToString(Convert.ToDouble(lblenglishstudentmarks.Text) + Convert.ToDouble(lblsessionalstudentmarksenglish.Text));
                        break;

                    case 3:
                        trmaths.Visible = true;
                        lblmathstudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        lbltotalstudentmarksmaths.Text = Convert.ToString(Convert.ToDouble(lblmathstudentmarks.Text) + Convert.ToDouble(lblsessionalpassingmarksmaths.Text));
                        break;

                    case 4:
                        trscience.Visible = true;
                        lblsciencestudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        lbltotalstudentmarksscience.Text = Convert.ToString(Convert.ToDouble(lblsciencestudentmarks.Text) + Convert.ToDouble(lblsessinalstudentmarksscience.Text));
                        break;

                    case 5:
                        trsocialscience.Visible = true;
                        lblsocialstudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        lbltotalstudentmarkssocialscience.Text = Convert.ToString(Convert.ToDouble(lblsocialstudentmarks.Text) + Convert.ToDouble(lblsessionalstudentmarkssocialscience.Text));
                        break;

                    case 6:
                        trgk.Visible = true;
                        lblgkstudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        lbltotalstudentmarksGK.Text = Convert.ToString(Convert.ToDouble(lblgkstudentmarks.Text) + Convert.ToDouble(lblsessionalstudentmarksGK.Text));
                        break;

                    case 7:
                        trchemistry.Visible = true;
                        lblchemistrystudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        lbltotalstudentmarkschemistry.Text = Convert.ToString(Convert.ToDouble(lblchemistrystudentmarks.Text) + Convert.ToDouble(lblsessionalstudentmarkschemistry.Text));
                        break;

                    case 8:
                        trphysics.Visible = true;
                        lblphysicsstudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        lbltotalstudentmarksphysics.Text = Convert.ToString(Convert.ToDouble(lblphysicsstudentmarks.Text) + Convert.ToDouble(lblphysicsstudentmarks.Text));
                        break;

                    case 12:
                        trdrawing.Visible = true;
                        lbldrawingstudentmarks.Text = Convert.ToString(Dtmaxminmarks.Rows[i]["marks"]);
                        lbltotalstudentmarksHistory.Text = Convert.ToString(Convert.ToDouble(lbldrawingstudentmarks.Text) + Convert.ToDouble(lblsessionalstudentmarksHistory.Text));
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