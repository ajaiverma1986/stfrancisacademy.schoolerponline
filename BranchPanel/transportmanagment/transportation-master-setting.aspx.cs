using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_transportation_master_setting : System.Web.UI.Page
{
    private DataUtility Objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
         
        }
    }  

    [WebMethod]
    public static int Addarea(string cityid, string Area, string Roadname, string cityname)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@zoneid", cityid);
        param[1] = new SqlParameter("@Area", Area.Replace("~","'"));
        param[2] = new SqlParameter("@Blockname", Roadname.Replace("`", "'"));
        param[3] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[4] = new SqlParameter("@cityname", cityname.Replace("`", "'"));
        param[5] = new SqlParameter("@intResult", SqlDbType.Int);
        param[5].Direction = ParameterDirection.Output;
        Objdut.ExecuteSqlSP(param, "[usp_addareamaster]");
        int result = Convert.ToInt32(param[5].Value);
        return result;
    }

    [WebMethod]
    public static int addRoadOnCondition(string citynameid, string Areanameid, string AllRoadNames, string BlockID)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@citynameid", citynameid);
        param[1] = new SqlParameter("@Areanameid", Areanameid);
        param[2] = new SqlParameter("@AllRoadNames", AllRoadNames.Replace("`", "'"));
        param[3] = new SqlParameter("@BlockID", BlockID);
        param[4] = new SqlParameter("@intResult", SqlDbType.Int);
        param[4].Direction = ParameterDirection.Output;
        int result = Convert.ToInt32(param[4].Value);
        result = Objdut.ExecuteSqlSP(param, "[usp_AddRoad_Setting]");
        return result;
    }
    [WebMethod]
    public static int addBlock(string citynamesid, string Areanamesid, string BlockNames)
    {
        DataUtility Objduct = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@citinameid", citynamesid);
        param[1] = new SqlParameter("@areanameid", Areanamesid);
        param[2] = new SqlParameter("@allBlockname", BlockNames.Replace("`", "'"));
        param[3] = new SqlParameter("@intResult", SqlDbType.Int);
        param[3].Direction = ParameterDirection.Output;
        int result = Convert.ToInt32(param[3].Value);
        result = Objduct.ExecuteSqlSP(param, "usp_addBlock");
        return result;
    }
    [WebMethod]
    public static int addStoppage(string cityNameDDl, string AreanameDDL, string allStopsnames, string BlockIDDDL, string RoadIDDDL)
    {
        DataUtility Objduct = new DataUtility();
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@cityNameDDl", cityNameDDl);
        param[1] = new SqlParameter("@AreanameDDL", AreanameDDL);
        param[2] = new SqlParameter("@allStopsnames", allStopsnames.Replace("`", "'"));
        param[3] = new SqlParameter("@BlockIDDDL", BlockIDDDL);
        param[4] = new SqlParameter("@RoadIDDDL", RoadIDDDL);
        param[5] = new SqlParameter("@intResult", SqlDbType.Int);
        param[5].Direction = ParameterDirection.Output;
        int result = Convert.ToInt32(param[5].Value);
        result = Objduct.ExecuteSqlSP(param, "usp_addStoppage");
        return result;
    }
    [WebMethod]
    public static int updatecities(string updatecityid, string updatecitydata)
    {
        DataUtility Objduct = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@cityid", updatecityid);
        param[1] = new SqlParameter("@cityname", updatecitydata.Replace("`", "'"));
        param[2] = new SqlParameter("@mode", 1);
        param[3] = new SqlParameter("@intResult", SqlDbType.Int);
        param[3].Direction = ParameterDirection.Output;
        int result = Convert.ToInt32(param[3].Value);
        result = Objduct.ExecuteSqlSP(param, "usp_updatedata_transportation");
        return result;
    }

    [WebMethod]
    public static int updateareas(string areadata, string cityids, string areaidforupdt)
    {
        DataUtility Objduct = new DataUtility();
        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@areadata", areadata.Replace("`", "'"));
        param[1] = new SqlParameter("@cityname", cityids);
        param[2] = new SqlParameter("@areaidforupdt", areaidforupdt);
        param[3] = new SqlParameter("@mode", 2);
        param[4] = new SqlParameter("@intResult", SqlDbType.Int);
        param[4].Direction = ParameterDirection.Output;
        int result = Convert.ToInt32(param[4].Value);
        result = Objduct.ExecuteSqlSP(param, "usp_updatedata_transportation");
        return result;
    }

    [WebMethod]
    public static int UpdateBlock(string Blockdata, string cityidForRoadupdate, string areaidforRoadupdt, string Blockupdateid)
    {
        DataUtility Objduct = new DataUtility();
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@BlockData", Blockdata.Replace("`", "'"));
        param[1] = new SqlParameter("@cityname", cityidForRoadupdate);
        param[2] = new SqlParameter("@areaidforupdt", areaidforRoadupdt);
        param[3] = new SqlParameter("@BlockID", Blockupdateid);
        param[4] = new SqlParameter("@mode", 3);
        param[5] = new SqlParameter("@intResult", SqlDbType.Int);
        param[5].Direction = ParameterDirection.Output;
        int result = Convert.ToInt32(param[5].Value);
        result = Objduct.ExecuteSqlSP(param, "usp_updatedata_transportation");
        return result;
    }

    [WebMethod]
    public static int UpdateRoads(string Roaddata, string Roadupdateid)
    {
        DataUtility Objduct = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@Roaddata", Roaddata.Replace("`", "'"));
        param[1] = new SqlParameter("@Roadupdateid", Roadupdateid);
        param[2] = new SqlParameter("@mode", 4);
        param[3] = new SqlParameter("@intResult", SqlDbType.Int);
        param[3].Direction = ParameterDirection.Output;
        int result = Convert.ToInt32(param[3].Value);
        result = Objduct.ExecuteSqlSP(param, "usp_updatedata_transportation");
        return result;
    }


    [WebMethod]
    public static int UpdateStoppage(string StoppageData, string Stoppageupdateid)
    {
        DataUtility Objduct = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@StoppageName", StoppageData.Replace("`", "'"));
        param[1] = new SqlParameter("@StoppageID", Stoppageupdateid);
        param[2] = new SqlParameter("@mode", 5);
        param[3] = new SqlParameter("@intResult", SqlDbType.Int);
        param[3].Direction = ParameterDirection.Output;
        int result = Convert.ToInt32(param[3].Value);
        result = Objduct.ExecuteSqlSP(param, "usp_updatedata_transportation");
        return result;
    }


    [WebMethod]
    public static ShowrowsDetails[] BindGridByJs(string searchcity, string searcharea)
    {
        DataSet Ds = new DataSet();
        List<ShowrowsDetails> StatusDetails = new List<ShowrowsDetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", 1);
        param[1] = new SqlParameter("@city", searchcity);
        param[2] = new SqlParameter("@areaname", searcharea);
        param[3] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        Ds = Objdut.GetDataSetSP(param, "usp_bindtransportsetting");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ShowrowsDetails user = new ShowrowsDetails();
                user.cityname = dtrow["cityname"].ToString();
                user.area = dtrow["area"].ToString();
                user.Block = dtrow["Block"].ToString();
                user.rdid = dtrow["rdid"].ToString();
                user.cityid = dtrow["cityid"].ToString();
                user.areaid = dtrow["areaid"].ToString();
               
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class ShowrowsDetails
    {
        public string cityname { get; set; }
        public string area { get; set; }
        public string Block { get; set; }
        public string stoppage { get; set; }
        public string cityid { get; set; }
        public string areaid { get; set; }
        public string rdid { get; set; }
    }

    [WebMethod]
    public static Showroaddetails[] BindGridByJsforroad(string ctyid, string aridtype)
    {
        DataSet Ds = new DataSet();
        List<Showroaddetails> StatusDetails = new List<Showroaddetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@ctyid", ctyid);
        param[2] = new SqlParameter("@aridtype", aridtype);
        Ds = Objdut.GetDataSetSP(param, "usp_bindtransportsetting");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                Showroaddetails user = new Showroaddetails();
                user.cityname = dtrow["cityname"].ToString();
                user.area = dtrow["area"].ToString();
                user.Block = dtrow["Block"].ToString();
                user.cityid = dtrow["cityid"].ToString();
                user.areaid = dtrow["areaid"].ToString();
                user.RoadName = dtrow["RoadName"].ToString();
                user.BlockID = dtrow["BlockID"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class Showroaddetails
    {
        public string cityname { get; set; }
        public string area { get; set; }
        public string Block { get; set; }
        public string stoppage { get; set; }
        public string cityid { get; set; }
        public string areaid { get; set; }
        public string RoadName { get; set; }
        public string arid { get; set; }
        public string BlockID { get; set; }
        public string RoadID { get; set; }
    }
    [WebMethod]
    public static showRoaddetails[] BindGridByJsforRoadDetails(string ctyids, string areid, string BlockID)
    {
        DataSet Ds = new DataSet();
        List<showRoaddetails> StatusDetails = new List<showRoaddetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@ctyid", ctyids);
        param[2] = new SqlParameter("@aridtype", areid);
        param[3] = new SqlParameter("@BlockID", BlockID);
        Ds = Objdut.GetDataSetSP(param, "usp_bindtransportsetting");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                showRoaddetails user = new showRoaddetails();
                user.RoadID = dtrow["RoadID"].ToString();
                user.cityname = dtrow["cityname"].ToString();
                user.areaname = dtrow["areaname"].ToString();
                user.BlockName = dtrow["BlockName"].ToString();
                user.Roadname = dtrow["Roadname"].ToString();
                user.Stoppage = dtrow["Stoppage"].ToString();
                user.Zoneid = dtrow["Zoneid"].ToString();
                user.areaid = dtrow["areaid"].ToString();
                user.BlockID = dtrow["BlockID"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class showRoaddetails
    {
        public string RoadID { get; set; }
        public string cityname { get; set; }
        public string areaname { get; set; }
        public string BlockName { get; set; }
        public string Roadname { get; set; }
        public string Stoppage { get; set; }
        public string Zoneid { get; set; }
        public string areaid { get; set; }
        public string BlockID { get; set; }
    }

    [WebMethod]
    public static showstoppagedetails[] BindGridByJsforStoppageDetails(string RdCityID, string RDAreaId, string RdRoadId)
    {
        DataSet Ds = new DataSet();
        List<showstoppagedetails> StatusDetails = new List<showstoppagedetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", 9);
        param[1] = new SqlParameter("@ctyid", RdCityID);
        param[2] = new SqlParameter("@aridtype", RDAreaId);
        param[3] = new SqlParameter("@RoadID", RdRoadId);
        Ds = Objdut.GetDataSetSP(param, "usp_bindtransportsetting");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                showstoppagedetails user = new showstoppagedetails();
                user.stoppageid = dtrow["stoppageid"].ToString();
                user.cityname = dtrow["cityname"].ToString();
                user.areaname = dtrow["areaname"].ToString();
                user.BlockName = dtrow["BlockName"].ToString();
                user.Roadname = dtrow["Roadname"].ToString();
                user.Stoppage = dtrow["Stoppage"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class showstoppagedetails
    {
        public string stoppageid { get; set; }
        public string cityname { get; set; }
        public string areaname { get; set; }
        public string BlockName { get; set; }
        public string Roadname { get; set; }
        public string Stoppage { get; set; }
    }

    [WebMethod]
    public static bindallddl[] BindDDLOFAddRoadByHeader(string changecityid, string changeareaid, string ChangeBlockiId)
    {
            List<bindallddl> details = new List<bindallddl>();
            DataSet Ds = new DataSet();
            List<bindallddl> StatusDetails = new List<bindallddl>();
            DataUtility Objdut = new DataUtility();
            SqlParameter[] param = new SqlParameter[5];
            param[0] = new SqlParameter("@mode", 4);
            param[1] = new SqlParameter("@changecityid", changecityid);
            param[2] = new SqlParameter("@changeareaid", changeareaid);
            param[3] = new SqlParameter("@BlockID", ChangeBlockiId);
            param[4] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
            Ds = Objdut.GetDataSetSP(param, "[usp_bindtransportsetting]");
            bindallddl obj = new bindallddl();
            obj.zoneid = Convert.ToInt32("0");
            obj.zonename = "-- Select City --";
            obj.areaid = Convert.ToString("0");
            obj.areaname = "-- Select Area --";
            obj.BlockID = Convert.ToString("0");
            obj.BlockName = "-- Select Block --";
            obj.roadid = Convert.ToString("0");
            obj.roadname = "-- Select Road --";
            details.Add(obj);
            if (Ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dtrow in Ds.Tables[0].Rows)
                {
                    bindallddl obje = new bindallddl();
                    obje.zoneid = Convert.ToInt32(dtrow["zoneid"].ToString());
                    obje.zonename = dtrow["zonename"].ToString();
                    details.Add(obje);
                }
                foreach (DataRow dtrow1 in Ds.Tables[1].Rows)
                {
                    bindallddl obje = new bindallddl();
                    obje.areaid = dtrow1["areaid"].ToString();
                    obje.areaname = dtrow1["areaname"].ToString();
                    details.Add(obje);
                }
                foreach (DataRow dtrow2 in Ds.Tables[2].Rows)
                {
                    bindallddl obje = new bindallddl();
                    obje.BlockID = dtrow2["BlockID"].ToString();
                    obje.BlockName = dtrow2["BlockName"].ToString();
                    details.Add(obje);
                }
                foreach (DataRow dtrow3 in Ds.Tables[3].Rows)
                {
                    bindallddl obje = new bindallddl();
                    obje.roadid = dtrow3["roadid"].ToString();
                    obje.roadname = dtrow3["roadname"].ToString();
                    details.Add(obje);
                }
            }
            return details.ToArray();
    }
    public class bindallddl
    {
        public int zoneid { get; set; }
        public string zonename { get; set; }
        public string areaname { get; set; }
        public string areaid { get; set; }
        public string BlockID { get; set; }
        public string BlockName { get; set; }
        public string roadid { get; set; }
        public string roadname { get; set; }
    }

    [WebMethod]
    public static bindallddlonconditions[] BindDDLFORAddRoad()
    {
        List<bindallddlonconditions> details = new List<bindallddlonconditions>();
        DataSet Ds = new DataSet();
        List<bindallddlonconditions> StatusDetails = new List<bindallddlonconditions>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 5);
        Ds = Objdut.GetDataSetSP(param, "[usp_bindtransportsetting]");
        bindallddlonconditions obj = new bindallddlonconditions();
        obj.zoneid = Convert.ToInt32("0");
        obj.zonename = "-- Select City --";
        obj.areaid = Convert.ToString("0");
        obj.areaname = "-- Select Area --";
        obj.BlockID = Convert.ToString("0");
        obj.BlockName = "-- Select Block --";
        obj.Roadid = Convert.ToString("0");
        obj.roadname = "-- Select Road --";
        details.Add(obj);
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                bindallddlonconditions obje = new bindallddlonconditions();
                obje.zoneid = Convert.ToInt32(dtrow["zoneid"].ToString());
                obje.zonename = dtrow["zonename"].ToString();
                details.Add(obje);
            }
            foreach (DataRow dtrow1 in Ds.Tables[1].Rows)
            {
                bindallddlonconditions obje = new bindallddlonconditions();
                obje.areaid = dtrow1["areaid"].ToString();
                obje.areaname = dtrow1["areaname"].ToString();
                details.Add(obje);
            }
            foreach (DataRow dtrow2 in Ds.Tables[2].Rows)
            {
                bindallddlonconditions obje = new bindallddlonconditions();
                obje.BlockID = dtrow2["BlockID"].ToString();
                obje.BlockName = dtrow2["BlockName"].ToString();
                details.Add(obje);
            }
            foreach (DataRow dtrow3 in Ds.Tables[3].Rows)
            {
                bindallddlonconditions obje = new bindallddlonconditions();
                obje.Roadid = dtrow3["Roadid"].ToString();
                obje.roadname = dtrow3["roadname"].ToString();
                details.Add(obje);
            }
        }
        return details.ToArray();
    }
    public class bindallddlonconditions
    {
        public int zoneid { get; set; }
        public string zonename { get; set; }
        public string areaname { get; set; }
        public string areaid { get; set; }
        public string BlockID { get; set; }
        public string BlockName { get; set; }
        public string Roadid { get; set; }
        public string roadname { get; set; }
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
}