using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_brtimetable : System.Web.UI.Page
{
    private int fullcount = 1;
    private string fulltime = string.Empty;
    private int count = 0;
    private string idfullday = string.Empty;
    private string PageName;
    private int fullday1 = 1;
    private Utility objut = new Utility();
    private DataUtility objDUT = new DataUtility();
    private string url;
    private int i;
    private Utility obju = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        //PageName = Utility.GetCurrentPagename();

        //if (!objut.isAccessible(((User)Session["BrUser"]).UserID, PageName))
        //{
        //    Response.Redirect("~/Login.aspx");
        //}
        if (!IsPostBack)
        {
            bindddl();
        }
    }

    public List<string> GetTimeIntervals()
    {
        List<string> timeIntervals = new List<string>();
        List<int> index = new List<int>();
        DateTime date = DateTime.MinValue.AddHours(6); // start at 6am
        DateTime endDate = DateTime.MinValue.AddDays(1).AddHours(1); // end at 5:45am (< 6am)
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

    public List<string> GetTimeIntervals1(int from, int to)
    {
        //int outer=
        List<string> timeIntervals = new List<string>();
        DateTime date = DateTime.MinValue.AddHours(from); // start at 6am
        DateTime endDate = DateTime.MinValue.AddHours(to).AddMinutes(5);
        //DateTime endDate = DateTime.MinValue.AddDays(1).AddHours(6); // end at 12:45am (< 6am)
        while (date < endDate)
        {
            timeIntervals.Add(date.ToShortTimeString());
            date = date.AddMinutes(5);
        }
        return timeIntervals;
    }

    public int findindex(string time)
    {
        List<string> timeIntervals = new List<string>();
        List<int> index = new List<int>();
        DateTime date = DateTime.MinValue.AddHours(6); // start at 6am
        DateTime endDate = DateTime.MinValue.AddDays(1).AddHours(1); // end at 12:45am (< 6am)
        int i = 0;
        while (date < endDate)
        {
            timeIntervals.Add(date.ToShortTimeString());
            date = date.AddMinutes(30);
            index.Add(i);
            i = i + 1;
            if (date.ToShortTimeString() == time)
            {
                break;
            }
        }
        return i;
    }

    public int findindex1(string time)
    {
        List<string> timeIntervals = new List<string>();
        List<int> index = new List<int>();
        DateTime date = DateTime.MinValue.AddHours(Convert.ToInt32(ViewState["from"]));
        DateTime endDate = DateTime.MinValue.AddHours(Convert.ToInt32(ViewState["to"]));
        int i = 0;
        while (date < endDate)
        {
            timeIntervals.Add(date.ToShortTimeString());
            date = date.AddMinutes(5);
            index.Add(i);
            i = i + 1;
            if (date.ToShortTimeString() == time)
            {
                break;
            }
        }
        return i;
    }

    private void bindddl()
    {
        trshowbtn.Visible = false;
        Session["state"] = null;
        ddlFrom.DataSource = GetTimeIntervals();
        ddlFrom.DataBind();
        ddlTo.DataSource = GetTimeIntervals();
        ddlTo.DataBind();
        string query = "select schooltiminingFrom,schooltimingTo,periods from tbl_schoolsettings where status=1";
        DataTable dt = objDUT.GetDataTable(query);

        if (dt.Rows.Count > 0)
        {
            ddlFrom.SelectedIndex = findindex(dt.Rows[0]["schooltiminingFrom"].ToString());
            ddlTo.SelectedIndex = findindex(dt.Rows[0]["schooltimingTo"].ToString());
            ViewState["periods"] = Convert.ToInt32(dt.Rows[0]["periods"]);
            lblperiods.Text = "Total number of periods : " + dt.Rows[0]["periods"].ToString();
            int posA = dt.Rows[0]["schooltiminingFrom"].ToString().IndexOf(":");
            ViewState["from"] = dt.Rows[0]["schooltiminingFrom"].ToString().Substring(0, posA);
            int difference = Convert.ToInt32(objDUT.GetScalar("select DATEDIFF(hour,'" + dt.Rows[0]["schooltiminingFrom"].ToString() + "','" + dt.Rows[0]["schooltimingTo"].ToString() + "')"));
            ViewState["to"] = Convert.ToInt32(ViewState["from"]) + difference;
        }
        dt.Dispose();
    }

    private void binggridfortime()
    {
        i = Convert.ToInt32(txtnoofperiod.Text) + Convert.ToInt32(txtafterlunch.Text) + 2;
        DataTable state = new DataTable();
        state.Columns.Add("Period", typeof(string));
        //  GridView1.Visible = true;
        for (int y = 0; y <= i - 1; y++)
        {
            DataRow row = state.NewRow();
            row["Period"] = "";
            state.Rows.Add(row);
        }
        Session["state"] = state;
        bindgrid();
    }

    protected void bindgrid()
    {
        trshowbtn.Visible = true;
        GridView1.DataSource = (DataTable)Session["state"];
        GridView1.DataBind();
        trnoofperdiod.Visible = true;
        fieldsetTableNoDistrict.Visible = true;
        ViewState["lunch"] = null;
        Session["state"] = null;
        return;
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@brid", Session["BrBrid"]);
        param[1] = new SqlParameter("@fullday", idfullday);
        param[2] = new SqlParameter("@intresult", SqlDbType.Int);
        param[2].Direction = ParameterDirection.Output;

        int result = objDUT.ExecuteSqlSP(param, "sp_workingdays");

        chekfortimetable();
    }

    private void chekfortimetable()
    {
        int countforafterluch = 0;
        int countforafterluch1 = 0;
        //divworkingdays.Visible = false;
        FIELDSET1.Visible = true;

        int count = Convert.ToInt32(objDUT.GetScalar("select count(*) from timeperiod where status=1 and brid=" + Session["BrBrid"]));
        if (count > 0)
        {
            DataTable dt = new DataTable();
            dt = objDUT.GetDataTable("select * from timeperiod where status=1 and brid=" + Session["BrBrid"] + "order by pid");
            if (dt.Rows.Count > 0)
            {
                string[] startth = dt.Rows[0]["starttime"].ToString().Split('.');
                //ddlsh.SelectedValue = startth[0];
                //ddlsm.SelectedValue = startth[1];
                string[] starttm = dt.Rows[dt.Rows.Count - 1]["endtime"].ToString().Split('.');
                //ddleh.SelectedValue = starttm[0];
                //ddlem.SelectedValue = starttm[1];
            }

            foreach (DataRow row1 in dt.Rows)
            {
                if ("L" == row1["period"].ToString())
                {
                    ViewState["starttime"] = row1["starttime"].ToString();
                    ViewState["endtime"] = row1["endtime"].ToString();
                }
            }

            foreach (DataRow row in dt.Rows)
            {
                if (Convert.ToDouble(row["endtime"]) <= Convert.ToDouble(ViewState["starttime"].ToString()))
                {
                    countforafterluch = countforafterluch + 1;
                }
                if (Convert.ToDouble(ViewState["endtime"]) <= Convert.ToDouble(row["starttime"]))
                {
                    countforafterluch1 = countforafterluch1 + 1;
                }
            }
            txtnoofperiod.Text = (countforafterluch - 1).ToString();
            txtafterlunch.Text = countforafterluch1.ToString();
            binggridfortime();

            int grdcount = 0;
            foreach (GridViewRow row in GridView1.Rows)
            {
                DropDownList ddlstarth = row.FindControl("ddlstarthour") as DropDownList;
                string[] start = dt.Rows[grdcount]["starttime"].ToString().Split('.');
                ddlstarth.SelectedValue = start[0];
                DropDownList ddlstartm = row.FindControl("ddlstartmin") as DropDownList;
                ddlstartm.SelectedValue = start[1];
                DropDownList ddlendh = row.FindControl("ddlendhour") as DropDownList;
                DropDownList ddlendm = row.FindControl("ddlendmin") as DropDownList;
                string[] end = dt.Rows[grdcount]["endtime"].ToString().Split('.');
                ddlendh.SelectedValue = end[0];
                ddlendm.SelectedValue = end[1];
                grdcount = grdcount + 1;
            }
            grdcount = 0;
        }
    }

    private void findtotaltime()
    {
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int index = 0;
            index = e.Row.RowIndex;
            Label l = e.Row.FindControl("Label1") as Label;
            DropDownList ddlstarttimehh = (DropDownList)e.Row.FindControl("ddlstarthour");
            DropDownList ddlendtimehh = (DropDownList)e.Row.FindControl("ddlendhour");
            TextBox tb1 = (TextBox)e.Row.FindControl("txtauto");
            TextBox tb2 = (TextBox)e.Row.FindControl("txtauto1");
            if (index > 0)
            {
                DropDownList ddlprevious = (DropDownList)GridView1.Rows[index - 1].FindControl("ddlendhour");
                tb1.Attributes.Add("onblur", "javascript:get1(" + tb1.ClientID + "," + ddlstarttimehh.ClientID + "," + ddlprevious.ClientID + ")");
                tb2.Attributes.Add("onblur", "javascript:get(" + tb2.ClientID + "," + ddlendtimehh.ClientID + ")");
            }
            else
            {
                tb1.Attributes.Add("onblur", "javascript:get(" + tb1.ClientID + "," + ddlstarttimehh.ClientID + ")");
                tb2.Attributes.Add("onblur", "javascript:get(" + tb2.ClientID + "," + ddlendtimehh.ClientID + ")");
            }
            ddlstarttimehh.DataSource = GetTimeIntervals1(Convert.ToInt32(ViewState["from"]), Convert.ToInt32(ViewState["to"]));
            ddlstarttimehh.DataBind();
            ddlendtimehh.DataSource = GetTimeIntervals1(Convert.ToInt32(ViewState["from"]), Convert.ToInt32(ViewState["to"]));
            ddlendtimehh.DataBind();

            if (count == 0)
            {
                l.Text = "Assembly";
            }
            else if (count == Convert.ToInt32(txtnoofperiod.Text) + 1)
            {
                l.Text = "Lunch";
                ViewState["lunch"] = "Lunch";
            }
            else
            {
                if (ViewState["lunch"] == null)
                {
                    l.Text = "Period " + (count);
                }
                else
                {
                    l.Text = "Period " + (count - 1);
                }
            }
            count = count + 1;
            var result = MultipleValues(l.Text);
            if (!string.IsNullOrEmpty(result.Item1.ToString()) || !string.IsNullOrEmpty(result.Item2.ToString()))
            {
                if (index == 0)
                {
                    ddlstarttimehh.SelectedIndex = (findindex1(result.Item1.ToString()) + 1);
                }
                else
                {
                    ddlstarttimehh.SelectedIndex = findindex1(result.Item1.ToString());
                }
                ddlendtimehh.SelectedIndex = findindex1(result.Item2.ToString());
            }
        }
    }

    private Tuple<string, string> MultipleValues(string period)
    {
        int count = 0;
        string actualParameter = string.Empty, query = string.Empty, fromtime = "", totime = "";
        if (period == "Assembly")
        {
            actualParameter = "A";
        }
        else if (period == "Lunch")
        {
            actualParameter = "L";
        }
        else if (period.Contains("Period"))
        {
            int posA = period.LastIndexOf("Period");
            int adjustedPosA = posA + "Period".Length;
            actualParameter = period.Substring(adjustedPosA).Trim();
        }
        count = Convert.ToInt32(objDUT.GetScalar("select count(pid) from timeperiod where status=1 and brid=" + Convert.ToInt32(Session["BrBrid"]) + " and period='" + actualParameter + "'"));
        if (count > 0)
        {
            query = "Select starttime,endtime from timeperiod where status=1 and brid=" + Convert.ToInt32(Session["BrBrid"]) + " and period='" + actualParameter + "' ";
            DataTable dt = objDUT.GetDataTable(query);
            if (dt.Rows.Count > 0)
            {
                fromtime = dt.Rows[0]["starttime"].ToString();
                totime = dt.Rows[0]["endtime"].ToString();
            }
            Tuple<string, string> obj = Tuple.Create(fromtime, totime);
            return obj;
        }
        else
        {
            Tuple<string, string> obj = Tuple.Create("", "");
            return obj;
        }
    }

    protected void TextBox4_TextChanged(object sender, EventArgs e)
    {
    }

    protected void btnCreate_Click(object sender, EventArgs e)
    {
        if (CheckValidations())
        {
            int noofperiod = Convert.ToInt32(txtnoofperiod.Text) + Convert.ToInt32(txtafterlunch.Text);
            ViewState["countfor"] = null;
            foreach (GridViewRow row in GridView1.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    Label l = row.FindControl("Label1") as Label;
                    DropDownList st = row.FindControl("ddlstarthour") as DropDownList;
                    DropDownList stm = row.FindControl("ddlendhour") as DropDownList;
                    string start = st.SelectedItem.Text;
                    string end = stm.SelectedItem.Text;
                    if (l.Text == "Assembly")
                    {
                        fulltime = fulltime + "A";
                    }
                    else if (l.Text == "Lunch")
                    {
                        ViewState["countfor"] = "Lunch";
                        fulltime = fulltime + "L";
                    }
                    else
                    {
                        if (ViewState["countfor"] == null)
                        {
                            fulltime = fulltime + (fullcount - 1);
                        }
                        else
                        {
                            fulltime = fulltime + (fullcount - 2);
                        }
                    }
                    fulltime = fulltime + "/" + start + "/" + end + ",";

                    fullcount = fullcount + 1;
                }
            }
            int length = fulltime.Length;
            fulltime = fulltime.Remove(length - 1, 1);
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@brid", Session["BrBrid"]);
            param[1] = new SqlParameter("@fulltime", fulltime);
            param[2] = new SqlParameter("@intresult", SqlDbType.Int);
            param[2].Direction = ParameterDirection.Output;
            param[3] = new SqlParameter("@noofperiod", noofperiod);
            int result = objDUT.ExecuteSqlSP(param, "sp_timeperiod");
            if (result == 0)
            {
                GridView1.Visible = false;
                GridView1.DataSource = null;
                GridView1.DataBind();
                trshowbtn.Visible = false;
                txtnoofperiod.Text = "";
                txtafterlunch.Text = "";
                td1.Visible = false;
                Utility.ViewAlertMessage(Page, "Time Table Created Successfully");
                return;
            }
            else
            {
                Utility.ViewAlertMessage(Page, "Some Error");
                return;
            }
        }
    }

    protected void txtafterlunch_TextChanged(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtafterlunch.Text))
        {
            if (Session["state"] == null)
            {
                if (!objut.IsNumeric(txtafterlunch.Text))
                {
                    Utility.ViewAlertMessage(Page, "Please enter numeric value only!!");
                    txtafterlunch.Text = "";
                    return;
                }
                if (txtnoofperiod.Text == "")
                {
                    Utility.ViewAlertMessage(Page, "Enter No. of Period before lunch!!");
                    return;
                }
                if (Convert.ToInt32(ViewState["periods"]) == (Convert.ToInt32(txtafterlunch.Text) + Convert.ToInt32(txtnoofperiod.Text)))
                {
                    trshowbtn.Visible = true;
                    td1.Visible = true;
                    GridView1.Visible = true;
                    GridView1.DataSource = null;
                    GridView1.DataBind();
                    binggridfortime();
                    btnCreate.Enabled = true;
                }
                else if (Convert.ToInt32(ViewState["periods"]) < (Convert.ToInt32(txtafterlunch.Text) + Convert.ToInt32(txtnoofperiod.Text)))
                {
                    Utility.ViewAlertMessage(Page, "Number of periods cannot be greater than the specified periods!!");
                    fieldsetTableNoDistrict.Visible = false;
                    divbtn.Visible = false;
                    txtafterlunch.Text = string.Empty;
                    txtnoofperiod.Text = string.Empty;
                    txtnoofperiod.Focus();
                    return;
                }
                else
                {
                    Utility.ViewAlertMessage(Page, "Number of periods cannot be less than the specified periods!!");
                    fieldsetTableNoDistrict.Visible = false;
                    divbtn.Visible = false;
                    txtafterlunch.Text = string.Empty;
                    txtnoofperiod.Text = string.Empty;
                    txtnoofperiod.Focus();
                    return;
                }
            }
        }
        else
        {
            Session["state"] = null;
            GridView1.Visible = false;
            GridView1.DataSource = null;
            GridView1.DataBind();
            trshowbtn.Visible = false;
            txtnoofperiod.Text = "";
            txtafterlunch.Text = "";
            bindddl();
            td1.Visible = false;
        }
    }

    protected void ddlendhour_SelectedIndexChanged(object sender, EventArgs e)
    {
        int rowindex = 0, rowindex1 = 0, res = 0, rowcount = 0;
        rowcount = GridView1.Rows.Count;
        DropDownList ddl2;
        string time = "", previoustime = "", query = "";
        DropDownList ddl1st = (DropDownList)sender;
        GridViewRow gvrow = (GridViewRow)ddl1st.Parent.Parent;
        rowindex = gvrow.RowIndex;
        rowindex1 = rowindex + 1;
        time = ddl1st.SelectedItem.Text;
        DropDownList ddlprevious = (DropDownList)GridView1.Rows[rowindex].FindControl("ddlstarthour");
        if (rowcount > rowindex1)
        {
            ddl2 = (DropDownList)GridView1.Rows[rowindex1].FindControl("ddlstarthour");
            previoustime = ddlprevious.SelectedItem.Text;
            query = "select dbo.[TimeValidation]('" + previoustime + "','" + time + "')";
            res = Convert.ToInt32(objDUT.GetScalar(query));
            if (res == 1)
            {
                ddl2.SelectedIndex = findindex1(time);
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "Start time cannot be greater than end time!!");
                ddl2.SelectedIndex = 0;
                ddl1st.SelectedIndex = 0;
                return;
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        GridView1.Visible = false;
        GridView1.DataSource = null;
        GridView1.DataBind();
        trshowbtn.Visible = false;
        txtnoofperiod.Text = "";
        txtafterlunch.Text = "";
        bindddl();
        td1.Visible = false;
    }

    protected bool CheckValidations()
    {
        ViewState["time"] = 0;
        if (txtnoofperiod.Text == "")
        {
            Utility.ViewAlertMessage(Page, "Enter No of period Before lunch");
            return false;
        }
        if (txtafterlunch.Text == "")
        {
            Utility.ViewAlertMessage(Page, "Enter No of period after lunch");
            return false;
        }
        if (!objut.IsNumeric(txtnoofperiod.Text))
        {
            Utility.ViewAlertMessage(Page, "Enter no. of period Before lunch numeric");
            return false;
        }
        if (!objut.IsNumeric(txtafterlunch.Text))
        {
            Utility.ViewAlertMessage(Page, "Enter no. of period after lunch numeric");
            return false;
        }
        foreach (GridViewRow gvrow in GridView1.Rows)
        {
            string time = "", previoustime = "", query = "";
            int res = 0, rowcount = 0, rowindex = 0;
            rowcount = GridView1.Rows.Count;
            rowindex = gvrow.RowIndex;
            DropDownList ddl1 = (DropDownList)gvrow.FindControl("ddlstarthour");
            DropDownList ddl2 = (DropDownList)gvrow.FindControl("ddlendhour");
            TextBox tb1 = (TextBox)gvrow.FindControl("txtauto");
            TextBox tb2 = (TextBox)gvrow.FindControl("txtauto1");
            if ((ddl1.SelectedItem.Text) == (ddl2.SelectedItem.Text))
            {
                Utility.ViewAlertMessage(this.Master.Page, "Start time and end time cannot be same!!");
                tb1.Focus();
                return false;
            }
            previoustime = ddl1.SelectedItem.Text;
            time = ddl2.SelectedItem.Text;
            query = "select dbo.[TimeValidation]('" + previoustime + "','" + time + "')";
            res = Convert.ToInt32(objDUT.GetScalar(query));
            if (res != 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Start time cannot be greater than end time!!");
                tb1.Focus();
                return false;
            }
            if (rowcount == (rowindex + 1))
            {
                if (ddl2.SelectedItem.Text != ddlTo.SelectedItem.Text)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "School end time must be " + ddlTo.SelectedItem.Text + "!!");
                    tb2.Focus();
                    return false;
                }
            }
        }
        return true;
    }
}