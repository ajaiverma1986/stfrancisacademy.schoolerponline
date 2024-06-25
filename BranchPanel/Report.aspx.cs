using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_Report : System.Web.UI.Page
{
    private SqlParameter[] param3 = new SqlParameter[4];
    private int totalpage = 0;
    private DataUtility objDUT = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        string url = Request.Url.ToString();
        if (Session["BrBrid"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!IsPostBack)
        {
            ViewState["acad"] = CommonClass.Scaler("ActiveAcademicYear");
            ViewState["noofrecord"] = 10;
            ViewState["PageNo"] = 1;
            string query = string.Empty;

            setpage();
            //BindColumnToGridview();
            binddata(10, 1, 0, "");

            fillDDL();
            fillbus();
        }
    }

    private void BindColumnToGridview()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("studentAdmissionnNo");
        dt.Columns.Add("studentname");
        dt.Columns.Add("routeno");
        dt.Columns.Add("busno");
        dt.Columns.Add("Classname");
        dt.Columns.Add("areaname");
        dt.Columns.Add("areaid");
        dt.Columns.Add("zoneid");
        dt.Columns.Add("ZoneName");
        dt.Columns.Add("busid");
        dt.Rows.Add();
        gvdetails.DataSource = dt;
        gvdetails.DataBind();
    }

    private void fillbus()
    {
        string query2 = "select registrationno,id from tbl_vehicleinfo";
        ddlbus.DataSource = objDUT.GetDataTable(query2);
        ddlbus.DataTextField = "registrationno";
        ddlbus.DataValueField = "id";
        ddlbus.DataBind();
        ListItem li = new ListItem("--Select Bus--", "0");
        ddlbus.Items.Insert(0, li);
        ListItem li1 = new ListItem("--Select Section--", "0");
        //ddlsection.Items.Insert(0, li1);
    }

    protected void fillDDL()
    {
        string query1 = @"select cm.id,cm.Classname from Class_Master cm left outer join ClassBranch_master cbm on cm.id=cbm.classid and cm.Status=1 where cbm.BranchId=" + Convert.ToDouble(Session["BrBrid"]) + " and cbm.Status=1";
        ddlClass.DataSource = objDUT.GetDataTable(query1);
        ddlClass.DataTextField = "Classname";
        ddlClass.DataValueField = "id";
        ddlClass.DataBind();
        ListItem li = new ListItem("--Select Class--", "0");
        ddlClass.Items.Insert(0, li);
    }

    public void binddata(int pagesize, int currentpage, int id, string busno)
    {
        DataTable dt = new DataTable();
        SqlParameter[] param1 = new SqlParameter[6];
        param1[0] = new SqlParameter("@PageSize", pagesize);
        param1[1] = new SqlParameter("@CurrentPage", currentpage);
        param1[2] = new SqlParameter("@searchvalue1", id);
        param1[3] = new SqlParameter("@searchvalue2", busno);
        param1[4] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));
        param1[5] = new SqlParameter("@fyid", ViewState["acad"]);

        dt = objDUT.GetDataTableSP(param1, "usp_transport_report");
        if (dt.Rows.Count > 0)
        {
            gvdetails.Visible = true;
            gvdetails.DataSource = dt;
            gvdetails.DataBind();
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "No record found.");
            gvdetails.DataSource = null;
            gvdetails.DataBind();
        }
    }

    [WebMethod]
    public static UserDetails[] BindDatatable(string pagesize, string pageno, int searchvalue1, string searchvalue2)
    {
        if (pageno == "Page No")
        {
            pageno = "1";
        }

        if (pageno == "")
        {
            pageno = "1";
        }
        DataSet ds = new DataSet();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_transport_report]", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[6];
                param[0] = new SqlParameter("@PageSize ", pagesize);
                param[1] = new SqlParameter("@CurrentPage", pageno);
                param[2] = new SqlParameter("@searchvalue1", searchvalue1);
                param[3] = new SqlParameter("@searchvalue2", searchvalue2);
                param[4] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);
                param[5] = new SqlParameter("@fyid", CommonClass.Scaler("ActiveAcademicYear"));

                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                con.Open();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.studentAdmissionnNo = dtrow["studentAdmissionnNo"].ToString();
                        user.studentname = dtrow["studentname"].ToString();
                        user.routeno = dtrow["routeno"].ToString();
                        user.busno = dtrow["busno"].ToString();
                        user.Classname = dtrow["Classname"].ToString();
                        user.areaname = dtrow["areaname"].ToString();
                        user.areaid = Convert.ToInt32(dtrow["areaid"].ToString());
                        user.zoneid = Convert.ToInt32(dtrow["zoneid"].ToString());
                        user.ZoneName = dtrow["ZoneName"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string studentAdmissionnNo { get; set; }

        public string studentname { get; set; }

        public string routeno { get; set; }

        public string busno { get; set; }

        public string Classname { get; set; }

        public string areaname { get; set; }

        public int areaid { get; set; }

        public int zoneid { get; set; }

        public string ZoneName { get; set; }
    }

    private void setpage()
    {
        string query = "select count(1) from tbl_addbusforstudent where  branchid=" + Session["BrBrid"] + " and fyid=" + ViewState["acad"];
        int i = 0;
        PageNo.Items.Clear();
        PageNo.Items.Insert(i, Convert.ToString("Page No"));
        totalpage = Convert.ToInt32(objDUT.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(objDUT.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
        {
            //  totalpage = totalpage + 1;
        }
        else
        {
            totalpage = totalpage + 1;
        }
        for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
        {
            PageNo.Items.Insert(page, Convert.ToString(page));
            page = page + 1;
        }
        if (Convert.ToInt32(ViewState["PageNo"]) > totalpage)
        {
            ViewState["PageNo"] = 1;
        }
    }

    [WebMethod]
    public static ArrayList bingrid1(string pagesize, string pageno, int searchvalue1, string searchvalue2)
    {
        System.Collections.ArrayList details1 = new ArrayList();
        DataTable dt = new DataTable();
        SqlCommand cmd;
        int countnew = 0;
        if (pageno == "")
        {
            pageno = "1";
        }
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            if (searchvalue1 == 0 && searchvalue2 == "")
            {
                con.Open();
                string query = "select count(1) from tbl_addbusforstudent where branchid=" + HttpContext.Current.Session["BrBrid"] + " and fyid=" + CommonClass.Scaler("ActiveAcademicYear");
                cmd = new SqlCommand(query, con);
                countnew = Convert.ToInt32(cmd.ExecuteScalar());
            }
            else if (searchvalue1 > 0 && searchvalue2 == "")
            {
                con.Open();
                string query = @"select count(1) from tbl_addbusforstudent tas inner join Zone_Master zm on tas.zoneid=zm.zoneid join tbl_addarea ta on ta.zoneid=zm.zoneid join Class_Master cm on tas.classid=cm.id  where   tas.branchid=" + HttpContext.Current.Session["BrBrid"] + " and tas.fyid=" + CommonClass.Scaler("ActiveAcademicYear") + " and  tas.classid =" + searchvalue1;
                cmd = new SqlCommand(query, con);
                countnew = Convert.ToInt32(cmd.ExecuteScalar());
            }
            else if (searchvalue1 == 0 && searchvalue2 != "")
            {
                con.Open();
                string query = (@"select count(1) from tbl_addbusforstudent tas inner join Zone_Master zm on tas.zoneid=zm.zoneid join tbl_addarea ta on ta.zoneid=zm.zoneid join Class_Master cm on tas.classid=cm.id where  tas.branchid=" + HttpContext.Current.Session["BrBrid"] + " and tas.fyid=" + CommonClass.Scaler("ActiveAcademicYear") + " and  tas.busno ='" + searchvalue2 + "'");
                cmd = new SqlCommand(query, con);
                countnew = Convert.ToInt32(cmd.ExecuteScalar());
            }
            else if (searchvalue1 > 0 && searchvalue2 != "")
            {
                con.Open();
                string query = (@"select count(1) from tbl_addbusforstudent tas inner join Zone_Master zm on tas.zoneid=zm.zoneid join tbl_addarea ta on ta.zoneid=zm.zoneid join Class_Master cm on tas.classid=cm.id where   tas.branchid=" + HttpContext.Current.Session["BrBrid"] + " and tas.fyid=" + CommonClass.Scaler("ActiveAcademicYear") + " and  tas.classid =" + searchvalue1 + " and tas.busno ='" + searchvalue2 + "'");
                cmd = new SqlCommand(query, con);
                countnew = Convert.ToInt32(cmd.ExecuteScalar());
            }

            int i = 0;

            con.Close();

            int totalpage = 0;

            details1.Insert(i, Convert.ToString("Page No"));
            totalpage = countnew / Convert.ToInt32(pagesize);

            if ((Convert.ToInt32(countnew)) % (Convert.ToInt32(pagesize)) == 0)
            {
                //  totalpage = totalpage + 1;
            }
            else
            {
                totalpage = totalpage + 1;
            }

            for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
            {
                details1.Insert(page, Convert.ToString(page));

                page = page + 1;
            }

            if (Convert.ToInt32(HttpContext.Current.Session["PageNo"]) > totalpage)
            {
                HttpContext.Current.Session["PageNo"] = 1;
            }
        }
        return details1;
    }
}