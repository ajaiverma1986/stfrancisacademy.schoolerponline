﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class BranchPanel_Exams_set_marks : System.Web.UI.Page
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
                FillAllDropDownList(0, 0);
                fill_Dropdown_Result(0);

                if (Request.QueryString.Count == 1)
                {
                    int eid = Convert.ToInt32(Request.QueryString[0]);

                    string maxmarks = objDut.GetScalar("select maxmarks from exam_name where eid=" + eid + "").ToString();
                    hfmaxmarks.Value = maxmarks;

                    ddlexam.SelectedValue = Convert.ToString(eid);
                    ddlcourse.Enabled = true;
                    Query = "select classid,classname from exam_class where examid=" + eid + " and status=" + 1 + "";
                    Dt = objDut.GetDataTable(Query);
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

    protected void ddlexam_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlexam.SelectedIndex > 0)
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

                FillAllDropDownList(Convert.ToInt32(ddlexam.SelectedValue), 0);
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
                FillAllDropDownList(0, Convert.ToInt32(ddlcourse.SelectedValue));
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

    protected void FillAllDropDownList(int examid, int classid)
    {
        try
        {
            // This Is For The Bind Class In Drop Down List
            if (examid > 0)
            {
                Query = " Select Distinct cm.id as classid,cm.Classname from classwithsection cws " +
                         " left outer join Class_Master cm on cws.classid=cm.id " +
                    //" inner join exam_class ec on ec.brid = cws.branchid " +
                         " where cm.status=1 and cws.branchid=" + Session["brBrid"] + " and cm.fyid=" + fyid; //+ "" +
                //" and ec.examid =" + examid;
                Dt = objDut.GetDataTable(Query);
                ddlcourse.DataSource = Dt;
                ddlcourse.DataTextField = "classname";
                ddlcourse.DataValueField = "classid";
                ddlcourse.DataBind();
                ListItem licourse = new ListItem("Select Class", "0");
                ddlcourse.Items.Insert(0, licourse);
            }
            else if (classid > 0)
            {
                // This Is For The Bind Section In Drop Down List
                Query = "select Distinct cwsid,sectionname from classwithsection where branchid=" + Session["brBrid"] + " and classid=" + classid + "";
                Dt = objDut.GetDataTable(Query);
                ddlsection.DataSource = Dt;
                ddlsection.DataTextField = "sectionname";
                ddlsection.DataValueField = "cwsid";
                ddlsection.DataBind();
                ListItem listsection = new ListItem("Select Section", "0");
                ddlsection.Items.Insert(0, listsection);
                // This Is For The Bind Subject In Drop Down List

                Query = @"Select subjectid,subjectname from SubjectBranch_master where BranchId=" + Session["brBrid"] + " and classid=" + classid + " and subjectname NOT IN('Health & Physical Education','Work Education','Discipline','Art Education')";
                Dt = objDut.GetDataTable(Query);
                ddlsubject.DataSource = Dt;
                ddlsubject.DataTextField = "subjectname";
                ddlsubject.DataValueField = "subjectid";
                ddlsubject.DataBind();
                ListItem lisubject = new ListItem("Select Subject", "0");
                ddlsubject.Items.Insert(0, lisubject);
            }
            else
            {
                // This Is For The Bind Exam In Drop Down List

                Query = @"Select * from exam_name
                                    inner join exam_class on exam_class.examid = exam_name.eid
                                    where exam_class.brid=" + Session["brBrid"] + " and exam_class.status=1 order by eid asc";

                Dt = objDut.GetDataTable(Query);
                ddlexam.DataSource = Dt;
                ddlexam.DataTextField = "examname";
                ddlexam.DataValueField = "eid";
                ddlexam.DataBind();
                ListItem liexam = new ListItem("Select Exam", "0");
                ddlexam.Items.Insert(0, liexam);
            }
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
                        foreach (DataRow dr in dt.Tables[1].Rows)
                        {
                            foreach (DataRow dr1 in dt.Tables[0].Rows)
                            {
                                if (dr1["sturegno"].ToString() == dr["sturegno"].ToString())
                                {
                                    dr1["marks"] = dr["marks"].ToString();
                                }
                            }
                        }
                    }
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
            //if (validate())
            //{
            foreach (GridViewRow row in grdsetmarks.Rows)
            {
                Label lblregno = (Label)row.FindControl("lblregno");
                TextBox txtmarks = (TextBox)row.FindControl("txtmarks");
                CheckBox chkstatus = (CheckBox)row.FindControl("chkstatus");

                SqlParameter[] param = new SqlParameter[11];

                param[0] = new SqlParameter("@examid", SqlDbType.BigInt);
                param[0].Value = ddlexam.SelectedValue;

                param[1] = new SqlParameter("@classid", SqlDbType.BigInt);
                param[1].Value = ddlcourse.SelectedValue;

                param[2] = new SqlParameter("@subjectid", SqlDbType.BigInt);
                param[2].Value = ddlsubject.SelectedValue;

                param[3] = new SqlParameter("@secionid", SqlDbType.BigInt);
                param[3].Value = ddlsection.SelectedValue;

                param[4] = new SqlParameter("@sturegno", SqlDbType.BigInt);
                param[4].Value = Convert.ToInt32(lblregno.Text);

                param[5] = new SqlParameter("@marks", SqlDbType.Char);
                if (chkstatus.Checked == true)
                {
                    param[5].Value = 0.00;
                }
                else
                {
                    param[5].Value = Convert.ToInt32(txtmarks.Text);
                }

                param[6] = new SqlParameter("@fyid", SqlDbType.BigInt);
                param[6].Value = fyid;

                param[7] = new SqlParameter("@brid", SqlDbType.BigInt);
                param[7].Value = Convert.ToInt64(Session["BrBrid"]);

                param[8] = new SqlParameter("@status", SqlDbType.Int);
                //if status =0 then absent and if status=1 then present
                if (chkstatus.Checked == true)
                {
                    param[8].Value = 0;
                }
                else
                {
                    param[8].Value = 1;
                }
                param[9] = new SqlParameter("@intResult", SqlDbType.Int);
                param[9].Direction = ParameterDirection.Output;

                param[10] = new SqlParameter("@mode", SqlDbType.BigInt);
                param[10].Value = Convert.ToInt32(1);

                int result = objDut.ExecuteSqlSP(param, "Usp_Insert_Stud_marks");
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
            //}
        }
        catch (Exception ex)
        {
        }

        #endregion button submit
    }

    private bool validate()
    {
        foreach (GridViewRow row1 in grdsetmarks.Rows)
        {
            TextBox txtmarks = row1.FindControl("txtmarks") as TextBox;
            CheckBox chkstatus1 = row1.FindControl("chkstatus") as CheckBox;

            if (txtmarks.Text == "0")
            {
                if (chkstatus1.Checked == false)
                {
                    txtmarks.Text = "0";
                }
            }
            //if (txtmarks1.Text != "" && chkstatus1.Checked == true)
            //{
            //    Utility.ViewAlertMessage(Page, "You can only enter the marks or check the status");
            //    return false;
            //}
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
            Query = "select eid,examname from exam_name where brid=" + Session["brBrid"] + " order by eid asc";
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