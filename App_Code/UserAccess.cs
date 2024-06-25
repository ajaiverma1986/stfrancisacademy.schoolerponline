/*-------------------------------------------------------
<copyright file="UserAccess.cs" company="ALPS">
Copyright (c) All rights reserved.
</copyright>
----------------------------------------------------------*/

using System;
using System.Data;
using System.Data.SqlClient;

public class UserAccess : DataUtility
{
    private DataUtility objDUT = new DataUtility();

    public UserAccess()
    {
    }

    public int SaveUserInformation(User objUser)
    {
        int returnValue = 0;
        try
        {
            SqlParameter[] UserParam = new SqlParameter[9];
            int zeroValue = 0;
            UserParam[0] = (objUser.UserID != 0) ? new SqlParameter("@UId", objUser.UserID) : new SqlParameter("@UId", zeroValue);
            UserParam[1] = (objUser.AssociatedToID != 0) ? new SqlParameter("@AssociatedToID", objUser.AssociatedToID) : new SqlParameter("@AssociatedToID", zeroValue);
            UserParam[2] = (objUser.AssociationID != 0) ? new SqlParameter("@AssociationID", objUser.AssociationID) : new SqlParameter("@AssociationID", zeroValue);
            UserParam[3] = (objUser.UserName != "") ? new SqlParameter("@UserName", objUser.UserName) : new SqlParameter("@UserName", DBNull.Value);
            UserParam[4] = (objUser.Password != "") ? new SqlParameter("@Password", objUser.Password) : new SqlParameter("@Password", DBNull.Value);
            UserParam[5] = (objUser.RoleID != 0) ? new SqlParameter("@RoleId", objUser.RoleID) : new SqlParameter("@RoleId", zeroValue);
            UserParam[6] = (objUser.CreatedByID != 0) ? new SqlParameter("@CreatedByID", objUser.CreatedByID) : new SqlParameter("@CreatedByID", zeroValue);
            UserParam[7] = (objUser.ModByID != 0) ? new SqlParameter("@ModByID", objUser.ModByID) : new SqlParameter("@ModByID", zeroValue);
            UserParam[8] = new SqlParameter("@QueryType", "SaveUser");
            returnValue = objDUT.ExecuteSqlSP(UserParam, "uspUser");//SqlHelper.ExecuteNonQuery(mCon, CommandType.StoredProcedure, "[dbo].[uspUser]", UserParam);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return returnValue;
    }

    public DataTable AuthenticateUser(string UserName, string Password)
    {
        DataTable dtUserInfo = new DataTable();
        //try
        //{
        SqlParameter[] UserParam = new SqlParameter[3];
        UserParam[0] = new SqlParameter("@UserName", UserName);
        UserParam[1] = new SqlParameter("@Password", Password);
        UserParam[2] = new SqlParameter("@QueryType", "GetUserDetails");
        dtUserInfo = objDUT.GetDataTableSP(UserParam, "[uspLogin]"); //SqlHelper.ExecuteDataset(mCon, CommandType.StoredProcedure, "[dbo].[uspLogin]", UserParam).Tables[0];
        //}
        //catch (Exception ex)
        //{
        //    throw ex;
        //}
        return dtUserInfo;
    }
}