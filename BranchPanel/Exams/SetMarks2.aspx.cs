using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
using System.Data.OleDb;
using ClosedXML.Excel;
using System.Linq;

public partial class BranchPanel_Exams_SetMarks : System.Web.UI.Page
{
    private DataUtility objDut = new DataUtility();
    private DataTable Dt;
    private string Query = "";
    private int fyid = 0;
    private int brid = 0;
    DataTable dtSubjectMarks;
    DataTable dtSubjectMark = new DataTable();
    public bool IsGradeType = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["BrUser"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
            if (Convert.ToInt64(Session["BrBrid"]) != 0 && Session["BrBrid"] != null)
            {
                brid = Convert.ToInt32(Session["BrBrid"]);
            }

            fyid = CommonClass.Scaler("ActiveAcademicYear");

            if (!IsPostBack)
            {
                //CreateRepeater();
                //FillAllDropDownList(0, 0);
                //fill_Dropdown_Result(0);
                divSection.Visible = false;
                divCourse.Visible = false;
                divSubject.Visible = false;
                divUpdateOption.Visible = false;
                Div2.Visible = false;
                divGrid.Visible = false;
                rbnUpdateOption.Visible = false;
                divExam.Visible = false;
                if (Request.QueryString.Count == 1)
                {
                    int eid = Convert.ToInt32(Request.QueryString[0]);

                    string maxmarks = objDut.GetScalar("select maxmarks from exam_name where eid=" + eid + "").ToString();
                    hfmaxmarks.Value = maxmarks;

                    //ddlexam.SelectedValue = Convert.ToString(eid);
                    ddlcourse.Enabled = true;

                    ddlcourse.DataSource = null;
                    ddlcourse.DataBind();

                    Query = "select classid,classname from exam_class where examid=" + eid + " and status=" + 1 + "";
                    Dt = objDut.GetDataTable(Query);
                    ddlcourse.DataSource = Dt;
                    ddlcourse.DataTextField = "classname";
                    ddlcourse.DataValueField = "classid";
                    ddlcourse.DataBind();
                    System.Web.UI.WebControls.ListItem licourse = new System.Web.UI.WebControls.ListItem("Select Class", "0");
                    ddlcourse.Items.Insert(0, licourse);
                }

            }
            //if (ddlsubject.SelectedValue != "0")
            //{
            //    ddlsubject_SelectedIndexChanged(null, null);
            //}
        }
        catch (Exception ex)
        {
        }
    }

    //protected void ddlexam_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        //if (ddlexam.SelectedIndex > 0)
    //        //{
    //        //    int examid = Convert.ToInt32(ddlexam.SelectedValue);
    //            //int status = Convert.ToInt32(objDut.GetScalar("select distinct status from Exam_marksSetting where eid=" + examid + " and brid=" + Convert.ToInt64(Session["BrBrid"]) + " and status=1"));
    //            //if (status == 1)
    //            //{
    //            //}
    //            //else
    //            //{
    //            //    Utility.ViewAlertMessage(Page, "You can not set marks for selected exam");
    //            //    divfortotal.Style.Add("display", "none");
    //            //    divforsetmarks.Style.Add("display", "block");
    //            //    divforclassname.Style.Add("display", "none");
    //            //    divforexamname.Style.Add("display", "none");
    //            //    divforsetmarks2.Style.Add("display", "none");
    //            //    ddlcourse.Enabled = false;
    //            //    ddlsection.Enabled = false;
    //            //    ddlsubject.Enabled = false;
    //            //    ddlcourse.SelectedIndex = 0;
    //            //    ddlsection.SelectedIndex = 0;
    //            //    ddlsubject.SelectedIndex = 0;
    //            //    return;
    //            //}

    //            FillAllDropDownList(Convert.ToInt32(ddlexam.SelectedValue), 0);
    //            ddlcourse.Enabled = true;
    //            string maxmarks = objDut.GetScalar("select maxmarks from exam_name where eid=" + Convert.ToInt32(ddlexam.SelectedValue) + "").ToString();
    //            hfmaxmarks.Value = maxmarks;
    //            divfortotal.Style.Add("display", "none");
    //            divforsetmarks.Style.Add("display", "block");
    //            divforclassname.Style.Add("display", "none");
    //            divforexamname.Style.Add("display", "none");
    //        }
    //        else
    //        {
    //            ddlcourse.Enabled = false;
    //            ddlsection.Enabled = false;
    //            ddlsubject.Enabled = false;
    //        }
    //        ddlcourse.SelectedIndex = 0;
    //        ddlsection.SelectedIndex = 0;
    //        ddlsubject.SelectedIndex = 0;
    //    }
    //    catch (Exception ex)
    //    { }
    //}
    public bool Validate()
    {
        if (ddlTerm.SelectedValue != "0" && ddlcourse.SelectedValue != "0")
        {
            int intResult = Convert.ToInt32(objDut.GetScalar("Select ISNULL(Count(examid),0) from exam_class where status=1 and brid=" + Session["brBrid"] +
                           " and classid=" + ddlcourse.SelectedValue + ""));
            if (ddlTerm.SelectedValue == "1")
            {
                if (intResult < 2)
                {
                    Utility.ViewAlertMessage(Page, "Please config exam to class for Ist Term");
                    return false;
                }
            }
            else if (ddlTerm.SelectedValue == "2")
            {
                if (intResult < 4)
                {
                    Utility.ViewAlertMessage(Page, "Please config exam to class for IInd Term");
                    return false;
                }
            }
            //else if (ddlTerm.SelectedValue == "3")
            //{
            //    if (intResult < 12)
            //    {
            //        Utility.ViewAlertMessage(Page, "Please config exam to class for IIrd Term");
            //        return false;
            //    }
            //}
        }
        return true;
    }
    protected void ddlcourse_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            OnSelectCourse();
            HideGrid();
            if (Validate())
            {
                if (ddlcourse.SelectedIndex > 0)
                {
                    Query = "select Distinct cwsid,sectionname from classwithsection where branchid=" + Session["brBrid"] + " and classid=" + ddlcourse.SelectedValue + "";
                    Dt = objDut.GetDataTable(Query);
                    ddlsection.DataSource = Dt;
                    ddlsection.DataTextField = "sectionname";
                    ddlsection.DataValueField = "cwsid";
                    ddlsection.DataBind();
                    System.Web.UI.WebControls.ListItem listsection = new System.Web.UI.WebControls.ListItem("Select Section", "0");
                    ddlsection.Items.Insert(0, listsection);

                    ddlsection.Enabled = true;
                    ddlsection.SelectedIndex = 0;
                    ddlsubject.SelectedIndex = 0;
                    divSection.Visible = true;
                }
                else
                {
                    divSection.Visible = false;
                    ddlcourse.Enabled = true;
                    ddlsection.Enabled = true;
                    ddlsubject.Enabled = true;
                    ddlcourse.SelectedIndex = 0;
                    ddlsection.SelectedIndex = 0;
                    ddlsubject.SelectedIndex = 0;
                }
            }
        }
        catch (Exception ex)
        {
        }
    }

    private void HideGrid() {
        divforsetmarks2.Visible = false;
        if (ddlsubject.SelectedIndex > 0) {
            ddlsubject.SelectedValue = "0";
            divGrid.Visible = false;
            btncancel.Visible = false;
        }
    }
    protected void ddlsection_SelectedIndexChanged(object sender, EventArgs e)
    {
        OnSelectSection();
        HideGrid();
        if (ddlsection.SelectedIndex > 0)
        {
            divUpdateOption.Visible = true;
        }
        else {
            divUpdateOption.Visible = false;
        }
    }

    protected void ddlsubject_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblError2.Text = "";
        lblError.Text = "";
        lblmessage.Text = "";
        lblmessage2.Text = "";
        if (ddlsubject.SelectedIndex > 0)
        {
            divforsetmarks2.Visible = true;
            divGrid.Visible = true;
            btncancel.Visible = true;

            IsGradeType = isGrade();
        }
        else {
            divGrid.Visible = false;
            divforsetmarks2.Visible = false;
            IsGradeType = false;
        }
        FillGrid(Convert.ToInt32(ddlcourse.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue), Convert.ToInt32(ddlsubject.SelectedValue), 0);
        //Bind_student_marks(Convert.ToInt32(ddlexam.SelectedValue), Convert.ToInt32(ddlcourse.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue));

        //fill_Dropdown_Result(Convert.ToInt32(ddlexam.SelectedValue));
        //ddlforclassame.SelectedValue = ddlcourse.SelectedValue.ToString();

        ////fill_Dropdown_Result(0);
        //ddlforexamname.SelectedValue = ddlexam.SelectedValue.ToString();

        divfortotal.Style.Add("display", "block");
        divforsetmarks.Style.Add("display", "block");
        divforclassname.Style.Add("display", "none");
        divforexamname.Style.Add("display", "none");
        //divforsetmarks2.Style.Add("display", "block");
    }

    //    protected void FillAllDropDownList(int examid, int classid)
    //    {
    //        try
    //        {
    //            // This Is For The Bind Class In Drop Down List
    //            if (examid > 0)
    //            {
    //                Query = " Select Distinct cm.id as classid,cm.Classname from classwithsection cws " +
    //                         " left outer join Class_Master cm on cws.classid=cm.id " +
    //                    //" inner join exam_class ec on ec.brid = cws.branchid " +
    //                         " where cm.status=1 and cws.branchid=" + Session["brBrid"] + " and cm.fyid=" + fyid; //+ "" +
    //                //" and ec.examid =" + examid;
    //                Dt = objDut.GetDataTable(Query);
    //                ddlcourse.DataSource = Dt;
    //                ddlcourse.DataTextField = "classname";
    //                ddlcourse.DataValueField = "classid";
    //                ddlcourse.DataBind();
    //                ListItem licourse = new ListItem("Select Class", "0");
    //                ddlcourse.Items.Insert(0, licourse);
    //            }
    //            else if (classid > 0)
    //            {
    //                // This Is For The Bind Section In Drop Down List
    //                Query = "select Distinct cwsid,sectionname from classwithsection where branchid=" + Session["brBrid"] + " and classid=" + classid + "";
    //                Dt = objDut.GetDataTable(Query);
    //                ddlsection.DataSource = Dt;
    //                ddlsection.DataTextField = "sectionname";
    //                ddlsection.DataValueField = "cwsid";
    //                ddlsection.DataBind();
    //                ListItem listsection = new ListItem("Select Section", "0");
    //                ddlsection.Items.Insert(0, listsection);
    //                // This Is For The Bind Subject In Drop Down List

    //                Query = @"Select subjectid,subjectname from SubjectBranch_master where BranchId=" + Session["brBrid"] + " and classid=" + classid + " and subjectname NOT IN('Health & Physical Education','Work Education','Discipline','Art Education')";
    //                Dt = objDut.GetDataTable(Query);
    //                ddlsubject.DataSource = Dt;
    //                ddlsubject.DataTextField = "subjectname";
    //                ddlsubject.DataValueField = "subjectid";
    //                ddlsubject.DataBind();
    //                ListItem lisubject = new ListItem("Select Subject", "0");
    //                ddlsubject.Items.Insert(0, lisubject);
    //            }
    //            else
    //            {
    //                // This Is For The Bind Exam In Drop Down List

    //                Query = @"Select * from exam_name
    //                                    inner join exam_class on exam_class.examid = exam_name.eid
    //                                    where exam_class.brid=" + Session["brBrid"] + " and exam_class.status=1 order by eid asc";

    //                Dt = objDut.GetDataTable(Query);
    //                ddlexam.DataSource = Dt;
    //                ddlexam.DataTextField = "examname";
    //                ddlexam.DataValueField = "eid";
    //                ddlexam.DataBind();
    //                ListItem liexam = new ListItem("Select Exam", "0");
    //                ddlexam.Items.Insert(0, liexam);
    //            }
    //        }
    //        catch (Exception ex)
    //        {
    //        }
    //    }
    private void FillGrid(int classid, int sectionid, int SubjectID, int Mode)
    {

        string Query = "";
        string StrQuery = "";
        string SubjectName = "";
        string Marks = "0";
        int SubjectID1 = 0;
        if (classid > 0)
        {
            if (Mode == 1)
            {
                StrQuery = " Order by Sr.RegNewNo asc";
            }
            else if (Mode == 2)
            {
                StrQuery = " Order by Sr.StudentFirstName asc";
            }
            string strQuery = @"SELECT SR.StudentFirstName+' '+SR.StudentMiddleName+' '+SR.StudentLastName+'('+SR.RegNewNo+')' as Name,SM.sturegno                            
                            FROM tbl_StudentRegistration SR  
                            inner join tbl_StudentMaster SM on SM.RID = SR.RID and SR.Brid = SM.Brid
                            INNER JOIN tbl_StudentAdmissionMaster sa ON SM.SturegNo = sa.StuRegNo and sa.Brid = SR.Brid
							where sa.IsTerminated=0 and SR.brid=" + Session["brBrid"] + " and SM.classid=" + classid + " and sm.sectionID=" + sectionid + "" + StrQuery + "";

            DataTable dtStdGrid = objDut.GetDataTable(strQuery);
            if (dtStdGrid.Rows.Count > 0)
            {
                ResultType.Value = Convert.ToString(objDut.GetScalar(@"SELECT ISNULL(mst_RresultToClass.Status,0) Status
                            from mst_RresultToClass
                            where brid=" + Session["brBrid"] + " and classid=" + classid + " and mst_RresultToClass.ResultTypeID=1"));
                //ResultType.Value = "1";
                //if (Convert.ToInt32(ddlcourse.SelectedValue) > 0)
                //{
                //    Query = @"Select subjectid,subjectname from SubjectBranch_master where BranchId=" + Session["brBrid"] + " and classid=" + Convert.ToInt32(ddlcourse.SelectedValue) + " and subjectname NOT IN('Health & Physical Education','Work Education','Discipline','Art Education')";
                //    Dt = objDut.GetDataTable(Query);
                //    if (Dt.Rows.Count > 0)
                //    {
                //        foreach (DataRow dr in Dt.Rows)
                //        {
                //            dtStd.Columns.Add(dr["subjectname"].ToString());
                //        }

                //        for (int i = 0; i < dtStd.Rows.Count; i++)
                //        {
                //            for (int k = 2; k < dtStd.Columns.Count; k++)
                //            {
                //                SubjectName = dtStd.Columns[k].ToString().Trim();
                //                SubjectID1 = (int)(objDut.GetScalar("Select subjectid from SubjectBranch_master where BranchId=" + Session["brBrid"] + "and subjectname ='" + SubjectName + "' and classid=" + classid + ""));
                //                string strMarks = "Select ISnull(marks,'0') marks from tbl_marks_master where examid=" + ddlTerm.SelectedValue + " and classid=" + classid + " and subjectid=" + SubjectID1 + " and studentregno=" + dtStd.Rows[i]["sturegno"].ToString() + "";
                //                if (SubjectID1 > 0)
                //                {
                //                    Marks = Convert.ToString(objDut.GetScalar(strMarks));
                //                    if (Marks == "")
                //                    {
                //                        Marks = "0";
                //                    }
                //                    dtStd.Rows[i][k] = Marks.ToString();
                //                }
                //            }
                //        }
                dtSubjectMark.TableName = "CopyTable";
                dtSubjectMark = dtStdGrid.Copy();

                grdsetmarks.DataSource = dtStdGrid;
                grdsetmarks.DataBind();
                btnsubmit.Style.Add("display", "block");
                divforstudentheading.Style.Add("display", "block");

                //SqlParameter[] param = new SqlParameter[4];

                //param[0] = new SqlParameter("@classid", SqlDbType.Int);
                //param[0].Value = classid;

                //param[1] = new SqlParameter("@sectionid", SqlDbType.Int);
                //param[1].Value = sectionid;

                ////param[2] = new SqlParameter("@subjectid", SqlDbType.Int);
                ////param[2].Value = SubjectID;

                //param[2] = new SqlParameter("@examid", SqlDbType.Int);
                //param[2].Value = Convert.ToInt32(ddlexam.SelectedValue);

                //param[3] = new SqlParameter("@mode", SqlDbType.Int);
                //param[3].Value = Convert.ToInt32(2);

                ////if (ddlsubject.SelectedValue != "0")
                ////{
                //DataSet dt = objDut.GetDataSetSP(param, "Usp_getStudent");
                //if (dt.Tables[0].Rows.Count > 0)
                //{
                //    if (dt.Tables[1].Rows.Count > 0)
                //    {
                //        foreach (DataRow dr in dt.Tables[1].Rows)
                //        {
                //            foreach (DataRow dr1 in dt.Tables[0].Rows)
                //            {
                //                if (dr1["sturegno"].ToString() == dr["sturegno"].ToString())
                //                {
                //                    dr1["marks"] = dr["marks"].ToString();
                //                }
                //            }
                //        }
                //    }
                //    grdsetmarks.DataSource = dt.Tables[0];
                //    grdsetmarks.DataBind();
                //    btnsubmit.Style.Add("display", "block");
                //    divforstudentheading.Style.Add("display", "block");
                //}
                //else
                //{
                //    grdsetmarks.EmptyDataText = "No Record Found";
                //    btnsubmit.Style.Add("display", "none");
                //    divforstudentheading.Style.Add("display", "block");
                //    grdsetmarks.DataBind();
                //}
                //}
                //else
                //{
                //    grdsetmarks.EmptyDataText = "No Record Found";
                //    btnsubmit.Style.Add("display", "none");
                //    divforstudentheading.Style.Add("display", "block");
                //    grdsetmarks.DataBind();
                //}
                //}
            }
        }
        else
        {
            grdsetmarks.EmptyDataText = "No Record Found";
            btnsubmit.Style.Add("display", "none");
            divforstudentheading.Style.Add("display", "block");
            grdsetmarks.DataBind();
        }

    }
    //private void FillGrid(int classid, int sectionid, int SubjectID)
    //{
    //    try
    //    {
    //        Session["TempDt"] = null;
    //        DataUtility objDut = new DataUtility();

    //        string Query = "select eid,examname from exam_name where brid=" + Session["brBrid"] + " and status=1 order by eid asc";

    //        Dt = objDut.GetDataTable(Query);
    //        DataTable TempDt = new DataTable();
    //        string StrStr = "";
    //        StrStr = " where SR.fyid=" + fyid + " and SR.brid=" + Convert.ToInt64(Session["BrBrid"]) + "";

    //        string StrStr1 = "";
    //        StrStr1 = " where Subject_Master.fyid=" + fyid + " and SEM.branchid=" + Convert.ToInt64(Session["BrBrid"]) + "and SEM.classid=" + ddlcourse.SelectedValue + " and Subject_Master.id=" + SubjectID + "";

    //        string strSubject = " Select DISTINCT Subject_Master.SubjectName from SubjectBranch_master SEM " +
    //                            " inner join Subject_Master on Subject_Master.id = SEM.subjectid " + StrStr1 + " and Subject_Master.SubjectName NOT IN('Health & Physical Education','Work Education','Discipline','Art Education')";
    //        DataTable dtSubject = objDut.GetDataTable(strSubject);
    //        if (dtSubject.Rows.Count > 0)
    //        {
    //            int Lengt = 0;
    //            int StartLengt = 0;
    //            string strExamList = "";
    //            if (ddlTerm.SelectedValue != "0")
    //            {
    //                int TermID = 0;
    //                TermID = Convert.ToInt32(ddlTerm.SelectedValue);
    //                if (TermID == 2)
    //                {
    //                    StartLengt = 4;
    //                    Lengt = Dt.Rows.Count - 1;
    //                }
    //                else
    //                {
    //                    StartLengt = 0;
    //                    Lengt = 3;
    //                }
    //            }
    //            for (int i = StartLengt; i <= Lengt; i++)
    //            {
    //                if (Dt.Rows[i]["examname"].ToString() != "")
    //                {
    //                    if (strExamList == "")
    //                    {
    //                        strExamList = "[" + Dt.Rows[i]["examname"].ToString() + "]";
    //                    }
    //                    else
    //                    {
    //                        strExamList = strExamList + ",[" + Dt.Rows[i]["examname"].ToString() + "]";
    //                    }
    //                }
    //            }
    //            string Query1 = "SELECT *" +
    //                " FROM ( " +
    //                    " SELECT " +
    //                         " SM.sturegno,SR.StudentFirstName+' '+SR.StudentMiddleName+' '+SR.StudentLastName as name,'marks'=0,examname " +
    //                         " FROM tbl_StudentRegistration SR " +
    //                         " inner join tbl_StudentMaster SM on SM.RID = SR.RID and SR.Brid = SM.Brid" +
    //                         //" inner join tbl_marks_master SEM on SEM.studentregno = SM.SturegNo " +
    //                         //" inner join exam_name on exam_name.eid = SEM.examid " +
    //                         " inner join exam_name SBM on SBM.Brid = SM.Brid " + StrStr + " ) as s " +
    //            " PIVOT " +
    //            " ( SUM(marks) FOR [examname] IN (" + strExamList + ") )AS pvt";

    //            TempDt = objDut.GetDataTable(Query1);

    //            if (TempDt.Rows.Count > 0)
    //            {
    //                Session["TempDt"] = TempDt;                    
    //                btnsubmit.Style.Add("display", "block");
    //                divforstudentheading.Style.Add("display", "block");

    //                //if (grdsetmarks.Columns.Count > 2)
    //                //{
    //                //    Response.Redirect("SetMarks.aspx");
    //                //}
    //                //if (grdsetmarks.Columns.Count == 2)
    //                //{
    //                //    int x = 0;
    //                //    BoundField bfield = new BoundField();
    //                //    bfield.ItemStyle.CssClass = "bgd";
    //                //    for (int i = 3; i < TempDt.Columns.Count; i++)
    //                //    {
    //                //        if (TempDt.Columns[i].ColumnName.ToString() != "examid")
    //                //        {
    //                //            bfield = new BoundField();
    //                //            bfield.HeaderText = TempDt.Columns[i].ColumnName.ToString();
    //                //            bfield.DataField = TempDt.Columns[i].ColumnName.ToString();
    //                //            grdsetmarks.Columns.Add(bfield);
    //                //        }
    //                //    }
    //                //}
    //                grdsetmarks.DataSource = TempDt;
    //                grdsetmarks.DataBind();
    //            }
    //        }

    //        //SqlParameter[] param = new SqlParameter[5];

    //        //param[0] = new SqlParameter("@classid", SqlDbType.Int);
    //        //param[0].Value = classid;

    //        //param[1] = new SqlParameter("@sectionid", SqlDbType.Int);
    //        //param[1].Value = sectionid;

    //        //param[2] = new SqlParameter("@subjectid", SqlDbType.Int);
    //        //param[2].Value = SubjectID;

    //        //param[3] = new SqlParameter("@examid", SqlDbType.Int);
    //        //param[3].Value = Convert.ToInt32(0);

    //        //param[4] = new SqlParameter("@mode", SqlDbType.Int);
    //        //param[4].Value = Convert.ToInt32(1);

    //        //if (ddlsubject.SelectedValue != "0")
    //        //{
    //        //    DataSet dt = objDut.GetDataSetSP(param, "Usp_getStudent");
    //        //    if (dt.Tables[0].Rows.Count > 0)
    //        //    {
    //        //        if (dt.Tables[1].Rows.Count > 0)
    //        //        {
    //        //            foreach (DataRow dr in dt.Tables[1].Rows)
    //        //            {
    //        //                foreach (DataRow dr1 in dt.Tables[0].Rows)
    //        //                {
    //        //                    if (dr1["sturegno"].ToString() == dr["sturegno"].ToString())
    //        //                    {
    //        //                        dr1["marks"] = dr["marks"].ToString();
    //        //                    }
    //        //                }
    //        //            }
    //        //        }
    //        //        grdsetmarks.DataSource = dt.Tables[0];
    //        //        grdsetmarks.DataBind();
    //        //        btnsubmit.Style.Add("display", "block");
    //        //        divforstudentheading.Style.Add("display", "block");
    //        //    }
    //        //    else
    //        //    {
    //        //        grdsetmarks.EmptyDataText = "No Record Found";
    //        //        btnsubmit.Style.Add("display", "none");
    //        //        divforstudentheading.Style.Add("display", "block");
    //        //        grdsetmarks.DataBind();
    //        //    }
    //        //}
    //        //else
    //        //{
    //        //    grdsetmarks.EmptyDataText = "No Record Found";
    //        //    btnsubmit.Style.Add("display", "none");
    //        //    divforstudentheading.Style.Add("display", "block");
    //        //    grdsetmarks.DataBind();
    //        //}
    //    }
    //    catch (Exception ex)
    //    { }
    //}
    int COunt = 0;
    protected void grdsetmarks_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            Session["ExamTemp"] = null;
            Query = "Select DISTINCT exam_name.eid AS id,examname from exam_class " +
                  " INNER join exam_name on exam_class.examid=exam_name.eid where exam_name.brid=" + Convert.ToInt32(Session["BrBrid"]) + " and exam_class.status=1 " +
                  " and exam_class.classid=" + ddlcourse.SelectedValue + " order by id asc";
            DataTable TempDt = new DataTable();
            TempDt = objDut.GetDataTable(Query);
            if (TempDt.Rows.Count > 0)
            {
                Session["ExamTemp"] = TempDt;
                if (ddlTerm.SelectedValue != "0")
                {
                    int Start = 0;
                    int End = 0;
                    if (ResultType.Value == "1")
                    {
                        //if (ddlTerm.SelectedValue == "1")
                        //{
                        //    Start = 3;
                        //    End = 4;
                        //}
                        //else
                        //{
                        //    Start = TempDt.Rows.Count - 1;
                        //    End = TempDt.Rows.Count;
                        //}
                        e.Row.Cells[2].Visible = false;
                        e.Row.Cells[3].Visible = false;
                        e.Row.Cells[4].Visible = false;
                    }
                    else
                    {
                        e.Row.Cells[2].Visible = true;
                        e.Row.Cells[3].Visible = true;
                        e.Row.Cells[4].Visible = true;
                    }
                    if (ddlTerm.SelectedValue == "1")
                    {
                        Start = 0;
                        End = 4;

                    }
                    else if (ddlTerm.SelectedValue == "2")
                    {
                        // Start = 4;
                        // End = 8;
                        Start = 0;
                        End = 4;

                    }
                    else
                    {
                        Start = 8;
                        End = TempDt.Rows.Count;
                    }
                    //}
                    if (ddlTerm.SelectedValue == "1")
                    {
                        e.Row.Cells[2].Visible = true;
                        e.Row.Cells[3].Visible = true;
                        e.Row.Cells[4].Visible = false;
                        e.Row.Cells[5].Visible = false;
                    }
                    else if (ddlTerm.SelectedValue == "2")
                    {

                        e.Row.Cells[2].Visible = false;
                        e.Row.Cells[3].Visible = false;
                        e.Row.Cells[4].Visible = true;
                        e.Row.Cells[5].Visible = true;
                    }
                    int l = 1;
                    for (int k = Start; k < End; k++)
                    {
                        if (ResultType.Value == "1")
                        {
                            e.Row.Cells[l].Text = "NAME";
                            e.Row.Cells[e.Row.Cells.Count - 1].Text = TempDt.Rows[k][1].ToString().ToUpper();
                            dtSubjectMark.Columns.Add(TempDt.Rows[k][1].ToString().ToUpper());
                        }
                        else
                        {
                            if (l == 1)
                            {
                                e.Row.Cells[l].Text = "NAME";
                                e.Row.Cells[l + 1].Text = TempDt.Rows[k][1].ToString().ToUpper();
                                dtSubjectMark.Columns.Add(TempDt.Rows[k][1].ToString().ToUpper());
                            }
                            else
                            {
                                e.Row.Cells[l + 1].Text = TempDt.Rows[k][1].ToString().ToUpper();
                                dtSubjectMark.Columns.Add(TempDt.Rows[k][1].ToString().ToUpper());
                            }
                        }
                        l++;
                    }
                }
            }
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string Marks1 = "0";
            string Marks2 = "0";
            string Marks3 = "0";
            string Marks4 = "0";
            int Start1 = 0;
            int Start2 = 0;
            int Start3 = 0;
            int Start4 = 0;
            if (ResultType.Value == "1")
            {
                if (ddlTerm.SelectedValue == "1")
                {
                    Start1 = 0;
                    Start2 = 0;
                    Start3 = 0;
                    Start4 = 3;
                }
                else if (ddlTerm.SelectedValue == "2")
                {
                    Start1 = 0;
                    Start2 = 0;
                    Start3 = 0;
                    Start4 = 7;
                }
                else
                {
                    Start1 = 0;
                    Start2 = 0;
                    Start3 = 0;
                    Start4 = 11;
                }
                e.Row.Cells[2].Visible = false;
                e.Row.Cells[3].Visible = false;
                e.Row.Cells[4].Visible = false;
            }
            else
            {
                e.Row.Cells[2].Visible = true;
                e.Row.Cells[3].Visible = true;
                e.Row.Cells[4].Visible = true;
                if (ddlTerm.SelectedValue == "1")
                {
                    Start1 = 0;
                    Start2 = 1;
                    Start3 = 2;
                    Start4 = 3;
                }
                else if (ddlTerm.SelectedValue == "2")
                {
                    //Start1 = 4;
                    //Start2 = 5;
                    //Start3 = 6;
                    //Start4 = 7;

                    Start1 = 0;
                    Start2 = 1;
                    Start3 = 2;
                    Start4 = 3;
                }
                else
                {
                    Start1 = 8;
                    Start2 = 9;
                    Start3 = 10;
                    Start4 = 11;
                }

                if (ddlTerm.SelectedValue == "1")
                {
                    e.Row.Cells[2].Visible = true;
                    e.Row.Cells[3].Visible = true;
                    e.Row.Cells[4].Visible = false;
                    e.Row.Cells[5].Visible = false;
                }
                else if (ddlTerm.SelectedValue == "2")
                {

                    e.Row.Cells[2].Visible = false;
                    e.Row.Cells[3].Visible = false;
                    e.Row.Cells[4].Visible = true;
                    e.Row.Cells[5].Visible = true;
                }
            }
            DataTable TempDt = new DataTable();
            TempDt = (DataTable)(Session["ExamTemp"]);

            Label lblregno = (Label)e.Row.FindControl("lblregno");
            TextBox txtMarks2 = (TextBox)e.Row.FindControl("txtMarks2");
            TextBox txtMarks3 = (TextBox)e.Row.FindControl("txtMarks3");
            TextBox txtMarks4 = (TextBox)e.Row.FindControl("txtMarks4");
            TextBox txtMarks5 = (TextBox)e.Row.FindControl("txtMarks5");

            if (ddlsubject.SelectedValue != "0")
            {
                var isGrading = isGrade();

                Marks1 = getMarksFromDb(TempDt.Rows[Start1][0].ToString(), lblregno.Text.ToString().Trim(), false, isGrading);
                
                txtMarks2.Text = Marks1.ToString();
                dtSubjectMark.Rows[Convert.ToInt32(e.Row.RowIndex)][2] = Marks1.ToString();
                
                Marks2 = getMarksFromDb(TempDt.Rows[Start2][0].ToString(), lblregno.Text.ToString().Trim(), false, isGrading);

                txtMarks3.Text = Marks2.ToString();
                dtSubjectMark.Rows[Convert.ToInt32(e.Row.RowIndex)][3] = Marks2.ToString();

                Marks3 = getMarksFromDb(TempDt.Rows[Start3][0].ToString(), lblregno.Text.ToString().Trim(), false, isGrading);

                txtMarks4.Text = Marks3.ToString();
                dtSubjectMark.Rows[Convert.ToInt32(e.Row.RowIndex)][4] = Marks3.ToString();

                Marks4 = getMarksFromDb(TempDt.Rows[Start4][0].ToString(), lblregno.Text.ToString().Trim(), false, isGrading);
                dtSubjectMark.Rows[Convert.ToInt32(e.Row.RowIndex)][5] = Marks4.ToString();
                txtMarks5.Text = Marks4.ToString();
            }

            //txtMarks2.Text = TempDt.Rows[COunt][2].ToString();
            //txtMarks3.Text = TempDt.Rows[COunt][3].ToString();
            //txtMarks4.Text = TempDt.Rows[COunt][4].ToString();
            //txtMarks5.Text = TempDt.Rows[COunt][5].ToString();
            //COunt++;
            //for (int k = 3; k < TempDt.Columns.Count; k++)
            //{
            //    string Marks = "0";
            //    TextBox txtCountry = new TextBox();
            //    txtCountry.ID = "txtMarks" + (k - 1).ToString();    
            //    if((e.Row.DataItem as DataRowView).Row[TempDt.Columns[k]].ToString()!="")
            //    {
            //        Marks = (e.Row.DataItem as DataRowView).Row[TempDt.Columns[k]].ToString();
            //    }
            //    txtCountry.Text = Marks;     
            //    e.Row.Cells[k-1].Controls.Add(txtCountry);
            //}
            //TextBox txt = new TextBox();
            //txt.Text = e.Row.Cells[e.Row.Cells.Count - 1].Text;
            //e.Row.Cells[e.Row.Cells.Count - 1].Text = "";
            //e.Row.Cells[e.Row.Cells.Count - 1].Controls.Add(txt);

            //TextBox txtCountry = new TextBox();
            //txtCountry.ID = "txtCountry";
            //txtCountry.Text = (e.Row.DataItem as DataRowView).Row["sturegno"].ToString();
            //e.Row.Cells[1].Controls.Add(txtCountry);

            //Label lblExamID = new Label();
            //lblExamID.ID = "lblExamID";
            //lblExamID.Text = (e.Row.DataItem as DataRowView).Row["sturegno"].ToString();
            //lblExamID.Visible = false;
            //e.Row.Cells[Convert.ToInt32(dtSubjectMarks.Columns.Count)].Controls.Add(lblExamID);
        }
    }

    private string getMarksFromDb(string examId, string regno, bool mode, bool IsGradeTypeSub = false, string subjectId = "")
    {
        if (!mode)
        {
            subjectId = ddlsubject.SelectedValue;
        }

        string marks = "", grade = "", isAbsent = "";
        string strMarks1 = @"Select ISnull(Grade,'') IsGrade, ISnull(marks,'0') marks, ISnull(IsAbsent,'0') IsAbsent from tbl_marks_master 
                            where sectionid=" + ddlsection.SelectedValue + " and examid=" + examId + " and classid=" + ddlcourse.SelectedValue +
                            " and subjectid=" + subjectId + " and studentregno=" + regno.ToString() + " and brid=" + Convert.ToInt64(Session["BrBrid"]) + "";

        DataTable dtMarks1 = objDut.GetDataTable(strMarks1);
        if (dtMarks1.Rows.Count > 0)
        {
            marks = Convert.ToString(dtMarks1.Rows[0]["marks"]);
            grade = Convert.ToString(dtMarks1.Rows[0]["IsGrade"]);
            isAbsent = Convert.ToString(dtMarks1.Rows[0]["IsAbsent"]);            
        }
        if (string.IsNullOrWhiteSpace(marks))
        {
            if (!IsGradeTypeSub)
                marks = "0";
        }
        else
        {
            if (IsGradeTypeSub)
                marks = grade;
        }
        if (isAbsent == "1")
        {
            marks = "AB";
        }

        return marks;
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        #region button submit

        // try
        // {
        IsGradeType = isGrade();
        var IsValid = true;
        if (!IsGradeType) {
            IsValid = validate();
        }
        if (IsValid)
        {
            foreach (GridViewRow row in grdsetmarks.Rows)
            {
                Label lblregno = (Label)row.FindControl("lblregno");
                TextBox txtMarks2 = row.FindControl("txtMarks2") as TextBox;
                TextBox txtMarks3 = row.FindControl("txtmarks3") as TextBox;
                TextBox txtMarks4 = row.FindControl("txtmarks4") as TextBox;
                TextBox txtMarks5 = row.FindControl("txtmarks5") as TextBox;
                int IsAbsent2 = 0, IsAbsent3 = 0,IsAbsent4 = 0,IsAbsent5 = 0;
                decimal decmarks2 = 0, decmarks3 = 0, decmarks4 = 0, decmarks5 = 0;
                string decmarks12 = "", decmarks13 = "", decmarks14 = "", decmarks15 = "";

                int Start1 = 0;
                int Start2 = 0;
                int Start3 = 0;
                int Start4 = 0;
                if (ddlTerm.SelectedValue == "1")
                {
                    IsAbsent2 = IsAbsent(txtMarks2.Text.ToString());
                    IsAbsent3 = IsAbsent(txtMarks3.Text.ToString());

                    decmarks12 = getMarks(txtMarks2.Text.ToString(), IsAbsent2, IsGradeType);
                    decmarks13 = getMarks(txtMarks3.Text.ToString(), IsAbsent3, IsGradeType);

                    Start1 = 0;
                    Start2 = 1;
                    Start3 = 2;
                    Start4 = 3;
                }
                else if (ddlTerm.SelectedValue == "2")
                {
                    IsAbsent4 = IsAbsent(txtMarks4.Text.ToString());
                    IsAbsent5 = IsAbsent(txtMarks5.Text.ToString());

                    decmarks14 = getMarks(txtMarks4.Text.ToString(), IsAbsent4, IsGradeType);
                    decmarks15 = getMarks(txtMarks5.Text.ToString(), IsAbsent5, IsGradeType);

                    Start1 = 0;
                    Start2 = 1;
                    Start3 = 2;
                    Start4 = 3;
                }
                else
                {
                    Start1 = 8;
                    Start2 = 9;
                    Start3 = 10;
                    Start4 = 11;
                }
                if (Session["ExamTemp"] != null)
                {
                    DataTable TempDt = new DataTable();
                    TempDt = (DataTable)(Session["ExamTemp"]);
                    if (TempDt.Rows.Count > 0)
                    {
                        int result = 0, result1 = 0, result2 = 0, result3 = 0;
                        if (ddlTerm.SelectedValue == "1")
                        {
                            result = uploadMarksNew(lblregno.Text, ddlsubject.SelectedValue, TempDt.Rows[Start1][0].ToString(), decmarks12.ToString(), IsGradeType, IsAbsent2);
                            result1 = uploadMarksNew(lblregno.Text, ddlsubject.SelectedValue, TempDt.Rows[Start2][0].ToString(), decmarks13.ToString(), IsGradeType, IsAbsent3);
                        }
                        if (ddlTerm.SelectedValue == "2")
                        {
                            result2 = uploadMarksNew(lblregno.Text, ddlsubject.SelectedValue, TempDt.Rows[Start3][0].ToString(), decmarks14.ToString(), IsGradeType, IsAbsent4);
                            result3 = uploadMarksNew(lblregno.Text, ddlsubject.SelectedValue, TempDt.Rows[Start4][0].ToString(), decmarks15.ToString(), IsGradeType, IsAbsent5);
                        }

                        //int result = INSERT_CO_Grade(Convert.ToInt32(lblregno.Text), Convert.ToInt32(ddlsubject.SelectedValue), decmarks2.ToString(), TempDt.Rows[Start1][0].ToString());
                        //int result1 = INSERT_CO_Grade(Convert.ToInt32(lblregno.Text), Convert.ToInt32(ddlsubject.SelectedValue), decmarks3.ToString(), TempDt.Rows[Start2][0].ToString());
                        //int result2 = INSERT_CO_Grade(Convert.ToInt32(lblregno.Text), Convert.ToInt32(ddlsubject.SelectedValue), decmarks4.ToString(), TempDt.Rows[Start3][0].ToString());
                        //int result3 = INSERT_CO_Grade(Convert.ToInt32(lblregno.Text), Convert.ToInt32(ddlsubject.SelectedValue), decmarks5.ToString(), TempDt.Rows[Start4][0].ToString());
                        if ((result == 1 && result1 == 1) || (result2 == 1 && result3 == 1))
                        {
                            //grdsetmarks.EmptyDataText = "<b><span style='font-size:12pt;'>" + ddlsubject.SelectedItem.Text + " marks for " + ddlcourse.SelectedItem.Text + " class have been inserted successfully</span></b>";
                            //grdsetmarks.DataBind();
                            divfortotal.Style.Add("display", "block");
                            divforsetmarks.Style.Add("display", "block");
                            divforclassname.Style.Add("display", "none");
                            divforexamname.Style.Add("display", "none");
                            //divforsetmarks2.Style.Add("display", "block");
                            btnsubmit.Style.Add("display", "none");
                            Utility.ViewAlertMessage(Page, "Marks Insert Successfully");
                        }
                        if ((result == 2 && result1 == 2) || (result2 == 2 && result3 == 2))
                        {
                            //grdsetmarks.EmptyDataText = "<b><span style='font-size:12pt;'>" + ddlsubject.SelectedItem.Text + " marks for " + ddlcourse.SelectedItem.Text + " class have already been inserted</span></b>";
                            btnsubmit.Style.Add("display", "none");
                            divforstudentheading.Style.Add("display", "block");
                            divforclassname.Style.Add("display", "none");
                            divforexamname.Style.Add("display", "none");
                            divforsetmarks.Style.Add("display", "block");
                            divfortotal.Style.Add("display", "block");
                            Utility.ViewAlertMessage(Page, "Marks Update Successfully");
                            //grdsetmarks.DataBind();
                        }
                    }
                }
            }
        }
        // }
        //  catch (Exception ex)
        // {
        // }
        #endregion button submit
    }

    private int IsAbsent(string marks)
    {
        return Convert.ToString(marks).ToUpper().Contains("AB") ? 1 : 0;
    }

    private string getMarks(string value, int isAbsent, bool isGrade)
    {
        string marks = "";
        decimal decmarks2 = 0;
        if (isGrade)
        {
            if (isAbsent > 0 || string.IsNullOrWhiteSpace(value))
                marks = "";
            else
            {
                var isNumeric = !string.IsNullOrEmpty(value) && value.All(Char.IsDigit);
                if (!isNumeric)
                    marks = Convert.ToString(value).Trim();
            }
        }
        else
        {
            if (isAbsent > 0 || string.IsNullOrWhiteSpace(value))
                marks = "0";
            else
            {
                decimal.TryParse(value, out decmarks2);
                decmarks2 = Math.Abs(decmarks2 / 1);
                marks = decmarks2.ToString();
            }
        }
        return marks;

        //if (IsGradeType)
        //{
        //    decmarks12 = txtMarks2.Text.ToString();
        //    decmarks13 = txtMarks3.Text.ToString();
        //    decmarks14 = txtMarks4.Text.ToString();
        //    decmarks15 = txtMarks5.Text.ToString();
        //}
        //else
        //{
        //    decimal.TryParse(txtMarks2.Text, out decmarks2);
        //    decimal.TryParse(txtMarks3.Text, out decmarks3);
        //    decimal.TryParse(txtMarks4.Text, out decmarks4);
        //    decimal.TryParse(txtMarks5.Text, out decmarks5);
        //    //decmarks2 = Math.Abs(decmarks2 / 5);
        //    decmarks2 = Math.Abs(decmarks2 / 1);
        //    decmarks3 = Math.Abs(decmarks3 / 1);
        //    decmarks4 = Math.Abs(decmarks4 / 1);
        //    decmarks5 = Math.Abs(decmarks5 / 1);

        //    decmarks12 = decmarks2.ToString();
        //    decmarks13 = decmarks3.ToString();
        //    decmarks14 = decmarks4.ToString();
        //    decmarks15 = decmarks5.ToString();
        //}
    }

    public int INSERT_CO_Grade(int RegNo, int SubjectID, string Marks, string ExamName)
    {
        int ExamID = 0;

        ExamID = Convert.ToInt32(ExamName);

        SqlParameter[] param = new SqlParameter[11];

        param[0] = new SqlParameter("@examid", SqlDbType.BigInt);
        param[0].Value = ExamID;

        param[1] = new SqlParameter("@classid", SqlDbType.BigInt);
        param[1].Value = ddlcourse.SelectedValue;

        param[2] = new SqlParameter("@subjectid", SqlDbType.BigInt);
        param[2].Value = ddlsubject.SelectedValue;

        param[3] = new SqlParameter("@secionid", SqlDbType.BigInt);
        param[3].Value = ddlsection.SelectedValue;

        param[4] = new SqlParameter("@sturegno", SqlDbType.BigInt);
        param[4].Value = Convert.ToInt32(RegNo);

        param[5] = new SqlParameter("@marks", SqlDbType.Char);
        if (Marks == "")
        {
            Marks = "0";
        }
        Marks = Convert.ToString(Math.Round(Convert.ToDecimal(Marks), 0));
        param[5].Value = Convert.ToInt32(Marks);


        param[6] = new SqlParameter("@fyid", SqlDbType.BigInt);
        param[6].Value = fyid;

        param[7] = new SqlParameter("@brid", SqlDbType.BigInt);
        param[7].Value = Convert.ToInt64(Session["BrBrid"]);

        param[8] = new SqlParameter("@status", SqlDbType.Int);
        param[8].Value = 1;

        param[9] = new SqlParameter("@intResult", SqlDbType.Int);
        param[9].Direction = ParameterDirection.Output;

        param[10] = new SqlParameter("@mode", SqlDbType.BigInt);
        param[10].Value = Convert.ToInt32(1);

        int result = objDut.ExecuteSqlSP(param, "Usp_Insert_Stud_marks");
        return result;
    }
    private bool validate()
    {
        foreach (GridViewRow row in grdsetmarks.Rows)
        {
            Label lblregno = (Label)row.FindControl("lblregno");
            Label lblname = (Label)row.FindControl("lblname");
            TextBox txtMarks2 = row.FindControl("txtMarks2") as TextBox;
            TextBox txtMarks3 = row.FindControl("txtmarks3") as TextBox;
            TextBox txtMarks4 = row.FindControl("txtmarks4") as TextBox;
            TextBox txtMarks5 = row.FindControl("txtmarks5") as TextBox;

            decimal decmarks2 = 0, decmarks3 = 0, decmarks4 = 0, decmarks5 = 0;
            decimal.TryParse(txtMarks2.Text, out decmarks2);
            decimal.TryParse(txtMarks3.Text, out decmarks3);
            decimal.TryParse(txtMarks4.Text, out decmarks4);
            decimal.TryParse(txtMarks5.Text, out decmarks5);
                        
            //decmarks2 = Math.Abs(decmarks2 / 5);
            decmarks2 = Math.Abs(decmarks2 / 1);
            decmarks3 = Math.Abs(decmarks3 / 1);
            decmarks4 = Math.Abs(decmarks4 / 1);
            decmarks5 = Math.Abs(decmarks5 / 1);
            int Start1 = 0;
            int Start2 = 0;
            int Start3 = 0;
            int Start4 = 0;
            if (Session["ExamTemp"] != null)
            {
                DataTable TempDt = new DataTable();
                TempDt = (DataTable)(Session["ExamTemp"]);
                if (TempDt.Rows.Count > 0)
                {
                    if (ResultType.Value == "1")
                    {
                        if (ddlTerm.SelectedValue == "1")
                        {
                            Start1 = 0;
                            Start2 = 0;
                            Start3 = 0;
                            Start4 = 3;
                        }
                        else if (ddlTerm.SelectedValue == "2")
                        {
                            Start1 = 0;
                            Start2 = 0;
                            Start3 = 0;
                            Start4 = 7;
                        }
                        else
                        {
                            Start1 = 0;
                            Start2 = 0;
                            Start3 = 0;
                            Start4 = 11;
                        }
                        decimal Marks5 = 0;
                        string strMarks5 = objDut.GetScalar("Select ISNULL(maxmarks,0) from exam_name where eid=" + TempDt.Rows[Start4][0] + " and fyid =" + fyid + " and brid=" + Convert.ToInt64(Session["BrBrid"]) + " and status=1").ToString();
                        if (strMarks5.ToString() == "")
                        {
                            Marks5 = 0;
                        }
                        Marks5 = Convert.ToDecimal(strMarks5);

                        if (Convert.ToDecimal(decmarks5) > Marks5)
                        {
                            //Utility.ViewAlertMessage(Page, "Entered Marks can not be greater than " + Marks5*5 + " of " + ddlsubject.SelectedItem.Text.ToString() + " for " + TempDt.Rows[Start4][1] + " of " + lblname.Text.ToString() + "");
                            Utility.ViewAlertMessage(Page, "Entered Marks can not be greater than " + Marks5 + " of " + ddlsubject.SelectedItem.Text.ToString() + " for " + TempDt.Rows[Start4][1] + " of " + lblname.Text.ToString() + "");
                            return false;
                        }
                    }
                    else
                    {
                        if (ddlTerm.SelectedValue == "1")
                        {
                            Start1 = 0;
                            Start2 = 1;
                            Start3 = 2;
                            Start4 = 3;
                        }
                        else if (ddlTerm.SelectedValue == "2")
                        {
                            // Start1 = 4;
                            // Start2 = 5;
                            // Start3 = 6;
                            // Start4 = 7;
                            Start1 = 0;
                            Start2 = 1;
                            Start3 = 2;
                            Start4 = 3;
                        }
                        else
                        {
                            Start1 = 8;
                            Start2 = 9;
                            Start3 = 10;
                            Start4 = 11;
                        }
                    }

                    decimal Marks1 = 0;
                    decimal Marks2 = 0;
                    decimal Marks3 = 0;
                    decimal Marks4 = 0;

                    if (ResultType.Value == "1")
                    {
                        string strMarks1 = objDut.GetScalar("Select ISNULL(maxmarks,0) from exam_name where eid=" + TempDt.Rows[Start1][0] + " and fyid =" + fyid + " and brid=" + Convert.ToInt64(Session["BrBrid"]) + " and status=1").ToString();
                        if (strMarks1.ToString() == "")
                        {
                            Marks1 = 0;
                        }
                        Marks1 = Convert.ToDecimal(strMarks1);

                        if (Convert.ToDecimal(decmarks2) > Marks1)
                        {
                            Utility.ViewAlertMessage(Page, "Entered Marks can not be greater than " + Marks1 * 5 + " of " + ddlsubject.SelectedItem.Text.ToString() + " for " + TempDt.Rows[Start1][1] + " of " + lblname.Text.ToString() + "");
                            return false;
                        }
                    }
                    else
                    {
                        string strMarks1 = objDut.GetScalar("Select ISNULL(maxmarks,0) from exam_name where eid=" + TempDt.Rows[Start1][0] + " and fyid =" + fyid + " and brid=" + Convert.ToInt64(Session["BrBrid"]) + " and status=1").ToString();
                        if (strMarks1.ToString() == "")
                        {
                            Marks1 = 0;
                        }
                        Marks1 = Convert.ToDecimal(strMarks1);

                        if (Convert.ToDecimal(decmarks2) > Marks1)
                        {
                            Utility.ViewAlertMessage(Page, "Entered Marks can not be greater than " + Marks1 * 5 + " of " + ddlsubject.SelectedItem.Text.ToString() + " for " + TempDt.Rows[Start1][1] + " of " + lblname.Text.ToString() + "");
                            return false;
                        }

                        string strMarks2 = objDut.GetScalar("Select ISNULL(maxmarks,0) from exam_name where eid=" + TempDt.Rows[Start2][0] + " and fyid =" + fyid + " and brid=" + Convert.ToInt64(Session["BrBrid"]) + " and status=1").ToString();
                        if (strMarks2.ToString() == "")
                        {
                            Marks2 = 0;
                        }
                        Marks2 = Convert.ToDecimal(strMarks2);
                        if (Convert.ToDecimal(decmarks3) > Marks2)
                        {
                            Utility.ViewAlertMessage(Page, "Entered Marks can not be greater than " + Marks2 * 5 + " of " + ddlsubject.SelectedItem.Text.ToString() + " for " + TempDt.Rows[Start2][1] + " of " + lblname.Text.ToString() + "");
                            return false;
                        }

                        string strMarks3 = objDut.GetScalar("Select ISNULL(maxmarks,0) from exam_name where eid=" + TempDt.Rows[Start3][0] + " and fyid =" + fyid + " and brid=" + Convert.ToInt64(Session["BrBrid"]) + " and status=1").ToString();
                        if (strMarks3.ToString() == "")
                        {
                            Marks3 = 0;
                        }
                        Marks3 = Convert.ToDecimal(strMarks3);
                        if (Convert.ToDecimal(decmarks4) > Marks3)
                        {
                            Utility.ViewAlertMessage(Page, "Entered Marks can not be greater than " + Marks3 * 5 + " of " + ddlsubject.SelectedItem.Text.ToString() + " for " + TempDt.Rows[Start3][1] + " of " + lblname.Text.ToString() + "");
                            return false;
                        }

                        string strMarks4 = objDut.GetScalar("Select ISNULL(maxmarks,0) from exam_name where eid=" + TempDt.Rows[Start4][0] + " and fyid =" + fyid + " and brid=" + Convert.ToInt64(Session["BrBrid"]) + " and status=1").ToString();
                        if (strMarks4.ToString() == "")
                        {
                            Marks4 = 0;
                        }
                        Marks4 = Convert.ToDecimal(strMarks4);
                        if (Convert.ToDecimal(decmarks5) > Marks4)
                        {
                            Utility.ViewAlertMessage(Page, "Entered Marks can not be greater than " + Marks4 * 5 + " of " + ddlsubject.SelectedItem.Text.ToString() + " for " + TempDt.Rows[Start4][1] + " of " + lblname.Text.ToString() + "");
                            return false;
                        }
                    }
                }
            }
        }
        //if (txtmarks1.Text != "" && chkstatus1.Checked == true)
        //{
        //    Utility.ViewAlertMessage(Page, "You can only enter the marks or check the status");
        //    return false;
        //}

        return true;
    }
    //private void CreateRepeater()
    //{
    //    string StrStr = "";
    //    StrStr = " where SEM.fyid=" + fyid + " and SEM.brid=" + Convert.ToInt64(Session["BrBrid"]) + " and SEM.examid=" + ddlexam.SelectedValue + "";

    //    DataUtility objDut = new DataUtility();
    //    string strSubject = " Select DISTINCT Subject_Master.SubjectName from tbl_marks_master SEM " +
    //                        " inner join Subject_Master on Subject_Master.id = SEM.subjectid " + StrStr;
    //    DataTable dtSubject = objDut.GetDataTable(strSubject);
    //    if (dtSubject.Rows.Count > 0)
    //    {
    //        string strSubjectList = "";
    //        //foreach (DataRow dr in dtSubject.Rows)
    //        //{
    //        //    if (dr["SubjectName"].ToString() != "")
    //        //    {
    //        //        if (strSubjectList == "")
    //        //        {
    //        //            strSubjectList = "[" + dr["SubjectName"].ToString() + "]";
    //        //        }
    //        //        else
    //        //        {
    //        //            strSubjectList = strSubjectList + ",[" + dr["SubjectName"].ToString() + "]";
    //        //        }
    //        //    }
    //        //}
    //        string Query = "SELECT" +
    //            //" FROM ( " +
    //            //    " SELECT " +
    //                     " SR.StudentFirstName+' '+SR.StudentMiddleName+' '+SR.StudentLastName as name,SM.sturegno,SEM.examid,Subject_Master.SubjectName,CASE SEM.marks WHEN 0 THEN 'Select' WHEN 1 THEN 'A' WHEN 2 THEN 'B' WHEN 3 THEN 'C' END AS marks " +
    //                     " FROM tbl_StudentRegistration SR " +
    //                     " inner join tbl_StudentMaster SM on SM.RID = SR.RID and SR.Brid = SM.Brid" +
    //                     " inner join tbl_marks_master SEM on SEM.studentregno = SM.SturegNo " +
    //                     " inner join Subject_Master on Subject_Master.id = SEM.subjectid " + StrStr;// +" ) as s " +
    //        //" PIVOT " +
    //        //" ( SUM(marks) FOR [SubjectName] IN (" + strSubjectList + ") )AS pvt";

    //        dtSubjectMarks = objDut.GetDataTable(Query);
    //    }

    //    if (dtSubjectMarks.Rows.Count > 0)
    //    {
    //        BoundField bfield = new BoundField();
    //        bfield.ItemStyle.CssClass = "bgd";
    //        for (int i = 0; i < dtSubjectMarks.Columns.Count; i++)
    //        {
    //            if (dtSubjectMarks.Columns[i].ColumnName.ToString() != "examid")
    //            {
    //                bfield = new BoundField();
    //                bfield.HeaderText = dtSubjectMarks.Columns[i].ColumnName.ToString();
    //                bfield.DataField = dtSubjectMarks.Columns[i].ColumnName.ToString();
    //                gridforshowmarks.Columns.Add(bfield);
    //            }
    //        }

    //        TemplateField tfield = new TemplateField();
    //        tfield = new TemplateField();
    //        tfield.HeaderText = "View";
    //        gridforshowmarks.Columns.Add(tfield);

    //        gridforshowmarks.DataSource = dtSubjectMarks;
    //        gridforshowmarks.DataBind();
    //    }
    //    else
    //    {
    //        gridforshowmarks.DataSource = null;
    //        gridforshowmarks.DataBind();
    //    }
    //}
    private void Bind_student_marks(int examid, int classid, int sectionid)
    {
        DataTable TempDt = new DataTable();
        string StrStr = "";
        StrStr = " where SEM.fyid=" + fyid + " and SEM.brid=" + Convert.ToInt64(Session["BrBrid"]) + "";

        string StrStr1 = "";
        StrStr1 = " where SEM.fyid=" + fyid + " and SEM.brid=" + Convert.ToInt64(Session["BrBrid"]) + "";

        DataUtility objDut = new DataUtility();
        string strSubject = " Select DISTINCT Subject_Master.SubjectName,ISNULL(marks,0) marks from tbl_marks_master SEM " +
                            " inner join Subject_Master on Subject_Master.id = SEM.subjectid " + StrStr1 + " and Subject_Master.SubjectName NOT IN('Health & Physical Education','Work Education','Discipline','Art Education')";
        DataTable dtSubject = objDut.GetDataTable(strSubject);
        if (dtSubject.Rows.Count > 0)
        {
            string strSubjectList = "";
            foreach (DataRow dr in dtSubject.Rows)
            {
                if (dr["subjectname"].ToString() != "")
                {
                    if (strSubjectList == "")
                    {
                        strSubjectList = "[" + dr["subjectname"].ToString() + "]";
                    }
                    else
                    {
                        strSubjectList = strSubjectList + ",[" + dr["subjectname"].ToString() + "]";
                    }
                }
            }
            string Query = "SELECT *" +
                " FROM ( " +
                    " SELECT " +
                         " SR.StudentFirstName+' '+SR.StudentMiddleName+' '+SR.StudentLastName as name,SM.sturegno,SEM.examid,Subject_Master.SubjectName,SEM.marks " +
                         " FROM tbl_StudentRegistration SR " +
                         " inner join tbl_StudentMaster SM on SM.RID = SR.RID and SR.Brid = SM.Brid" +
                         " inner join tbl_marks_master SEM on SEM.studentregno = SM.SturegNo " +
                         " inner join Subject_Master on Subject_Master.id = SEM.subjectid " + StrStr + " ) as s " +
            " PIVOT " +
            " ( SUM(marks) FOR [SubjectName] IN (" + strSubjectList + ") )AS pvt";

            TempDt = objDut.GetDataTable(Query);

            if (TempDt.Rows.Count > 0)
            {
                //dtSubjectMarks = new DataTable();
                //for (int a = 0; a < TempDt.Columns.Count; a++)
                //{
                //    dtSubjectMarks.Columns.Add(TempDt.Columns[a].ColumnName.ToString());
                //}

                //for (int a = 0; a < TempDt.Rows.Count; a++)
                //{
                //    DataRow dr = dtSubjectMarks.NewRow();
                //    for (int b = 0; b < TempDt.Columns.Count; b++)
                //    {
                //        string ColName = TempDt.Columns[b].ColumnName.ToString();
                //        if (b == 0 || b == 1 || b == 2)
                //        {
                //            dr[ColName] = TempDt.Rows[a][b];
                //        }
                //        else
                //        {
                //            if (b > 2)
                //            {
                //                int Grade = 0;
                //                if (TempDt.Rows[a][b] != DBNull.Value)
                //                {
                //                    Grade = Convert.ToInt32(TempDt.Rows[a][b]);
                //                }
                //                else
                //                {
                //                    Grade = 0;
                //                }
                //                if (Grade == 1)
                //                {
                //                    dr[ColName] = "A";
                //                }
                //                else if (Grade == 2)
                //                {
                //                    dr[ColName] = "B";
                //                }
                //                else if (Grade == 3)
                //                {
                //                    dr[ColName] = "C";
                //                }
                //                else
                //                {
                //                    dr[ColName] = "N/A";
                //                }
                //            }
                //        }
                //    }
                //    dtSubjectMarks.Rows.Add(dr);
                //    dtSubjectMarks.AcceptChanges();
                //}

                if (gridforshowmarks.Columns.Count == 2)
                {
                    BoundField bfield = new BoundField();
                    bfield.ItemStyle.CssClass = "bgd";
                    for (int i = 0; i < TempDt.Columns.Count; i++)
                    {
                        if (TempDt.Columns[i].ColumnName.ToString() != "examid")
                        {
                            bfield = new BoundField();
                            bfield.HeaderText = TempDt.Columns[i].ColumnName.ToString();
                            bfield.DataField = TempDt.Columns[i].ColumnName.ToString();
                            gridforshowmarks.Columns.Add(bfield);
                        }
                    }

                    //TemplateField tfield = new TemplateField();
                    ////tfield = new TemplateField();
                    //tfield.HeaderText = "View";
                    //gridforshowmarks.Columns.Add(tfield);
                }
            }

            gridforshowmarks.DataSource = TempDt;
            gridforshowmarks.DataBind();
        }
        else
        {
            gridforshowmarks.DataSource = null;
            gridforshowmarks.DataBind();
        }
    }

    protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            for (int j = 0; j < e.Row.Cells.Count; j++)
            {
                e.Row.Cells[j].Style.Add("COLOR", "RED");
                e.Row.Cells[j].Style.Add("text-align", "LEFT");
            }
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            for (int k = 0; k < e.Row.Cells.Count; k++)
            {
                e.Row.Cells[k].Style.Add("BACKGROUND-COLOR", "WHITE");

            }
            //TextBox txt = new TextBox();
            //txt.Text = e.Row.Cells[e.Row.Cells.Count-1].Text;
            //e.Row.Cells[e.Row.Cells.Count-1].Text = "";
            //e.Row.Cells[e.Row.Cells.Count-1].Controls.Add(txt);

            //TextBox txtCountry = new TextBox();
            //txtCountry.ID = "txtCountry";
            //txtCountry.Text = (e.Row.DataItem as DataRowView).Row["sturegno"].ToString();
            //e.Row.Cells[1].Controls.Add(txtCountry);

            //Label lblExamID = new Label();
            //lblExamID.ID = "lblExamID";
            //lblExamID.Text = (e.Row.DataItem as DataRowView).Row["examid"].ToString();
            //lblExamID.Visible = false;
            //e.Row.Cells[Convert.ToInt32(dtSubjectMarks.Columns.Count)].Controls.Add(lblExamID);

            //Button btnquestion = new Button();
            //btnquestion.Text = "View";
            //btnquestion.ID = "lnkView";
            //btnquestion.CssClass = "btn btn-primary";
            //btnquestion.CommandArgument = (e.Row.DataItem as DataRowView).Row["sturegno"].ToString();
            //btnquestion.CommandName = "Show";
            //btnquestion.OnClientClick += new System.EventHandler(ViewDetails);
            //btnquestion.Click += new System.EventHandler(ViewDetails);
            //e.Row.Cells[Convert.ToInt32(dtSubjectMarks.Columns.Count)].Controls.Add(btnquestion);

            //LinkButton lnkview = new LinkButton();
            //lnkview.ID = "lnkview";
            //lnkview.Text = "view";
            //lnkview.CommandArgument = (e.Row.DataItem as DataRowView).Row["sturegno"].ToString();
            //lnkview.CommandName = "Show";
            //lnkview.Click += new System.EventHandler(this.ViewDetails);

            // e.Row.Cells[Convert.ToInt32(dtSubjectMarks.Columns.Count)].Controls.Add(lnkview);

        }
    }


    protected void ViewDetails(object sender, EventArgs e)
    {
        LinkButton lnkView = (sender as LinkButton);
        Label lblExamID = (sender as Label);
        GridViewRow row = (lnkView.NamingContainer as GridViewRow);
        int examid = 0;

        //if (ddlexam.SelectedIndex > 0)
        //{
        //    examid = Convert.ToInt32(ddlexam.SelectedValue);
        //}

        if (lnkView.CommandName == "Show")
        {
            GridViewRow gvRow = lnkView.Parent.NamingContainer as GridViewRow;
            int regno = Convert.ToInt32(lnkView.CommandArgument);

            string strClassID = "";
            int ClassID = 0;

            strClassID = @"Select DISTINCT isnull(SA.ClassID,'0') ClassID from tbl_StudentRegistration SR
				inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.Brid
				inner join tbl_StudentAdmissionMaster SA on SA.StuRegNo = SM.SturegNo
				where SA.IsTerminated=0 and SA.StuRegNo=" + regno + " and SR.IsAdmissionTaken=1 and SR.Brid=" + Convert.ToInt32(Session["BrBrid"]) + "";

            ClassID = (int)(objDut.GetScalar(strClassID));

            if (ClassID > 1 && ClassID < 6)
            {
                //Response.Redirect("ReportCard.aspx?regno=" + regno + "");
                Response.Write("<script>window.open ('ReportCard.aspx?regno=" + regno + "','_blank');</script>");
            }
            else
            {
                Response.Write("<script>window.open ('ReportCard.aspx?regno=" + regno + "','_blank');</script>");
                //Response.Redirect("ReportCard.aspx?regno=" + regno + "");
            }
        }
    }
    private int examid = 0;

    protected void gridforshowmarks_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Control ctrl = e.CommandSource as Control;
        if (0 > 0)
        {
            examid = Convert.ToInt32(0);
        }
        else if (ddlforexamname.SelectedIndex > 0)
        {
            examid = Convert.ToInt32(ddlforexamname.SelectedValue);
        }
        if (e.CommandName == "Show")
        {
            GridViewRow gvRow = ctrl.Parent.NamingContainer as GridViewRow;
            int eid = Convert.ToInt32(((Label)gvRow.FindControl("lbleid")).Text);
            int regno = Convert.ToInt32(e.CommandArgument);

            if (examid == 4)
            {
                Response.Redirect("halfyearly-report.aspx?regno=" + regno + " &eid=" + eid + "");
            }
            else
            {
                Response.Redirect("sessional-report-card.aspx?regno=" + regno + " &eid=" + eid + "");
            }
        }
    }

    protected void ddlforexamname_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlforexamname.SelectedIndex > 0)
        {
            fill_Dropdown_Result(Convert.ToInt32(ddlforexamname.SelectedValue));
            //Bind_student_marks(Convert.ToInt32(ddlforexamname.SelectedValue), Convert.ToInt32(ddlforclassame.SelectedValue), 0);
        }
    }

    protected void ddlforclassame_SelectedIndexChanged(object sender, EventArgs e)
    {
        //Bind_student_marks(Convert.ToInt32(ddlforexamname.SelectedValue), Convert.ToInt32(ddlforclassame.SelectedValue), 0);
    }

    private void fill_Dropdown_Result(int examid)
    {
        //if (examid > 0)
        //{
        //    Query = " Select Distinct cm.id as classid,cm.Classname from classwithsection cws " +
        //                  " left outer join Class_Master cm on cws.classid=cm.id " +
        //        //" inner join exam_class ec on ec.brid = cws.branchid " +
        //                  " where cm.status=1 and cws.branchid=" + Session["brBrid"] + " and cm.fyid=" + fyid; //+ "" +
        //    //" and ec.examid =" + examid;
        //    Dt = objDut.GetDataTable(Query);
        //    ddlforclassame.DataSource = Dt;
        //    ddlforclassame.DataTextField = "classname";
        //    ddlforclassame.DataValueField = "classid";
        //    ddlforclassame.DataBind();
        //    ListItem licourse = new ListItem("Select Class", "0");
        //    ddlforclassame.Items.Insert(0, licourse);
        //}
        //else
        //{
        //    Query = "select eid,examname from exam_name where brid=" + Session["brBrid"] + " order by eid asc";
        //    Dt = objDut.GetDataTable(Query);
        //    ddlexam.DataSource = Dt;
        //    ddlexam.DataTextField = "examname";
        //    ddlexam.DataValueField = "eid";
        //    ddlexam.DataBind();
        //    ListItem liexam = new ListItem("Select Exam", "0");
        //    ddlexam.Items.Insert(0, liexam);
        //}
    }
    protected void gridforshowmarks_RowCommand2(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "View")
        {

            int regno = Convert.ToInt32(e.CommandArgument);

            string strClassID = "";
            int ClassID = 0;

            strClassID = @"Select DISTINCT isnull(SA.ClassID,'0') ClassID from tbl_StudentRegistration SR
				inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.Brid
				inner join tbl_StudentAdmissionMaster SA on SA.StuRegNo = SM.SturegNo
				where SA.IsTerminated=0 and SA.StuRegNo=" + regno + " and SR.IsAdmissionTaken=1 and SR.Brid=" + Convert.ToInt32(Session["BrBrid"]) + "";

            ClassID = (int)(objDut.GetScalar(strClassID));

            if (ClassID > 1 && ClassID < 6)
            {
                //Response.Redirect("ReportCard.aspx?regno=" + regno + "");
                Response.Write("<script>window.open ('ReportCard.aspx?regno=" + regno + "','_blank');</script>");
            }
            else
            {
                Response.Write("<script>window.open ('ReportCard.aspx?regno=" + regno + "','_blank');</script>");
                //Response.Redirect("ReportCard.aspx?regno=" + regno + "");
            }
        }
    }
    protected void grdsetmarks_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //HiddenField gradeID = (HiddenField)e.Row.FindControl("gradeID");
            //DropDownList ddlsubGrade = (DropDownList)e.Row.FindControl("ddlsubGrade");
            //if (gradeID.Value != "")
            //{
            //    //int GradeID = Convert.ToInt32(gradeID.Value);
            //    //ddlsubGrade.SelectedValue = GradeID.ToString();
            //}
        }
    }
    protected void ddlTerm_SelectedIndexChanged(object sender, EventArgs e)
    {
        HideGrid();
        OnSelectTerm();
        if (ddlTerm.SelectedValue != "0")
        {
            ddlcourse.DataSource = null;
            ddlcourse.DataBind();

            Query = " Select Distinct cm.id as classid,cm.Classname from classwithsection cws " +
                            " left outer join Class_Master cm on cws.classid=cm.id " +
                            //" inner join exam_class ec on ec.brid = cws.branchid " +
                            " where cm.status=1 and cws.branchid=" + Session["brBrid"] + " and cm.fyid=" + fyid; //+ "" +
            //" and ec.examid =" + examid;
            Dt = objDut.GetDataTable(Query);
            ddlcourse.Enabled = true;
            ddlcourse.DataSource = Dt;
            ddlcourse.DataTextField = "classname";
            ddlcourse.DataValueField = "classid";
            ddlcourse.DataBind();
            System.Web.UI.WebControls.ListItem licourse = new System.Web.UI.WebControls.ListItem("Select Class", "0");
            ddlcourse.Items.Insert(0, licourse);
            divCourse.Visible = true;
        }
        else {
            divCourse.Visible = false;
        }
    }

    private void OnSelectTerm()
    {
        divCourse.Visible = false;
        divSection.Visible = false;
        if (ddlsection.SelectedIndex > 0) {
            ddlsection.SelectedValue = "0";
        }
        if (ddlcourse.SelectedIndex > 0) {
            ddlcourse.SelectedValue = "0";
        }
        ddlsection.Enabled = true;
        RestOnSelectSection();
    }
    private void OnSelectCourse()
    {
        OnSelectSection();
    }
    private void OnSelectSection()
    {
        RestOnSelectSection();
    }

    private void RestOnSelectSection()
    {
        divUpdateOption.Visible = false;
        divSubject.Visible = false;
        if (ddlUpdateOption.SelectedIndex > 0)
        {
            ddlUpdateOption.SelectedValue = "0";
        }
        if (ddlsubject.SelectedIndex > 0)
        {
            ddlsubject.SelectedValue = "0";
        }
        btncancel.Visible = false;
        btnDwonload.Visible = false;
        Button1.Visible = false;
        divGrid.Visible = false;
    }

    protected void btnDwonload_Click(object sender, EventArgs e)
    {

        int mode = 0;
        int.TryParse(cserc.SelectedValue, out mode);
        int subid = 0;
        int.TryParse(ddlsubject.SelectedValue, out subid);
        GetDataExcel(Convert.ToInt32(ddlcourse.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue));
        //this.FillGrid(Convert.ToInt32(ddlcourse.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue), subid, mode);
        if (dtSubjectMark.Rows.Count > 0)
        {
            //string FileName = ddlTerm.SelectedItem.Text + "_" + ddlcourse.SelectedItem.Text + "_" + ddlsection.SelectedItem.Text + "_Shl_" + ddlsubject.SelectedItem.Text + "_" + DateTime.Today.ToString("dd_MMM_yy");
            string FileName = ddlTerm.SelectedItem.Text + "_" + ddlcourse.SelectedItem.Text + "_" + ddlsection.SelectedItem.Text + "_" + DateTime.Today.ToString("dd_MMM_yy");
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", FileName + ".xls"));
            Response.ContentType = "application/ms-excel";
            string str = string.Empty;
            foreach (DataColumn dtcol in dtSubjectMark.Columns)
            {
                Response.Write(str + dtcol.ColumnName.ToString().ToUpper());
                str = "\t";
            }
            Response.Write("\n");
            foreach (DataRow dr in dtSubjectMark.Rows)
            {
                str = "";
                for (int j = 0; j < dtSubjectMark.Columns.Count; j++)
                {

                    Response.Write(str + Convert.ToString(dr[j]));

                    str = "\t";
                }
                Response.Write("\n");
            }
            Response.End();
        }
        else
        {
            Utility.ViewAlertMessage(Page, "No Records Found");
        }
    }

    private void GetDataExcel(int classid, int sectionid)
    {
        string Query = "";
        string StrQuery = "";
        string SubjectName = "";
        string Marks = "0";
        int SubjectID1 = 0;
        if (classid > 0)
        {
            var Mode = Convert.ToInt32(Convert.ToString(rbnUpdateOption.SelectedValue));
            if (Mode == 1)
            {
                StrQuery = " Order by Sr.RegNewNo asc";
            }
            else if (Mode == 2)
            {
                StrQuery = " Order by Sr.StudentFirstName asc";
            }
            string strQuery = @"SELECT SR.StudentFirstName+' '+SR.StudentMiddleName+' '+SR.StudentLastName +'('+SR.RegNewNo+')' as 'Name of Student',SM.StuRegNO as RegNo,
                            CM.Classname as Class,CWS.sectionname as Section
                            FROM tbl_StudentRegistration SR  
                            inner join tbl_StudentMaster SM on SM.RID = SR.RID and SR.Brid = SM.Brid
                            inner join Class_Master CM on CM.id = SM.Classid
                            inner join classwithsection CWS on CWS.classid = CM.id and CWS.cwsid = SM.sectionid
                           INNER JOIN tbl_StudentAdmissionMaster sa ON SM.SturegNo = sa.StuRegNo and sa.Brid = SR.Brid
						   where sa.IsTerminated=0 and SR.brid=" + Session["brBrid"] + " and SM.classid=" + classid + " and sm.sectionID=" + sectionid + "" + StrQuery + "";

            DataSet dtStdExcelData = objDut.GetDataSet(strQuery);
            if (dtStdExcelData.Tables[0].Rows.Count > 0)
            {
                DataSet dt = new DataSet();
                var fileName = "ForExamUpdateByClass_" + ddlExam.SelectedValue + "_" + "_" + dtStdExcelData.Tables[0].Rows[0]["Class"] + "_" + "Sec" + "_" + dtStdExcelData.Tables[0].Rows[0]["Section"] + "_" + DateTime.Today.ToString("dd_MMM_yy");

                var dtSubjectList = GetSubjectList();
                if (dtSubjectList.Rows.Count > 0)
                {
                    foreach (DataRow dataRow in dtSubjectList.Rows)
                    {
                        var SubjectId = dataRow.ItemArray[0].ToString();
                        var SubjectName1 = dataRow.ItemArray[1].ToString();
                        dtStdExcelData.Tables[0].Columns.Add(Convert.ToString(SubjectName1).Trim());
                    }

                    dt = updateSubjecMarks(dtStdExcelData, 1);
                }
                dtStdExcelData.AcceptChanges();

                using (XLWorkbook wb = new XLWorkbook())
                {
                    wb.Worksheets.Add(dt.Tables[0], "Sheet1");
                    wb.NamedRange("Enter_a_Name_same_as_Excelsheetname");
                    Response.Clear();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".xlsx");
                    using (MemoryStream MyMemoryStream = new MemoryStream())
                    {
                        wb.SaveAs(MyMemoryStream);
                        MyMemoryStream.WriteTo(Response.OutputStream);
                        Response.Flush();
                        Response.End();
                    }
                }

                ResultType.Value = Convert.ToString(objDut.GetScalar(@"SELECT ISNULL(mst_RresultToClass.Status,0) Status
                            from mst_RresultToClass
                            where brid=" + Session["brBrid"] + " and classid=" + classid + " and mst_RresultToClass.ResultTypeID=1"));
                //ResultType.Value = "1";
                //if (Convert.ToInt32(ddlcourse.SelectedValue) > 0)
                //{
                //    Query = @"Select subjectid,subjectname from SubjectBranch_master where BranchId=" + Session["brBrid"] + " and classid=" + Convert.ToInt32(ddlcourse.SelectedValue) + " and subjectname NOT IN('Health & Physical Education','Work Education','Discipline','Art Education')";
                //    Dt = objDut.GetDataTable(Query);
                //    if (Dt.Rows.Count > 0)
                //    {
                //        foreach (DataRow dr in Dt.Rows)
                //        {
                //            dtStd.Columns.Add(dr["subjectname"].ToString());
                //        }

                //        for (int i = 0; i < dtStd.Rows.Count; i++)
                //        {
                //            for (int k = 2; k < dtStd.Columns.Count; k++)
                //            {
                //                SubjectName = dtStd.Columns[k].ToString().Trim();
                //                SubjectID1 = (int)(objDut.GetScalar("Select subjectid from SubjectBranch_master where BranchId=" + Session["brBrid"] + "and subjectname ='" + SubjectName + "' and classid=" + classid + ""));
                //                string strMarks = "Select ISnull(marks,'0') marks from tbl_marks_master where examid=" + ddlTerm.SelectedValue + " and classid=" + classid + " and subjectid=" + SubjectID1 + " and studentregno=" + dtStd.Rows[i]["sturegno"].ToString() + "";
                //                if (SubjectID1 > 0)
                //                {
                //                    Marks = Convert.ToString(objDut.GetScalar(strMarks));
                //                    if (Marks == "")
                //                    {
                //                        Marks = "0";
                //                    }
                //                    dtStd.Rows[i][k] = Marks.ToString();
                //                }
                //            }
                //        }
                //dtSubjectMark.TableName = "CopyTable";
                //dtSubjectMark = dtStd.Copy();

                //grdsetmarks.DataSource = dtStd;
                //grdsetmarks.DataBind();
                btnsubmit.Style.Add("display", "block");
                divforstudentheading.Style.Add("display", "block");

                //SqlParameter[] param = new SqlParameter[4];

                //param[0] = new SqlParameter("@classid", SqlDbType.Int);
                //param[0].Value = classid;

                //param[1] = new SqlParameter("@sectionid", SqlDbType.Int);
                //param[1].Value = sectionid;

                ////param[2] = new SqlParameter("@subjectid", SqlDbType.Int);
                ////param[2].Value = SubjectID;

                //param[2] = new SqlParameter("@examid", SqlDbType.Int);
                //param[2].Value = Convert.ToInt32(ddlexam.SelectedValue);

                //param[3] = new SqlParameter("@mode", SqlDbType.Int);
                //param[3].Value = Convert.ToInt32(2);

                ////if (ddlsubject.SelectedValue != "0")
                ////{
                //DataSet dt = objDut.GetDataSetSP(param, "Usp_getStudent");
                //if (dt.Tables[0].Rows.Count > 0)
                //{
                //    if (dt.Tables[1].Rows.Count > 0)
                //    {
                //        foreach (DataRow dr in dt.Tables[1].Rows)
                //        {
                //            foreach (DataRow dr1 in dt.Tables[0].Rows)
                //            {
                //                if (dr1["sturegno"].ToString() == dr["sturegno"].ToString())
                //                {
                //                    dr1["marks"] = dr["marks"].ToString();
                //                }
                //            }
                //        }
                //    }
                //    grdsetmarks.DataSource = dt.Tables[0];
                //    grdsetmarks.DataBind();
                //    btnsubmit.Style.Add("display", "block");
                //    divforstudentheading.Style.Add("display", "block");
                //}
                //else
                //{
                //    grdsetmarks.EmptyDataText = "No Record Found";
                //    btnsubmit.Style.Add("display", "none");
                //    divforstudentheading.Style.Add("display", "block");
                //    grdsetmarks.DataBind();
                //}
                //}
                //else
                //{
                //    grdsetmarks.EmptyDataText = "No Record Found";
                //    btnsubmit.Style.Add("display", "none");
                //    divforstudentheading.Style.Add("display", "block");
                //    grdsetmarks.DataBind();
                //}
                //}
            }
        }
        else
        {
            grdsetmarks.EmptyDataText = "No Record Found";
            btnsubmit.Style.Add("display", "none");
            divforstudentheading.Style.Add("display", "block");
            grdsetmarks.DataBind();
        }
    }
    private bool isGrade() {
        var IsGrade = false;
        string str = @"Select CASE when IsGrade = 1 then 'true' else 'false' end IsGrade from SubjectBranch_master where BranchId="+ Convert.ToInt64(Session["BrBrid"]) + " and classid=" + ddlcourse.SelectedValue + " and Subjectid=" + ddlsubject.SelectedValue + "";
        if (string.IsNullOrWhiteSpace(Convert.ToString(objDut.GetScalar(str))))
            IsGrade = false;
        else
            IsGrade = Convert.ToBoolean(objDut.GetScalar(str));
        return IsGrade;
    }
    private DataSet updateSubjecMarks(DataSet dtStd, int mode)
    {
        int ColsCount = dtStd.Tables[0].Columns.Count;
        int RowsCount = dtStd.Tables[0].Rows.Count;
        for (int i = 0; i < RowsCount; i++)
        {
            for (int j = 4; j < ColsCount; j++)
            {
                var StuRegNo = Convert.ToString(dtStd.Tables[0].Rows[i]["RegNo"]);
                if(StuRegNo== "512")
                {
                    var d = "";
                }
                if (!string.IsNullOrWhiteSpace(StuRegNo))
                {
                    int IsAbsent1 = 0;
                    var SubjectName = dtStd.Tables[0].Columns[j].ColumnName.ToString().Trim();
                    string SubjecTId = "";
                    bool IsGrade = false;
                    if (!string.IsNullOrWhiteSpace(SubjectName))
                    {
                        string StrStr = " where Subject_Master.fyid=" + fyid + " and SEM.branchid=" + Convert.ToInt64(Session["BrBrid"]) + " and SEM.classid=" + ddlcourse.SelectedValue + " and SEM.Status=1";
                        DataUtility objDut = new DataUtility();
                        string strSubject = " Select DISTINCT Subject_Master.id,Cast((Case When(IsNull(IsGrade,0))=1 Then 'True' else 'False' end) As bit) as IsGrade from SubjectBranch_master SEM " +
                                            " inner join Subject_Master on Subject_Master.id = SEM.subjectid " + StrStr + " and " +
                                            " Subject_Master.SubjectName ='" + SubjectName + "' and " +
                                            "Subject_Master.SubjectName NOT IN('Health & Physical Education','Work Education','Discipline','Art Education')";
                        DataTable dtSubjectId = objDut.GetDataTable(strSubject);
                        if (dtSubjectId.Rows.Count > 0)
                        {
                            SubjecTId = Convert.ToString(dtSubjectId.Rows[0]["id"]);
                            IsGrade = Convert.ToBoolean(dtSubjectId.Rows[0]["IsGrade"]);
                            if (!string.IsNullOrWhiteSpace(SubjecTId))
                            {
                                var termId = ddlTerm.SelectedValue;
                                var ClassId = ddlcourse.SelectedValue;
                                var sectionId = ddlsection.SelectedValue;
                                var examId = ddlExam.SelectedValue;
                                var StuReg = dtStd.Tables[0].Rows[i]["RegNo"];
                                if (mode == 1)
                                {
                                    var mark = "";

                                    mark = getMarksFromDb(examId.ToString(), StuReg.ToString().Trim(), true, IsGrade, SubjecTId.ToString().Trim());

                                    if (dtStd.Tables[0].Columns.Contains(SubjectName))
                                    {
                                        dtStd.Tables[0].Rows[i][SubjectName] = mark.ToString().Trim();
                                        dtStd.AcceptChanges();
                                    }
                                }
                                if (mode == 2)
                                {
                                    var value = "";
                                    decimal decmarks2 = 0;
                                    var oldMark = Convert.ToString(dtStd.Tables[0].Rows[i][SubjectName]);

                                    IsAbsent1 = IsAbsent(oldMark);

                                    value = getMarks(oldMark, IsAbsent1, IsGrade);

                                    var IsValidMark = false;
                                    if (IsGrade)
                                    {
                                        IsValidMark = true;
                                    }
                                    else
                                    {
                                        decimal Marks5 = 0;
                                        string strMarks5 = objDut.GetScalar("Select ISNULL(maxmarks,0) from exam_name where eid=" + examId + " and fyid =" + fyid + " and brid=" + Convert.ToInt64(Session["BrBrid"]) + " and status=1").ToString();
                                        if (strMarks5.ToString() == "")
                                        {
                                            Marks5 = 0;
                                        }
                                        Marks5 = Convert.ToDecimal(strMarks5);

                                        if (Convert.ToDecimal(value) > Marks5)
                                            IsValidMark = false;
                                        else
                                            IsValidMark = true;
                                    }

                                    //string examname = dt.Columns[6].ToString();
                                    //uploadMarks1(Convert.ToString(dr["STUREGNO"]), Convert.ToString(dr["CLASS"]), Convert.ToString(dr["SECTION"]), Convert.ToString(dr["SUBJECT"]), "UNIT TEST - I", Convert.ToString(decmarks2));
                                    if (IsValidMark)
                                    {
                                        try
                                        {
                                            uploadMarksNew(Convert.ToString(dtStd.Tables[0].Rows[i]["RegNo"]), SubjecTId, ddlExam.SelectedValue, value, IsGrade, IsAbsent1);
                                        }
                                        catch (Exception ex)
                                        {
                                            var values = Convert.ToString(dtStd.Tables[0].Rows[i]["RegNo"]) + "_" + SubjecTId + "_" + ddlExam.SelectedValue + "_" + value + "_" + IsGrade + "_" + IsAbsent1;
                                            var error = ex.Message;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return dtStd;
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
    protected void cserc_TextChanged(object sender, EventArgs e)
    {
        if (cserc.SelectedValue == "1")
        {
            FillGrid(Convert.ToInt32(ddlcourse.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue), 0,1);
        }
        else if (cserc.SelectedValue == "2")
        {
            FillGrid(Convert.ToInt32(ddlcourse.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue), 0,2);
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        int mode = 0;
        int.TryParse(cserc.SelectedValue, out mode);
        int subid = 0;
        int.TryParse(ddlsubject.SelectedValue, out subid);
        this.FillGrid(Convert.ToInt32(ddlcourse.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue), subid, mode);
        if (dtSubjectMark.Rows.Count > 0)
        {
            string FileName = ddlTerm.SelectedItem.Text + "_" + ddlcourse.SelectedItem.Text + "_" + ddlsection.SelectedItem.Text + "_Shl_" + ddlsubject.SelectedItem.Text + "_" + DateTime.Today.ToString("dd_MMM_yy");
            string filepath = "";
            if(!Directory.Exists(Server.MapPath("~/Uploads")))
            {
                Directory.CreateDirectory(Server.MapPath("~/Uploads"));
            }
            filepath = Server.MapPath("~/Uploads/") + FileName + ".pdf";
            if(File.Exists(filepath))
            {
                File.Delete(filepath);
            }
            CreatePdf(filepath, dtSubjectMark, " ");
            Response.ContentType = "Application/pdf";
            Response.AppendHeader("Content-Disposition", "attachment; filename=list.pdf");
            Response.TransmitFile(filepath);
            Response.End();
        }
        else
        {
            Utility.ViewAlertMessage(Page, "No Records Found");
        }
    }

    public class ITextEvents : PdfPageEventHelper
    {
        // This is the contentbyte object of the writer
        PdfContentByte cb;

        // we will put the final number of pages in a template
        PdfTemplate headerTemplate, footerTemplate;

        // this is the BaseFont we are going to use for the header / footer
        BaseFont bf = null;

        // This keeps track of the creation time
        DateTime PrintTime = DateTime.Now;

        #region Fields
        private string _header;
        #endregion

        #region Properties
        public string Header
        {
            get { return _header; }
            set { _header = value; }
        }
        #endregion

        public override void OnOpenDocument(PdfWriter writer, Document document)
        {
            try
            {
                PrintTime = DateTime.Now;
                bf = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                cb = writer.DirectContent;
                headerTemplate = cb.CreateTemplate(65, 65);
                footerTemplate = cb.CreateTemplate(50, 50);
            }
            catch (DocumentException de)
            {
            }
            catch (System.IO.IOException ioe)
            {
            }
        }

        public override void OnEndPage(iTextSharp.text.pdf.PdfWriter writer, iTextSharp.text.Document document)
        {
            base.OnEndPage(writer, document);
            iTextSharp.text.Font baseFontNormal = new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 12f, iTextSharp.text.Font.NORMAL, iTextSharp.text.BaseColor.BLACK);
            iTextSharp.text.Font baseFontSmall = new iTextSharp.text.Font(iTextSharp.text.Font.FontFamily.HELVETICA, 10f, iTextSharp.text.Font.NORMAL, iTextSharp.text.BaseColor.BLACK);
            DataUtility objdut = new DataUtility();
            string branchdata = Convert.ToString(objdut.GetScalar(@"select BrAddress+'^'+City+', '+state+', '+Country+', '+pincode+'^'+
            LandLineNo+','+MobileNo+'^'+Emailid+'^'+isnull(Website,'')+'^'+isnull(SchoolAffi,'')+'^'+isnull(BrName,'')+'^'+isnull(photo,'') from branch_master where brid = " + System.Web.HttpContext.Current.Session["brbrid"] + ""));

            string title = "";
           string ImageUrl="~/BranchPanel/images/9update.png";
           string addr1 = "";
           string addr2 = "";
            if (branchdata != "")
            {
                string[] getbranchdata = branchdata.Split('^');
                title = getbranchdata[6].ToString();
                addr1 = getbranchdata[0];
                addr2 = getbranchdata[1];

                //string[] getCont;
                //Contact = getbranchdata[2];
                //getCont = Contact.Split(',');
                //Ph = getCont[0].ToString();
                //mobile = getCont[1].ToString();
                //EmailID = getbranchdata[3].ToString();
                //Website = getbranchdata[4].ToString();
                //SchoolAffi = getbranchdata[5].ToString();
                //SpScool.InnerText = getbranchdata[6].ToString();
                //SAddress.InnerText = address;

                //SpFone.InnerText = Ph.ToString();
                //SMobile.InnerText = mobile.ToString();
                //SEmailID.InnerText = EmailID.ToString();

                //if (SchoolAffi != "")
                //{
                //    SchoolAffia.InnerText = SchoolAffi.Trim();
                //    affhead.InnerText = "Affiliation No:";

                //}
                //else
                //{
                //    affhead.InnerText = ".";
                //}
                //SWebsite.InnerText = Website.Trim();
                if (getbranchdata[7].ToString() != "")
                {
                    ImageUrl = System.Web.HttpContext.Current.Server.MapPath("~/BranchPanel/images/") + getbranchdata[7].ToString();
                }
                else
                {
                    ImageUrl = System.Web.HttpContext.Current.Server.MapPath("~/BranchPanel/images/")+"9update.png";
                }
            }
            Phrase p1Header = new Phrase(title, baseFontNormal);

            //Create PdfTable object
            PdfPTable pdfTab = new PdfPTable(3);

            //We will have to create separate cells to include image logo and 2 separate strings
            //Row 1

            PdfPCell pdfCell2 = new PdfPCell(p1Header);
            Phrase p2Header = new Phrase(Convert.ToString(addr1), baseFontSmall);         

            PdfPCell pdfCell3 = new PdfPCell(p2Header);
            Phrase p3Header = new Phrase(Convert.ToString(addr2), baseFontSmall);

            PdfPCell pdfCell4 = new PdfPCell(p3Header);
            pdfCell2.Colspan = 3;
            pdfCell3.Colspan = 3;
            pdfCell4.Colspan = 3;
            String text = "Page " + writer.PageNumber + " of ";

            //Add paging to header
            //{
            //    cb.BeginText();
            //    cb.SetFontAndSize(bf, 12);
            //    cb.SetTextMatrix(document.PageSize.GetRight(200), document.PageSize.GetTop(45));
            //    cb.ShowText(text);
            //    cb.EndText();
            //    float len = bf.GetWidthPoint(text, 12);
            //    //Adds "12" in Page 1 of 12
            //    cb.AddTemplate(headerTemplate, document.PageSize.GetRight(200) + len, document.PageSize.GetTop(45));
            //}
            //Add paging to footer
            {
                cb.BeginText();
                cb.SetFontAndSize(bf, 12);
                cb.SetTextMatrix(document.PageSize.GetRight(180), document.PageSize.GetBottom(30));
                cb.ShowText(text);
                cb.EndText();
                float len = bf.GetWidthPoint(text, 12);
                cb.AddTemplate(footerTemplate, document.PageSize.GetRight(180) + len, document.PageSize.GetBottom(30));
            }

            //Row 2
            iTextSharp.text.Image img = iTextSharp.text.Image.GetInstance(ImageUrl);
            img.ScaleAbsolute(30f, 30f);
            //Row 3 
            //PdfPCell pdfCell5 = new PdfPCell(new Phrase("Date:" + PrintTime.ToShortDateString(), baseFontSmall));
            PdfPCell pdfCell6 = new PdfPCell(img);
            pdfCell6.Colspan = 1;

            PdfPCell pdfCell8 = new PdfPCell(new Phrase("Class.....................,Section...................."));
            pdfCell8.Colspan = 1;
            PdfPCell pdfCell7 = new PdfPCell(new Phrase("Date:" + PrintTime.ToString("dd-MM-yyyy") + ",TIME:" + string.Format("{0:t}", DateTime.Now), baseFontSmall));

            //set the alignment of all three cells and set border to 0

            pdfCell2.HorizontalAlignment = Element.ALIGN_CENTER;
            pdfCell3.HorizontalAlignment = Element.ALIGN_CENTER;
            pdfCell4.HorizontalAlignment = Element.ALIGN_CENTER;

            // pdfCell5.HorizontalAlignment = Element.ALIGN_LEFT;
            pdfCell6.HorizontalAlignment = Element.ALIGN_LEFT;
            pdfCell7.HorizontalAlignment = Element.ALIGN_RIGHT;
            pdfCell8.HorizontalAlignment = Element.ALIGN_CENTER;
            pdfCell8.Border = 0;
            pdfCell2.VerticalAlignment = Element.ALIGN_BOTTOM;

            // pdfCell5.VerticalAlignment = Element.ALIGN_MIDDLE;
            pdfCell6.VerticalAlignment = Element.ALIGN_MIDDLE;
            pdfCell7.VerticalAlignment = Element.ALIGN_MIDDLE;

            pdfCell2.Border = 0;
            pdfCell3.Border = 0;
            pdfCell4.Border = 0;

            // pdfCell5.Border = 0;
            pdfCell6.Border = 0;
            pdfCell7.Border = 0;

            //add all three cells into PdfTable

            pdfTab.AddCell(pdfCell2);
            pdfTab.AddCell(pdfCell3);
            pdfTab.AddCell(pdfCell4);

            //  pdfTab.AddCell(pdfCell5);
            pdfTab.AddCell(pdfCell6);
            pdfTab.AddCell(pdfCell8);
            pdfTab.AddCell(pdfCell7);

            pdfTab.TotalWidth = document.PageSize.Width - 80f;
            pdfTab.WidthPercentage = 70;
            //pdfTab.HorizontalAlignment = Element.ALIGN_CENTER;    

            //call WriteSelectedRows of PdfTable. This writes rows from PdfWriter in PdfTable
            //first param is start row. -1 indicates there is no end row and all the rows to be included to write
            //Third and fourth param is x and y position to start writing
            pdfTab.WriteSelectedRows(0, -1, 40, document.PageSize.Height - 30, writer.DirectContent);
            //set pdfContent value

            //Move the pointer and draw line to separate header section from rest of page
            cb.MoveTo(40, document.PageSize.Height - 106);
            cb.LineTo(document.PageSize.Width - 30, document.PageSize.Height - 106);
            cb.Stroke();

            //Move the pointer and draw line to separate footer section from rest of page
            cb.MoveTo(40, document.PageSize.GetBottom(50));
            cb.LineTo(document.PageSize.Width - 30, document.PageSize.GetBottom(50));
            cb.Stroke();
        }

        public override void OnCloseDocument(PdfWriter writer, Document document)
        {
            base.OnCloseDocument(writer, document);

            //headerTemplate.BeginText();
            //headerTemplate.SetFontAndSize(bf, 12);
            //headerTemplate.SetTextMatrix(0, 0);
            //headerTemplate.ShowText((writer.PageNumber - 1).ToString());
            //headerTemplate.EndText();

            footerTemplate.BeginText();
            footerTemplate.SetFontAndSize(bf, 12);
            footerTemplate.SetTextMatrix(0, 0);
            footerTemplate.ShowText((writer.PageNumber).ToString());
            footerTemplate.EndText();
        }
    }
    public static string _title = "";
    public void CreatePdf(string pdfPath, DataTable dt, string title)
    {
        _title = title;
        Document doc = new Document(PageSize.A4.Rotate(), 0, 0, 107, 50);
        //doc.SetPageSize(PageSize.A4.Rotate());
        PdfWriter pdfWriter = PdfWriter.GetInstance(doc, new FileStream(pdfPath, FileMode.Create));
        pdfWriter.PageEvent = new ITextEvents();
        doc.Open();
        PdfPTable tableLayout = new PdfPTable(4);


        //tableLayout.AddCell(new PdfPCell(new Phrase(title, new Font(Font.NORMAL, 13, 1, new iTextSharp.text.BaseColor(153, 51, 0)))) { Colspan = 4, Border = 0, PaddingBottom = 20, HorizontalAlignment = Element.ALIGN_CENTER });
        //doc.Add(tableLayout);
        //float[] headers = { 5, 10, 11, 12, 12, 10, 10, 10, 10, 10 };
        PdfPTable tableLayout1 = new PdfPTable(dt.Columns.Count);

        tableLayout1.DefaultCell.Border = Rectangle.NO_BORDER;
        //tableLayout1.SetTotalWidth(headers);
        tableLayout1.WidthPercentage = 95;
        foreach(DataColumn dc in dt.Columns)
        {
            AddLabelCellToBody(tableLayout1, dc.ColumnName);
        }
       
        foreach (DataRow dr in dt.Rows)
        {           
            foreach(DataColumn dc in dt.Columns)
            {
                if (Convert.ToString(dr[dc.ColumnName]).Trim() == "0")
                {
                    AddCellToBody(tableLayout1, "");
                }
                else
                {
                    AddCellToBody(tableLayout1, Convert.ToString(dr[dc.ColumnName]));
                }
            }
        }
        doc.Add(tableLayout1);
        doc.Close();
    }

    private static void AddCellToBody(PdfPTable tableLayout, string cellText)
    {
        PdfPCell cell = new PdfPCell(new Phrase(cellText, new Font(Font.FontFamily.HELVETICA, 8, 1, iTextSharp.text.BaseColor.BLACK))) { HorizontalAlignment = Element.ALIGN_LEFT, Padding = 5, BackgroundColor = iTextSharp.text.BaseColor.WHITE };
        // cell.Border = Rectangle.NO_BORDER;
        tableLayout.AddCell(cell);

    }

    private static void AddCellToBody1(PdfPTable tableLayout, string cellText)
    {
        PdfPCell cell = new PdfPCell(new Phrase(cellText, new Font(Font.FontFamily.HELVETICA, 8, 1, iTextSharp.text.BaseColor.BLACK))) { HorizontalAlignment = Element.ALIGN_LEFT, Padding = 5, BackgroundColor = new BaseColor(204, 204, 255) };
        // cell.Border = Rectangle.NO_BORDER;
        tableLayout.AddCell(cell);

    }

    private static void AddCellToBody2(PdfPTable tableLayout, string cellText)
    {
        PdfPCell cell = new PdfPCell(new Phrase(cellText, new Font(Font.FontFamily.HELVETICA, 8, 1, iTextSharp.text.BaseColor.BLACK))) { HorizontalAlignment = Element.ALIGN_LEFT, Padding = 5, BackgroundColor = new BaseColor(234, 234, 250) };
        // cell.Border = Rectangle.NO_BORDER;
        tableLayout.AddCell(cell);

    }
    private static void AddLabelCellToBody(PdfPTable tableLayout, string cellText)
    {
        Font fontH1 = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.BOLD, BaseColor.BLACK);
        //PdfPCell cell = new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.WHITE))) { HorizontalAlignment = Element.ALIGN_CENTER, Padding = 5, BackgroundColor = new iTextSharp.text.BaseColor(33, 49, 78) };
        PdfPCell cell = new PdfPCell(new Phrase(cellText, fontH1)) { HorizontalAlignment = Element.ALIGN_LEFT, Padding = 5, BackgroundColor = new iTextSharp.text.BaseColor(153, 204, 255) };
        //  cell.Border = Rectangle.NO_BORDER;
        tableLayout.AddCell(cell);

    }

    private static void AddLabelCellToBody1(PdfPTable tableLayout, string cellText)
    {
        // PdfPCell cell = new PdfPCell(new Phrase(cellText, new Font(Font.NORMAL, 8, 1, iTextSharp.text.BaseColor.WHITE))) { HorizontalAlignment = Element.ALIGN_CENTER, Padding = 5, BackgroundColor = new iTextSharp.text.BaseColor(33,49,78) };
        Font fontH1 = new Font(Font.FontFamily.TIMES_ROMAN, 10, Font.BOLD, BaseColor.BLACK);
        PdfPCell cell = new PdfPCell(new Phrase(cellText, fontH1)) { HorizontalAlignment = Element.ALIGN_LEFT, Padding = 5, BackgroundColor = new iTextSharp.text.BaseColor(204, 229, 255) };
        // cell.Border = Rectangle.NO_BORDER;
        tableLayout.AddCell(cell);

    }
    protected void btnUpload_Click(object sender, EventArgs e)
    {
        lblError.Text = "";
        try
        {
            if (FileUpload1.HasFile)
            {
                string filename = FileUpload1.FileName;
                string ext = Path.GetExtension(filename);
                if (!ext.ToUpper().Contains("xlsx".ToUpper()))
                {
                    lblError.Text = "select File in xlsx format!!";
                    return;
                }
                else
                {
                    string path1 = string.Format("{0}/{1}", Server.MapPath("~/Uploads"), FileUpload1.FileName);
                    if (!Directory.Exists(Server.MapPath("~/Uploads")))
                    {
                        Directory.CreateDirectory(Server.MapPath("~/Uploads"));
                    }
                    if (File.Exists(path1))
                    {
                        File.Delete(path1);
                    }
                    FileUpload1.SaveAs(path1);
                    string connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path1 + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                    DataTable dt = ConvertXSLXtoDataTable(path1, connString);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        foreach (DataRow dr in dt.Rows)
                        {
							decimal decmarks2 = 0, decmarks3 = 0, decmarks4 = 0, decmarks5 = 0;
							decimal.TryParse(Convert.ToString(dr["PER TEST (10) I"]), out decmarks2);
							decimal.TryParse(Convert.ToString(dr["NOTE BOOK (5) I"]), out decmarks3);
							decimal.TryParse(Convert.ToString(dr["SUB ENRICHMENT (5) I"]), out decmarks4);
							decimal.TryParse(Convert.ToString(dr["HALF YEARLY EXAM (80) I"]), out decmarks5);
                            //decmarks2 = Math.Abs(decmarks2 / 5);
                            decmarks2 = Math.Abs(decmarks2 / 1);
							decmarks3 = Math.Abs(decmarks3 / 1);
							decmarks4 = Math.Abs(decmarks4 / 1);
							decmarks5 = Math.Abs(decmarks5 / 1);
                            uploadMarks(Convert.ToString(dr["STUREGNO"]), Convert.ToString(dr["Class"]), Convert.ToString(dr["Section"]), Convert.ToString(dr["Subject"]), "PER TEST (10) I", Convert.ToString(decmarks2));
                            uploadMarks(Convert.ToString(dr["STUREGNO"]), Convert.ToString(dr["Class"]), Convert.ToString(dr["Section"]), Convert.ToString(dr["Subject"]), "NOTE BOOK (5) I", Convert.ToString(decmarks3));
                            uploadMarks(Convert.ToString(dr["STUREGNO"]), Convert.ToString(dr["Class"]), Convert.ToString(dr["Section"]), Convert.ToString(dr["Subject"]), "SUB ENRICHMENT (5) I", Convert.ToString(decmarks4));
                            uploadMarks(Convert.ToString(dr["STUREGNO"]), Convert.ToString(dr["Class"]), Convert.ToString(dr["Section"]), Convert.ToString(dr["Subject"]), "HALF YEARLY(80)I", Convert.ToString(decmarks5));
                        }
                        lblmessage.Text = "uploaded";
                    }
                }
            }
            else
            {
                lblError.Text = "select excel file";
            }
        }
        catch(Exception ex)
        {
            lblError.Text = ex.Message;
        }
        
    }
    protected void btnUpload1_Click(object sender, EventArgs e)
    {
        lblError2.Text = "";
        lblError.Text = "";
        lblmessage.Text = "";
        lblmessage2.Text = "";
        try
        {
            if (FileUpload2.HasFile)
            {
                string filename = FileUpload2.FileName;
                string ext = Path.GetExtension(filename);
                if (!ext.ToUpper().Contains("xlsx".ToUpper()))
                {
                    lblError2.Text = "select File in xlsx format!!";
                    return;
                }
                else
                {
                    string path1 = string.Format("{0}/{1}", Server.MapPath("~/Uploads"), FileUpload2.FileName);
                    if (!Directory.Exists(Server.MapPath("~/Uploads")))
                    {
                        Directory.CreateDirectory(Server.MapPath("~/Uploads"));
                    }
                    if (File.Exists(path1))
                    {
                        File.Delete(path1);
                    }
                    FileUpload2.SaveAs(path1);
                    string connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path1 + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                    DataTable dt = ConvertXSLXtoDataTable(path1, connString);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        for (int i=0;i<dt.Columns.Count;i++) {
                            var col = dt.Columns[i].ColumnName;
                            if (col.Contains("#")) {
                                dt.Columns[i].ColumnName = col.Replace("#", ".");
                            }
                        }

                        DataSet ds = new DataSet();

                        var dtCopy = dt.Copy();
                        ds.Tables.Add(dtCopy);

                        var dsDt = updateSubjecMarks(ds,2);
                        //foreach (DataRow dr in dt.Rows)
                        //{
                        //    decimal decmarks2 = 0;
                        //    decimal.TryParse(Convert.ToString(dr["MARKS"]), out decmarks2);
                        //    //string examname = dt.Columns[6].ToString();
                        //    //uploadMarks1(Convert.ToString(dr["STUREGNO"]), Convert.ToString(dr["CLASS"]), Convert.ToString(dr["SECTION"]), Convert.ToString(dr["SUBJECT"]), "UNIT TEST - I", Convert.ToString(decmarks2));
                        //    uploadMarksNew(Convert.ToString(dr["STUREGNO"]), Convert.ToString(dr["CLASS"]), Convert.ToString(dr["SECTION"]), Convert.ToString(dr["SUBJECT"]), ddlExam.SelectedValue, Convert.ToString(decmarks2));
                        //}
                        lblmessage2.Text = "uploaded";
                    }
                }
            }
            else
            {
                lblError2.Text = "select excel file";
            }
        }
        catch (Exception ex)
        {
            lblError2.Text = ex.Message;
        }

    }

    public int uploadMarksNew(string regNo, string subjectId, string examId, string marks,bool isGrade,int IsAbsent)
    {
        int result = 0;
        SqlParameter[] param = new SqlParameter[15];

        param[0] = new SqlParameter("@examName", SqlDbType.VarChar);
        param[0].Value = "";

        param[1] = new SqlParameter("@classid", SqlDbType.VarChar);
        param[1].Value = ddlcourse.SelectedValue;

        param[2] = new SqlParameter("@subjectId", SqlDbType.VarChar);
        param[2].Value = subjectId;

        param[3] = new SqlParameter("@secionid", SqlDbType.VarChar);
        param[3].Value = ddlsection.SelectedValue;

        param[4] = new SqlParameter("@sturegno", SqlDbType.BigInt);
        param[4].Value = Convert.ToInt32(regNo);

        param[5] = new SqlParameter("@marks", SqlDbType.Float);
        float fmarks = 0;
        float.TryParse(marks, out fmarks);
        param[5].Value = fmarks;

        param[6] = new SqlParameter("@fyid", SqlDbType.BigInt);
        param[6].Value = fyid;

        param[7] = new SqlParameter("@brid", SqlDbType.BigInt);
        param[7].Value = Convert.ToInt64(Session["BrBrid"]);

        param[8] = new SqlParameter("@status", SqlDbType.Int);
        param[8].Value = 1;

        param[9] = new SqlParameter("@intResult", SqlDbType.Int);
        param[9].Direction = ParameterDirection.Output;

        param[10] = new SqlParameter("@mode", SqlDbType.BigInt);
        param[10].Value = Convert.ToInt32(1);

        param[11] = new SqlParameter("@examid", SqlDbType.VarChar);
        param[11].Value = examId;

        param[12] = new SqlParameter("@isGrade", SqlDbType.VarChar);
        param[12].Value = isGrade == true ? 1 : 0;

        param[13] = new SqlParameter("@grade", SqlDbType.VarChar);
        param[13].Value = marks;

        param[14] = new SqlParameter("@IsAbsent", SqlDbType.Int);
        param[14].Value = IsAbsent;

        result = objDut.ExecuteSqlSP(param, "Usp_Upload_Stud_marks");
        return result;
    }

    public int uploadMarks(string regNo, string className, string section, string subject, string examName, string marks)
    {
        int result = 0;
        SqlParameter[] param = new SqlParameter[11];

        param[0] = new SqlParameter("@examName", SqlDbType.VarChar);
        param[0].Value = examName;

        param[1] = new SqlParameter("@className", SqlDbType.VarChar);
        param[1].Value = className;

        param[2] = new SqlParameter("@subjectName", SqlDbType.VarChar);
        param[2].Value = subject;

        param[3] = new SqlParameter("@secionName", SqlDbType.VarChar);
        param[3].Value = section;

        param[4] = new SqlParameter("@sturegno", SqlDbType.BigInt);
        param[4].Value = Convert.ToInt32(regNo);

        param[5] = new SqlParameter("@marks", SqlDbType.Float);
        float fmarks = 0;
        float.TryParse(marks, out fmarks);
        param[5].Value = Convert.ToInt32(fmarks);


        param[6] = new SqlParameter("@fyid", SqlDbType.BigInt);
        param[6].Value = fyid;

        param[7] = new SqlParameter("@brid", SqlDbType.BigInt);
        param[7].Value = Convert.ToInt64(Session["BrBrid"]);

        param[8] = new SqlParameter("@status", SqlDbType.Int);
        param[8].Value = 1;

        param[9] = new SqlParameter("@intResult", SqlDbType.Int);
        param[9].Direction = ParameterDirection.Output;

        param[10] = new SqlParameter("@mode", SqlDbType.BigInt);
        param[10].Value = Convert.ToInt32(1);

        result = objDut.ExecuteSqlSP(param, "Usp_Upload_Stud_marks");
        return result;
    }

    public int uploadMarks1(string regNo, string className, string section, string subject, string examName, string marks)
    {
        int result = 0;
        SqlParameter[] param = new SqlParameter[11];

        param[0] = new SqlParameter("@examName", SqlDbType.VarChar);
        param[0].Value = examName;

        param[1] = new SqlParameter("@className", SqlDbType.VarChar);
        param[1].Value = className;

        param[2] = new SqlParameter("@subjectName", SqlDbType.VarChar);
        param[2].Value = subject;

        param[3] = new SqlParameter("@secionName", SqlDbType.VarChar);
        param[3].Value = section;

        param[4] = new SqlParameter("@sturegno", SqlDbType.BigInt);
        param[4].Value = Convert.ToInt32(regNo);

        param[5] = new SqlParameter("@marks", SqlDbType.Float);
        float fmarks = 0;
        float.TryParse(marks, out fmarks);
        param[5].Value = fmarks;


        param[6] = new SqlParameter("@fyid", SqlDbType.BigInt);
        param[6].Value = fyid;

        param[7] = new SqlParameter("@brid", SqlDbType.BigInt);
        param[7].Value = Convert.ToInt64(Session["BrBrid"]);

        param[8] = new SqlParameter("@status", SqlDbType.Int);
        param[8].Value = 1;

        param[9] = new SqlParameter("@intResult", SqlDbType.Int);
        param[9].Direction = ParameterDirection.Output;

        param[10] = new SqlParameter("@mode", SqlDbType.BigInt);
        param[10].Value = Convert.ToInt32(1);

        result = objDut.ExecuteSqlSP(param, "Usp_Upload_Stud_marks");
        return result;
    }
    public static DataTable ConvertXSLXtoDataTable(string strFilePath, string connString)
    {
        OleDbConnection oledbConn = new OleDbConnection(connString);

        DataTable dt = new DataTable();

        try
        {
            oledbConn.Open();
            DataTable dtSchema = oledbConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });
            string filename = Path.GetFileNameWithoutExtension(strFilePath);
            if (dtSchema.Rows.Count > 0)
            {


                for (int i = 0; i < dtSchema.Rows.Count; i++)
                {
                    if (Convert.ToString(dtSchema.Rows[i]["TABLE_NAME"]).ToUpper().Contains("SHEET1"))
                    {
                        filename = "Sheet1";
                        break;
                    }
                }
            }
            else
            {
                filename = "Sheet1";
            }
            using (OleDbCommand cmd = new OleDbCommand("SELECT * FROM [" + filename + "$]", oledbConn))
            {
                OleDbDataAdapter oleda = new OleDbDataAdapter();
                oleda.SelectCommand = cmd;
                DataSet ds = new DataSet();
                oleda.Fill(ds);

                dt = ds.Tables[0];
            }
        }
        catch (Exception ex)
        {
 throw ex;
        }
        finally
        {

            oledbConn.Close();
        }

        return dt;

    }

    protected void ddlUpdateOption_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblError2.Text = "";
        lblError.Text = "";
        lblmessage.Text = "";
        lblmessage2.Text = "";
        HideGrid();
        if (ddlUpdateOption.SelectedIndex > 0)
        {
            for_sigle_row_Download.Visible = true;
            if (ddlUpdateOption.SelectedValue == "1")
            {
                divSubject.Visible = true;
                Div2.Visible = false;                               
                GetSubject();
                btnDwonload.Visible = false;
                Button1.Visible = true;
                rbnUpdateOption.Visible = false;
                divExam.Visible = false;
                divSubject.Visible = true;
            }
            else
            {
                divSubject.Visible = false;
                divExam.Visible = true; 
                rbnUpdateOption.Visible = true;
                Button1.Visible = false;
                btnDwonload.Visible = true;
                btncancel.Visible = false;
                Div2.Visible = true;
                divSubject.Visible = false;
                divforsetmarks2.Visible = false;
                divGrid.Visible = false;


                DataTable dtExam = objDut.GetDataTable(@"Select distinct examid,examName from exam_class " +
                                                        "Inner  join exam_name on eid = examid "+
                                                        " where classid = " + ddlcourse.SelectedValue + " and exam_class.brid=" + Convert.ToInt64(Session["BrBrid"]) + " and exam_class.status=1");
                if (dtExam.Rows.Count > 0)
                {
                    ddlExam.DataSource = dtExam;
                    ddlExam.DataValueField = "examid";
                    ddlExam.DataTextField = "examName";
                    ddlExam.DataBind();
                    System.Web.UI.WebControls.ListItem listsection = new System.Web.UI.WebControls.ListItem("Select Exam", "0");
                    ddlExam.Items.Insert(0, listsection);
                    ddlExam.Enabled = true;
                    ddlExam.SelectedIndex = 1;
                }
            }
        }
        else
        {
            divSubject.Visible = false;
            Div2.Visible = false;
            for_sigle_row_Download.Visible = false;
            divforsetmarks2.Visible = false;
            divGrid.Visible = false;
        }
    }
    public DataTable GetSubjectList() {
        string StrStr = " where Subject_Master.fyid=" + fyid + " and SEM.branchid=" + Convert.ToInt64(Session["BrBrid"]) + " and SEM.classid=" + ddlcourse.SelectedValue + " and SEM.Status=1";
        DataUtility objDut = new DataUtility();
        string strSubject = " Select DISTINCT Subject_Master.id,Subject_Master.SubjectName from SubjectBranch_master SEM " +
                            " inner join Subject_Master on Subject_Master.id = SEM.subjectid " + StrStr + " and Subject_Master.SubjectName NOT IN('Health & Physical Education','Work Education','Discipline','Art Education')";
        DataTable dtSubject = objDut.GetDataTable(strSubject);
        return dtSubject;
    }
    public void GetSubject() {
        if (ddlsection.SelectedIndex > 0)
        {
            divUpdateOption.Visible = true;
            DataTable dtSubject = GetSubjectList();
            if (dtSubject.Rows.Count > 0)
            {
                //Bind_student_marks(Convert.ToInt32(ddlexam.SelectedValue), Convert.ToInt32(ddlcourse.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue));
                ddlsubject.DataSource = dtSubject;
                ddlsubject.DataValueField = "id";
                ddlsubject.DataTextField = "SubjectName";
                ddlsubject.DataBind();
                System.Web.UI.WebControls.ListItem listsection = new System.Web.UI.WebControls.ListItem("Select Subject", "0");
                ddlsubject.Items.Insert(0, listsection);
                ddlsubject.Enabled = true;
                ddlsubject.SelectedIndex = 0;
                //for_sigle_row_Download.Visible = true;
                cserc.Visible = true;
            }
            else
            {
                ddlsection.Enabled = true;
                ddlsubject.Enabled = true;
                ddlsection.SelectedIndex = 0;
                ddlsubject.SelectedIndex = 0;
                //for_sigle_row_Download.Visible = false;
                cserc.Visible = false;
                Utility.ViewAlertMessage(Page, "Please Config Subject to Class");
            }
        }
    }
}