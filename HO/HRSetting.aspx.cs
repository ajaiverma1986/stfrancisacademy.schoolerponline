using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class HO_HRSetting : System.Web.UI.Page
{
    private Utility objut = new Utility();
    private SqlParameter[] param = new SqlParameter[2];
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static GetTopicDetails[] BindGridByJs()
    {
        DataSet Ds = new DataSet();
        List<GetTopicDetails> TopicDetails = new List<GetTopicDetails>();
        DataUtility Objdut = new DataUtility();
        Ds = Objdut.GetDataSetSP("[usp_BindDepertmentMaster]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                GetTopicDetails user = new GetTopicDetails();
                user.RowNumber = dtrow["RowNumber"].ToString();
                user.deptid = dtrow["deptid"].ToString();
                user.deptname = dtrow["deptname"].ToString();
                user.desigID = dtrow["desigID"].ToString();
                user.desigName = dtrow["desigName"].ToString();
                user.status = dtrow["status"].ToString();
                user.statusname = dtrow["statusname"].ToString();
                user.dpstatus = dtrow["dpstatus"].ToString();
                user.dpstatusname = dtrow["dpstatusname"].ToString();
                user.IsEditable = dtrow["IsEditable"].ToString();
                TopicDetails.Add(user);
            }
        }
        return TopicDetails.ToArray();
    }

    public class GetTopicDetails
    {
        public string RowNumber { get; set; }

        public string deptid { get; set; }

        public string deptname { get; set; }

        public string desigID { get; set; }

        public string desigName { get; set; }

        public string status { get; set; }

        public string statusname { get; set; }

        public string dpstatus { get; set; }

        public string dpstatusname { get; set; }

        public string IsEditable { get; set; }
    }

    [WebMethod]
    public static int AddClass(string ClassName)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_adddepartment]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@deptName", ClassName.Replace("~", "'"));
                param[1] = new SqlParameter("@intresult", SqlDbType.Int);
                param[1].Direction = ParameterDirection.Output;
                param[2] = new SqlParameter("@mode", "Adddepartment");
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
    public static int AddSubject(string Classid, string Allsubjectname)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_adddesigName]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[4];

                param[0] = new SqlParameter("@deptid", Classid);

                param[1] = new SqlParameter("@desigName", Allsubjectname.Replace("~", "'"));

                param[2] = new SqlParameter("@intresult", SqlDbType.Int);

                param[2].Direction = ParameterDirection.Output;
                param[3] = new SqlParameter("@mode", "AdddesigName");
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
    public static ClassDetails[] BindClass()
    {
        List<ClassDetails> Details = new List<ClassDetails>();
        DataTable dt = new DataTable();
        string Query = "select deptid, deptName from dept_master where Status=1";
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand(Query, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    ClassDetails Dsdetails = new ClassDetails();
                    Dsdetails.Id = Convert.ToInt32(dtrow["deptid"].ToString());
                    Dsdetails.Name = dtrow["deptName"].ToString();
                    Details.Add(Dsdetails);
                }
            }
        }
        return Details.ToArray();
    }

    public class ClassDetails
    {
        public int Id { get; set; }

        public string Name { get; set; }
    }

    [WebMethod]
    public static int updatestatus(string desigID, string status)
    {
        DataUtility objdut = new DataUtility();

        int result = objdut.ExecuteSql("update designation_master set status=" + status + " where desigID=" + desigID);
        return result;
    }

    [WebMethod]
    public static int updatedepartment(string deptid, string deptName)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@deptName", deptName.Replace("~", "'"));
        param[1] = new SqlParameter("@intresult", SqlDbType.Int);
        param[1].Direction = ParameterDirection.Output;
        param[2] = new SqlParameter("@mode", "Update");
        param[3] = new SqlParameter("@deptid", deptid);
        int result = objdut.ExecuteSqlSP(param, "usp_adddepartment");
        return result;
    }

    [WebMethod]
    public static int updatedesignation(string desigID, string desigName)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@desigName", desigName.Replace("~", "'"));
        param[1] = new SqlParameter("@intresult", SqlDbType.Int);
        param[1].Direction = ParameterDirection.Output;
        param[2] = new SqlParameter("@mode", "Edit");
        param[3] = new SqlParameter("@desigID", desigID);
        int result = objdut.ExecuteSqlSP(param, "usp_adddesigName");
        return result;
    }

    [WebMethod]
    public static int updatedepartmentstatus(string deptid, string status)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@status", status);
        param[1] = new SqlParameter("@intresult", SqlDbType.Int);
        param[1].Direction = ParameterDirection.Output;
        param[2] = new SqlParameter("@mode", "Updatestatus");
        param[3] = new SqlParameter("@deptid", deptid);
        int result = objdut.ExecuteSqlSP(param, "usp_adddepartment");
        return result;
    }
}