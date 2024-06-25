using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_transportmanagment_route_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static ShowRoutedetails[] BindGridByjsRoute()
    {
        DataSet Ds = new DataSet();
        List<ShowRoutedetails> StatusDetails = new List<ShowRoutedetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        Ds = Objdut.GetDataSetSP(param,"[Usp_ManageRoute]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ShowRoutedetails user = new ShowRoutedetails();
                user.routid = dtrow["routid"].ToString();
                user.RouteName = dtrow["RouteName"].ToString();
                user.RouteSource = dtrow["RouteSource"].ToString();
                user.Destination = dtrow["Destination"].ToString();
                user.Distance = dtrow["Distance"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class ShowRoutedetails
    {
        public string routid { get; set; }
        public string RouteName { get; set; }
        public string RouteSource { get; set; }
        public string Destination { get; set; }
        public string Distance { get; set; }
    }
    [WebMethod]
    public static ShowRoutedetailsOfFields[] BindGridByjsRouteOfDetails(string RouteDetailsID)
    {
        DataSet Ds = new DataSet();
        List<ShowRoutedetailsOfFields> StatusDetails = new List<ShowRoutedetailsOfFields>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@RouteID", RouteDetailsID);
        Ds = Objdut.GetDataSetSP(param, "[Usp_ManageRoute]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ShowRoutedetailsOfFields user = new ShowRoutedetailsOfFields();
                user.CityName = dtrow["CityName"].ToString();
                user.AreaName = dtrow["AreaName"].ToString();
                user.RoadName = dtrow["RoadName"].ToString();
                user.stoppage = dtrow["stoppage"].ToString();
                user.RouteName = dtrow["RouteName"].ToString();
                user.BlockName = dtrow["BlockName"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class ShowRoutedetailsOfFields
    {
        public string CityName { get; set; }
        public string AreaName { get; set; }
        public string RoadName { get; set; }
        public string stoppage { get; set; }
        public string RouteName { get; set; }
        public string BlockName { get; set; }
    }

    [WebMethod]
    public static int deleteRoute(int RouteDeleteID)
    {
        int ret = 0;
        DataUtility Objdut = new DataUtility();
        ret = Objdut.ExecuteSql("update tbl_Route_Create set IsActive = 0 where RoutID=" + RouteDeleteID + "");
        return ret;
    }
}