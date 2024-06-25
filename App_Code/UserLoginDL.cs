using System;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for UserLoginDL
/// </summary>
public class UserLoginDL
{
    public UserLoginDL()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public bool CheckUser(string uid, string pass)
    {
        // Create object of DataUtility

        DataUtility objDUT = new DataUtility();
        Utility uti = new Utility();
        bool blFlag, f;

        f = uti.IsNumeric(uid);
        if (f)
        {
            string strSql = " select COUNT(memcode) from Member_Login where memcode=@UserName and Password=@Password";

            // Create SqlParameter object.
            SqlParameter[] arrParam = new SqlParameter[2];
            arrParam[0] = new SqlParameter("@UserName", SqlDbType.VarChar, 100);
            arrParam[0].Value = uid;
            arrParam[1] = new SqlParameter("@Password", SqlDbType.VarChar, 50);
            arrParam[1].Value = pass;
            blFlag = objDUT.IsExist(arrParam, strSql);
        }
        else
        {
            string strSql = " select COUNT(Loginid) from Member_Login where loginid=@UserName and Password=@Password";

            // Create SqlParameter object.
            SqlParameter[] arrParam = new SqlParameter[2];
            arrParam[0] = new SqlParameter("@UserName", SqlDbType.VarChar, 100);
            arrParam[0].Value = uid;
            arrParam[1] = new SqlParameter("@Password", SqlDbType.VarChar, 50);
            arrParam[1].Value = pass;
            blFlag = objDUT.IsExist(arrParam, strSql);
        }
        return blFlag;
    }

    public object getMemCode(string uid)
    {
        DataUtility objDUT = new DataUtility();
        string strSql = " select memCode from Member_Login where loginid=@UserName";

        // Create SqlParameter object.
        SqlParameter[] arrParam = new SqlParameter[1];
        arrParam[0] = new SqlParameter("@UserName", SqlDbType.VarChar, 100);
        arrParam[0].Value = uid;
        object blFlag = objDUT.GetScaler(arrParam, strSql);
        return blFlag;
    }

    public SqlDataReader getMemLoginDetails(string uid)
    {
        DataUtility objDUT = new DataUtility();
        Utility uti = new Utility();
        bool f;
        SqlDataReader blReader;
        f = uti.IsNumeric(uid);
        if (f)
        {
            string strSql = " select M.MemName as Memname, L.lastLogin from Member_Login L,Member_Master M where L.memcode=@UserName and L.regno=M.regno";

            // Create SqlParameter object.
            SqlParameter[] arrParam = new SqlParameter[1];
            arrParam[0] = new SqlParameter("@UserName", SqlDbType.Decimal);
            arrParam[0].Value = Convert.ToDecimal(uid);
            blReader = objDUT.GetDataReader(arrParam, strSql);
        }
        else
        {
            string strSql = " select M.MemName as Memname, L.lastLogin from Member_Login L,Member_Master M where L.loginid=@UserName and L.regno=M.regno";

            // Create SqlParameter object.
            SqlParameter[] arrParam = new SqlParameter[1];
            arrParam[0] = new SqlParameter("@UserName", SqlDbType.VarChar, 100);
            arrParam[0].Value = uid;
            blReader = objDUT.GetDataReader(arrParam, strSql);
        }
        return blReader;
    }
}