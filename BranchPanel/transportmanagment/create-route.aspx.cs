using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_transportmanagment_create_root : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static bindcityddlforsearch[] searchcity()
    {
        List<bindcityddlforsearch> details = new List<bindcityddlforsearch>();
        DataSet Ds = new DataSet();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 6);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        Ds = Objdut.GetDataSetSP(param, "[usp_bindtransportsetting]");
        bindcityddlforsearch obj = new bindcityddlforsearch();
        obj.zoneid = Convert.ToInt32("0");
        obj.zonename = "-- Select City --";

        details.Add(obj);
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                bindcityddlforsearch obje = new bindcityddlforsearch();
                obje.zoneid = Convert.ToInt32(dtrow["zoneid"].ToString());
                obje.zonename = dtrow["zonename"].ToString();
                details.Add(obje);
            }
        }
        return details.ToArray();
    }
    public class bindcityddlforsearch
    {
        public int zoneid { get; set; }
        public string zonename { get; set; }
    }

    [WebMethod]
    public static bindareaddl[] areaddl(string cityid)
    {
        List<bindareaddl> details = new List<bindareaddl>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        Dt = Objdut.GetDataTable("select areaid,areaname from tbl_addarea where zoneid = "+cityid);
        bindareaddl obj = new bindareaddl();
        obj.areaid = Convert.ToInt32("0");
        obj.areaname = "-- Select Area --";

        details.Add(obj);
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in Dt.Rows)
            {
                bindareaddl obje = new bindareaddl();
                obje.areaid = Convert.ToInt32(dtrow["areaid"].ToString());
                obje.areaname = dtrow["areaname"].ToString();
                details.Add(obje);
            }

        }
        return details.ToArray();
    }
    public class bindareaddl
    {
        public int areaid { get; set; }
        public string areaname { get; set; }
    }

    [WebMethod]
    public static bindroadddl[] BindDDLRoad(string ChangeBlockID)
    {
        List<bindroadddl> details = new List<bindroadddl>();
        DataSet Ds = new DataSet();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 7);
        param[1] = new SqlParameter("@BlockID", ChangeBlockID);
        Ds = Objdut.GetDataSetSP(param, "[usp_bindtransportsetting]");
        bindroadddl obj = new bindroadddl();
        obj.roadid = Convert.ToInt32("0");
        obj.roadname = "-- Select Road --";

        details.Add(obj);
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                bindroadddl obje = new bindroadddl();
                obje.roadid = Convert.ToInt32(dtrow["roadid"].ToString());
                obje.roadname = dtrow["roadname"].ToString();
                details.Add(obje);
            }
        }
        return details.ToArray();
    }
    public class bindroadddl
    {
        public int roadid { get; set; }
        public string roadname { get; set; }
    }

    [WebMethod]
    public static bindSoppageddl[] BindDDLStoppage(string changeRoadId)
    {
        List<bindSoppageddl> details = new List<bindSoppageddl>();
        DataSet Ds = new DataSet();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 8);
        param[1] = new SqlParameter("@changeroadid", changeRoadId);
        Ds = Objdut.GetDataSetSP(param, "[usp_bindtransportsetting]");
        bindSoppageddl obj = new bindSoppageddl();
        obj.stoppageid = Convert.ToInt32("0");
        obj.stoppagename = "-- Select Stoppage --";

        details.Add(obj);
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                bindSoppageddl obje = new bindSoppageddl();
                obje.stoppageid = Convert.ToInt32(dtrow["stoppageid"].ToString());
                obje.stoppagename = dtrow["stoppagename"].ToString();
                details.Add(obje);
            }
        }
        return details.ToArray();
    }
    public class bindSoppageddl
    {
        public int stoppageid { get; set; }
        public string stoppagename { get; set; }
    }

    [WebMethod]
    public static int SaveRouteData(string RouteId,string Routename, string Source, string Destination,
        string Distance, string AllCityForRouteID, string AllAreaForRouteID, string AllRoadForRouteID, string AllStoppageForRouteID, string AddUpdateMode, string RouteDetailupdateid, string AllBlockForRouteID, string AllRouteDetailsId)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[16];
        param[0] = new SqlParameter("@Routename", Routename);
        param[1] = new SqlParameter("@RouteSource", Source.Replace("`", "'"));
        param[2] = new SqlParameter("@Destination", Destination.Replace("`", "'"));
        param[3] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[4] = new SqlParameter("@Distance", Distance.Replace("`", "'"));
        param[5] = new SqlParameter("@BrAdId", System.Web.HttpContext.Current.Session["BrADID"].ToString());
        param[6] = new SqlParameter("@City", AllCityForRouteID);
        param[7] = new SqlParameter("@Area ", AllAreaForRouteID);
        param[8] = new SqlParameter("@Road", AllRoadForRouteID);
        param[9] = new SqlParameter("@Stopage", AllStoppageForRouteID);
        param[10] = new SqlParameter("@mode", AddUpdateMode);
        param[11] = new SqlParameter("@RouteUpdtID", RouteDetailupdateid);
        param[12] = new SqlParameter("@Block", AllBlockForRouteID);
        param[13] = new SqlParameter("@intResult", SqlDbType.Int);
        param[13].Direction = ParameterDirection.Output;
        param[14] = new SqlParameter("@RouteIDForUpdate", RouteId);
        param[15] = new SqlParameter("@RouteDetailsId", AllRouteDetailsId);
        Objdut.ExecuteSqlSP(param, "[Usp_ManageRoute]");
        int result = Convert.ToInt32(param[13].Value);
        return result;
    }
    [WebMethod]
    public static bindRoutetxt[] BindTxtFieldsOfRouteDetails(string RouteDetailupdateid)
    {
        List<bindRoutetxt> details = new List<bindRoutetxt>();
        DataSet Ds = new DataSet();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 4);
        param[1] = new SqlParameter("@RouteID", RouteDetailupdateid);
        Ds = Objdut.GetDataSetSP(param, "[Usp_ManageRoute]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                bindRoutetxt user = new bindRoutetxt();
                user.RouteSource = dtrow["RouteSource"].ToString();
                user.Destination = dtrow["Destination"].ToString();
                user.Distance = dtrow["Distance"].ToString();
                user.RouteName = dtrow["RouteName"].ToString();
                user.RouteId = dtrow["RoutID"].ToString();
                details.Add(user);
            }
            foreach (DataRow dtrow1 in Ds.Tables[1].Rows)
            {
                bindRoutetxt user = new bindRoutetxt();
                user.CityID = dtrow1["CityID"].ToString();
                user.AreaID = dtrow1["AreaID"].ToString();
                user.RoadID = dtrow1["RoadID"].ToString();
                user.StoppageID = dtrow1["StoppageID"].ToString();
                user.BlockID = dtrow1["BlockID"].ToString();
                user.RouteDetailsId = dtrow1["RouteId"].ToString();
                details.Add(user);
            }
        }
        return details.ToArray();
    }
    public class bindRoutetxt
    {
        public string RouteId { get; set; }
        public string RouteDetailsId { get; set; }
        public string RouteName { get; set; }
        public string RouteSource { get; set; }
        public string Destination { get; set; }
        public string Distance { get; set; }
        public string CityID { get; set; }
        public string AreaID { get; set; }
        public string RoadID { get; set; }
        public string StoppageID { get; set; }
        public string BlockID { get; set; }
    }

    [WebMethod]
    public static bindBlock[] BindDDLBlock(string changeareaid)
    {
        List<bindBlock> details = new List<bindBlock>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        Dt = Objdut.GetDataTable("select BlockID,BlockName from tbl_block_master where status = 1 and isactive = 1 and AreaID = " + changeareaid);
        bindBlock obj = new bindBlock();
        obj.BlockID = Convert.ToInt32("0");
        obj.BlockName = "-- Select Block --";

        details.Add(obj);
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in Dt.Rows)
            {
                bindBlock obje = new bindBlock();
                obje.BlockID = Convert.ToInt32(dtrow["BlockID"].ToString());
                obje.BlockName = dtrow["BlockName"].ToString();
                details.Add(obje);
            }

        }
        return details.ToArray();
    }
    public class bindBlock
    {
        public int BlockID { get; set; }
        public string BlockName { get; set; }
    }
}