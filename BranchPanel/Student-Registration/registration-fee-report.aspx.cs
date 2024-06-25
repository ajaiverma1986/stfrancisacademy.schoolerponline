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

public partial class BranchPanel_Student_Registration_registration_fee_report : System.Web.UI.Page
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

        DataTable dt = objdut.GetDataTable("select username from tbluser where isactive=1 and isdeleted=0");
        ddlUsers.DataSource = dt;
        ddlUsers.DataValueField = "username";
        ddlUsers.DataTextField = "username";
        ddlUsers.DataBind();
        ddlUsers.Items.Insert(0, new ListItem("Select user", ""));
    }
    [WebMethod]
    public static BIndClass[] BindClassDDL(string Fyid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(Fyid), Convert.ToInt32(System.Web.HttpContext.Current.Session["BrBrid"]));
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
    public static studentregistration[] BindGridByJs(string Fromdate, string Todate, string Registrationnumber, string StudentName, string Parentname, string checkNo, int Status, int Applyingforclass, int paymentmode, int Fyid, string pagesize, string pageno,string User)
    {
        DataSet ds = new DataSet();
        List<studentregistration> details = new List<studentregistration>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_studentregistrationlist]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[15];
                param[0] = new SqlParameter("@mode", 1);
                param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
                param[2] = new SqlParameter("@FromDate", Fromdate);
                param[3] = new SqlParameter("@ToDate", Todate);
                param[4] = new SqlParameter("@registrationno", Registrationnumber);
                param[5] = new SqlParameter("@Studentname", StudentName);
                param[6] = new SqlParameter("@Parentname", Parentname);
                param[7] = new SqlParameter("@checkNo", checkNo);
                param[8] = new SqlParameter("@status", Status);
                param[9] = new SqlParameter("@applyingforclass", Applyingforclass);
                param[10] = new SqlParameter("@paymentmode", paymentmode);
                param[11] = new SqlParameter("@Fyid", Fyid);
                param[12] = new SqlParameter("@pagesize", pagesize);
                param[13] = new SqlParameter("@pageno", pageno);
                param[14] = new SqlParameter("@User", User);
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
                        DataTable dtCol = new DataTable();
                        dtCol.Columns.Add("S.No.");
                        dtCol.Columns.Add("Registration Date");
                        dtCol.Columns.Add("Registration No");                        
                        dtCol.Columns.Add("Student Name");
                        dtCol.Columns.Add("Apply Class");                        
                        dtCol.Columns.Add("Registration Fee");
                        dtCol.Columns.Add("Payment Mode");
                        ManageDoc doc = new ManageDoc();
                        string baseUrl = HttpContext.Current.Request.Url.Scheme + "://" + HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.ApplicationPath.TrimEnd('/') + "/";
                        string fileName = "RegReportPdf" + DateTime.Now.ToString("ddMMyyyyhhmm") + ".pdf";
                        int i = 1;
                        foreach (DataRow dtrow in ds.Tables[0].Rows)
                        {
                            DataRow dr = dtCol.NewRow();
                            dr["S.No."] = i;
                            dr["Registration Date"] = dtrow["RegistrationDate"].ToString();
                            dr["Registration No"] = dtrow["Registration_No"].ToString();
                            dr["Student Name"] = dtrow["studentname"].ToString();
                            dr["Apply Class"] = dtrow["Classname"].ToString();
                            dr["Registration Fee"] = dtrow["RegistrationFee"].ToString();                            
                            dr["Payment Mode"] = dtrow["PaymentMode"].ToString();                            
                            dtCol.Rows.Add(dr);
                            studentregistration user = new studentregistration();
                            user.RID = dtrow["RID"].ToString();
                            user.RegistrationDate = dtrow["RegistrationDate"].ToString();
                            user.Registration_No = dtrow["Registration_No"].ToString();
                            user.studentname = dtrow["studentname"].ToString();
                            user.Classname = dtrow["Classname"].ToString();
                            user.Status = dtrow["Status"].ToString();
                            user.Registrationfee = dtrow["RegistrationFee"].ToString();
                            user.Payment = dtrow["PaymentMode"].ToString();
                            user.Paymentmode = dtrow["ChkRefNo"].ToString();
                            user.CheckStatus = dtrow["CheckStatus"].ToString();
                            user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString();
                            user.filePath = baseUrl + "/Uploads/" + fileName;
                            details.Add(user);
                            i++;
                        }
                        doc.CreatePdf(HttpContext.Current.Server.MapPath("~/Uploads/") + fileName, dtCol, "Registration Report");
                    }
                }
            }
        }
        
        return details.ToArray();
    }
    public class studentregistration
    {
        public string RID { get; set; }
        public string RegistrationDate { get; set; }
        public string Registration_No { get; set; }
        public string studentname { get; set; }
        public string Classname { get; set; }
        public string Status { get; set; }
        public string Registrationfee { get; set; }
        public string Payment { get; set; }
        public string Paymentmode { get; set; }
        public string CheckStatus { get; set; }
        public string pagecount { get; set; }
        public string filePath { get; set; }
    }    
}