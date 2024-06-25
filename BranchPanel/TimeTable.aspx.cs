using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_TimeTable : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private string type, query1 = "", query2 = "", query3 = "", query4 = "", query5 = "", query6 = "", query = "", names = "";
    private DataTable dt, dtlist, dtday, dtPeriod, dtsubject, dtteacher, dts;
    private int count = 0, i = 0, q = 0, forsaturday = 0, fullday1 = 1, fullcount = 1, rowindex = 0, rowindex1 = 0;
    private string PageName, url, idfullday = string.Empty, fulltime = string.Empty;
    private int count1 = 0, classid = 0, secid = 0, did = 0, per = 0, ab = 0, result = 0;
    private string subjid = string.Empty, period = string.Empty, teacherid = string.Empty, dayid = string.Empty;

    #region PageLoad

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!IsPostBack)
        {
            PageLoadHide();
            FillClass(Convert.ToInt32(Session["BrBrid"]));
        }
    }

    #endregion PageLoad

    #region For Showing and hiding Controls

    protected void PageLoadHide()
    {
        divsection.Visible = false;
        divdays.Visible = false;
        divperiod.Visible = false;
        divscheduletype.Visible = false;
        divGrids.Visible = false;
        grdLateStudents.DataSource = null;
        grdLateStudents.DataBind();
        GRDSTUDENT.DataSource = null;
        GRDSTUDENT.DataBind();
        rbgender.ClearSelection();
        grdDay.DataSource = null;
        grdDay.DataBind();
        grdPeriod.DataSource = null;
        grdPeriod.DataBind();
        lblDayname.Text = "";
        lblPeriod.Text = "";
        divdayWise.Visible = false;
        divperiodwise.Visible = false;
        divbtn.Visible = false;
        SimplifyRows();
    }

    protected void ClearForClass()
    {
        ddlSection.Items.Clear();
        ddlPeriod.Items.Clear();
        ddlSection.Items.Insert(0, new ListItem("--Select Section--", "0"));
        ddlPeriod.Items.Insert(0, new ListItem("--Select Period--", "0"));
        rbgender.ClearSelection();
        divbtn.Visible = false;
        SimplifyRows();
    }

    protected void ClearforSection()
    {
        grdteacher.Visible = false;
        divsection.Visible = true;
        divdays.Visible = false;
        divperiod.Visible = false;
        divscheduletype.Visible = false;
        divGrids.Visible = false;
        rbgender.ClearSelection();
        grdDay.DataSource = null;
        grdDay.DataBind();
        grdPeriod.DataSource = null;
        grdPeriod.DataBind();
        lblDayname.Text = "";
        lblPeriod.Text = "";
        divdayWise.Visible = false;
        divperiodwise.Visible = false;
        divbtn.Visible = false;
        SimplifyRows();
    }

    protected void ShowForSection()
    {
        divscheduletype.Visible = true;
        divGrids.Visible = true;
        rbgender.ClearSelection();
    }

    protected void ClearForRadioButton()
    {
        grdteacher.Visible = false;
        divdays.Visible = false;
        divperiod.Visible = false;
        divdayWise.Visible = false;
        divperiodwise.Visible = false;
        grdDay.DataSource = null;
        grdDay.DataBind();
        grdPeriod.DataSource = null;
        grdPeriod.DataBind();
        lblDayname.Text = "";
        lblPeriod.Text = "";
        ddlDays.SelectedIndex = 0;
        divbtn.Visible = false;
        SimplifyRows();
    }

    #endregion For Showing and hiding Controls

    #region Binding and Simplifying MEthods

    private void SubjectsTeacherGrids(int classid, int brid)
    {
        query1 = "select eid,UPPER((fname+' '+ISNULL(MName,'')+' '+lname))as name from tblEmp_Master where desigtype=2 and status=1 and brid=" + brid + " and eid in (select eid from tblTeacherSubjectMapping where status=1 and brid=" + brid + "and classid=" + classid + " )";
        dt = objdut.GetDataTable(query1);
        if (dt.Rows.Count > 0)
        {
            GRDSTUDENT.DataSource = dt;
            GRDSTUDENT.DataBind();
        }
        else
        {
            GRDSTUDENT.EmptyDataText = "No faculty found for this class!!";
            GRDSTUDENT.DataSource = null;
            GRDSTUDENT.DataBind();
        }
        dt.Dispose();

        query2 = "select classname,subjectname from classsubject_master where status=1 and classid=" + classid + "";
        dt = objdut.GetDataTable(query2);
        if (dt.Rows.Count > 0)
        {
            grdLateStudents.DataSource = dt;
            grdLateStudents.DataBind();
        }
        else
        {
            grdLateStudents.EmptyDataText = "No subject found for this class!!";
            grdLateStudents.DataSource = null;
            grdLateStudents.DataBind();
        }
        dt.Dispose();
    }

    protected void FillClass(int brid)
    {
        query = "select classid,Classname from ClassBranch_master where branchid=" + brid + " and status=1";
        dt = objdut.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "classname";
            ddlClass.DataValueField = "classid";
            ddlClass.DataBind();
            ddlClass.Items.Insert(0, new ListItem("--Select Class--", "0"));
        }
        dt.Dispose();
    }

    protected string SubjectNames(int eid, int brid)
    {
        query = @"select (stuff((select ','+cast(sm.SubjectName+'('+cm.Classname+')' as varchar(max))  from tblTeacherSubjectMapping tsm join Subject_Master sm on sm.id=tsm.subjectID join Class_Master cm on tsm.classID=cm.id
                  where sm.status=1 and tsm.status=1 and cm.Status=1 and tsm.brid=" + brid + " and tsm.eid=" + eid + " order by tsm.classID  for xml path('')),1,1,''))";
        names = Convert.ToString(objdut.GetScalar(query));
        return names;
    }

    protected void HighlightRow(string comparestring)
    {
        foreach (GridViewRow grow in grdLateStudents.Rows)
        {
            Label lbl = (Label)grow.FindControl("Label2");
            if (lbl.Text.ToLower() == comparestring.ToLower())
            {
                grow.BackColor = System.Drawing.Color.SkyBlue;
            }
            else
            {
                grow.BackColor = System.Drawing.Color.White;
            }
        }
        foreach (GridViewRow grow in GRDSTUDENT.Rows)
        {
            Label lbl = (Label)grow.FindControl("lbllnk1");
            if (lbl.Text.Contains(comparestring))
            {
                grow.BackColor = System.Drawing.Color.SkyBlue;
            }
            else
            {
                grow.BackColor = System.Drawing.Color.White;
            }
        }
    }

    protected void SimplifyRows()
    {
        //foreach (GridViewRow grow in grdLateStudents.Rows)
        //{
        //    grow.BackColor = System.Drawing.Color.White;
        //}
        //foreach (GridViewRow grow in GRDSTUDENT.Rows)
        //{
        //    grow.BackColor = System.Drawing.Color.White;
        //}
    }

    protected int periodCount()
    {
        count = 0;
        query2 = "select periods from tbl_schoolsettings where status=1";
        count = Convert.ToInt32(objdut.GetScalar(query2));
        return count;
    }

    #endregion Binding and Simplifying MEthods

    #region IndexChanged Events

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlClass.SelectedIndex != 0)
        {
            PageLoadHide();
            query = "select count(cwsid) from classwithsection where classid=" + ddlClass.SelectedValue + " and branchid=" + Convert.ToInt16(Session["BrBrid"]) + " and status=1";
            q = Convert.ToInt32(objdut.GetScalar(query));
            if (q > 0)
            {
                query = "select cwsid,sectionname from classwithsection where classid=" + ddlClass.SelectedValue + " and status=1 and branchid=" + Convert.ToInt16(Session["BrBrid"]);
                dt = objdut.GetDataTable(query);
                if (dt.Rows.Count > 0)
                {
                    ddlSection.DataSource = dt;
                    ddlSection.DataTextField = "sectionname";
                    ddlSection.DataValueField = "cwsid";
                    ddlSection.DataBind();
                    ddlSection.Items.Insert(0, new ListItem("--Select Section--", "0"));
                }
                dt.Dispose();
                divsection.Visible = true;
                SubjectsTeacherGrids(Convert.ToInt32(ddlClass.SelectedValue), Convert.ToInt32(Session["BrBrid"]));
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No section exist against this class. First add section!!");
                ddlClass.SelectedIndex = 0;
                return;
            }
        }
        else
        {
            ClearForClass();
            PageLoadHide();
        }
    }

    protected void ddlSection_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSection.SelectedIndex != 0)
        {
            ClearforSection();
            ShowForSection();
        }
        else
        {
            ClearforSection();
        }
    }

    protected void rbgender_SelectedIndexChanged(object sender, EventArgs e)
    {
        ClearForRadioButton();
        if (rbgender.SelectedIndex == 0)
        {
            divdays.Visible = true;
        }
        else
        {
            divperiod.Visible = true;
            i = periodCount();
            ddlPeriod.DataSource = GeneratePeriods(i);
            ddlPeriod.DataTextField = "name";
            ddlPeriod.DataValueField = "id";
            ddlPeriod.DataBind();
            ddlPeriod.Items.Insert(0, new ListItem("--Select Period--", "0"));
        }
    }

    protected void ddlDays_SelectedIndexChanged(object sender, EventArgs e)
    {
        grdteacher.Visible = false;
        int classid = Convert.ToInt32(ddlClass.SelectedValue);
        int secid = Convert.ToInt32(ddlSection.SelectedValue);
        int did = Convert.ToInt32(ddlDays.SelectedValue);

        SimplifyRows();

        if (ddlDays.SelectedIndex != 0)
        {
            divbtn.Visible = true;
            divdayWise.Visible = true;
            lblDayname.Text = "Create schedule for " + ddlDays.SelectedItem.Text;
            grdDay.DataSource = GridForDay(Convert.ToInt32(Session["BrBrid"]));
            grdDay.DataBind();
        }
        else
        {
            divbtn.Visible = false;
            grdDay.DataSource = null;
            grdDay.DataBind();
            lblDayname.Text = "";
            divdayWise.Visible = false;
        }
    }

    protected void ddlSubject1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;
        GridViewRow gvrow = (GridViewRow)ddl.Parent.Parent;
        rowindex = gvrow.RowIndex;
        DropDownList teacher = (DropDownList)grdDay.Rows[rowindex].FindControl("ddlTeacher1");
        if (ddl.SelectedIndex != 0)
        {
            teacher.Items.Clear();
            dt = GetTeachers(Convert.ToInt32(ddlClass.SelectedValue), Convert.ToInt32(ddl.SelectedValue), Convert.ToInt32(Session["BrBrid"]));
            if (dt.Rows.Count > 0)
            {
                teacher.Enabled = true;
                teacher.DataSource = dt;
                teacher.DataTextField = "fname";
                teacher.DataValueField = "eid";
                teacher.DataBind();
                teacher.Items.Insert(0, new ListItem("--Select Teacher--", "0"));
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No teacher exist for the selected subject of the class.");
                teacher.Items.Insert(0, new ListItem("--Select Teacher--", "0"));
                teacher.Enabled = false;
                return;
            }
            dt.Dispose();
        }
        else
        {
            teacher.Items.Clear();
            teacher.Items.Insert(0, new ListItem("--Select Teacher--", "0"));
            teacher.Enabled = false;
        }
        HighlightRow(ddl.SelectedItem.Text);
    }

    protected void ddlSubject2_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList ddl = (DropDownList)sender;
        GridViewRow gvrow = (GridViewRow)ddl.Parent.Parent;
        rowindex = gvrow.RowIndex;
        DropDownList teacher = (DropDownList)grdPeriod.Rows[rowindex].FindControl("ddlTeacher2");
        if (ddl.SelectedIndex != 0)
        {
            teacher.Items.Clear();
            dt = GetTeachers(Convert.ToInt32(ddlClass.SelectedValue), Convert.ToInt32(ddl.SelectedValue), Convert.ToInt32(Session["BrBrid"]));
            if (dt.Rows.Count > 0)
            {
                teacher.Enabled = true;
                teacher.DataSource = dt;
                teacher.DataTextField = "fname";
                teacher.DataValueField = "eid";
                teacher.DataBind();
                teacher.Items.Insert(0, new ListItem("--Select Teacher--", "0"));
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No teacher exist for the selected subject of the class.");
                teacher.Items.Insert(0, new ListItem("--Select Teacher--", "0"));
                teacher.Enabled = false;
                return;
            }
            dt.Dispose();
        }
        else
        {
            teacher.Items.Clear();
            teacher.Items.Insert(0, new ListItem("--Select Teacher--", "0"));
            teacher.Enabled = false;
        }
    }

    protected void ddlPeriod_SelectedIndexChanged(object sender, EventArgs e)
    {
        grdteacher.Visible = false;
        SimplifyRows();
        if (ddlPeriod.SelectedIndex != 0)
        {
            divperiodwise.Visible = true;
            divbtn.Visible = true;
            lblPeriod.Text = "Create schedule for " + ddlPeriod.SelectedItem.Text;
            grdPeriod.DataSource = GridForPeriod(Convert.ToInt32(Session["BrBrid"]), ddlPeriod.SelectedValue);
            grdPeriod.DataBind();
        }
        else
        {
            divbtn.Visible = false;
            grdPeriod.DataSource = null;
            grdPeriod.DataBind();
            lblPeriod.Text = "";
            divperiodwise.Visible = false;
        }
    }

    protected void ddlTeacher1_SelectedIndexChanged(object sender, EventArgs e)
    {
        grdteacher.Visible = false;
        int classid = Convert.ToInt32(ddlClass.SelectedValue);
        int secid = Convert.ToInt32(ddlSection.SelectedValue);
        int did = Convert.ToInt32(ddlDays.SelectedValue);
        DropDownList ddl = (DropDownList)sender;
        GridViewRow gvrow = (GridViewRow)ddl.Parent.Parent;
        rowindex = gvrow.RowIndex;
        DropDownList teacher = (DropDownList)grdDay.Rows[rowindex].FindControl("ddlTeacher1");
        HiddenField hftchr = (HiddenField)grdDay.Rows[rowindex].FindControl("hfteachr");
        Label lblperiod = (Label)grdDay.Rows[rowindex].FindControl("lblsub");
        Label lblmsg = (Label)grdDay.Rows[rowindex].FindControl("lblmssg");
        lblmsg.Visible = false;
        int prd = Convert.ToInt32(lblperiod.Text);

        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@classid", Convert.ToInt32(ddlClass.SelectedValue));
        param[1] = new SqlParameter("@periodid", prd);
        param[2] = new SqlParameter("@teacherid", Convert.ToInt32(ddl.SelectedValue));
        param[3] = new SqlParameter("@did", ddlDays.SelectedValue);
        param[4] = new SqlParameter("@brid", Session["BrBrid"]);
        DataTable dt = objdut.GetDataTableSP(param, "usp_engageteacher");
        if (dt.Rows.Count > 0)
        {
            lblmsg.Visible = true;
            lblmsg.Text = "Engaged";
            grdteacher.Visible = true;
            grdteacher.DataSource = dt;
            grdteacher.DataBind();
            foreach (GridViewRow grow in grdteacher.Rows)
            {
                grow.BackColor = System.Drawing.Color.SkyBlue;
            }
        }
        else
        {
            grdteacher.EmptyDataText = "No Record.";
        }
        //getteacherinfo();
    }

    protected void GRDSTUDENT_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hf = (HiddenField)e.Row.FindControl("hdnsub");
            Label lbl = (Label)e.Row.FindControl("lbllnk1");
            lbl.Text = SubjectNames(Convert.ToInt32(hf.Value), Convert.ToInt32(Session["BrBrid"]));
        }
    }

    #endregion IndexChanged Events

    #region Getting DataTables

    protected DataTable GeneratePeriods(int numberofPeriods)
    {
        DynamicTable Dt = new DynamicTable();
        dtlist = Dt.CreateDataSource();
        for (int i = 1; i <= numberofPeriods; i++)
        {
            Dt.AddRow(i, "Period " + i.ToString(), dtlist);
        }
        return dtlist;
    }

    protected DataTable GridForDay(int brid)
    {
        query3 = "select period,(starttime+'-'+endtime) as timing from timeperiod where status=1 and brid=" + brid + " and period not in ('a','l')";
        dtday = objdut.GetDataTable(query3);
        return dtday;
    }

    protected DataTable GridForPeriod(int brid, string period)
    {
        query6 = @"select did,dayname,period,(starttime+'-'+endtime) as timing from timeperiod,days where days.status=1 and timeperiod.status=1 and timeperiod.brid=" + brid + " and " +
                   "timeperiod.period='" + period + "'";
        dtteacher = objdut.GetDataTable(query6);
        return dtteacher;
    }

    protected DataTable GetSubjects(int classid)
    {
        query4 = "select subjectname,subjectid from classsubject_master where status=1 and classid=" + classid;
        dtsubject = objdut.GetDataTable(query4);
        return dtsubject;
    }

    protected DataTable GetTeachers(int classid, int subjectid, int brid)
    {
        query5 = @"select eid,UPPER((fname+' '+ISNULL(MName,'')+' '+lname))as fname from tblEmp_Master where desigtype=2 and status=1 and brid=" + brid + " and " +
                   "eid in (select eid from tblTeacherSubjectMapping where status=1 and brid=" + brid + " and classid=" + classid + " and subjectID=" + subjectid + ")";
        dtteacher = objdut.GetDataTable(query5);
        return dtteacher;
    }

    #endregion Getting DataTables

    #region RowDataBound Events

    protected void grdDay_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlSubject = (DropDownList)e.Row.FindControl("ddlSubject1");
            DropDownList ddlTeacher = (DropDownList)e.Row.FindControl("ddlTeacher1");
            Label lblperiod = (Label)e.Row.FindControl("lblsub");
            classid = Convert.ToInt32(ddlClass.SelectedValue);
            secid = Convert.ToInt32(ddlSection.SelectedValue);
            did = Convert.ToInt32(ddlDays.SelectedValue);
            per = Convert.ToInt32(lblperiod.Text);
            ab = Convert.ToInt32(objdut.GetScalar("select count(*) from schedule_master where status=1 and did=" + did + " and classid=" + classid + " and sectionid=" + secid + " and period=" + per + " and brid=" + Session["BrBrid"]));
            if (ab == 0)
            {
                ddlSubject.DataSource = GetSubjects(Convert.ToInt32(ddlClass.SelectedValue));
                ddlSubject.DataTextField = "subjectname";
                ddlSubject.DataValueField = "subjectid";
                ddlSubject.DataBind();
                ddlSubject.Items.Insert(0, new ListItem("--Select Subject--", "0"));
                ddlTeacher.Items.Insert(0, new ListItem("--Select Teacher--", "0"));
                ddlTeacher.Enabled = false;
            }
            else
            {
                names = "select empid,subjectid from schedule_master where status=1 and did=" + did + " and classid=" + classid + " and  period=" + per + " and sectionid=" + secid + " and brid=" + Session["BrBrid"];
                dts = objdut.GetDataTable(names);
                if (dts.Rows.Count > 0)
                {
                    ddlSubject.DataSource = GetSubjects(Convert.ToInt32(ddlClass.SelectedValue));
                    ddlSubject.DataTextField = "subjectname";
                    ddlSubject.DataValueField = "subjectid";
                    ddlSubject.DataBind();
                    ddlSubject.Items.Insert(0, new ListItem("--Select Subject--", "0"));
                    ddlSubject.SelectedValue = dts.Rows[0]["subjectid"].ToString();
                    ddlTeacher.Items.Clear();
                    if (ddlSubject.SelectedValue != "0")
                    {
                        dt = GetTeachers(Convert.ToInt32(ddlClass.SelectedValue), Convert.ToInt32(ddlSubject.SelectedValue), Convert.ToInt32(Session["BrBrid"]));
                        if (dt.Rows.Count > 0)
                        {
                            ddlTeacher.Enabled = true;
                            ddlTeacher.DataSource = dt;
                            ddlTeacher.DataTextField = "fname";
                            ddlTeacher.DataValueField = "eid";
                            ddlTeacher.DataBind();
                            ddlTeacher.Items.Insert(0, new ListItem("--Select Teacher--", "0"));
                            ddlTeacher.SelectedValue = dts.Rows[0]["empid"].ToString();
                        }
                    }
                    else
                    {
                        ddlTeacher.Enabled = false;
                        ddlTeacher.Items.Insert(0, new ListItem("--Select Teacher--", "0"));
                    }
                }
            }
        }
    }

    protected void grdPeriod_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlSubject = (DropDownList)e.Row.FindControl("ddlSubject2");
            DropDownList ddlTeacher = (DropDownList)e.Row.FindControl("ddlTeacher2");
            HiddenField lblperiod = (HiddenField)e.Row.FindControl("HiddenField1");
            HiddenField hh = (HiddenField)e.Row.FindControl("hfday");
            classid = Convert.ToInt32(ddlClass.SelectedValue);
            secid = Convert.ToInt32(ddlSection.SelectedValue);
            did = Convert.ToInt32(hh.Value);
            per = Convert.ToInt32(lblperiod.Value);
            ab = Convert.ToInt32(objdut.GetScalar("select count(*) from schedule_master where status=1 and did=" + did + " and classid=" + classid + " and sectionid=" + secid + " and period=" + per + " and brid=" + Session["BrBrid"]));
            if (ab == 0)
            {
                ddlSubject.DataSource = GetSubjects(Convert.ToInt32(ddlClass.SelectedValue));
                ddlSubject.DataTextField = "subjectname";
                ddlSubject.DataValueField = "subjectid";
                ddlSubject.DataBind();
                ddlSubject.Items.Insert(0, new ListItem("--Select Subject--", "0"));
                ddlTeacher.Items.Insert(0, new ListItem("--Select Teacher--", "0"));
                ddlTeacher.Enabled = false;
            }
            else
            {
                names = "select empid,subjectid from schedule_master where status=1 and did=" + did + " and classid=" + classid + " and  period=" + per + " and sectionid=" + secid + " and brid=" + Session["BrBrid"];
                dts = objdut.GetDataTable(names);
                if (dts.Rows.Count > 0)
                {
                    ddlSubject.DataSource = GetSubjects(Convert.ToInt32(ddlClass.SelectedValue));
                    ddlSubject.DataTextField = "subjectname";
                    ddlSubject.DataValueField = "subjectid";
                    ddlSubject.DataBind();
                    ddlSubject.Items.Insert(0, new ListItem("--Select Subject--", "0"));
                    ddlSubject.SelectedValue = dts.Rows[0]["subjectid"].ToString();
                    ddlTeacher.Items.Clear();
                    if (ddlSubject.SelectedValue != "0")
                    {
                        dt = GetTeachers(Convert.ToInt32(ddlClass.SelectedValue), Convert.ToInt32(ddlSubject.SelectedValue), Convert.ToInt32(Session["BrBrid"]));
                        if (dt.Rows.Count > 0)
                        {
                            ddlTeacher.Enabled = true;
                            ddlTeacher.DataSource = dt;
                            ddlTeacher.DataTextField = "fname";
                            ddlTeacher.DataValueField = "eid";
                            ddlTeacher.DataBind();
                            ddlTeacher.Items.Insert(0, new ListItem("--Select Teacher--", "0"));
                            ddlTeacher.SelectedValue = dts.Rows[0]["empid"].ToString();
                        }
                    }
                    else
                    {
                        ddlTeacher.Enabled = false;
                        ddlTeacher.Items.Insert(0, new ListItem("--Select Teacher--", "0"));
                    }
                }
            }
        }
    }

    #endregion RowDataBound Events

    #region Bool Validation

    protected bool testforday()
    {
        foreach (GridViewRow gvrow in grdDay.Rows)
        {
            DropDownList subjectddl = (DropDownList)gvrow.FindControl("ddlSubject1");
            DropDownList teacherddl = (DropDownList)gvrow.FindControl("ddlTeacher1");
            if (subjectddl.SelectedIndex > 0)
            {
                if (teacherddl.SelectedIndex == 0)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Please select teacher against selected subject.");
                    teacherddl.Focus();
                    return false;
                }
            }
        }
        return true;
    }

    protected bool testforPeriod()
    {
        foreach (GridViewRow gvrow in grdPeriod.Rows)
        {
            DropDownList subjectddl = (DropDownList)gvrow.FindControl("ddlSubject2");
            DropDownList teacherddl = (DropDownList)gvrow.FindControl("ddlTeacher2");
            if (subjectddl.SelectedIndex > 0)
            {
                if (teacherddl.SelectedIndex == 0)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Please select teacher against selected subject.");
                    teacherddl.Focus();
                    return false;
                }
            }
        }
        return true;
    }

    #endregion Bool Validation

    #region ButtonClick

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (rbgender.SelectedValue == "1")
        {
            if (testforday())
            {
                foreach (GridViewRow row in grdDay.Rows)
                {
                    Label lblperiod = (Label)row.FindControl("lblsub");
                    DropDownList ddlsubject = (DropDownList)row.FindControl("ddlSubject1");
                    DropDownList ddlteacher = (DropDownList)row.FindControl("ddlTeacher1");
                    period = period + "," + lblperiod.Text;
                    subjid = subjid + "," + ddlsubject.SelectedValue;
                    teacherid = teacherid + "," + ddlteacher.SelectedValue;
                }
                subjid = subjid.Remove(0, 1);
                period = period.Remove(0, 1);
                teacherid = teacherid.Remove(0, 1);
                SqlParameter[] param = new SqlParameter[8];
                param[0] = new SqlParameter("@classid", Convert.ToInt32(ddlClass.SelectedValue));
                param[1] = new SqlParameter("@sectionid", ddlSection.SelectedValue);
                param[2] = new SqlParameter("@periodid", period);
                param[3] = new SqlParameter("@subjectid", subjid);
                param[4] = new SqlParameter("@teacherid", teacherid);
                param[5] = new SqlParameter("@did", ddlDays.SelectedValue);
                param[6] = new SqlParameter("@brid", Session["BrBrid"]);
                param[7] = new SqlParameter("@intresult", SqlDbType.Int, 1);
                param[7].Direction = ParameterDirection.Output;
                result = objdut.ExecuteSqlSP(param, "usp_timetablesq");
                if (result == 0)
                {
                    Utility.ViewAlertMessage(Page, "Schedule created successfully for the selected day.");
                    PageLoadHide();
                    FillClass(Convert.ToInt32(Session["BrBrid"]));
                    return;
                }
                else
                {
                    Utility.ViewAlertMessage(Page, "Some Error");
                    return;
                }
            }
        }
        else
        {
            if (testforPeriod())
            {
                foreach (GridViewRow row in grdPeriod.Rows)
                {
                    HiddenField hfdid = (HiddenField)row.FindControl("hfday");
                    DropDownList ddlsubject = (DropDownList)row.FindControl("ddlSubject2");
                    DropDownList ddlteacher = (DropDownList)row.FindControl("ddlTeacher2");
                    dayid = dayid + "," + hfdid.Value;
                    subjid = subjid + "," + ddlsubject.SelectedValue;
                    teacherid = teacherid + "," + ddlteacher.SelectedValue;
                }
                subjid = subjid.Remove(0, 1);
                dayid = dayid.Remove(0, 1);
                teacherid = teacherid.Remove(0, 1);
                SqlParameter[] param = new SqlParameter[8];
                param[0] = new SqlParameter("@classid", Convert.ToInt32(ddlClass.SelectedValue));
                param[1] = new SqlParameter("@sectionid", ddlSection.SelectedValue);
                param[2] = new SqlParameter("@dayid", dayid);
                param[3] = new SqlParameter("@subjectid", subjid);
                param[4] = new SqlParameter("@teacherid", teacherid);
                param[5] = new SqlParameter("@periodid", ddlPeriod.SelectedValue);
                param[6] = new SqlParameter("@brid", Session["BrBrid"]);
                param[7] = new SqlParameter("@intresult", SqlDbType.Int, 1);
                param[7].Direction = ParameterDirection.Output;
                result = objdut.ExecuteSqlSP(param, "usp_timetableperiod");
                if (result == 0)
                {
                    Utility.ViewAlertMessage(Page, "Schedule created successfully for the selected Period..");
                    PageLoadHide();
                    FillClass(Convert.ToInt32(Session["BrBrid"]));
                    return;
                }
                else
                {
                    Utility.ViewAlertMessage(Page, "Some Error");
                    return;
                }
            }
        }
    }

    #endregion ButtonClick

    protected void grdteacher_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (ddlDays.SelectedIndex != 0)
        {
            string str = ddlDays.SelectedItem.Text;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lbl = (Label)e.Row.FindControl("lblddy");
                lbl.Text = str;
            }
        }
        else
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lbl = (Label)e.Row.FindControl("lblddy");
                lbl.Text = Convert.ToString(ViewState["day"]);
            }
        }
    }

    protected void ddlTeacher2_SelectedIndexChanged(object sender, EventArgs e)
    {
        grdteacher.Visible = false;
        int classid = Convert.ToInt32(ddlClass.SelectedValue);
        int secid = Convert.ToInt32(ddlSection.SelectedValue);
        int periodid = Convert.ToInt32(ddlPeriod.SelectedValue);
        DropDownList ddl = (DropDownList)sender;
        GridViewRow gvrow = (GridViewRow)ddl.Parent.Parent;
        rowindex = gvrow.RowIndex;
        DropDownList teacher = (DropDownList)grdPeriod.Rows[rowindex].FindControl("ddlTeacher2");
        // HiddenField hftchr = (HiddenField)grdDay.Rows[rowindex].FindControl("hfteachr");
        Label lbldy = (Label)grdPeriod.Rows[rowindex].FindControl("lblsub1");
        HiddenField hfdid = (HiddenField)grdPeriod.Rows[rowindex].FindControl("hfday");
        Label lblmsg = (Label)grdPeriod.Rows[rowindex].FindControl("lblmg");
        lblmsg.Visible = false;
        string dayname = lbldy.Text;
        ViewState["day"] = dayname;
        int ddid = Convert.ToInt32(hfdid.Value);

        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@classid", Convert.ToInt32(ddlClass.SelectedValue));
        param[1] = new SqlParameter("@periodid", ddlPeriod.SelectedValue);
        param[2] = new SqlParameter("@teacherid", Convert.ToInt32(ddl.SelectedValue));
        param[3] = new SqlParameter("@dayname", dayname);
        param[4] = new SqlParameter("@did", ddid);
        param[5] = new SqlParameter("@brid", Session["BrBrid"]);
        DataTable dt = objdut.GetDataTableSP(param, "usp_engageperiodteacher");
        if (dt.Rows.Count > 0)
        {
            lblmsg.Visible = true;
            lblmsg.Text = "Engaged";
            grdteacher.Visible = true;
            grdteacher.DataSource = dt;
            grdteacher.DataBind();
            foreach (GridViewRow grow in grdteacher.Rows)
            {
                grow.BackColor = System.Drawing.Color.SkyBlue;
            }
        }
        else
        {
            grdteacher.EmptyDataText = "No Record.";
        }
        dt.Dispose();
    }
}