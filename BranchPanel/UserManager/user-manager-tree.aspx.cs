using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class branchpanel_user_manager_tree : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    [WebMethod]
    public static GetUserDetails[] BindGridByJs(string SponserId)
    {
        DataSet Ds = new DataSet();
        List<GetUserDetails> UserDetails = new List<GetUserDetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@SponserId", SponserId);
        param[1] = new SqlParameter("@Brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        Ds = Objdut.GetDataSetSP(param, "usp_GetUserTree");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                GetUserDetails user = new GetUserDetails();
                user.Username = dtrow["UserName"].ToString();
                user.Password = dtrow["Password"].ToString();
                user.Userid = dtrow["Userid"].ToString();
                UserDetails.Add(user);
            }
        }
        return UserDetails.ToArray();
    }
    public class GetUserDetails
    {
        public string Username { get; set; }
        public string Password { get; set; }
        public string Userid { get; set; }
    }
}