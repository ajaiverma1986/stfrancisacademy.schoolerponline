using System;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;
using System.Web.UI.WebControls;

public partial class BranchPanel_Attendence1 : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();
    private Utility objUT = new Utility();
    private CommonClass CommmonOBJ = new CommonClass();
    private int days = 0, actualmonth = 0, i = 0;
    private string Pstudentid = "", Astudentid = "";
    private string PageName = "", url = "";
    private SqlParameter[] param = new SqlParameter[8];

    protected void Page_Load(object sender, EventArgs e)
    {
        txtDAyname.Text = "Day";
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        // PageName = Utility.GetCurrentPagename();

        //if (!objUT.isAccessible(((User)Session["BrUser"]).UserID, PageName))
        //{
        //    Response.Redirect("~/Login.aspx");
        //}

        if (!IsPostBack)
        {
            int fyid = Convert.ToInt32(objDUT.GetScalar("select fyid from financial_Year where isActive=1 and isClosed=0"));
            ViewState["fyid"] = fyid;
            DDL_Class_Bind();
            bind_month();
            DDLMonth.Enabled = false;
            ddldays.Enabled = false;
            txtDAyname.Text = "Day";
            tr1.Visible = false;
            btnBack.Visible = false;
            if (Request.QueryString.Count > 0)
            {
                btnSubmit.Visible = false;
                btnBack.Visible = true;
                tr1.Visible = true;
                DDLClass.Enabled = false;
                DDLSection.Enabled = false;
                DDLMonth.Enabled = false;
                ddldays.Enabled = false;
                int SECID = Convert.ToInt32(Request.QueryString[0]);
                ViewState["SECID"] = SECID;
                showAttendance();
            }
            //this.PopulateStudentDetails();
        }
    }

    private void DDL_Class_Bind()
    {
        DataTable dt = CommmonOBJ.Dll("ClassInBranch", Convert.ToInt32(Session["BrBrid"])); //objDUT.GetDataTable(query);
        DDLClass.DataSource = dt;
        DDLClass.DataBind();
        DDLClass.DataTextField = "Classname";
        DDLClass.DataValueField = "classid";
        DDLClass.DataBind();
        DDLClass.Items.Insert(0, "--Select Class--");
        DDLSection.Items.Insert(0, "--Select Section--");
        //DDLClass.Items.Add(0, "--Select--");
    }

    private void bind_month()
    {
        DataTable dt = CommmonOBJ.Dll("MonthName");
        DDLMonth.DataSource = dt;
        DDLMonth.DataBind();
        DDLMonth.DataTextField = "MonthName";
        DDLMonth.DataValueField = "MonthId";
        DDLMonth.DataBind();

        DDLMonth.Items.Insert(0, "--Select Month--");
        ddldays.Items.Insert(0, "--Date--");
    }

    protected void DDLClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        DDLSection.Items.Clear();
        tr1.Visible = false;
        GrdAttendence.DataSource = null;
        GrdAttendence.DataBind();
        txtDAyname.Text = "Day";
        if (DDLClass.SelectedValue == "--Select Class--")
        {
            DDLSection.Items.Insert(0, "--Select Section--");
            DDLMonth.SelectedValue = "--Select Month--";
            ddldays.SelectedValue = "--Date--";
            DDLMonth.Enabled = false;
            ddldays.Enabled = false;
        }
        else
        {
            DataTable dt = CommmonOBJ.Dll("sectiondll", Convert.ToInt32(DDLClass.SelectedValue), Convert.ToInt32(Session["BrBrid"])); //objDUT.GetDataTable(query);
            DDLSection.DataSource = dt;
            DDLSection.DataBind();
            DDLSection.DataTextField = "sectionname";
            DDLSection.DataValueField = "cwsid";
            DDLSection.DataBind();
            DDLSection.Items.Insert(0, "--Select Section--");
            DDLMonth.SelectedValue = "--Select Month--";
            ddldays.SelectedValue = "--Date--";
            DDLMonth.Enabled = false;
            ddldays.Enabled = false;
            //  GRDV_Attendence.Visible = false;
        }
    }

    protected void DDLSection_SelectedIndexChanged(object sender, EventArgs e)
    {
        tr1.Visible = false;
        GrdAttendence.DataSource = null;
        GrdAttendence.DataBind();
        if (DDLSection.SelectedValue == "--Select Section--")
        {
            DDLMonth.Enabled = false;
            DDLMonth.SelectedValue = "--Select Month--";
            ddldays.SelectedValue = "--Date--";
            DDLMonth.Enabled = false;
            ddldays.Enabled = false;
            txtDAyname.Text = "Day";
            // GRDV_Attendence.Visible = false;
        }
        else
        {
            DDLMonth.Enabled = true;
        }
    }

    protected void DDLMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        int currentYear = 0;
        tr1.Visible = false;
        GrdAttendence.DataSource = null;
        GrdAttendence.DataBind();
        ddldays.SelectedValue = "--Date--";
        txtDAyname.Text = "Day";
        if (DDLMonth.SelectedValue != "--Select Month--")
        {
            ddldays.Enabled = true;
            days = CommonClass.Scaler("getdays", Convert.ToInt32(DDLMonth.SelectedValue));
            if (Convert.ToInt32(DDLMonth.SelectedValue) <= 9)
            {
                currentYear = Convert.ToInt32(objDUT.GetScalar("select startingyear from financial_year where isActive=1 and isClosed=0"));
            }
            else
            {
                currentYear = Convert.ToInt32(objDUT.GetScalar("select endyear from financial_year where isActive=1 and isClosed=0"));
            }
            if (objUT.isLeapYear(currentYear))
            {
                if (DDLMonth.SelectedValue == "11")
                {
                    days = 29;
                }
            }
            ddldays.Items.Clear();
            ddldays.Items.Insert(0, "--Date--");
            for (int i = 1; i <= days; i++)
            {
                ddldays.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
            ViewState["currentyear"] = currentYear;
        }
        else
        {
            ddldays.SelectedValue = "--Date--";
            txtDAyname.Text = "Day";
            ddldays.Enabled = false;
        }
    }

    protected void ddldays_SelectedIndexChanged(object sender, EventArgs e)
    {
        // chkall.Checked = false;
        if (ddldays.SelectedValue != "--Date--")
        {
            string date = ddldays.SelectedItem.Text + "-" + DDLMonth.SelectedItem.Text + "-" + ViewState["currentyear"].ToString();
            string dayName = CommmonOBJ.stringType("dayName", date);
            ViewState["Dayname"] = dayName;
            txtDAyname.Text = dayName;
            if (dayName == "Sunday")
            {
                Utility.ViewAlertMessage(Page, "Sorry, Today is Sunday");
                ddldays.SelectedValue = "--Date--";
                txtDAyname.Text = "Day";
                ddldays.Focus();
                tr1.Visible = false;
                GrdAttendence.DataSource = null;
                GrdAttendence.DataBind();
                return;
            }
            //Check Whether Attendence has been taken or not
            string query1 = "select isnull(COUNT(*),0) from tbl_attendance where FYID=" + ViewState["currentyear"] + " and BRID=" + Session["BrBrid"] + " and MONTHID=" + DDLMonth.SelectedValue + " and CLASSID=" + DDLClass.SelectedValue + " and CWSID=" + DDLSection.SelectedValue + " and DATE=" + ddldays.SelectedValue;
            if (Convert.ToInt32(objDUT.GetScalar(query1)) > 0)
            {
                // Utility.ViewAlertMessage(Page, "Sorry, Attendence has been taken already of selected day");
                // ddldays.SelectedValue = "--Date--";
                // GrdAttendence.DataSource = null;
                // GrdAttendence.DataBind();
                // return;
            }
            if (Convert.ToInt32(DDLMonth.SelectedValue) <= 9)
            {
                actualmonth = Convert.ToInt32(DDLMonth.SelectedValue) + 3;
            }
            else
            {
                actualmonth = Convert.ToInt32(DDLMonth.SelectedValue) - 9;
            }

            string getdate = actualmonth.ToString() + "-" + ddldays.SelectedValue + "-" + ViewState["currentyear"].ToString();

            string query = @"select (FirstName+' '+ISNULL(MiddleName,' ')+' '+LastName) as name, ta.adid,isnull(ta1.attendance,0) as attendance ,
    case when attendance=1 then 'P' else 'A' end as state  from tbl_Admission ta left outer
    join tbl_attendance ta1 on ta.classid=" + DDLClass.SelectedValue + " and ta1.ADID=ta.adid and ta1.MONTHID=" + DDLMonth.SelectedValue + " and ta1.DATE=" + ddldays.SelectedValue + @" join student_master on student_master.sturegno=ta.sturegno where
 ta.fyid=" + ViewState["fyid"] + " and ta.Brid=" + Session["BrBrid"] + " and ta.classid=" + DDLClass.SelectedValue + " and ta.sectionid=" + DDLSection.SelectedValue + " and ta.admissiondate<'" + getdate + "'  order by adid";

            DataTable dt = objDUT.GetDataTable(query);
            if (dt.Rows.Count > 0)
            {
                tr1.Visible = true;
                GrdAttendence.DataSource = dt;
                GrdAttendence.DataBind();
            }

            string query2 = "select isnull(COUNT(*),0) from tbl_attendance where FYID=" + ViewState["fyid"] + " and BRID=" + Session["BrBrid"] + " and MONTHID=" + DDLMonth.SelectedValue + " and CLASSID=" + DDLClass.SelectedValue + " and CWSID=" + DDLSection.SelectedValue + " and DATE=" + ddldays.SelectedValue;
            if (Convert.ToInt32(objDUT.GetScalar(query2)) > 0)
            {
                foreach (GridViewRow gvrow in GrdAttendence.Rows)
                {
                    Label lbn = (Label)gvrow.FindControl("lbmssg");
                    CheckBox chk = (CheckBox)gvrow.FindControl("chkclass");
                    if (dt.Rows[i]["state"].ToString() == "P")
                    {
                        chk.Checked = false;
                    }
                    else
                    {
                        chk.Checked = true;
                        lbn.Text = "Absent";
                    }

                    i++;
                }
            }
        }
        else
        {
            txtDAyname.Text = "Day";
            tr1.Visible = false;
            GrdAttendence.DataSource = null;
            GrdAttendence.DataBind();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Validate1())
        {
            int count = 0, count1 = 0;
            Pstudentid = "";
            Astudentid = "";
            foreach (GridViewRow gvrow in GrdAttendence.Rows)
            {
                CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
                Label classname = (Label)gvrow.FindControl("lblclass");
                HiddenField hd1 = (HiddenField)gvrow.FindControl("HD1");
                if (chkdelete.Checked)
                {
                    count = count + 1;

                    Pstudentid = Pstudentid + "," + hd1.Value;
                }
                else
                {
                    count1 = count1 + 1;
                    Astudentid = Astudentid + "," + hd1.Value;
                }
            }
            if (count != 0)
            {
                Pstudentid = Pstudentid.Remove(0, 1);
            }
            if (count1 != 0)
            {
                Astudentid = Astudentid.Remove(0, 1);
            }

            param[0] = new SqlParameter("@brid", Session["BrBrid"]);
            param[1] = new SqlParameter("@classID", DDLClass.SelectedValue);
            param[2] = new SqlParameter("@cwsid", DDLSection.SelectedValue);
            param[3] = new SqlParameter("@monthid", DDLMonth.SelectedValue);
            param[4] = new SqlParameter("@date", ddldays.SelectedValue);
            param[5] = new SqlParameter("@PstudentID", Astudentid);
            param[6] = new SqlParameter("@Astudentid", Pstudentid);

            param[7] = new SqlParameter("@intResult", Convert.ToInt32("0"));
            param[7].Direction = ParameterDirection.Output;

            int intresult = objDUT.ExecuteSqlSP(param, "usp_tblAttendence1");
            if (intresult > 0)
            {
                Utility.ViewAlertMessage(Page, "Attendence has been taken Successfully.");
                txtDAyname.Text = ViewState["Dayname"].ToString();
                // Response.Redirect("Attendence1.aspx");
            }
        }
    }

    public bool Validate1()
    {
        if (DDLClass.SelectedValue == "--Select Class--")
        {
            Utility.ViewAlertMessage(Page, "please select class first");
            // DDLClass.Attributes.Remove("class");
            // DDLClass.CssClass = "abhi";
            DDLClass.Attributes.Add("class", "abhi");
            DDLClass.Focus();
            return false;
        }
        if (DDLSection.SelectedValue == "--Select Section--")
        {
            Utility.ViewAlertMessage(Page, "please select section first");
            DDLSection.Attributes.Remove("class");
            DDLSection.CssClass = "abhi";
            DDLSection.Focus();

            return false;
        }
        if (DDLMonth.SelectedValue == "--Select Month--")
        {
            Utility.ViewAlertMessage(Page, "please select Month.");
            return false;
        }
        if (ddldays.SelectedValue == "--Date--")
        {
            Utility.ViewAlertMessage(Page, "please select date.");
            return false;
        }
        return true;
    }

    protected void showAttendance()
    {
        string qu1 = "select classid,classname,sectionname,cwsid from classwithsection where cwsid=" + Convert.ToInt32(ViewState["SECID"]) + "";
        DataTable dt = objDUT.GetDataTable(qu1);
        if (dt.Rows.Count > 0)
        {
            DDLClass.SelectedValue = dt.Rows[0]["classid"].ToString();
            DDLSection.SelectedItem.Text = dt.Rows[0]["sectionname"].ToString();
            DDLMonth.SelectedValue = Session["Month"].ToString();
            ddldays.SelectedItem.Text = Session["Date"].ToString();
            txtDAyname.Text = Session["Day"].ToString();

            string qu2 = @"select (FirstName+' '+ISNULL(MiddleName,' ')+' '+LastName) as name, ta.adid,isnull(ta1.attendance,0) as attendance ,
									 case when attendance=1 then 'P' else 'A' end as state  from tbl_Admission ta left outer
                                     join tbl_attendance ta1 on ta.classid=" + DDLClass.SelectedValue + " and ta1.ADID=ta.adid and ta1.MONTHID=" + DDLMonth.SelectedValue + " and ta1.DATE=" + ddldays.SelectedItem.Text + @" join student_master on student_master.sturegno=ta.sturegno
									    where ta.fyid=" + ViewState["fyid"] + " and ta.classid=" + DDLClass.SelectedValue + " and ta.Brid=" + Session["BrBrid"] + "  and  ta.sectionid=" + Convert.ToInt32(ViewState["SECID"]) + " order by adid";
            DataTable dt1 = objDUT.GetDataTable(qu2);
            if (dt1.Rows.Count > 0)
            {
                btnBack.Visible = true;
                btnSubmit.Enabled = false;
                tr1.Visible = true;
                GrdAttendence.DataSource = dt1;
                GrdAttendence.DataBind();
            }
            foreach (GridViewRow gvrow in GrdAttendence.Rows)
            {
                Label lbn = (Label)gvrow.FindControl("lbmssg");
                CheckBox chk = (CheckBox)gvrow.FindControl("chkclass");
                if (dt1.Rows[i]["state"].ToString() == "P")
                {
                    chk.Checked = false;
                    chk.Enabled = false;
                }
                else
                {
                    chk.Checked = true;
                    chk.Enabled = false;
                    lbn.Text = "Absent";
                }

                i++;
            }
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "There was problem fetching data. Please try again.");
            return;
        }
    }

    protected void btnBack_Click1(object sender, EventArgs e)
    {
        PropertyInfo obj = typeof(System.Collections.Specialized.NameValueCollection).GetProperty("IsReadOnly", BindingFlags.Instance | BindingFlags.NonPublic);
        obj.SetValue(this.Request.QueryString, false, null);
        this.Request.QueryString.Clear();
        Response.Redirect("DaywiseAttendence.aspx");
    }

    //protected void chkall_CheckedChanged(object sender, EventArgs e)
    //{
    //    foreach (GridViewRow gvrow in GrdAttendence.Rows)
    //    {
    //        //Finiding checkbox control in gridview for particular row
    //        CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
    //        if (chkall.Checked)
    //        {
    //            txtDAyname.Text = ViewState["Dayname"].ToString();
    //            chkdelete.Checked = true;
    //        }
    //        else
    //        {
    //            txtDAyname.Text = ViewState["Dayname"].ToString();
    //            chkdelete.Checked = false;
    //        }
    //    }
    //}

    protected void chkclass_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GrdAttendence.Rows)
        {
            Label lbn = (Label)row.FindControl("lbmssg");
            CheckBox chk = (CheckBox)row.FindControl("chkclass");
            if (chk.Checked == true)
            {
                lbn.Text = "Absent";
            }
            else
            {
                lbn.Text = "";
            }
        }
    }
}