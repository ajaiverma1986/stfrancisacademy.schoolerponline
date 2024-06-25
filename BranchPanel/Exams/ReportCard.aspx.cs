using System;
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

public partial class BranchPanel_Exams_ReportCard : System.Web.UI.Page
{
    DataUtility ObjDut = new DataUtility();
    DataTable dtPerInfo;
    DataTable dtExam;
    DataTable dtReg;
    DataTable dtSubject;
    DataTable dtMarks;
    int eid = 0;
    int fyid = 0;
    int ClassID = 0;
    int SectionID = 0;
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
        //if (Request.QueryString["regno"] != null)
        //{
        //    eid = Convert.ToInt32(Request.QueryString["regno"]);
        //    if (eid > 0)
        //    {
        //        affhead.InnerText = "Affiliation No:";
        //        BindPersonalInfo(eid);
        //        ExamMarks(eid);
        //        getrecieptgenraldetails();
        //        BindCoSc();
        //    }
        //}
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
                Image1.ImageUrl = "~/BranchPanel/images/" + getbranchdata[7].ToString();
            }
            else
            {
                Image1.ImageUrl = "~/BranchPanel/images/9update.png";
            }
        }
    }
    private void BindPersonalInfo(int eid, HtmlGenericControl RollNoA, string dfrollno, HtmlGenericControl RollNo, HtmlGenericControl classID, HtmlGenericControl SpClasss, HtmlGenericControl sectionID, HtmlGenericControl DOB, HtmlGenericControl SpName, HtmlGenericControl SpMName, HtmlGenericControl SpFName, Image Image2)
    {
        string strPer = @"Select DISTINCT SR.fyid,SR.RID,SR.StudentPhotograph,SR.Registration_No,SR.StudentFirstName+' '+SR.StudentMiddleName+' '+StudentLastName as StdName,
                                ISNULL(mst_RresultToClass.Status,0) Status,SR.PrimaryParentFirstName+' '+SR.PrimaryParentMiddleName+' '+PrimaryParentLastName as FatherName,
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
            if (dtPerInfo.Rows.Count > 0)
            {
                if (dfrollno != "")
                {
                    RollNo.InnerText = dfrollno.ToString();
                }
                else
                {
                    RollNo.InnerText = dtPerInfo.Rows[0]["RegNewNo"].ToString();
                }  
                classID.InnerText = dtPerInfo.Rows[0]["Classname"].ToString();
                //SpClasss.InnerText = classID.InnerText;
                SectionID = Convert.ToInt32(dtPerInfo.Rows[0]["SectionId"]);
                DOB.InnerText = Convert.ToDateTime(dtPerInfo.Rows[0]["StudentDOB"]).ToString("dd MMM yyyy");
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
                else
                {
                    ResultType.Value = ValueResult.ToString();
                }
            }
        }
    }
    private void ExamMarks(int eid, PlaceHolder placeholder, HtmlTableCell td1, HtmlTableCell td2, HtmlTableCell td4, HtmlTableCell td5)
    {
        int mm = 0, ResultTerm = 0;
        string strExam = "";
        string strSub = "";
        ResultTerm = Convert.ToInt32(dtReg.Rows[0]["ResultTerm"]);
        //                inner join exam_class on exam_class.examid = exam_name.eid
        dtExam = new DataTable();
        strExam = "Select DISTINCT exam_name.eid AS id,examname,examcode from exam_class " +
                   " INNER join exam_name on exam_class.examid=exam_name.eid where exam_name.brid=" + Convert.ToInt32(Session["BrBrid"]) + " and exam_class.status=1 " +
                   " and exam_class.classid=" + ClassID + "order by id asc";
        //where status=1 and exam_name.brid=" + Convert.ToInt32(Session["BrBrid"]);// +" and exam_class.classid=" + ClassID + "";
        dtExam = ObjDut.GetDataTable(strExam);
        if (ResultTerm == 4)
        {
            td4.Visible = false;
            td1.Style.Add("Width", "8.6%");
            td2.Style.Add("Width", "24.5%");
            td5.Style.Add("Width", "4%");
            if (ResultType.Value == "1")
            {
                mm = 1;
            }
            else
            {
                mm = 7;
            }
        }
        else
        {
            td1.Style.Add("Width", "13.4%");
            td2.Style.Add("Width", "25.4%");
            td5.Style.Add("Width", "10%");
            td4.Visible = true;
            if (ResultType.Value == "1")
            {
                mm = 1;
            }
            else
            {
                mm = 11;
            }
        }
        if (dtExam.Rows.Count > mm)
        {
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
                    dtMarks.Columns.Add("SUBJECT NAME");
                    if (ResultType.Value == "1")
                    {
                        dtMarks.Columns.Add(dtExam.Rows[3]["examcode"].ToString());
                        dtMarks.Columns.Add("Marks Obtained I");
                        dtMarks.Columns.Add("Grade I");

                        dtMarks.Columns.Add(dtExam.Rows[7]["examcode"].ToString());
                        dtMarks.Columns.Add("Marks Obtained II");
                        dtMarks.Columns.Add("Grade II");

                        dtMarks.Columns.Add(dtExam.Rows[7]["examcode"].ToString());
                        dtMarks.Columns.Add("Marks Obtained III");
                        dtMarks.Columns.Add("Grade III");
                    }
                    else
                    {
                        for (int i = 0; i <= mm; i++)
                        {
                            if (i == 4)
                            {
                                dtMarks.Columns.Add("MO I");
                                dtMarks.Columns.Add("GR I");
                                dtMarks.Columns.Add(dtExam.Rows[i]["examcode"].ToString());
                            }
                            else if (i == 7)
                            {
                                dtMarks.Columns.Add(dtExam.Rows[i]["examcode"].ToString());
                                dtMarks.Columns.Add("MO II");
                                dtMarks.Columns.Add("GR II");
                            }
                            else if (i == 11)
                            {
                                dtMarks.Columns.Add(dtExam.Rows[i]["examcode"].ToString());
                                dtMarks.Columns.Add("MO III");
                                dtMarks.Columns.Add("GR III");
                            }
                            else
                            {
                                dtMarks.Columns.Add(dtExam.Rows[i]["examcode"].ToString().ToUpper());
                            }
                        }
                    }

                }
                dtMarks.Columns.Add(". Total ");
                for (int a = 0; a < dtSubject.Rows.Count; a++)
                {
                    DataRow dr = dtMarks.NewRow();
                    dr["SUBJECT NAME"] = dtSubject.Rows[a]["SubjectName"];
                    dtMarks.Rows.Add(dr);
                    dtMarks.AcceptChanges();
                }
                if (dtMarks.Rows.Count > 0)
                {                    
                    string ExamCode = "";
                    string SubjectName = "";
                    int ExamID = 0;
                    int SubjectID = 0;
                    for (int a = 0; a < dtMarks.Rows.Count; a++)
                    {
                        SubjectName = dtMarks.Rows[a][0].ToString();
                        SubjectID = (int)(ObjDut.GetScalar("Select ISNULL(SM.id,0) subjectid from Subject_Master SM " +
                                   " INNER JOIN SubjectBranch_master SBM on SM.id = SBM.Subjectid where SBM.BranchId=" + Convert.ToInt32(Session["BrBrid"]) + "" +
                                   " and SBM.classid=" + ClassID + " and SM.subjectname ='" + SubjectName + "' order by SM.id asc"));
                        int TtlMarks = 0;
                        for (int b = 1; b < dtMarks.Columns.Count; b++)
                        {
                            string Marks = "0";

                            ExamCode = dtMarks.Columns[b].ColumnName.ToString();
                            if (ExamCode.Trim() == ("MO I").ToString())
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
                            else if (ExamCode.Trim() == ("GR I").Trim())
                            {
                                decimal TotalMarks = 0;
                                if (ResultType.Value != "0")
                                {
                                    TotalMarks = Convert.ToDecimal(dtMarks.Rows[a][1]);
                                }
                                else
                                {
                                    TotalMarks = Convert.ToDecimal(dtMarks.Rows[a][1]) + Convert.ToDecimal(dtMarks.Rows[a][2]) + Convert.ToDecimal(dtMarks.Rows[a][3]) + Convert.ToDecimal(dtMarks.Rows[a][4]);
                                }
                                dtMarks.Rows[a][b] = getGrade(TotalMarks).ToString();
                            }
                            else if (ExamCode.Trim() == ("MO II").Trim())
                            {
                                if (ResultType.Value != "0")
                                {
                                    dtMarks.Rows[a][b] = (Convert.ToDecimal(dtMarks.Rows[a][10]));
                                }
                                else
                                {
                                    dtMarks.Rows[a][b] = (Convert.ToDecimal(dtMarks.Rows[a][7]) + Convert.ToDecimal(dtMarks.Rows[a][8]) + Convert.ToDecimal(dtMarks.Rows[a][9]) + Convert.ToDecimal(dtMarks.Rows[a][10])).ToString();
                                }
                            }
                            else if (ExamCode.Trim() == ("GR II").Trim())
                            {
                                decimal TotalMarks = 0;
                                if (ResultType.Value != "0")
                                {
                                    TotalMarks = Convert.ToDecimal(dtMarks.Rows[a][10]);
                                }
                                else
                                {
                                    TotalMarks = Convert.ToDecimal(dtMarks.Rows[a][7]) + Convert.ToDecimal(dtMarks.Rows[a][8]) + Convert.ToDecimal(dtMarks.Rows[a][9]) + Convert.ToDecimal(dtMarks.Rows[a][10]);
                                }
                                dtMarks.Rows[a][b] = getGrade(TotalMarks).ToString();
                            }
                            else if (ExamCode.Trim() == ("MO III").Trim())
                            {
                                if (ResultType.Value != "0")
                                {
                                    dtMarks.Rows[a][b] = (Convert.ToDecimal(dtMarks.Rows[a][16]));
                                }
                                else
                                {
                                    dtMarks.Rows[a][b] = (Convert.ToDecimal(dtMarks.Rows[a][13]) + Convert.ToDecimal(dtMarks.Rows[a][14]) + Convert.ToDecimal(dtMarks.Rows[a][15]) + Convert.ToDecimal(dtMarks.Rows[a][16])).ToString();
                                }
                            }
                            else if (ExamCode.Trim() == ("GR III").Trim())
                            {
                                decimal TotalMarks = 0;
                                if (ResultType.Value != "0")
                                {
                                    TotalMarks = Convert.ToDecimal(dtMarks.Rows[a][4]);
                                }
                                else
                                {
                                    TotalMarks = (Convert.ToDecimal(dtMarks.Rows[a][13]) + Convert.ToDecimal(dtMarks.Rows[a][14]) + Convert.ToDecimal(dtMarks.Rows[a][15]) + Convert.ToDecimal(dtMarks.Rows[a][16]));
                                }
                                dtMarks.Rows[a][b] = getGrade(TotalMarks).ToString();
                            }
                            else if (ExamCode.Trim() == (". Total").Trim())
                            {
                                dtMarks.Rows[a][dtMarks.Columns.Count - 1] = TtlMarks.ToString();
                            }
                            else
                            {
                                string strExam1 = "";
                                strExam1 = "Select ISNULL(exam_name.eid,0) from exam_class " +
                                       " INNER join exam_name on exam_class.examid=exam_name.eid where exam_name.brid=" + Convert.ToInt32(Session["BrBrid"]) + " and exam_class.status=1 " +
                                       " and exam_class.classid=" + ClassID + " and ExamCode='" + ExamCode + "'";
                                //inner join exam_class on exam_class.examid = exam_name.eid
                                ExamID = (int)(ObjDut.GetScalar(strExam1));
                                if (SubjectID > 0 && ExamID > 0)
                                {
                                    string strMarks = "Select ISnull(marks,'') marks from tbl_marks_master where examid=" + ExamID + " and classid=" + ClassID + " and subjectid=" + SubjectID + " and studentregno=" + eid + "";
                                    Marks = Convert.ToString(ObjDut.GetScalar(strMarks));
                                    if (Marks == "")
                                    {
                                        Marks = "0";
                                    }
                                    dtMarks.Rows[a][b] = Marks.ToString();
                                    TtlMarks = TtlMarks + Convert.ToInt32(Marks);
                                }
                            }
                        }
                    }
                    //Building an HTML string.
                    StringBuilder html = new StringBuilder();
                    //Table start.
                    html.Append("<table border = '1' Style='width: 100%; font-size: 10px;'>");
                    //Building the Header row.
                    html.Append("<tr>");
                    foreach (DataColumn column in dtMarks.Columns)
                    {
                        if (column.ColumnName.ToString() == "SUBJECT NAME")
                        {
                            html.Append("<th style='Width:100px; text-align: left; font-size: 12px;'>");
                            html.Append(column.ColumnName);
                            html.Append("</th>");
                        }
                        else
                        {
                            html.Append("<th style='font-size: 10px; width: 0px;'>");
                            html.Append(column.ColumnName.ToString());
                            html.Append("</th>");
                        }
                    }
                    html.Append("</tr>");
                    //Building the Data rows.
                    foreach (DataRow row in dtMarks.Rows)
                    {
                        html.Append("<tr>");
                        foreach (DataColumn column in dtMarks.Columns)
                        {
                            html.Append("<td style='font-size: 12px; line-height: 20px; text-align: center;'>");
                            html.Append(row[column.ColumnName]);
                            html.Append("</td>");
                        }
                        html.Append("</tr>");
                    }
                    //Table end.
                    html.Append("</table>");
                    string strText = html.ToString();
                    ////Append the HTML string to Placeholder.
                    placeholder.Controls.Add(new Literal { Text = html.ToString() });
                }
            }
        }
    }
    private string getGrade(decimal TotalMarks)
    {
        string Grade = "";
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
        return Grade;
    }

    private void BindCoSc(int eid, HtmlGenericControl spWorkI, HtmlGenericControl spWorkII, HtmlGenericControl SpArtI, HtmlGenericControl SpArtII, HtmlGenericControl SpPhyI, HtmlGenericControl SpPhyII, HtmlGenericControl SpDisI, HtmlGenericControl SpDisII)
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
                                else
                                {
                                    spWorkII.InnerText = dtCoDT.Rows[i][ColName].ToString();
                                }
                            }
                            if (ColName == "Art Education")
                            {
                                if (dtCoDT.Rows[i]["examid"].ToString() == "101")
                                {
                                    SpArtI.InnerText = dtCoDT.Rows[i][ColName].ToString();
                                }
                                else
                                {
                                    SpArtII.InnerText = dtCoDT.Rows[i][ColName].ToString();
                                }
                            }
                            if (ColName == "Health & Physical Education")
                            {
                                if (dtCoDT.Rows[i]["examid"].ToString() == "101")
                                {
                                    SpPhyI.InnerText = dtCoDT.Rows[i][ColName].ToString();
                                }
                                else
                                {
                                    SpPhyII.InnerText = dtCoDT.Rows[i][ColName].ToString();
                                }
                            }
                            if (ColName == "Discipline")
                            {
                                if (dtCoDT.Rows[i]["examid"].ToString() == "101")
                                {
                                    SpDisI.InnerText = dtCoDT.Rows[i][ColName].ToString();
                                }
                                else
                                {
                                    SpDisII.InnerText = dtCoDT.Rows[i][ColName].ToString();
                                }
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
            HtmlGenericControl SpClasss = (HtmlGenericControl)e.Row.FindControl("SpClasss");

            HtmlGenericControl sectionID = (HtmlGenericControl)e.Row.FindControl("sectionID");
            HtmlGenericControl DOB = (HtmlGenericControl)e.Row.FindControl("DOB");
            HtmlGenericControl SpName = (HtmlGenericControl)e.Row.FindControl("SpName");
            HtmlGenericControl SpMName = (HtmlGenericControl)e.Row.FindControl("SpMName");
            HtmlGenericControl SpFName = (HtmlGenericControl)e.Row.FindControl("SpFName");
            HtmlGenericControl spWorkI = (HtmlGenericControl)e.Row.FindControl("spWorkI");
            HtmlGenericControl spWorkII = (HtmlGenericControl)e.Row.FindControl("spWorkII");
            HtmlGenericControl SpArtI = (HtmlGenericControl)e.Row.FindControl("SpArtI");
            HtmlGenericControl SpArtII = (HtmlGenericControl)e.Row.FindControl("SpArtII");
            HtmlGenericControl SpPhyI = (HtmlGenericControl)e.Row.FindControl("SpPhyI");
            HtmlGenericControl SpPhyII = (HtmlGenericControl)e.Row.FindControl("SpPhyII");
            PlaceHolder placeholder = (PlaceHolder)e.Row.FindControl("placeholder");

            HtmlTableCell td1 = (HtmlTableCell)e.Row.FindControl("td1");
            HtmlTableCell td2 = (HtmlTableCell)e.Row.FindControl("td2");
            HtmlTableCell td3 = (HtmlTableCell)e.Row.FindControl("td3");
            HtmlTableCell td4 = (HtmlTableCell)e.Row.FindControl("td4");
            HtmlTableCell td5 = (HtmlTableCell)e.Row.FindControl("td5");

            HtmlGenericControl SpDisI = (HtmlGenericControl)e.Row.FindControl("SpDisI");
            HtmlGenericControl SpDisII = (HtmlGenericControl)e.Row.FindControl("SpDisII");
            Image Image2 = (Image)e.Row.FindControl("Image2");
            Image Image1 = (Image)e.Row.FindControl("Image1");


            if (dfregno.Value != null)
            {
                getrecieptgenraldetails(SSAddress, SpScool, SAddress, SpFone, SMobile, SEmailID, SchoolAffia, affhead, SWebsite, Image1);
                //affhead.InnerText = "Affiliation No:";
                BindPersonalInfo(Convert.ToInt32(dfregno.Value), RollNoA, dfrollno.Value.ToString(), RollNo, classID, SpClasss, sectionID, DOB, SpName, SpMName, SpFName, Image2);
                ExamMarks(Convert.ToInt32(dfregno.Value), placeholder, td1, td2, td4, td5);
                BindCoSc(Convert.ToInt32(dfregno.Value), spWorkI, spWorkII, SpArtI, SpArtII, SpPhyI, SpPhyII, SpDisI, SpDisII);
            }
        }
    }
}