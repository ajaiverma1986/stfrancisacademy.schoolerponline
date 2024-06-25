using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_transportmanagment_vehicle_to_route : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        fillMultipleTimeschedule();
    }
    private void fillMultipleTimeschedule()
    {
        DataUtility objDut = new DataUtility();
        string Query = "select did,dayname from days where status=1";
        DataTable dt_day = objDut.GetDataTable(Query);
        if (dt_day.Rows.Count > 0)
        {
            ddlDeparturetime.DataSource = GetTimeIntervals();
            ddlDeparturetime.DataBind();
            ddlArrivaltime.DataSource = GetTimeIntervals();
            ddlArrivaltime.DataBind();
        }
    }
    public List<string> GetTimeIntervals()
    {
        List<string> timeIntervals = new List<string>();
        DateTime date = DateTime.MinValue.AddHours(6); // start at 6am
        DateTime endDate = DateTime.MinValue.AddDays(1).AddHours(6); // end at 5:45am (< 6am)

        while (date < endDate)
        {
            timeIntervals.Add(date.ToShortTimeString());
            date = date.AddMinutes(1);
        }
        return timeIntervals;
    }
    [WebMethod]
    public static bindvehicleddl[] ddlvehicle()
    {
        List<bindvehicleddl> details = new List<bindvehicleddl>();
        DataSet Ds = new DataSet();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@MODE", 1);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        Ds = Objdut.GetDataSetSP(param, "[USP_VEHICLETOROUTE]");
        bindvehicleddl obj = new bindvehicleddl();
        obj.VEHICLEID = "0";
        obj.VEHICLEREGNO = "-- Select Vehicle --";
        obj.ROUTEID = "0";
        obj.ROUTENAME = "-- Select Route --";
        details.Add(obj);
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                bindvehicleddl obje = new bindvehicleddl();
                obje.VEHICLEID = dtrow["VEHICLEID"].ToString();
                obje.VEHICLEREGNO = dtrow["VEHICLEREGNO"].ToString();
                details.Add(obje);
            }
            foreach (DataRow dtrow1 in Ds.Tables[1].Rows)
            {
                bindvehicleddl obje = new bindvehicleddl();
                obje.ROUTEID = dtrow1["ROUTID"].ToString();
                obje.ROUTENAME = dtrow1["ROUTENAME"].ToString();
                details.Add(obje);
            }
        }
        return details.ToArray();
    }
    public class bindvehicleddl
    {
        public string VEHICLEID { get; set; }
        public string VEHICLEREGNO { get; set; }
        public string ROUTEID { get; set; }
        public string ROUTENAME { get; set; }
    }
    [WebMethod]
    public static ShowVehicledetails[] BindGridByjsVehicle(string VehicleID)
    {
        DataSet Ds = new DataSet();
        List<ShowVehicledetails> StatusDetails = new List<ShowVehicledetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@VEHICLEID", VehicleID);
        param[2] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        Ds = Objdut.GetDataSetSP(param, "[USP_VEHICLETOROUTE]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ShowVehicledetails user = new ShowVehicledetails();
                user.VEHICLEREGNO = dtrow["VEHICLEREGNO"].ToString();
                user.DRIVERNAME = dtrow["DRIVERNAME"].ToString();
                user.HELPERNAME = dtrow["HELPERNAME"].ToString();
                user.CONTRACTORNAME = dtrow["CONTRACTORNAME"].ToString();
                user.BUSTYPE = dtrow["BUSTYPE"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class ShowVehicledetails
    {
        public string VEHICLEREGNO { get; set; }
        public string DRIVERNAME { get; set; }
        public string HELPERNAME { get; set; }
        public string CONTRACTORNAME { get; set; }
        public string BUSTYPE { get; set; }
    }
    [WebMethod]
    public static ShowRouteSource[] BindSourceAndDestination(string ChangeRouteID)
    {
        DataSet Ds = new DataSet();
        List<ShowRouteSource> StatusDetails = new List<ShowRouteSource>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@ChangeRouteID", ChangeRouteID);
        Ds = Objdut.GetDataSetSP(param, "[USP_VEHICLETOROUTE]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ShowRouteSource user = new ShowRouteSource();
                user.ROUTESOURCE = dtrow["ROUTESOURCE"].ToString();
                user.DESTINATION = dtrow["DESTINATION"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class ShowRouteSource
    {
        public string ROUTESOURCE { get; set; }
        public string DESTINATION { get; set; }
    }
    [WebMethod]
    public static int SaveVehicleRouteMap(string VehicleReg, string AlllRouteID, string AllDepartureTime, string AllArrivaltime, string AllRouteDetailsId)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[9];
        param[0] = new SqlParameter("@VehicleRegID", VehicleReg);
        param[1] = new SqlParameter("@ROUTEID", AlllRouteID);
        param[2] = new SqlParameter("@DEPARTURETIME", AllDepartureTime);
        param[3] = new SqlParameter("@ARRIVALTIME", AllArrivaltime);
        param[4] = new SqlParameter("@BRID", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[5] = new SqlParameter("@BrAdId", System.Web.HttpContext.Current.Session["BrADID"].ToString());
        param[6] = new SqlParameter("@mode", 4);
        param[7] = new SqlParameter("@VEHICLEROUTEMAPID", AllRouteDetailsId);
        param[8] = new SqlParameter("@intResult", SqlDbType.Int);
        param[8].Direction = ParameterDirection.Output;
        Objdut.ExecuteSqlSP(param, "[USP_VEHICLETOROUTE]");
        int result = Convert.ToInt32(param[8].Value);
        return result;
    }
    [WebMethod]
    public static bindRoutetxt[] BindTxtFieldsOfVehicleRouteDetails(string vehicleRegID)
    {
        List<bindRoutetxt> details = new List<bindRoutetxt>();
        DataSet Ds = new DataSet();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@MODE", 5);
        param[1] = new SqlParameter("@vehicleRegID", vehicleRegID);
        Ds = Objdut.GetDataSetSP(param, "[USP_VEHICLETOROUTE]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                bindRoutetxt user = new bindRoutetxt();
                user.vehicleroutemapid = dtrow["vehicleroutemapid"].ToString();
                user.routeid = dtrow["routeid"].ToString();
                user.DepartureTime = dtrow["DepartureTime"].ToString();
                user.ArrivalTime = dtrow["ArrivalTime"].ToString();
                details.Add(user);
            }
        }
        return details.ToArray();
    }
    public class bindRoutetxt
    {
        public string vehicleroutemapid { get; set; }
        public string routeid { get; set; }
        public string DepartureTime { get; set; }
        public string ArrivalTime { get; set; }
        
    }
}