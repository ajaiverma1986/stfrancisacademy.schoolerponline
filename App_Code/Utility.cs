//***************************************************
//  Creator Name    : Ranjan
//  Creation Date   : 17/10/2010
//  Reason          : To create all BLS.
//  Updated By      :
//  Update Date     : 26/10/2016
//***************************************************

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;

/// <summary>
/// This class work as a Model,
/// all BL driven generic methods to be placed here.
/// </summary>
public class Utility
{
    private DataUtility objDUT = new DataUtility();

    public Utility()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    /// <summary>
    /// This is created to show user defined message.
    /// </summary>
    /// <param name="msg">Enum</param>
    /// <returns>String</returns>

    public string ShowMsg(MsgType msg)
    {
        switch (msg)
        {
            case MsgType.DELETE:
                return ConfigurationManager.AppSettings["DeleteMsg"].ToString();

            case MsgType.INSERT:
                return ConfigurationManager.AppSettings["InsertMsg"].ToString();

            case MsgType.ERROR:
                return ConfigurationManager.AppSettings["ErrorMsg"].ToString();

            case MsgType.ISEXIST:
                return ConfigurationManager.AppSettings["ExistMsg"].ToString();

            case MsgType.UPDATE:
                return ConfigurationManager.AppSettings["UpdateMsg"].ToString();

            case MsgType.UNDEFINE:
                return ConfigurationManager.AppSettings["UndefineMsg"].ToString();

            case MsgType.LOGINPASSWORD:
                return ConfigurationManager.AppSettings["LoginMsg"].ToString();

            case MsgType.PARENTNOT:
                return ConfigurationManager.AppSettings["ParentMsg"].ToString();

            case MsgType.PARENTFULL:
                return ConfigurationManager.AppSettings["ParentFullMsg"].ToString();

            case MsgType.PARENTNOTINTREE:
                return ConfigurationManager.AppSettings["ParetnTreeMsg"].ToString();

            case MsgType.SPONSOR:
                return ConfigurationManager.AppSettings["SponsorMsg"].ToString();

            case MsgType.ASSOCIATE:
                return ConfigurationManager.AppSettings["AssociateMsg"].ToString();

            case MsgType.SPONSOREXIST:
                return ConfigurationManager.AppSettings["SponsorEMsg"].ToString();

            case MsgType.BOARD:
                return ConfigurationManager.AppSettings["BoardMsg"].ToString();

            case MsgType.STATENOT:
                return ConfigurationManager.AppSettings["StateMsg"].ToString();

            case MsgType.LOGINALREADY:
                return ConfigurationManager.AppSettings["LoginAlreadyMsg"].ToString();

            case MsgType.ACSTATEMENT:
                return ConfigurationManager.AppSettings["ACStatementMsg"].ToString();

            case MsgType.SPONSORLIST:
                return ConfigurationManager.AppSettings["SponsorList"].ToString();

            case MsgType.DOWNLINE:
                return ConfigurationManager.AppSettings["DownlineList"].ToString();

            case MsgType.CHILDLIST:
                return ConfigurationManager.AppSettings["ChildList"].ToString();

            default:
                return "Error !!";
                break;
        }
    }

    /// <summary>
    /// This method check input string is numeric or not.
    /// If numeric return true else false.
    /// Creation Date : 23/10/2007.
    /// </summary>
    /// <param name="strValue">string</param>
    /// <returns>bool</returns>
    public bool IsNumeric(string strValue)
    {
        string strValidChars = "0123456789";
        bool Flag = true;
        for (int i = 0; i < strValue.Length && Flag == true; i++)
        {
            char s = Convert.ToChar(strValue.Substring(i, 1));
            if (strValidChars.IndexOf(s) == -1)
            {
                Flag = false;
            }
        }
        return Flag;
    }

    public static bool isValidEmail(string inputEmail)
    {
        string strRegex = @"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}" +
              @"\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\" +
              @".)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$";
        Regex re = new Regex(strRegex);
        if (re.IsMatch(inputEmail))
            return (true);
        else
            return (false);
    }

    /// <summary>
    /// This method is used to get registration number.
    /// Pass Random Id as argument.
    /// Creation Date : 23/10/2007.
    /// </summary>
    /// <param name="strValue">string</param>
    /// <returns>long, Registration Number</returns>
    public long GetAdmissionno(string strValue)
    {
        long lngRegNo = 0;
        long lngRegNos = 0;
        bool Flag = IsNumeric(strValue);
        // Create Datautility object.
        DataUtility objDUT = new DataUtility();
        if (Flag)
        {
            long lngMemCode = Convert.ToInt64(strValue.Trim());
            string strSql = "Select adid from tbl_admission where adno=@lngMemCode";

            SqlParameter[] arrParam = new SqlParameter[1];
            arrParam[0] = new SqlParameter("@lngMemCode", SqlDbType.BigInt); // change to bigint
            arrParam[0].Value = lngMemCode;
            SqlDataReader dReader = objDUT.GetDataReader(arrParam, strSql);
            while (dReader.Read())
            {
                lngRegNo = Convert.ToInt64(dReader["adid"]);
            }
            return lngRegNo;
        }
        else
        {
            string strLoginId = strValue.Trim();
            string strSqlRegno = "Select adid from tbl_admission where adno= @strLoginId";
            SqlParameter[] arrParams = new SqlParameter[1];
            arrParams[0] = new SqlParameter("@strLoginId", SqlDbType.VarChar, 50);
            arrParams[0].Value = strLoginId;
            SqlDataReader dReader = objDUT.GetDataReader(arrParams, strSqlRegno);
            while (dReader.Read())
            {
                lngRegNos = Convert.ToInt64(dReader["Adid"]);
            }
            return lngRegNos;
        }
    }

    /// <summary>
    /// This method is used to get registration number.
    /// Pass Member Registration number as argument.
    /// Creation Date : 23/10/2007.
    /// </summary>
    /// <param name="strValue">string</param>
    /// <returns>long, Registration Number</returns>
    public long GetRegistrationNo(string strValue)
    {
        long lngRegNo = 0;
        long lngRegNos = 0;
        bool Flag = IsNumeric(strValue);
        // Create Datautility object.
        DataUtility objDUT = new DataUtility();
        if (Flag)
        {
            long lngMemCode = Convert.ToInt64(strValue.Trim());
            string strSql = "Select isnull(rid,0) as rid from tbl_StudentRegistration where Registration_No=@lngMemCode ";
            SqlParameter[] arrParam = new SqlParameter[1];
            arrParam[0] = new SqlParameter("@lngMemCode", SqlDbType.VarChar, 50); // change to bigint
            arrParam[0].Value = strValue.Trim();
            SqlDataReader dReader = objDUT.GetDataReader(arrParam, strSql);
            while (dReader.Read())
            {
                lngRegNo = Convert.ToInt64(dReader["rid"]);
            }
            return lngRegNo;
        }
        else
        {
            string strLoginId = strValue.Trim();
            string strSqlRegno = "Select isnull(rid,0) as rid from tbl_StudentRegistration where Registration_No= @strLoginId";
            SqlParameter[] arrParams = new SqlParameter[1];
            arrParams[0] = new SqlParameter("@strLoginId", SqlDbType.VarChar, 50);
            arrParams[0].Value = strLoginId;
            SqlDataReader dReader = objDUT.GetDataReader(arrParams, strSqlRegno);
            while (dReader.Read())
            {
                lngRegNos = Convert.ToInt64(dReader["rid"]);
            }
            return lngRegNos;
        }
    }

    /// <summary>
    ///  This method is used to get plot registration Number Wrt. Customer ID.
    /// Pass customer Id TO get Plot registration no.
    /// </summary>
    /// <param name="cid"></param>
    /// <returns></returns>
    public long GetPlotRegistrationNo(string cid)
    {
        long lngPlotno = 0;
        bool Flag = IsNumeric(cid);
        // Create Datautility object.
        DataUtility objDUT = new DataUtility();
        if (Flag)
        {
            lngPlotno = Convert.ToInt32(cid);
            string strSql = " SELECT plotregno FROM Customer_master WHERE custid=@cid";
            SqlParameter[] arrParam = new SqlParameter[1];
            arrParam[0] = new SqlParameter("@cid", SqlDbType.BigInt); // change to bigint
            arrParam[0].Value = lngPlotno;
            SqlDataReader dReader = objDUT.GetDataReader(arrParam, strSql);
            if (dReader.HasRows)
            {
                while (dReader.Read())
                {
                    lngPlotno = Convert.ToInt64(dReader["plotregno"]);
                }
                return lngPlotno;
            }
            else
            {
                return 0;
            }
        }
        else
        {
            return 0;
        }
    }

    /// <summary>
    /// This method is used to get Customer ID Wrt. plot registration Number.
    /// Pass customer Id TO get Plot registration no.
    /// </summary>
    /// <param name="plotregno"></param>
    /// <returns></returns>
    public long GetCustomerId(string plotregno)
    {
        long lngPlotno = 0;
        bool Flag = IsNumeric(plotregno);
        // Create Datautility object.
        DataUtility objDUT = new DataUtility();
        if (Flag)
        {
            lngPlotno = Convert.ToInt64(plotregno);
            string strSql = "SELECT custid FROM Customer_plot WHERE plotregno=@cid";
            SqlParameter[] arrParam = new SqlParameter[1];
            arrParam[0] = new SqlParameter("@cid", SqlDbType.BigInt); // change to bigint
            arrParam[0].Value = lngPlotno;
            SqlDataReader dReader = objDUT.GetDataReader(arrParam, strSql);
            if (dReader.HasRows)
            {
                while (dReader.Read())
                {
                    lngPlotno = Convert.ToInt64(dReader["custid"].ToString());
                }
                return lngPlotno;
            }
            else
            {
                return 0;
            }
        }
        else
        {
            return 0;
        }
    }

    /// <summary>
    /// This method is used to get Login Id of that registration number or Member Code.
    /// Creation Date : 23/10/2007.
    /// </summary>
    /// <param name="lngRegNo">long, Registration Number or Member Code</param>
    /// <returns>string, Login Id</returns>
    public string GetLoginId(long lngRegNo)
    {
        string strLoginId = String.Empty;
        // Create Datautility object.
        DataUtility objDUT = new DataUtility();
        string strSql = " select loginid from Member_master where regno =@lngRegNo";
        SqlParameter[] arrParam = new SqlParameter[1];
        arrParam[0] = new SqlParameter("@lngRegNo", SqlDbType.Int, 8); // replace with bigint
        arrParam[0].Value = lngRegNo;
        SqlDataReader dReader = objDUT.GetDataReader(arrParam, strSql);
        while (dReader.Read())
        {
            strLoginId = dReader["loginid"].ToString();
        }
        return strLoginId;
        //dReader.Close();
    }

    /// <summary>
    /// This method is used to get Multiple Login Id According to multiple Registration Number.
    /// Creation Date : 23/10/2007.
    /// </summary>
    /// <param name="strRegNo">string, Multiple Registration Number </param>
    /// <returns>string, Multiple Login Id</returns>
    public string GetLoginId(string strRegNo)
    {
        string strLoginId = String.Empty;
        // Create Datautility object.
        DataUtility objDUT = new DataUtility();
        string strSql = " select loginid from Member_master where regno in (" + strRegNo + ")"; // =@lngRegNo or memcode=@lngRegNo";
        // SqlParameter[] arrParam = new SqlParameter[1];
        //arrParam[0] = new SqlParameter("@strRegNo", SqlDbType.VarChar);
        //arrParam[0].Value = strRegNo;
        SqlDataReader dReader = objDUT.GetDataReader(strSql);
        while (dReader.Read())
        {
            strLoginId = strLoginId + dReader["loginid"].ToString();
            strLoginId = strLoginId + ",";
        }
        return strLoginId;
    }

    /// <summary>
    /// This method is used to get Member Code of that registration number or loginid.
    /// Creation Date : 23/10/2007.
    /// </summary>
    /// <param name="strValue">string, Registraion Number or LoginId</param>
    /// <returns>long, MemberCode</returns>
    public long GetMemberCode(string strValue)
    {
        long lngMemCode = 0;
        long lngMemCodes = 0;
        bool Flag = IsNumeric(strValue);
        // Create Datautility object.
        DataUtility objDUT = new DataUtility();
        if (Flag)
        {
            long lngRegNo = Convert.ToInt64(strValue.Trim());
            string strSql = " select memcode from Member_master where regno = @lngRegNo";
            SqlParameter[] arrParam = new SqlParameter[1];
            arrParam[0] = new SqlParameter("@lngRegNo", SqlDbType.Int, 4); // replace with bigint
            arrParam[0].Value = lngRegNo;
            SqlDataReader dReader = objDUT.GetDataReader(arrParam, strSql);
            while (dReader.Read())
            {
                lngMemCode = Convert.ToInt64(dReader["memcode"]);
            }
            return lngMemCode;
        }
        else
        {
            string strLoginId = strValue.Trim();
            string strSqlMemCode = " select memcode from Member_master where loginid = @strLoginId";
            SqlParameter[] arrParams = new SqlParameter[1];
            arrParams[0] = new SqlParameter("@strLoginId", SqlDbType.VarChar, 50);
            arrParams[0].Value = strLoginId;
            SqlDataReader dReader = objDUT.GetDataReader(arrParams, strSqlMemCode);
            while (dReader.Read())
            {
                lngMemCodes = Convert.ToInt64(dReader["memcode"]);
            }
            return lngMemCodes;
        }
    }

    /// <summary>
    /// This method is used to get Randomid of that registration number or loginid.
    /// Creation Date : 07/05/2010.
    /// </summary>
    /// <param name="strValue">string, Registraion Number or LoginId</param>
    /// <returns>long, MemberCode</returns>
    public string GetRandomid(string strValue)
    {
        string lngMemCode = "";
        string lngMemCodes = "";
        bool Flag = IsNumeric(strValue);
        // Create Datautility object.
        DataUtility objDUT = new DataUtility();
        if (Flag)
        {
            long lngRegNo = Convert.ToInt64(strValue.Trim());
            string strSql = "Select randomid from Member_master where regno=@lngRegNo";
            SqlParameter[] arrParam = new SqlParameter[1];
            arrParam[0] = new SqlParameter("@lngRegNo", SqlDbType.Int, 4); // replace with bigint
            arrParam[0].Value = lngRegNo;
            SqlDataReader dReader = objDUT.GetDataReader(arrParam, strSql);
            while (dReader.Read())
            {
                lngMemCode = Convert.ToString(dReader["randomid"]);
            }
            return lngMemCode;
        }
        else
        {
            string strLoginId = strValue.Trim();
            string strSqlMemCode = " select randomid from Member_master where loginid = @strLoginId";
            SqlParameter[] arrParams = new SqlParameter[1];
            arrParams[0] = new SqlParameter("@strLoginId", SqlDbType.VarChar, 50);
            arrParams[0].Value = strLoginId;
            SqlDataReader dReader = objDUT.GetDataReader(arrParams, strSqlMemCode);
            while (dReader.Read())
            {
                lngMemCodes = Convert.ToString(dReader["randomid"]);
            }
            return lngMemCodes;
        }
    }

    public int agentStatus(long regno)
    {
        int val = 1;
        DataUtility objDUT = new DataUtility();
        SqlDataReader dr = objDUT.GetDataReader("select approved,lvlid from member_master where regno = " + regno);
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                if (Convert.ToInt32(dr["approved"]) == 0)
                {
                    val = 1;
                }
                else if ((Convert.ToInt32(dr["approved"]) == 1) && (Convert.ToInt32(dr["lvlid"]) <= 1))
                {
                    val = 2;
                }
                else
                {
                    val = 0;
                }
            }
        }
        return val;
    }

    public Double calBV(Double amount, int Y, int plan)
    {
        DataUtility objDUT = new DataUtility();
        String Query;
        Double MaxSlab, BV;
        if (plan == 0)
        {
            if (Y == 1)
            {
                Query = "Select top 1 IPP1 from SLABRATES order by levels desc";
            }
            else if (Y == 2)
            {
                Query = "Select top 1 IPP2 from SLABRATES order by levels desc";
            }
            else
            {
                Query = "Select top 1 IPP3 from SLABRATES order by levels desc";
            }
        }
        else
        {
            Query = "Select top 1 cdpp from SLABRATES order by levels desc";
        }
        MaxSlab = Convert.ToDouble(objDUT.GetScalar(Query).ToString());

        BV = (amount * 100) / MaxSlab;

        return BV;
    }

    public bool isLeapYear(int year)
    {
        bool isLeap = true;
        if (year % 4 == 0)
        {
            if (year % 100 == 0)
            {
                if (year % 400 == 0)
                    isLeap = true;
                else isLeap = false;
            }
        }
        else
        {
            isLeap = false;
        }

        return isLeap;
    }

    public int getYear(string insType, int cInstallmentno)
    {
        int noofyear = 0;

        if (insType == "Monthly")
        {
            if (cInstallmentno < 13)
                noofyear = 1;
            if (cInstallmentno >= 13 && cInstallmentno < 25)
                noofyear = 2;
            if (cInstallmentno >= 25 && cInstallmentno < 37)
                noofyear = 3;
            if (cInstallmentno >= 37 && cInstallmentno < 49)
                noofyear = 4;
            if (cInstallmentno >= 49 && cInstallmentno < 61)
                noofyear = 5;
            if (cInstallmentno >= 61)
                noofyear = 6;
        }
        if (insType == "Quaterly")
        {
            if (cInstallmentno <= 4)
                noofyear = 1;
            if (cInstallmentno > 4 && cInstallmentno <= 8)
                noofyear = 2;
            if (cInstallmentno > 8 && cInstallmentno <= 12)
                noofyear = 3;
            if (cInstallmentno > 12 && cInstallmentno <= 16)
                noofyear = 4;
            if (cInstallmentno > 16 && cInstallmentno <= 20)
                noofyear = 5;
            if (cInstallmentno > 20)
                noofyear = 6;
        }
        if (insType == "HalfYearly")
        {
            if (cInstallmentno <= 2)
                noofyear = 1;
            if (cInstallmentno > 2 && cInstallmentno <= 4)
                noofyear = 2;
            if (cInstallmentno > 4 && cInstallmentno <= 6)
                noofyear = 3;
            if (cInstallmentno > 6 && cInstallmentno <= 8)
                noofyear = 4;
            if (cInstallmentno > 8 && cInstallmentno <= 10)
                noofyear = 5;
            if (cInstallmentno > 10)
                noofyear = 6;
        }
        if (insType == "Yearly")
        {
            noofyear = cInstallmentno;
        }
        return noofyear;
    }

    #region RepeaterCurrentRowCssClass

    private static int rowCounter = 0;

    public static string RepeaterCurrentRowCssClass
    {
        get
        {
            string toReturn = "";
            if (rowCounter % 2 == 0)
            {
                toReturn = "bg_grey";
            }
            if (rowCounter == Int32.MaxValue)
            {
                rowCounter = 0;
            }
            else
            {
                rowCounter++;
            }
            return toReturn;
        }
    }

    #endregion RepeaterCurrentRowCssClass

    public static void ViewAlertMessage(Page page, string msg)
    {
        ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "Key", "<script language='javascript'>alert('" + msg + "');</script>", false);
    }

    ///<Summry>
    ///This method check the permission of an user on page
    /// </Summry>
    /// <param name="userId">bigint</param>
    /// <param name="PageName">string</param>
    /// <returns>bool</returns>
    public Boolean isAccessible(Int64 userId, string pageName)
    {
        Boolean Flag = true;
        Int32 result = 0;
        SqlParameter[] arrParam = new SqlParameter[3];
        arrParam[0] = new SqlParameter("@userId", SqlDbType.BigInt); // change to bigint
        arrParam[0].Value = userId;
        arrParam[1] = new SqlParameter("@pageName", SqlDbType.VarChar, 50); // change to bigint
        arrParam[1].Value = pageName;
        arrParam[2] = new SqlParameter("@intResult", SqlDbType.Int);
        arrParam[2].Direction = ParameterDirection.Output;

        result = Convert.ToInt32(objDUT.ExecuteSqlSP(arrParam, "USP_checkPermission").ToString());
        if (result == 0)
            Flag = false;
        else
            Flag = true;
        return Flag;
    }

    public double taxFraction(double Amount, double taxRate)
    {
        double tax = 0;
        tax = (Amount * (taxRate / (taxRate + 100)));
        return tax;
    }

    //#region Get Page Name

    public static string GetCurrentPagename()
    {
        string sPath = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
        System.IO.FileInfo oInfo = new System.IO.FileInfo(sPath);
        string sRet = oInfo.Name;

        return sRet;
    }

    //#endregion Get Page Name
}