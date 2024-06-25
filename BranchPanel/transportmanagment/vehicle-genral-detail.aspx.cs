using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_transportmanagment_vehicle_genral_detail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static int vehicledata(string vehicletypeid, string Contractorid, string Contractordriverid, string ContractorHelperid,
        string Date, string regno, string vehiclename, string Makeby, string NOofSeate, string ModelNo, string Color, string ChassisNo, string EnginNo, string Remark,
        string InsComp, string InsNo, string InsContact, string InsDate, string PolutionVdate, string Polutiontilldate, string Polutionnxtdate, string ImgRegdocabt,
        string getREGdocrsc, string docRegExtension, string imagevehicleabt, string vehiclegetrsc, string VehicleExtension, string docRoadExtension, string docfitExtension,
        string docInsuExtension, string docPoluExtension, string ImgRoaddocabt, string getRoaddocrsc, string ImgFitnessdocabt, string getFitnessdocrsc, string Imginsudocabt,
        string getinsudocrsc, string ImgPolutiondocabt, string getPolutiondocrsc, string RegFromdate, string Regtilldate, string RoadFromdate, string RoadTilldate,
        string Roadnxtdate, string Fitfromdate, string Fittilldate, string fitnextdate, string AddUpdateMode, string vehicleupdateid)
      {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[39];
        param[0] = new SqlParameter("@Vehicletypeid", vehicletypeid);
        param[1] = new SqlParameter("@Contractorid", Contractorid);
        param[2] = new SqlParameter("@Driverid", Contractordriverid);
        param[3] = new SqlParameter("@Helperid", ContractorHelperid);
        param[4] = new SqlParameter("@datetype", Date);
        param[5] = new SqlParameter("@VehicleRegNo", regno.Replace("`", "'"));
        param[6] = new SqlParameter("@Vehiclename", vehiclename.Replace("`", "'"));
        param[7] = new SqlParameter("@Vehiclemake", Makeby.Replace("`", "'"));
        param[8] = new SqlParameter("@Numberofseats", NOofSeate);
        param[9] = new SqlParameter("@Modelnum", ModelNo.Replace("`", "'"));
        param[10] = new SqlParameter("@Color", Color.Replace("`", "'"));
        param[11] = new SqlParameter("@ChassisNo", ChassisNo.Replace("`", "'"));
        param[12] = new SqlParameter("@EnginNo", EnginNo.Replace("`", "'"));
        param[13] = new SqlParameter("@Remark", Remark.Replace("`", "'"));
        param[14] = new SqlParameter("@Insurancecompname", InsComp.Replace("`", "'"));
        param[15] = new SqlParameter("@InsuranceNo", InsNo.Replace("`", "'"));
        param[16] = new SqlParameter("@ContactNo", InsContact);
        param[17] = new SqlParameter("@NextinsuranceDate", InsDate);
        param[18] = new SqlParameter("@Vailidfromdate", PolutionVdate);
        param[19] = new SqlParameter("@Vailidtilldate", Polutiontilldate);
        param[20] = new SqlParameter("@Polutionnextdate", Polutionnxtdate);
        param[21] = new SqlParameter("@Regphoto", ImgRegdocabt);
        param[22] = new SqlParameter("@Vehiclephoto", imagevehicleabt);
        param[23] = new SqlParameter("@Roadphoto", ImgRoaddocabt);
        param[24] = new SqlParameter("@Fitnessphoto", ImgFitnessdocabt);
        param[25] = new SqlParameter("@Insurancephoto", Imginsudocabt);
        param[26] = new SqlParameter("@PolutionPhoto", ImgPolutiondocabt);
        param[27] = new SqlParameter("@RegFromDate", RegFromdate);
        param[28] = new SqlParameter("@RegtillDate", Regtilldate);
        param[29] = new SqlParameter("@RoadFromDate", RoadFromdate);
        param[30] = new SqlParameter("@RoadtillDate", RoadTilldate);
        param[31] = new SqlParameter("@RoadNextDate", Roadnxtdate);
        param[32] = new SqlParameter("@Fittnessfromdate", Fitfromdate);
        param[33] = new SqlParameter("@FitnesstillDate", Fittilldate);
        param[34] = new SqlParameter("@Fitnessnextdate", fitnextdate);
        param[35] = new SqlParameter("@updatevehicleid", vehicleupdateid);
        param[36] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[37] = new SqlParameter("@mode", AddUpdateMode);
        param[38] = new SqlParameter("@intResult", SqlDbType.Int);
        param[38].Direction = ParameterDirection.Output;
        int result = Convert.ToInt32(param[38].Value);
        if (getREGdocrsc != "")
        {
            if (getREGdocrsc.Contains("base64,"))
            {
                int IndexNo = getREGdocrsc.IndexOf("/") + 1;
                int lastIndexNo = getREGdocrsc.IndexOf(";");
                int IndexNo1 = getREGdocrsc.IndexOf(",") + 1;
                int Pathlength1 = getREGdocrsc.Length;
                getREGdocrsc = getREGdocrsc.Substring(IndexNo1, (Pathlength1 - IndexNo1));
                byte[] b = Convert.FromBase64String(getREGdocrsc);
                string pathforsaveimage = HttpContext.Current.Request.MapPath("transportimage/") + ImgRegdocabt;
                MasterImageUpload.CreateImage(b, ImgRegdocabt, docRegExtension, pathforsaveimage, 0);
            }
        }
        if (vehiclegetrsc != "")
        {
            if (vehiclegetrsc.Contains("base64,"))
            {
                int IndexNo = vehiclegetrsc.IndexOf("/") + 1;
                int lastIndexNo = vehiclegetrsc.IndexOf(";");
                int IndexNo1 = vehiclegetrsc.IndexOf(",") + 1;
                int Pathlength1 = vehiclegetrsc.Length;
                vehiclegetrsc = vehiclegetrsc.Substring(IndexNo1, (Pathlength1 - IndexNo1));
                byte[] vb = Convert.FromBase64String(vehiclegetrsc);
                string vpathforsaveimage = HttpContext.Current.Request.MapPath("transportimage/") + imagevehicleabt;
                MasterImageUpload.CreateImage(vb, imagevehicleabt, VehicleExtension, vpathforsaveimage, 0);
            }
        }
        if (getRoaddocrsc != "")
        {
            if (getRoaddocrsc.Contains("base64,"))
            {
                int IndexNo = getRoaddocrsc.IndexOf("/") + 1;
                int lastIndexNo = getRoaddocrsc.IndexOf(";");
                int IndexNo1 = getRoaddocrsc.IndexOf(",") + 1;
                int Pathlength1 = getRoaddocrsc.Length;
                getRoaddocrsc = getRoaddocrsc.Substring(IndexNo1, (Pathlength1 - IndexNo1));
                byte[] vb = Convert.FromBase64String(getRoaddocrsc);
                string vpathforsaveimage = HttpContext.Current.Request.MapPath("transportimage/") + ImgRoaddocabt;
                MasterImageUpload.CreateImage(vb, ImgRoaddocabt, docRoadExtension, vpathforsaveimage, 0);
            }
        }
        if (getFitnessdocrsc != "")
        {
            if (getFitnessdocrsc.Contains("base64,"))
            {
                int IndexNo = getFitnessdocrsc.IndexOf("/") + 1;
                int lastIndexNo = getFitnessdocrsc.IndexOf(";");
                int IndexNo1 = getFitnessdocrsc.IndexOf(",") + 1;
                int Pathlength1 = getFitnessdocrsc.Length;
                getFitnessdocrsc = getFitnessdocrsc.Substring(IndexNo1, (Pathlength1 - IndexNo1));
                byte[] vb = Convert.FromBase64String(getFitnessdocrsc);
                string vpathforsaveimage = HttpContext.Current.Request.MapPath("transportimage/") + ImgFitnessdocabt;
                MasterImageUpload.CreateImage(vb, ImgFitnessdocabt, docfitExtension, vpathforsaveimage, 0);
            }
        }
        if (getinsudocrsc != "")
        {
            if (getinsudocrsc.Contains("base64,"))
            {
                int IndexNo = getinsudocrsc.IndexOf("/") + 1;
                int lastIndexNo = getinsudocrsc.IndexOf(";");
                int IndexNo1 = getinsudocrsc.IndexOf(",") + 1;
                int Pathlength1 = getinsudocrsc.Length;
                getinsudocrsc = getinsudocrsc.Substring(IndexNo1, (Pathlength1 - IndexNo1));
                byte[] vb = Convert.FromBase64String(getinsudocrsc);
                string vpathforsaveimage = HttpContext.Current.Request.MapPath("transportimage/") + Imginsudocabt;
                MasterImageUpload.CreateImage(vb, Imginsudocabt, docInsuExtension, vpathforsaveimage, 0);
            }
        }
        if (getPolutiondocrsc != "")
        {
            if (getPolutiondocrsc.Contains("base64,"))
            {
                int IndexNo = getPolutiondocrsc.IndexOf("/") + 1;
                int lastIndexNo = getPolutiondocrsc.IndexOf(";");
                int IndexNo1 = getPolutiondocrsc.IndexOf(",") + 1;
                int Pathlength1 = getPolutiondocrsc.Length;
                getPolutiondocrsc = getPolutiondocrsc.Substring(IndexNo1, (Pathlength1 - IndexNo1));
                byte[] vb = Convert.FromBase64String(getPolutiondocrsc);
                string vpathforsaveimage = HttpContext.Current.Request.MapPath("transportimage/") + ImgPolutiondocabt;
                MasterImageUpload.CreateImage(vb, ImgPolutiondocabt, docPoluExtension, vpathforsaveimage, 0);
            }
        }
        result = Objdut.ExecuteSqlSP(param, "usp_vehicle_details");
        return result;
    }

    [WebMethod]
    public static bindallddl[] contractorlist()
    {
        List<bindallddl> details = new List<bindallddl>();
        DataSet Ds = new DataSet();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 1);
        Ds = Objdut.GetDataSetSP(param, "[usp_vehicle_details]");
        bindallddl obj = new bindallddl();
        obj.contractorid = Convert.ToInt32("0");
        obj.contractName = "-- Select Contractor --";
        details.Add(obj);
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                bindallddl obje = new bindallddl();
                obje.contractorid = Convert.ToInt32(dtrow["contractorid"].ToString());
                obje.contractName = dtrow["contractName"].ToString();
                details.Add(obje);
            }
        }
        return details.ToArray();
    }
    public class bindallddl
    {
        public int contractorid { get; set; }
        public string contractName { get; set; }
    }

    [WebMethod]
    public static bindhelperdriverddl[] binddriverhlpr(string changecontractorid)
    {
        List<bindhelperdriverddl> details = new List<bindhelperdriverddl>();
        DataSet Ds = new DataSet();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 1);
        param[1] = new SqlParameter("@contractor_id", changecontractorid);
        Ds = Objdut.GetDataSetSP(param, "[usp_vehicle_details]");
        bindhelperdriverddl obj = new bindhelperdriverddl();
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow1 in Ds.Tables[1].Rows)
            {
                bindhelperdriverddl obje = new bindhelperdriverddl();
                obje.Con_driverid = dtrow1["Con_driverid"].ToString();
                obje.name = dtrow1["name"].ToString();
                details.Add(obje);
            }
            foreach (DataRow dtrow2 in Ds.Tables[2].Rows)
            {
                bindhelperdriverddl obje = new bindhelperdriverddl();
                obje.helperid = dtrow2["helperid"].ToString();
                obje.helpername = dtrow2["helpername"].ToString();
                details.Add(obje);
            }
        }
        return details.ToArray();
    }
    public class bindhelperdriverddl
    {
        public string name { get; set; }
        public string Con_driverid { get; set; }
        public string helperid { get; set; }
        public string helpername { get; set; }
    }

    [WebMethod]
    public static ShowVehicledetails[] BindTextFieldsVehicle(string vehicleupdateid)
    {
        DataSet Ds = new DataSet();
        List<ShowVehicledetails> StatusDetails = new List<ShowVehicledetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 4);
        param[1] = new SqlParameter("@updatevehicleid", vehicleupdateid);
        param[2] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        Ds = Objdut.GetDataSetSP(param, "usp_vehicle_details");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ShowVehicledetails user = new ShowVehicledetails();
                user.date = dtrow["date"].ToString();
                user.VehicleRegNo = dtrow["VehicleRegNo"].ToString();
                user.Vehiclename = dtrow["Vehiclename"].ToString();
                user.Vehiclemake = dtrow["Vehiclemake"].ToString();
                user.Numberofseats = dtrow["Numberofseats"].ToString();
                user.Modelnum = dtrow["Modelnum"].ToString();
                user.Color = dtrow["Color"].ToString();
                user.ChassisNo = dtrow["ChassisNo"].ToString();
                user.EnginNo = dtrow["EnginNo"].ToString();
                user.Vehiclephoto = dtrow["Vehiclephoto"].ToString();
                user.Remark = dtrow["Remark"].ToString();
                user.Regphoto = dtrow["Regphoto"].ToString();
                user.Roadphoto = dtrow["Roadphoto"].ToString();
                user.Fitnessphoto = dtrow["Fitnessphoto"].ToString();
                user.Insurancephoto = dtrow["Insurancephoto"].ToString();
                user.Insurancecompname = dtrow["Insurancecompname"].ToString();
                user.InsuranceNo = dtrow["InsuranceNo"].ToString();
                user.ContactNo = dtrow["ContactNo"].ToString();
                user.NextinsuranceDate = dtrow["NextinsuranceDate"].ToString();
                user.Vailidfromdate = dtrow["Vailidfromdate"].ToString();
                user.Vailidtilldate = dtrow["Vailidtilldate"].ToString();
                user.Polutionnextdate = dtrow["Polutionnextdate"].ToString();
                user.PolutionPhoto = dtrow["PolutionPhoto"].ToString();
                user.Contractorid = dtrow["Contractorid"].ToString();
                user.Driverid = dtrow["Driverid"].ToString();
                user.Helperid = dtrow["Helperid"].ToString();
                user.Vehicletypeid = dtrow["Vehicletypeid"].ToString();
                user.RegFromDate = dtrow["RegFromDate"].ToString();
                user.RegtillDate = dtrow["RegtillDate"].ToString();
                user.RoadFromDate = dtrow["RoadFromDate"].ToString();
                user.RoadtillDate = dtrow["RoadtillDate"].ToString();
                user.RoadNextDate = dtrow["RoadNextDate"].ToString();
                user.Fittnessfromdate = dtrow["Fittnessfromdate"].ToString();
                user.FitnesstillDate = dtrow["FitnesstillDate"].ToString();
                user.Fitnessnextdate = dtrow["Fitnessnextdate"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class ShowVehicledetails
    {
        public string date { get; set; }
        public string VehicleRegNo { get; set; }
        public string Vehiclename { get; set; }
        public string Vehiclemake { get; set; }
        public string Numberofseats { get; set; }
        public string Modelnum { get; set; }
        public string Color { get; set; }
        public string ChassisNo { get; set; }
        public string EnginNo { get; set; }
        public string Vehiclephoto { get; set; }
        public string Remark { get; set; }
        public string Regphoto { get; set; }
        public string Roadphoto { get; set; }
        public string Fitnessphoto { get; set; }
        public string Insurancephoto { get; set; }
        public string Insurancecompname { get; set; }
        public string InsuranceNo { get; set; }
        public string ContactNo { get; set; }
        public string NextinsuranceDate { get; set; }
        public string Vailidfromdate { get; set; }
        public string Vailidtilldate { get; set; }
        public string Polutionnextdate { get; set; }
        public string PolutionPhoto { get; set; }
        public string Contractorid { get; set; }
        public string Driverid { get; set; }
        public string Helperid { get; set; }
        public string Vehicletypeid { get; set; }
        public string RegFromDate { get; set; }
        public string RegtillDate { get; set; }
        public string RoadFromDate { get; set; }
        public string RoadtillDate { get; set; }
        public string RoadNextDate { get; set; }
        public string Fittnessfromdate { get; set; }
        public string FitnesstillDate { get; set; }
        public string Fitnessnextdate { get; set; }
    }
}