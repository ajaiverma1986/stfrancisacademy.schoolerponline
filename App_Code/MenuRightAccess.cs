using DataObjects.DBAccess;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public class MenuRightAccess
{
    private DataUtility objDUT = new DataUtility();
    private SqlConnection conn = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());

    public int SaveRightInformation(string RightXml)
    {
        int returnValue = 0;
        SqlParameter[] RightParam = new SqlParameter[3];
        try
        {
            RightParam[0] = new SqlParameter("@RightXml", RightXml);
            RightParam[1] = new SqlParameter("@QueryType", "SaveModule");
            RightParam[2] = new SqlParameter("@intResult", SqlDbType.Int);
            RightParam[2].Direction = ParameterDirection.Output;

            //returnValue = objDUT.ExecuteSqlSP(RightParam, "[uspModulePermission]");
            returnValue = SqlHelper.ExecuteNonQuery(conn, CommandType.StoredProcedure, "[dbo].[uspModulePermission]", RightParam);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return returnValue;
    }
}