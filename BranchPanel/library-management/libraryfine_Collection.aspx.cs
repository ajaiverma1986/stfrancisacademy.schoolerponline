using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_library_management_libraryfine_Collection : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static bookfinelist[] fillfinelist(string fyid)
    {
        DataSet ds = new DataSet();
        List<bookfinelist> details = new List<bookfinelist>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@intResult", 0);
        param[1].Direction = ParameterDirection.Output;
        param[2] = new SqlParameter("@Brid", HttpContext.Current.Session["Brbrid"]);
        param[3] = new SqlParameter("@fyid", fyid);
        ds = ObjDUT.GetDataSetSP(param, "[Usp_Book_Return]");

        if (ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in ds.Tables[0].Rows)
            {
                bookfinelist user = new bookfinelist();
                user.rownumber = dtrow["rownumber"].ToString();
                user.StudentName = dtrow["Student_Name"].ToString();
                user.AdmissionNo = dtrow["AdmissionNo"].ToString();
                user.Librarycard = dtrow["library_Card_No"].ToString();
                user.classname = dtrow["Classname"].ToString();
                user.paidfine = dtrow["Paid_fine_Amount"].ToString();
                details.Add(user);
            }
        }
        return details.ToArray();
    }

    public class bookfinelist
    {
         public string rownumber { get; set; }
        public string StudentName{ get; set; }
        public string AdmissionNo{ get; set; }
        public string Librarycard { get; set; }
        public string classname { get; set; }
        public string paidfine { get; set; }
        
    }
    //*******************************************************for session or fyid**********************************************************************
    [WebMethod]
    public static getsession[] bindsession()
    {
        List<getsession> Details = new List<getsession>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@whyCall", "GetAcademicYearDDL");
        Dt = Objdut.GetDataTableSP(param, "MasterProc");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                getsession obje = new getsession();
                obje.id = Convert.ToInt32(Dt.Rows[i]["fyid"]);
                obje.session = Convert.ToString(Dt.Rows[i]["FYName"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }

    public class getsession
    {
        public int id { get; set; }

        public string session { get; set; }
    }

}