﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.HtmlControls;

public partial class BranchPanel_Exams_ReportCard_Term : System.Web.UI.Page
{
    DataUtility ObjDut = new DataUtility();
    DataTable dtPerInfo;
    DataTable dtReg;
    DataTable dtExam;
    DataTable dtSubject;
    DataTable dtMarks;
    int eid = 0;
    int fyid = 0;
    int ClassID = 0;
    int SectionID = 0, ResultTerm = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["RegList"] != null)
        {
            dtReg = (DataTable)(Session["RegList"]);
            if (dtReg.Rows.Count > 0)
            {
                grdSTDResult.DataSource = dtReg;
                grdSTDResult.DataBind();
            }
        }
        else
        {
            Response.Redirect("ViewResult.aspx");
        }
    }
    private void getrecieptgenraldetails(HtmlGenericControl SSAddress, HtmlGenericControl SpScool, HtmlGenericControl SAddress, HtmlGenericControl SpFone, HtmlGenericControl SMobile, HtmlGenericControl SEmailID, HtmlGenericControl SchoolAffia, HtmlGenericControl affhead, HtmlGenericControl SWebsite, Image Image1)
    {
        string value = "";
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 10);
        value = objdut.GetScalerSP(param, "[usp_general_master_setting]").ToString();
        string[] getdata = value.Split('~');
        string isbranch = getdata[0];
        string address = "", serviceno = "", Ph = "", mobile = "", Contact = "", EmailID = "", tin = "", SchoolAffi = "", Website = "";

        string branchdata = Convert.ToString(objdut.GetScalar(@"select BrAddress+'^'+City+', '+state+', '+Country+', '+pincode+'^'+
            LandLineNo+','+MobileNo+'^'+Emailid+'^'+isnull(Website,'')+'^'+isnull(SchoolAffi,'')+'^'+isnull(BrName,'')+'^'+isnull(photo,'') from branch_master where brid = " + Session["brbrid"] + ""));
        if (branchdata != "")
        {
            string[] getbranchdata = branchdata.Split('^');
            address = getbranchdata[0];
            SSAddress.InnerText = getbranchdata[1];

            string[] getCont;
            Contact = getbranchdata[2];
            getCont = Contact.Split(',');
            Ph = getCont[0].ToString();
            mobile = getCont[1].ToString();
            EmailID = getbranchdata[3].ToString();
            Website = getbranchdata[4].ToString();
            SchoolAffi = getbranchdata[5].ToString();
            SpScool.InnerText = getbranchdata[6].ToString();
            SAddress.InnerText = address;

            SpFone.InnerText = Ph.ToString();
            SMobile.InnerText = mobile.ToString();
            SEmailID.InnerText = EmailID.ToString();

            if (SchoolAffi != "")
            {
                SchoolAffia.InnerText = SchoolAffi.Trim();
                affhead.InnerText = "Affiliation No:";

            }
            else
            {
                affhead.InnerText = ".";
            }
            SWebsite.InnerText = Website.Trim();
            if (getbranchdata[7].ToString() != "")
            {
                //Image1.ImageUrl = "~/BranchPanel/images/" + getbranchdata[7].ToString();
            }
            else
            {
                //Image1.ImageUrl = "~/BranchPanel/images/9update.png";
            }
        }
    }
    private void BindPersonalInfo(int eid, HtmlGenericControl RollNoA, string dfrollno, HtmlGenericControl RollNo, HtmlGenericControl classID, HtmlGenericControl DOB, HtmlGenericControl sectionID, HtmlGenericControl SpName, HtmlGenericControl SpMName, HtmlGenericControl SpFName, Image Image2)
    {
        string strPer = @"Select distinct SR.fyid,SR.RID,SR.StudentPhotograph,SR.Registration_No,SR.StudentFirstName+' '+SR.StudentMiddleName+' '+StudentLastName as StdName,
                            SR.PrimaryParentFirstName+' '+SR.PrimaryParentMiddleName+' '+PrimaryParentLastName as FatherName,
                            SR.SecondaryParentFirstName+' '+SR.SecondaryParentMiddleName+' '+SecondaryParentLastName as MotherName,
                            ISNULL(SR.RegNewNo,0) RegNewNo,SR.StudentDOB,SA.ClassID,Class_Master.Classname,SA.SectionId from tbl_StudentRegistration SR 
                            inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.brid 
                            inner join tbl_StudentAdmissionMaster SA on SM.SturegNo = SA.StuRegNo and SM.Brid = SA.brid
                            inner join classwithsection ON  classwithsection.classid = SA.ClassID
                            inner join Class_Master ON  Class_Master.id = classwithsection.ClassID
                            Left Outer join mst_RresultToClass ON  mst_RresultToClass.ClassID = SM.ClassID and mst_RresultToClass.ResultTypeID=1
                            where sr.Brid=" + Convert.ToInt32(Session["BrBrid"]) + " and SA.StuRegNo=" + eid + "";
        dtPerInfo = new DataTable();

        dtPerInfo = ObjDut.GetDataTable(strPer);

        if (dtPerInfo.Rows.Count > 0)
        {
            if (dfrollno != "")
            {
                //RollNo.InnerText = dfrollno.ToString();
            }
            else
            {
                //RollNo.InnerText = dtPerInfo.Rows[0]["RegNewNo"].ToString();
            }
            classID.InnerText = dtPerInfo.Rows[0]["Classname"].ToString();
            //SpClasss.InnerText = classID.InnerText;
            SectionID = Convert.ToInt32(dtPerInfo.Rows[0]["SectionId"]);
            DOB.InnerText = Convert.ToDateTime(dtPerInfo.Rows[0]["StudentDOB"]).ToString("dd-MM-yyyy");
            ClassID = Convert.ToInt32(dtPerInfo.Rows[0]["ClassID"]);
            sectionID.InnerText = (string)(ObjDut.GetScalar("Select sectionname from classwithsection where cwsid=" + SectionID + " and branchid=" + Convert.ToInt32(Session["BrBrid"]) + ""));
            SpName.InnerText = dtPerInfo.Rows[0]["StdName"].ToString();
            SpMName.InnerText = dtPerInfo.Rows[0]["MotherName"].ToString();
            SpFName.InnerText = dtPerInfo.Rows[0]["FatherName"].ToString();
            Image2.ImageUrl = "~/BranchPanel/Student-Registration/student-registration-document/" + dtPerInfo.Rows[0]["StudentPhotograph"].ToString();
            fyid = Convert.ToInt32(dtPerInfo.Rows[0]["fyid"]);
        }
    }

    private void ExamMarks(int eid, PlaceHolder placeholder, HtmlGenericControl spnPercent, HtmlGenericControl spnRank)
    {
        ResultTerm = Convert.ToInt32(dtReg.Rows[0]["ResultTerm"]);
        int mm = 0;
        string strExam = "";
        string strSub = "";
        decimal AllSubjectMarks = 0;
        dtExam = new DataTable();
        strExam = "Select DISTINCT exam_name.eid AS id,examname from exam_class " +
                   " INNER join exam_name on exam_class.examid=exam_name.eid where exam_name.brid=" + Convert.ToInt32(Session["BrBrid"]) + " and exam_class.status=1 " +
                   " and exam_class.classid=" + ClassID + " order by id asc";
        dtExam = ObjDut.GetDataTable(strExam);
        if (dtExam.Rows.Count > mm)
        {
            
            dtSubject = new DataTable();

            strSub = @"Select * from Subject_Master SM " +
               " INNER JOIN SubjectBranch_master SBM on SM.id = SBM.Subjectid where SBM.BranchId=" + Convert.ToInt32(Session["BrBrid"]) + "" +
               " and SBM.classid=" + ClassID + " and SM.subjectname NOT IN('Health & Physical Education','Work Education','Discipline','Art Education') and SBM.status=1" +
               " order by SBM.IsGrade asc";
            dtSubject = ObjDut.GetDataTable(strSub);
            if (dtSubject.Rows.Count > 0)
            {
                dtMarks = new DataTable();
                if (dtMarks.Columns.Count == 0)
                {
                    int p = 0;
                    int q = 0;
                    int t = 0;
                    dtMarks.Columns.Add("SUBJECT NAME");

                    if (ResultTerm == 1)
                    {
                        p = 0;
                        q = 2;
                    }
                    else if (ResultTerm == 2)
                    {
                        p = 0;
                        q = 4;
                    }

                    for (int i = p; i < q; i++)
                    {
                        dtMarks.Columns.Add(dtExam.Rows[i]["examname"].ToString().ToUpper());
                    }
                }
                for (int a = 0; a < dtSubject.Rows.Count; a++)
                {
                    var IsGrade = Convert.ToString(dtSubject.Rows[a]["IsGrade"]);
                    DataRow dr = dtMarks.NewRow();
                    dr["SUBJECT NAME"] = dtSubject.Rows[a]["SubjectName"] + "_" + (string.IsNullOrWhiteSpace(IsGrade) == true ? "0" : IsGrade);
                    dtMarks.Rows.Add(dr);
                    dtMarks.AcceptChanges();
                }
                if (dtMarks.Rows.Count > 0)
                {
                    string ExamName = "";
                    string SubjectName = "";
                    int ExamID = 0;
                    int SubjectID = 0;
                    int IsGradeed = 0;
                    fyid = Convert.ToInt32(dtPerInfo.Rows[0]["fyid"]);
                    for (int a = 0; a < dtMarks.Rows.Count; a++)
                    {
                        SubjectName = dtMarks.Rows[a][0].ToString().Split('_')[0];
                        IsGradeed = Convert.ToInt32(dtMarks.Rows[a][0].ToString().Split('_')[1]);
                        SubjectID = (int)(ObjDut.GetScalar("Select ISNULL(SM.id,0) subjectid from Subject_Master SM " +
                                        " INNER JOIN SubjectBranch_master SBM on SM.id = SBM.Subjectid where SBM.BranchId=" + Convert.ToInt32(Session["BrBrid"]) + "" +
                                        " and SBM.classid=" + ClassID + " and SM.subjectname ='" + SubjectName + "' and fyid=" + fyid + " order by SM.id asc"));
                        for (int b = 1; b < dtMarks.Columns.Count; b++)
                        {
                            ExamName = dtMarks.Columns[b].ColumnName.ToString(); 
                            string Marks = "0", GradeValue = "";
                            string strExam1 = "";
                            strExam1 = "Select ISNULL(exam_name.eid,0) from exam_class " +
                                   " INNER join exam_name on exam_class.examid=exam_name.eid where exam_name.brid=" + Convert.ToInt32(Session["BrBrid"]) + " and exam_class.status=1 " +
                                   " and exam_class.classid=" + ClassID + " and examname='" + ExamName + "'";
                            ExamID = (int)(ObjDut.GetScalar(strExam1));
                            if (SubjectID > 0 && ExamID > 0)
                            {
                                string strMarks = @"Select ISnull(marks,'0') marks,ISNULL(Grade,'') Grade,IsGrade IsGrade,ISnull(IsAbsent,'0') IsAbsent
                                                        from tbl_marks_master where sectionid=" + SectionID + " and examid=" + ExamID +
                                                    " and classid=" + ClassID + " and subjectid=" + SubjectID + " and studentregno=" + eid + "";

                                DataTable dtMarksDT = ObjDut.GetDataTable(strMarks);
                                if (dtMarksDT.Rows.Count > 0)
                                {
                                    string markss = "", Gradee = "";
                                    var IsGrade = 0;
                                    Gradee = Convert.ToString(dtMarksDT.Rows[0]["Grade"]);
                                    int IsAbsent = Convert.ToInt32(dtMarksDT.Rows[0]["IsAbsent"]);
                                    if (IsAbsent > 0)
                                    {
                                        dtMarks.Rows[a][b] = "AB";
                                    }
                                    else
                                    {
                                        if (!string.IsNullOrWhiteSpace(Convert.ToString(dtMarksDT.Rows[0]["IsGrade"])))
                                        {
                                            IsGrade = Convert.ToInt32(dtMarksDT.Rows[0]["IsGrade"]);
                                        }
                                        else
                                        {
                                            IsGrade = IsGradeed;
                                        }
                                        markss = Convert.ToString(dtMarksDT.Rows[0]["marks"]);
                                        if (IsGrade > 0)
                                        {
                                            dtMarks.Rows[a][b] = Gradee.ToString();
                                        }
                                        else
                                        {
                                            dtMarks.Rows[a][b] = markss.ToString();
                                        }
                                    }
                                }
                                else
                                {
                                    if (IsGradeed > 0)
                                    {
                                        dtMarks.Rows[a][b] = "";
                                    }
                                    else
                                    {
                                        dtMarks.Rows[a][b] = "0";
                                    }
                                }
                            }
                        }
                    }
                    //Building an HTML string.
                    StringBuilder html = new StringBuilder();
                    //Table start.
                    html.Append("<table border = '1' Style='width: 100%; font-size: 16px;'>");
                    //Building the Header row.
                    html.Append("<tr>");
                    html.Append("<th style='Width:154px; text-align: center; font-size: 16px;font-weight:bold; line-height: 30px;'>");
                    html.Append("");
                    html.Append("</th>");
                    html.Append("<th style='Width:84px; text-align: center; font-size: 16px;font-weight:bold; line-height: 30px;'>");
                    html.Append("Unit Test I");
                    html.Append("<br/>20</th>");

                    html.Append("<th style='Width:84px; text-align: center; font-size: 16px;font-weight:bold; line-height: 30px;'>");
                    html.Append("Half Yearly");
                    html.Append("<br/>80</th>");

                    html.Append("<th style='Width:84px; text-align: center; font-size: 18px;font-weight:bold; line-height: 30px;'>");
                    html.Append("Total");
                    html.Append("<br/>100</th>");
                    html.Append("<th style='Width:84px; text-align: center; font-size: 16px;font-weight:bold; line-height: 30px;'>");
                    html.Append("Unit Test II");
                    html.Append("<br/>20</th>");

                    html.Append("<th style='Width:84px; text-align: center; font-size: 16px;font-weight:bold; line-height: 30px;'>");
                    html.Append("Annual");
                    html.Append("<br/>80</th>");

                    html.Append("<th style='Width:84px; text-align: center; font-size: 18px;font-weight:bold; line-height: 30px;'>");
                    html.Append("Total");
                    html.Append("<br/>100</th>");

                    html.Append("<th style='Width:84px; text-align: center; font-size: 18px;font-weight:bold; line-height: 30px;'>");
                    html.Append("Final");
                    html.Append("<br/>200</th>");

                    html.Append("<th style='Width:84px; text-align: center; font-size: 18px;font-weight:bold; line-height: 30px;'>");
                    html.Append("Grade");
                    html.Append("<br/></th>");

                    html.Append("</tr>");
                    //Building the Data rows.
                    int total1 = 0, total2 = 0, total3 = 0, total4 = 0, total5 = 0, total6 = 0;
                    double finalPercentage = 0;
                    foreach (DataRow row in dtMarks.Rows)
                    {
                        html.Append("<tr>");
                        int a = 1;
                        foreach (DataColumn column in dtMarks.Columns)
                        {
                            if (column.ColumnName.ToUpper() == "SUBJECT NAME")
                            {
                                html.Append("<td style='font-size: 17px; line-height: 22px; font-weight:bold; text-align: left;'>");
                            }
                            else
                            {
                                html.Append("<td style='font-size: 16px; line-height: 22px; text-align: center;'>");
                            }

                            var value = Convert.ToString(row[column.ColumnName]);
                            var filterValue = "";
                            if (!string.IsNullOrWhiteSpace(value))
                            {
                                if (value.Contains("_"))
                                    filterValue = value.Split('_')[0];
                                else
                                    filterValue = value;
                            }
                            html.Append(filterValue);
                            html.Append("</td>");
                            if (dtMarks.Columns.Count < 7 && a == 3)
                            {
                                string finalMarks = "";
                                var IsGrade = Convert.ToInt32(row[0].ToString().Split('_')[1]);
                                if (IsGrade > 0)
                                {
                                    finalMarks = Convert.ToString(row[2]);
                                }
                                else
                                {
                                    int marks1 = 0, marks2 = 0;
                                    int.TryParse(Convert.ToString(row[1]), out marks1);
                                    total1 = total1 + marks1;
                                    int.TryParse(Convert.ToString(row[2]), out marks2);
                                    total2 = total2 + marks2;
                                    finalMarks = (marks1 + marks2).ToString();
                                    total3 = total3 + Convert.ToInt32(finalMarks);
                                }
                                html.Append("<td style='font-size: 18px; line-height: 22px;font-weight:bold; text-align: center;'>");
                                html.Append(finalMarks);
                                html.Append("</td>");
                            }
                            if (dtMarks.Columns.Count < 7 && a == 5)
                            {
                                string finalMarks = "", TotalMarks="", TotalGrade="";
                                var IsGrade = Convert.ToInt32(row[0].ToString().Split('_')[1]);
                                if (IsGrade > 0)
                                {
                                    finalMarks = Convert.ToString(row[4]);
                                    TotalMarks = finalMarks;
                                    TotalGrade = finalMarks;
                                }
                                else
                                {
                                    int marks1 = 0, marks2 = 0, marks3 = 0, marks4 = 0;

                                    int.TryParse(Convert.ToString(row[1]), out marks3);
                                    int.TryParse(Convert.ToString(row[2]), out marks4);

                                    int.TryParse(Convert.ToString(row[3]), out marks1);
                                    total4 = total4 + marks1;
                                    int.TryParse(Convert.ToString(row[4]), out marks2);
                                    total5 = total5 + marks2;
                                    finalMarks = (marks1 + marks2).ToString();
                                    total6 = total6 + Convert.ToInt32(finalMarks);

                                    TotalMarks = (marks1 + marks2 + marks3 + marks4).ToString();
                                    var percentage = ((marks1 + marks2 + marks3 + marks4) * 100) / 200; 
                                    TotalGrade = getGrade(percentage, "");
                                }
                                html.Append("<td style='font-size: 18px; line-height: 22px;font-weight:bold; text-align: center;'>");
                                html.Append(finalMarks);
                                html.Append("</td>");

                                html.Append("<td style='font-size: 18px; line-height: 22px;font-weight:bold; text-align: center;'>");
                                html.Append(TotalMarks);
                                html.Append("</td>");

                                html.Append("<td style='font-size: 18px; line-height: 22px;font-weight:bold; text-align: center;'>");
                                html.Append(TotalGrade);
                                html.Append("</td>");
                            }
                            a = a + 1;
                        }

                        html.Append("</tr>");
                    }
                    html.Append("<tr>");


                    foreach (DataColumn column in dtMarks.Columns)
                    {

                        if (column.ColumnName.ToUpper() == "SUBJECT NAME")
                        {
                            html.Append("<td style='font-size: 20px; line-height: 22px;font-weight:bold; text-align: left;'>");
                            html.Append("TOTAL");
                            html.Append("</td>");
                        }
                        else
                        {


                        }


                    }


                    for (int i = 0; i < 8; i++)
                    {
                        html.Append("<td style='font-size: 18px; line-height: 22px; font-weight:bold; text-align: center;'>");
                        if (i == 0)
                        {
                            html.Append(total1.ToString());
                        }
                        if (i == 1)
                        {
                            html.Append(total2.ToString());
                        }
                        if (i == 2)
                        {
                            html.Append(total3.ToString());
                        }
                        if (i == 3)
                        {
                            html.Append(total4.ToString());
                        }
                        if (i == 4)
                        {
                            html.Append(total5.ToString());
                        }
                        if (i == 5)
                        {
                            html.Append(total6.ToString());
                        }
                        if (i == 6)
                        {
                            html.Append((total3 + total6).ToString());
                        }
                        if (i == 7)
                        {
                            // var subjectCount = dtSubject.AsEnumerable().Where(x => Convert.ToInt32(x.ItemArray[x.ItemArray.Count() - 2]) == 1).ToList().Count;
                            var subjectCount = dtSubject.Select("IsGrade = 0").Count();
                            finalPercentage = GetPercentage((total3 + total6), (subjectCount * 200));
                            var gradeFinal = getGrade(finalPercentage, "");
                            html.Append(gradeFinal);
                        }
                        html.Append("</td>");
                    }

                    html.Append("</tr>");


                    string rank = "";
                    try
                    {
                        rank = ObjDut.GetScalar("select _rank from (select studentregno,sum(marks) as totalMarks, RANK () OVER (  ORDER BY sum(marks) DESC  ) _rank  from tbl_marks_master where classid=" + ClassID + " and fyid=" + fyid + " and brid=" + Convert.ToInt32(Session["BrBrid"]) + "   group by studentregno ) t where t.studentregno='" + eid + "'").ToString();
                    }
                    catch (Exception ex)
                    {

                    }

                    string ranksection = "", ranksection1 = "", finalrank = "";
                    try
                    {
                        ranksection = ObjDut.GetScalar("select _rank from (select studentregno,sum(marks) as totalMarks, RANK () OVER (  ORDER BY sum(marks) DESC  ) _rank  from tbl_marks_master where examid in(1,2) and classid=" + ClassID + " and sectionid=" + SectionID + " and fyid=" + fyid + " and brid=" + Convert.ToInt32(Session["BrBrid"]) + "   group by studentregno ) t where t.studentregno='" + eid + "'").ToString();
                        ranksection1 = ObjDut.GetScalar("select _rank from (select studentregno,sum(marks) as totalMarks, RANK () OVER (  ORDER BY sum(marks) DESC  ) _rank  from tbl_marks_master where examid in(3,4) and classid=" + ClassID + " and sectionid=" + SectionID + " and fyid=" + fyid + " and brid=" + Convert.ToInt32(Session["BrBrid"]) + "   group by studentregno ) t where t.studentregno='" + eid + "'").ToString();
                        finalrank = ObjDut.GetScalar("select _rank from (select studentregno,sum(marks) as totalMarks, RANK () OVER (  ORDER BY sum(marks) DESC  ) _rank  from tbl_marks_master where classid=" + ClassID + " and sectionid=" + SectionID + " and fyid=" + fyid + " and brid=" + Convert.ToInt32(Session["BrBrid"]) + "   group by studentregno ) t where t.studentregno='" + eid + "'").ToString();
                    }
                    catch (Exception ex)
                    {

                    }
                    html.Append("<tr>");
                    int y = 0;
                    foreach (DataColumn column in dtMarks.Columns)
                    {
                        if (column.ColumnName.ToUpper() == "SUBJECT NAME")
                        {
                            html.Append("<td style='font-size: 20px; line-height: 22px;font-weight:bold; text-align: left;'>");
                            html.Append("RANK");
                        }
                        //else
                        //{
                        //    html.Append("<td style='font-size: 16px; line-height: 22px; text-align: center;'>");
                        //    if (y == 2)
                        //        html.Append(ranksection);
                        //    else
                        //        html.Append("");
                        //}
                        //y++;
                        html.Append("</td>");
                    }
                    int count = 0;
                    if (ResultTerm == 1)
                        count = dtMarks.Columns.Count - 1;
                    else
                        count = dtMarks.Columns.Count;
                    for (int i = 0; i <= count; i++)
                    {
                        html.Append("<td style='font-size: 18px; line-height: 22px;font-weight:bold; text-align: center;'>");
                        if (ResultTerm == 1)
                        {
                            if (i == count)
                            {
                                html.Append(ranksection);
                            }
                        }
                        else
                        {
                            if (i == 2)
                            {
                                html.Append(ranksection);
                            }
                            else if (i == count)
                            {
                                html.Append(ranksection1);
                            }
                            else
                                html.Append("");
                            html.Append("</td>");
                        }
                    }
                    
                    html.Append("<td style='font-size: 18px; line-height: 22px;font-weight:bold; text-align: center;'>");
                    html.Append(finalrank.ToString());
                    html.Append("</td>");

                    html.Append("<td style='font-size: 18px; line-height: 22px;font-weight:bold; text-align: center;'>");
                    html.Append("");
                    html.Append("</td>");

                    html.Append("</tr>");
                    html.Append("<tr>");
                    decimal percent = 0;
                    if (dtMarks.Rows.Count > 0)
                    {
                        percent = AllSubjectMarks / dtMarks.Rows.Count;
                    }
                    double percent1 = 0, percent2 = 0, percent3 = 0, percent4 = 0, percent5 = 0, percent6 = 0;
                    if (dtMarks.Rows.Count > 0)
                    {
                        int Count = 0;
                        foreach (DataRow dr in dtMarks.Rows)
                        {
                            if (dr.ItemArray.Count() > 1)
                            {
                                var IsGradeedd = Convert.ToInt32(dr.ItemArray[0].ToString().Split('_')[1]);
                                var value = Convert.ToString(dr.ItemArray[1]);
                                if (!string.IsNullOrWhiteSpace(value))
                                {
                                    var isNumeric = !string.IsNullOrEmpty(value) && value.All(Char.IsDigit);
                                    if (isNumeric || IsGradeedd==0)
                                    {
                                        Count = Count + 1;
                                    }
                                }
                            }
                        }

                        percent1 = Convert.ToDouble(total3) / Convert.ToDouble(Count); // Total -1st Term
                        percent2 = Convert.ToDouble(total6) / Convert.ToDouble(Count);
                        percent3 = (Convert.ToDouble(total1) / Convert.ToDouble(Count)) * 5; //Total -1st Term - Unit Test I
                        percent4 = (Convert.ToDouble(total2) / Convert.ToDouble(Count)) * 5 / 4; //Total -1st Term - Half Yealy
                        percent5 = (Convert.ToDouble(total4) / Convert.ToDouble(Count)) * 5;
                        percent6 = (Convert.ToDouble(total5) / Convert.ToDouble(Count)) * 5 / 4;

                        percent1 = Math.Round(percent1);
                        percent2 = Math.Round(percent2);
                        percent3 = Math.Round(percent3);
                        percent4 = Math.Round(percent4);
                        percent5 = Math.Round(percent5);
                        percent6 = Math.Round(percent6);
                    }

                    string grade = getGrade(Convert.ToDouble(percent), "all");
                    foreach (DataColumn column in dtMarks.Columns)
                    {

                        if (column.ColumnName.ToUpper() == "SUBJECT NAME")
                        {
                            html.Append("<td style='font-size: 18px; line-height: 22px;font-weight:bold; text-align: left;'>");
                            html.Append("Percentage");
                            html.Append("</td>");
                        }
                    }

                    for (int i = 0; i < 8; i++)
                    {
                        if (i == 0)
                        {
                            html.Append("<td style='font-size: 18px; line-height: 22px;font-weight:bold; text-align: center;'>");
                            html.Append(percent3.ToString() + "%");
                            html.Append("</td>");
                        }
                        else if (i == 1)
                        {
                            html.Append("<td style='font-size: 16px; line-height: 22px;font-weight:bold; text-align: center;'>");
                            html.Append(percent4.ToString() + "%");
                            html.Append("</td>");
                        }
                        else if (i == 2)
                        {
                            html.Append("<td style='font-size: 16px; line-height: 22px;font-weight:bold; text-align: center;'>");
                            html.Append(percent1.ToString() + "%");
                            html.Append("</td>");
                        }
                        else if (i == 3)
                        {
                            html.Append("<td style='font-size: 16px; line-height: 22px;font-weight:bold; text-align: center;'>");
                            html.Append(percent5.ToString() + "%");
                            html.Append("</td>");
                        }
                        else if (i == 4)
                        {
                            html.Append("<td style='font-size: 16px; line-height: 22px;font-weight:bold; text-align: center;'>");
                            html.Append(percent6.ToString() + "%");
                            html.Append("</td>");
                        }
                        else if (i == 5)
                        {
                            html.Append("<td style='font-size: 16px; line-height: 22px;font-weight:bold; text-align: center;'>");
                            html.Append(percent2.ToString() + "%");
                            html.Append("</td>");
                        }
                        else if (i == 6)
                        {
                            html.Append("<td style='font-size: 16px; line-height: 22px;font-weight:bold; text-align: center;'>");
                            html.Append(finalPercentage.ToString() + "%");
                            html.Append("</td>");
                        }
                        else if (i == 7)
                        {
                            html.Append("<td style='font-size: 16px; line-height: 22px;font-weight:bold; text-align: center;'>");
                            html.Append("");
                            html.Append("</td>");
                        }
                        else
                        {
                            html.Append("<td style='font-size: 16px; line-height: 22px; text-align: center;'>");
                            html.Append("");
                            html.Append("</td>");
                        }

                    }
                    html.Append("</tr>");
                    html.Append("<tr>");
                    foreach (DataColumn column in dtMarks.Columns)
                    {

                        if (column.ColumnName.ToUpper() == "SUBJECT NAME")
                        {
                            html.Append("<td style='font-size: 18px; line-height: 22px;font-weight:bold; text-align: left;'>");
                            html.Append("Attendance");
                        }
                        else
                        {
                            html.Append("<td style='font-size: 16px; line-height: 22px; text-align: center;'>");
                            html.Append("");
                        }

                        html.Append("</td>");
                    }
                    if (dtMarks.Columns.Count < 7)
                    {
                        for (int i = 0; i < 7 - dtMarks.Columns.Count; i++)
                        {
                            html.Append("<td style='font-size: 16px; line-height: 22px; text-align: center;'>");
                            html.Append("");
                            html.Append("</td>");
                        }
                    }
                    html.Append("</tr>");
                    html.Append("</table>");
                    placeholder.Controls.Add(new Literal { Text = html.ToString() });
                }
            }
        }
    }

    private double GetPercentage(int v1, int v2)
    {
        var max = Convert.ToDouble(v2);
        var obtained = Convert.ToDouble(v1);
        double per = (obtained / max) * 100;
        var decimalValueBy_2 = Math.Round(per, 2);
        var decimalValue = decimalValueBy_2.ToString().Split('.');
        string finalValue = "";
        if (decimalValue.Length == 2)
        {
            var decimalV = decimalValue[1].Length == 1 ? decimalValue[1] + "0" : decimalValue[1];
            if (Convert.ToInt32(decimalV) >= 50)
                finalValue = (Convert.ToInt32(decimalValue[0]) + 1).ToString();
            else
                finalValue = decimalValue[0].ToString();
        }
        else
            finalValue = per.ToString();
        return Convert.ToDouble(finalValue);
    }

    private string getGrade(double TotalMarks, string SubjectName)
    {
        string Grade = "";
        if (SubjectName.ToLower() == "general knowledge" || SubjectName.ToLower() == "drawing" || SubjectName.ToLower() == "mv")
        {
            if (TotalMarks < 40)
            {
                Grade = "E";
            }
            else if (TotalMarks > 39 && TotalMarks <50)
            {
                Grade = "D";
            }

            else if (TotalMarks >= 50 && TotalMarks < 65)
            {
                Grade = "C";
            }
            else if (TotalMarks >= 65 && TotalMarks < 80)
            {
                Grade = "B";
            }
            else if (TotalMarks >=80 && TotalMarks < 100)
            {
                Grade = "A";
            }
           
        }
        else
        {
            if (TotalMarks < 40)
            {
                Grade = "E";
            }
            else if (TotalMarks >=40 && TotalMarks < 50)
            {
                Grade = "D";
            }
            else if (TotalMarks >=50 && TotalMarks < 65)
            {
                Grade = "C";
            }
            else if (TotalMarks >=65 && TotalMarks < 80)
            {
                Grade = "B";
            }
            else if (TotalMarks >=80 && TotalMarks < 100)
            {
                Grade = "A";
            }
           
           
        }

        return Grade;
    }
    private void BindCoSc(int eid, HtmlGenericControl spWorkI, HtmlGenericControl SpPhyI, HtmlGenericControl SpArtI, HtmlGenericControl SpDisI)
    {
        DataTable dtCoDT = new DataTable();
        string str = "";
        //int SectionID = (int)(ObjDut.GetScalar("Select ISNULL(cwsid,0) from classwithsection where classid=" + ClassID + " and branchid=" + Convert.ToInt32(Session["BrBrid"]) + ""));
        str = "Select * from tbl_Co_Sc_marks_master where classid=" + ClassID + " and sectionid=" + SectionID + " and studentregno=" + eid + " and brid=" + Convert.ToInt32(Session["BrBrid"]) + "";

        DataTable TempDt = new DataTable();
        string StrStr = "";
        StrStr = " where SEM.fyid=" + fyid + " and SEM.brid=" + Convert.ToInt64(Session["BrBrid"]) + "";

        DataUtility objDut = new DataUtility();
        string strSubject = " Select DISTINCT Subject_Master.SubjectName from tbl_Co_Sc_marks_master SEM " +
                            " inner join Subject_Master on Subject_Master.id = SEM.subjectid " + StrStr;
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
                         " inner join tbl_Co_Sc_marks_master SEM on SEM.studentregno = SM.SturegNo " +
                         " inner join Subject_Master on Subject_Master.id = SEM.subjectid " + StrStr + " and SEM.studentregno=" + eid + " ) as s " +
            " PIVOT " +
            " ( SUM(marks) FOR [SubjectName] IN (" + strSubjectList + ") )AS pvt";

            TempDt = objDut.GetDataTable(Query);

            if (TempDt.Rows.Count > 0)
            {
                dtCoDT = new DataTable();
                for (int a = 0; a < TempDt.Columns.Count; a++)
                {
                    dtCoDT.Columns.Add(TempDt.Columns[a].ColumnName.ToString());
                }

                for (int a = 0; a < TempDt.Rows.Count; a++)
                {
                    DataRow dr = dtCoDT.NewRow();
                    for (int b = 0; b < TempDt.Columns.Count; b++)
                    {
                        string ColName = TempDt.Columns[b].ColumnName.ToString();
                        if (b == 0 || b == 1 || b == 2)
                        {
                            dr[ColName] = TempDt.Rows[a][b];
                        }
                        else
                        {
                            if (b > 2)
                            {
                                int Grade = 0;
                                if (TempDt.Rows[a][b] != DBNull.Value)
                                {
                                    Grade = Convert.ToInt32(TempDt.Rows[a][b]);
                                }
                                else
                                {
                                    Grade = 0;
                                }
                                if (Grade == 1)
                                {
                                    dr[ColName] = "A";
                                }
                                else if (Grade == 2)
                                {
                                    dr[ColName] = "B";
                                }
                                else if (Grade == 3)
                                {
                                    dr[ColName] = "C";
                                }
                                else
                                {
                                    dr[ColName] = "N/A";
                                }
                            }
                        }
                    }
                    dtCoDT.Rows.Add(dr);
                    dtCoDT.AcceptChanges();
                }
                if (dtCoDT.Rows.Count > 0)
                {
                    for (int i = 0; i < dtCoDT.Rows.Count; i++)
                    {
                        for (int k = 0; k < dtCoDT.Columns.Count; k++)
                        {
                            string ColName = dtCoDT.Columns[k].ToString();
                            if (ColName == "Work Education")
                            {
                                if (dtCoDT.Rows[i]["examid"].ToString() == "101")
                                {
                                    spWorkI.InnerText = dtCoDT.Rows[i][ColName].ToString();
                                }
                                //else
                                //{
                                //    spWorkII.InnerText = dtCoDT.Rows[i][ColName].ToString();
                                //}
                            }
                            if (ColName == "Art Education")
                            {
                                if (dtCoDT.Rows[i]["examid"].ToString() == "101")
                                {
                                    SpArtI.InnerText = dtCoDT.Rows[i][ColName].ToString();
                                }
                                //else
                                //{
                                //    SpArtII.InnerText = dtCoDT.Rows[i][ColName].ToString();
                                //}
                            }
                            if (ColName == "Health & Physical Education")
                            {
                                if (dtCoDT.Rows[i]["examid"].ToString() == "101")
                                {
                                    SpPhyI.InnerText = dtCoDT.Rows[i][ColName].ToString();
                                }
                                //else
                                //{
                                //    SpPhyII.InnerText = dtCoDT.Rows[i][ColName].ToString();
                                //}
                            }
                            if (ColName == "Discipline")
                            {
                                if (dtCoDT.Rows[i]["examid"].ToString() == "101")
                                {
                                    SpDisI.InnerText = dtCoDT.Rows[i][ColName].ToString();
                                }
                                //else
                                //{
                                //    SpDisII.InnerText = dtCoDT.Rows[i][ColName].ToString();
                                //}
                            }
                        }
                    }
                }
            }
        }
    }
    protected void grdSTDResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField dfrollno = (HiddenField)e.Row.FindControl("dfrollno");
            HiddenField dfregno = (HiddenField)e.Row.FindControl("dfregno");
            HtmlGenericControl SSAddress = (HtmlGenericControl)e.Row.FindControl("SSAddress");
            HtmlGenericControl SpScool = (HtmlGenericControl)e.Row.FindControl("SpScool");
            HtmlGenericControl SAddress = (HtmlGenericControl)e.Row.FindControl("SAddress");
            HtmlGenericControl SpFone = (HtmlGenericControl)e.Row.FindControl("SpFone");
            HtmlGenericControl SMobile = (HtmlGenericControl)e.Row.FindControl("SMobile");
            HtmlGenericControl SEmailID = (HtmlGenericControl)e.Row.FindControl("SEmailID");
            HtmlGenericControl SchoolAffia = (HtmlGenericControl)e.Row.FindControl("SchoolAffia");
            HtmlGenericControl affhead = (HtmlGenericControl)e.Row.FindControl("affhead");
            HtmlGenericControl SWebsite = (HtmlGenericControl)e.Row.FindControl("SWebsite");
            HtmlGenericControl RollNoA = (HtmlGenericControl)e.Row.FindControl("RollNoA");
            HtmlGenericControl RollNo = (HtmlGenericControl)e.Row.FindControl("RollNo");
            HtmlGenericControl classID = (HtmlGenericControl)e.Row.FindControl("classID");
            HtmlGenericControl DOB = (HtmlGenericControl)e.Row.FindControl("DOB");

            HtmlGenericControl sectionID = (HtmlGenericControl)e.Row.FindControl("sectionID");
            HtmlGenericControl SpName = (HtmlGenericControl)e.Row.FindControl("SpName");
            HtmlGenericControl SpTerm = (HtmlGenericControl)e.Row.FindControl("SpTerm");
            HtmlGenericControl SpMName = (HtmlGenericControl)e.Row.FindControl("SpMName");
            HtmlGenericControl SpFName = (HtmlGenericControl)e.Row.FindControl("SpFName");
            HtmlGenericControl spWorkI = (HtmlGenericControl)e.Row.FindControl("spWorkI");

            HtmlGenericControl SpPhyI = (HtmlGenericControl)e.Row.FindControl("SpPhyI");
            PlaceHolder placeholder = (PlaceHolder)e.Row.FindControl("placeholder");
            HtmlGenericControl SpArtI = (HtmlGenericControl)e.Row.FindControl("SpArtI");
            HtmlGenericControl SpDisI = (HtmlGenericControl)e.Row.FindControl("SpDisI");
            HtmlGenericControl spnPercent = (HtmlGenericControl)e.Row.FindControl("spnPercent");
            HtmlGenericControl SpanRank = (HtmlGenericControl)e.Row.FindControl("SpanRank");

            Image Image2 = (Image)e.Row.FindControl("Image2");
            Image Image1 = (Image)e.Row.FindControl("Image1");

            if (dfregno.Value != null)
            {
                getrecieptgenraldetails(SSAddress, SpScool, SAddress, SpFone, SMobile, SEmailID, SchoolAffia, affhead, SWebsite, Image1);
                //affhead.InnerText = "Affiliation No:";
                BindPersonalInfo(Convert.ToInt32(dfregno.Value), RollNoA, dfrollno.Value.ToString(), RollNo, classID, DOB, sectionID, SpName, SpMName, SpFName, Image2);
                ExamMarks(Convert.ToInt32(dfregno.Value), placeholder, spnPercent, SpanRank);
                BindCoSc(Convert.ToInt32(dfregno.Value), spWorkI, SpPhyI, SpArtI, SpDisI);

                int ResultTerm = Convert.ToInt32(dtReg.Rows[0]["ResultTerm"]);
                if (ResultTerm == 1)
                {
                    // SpTerm.InnerText = "Term - I ( 100 Marks )";
                }
                else if (ResultTerm == 2)
                {
                    SpTerm.InnerText = "Term - I";
                }
                else if (ResultTerm == 3)
                {
                    SpTerm.InnerText = "Term - III ( 100 Marks )";
                }
            }
        }
    }
    protected void OnRowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Visible = false;
        }
    }
}