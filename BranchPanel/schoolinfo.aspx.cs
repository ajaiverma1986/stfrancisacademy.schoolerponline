using System;
using System.Collections.Generic;
using System.Data;

using System.Data.SqlClient;

using System.Web.UI.WebControls;

public partial class BranchPanel_schoolinfo : System.Web.UI.Page
{
    private SqlParameter[] param = new SqlParameter[48];
    private DataUtility objDUT = new DataUtility();
    private CommonClass CommonClass = new CommonClass();
    private string fromdate = string.Empty;
    private string todate = string.Empty;
    private string query, query2, query3, query4, query5, query6, query7, query8, query9, Fromdate, Todate, query10, query11;
    private int domainID = 0;
    private int status, regid, classid, count, count2, count3, feeSlipID;
    private DataTable dt1;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            gd.Visible = false;
            fillCountry();
            fillddl();
            fill_timingDDl();
            fillddL_acadmics();
        }
    }

    public void fillCountry()
    {
        ddlcuntry.DataSource = CommonClass.Dll("Countrydll");
        ddlcuntry.DataTextField = "countryName";
        ddlcuntry.DataValueField = "CID";
        ddlcuntry.DataBind();
        ddlcuntry.Items.Insert(0, new ListItem("--Select Country--", "0"));
        ddlstate.Items.Insert(0, new ListItem("--Select State--", "0"));
        ddlcity.Items.Insert(0, new ListItem("--Select City--", "0"));
    }

    protected void ddlcuntry_SelectedIndexChanged(object sender, EventArgs e)
    {
        string querystsateCount = "select COUNT(*) from STATE where CID=" + ddlcuntry.SelectedValue + "";
        int statecount = Convert.ToInt32(objDUT.GetScalar(querystsateCount));
        if (statecount == 0)
        {
            ddlstate.Items.Clear();
            ddlstate.Items.Insert(0, new ListItem("--Select State--", "0"));
            ddlcity.Items.Clear();
            ddlcity.Items.Insert(0, new ListItem("--Select City--", "0"));
            ddlcuntry.Focus();
        }
        else
        {
            ddlstate.Items.Clear();
            ddlstate.DataSource = CommonClass.Dll("Statedll", Convert.ToInt32(ddlcuntry.SelectedValue));
            ddlstate.DataTextField = "stateName";
            ddlstate.DataValueField = "SID";
            ddlstate.DataBind();
            ddlstate.Items.Insert(0, new ListItem("--Select State--", "0"));
            ddlstate.Focus();
        }
    }

    protected void ddlstate_SelectedIndexChanged(object sender, EventArgs e)
    {
        int intStateId = Convert.ToInt32(ddlstate.SelectedValue);
        string querycityCount = "select COUNT(*) from CITY where SID=" + intStateId + "";
        int citycount = Convert.ToInt32(objDUT.GetScalar(querycityCount));
        if (citycount == 0)
        {
            ddlcity.Items.Clear();
            ddlcity.Items.Insert(0, new ListItem("--Select City--", "0"));
            ddlstate.Focus();
        }
        else
        {
            ddlcity.Items.Clear();
            string strSql = "select ctId,cityName from city where cityName<>'Others' and sid=" + intStateId + " order by cityName";
            DataTable dtCity = objDUT.GetDataTable(strSql);
            ddlcity.DataSource = dtCity;
            ddlcity.DataTextField = "cityName";
            ddlcity.DataValueField = "ctId";
            ddlcity.DataBind();
            ddlcity.Items.Insert(0, new ListItem("--Select City--", "0"));
            ddlcity.Focus();
        }
    }

    protected void fillddl()
    {
        ddlEstd.Items.Insert(0, new ListItem("--Select Establishment Year--", "0"));

        for (int i = 2014; i >= 1947; i--)
        {
            ddlEstd.Items.Add("" + i);
        }
    }

    protected void fillddL_acadmics()
    {
        ddacadyr.Items.Insert(0, new ListItem("--Select Acadamic(s) year--", "0"));
        ddToyr.Items.Insert(0, new ListItem("---- To ----", "0"));
        for (int i = 2020; i >= 2000; i--)
        {
            ddacadyr.Items.Add("" + i);
            ddToyr.Items.Add("" + i);
        }
    }

    public List<string> GetTimeIntervals()
    {
        List<string> timeIntervals = new List<string>();
        List<int> index = new List<int>();
        DateTime date = DateTime.MinValue.AddHours(7); // start at 6am
        DateTime endDate = DateTime.MinValue.AddDays(1).AddHours(6); // end at 5:45am (< 6am)
        int i = 0;
        while (date < endDate)
        {
            timeIntervals.Add(date.ToShortTimeString());
            date = date.AddMinutes(30);
            index.Add(i);
            i = i + 1;
        }

        return timeIntervals;
    }

    public void fill_timingDDl()
    {
        ddscTiming.DataSource = GetTimeIntervals();
        ddscTiming.DataBind();
        ddtimingTo.DataSource = GetTimeIntervals();
        ddtimingTo.DataBind();
        ddtimings.DataSource = GetTimeIntervals();
        ddtimings.DataBind();
        ddtiminghlfdyTo.DataSource = GetTimeIntervals();
        ddtiminghlfdyTo.DataBind();

        string str = "select id,Classname from Class_Master where  status=1";
        DataTable dt = objDUT.GetDataTable(str);
        if (dt.Rows.Count > 0)
        {
            ddlclassfrm.DataSource = dt;
            ddlclassfrm.DataTextField = "classname";
            ddlclassfrm.DataValueField = "id";
            ddlclassfrm.DataBind();
            ddlclassfrm.Items.Insert(0, new ListItem("--Select Class--", "0"));
            ddlclassTo.DataSource = dt;
            ddlclassTo.DataTextField = "classname";
            ddlclassTo.DataValueField = "id";
            ddlclassTo.DataBind();
            ddlclassTo.Items.Insert(0, new ListItem("-- To --", "0"));
            dt.Dispose();
        }
    }

    protected void btn_Update_Click(object sender, EventArgs e)
    {
        string pname = "usp_schoolinfo";
        param[0] = new SqlParameter("@scid", "");
        param[1] = new SqlParameter("@schoolname", txtscname.Text.Trim());
        //if (ddlcuntry.SelectedValue != "0")
        //{
        param[2] = new SqlParameter("@countryid", ddlcuntry.SelectedValue);
        param[3] = new SqlParameter("@countryname", ddlcuntry.SelectedItem.Text);
        //}

        //if (ddlstate.SelectedValue != "0")
        //{
        param[4] = new SqlParameter("@stateid", ddlstate.SelectedValue);
        param[5] = new SqlParameter("@statename", ddlstate.SelectedItem.Text);
        //}
        //if (ddlcity.SelectedValue != "0")
        //{
        param[6] = new SqlParameter("@cityid ", ddlcity.SelectedValue);
        param[7] = new SqlParameter("@cityname", ddlcity.SelectedItem.Text);
        //}

        param[8] = new SqlParameter("@areazipcode", txtzip.Text.Trim());
        param[9] = new SqlParameter("@establishon", ddlEstd.SelectedItem.Text);
        param[10] = new SqlParameter("@emailid", txtemail.Text.ToString());

        param[11] = new SqlParameter("@contactno", txtcnprson.Text.Trim());
        param[12] = new SqlParameter("@mobile", txtmob.Text.ToString());
        param[13] = new SqlParameter("@fax", txtfax.Text.Trim());

        //if (ddlclassfrm.SelectedValue != "0")
        //{
        param[14] = new SqlParameter("@claas1id", ddlclassfrm.SelectedValue);
        param[15] = new SqlParameter("@class", ddlclassfrm.SelectedItem.Text);
        //}
        //if (ddlclassTo.SelectedValue != "0")
        //{
        param[16] = new SqlParameter("@claas2idid", ddlclassTo.SelectedValue);
        param[17] = new SqlParameter("@class2", ddlclassTo.SelectedItem.Text);
        //}
        param[18] = new SqlParameter("@acadmicyear", ddacadyr.SelectedItem.Text);
        param[19] = new SqlParameter("@acadmicyearto", ddToyr.SelectedItem.Text);

        //if (ddscTiming.SelectedValue != "0")
        //{
        param[20] = new SqlParameter("@schooltimingfromid", 0);
        param[21] = new SqlParameter("@schooltimingfrom", ddscTiming.SelectedItem.Text);
        //}
        //if (ddtimingTo.SelectedValue != "0")
        //{
        param[22] = new SqlParameter("@schooltimingid", 0);
        param[23] = new SqlParameter("@schooltimingTo", ddtimingTo.SelectedItem.Text);
        //}
        param[24] = new SqlParameter("@totalworkingday", txtWrkdays.Text.Trim());

        //if (ddstrtday.SelectedValue != "0")
        //{
        param[25] = new SqlParameter("@weeklyworkingid", ddstrtday.SelectedValue);
        param[26] = new SqlParameter("@weeklyworkingday", ddstrtday.SelectedItem.Text);
        //}

        //if (ddweekoff.SelectedValue != "0")
        //{
        param[27] = new SqlParameter("@weeklyoff_Dayid", ddweekoff.SelectedValue);
        param[28] = new SqlParameter("@weeklyoff_dayname", ddweekoff.SelectedItem.Text);
        //}

        //if (ddhalfday.SelectedValue != "0")
        //{
        param[29] = new SqlParameter("@halfDayId", ddhalfday.SelectedValue);

        param[30] = new SqlParameter("@halfdayname", ddhalfday.SelectedItem.Text);
        //}
        param[31] = new SqlParameter("@periods", txtperiod.Text.Trim());
        param[32] = new SqlParameter("@lduration", txtbreak.Text.Trim());
        param[33] = new SqlParameter("@sduration", txtshortbrek.Text.Trim());

        if (chk1.Checked)
        {
            param[34] = new SqlParameter("@hostel", 1);
        }
        else
        {
            param[34] = new SqlParameter("@hostel", 0);
        }
        if (chk2.Checked)
        {
            param[35] = new SqlParameter("@library", 1);
        }
        else
        {
            param[35] = new SqlParameter("@library", 0);
        }
        if (chk3.Checked)
        {
            param[36] = new SqlParameter("@transport", 1);
        }
        else
        {
            param[36] = new SqlParameter("@transport", 0);
        }

        param[37] = new SqlParameter("@reopendate", Convert.ToDateTime(txtToDate.Text.Trim()));

        if (chk4.Checked)
        {
            param[38] = new SqlParameter("@empenrollment", 1);
        }
        else
        {
            param[38] = new SqlParameter("@empenrollment", 0);
        }
        if (chk4.Checked)
        {
            param[39] = new SqlParameter("@stuadmision", 1);
        }
        else
        {
            param[39] = new SqlParameter("@stuadmision", 0);
        }
        //if (ddtimings.SelectedValue != "0")
        //{
        param[40] = new SqlParameter("@halfdayfromid", 0);
        param[41] = new SqlParameter("@halfdayfrom", ddtimings.SelectedItem.Text);
        //}
        //if (ddtiminghlfdyTo.SelectedValue != "0")
        //{
        param[42] = new SqlParameter("@halfdaytoid", 0);
        param[43] = new SqlParameter("@halfday", ddtiminghlfdyTo.SelectedItem.Text);
        //}
        param[44] = new SqlParameter("@hperiods", txtperiods.Text.Trim());
        param[45] = new SqlParameter("@hlduration", txtbreak2.Text.Trim());
        param[46] = new SqlParameter("@hsduration", txtShrtbrek.Text.Trim());
        param[47] = new SqlParameter("@intresult", 0);
        param[47].Direction = ParameterDirection.Output;
        int result = objDUT.ExecuteSqlSP(param, pname);
        if (result > 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "School details have been inserted successfully.");

            empty();
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Some error.!");
        }
    }

    protected void ddhalfday_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddhalfday.SelectedIndex > 0)
        {
            gd.Visible = true;
        }
        else
        {
            gd.Visible = false;
        }
    }

    protected void empty()
    {
        txtscname.Text = string.Empty;
        txtzip.Text = string.Empty;
        txtemail.Text = string.Empty;
        ddlcuntry.SelectedIndex = 0;
        ddlstate.SelectedIndex = 0;
        ddlcity.SelectedIndex = 0;
        ddlEstd.SelectedIndex = 0;
        txtcnprson.Text = string.Empty;
        txtmob.Text = string.Empty;
        txtfax.Text = string.Empty;
        ddlclassfrm.SelectedIndex = 0;
        ddlclassTo.SelectedIndex = 0;
        ddacadyr.SelectedIndex = 0;
        ddToyr.SelectedIndex = 0;
        ddscTiming.SelectedIndex = 0;
        ddtimingTo.SelectedIndex = 0;
        txtWrkdays.Text = string.Empty;
        ddstrtday.SelectedIndex = 0;
        ddweekoff.SelectedIndex = 0;
        ddhalfday.SelectedIndex = 0;
        txtperiod.Text = string.Empty;
        txtbreak.Text = string.Empty;
        txtshortbrek.Text = string.Empty;
        txtToDate.Text = string.Empty;
        ddtiminghlfdyTo.SelectedIndex = 0;
        ddtimings.SelectedIndex = 0;
        txtperiods.Text = string.Empty;
        txtbreak2.Text = string.Empty;
        txtShrtbrek.Text = string.Empty;
        chk1.Checked = false;
        chk2.Checked = false;
        chk3.Checked = false;
        chk4.Checked = false;
        chk5.Checked = false;
    }
}