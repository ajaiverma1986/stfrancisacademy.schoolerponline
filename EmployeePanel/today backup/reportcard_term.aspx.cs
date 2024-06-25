using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class EmployeePanel_reportcard_term : System.Web.UI.Page
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
            Response.Redirect("download.aspx");
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
            string StrResult = "";
            string ValueResult = "";
            StrResult = "Select ISNULL(mst_RresultToClass.Status,0) from mst_RresultToClass where Brid=" + Convert.ToInt32(Session["BrBrid"]) + " and ClassID=" + ClassID + " and ResultTypeID=1";
            ValueResult = Convert.ToString(ObjDut.GetScalar(StrResult));
            if (ValueResult == "")
            {
                ResultType.Value = "0";
            }
            //else
            //{
            //    ResultType.Value = ValueResult.ToString();
            //}
        }
    }
   // private void ExamMarks(int eid, PlaceHolder placeholder, HtmlGenericControl spnPercent, HtmlGenericControl spnRank)
    private void ExamMarks(int eid, PlaceHolder placeholder, HtmlGenericControl spnPercent)
    {
        int mm = 0;
        string strExam = "";
        string strSub = "";
        decimal AllSubjectMarks = 0;
        //                inner join exam_class on exam_class.examid = exam_name.eid
        dtExam = new DataTable();
        strExam = "Select DISTINCT exam_name.eid AS id,examname from exam_class " +
                   " INNER join exam_name on exam_class.examid=exam_name.eid where exam_name.brid=" + Convert.ToInt32(Session["BrBrid"]) + " and exam_class.status=1 " +
                   " and exam_class.classid=" + ClassID + " order by id asc";
        //where status=1 and exam_name.brid=" + Convert.ToInt32(Session["BrBrid"]);// +" and exam_class.classid=" + ClassID + "";
        dtExam = ObjDut.GetDataTable(strExam);
        //if (ResultType.Value == "1")
        //{
        //    mm = 1;
        //}
        //else
        //{
        //    if (ResultTerm > 0)
        //    {
        //        mm = 11;
        //    }
        //}
        if (dtExam.Rows.Count > mm)
        {
            ResultTerm = Convert.ToInt32(dtReg.Rows[0]["ResultTerm"]);
            dtSubject = new DataTable();

            strSub = @"Select * from Subject_Master SM " +
               " INNER JOIN SubjectBranch_master SBM on SM.id = SBM.Subjectid where SBM.BranchId=" + Convert.ToInt32(Session["BrBrid"]) + "" +
               " and SBM.classid=" + ClassID + " and SM.subjectname NOT IN('Health & Physical Education','Work Education','Discipline','Art Education') and SBM.status=1" +
               " order by SM.id asc";
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
                    if (ResultTerm > 0)
                    {
                        if (ResultType.Value == "1")
                        {
                            if (ResultTerm == 1)
                            {
                                // t = 3;
                                dtMarks.Columns.Add(dtExam.Rows[t]["examname"].ToString());
                                dtMarks.Columns.Add("Marks Obtained I");
                                dtMarks.Columns.Add("Grade I");
                            }
                            else if (ResultTerm == 2)
                            {
                                t = 7;
                                dtMarks.Columns.Add(dtExam.Rows[t]["examname"].ToString());
                                dtMarks.Columns.Add("Marks Obtained II");
                                dtMarks.Columns.Add("Grade II");
                            }
                            else if (ResultTerm == 3)
                            {
                                t = 11;
                                dtMarks.Columns.Add(dtExam.Rows[t]["examname"].ToString());
                                dtMarks.Columns.Add("Marks Obtained III");
                                dtMarks.Columns.Add("Grade III");
                            }
                        }
                        else
                        {
                            if (ResultTerm == 1)
                            {
                                p = 0;
                                q = 1; //4
                            }
                            else if (ResultTerm == 2)
                            {
                                p = 4;
                                q = 8;
                            }
                            else if (ResultTerm == 3)
                            {
                                p = 8;
                                q = 12;
                            }
                        }
                    }
                    for (int i = p; i < q; i++)
                    {
                        dtMarks.Columns.Add(dtExam.Rows[i]["examname"].ToString().ToUpper());
                    }
                    if (ResultTerm == 1)
                    {
                        //dtMarks.Columns.Add("Marks Obtained I");
                        //dtMarks.Columns.Add("Grade I");
                    }
                    else if (ResultTerm == 2)
                    {
                        dtMarks.Columns.Add("Marks Obtained II");
                        dtMarks.Columns.Add("Grade II");
                    }
                    else if (ResultTerm == 3)
                    {
                        dtMarks.Columns.Add("Marks Obtained III");
                        dtMarks.Columns.Add("Grade III");
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
                            //for (int c = dtMarks.Columns.Count-1; c > 6; c--)
                            //{
                            //    dtMarks.Columns.RemoveAt(c);
                            //}
                            string Marks = "0", GradeValue = "";

                            ExamName = dtMarks.Columns[b].ColumnName.ToString();
                            if (ExamName.Trim() == ("Marks Obtained I").ToString() || ExamName.Trim() == ("Marks Obtained II").ToString() || ExamName.Trim() == ("Marks Obtained III").ToString())
                            {
                                if (ResultType.Value != "0")
                                {
                                    dtMarks.Rows[a][b] = (Convert.ToDecimal(dtMarks.Rows[a][1]));
                                }
                                else
                                {
                                    dtMarks.Rows[a][b] = (Convert.ToDecimal(dtMarks.Rows[a][1]) + Convert.ToDecimal(dtMarks.Rows[a][2]) + Convert.ToDecimal(dtMarks.Rows[a][3]) + Convert.ToDecimal(dtMarks.Rows[a][4])).ToString();
                                }
                            }
                            else if (ExamName.Trim() == ("Grade I").Trim() || ExamName.Trim() == ("Grade II").Trim() || ExamName.Trim() == ("Grade III").Trim())
                            {
                                string Grade = "";
                                decimal TotalMarks = 0;
                                if (ResultType.Value != "0")
                                {
                                    TotalMarks = Convert.ToDecimal(dtMarks.Rows[a][1]);
                                }
                                else
                                {
                                    TotalMarks = Convert.ToDecimal(dtMarks.Rows[a][1]) + Convert.ToDecimal(dtMarks.Rows[a][2]) + Convert.ToDecimal(dtMarks.Rows[a][3]) + Convert.ToDecimal(dtMarks.Rows[a][4]);
                                }
                                AllSubjectMarks = AllSubjectMarks + TotalMarks;
                                dtMarks.Rows[a][b] = getGrade(TotalMarks, SubjectName).ToString();
                            }
                            //else if (ExamName.Trim() == ("Marks Obtained II").Trim())
                            //{
                            //    dtMarks.Rows[a][b] = (Convert.ToDecimal(dtMarks.Rows[a][7]) + Convert.ToDecimal(dtMarks.Rows[a][8]) + Convert.ToDecimal(dtMarks.Rows[a][9]) + Convert.ToDecimal(dtMarks.Rows[a][10])).ToString();
                            //}
                            //else if (ExamName.Trim() == ("Grade II").Trim())
                            //{
                            //    string d = "d0";
                            //}
                            else
                            {
                                string strExam1 = "";
                                strExam1 = "Select ISNULL(exam_name.eid,0) from exam_class " +
                                       " INNER join exam_name on exam_class.examid=exam_name.eid where exam_name.brid=" + Convert.ToInt32(Session["BrBrid"]) + " and exam_class.status=1 " +
                                       " and exam_class.classid=" + ClassID + " and examname='" + ExamName + "'";
                                //inner join exam_class on exam_class.examid = exam_name.eid
                                ExamID = (int)(ObjDut.GetScalar(strExam1));
                                if (SubjectID > 0 && ExamID > 0)
                                {
                                    string strMarks = @"Select ISnull(marks,'0') marks,ISNULL(Grade,'') Grade,IsGrade
                                                        from tbl_marks_master where sectionid=" + SectionID + " and examid=" + ExamID +
                                                        " and classid=" + ClassID + " and subjectid=" + SubjectID + " and studentregno=" + eid + "";

                                    DataTable dtMarksDT = ObjDut.GetDataTable(strMarks);
                                    if (dtMarksDT.Rows.Count > 0)
                                    {
                                        string markss = "", Gradee = "";
                                        var IsGrade = 0;
                                        markss = Convert.ToString(dtMarksDT.Rows[0]["marks"]);
                                        Gradee = Convert.ToString(dtMarksDT.Rows[0]["Grade"]);
                                        //IsGrade = Convert.ToInt32(dtMarksDT.Rows[0]["IsGrade"]);
										if (string.IsNullOrWhiteSpace(Convert.ToString(dtMarksDT.Rows[0]["IsGrade"])))
                                        {
                                            IsGrade = IsGradeed;
                                        }
                                        else
                                        {
                                            IsGrade = Convert.ToInt32(dtMarksDT.Rows[0]["IsGrade"]);
                                        }
                                        if (IsGrade > 0)
                                        {
                                            dtMarks.Rows[a][b] = Gradee.ToString();
                                        }
                                        else
                                        {
                                            dtMarks.Rows[a][b] = markss.ToString();
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
                    }
                    //Building an HTML string.
                    StringBuilder html = new StringBuilder();
                    //Table start.
                    html.Append("<table border = '1' Style='width: 100%; font-size: 12px;'>");
                    //Building the Header row.
                    html.Append("<tr>");
                    html.Append("<th style='Width:50%; text-align: center; font-size: 12px;font-weight:bold; line-height: 30px;'>");
                    html.Append("");
                    html.Append("</th>");
                    html.Append("<th style='Width:84px; text-align: center; font-size: 12px;font-weight:bold; line-height: 30px;'>");
                    html.Append("Unit Test I");
                    html.Append("<br/>20</th>");

                    html.Append("<th style='Width:84px; text-align: center; font-size: 12px;font-weight:bold; line-height: 30px;'>");
                    html.Append("Half Yearly");
                    html.Append("<br/>80</th>");

                    html.Append("<th style='Width:84px; text-align: center; font-size: 12px;font-weight:bold; line-height: 30px;'>");
                    html.Append("Total");
                    //html.Append("<br/>100</th>");
                    //html.Append("<th style='Width:84px; text-align: center; font-size: 12px;font-weight:bold; line-height: 30px;'>");
                    //html.Append("Unit Test II");
                    //html.Append("<br/>20</th>");

                    //html.Append("<th style='Width:84px; text-align: center; font-size: 12px;font-weight:bold; line-height: 30px;'>");
                    //html.Append("Annual");
                    //html.Append("<br/>80</th>");

                    //html.Append("<th style='Width:84px; text-align: center; font-size: 12px;font-weight:bold; line-height: 30px;'>");
                    //html.Append("Total");
                    //html.Append("<br/>100</th>");

                    html.Append("</tr>");
                    //Building the Data rows.
                    int total1 = 0, total2 = 0, total3 = 0, total4 = 0, total5 = 0, total6 = 0;
                    foreach (DataRow row in dtMarks.Rows)
                    {
                        html.Append("<tr>");
                        int a = 1;
                        foreach (DataColumn column in dtMarks.Columns)
                        {
                            if (column.ColumnName.ToUpper() == "SUBJECT NAME")
                            {
                                html.Append("<td style='font-size: 14px; line-height: 20px;font-weight:bold; text-align: left;'>");
                            }
                            else
                            {
                                html.Append("<td style='font-size: 14px; line-height: 20px; text-align: center;'>");
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
                            if (dtMarks.Columns.Count < 7 || a == 2)
                            {
                                string finalMarks = "";
                                if (a == 2)
                                {                             
                                    var IsGrade = Convert.ToInt32(row[0].ToString().Split('_')[1]);
                                    if (IsGrade > 0)
                                    {
                                        finalMarks = Convert.ToString(row[1]);
                                    }
                                    else
                                    {
                                        int marks1 = 0, marks2 = 0;
                                        int.TryParse(Convert.ToString(row[1]), out marks1);
                                        total1 = total1 + marks1;
                                        //int.TryParse(Convert.ToString(row[2]), out marks2);
                                        //total2 = total2 + marks2;
                                        finalMarks = (marks1 + marks2).ToString();
                                        total3 = total3 + Convert.ToInt32(finalMarks);
                                    }
                                }
                                //else
                                //{
                                //    html.Append("<td style='font-size: 14px; line-height: 20px; text-align: center;'>");
                                //    html.Append(finalMarks);
                                //    html.Append("</td>");
                                //}
                            }
                            if (dtMarks.Columns.Count < 7 && a == 5)
                            {
                                string finalMarks = "";
                                var IsGrade = Convert.ToInt32(row[0].ToString().Split('_')[1]);
                                if (IsGrade > 0)
                                {
                                    finalMarks = Convert.ToString(row[4]);
                                }
                                else
                                {
                                   int marks1 = 0, marks2 = 0;
                                    int.TryParse(Convert.ToString(row[3]), out marks1);
                                   total4 = total4 + marks1;
                                  //  int.TryParse(Convert.ToString(row[4]), out marks2);
                                  //  total5 = total5 + marks2;
                                  //  finalMarks = (marks1 + marks2).ToString();
                                  //  total6 = total6 + Convert.ToInt32(finalMarks);
                                }
                                html.Append("<td style='font-size: 14px; line-height: 20px; text-align: center;'>");
                                html.Append(finalMarks);
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
                            html.Append("<td style='font-size: 18px; line-height: 20px;font-weight:bold; text-align: left;'>");
                            html.Append("TOTAL");
                            html.Append("</td>");
                        }
                        else
                        {


                        }


                    }


                    for (int i = 0; i < 1; i++)
                    {
                        html.Append("<td style='font-size: 14px; line-height: 20px; text-align: center;'>");
                        if (i == 0)
                        {
                            html.Append(total3.ToString());
                        }
                        //if (i == 1)
                        //{
                        //    html.Append(total2.ToString());
                        //}
                        //if (i == 2)
                        //{
                        //    html.Append(total3.ToString());
                        //}
                        //if (i == 3)
                        //{
                        //    html.Append(total4.ToString());
                        //}
                        //if (i == 4)
                        //{
                        //    html.Append(total5.ToString());
                        //}
                        //if (i == 5)
                        //{
                        //    html.Append(total6.ToString());
                        //}
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

                    string ranksection = "";
                    try
                    {
                        ranksection = ObjDut.GetScalar("select _rank from (select studentregno,sum(marks) as totalMarks, RANK () OVER (  ORDER BY sum(marks) DESC  ) _rank  from tbl_marks_master where classid=" + ClassID + " and sectionid=" + SectionID + " and fyid=" + fyid + " and brid=" + Convert.ToInt32(Session["BrBrid"]) + "   group by studentregno ) t where t.studentregno='" + eid + "'").ToString();
                    }
                    catch (Exception ex)
                    {

                    }
                    // html.Append("<tr>");
                    //int z = 0;
                    // foreach (DataColumn column in dtMarks.Columns)
                    // {


                    //     if (column.ColumnName.ToUpper() == "SUBJECT NAME")
                    //     {
                    //         html.Append("<td style='font-size: 14px; line-height: 20px;font-weight:bold; text-align: left;'>");
                    //         html.Append("Rank in class");
                    //     }
                    //     else
                    //     {
                    //         html.Append("<td style='font-size: 14px; line-height: 20px; text-align: center;'>");
                    //         if (z == 3)
                    //             html.Append(rank);
                    //         else
                    //             html.Append("");
                    //     }
                    //     z++;
                    //     html.Append("</td>");
                    // }
                    // if (dtMarks.Columns.Count<7)
                    //     {
                    //         for (int i = 0; i < 7 - dtMarks.Columns.Count; i++)
                    //         {
                    //             html.Append("<td style='font-size: 14px; line-height: 20px; text-align: center;'>");
                    //             if (i == 1)
                    //                 html.Append(rank);
                    //             else
                    //                 html.Append("");
                    //             html.Append("</td>");
                    //         }
                    //     }
                    // html.Append("</tr>");
                    html.Append("<tr>");
                    int y = 0;
                    foreach (DataColumn column in dtMarks.Columns)
                    {
                        if (column.ColumnName.ToUpper() == "SUBJECT NAME")
                        {
                           // html.Append("<td style='font-size: 14px; line-height: 20px;font-weight:bold; text-align: left;'>");
                          //  html.Append("Rank");
                        }
                       // else
                        //{
                        //    html.Append("<td style='font-size: 14px; line-height: 20px; text-align: center;'>");
                         //   if (y == 1)
                         //      html.Append(ranksection);
                         //   else
                          //      html.Append("");
                        //}
                        //if (y == 1)
                        //    break;
                        //y++;
                      //  html.Append("</td>");
                    }
                    //if (dtMarks.Columns.Count < 7)
                    //{
                    //    for (int i = 0; i < 7 - dtMarks.Columns.Count; i++)
                    //    {
                    //        html.Append("<td style='font-size: 14px; line-height: 20px; text-align: center;'>");
                    //        if (i == 1)
                    //            html.Append(ranksection);
                    //        else
                    //            html.Append("");
                    //        html.Append("</td>");
                    //        if (i == 1)
                    //            break;
                    //    }
                    //}
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
                                var value = Convert.ToString(dr.ItemArray[1]);
                                if (!string.IsNullOrWhiteSpace(value))
                                {
                                    var isNumeric = !string.IsNullOrEmpty(value) && value.All(Char.IsDigit);
                                    if (isNumeric)
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

                    string grade = getGrade(percent, "all");
                    foreach (DataColumn column in dtMarks.Columns)
                    {

                        if (column.ColumnName.ToUpper() == "SUBJECT NAME")
                        {
                            html.Append("<td style='font-size: 14px; line-height: 20px;font-weight:bold; text-align: left;'>");
                            html.Append("Percentage");
                            html.Append("</td>");
                        }


                    }

                    for (int i = 0; i < 1; i++)
                    {
                        if (i == 0)
                        {
                            html.Append("<td style='font-size: 14px; line-height: 20px; text-align: center;'>");
                            html.Append(percent3.ToString() + "%");
                            html.Append("</td>");
                        }
                        //else if (i == 1)
                        //{
                        //    html.Append("<td style='font-size: 14px; line-height: 20px; text-align: center;'>");
                        //    html.Append(percent4.ToString() + "%");
                        //    html.Append("</td>");
                        //}
                        //else if (i == 2)
                        //{
                        //    html.Append("<td style='font-size: 14px; line-height: 20px; text-align: center;'>");
                        //    html.Append(percent1.ToString() + "%");
                        //    html.Append("</td>");
                        //}
                        //else if (i == 3)
                        //{
                        //    html.Append("<td style='font-size: 14px; line-height: 20px; text-align: center;'>");
                        //    html.Append(percent5.ToString() + "%");
                        //    html.Append("</td>");
                        //}
                        //else if (i == 4)
                        //{
                        //    html.Append("<td style='font-size: 14px; line-height: 20px; text-align: center;'>");
                        //    html.Append(percent6.ToString() + "%");
                        //    html.Append("</td>");
                        //}
                        //else if (i == 5)
                        //{
                        //    html.Append("<td style='font-size: 14px; line-height: 20px;font-weight:bold; text-align: center;'>");
                        //    html.Append(percent2.ToString() + "%");
                        //    html.Append("</td>");
                        //}
                        //else
                        //{
                        //    html.Append("<td style='font-size: 14px; line-height: 20px; text-align: center;'>");
                        //    html.Append("");
                        //    html.Append("</td>");
                        //}

                    }

                    html.Append("</tr>");

                    html.Append("<tr>");
                    foreach (DataColumn column in dtMarks.Columns)
                    {

                        if (column.ColumnName.ToUpper() == "SUBJECT NAME")
                        {
                            html.Append("<td style='font-size: 14px; line-height: 20px;font-weight:bold; text-align: left;'>");
                            html.Append("Attendance");
                        }
                        //else
                        //{
                        //    html.Append("<td style='font-size: 14px; line-height: 20px; text-align: center;'>");
                        //    html.Append("");
                        //}

                        html.Append("</td>");
                    }
                    if (dtMarks.Columns.Count < 7)
                    {
                        for (int i = 0; i < 1; i++)
                        {
                            html.Append("<td style='font-size: 12px; line-height: 20px; text-align: center;'>");
                            html.Append("");
                            html.Append("</td>");
                        }
                    }
                    html.Append("</tr>");
                    html.Append("</table>");
                    //html.Append("<table  Style='width: 100%; font-size: 10px;margin-bottom: -27px;border: 0px;' >");
                    //html.Append("<tr>");
                    //int c = 1;
                    //foreach (DataColumn column in dtMarks.Columns)
                    //{
                    //    html.Append("<td style='font-size: 12px; line-height: 20px; text-align: center;border:0px !important;font-weight:bold !important'>");
                    //    if (c == dtMarks.Columns.Count-2)
                    //    {
                    //        html.Append("Total:");
                    //    }
                    //    else if (c == dtMarks.Columns.Count - 1)
                    //    {
                    //        html.Append(AllSubjectMarks.ToString());
                    //    }
                    //    else 
                    //    {
                    //        html.Append("                 ");
                    //    }
                    //    html.Append("</td>");
                    //    c++;
                    //}
                    //html.Append("</tr>");
                    //html.Append("</table>");
                    //Table end.

                    //spnPercent.InnerHtml = percent.ToString("0.##")+"%"+"/"+grade;
                    //spnRank.InnerHtml = ObjDut.GetScalar("select _rank from (select studentregno,sum(marks) as totalMarks, RANK () OVER (  ORDER BY sum(marks) DESC  ) _rank  from tbl_marks_master where classid=" + ClassID + " and fyid=" + fyid + " and brid=" + Convert.ToInt32(Session["BrBrid"]) + "   group by studentregno ) t where t.studentregno='"+eid+"'").ToString();
                    //string strText = html.ToString();
                    ////Append the HTML string to Placeholder.
                    placeholder.Controls.Add(new Literal { Text = html.ToString() });
                }
            }
        }
    }
    private string getGrade(decimal TotalMarks, string SubjectName)
    {
        string Grade = "";
        if (SubjectName.ToLower() == "general knowledge" || SubjectName.ToLower() == "drawing" || SubjectName.ToLower() == "mv")
        {
            if (TotalMarks <= 17)
            {
                Grade = "E";
            }
            else if (TotalMarks > 17 && TotalMarks < 21)
            {
                Grade = "D";
            }

            else if (TotalMarks > 20 && TotalMarks < 26)
            {
                Grade = "C1";
            }
            else if (TotalMarks > 25 && TotalMarks < 31)
            {
                Grade = "B2";
            }
            else if (TotalMarks > 30 && TotalMarks < 41)
            {
                Grade = "B1";
            }
            else if (TotalMarks > 40 && TotalMarks < 44)
            {
                Grade = "A2";
            }
            else if (TotalMarks > 45 && TotalMarks < 51)
            {
                Grade = "A1";
            }
        }
        else
        {
            if (TotalMarks <= 32)
            {
                Grade = "E";
            }
            else if (TotalMarks > 32 && TotalMarks < 41)
            {
                Grade = "D";
            }
            else if (TotalMarks > 40 && TotalMarks < 51)
            {
                Grade = "C2";
            }
            else if (TotalMarks > 50 && TotalMarks < 61)
            {
                Grade = "C1";
            }
            else if (TotalMarks > 60 && TotalMarks < 71)
            {
                Grade = "B2";
            }
            else if (TotalMarks > 70 && TotalMarks < 81)
            {
                Grade = "B1";
            }
            else if (TotalMarks > 80 && TotalMarks < 91)
            {
                Grade = "A2";
            }
            else if (TotalMarks > 90 && TotalMarks < 101)
            {
                Grade = "A1";
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
           // HtmlGenericControl SpanRank = (HtmlGenericControl)e.Row.FindControl("SpanRank");

            Image Image2 = (Image)e.Row.FindControl("Image2");
            Image Image1 = (Image)e.Row.FindControl("Image1");

            if (dfregno.Value != null)
            {
                getrecieptgenraldetails(SSAddress, SpScool, SAddress, SpFone, SMobile, SEmailID, SchoolAffia, affhead, SWebsite, Image1);
                //affhead.InnerText = "Affiliation No:";
                BindPersonalInfo(Convert.ToInt32(dfregno.Value), RollNoA, dfrollno.Value.ToString(), RollNo, classID, DOB, sectionID, SpName, SpMName, SpFName, Image2);
                //ExamMarks(Convert.ToInt32(dfregno.Value), placeholder, spnPercent, SpanRank);
				 ExamMarks(Convert.ToInt32(dfregno.Value), placeholder, spnPercent);
                BindCoSc(Convert.ToInt32(dfregno.Value), spWorkI, SpPhyI, SpArtI, SpDisI);

                int ResultTerm = Convert.ToInt32(dtReg.Rows[0]["ResultTerm"]);
                if (ResultTerm == 1)
                {
                    // SpTerm.InnerText = "Term - I ( 100 Marks )";
                }
                else if (ResultTerm == 2)
                {
                    SpTerm.InnerText = "Term - II ( 100 Marks )";
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