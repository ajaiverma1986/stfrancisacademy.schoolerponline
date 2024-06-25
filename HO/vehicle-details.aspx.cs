using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HO_vehicle_details : System.Web.UI.Page
{
    DataUtility obj = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        BindSessionDDL();
    }
    public void BindSessionDDL()
    {
        DataTable dt = new DataTable();
        dt = obj.GetDataTable("select Brid,BrName from Branch_master where BrActive=1 and isDeleted=0 and isActive=1");
        if (dt.Rows.Count > 0)
        {
            ddlbranch.DataSource = dt;
            ddlbranch.DataValueField = "Brid";
            ddlbranch.DataTextField = "BrName";
            ddlbranch.DataBind();
        }
        ddlbranch.Items.Insert(0, new ListItem("--Select Branch--", "0"));
    }
    [WebMethod]
    public static ShowVehicledetails[] BindGridByjsVehicle(String Brid)
    {
        DataSet Ds = new DataSet();
        List<ShowVehicledetails> StatusDetails = new List<ShowVehicledetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 7);
        param[1] = new SqlParameter("@Brid", Brid);
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

}