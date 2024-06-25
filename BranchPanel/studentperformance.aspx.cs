using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_studentperformance : System.Web.UI.Page
{
    private string str, eid, qury, url, str1, str2, str3, ss, b = "";
    private DataTable dt;
    public double totalmarks = 0, percentage = 0, totalmaxmarks = 0;
    public long examid;
    private DataUtility objDut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["stue"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        if (!IsPostBack)
        {
            int x = Convert.ToInt32(objDut.GetScalar("select FYID from financial_Year where isActive=1 and isClosed=0"));
            ViewState["fyid"] = x;
            fillgrd();
            tblreport.Visible = false;
            divsug.Visible = false;
            btnsubmit.Visible = false;
        }
    }

    private void fillgrd()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@brid", Session["BrBrid"]);
        eid = Convert.ToString(objDut.GetScalerSP(param, "usp_returneid"));
        ViewState["eid"] = eid;
        str = @"select sum(marks) as marks,examname,examid from tbl_marks_master inner join exam_name on exam_name.eid=tbl_marks_master.examid where studentregno=" + Session["stue"] + " and examid like ('" + eid + "') group by examname,examid";
        dt = objDut.GetDataTable(str);
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
            GridView1.EmptyDataText = "No Records.";
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbdate = (Label)e.Row.FindControl("lbldate");
            HiddenField lbexmid = (HiddenField)e.Row.FindControl("lbexamid");
            str1 = Convert.ToString(objDut.GetScalar("select min(CAST(date AS DATE))   from exam_SchemReport where eid = " + lbexmid.Value + " and ExamStatus=1 and brid=" + Convert.ToInt32(Session["BrBrid"])));
            str2 = Convert.ToString(objDut.GetScalar("select max(CAST(date AS DATE))   from exam_SchemReport where eid = " + lbexmid.Value + " and ExamStatus=1 and brid=" + Convert.ToInt32(Session["BrBrid"])));
            str3 = str1 + " to " + str2;
            lbdate.Text = str3;
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        examid = Convert.ToInt32(e.CommandArgument);

        Control ctrl = e.CommandSource as Control;
        if (e.CommandName == "Show")
        {
            btnsubmit.Visible = true;
            GridView1.Visible = false;
            tblreport.Visible = true;
            divsug.Visible = true;
            BindMarks();
        }
    }

    protected void BindMarks()
    {
        string Query = "select maxmarks,passingmarks from exam_name where eid=" + examid;
        DataTable Dtmaxminmarks = objDut.GetDataTable(Query);
        if (Dtmaxminmarks.Rows.Count > 0)
        {
            lblphysicsmaximummarks.Text = lblchemistrymaximummarks.Text = lblgkmaximummarks.Text = lblhindimaximummarks.Text = lblenglishmaximummarks.Text = lblsciencemaximummarks.Text = lblmathsmaximummarks.Text = lblsocialsciencemaxmarks.Text = lbldrawingmaximummarks.Text = Convert.ToString(Dtmaxminmarks.Rows[0]["maxmarks"]);
            lblgkpassingmarks.Text = lblchemistrypassingmarks.Text = lblphysicspassingmarks.Text = lbldrawingpassingmarks.Text = lblsocialsciencepassingmarks.Text = lblsciencepassingmarks.Text = lblmathpassingmarks.Text = lblenglishpassingmarks.Text = lblpassingmarkshindi.Text = Convert.ToString(Dtmaxminmarks.Rows[0]["passingmarks"]);
            totalmaxmarks = Convert.ToDouble(Dtmaxminmarks.Rows[0]["maxmarks"]);
        }

        Query = "select studentregno,examname,marks,subjectid from tbl_marks_master inner join exam_name on exam_name.eid=tbl_marks_master.examid where studentregno=" + Session["stue"] + "  and fyid=" + Convert.ToInt32(ViewState["fyid"]) + " and brid=" + Convert.ToInt32(Session["BrBrid"]) + " and examid=" + examid;
        Dtmaxminmarks = objDut.GetDataTable(Query);
        totalmaxmarks = (totalmaxmarks * Dtmaxminmarks.Rows.Count);
        if (Dtmaxminmarks.Rows.Count > 0)
        {
            lblsessionalname.Text = Convert.ToString(Dtmaxminmarks.Rows[0]["examname"]);
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

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        divsug.Visible = false;
        GridView1.Visible = true;
        tblreport.Visible = false;
        btnsubmit.Visible = false;
    }
}