using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class HO_add_topic : System.Web.UI.Page
{
    private DataUtility Objdut = new DataUtility();
    private CommonClass CommonClass = new CommonClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindgrid();
        }
    }

    protected void bindgrid()
    {
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        DataTable dt = new DataTable();
        dt = Objdut.GetDataTable("select id,Classname as classname from Class_Master where Status=" + ActiveFinancialyear);
        if (dt.Rows.Count > 0)
        {
            ddlclassforaddtopic.DataSource = dt;
            ddlclassforaddtopic.DataValueField = "id";
            ddlclassforaddtopic.DataTextField = "classname";
            ddlclassforaddtopic.DataBind();
            ddlclassforaddtopic.Items.Insert(0, new ListItem("Select Class", "0"));
        }
        dt.Dispose();
        dt = Objdut.GetDataTable("select id,SubjectName from Subject_Master where fyid=" + ActiveFinancialyear);
        if (dt.Rows.Count > 0)
        {
            ddlsubjectforaddtopic.DataSource = dt;
            ddlsubjectforaddtopic.DataValueField = "id";
            ddlsubjectforaddtopic.DataTextField = "SubjectName";
            ddlsubjectforaddtopic.DataBind();
            ddlsubjectforaddtopic.Items.Insert(0, new ListItem("Select Subject", "0"));
        }
        dt.Dispose();
    }

    [WebMethod]
    public static GetTopicDetails[] BindGridByJs(string ClassName,string SubjectName)
    {
        DataSet Ds = new DataSet();
        List<GetTopicDetails> TopicDetails = new List<GetTopicDetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter [] param = new SqlParameter[2];
        param[0] = new SqlParameter("@ClassName", ClassName.Replace("~","'"));
        param[1] = new SqlParameter("@SubjectName", SubjectName.Replace("~", "'"));
        Ds = Objdut.GetDataSetSP(param,"[usp_BindTopicMaster]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                GetTopicDetails user = new GetTopicDetails();
                user.RowNumber = dtrow["RowNumber"].ToString();
                user.ClassName = dtrow["ClassName"].ToString();
                user.ClassId = dtrow["ClassId"].ToString();
                user.SubjectName = dtrow["SubjectName"].ToString();
                user.SubjectId = dtrow["SubjectId"].ToString();
                user.TopicName = dtrow["ToipcName"].ToString();
                user.ToipcTime = dtrow["ToipcTime"].ToString();
                user.TopicId = dtrow["TopicId"].ToString();
                user.StatusName = dtrow["StatusName"].ToString();
                user.ShowTopicAnchor = dtrow["ShowTopicAnchor"].ToString();
                user.SubStatusId = dtrow["SubStatusId"].ToString();
                user.SubStatusName = dtrow["SubStatusName"].ToString();
                user.AddTopicAnchor = dtrow["AddTopicAnchor"].ToString();
                TopicDetails.Add(user);
            }
        }
        return TopicDetails.ToArray();
    }

    public class GetTopicDetails
    {
        public string RowNumber { get; set; }

        public string ClassName { get; set; }

        public string ClassId { get; set; }

        public string SubjectName { get; set; }

        public string SubjectId { get; set; }

        public string TopicName { get; set; }

        public string ToipcTime { get; set; }

        public string TopicId { get; set; }

        public string StatusName { get; set; }

        public string ShowTopicAnchor { get; set; }

        public string SubStatusId { get; set; }

        public string SubStatusName { get; set; }

        public string AddTopicAnchor { get; set; }
    }

    [WebMethod]
    public static ViewTopiclist[] BindGridViewTopic(int subid, int classid)
    {
        DataSet Ds = new DataSet();
        List<ViewTopiclist> TopicDetails = new List<ViewTopiclist>();
        DataUtility Objdut = new DataUtility();
        Ds = Objdut.GetDataSet("select tid,topicname,CompletionTime_inhr from topic_master where status=1 and classid=" + classid + " and subjID=" + subid);
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ViewTopiclist user = new ViewTopiclist();
                user.TopicName = dtrow["topicname"].ToString();
                user.ToipcTime = dtrow["CompletionTime_inhr"].ToString();
                user.TopicId = dtrow["tid"].ToString();
                TopicDetails.Add(user);
            }
        }
        return TopicDetails.ToArray();
    }

    public class ViewTopiclist
    {
        public string TopicName { get; set; }

        public string ToipcTime { get; set; }

        public string TopicId { get; set; }
    }

    [WebMethod]
    public static int AddTopic(string Classid, string SubjectId, string Topicname, string Topictime)
    {
        string name = Topicname.Replace("@", "'");
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_Add_Topic]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[5];
                param[0] = new SqlParameter("@Classid", Classid);
                param[1] = new SqlParameter("@SubjectId", SubjectId);
                param[2] = new SqlParameter("@Topicname", name);
                param[3] = new SqlParameter("@intresult", SqlDbType.Int);
                param[3].Direction = ParameterDirection.Output;
                param[4] = new SqlParameter("@Topictime", Topictime);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.ExecuteNonQuery();
                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);
                return result;
            }
        }
    }

    [WebMethod]
    public static int TopicManagement(string TopicId, string TopicName, string TopicTime, string TopicMode)
    {
        string name = TopicName.Replace("@", "'");
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_Manage_Topic]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[5];
                param[0] = new SqlParameter("@TopicId", Convert.ToInt32(TopicId));
                param[1] = new SqlParameter("@TopicName", name.Replace("~","'"));
                param[2] = new SqlParameter("@TopicMode", Convert.ToInt32(TopicMode));
                param[3] = new SqlParameter("@intresult", SqlDbType.Int);
                param[3].Direction = ParameterDirection.Output;
                param[4] = new SqlParameter("@TopicTime", TopicTime.Replace("~", "'"));

                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.ExecuteNonQuery();
                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);
                return result;
            }
        }
    }
    [WebMethod]
    public static int updateclass(string data, string id)
    {
        int result = 0;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@TopicId", Convert.ToInt32(id));
        param[1] = new SqlParameter("@TopicName", data.Replace("~","'"));
        param[2] = new SqlParameter("@TopicMode", 4);
        param[3] = new SqlParameter("@intresult", SqlDbType.Int);
        param[3].Direction = ParameterDirection.Output;
        result = objdut.ExecuteSqlSP(param, "usp_Manage_Topic");
        return result;
    }
    [WebMethod]
    public static int updatesubject(string data, string id)
    {
        int result = 0;
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@TopicId", Convert.ToInt32(id));
        param[1] = new SqlParameter("@TopicName", data.Replace("~","'"));
        param[2] = new SqlParameter("@TopicMode", 3);
        param[3] = new SqlParameter("@intresult", SqlDbType.Int);
        param[3].Direction = ParameterDirection.Output;
        result = objdut.ExecuteSqlSP(param, "usp_Manage_Topic");
        return result;
    }
}