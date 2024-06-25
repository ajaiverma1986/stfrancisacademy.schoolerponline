using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HO_classteachermaster1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!string.IsNullOrWhiteSpace(Convert.ToString(HttpContext.Current.Session["BrBrid"])))
            {
                hfBrid.Value = Convert.ToString(HttpContext.Current.Session["BrBrid"]);
            }
            else
            {
                hfBrid.Value = "0";
            }
        }
    }

    [WebMethod]
    public static List<Teachers> BindTeacherList(int Brid)
    {
        DataSet ds = new DataSet();
        List<Teachers> teachers = new List<Teachers>();
        DataUtility objut = new DataUtility();
        string strTeacher = @"select sm.eid,sm.fName as EmpName from tblEmp_Master sm where status=1 and branchID=" + Brid + " order by fName";      
        ds = objut.GetDataSet(strTeacher);
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                Teachers teacher = new Teachers();
                teacher.Eid = Convert.ToInt32(ds.Tables[0].Rows[i]["eid"]);
                teacher.EmpName = Convert.ToString(ds.Tables[0].Rows[i]["EmpName"]);
                teachers.Add(teacher);
            }
        }
        return teachers.ToList();
    }
    [WebMethod]
    public static List<Subjects> BindSubjectList(int Brid, int Fyid, int Classid, int Sectionid, int Eid)
    {
        DataSet ds = new DataSet();
        List<Subjects> subjects = new List<Subjects>();
        DataUtility objut = new DataUtility();
        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@eid", Eid);
        param[1] = new SqlParameter("@classid", Classid);
        param[2] = new SqlParameter("@sectionid", Sectionid);
        param[3] = new SqlParameter("@brid", Convert.ToString(Brid));
        param[4] = new SqlParameter("@Fyid", Convert.ToInt32(Fyid));
        ds = objut.GetDataSetSP(param, "usp_SubjectToTeacherList");
        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                Subjects subject = new Subjects();
                subject.SubjectId = Convert.ToInt32(ds.Tables[0].Rows[i]["SubjectID"]);
                subject.SubName = Convert.ToString(ds.Tables[0].Rows[i]["SubjectName"]);
                subject.Status = Convert.ToBoolean(ds.Tables[0].Rows[i]["Status"]);
                subjects.Add(subject);
            }
        }
        return subjects.ToList();
    }
    [WebMethod]
    public static int SaveOrUpdateSubjectToTeacher(int Brid, int Fyid, int Classid, int Sectionid, int Eid, string SubjectID, string Status)
    {
        int result = 0;
        DataUtility objut = new DataUtility();
        int Count = 0; 
        if (!string.IsNullOrWhiteSpace(SubjectID) && !string.IsNullOrWhiteSpace(Status))
        {
            var AllSubjectID = SubjectID.Split('~');
            var AllStatus = Status.Split('~');            
            if (AllSubjectID.Length > 0)
            {
                for (int i = 1; i < AllSubjectID.Length; i++)
                {
                    var strisExisting = @"Select ISNULL(Count(*),0) FROm [tbl_TeacherToClass] 
                    where Brid=" + Brid + " and Fyid=" + Fyid + " and Empid=" + Eid + " and SubjectId=" + AllSubjectID[i] + " " +
                    " and ClassId=" + Classid + " and SectionId=" + Sectionid + "";
                    var isExisting = Convert.ToString(objut.GetScalar(strisExisting));
                    if (!string.IsNullOrWhiteSpace(isExisting))
                    {
                        string strAddOrUpdate = "";
                        if (Convert.ToInt32(isExisting) == 0)
                        {
                            strAddOrUpdate = @"INSERT INTO [tbl_TeacherToClass] (empid,ClassId,SectionId,SubjectId,Fyid,Brid,Status)   
                            VALUES(" + Eid + "," + Classid + "," + Sectionid + "," + AllSubjectID[i] + "," + Fyid + "," + Brid + "," + AllStatus[i] + ")";
                        }
                        else
                        {
                            strAddOrUpdate = @"UPDATE [tbl_TeacherToClass] SET Status=" + AllStatus[i] +
                            " where Brid=" + Brid + " and Fyid=" + Fyid + " and Empid=" + Eid + " and SubjectId=" + AllSubjectID[i] + " " +
                            " and ClassId=" + Classid + " and SectionId=" + Sectionid + "";
                        }
                        result = objut.ExecuteSql(strAddOrUpdate);
                        if (result > 0) {
                            Count = Count + 1;
                        }
                    }
                }
                if (Count == (AllStatus.Length - 1)) {
                    result = 1;
                }
            }
        }        
        return result;
    }
}
public class Teachers
{
    public int Eid { set; get; }
    public string EmpName { set; get; }
}

public class Subjects
{
    public int SubjectId { set; get; }
    public string SubName { set; get; }
    public bool Status { set; get; }
}