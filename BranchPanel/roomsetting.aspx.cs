using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_roomsetting : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    private DataUtility objdut = new DataUtility();
    private Utility objut = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        }
    }

    [WebMethod]
    public static int insertdata(string roomname, string typname, string capacity, string description, string floor)
    {
        DataUtility objdut = new DataUtility();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            con.Open();
            using (SqlCommand cmd = new SqlCommand("usp_classdetail", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@roomname", roomname);
                //cmd.Parameters.AddWithValue("@rtype", typecheck);
                cmd.Parameters.AddWithValue("@rtypename", typname);
                cmd.Parameters.AddWithValue("@capacity", capacity);
                cmd.Parameters.AddWithValue("@description", description);
                cmd.Parameters.AddWithValue("@floor1", floor);
                cmd.Parameters.AddWithValue("@brid", HttpContext.Current.Session["BrBrid"]);
                cmd.Parameters.Add("@intResult", SqlDbType.NVarChar, 100, "");
                cmd.Parameters["@intResult"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int intResult = Convert.ToInt32(cmd.Parameters["@intResult"].Value);

                con.Close();

                if (intResult == 1)
                {
                    return intResult;
                }
                else
                {
                    return intResult;
                }
            }
        }
    }

    [WebMethod]
    public static UserDetails[] BindDatatable()
    {
        DataTable dt = new DataTable();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select  *,case when status1=0 then 'Room Alloted' else 'Free' end as Status from tbl_classroom  order by room_id  desc", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    UserDetails user = new UserDetails();
                    user.roomname1 = dtrow["room_name"].ToString();
                    user.capacity1 = dtrow["capacity"].ToString();
                    user.typename1 = dtrow["rtypename"].ToString();
                    user.floor12 = dtrow["floor1"].ToString();
                    user.roomid = dtrow["room_id"].ToString();
                    user.status1 = dtrow["status"].ToString();

                    details.Add(user);
                }
            }
        }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string roomname1 { get; set; }

        public string capacity1 { get; set; }

        public string typename1 { get; set; }

        public string floor12 { get; set; }

        public string roomid { get; set; }

        public string status1 { get; set; }
    }

    [WebMethod]
    public static roomdetail[] filldata(string roomid)
    {
        List<roomdetail> details = new List<roomdetail>();
        DataUtility objdut = new DataUtility();
        DataTable dt = new DataTable();
        CommonClass CommonClass = new CommonClass();
        Utility objUT = new Utility();
        DataSet ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select * from tbl_classroom where room_id='" + roomid + "'", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    roomdetail user = new roomdetail();

                    user.roomname = dt.Rows[0]["room_name"].ToString();
                    user.roomtype = dt.Rows[0]["rtypename"].ToString();
                    user.roomcapacity = dt.Rows[0]["capacity"].ToString();
                    user.roomfloor = dt.Rows[0]["floor1"].ToString();
                    user.room_id = dt.Rows[0]["room_id"].ToString();
                    details.Add(user);
                }
            }
        }

        return details.ToArray();
    }

    public class roomdetail
    {
        public string roomname { get; set; }

        public string roomtype { get; set; }

        public string roomcapacity { get; set; }

        public string roomfloor { get; set; }

        public string room_id { get; set; }
    }

    [WebMethod]
    public static int updateroom(int capacity, int roomid2)
    {
        int intResult = 0;
        DataUtility objdut = new DataUtility();

        string srt = "update tbl_classroom set capacity=" + capacity + "  where room_id=" + roomid2 + "and brid=" + HttpContext.Current.Session["BrBrid"] + "";
        intResult = objdut.ExecuteSql(srt);

        if (intResult > 0)
        {
        }

        return intResult;
    }
}