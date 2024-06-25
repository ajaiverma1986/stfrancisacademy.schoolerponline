using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_addroad : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    private DataUtility objdut = new DataUtility();
    private Utility objut = new Utility();
    private SqlParameter[] param1;
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
    private SqlCommand cmd = new SqlCommand();
    private DataTable dt, dt1, dt2;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindColumnToGridview();
            fildll();
        }
    }

    private void fillarea()
    {
        //obj = objdut.GetDataTable("select ");
    }

    [WebMethod]
    public static UserDetails[] BindDatatable()
    {
        DataTable dt = new DataTable();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select  roadid, areaid,zonename, area,roadname from road_master where status=1 order by roadid desc", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    UserDetails user = new UserDetails();
                    user.roadid = dtrow["roadid"].ToString();
                    user.areaid = dtrow["areaid"].ToString();
                    user.zonename = dtrow["zonename"].ToString();
                    user.area = dtrow["area"].ToString();
                    user.roadname = dtrow["roadname"].ToString();
                    details.Add(user);
                }
            }
        }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string roadid { get; set; }

        public string areaid { get; set; }

        public string zonename { get; set; }

        public string area { get; set; }

        public string roadname { get; set; }
    }

    private void BindColumnToGridview()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("roadid");
        dt.Columns.Add("areaid");
        dt.Columns.Add("zonename");
        dt.Columns.Add("area");
        dt.Columns.Add("roadname");
        dt.Rows.Add();

        griview_addarea.DataSource = dt;
        griview_addarea.DataBind();
        //griview_addarea.Rows[0].Visible = false;
    }

    private void fillgridview()
    {
        string query = "select  roadid, areaid,zonename, area,roadname from road_master where status=1 order by roadid desc";
        ViewState["q"] = query;
        DataTable dt;
        dt = objdut.GetDataTable(query);
        griview_addarea.DataSource = dt;
        griview_addarea.DataBind();
    }

    private void fildll()
    {
        ddl_Busroot.DataSource = CommonClass.ABC("zone"); //CommonClass.Dll("zone");
        ddl_Busroot.DataTextField = "zonename";
        ddl_Busroot.DataValueField = "zoneid";
        ddl_Busroot.DataBind();
        //int ddlbus = Convert.ToInt32(ddl_Busroot.SelectedValue);
        //ViewState["ddd1l"] = ddlbus;
        ddl_Busroot.Items.Insert(0, new ListItem("--Select Sector--", "0"));
        ddlarea1.Items.Clear();
    }

    [WebMethod]
    public static citymaster[] bindarea(string zoneid)
    {
        List<citymaster> details = new List<citymaster>();
        DataTable dtcity = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select areaid,areaname from tbl_addarea where status=1 and zoneid=" + zoneid, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dtcity);
                citymaster objProductMasterDetails0 = new citymaster();
                objProductMasterDetails0.areaid = Convert.ToInt32("0");
                objProductMasterDetails0.areaname = "-Select Society-";
                details.Add(objProductMasterDetails0);

                foreach (DataRow dtrow in dtcity.Rows)
                {
                    citymaster citymasterobj = new citymaster();
                    citymasterobj.areaid = Convert.ToInt32(dtrow["areaid"].ToString());
                    citymasterobj.areaname = dtrow["areaname"].ToString();
                    details.Add(citymasterobj);
                }
            }
        }
        return details.ToArray();
    }

    public class citymaster
    {
        public int areaid { get; set; }

        public string areaname { get; set; }
    }

    [WebMethod]
    public static string addroad(int zoneid, string zonename, int areaid, string areaname, string road, string textname, int roadid)
    {
        int ret = 0;
        DataTable dt = new DataTable();
        DataUtility objdut = new DataUtility();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            con.Open();

            if (textname == "Submit")
            {
                SqlParameter[] param = new SqlParameter[8];
                param[0] = new SqlParameter("@mode", "addarea");
                param[1] = new SqlParameter("@areaname", areaname);
                param[2] = new SqlParameter("@areaid", areaid);
                param[3] = new SqlParameter("@zonename", zonename);
                param[4] = new SqlParameter("@zoneid", zoneid);
                param[5] = new SqlParameter("@roadname", road);
                param[6] = new SqlParameter("@id", Convert.ToInt32("0"));
                param[7] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                param[7].Direction = ParameterDirection.Output;
                ret = objdut.ExecuteSqlSP(param, "usp_AddareawithRoad");
                if (ret > 0)
                {
                }
                else
                {
                }
            }
            if (textname == "Update")
            {
                SqlParameter[] param = new SqlParameter[8];
                param[0] = new SqlParameter("@mode", "update");
                param[1] = new SqlParameter("@areaname", areaname);
                param[2] = new SqlParameter("@areaid", areaid);
                param[3] = new SqlParameter("@zonename", zonename);
                param[4] = new SqlParameter("@zoneid", zoneid);
                param[5] = new SqlParameter("@roadname", road);
                param[6] = new SqlParameter("@id", roadid);
                param[7] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                param[7].Direction = ParameterDirection.Output;
                ret = objdut.ExecuteSqlSP(param, "usp_AddareawithRoad");
                if (ret > 0)
                {
                }
                else
                {
                }
            }
            con.Close();
            return Convert.ToString(ret);
        }
    }

    private void reset()
    {
        txtroad.Text = "";
        ddlarea1.SelectedIndex = 0;
        ddl_Busroot.SelectedIndex = 0;
        ddlarea1.Items.Clear();
    }

    private void fillgrid(string query)
    {
        DataTable dt2;
        dt2 = objdut.GetDataTable(query);
        griview_addarea.DataSource = dt2;
        griview_addarea.DataBind();
    }

    protected void btnroad_Click(object sender, EventArgs e)
    {
        Response.Redirect("addroad.aspx");
    }

    [WebMethod]
    public static feedetails[] filldata(string roadid)
    {
        List<feedetails> details = new List<feedetails>();
        DataUtility objdut = new DataUtility();
        DataTable dt = new DataTable();
        CommonClass CommonClass = new CommonClass();
        Utility objUT = new Utility();
        DataSet ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select zoneid,zonename,roadid,roadname,area,areaid from road_master where roadid=" + roadid + " and status=1", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    feedetails user = new feedetails();

                    user.zoneid = dt.Rows[0]["zoneid"].ToString();
                    user.zonename = dt.Rows[0]["zonename"].ToString();
                    user.roadid = dt.Rows[0]["roadid"].ToString();
                    user.roadname = dt.Rows[0]["roadname"].ToString();
                    user.area = dt.Rows[0]["area"].ToString();
                    user.areaid = dt.Rows[0]["areaid"].ToString();
                    details.Add(user);
                }
            }
        }
        return details.ToArray();
    }

    public class feedetails
    {
        public string zoneid { get; set; }

        public string zonename { get; set; }

        public string roadid { get; set; }

        public string roadname { get; set; }

        public string area { get; set; }

        public string areaid { get; set; }
    }
}