using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class BranchPanel_StudentManagement_student_hostel_details : System.Web.UI.Page
{
    private static int PageSize = 10;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static string GetHostelFee(string MonthID)
    {
        DataSet Ds = new DataSet();
        DataUtility Objdut = new DataUtility();
        CommonClass objCommon = new CommonClass();

        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@MODE", 4);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@fyid", Convert.ToInt32(objCommon.GetActiveAcedmicYear()));
        param[3] = new SqlParameter("@STUREGNO", System.Web.HttpContext.Current.Session["StuRegNo"].ToString());
        param[4] = new SqlParameter("@MonthID", MonthID.ToString());
        Ds = Objdut.GetDataSetSP(param, "[USP_HostelToStudent]");

        return Ds.GetXml().ToString();
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
    public static int SaveHostelStudent(string AddedDate, string MonthList, string HostelID, string FeeID, string HTSID)
    {
        DataUtility Objdut = new DataUtility();
        CommonClass objCommon = new CommonClass();

        SqlParameter[] param = new SqlParameter[10];
        param[0] = new SqlParameter("@MonthList", MonthList);
        param[1] = new SqlParameter("@FeeID", FeeID);
        param[2] = new SqlParameter("@BRID", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[3] = new SqlParameter("@STUREGNO", System.Web.HttpContext.Current.Session["StuRegNo"].ToString());
        param[4] = new SqlParameter("@MODE", 5);
        param[5] = new SqlParameter("@fyid", Convert.ToInt32(objCommon.GetActiveAcedmicYear()));
        param[6] = new SqlParameter("@HostelID", Convert.ToInt32(HostelID));
        param[7] = new SqlParameter("@ADDEDDATE", AddedDate);
        param[8] = new SqlParameter("@intResult", SqlDbType.Int);
        param[8].Direction = ParameterDirection.Output;
        param[9] = new SqlParameter("@HTSID", Convert.ToInt32(HTSID));
        Objdut.ExecuteSqlSP(param, "[USP_HostelToStudent]");
        int result = Convert.ToInt32(param[8].Value);
        return result;
    }
    [WebMethod]
    public static HostelMst[] ddlHostel()
    {
        List<HostelMst> details = new List<HostelMst>();
        DataSet Ds = new DataSet();
        DataUtility Objdut = new DataUtility();
        CommonClass objCommon = new CommonClass();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@MODE", 3);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@fyid", Convert.ToInt32(objCommon.GetActiveAcedmicYear()));
        Ds = Objdut.GetDataSetSP(param, "[USP_HostelToStudent]");
        HostelMst obj = new HostelMst();
        obj.HostelID = "0";
        obj.HostelName = "-- Select Hostel --";
        details.Add(obj);
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow1 in Ds.Tables[0].Rows)
            {
                HostelMst obje = new HostelMst();
                obje.HostelID = dtrow1["HostelID"].ToString();
                obje.HostelName = dtrow1["HostelName"].ToString();
                details.Add(obje);
            }
        }
        return details.ToArray();
    }
    [WebMethod]
    public static HostelMst[] ddlHostelFee()
    {
        List<HostelMst> details = new List<HostelMst>();
        DataSet Ds = new DataSet();
        DataUtility Objdut = new DataUtility();
        CommonClass objCommon = new CommonClass();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@MODE", 10);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@fyid", Convert.ToInt32(objCommon.GetActiveAcedmicYear()));
        param[3] = new SqlParameter("@STUREGNO", System.Web.HttpContext.Current.Session["StuRegNo"].ToString());
        Ds = Objdut.GetDataSetSP(param, "[USP_HostelToStudent]");
        HostelMst obj = new HostelMst();
        obj.HostelFeeID = "0";
        obj.HostelNameFee = "-- Select Hostel --";
        details.Add(obj);
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow1 in Ds.Tables[0].Rows)
            {
                HostelMst obje = new HostelMst();
                obje.HostelFeeID = dtrow1["HostelFeeID"].ToString();
                obje.HostelNameFee = dtrow1["FeeAmount"].ToString();
                details.Add(obje);
            }
        }
        return details.ToArray();
    }
    public class HostelMst
    {
        public string HostelID { get; set; }
        public string HostelName { get; set; }
        public string HostelFeeID { get; set; }
        public string HostelNameFee { get; set; }
        public string ClassID { get; set; }
        public string ClassName { get; set; }
    }

    [WebMethod]
    public static int CheckHostelOfStd()
    {
        CommonClass objCommon = new CommonClass();
        DataUtility Objdut = new DataUtility();
        string StrW = "";
        StrW= @"Select ISNULL(SR.IsHostel,0) IsHostel from tbl_StudentRegistration SR
                Inner Join tbl_StudentMaster SM on SR.RID=SM.RID and SR.Brid = SM.Brid 
                Inner Join tbl_StudentAdmissionMaster SA on SA.StuRegNo = SM.SturegNo and SA.Brid = SM.Brid where SR.Status = 1 and SR.fyid=" + Convert.ToInt32(objCommon.GetActiveAcedmicYear()) + " and SR.Brid = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["BrBrid"]) + " and SA.StuRegNo = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["StuRegNo"]) + "";
        int result = Convert.ToInt32(Objdut.GetScalar(StrW));
        return result;
    }
    [WebMethod]
    public static int CheckStatus(string HostelIDofStu)
    {
        CommonClass objCommon = new CommonClass();
        DataUtility Objdut = new DataUtility();
        string StrW = "";
        StrW = @"Select ISNULL(status,0) status from tbl_HostelToStudent
        where fyid=" + Convert.ToInt32(objCommon.GetActiveAcedmicYear()) + " and Brid = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["BrBrid"]) + " and StuRegNo = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["StuRegNo"]) + " and HTSID=" + HostelIDofStu + "";
        int result = Convert.ToInt32(Objdut.GetScalar(StrW));
        return result;
    }
    [WebMethod]
    public static ShowStudentTransportdetails[] Check_UncheckedByFeeID(string FeeID)
    {
        DataSet Ds = new DataSet();
        List<ShowStudentTransportdetails> StatusDetails = new List<ShowStudentTransportdetails>();
        DataUtility Objdut = new DataUtility();
        if (Convert.ToInt32(FeeID) > 0)
        {
            Ds = Objdut.GetDataSet("select DISTINCT MonthID as InstallmentDate from tbl_PayHostelFee1 where PayStatus=2 and Brid = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["BrBrid"]) + " and StuRegNo = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["StuRegNo"]) + " and FeeID=" + FeeID + "");
            if (Ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dtrow in Ds.Tables[0].Rows)
                {
                    ShowStudentTransportdetails user = new ShowStudentTransportdetails();
                    user.InstallmentDate = dtrow["InstallmentDate"].ToString();
                    StatusDetails.Add(user);
                }
            }
        }
        return StatusDetails.ToArray();
    }
    [WebMethod]
    public static ShowStudentTransportdetails[] CheckUnchecked(string HostelID, string HTSID)
    {
        DataSet Ds = new DataSet();
        List<ShowStudentTransportdetails> StatusDetails = new List<ShowStudentTransportdetails>();
        DataUtility Objdut = new DataUtility();
        if (HostelID == "0")
        {
            if (Convert.ToInt32(HTSID) > 0)
            {
                HostelID = Convert.ToString(Objdut.GetScalar("Select ISNULL(HostelID,0) from tbl_HostelToStudent where Brid = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["BrBrid"]) + " and StuRegNo = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["StuRegNo"]) + " and HTSID=" + HTSID + ""));
            }
        }
        Ds = Objdut.GetDataSet("select DISTINCT MonthID as InstallmentDate from tbl_PayHostelFee1 where PayStatus=2 and Brid = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["BrBrid"]) + " and StuRegNo = " + Convert.ToInt32(System.Web.HttpContext.Current.Session["StuRegNo"]) + "");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ShowStudentTransportdetails user = new ShowStudentTransportdetails();
                user.InstallmentDate = dtrow["InstallmentDate"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    [WebMethod]
    public static ShowStudentTransportdetails[] BindGridByTransportStudent()
    {
        DataSet Ds = new DataSet();
        CommonClass objCommon = new CommonClass();
        List<ShowStudentTransportdetails> StatusDetails = new List<ShowStudentTransportdetails>();
        DataUtility Objdut = new DataUtility();

        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@MODE", 6);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@STUREGNO", System.Web.HttpContext.Current.Session["StuRegNo"].ToString());
        param[3] = new SqlParameter("@fyid", Convert.ToInt32(objCommon.GetActiveAcedmicYear()));
        Ds = Objdut.GetDataSetSP(param, "[USP_HostelToStudent]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ShowStudentTransportdetails user = new ShowStudentTransportdetails();
                user.HostelName = dtrow["HostelName"].ToString();
                user.StuTransPortStatus = dtrow["StuTransPortStatus"].ToString();
                user.AddedDate = Convert.ToDateTime(dtrow["AddedDate"]).ToString("dd MMM yyyy");
                user.HostelID = dtrow["HostelID"].ToString();
                user.StuTransPortId = dtrow["HTSID"].ToString();
                //user.RouteSource = dtrow["RouteSource"].ToString();               
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
        public string HostelName { get; set; }
        public string RouteName { get; set; }
        public string AddedDate { get; set; }
        public string VehicleTime { get; set; }
        public string StuTransPortStatus { get; set; }
        public string StuTransPortId { get; set; }
        public string HostelID { get; set; }
        public string RouteDestination { get; set; }
        public string StoppageName { get; set; }
        public string activestatus { get; set; }
        public string status { get; set; }
        public string StuRegNo { get; set; }
        public string InstallmentDate { get; set; }
    }
    [WebMethod]
    public static FillFieldstudentTransportdetails[] BindtxtHostelStudent(string HostelIDofStu, string HostelID)
    {
        DataSet Ds = new DataSet();
        List<FillFieldstudentTransportdetails> StatusDetails = new List<FillFieldstudentTransportdetails>();
        DataUtility Objdut = new DataUtility();
        CommonClass objCommon = new CommonClass();

        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@MODE", 6);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@STUREGNO", System.Web.HttpContext.Current.Session["StuRegNo"].ToString());
        param[3] = new SqlParameter("@fyid", Convert.ToInt32(objCommon.GetActiveAcedmicYear()));
        param[4] = new SqlParameter("@HostelID", Convert.ToInt32(HostelID));
        param[5] = new SqlParameter("@HTSID", Convert.ToInt32(HostelIDofStu));
        Ds = Objdut.GetDataSetSP(param, "[USP_HostelToStudent]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                FillFieldstudentTransportdetails user = new FillFieldstudentTransportdetails();
                user.HostelID = dtrow["HostelID"].ToString();
                user.AddedDate = Convert.ToDateTime(dtrow["AddedDate"]).ToString("dd MMM yyyy");
                //user.FeeList = dtrow["HostelFeeIDs"].ToString();
                //user.Area = dtrow["Area"].ToString();
                //user.Block = dtrow["Block"].ToString();
                //user.Road = dtrow["Road"].ToString();
                //user.Stoppage = dtrow["Stoppage"].ToString();
                //user.VehicleRegID = dtrow["VehicleRegID"].ToString();
                //user.vehicleroutemapid = dtrow["vehicleroutemapid"].ToString();
                user.MonthList = "0";
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    [WebMethod]
    public static FillFieldstudentTransportdetails[] BindtxtHostelStudentByFeeID(string FeeID, string HostelID)
    {
        DataSet Ds = new DataSet();
        List<FillFieldstudentTransportdetails> StatusDetails = new List<FillFieldstudentTransportdetails>();
        DataUtility Objdut = new DataUtility();
        CommonClass objCommon = new CommonClass();

        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@MODE", 12);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@STUREGNO", System.Web.HttpContext.Current.Session["StuRegNo"].ToString());
        param[3] = new SqlParameter("@fyid", Convert.ToInt32(objCommon.GetActiveAcedmicYear()));
        param[4] = new SqlParameter("@HostelID", Convert.ToInt32(HostelID));
        param[5] = new SqlParameter("@FeeID", Convert.ToInt32(FeeID));
        Ds = Objdut.GetDataSetSP(param, "[USP_HostelToStudent]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            string StrMonthList = "";
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                if (StrMonthList == "")
                {
                    StrMonthList = dtrow["InstallmentDate"].ToString();
                }
                else
                {
                    StrMonthList = StrMonthList + "~" + dtrow["InstallmentDate"].ToString();
                }
            }
            FillFieldstudentTransportdetails user = new FillFieldstudentTransportdetails();
            user.MonthList = StrMonthList.ToString();
            StatusDetails.Add(user);
        }
        return StatusDetails.ToArray();
    }
    public class FillFieldstudentTransportdetails
    {
        public string HostelID { get; set; }
        public string AddedDate { get; set; }
        public string City { get; set; }
        public string Area { get; set; }
        public string Block { get; set; }
        public string Road { get; set; }
        public string Stoppage { get; set; }
        public string VehicleRegID { get; set; }
        public string vehicleroutemapid { get; set; }
        public string MonthList { get; set; }
        public string FeeList { get; set; }
    }

    [WebMethod]
    public static int updatestatus(int changestatus, int Stureg, int TransportIDofStu)
    {
        DataUtility Objdut = new DataUtility();
        CommonClass objCommon = new CommonClass();

        SqlParameter[] param = new SqlParameter[7];
        param[0] = new SqlParameter("@status", changestatus);
        param[1] = new SqlParameter("@BRID", Convert.ToInt32(System.Web.HttpContext.Current.Session["BrBrid"]));
        param[2] = new SqlParameter("@STUREGNO", Stureg);
        param[3] = new SqlParameter("@MODE", 9);
        param[4] = new SqlParameter("@HTSID", TransportIDofStu);
        param[5] = new SqlParameter("@fyid", Convert.ToInt32(objCommon.GetActiveAcedmicYear()));
        param[6] = new SqlParameter("@intResult", SqlDbType.Int);
        param[6].Direction = ParameterDirection.Output;
        Objdut.ExecuteSqlSP(param, "[USP_HostelToStudent]");
        int result = Convert.ToInt32(param[6].Value);
        return result;       
    }
    protected void allck_CheckedChanged(object sender, EventArgs e)
    {
        if (allck.Checked == true)
        {
            for (int i = 0; i < CheckBoxList1.Items.Count; i++)
            {
                if (CheckBoxList1.Items[i].Enabled == true)
                {
                    CheckBoxList1.Items[i].Selected = true;
                }
            }
            for (int i = 0; i < CheckBoxList2.Items.Count; i++)
            {
                if (CheckBoxList2.Items[i].Enabled == true)
                {
                    CheckBoxList2.Items[i].Selected = true;
                }
            }
        }
        else
        {
            for (int a = 0; a < CheckBoxList1.Items.Count; a++)
            {
                CheckBoxList1.Items[a].Selected = false;
            }
            for (int a = 0; a < CheckBoxList2.Items.Count; a++)
            {
                CheckBoxList2.Items[a].Selected = false;
            }
        }
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "sopop();", true);
    }
}