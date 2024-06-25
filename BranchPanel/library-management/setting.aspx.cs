using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_library_management_setting : System.Web.UI.Page
{
    private DataTable dt;
    private DataUtility objdut = new DataUtility();
    private string query = "";
    private SqlParameter[] param;
    private string url = "";
    private static int academicyear = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

   //************************************************getdatato commantoall************************************************
    [WebMethod]
    public static string getdata(int Fyid)
    {
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@Fyid",Fyid);
        param[1] = new SqlParameter("@Brid",HttpContext.Current.Session["Brbrid"]);
        return (Convert.ToString(ObjDUT.GetScalerSP(param, "[Usp_ManagementOfLibrarySettings]")));
    }

    //******************************************save comman setting for all class****************************************
    [WebMethod]
    public static int savesettingdata(string classname, string Noofbook, string finestatus, string fineamt, string Noofdaytoreturn, string settingstatus, string session, string settingfor, string fromdate, string todate)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_booksetting]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@classname",classname);
                cmd.Parameters.Add("@mode",2);
                cmd.Parameters.Add("@nbook_card",Noofbook);
                cmd.Parameters.Add("@allow_fine",finestatus);
                cmd.Parameters.Add("@returnday_book",Noofdaytoreturn);
                cmd.Parameters.Add("@amt_perday",fineamt);
                cmd.Parameters.Add("@fyid",session);
                cmd.Parameters.Add("@issettingfor", settingfor);
                cmd.Parameters.Add("@status",settingstatus);
                cmd.Parameters.Add("@todate", todate);
                cmd.Parameters.Add("@fromdate", fromdate);
                cmd.Parameters.Add("@brid",Convert.ToString(HttpContext.Current.Session["BrBrid"]));
                int result = cmd.ExecuteNonQuery();
                return result;
            }
        }
    }
    //*************************************************get details for classwise************************************************************
  
    [WebMethod]
    public static classdata[] getclasswisedatadetail(int fyid)
    {
        DataUtility objdut = new DataUtility();
        List<classdata> result = new List<classdata>();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@brid",Convert.ToString(HttpContext.Current.Session["BrBrid"]));
        param[2] = new SqlParameter("@fyid", fyid);
        DataTable dt = objdut.GetDataTableSP(param, "[usp_booksetting]");
        foreach (DataRow dtrow in dt.Rows)
        {
            classdata user = new classdata();
            user.classid = dtrow["classid"].ToString();
            user.classname = dtrow["classname"].ToString();
            user.Noofbook = dtrow["nbook_card"].ToString();
            user.allowfine = dtrow["allow_fine"].ToString();
            user.fineamount = dtrow["amt_perday"].ToString();
            user.noofdaytoreturn = dtrow["returnday_book"].ToString();
            user.status = dtrow["status"].ToString();
            user.sbcwid = dtrow["sbcwid"].ToString();
            result.Add(user);
        }
        return result.ToArray();
    }

    public class classdata
    {
        public string classid { get; set; }
        public string classname { get; set; }      
        public string Noofbook { get; set; }
        public string allowfine { get; set; }
        public string fineamount { get; set; }
        public string noofdaytoreturn { get; set; }
        public string status { get; set; }
        public string sbcwid { get; set; }
    }
    //*********************************************************save the setting classwise****************************************
    [WebMethod]
    public static int revisedataclasswise(string classid, string noofbook, string allowfine, string fineamount, string noofdaytoreturn, string status, string session, string cwid, string settingfor, string revisesettingapplydate)
    {
       
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[13];
        param[0] = new SqlParameter("@classid", classid);
        param[1] = new SqlParameter("@nbook_card", noofbook);
        param[2] = new SqlParameter("@allow_fine", allowfine);
        param[3] = new SqlParameter("@amt_perday", fineamount);
        param[4] = new SqlParameter("@returnday_book", noofdaytoreturn);
        param[5] = new SqlParameter("@status", status);
        param[6] = new SqlParameter("@brid", Convert.ToString(HttpContext.Current.Session["BrBrid"]));
        param[7] = new SqlParameter("@fyid",session);
        param[8] = new SqlParameter("@INTRESULT", 0);
        param[8].Direction = ParameterDirection.Output;
        param[9] = new SqlParameter("@cwid", cwid);
        param[10] = new SqlParameter("@issettingfor", settingfor);
        param[11] = new SqlParameter("@fromdate", revisesettingapplydate);
        param[12] = new SqlParameter("@mode",5);
        int result = objdut.ExecuteSqlSP(param, "[usp_booksetting]");
        return result;
    }
    //**********************************************************update or save setting for particular class***********************************
    [WebMethod]
    public static int updatedataclasswise(string classid, string noofbook, string allowfine, string fineamount, string noofdaytoreturn, string status, string session, string cwidforupdate, string settingfor)
    {

        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[12];
        param[0] = new SqlParameter("@classid", classid);
        param[1] = new SqlParameter("@nbook_card", noofbook);
        param[2] = new SqlParameter("@allow_fine", allowfine);
        param[3] = new SqlParameter("@amt_perday", fineamount);
        param[4] = new SqlParameter("@returnday_book", noofdaytoreturn);
        param[5] = new SqlParameter("@status", status);
        param[6] = new SqlParameter("@brid", Convert.ToString(HttpContext.Current.Session["BrBrid"]));
        param[7] = new SqlParameter("@mode",4);
        param[8] = new SqlParameter("@fyid", session);
        param[9] = new SqlParameter("@INTRESULT", 0);
        param[9].Direction = ParameterDirection.Output;
        param[10] = new SqlParameter("@cwid", cwidforupdate);
        param[11] = new SqlParameter("@issettingfor", settingfor);
        int result = objdut.ExecuteSqlSP(param, "[usp_booksetting]");
        return result;
    }
    //*******************************************************for session or fyid**********************************************************************
    [WebMethod]
    public static getsession[] bindsession()
    {
        List<getsession> Details = new List<getsession>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@whyCall","GetAcademicYearDDL");
        Dt = Objdut.GetDataTableSP(param,"MasterProc");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                getsession obje = new getsession();
                obje.id = Convert.ToInt32(Dt.Rows[i]["fyid"]);
                obje.session = Convert.ToString(Dt.Rows[i]["FYName"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }

    public class getsession
    {
        public int id { get; set; }

        public string session { get; set; }
    }
}