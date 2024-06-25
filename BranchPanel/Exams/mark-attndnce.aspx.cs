using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_Exam_mark_attndnce : System.Web.UI.Page
{
    private DataTable dt, dt1, dt3;
    private SqlParameter[] param;
    private string batchid = "", name1 = "", roll = "", regno = "", batchid1 = "", url = "";
    private DataUtility objDut = new DataUtility();

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
            fillGrid();
        }
    }

    private void fillGrid()
    {
        dt = CommonClass.examMaster("markattendance", Convert.ToInt32(Session["tid"]));
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }

    protected void GrdAttendence_RowCommand(object sender, GridViewCommandEventArgs e)
    {
    }

    protected void ddlbatch_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        string sturegno = "";
        string attendance = "";
        foreach (GridViewRow gvrow in GridView1.Rows)
        {
            CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
            Label classname = (Label)gvrow.FindControl("lblclass");
            HiddenField hd1 = (HiddenField)gvrow.FindControl("HD1");
            sturegno = sturegno + "," + hd1.Value;
            if (chkdelete.Checked)
            {
                attendance = attendance + "," + "0";
            }
            else
            {
                attendance = attendance + "," + "1";
            }
        }

        sturegno = sturegno.Remove(0, 1);
        attendance = attendance.Remove(0, 1);
        param = new SqlParameter[5];

        //Session["sturegno"] = sturegno;
        param[0] = new SqlParameter("@sturegno", sturegno);
        Session["attendance"] = attendance;
        param[1] = new SqlParameter("@stuAtt", attendance);
        param[2] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));

        param[3] = new SqlParameter("@testid", Convert.ToString(Session["tid"]));
        param[4] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[4].Direction = ParameterDirection.Output;
        int res = objDut.ExecuteSqlSP(param, "usp_examattendanceMaster");
        if (res == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Student Absent Succefully.");
            Response.Redirect("markslist.aspx");
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Error....!");
            return;
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
    }
}