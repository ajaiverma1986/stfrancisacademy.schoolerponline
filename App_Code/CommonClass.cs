using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.IO;
using System.Drawing;

using System.Text;
using Excel;
using System.Globalization;
using System.Data.OleDb;
using System.Collections.Generic;
using System.Text.RegularExpressions;

/// <summary>
/// This class have a common method used in this project only.
/// </summary>
public class CommonClass
{
    private DataUtility objdut = new DataUtility();

    private SqlParameter[] param;

    public CommonClass()
    {
    }
    public static DataSet ImportExcelXLS(string FileName, bool hasHeaders)
    {
        string HDR = hasHeaders ? "Yes" : "No";
        string strConn;
        if (FileName.Substring(FileName.LastIndexOf('.')).ToLower() == ".xlsx")
        {
            strConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source="+FileName+";Extended Properties=\"Excel 12.0 Xml;HDR=" + HDR + ";IMEX=1;\"";
            //strConn = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + FileName + ";Extended Properties=\"Excel 12.0;HDR=" + HDR + ";IMEX=0\"";
        }
        else
            strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + FileName + ";Extended Properties=\"Excel 8.0;HDR=" + HDR + ";IMEX=0\"";

        DataSet output = new DataSet();

        using (OleDbConnection conn = new OleDbConnection(strConn))
        {
            conn.Open();

            DataTable schemaTable = conn.GetOleDbSchemaTable(
                OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });

            foreach (DataRow schemaRow in schemaTable.Rows)
            {
                string sheet = schemaRow["TABLE_NAME"].ToString();

                if (!sheet.EndsWith("_"))
                {
                    try
                    {
                        OleDbCommand cmd = new OleDbCommand("SELECT * FROM [" + sheet + "]", conn);
                        cmd.CommandType = CommandType.Text;

                        DataTable outputTable = new DataTable(sheet);
                        output.Tables.Add(outputTable);
                        new OleDbDataAdapter(cmd).Fill(outputTable);
                    }
                    catch (Exception ex)
                    {
                        throw new Exception(ex.Message + string.Format("Sheet:{0}.File:F{1}", sheet, FileName), ex);
                    }
                }
            }
        }
        return output;
    }
    public DataTable JsonStringToDataTable(string jsonString)
    {
        DataTable dt = new DataTable();
        if (jsonString.Length > 2)
        {
            string[] jsonStringArray = Regex.Split(jsonString.Replace("[", "").Replace("]", ""), "},{");
            List<string> ColumnsName = new List<string>();
            foreach (string jSA in jsonStringArray)
            {
                string[] jsonStringData = Regex.Split(jSA.Replace("{", "").Replace("}", ""), ",");
                foreach (string ColumnsNameData in jsonStringData)
                {
                    try
                    {
                        int idx = ColumnsNameData.IndexOf(":");
                        string ColumnsNameString = ColumnsNameData.Substring(0, idx - 1).Replace("\"", "");
                        if (!ColumnsName.Contains(ColumnsNameString))
                        {
                            ColumnsName.Add(ColumnsNameString);
                        }
                    }
                    catch (Exception ex)
                    {
                        throw new Exception(string.Format("Error Parsing Column Name : {0}", ColumnsNameData));
                    }
                }
                break;
            }
            foreach (string AddColumnName in ColumnsName)
            {
                dt.Columns.Add(AddColumnName);
            }
            foreach (string jSA in jsonStringArray)
            {
                string[] RowData = Regex.Split(jSA.Replace("{", "").Replace("}", ""), ",");
                DataRow nr = dt.NewRow();
                foreach (string rowData in RowData)
                {
                    try
                    {
                        int idx = rowData.IndexOf(":");
                        string RowColumns = rowData.Substring(0, idx - 1).Replace("\"", "");
                        string RowDataString = rowData.Substring(idx + 1).Replace("\"", "");
                        nr[RowColumns] = RowDataString;
                    }
                    catch (Exception ex)
                    {
                        continue;
                    }
                }
                dt.Rows.Add(nr);
            }
        }
        return dt;
    }
    public static int getStudentMobileNo(int Brid, decimal studentID, int fyid, string msg1, string msg2, string msg3)
    {
        DataUtility objDut = new DataUtility();
        string MobileNo = "";
        string PrimaryMobileNo = "";
        string SecondaryMobileNo = "";
        string api = "";
        api = (string)(objDut.GetScalar("select isnull(sms_api,'') sms_api from tbl_smsapisetting where Brid=" + Brid + " and status=1"));
        try
        {
            DataUtility Objdut = new DataUtility();

            string strPrimaryMobileNo = "select isnull(SR.PrimaryMobileNo,0) PrimaryMobileNo from tbl_StudentMaster SM " +
                         " inner join tbl_StudentRegistration SR on SM.Registration_No = SR.Registration_No and SR.Brid = SM.Brid" +
                         " where sm.brid=" + Brid + " and SM.StuRegNo =" + studentID + "" +
                         " and SM.Fyid=" + fyid + "";

            PrimaryMobileNo = Objdut.GetScalar(strPrimaryMobileNo).ToString();
            if (PrimaryMobileNo.Length < 10)
            {
                string strSecondaryMobileNo = "select isnull(SR.SecondaryMobileNo,0) PrimaryMobileNo from tbl_StudentMaster SM " +
                             " inner join tbl_StudentRegistration SR on SM.Registration_No = SR.Registration_No and SR.Brid = SM.Brid" +
                             " where sm.brid=" + Brid + " and SM.StuRegNo =" + studentID + "" +
                             " and SM.Fyid=" + fyid + "";

                SecondaryMobileNo = Objdut.GetScalar(strPrimaryMobileNo).ToString();
            }
            string Name = Objdut.GetScalar("select DISTINCT sr.StudentFirstName as studentname " +
                        " from tbl_StudentMaster sm " +
                        " INNER JOIN tbl_StudentRegistration sr ON sm.RID=sr.RID and sm.Brid = sr.Brid" +
                        " INNER JOIN tbl_StudentAdmissionMaster sa ON sm.SturegNo=sa.StuRegNo and sa.Brid = sr.Brid" +
                        " where sm.IsActive=1 and sm.brid=" + Brid + " and sa.StuRegNo =" + studentID + "" +
                        " and sa.Fyid=" + fyid + "").ToString();

            if (PrimaryMobileNo.Length > 9)
            {
                MobileNo = PrimaryMobileNo;
            }
            else if (SecondaryMobileNo.Length > 9)
            {
                MobileNo = PrimaryMobileNo;
            }

            if (MobileNo.Length > 9)
            {
                //string msg = msg1 + (Name.ToString()) + msg2 + msg3;
				string msg = msg1  + msg2 + msg3;
                int result = sendMessageToMobile.SMSSend(MobileNo, msg, api);
                return 5;
            }
            return 1;
        }
        catch
        {
            return 0;
        }
        finally
        {
            MobileNo = "";
            PrimaryMobileNo = "";
            SecondaryMobileNo = "";
        }
    }

    public static int getStudentMobileNoForShorlist(string MobileNo, int rid, string msg1, string msg2, string msg3)
    {  
        try
        {
            DataUtility Objdut = new DataUtility();
             string api = "";
            api = (string)(Objdut.GetScalar("select isnull(sms_api,'') sms_api from tbl_smsapisetting where Brid=" + HttpContext.Current.Session["BrBrid"].ToString() + " and status=1"));

            string Name = Objdut.GetScalar("select DISTINCT sr.StudentFirstName as studentname " +
                        " from tbl_StudentRegistration sr where sr.Brid = " + HttpContext.Current.Session["BrBrid"].ToString() + " and sr.RID =" + rid + "").ToString();                       
            
            if (MobileNo.Length > 9)
            {
                string msg = msg1 + (Name.ToString()) + msg2 + msg3;
                int result = sendMessageToMobile.SMSSend(MobileNo, msg,api);
                return 5;
            }
            return 1;
        }
        catch
        {
            return 0;
        }
        finally
        {
            MobileNo = "";           
        }
    }

    public static DataTable examMaster(string p)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;
        param = new SqlParameter[1];
        param[0] = new SqlParameter("@whyCall", p);
        DataTable dt = objdut.GetDataTableSP(param, "masterprocforExam");
        return dt;
    }

    public int financialyear(string p)
    {
        param = new SqlParameter[1];
        param[0] = new SqlParameter("@whyCall", p);
        int result = Convert.ToInt32(objdut.GetScalerSP(param, "masterEnquiry"));
        return result;
    }

    public int GetActiveAcedmicYear()
    {
        param = new SqlParameter[1];
        param[0] = new SqlParameter("@whyCall", "ActiveAcademicYear");
        int result = Convert.ToInt32(objdut.GetScalerSP(param, "MasterProc"));
        return result;
    }

    public static DataTable examMaster(string p, int id, int brid)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;
        string param2 = string.Empty;
        string param3 = string.Empty;
        param = new SqlParameter[3];
        if (p == "topicmaster")
        {
            param3 = "@subid";
            param2 = "@classid";
        }
        else if (p == "batchmaster")
        {
            param2 = "@classid";
            param3 = "@brid";
        }
        else if (p == "topicstatus")
        {
            param2 = "@classid";
            param3 = "@subid";
        }
        else if (p == "batchmaster1")
        {
            param2 = "@classid";
            param3 = "@brid";
        }
        else if (p == "examatendance")
        {
            param2 = "@brid";
            param3 = "@testid";
        }
        else if (p == "examDetail")
        {
            param2 = "@brid";
            param3 = "@testid";
        }
        else if (p == "examus")
        {
            param2 = "@brid";
            param3 = "@testid";
        }
        else if (p == "add")
        {
            param2 = "@batchid";
            param3 = "@testid";
        }
        else if (p == "remove")
        {
            param2 = "@batchid";
            param3 = "@testid";
        }
        else if (p == "batchbind")
        {
            param2 = "@brid";
            param3 = "@testid";
        }
        else if (p == "fillgrid")
        {
            param2 = "@brid";
            param3 = "@testid";
        }
        else if (p == "fillgrid1")
        {
            param2 = "@brid";
            param3 = "@testid";
        }

        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, brid);
        param[2] = new SqlParameter(param3, id);
        DataTable dt = objdut.GetDataTableSP(param, "masterprocforExam");
        if (dt.Rows.Count > 0)
        {
        }
        return dt;
    }

    public static DataTable examMaster(string p, int id)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;
        string param2 = string.Empty;
        if (p == "testlist")
        {
            param2 = "@brid";
        }
        else if (p == "examstatuspendind")
        {
            param2 = "@brid";
        }
        else if (p == "examstatus")
        {
            param2 = "@brid";
        }
        else if (p == "coursedll")
        {
            param2 = "@classid";
        }
        else if (p == "testdetail1")
        {
            param2 = "@testid";
        }
        else if (p == "markattendance")
        {
            param2 = "@testid";
        }
        else if (p == "marksreport")
        {
            param2 = "@testid";
        }
        else if (p == "examstuinfo")
        {
            param2 = "@testid";
        }
        else if (p == "examstuinfo1")
        {
            param2 = "@testid";
        }
        else if (p == "classdll")
        {
            param2 = "@Brid";
        }
        param = new SqlParameter[2];
        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, id);
        DataTable dt = objdut.GetDataTableSP(param, "masterprocforExam");
        if (dt.Rows.Count > 0)
        {
        }
        return dt;
    }

    public static DataTable examMaster(string p, int id, int brid, int brid2)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;
        string param2 = string.Empty;
        string param3 = string.Empty;
        string param4 = string.Empty;
        param = new SqlParameter[4];
        if (p == "batchmasteredit")
        {
            param2 = "@brid";
            param3 = "@testid";
            param4 = "@classid";
        }
        else if (p == "filltopic")
        {
            param2 = "@subid";
            param3 = "@testid";
            param4 = "@classid";
        }
        else if (p == "admissionlistwithclasssection")
        {
            param2 = "@classid";
            param3 = "@sectionid";
            param4 = "@brid";
        }
        else if (p == "feereportbyid")
        {
            param2 = "@admissionid";
            param3 = "@academicyearid";
            param4 = "@brid";
        }

        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, id);
        param[2] = new SqlParameter(param3, brid);
        param[3] = new SqlParameter(param4, brid2);
        DataTable dt = objdut.GetDataTableSP(param, "masterprocforExam");
        if (dt.Rows.Count > 0)
        {
        }
        return dt;
    }

    public static DataTable invent(string p, int id)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;
        string param2 = string.Empty;
        if (p == "dll")
        {
            param2 = "@brid";
        }
        else if (p == "branch")
        {
            param2 = "@brid";
        }
        else if (p == "getlist1")
        {
            param2 = "@orderid";
        }

        param = new SqlParameter[2];
        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, id);
        DataTable dt = objdut.GetDataTableSP(param, "masterInventory");
        if (dt.Rows.Count > 0)
        {
        }

        return dt;
    }

    public DataTable dtCommon(string id, int mode)
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("id", id);
        param[1] = new SqlParameter("mode", mode);
        return objdut.GetDataTableSP(param, "usp_getRecords");
    }

    public DataTable Dll(string p)
    {
        param = new SqlParameter[1];
        param[0] = new SqlParameter("@whyCall", p);
        DataTable dt = objdut.GetDataTableSP(param, "MasterProc");
        return dt;
    }

    public static DataTable recentfee(string p, long id)
    {
        string param2 = string.Empty;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;

        if (p == "recentfee")
        {
            param2 = "@branchID";
        }
        else if (p == "monthfeereport")
        {
            param2 = "@branchID";
        }
        else if (p == "stufeereport")
        {
            param2 = "@adid";
        }

        param = new SqlParameter[2];
        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, id);
        DataTable dt = objdut.GetDataTableSP(param, "MasterProc");
        if (dt.Rows.Count > 0)
        {
        }

        return dt;
    }

    public static DataTable parentpanel(string p, string id)
    {
        string param2 = string.Empty;
        string param3 = string.Empty;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;
        param = new SqlParameter[2];
        if (p == "parentusercontrol")
        {
            param2 = "@sturegno";
        }

        if (p == "parentfees")
        {
            param2 = "@sturegno";
        }

        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, id);

        DataTable dt = objdut.GetDataTableSP(param, "MasterProc");
        if (dt.Rows.Count > 0)
        {
        }

        return dt;
    }

    public static DataTable parentdetails(string p, int id, int brid)
    {
        string param2 = string.Empty;
        string param3 = string.Empty;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;
        param = new SqlParameter[3];
        if (p == "parentdetals")
        {
            param2 = "@sturegno";
            param3 = "@branchID";
        }

        if (p == "getfilegrid")
        {
            param2 = "@sturegno";
            param3 = "@branchID";
        }

        if (p == "feetypeselected")
        {
            param2 = "@ssid";
            param3 = "@branchID";
        }
        if (p == "getstudentdata")
        {
            param2 = "@adid";
            param3 = "@branchID";
        }
        else if (p == "stufeereport")
        {
            param2 = "@adid";
            param3 = "@branchID";
        }
        else if (p == "getinfo")
        {
            param2 = "@adid";
            param3 = "@branchID";
        }
        else if (p == "fillstudentdeatils")
        {
            param2 = "@sturegno";
            param3 = "@branchID";
        }

        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, id);
        param[2] = new SqlParameter(param3, brid);

        DataTable dt = objdut.GetDataTableSP(param, "MasterProc");
        if (dt.Rows.Count > 0)
        {
        }

        return dt;
    }

    public static DataTable recentfee(string p, int id, int id1)
    {
        string param2 = string.Empty;
        string param3 = string.Empty;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;

        if (p == "monthfeereport")
        {
            param2 = "@branchID";
            param3 = "@monthid";
        }
        else if (p == "monthcollection")
        {
            param2 = "@branchID";
            param3 = "@monthid";
        }
        else if (p == "FeeRemaind")
        {
            param2 = "@branchID";
            param3 = "@monthid";
        }
        else if (p == "Regis_Mobile")
        {
            param2 = "@branchID";
            param3 = "@ccid";
        }
        else if (p == "Adm_Mobile")
        {
            param2 = "@branchID";
            param3 = "@ccid";
        }

        param = new SqlParameter[3];
        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, id);
        param[2] = new SqlParameter(param3, id1);
        DataTable dt = objdut.GetDataTableSP(param, "MasterProc");
        if (dt.Rows.Count > 0)
        {
        }

        return dt;
    }

    public static DataTable recentfee(string p, int id, int id1, int id2)
    {
        string param2 = string.Empty;
        string param3 = string.Empty;
        string param4 = string.Empty;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;

        if (p == "classcollection")
        {
            param2 = "@branchID";
            param3 = "@monthid";
            param4 = "@classid";
        }

        if (p == "getpaydate")
        {
            param2 = "@branchID";
            param3 = "@monthid";
            param4 = "@adid";
        }

        param = new SqlParameter[4];
        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, id);
        param[2] = new SqlParameter(param3, id1);
        param[3] = new SqlParameter(param4, id2);
        DataTable dt = objdut.GetDataTableSP(param, "MasterProc");
        if (dt.Rows.Count > 0)
        {
        }

        return dt;
    }

    public static double zxy(string p, int branchid, long id)
    {
        SqlParameter[] param;
        DataUtility objdut = new DataUtility();
        string param2 = string.Empty;
        string param3 = string.Empty;
        param = new SqlParameter[3];

        if (p == "collectionofmonth")
        {
            param2 = "@branchid";
            param3 = "@monthid";
        }
        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, branchid);
        param[2] = new SqlParameter(param3, id);

        double result = Convert.ToInt32(objdut.GetScalerSP(param, "MasterProc"));
        return result;
    }

    public static double Scaler(string p, int branchid, int id)
    {
        SqlParameter[] param;
        DataUtility objdut = new DataUtility();
        string param2 = string.Empty;
        string param3 = string.Empty;
        param = new SqlParameter[3];

        if (p == "collectionofmonth")
        {
            param2 = "@branchid";
            param3 = "@monthid";
        }

        if (p == "studentregno")
        {
            param2 = "@branchid";
            param3 = "@sturegno";
        }

        if (p == "countclass_student")
        {
            param2 = "@branchid";
            param3 = "@classid";
        }
        if (p == "checkadno")
        {
            param2 = "@branchid";
            param3 = "@adid";
        }
        if (p == "getPaytype")
        {
            param2 = "@branchid";
            param3 = "@adid";
        }
        if (p == "getTransType")
        {
            param2 = "@branchid";
            param3 = "@adid";
        }
        if (p == "gettoppaymonth")
        {
            param2 = "@branchid";
            param3 = "@adid";
        }
        if (p == "getclassid")
        {
            param2 = "@branchid";
            param3 = "@adid";
        }

        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, branchid);
        param[2] = new SqlParameter(param3, id);

        double result = Convert.ToInt32(objdut.GetScalerSP(param, "MasterProc"));
        return result;
    }

    public DataTable Dll(string p, int id)
    {
        string param2 = string.Empty;
        if (p == "GetHouse")
        {
            param2 = "@branchID";
        }
        if (p == "Statedll")
        {
            param2 = "@COUNTRYID";
        }
        else if (p == "Citydll")
        {
            param2 = "@Stateid";
        }
        else if (p == "sectiondll")
        {
            param2 = "@classid";
        }
        else if (p == "ClassInBranch")
        {
            param2 = "@branchID";
        }
        else if (p == "recentfee")
        {
            param2 = "@branchID";
        }
       
        param = new SqlParameter[2];
        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, id);
        DataTable dt = objdut.GetDataTableSP(param, "MasterProc");
        if (dt.Rows.Count > 0)
        {
        }

        return dt;
    }

    public DataTable Dll(string p, int id, int brid)
    {
        string param2 = string.Empty;
        string param3 = string.Empty;
        param = new SqlParameter[3];
        if (p == "sectiondll")
        {
            param2 = "@BranchId";
            param3 = "@classid";
        }
        if (p == "GetHouse")
        {
            param2 = "@BranchId";
            param3 = "@fyid";
        }
        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, brid);
        param[2] = new SqlParameter(param3, id);
        DataTable dt = objdut.GetDataTableSP(param, "MasterProc");
        if (dt.Rows.Count > 0)
        {
        }
        return dt;
    }

    public string stringType(string p, string strng)
    {
        param = new SqlParameter[2];
        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter("@date1", strng);

        string result = Convert.ToString(objdut.GetScalerSP(param, "MasterProc"));
        return result;
    }

    public static DataTable ABC(string p)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;
        param = new SqlParameter[1];
        param[0] = new SqlParameter("@whyCall", p);
        DataTable dt = objdut.GetDataTableSP(param, "MasterProc");
        return dt;
    }

    public static DataTable ABC(string p,int id)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;
        param = new SqlParameter[2];
        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter("@Financialyearid",id);
        DataTable dt = objdut.GetDataTableSP(param, "MasterProc");
        return dt;
    }

    public static DataTable NameFun(string p, int id, string name)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;
        string param2 = string.Empty;
        string param3 = string.Empty;
        param = new SqlParameter[3];
        if ((p == "RegistrationListwithname"))
        {
            param2 = "@BranchId";
            param3 = "@name";
        }
        else if ((p == "RegistrationListwithfname"))
        {
            param2 = "@BranchId";
            param3 = "@fname";
        }
        else if ((p == "RegistrationListwithfdate"))
        {
            param2 = "@BranchId";
            param3 = "@fdate";
        }
        else if ((p == "RegistrationListwithtodate"))
        {
            param2 = "@BranchId";
            param3 = "@fdate";
        }
        else if ((p == "Searchbyregistration"))
        {
            param2 = "@branchId";
            param3 = "@regno";
        }
        else if (p == "admissionlistwithfdate")
        {
            param2 = "@branchId";
            param3 = "@fdate";
        }
        else if (p == "admissionlistwithname")
        {
            param2 = "@branchId";
            param3 = "@name";
        }
        else if (p == "admissionlistwithfname")
        {
            param2 = "@branchId";
            param3 = "@fname";
        }
        else if (p == "admissionlistwithaddno")
        {
            param2 = "@branchId";
            param3 = "@name";
        }
        else if (p == "listwithname")
        {
            param2 = "@branchId";
            param3 = "@name";
        }
        else if (p == "listwithfname")
        {
            param2 = "@branchId";
            param3 = "@fname";
        }
        else if (p == "bindstudentfee")
        {
            param2 = "@branchId";
            param3 = "@name";
        }
        else if (p == "studentfeewithdiscount")
        {
            param2 = "@branchID";
            param3 = "@sturegno";
        }

        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, id);
        param[2] = new SqlParameter(param3, name);
        DataTable dt = objdut.GetDataTableSP(param, "MasterProc");
        if (dt.Rows.Count > 0)
        {
        }
        return dt;
    }

    public static DataTable ABC1(string p, int id)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;
        string param2 = string.Empty;
        if (p == "Statedll")
        {
            param2 = "@COUNTRYID";
        }
        else if (p == "Citydll")
        {
            param2 = "@Stateid";
        }
        else if (p == "sectiondll")
        {
            param2 = "@classid";
        }
        else if ((p == "ClassInBranch") || (p == "GetAllDepartment") || (p == "GetAllDesignation") || (p == "classMasterBranch"))
        {
            param2 = "@branchID";
        }
        else if (p == "areanamedll")
        {
            param2 = "@zoneid";
        }
        else if (p == "GetAllDesignationinSingledepartment")
        {
            param2 = "@deptid";
        }
        else if (p == "GetAllsubcatinsinglecat")
        {
            param2 = "@catid";
        }
        else if (p == "ReceiveOrderList")
        {
            param2 = "@receiverid";
        }
        else if (p == "RegistrationList")
        {
            param2 = "@branchID";
        }
        else if (p == "RoleUser")
        {
            param2 = "@assco";
        }
        else if (p == "Getddlcountryh")
        {
            param2 = "@ccid";
        }
        else if (p == "admissionddl")
        {
            param2 = "@branchid";
        }
        else if (p == "Getaddclassbranch")
        {
            param2 = "@classbranchid";
        }
        else if (p == "admissionlist")
        {
            param2 = "@branchid";
        }
        else if (p == "editstate")
        {
            param2 = "@stateid";
        }
        else if (p == "getfeetyperecord")
        {
            param2 = "@branchID";
        }
        else if (p == "finecollection")
        {
            param2 = "@branchID";
        }
        else if (p == "discountcollection")
        {
            param2 = "@branchID";
        }
        else if (p == "DdlMonth")
        {
            param2 = "@Financialyearid";
        }
        else if (p == "fillgridfee")
        {
            param2 = "@Financialyearid";
        }
        else if (p == "GetClassDDL")
        {
            param2 = "@BranchID";
        }
        else if (p == "GetMonthForAttendance")
        {
            param2 = "@Financialyearid";
        }
        else if (p == "MonthName")
        {
            param2 = "@Financialyearid";
        }
        param = new SqlParameter[2];
        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, id);
        DataTable dt = objdut.GetDataTableSP(param, "MasterProc");
        if (dt.Rows.Count > 0)
        {
        }
        return dt;
    }

    public static DataTable ABC(string p, int id, int brid)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;
        string param2 = string.Empty;
        string param3 = string.Empty;
        param = new SqlParameter[3];
          if (p == "stuDentDetails")
        {
            param2 = "@sturegno";
            param3 = "@branchID";
        }
          else if (p == "ShowFeeStructurewr")
        {
            param2 = "@classid";
            param3 = "@branchID";
        }
        else if (p == "sectiondll")
        {
            param2 = "@classid";
            param3 = "@BranchId";
        }
        else if (p == "RegistrationListwithddlclass")
        {
            param2 = "@classid";
            param3 = "@branchID";
        }
        else if (p == "admissionlistwithddl")
        {
            param2 = "@classid";
            param3 = "@branchID";
        }
        else if (p == "GetClassDDL")
        {
            param2 = "@Financialyearid";
            param3 = "@BranchID";
        }


        param[0] = new SqlParameter("@whyCall", p);
        param[1] = new SqlParameter(param2, id);
        param[2] = new SqlParameter(param3, brid);
        DataTable dt = objdut.GetDataTableSP(param, "MasterProc");
        if (dt.Rows.Count > 0)
        {
        }
        return dt;
    }

    public static int Scaler(string p)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param;
        param = new SqlParameter[1];
        param[0] = new SqlParameter("@whyCall", p);
        int result = Convert.ToInt32(objdut.GetScalerSP(param, "MasterProc"));
        return result;
    }

    public static int scaler(string p, int id)
    {
        SqlParameter[] param;
        DataUtility objdut = new DataUtility();
        string param2 = string.Empty;
        param = new SqlParameter[2];
        param[0] = new SqlParameter("@whyCall", p);
        if (p == "getdays")
        {
            param2 = "@monthid";
        }
        else if (p == "CheckREGNo")
        {
            param2 = "@rid";
        }
        else if (p == "sizeofpage")
        {
            param2 = "@branchID";
        }
        else if (p == "countstudentwithtransport")
        {
            param2 = "@branchID";
        }
        else if (p == "countstudentnotransport")
        {
            param2 = "@branchID";
        }
        else if (p == "counttodayfeestudents")
        {
            param2 = "@branchID";
        }

        param[1] = new SqlParameter(param2, id);

        int result = Convert.ToInt32(objdut.GetScalerSP(param, "MasterProc"));
        return result;
    }

    public static int scaler(string p, string id, int brid)
    {
        SqlParameter[] param;
        DataUtility objdut = new DataUtility();
        string param2 = string.Empty;
        string param3 = string.Empty;
        param = new SqlParameter[3];
        param[0] = new SqlParameter("@whyCall", p);
        if (p == "countnamewisestudent")
        {
            param2 = "@name";
            param3 = "@branchID";
        }

        if (p == "getstudentregno")
        {
            param2 = "@name";
            param3 = "@branchID";
        }

        param[1] = new SqlParameter(param2, id);
        param[2] = new SqlParameter(param3, brid);

        int result = Convert.ToInt32(objdut.GetScalerSP(param, "MasterProc"));
        return result;
    }

    public static int Scaler(string p, int id)
    {
        DataUtility objdut = new DataUtility();
        string param2 = string.Empty;
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@whyCall", p);
        if (p == "getdays")
        {
            param2 = "@monthid";
        }
        else if (p == "CheckREGNo")
        {
            param2 = "@rid";
        }
        else if (p == "getpayid")
        {
            param2 = "@fyforpayid";
        }

        param[1] = new SqlParameter(param2, id);

        int result = Convert.ToInt32(objdut.GetScalerSP(param, "MasterProc"));

        return result;
    }
}