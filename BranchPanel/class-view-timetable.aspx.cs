using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_class_view_timetable : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private CommonClass CommonClass = new CommonClass();
    private static int fyid = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        fyid = CommonClass.Scaler("ActiveAcademicYear");

        BindGrid();
        if (!IsPostBack)
        {
            FillClass(Convert.ToInt32(Session["BrBrid"]));
        }
    }

    protected void BindGrid()
    {
        string Query = "select top 1 eid,examname from exam_name";
        dt = objdut.GetDataTable(Query);
        gridcreatetimetable.DataSource = dt;
        gridcreatetimetable.DataBind();
    }

    protected void FillClass(int brid)
    {
        string Query = "select classid,Classname from ClassBranch_master where branchid=" + brid + " and status=1";
        dt = objdut.GetDataTable(Query);
        if (dt.Rows.Count > 0)
        {
            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "classname";
            ddlClass.DataValueField = "classid";
            ddlClass.DataBind();
            ddlClass.Items.Insert(0, new ListItem("Select Class", "0"));
        }
        dt.Dispose();
    }

    [WebMethod]
    public static classtimetable[] BindClassGrid(string classid, string sectionid)
    {
        DataSet ds = new DataSet();
        List<classtimetable> details = new List<classtimetable>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_classtimetable]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[4];

                param[0] = new SqlParameter("@classid", Convert.ToInt32(classid));
                param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
                param[2] = new SqlParameter("@fyid", fyid);
                param[3] = new SqlParameter("@sectionid", Convert.ToInt32(sectionid));

                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        classtimetable classdetails = new classtimetable();
                        classdetails.RowNumber = dtrow["RowNumber"].ToString();
                        classdetails.Dayid = dtrow["Dayid"].ToString();
                        classdetails.Day = dtrow["Day"].ToString();

                        classdetails.FirstLectureSubject = dtrow["FirstLectureSubject"].ToString();
                        classdetails.FirstLectureTeacher = dtrow["FirstLectureTeacher"].ToString();

                        classdetails.SecondLectureSubject = dtrow["SecondLectureSubject"].ToString();
                        classdetails.SecondLectureTeacher = dtrow["SecondLectureTeacher"].ToString();

                        classdetails.ThirdLectureSubject = dtrow["ThirdLectureSubject"].ToString();
                        classdetails.ThirdLectureTeacher = dtrow["ThirdLectureTeacher"].ToString();

                        classdetails.FourthLectureSubject = dtrow["FourthLectureSubject"].ToString();
                        classdetails.FourthLectureTeacher = dtrow["FourthLectureTeacher"].ToString();

                        classdetails.FifthLectureSubject = dtrow["FifthLectureSubject"].ToString();
                        classdetails.FifthLectureTeacher = dtrow["FifthLectureTeacher"].ToString();

                        classdetails.SixthLectureSubject = dtrow["SixthLectureSubject"].ToString();
                        classdetails.SixthLectureTeacher = dtrow["SixthLectureTeacher"].ToString();

                        classdetails.SeventhLectureSubject = dtrow["SeventhLectureSubject"].ToString();
                        classdetails.SeventhLectureTeacher = dtrow["SeventhLectureTeacher"].ToString();

                        classdetails.EightthLectureSubject = dtrow["EightthLectureSubject"].ToString();
                        classdetails.EightthLectureTeacher = dtrow["EightthLectureTeacher"].ToString();

                        details.Add(classdetails);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class classtimetable
    {
        public string RowNumber { get; set; }

        public string Dayid { get; set; }

        public string Day { get; set; }

        public string FirstLectureSubject { get; set; }

        public string FirstLectureTeacher { get; set; }

        public string SecondLectureSubject { get; set; }

        public string SecondLectureTeacher { get; set; }

        public string ThirdLectureSubject { get; set; }

        public string ThirdLectureTeacher { get; set; }

        public string FourthLectureSubject { get; set; }

        public string FourthLectureTeacher { get; set; }

        public string FifthLectureSubject { get; set; }

        public string FifthLectureTeacher { get; set; }

        public string SixthLectureSubject { get; set; }

        public string SixthLectureTeacher { get; set; }

        public string SeventhLectureSubject { get; set; }

        public string SeventhLectureTeacher { get; set; }

        public string EightthLectureSubject { get; set; }

        public string EightthLectureTeacher { get; set; }
    }
}