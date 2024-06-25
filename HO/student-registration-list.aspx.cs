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
public partial class HO_Student_Registration_student_registration_list : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    private DataUtility objdut = new DataUtility();
    DataUtility obj = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillfyear_branch();    
        }
    }
    public void fillfyear_branch()
    {
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfyear.DataSource = Dt;
        ddlfyear.DataValueField = "fyid";
        ddlfyear.DataTextField = "FYName";
        ddlfyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
        DataTable dt = new DataTable();
        dt = obj.GetDataTable("select Brid,BrName from Branch_master where BrActive=1 and isDeleted=0 and isActive=1");
        if (dt.Rows.Count > 0)
        {
            ddlbranch.DataSource = dt;
            ddlbranch.DataValueField = "Brid";
            ddlbranch.DataTextField = "BrName";
            ddlbranch.DataBind();
        }
        
    }
    [WebMethod]
    public static studentregistration[] BindGridByJs(string Fromdate, string Todate, string Registrationnumber, string StudentName, string Parentname, string ParentMobileNo, int Status, int Applyingforclass, int Fyid, int mode, string Admissionnnumber, string pagesize, string pageno, int BrId)
    {
        DataSet ds = new DataSet();
        List<studentregistration> details = new List<studentregistration>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_studentregistrationlist]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[14];
                param[0] = new SqlParameter("@mode", mode);
                param[1] = new SqlParameter("@Brid", BrId);
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
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dtrow in ds.Tables[0].Rows)
                        {
                            studentregistration user = new studentregistration();
                                user.RID = dtrow["RID"].ToString();
                                user.RegistrationDate = dtrow["RegistrationDate"].ToString();
                                user.Registration_No = dtrow["Registration_No"].ToString();
                                user.studentname = dtrow["studentname"].ToString();
                                user.Classname = dtrow["Classname"].ToString();
                                user.Status = dtrow["Status"].ToString();
                                user.fathername = dtrow["fathername"].ToString();
                                user.PrimaryMobileNo = dtrow["PrimaryMobileNo"].ToString();
                                user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString(); 
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
        public string RID { get; set; }
        public string RegistrationDate { get; set; }
        public string Registration_No { get; set; }
        public string studentname { get; set; }
        public string Classname { get; set; }
        public string Status { get; set; }
        public string fathername { get; set; }
        public string PrimaryMobileNo { get; set; }
        public string pagecount { get; set; }
    }
    [WebMethod]
    public static BIndClass[] BindClassDDL(string Fyid,string BrId)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(Fyid), Convert.ToInt32(BrId));
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
}