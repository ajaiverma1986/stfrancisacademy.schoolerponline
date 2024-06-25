using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_UserManager_branch_user_list : System.Web.UI.Page
{
    private DataUtility objUTL = new DataUtility();
    private DataSet ds;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillgrid();
        }
    }
    private void fillgrid()
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@Userid", Convert.ToInt32(Session["BrADID"]));
        param[1] = new SqlParameter("@Brid", Convert.ToInt32(Session["BrBrid"]));
        ds = objUTL.GetDataSetSP(param, "[search_user_list]");
        if (ds.Tables[0].Rows.Count > 0)
        {
            grduserlist.DataSource = ds.Tables[0];
            grduserlist.DataBind();
            hfpages.Value = ds.Tables[1].Rows[0]["pages"].ToString();
        }
        else
        {
            grduserlist.EmptyDataText = "Currently, Brach User list is not available.";
            grduserlist.DataSource = null;
            grduserlist.DataBind();
        }
    }

    [WebMethod]
    public static int ChangeStatus(string Eid, string Status)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_ChangeStatus]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[3];

                param[0] = new SqlParameter("@Eid", Eid);

                param[1] = new SqlParameter("@Status", Status);

                param[2] = new SqlParameter("@intresult", SqlDbType.Int);

                param[2].Direction = ParameterDirection.Output;

                cmd.Parameters.Add(param[0]);

                cmd.Parameters.Add(param[1]);

                cmd.Parameters.Add(param[2]);

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }

    [WebMethod]
    public static GetBranchUserList[] BindGridByJs(string Name, string LoginId)
    {
        DataSet ds = new DataSet();
        List<GetBranchUserList> Details = new List<GetBranchUserList>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[search_user_list]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@Userid", Convert.ToInt32(HttpContext.Current.Session["BrADID"]));
                param[1] = new SqlParameter("@Brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
                param[2] = new SqlParameter("@Name", Name);
                param[3] = new SqlParameter("@Loginid", LoginId);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dtrow in ds.Tables[0].Rows)
                        {
                            GetBranchUserList user = new GetBranchUserList();
                            user.RowNumber = dtrow["RowNumber"].ToString();
                            user.Eid = dtrow["Eid"].ToString();
                            user.employeename = dtrow["name"].ToString();
                            user.EmployeeCode = dtrow["EmployeeCode"].ToString();
                            user.UserName = dtrow["UserName"].ToString();
                            user.Password = dtrow["Password"].ToString();
                            user.statusimage = dtrow["statusimage"].ToString();
                            user.sponsername = dtrow["sponsername"].ToString();
                            user.Introducername = dtrow["Introducername"].ToString();
                            Details.Add(user);
                        }
                    }
                }
            }
        }
        return Details.ToArray();
    }

    public class GetBranchUserList
    {
        public string RowNumber { get; set; }

        public string Eid { get; set; }

        public string employeename { get; set; }

        public string EmployeeCode { get; set; }

        public string UserName { get; set; }

        public string Password { get; set; }

        public string statusimage { get; set; }

        public string sponsername { get; set; }

        public string Introducername { get; set; }
    }

    [WebMethod]
    public static int ChangePermission(string UserId, string ModuleId)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_GivePermission]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[4];

                param[0] = new SqlParameter("@moduleid", ModuleId);

                param[1] = new SqlParameter("@userid", UserId);

                param[2] = new SqlParameter("@CreateOrModifiedById", 0);

                param[3] = new SqlParameter("@intresult", SqlDbType.Int);

                param[3].Direction = ParameterDirection.Output;

                cmd.Parameters.Add(param[0]);

                cmd.Parameters.Add(param[1]);

                cmd.Parameters.Add(param[2]);

                cmd.Parameters.Add(param[3]);

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }

    [WebMethod]
    public static GetAllGivenPermission[] BindGridByJsForPermission(string userid)
    {
        DataSet ds = new DataSet();
        List<GetAllGivenPermission> details = new List<GetAllGivenPermission>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_GetAllPermittedModuleId]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@userid", Convert.ToInt32(userid));
                cmd.Parameters.Add(param[0]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dtrow in ds.Tables[0].Rows)
                        {
                            GetAllGivenPermission user = new GetAllGivenPermission();
                            user.RowNumber = dtrow["RowNumber"].ToString();
                            user.Moduleid = dtrow["Moduleid"].ToString();
                            details.Add(user);
                        }
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class GetAllGivenPermission
    {
        public string RowNumber { get; set; }

        public string Moduleid { get; set; }
    }

    [WebMethod]
    public static BindMenuAccordingToPermission[] BindGridByJsForBindPermission(string userid)
    {
        DataSet Ds = new DataSet();
        List<BindMenuAccordingToPermission> details = new List<BindMenuAccordingToPermission>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[user_Permission]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Userid", Convert.ToString(userid));
                cmd.Parameters.Add(param[0]);
                SqlDataAdapter Da = new SqlDataAdapter(cmd);
                Da.Fill(Ds);
                if (Ds.Tables.Count > 0)
                {
                    if (Ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dtrow in Ds.Tables[0].Rows)
                        {
                            BindMenuAccordingToPermission user = new BindMenuAccordingToPermission();
                            user.ModuleId = dtrow["ModuleId"].ToString();
                            user.ModuleName = dtrow["ModuleName"].ToString();
                            details.Add(user);
                        }
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class BindMenuAccordingToPermission
    {
        public string ModuleId { get; set; }

        public string ModuleName { get; set; }
    }

    [WebMethod]
    public static GetAllGivenActionPermission[] BindGridByJsForActionPermission(string userid)
    {
        DataSet ds = new DataSet();
        List<GetAllGivenActionPermission> Details = new List<GetAllGivenActionPermission>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_GetAllActionPermittedModuleId]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@userid", Convert.ToInt32(userid));
                cmd.Parameters.Add(param[0]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dtrow in ds.Tables[0].Rows)
                        {
                            GetAllGivenActionPermission user = new GetAllGivenActionPermission();
                            user.RowNumber = dtrow["RowNumber"].ToString();
                            user.Id = dtrow["Id"].ToString();
                            Details.Add(user);
                        }
                    }
                }
            }
        }
        return Details.ToArray();
    }

    public class GetAllGivenActionPermission
    {
        public string RowNumber { get; set; }

        public string Id { get; set; }
    }

    [WebMethod]
    public static BindMenuAccordingToActionPermission[] BindGridByJsForBindActionPermission(string userid)
    {
        DataSet Ds = new DataSet();
        List<BindMenuAccordingToActionPermission> Details = new List<BindMenuAccordingToActionPermission>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[BranchAction_Permission]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@Userid", Convert.ToString(userid));
                cmd.Parameters.Add(param[0]);
                SqlDataAdapter Da = new SqlDataAdapter(cmd);
                Da.Fill(Ds);
                if (Ds.Tables.Count > 0)
                {
                    if (Ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dtrow in Ds.Tables[0].Rows)
                        {
                            BindMenuAccordingToActionPermission user = new BindMenuAccordingToActionPermission();
                            user.Id = dtrow["Id"].ToString();
                            user.Name = dtrow["Name"].ToString();
                            Details.Add(user);
                        }
                    }
                }
            }
        }
        return Details.ToArray();
    }

    public class BindMenuAccordingToActionPermission
    {
        public string Id { get; set; }

        public string Name { get; set; }
    }

    [WebMethod]
    public static int ChangeActionPermission(string UserId, string ModuleId)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_GiveActionPermission]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[4];

                param[0] = new SqlParameter("@Action_Id", ModuleId);

                param[1] = new SqlParameter("@userid", UserId);

                param[2] = new SqlParameter("@CreateOrModifiedById", 0);

                param[3] = new SqlParameter("@intresult", SqlDbType.Int);

                param[3].Direction = ParameterDirection.Output;

                cmd.Parameters.Add(param[0]);

                cmd.Parameters.Add(param[1]);

                cmd.Parameters.Add(param[2]);

                cmd.Parameters.Add(param[3]);

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }

}