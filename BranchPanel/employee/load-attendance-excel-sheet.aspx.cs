using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;

public partial class BranchPanel_load_attendance_excel_sheet : System.Web.UI.Page
{
    private static string attendancesheetname = "";
    private CommonClass commonOBJ = new CommonClass();
    private static int fyid = 2;
    private DataUtility objDUT = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        }
    }

    protected void btnuploadorsubmit_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable tblStudentDtl = new DataTable();
            gvdetails.Visible = true;
            string FileName = fileuploadExcel.PostedFile.FileName;
            string Pathoffile = Server.MapPath(FileName);
            FileInfo file = new FileInfo(Pathoffile);
            if (file.Exists)
            {
                file.Delete();
            }
            if (fileuploadExcel.PostedFile.ContentLength <= 20971520)
            {
                string fileexe = Path.GetExtension(fileuploadExcel.FileName);
                if (fileexe == ".xlsx" || fileexe == ".xls")
                {
                    fileuploadExcel.SaveAs(Server.MapPath(fileuploadExcel.PostedFile.FileName));
                    //GetCustomers(Convert.ToString(Server.MapPath(fileuploadExcel.PostedFile.FileName)));
                    string FileNameDS = Convert.ToString(Server.MapPath(fileuploadExcel.PostedFile.FileName));
                    DataSet dsUnUpdated = CommonClass.ImportExcelXLS(FileNameDS, true);
                    
                    if (dsUnUpdated != null)
                    {
                        for (int i = 0; i < dsUnUpdated.Tables.Count; i++)
                        {
                            if (Convert.ToString(dsUnUpdated.Tables[i]).Contains("Sheet1"))
                            {
                                tblStudentDtl = dsUnUpdated.Tables[i];
                            }
                        }
                    }
                }
                else
                {
                    Utility.ViewAlertMessage(this, "You Can Upload Only Excel Sheet.");
                } 
                if (tblStudentDtl.Rows.Count > 0)
                {
                    tblStudentDtl.Columns.Add("EID");
                    tblStudentDtl.Columns["EID"].SetOrdinal(tblStudentDtl.Columns.IndexOf("EMP_CODE"));

                    tblStudentDtl.Columns.Add("EMP_NAME");
                    tblStudentDtl.Columns["EMP_NAME"].SetOrdinal(tblStudentDtl.Columns.IndexOf("ATTANDANCE_DATE"));

                    tblStudentDtl.Columns.Add("DEPART");
                    tblStudentDtl.Columns["DEPART"].SetOrdinal(tblStudentDtl.Columns.IndexOf("STATUS"));
                    foreach (DataRow dr in tblStudentDtl.Rows)
                    {
                        DataTable TempEmp = new DataTable();
                        string EMP_CODE="";
                        EMP_CODE = dr["EMP_CODE"].ToString();
                        if (EMP_CODE != "")
                        {
                            TempEmp = objDUT.GetDataTable("Select ISNULL(eid,0) eid, fName+' '+mName+' '+lName as EMP_NAME,department from tblEmp_Master where refNo='" + EMP_CODE + "'");
                            if (TempEmp.Rows.Count > 0)
                            {
                                dr["EMP_NAME"] = TempEmp.Rows[0]["EMP_NAME"].ToString();
                                dr["DEPART"] = TempEmp.Rows[0]["department"].ToString();
                                dr["EID"] = TempEmp.Rows[0]["eid"].ToString();

                                if (dr["ATTANDANCE_DAY"].ToString() != "")
                                {
                                    string DAY = dr["ATTANDANCE_DAY"].ToString();
                                    if (DAY == "1")
                                    {
                                        dr["ATTANDANCE_DAY"] = "Monday";
                                    }
                                    if (DAY == "2")
                                    {
                                        dr["ATTANDANCE_DAY"] = "Tuesday";
                                    }
                                    if (DAY == "3")
                                    {
                                        dr["ATTANDANCE_DAY"] = "Wednesday";
                                    }
                                    if (DAY == "4")
                                    {
                                        dr["ATTANDANCE_DAY"] = "Thursday";
                                    }
                                    if (DAY == "5")
                                    {
                                        dr["ATTANDANCE_DAY"] = "Friday";
                                    }
                                    if (DAY == "6")
                                    {
                                        dr["ATTANDANCE_DAY"] = "Saturday";
                                    }
                                    if (DAY == "7")
                                    {
                                        dr["ATTANDANCE_DAY"] = "Sunday";
                                    }
                                }
                            }
                            else
                            {
                                dr["EMP_CODE"] = "";
                                dr["EMP_NAME"] = "";
                                dr["DEPART"] = "";
                                dr["EID"] = "0";
                                dr["ATTANDANCE_DAY"] = "";
                            }
                        }
                        else
                        {
                            dr["EMP_CODE"] = "";
                            dr["EMP_NAME"] = "";
                            dr["DEPART"] = "";
                            dr["EID"] = "0";
                            dr["ATTANDANCE_DAY"] = "";
                        }
                    }
                    gvdetails.DataSource = tblStudentDtl;
                    gvdetails.DataBind();
                    btnpayamount.Visible = true;
                }
            }
        }
        catch (Exception exp)
        {
        }
    }

    protected void GetCustomers(string DataSource)
    {
        try
        {
            string NewConnectionstring = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + DataSource + ";Extended Properties=\"Excel 12.0 Xml;HDR=NO;IMEX=1;\"";
            System.Data.OleDb.OleDbConnection connExcel = new System.Data.OleDb.OleDbConnection(NewConnectionstring);
            System.Data.OleDb.OleDbCommand cmdExcel = new System.Data.OleDb.OleDbCommand();
            cmdExcel.Connection = connExcel;
            connExcel.Open();
            DataTable dtExcelSchema;
            dtExcelSchema = connExcel.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, null);
            connExcel.Close();
            connExcel.Open();
            System.Data.OleDb.OleDbDataAdapter da = new System.Data.OleDb.OleDbDataAdapter();
            DataSet ds = new DataSet();
            string sheetName = dtExcelSchema.Rows[0]["Table_Name"].ToString();
            cmdExcel.CommandText = "SELECT * From [Sheet1$]";
            da.SelectCommand = cmdExcel;
            da.Fill(ds); connExcel.Close();
            DataTable dt = ds.Tables[0];

            if (dt.Rows.Count > 0)
            {
                //txttodate.Text = dt.Rows[0]["ATTANDANCE_DATE"].ToString();
                //txtdateofexcelsheet.Text = dt.Rows[0]["ATTANDANCE_DATE"].ToString();
                //for (int i = 0; i <= 20; i++)
                //{
                //    dt.Rows[i].Delete();
                //}

                //for (int j = (dt.Rows.Count - 4); j < dt.Rows.Count; j++)
                //{
                //    dt.Rows[j].Delete();
                //}

                gvdetails.DataSource = dt;
                gvdetails.DataBind();
                btnpayamount.Visible = true;
            }
        }
        catch (Exception exp)
        {
        }
    }

    protected void btnpayamount_Click(object sender, EventArgs e)
    {
        int result = 0;

        try
        {
            //int cardno = 0;
            string Date = "", intime = "", outtime = "", status = "", cardno = "";
            DataTable dt = new DataTable();
            DataRow dr;
            dt.Columns.Add(new System.Data.DataColumn("Card No", typeof(String)));
            dt.Columns.Add(new System.Data.DataColumn("Employee Name", typeof(String)));
            dt.Columns.Add(new System.Data.DataColumn("Attendance Date", typeof(String)));
            dt.Columns.Add(new System.Data.DataColumn("Attendance Day", typeof(String)));
            dt.Columns.Add(new System.Data.DataColumn("Department", typeof(String)));
            dt.Columns.Add(new System.Data.DataColumn("Status", typeof(String)));
            dt.Columns.Add(new System.Data.DataColumn("In Time", typeof(String)));
            dt.Columns.Add(new System.Data.DataColumn("Out Time", typeof(String)));
            dt.Columns.Add(new System.Data.DataColumn("EID", typeof(String)));

            foreach (GridViewRow row in gvdetails.Rows)
            {
                Label lblbiometriccardno = (Label)row.FindControl("lblbiometriccardno");
                Label lblemployeename = (Label)row.FindControl("lblemployeename");
                Label lbattendancedate = (Label)row.FindControl("lbattendancedate");
                Label lbldayname = (Label)row.FindControl("lbldayname");
                Label lbldepartment = (Label)row.FindControl("lbldepartment");
                Label lblstatus = (Label)row.FindControl("lblstatus");
                Label lblintime = (Label)row.FindControl("lblintime");
                Label lblouttime = (Label)row.FindControl("lblouttime");
                Label lblEID = (Label)row.FindControl("lblEID");

                dr = dt.NewRow();
                dr[0] = lblbiometriccardno.Text;
                dr[1] = lblemployeename.Text;
                dr[2] = lbattendancedate.Text;
                dr[3] = lbldayname.Text;
                dr[4] = lbldepartment.Text;
                dr[5] = lblstatus.Text;
                dr[6] = lblintime.Text;
                dr[7] = lblouttime.Text;
                dr[8] = lblEID.Text;
                dt.Rows.Add(dr);
            }

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                //if (Convert.ToString(dt.Rows[i]["Card No"]) != "")
                //{
                //    cardno = dt.Rows[i]["Card No"].ToString();
                //}
                //else
                //{
                    if (Convert.ToString(dt.Rows[i]["Attendance Date"]) != "")
                    {
                        intime = Convert.ToString(dt.Rows[i]["In Time"]);
                        outtime = Convert.ToString(dt.Rows[i]["Out Time"]);
                        status = Convert.ToString(dt.Rows[i]["Status"]);
                        Date = Convert.ToString(dt.Rows[i]["Attendance Date"]);
                        string strValue = Date;
                        string[] strArray = strValue.Split('/');
                        Date = strArray[2] + "-" + strArray[1] + "-" + strArray[0];
                    }
                //}

                //if (Convert.ToString(dt.Rows[i]["Card No"]) == "")
                //{
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
                    {
                        using (SqlCommand cmd = new SqlCommand("[Insert_Attendance ]", con))
                        {
                            con.Open();

                            cmd.CommandType = CommandType.StoredProcedure;

                            SqlParameter[] param = new SqlParameter[8];

                            param[0] = new SqlParameter("@isabsent", Convert.ToInt32(status));

                            param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));

                            param[2] = new SqlParameter("@fyid", fyid);

                            param[3] = new SqlParameter("@Date", Date);

                            param[4] = new SqlParameter("@eid", Convert.ToInt32(dt.Rows[i]["EID"]));

                            param[5] = new SqlParameter("@intime", intime);

                            param[6] = new SqlParameter("@outtime", outtime);

                            param[7] = new SqlParameter("@intresult", SqlDbType.Int);

                            param[7].Direction = ParameterDirection.Output;

                            cmd.Parameters.Add(param[0]);

                            cmd.Parameters.Add(param[1]);

                            cmd.Parameters.Add(param[2]);

                            cmd.Parameters.Add(param[3]);

                            cmd.Parameters.Add(param[4]);

                            cmd.Parameters.Add(param[5]);

                            cmd.Parameters.Add(param[6]);

                            cmd.Parameters.Add(param[7]);

                            cmd.ExecuteNonQuery();

                            result = result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);
                        }


                        //SqlParameter[] param = new SqlParameter[8];

                        //param[0] = new SqlParameter("@Date", Convert.ToString(Date));

                        //param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));

                        //param[2] = new SqlParameter("@fyid", fyid);

                        //param[3] = new SqlParameter("@intime", intime);

                        //param[4] = new SqlParameter("@outtime", outtime);

                        //param[5] = new SqlParameter("@biometriccardno", Convert.ToString(cardno));

                        //param[6] = new SqlParameter("@status", status);

                        //param[7] = new SqlParameter("@intresult", SqlDbType.Int);

                        //param[7].Direction = ParameterDirection.Output;

                        //result = result = objDUT.ExecuteSqlSP(param, "[Usp_TakeAllAttendance_excelsheet]");
                    }
                //}
            }
        }
        catch (Exception Exp)
        {
            return;
        }

        if (result > 0)
        {
            Utility.ViewAlertMessage(this, "Attendance uploaded sucessfully.");
        }
    }
}