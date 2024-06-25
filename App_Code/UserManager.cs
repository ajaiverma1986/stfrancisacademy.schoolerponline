using System;
using System.Data;

//using BusinessObjects.Entity;
//using BusinessObjects.Data;

public class UserManager
{
    public UserManager()
    {
    }

    public int SaveUserInformation(User objUser)
    {
        int returnValue = 0;
        try
        {
            UserAccess objUserAccess = new UserAccess();
            returnValue = objUserAccess.SaveUserInformation(objUser);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return returnValue;
    }

    public User GetUserDetails(string UserName, string Password)
    {
        //try
        //{
        DataTable dtUserDetails = new DataTable();
        UserAccess objUserAccess = new UserAccess();
        dtUserDetails = objUserAccess.AuthenticateUser(UserName, Password);
        User user = null;
        foreach (DataRow dr in dtUserDetails.Rows)
        {
            user = new User();
            user.UserID = Convert.ToInt32(dr["UserID"].ToString());
            user.AssociatedToID = Convert.ToInt32(dr["AssociatedToID"].ToString());
            user.AssociationID = Convert.ToInt32(dr["Eid"].ToString());
            user.UserName = dr["UserName"].ToString();
            user.RoleID = Convert.ToInt32(dr["RoleID"].ToString());
            user.IsActive = Convert.ToBoolean(dr["IsActive"].ToString());
            user.brid = Convert.ToInt32(dr["Brid"].ToString());
            user.LastLogOn = Convert.ToDateTime(dr["LastLogOn"].ToString());
        }
        return user;
        //}
        //catch (Exception ex)
        //{
        //    throw ex;
        //}
    }
}