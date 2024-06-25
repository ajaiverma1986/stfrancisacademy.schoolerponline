using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Exams_exam_settings : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable dt, dt1;
    private string marks = "", subid = "";
    private SqlParameter[] param = new SqlParameter[5];

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillexam();
            //fillMultipleschedule();
        }
    }

    public void addeventInRepeater()
    {
        string rpt1 = rptModule.ClientID;
        string chkpage = "chkpage";
        int rptModuleItemIndex = 0;
        foreach (RepeaterItem ri in rptModule.Controls)
        {
            if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
            {
                CheckBox chkmod = (CheckBox)ri.FindControl("chkmodule");
                Repeater rptForm1 = (Repeater)ri.FindControl("rptForm");
                int count = rptForm1.Items.Count;
                chkmod.Attributes.Add("onclick", "checkModule('" + rpt1 + "', " + count + ",'" + rptForm1.ClientID + "','" + chkmod.ClientID + "','" + chkpage + "');");
                int rptFormItemIndex = 0;
                foreach (RepeaterItem ri1 in rptForm1.Controls)
                {
                    if (ri1.ItemType == ListItemType.Item || ri1.ItemType == ListItemType.AlternatingItem)
                    {
                        string rpt2 = rptForm1.ClientID;
                        CheckBox chkp = (CheckBox)ri1.FindControl("chkpage");
                        TextBox txt = (TextBox)ri1.FindControl("txtbox");
                        //chkp.Attributes.Add("onclick", "document.getElementById('" + txt.ClientID + "').disabled = !this.checked;");
                        chkp.Attributes.Add("onclick", "checkPage('" + rpt1 + "'," + rptModuleItemIndex + "," + rptFormItemIndex + ",'" + rptForm1.ClientID + "','" + chkmod.ClientID + "','" + chkpage + "');");
                        rptFormItemIndex++;
                    }
                }
            }
            rptModuleItemIndex++;
        }
    }

    private void fillexam()
    {
        string q1 = @"Select DISTINCT eid,examname from exam_name
                inner join exam_class on exam_class.examid = exam_name.eid
                where exam_class.brid=" + Convert.ToInt32(Session["BrBrid"]) + " and exam_name.status=1";
        dt = objdut.GetDataTable(q1);
        if (dt.Rows.Count > 0)
        {
            ddltest.DataSource = dt;
            ddltest.DataTextField = "examname";
            ddltest.DataValueField = "eID";
            ddltest.DataBind();
            ddltest.Items.Insert(0, new ListItem("--Select exam--", "0"));
        }
    }

    protected void ddltest_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddltest.SelectedIndex > 0)
        {
            string q = "select Distinct cast((isnull(cm.status,0)) as bit)as status,cm.id,ec.classid,cm.Classname from exam_class ec"+
                       " left outer join Class_Master cm on ec.classid=cm.id where cm.id in (select classid from classsubject_master where status=1) and ec.Status=1 and brid=" + Session["BrBrid"] + " and examid=" + ddltest.SelectedValue;
            //            string q = @"select distinct Class_Master.classname,Class_Master.id,exam_shiftclasinfo.status
            //from Class_Master left outer join exam_shiftclasinfo on
            //
            // exam_shiftclasinfo.Classid=Class_Master.id and exam_shiftclasinfo.eid="+ddltest.SelectedValue+@"
            //  where Class_Master.id in (select classid from classsubject_master where status=1) and Class_Master.Status=1 and exam_shiftclasinfo.eid="+ddltest.SelectedValue+" and exam_shiftclasinfo.status=1";

            dt1 = objdut.GetDataTable(q);
            if (dt1.Rows.Count > 0)
            {
                rptModule.DataSource = dt1;
                rptModule.DataBind();
            }

            //int count = Convert.ToInt32(objdut.GetScalar("select shifting from Exam_shiftingMaster where eid="+ddltest.SelectedValue));
            //if (count == 1)
            //{
            //    dd1.Visible = false;
            //}
            //else
            //{
            //    dd1.Visible = true;
            //}
            addeventInRepeater();
        }
    }

    //private void fillMultipleschedule()
    //{
    //    string Query = "select did,dayname from days where status=1";
    //    DataTable dt_day = objdut.GetDataTable(Query);
    //    if (dt_day.Rows.Count > 0)
    //    {
    //        ddlftime.DataSource = GetTimeIntervals();
    //        ddlftime.DataBind();
    //        ddltotime.DataSource = GetTimeIntervals();
    //        ddltotime.DataBind();
    //    }
    //}

    //public List<string> GetTimeIntervals()
    //{
    //    List<string> timeIntervals = new List<string>();
    //    DateTime date = DateTime.MinValue.AddHours(6); // start at 6am
    //    DateTime endDate = DateTime.MinValue.AddDays(1).AddHours(6); // end at 5:45am (< 6am)

    //    while (date < endDate)
    //    {
    //        timeIntervals.Add(date.ToShortTimeString());
    //        date = date.AddMinutes(5);
    //    }
    //    return timeIntervals;
    //}
    protected void rptModule_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataTable dt2 = new DataTable();
            Repeater rptForm = (Repeater)e.Item.FindControl("rptForm");
            // string q = "select sbm.Subjectid,sbm.Subjectname,CAST((isnull(em.status,0)) as bit) as status from SubjectBranch_master sbm left outer join Exam_marksSetting em on em.subid=sbm.Subjectid and em.classid=sbm.classid  where em.classid=1 and em.BranchId=1 and sbm.status=1 ";
            string moduleId = ((Label)e.Item.FindControl("lblModuleId")).Text;
            //string q = " select distinct classsubject_master.subjectid,subjectname,classsubject_master.csmid,isnull(Exam_marksSetting.status,0) as status ,isnull(marks,0) 'marks' " +
            //           " from classsubject_master left outer join Exam_marksSetting on classsubject_master.classid=" + moduleId + "" +
            //           " and Exam_marksSetting.csmid=classsubject_master.csmid and Exam_marksSetting.eid=" + ddltest.SelectedValue + "" +
            //           " where classsubject_master.status=1 and classsubject_master.classid=" + moduleId + " and Exam_marksSetting.brid=" + Session["brBrid"] + "";

            string q = @"select distinct SubjectBranch_master.subjectid,subjectname,
                        isnull(Exam_marksSetting.Status,0) as status ,isnull(marks,0) 'marks'  
                        from SubjectBranch_master 
                        left outer join Exam_marksSetting on SubjectBranch_master.classid=1 and Exam_marksSetting.csmid=SubjectBranch_master.subjectid
                        and Exam_marksSetting.eid=" + ddltest.SelectedValue + " where SubjectBranch_master.Status=1 and SubjectBranch_master.classid=" + moduleId + " and SubjectBranch_master.branchid=" + Session["brBrid"] + " and SubjectBranch_master.SubjectName NOT IN('Health & Physical Education','Work Education','Discipline','Art Education')";

            dt2 = objdut.GetDataTable(q);
            if (dt2.Rows.Count > 0)
            {
                rptForm.DataSource = dt2;
                rptForm.DataBind();
            }
        }
    }
    protected void rptModule1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        //TextBox textbox = (TextBox)e.Item.FindControl("txtbox");
        //CheckBox chk = (CheckBox)e.Item.FindControl("chkpage");
        //chk.Attributes.Add("onclick", "document.getElementById('" + textbox.ClientID + "').disabled = !this.checked;");
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        int count = 0;
        foreach (RepeaterItem ri in rptModule.Items)
        {
            if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
            {
                CheckBox chkmodule = (CheckBox)ri.FindControl("chkmodule");
                if (chkmodule != null && chkmodule.Checked)
                {
                    count++;
                    break;
                }
            }
        }
        if (count <= 0)
        {
            Utility.ViewAlertMessage(Page, "Please select at least one fee type.");
            return;
        }
        else
        {
            foreach (RepeaterItem ri in rptModule.Items)
            {
                if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chkmodule = (CheckBox)ri.FindControl("chkmodule");
                    Label lblmoduleid = (Label)ri.FindControl("lblmoduleid");
                    if (chkmodule.Checked)
                    {
                        Repeater rptForm = (Repeater)ri.FindControl("rptForm");
                        foreach (RepeaterItem ri1 in rptForm.Items)
                        {
                            if (ri1.ItemType == ListItemType.Item || ri1.ItemType == ListItemType.AlternatingItem)
                            {
                                CheckBox chkpage = (CheckBox)ri1.FindControl("chkpage");
                                TextBox lblpageid = (TextBox)ri1.FindControl("txtbox");
                                HiddenField hd1 = (HiddenField)ri1.FindControl("HD1");

                                if (chkpage.Checked)
                                {
                                    subid = hd1.Value;
                                    marks = lblpageid.Text;

                                    param = new SqlParameter[5];

                                    param[0] = new SqlParameter("@eid", ddltest.SelectedValue);
                                    param[1] = new SqlParameter("@brid", Session["BrBrid"]);

                                    param[2] = new SqlParameter("@CSMID", subid);
                                    param[3 ] = new SqlParameter("@marks", Convert.ToDecimal(marks));

                                    param[4] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                                    param[4].Direction = ParameterDirection.Output;

                                    int intresult = objdut.ExecuteSqlSP(param, "usp_examsettings");

                                    if (intresult == 1)
                                    {
                                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Only alert Message');", true);

                                        grddiv.Visible = false;
                                    }
                                    else if (intresult == 0)
                                    {
                                        Utility.ViewAlertMessage(Page, "Error while saving the record.");
                                    }
                                }
                            }
                        }
                    }
                }
            }
            subid = subid.Remove(0, 1);
            marks = marks.Remove(0, 1);
        }

        
    }
}