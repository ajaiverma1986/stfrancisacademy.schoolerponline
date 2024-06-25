using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Exam_test_batch : System.Web.UI.Page
{
    private DataUtility objDut = new DataUtility();
    private DataTable dt, dt1, dt2;
    private string batchid = "", url = "";
    private SqlParameter[] param;

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
            Tab1.CssClass = "Clicked";
            MainView.ActiveViewIndex = 0;

                dt = objDut.GetDataTable("select batchname,subname,batchid from examperdetail where TID1=" + Convert.ToInt32(Session["tid"]) + " and status1=1 and brid=1");
                dt = CommonClass.examMaster("",);
              int count = 0;
                for (; count < dt.Rows.Count; )
                {
                    if (dt.Rows.Count > 0)
                    {
                        Label title = new Label();
                        ViewState["bid"] = dt.Rows[count]["batchid"].ToString();
                        batchid = batchid + "," + dt.Rows[count]["batchid"].ToString();
                        //fillv(ViewState["bid"]);
                        Filinfo();
                        title.Text = dt.Rows[count]["batchname"].ToString();
                        Area1.Controls.Add(new LiteralControl("<br>"));
                        Area1.Controls.Add(title);
                        //int i = batchid.IndexOf(",");
                        batchid = batchid.Trim(',');
                    }
                    if (!string.IsNullOrEmpty(batchid))
                        ViewState["ba1"] = batchid;
                    count++;
                }
                if (ViewState["ba1"] == null)
                {
                }
                else
                {
                    fillinfo(ViewState["ba1"]);
                }
            }
        }

    //private void fillnext(object p)
    //{
    //    int a = Convert.ToInt32(objDut.GetScalar("select count(*) from ExamAttendance where stataus=0 and batchid in (" + p + ")"));
    //    if (a > 0)
    //    {
    //        lblcount.Text = "(" + a.ToString() + ")";
    //    }
    //    else
    //    {
    //        lblcount.Text = "0";
    //    }
    //}

    private void fillinfo(object p)
    {
        dt1 = objDut.GetDataTable(@"select sb.batchid as batchid,sb.batchname as batchname ,sb.stuRegNo as regno,(sm.FName+' '+sm.LName) as name from  Student_BatchMaster sb,student_master sm where sb.batchid  in (" + p + ")  and sb.status=1 and sb.brid=1 and sm.brid=1 and sm.StuRegNo=sb.stuRegNo and  sm.StuRegNo not in(select ex1.sturegno from ExamAttendance ex1,student_master sm1 where ex1.sturegno=sm1.sturegno and  ex1.stataus=0 and sb.batchid  in (select ex12.batchid from ExamAttendance ex12,Student_BatchMaster sm12 where ex12.sturegno!=sm12.sturegno and ex12.stataus=0 AND ex12.descp1='Remove') and  sm.sturegno  in       (select ex123.sturegno from ExamAttendance ex123,Student_BatchMaster sm123 where ex123.sturegno!=sm123.sturegno and ex123.stataus=0 and ex123.descp1='Remove' and ex123.tid=" + Convert.ToInt32(Session["tid"]) + ")) ");

        dt2 = objDut.GetDataTable(@" select sb.batchid as batchid,sb.batchname as batchname ,sb.stuRegNo as regno,(sm.FName+' '+sm.LName) as name from
Student_BatchMaster sb, student_master sm where sb.batchid  in(" + p + ") and sb.status=1 and sb.brid=1 and sm.brid=1 and sm.StuRegNo=sb.stuRegNo  and sb.batchid   in(select ex12.batchid from ExamAttendance ex12,Student_BatchMaster sm12 where ex12.sturegno=sm12.sturegno and ex12.stataus=0 and ex12.batchid=sm12.batchid ) and  sm.sturegno in (select ex123.sturegno from ExamAttendance ex123,Student_BatchMaster sm123    where ex123.sturegno=sm123.sturegno and ex123.stataus=0 and ex123.batchid=sm123.batchid and ex123.tid=" + Convert.ToInt32(Session["tid"]) + ")  ");

        ViewState["theDataTable"] = dt1;
        if (dt1.Rows.Count > 0)
        {
            //fillnext(ViewState["ba1"]);
            gridenquiry.DataSource = dt1;
            gridenquiry.DataBind();
        }
        else
        {
            gridenquiry.DataSource = null;
            gridenquiry.DataBind();

            //fillnext(ViewState["ba1"]);
        }

        if (dt2.Rows.Count > 0)
        {
            GridView1.DataSource = dt2;
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
        }
    }

    private void Filinfo()
    {
    }

    protected void Tab1_Click(object sender, EventArgs e)
    {
        Tab1.CssClass = "Clicked";
        Tab2.CssClass = "Initial";

        MainView.ActiveViewIndex = 0;
    }

    protected void Tab2_Click(object sender, EventArgs e)
    {
        Tab1.CssClass = "Initial";
        Tab2.CssClass = "Clicked";

        MainView.ActiveViewIndex = 1;
    }

    protected void Tab3_Click(object sender, EventArgs e)
    {
        Tab1.CssClass = "Initial";
        Tab2.CssClass = "Initial";

        MainView.ActiveViewIndex = 2;
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row1 = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);

        HiddenField hd1 = row1.FindControl("lblbatch") as HiddenField;

        int regno = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "ed")
        {
            param = new SqlParameter[7];
            param[0] = new SqlParameter("@sturegno", regno);
            param[1] = new SqlParameter("@batchid", hd1.Value);
            param[2] = new SqlParameter("@status", Convert.ToInt32("0"));
            param[3] = new SqlParameter("@attendance", Convert.ToInt32("0"));
            param[4] = new SqlParameter("@decs", "Remove");
            param[5] = new SqlParameter("@intResult", Convert.ToInt32("0"));
            param[5].Direction = ParameterDirection.Output;
            param[6] = new SqlParameter("@mode", "add");

            int res = objDut.ExecuteSqlSP(param, "usp_examAttendance");

            if (res == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Join successfully!");

                fillinfo(ViewState["ba1"]);
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "Error....!1");
                return;
            }
        }
    }

    protected void gridenquiry_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row1 = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);

        HiddenField hd1 = row1.FindControl("lblbatch") as HiddenField;

        int regno = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "ed")
        {
            param = new SqlParameter[7];
            param[0] = new SqlParameter("@sturegno", regno);
            param[1] = new SqlParameter("@batchid", hd1.Value);
            param[2] = new SqlParameter("@status", Convert.ToInt32("0"));
            param[3] = new SqlParameter("@attendance", Convert.ToInt32("0"));
            param[4] = new SqlParameter("@decs", "Romove");
            param[5] = new SqlParameter("@intResult", Convert.ToInt32("0"));
            param[5].Direction = ParameterDirection.Output;
            param[6] = new SqlParameter("@mode", "remove");

            int res = objDut.ExecuteSqlSP(param, "usp_examAttendance");

            if (res == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Remove successfully");
                Filinfo();
                fillinfo(ViewState["ba1"]);
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "Error....!1");
                return;
            }
        }
    }
}