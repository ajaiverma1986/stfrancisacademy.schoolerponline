using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.Services;

public partial class HO_receipt_setting : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        string imgsrc = Convert.ToString(objdut.GetScalar("select isnull(logo,'')+'^'+isnull(LogoBgColor,'') from tbl_recieptsettingcenter"));
        string[] data = imgsrc.Split('^');
        btnlogoforrecipt.ImageUrl = "../images/" + data[0];
        divforlogo.Style.Add("background-color", data[1]);
    }

    [WebMethod]
    public static int callmethod(string Service_tax_no, string TIN, string Contact, string address, string autoormannual, string numberstartfrom, string receptapplyto, string brid, string Logo, string ImageLogoByteCode, string logobgcolor)
{
        string ImageExtforlogo = "";
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[11];
        param[0] = new SqlParameter("@servicetax", Service_tax_no);
        param[1] = new SqlParameter("@tin", TIN);
        param[2] = new SqlParameter("@Contact", Contact);
        param[3] = new SqlParameter("@address", address);
        param[4] = new SqlParameter("@brid", brid);
        param[5] = new SqlParameter("@intResult", 0);
        param[5].Direction = ParameterDirection.Output;
        param[6] = new SqlParameter("@autoormannual", autoormannual);
        param[7] = new SqlParameter("@numberstartfrom", numberstartfrom);
        param[8] = new SqlParameter("@receptapplyto", receptapplyto);
        param[10] = new SqlParameter("@logobgcolor", logobgcolor);

        if (Logo != "")
        {
            if (ImageLogoByteCode.Contains("base64,"))
            {
                int IndexNo = ImageLogoByteCode.IndexOf("/") + 1;
                int lastIndexNo = ImageLogoByteCode.IndexOf(";");
                ImageExtforlogo = ImageLogoByteCode.Substring(IndexNo, (lastIndexNo - IndexNo));
                int IndexNo1 = ImageLogoByteCode.IndexOf(",") + 1;
                int Pathlength1 = ImageLogoByteCode.Length;
                ImageLogoByteCode = ImageLogoByteCode.Substring(IndexNo1, (Pathlength1 - IndexNo1));
                byte[] b = Convert.FromBase64String(ImageLogoByteCode);
                MemoryStream ms = new MemoryStream(b);
                FileStream fs = new FileStream(System.Web.Hosting.HostingEnvironment.MapPath("~/images/") + Logo, FileMode.Create);
                ms.WriteTo(fs);
                ms.Close();
                fs.Close();
                fs.Dispose();
            }
            param[9] = new SqlParameter("@logoforrec", Logo);
        }
        else
        {
            param[9] = new SqlParameter("@logoforrec", "");
        }
        int result = objdut.ExecuteSqlSP(param, "usp_addrecieptsetting");
        return result;
    }

    [WebMethod]
    public static string getdata()
    {
        string insdata = "", a = "", b = "";
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        if (ObjDUT.GetScalar("select isnull((Service_tax_no+'^'+tin+'^'+Landline+'^'+address),'n') tax from tbl_institutemaster") != null)
        {
            a = ObjDUT.GetScalar("select isnull((Service_tax_no+'^'+tin+'^'+Landline+'^'+address),'n') tax from tbl_institutemaster").ToString();
        }        
        b = ObjDUT.GetScalar("select isnull((logo+'^'+LogoBgColor),'') logo from tbl_recieptsettingcenter").ToString();       
        insdata = a.ToString() + '^' + b.ToString();
        return insdata;
    }

    [WebMethod]
    public static branchdetails[] getbranchnames()
    {
        DataUtility objdut = new DataUtility();
        List<branchdetails> result = new List<branchdetails>();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 5);
        DataTable dt = objdut.GetDataTableSP(param, "[usp_general_master_setting]");
        foreach (DataRow dtrow in dt.Rows)
        {
            branchdetails user = new branchdetails();
            user.brid = dtrow["BrId"].ToString();
            user.brcode = dtrow["BrCode"].ToString();
            user.brname = dtrow["BrName"].ToString();
            user.landlineno = dtrow["LandLineNo"].ToString();
            result.Add(user);
        }
        return result.ToArray();
    }

    public class branchdetails
    {
        public string brid { get; set; }

        public string brcode { get; set; }

        public string brname { get; set; }

        public string landlineno { get; set; }
    }

    [WebMethod]
    public static string getbranchaddress(string brid="0")
    {
        string Address = "";
        DataUtility objdut = new DataUtility();
        Address = objdut.GetScalar("select BrAddress+','+City+' - '+pincode+', '+state+', '+Country from branch_master where brid = '" + brid + "'").ToString();
        return Address;
    }

    [WebMethod]
    public static string getbranchcontact(string brid = "0")
    {
        string Contact = "";
        DataUtility objdut = new DataUtility();
        Contact = objdut.GetScalar("select IsNull(LandLineNo,'') from Branch_master where BrId=" + brid).ToString();
        return Contact;
    }
    //webmethod for branchwise data
    [WebMethod]
    public static branchdata[] getbranchwisedata()
    {
        DataUtility objdut = new DataUtility();
        List<branchdata> result = new List<branchdata>();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 9);
        DataTable dt = objdut.GetDataTableSP(param, "[usp_Add_Name]");
        foreach (DataRow dtrow in dt.Rows)
        {
            branchdata user = new branchdata();
            user.brid = dtrow["BrId"].ToString();
            user.servicenumber = dtrow["servicenumber"].ToString();
            user.is_vat = dtrow["contact"].ToString();
            user.is_tin = dtrow["is_tin"].ToString();
            user.is_address = dtrow["is_address"].ToString();
            result.Add(user);
        }
        return result.ToArray();
    }

    public class branchdata
    {
        public string brid { get; set; }

        public string servicenumber { get; set; }

        public string is_vat { get; set; }

        public string is_tin { get; set; }

        public string is_address { get; set; }
    }

    [WebMethod]
    public static string getradiobuttonvalue()
    {
        string value = "";
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 10);
        value = objdut.GetScalerSP(param, "[usp_general_master_setting]").ToString();
        return value;
    }

    [WebMethod]
    public static gettest[] bindtestname()
    {
        List<gettest> details = new List<gettest>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select BrName,BrId  from Branch_master where BrActive = 1", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                gettest objemp = new gettest();
                objemp.BrId = Convert.ToInt32("0");
                objemp.BrName = "-Branch Name-";
                details.Add(objemp);
                foreach (DataRow dtrow in dt.Rows)
                {
                    gettest obje = new gettest();
                    obje.BrId = Convert.ToInt32(dtrow["BrId"].ToString());
                    obje.BrName = dtrow["BrName"].ToString();
                    details.Add(obje);
                }
            }
        }
        return details.ToArray();
    }

    public class gettest
    {
        public int BrId { get; set; }

        public string BrName { get; set; }
    }
}