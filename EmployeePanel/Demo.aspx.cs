using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class EmployeePanel_Demo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static List<GetClassLIst> BindClass(string classname)
    {
        try
        {
            List<GetClassLIst> objgetclasslist = new List<GetClassLIst>();
            DataUtility objDUT = new DataUtility();
            SqlParameter[] param = new SqlParameter[1];
            param[0] = new SqlParameter("@classname", classname);
            DataTable Dt = objDUT.GetDataTableSP(param, "[usp_BindClass]");
            foreach (DataRow dtrow in Dt.Rows)
            {
                GetClassLIst getclasslist = new GetClassLIst();
                getclasslist.ClassName = dtrow["ClassName"].ToString();
                getclasslist.ClassID = dtrow["id"].ToString();
                objgetclasslist.Add(getclasslist);
            }
            return objgetclasslist;
        }
        catch (Exception ex)
        {
            List<GetClassLIst> objrefofcity = new List<GetClassLIst>();
            return objrefofcity;
        }
    }

    public class GetClassLIst
    {
        public string ClassName { get; set; }

        public string ClassID { get; set; }
    }
}