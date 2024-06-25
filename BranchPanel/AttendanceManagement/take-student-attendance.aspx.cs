using ClosedXML.Excel;
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

public partial class BranchPanel_AttendanceManagement_take_student_attendance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindClass();
    }

    public void BindClass()
    {
        DataTable Dt = new DataTable();
        CommonClass CommonClass = new CommonClass();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ActiveFinancialyear), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        if (Dt.Rows.Count > 0)
        {
            ddlapplyingforclass.DataSource = Dt;
            ddlapplyingforclass.DataTextField = "Classname";
            ddlapplyingforclass.DataValueField = "classid";
            ddlapplyingforclass.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlapplyingforclass.Items.Insert(0, li);
        }
    }
    [WebMethod]
    public static BindSection[] BindSectionDDL(string Classid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("sectiondll", Convert.ToInt32(Classid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        List<BindSection> BindObj = new List<BindSection>();
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            BindSection Obj = new BindSection();
            Obj.SECTIONID = Dt.Rows[i]["cwsid"].ToString();
            Obj.SECTIONNAME = Dt.Rows[i]["sectionname"].ToString();
            BindObj.Add(Obj);
        }
        return BindObj.ToArray();
    }
    public class BindSection
    {
        public string SECTIONID { get; set; }
        public string SECTIONNAME { get; set; }
    }


    [WebMethod]
    public static BindAttendance[] BindAttendanceGrid(string Classid, string SectionId, string Date)
    {
        DataUtility ObjDut = new DataUtility();
        List<BindAttendance> BindAttendanceObj = new List<BindAttendance>();
        SqlParameter[] Param = new SqlParameter[4];
        Param[0]=new SqlParameter("@ClassId",Classid);
        Param[1]=new SqlParameter("@SectionId",SectionId);
        Param[2]=new SqlParameter("@Date",Date);
        Param[3] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        DataTable Dt = ObjDut.GetDataTableSP(Param, "[Usp_TakeAttendance]");
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            BindAttendance Obj = new BindAttendance();
            Obj.ROWNUMBER = Dt.Rows[i]["RowNumber"].ToString();
            Obj.ADMISSIONNO = Dt.Rows[i]["AdmissionNo"].ToString();
            Obj.STUREGNO = Dt.Rows[i]["SturegNo"].ToString();
            Obj.REGNEWNO = GetRegNewNo(Classid, SectionId, HttpContext.Current.Session["BrBrid"].ToString(), Obj.STUREGNO);
            Obj.NAME = Dt.Rows[i]["Name"].ToString();
            Obj.ATTENDANCESTATUS = Dt.Rows[i]["AttendanceStatus"].ToString();
            Obj.CHECKBOXSTATUS = Dt.Rows[i]["CheckBoxStatus"].ToString();
            BindAttendanceObj.Add(Obj);
        }
        return BindAttendanceObj.ToArray();
    }

    private static string GetRegNewNo(string classid, string sectionId, string brid, string sTUREGNO)
    {
        DataUtility ObjDut = new DataUtility();
        string str = @"Select * from tbl_StudentRegistration SR
                        INNER JOIN tbl_StudentMaster SM on SR.RID = SM.RID and SR.Fyid = SM.Fyid and SR.Brid = SM.Brid
                        INNER JOIN tbl_StudentAdmissionMaster SA on SM.SturegNo = SA.SturegNo and SM.Fyid = SA.Fyid and SA.Brid = SM.Brid
                        Where SA.StuRegNo="+ sTUREGNO + " and SA.Brid=" + brid + " and SR.ApplyingForClass=" + classid + " and SM.sectionid=" + sectionId + "";
        var RegNewNO = Convert.ToString(ObjDut.GetScalar(str));
        return RegNewNO;
    }

    public class BindAttendance
    {
        public string ROWNUMBER { get; set; }
        public string ADMISSIONNO { get; set; }
        public string STUREGNO { get; set; }
        public string NAME { get; set; }
        public string ATTENDANCESTATUS { get; set; }
        public string CHECKBOXSTATUS { get; set; }
        public string REGNEWNO { get; set; }
    }

    [WebMethod]
    public static int TakeAttendance(string AdmissionNo, string SturegNo, string AttendanceStatus, string Date)
    {
        DataUtility Objdut = new DataUtility();        
        int intresult = 0;       
        SqlParameter[] Param = new SqlParameter[8];
        Param[0] = new SqlParameter("@AdmissionNo", AdmissionNo);
        Param[1] = new SqlParameter("@SturegNo", SturegNo);
        Param[2] = new SqlParameter("@AttendanceStatus", AttendanceStatus);
        Param[3] = new SqlParameter("@intresult", SqlDbType.Int);
        Param[3].Direction = ParameterDirection.Output;
        Param[4] = new SqlParameter("@Date", Date);
        Param[5] = new SqlParameter("@Brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        Param[6] = new SqlParameter("@userId", Convert.ToInt32(HttpContext.Current.Session["BrAdid"]));
        Param[7] = new SqlParameter("@SystemName", "");
        intresult = Objdut.ExecuteSqlSP(Param, "[usp_managestudentattendance]");

        if (intresult == 1)
        {
           
            string[] Attendance = AttendanceStatus.Split(',');
            string[] StudentID = SturegNo.Split(',');
            for (int i = 0; i < StudentID.Length; i++)
            {
                if (Convert.ToInt32(Attendance[i]) == 0)
                {
                    string msg1="",msg2="",msg3="";
                    msg1 = "'Dear Parent , Student ";
                    msg2 = " is absent Today("+ DateTime.Today.ToString("dd/MM/yyyy")+").";
                    msg3 = " Please Contact School. ";
                    int ied = CommonClass.getStudentMobileNo(Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), Convert.ToDecimal(StudentID[i]), Convert.ToInt32(CommonClass.Scaler("ActiveAcademicYear")), msg1, msg2, msg3);
                }
            }
        }
        return intresult;
    }
    protected void btnUpload1_Click(object sender, EventArgs e)
    {
        lblError2.Text = "";
        try
        {
            if (FileUpload2.HasFile)
            {
                string filename = FileUpload2.FileName;
                string ext = Path.GetExtension(filename);
                if (!ext.ToUpper().Contains("xls".ToUpper()))
                {
                    lblError2.Text = "select File in xlsx format!!";
                    return;
                }
                else
                {
                    string path1 = string.Format("{0}/{1}", Server.MapPath("~/Uploads"), FileUpload2.FileName);
                    if (!Directory.Exists(Server.MapPath("~/Uploads")))
                    {
                        Directory.CreateDirectory(Server.MapPath("~/Uploads"));
                    }
                    if (File.Exists(path1))
                    {
                        File.Delete(path1);
                    }
                    FileUpload2.SaveAs(path1);
                    string connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path1 + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                    DataTable dt = ConvertXSLXtoDataTable(path1, connString);
                    if (dt != null && dt.Rows.Count > 0)
                    {
                        DataSet ds = new DataSet();

                        var dtCopy = dt.Copy();
                        ds.Tables.Add(dtCopy);

                        UpdateStudentAttandance(ds, 2);
                        //foreach (DataRow dr in dt.Rows)
                        //{
                        //    decimal decmarks2 = 0;
                        //    decimal.TryParse(Convert.ToString(dr["MARKS"]), out decmarks2);
                        //    //string examname = dt.Columns[6].ToString();
                        //    //uploadMarks1(Convert.ToString(dr["STUREGNO"]), Convert.ToString(dr["CLASS"]), Convert.ToString(dr["SECTION"]), Convert.ToString(dr["SUBJECT"]), "UNIT TEST - I", Convert.ToString(decmarks2));
                        //    uploadMarksNew(Convert.ToString(dr["STUREGNO"]), Convert.ToString(dr["CLASS"]), Convert.ToString(dr["SECTION"]), Convert.ToString(dr["SUBJECT"]), ddlExam.SelectedValue, Convert.ToString(decmarks2));
                        //}
                    }
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Attendance updated successfull')", true);
                }
            }
            else
            {
                lblError2.Text = "select excel file";
            }
        }
        catch (Exception ex)
        {
            lblError2.Text = ex.Message;
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + ex.Message + "')", true);
        }

    }

    private void UpdateStudentAttandance(DataSet ds, int v)
    {
        try
        {
            string AdmissionNoAll = "", SturegNoAll = "", AttendanceStatusAll = "", DateAll = txtdateforattendance.Text;
            var error = 0;
            int ColsCount = ds.Tables[0].Columns.Count;
            int RowsCount = ds.Tables[0].Rows.Count;
            for (int i = 0; i < RowsCount; i++)
            {
                var ClassId = hdClassId.Value;
                var SectionId = hdSectionId.Value;
                var Brid = Convert.ToString(Session["BrBrid"]);
                var AdmissionNo = Convert.ToString(ds.Tables[0].Rows[i]["AdmissionNo"]);
                var StuRegNo =Convert.ToString(ds.Tables[0].Rows[i]["RegNo"]);
                var AttStatus = Convert.ToString(ds.Tables[0].Rows[i][5]);
                if (!string.IsNullOrWhiteSpace(ClassId) && !string.IsNullOrWhiteSpace(SectionId) && !string.IsNullOrWhiteSpace(Brid) && !string.IsNullOrWhiteSpace(StuRegNo))
                {
                    AdmissionNoAll = AdmissionNoAll + "," + AdmissionNo;
                    SturegNoAll = SturegNoAll + "," + StuRegNo;

                    if (AttStatus.Trim() == "1")
                    {
                        AttendanceStatusAll = AttendanceStatusAll + ',' + '1';
                    }
                    else
                    {
                        AttendanceStatusAll = AttendanceStatusAll + ',' + '0';
                    }
                }
                else
                {
                    error = error + 1;
                }
            }
            AdmissionNoAll = AdmissionNoAll.Substring(1, AdmissionNoAll.Length-1);
            SturegNoAll = SturegNoAll.Substring(1, SturegNoAll.Length-1);
            AttendanceStatusAll = AttendanceStatusAll.Substring(1, AttendanceStatusAll.Length-1);
            var result = TakeAttendance(AdmissionNoAll, SturegNoAll, AttendanceStatusAll, DateAll);
            if (result > 0)
            {
                lblmessage2.Text = "Update successfully."; 
            }
            else
            {
                lblmessage2.Text = "Some record are not updated.";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + lblmessage2.Text + "')", true);
            }
        }
        catch (Exception ex)
        {
            lblmessage2.Text = "Error";
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + ex.Message + "')", true);
        }
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
            throw ex;
        }
        finally
        {

            oledbConn.Close();
        }

        return dt;

    }

    protected void IBExcel_Click(object sender, EventArgs e)
    {
        var fileName = "ForStdAttUpdateByClass_" + hdClassName.Value + "_" + "Sec" + "_" + hdSectionName.Value + "_" + DateTime.Today.ToString("dd_MMM_yy");
        DataTable dt = new DataTable();
        DataUtility ObjDut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[4];
        Param[0] = new SqlParameter("@ClassId", hdClassId.Value);
        Param[1] = new SqlParameter("@SectionId", hdSectionId.Value);
        Param[2] = new SqlParameter("@Date", txtdateforattendance.Text);
        Param[3] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        DataSet ds = ObjDut.GetDataSetSP(Param, "[Usp_TakeAttendance]");
        if (ds.Tables.Count > 0)
        {            
            dt.Columns.Add("Student Name");
            dt.Columns.Add("AdmissionNo");
            dt.Columns.Add("RegNo");
            dt.Columns.Add("Class"); 
            dt.Columns.Add("Section");
            dt.Columns.Add("AttandanceStatus");

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                var IsAttendanceTaken = ds.Tables[0].Rows[i]["AttendanceStatus"].ToString();
                var AttendanceStatus = ds.Tables[0].Rows[i]["CheckBoxStatus"].ToString();
                var STUREGNO = ds.Tables[0].Rows[i]["SturegNo"].ToString();
                var REGNEWNO = GetRegNewNo(hdClassId.Value, hdSectionId.Value, HttpContext.Current.Session["BrBrid"].ToString(), STUREGNO);
                var Name = ds.Tables[0].Rows[i]["Name"] + "(" + REGNEWNO + ")";

                if (!string.IsNullOrWhiteSpace(IsAttendanceTaken))
                {
                    if (IsAttendanceTaken.Trim() == "Taken")
                    {
                        if (AttendanceStatus.Trim() == "Checked")
                            AttendanceStatus = "0";
                        else
                            AttendanceStatus = "1";
                    }
                    else
                    {
                        AttendanceStatus = "0";
                    }
                }
                else
                {
                    AttendanceStatus = "";
                }

                DataRow dr = dt.NewRow();
                dr["Student Name"] = Name;
                dr["AdmissionNo"] = ds.Tables[0].Rows[i]["AdmissionNo"].ToString();
                dr["RegNo"] = STUREGNO;
                dr["Class"] = hdClassName.Value;
                dr["Section"] = hdSectionName.Value;
                dr["AttandanceStatus"] = AttendanceStatus;

                dt.Rows.Add(dr);
                dt.AcceptChanges();
            }
        }

        DataSet dtStd = new DataSet();
        dtStd.Tables.Add(dt);

        using (XLWorkbook wb = new XLWorkbook())
        {
            wb.Worksheets.Add(dtStd.Tables[0], "Sheet1");
            wb.NamedRange("Enter_a_Name_same_as_Excelsheetname");
            Response.Clear();
            Response.Buffer = true;
            Response.Charset = "";
            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".xlsx");
            using (MemoryStream MyMemoryStream = new MemoryStream())
            {
                wb.SaveAs(MyMemoryStream);
                MyMemoryStream.WriteTo(Response.OutputStream);
                Response.Flush();
                Response.End();
            }
        }
    }
}