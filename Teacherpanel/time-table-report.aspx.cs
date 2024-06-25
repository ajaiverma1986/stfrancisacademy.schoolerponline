using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class EmployeePanel_time_table_report : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable Dt;
    private static int fyid = 2;
    private CommonClass CommonClass = new CommonClass();

    protected void Page_Load(object sender, EventArgs e)
    {
        fyid = CommonClass.Scaler("ActiveAcademicYear");
        if (!IsPostBack)
        {
            BindGrid();
        }
    }

    protected void BindGrid()
    {
        Dt = new DataTable();
        Dt.Columns.Add("eid", typeof(string));
        DataRow Dr = Dt.NewRow();
        Dr["eid"] = "1";
        Dt.Rows.Add(Dr);
        if (Dt.Rows.Count > 0)
        {
            gridcreatetimetable.DataSource = Dt;
            gridcreatetimetable.DataBind();
            tablecreatetimetable.Style.Add("display", "none");
        }
        Dt.Dispose();
    }

    [WebMethod]
    public static teachertimetable[] BindTeacherTimeTable()
    {
        DataSet ds = new DataSet();
        List<teachertimetable> details = new List<teachertimetable>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_teacherpaneltimetable]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[3];

                param[0] = new SqlParameter("@teacherid", Convert.ToInt32(1));
                param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
                param[2] = new SqlParameter("@fyid", fyid);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        teachertimetable teachetdetails = new teachertimetable();
                        teachetdetails.RowNumber = dtrow["RowNumber"].ToString();
                        teachetdetails.Dayid = dtrow["Dayid"].ToString();
                        teachetdetails.Day = dtrow["Day"].ToString();
                        teachetdetails.FirstLectureClass = dtrow["FirstLectureClass"].ToString();
                        teachetdetails.FirstLectureSubject = dtrow["FirstLectureSubject"].ToString();
                        teachetdetails.SecondLectureClass = dtrow["SecondLectureClass"].ToString();
                        teachetdetails.SecondLectureSubject = dtrow["SecondLectureSubject"].ToString();
                        teachetdetails.ThirdLectureClass = dtrow["ThirdLectureClass"].ToString();
                        teachetdetails.ThirdLectureSubject = dtrow["ThirdLectureSubject"].ToString();
                        teachetdetails.FourthLectureClass = dtrow["FourthLectureClass"].ToString();
                        teachetdetails.FourthLectureSubject = dtrow["FourthLectureSubject"].ToString();
                        teachetdetails.FifthLectureClass = dtrow["FifthLectureClass"].ToString();
                        teachetdetails.FifthLectureSubject = dtrow["FifthLectureSubject"].ToString();
                        teachetdetails.SixthLectureClass = dtrow["SixthLectureClass"].ToString();
                        teachetdetails.SixthLectureSubject = dtrow["SixthLectureSubject"].ToString();
                        teachetdetails.SeventhLectureClass = dtrow["SeventhLectureClass"].ToString();
                        teachetdetails.SeventhLectureSubject = dtrow["SeventhLectureSubject"].ToString();
                        teachetdetails.EightthLectureClass = dtrow["EightthLectureClass"].ToString();
                        teachetdetails.EightthLectureSubject = dtrow["EightthLectureSubject"].ToString();
                        details.Add(teachetdetails);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class teachertimetable
    {
        public string RowNumber { get; set; }

        public string Dayid { get; set; }

        public string Day { get; set; }

        public string FirstLectureClass { get; set; }

        public string FirstLectureSubject { get; set; }

        public string SecondLectureClass { get; set; }

        public string SecondLectureSubject { get; set; }

        public string ThirdLectureClass { get; set; }

        public string ThirdLectureSubject { get; set; }

        public string FourthLectureClass { get; set; }

        public string FourthLectureSubject { get; set; }

        public string FifthLectureClass { get; set; }

        public string FifthLectureSubject { get; set; }

        public string SixthLectureClass { get; set; }

        public string SixthLectureSubject { get; set; }

        public string SeventhLectureClass { get; set; }

        public string SeventhLectureSubject { get; set; }

        public string EightthLectureClass { get; set; }

        public string EightthLectureSubject { get; set; }
    }
}