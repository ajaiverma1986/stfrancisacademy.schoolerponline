using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClosedXML;
using System.IO;
using ClosedXML.Excel;

public partial class BranchPanel_transportmanagment_student_transport_details : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    DataUtility Objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            fillfyear();
    }
    public void fillfyear()
    {
        DataTable Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    [WebMethod]
    public static bindallddl[] BindDDLTransport()
    {
        List<bindallddl> details = new List<bindallddl>();
        DataSet Ds = new DataSet();
        List<bindallddl> StatusDetails = new List<bindallddl>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 5);
        Ds = Objdut.GetDataSetSP(param, "[usp_bindtransportsetting]");
        bindallddl obj = new bindallddl();
        obj.zoneid = Convert.ToInt32("0");
        obj.zonename = "-Select City-";
        obj.areaid = Convert.ToString("0");
        obj.areaname = "-Select Area-";
        obj.BlockID = Convert.ToString("0");
        obj.BlockName = "-Select Block-";
        obj.roadid = Convert.ToString("0");
        obj.roadname = "-Select Road-";
        obj.StoppageID = Convert.ToString("0");
        obj.StoppageName = "-Select Stoppage-";
        obj.Id = Convert.ToString("0");
        obj.ClassName = "-Select Class-";
        obj.vehicleid = Convert.ToString("0");
        obj.VehicleRegNo = "-Select Vehicle Reg-";
        obj.RoutId = Convert.ToString("0");
        obj.RouteName = "-Select Route-";
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
            foreach (DataRow dtrow4 in Ds.Tables[4].Rows)
            {
                bindallddl obje = new bindallddl();
                obje.StoppageID = dtrow4["StoppageID"].ToString();
                obje.StoppageName = dtrow4["StoppageName"].ToString();
                details.Add(obje);
            }
            foreach (DataRow dtrow5 in Ds.Tables[5].Rows)
            {
                bindallddl obje = new bindallddl();
                obje.Id = dtrow5["Id"].ToString();
                obje.ClassName = dtrow5["ClassName"].ToString();
                details.Add(obje);
            }
            foreach (DataRow dtrow6 in Ds.Tables[6].Rows)
            {
                bindallddl obje = new bindallddl();
                obje.vehicleid = dtrow6["vehicleid"].ToString();
                obje.VehicleRegNo = dtrow6["VehicleRegNo"].ToString();
                details.Add(obje);
            }
            foreach (DataRow dtrow7 in Ds.Tables[7].Rows)
            {
                bindallddl obje = new bindallddl();
                obje.RoutId = dtrow7["RoutId"].ToString();
                obje.RouteName = dtrow7["RouteName"].ToString();
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
        public string Id { get; set; }
        public string ClassName { get; set; }
        public string vehicleid { get; set; }
        public string VehicleRegNo { get; set; }
        public string RoutId { get; set; }
        public string RouteName { get; set; }
    }
    [WebMethod]
    public static ShowStudentTransportdetails[] BindGridByTransportStudent(string fyid, string ClassID, string RouteID,
        string VehicleReg, string CityID, string AreaID, string BlockID, string RoadID, string StoppageID, string StudentName)
    {
        DataSet Ds = new DataSet();
        List<ShowStudentTransportdetails> StatusDetails = new List<ShowStudentTransportdetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[11];
        param[0] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[1] = new SqlParameter("@Name", StudentName);
        param[2] = new SqlParameter("@classid", ClassID);
        param[3] = new SqlParameter("@CityID", CityID);
        param[4] = new SqlParameter("@AreaID", AreaID);
        param[5] = new SqlParameter("@BlockID", BlockID);
        param[6] = new SqlParameter("@RoadID", RoadID);
        param[7] = new SqlParameter("@StoppageID", StoppageID);
        param[8] = new SqlParameter("@RouteID", RouteID);
        param[9] = new SqlParameter("@VehicleRegID", VehicleReg);
        param[10] = new SqlParameter("@Fyid", fyid);
        Ds = Objdut.GetDataSetSP(param, "[Usp_BindStudentTransposrt]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ShowStudentTransportdetails user = new ShowStudentTransportdetails();
                user.RowNumber = dtrow["RowNumber"].ToString();
                user.AddedDate = dtrow["AddedDate"].ToString();
                user.StuTransPortStatus = dtrow["StuTransPortStatus"].ToString();
                user.VehicleTime = dtrow["VehicleTime"].ToString();
                user.StudentName = dtrow["StudentName"].ToString();
                user.RouteName = dtrow["RouteName"].ToString();
                user.RouteSource = dtrow["RouteSource"].ToString();
                user.RouteDestination = dtrow["RouteDestination"].ToString();
                user.VehicleRegNum = dtrow["VehicleRegNum"].ToString();
                user.classname = dtrow["classname"].ToString();
                user.StoppageName = dtrow["StoppageName"].ToString();
                user.pagecount = Ds.Tables[1].Rows[0]["pages"].ToString();
                user.PrimaryMobileNo = dtrow["PrimaryMobileNo"].ToString();
                user.Parent = dtrow["Parent"].ToString();
                StatusDetails.Add(user);
            }
        }
        string filePath = HttpContext.Current.Server.MapPath("~/Uploads/") + "StuTransportRpt_" + System.Web.HttpContext.Current.Session["BrBrid"].ToString() + ".xlsx";
        if(File.Exists(filePath))
        {
            File.Delete(filePath);
        }
        DataTable dtExcel = new DataTable();
        dtExcel.Columns.Add("S.No.");
        dtExcel.Columns.Add("Name");
        dtExcel.Columns.Add("Parent");
        dtExcel.Columns.Add("Mobile");
        dtExcel.Columns.Add("Class");
        dtExcel.Columns.Add("Route");
        dtExcel.Columns.Add("Vehicle");
        dtExcel.Columns.Add("Source");
        dtExcel.Columns.Add("Destination");
        dtExcel.Columns.Add("Vehicle Time");
        dtExcel.Columns.Add("Added Date");
        dtExcel.Columns.Add("Status");
        dtExcel.Columns.Add("Stoppage");
        foreach(DataRow row in Ds.Tables[0].Rows)
        {
            DataRow dtr = dtExcel.NewRow();
            dtr["S.No."] = Convert.ToString(row["RowNumber"]);
            dtr["Name"] = Convert.ToString(row["StudentName"]);
            dtr["Parent"] = Convert.ToString(row["Parent"]);
            dtr["Mobile"] = Convert.ToString(row["PrimaryMobileNo"]);
            dtr["Class"] = Convert.ToString(row["classname"]);
            dtr["Route"] = Convert.ToString(row["RouteName"]);
            dtr["Vehicle"] = Convert.ToString(row["VehicleRegNum"]);
            dtr["Source"] = Convert.ToString(row["RouteSource"]);
            dtr["Destination"] = Convert.ToString(row["RouteDestination"]);
            dtr["Vehicle Time"] = Convert.ToString(row["VehicleTime"]);
            dtr["Added Date"] = Convert.ToString(row["AddedDate"]);
            dtr["Status"] = Convert.ToString(row["StuTransPortStatus"]);
            dtr["Stoppage"] = Convert.ToString(row["StoppageName"]);
            dtExcel.Rows.Add(dtr);
           
        }
        using (XLWorkbook wb = new XLWorkbook())
        {
            wb.Worksheets.Add(dtExcel, "Student Report");
            wb.Style.Alignment.Horizontal = XLAlignmentHorizontalValues.Center;
            wb.Style.Font.Bold = true;
            wb.SaveAs(filePath);
        }
        return StatusDetails.ToArray();
    }
    public class ShowStudentTransportdetails
    {
        public string RowNumber { get; set; }
        public string AddedDate { get; set; }
        public string StuTransPortStatus { get; set; }
        public string VehicleTime { get; set; }
        public string StudentName { get; set; }
        public string RouteName { get; set; }
        public string RouteSource { get; set; }
        public string RouteDestination { get; set; }
        public string VehicleRegNum { get; set; }
        public string classname { get; set; }
        public string StoppageName { get; set; }
        public string pagecount { get; set; }
        public string PrimaryMobileNo { get; set; }
        public string Parent { get; set; }
    }

    [WebMethod]
    public static getcourse[] BindClassMethod(int fyid)
    {
        List<getcourse> Details = new List<getcourse>();
        DataTable Dt = new DataTable();
        Dt = CommonClass.ABC("GetClassDDL", fyid, Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                getcourse obje = new getcourse();
                obje.courseID = Convert.ToInt32(Dt.Rows[i]["classid"]);
                obje.courseName = Convert.ToString(Dt.Rows[i]["Classname"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }
    public class getcourse
    {
        public int courseID { get; set; }
        public string courseName { get; set; }
    }
}