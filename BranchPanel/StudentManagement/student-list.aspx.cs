using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;
public partial class BranchPanel_Admission_student_list : System.Web.UI.Page
{
    private Utility Dut = new Utility();
    private DataUtility ObjDut = new DataUtility();
    private CommonClass common = new CommonClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindSessionDDL();
           
        } 
    }
    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlfyear.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlfyear.DataValueField = "Fyid";
        ddlfyear.DataTextField = "FYName";
        ddlfyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    [WebMethod]
    public static BIndClass[] BindClassDDL(string Fyid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(Fyid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        List<BIndClass> BindObj = new List<BIndClass>();
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            BIndClass Obj = new BIndClass();
            Obj.ID = Dt.Rows[i]["classid"].ToString();
            Obj.ClassName = Dt.Rows[i]["Classname"].ToString();
            BindObj.Add(Obj);
        }
        return BindObj.ToArray();
    }
    public class BIndClass
    {
        public string ID { get; set; }
        public string ClassName { get; set; }
    }


    [WebMethod]
    public static StudentList[] GetStudentList(string SectionID, string Fromdate, string Todate, string StudentName, string admissionno, string Registrationnumber, string Parentname, string ParentMobileNo, int Applyingforclass, int Fyid,string pagesize, string pageno)    
    {
        DataSet Ds = new DataSet();
        List<StudentList> details = new List<StudentList>();
        SqlParameter[] param = new SqlParameter[14];
        param[0] = new SqlParameter("@mode", 1);
        param[1] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@FromDate", Fromdate);
        param[3] = new SqlParameter("@ToDate", Todate);
        param[4] = new SqlParameter("@Studentname", StudentName);
        param[5] = new SqlParameter("@admissionno", admissionno);
        param[6] = new SqlParameter("@registrationno", Registrationnumber);
        param[7] = new SqlParameter("@Parentname", Parentname);
        param[8] = new SqlParameter("@ParentMobileNo", ParentMobileNo);
        param[9] = new SqlParameter("@applyingforclass", Applyingforclass);
        param[10] = new SqlParameter("@Fyid", Fyid);
        param[11] = new SqlParameter("@pagesize", pagesize);
        param[12] = new SqlParameter("@pageno", pageno);
        param[13] = new SqlParameter("@SectionID", Convert.ToInt32(SectionID));
        DataUtility ObjDUT = new DataUtility();
        Ds = ObjDUT.GetDataSetSP(param, "[usp_BindStudentList]");
        foreach (DataRow Dtrow in Ds.Tables[0].Rows)
        {
            StudentList user = new StudentList();
            user.photo = Dtrow["photo"].ToString();
            user.studentname = Dtrow["studentname"].ToString();
            user.fathername = Dtrow["FatherName"].ToString();
            user.class_sectionname = Dtrow["class_sectionname"].ToString();
            user.Registration_No = Dtrow["Registration_No"].ToString();
            user.RID = Dtrow["RID"].ToString();
            user.AdmissionNo = Dtrow["AdmissionNo"].ToString();
            user.AdmissionDate = Dtrow["AdmissionDate"].ToString();
            user.StuRegNo = Dtrow["StuRegNo"].ToString();
            user.RegNewNo = Dtrow["RegNewNo"].ToString();
            user.pagecount = Ds.Tables[1].Rows[0]["pages"].ToString(); 
            details.Add(user);
        }
        return details.ToArray();
    }
    public class StudentList
    {
        public string photo { get; set; }
        public string studentname { get; set; }
        public string fathername { get; set; }
        public string class_sectionname { get; set; }
        public string Registration_No { get; set; }
        public string RID { get; set; }
        public string AdmissionNo { get; set; }
        public string AdmissionDate { get; set; }
        public string StuRegNo { get; set; }
        public string pagecount { get; set; }
        public string RegNewNo { get; set; }
    }   
}