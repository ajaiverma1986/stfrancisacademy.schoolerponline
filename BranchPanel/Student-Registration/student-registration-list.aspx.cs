using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Services;
using System.IO;
using System.Web.UI.WebControls;
using System.Web;
public partial class BranchPanel_Student_Registration_student_registration_list : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
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
    public static studentregistration[] BindGridByJs(string SectionID, string Fromdate, string Todate, string Registrationnumber, string StudentName, string Parentname, string ParentMobileNo, int Status, int Applyingforclass, int Fyid, int mode, string Admissionnnumber, string pagesize, string pageno)
    {         

        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        dt.Columns.Add("Fromdate");
        dt.Columns.Add("Todate");
        dt.Columns.Add("Registrationnumber");
        dt.Columns.Add("StudentName");
        dt.Columns.Add("Parentname");
        dt.Columns.Add("ParentMobileNo");
        dt.Columns.Add("status");
        dt.Columns.Add("applyingforclass");
        dt.Columns.Add("Fyid");
        dt.Columns.Add("AdmissionNo");
        dt.Columns.Add("SectionID");
        DataRow dr = dt.NewRow();

        List<studentregistration> details = new List<studentregistration>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_studentregistrationlist]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[15];
                param[0] = new SqlParameter("@mode", mode);
                param[1] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"].ToString());
                param[2] = new SqlParameter("@FromDate", Fromdate);
                param[3] = new SqlParameter("@ToDate", Todate);
                param[4] = new SqlParameter("@registrationno", Registrationnumber);
                param[5] = new SqlParameter("@Studentname", StudentName);
                param[6] = new SqlParameter("@Parentname", Parentname);
                param[7] = new SqlParameter("@ParentMobileNo", ParentMobileNo);
                param[8] = new SqlParameter("@status", Status);
                param[9] = new SqlParameter("@applyingforclass", Applyingforclass);
                param[10] = new SqlParameter("@Fyid", Fyid);
                param[11] = new SqlParameter("@AdmissionNo", Admissionnnumber);
                param[12] = new SqlParameter("@pagesize", pagesize);
                param[13] = new SqlParameter("@pageno", pageno);
                param[14] = new SqlParameter("@SectionID", SectionID);

                //for downnload EXECL ONLy
                dr["Fromdate"] = Fromdate;
                dr["Todate"] = Todate;
                dr["Registrationnumber"] = Registrationnumber;
                dr["StudentName"] = StudentName;
                dr["Parentname"] = Parentname;
                dr["ParentMobileNo"] = ParentMobileNo;
                dr["status"] = Status;
                dr["applyingforclass"] = Applyingforclass;
                dr["Fyid"] = Fyid;
                dr["AdmissionNo"] = Admissionnnumber;
                dr["SectionID"] = SectionID;
                dt.Rows.Add(dr);
                dt.AcceptChanges();
                if (dt.Rows.Count > 0)
                {
                    HttpContext.Current.Session["AdmListFilter"] = dt;
                }
                //END


                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);
                cmd.Parameters.Add(param[6]);
                cmd.Parameters.Add(param[7]);
                cmd.Parameters.Add(param[8]);
                cmd.Parameters.Add(param[9]);
                cmd.Parameters.Add(param[10]);
                cmd.Parameters.Add(param[11]);
                cmd.Parameters.Add(param[12]);
                cmd.Parameters.Add(param[13]);
                cmd.Parameters.Add(param[14]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                 da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        if (mode == 3)
                        {
                            HttpContext.Current.Session["CUSTOMEXCELFORADMISSION"] = ds.Tables[0];
                        }
                        else
                        {
                            HttpContext.Current.Session["CUSTOMEXCELFORADMISSION"] = null;
                        }
                        foreach (DataRow dtrow in ds.Tables[0].Rows)
                        {
                            studentregistration user = new studentregistration();
                            if (mode == 1)
                            {
                                user.RID = dtrow["RID"].ToString();
                                user.RegistrationDate = dtrow["RegistrationDate"].ToString();
                                user.Registration_No = dtrow["Registration_No"].ToString();
                                user.studentname = dtrow["studentname"].ToString();
                                user.Classname = dtrow["Classname"].ToString();
                                user.Status = dtrow["Status"].ToString();
                                user.fathername = dtrow["fathername"].ToString();
                                user.PrimaryMobileNo = dtrow["PrimaryMobileNo"].ToString();
                                //user.Sectionname = dtrow["Sectionname"].ToString();
                                //user.DOB = dtrow["StudentDOB"].ToString();
                                user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString(); 
                            }
                            else if (mode == 3)
                            {
                                user.SAMID = dtrow["SAMID"].ToString();
                                user.AdmissionDate = dtrow["AdmissionDate"].ToString();
                                user.AdmissionNo = dtrow["AdmissionNo"].ToString();
                                user.Registration_No = dtrow["Registration_No"].ToString();
                                user.RefAdmNo = dtrow["RegNewNo"].ToString();
                                user.studentname = dtrow["studentname"].ToString();
                                user.Classname = dtrow["Classname"].ToString();
                                user.fathername = dtrow["PrimaryParentName"].ToString();
                                user.Sectionname = dtrow["Sectionname"].ToString();
                                user.DOB = dtrow["StudentDOB"].ToString();
                                user.PrimaryMobileNo = dtrow["PrimaryMobileNo"].ToString();
                                user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString(); 
                            }
                            details.Add(user);
                        }
                    }
                }
            }
        }
        return details.ToArray();
    }
    public class studentregistration
    {
        public string SAMID { get; set; }
        public string AdmissionDate { get; set; }
        public string AdmissionNo { get; set; }
        public string RefAdmNo { get; set; }
        public string RID { get; set; }
        public string RegistrationDate { get; set; }
        public string Registration_No { get; set; }
        public string studentname { get; set; }
        public string Classname { get; set; }
        public string Sectionname { get; set; }
        public string DOB { get; set; }
        public string Status { get; set; }
        public string fathername { get; set; }
        public string PrimaryMobileNo { get; set; }
        public string pagecount { get; set; }
    }
}