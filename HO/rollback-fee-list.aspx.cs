using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HO_rollback_fee_list : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    DataUtility obj = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindDdl();
        }
    }
    protected void BindDdl()
    {
        DataTable Dt = CommonClass.Dll("GetAcademicYearDDL");
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinacialyearforsearching.DataSource = Dt;
        ddlfinacialyearforsearching.DataValueField = "fyid";
        ddlfinacialyearforsearching.DataTextField = "FYName";
        ddlfinacialyearforsearching.DataBind();
        ddlfinacialyearforsearching.SelectedValue = Convert.ToString(ActiveFinancialyear);
        DataTable dt = new DataTable();
        dt = obj.GetDataTable("select Brid,BrName from Branch_master where BrActive=1 and isDeleted=0 and isActive=1");
        if (dt.Rows.Count > 0)
        {
            ddlbranch.DataSource = dt;
            ddlbranch.DataValueField = "Brid";
            ddlbranch.DataTextField = "BrName";
            ddlbranch.DataBind();
        }
        ddlbranch.Items.Insert(0, new ListItem("--Select Branch--", "0"));
        
    }
    [WebMethod]
    public static GetadmissionDetails[] BindGridByJs(string name, string stmob, string classid, string frdate, string todate, string pagesize, string pageno, string fyid,string brid)
    {
        DataSet Ds = new DataSet();
        List<GetadmissionDetails> Details = new List<GetadmissionDetails>();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[9];
        Param[0] = new SqlParameter("@Name", name);
        Param[1] = new SqlParameter("@Mobile", stmob);
        Param[2] = new SqlParameter("@RollbackFromDate", frdate);
        Param[3] = new SqlParameter("@RollbackToDate", todate);
        Param[4] = new SqlParameter("@pagesize", pagesize);
        Param[5] = new SqlParameter("@pageno", pageno);
        Param[6] = new SqlParameter("@classid", classid);
        Param[7] = new SqlParameter("@Brid", brid);
        Param[8] = new SqlParameter("@fyid", fyid);
        Ds = Objdut.GetDataSetSP(Param, "[Usp_BindRollBackDetails]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                GetadmissionDetails user = new GetadmissionDetails();
                user.Reciptno = dtrow["Reciptno"].ToString();
                user.AdmissionNo = dtrow["AdmissionNo"].ToString();
                user.Name = dtrow["Name"].ToString();
                user.RollbackDate = dtrow["RollbackDate"].ToString();
                user.RollbackedByUserName = dtrow["RollbackedByUserName"].ToString();
                user.Classname = dtrow["Classname"].ToString();
                user.InstallmentAmount = dtrow["InstallmentAmount"].ToString();
                user.MobileNo = dtrow["MobileNo"].ToString();
                user.SystemName = dtrow["SystemName"].ToString();
                user.pagecount = Ds.Tables[1].Rows[0]["pages"].ToString();
                Details.Add(user);
            }
        }
        return Details.ToArray();
    }

    public class GetadmissionDetails
    {
        public string Reciptno { get; set; }

        public string AdmissionNo { get; set; }

        public string RollbackDate { get; set; }

        public string RollbackedByUserName { get; set; }

        public string Classname { get; set; }

        public string InstallmentAmount { get; set; }

        public string Name { get; set; }

        public string MobileNo { get; set; }

        public string pagecount { get; set; }

        public string SystemName { get; set; }
    }

    [WebMethod]
    public static int pageredirect(string scid, string stuid)
    {
        HttpContext.Current.Session["scid"] = scid;
        HttpContext.Current.Session["StudID"] = stuid;
        if (HttpContext.Current.Session["scid"] != null && HttpContext.Current.Session["StudID"] != null)
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }

    [WebMethod]
    public static getclass[] bindclass(string fyid,string brid)
    {
        List<getclass> Details = new List<getclass>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@brid", brid);
        param[2] = new SqlParameter("@fyid", fyid);
        Dt = Objdut.GetDataTableSP(param, "Usp_Class");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                getclass obje = new getclass();
                obje.classid = Convert.ToInt32(Dt.Rows[i]["classid"]);
                obje.Classname = Convert.ToString(Dt.Rows[i]["Classname"]);
                Details.Add(obje);
            }
        }
        return Details.ToArray();
    }

    public class getclass
    {
        public int classid { get; set; }

        public string Classname { get; set; }
    }

    
}