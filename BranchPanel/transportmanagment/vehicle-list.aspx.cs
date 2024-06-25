using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_transportmanagment_vehicle_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static ShowVehicledetails[] BindGridByjsVehicle()
    {
        DataSet Ds = new DataSet();
        List<ShowVehicledetails> StatusDetails = new List<ShowVehicledetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        Ds = Objdut.GetDataSetSP(param, "usp_vehicle_details");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ShowVehicledetails user = new ShowVehicledetails();
                user.VehicleRegNo = dtrow["VehicleRegNo"].ToString();
                user.Vehiclename = dtrow["Vehiclename"].ToString();
                user.Modelnum = dtrow["Modelnum"].ToString();
                user.Numberofseats = dtrow["Numberofseats"].ToString();
                user.NextinsuranceDate = dtrow["NextinsuranceDate"].ToString();
                user.RoadNextDate = dtrow["RoadNextDate"].ToString();
                user.Fitnessnextdate = dtrow["Fitnessnextdate"].ToString();
                user.vehicletype = dtrow["vehicletype"].ToString();
                user.vehicleid = dtrow["vehicleid"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class ShowVehicledetails
    {
        public string VehicleRegNo { get; set; }
        public string Vehiclename { get; set; }
        public string Modelnum { get; set; }
        public string Numberofseats { get; set; }
        public string NextinsuranceDate { get; set; }
        public string RoadNextDate { get; set; }
        public string Fitnessnextdate { get; set; }
        public string vehicletype { get; set; }
        public string vehicleid { get; set; }
    }

    [WebMethod]
    public static int deletevehicle(int vehicledelid)
    {
        int ret = 0;
        DataUtility Objdut = new DataUtility();
        ret = Objdut.ExecuteSql("update tbl_vehicle_details set isactive = 0 where Vehicleid=" + vehicledelid + "");
        return ret;
    }

    //[WebMethod]
    //public static bindcityddlforsearch[] searchcity()
    //{
    //    List<bindcityddlforsearch> details = new List<bindcityddlforsearch>();
    //    DataSet Ds = new DataSet();
    //    DataUtility Objdut = new DataUtility();
    //    SqlParameter[] param = new SqlParameter[1];
    //    param[0] = new SqlParameter("@mode", 6);
    //    Ds = Objdut.GetDataSetSP(param, "[usp_bindtransportsetting]");
    //    bindcityddlforsearch obj = new bindcityddlforsearch();
    //    obj.zoneid = Convert.ToInt32("0");
    //    obj.zonename = "-- Select City --";
    //    details.Add(obj);
    //    if (Ds.Tables[0].Rows.Count > 0)
    //    {
    //        foreach (DataRow dtrow in Ds.Tables[0].Rows)
    //        {
    //            bindcityddlforsearch obje = new bindcityddlforsearch();
    //            obje.zoneid = Convert.ToInt32(dtrow["zoneid"].ToString());
    //            obje.zonename = dtrow["zonename"].ToString();
    //            details.Add(obje);
    //        }
    //    }
    //    return details.ToArray();
    //}
    //public class bindcityddlforsearch
    //{
    //    public int zoneid { get; set; }
    //    public string zonename { get; set; }
    //}
    [WebMethod]
    public static ShowVehicleRoutedetails[] BindGridVehicleRouteDetails(string VehicleIDForRouteDetail)
    {
        DataSet Ds = new DataSet();
        List<ShowVehicleRoutedetails> StatusDetails = new List<ShowVehicleRoutedetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 6);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@updatevehicleid", VehicleIDForRouteDetail);
        Ds = Objdut.GetDataSetSP(param, "usp_vehicle_details");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ShowVehicleRoutedetails user = new ShowVehicleRoutedetails();
                user.VehicleReg = dtrow["VehicleReg"].ToString();
                user.RouteName = dtrow["RouteName"].ToString();
                user.DepartureTime = dtrow["DepartureTime"].ToString();
                user.ArrivalTime = dtrow["ArrivalTime"].ToString();
                user.VehicleRouteMapID = dtrow["VehicleRouteMapID"].ToString();
                user.SourceName = dtrow["SourceName"].ToString();
                user.VehicleRegID = dtrow["VehicleRegID"].ToString();
                user.Destination = dtrow["Destination"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class ShowVehicleRoutedetails
    {
        public string VehicleReg { get; set; }
        public string RouteName { get; set; }
        public string DepartureTime { get; set; }
        public string ArrivalTime { get; set; }
        public string VehicleRouteMapID { get; set; }
        public string SourceName { get; set; }
        public string Destination { get; set; }
        public string VehicleRegID { get; set; }
    }

}