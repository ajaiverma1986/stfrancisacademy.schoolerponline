using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_facultysubject : System.Web.UI.Page
{
    private int index, facultyID;
    private DataTable dt;
    private DataUtility objDUT = new DataUtility();
    private int count = 0;
    private SqlParameter[] param;
    private string feeid = string.Empty, url;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["facID"] == null)
        {
            Response.Redirect("viewfaculty.aspx");
        }
        if (!IsPostBack)
        {
            ViewState["facultyid"] = null;
            if (Session["facID"] != null)
            {
                getfacultyName();
                facultyID = Convert.ToInt32(Session["facID"]);
                ViewState["facultyid"] = facultyID;
            }
            fillclass();
            btn.Visible = false;
        }
    }

    public void getfacultyName()
    {
        String Facultyname = Convert.ToString(objDUT.GetScalar("select fname from tblEmp_Master where eid=" + Session["facID"]));
        txtfacultyname.Text = Facultyname;
    }

    private void fillclass()
    {
        string str = @" select Class_Master.classname,id,isnull(facultyclass_master.status,0) as status from Class_Master left outer join facultyclass_master on
                    facultyclass_master.Classid=Class_Master.id and facultyclass_master.eid=" + ViewState["facultyid"] + " where Class_Master.id in (select classid from classsubject_master where status=1) and Class_Master.Status=1 and facultyclass_master.status=1";
        dt = objDUT.GetDataTable(str);
        //dt = CommonClass.facultymaster("fillclass");
        if (dt.Rows.Count > 0)
        {
            rptfeetype.DataSource = dt;
            rptfeetype.DataBind();
            addeventInRepeater();
        }
    }

    public void addeventInRepeater()
    {
        string rpt1 = rptfeetype.ClientID;
        string chkpage = "chkpage";
        int rptModuleItemIndex = 0;
        foreach (RepeaterItem ri in rptfeetype.Controls)
        {
            if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
            {
                CheckBox chkmod = (CheckBox)ri.FindControl("chkmodule");
                Repeater rptForm1 = (Repeater)ri.FindControl("rptfeesubtype");
                int count = rptForm1.Items.Count;
                chkmod.Attributes.Add("onclick", "checkModule('" + rpt1 + "', " + count + ",'" + rptForm1.ClientID + "','" + chkmod.ClientID + "','" + chkpage + "');");
                int rptFormItemIndex = 0;
                foreach (RepeaterItem ri1 in rptForm1.Controls)
                {
                    if (ri1.ItemType == ListItemType.Item || ri1.ItemType == ListItemType.AlternatingItem)
                    {
                        string rpt2 = rptForm1.ClientID;
                        CheckBox chkp = (CheckBox)ri1.FindControl("chkpage");
                        chkp.Attributes.Add("onclick", "checkPage('" + rpt1 + "'," + rptModuleItemIndex + "," + rptFormItemIndex + ",'" + rptForm1.ClientID + "','" + chkmod.ClientID + "','" + chkpage + "');");
                        rptFormItemIndex++;
                    }
                }
            }
            rptModuleItemIndex++;
        }
    }

    private void UncheckAll()
    {
        //divu.Visible = false;
        kk.Visible = false;
        trdiv.Visible = false;
        rptfeetype.Visible = false;
        // btn.Visible = false;

        foreach (RepeaterItem ri in rptfeetype.Items)
        {
            if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
            {
                CheckBox chkmodule = (CheckBox)ri.FindControl("chkmodule");
                Repeater rptForm = (Repeater)ri.FindControl("rptfeesubtype");
                if (chkmodule != null && chkmodule.Checked)
                {
                    chkmodule.Checked = false;
                    foreach (RepeaterItem ri1 in rptForm.Items)
                    {
                        if (ri1.ItemType == ListItemType.Item || ri1.ItemType == ListItemType.AlternatingItem)
                        {
                            CheckBox chkpage = (CheckBox)ri1.FindControl("chkpage");
                            if (chkpage != null && chkpage.Checked)
                            {
                                chkpage.Checked = false;
                            }
                        }
                    }
                }
            }
        }
    }

    protected void rptfeetype_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        DataTable dt1 = new DataTable();
        string moduleId = ((Label)e.Item.FindControl("lblModuleId")).Text;
        ViewState["module"] = moduleId;
        dt1 = objDUT.GetDataTable(@"select classsubject_master.subjectid,subjectname,classsubject_master.csmid,isnull(tblTeacherSubjectMapping.status,0) as status
                                   from classsubject_master left outer join tblTeacherSubjectMapping on tblTeacherSubjectMapping.Classid=" + moduleId + @" and
                                  tblTeacherSubjectMapping.subjectID=classsubject_master.subjectid and tblTeacherSubjectMapping.eid=" + facultyID + @"where
                                  classsubject_master.status=1 and classsubject_master.classid=" + moduleId + "  and tblTeacherSubjectMapping.status=1");
        //dt1 = CommonClass.facultymaster1("fillsubject",Convert.ToInt32(moduleId),Convert.ToInt32(facultyID));

        Repeater rptForm1 = (Repeater)e.Item.FindControl("rptfeesubtype");

        //CheckBox chkp = (CheckBox)e.Item.FindControl("chkpage");
        if (dt1.Rows.Count > 0)
        {
            rptForm1.DataSource = dt1;
            rptForm1.DataBind();
        }
    }

    protected void btn_Click1(object sender, EventArgs e)
    {
        int count = 0;
        foreach (RepeaterItem ri in rptfeetype.Items)
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
            foreach (RepeaterItem ri in rptfeetype.Items)
            {
                if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chkmodule = (CheckBox)ri.FindControl("chkmodule");
                    Label lblmoduleid = (Label)ri.FindControl("lblmoduleid");
                    if (chkmodule.Checked)
                    {
                        //feeid = feeid + "," + lblmoduleid.Text;
                    }
                    Repeater rptForm = (Repeater)ri.FindControl("rptfeesubtype");
                    foreach (RepeaterItem ri1 in rptForm.Items)
                    {
                        if (ri1.ItemType == ListItemType.Item || ri1.ItemType == ListItemType.AlternatingItem)
                        {
                            CheckBox chkpage = (CheckBox)ri1.FindControl("chkpage");
                            Label lblpageid = (Label)ri1.FindControl("lblpageid");
                            HiddenField hd1 = (HiddenField)ri1.FindControl("HD1");
                            if (chkpage.Checked)
                            {
                                feeid = feeid + "," + hd1.Value;
                            }
                        }
                    }
                }
            }
            feeid = feeid.Remove(0, 1);
        }
        param = new SqlParameter[4];
        if (ViewState["facultyid"] != null)
        {
            param[0] = new SqlParameter("@facultyID", ViewState["facultyid"]);
            param[1] = new SqlParameter("@facultyName", txtfacultyname.Text);
        }
        else
        {
            param[0] = new SqlParameter("@facultyID", 0);
            param[1] = new SqlParameter("@facultyName", txtfacultyname.Text);
        }
        param[2] = new SqlParameter("@CSMID", feeid);

        param[3] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[3].Direction = ParameterDirection.Output;

        int intresult = objDUT.ExecuteSqlSP(param, "usp_setfacultysubjects");

        if (intresult == 1)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "displayalertmessage", "Showalert();", true);
            Session.Remove("RootNode");
            Session.Remove("Page");
            //grddiv.Visible = false;

            if (ViewState["facultyid"] != null)
            {
                Response.Redirect("viewfaculty.aspx", true);
            }
            else
            {
            }
        }
        else
        {
            Utility.ViewAlertMessage(Page, "Error while saving the record.");
        }
        UncheckAll();
        trdiv.Visible = false;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        btn.Visible = true;
        string str = @" select Class_Master.classname,id,isnull(facultyclass_master.status,0) as status from Class_Master left outer join facultyclass_master on
                    facultyclass_master.Classid=Class_Master.id and facultyclass_master.eid=" + ViewState["facultyid"] + " where Class_Master.id in (select classid from classsubject_master where status=1) and Class_Master.Status=1";
        dt = objDUT.GetDataTable(str);
        //dt = CommonClass.facultymaster("fillclass");
        if (dt.Rows.Count > 0)
        {
            rptfeetype.DataSource = dt;
            rptfeetype.DataBind();
            addeventInRepeater();

            foreach (RepeaterItem item in rptfeetype.Items)
            {
                DataTable dt1 = new DataTable();
                string moduleId = ((Label)item.FindControl("lblModuleId")).Text;

                string str1 = @"select classsubject_master.subjectid,subjectname,classsubject_master.csmid,isnull(tblTeacherSubjectMapping.status,0) as status
                                   from classsubject_master left outer join tblTeacherSubjectMapping on tblTeacherSubjectMapping.Classid=" + moduleId + @" and
                                  tblTeacherSubjectMapping.subjectID=classsubject_master.subjectid and tblTeacherSubjectMapping.eid=" + ViewState["facultyid"] + @" where
                                  classsubject_master.status=1 and classsubject_master.classid=" + moduleId;
                dt1 = objDUT.GetDataTable(str1);
                //dt1 = CommonClass.facultymaster1("fillsubject",Convert.ToInt32(moduleId),Convert.ToInt32(facultyID));

                Repeater rptForm1 = (Repeater)item.FindControl("rptfeesubtype");

                //CheckBox chkp = (CheckBox)e.Item.FindControl("chkpage");
                if (dt1.Rows.Count > 0)
                {
                    rptForm1.DataSource = dt1;
                    rptForm1.DataBind();
                }
            }
        }
    }
}