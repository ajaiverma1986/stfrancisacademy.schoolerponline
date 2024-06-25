using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class HO_rollnumber_create : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

   

    [WebMethod]
    public static string getroollnumber()
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[1].Direction = ParameterDirection.Output;
        string rollnum = objdut.GetScalerSP(param, "[usp_Add_Name]").ToString();
        return rollnum;
    }

   

    [WebMethod]
    public static int updaterollnumber(string roallnumins, string digit, string date, string mode, string rollnumbertype, string serial)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[7];
        param[0] = new SqlParameter("@mode", mode);
        param[1] = new SqlParameter("@rollnumberinitial", roallnumins.Replace("~","'"));
        param[2] = new SqlParameter("@rollnumberdigit", digit);
        param[3] = new SqlParameter("@adddate", date);
        param[4] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[4].Direction = ParameterDirection.Output;
        param[5] = new SqlParameter("@branchorsolo", rollnumbertype);
        param[6] = new SqlParameter("@serial", serial);
        int a = objdut.ExecuteSqlSP(param, "usp_Add_Name");
        return a;
    }

    [WebMethod]
    public static int updatebranchrollnumber(string brid, string inhial, string noofdigit, string isfinicialyear, string brcode, string rollnumbertype, string serialtype)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[8];
        param[0] = new SqlParameter("@brid", brid);
        param[1] = new SqlParameter("@inhial", inhial.Replace("~", "'"));
        param[2] = new SqlParameter("@noofdigit", noofdigit);
        param[3] = new SqlParameter("@isfinicialyear", isfinicialyear);
        param[4] = new SqlParameter("@intResult", SqlDbType.Int, 4);
        param[4].Direction = ParameterDirection.Output;
        param[5] = new SqlParameter("@brcode", brcode);
        param[6] = new SqlParameter("@rollnumbertype", rollnumbertype);
        param[7] = new SqlParameter("@serialtype", serialtype);
        int result = objdut.ExecuteSqlSP(param, "usp_addrollnumber");
        return result;
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
            result.Add(user);
        }
        return result.ToArray();
    }

    public class branchdetails
    {
        public string brid { get; set; }

        public string brcode { get; set; }

        public string brname { get; set; }
    }

    [WebMethod]
    public static branchrollnumber[] getbranchwiserollnumberts()
    {
        DataUtility objdut = new DataUtility();
        List<branchrollnumber> result = new List<branchrollnumber>();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 8);
        DataTable dt = objdut.GetDataTableSP(param, "[usp_Add_Name]");
        foreach (DataRow dtrow in dt.Rows)
        {
            branchrollnumber user = new branchrollnumber();
            user.brid = dtrow["BrId"].ToString();
            user.initial = dtrow["initial"].ToString();
            user.is_finicialyear = dtrow["is_finicialyear"].ToString();
            user.noofdigits = dtrow["noofdigits"].ToString();
            result.Add(user);
        }
        return result.ToArray();
    }

    public class branchrollnumber
    {
        public string brid { get; set; }

        public string initial { get; set; }

        public string is_finicialyear { get; set; }

        public string noofdigits { get; set; }
    }

    [WebMethod]
    public static int checkbrcode(string brcode)
    {
        DataUtility objdut = new DataUtility();
        int result = 0;
        if (brcode != "")
        {
            result = Convert.ToInt32(objdut.GetScalar("select COUNT(1) from tbl_rollnumberpattern where brcode='" + brcode + "'"));
        }
        else
        {
            result = 0;
        }
        return result;
    }
}