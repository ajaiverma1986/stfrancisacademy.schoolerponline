using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class branchpanel_employee_leavehistory : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private string url = "";
    public static int pagesize = 10;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        if (!IsPostBack)
        {
            getleaveslist();
            fillleavetypes();
            gethalfdayleaveslist();
        }
    }

    protected void fillleavetypes()
    {
        string query = "select Leave_Type,Ltid  from tbl_leavetype where Status = 1 order by Leave_Type";
        DataTable dtdept = objdut.GetDataTable(query);
        if (dtdept.Rows.Count > 0)
        {
            ddlleavetype.DataSource = dtdept;
            ddlleavetype.DataTextField = "Leave_Type";
            ddlleavetype.DataValueField = "Ltid";
            ddlleavetype.DataBind();
            ddlleavetype.Items.Insert(0, new ListItem("---Type---", "0"));
        }

        DataTable dtfyid = objdut.GetDataTable("select FYID,FYName from financial_Year");
        ddlfinicialyear.DataSource = dtfyid;
        ddlfinicialyear.DataTextField = "FYName";
        ddlfinicialyear.DataValueField = "FYID";
        ddlfinicialyear.DataBind();
        ddlfinicialyear.Items.Insert(0, new ListItem("--Year--", "0"));
    }

    private void getleaveslist()
    {
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@empname", "");
        param[1] = new SqlParameter("@leavefromdate", "");
        param[2] = new SqlParameter("@leaveapplieddate", "");
        param[3] = new SqlParameter("@mode", 1);
        param[4] = new SqlParameter("@pageno", 1);
        param[5] = new SqlParameter("@pagesize", 10);
        DataSet ds = objdut.GetDataSetSP(param, "[usp_searchProcDemo]");

        gvdetails.DataSource = ds.Tables[0];
        gvdetails.DataBind();
        lblpage.Text = "1";
        lblTotalPages.Text = ds.Tables[1].Rows[0]["pages"].ToString();
    }

    [WebMethod]
    public static UserDetails[] BindDatatable(string fname, string datefirst, string datesecond, string leavetype, string pageno, string fyid)
    {
        DataSet ds = new DataSet();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_searchProcDemo]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[8];
                param[0] = new SqlParameter("@empname", fname);
                param[1] = new SqlParameter("@leavefromdate", datefirst);
                param[2] = new SqlParameter("@leaveapplieddate", datesecond);
                param[3] = new SqlParameter("@leavetype", leavetype);
                param[4] = new SqlParameter("@mode", 1);
                param[5] = new SqlParameter("@pageno", pageno);
                param[6] = new SqlParameter("@pagesize", pagesize);
                param[7] = new SqlParameter("@fyid", fyid);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);
                cmd.Parameters.Add(param[6]);
                cmd.Parameters.Add(param[7]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.refNo = dtrow["refNo"].ToString();
                        user.name = dtrow["name"].ToString();
                        user.Leave_Start_From = dtrow["Leave_Start_From"].ToString();
                        user.Leave_Apply_Date = dtrow["Leave_Apply_Date"].ToString();
                        user.Leave_Type = dtrow["Leave_Type"].ToString();
                        user.leave_status = dtrow["leave_status"].ToString();
                        user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString();
                        user.rownumber = dtrow["RowNumber"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string rownumber { get; set; }

        public string refNo { get; set; }

        public string name { get; set; }

        public string Leave_Start_From { get; set; }

        public string Leave_Apply_Date { get; set; }

        public string Leave_Type { get; set; }

        public string leave_status { get; set; }

        public string pagecount { get; set; }
    }

    private void gethalfdayleaveslist()
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 9);
        param[1] = new SqlParameter("@leavestatus", 2);
        DataTable dt = objdut.GetDataTableSP(param, "[usp_leavehistory]");
        gvleavedetails.DataSource = dt;
        gvleavedetails.DataBind();
    }

    [WebMethod]
    public static halfdayleave[] BindDatatableforhalfday(string fname, string leavetype)
    {
        DataSet ds = new DataSet();
        List<halfdayleave> details = new List<halfdayleave>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_leavehistory]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@fname", fname);
                param[1] = new SqlParameter("@leavestatus", leavetype);
                param[2] = new SqlParameter("@mode", 9);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        halfdayleave user = new halfdayleave();
                        user.eid = dtrow["eid"].ToString();
                        user.refNo = dtrow["refNo"].ToString();
                        user.name = dtrow["name"].ToString();
                        user.hd_date = dtrow["hd_date"].ToString();
                        user.hdid = dtrow["hdid"].ToString();
                        user.halfday = dtrow["halfday"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class halfdayleave
    {
        public string eid { get; set; }

        public string refNo { get; set; }

        public string name { get; set; }

        public string hd_date { get; set; }

        public string hdid { get; set; }

        public string halfday { get; set; }
    }
}