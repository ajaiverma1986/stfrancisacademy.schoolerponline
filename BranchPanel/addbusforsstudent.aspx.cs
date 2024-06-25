using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_addbusforsstudent : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    private DataUtility objdut = new DataUtility();
    private Utility objut = new Utility();
    private SqlParameter[] param;
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
    private SqlCommand cmd = new SqlCommand();
    private DataTable dt, dt1, dt2;

    private static int academicyear_id = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ViewState["acad"] = CommonClass.Scaler("ActiveAcademicYear");

            fillzonewisearea();
            fillbus();

            bindgridview(20, 1, 0, "", "", "");
        }
    }

    private void fillgrd()
    {
        string str = "select ta.*,(sm.FirstName+' '+sm.LastName) as name from tbl_Admission ta inner join student_master sm on sm.ADMIID=ta.ADMIID where transportaion=1 and ta.fyid=" + ViewState["acad"] + " and ta.brid=" + Session["BrBrid"];
        dt2 = objdut.GetDataTable(str);
        if (dt2.Rows.Count > 0)
        {
            griview_addarea.Visible = true;
            griview_addarea.DataSource = dt2;
            griview_addarea.DataBind();
        }
        else
        {
            griview_addarea.EmptyDataText = "No Record Found.";
            griview_addarea.DataSource = null;
            griview_addarea.DataBind();
        }
    }

    private void fillbus()
    {
    }

    private void fillzonewisearea()
    {
        DropDownList1.DataSource = CommonClass.Dll("zone");
        DropDownList1.DataTextField = "zonename";
        DropDownList1.DataValueField = "zoneid";
        DropDownList1.DataBind();
        DropDownList1.Items.Insert(0, new ListItem("--Select Zone--", "0"));
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        griview_addarea.Visible = false;
    }

    protected void griview_addarea_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbladno = (Label)e.Row.FindControl("lblproducname");
            LinkButton lnked = (LinkButton)e.Row.FindControl("Ed1");

            int chk = Convert.ToInt32(objdut.GetScalar("select isnull(max(id),0) from tbl_addbusforstudent where studentAdmissionnNo='" + lbladno.Text + "' and trstatus!=0"));
            if (chk > 0)
            {
                lnked.Text = "Already Added";

                lnked.Enabled = false;
                lnked.ForeColor = System.Drawing.Color.Black;
            }
            else
            {
                lnked.Text = "Add";
            }
        }
    }

    [WebMethod]
    public static bindclasses_new[] bindarea(string ddlzoneid)
    {
        List<bindclasses_new> details = new List<bindclasses_new>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select areaid,areaname from tbl_addarea where zoneid=" + ddlzoneid, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                bindclasses_new objProductMasterDetails0 = new bindclasses_new();
                objProductMasterDetails0.SID = Convert.ToInt32("0");
                objProductMasterDetails0.statename = "-Select Area-";
                details.Add(objProductMasterDetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    bindclasses_new objProductMasterDetails = new bindclasses_new();
                    objProductMasterDetails.SID = Convert.ToInt32(dtrow["areaid"].ToString());
                    objProductMasterDetails.statename = dtrow["areaname"].ToString();
                    details.Add(objProductMasterDetails);
                }
            }
        }
        return details.ToArray();
    }

    public class bindclasses_new
    {
        public int SID { get; set; }

        public string statename { get; set; }
    }

    [WebMethod]
    public static bindarea_new[] bindbus(string areaid)
    {
        List<bindarea_new> details = new List<bindarea_new>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select distinct isnull(busno,'-') as  busno, ROW_NUMBER() OVER(ORDER BY busno ASC) as rowNumber  from tbl_stopage group by busno,Areaid having Areaid=" + areaid + " and busno is not NULL", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                bindarea_new objProductMasterDetails0 = new bindarea_new();
                objProductMasterDetails0.areaid = Convert.ToInt32("0");
                objProductMasterDetails0.areaname = "-Select Bus-";
                details.Add(objProductMasterDetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    bindarea_new objProductMasterDetails = new bindarea_new();
                    objProductMasterDetails.areaid = Convert.ToInt32(dtrow["rowNumber"].ToString());
                    objProductMasterDetails.areaname = dtrow["busno"].ToString();
                    details.Add(objProductMasterDetails);
                }
            }
        }
        return details.ToArray();
    }

    public class bindarea_new
    {
        public int areaid { get; set; }

        public string areaname { get; set; }
    }

    [WebMethod]
    public static binstoppage[] binstopage(string busid)
    {
        List<binstoppage> details = new List<binstoppage>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select stopagename,stopageid from tbl_stopage where busno='" + busid + "'", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                binstoppage objProductMasterDetails0 = new binstoppage();
                objProductMasterDetails0.stopid = Convert.ToInt32("0");
                objProductMasterDetails0.stopname = "-Select Stoppage-";
                details.Add(objProductMasterDetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    binstoppage objProductMasterDetails = new binstoppage();
                    objProductMasterDetails.stopid = Convert.ToInt32(dtrow["stopageid"].ToString());
                    objProductMasterDetails.stopname = dtrow["stopagename"].ToString();
                    details.Add(objProductMasterDetails);
                }
            }
        }
        return details.ToArray();
    }

    public class binstoppage
    {
        public int stopid { get; set; }

        public string stopname { get; set; }
    }

    [WebMethod]
    public static int findseat(string busid)
    {
        DataUtility objdut = new DataUtility();
        CommonClass CommonClass = new CommonClass();
        Utility objUT = new Utility();
        DataSet ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            int q2 = Convert.ToInt32(objdut.GetScalar("select count(1) from tbl_addbusforstudent where busno='" + busid + "'"));
            int q3 = Convert.ToInt32(objdut.GetScalar("select noofseats from tbl_vehicleinfo where registrationno='" + busid + "'"));
            int m1 = Convert.ToInt32(q3 - q2);
            return m1;
        }
    }

    [WebMethod]
    public static int insertdata(string adno, string sname, string classnm, int zoneid, int areaid, int busid, string busno, int stoppageid)
    {
        DataUtility objdut = new DataUtility();
        DataTable dt = new DataTable();

        string monthidfde = "";
        DateTime date = Convert.ToDateTime(objdut.GetScalar("select getdate()"));

        int monthid12 = Convert.ToInt32(objdut.GetScalar("select DATEPART(month,getdate())"));

        int monthid = 0;

        if (monthid12 == 1)
        {
            monthid = 10;
        }
        else if (monthid12 == 2)
        {
            monthid = 11;
        }
        else if (monthid12 == 3)
        {
            monthid = 12;
        }
        else if (monthid12 == 4)
        {
            monthid = 11;
        }
        else if (monthid12 == 5)
        {
            monthid = 2;
        }
        else if (monthid12 == 6)
        {
            monthid = 3;
        }
        else if (monthid12 == 7)
        {
            monthid = 4;
        }
        else if (monthid12 == 8)
        {
            monthid = 5;
        }
        else if (monthid12 == 9)
        {
            monthid = 6;
        }
        else if (monthid12 == 10)
        {
            monthid = 7;
        }
        else if (monthid12 == 11)
        {
            monthid = 8;
        }
        else if (monthid12 == 12)
        {
            monthid = 9;
        }

        int monthidfordeactive;

        if (monthid == 12)
        {
            monthidfordeactive = 0;
        }
        else
        {
            monthidfordeactive = monthid;

            for (int i = monthidfordeactive; i <= 12; i++)
            {
                monthidfde = monthidfde + "," + Convert.ToString(i);
            }
        }

        monthidfde = monthidfde.Remove(0, 1);

        int adid = Convert.ToInt32(objdut.GetScalar("select adid from tbl_Admission where brid=" + HttpContext.Current.Session["BrBrid"] + " and fyid=" + CommonClass.Scaler("ActiveAcademicYear") + " and ADNO='" + adno + "'"));
        string q = Convert.ToString(objdut.GetScalar("select RouteName from tbl_stopage where busno='" + busno + "'"));
        int y = Convert.ToInt32(objdut.GetScalar("select classid from ClassBranch_master where BranchId=1 and classname='" + classnm + "'"));

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            con.Open();
            using (SqlCommand cmd = new SqlCommand("usp_addbusfrostudent", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@mode", "addbusforstudent");
                cmd.Parameters.AddWithValue("@studenAdmissionNo", adno);
                cmd.Parameters.AddWithValue("@studentname", sname);
                cmd.Parameters.AddWithValue("@classid", y);
                cmd.Parameters.AddWithValue("@zoneid", zoneid);
                cmd.Parameters.AddWithValue("@areaid", areaid);
                cmd.Parameters.AddWithValue("@busid", busid);
                cmd.Parameters.AddWithValue("@busno", busno);
                cmd.Parameters.AddWithValue("@stopageid", stoppageid);

                cmd.Parameters.AddWithValue("@branchid", HttpContext.Current.Session["BrBrid"]);
                cmd.Parameters.AddWithValue("@fyid", CommonClass.Scaler("ActiveAcademicYear"));
                cmd.Parameters.AddWithValue("@routeno", q);
                cmd.Parameters.AddWithValue("@adid", adid);
                cmd.Parameters.AddWithValue("@updatemonth", monthidfde);
                cmd.Parameters.Add("@intResult", SqlDbType.NVarChar, 100, "");
                cmd.Parameters["@intResult"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                int intResult = Convert.ToInt32(cmd.Parameters["@intResult"].Value);

                con.Close();

                if (intResult == 1)
                {
                    // string query0 = "select max(adid) from tbl_Admission where Brid=" + Convert.ToDouble(HttpContext.Current.Session["BrBrid"]);
                    return intResult;
                }
                else
                {
                    return intResult;
                }
            }
        }
        // return details.ToArray();
    }

    public void bindgridview(int pagesize, int pageno, int searchitem, string classid, string textboxvalue1, string sd)
    {
        DataTable dt = new DataTable();
        SqlParameter[] param1 = new SqlParameter[7];
        param1[0] = new SqlParameter("@PageSize", pagesize);
        param1[1] = new SqlParameter("@CurrentPage", pageno);
        param1[2] = new SqlParameter("@searchvalue1", searchitem);
        param1[3] = new SqlParameter("@searchvalue2", classid);
        param1[4] = new SqlParameter("@searchvalue3", sd);
        param1[5] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));
        param1[6] = new SqlParameter("@fyid", ViewState["acad"]);

        dt = objdut.GetDataTableSP(param1, "usp_addstudenttobusreportlist");
        if (dt.Rows.Count > 0)
        {
            griview_addarea.Visible = true;
            griview_addarea.DataSource = dt;
            griview_addarea.DataBind();
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "No record found.");
            griview_addarea.DataSource = null;
            griview_addarea.DataBind();
        }
    }

    [WebMethod]
    public static UserDetails[] binddata(string pagesize, string pageno, int searchitem, string classid, string sd)
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
            using (SqlCommand cmd = new SqlCommand("[usp_addstudenttobusreportlist]", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param1 = new SqlParameter[7];
                param1[0] = new SqlParameter("@PageSize", pagesize);
                param1[1] = new SqlParameter("@CurrentPage", pageno);
                param1[2] = new SqlParameter("@searchvalue1", searchitem);
                param1[3] = new SqlParameter("@searchvalue2", classid);
                param1[4] = new SqlParameter("@searchvalue3", sd);
                param1[5] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);
                param1[6] = new SqlParameter("@fyid", CommonClass.Scaler("ActiveAcademicYear"));

                cmd.Parameters.Add(param1[0]);
                cmd.Parameters.Add(param1[1]);
                cmd.Parameters.Add(param1[2]);
                cmd.Parameters.Add(param1[3]);
                cmd.Parameters.Add(param1[4]);
                cmd.Parameters.Add(param1[3]);
                cmd.Parameters.Add(param1[4]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                con.Open();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.ADNO = dtrow["adno"].ToString();
                        user.sturegno = dtrow["sturegno"].ToString();
                        user.ApplyClass = dtrow["ApplyClass"].ToString();
                        user.name = dtrow["name"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string ADNO { get; set; }

        public string sturegno { get; set; }

        public string ApplyClass { get; set; }

        public string name { get; set; }
    }
}