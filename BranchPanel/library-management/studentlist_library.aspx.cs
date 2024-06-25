using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_library_management_studentlist_library : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    //******************************************************get booklist***************************************

    [WebMethod]
    public static studenntlist[] fillstudentlist(string classid, string studentname, string Admissionno, string librarycard, string memberstatus)
    {
        DataSet ds = new DataSet();
        List<studenntlist> details = new List<studenntlist>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[8];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@intResult", 0);
        param[1].Direction = ParameterDirection.Output;
        param[2] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        param[3] = new SqlParameter("@classid", classid);
        param[4] = new SqlParameter("@studentname", studentname);
        param[5] = new SqlParameter("@Admissionno", Admissionno);
        param[6] = new SqlParameter("@librarycard", librarycard);
        param[7] = new SqlParameter("@memberstatus", memberstatus);
        ds = ObjDUT.GetDataSetSP(param, "Usp_book_search");

        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                studenntlist user = new studenntlist();
                user.rownumber = dtrow["rownumber"].ToString();
                user.name = dtrow["Student_name"].ToString();
                user.classname = dtrow["class_name"].ToString();
                user.Admissionno = dtrow["Admission_No"].ToString();
                user.librarycardno = dtrow["Librarycardno"].ToString();
                user.sturegno = dtrow["sturegno"].ToString();
                user.ismember = dtrow["Student_status"].ToString();
                details.Add(user);
            }
        }
        return details.ToArray();
    }

    public class studenntlist
    {
        public string rownumber { get; set; }
        public string name { get; set; }
        public string classname { get; set; }
        public string Admissionno { get; set; }
        public string librarycardno { get; set; }
        public string sturegno { get; set; }
        public string ismember { get; set; }
    }

    //**********************************************bindclass************************************************************
    [WebMethod]
    public static getclassddl[] Bindclass()
    {
        List<getclassddl> Details = new List<getclassddl>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 4);
        param[1] = new SqlParameter("@intResult", 0);
        param[1].Direction = ParameterDirection.Output;
        param[2] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        Dt = Objdut.GetDataTableSP(param, "[Usp_book_search]");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                getclassddl obje = new getclassddl();
                obje.id = Convert.ToInt32(Dt.Rows[i]["classid"]);
                obje.classname = Convert.ToString(Dt.Rows[i]["Classname"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }

    public class getclassddl
    {
        public int id { get; set; }
        public string classname { get; set; }
    }
    //*******************************************************deactivate student*************************************************************************************

    [WebMethod]
    public static int deactivatestudent(string sturegnofordeactivate)
    {
        SqlParameter[] param = new SqlParameter[4];
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_book_search]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                param[0] = new SqlParameter("@sturegno", sturegnofordeactivate);
                param[1] = new SqlParameter("@mode",5);
                param[2] = new SqlParameter("@intresult", 0);
                param[2].Direction = ParameterDirection.Output;
                param[3] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);

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
    //*******************************************************Activate student*************************************************************************************

    [WebMethod]
    public static int Activatestudent(string sturegnofordeactivate)
    {
        SqlParameter[] param = new SqlParameter[4];
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[Usp_book_search]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                param[0] = new SqlParameter("@sturegno", sturegnofordeactivate);
                param[1] = new SqlParameter("@mode", 6);
                param[2] = new SqlParameter("@intresult", 0);
                param[2].Direction = ParameterDirection.Output;
                param[3] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);

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