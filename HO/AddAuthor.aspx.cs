using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class HO_AddAuthor : System.Web.UI.Page
{
    private SqlParameter[] param;
    private DataUtility objDut = new DataUtility();
    private DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

 
    //*********************************************add Author********************************************
    [WebMethod]
    public static int saveAuthordata(string Authorname, string Description, string settingstatus)
    {

        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@id", Convert.ToInt32("0"));
        param[1] = new SqlParameter("@Au_Name", Authorname.Replace("~", "'"));
        param[2] = new SqlParameter("@Description", Description.Replace("~", "'"));
        param[3] = new SqlParameter("@status", settingstatus);
        param[4] = new SqlParameter("@intResult", 0);
        param[4].Direction = ParameterDirection.Output;
        param[5] = new SqlParameter("@mode", 4);
        int result = objdut.ExecuteSqlSP(param, "usp_Auther_Master");
        return result;
    }
    //******************************************************get authorlist***************************************
  
    [WebMethod]
    public static authorlist[] fillauthorlist(string authornamesearch)
    {
        DataSet ds = new DataSet();
        List<authorlist> details = new List<authorlist>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode",1);
        param[1] = new SqlParameter("@intResult", 0);
        param[1].Direction = ParameterDirection.Output;
        param[2] = new SqlParameter("@Au_Name", authornamesearch.Replace("~", "'"));
        ds = ObjDUT.GetDataSetSP(param, "Usp_Auther_Master");

        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                authorlist user = new authorlist();
                user.Authorid = dtrow["authorid"].ToString();
                user.AuthorName = dtrow["Author_Name"].ToString();
                user.Status = dtrow["Active"].ToString();
                details.Add(user);
            }
        }
        return details.ToArray();
    }

    public class authorlist
    {
        public string Authorid { get; set; }
        public string AuthorName { get; set; }
        public string Status { get; set; }

    }
    //********************************************web method for edit*******************************************
    [WebMethod]
    public static Authoredit[] Editdetail(string Authorid)
    {
        DataSet ds = new DataSet();
        List<Authoredit> details = new List<Authoredit>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@authorid",Authorid);
        param[2] = new SqlParameter("@intResult", 0);
        param[2].Direction = ParameterDirection.Output;
        ds = ObjDUT.GetDataSetSP(param, "Usp_Auther_Master");
        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                Authoredit user = new Authoredit();
                user.Authorid = dtrow["au_id"].ToString();
                user.AuthorName = dtrow["Au_Name"].ToString();
                user.Description = dtrow["Description1"].ToString();
                user.Status = dtrow["Active"].ToString();
                details.Add(user);
            }
        }
        return details.ToArray();
    }

    public class Authoredit
    {
        public string Authorid { get; set; }
        public string AuthorName { get; set; }
        public string Description { get; set; }
        public string Status { get; set; }
 }
    //**************************************************update Author*************************************************
    [WebMethod]
    public static int updateauthor(string authorname, string description, string isstatus, string Authorid)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@authorid",Authorid);
        param[1] = new SqlParameter("@Au_Name",authorname.Replace("~", "'"));
        param[2] = new SqlParameter("@Description",description.Replace("~", "'"));
        param[3] = new SqlParameter("@status", isstatus);
        param[4] = new SqlParameter("@intResult", "0");
        param[4].Direction = ParameterDirection.Output;
        param[5] = new SqlParameter("@mode", 3);
        int result = objdut.ExecuteSqlSP(param, "Usp_Auther_Master");
        return result;
    }

    //*******************************************************delete book*************************************************************************************

    [WebMethod]
    public static int deleteAuthor(string Authorid)
    {
        SqlParameter[] param = new SqlParameter[3];
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_Auther_Master]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                param[0] = new SqlParameter("@authorid", Authorid);
                param[1] = new SqlParameter("@mode",5);
                param[2] = new SqlParameter("@intresult", 0);
                param[2].Direction = ParameterDirection.Output;
          

                for (int i = 0; i < param.Length; i++)
                {
                    cmd.Parameters.Add(param[i]);
                }
                cmd.ExecuteNonQuery();
                int ret = Convert.ToInt16(cmd.Parameters["@intresult"].Value);
                return ret;
            }
        }
    }
}