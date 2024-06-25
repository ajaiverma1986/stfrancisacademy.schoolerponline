using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class BranchPanel_teacherschedule : System.Web.UI.Page
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
            bindteacher();
            bindgridfortime();
        }
    }

    private void bindteacher()
    {
        DataTable dt = new DataTable();
        dt = objDUT.GetDataTable("select eid,(title+' '+fName+' '+ISNULL(lName,'')) as name from tblEmp_Master where brid=" + Session["BrBrid"] + " and status=1");
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dt1 in dt.Rows)
            {
                string fullname = dt1["name"].ToString();
                ListItem li = new ListItem(fullname, dt1["eid"].ToString());
                ddlteacher.Items.Add(li);
            }
            ddlteacher.Items.Insert(0, new ListItem("---Select---", "0"));
        }
        else
        {
            lblmsg.Text = "Select Teacher";
            return;
        }
    }

    private void bindgridfortime()
    {
        int count;
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

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (ddlteacher.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(Page, "Select Teacher");
            return;
        }

        grdtable.Visible = true;

        foreach (GridViewRow row in grdscheduletime.Rows)
        {
            Label l = (Label)row.FindControl("lblperiod");
            Label ddlclass1 = (Label)row.FindControl("ddlclass");
            Label ddlsection1 = (Label)row.FindControl("ddlsection");
            Label ddlsubject1 = (Label)row.FindControl("ddlSubject");

            Label ddlclass2 = (Label)row.FindControl("ddlclass1");
            Label ddlsection2 = (Label)row.FindControl("ddlsection1");
            Label ddlsubject2 = (Label)row.FindControl("ddlSubject1");

            Label ddlclass3 = (Label)row.FindControl("ddlclass2");
            Label ddlsection3 = (Label)row.FindControl("ddlsection2");
            Label ddlsubject3 = (Label)row.FindControl("ddlSubject2");

            Label ddlclass4 = (Label)row.FindControl("ddlclass3");
            Label ddlsection4 = (Label)row.FindControl("ddlsection3");
            Label ddlsubject4 = (Label)row.FindControl("ddlSubject3");

            Label ddlclass5 = (Label)row.FindControl("ddlclass4");
            Label ddlsection5 = (Label)row.FindControl("ddlsection4");
            Label ddlsubject5 = (Label)row.FindControl("ddlSubject4");

            Label ddlclass6 = (Label)row.FindControl("ddlclass5");
            Label ddlsection6 = (Label)row.FindControl("ddlsection5");
            Label ddlsubject6 = (Label)row.FindControl("ddlSubject5");
            if (l.Text == "A")
            {
                ddlclass1.Text = "";
                ddlsection1.Text = "";
                ddlsubject1.Text = "";

                ddlclass2.Text = "";
                ddlsection2.Text = "";
                ddlsubject2.Text = "";

                ddlclass3.Text = "";
                ddlsection3.Text = "";
                ddlsubject3.Text = "";

                ddlclass4.Text = "";
                ddlsection4.Text = "";
                ddlsubject4.Text = "";

                ddlclass5.Text = "";
                ddlsection5.Text = "";
                ddlsubject5.Text = "";

                ddlclass6.Text = "";
                ddlsection6.Text = "";
                ddlsubject6.Text = "";
            }
            else if (l.Text == "L")
            {
                ddlclass1.Text = "";
                ddlsection1.Text = "";
                ddlsubject1.Text = "";

                ddlclass2.Text = "";
                ddlsection2.Text = "";
                ddlsubject2.Text = "";

                ddlclass3.Text = "";
                ddlsection3.Text = "";
                ddlsubject3.Text = "";

                ddlclass4.Text = "";
                ddlsection4.Text = "";
                ddlsubject4.Text = "";

                ddlclass5.Text = "";
                ddlsection5.Text = "";
                ddlsubject5.Text = "";

                ddlclass6.Text = "";
                ddlsection6.Text = "";
                ddlsubject6.Text = "";
            }
            else
            {
                ddlclass1.Text = "N/A";
                ddlsection1.Text = "";
                ddlsubject1.Text = "";

                ddlclass2.Text = "N/A";
                ddlsection2.Text = "";
                ddlsubject2.Text = "";

                ddlclass3.Text = "N/A";
                ddlsection3.Text = "";
                ddlsubject3.Text = "";

                ddlclass4.Text = "N/A";
                ddlsection4.Text = "";
                ddlsubject4.Text = "";

                ddlclass5.Text = "N/A";
                ddlsection5.Text = "";
                ddlsubject5.Text = "";

                ddlclass6.Text = "N/A";
                ddlsection6.Text = "";
                ddlsubject6.Text = "";
            }
        }

        foreach (GridViewRow row in grdscheduletime.Rows)
        {
            Label l = (Label)row.FindControl("lblperiod");
            Label ddlclass1 = (Label)row.FindControl("ddlclass");
            Label ddlsection1 = (Label)row.FindControl("ddlsection");
            Label ddlsubject1 = (Label)row.FindControl("ddlSubject");

            Label ddlclass2 = (Label)row.FindControl("ddlclass1");
            Label ddlsection2 = (Label)row.FindControl("ddlsection1");
            Label ddlsubject2 = (Label)row.FindControl("ddlSubject1");

            Label ddlclass3 = (Label)row.FindControl("ddlclass2");
            Label ddlsection3 = (Label)row.FindControl("ddlsection2");
            Label ddlsubject3 = (Label)row.FindControl("ddlSubject2");

            Label ddlclass4 = (Label)row.FindControl("ddlclass3");
            Label ddlsection4 = (Label)row.FindControl("ddlsection3");
            Label ddlsubject4 = (Label)row.FindControl("ddlSubject3");

            Label ddlclass5 = (Label)row.FindControl("ddlclass4");
            Label ddlsection5 = (Label)row.FindControl("ddlsection4");
            Label ddlsubject5 = (Label)row.FindControl("ddlSubject4");

            Label ddlclass6 = (Label)row.FindControl("ddlclass5");
            Label ddlsection6 = (Label)row.FindControl("ddlsection5");
            Label ddlsubject6 = (Label)row.FindControl("ddlSubject5");

            DataTable dtnew = new DataTable();
            if (l.Text == "A")
            {
                ddlclass1.Text = "";
                ddlsection1.Text = "";
                ddlsubject1.Text = "";

                ddlclass2.Text = "";
                ddlsection2.Text = "";
                ddlsubject2.Text = "";

                ddlclass3.Text = "";
                ddlsection3.Text = "";
                ddlsubject3.Text = "";

                ddlclass4.Text = "";
                ddlsection4.Text = "";
                ddlsubject4.Text = "";

                ddlclass5.Text = "";
                ddlsection5.Text = "";
                ddlsubject5.Text = "";

                ddlclass6.Text = "";
                ddlsection6.Text = "";
                ddlsubject6.Text = "";
            }
            else if (l.Text == "L")
            {
                ddlclass1.Text = "";
                ddlsection1.Text = "";
                ddlsubject1.Text = "";

                ddlclass2.Text = "";
                ddlsection2.Text = "";
                ddlsubject2.Text = "";

                ddlclass3.Text = "";
                ddlsection3.Text = "";
                ddlsubject3.Text = "";

                ddlclass4.Text = "";
                ddlsection4.Text = "";
                ddlsubject4.Text = "";

                ddlclass5.Text = "";
                ddlsection5.Text = "";
                ddlsubject5.Text = "";

                ddlclass6.Text = "";
                ddlsection6.Text = "";
                ddlsubject6.Text = "";
            }
            else
            {
                dtnew = objDUT.GetDataTable(@" select cws.cwsid,cws.sectionname,cbm.classid,cbm.Classname,sbm.Subjectid,sbm.Subjectname,sm.did from schedule_master sm,ClassBranch_master cbm,classwithsection cws,
                    SubjectBranch_master sbm where sm.empid=" + ddlteacher.SelectedValue + " and sm.brid=" + Session["BrBrid"] + " and  sm.period=" + l.Text + @" and sm.classid=cbm.classid
                     and sm.brid=cbm.BranchId and cws.cwsid=sm.sectionid
                  and cws.branchid=sm.brid and sm.subjectid=sbm.Subjectid and sm.brid=sbm.BranchId group by cws.cwsid,cws.sectionname,cbm.classid,cbm.Classname,sbm.Subjectid,sbm.Subjectname,sm.did order by sm.did ");

                foreach (DataRow rowdata in dtnew.Rows)
                {
                    if ("1" == rowdata["did"].ToString())
                    {
                        //string ddlclass = "ddlclass1" ;
                        //string ddlsection = "ddlsection1" ;
                        //string ddlsubject = "ddlSubject1" ;
                        //Label ddlSubject = (Label)this.Master.FindControl("ContentPlaceHolder1").FindControl(subject);
                        //Label ddlTeacher = (Label)this.Master.FindControl("ContentPlaceHolder1").FindControl(teacher);

                        Label ddlclas = (Label)row.FindControl("ddlclass");
                        Label ddlsectio = (Label)row.FindControl("ddlsection");
                        Label ddlsubjec = (Label)row.FindControl("ddlSubject");

                        ddlclas.Text = rowdata["Classname"].ToString();
                        ddlsectio.Text = "---" + rowdata["sectionname"].ToString();
                        ddlsubjec.Text = rowdata["Subjectname"].ToString();
                    }
                    if ("2" == rowdata["did"].ToString())
                    {
                        //string ddlclass = "ddlclass1" ;
                        //string ddlsection = "ddlsection1" ;
                        //string ddlsubject = "ddlSubject1" ;
                        //Label ddlSubject = (Label)this.Master.FindControl("ContentPlaceHolder1").FindControl(subject);
                        //Label ddlTeacher = (Label)this.Master.FindControl("ContentPlaceHolder1").FindControl(teacher);

                        Label ddlclas1 = (Label)row.FindControl("ddlclass1");
                        Label ddlsectio1 = (Label)row.FindControl("ddlsection1");
                        Label ddlsubjec1 = (Label)row.FindControl("ddlSubject1");

                        ddlclas1.Text = rowdata["Classname"].ToString();
                        ddlsectio1.Text = "---" + rowdata["sectionname"].ToString();
                        ddlsubjec1.Text = rowdata["Subjectname"].ToString();
                    }
                    if ("3" == rowdata["did"].ToString())
                    {
                        //string ddlclass = "ddlclass1" ;
                        //string ddlsection = "ddlsection1" ;
                        //string ddlsubject = "ddlSubject1" ;
                        //Label ddlSubject = (Label)this.Master.FindControl("ContentPlaceHolder1").FindControl(subject);
                        //Label ddlTeacher = (Label)this.Master.FindControl("ContentPlaceHolder1").FindControl(teacher);

                        Label ddlclas2 = (Label)row.FindControl("ddlclass2");
                        Label ddlsectio2 = (Label)row.FindControl("ddlsection2");
                        Label ddlsubjec2 = (Label)row.FindControl("ddlSubject2");

                        ddlclas2.Text = rowdata["Classname"].ToString();
                        ddlsectio2.Text = "---" + rowdata["sectionname"].ToString();
                        ddlsubjec2.Text = rowdata["Subjectname"].ToString();
                    }
                    if ("4" == rowdata["did"].ToString())
                    {
                        //string ddlclass = "ddlclass1" ;
                        //string ddlsection = "ddlsection1" ;
                        //string ddlsubject = "ddlSubject1" ;
                        //Label ddlSubject = (Label)this.Master.FindControl("ContentPlaceHolder1").FindControl(subject);
                        //Label ddlTeacher = (Label)this.Master.FindControl("ContentPlaceHolder1").FindControl(teacher);

                        Label ddlclas3 = (Label)row.FindControl("ddlclass3");
                        Label ddlsectio3 = (Label)row.FindControl("ddlsection3");
                        Label ddlsubjec3 = (Label)row.FindControl("ddlSubject3");

                        ddlclas3.Text = rowdata["Classname"].ToString();
                        ddlsectio3.Text = "---" + rowdata["sectionname"].ToString();
                        ddlsubjec3.Text = rowdata["Subjectname"].ToString();
                    }
                    if ("5" == rowdata["did"].ToString())
                    {
                        //string ddlclass = "ddlclass1" ;
                        //string ddlsection = "ddlsection1" ;
                        //string ddlsubject = "ddlSubject1" ;
                        //Label ddlSubject = (Label)this.Master.FindControl("ContentPlaceHolder1").FindControl(subject);
                        //Label ddlTeacher = (Label)this.Master.FindControl("ContentPlaceHolder1").FindControl(teacher);

                        Label ddlclas4 = (Label)row.FindControl("ddlclass4");
                        Label ddlsectio4 = (Label)row.FindControl("ddlsection4");
                        Label ddlsubjec4 = (Label)row.FindControl("ddlSubject4");

                        ddlclas4.Text = rowdata["Classname"].ToString();
                        ddlsectio4.Text = "---" + rowdata["sectionname"].ToString();
                        ddlsubjec4.Text = rowdata["Subjectname"].ToString();
                    }
                    if ("6" == rowdata["did"].ToString())
                    {
                        //string ddlclass = "ddlclass1" ;
                        //string ddlsection = "ddlsection1" ;
                        //string ddlsubject = "ddlSubject1" ;
                        //Label ddlSubject = (Label)this.Master.FindControl("ContentPlaceHolder1").FindControl(subject);
                        //Label ddlTeacher = (Label)this.Master.FindControl("ContentPlaceHolder1").FindControl(teacher);

                        Label ddlclas5 = (Label)row.FindControl("ddlclass5");
                        Label ddlsectio5 = (Label)row.FindControl("ddlsection5");
                        Label ddlsubjec5 = (Label)row.FindControl("ddlSubject5");

                        ddlclas5.Text = rowdata["Classname"].ToString();
                        ddlsectio5.Text = "---" + rowdata["sectionname"].ToString();
                        ddlsubjec5.Text = rowdata["Subjectname"].ToString();
                    }
                }
            }
            dtnew.Dispose();
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