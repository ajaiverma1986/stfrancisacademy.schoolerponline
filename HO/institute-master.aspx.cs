using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.Services;

public partial class branchpanel_master_company_master : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static int callmethod(string institutename, string Service_tax_no, string TIN, string VAT, string Landline, string Mobile, string address, string url, string filenameoflogo, string filenameoffavicon, string ImagefaviconByteCode, string ImageLogoByteCode, string LogoBgColor, string brid)
    {
        string ImageExtforlogo = "", ImageExtforfavicon = "";
        string constr = ConfigurationManager.AppSettings["ConnectionString"].ToString();
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_general_master_setting]"))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@institutename", institutename.Replace("~","'"));
                cmd.Parameters.AddWithValue("@servicetax", Service_tax_no);
                cmd.Parameters.AddWithValue("@tin", TIN);
                cmd.Parameters.AddWithValue("@vat", VAT);
                cmd.Parameters.AddWithValue("@phone", Landline);
                cmd.Parameters.AddWithValue("@mobile", Mobile);
                cmd.Parameters.AddWithValue("@address", address.Replace("~", "'"));
                cmd.Parameters.AddWithValue("@url", url);
                cmd.Parameters.AddWithValue("@bgcolorcode", LogoBgColor);
                cmd.Parameters.AddWithValue("@mode", 8);
                cmd.Parameters.AddWithValue("@brid", brid);
                #region//Code For Upload Company Logo

                if (filenameoflogo != "")
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
                        FileStream fs = new FileStream(System.Web.Hosting.HostingEnvironment.MapPath("~/images/") + filenameoflogo, FileMode.Create);
                        ms.WriteTo(fs);
                        ms.Close();
                        fs.Close();
                        fs.Dispose();
                    }

                    cmd.Parameters.Add("@logoname", filenameoflogo);
                }
                else
                {
                    cmd.Parameters.Add("@logoname", "");
                }

                #endregion

                #region//Code For Upload Favicon Image

                if (filenameoffavicon != "")
                {
                    if (ImagefaviconByteCode.Contains("base64,"))
                    {
                        int IndexNo = ImagefaviconByteCode.IndexOf("/") + 1;
                        int lastIndexNo = ImagefaviconByteCode.IndexOf(";");
                        ImageExtforfavicon = ImagefaviconByteCode.Substring(IndexNo, (lastIndexNo - IndexNo));
                        int IndexNo1 = ImagefaviconByteCode.IndexOf(",") + 1;
                        int Pathlength1 = ImagefaviconByteCode.Length;
                        ImagefaviconByteCode = ImagefaviconByteCode.Substring(IndexNo1, (Pathlength1 - IndexNo1));
                        byte[] b = Convert.FromBase64String(ImagefaviconByteCode);
                        MemoryStream ms = new MemoryStream(b);
                        FileStream fs = new FileStream(System.Web.Hosting.HostingEnvironment.MapPath("~/images/") + filenameoffavicon, FileMode.Create);
                        ms.WriteTo(fs);
                        ms.Close();
                        fs.Close();
                        fs.Dispose();
                    }

                    cmd.Parameters.Add("@faviconimagename", filenameoffavicon);
                }
                else
                {
                    cmd.Parameters.Add("@faviconimagename", "");
                }

                #endregion

                SqlParameter output = new SqlParameter("@intresult", SqlDbType.Int);
                output.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(output);
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();

                con.Close();
                return Convert.ToInt32(output.Value);
            }
        }
    }

    [WebMethod]
    public static string getdata(string brid)
    {
        //SendMail.SendDemo("shourya@awapalsolutions.com", "shourya@awapalsolutions.com", "", "", "Testing", "Test Mail", "988912aug", "webmail.awapalsolutions.com");
        string insdata = "";
        string strinsdata = "";
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        strinsdata = "select institute_name+'^'+Service_tax_no+'^'+tin+'^'+vat+'^'+Landline+'^'+mobile+'^'+address+'^'+url+'^'+Logo+'^'+favicon+'^'+ISNULL(LogoBgColor,'') from tbl_institutemaster where Brid=" + brid;
        if (ObjDUT.GetScalar(strinsdata) != null)
        {
            insdata = ObjDUT.GetScalar(strinsdata).ToString();
        }
        return insdata;
    }
}