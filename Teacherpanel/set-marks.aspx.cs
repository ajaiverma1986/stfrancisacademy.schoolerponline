@@@@@@@using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Teacherpanel_set_marks : System.Web.UI.Page
{
    private DataUtility objDut = new DataUtility();
    private DataTable Dt;
    private string Query = "";
    private int fyid = 0;
    private int brid = 0;
    DataTable dtSubjectMarks;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["eid"] == null)
            {
                Response.Redirect("~/Teacher-Login.aspx");
            }
            if (Convert.ToInt64(Session["BrBrid"]) != 0 && Session["BrBrid"] != null)
            {
                brid = Convert.ToInt32(Session["BrBrid"]);
            }

            fyid = CommonClass.Scaler("ActiveAcademicYear");

            if (!IsPostBack)
            {
                //CreateRepeater();
                FillAllDropDownList(0, 0, 0);
                fill_Dropdown_Result(0);

                if (Request.QueryString.Count == 1)
                {
                    int eid = Convert.ToInt32(Request.QueryString[0]);
                    int EmpId = 0;
                    int.TryParse(Convert.ToString(Session["eid"]), out EmpId);
                    string maxmarks = objDut.GetScalar("select maxmarks from exam_name where eid=" + eid + "").ToString();
                    hfmaxmarks.Value = maxmarks;

                    ddlexam.SelectedValue = Convert.ToString(eid);
                    ddlcourse.Enabled = true;
                    SqlParameter[] param = new SqlParameter[3];
                    param[0] = new SqlParameter("@mode", 8);
                    param[1] = new SqlParameter("@empid", EmpId);
                    param[2] = new SqlParameter("@examID", eid);
                    //  param[1] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
                    Dt = objDut.GetDataTableSP(param, "Usp_Class");
                    ddlcourse.DataSource = Dt;
                    ddlcourse.DataTextField = "classname";
                    ddlcourse.DataValueField = "classid";
                    ddlcourse.DataBind();
                    ListItem licourse = new ListItem("Select Class", "0");
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
    [WebMethod]
    public static int SaveOrUpdateMark(string regNo, int subjectId, string examId, string marks, int classId, int sectionId, int IsAbsent)
    {
        Teacherpanel_set_marks obj = new Teacherpanel_set_marks();
        var IsGradeType = obj.isGrade(classId, subjectId);
        int result = obj.uploadMarksNew(regNo, subjectId.ToString(), examId, marks, IsGradeType, IsAbsent, classId.ToString(), sectionId.ToString());
        return result;
    }

    protected void ddlexam_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlexam.SelectedIndex >=0 )
            {
                int examid = Convert.ToInt32(ddlexam.SelectedValue);
                //int status = Convert.ToInt32(objDut.GetScalar("select distinct status from Exam_marksSetting where eid=" + examid + " and brid=" + Convert.ToInt64(Session["BrBrid"]) + " and status=1"));
                //if (status == 1)
                //{
                //}
                //else
                //{
                //    Utility.ViewAlertMessage(Page, "You can not set marks for selected exam");
                //    divfortotal.Style.Add("display", "none");
                //    divforsetmarks.Style.Add("display", "block");
                //    divforclassname.Style.Add("display", "none");
                //    divforexamname.Style.Add("display", "none");
                //    divforsetmarks2.Style.Add("display", "none");
                //    ddlcourse.Enabled = false;
                //    ddlsection.Enabled = false;
                //    ddlsubject.Enabled = false;
                //    ddlcourse.SelectedIndex = 0;
                //    ddlsection.SelectedIndex = 0;
                //    ddlsubject.SelectedIndex = 0;
                //    return;
                //}

                FillAllDropDownList(Convert.ToInt32(ddlexam.SelectedValue), 0, 0);
                ddlcourse.Enabled = true;
                string maxmarks = objDut.GetScalar("select maxmarks from exam_name where eid=" + Convert.ToInt32(ddlexam.SelectedValue) + "").ToString();
                hfmaxmarks.Value = maxmarks;
                divfortotal.Style.Add("display", "none");
                divforsetmarks.Style.Add("display", "block");
                divforclassname.Style.Add("display", "none");
                divforexamname.Style.Add("display", "none");
            }
            else
            {
                ddlcourse.Enabled = false;
                ddlsection.Enabled = false;
                ddlsubject.Enabled = false;
            }
            ddlcourse.SelectedIndex = 0;
            ddlsection.SelectedIndex = 0;
            ddlsubject.SelectedIndex = 0;
        }
        catch (Exception ex)
        { }
    }

    protected void ddlcourse_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlcourse.SelectedIndex > 0)
            {
                FillAllDropDownList(0, Convert.ToInt32(ddlcourse.SelectedValue), 0);
                ddlsection.Enabled = true;
                ddlsection.SelectedIndex = 0;
                ddlsubject.SelectedIndex = 0;
            }
            else
            {
                ddlcourse.Enabled = false;
                ddlsection.Enabled = false;
                ddlsubject.Enabled = false;
                ddlcourse.SelectedIndex = 0;
                ddlsection.SelectedIndex = 0;
                ddlsubject.SelectedIndex = 0;
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void ddlsection_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlsection.SelectedIndex > 0)
        {
            //Bind_student_marks(Convert.ToInt32(ddlexam.SelectedValue), Convert.ToInt32(ddlcourse.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue));
            ddlsubject.Enabled = true;
            ddlsubject.SelectedIndex = 0;
        }
        else
        {
            ddlsection.Enabled = false;
            ddlsubject.Enabled = false;
            ddlsection.SelectedIndex = 0;
            ddlsubject.SelectedIndex = 0;
        }
        FillAllDropDownList(Convert.ToInt32(ddlexam.SelectedValue), Convert.ToInt32(ddlcourse.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue));
    }

    protected void ddlsubject_SelectedIndexChanged(object sender, EventArgs e)
    {

        FillGrid(Convert.ToInt32(ddlcourse.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue), Convert.ToInt32(ddlsubject.SelectedValue));
        Bind_student_marks(Convert.ToInt32(ddlexam.SelectedValue), Convert.ToInt32(ddlcourse.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue));

        fill_Dropdown_Result(Convert.ToInt32(ddlexam.SelectedValue));
        ddlforclassame.SelectedValue = ddlcourse.SelectedValue.ToString();

        //fill_Dropdown_Result(0);
        ddlforexamname.SelectedValue = ddlexam.SelectedValue.ToString();

        divfortotal.Style.Add("display", "block");
        divforsetmarks.Style.Add("display", "block");
        divforclassname.Style.Add("display", "none");
        divforexamname.Style.Add("display", "none");
        divforsetmarks2.Style.Add("display", "block");
    }

    protected void FillAllDropDownList(int examid, int classid, int SectionId)
    {
        try
        {
            int EmpId = 0;
            int.TryParse(Convert.ToString(Session["eid"]), out EmpId);
            // This Is For The Bind Class In Drop Down List
            if (examid > 0)
            {
                Query = " Select Distinct cm.id as classid,cm.Classname from classwithsection cws " +
                         " left outer join Class_Master cm on cws.classid=cm.id " +
                         //" inner join exam_class ec on ec.brid = cws.branchid " +
                         " where cm.status=1  and cm.id in (select tc.classid from [tbl_TeacherToClass] tc where tc.status=1 and tc.empid=" + EmpId + ") and cws.branchid=" + Session["brBrid"] + " and cm.fyid=" + fyid; //+ "" +
                                                                                                                                                                                                                          //" and ec.examid =" + examid;

                Dt = objDut.GetDataTable(Query);
                ddlcourse.DataSource = Dt;
                ddlcourse.DataTextField = "classname";
                ddlcourse.DataValueField = "classid";
                ddlcourse.DataBind();
                ListItem licourse = new ListItem("Select Class", "0");
                ddlcourse.Items.Insert(0, licourse);
            }
            if (classid > 0)
            {
                // This Is For The Bind Section In Drop Down List
                Query = "select Distinct cwsid,sectionname from classwithsection where branchid=" + Session["brBrid"] + " and classid=" + classid + " and cwsid in (select Distinct tc.sectionid from [tbl_TeacherToClass] tc where tc.status=1 and tc.classid=" + classid + " and tc.empid=" + EmpId + ")";
                Dt = objDut.GetDataTable(Query);
                ddlsection.DataSource = Dt;
                ddlsection.DataTextField = "sectionname";
                ddlsection.DataValueField = "cwsid";
                ddlsection.DataBind();
                ListItem listsection = new ListItem("Select Section", "0");
                ddlsection.Items.Insert(0, listsection);
                // This Is For The Bind Subject In Drop Down List

                if (SectionId > 0)
                {
                    Query = @"Select DISTINCT SBM.subjectid,subjectname from SubjectBranch_master SBM
                        INNER JOIN tbl_TeacherToClass TC ON  SBM.BranchId = TC.Brid and SBM.classid = TC.ClassId and SBM.Subjectid = TC.SubjectId
                        where tc.sectionid=" + SectionId + " and tc.Empid =" + Session["eid"] + " and tc.status=1 and TC.Brid=" + Session["brBrid"] + " and tc.classid=" + classid + " and subjectname NOT IN('Health & Physical Education','Work Education','Discipline','Art Education')";
                    Dt = objDut.GetDataTable(Query);
                    ddlsubject.DataSource = Dt;
                    ddlsubject.DataTextField = "subjectname";
                    ddlsubject.DataValueField = "subjectid";
                    ddlsubject.DataBind();
                    ListItem lisubject = new ListItem("Select Subject", "0");
                    ddlsubject.Items.Insert(0, lisubject);
                    ddlsubject.SelectedIndex = 0;
                    ddlcourse.SelectedValue = classid.ToString();
                    ddlsection.SelectedValue = SectionId.ToString();
                    ddlsubject.SelectedIndex = 0;
                }
            }
            //else
            //{
            //    // This Is For The Bind Exam In Drop Down List

            //    Query = @"Select * from exam_name
            //                        inner join exam_class on exam_class.examid = exam_name.eid
            //                        where exam_class.brid=" + Session["brBrid"] + " and exam_class.status=1 order by eid asc";

            //    Dt = objDut.GetDataTable(Query);
            //    ddlexam.DataSource = Dt;
            //    ddlexam.DataTextField = "examname";
            //    ddlexam.DataValueField = "eid";
            //    ddlexam.DataBind();
            //    ListItem liexam = new ListItem("Select Exam", "0");
            //    ddlexam.Items.Insert(0, liexam);
            //}
        }
        catch (Exception ex)
        {
        }
    }

    private void FillGrid(int classid, int sectionid, int SubjectID)
    {
        try
        {
            SqlParameter[] param = new SqlParameter[5];

            param[0] = new SqlParameter("@classid", SqlDbType.Int);
            param[0].Value = classid;

            param[1] = new SqlParameter("@sectionid", SqlDbType.Int);
            param[1].Value = sectionid;

            param[2] = new SqlParameter("@subjectid", SqlDbType.Int);
            param[2].Value = SubjectID;

            param[3] = new SqlParameter("@examid", SqlDbType.Int);
            param[3].Value = Convert.ToInt32(ddlexam.SelectedValue);

            param[4] = new SqlParameter("@mode", SqlDbType.Int);
            param[4].Value = Convert.ToInt32(1);

            if (ddlsubject.SelectedValue != "0")
            {
                DataSet dt = objDut.GetDataSetSP(param, "Usp_getStudent");
                if (dt.Tables[0].Rows.Count > 0)
                {
                    if (dt.Tables[1].Rows.Count > 0)
                    {
                        var isGrading = isGrade(classid, SubjectID);
                        foreach (DataRow dr in dt.Tables[1].Rows)
                        {
                            foreach (DataRow dr1 in dt.Tables[0].Rows)
                            {
                                if (dr1["sturegno"].ToString() == dr["sturegno"].ToString())
                                {
                                    var marks = "";
                                    if (isGrading)
                                    {
                                        marks = Convert.ToString(dr["Grade"]);
                                    }
                                    else
                                    {
                                        marks = getMarks(dr["marks"].ToString(), Convert.ToInt32(dr["IsAbsent"]), isGrading);
                                    }
                                    dr1["marks"] = marks.ToString();
                                    dr1["IsAbsent"] = dr["IsAbsent"].ToString();
                                }
                            }
                        }
                    }
                    
                    DataView dv = dt.Tables[0].DefaultView;
                    dv.Sort = "Name";
                    DataTable sortedDT = dv.ToTable();

                    grdsetmarks.DataSource = dt.Tables[0];
                    grdsetmarks.DataBind();
                    btnsubmit.Style.Add("display", "block");
                    divforstudentheading.Style.Add("display", "block");
                }
                else
                {
                    grdsetmarks.EmptyDataText = "No Record Found";
                    btnsubmit.Style.Add("display", "none");
                    divforstudentheading.Style.Add("display", "block");
                    grdsetmarks.DataBind();
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
        catch (Exception ex)
        { }
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        #region button submit

        try
        {
            var examId = ddlexam.SelectedValue;
            var IsGradeType = isGrade(Convert.ToInt32(ddlcourse.SelectedValue), Convert.ToInt32(ddlsubject.SelectedValue));
            if (validate(IsGradeType))
            {
                foreach (GridViewRow row in grdsetmarks.Rows)
                {
                    int IsAbsent = 0;
                    string marks = "";
                    Label lblregno = (Label)row.FindControl("lblregno");
                    TextBox txtmarks = (TextBox)row.FindControl("txtmarks");
                    CheckBox chkstatus = (CheckBox)row.FindControl("chkstatus");

                    SqlParameter[] param = new SqlParameter[11];
                    if (chkstatus.Checked)
                    {
                        IsAbsent = 1;// IsAbsentStudent(txtmarks.Text.ToString());
                    }
                    marks = getMarks(txtmarks.Text.ToString(), IsAbsent, IsGradeType);

                    var result = uploadMarksNew(lblregno.Text, ddlsubject.SelectedValue, ddlexam.SelectedValue, marks.ToString(), IsGradeType, IsAbsent, ddlcourse.SelectedValue, ddlsection.SelectedValue);



                    //param[0] = new SqlParameter("@examid", SqlDbType.BigInt);
                    //param[0].Value = ddlexam.SelectedValue;

                    //param[1] = new SqlParameter("@classid", SqlDbType.BigInt);
                    //param[1].Value = ddlcourse.SelectedValue;

                    //param[2] = new SqlParameter("@subjectid", SqlDbType.BigInt);
                    //param[2].Value = ddlsubject.SelectedValue;

                    //param[3] = new SqlParameter("@secionid", SqlDbType.BigInt);
                    //param[3].Value = ddlsection.SelectedValue;

                    //param[4] = new SqlParameter("@sturegno", SqlDbType.BigInt);
                    //param[4].Value = Convert.ToInt32(lblregno.Text);

                    //param[5] = new SqlParameter("@marks", SqlDbType.Char);
                    //if (chkstatus.Checked == true)
                    //{
                    //    param[5].Value = 0.00;
                    //}
                    //else
                    //{
                    //    param[5].Value = Convert.ToInt32(txtmarks.Text);
                    //}

                    //param[6] = new SqlParameter("@fyid", SqlDbType.BigInt);
                    //param[6].Value = fyid;

                    //param[7] = new SqlParameter("@brid", SqlDbType.BigInt);
                    //param[7].Value = Convert.ToInt64(Session["BrBrid"]);

                    //param[8] = new SqlParameter("@status", SqlDbType.Int);
                    ////if status =0 then absent and if status=1 then present
                    //if (chkstatus.Checked == true)
                    //{
                    //    param[8].Value = 0;
                    //}
                    //else
                    //{
                    //    param[8].Value = 1;
                    //}
                    //param[9] = new SqlParameter("@intResult", SqlDbType.Int);
                    //param[9].Direction = ParameterDirection.Output;

                    //param[10] = new SqlParameter("@mode", SqlDbType.BigInt);
                    //param[10].Value = Convert.ToInt32(1);

                    //int result = objDut.ExecuteSqlSP(param, "Usp_Insert_Stud_marks");
                    if (result == 1)
                    {
                        grdsetmarks.EmptyDataText = "<b><span style='font-size:12pt;'>" + ddlsubject.SelectedItem.Text + " marks for " + ddlcourse.SelectedItem.Text + " class have been inserted successfully</span></b>";
                        grdsetmarks.DataBind();
                        divfortotal.Style.Add("display", "block");
                        divforsetmarks.Style.Add("display", "block");
                        divforclassname.Style.Add("display", "none");
                        divforexamname.Style.Add("display", "none");
                        divforsetmarks2.Style.Add("display", "block");
                        btnsubmit.Style.Add("display", "none");
                    }
                    if (result == 2)
                    {
                        grdsetmarks.EmptyDataText = "<b><span style='font-size:12pt;'>" + ddlsubject.SelectedItem.Text + " marks for " + ddlcourse.SelectedItem.Text + " class have already been inserted</span></b>";
                        btnsubmit.Style.Add("display", "none");
                        divforstudentheading.Style.Add("display", "block");
                        divforclassname.Style.Add("display", "none");
                        divforexamname.Style.Add("display", "none");
                        divforsetmarks.Style.Add("display", "block");
                        divfortotal.Style.Add("display", "block");
                        grdsetmarks.DataBind();
                    }
                }
                fill_Dropdown_Result(Convert.ToInt32(ddlexam.SelectedValue));
                ddlforclassame.SelectedValue = ddlcourse.SelectedValue.ToString();

                fill_Dropdown_Result(0);
                ddlforexamname.SelectedValue = ddlexam.SelectedValue.ToString();

                Bind_student_marks(Convert.ToInt32(ddlexam.SelectedValue), Convert.ToInt32(ddlcourse.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue));
                fill_Dropdown_Result(Convert.ToInt32(ddlforexamname.SelectedValue));
            }
            ddlexam.SelectedValue = examId;
        }
        catch (Exception ex)
        {
        }
    
        #endregion button submit
    }

    public int uploadMarksNew(string regNo, string subjectId, string examId, string marks, bool isGrade, int IsAbsent, string classId, string sectionId)
    {
        int result = 0;
        SqlParameter[] param = new SqlParameter[15];

        param[0] = new SqlParameter("@examName", SqlDbType.VarChar);
        param[0].Value = "";

        param[1] = new SqlParameter("@classid", SqlDbType.VarChar);
        param[1].Value = classId;

        param[2] = new SqlParameter("@subjectId", SqlDbType.VarChar);
        param[2].Value = subjectId;

        param[3] = new SqlParameter("@secionid", SqlDbType.VarChar);
        param[3].Value = sectionId;

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
    }

    private int IsAbsentStudent(string marks)
    {
        return Convert.ToString(marks).ToUpper().Contains("AB") ? 1 : 0;
    }
    private bool isGrade(int classId, int subjectId)
    {
        var IsGrade = false;
        string str = @"Select CASE when IsGrade = 1 then 'true' else 'false' end IsGrade from SubjectBranch_master where BranchId=" + Convert.ToInt64(Session["BrBrid"]) + 
            " and classid=" + classId + " and Subjectid=" + subjectId + "";
        if (string.IsNullOrWhiteSpace(Convert.ToString(objDut.GetScalar(str))))
            IsGrade = false;
        else
            IsGrade = Convert.ToBoolean(objDut.GetScalar(str));
        return IsGrade;
    }
    private bool validate(bool IsGrade)
    {
        foreach (GridViewRow row1 in grdsetmarks.Rows)
        {
            TextBox txtmarks = row1.FindControl("txtmarks") as TextBox;
            CheckBox chkstatus1 = row1.FindControl("chkstatus") as CheckBox;
            Label Name = row1.FindControl("lblname") as Label;
            var mark = string.IsNullOrWhiteSpace(txtmarks.Text) ? "0" : txtmarks.Text;
            if (mark != "0")
            {
                ///int IsGrade = Convert.ToInt32(objDut.GetScalar("Select ISNULL(IsGrade,0) from SubjectBranch_master where Subjectid=" + ddlsubject.SelectedValue + " and classid=" + ddlcourse.SelectedValue + " and status=1 and BranchId=" + Convert.ToInt64(Session["BrBrid"]) + ""));
                if (!IsGrade)
                {
                    int maxMarks = Convert.ToInt32(objDut.GetScalar("Select ISNULL(maxmarks,0) from exam_name where eid=" + ddlexam.SelectedValue + ""));
                    if (Convert.ToInt32(mark) > maxMarks)
                    {
                        txtmarks.Text = "0";
                        Utility.ViewAlertMessage(Page, "Max mark can not be grather than Max Mark for Student - " + Name.Text + "");
                        return false;
                    }
                }
            }
        }
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
        StrStr = " where SEM.fyid=" + fyid + " and SEM.brid=" + Convert.ToInt64(Session["BrBrid"]) + " and SEM.examid=" + ddlexam.SelectedValue + "";

        string StrStr1 = "";
        StrStr1 = " where SEM.fyid=" + fyid + " and SEM.brid=" + Convert.ToInt64(Session["BrBrid"]) + "";

        DataUtility objDut = new DataUtility();
        string strSubject = " Select DISTINCT Subject_Master.SubjectName from tbl_marks_master SEM " +
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
        }
    }

    protected void ViewDetails(object sender, EventArgs e)
    {
        LinkButton lnkView = (sender as LinkButton);
        Label lblExamID = (sender as Label);
        GridViewRow row = (lnkView.NamingContainer as GridViewRow);
        int examid = 0;

        if (ddlexam.SelectedIndex > 0)
        {
            examid = Convert.ToInt32(ddlexam.SelectedValue);
        }

        if (lnkView.CommandName == "Show")
        {
            GridViewRow gvRow = lnkView.Parent.NamingContainer as GridViewRow;
            int regno = Convert.ToInt32(lnkView.CommandArgument);

            string strClassID = "";
            int ClassID = 0;

            strClassID = @"Select DISTINCT isnull(SA.ClassID,'0') ClassID from tbl_StudentRegistration SR
				inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.Brid
				inner join tbl_StudentAdmissionMaster SA on SA.StuRegNo = SM.SturegNo
				where SA.StuRegNo=" + regno + " and SR.IsAdmissionTaken=1 and SR.Brid=" + Convert.ToInt32(Session["BrBrid"]) + "";

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
        if (ddlexam.SelectedIndex > 0)
        {
            examid = Convert.ToInt32(ddlexam.SelectedValue);
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
        if (examid > 0)
        {
            Query = " Select Distinct cm.id as classid,cm.Classname from classwithsection cws " +
                          " left outer join Class_Master cm on cws.classid=cm.id " +
                //" inner join exam_class ec on ec.brid = cws.branchid " +
                          " where cm.status=1 and cws.branchid=" + Session["brBrid"] + " and cm.fyid=" + fyid; //+ "" +
            //" and ec.examid =" + examid;
            Dt = objDut.GetDataTable(Query);
            ddlforclassame.DataSource = Dt;
            ddlforclassame.DataTextField = "classname";
            ddlforclassame.DataValueField = "classid";
            ddlforclassame.DataBind();
            ListItem licourse = new ListItem("Select Class", "0");
            ddlforclassame.Items.Insert(0, licourse);
        }
        else
        {
            Query = "select eid,examname from exam_name where status=1 and brid=" + Session["brBrid"] + " order by eid asc";
            Dt = objDut.GetDataTable(Query);
            ddlexam.DataSource = Dt;
            ddlexam.DataTextField = "examname";
            ddlexam.DataValueField = "eid";
            ddlexam.DataBind();
            ListItem liexam = new ListItem("Select Exam", "0");
            ddlexam.Items.Insert(0, liexam);
        }
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
				where SA.StuRegNo=" + regno + " and SR.IsAdmissionTaken=1 and SR.Brid=" + Convert.ToInt32(Session["BrBrid"]) + "";

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
            HiddenField IsAbsent = (HiddenField)e.Row.FindControl("IsAbsent");
            CheckBox chkstatus = (CheckBox)e.Row.FindControl("chkstatus");
            if (IsAbsent.Value == "1")
            {
                chkstatus.Checked = true;
            }

            //HiddenField gradeID = (HiddenField)e.Row.FindControl("gradeID");
            //DropDownList ddlsubGrade = (DropDownList)e.Row.FindControl("ddlsubGrade");
            //if (gradeID.Value != "")
            //{
            //    //int GradeID = Convert.ToInt32(gradeID.Value);
            //    //ddlsubGrade.SelectedValue = GradeID.ToString();
            //}
        }
    }
}