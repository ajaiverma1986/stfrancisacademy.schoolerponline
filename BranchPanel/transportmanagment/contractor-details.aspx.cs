using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_transportmanagment_contractor_details : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static int COntractordata(string ContractName, string COntractAddress,
        string Contracttin, string contracsstax, string ContractCOntact, string ContractEmail, string ContractPan, string ContactDocument, string Imgdocabt, string getdocrsc,
        string docExtension, string imagepanabt, string pandocgetrsc, string PanExtension, string datetype, string updatemode, string updateid)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[15];
        param[0] = new SqlParameter("@ContractName", ContractName.Replace("`", "'"));
        param[1] = new SqlParameter("@COntractAddress", COntractAddress.Replace("`", "'"));
        param[2] = new SqlParameter("@Contracttin", Contracttin.Replace("`", "'"));
        param[3] = new SqlParameter("@contracsstax", contracsstax.Replace("`", "'"));
        param[4] = new SqlParameter("@ContractCOntact", ContractCOntact);
        param[5] = new SqlParameter("@ContractEmail", ContractEmail.Replace("`", "'"));
        param[6] = new SqlParameter("@ContractPan", ContractPan.Replace("`", "'"));
        param[7] = new SqlParameter("@ContactDocument", ContactDocument.Replace("`", "'"));
        param[8] = new SqlParameter("@Imgdocabt", Imgdocabt);
        param[9] = new SqlParameter("@imagepanabt", imagepanabt);
        param[10] = new SqlParameter("@datetype", datetype);
        param[11] = new SqlParameter("@updateid", updateid);
        param[12] = new SqlParameter("@brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[13] = new SqlParameter("@mode", updatemode);
        param[14] = new SqlParameter("@intResult", SqlDbType.Int);
        param[14].Direction = ParameterDirection.Output;
       
        if (getdocrsc != "")
        {
            if (getdocrsc.Contains("base64,"))
            {
                int IndexNo = getdocrsc.IndexOf("/") + 1;
                int lastIndexNo = getdocrsc.IndexOf(";");
                int IndexNo1 = getdocrsc.IndexOf(",") + 1;
                int Pathlength1 = getdocrsc.Length;
                getdocrsc = getdocrsc.Substring(IndexNo1, (Pathlength1 - IndexNo1));
                byte[] b = Convert.FromBase64String(getdocrsc);
                string pathforsaveimage = HttpContext.Current.Request.MapPath("transportimage/") + Imgdocabt;
                MasterImageUpload.CreateImage(b, Imgdocabt, docExtension, pathforsaveimage, 0);
            }
        }
        if (pandocgetrsc != "")
        {
            if (pandocgetrsc.Contains("base64,"))
            {
                int IndexNo = pandocgetrsc.IndexOf("/") + 1;
                int lastIndexNo = pandocgetrsc.IndexOf(";");
                int IndexNo1 = pandocgetrsc.IndexOf(",") + 1;
                int Pathlength1 = pandocgetrsc.Length;
                pandocgetrsc = pandocgetrsc.Substring(IndexNo1, (Pathlength1 - IndexNo1));
                byte[] vb = Convert.FromBase64String(pandocgetrsc);
                string vpathforsaveimage = HttpContext.Current.Request.MapPath("transportimage/") + imagepanabt;
                MasterImageUpload.CreateImage(vb, imagepanabt, PanExtension, vpathforsaveimage, 0);
            }
        }

        Objdut.ExecuteSqlSP(param, "[Usp_Contractor_Details]");
        int result = Convert.ToInt32(param[14].Value);
        return result;
    }

    [WebMethod]
    public static Showroaddetails[] BindGridByJscontractor(string mode, string updateid)
    {
        DataSet Ds = new DataSet();
        List<Showroaddetails> StatusDetails = new List<Showroaddetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", mode);
        param[1] = new SqlParameter("@updateid", updateid);
        param[2] = new SqlParameter("@brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        Ds = Objdut.GetDataSetSP(param, "Usp_Contractor_Details");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                Showroaddetails user = new Showroaddetails();
                user.contractname = dtrow["contractname"].ToString();
                user.contractorid = dtrow["contractorid"].ToString();
                user.contractcontact = dtrow["contractcontact"].ToString();
                user.contractemail = dtrow["contractemail"].ToString();
                user.driver = dtrow["driver"].ToString();
                user.conductor = dtrow["conductor"].ToString();
                user.COntractAddress = dtrow["COntractAddress"].ToString();
                user.contracttin = dtrow["contracttin"].ToString();
                user.contracsstax = dtrow["contracsstax"].ToString();
                user.ContractPan = dtrow["ContractPan"].ToString();
                user.ContactDocument = dtrow["ContactDocument"].ToString();
                user.Imgdocabt = dtrow["Imgdocabt"].ToString();
                user.imagepanabt = dtrow["imagepanabt"].ToString();
                user.date = dtrow["date"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class Showroaddetails
    {
        public string contractname { get; set; }
        public string contractorid { get; set; }
        public string contractcontact { get; set; }
        public string contractemail { get; set; }
        public string driver { get; set; }
        public string conductor { get; set; }
        public string COntractAddress { get; set; }
        public string contracttin { get; set; }
        public string contracsstax { get; set; }
        public string ContractPan { get; set; }
        public string ContactDocument { get; set; }
        public string Imgdocabt { get; set; }
        public string imagepanabt { get; set; }
        public string date { get; set; }
    }

    [WebMethod]
    public static bindcontractor[] bindcontractorddl()
    {
        List<bindcontractor> details = new List<bindcontractor>();
        DataSet Ds = new DataSet();
        List<bindcontractor> StatusDetails = new List<bindcontractor>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 5);
       // param[1] = new SqlParameter("@contractupdtid", contractupdtid);
        Ds = Objdut.GetDataSetSP(param, "[Usp_Contractor_Details]");
        bindcontractor obj = new bindcontractor();
        obj.contractorid = Convert.ToString("0");
        obj.ContractName = "-- Select Contractor --";
        details.Add(obj);
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                bindcontractor obje = new bindcontractor();
                obje.contractorid = dtrow["contractorid"].ToString();
                obje.ContractName = dtrow["ContractName"].ToString();
                details.Add(obje);
            }
        }
        return details.ToArray();
    }
    public class bindcontractor
    {
        public string ContractName { get; set; }
        public string contractorid { get; set; }
    }

    [WebMethod]
    public static int Driverdata(string Contractoridfordriver, string drivername,
        string drivermob, string driveremail, string driverdate, string driverdoc, string driveraddress, string imagedriverdata, string drivergetrsc, string driverExtension, string driverremark, string DriverModeAddUpdate, string updatedriverid)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[13];
        param[0] = new SqlParameter("@contractor_drid", Contractoridfordriver);
        param[1] = new SqlParameter("@drivername", drivername.Replace("`", "'"));
        param[2] = new SqlParameter("@drivermob", drivermob);
        param[3] = new SqlParameter("@driveremail", driveremail.Replace("`", "'"));
        param[4] = new SqlParameter("@drivercondate", driverdate);
        param[5] = new SqlParameter("@driverdoc", driverdoc.Replace("`", "'"));
        param[6] = new SqlParameter("@driveradd", driveraddress.Replace("`", "'"));
        param[7] = new SqlParameter("@docimage", imagedriverdata.Replace("`", "'"));
        param[8] = new SqlParameter("@driverremark", driverremark.Replace("`", "'"));
        param[9] = new SqlParameter("@brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[10] = new SqlParameter("@mode", DriverModeAddUpdate);
        param[11] = new SqlParameter("@updatecontractor_drid", updatedriverid);
        param[12] = new SqlParameter("@intResult", SqlDbType.Int);
        param[12].Direction = ParameterDirection.Output;

        if (drivergetrsc != "")
        {
            if (drivergetrsc.Contains("base64,"))
            {
                int IndexNo = drivergetrsc.IndexOf("/") + 1;
                int lastIndexNo = drivergetrsc.IndexOf(";");
                int IndexNo1 = drivergetrsc.IndexOf(",") + 1;
                int Pathlength1 = drivergetrsc.Length;
                drivergetrsc = drivergetrsc.Substring(IndexNo1, (Pathlength1 - IndexNo1));
                byte[] b = Convert.FromBase64String(drivergetrsc);
                string pathforsaveimagedriver = HttpContext.Current.Request.MapPath("transportimage/") + imagedriverdata;
                MasterImageUpload.CreateImage(b, imagedriverdata, driverExtension, pathforsaveimagedriver, 0);
            }
        }
        Objdut.ExecuteSqlSP(param, "[Usp_Contractor_Details]");
        int result = Convert.ToInt32(param[12].Value);
        return result;
    }
    [WebMethod]
    public static int helperdata(string helpercontractorid, string helpername,
        string helpercontact, string helperdate, string helperaddress, string helperremark, string updatehelpermode, string hlprshowtxtid)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[10];
        param[0] = new SqlParameter("@contractor_helperid", helpercontractorid);
        param[1] = new SqlParameter("@helpername", helpername.Replace("`", "'"));
        param[2] = new SqlParameter("@helpercontact", helpercontact);
        param[3] = new SqlParameter("@helperdate", helperdate);
        param[4] = new SqlParameter("@helperaddress", helperaddress.Replace("`", "'"));
        param[5] = new SqlParameter("@helperremark", helperremark.Replace("`", "'"));
        param[6] = new SqlParameter("@brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[7] = new SqlParameter("@mode", updatehelpermode);
        param[8] = new SqlParameter("@updatehelperid", hlprshowtxtid);
        param[9] = new SqlParameter("@intResult", SqlDbType.Int);
        param[9].Direction = ParameterDirection.Output;
        Objdut.ExecuteSqlSP(param, "[Usp_Contractor_Details]");
        int result = Convert.ToInt32(param[9].Value);
        return result;
    }

    [WebMethod]
    public static Showdriverdetails[] BindGridByJsDriver(string contractorforshow, string DriverMode, string updatedriverid)
    {
        DataSet Ds = new DataSet();
        List<Showdriverdetails> StatusDetails = new List<Showdriverdetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", DriverMode);
        param[1] = new SqlParameter("@contractor_drid", contractorforshow);
        param[2] = new SqlParameter("@driverid", updatedriverid);
        param[3] = new SqlParameter("@brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        Ds = Objdut.GetDataSetSP(param, "Usp_Contractor_Details");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                Showdriverdetails user = new Showdriverdetails();
                user.contractorname = dtrow["contractorname"].ToString();
                user.name = dtrow["name"].ToString();
                user.mobile = dtrow["mobile"].ToString();
                user.con_date = dtrow["con_date"].ToString();
                user.driver_document = dtrow["driver_document"].ToString();
                user.con_driverid = dtrow["con_driverid"].ToString();
                user.driver_address = dtrow["driver_address"].ToString();
                user.email = dtrow["email"].ToString();
                user.ctorid = dtrow["ctorid"].ToString();
                user.driverremark = dtrow["driverremark"].ToString();
                user.docimage = dtrow["docimage"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class Showdriverdetails
    {
        public string contractorname { get; set; }
        public string name { get; set; }
        public string mobile { get; set; }
        public string con_date { get; set; }
        public string driver_document { get; set; }
        public string con_driverid { get; set; }
        public string ctorid { get; set; }
        public string driver_address { get; set; }
        public string email { get; set; }
        public string driverremark { get; set; }
        public string docimage { get; set; }
    }

    [WebMethod]
    public static ShowHelperdetails[] BindGridByJsHelper(string contractupdtidbb, string ShowHElperListMode, string hlprshowtxtid)
    {
        DataSet Ds = new DataSet();
        List<ShowHelperdetails> StatusDetails = new List<ShowHelperdetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", ShowHElperListMode);
        param[1] = new SqlParameter("@contractor_helperid", contractupdtidbb);
        param[2] = new SqlParameter("@contractor_helpershowtxtid", hlprshowtxtid);
        param[3] = new SqlParameter("@brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        Ds = Objdut.GetDataSetSP(param, "Usp_Contractor_Details");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                ShowHelperdetails user = new ShowHelperdetails();
                user.contractorname = dtrow["contractorname"].ToString();
                user.helpername = dtrow["helpername"].ToString();
                user.helpercontact = dtrow["helpercontact"].ToString();
                user.helperdate = dtrow["helperdate"].ToString();
                user.helperid = dtrow["helperid"].ToString();
                user.helperaddress = dtrow["helperaddress"].ToString();
                user.helperremark = dtrow["helperremark"].ToString();
                user.contractorhelperid = dtrow["contractorhelperid"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    public class ShowHelperdetails
    {
        public string contractorname { get; set; }
        public string helpername { get; set; }
        public string helpercontact { get; set; }
        public string helperdate { get; set; }
        public string helperid { get; set; }
        public string helperaddress { get; set; }
        public string helperremark { get; set; }
        public string contractorhelperid { get; set; }
    }
}