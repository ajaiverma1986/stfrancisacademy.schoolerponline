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

public partial class BranchPanel_Exams_AdmitCard : System.Web.UI.Page
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
                Image1.ImageUrl = "~/images/" + getbranchdata[7].ToString();
            }
            else
            {
                Image1.ImageUrl = "~/images/9update.png";
            }
        }
    }
    private void BindPersonalInfo(int eid, HtmlGenericControl RollNoA, string dfrollno, HtmlGenericControl RollNo, HtmlGenericControl classID, HtmlGenericControl DOB, HtmlGenericControl sectionID, HtmlGenericControl SpName, HtmlGenericControl SpMName, HtmlGenericControl SpFName, Image Image2, HtmlGenericControl SpanAddr, HtmlGenericControl SpanMob)
    {
        string strPer = @"Select distinct SR.fyid,SR.RID,SR.StudentPhotograph,SR.Registration_No,SR.StudentFirstName+' '+SR.StudentMiddleName+' '+StudentLastName as StdName,
                            SR.PrimaryParentFirstName+' '+SR.PrimaryParentMiddleName+' '+PrimaryParentLastName as FatherName,
                            SR.SecondaryParentFirstName+' '+SR.SecondaryParentMiddleName+' '+SecondaryParentLastName as MotherName,
                            ISNULL(SR.RegNewNo,0) RegNewNo,SR.StudentDOB,SA.ClassID,Class_Master.Classname,SA.SectionId, sr.Address+' '+sr.city+ ' '+ sr.state as addr, Primarymobileno from tbl_StudentRegistration SR 
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
            SpanAddr.InnerText = dtPerInfo.Rows[0]["addr"].ToString();
            SpanMob.InnerText = dtPerInfo.Rows[0]["Primarymobileno"].ToString();

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
            HtmlGenericControl SpanMob = (HtmlGenericControl)e.Row.FindControl("SpanMob");
            HtmlGenericControl SpanAddr = (HtmlGenericControl)e.Row.FindControl("SpanAddr");
            HtmlGenericControl SpanFrom = (HtmlGenericControl)e.Row.FindControl("SpanFrom");
            HtmlGenericControl SpanTo = (HtmlGenericControl)e.Row.FindControl("SpanTo");
            HtmlTableCell tdExams = (HtmlTableCell)e.Row.FindControl("tdExams");
            HiddenField hdnClass = (HiddenField)e.Row.FindControl("hdnClass");
            HiddenField hdnSection = (HiddenField)e.Row.FindControl("hdnSection");
            HiddenField hdnTerm = (HiddenField)e.Row.FindControl("hdnTerm");
            Image Image2 = (Image)e.Row.FindControl("Image2");
            Image Image1 = (Image)e.Row.FindControl("Image1");
            string strSubject = " select t.*,s.SubjectName from tbl_ExamTime t inner join Subject_Master s on t.SubjectId=s.id where t.classid=" + hdnClass.Value + " and t.SectionId=" + hdnSection.Value + " and t.TermId=" + hdnTerm.Value+ " order by ExamDate";
                                
            DataTable dtSubject = ObjDut.GetDataTable(strSubject);

            if(dtSubject!=null && dtSubject.Rows.Count>0)
            {
                string subhtml = "<table style='width:100%'><tr style='font-weight:bold'><td>Subject</td><td>Date</td><td>Day</td><td>Start Time</td><td>EndTime</td></tr>";
                foreach(DataRow dr in dtSubject.Rows)
                {
                    subhtml = subhtml + "<tr><td>" + Convert.ToString(dr["subjectName"]) + "</td>" + "<td>" + Convert.ToDateTime(dr["ExamDate"]).ToString("dd-MM-yyyy") + "</td>" + "<td>" + Convert.ToString(dr["ExamDay"]) + "</td>";
                    subhtml = subhtml + "<td>" + Convert.ToString(dr["fromtime"]) + "</td>" + "<td>" + Convert.ToString(dr["totime"]) + "</td>" + "</tr>";

                }
                subhtml = subhtml + "</table>";
                tdExams.InnerHtml = subhtml;
            }
            
            if (dfregno.Value != null)
            {
                SpanFrom.InnerText = Convert.ToString(Session["AdmitFromDate"]);
                SpanTo.InnerText = Convert.ToString(Session["AdmitToDate"]);
                getrecieptgenraldetails(SSAddress, SpScool, SAddress, SpFone, SMobile, SEmailID, SchoolAffia, affhead, SWebsite, Image1);
                //affhead.InnerText = "Affiliation No:";
                BindPersonalInfo(Convert.ToInt32(dfregno.Value), RollNoA, dfrollno.Value.ToString(), RollNo, classID, DOB, sectionID, SpName, SpMName, SpFName, Image2,SpanAddr,SpanMob);
               // ExamMarks(Convert.ToInt32(dfregno.Value), placeholder);
                //BindCoSc(Convert.ToInt32(dfregno.Value), spWorkI, SpPhyI, SpArtI, SpDisI);

                //int ResultTerm = Convert.ToInt32(dtReg.Rows[0]["ResultTerm"]);
                //if (ResultTerm == 1)
                //{
                //    SpTerm.InnerText = "Term - I ( 100 Marks )";
                //}
                //else if (ResultTerm == 2)
                //{
                //    SpTerm.InnerText = "Term - II ( 100 Marks )";
                //}
                //else if (ResultTerm == 3)
                //{
                //    SpTerm.InnerText = "Term - III ( 100 Marks )";
                //}
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