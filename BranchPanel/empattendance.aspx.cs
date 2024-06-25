using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_empattendancece : System.Web.UI.Page
{
    private Utility objUT = new Utility();
    private DataUtility objDUT = new DataUtility();
    private string url = "", query, query2, query3, pp, PageName, pname, query4, query5;
    private DataTable dt;
    private string Classname = string.Empty;
    private string classid = string.Empty;
    private int count = 0, eid;
    //private SqlParameter[] param = new SqlParameter[];

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int fyid = Convert.ToInt32(objDUT.GetScalar("select FYID  from financial_Year where isActive=1 and isClosed=0"));
            ViewState["fyid"] = Convert.ToInt32(fyid);
            dibsubmit.Visible = false;
            divtext.Visible = false;
            // DateTime dd = Convert.ToDateTime(objDUT.GetScalar("select GETDATE()"));
        }
    }

    //private void sesssss()
    //{
    //    int date = Convert.ToInt32(objDUT.GetScalar("select CONVERT(VARCHAR(24),date,113) from tbl_setholiday where status =1 and fyid=2"));
    //    ViewState["date"]=date;
    //}
    private void fillgrid()
    {
        string str = "select (fname+' '+ISNULL(MName,'')+' '+lname) as name , te.eid,cast((isnull(em.status,0)) as bit)as status from tblEmp_Master te left outer join EmpAttendance_Master em on te.eid=em.eid where te.status=1 and CONVERT(varchar(13),em.date,106)= CONVERT(varchar(13),GETDATE(),106)";

        DataTable dte = objDUT.GetDataTable(str);
        if (dte.Rows.Count > 0)
        {
            Grid_holiday.DataSource = dte;
            Grid_holiday.DataBind();
            foreach (GridViewRow gvrow in Grid_holiday.Rows)
            {
                CheckBox chkdelete = (CheckBox)gvrow.FindControl("chk1");
                if (chkdelete.Checked)
                {
                    chkdelete.Enabled = false;
                }
                else
                {
                    chkdelete.Enabled = true;
                }
            }
        }
        else
        {
            Grid_holiday.DataSource = null;
            Grid_holiday.DataBind();
        }
    }

    protected void btnInTime_Click(object sender, EventArgs e)
    {
        btnInTime.Visible = false;
        btnOutTime.Visible = false;
        dibsubmit.Visible = true;
        divtext.Visible = true;

        fillgrid();
    }

    public List<string> GetTimeIntervals()
    {
        List<string> timeIntervals = new List<string>();
        List<int> index = new List<int>();
        DateTime date = DateTime.MinValue.AddHours(6); // start at 6am
        DateTime endDate = DateTime.MinValue.AddDays(1).AddHours(6); // end at 5:45am (< 6am)
        int i = 0;
        while (date < endDate)
        {
            timeIntervals.Add(date.ToShortTimeString());
            date = date.AddMinutes(5);
            index.Add(i);
            i = i + 1;
        }

        return timeIntervals;
    }

    protected void btnAttendance_Click(object sender, EventArgs e)
    {
    }

    protected void btnBack2_Click(object sender, EventArgs e)
    {
        int count = 0;
        Classname = "";
        classid = "";
        foreach (GridViewRow gvrow in Grid_holiday.Rows)
        {
            CheckBox chkdelete = (CheckBox)gvrow.FindControl("chk1");
            Label classname = (Label)gvrow.FindControl("lblreason");
            HiddenField hd1 = (HiddenField)gvrow.FindControl("HD12");
            if (chkdelete.Checked && chkdelete.Enabled == true)
            {
                count = count + 1;

                Classname = Classname + "," + classname.Text;
                classid = classid + "," + hd1.Value;
            }
        }
        if (count == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select attendance.");
            //btnSubmit.Visible = true;
            return;
        }
        classid = classid.Remove(0, 1);
        pname = "usp_empattendance1";
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));
        param[1] = new SqlParameter("@eid", classid);
        param[2] = new SqlParameter("@intresult", Convert.ToInt32("0"));
        param[2].Direction = ParameterDirection.Output;
        param[3] = new SqlParameter("@fyid", Convert.ToInt32(ViewState["fyid"]));

        count = objDUT.ExecuteSqlSP(param, pname);
        if (count == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Attendance marked successfully.");
        }
        else if (count == 2)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Today is holiday.");
            return;
        }
    }

    protected void txtDate_TextChanged(object sender, EventArgs e)
    {
        btnsubmit.Visible = false;

        pp = "select eid,cast((isnull(status,0)) as bit)as status,name  from EmpAttendance_Master where  CONVERT(varchar(13),date,101)= CONVERT(varchar(13),'" + txtDate.Text.Trim() + "',106)  and status=1  ";
        ViewState["ikj"] = pp;
        dt = objDUT.GetDataTable(pp);
        if (dt.Rows.Count > 0)
        {
            Grid_holiday.DataSource = dt;
            Grid_holiday.DataBind();
            foreach (GridViewRow gvrow in Grid_holiday.Rows)
            {
                CheckBox chkdelete = (CheckBox)gvrow.FindControl("chk1");
                if (chkdelete.Checked)
                {
                    chkdelete.Enabled = false;
                }
                else
                {
                    chkdelete.Enabled = true;
                }
            }
        }
        else
        {
            Grid_holiday.DataSource = null;
            Grid_holiday.DataBind();
            Grid_holiday.EmptyDataText = "No Record Found.!";
        }
    }

    protected void btnOutTime_Click(object sender, EventArgs e)
    {
        dibsubmit.Visible = true;
        divtext.Visible = true;
        btnOutTime.Visible = false;
        btnInTime.Visible = false;

        pp = "select eid,cast((isnull(logoutstatus,0)) as bit)as status,name  from EmpAttendance_Master where  CONVERT(varchar(13),date,106)= CONVERT(varchar(13),GETDATE(),106)  and status=1";
        dt = objDUT.GetDataTable(pp);
        if (dt.Rows.Count > 0)
        {
            Grid_holiday.DataSource = dt;
            Grid_holiday.DataBind();
            foreach (GridViewRow gvrow in Grid_holiday.Rows)
            {
                CheckBox chkdelete = (CheckBox)gvrow.FindControl("chk1");

                if (chkdelete.Checked)
                {
                    chkdelete.Enabled = false;
                }
                else
                {
                }
            }
        }
    }
}