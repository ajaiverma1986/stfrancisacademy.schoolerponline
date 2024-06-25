using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class BranchPanel_classschedule : System.Web.UI.Page
{
    private string fulltime = string.Empty;
    private string idfullday = string.Empty;
    private string PageName;
    private Utility objut = new Utility();
    private DataUtility objDUT = new DataUtility();
    private string url;
    private int i;
    private int forsaturday = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        PageName = Utility.GetCurrentPagename();

        if (!objut.isAccessible(((User)Session["BrUser"]).UserID, PageName))
        {
            //Response.Redirect("~/Login.aspx");
        }
        if (!IsPostBack)
        {
            bindclasswithsection();
            bindgridfortime();
        }
    }

    private void bindclasswithsection()
    {
        DataTable dt = new DataTable();
        dt = objDUT.GetDataTable("select * from ClassBranch_master where branchid=" + Session["BrBrid"] + " and status=1");
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dt1 in dt.Rows)
            {
                string fullname = dt1["classname"].ToString();
                ListItem li = new ListItem(fullname, dt1["classid"].ToString());
                ddlwithsection.Items.Add(li);
            }
            ddlwithsection.Items.Insert(0, new ListItem("---Select---", "0"));
        }
        else
        {
            lblmsg.Text = "First Create Class";
            return;
        }
    }

    private void bindgridfortime()
    {
        DataTable dt = new DataTable();
        DataTable dt1 = new DataTable();
        dt = objDUT.GetDataTable("select pid,period,(starttime+'---'+endtime) as time,starttime,endtime from timeperiod where status=1 and brid=" + Session["BrBrid"]);

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["period"].ToString() == "L")
            {
                dt1 = dt.Clone();
                DataRow[] copyrows = dt.Select("period='L'");
                foreach (DataRow copyrow in copyrows)
                    dt1.ImportRow(copyrow);

                dt.Rows[i].Delete();
                dt.AcceptChanges();
            }
        }
        ////count = dt.Rows.Count;
        ////count = count / 2;
        ////count = count + 1;
        for (int j = 0; j < dt.Rows.Count; j++)
        {
            if (dt.Rows[j]["endtime"].ToString() == dt1.Rows[0]["starttime"].ToString())
            {
                foreach (DataRow row1 in dt1.Rows)
                {
                    DataRow dr = dt.NewRow();
                    dr.ItemArray = row1.ItemArray;
                    dt.Rows.InsertAt(dr, j + 1);
                    dt.AcceptChanges();
                }
            }
        }

        grdscheduletime.DataSource = dt;
        grdscheduletime.DataBind();
    }

    protected void ddlwithsection_SelectedIndexChanged(object sender, EventArgs e)
    {
        grdtable.Visible = false;
        DataTable dtclassid = new DataTable();
        dtclassid = objDUT.GetDataTable(" select cwsid,sectionname from classwithsection where classid=" + ddlwithsection.SelectedValue + " and status=1 and branchid=" + (Session["BrBrid"]) + "");
        if (dtclassid.Rows.Count == 0)
        {
            Utility.ViewAlertMessage(Page, "No Section of this class");
            return;
        }
        ddlsection.DataSource = dtclassid;
        ddlsection.DataTextField = "sectionname";
        ddlsection.DataValueField = "cwsid";
        ddlsection.DataBind();
        ddlsection.Items.Insert(0, new ListItem("--Select --", "0"));
    }

    protected void ddlsection_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dtnew = new DataTable();
        if (ddlsection.SelectedIndex == 0)
        {
            grdtable.Visible = false;
            return;
        }
        grdtable.Visible = true;

        foreach (GridViewRow row in grdscheduletime.Rows)
        {
            Label lblperiod = (Label)row.FindControl("lblperiod");

            Label ddlSubjec1 = (Label)row.FindControl("ddlSubject1");
            Label ddlTeache1 = (Label)row.FindControl("ddlTeacher1");
            Label ddlSubjec2 = (Label)row.FindControl("ddlSubject2");
            Label ddlTeache2 = (Label)row.FindControl("ddlTeacher2");
            Label ddlSubjec3 = (Label)row.FindControl("ddlSubject3");
            Label ddlTeache3 = (Label)row.FindControl("ddlTeacher3");
            Label ddlSubjec4 = (Label)row.FindControl("ddlSubject4");
            Label ddlTeache4 = (Label)row.FindControl("ddlTeacher4");
            Label ddlSubjec = (Label)row.FindControl("ddlSubject5");
            Label ddlTeache = (Label)row.FindControl("ddlTeacher5");
            Label ddlSubjec6 = (Label)row.FindControl("ddlSubject6");
            Label ddlTeache6 = (Label)row.FindControl("ddlTeacher6");

            if (lblperiod.Text == "A")
            {
                ddlSubjec.Text = "";
                ddlTeache.Text = "";
                ddlSubjec1.Text = "";
                ddlTeache1.Text = "";
                ddlSubjec2.Text = "";
                ddlTeache2.Text = "";
                ddlSubjec3.Text = "";
                ddlTeache3.Text = "";
                ddlSubjec4.Text = "";
                ddlTeache4.Text = "";
                ddlSubjec6.Text = "";
                ddlTeache6.Text = "";
            }
            else if (lblperiod.Text == "L")
            {
                ddlSubjec.Text = "";
                ddlTeache.Text = "";
                ddlSubjec1.Text = "";
                ddlTeache1.Text = "";
                ddlSubjec2.Text = "";
                ddlTeache2.Text = "";
                ddlSubjec3.Text = "";
                ddlTeache3.Text = "";
                ddlSubjec4.Text = "";
                ddlTeache4.Text = "";
                ddlSubjec6.Text = "";
                ddlTeache6.Text = "";
            }
            else
            {
                ddlSubjec.Text = "N/A";
                ddlTeache.Text = "";
                ddlSubjec1.Text = "N/A";
                ddlTeache1.Text = "";
                ddlSubjec2.Text = "N/A";
                ddlTeache2.Text = "";
                ddlSubjec3.Text = "N/A";
                ddlTeache3.Text = "";
                ddlSubjec4.Text = "N/A";
                ddlTeache4.Text = "";
                ddlSubjec6.Text = "N/A";
                ddlTeache6.Text = "";
            }
        }

        int forhalf = 0;
        foreach (GridViewRow row in grdscheduletime.Rows)
        {
            Label lblperiod = (Label)row.FindControl("lblperiod");

            Label ddlSubjec1 = (Label)row.FindControl("ddlSubject1");
            Label ddlTeache1 = (Label)row.FindControl("ddlTeacher1");
            Label ddlSubjec2 = (Label)row.FindControl("ddlSubject2");
            Label ddlTeache2 = (Label)row.FindControl("ddlTeacher2");
            Label ddlSubjec3 = (Label)row.FindControl("ddlSubject3");
            Label ddlTeache3 = (Label)row.FindControl("ddlTeacher3");
            Label ddlSubjec4 = (Label)row.FindControl("ddlSubject4");
            Label ddlTeache4 = (Label)row.FindControl("ddlTeacher4");
            Label ddlSubjec = (Label)row.FindControl("ddlSubject5");
            Label ddlTeache = (Label)row.FindControl("ddlTeacher5");
            Label ddlSubjec6 = (Label)row.FindControl("ddlSubject6");
            Label ddlTeache6 = (Label)row.FindControl("ddlTeacher6");

            if (lblperiod.Text == "A")
            {
                ddlSubjec.Text = "";
                ddlTeache.Text = "";
                ddlSubjec1.Text = "";
                ddlTeache1.Text = "";
                ddlSubjec2.Text = "";
                ddlTeache2.Text = "";
                ddlSubjec3.Text = "";
                ddlTeache3.Text = "";
                ddlSubjec4.Text = "";
                ddlTeache4.Text = "";
                ddlSubjec6.Text = "";
                ddlTeache6.Text = "";
            }
            else if (lblperiod.Text == "L")
            {
                forhalf = 1;
                ddlSubjec.Text = "";
                ddlTeache.Text = "";
                ddlSubjec1.Text = "";
                ddlTeache1.Text = "";
                ddlSubjec2.Text = "";
                ddlTeache2.Text = "";
                ddlSubjec3.Text = "";
                ddlTeache3.Text = "";
                ddlSubjec4.Text = "";
                ddlTeache4.Text = "";
                ddlSubjec6.Text = "";
                ddlTeache6.Text = "";
            }
            else
            {
                int subjectcount = 1;

                dtnew = objDUT.GetDataTable(@"select distinct sm.period,sm.section,cm.Classname,sm.did,sbm.Subjectname,UPPER((tem.title+' '+tem.fname+' '+ISNULL(tem.MName,'')+''+tem.lname))as name from schedule_master sm inner join Class_Master cm
                                         on cm.id=sm.classid inner join timeperiod t on t.pid=sm.pid left outer join tblEmp_Master tem on tem.eid=sm.empid left outer join SubjectBranch_master sbm
                                         on sbm.Subjectid=sm.subjectid where sm.brid=" + Session["BrBrid"] + " and sm.period=" + lblperiod.Text + @" and sm.sectionid=" + ddlsection.SelectedValue + " and sm.classid=" + ddlwithsection.SelectedValue);

                //               dtnew = objDUT.GetDataTable(@"select tp.period,cws.classname,cws.sectionname,sbm.Subjectname,sm.did,(tem.title+' '+ tem.fname+' '+ISNULL(tem.lname,'')) as name from schedule_master sm,timeperiod tp,
                //               classwithsection cws,SubjectBranch_master sbm,tblEmp_Master tem where sm.sectionid="+ddlsection.SelectedValue+" and sm.brid=1 and sm.period="+lblperiod.Text+@"
                //               and sm.classid="+ddlwithsection.SelectedValue+@" and sm.status=1
                //               and sm.pid=tp.pid and cws.cwsid=sm.sectionid and sbm.Subjectid=sm.subjectid and tem.eid=sm.empid group by tp.period,
                //               cws.classname,cws.sectionname,sbm.Subjectname,sm.did,tem.title, tem.fname,tem.lname order by sm.did ");

                foreach (DataRow rowdata in dtnew.Rows)
                {
                    string subject = "ddlSubject" + subjectcount;
                    string teacher = "ddlTeacher" + subjectcount;
                    //Label ddlSubject = (Label)this.Master.FindControl("ContentPlaceHolder1").FindControl(subject);
                    //Label ddlTeacher = (Label)this.Master.FindControl("ContentPlaceHolder1").FindControl(teacher);

                    Label ddlSubject = (Label)row.FindControl(subject);
                    Label ddlTeacher = (Label)row.FindControl(teacher);

                    if (rowdata["Subjectname"].ToString() != "")
                    {
                        ddlSubject.Text = rowdata["Subjectname"].ToString();
                        ddlTeacher.Text = rowdata["name"].ToString();
                    }
                    else
                    {
                        ddlSubject.Text = "N/A";
                        ddlTeacher.Text = "";
                    }

                    if (forhalf == 1 && subjectcount == 6)
                    {
                        int sresult = Convert.ToInt32(objDUT.GetScalar("select COUNT(*) from workingdays where wdid=6 and fullday=0"));
                        if (sresult > 0)
                        {
                            ddlSubject.Text = "";
                            ddlTeacher.Text = "";
                        }
                    }
                    subjectcount = subjectcount + 1;
                }
                subjectcount = 1;
            }
        }
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        Response.Redirect("classschedule.aspx");
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
        Response.Redirect("teacherschedule.aspx");
    }
}