using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Fee_Management_overdue_fee : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    DataUtility Objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        fillfyear();
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        lblError.Text = "";
        //  try
        // {
        if (fileUpload.HasFile)
        {
            string filename = fileUpload.FileName;
            string ext = Path.GetExtension(filename);
            if (!ext.ToUpper().Contains("xlsx".ToUpper()))
            {
                lblError.Text = "select File in xlsx format!!";
                return;
            }
            else
            {
                string path1 = string.Format("{0}/{1}", Server.MapPath("~/Uploads"), fileUpload.FileName);
                if (!Directory.Exists(Server.MapPath("~/Uploads")))
                {
                    Directory.CreateDirectory(Server.MapPath("~/Uploads"));
                }
                if (File.Exists(path1))
                {
                    File.Delete(path1);
                }
                fileUpload.SaveAs(path1);
                string connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path1 + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                DataTable dt = ConvertXSLXtoDataTable(path1, connString);
                if (dt != null && dt.Rows.Count > 0)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        if ((Convert.ToString(dr["First_Name"]) + " " + Convert.ToString(dr["Middle_Name"]) + " " + Convert.ToString(dr["Last_Name"])).Trim() != "")
                        {
                            DataUtility Objdut = new DataUtility();
                            SqlParameter[] param = new SqlParameter[10];
                            param[0] = new SqlParameter("@RegNum", Convert.ToString(dr["RegNoForUpdate"]));
                            param[1] = new SqlParameter("@NewRegNum", Convert.ToString(dr["RegNewNo"]));
                            param[2] = new SqlParameter("@Name", Convert.ToString(dr["First_Name"]) + " " + Convert.ToString(dr["Middle_Name"]) + " " + Convert.ToString(dr["Last_Name"]));
                            param[3] = new SqlParameter("@Gender", Convert.ToString(dr["Gender"]));
                            param[4] = new SqlParameter("@Religion", Convert.ToString(dr["Religion"]));
                            param[5] = new SqlParameter("@ClassId", Convert.ToString(dr["ClassID"]));
                            param[6] = new SqlParameter("@Sectionid", Convert.ToString(dr["SectionID"]));
                            param[7] = new SqlParameter("@ParentName", Convert.ToString(dr["ParentFname"]) + " " + Convert.ToString(dr["ParentMName"]) + " " + Convert.ToString(dr["ParentLName"]));
                            param[8] = new SqlParameter("@ParentMobile", Convert.ToString(dr["ParentMobileNo"]));
                            param[9] = new SqlParameter("@Due", Convert.ToString(dr["Privios year duce"]));
                            DataSet Ds = Objdut.GetDataSetSP(param, "[sp_insertPrevDue]");
                        }

                    }

                    lblmessage.Text = "uploaded";
                }
            }
        }
        else
        {
            lblError.Text = "select excel file";
        }
        // }
        //catch(Exception ex)
        //{
        //   lblError.Text = ex.Message;
        // }
    }

    public static DataTable ConvertXSLXtoDataTable(string strFilePath, string connString)
    {
        OleDbConnection oledbConn = new OleDbConnection(connString);

        DataTable dt = new DataTable();

        try
        {
            oledbConn.Open();
            DataTable dtSchema = oledbConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });
            string filename = Path.GetFileNameWithoutExtension(strFilePath);
            if (dtSchema.Rows.Count > 0)
            {
                for (int i = 0; i < dtSchema.Rows.Count; i++)
                {
                    if (Convert.ToString(dtSchema.Rows[i]["TABLE_NAME"]).ToUpper().Contains("SHEET1"))
                    {
                        filename = "Sheet1";
                        break;
                    }
                }
            }
            else
            {
                filename = "Sheet1";
            }
            using (OleDbCommand cmd = new OleDbCommand("SELECT * FROM [" + filename + "$]", oledbConn))
            {
                OleDbDataAdapter oleda = new OleDbDataAdapter();
                oleda.SelectCommand = cmd;
                DataSet ds = new DataSet();
                oleda.Fill(ds);

                dt = ds.Tables[0];
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {

            oledbConn.Close();
        }
        return dt;
    }

    [WebMethod]
    public static bool SendToken(string ASAID, string stdRegNo) {
        DataTable dtStudent = new DataTable();
        dtStudent.Columns.Add("ASAID");
        dtStudent.Columns.Add("STUREGNO");
        HttpContext.Current.Session["dtStudent"] = null;
        if (!String.IsNullOrEmpty(ASAID) && !String.IsNullOrEmpty(stdRegNo)) {
            var AsaidList = ASAID.Split(',');
            var StuRegList = stdRegNo.Split(',');
            if (AsaidList.Length > 0)
            {
                for (int i = 0; i < AsaidList.Length; i++)
                {
                    DataRow dr = dtStudent.NewRow();
                    if (!string.IsNullOrEmpty(AsaidList[i]))
                    {
                        dr["ASAID"] = AsaidList[i].ToString();
                        dr["STUREGNO"] = StuRegList[i].ToString();
                        dtStudent.Rows.Add(dr);
                        dtStudent.AcceptChanges();
                    }
                }
            }
            HttpContext.Current.Session["dtStudent"] = dtStudent; 
            return true;
        }        
        return false;
    }
     public void fillfyear()
    {
        DataTable Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
        
    }
    [WebMethod]
    public static GetOverDueFeeDetails[] BindSectionMethod(int ClassID)
    {
        List<GetOverDueFeeDetails> Details = new List<GetOverDueFeeDetails>();
        DataTable Dt = new DataTable();
        Dt = CommonClass.ABC("sectiondll", ClassID, Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                GetOverDueFeeDetails obje = new GetOverDueFeeDetails();
                obje.courseID = Convert.ToInt32(Dt.Rows[i]["cwsid"]);
                obje.courseName = Convert.ToString(Dt.Rows[i]["sectionname"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }
    public class getcourse
    {
        public int courseID { get; set; }

        public string courseName { get; set; }
    }
    [WebMethod]
    public static GetOverDueFeeDetails[] BindGridOfOverDueList(int SectionID, int Fyid, string pagesize, string pageno, string stuname, string duefromdate, string duetodate, string mobileno, string classid)    
    {
        DataSet Ds = new DataSet();
        List<GetOverDueFeeDetails> Details = new List<GetOverDueFeeDetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[10];
        param[0] = new SqlParameter("@Fyid", Fyid);
        param[1] = new SqlParameter("@pagesize", pagesize);
        param[2] = new SqlParameter("@pageno", pageno);
        param[3] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        param[4] = new SqlParameter("@DueFromDate",duefromdate);
         param[5] = new SqlParameter("@DueToDate",duetodate);
         param[6] = new SqlParameter("@Mobileno",mobileno);
         param[7] = new SqlParameter("@Name",stuname);
         param[8] = new SqlParameter("@classid", classid);
         param[9] = new SqlParameter("@SectionID", SectionID);
        Ds = Objdut.GetDataSetSP(param, "[Usp_BindOverDue]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            decimal totalfee = 0;
            foreach (DataRow Dtrow in Ds.Tables[0].Rows)
            {
                decimal tempfee = 0;
                GetOverDueFeeDetails user = new GetOverDueFeeDetails();
                user.Rownumber = Dtrow["Rownumber"].ToString();
                user.RegNewNo = Dtrow["RegNewNo"].ToString();
                user.Name = Dtrow["Name"].ToString();
                user.DueDate = Dtrow["DueDate"].ToString();
                user.PayableOrDueAmount = Dtrow["PayableOrDueAmount"].ToString();
                user.Mobile = Dtrow["Mobile"].ToString();
                user.Sturegno = Dtrow["Sturegno"].ToString();
                user.pagecount = Ds.Tables[1].Rows[0]["pages"].ToString();
                user.TotalStudent = Ds.Tables[2].Rows[0]["TotalStudent"].ToString();
                //user.TotalStudent = Ds.Tables[0].Rows.Count.ToString();
                user.TotalOverDueFee = Ds.Tables[2].Rows[0]["TotalOverDueFee"].ToString();
                decimal.TryParse(Dtrow["PayableOrDueAmount"].ToString(), out tempfee);
                totalfee = totalfee + tempfee;
                user.Tax = Dtrow["Tax"].ToString();
                user.TaxWithFee = Dtrow["TaxWithFee"].ToString();
                user.TotalDue = Ds.Tables[0].Compute("SUM(PayableOrDueAmount)", "Sturegno=" + Dtrow["Sturegno"].ToString() + "").ToString();
                user.classes = Dtrow["Class"].ToString();
                user.SectionID = Dtrow["Section"].ToString();
                user.Asaid = Dtrow["Asaid"].ToString();
                user.Samid = Dtrow["Samid"].ToString();
                Details.Add(user);
            }
            //Details[0].TotalOverDueFee = totalfee.ToString();
        }
        return Details.ToArray();
    }

    public class GetOverDueFeeDetails
    {
        public int courseID { get; set; }
        public string courseName { get; set; }
        public string Rownumber { get; set; }
        public string AdmissionNo { get; set; }
        public string RegNewNo { get; set; }
        public string Name { get; set; }
        public string DueDate { get; set; }
        public string PayableOrDueAmount { get; set; }
        public string Mobile { get; set; }
        public string Sturegno { get; set; }
        public string pagecount { get; set; }
        public string TotalStudent { get; set; }
        public string TotalOverDueFee { get; set; }
        public string Tax { get; set; }
        public string TaxWithFee { get; set; }
        public string classes { get; set; }
        public string SectionID { get; set; }
        public string Asaid { get; set; }
        public string Samid { get; set; }
        public string TotalDue { get; set; } 
    }

    
}