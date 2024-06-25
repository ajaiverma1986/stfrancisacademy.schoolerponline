﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_StudentManagement_student_transport_details : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            BindSessionDDL();
        }
    }
    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlfyear.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlfyear.DataValueField = "Fyid";
        ddlfyear.DataTextField = "FYName";
        ddlfyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }

    [WebMethod]
    public static bindallddl[] BindDDLOFAddRoadTransport(string changecityid, string changeareaid, string ChangeBlockiId, string ChangeRoadID,string RouteId)
    {
        List<bindallddl> details = new List<bindallddl>();
        DataSet Ds = new DataSet();
        List<bindallddl> StatusDetails = new List<bindallddl>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[7];
        param[0] = new SqlParameter("@mode", 10);
        param[1] = new SqlParameter("@changecityid", changecityid);
        param[2] = new SqlParameter("@changeareaid", changeareaid);
        param[3] = new SqlParameter("@BlockID", ChangeBlockiId);
        param[4] = new SqlParameter("@roadid", ChangeRoadID);
        param[5] = new SqlParameter("@RouteId", RouteId);
        param[6] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
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
        obj.StoppageID = Convert.ToString("0");
        obj.StoppageName = "-- Select Stoppage --";
        details.Add(obj);
        if (Ds.Tables[4].Rows.Count > 0)
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
            foreach (DataRow dtrow4 in Ds.Tables[4].Rows)
            {
                bindallddl obje = new bindallddl();
                obje.StoppageID = dtrow4["StoppageID"].ToString();
                obje.StoppageName = dtrow4["StoppageName"].ToString();
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
        public string StoppageID { get; set; }
        public string StoppageName { get; set; }
    }
    [WebMethod]
    public static ShowRoutedetails[] BindGridByjsTransportForStudent(string ChangeRouteID)
    {
        DataSet Ds = new DataSet();
        List<ShowRoutedetails> StatusDetails = new List<ShowRoutedetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 6);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@ChangeRouteID", ChangeRouteID);
        Ds = Objdut.GetDataSetSP(param, "[USP_VEHICLETOROUTE]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ShowRoutedetails user = new ShowRoutedetails();
                user.VEHICLEREGNO = dtrow["VEHICLEREGNO"].ToString();
                user.VEHICLETYPE = dtrow["VEHICLETYPE"].ToString();
                user.NUMBEROFSEATS = dtrow["NUMBEROFSEATS"].ToString();
                user.vehicleroutemapid = dtrow["vehicleroutemapid"].ToString();
                user.AvailableSeats = dtrow["AvailableSeats"].ToString();
                user.vehicleId = dtrow["vehicleId"].ToString();
                user.VehicleTime = dtrow["VehicleTime"].ToString();
                user.RouteSource = dtrow["RouteSource"].ToString();
                user.Destination = dtrow["Destination"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class ShowRoutedetails
    {
        public string VEHICLEREGNO { get; set; }
        public string VEHICLETYPE { get; set; }
        public string NUMBEROFSEATS { get; set; }
        public string vehicleroutemapid { get; set; }
        public string AvailableSeats { get; set; }
        public string vehicleId { get; set; }
        public string VehicleTime { get; set; }
        public string RouteSource { get; set; }
        public string Destination { get; set; }
    }
    [WebMethod]
    public static int SaveTransportStudent(string Trip, string VehicleId, string AddedDate, string MonthList, string VehicleRouteMapID, string TransportIDofStu, string AddupdateMode, string changecityid,
        string changeareaid, string ChangeBlockiId, string ChangeRoadID, string Stoppage, string RouteIDSave, string feeDetails, int Fyid, string StoppageName)
    {
        int totalAmt = 0;

        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[21];
        try
        {
            param[0] = new SqlParameter("@MonthList", MonthList);
            param[1] = new SqlParameter("@VEHICLEROUTEMAPIDFORSTU", VehicleRouteMapID);
            param[2] = new SqlParameter("@BRID", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
            param[3] = new SqlParameter("@STUREGNO", System.Web.HttpContext.Current.Session["StuRegNo"].ToString());
            param[4] = new SqlParameter("@MODE", 10);
            param[5] = new SqlParameter("@TVRMID", TransportIDofStu);
            param[6] = new SqlParameter("@AreaID", changeareaid);
            param[7] = new SqlParameter("@BlockID", ChangeBlockiId);
            param[8] = new SqlParameter("@RoadID", ChangeRoadID);
            param[9] = new SqlParameter("@StoppageID", Stoppage);
            param[10] = new SqlParameter("@CityID", changecityid);
            param[11] = new SqlParameter("@RouteIDSave", RouteIDSave);
            param[12] = new SqlParameter("@ADDEDDATE", AddedDate);
            param[13] = new SqlParameter("@INTRESULT", SqlDbType.Int);
            param[13].Direction = ParameterDirection.Output;
            param[14] = new SqlParameter("@Activity", AddupdateMode);
            param[15] = new SqlParameter("@feeDetails", feeDetails);
            if (feeDetails.Contains('@'))
            {
                string[] arr = feeDetails.Split('@');
                for (int a = 0; a < arr.Length; a++)
                {
                    string[] arr1 = arr[a].Split('_');
                    int amt = 0;
                    int.TryParse(Convert.ToString(arr1[1]), out amt);
                    totalAmt = totalAmt + amt;
                }
                param[16] = new SqlParameter("@totalAmt", totalAmt);
            }
            else
            {

                string[] arr1 = feeDetails.Split('_');
                int amt = 0;
                int.TryParse(Convert.ToString(arr1[1]), out amt);
                totalAmt = totalAmt + amt;

                param[16] = new SqlParameter("@totalAmt", totalAmt);
            }
            param[17] = new SqlParameter("@Fyid", Fyid);
            param[18] = new SqlParameter("@StoppageName", StoppageName.ToString());
            param[19] = new SqlParameter("@VEHICLEID", VehicleId.ToString());
            param[20] = new SqlParameter("@Trip", Trip.ToString());

            Objdut.ExecuteSqlSP(param, "[USP_VEHICLETOROUTE]");
        }
        catch (Exception e) {
            var es = e.Message;
        }
        int result = Convert.ToInt32(param[13].Value);
        return result;
    }
    [WebMethod]
    public static bindvehicleddl[] ddlRoute()
    {
        List<bindvehicleddl> details = new List<bindvehicleddl>();
        DataSet Ds = new DataSet();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@MODE", 1);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        Ds = Objdut.GetDataSetSP(param, "[USP_VEHICLETOROUTE]");
        bindvehicleddl obj = new bindvehicleddl();
        obj.ROUTEID = "0";
        obj.ROUTENAME = "-- Select Amount --";
        details.Add(obj);
        if (Ds.Tables[0].Rows.Count > 0)
        {
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
        public string ROUTEID { get; set; }
        public string ROUTENAME { get; set; }
    }

    [WebMethod]
    public static int CheckTransOfStd()
    {        
        DataUtility Objdut = new DataUtility();
        int result = (int)(Objdut.GetScalar("Select ISNULL(TransportationRequired,0) TransportationRequired from tbl_StudentAdmissionMaster where IsActive = 1 and Brid = "+Convert.ToInt32(System.Web.HttpContext.Current.Session["BrBrid"])+" and StuRegNo = "+Convert.ToInt32(System.Web.HttpContext.Current.Session["StuRegNo"])+""));
        return result;
    }
    [WebMethod]
    public static ShowStudentTransportdetails[] CheckUnchecked()
    {
        DataSet Ds = new DataSet();
        List<ShowStudentTransportdetails> StatusDetails = new List<ShowStudentTransportdetails>();
        DataUtility Objdut = new DataUtility();
        string strQuery = @"select DISTINCT MonthId,ALLASAID from tbl_StudentAdmissionInstallment Sai " +
                "where Sai.PaymentStatusId=2 and Sai.Brid = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["BrBrid"]) + " and Sai.StuRegNo = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["StuRegNo"]) + "";
        
        Ds = Objdut.GetDataSet(strQuery);
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                string AllAsaid = dtrow["ALLASAID"].ToString();
                if (string.IsNullOrEmpty(AllAsaid))
                {
                    ShowStudentTransportdetails user = new ShowStudentTransportdetails();
                    user.InstallmentDate = dtrow["MonthId"].ToString();
                    StatusDetails.Add(user);
                }
                else
                {
                    var AllAsaidArray = AllAsaid.Split(',');
                    for (int i = 0; i < AllAsaidArray.Length; i++)
                    {
                        DataTable dtAllAsaid = getMonth(AllAsaidArray[i]);
                        if (dtAllAsaid.Rows.Count > 0)
                        {
                            foreach (DataRow drAllAsaid in dtAllAsaid.Rows)
                            {
                                ShowStudentTransportdetails user = new ShowStudentTransportdetails();
                                user.InstallmentDate = drAllAsaid["MonthId"].ToString();
                                StatusDetails.Add(user);
                            }
                        }
                    }
                }
            }
        }
        string strTransFee = "Select DISTINCT ISNULL(Asaid,0) PayStatus from tbl_TransFee TF where TF.PayStatus=2 and TF.Brid = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["BrBrid"]) + " and TF.StuRegNo = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["StuRegNo"]) + "";
        DataTable dtTransFee = Objdut.GetDataTable(strTransFee);
        if (dtTransFee.Rows.Count > 0) {
            foreach (DataRow drTransFee in dtTransFee.Rows)
            {
                var asaid = drTransFee[0].ToString();
                if (!string.IsNullOrEmpty(asaid))
                {
                    DataTable dtAllAsaid = getMonth(asaid);
                    if (dtAllAsaid.Rows.Count > 0)
                    {
                        var monthId = dtAllAsaid.Rows[0]["MonthId"].ToString();
                        if (!isAlreadyExists(StatusDetails, monthId))
                        {
                            ShowStudentTransportdetails user = new ShowStudentTransportdetails();
                            user.InstallmentDate = monthId;
                            StatusDetails.Add(user);
                        }
                        //if (StatusDetails.Any<ShowStudentTransportdetails>(x => x.InstallmentDate.Trim().ToUpper() != monthId.Trim().ToUpper()))
                        //{
                        //    ShowStudentTransportdetails user = new ShowStudentTransportdetails();
                        //    user.InstallmentDate = monthId;
                        //    StatusDetails.Add(user);
                        //}
                    }
                }
            }
        }
        return StatusDetails.ToArray();
    }
    public static bool isAlreadyExists(List<ShowStudentTransportdetails> statusDetails, string monthId)
    {
        foreach (var monthDt in statusDetails)
        {
            string existsMonthId = monthDt.InstallmentDate;
            if (!string.IsNullOrEmpty(existsMonthId))
            {
                if (existsMonthId.Trim().ToLower() == monthId.Trim().ToLower())
                {
                    return true;
                }
            }
        }
        return false;
    }

    public static DataTable getMonth(string Asaid) {
        DataUtility Objdut = new DataUtility();
        string strQuery1 = @"select DISTINCT MonthId from tbl_StudentAdmissionInstallment Sai " +
                                "where Sai.Asaid =" + Asaid + " and Sai.Brid = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["BrBrid"]) + " and Sai.StuRegNo = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["StuRegNo"]) + "";

        DataTable dtAllAsaid = Objdut.GetDataTable(strQuery1);
        return dtAllAsaid;
    }
    [WebMethod]
    public static ShowStudentTransportdetails[] BindGridByTransportStudent()
    {
        DataSet Ds = new DataSet();
        List<ShowStudentTransportdetails> StatusDetails = new List<ShowStudentTransportdetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@MODE", 8);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@STUREGNO", System.Web.HttpContext.Current.Session["StuRegNo"].ToString());
        Ds = Objdut.GetDataSetSP(param, "[USP_VEHICLETOROUTE]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ShowStudentTransportdetails user = new ShowStudentTransportdetails();
                user.VehicleRegNum = dtrow["VehicleRegNum"].ToString();
                user.RouteName = dtrow["RouteName"].ToString();
                user.AddedDate = dtrow["AddedDate"].ToString();
                user.VehicleTime = dtrow["VehicleTime"].ToString();
                user.StuTransPortStatus = dtrow["StuTransPortStatus"].ToString();
                user.StuTransPortId = dtrow["StuTransPortId"].ToString();
                user.RouteSource = dtrow["RouteSource"].ToString();
                user.RouteDestination = dtrow["RouteDestination"].ToString();
                user.Trip = dtrow["Trip"].ToString();
                user.StoppageName = dtrow["StoppageName"].ToString();
                user.activestatus = dtrow["activestatus"].ToString();
                user.status = dtrow["status"].ToString();
                user.StuRegNo = dtrow["StuRegNo"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class ShowStudentTransportdetails
    {
        public string VehicleRegNum { get; set; }
        public string RouteName { get; set; }
        public string AddedDate { get; set; }
        public string VehicleTime { get; set; }
        public string StuTransPortStatus { get; set; }
        public string StuTransPortId { get; set; }
        public string RouteSource { get; set; }
        public string RouteDestination { get; set; }
        public string StoppageName { get; set; }
        public string Trip { get; set; }
        public string activestatus { get; set; }
        public string status { get; set; }
        public string StuRegNo { get; set; }
        public string InstallmentDate { get; set; }
    }
    [WebMethod]
    public static FillFieldstudentTransportdetails[] BindtxtTransportStudent(string TransportIDofStu)
    {
        DataSet Ds = new DataSet();
        List<FillFieldstudentTransportdetails> StatusDetails = new List<FillFieldstudentTransportdetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@MODE", 9);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@STUREGNO", System.Web.HttpContext.Current.Session["StuRegNo"].ToString());
        param[3] = new SqlParameter("@TVRMID", TransportIDofStu);
        Ds = Objdut.GetDataSetSP(param, "[USP_VEHICLETOROUTE]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                FillFieldstudentTransportdetails user = new FillFieldstudentTransportdetails();
                user.RouteID = dtrow["RouteID"].ToString();
                user.AddedDate = dtrow["AddedDate"].ToString();
                user.City = dtrow["City"].ToString();
                user.Area = dtrow["Area"].ToString();
                user.Block = dtrow["Block"].ToString();
                user.Road = dtrow["Road"].ToString();
                user.Stoppage = dtrow["Stoppage"].ToString();
                user.VehicleRegID = dtrow["VehicleRegID"].ToString();
                user.vehicleroutemapid = dtrow["vehicleroutemapid"].ToString();
                user.MonthList = dtrow["TransPortRequired"].ToString();
                user.feeDetails = dtrow["feeDetails"].ToString();
                user.stoppageName = dtrow["stoppageName"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class FillFieldstudentTransportdetails
    {
        public string RouteID { get; set; }
        public string AddedDate { get; set; }
        public string City { get; set; }
        public string Area { get; set; }
        public string Block { get; set; }
        public string Road { get; set; }
        public string Stoppage { get; set; }
        public string VehicleRegID { get; set; }
        public string vehicleroutemapid { get; set; }
        public string MonthList { get; set; }
        public string feeDetails { get; set; }
        public string stoppageName { get; set; }
    }

    [WebMethod]
    public static int updatestatus(int changestatus, int Stureg, int TransportIDofStu)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[7];
        param[0] = new SqlParameter("@changestatus", changestatus);
        param[1] = new SqlParameter("@BRID", Convert.ToInt32(System.Web.HttpContext.Current.Session["BrBrid"]));
        param[2] = new SqlParameter("@STUREGNO", Stureg);
        param[3] = new SqlParameter("@MODE", 10);
        param[4] = new SqlParameter("@TVRMID", TransportIDofStu);
        param[5] = new SqlParameter("@Activity", 11);
        param[6] = new SqlParameter("@intResult", SqlDbType.Int);
        param[6].Direction = ParameterDirection.Output;        
        Objdut.ExecuteSqlSP(param, "[USP_VEHICLETOROUTE]");
        int result = Convert.ToInt32(param[6].Value);
        return result;
        //DataUtility Objdut = new DataUtility();
        //if (changestatus == 0)
        //{
        //    ret = Objdut.ExecuteSql("update tbl_vehicleroutemap_StudentDetails set staus = 0 where StuRegNo = " + Stureg + "");
        //    ret = Objdut.ExecuteSql("update tbl_vehicleroutemap_StudentDetails set staus = 1 where StuRegNo=" + Stureg + " and tvrmid=" + TransportIDofStu + "");
        //}
        //else
        //{
        //    ret = Objdut.ExecuteSql("update tbl_vehicleroutemap_StudentDetails set staus = 0 where StuRegNo=" + Stureg + " and tvrmid=" + TransportIDofStu + "");
        //}        
    }
    //protected void allck_CheckedChanged(object sender, EventArgs e)
    //{
    //    if(allck.Checked=true)
    //    {
    //        for (int i = 0; i < CheckBoxList1.Items.Count; i++)
    //        {
    //            CheckBoxList1.Items[i].Selected = true;
    //        }
    //        for (int i = 0; i < CheckBoxList2.Items.Count; i++)
    //        {
    //            CheckBoxList2.Items[i].Selected = true;
    //        }
    //    }
    //    else
    //    {
    //        for (int a = 0; a < CheckBoxList1.Items.Count;a++)
    //        {
    //            CheckBoxList1.Items[a].Selected = false;
    //        }
    //        for (int a = 0; a < CheckBoxList2.Items.Count; a++)
    //        {
    //            CheckBoxList2.Items[a].Selected = false;
    //        }
    //    }
    //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "sopop();", true);        
    //}
    protected void allck_CheckedChanged(object sender, EventArgs e)
    {

    }
}