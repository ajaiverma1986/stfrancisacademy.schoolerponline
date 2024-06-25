using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Timetable_viewtimetable_daywise : System.Web.UI.Page
{
   private CommonClass CommonClass = new CommonClass();
    DataUtility Objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            BindDDl();
    }
    protected void BindDDl()
    {
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    [WebMethod]
    public static Getdaydetail[] BindGriddays(string fyid)
    {
        DataSet Ds = new DataSet();
        List<Getdaydetail> StatusDetails = new List<Getdaydetail>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 13);
        param[1] = new SqlParameter("@fyid", fyid);
        Ds = Objdut.GetDataSetSP(param, "[Usp_timetablesettingsdetails]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                Getdaydetail user = new Getdaydetail();
                user.Classid = dtrow["Classid"].ToString();
                user.Classname = dtrow["Classname"].ToString();              
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class Getdaydetail
    {
        public string Sectionid { get; set; }
        public string Sectionname { get; set; }
        public string Classid { get; set; }
        public string Classname { get; set; }
    }

    [WebMethod]
    public static Getdaydetail[] BindClassSection(string classid)
    {
        DataSet Ds = new DataSet();
        List<Getdaydetail> StatusDetails = new List<Getdaydetail>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 14);
        param[1] = new SqlParameter("@classid", classid);
       
        Ds = Objdut.GetDataSetSP(param, "[Usp_timetablesettingsdetails]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                Getdaydetail user = new Getdaydetail();
                user.Sectionid = dtrow["Sectionid"].ToString();
                user.Classname = dtrow["Classname"].ToString();
                user.Sectionname = dtrow["Sectionname"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }

    [WebMethod]
    public static timetable[] viewtimetable()
    {
        DataUtility objdut = new DataUtility();
        List<timetable> Details = new List<timetable>();
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode",12);
        dt = objdut.GetDataTableSP(param, "[Usp_timetablesettingsdetails]");
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in dt.Rows)
            {
                timetable Dsdetails = new timetable();
                Dsdetails.did = Convert.ToInt32(dtrow["did"].ToString());
                Dsdetails.dayname = dtrow["dayname"].ToString();
                Details.Add(Dsdetails);
            }
        }
        return Details.ToArray();
    }

    public class timetable
    {
        public int did { get; set; }

        public string dayname { get; set; }
    }

    }
