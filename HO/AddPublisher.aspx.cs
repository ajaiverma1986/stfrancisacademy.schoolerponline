using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class HO_AddPublisher : System.Web.UI.Page
{
    private SqlParameter[] param;
    private DataUtility OBJDut = new DataUtility();
    private Utility objUT = new Utility();
    private DataTable dt;
    private string url = "", query;

 
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    //*********************************************add publisher********************************************
    [WebMethod]
    public static int savePublisherdata(string Publishername, string Company, string Address,string City,string State,string Postal,string Telephone,string Email,string Comments,string Website,string Active)
    {

        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[14];
        param[0] = new SqlParameter("@id", Convert.ToInt32("0"));
        param[1] = new SqlParameter("@pub_Name", Publishername.Replace("~", "'"));
        param[2] = new SqlParameter("@Company_name", Company.Replace("~", "'"));
        param[3] = new SqlParameter("@address", Address.Replace("~", "'"));
        param[4] = new SqlParameter("@intResult", 0);
        param[4].Direction = ParameterDirection.Output;
        param[5] = new SqlParameter("@mode", 1);
        param[6] = new SqlParameter("@city", City.Replace("~", "'"));
        param[7] = new SqlParameter("@state", State.Replace("~", "'"));
        param[8] = new SqlParameter("@postalCode", Postal.Replace("~", "'"));
        param[9] = new SqlParameter("@phone", Telephone.Replace("~", "'"));
        param[10] = new SqlParameter("@email", Email.Replace("~", "'"));
        param[11] = new SqlParameter("@comments", Comments.Replace("~", "'"));
        param[12] = new SqlParameter("@websites", Website.Replace("~", "'"));
        param[13] = new SqlParameter("@status", Active);

        int result = objdut.ExecuteSqlSP(param, "usp_Publisher_master");
        return result;
    }
    //******************************************************get publisher list***************************************

    [WebMethod]
    public static publisherlist[] fillpublisherlist(string publishenamesearch)
    {
        DataSet ds = new DataSet();
        List<publisherlist> details = new List<publisherlist>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@pub_Name", publishenamesearch.Replace("~", "'"));
        param[2] = new SqlParameter("@intResult", 0);
        param[2].Direction = ParameterDirection.Output;
      ds = ObjDUT.GetDataSetSP(param, "usp_Publisher_master");
        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                publisherlist user = new publisherlist();
                user.Publisherid = dtrow["Pub_ID"].ToString();
                user.PublisherName = dtrow["pub_Name"].ToString();
                user.CompanyName = dtrow["Company_name"].ToString();
                user.Telephone = dtrow["phone"].ToString();
                user.Email = dtrow["email"].ToString();
                user.Status = dtrow["status"].ToString();
                details.Add(user);
            }
        }
        return details.ToArray();
    }

    public class publisherlist
    {
        public string Publisherid { get; set; }
        public string PublisherName { get; set; }
        public string CompanyName { get; set; }
        public string Telephone { get; set; }
        public string Email { get; set; }
        public string Status { get; set; }
    }
    //********************************************web method for edit*******************************************
    [WebMethod]
    public static publisheredit[] Editdetail(string publisherid)
    {
        DataSet ds = new DataSet();
        List<publisheredit> details = new List<publisheredit>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@publisher_id", publisherid);
        param[2] = new SqlParameter("@intResult", 0);
        param[2].Direction = ParameterDirection.Output;
        ds = ObjDUT.GetDataSetSP(param, "[usp_Publisher_master]");
        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                publisheredit user = new publisheredit();
                user.Publisherid = dtrow["Pub_ID"].ToString();
                user.PublisherName = dtrow["pub_Name"].ToString();
                user.CompanyName = dtrow["Company_name"].ToString();
                user.city = dtrow["city"].ToString();
                user.state = dtrow["state"].ToString();
                user.pincode = dtrow["postalCode"].ToString();
                user.phno = dtrow["phone"].ToString();
                user.email = dtrow["email"].ToString();
                user.comments = dtrow["comments"].ToString();
                user.wesite = dtrow["websites"].ToString();
                user.Status = dtrow["status"].ToString();
                user.Address = dtrow["address"].ToString();
                details.Add(user);
            }
        }
        return details.ToArray();
    }

    public class publisheredit
    {
        public string Publisherid { get; set; }
        public string PublisherName { get; set; }
        public string CompanyName { get; set; }
        public string city { get; set; }
        public string state { get; set; }
        public string pincode { get; set; }
        public string phno { get; set; }
        public string email { get; set; }
        public string comments { get; set; }
        public string wesite { get; set; }
        public string Address { get; set; }
        public string Status { get; set; }
    }
    //**************************************************update publisher*************************************************
    [WebMethod]
    public static int updatePublisher(string ePublishername, string eCompany, string eAddress, string eCity, string eState, string ePostal, string eTelephone, string eEmail,string eComments, string eWebsite, string eActive, string publisherid)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[14];
        param[0] = new SqlParameter("@publisher_id", publisherid);
        param[1] = new SqlParameter("@pub_Name", ePublishername.Replace("~", "'"));
        param[2] = new SqlParameter("@Company_name", eCompany.Replace("~", "'"));
        param[3] = new SqlParameter("@address", eAddress.Replace("~", "'"));
        param[4] = new SqlParameter("@intResult", "0");
        param[4].Direction = ParameterDirection.Output;
        param[5] = new SqlParameter("@mode", 4);
        param[6] = new SqlParameter("@city", eCity.Replace("~", "'"));
        param[7] = new SqlParameter("@state", eState.Replace("~", "'"));
        param[8] = new SqlParameter("@postalCode", ePostal.Replace("~", "'"));
        param[9] = new SqlParameter("@phone", eTelephone.Replace("~", "'"));
        param[10] = new SqlParameter("@email", eEmail.Replace("~", "'"));
        param[11] = new SqlParameter("@comments", eComments.Replace("~", "'"));
        param[12] = new SqlParameter("@websites", eWebsite.Replace("~", "'"));
        param[13] = new SqlParameter("@status", eActive);
        int result = objdut.ExecuteSqlSP(param, "usp_Publisher_master");
        return result;
    }
}
    
