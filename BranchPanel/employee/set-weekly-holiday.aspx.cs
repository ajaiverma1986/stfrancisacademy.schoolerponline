using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class BranchPanel_set_weekly_holiday : System.Web.UI.Page
{
    private CommonClass commonOBJ = new CommonClass();
    private static int fyid = 2;
    private static int brid = 0;
    private DataUtility objDUT = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        fyid = CommonClass.Scaler("ActiveAcademicYear");
        if (Session["BrBrid"] != "" && Session["BrBrid"] != null)
        {
            brid = Convert.ToInt32(Session["BrBrid"]);
        }

        BindReapeter();

        BindGrid();
    }

    protected void BindGrid()
    {
        string str = "select ROW_NUMBER() over (ORDER BY wdid) AS Number,dayname,wdid from workingdays where status=0 and brid=" + Convert.ToInt32(Session["BrBrid"]) + "";
        DataTable Dt = objDUT.GetDataTable(str);
        if (Dt.Rows.Count > 0)
        {
            gvdetails.DataSource = Dt;
            gvdetails.DataBind();
            trmessage.Style.Add("display", "none");
        }
        else
        {
            str = "select ROW_NUMBER() over (ORDER BY wdid) AS Number,dayname,wdid from workingdays where brid=" + Convert.ToInt32(Session["BrBrid"]) + "";
            Dt = objDUT.GetDataTable(str);
            if (Dt.Rows.Count > 0)
            {
                gvdetails.DataSource = Dt;
                gvdetails.DataBind();
                trmessage.Style.Add("display", "Block");
                trgrid.Style.Add("display", "none");
            }
        }
    }

    protected void BindReapeter()
    {
        DataTable dt = objDUT.GetDataTable("select wdid,dayname from workingdays");
        if (dt.Rows.Count > 0)
        {
            dlsponserad.DataSource = dt;
            dlsponserad.DataBind();
        }
        else
        {
            dlsponserad.Dispose();
        }
    }

    [WebMethod]
    public static int InsertHoliday(string Dayid)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_Insert_weeklyHoliday]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[2];

                param[0] = new SqlParameter("@dayid", Dayid);

                param[1] = new SqlParameter("@intresult", SqlDbType.Int);
                param[1].Direction = ParameterDirection.Output;

                cmd.Parameters.Add(param[0]);

                cmd.Parameters.Add(param[1]);

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }

    [WebMethod]
    public static datlist[] bindrepeater()
    {
        DataTable dt = new DataTable();
        List<datlist> details = new List<datlist>();
        DataUtility ObjDUT = new DataUtility();

        dt = ObjDUT.GetDataTable("select ROW_NUMBER() over (ORDER BY wdid) AS Number,dayname,wdid from workingdays where status=0 and brid=" + brid + "");
        foreach (DataRow dtrow in dt.Rows)
        {
            datlist day = new datlist();
            day.Number = dtrow["Number"].ToString();
            day.wdid = dtrow["wdid"].ToString();
            day.dayname = dtrow["dayname"].ToString();
            details.Add(day);
        }
        return details.ToArray();
    }

    public class datlist
    {
        public string Number { get; set; }

        public string dayname { get; set; }

        public string wdid { get; set; }
    }

    [WebMethod]
    public static int removeholiday(string Dayid)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("update workingdays set status=1 where wdid=" + Convert.ToInt32(Dayid) + "", con))
            {
                con.Open();
                cmd.CommandType = CommandType.Text;
                int result = cmd.ExecuteNonQuery();
                return result;
            }
        }
    }
}