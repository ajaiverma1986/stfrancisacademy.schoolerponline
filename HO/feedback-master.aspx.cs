using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class HO_feedback_master : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    public class BindLable
    {
        public string TotalActivate { get; set; }

        public string TotalDeactive { get; set; }

        public string TotaDeletedFeedback { get; set; }

        public string TotalSubmitFeedback { get; set; }
    }

    [WebMethod]
    public static BindLable[] Feedbacklable()
    {
        DataTable Dt = new DataTable();
        List<BindLable> Details = new List<BindLable>();
        DataUtility objDut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 3);
        Dt = objDut.GetDataTableSP(param, "[Usp_FeedBackSetting]");
        if (Dt.Rows.Count > 0)
        {
            BindLable obj = new BindLable();
            obj.TotalActivate = Convert.ToString(Dt.Rows[0]["TotalActivate"]);
            obj.TotalDeactive = Convert.ToString(Dt.Rows[0]["TotalDeactive"]);
            obj.TotaDeletedFeedback = Convert.ToString(Dt.Rows[0]["TotaDeletedFeedback"]);
            obj.TotalSubmitFeedback = Convert.ToString(Dt.Rows[0]["TotalSubmitFeedback"]);
            Details.Add(obj);
        }
        return Details.ToArray();
    }

    [WebMethod]
    public static int AddFeedbackType(string AllFeedbackcomment = "", int feedbacktypes = 0, string feedbacktypesname = "")
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_FeedBackSetting]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[5];

                param[0] = new SqlParameter("@feedbacktypes", feedbacktypes);
                param[1] = new SqlParameter("@AllFeedbackTypename", AllFeedbackcomment.Replace("~", "'"));
                param[2] = new SqlParameter("@intresult", SqlDbType.Int);
                param[2].Direction = ParameterDirection.Output;
                param[3] = new SqlParameter("@feedbacktypesname", feedbacktypesname.Replace("~", "'"));
                param[4] = new SqlParameter("@mode", 1);

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
    public static BindFeedbackType[] BindGridByJs()
    {
        List<BindFeedbackType> Feedback = new List<BindFeedbackType>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            string Query = "select FeedbackTypeid,FeedbackTypeName,feedbacktypes,feedbacktypesname,(case when status=1 then '../images/yes.png' when status=0 then '../images/ic.png' end) As StatusImageName from [tbl_FeedbackType] where status<>2";
            using (SqlCommand cmd = new SqlCommand(Query, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    BindFeedbackType FeedbackType = new BindFeedbackType();
                    FeedbackType.FeedbackTypeid = Convert.ToInt32(dtrow["FeedbackTypeid"].ToString());
                    FeedbackType.FeedbackTypeName = dtrow["FeedbackTypeName"].ToString();
                    FeedbackType.feedbacktypes = dtrow["feedbacktypes"].ToString();
                    FeedbackType.feedbacktypesname = dtrow["feedbacktypesname"].ToString();
                    FeedbackType.StatusImageName = dtrow["StatusImageName"].ToString();
                    Feedback.Add(FeedbackType);
                }
            }
        }
        return Feedback.ToArray();
    }

    public class BindFeedbackType
    {
        public int FeedbackTypeid { get; set; }

        public string FeedbackTypeName { get; set; }

        public string feedbacktypes { get; set; }

        public string StatusImageName { get; set; }

        public string feedbacktypesname { get; set; }
    }

    [WebMethod]
    public static int EditOrChangeStatusOfFeedbackType(string FeedbackTypeid, string FeedbackTypeName, string Status, int ddlforfeedbacktypeid, string ddlforfeedbacktype)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_FeedBackSetting]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[7];

                param[0] = new SqlParameter("@FeedbackTypeid", FeedbackTypeid);

                param[1] = new SqlParameter("@FeedbackTypeName", FeedbackTypeName.Replace("~","'"));

                param[2] = new SqlParameter("@Status", Status);

                param[3] = new SqlParameter("@intresult", SqlDbType.Int);

                param[3].Direction = ParameterDirection.Output;

                param[4] = new SqlParameter("@mode", 2);
                param[5] = new SqlParameter("@ddlforfeedbacktypeid", ddlforfeedbacktypeid);
                param[6] = new SqlParameter("@ddlforfeedbacktype", ddlforfeedbacktype);

                cmd.Parameters.Add(param[0]);

                cmd.Parameters.Add(param[1]);

                cmd.Parameters.Add(param[2]);

                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);
                cmd.Parameters.Add(param[6]);
                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }
}