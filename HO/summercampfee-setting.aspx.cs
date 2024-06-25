using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HO_summercampfee_setting : System.Web.UI.Page
{
    CommonClass CommonClass = new CommonClass();
    DataUtility objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillfyear();
        }
    }
    public void fillfyear()
    {
        DataTable Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        //int ViewState["Fyid"] = CommonClass.GetActiveAcedmicYear();
        ViewState["Fyid"] = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ViewState["Fyid"]);
        DataTable dt = new DataTable();
        dt = objdut.GetDataTable("select Brid,BrName from Branch_master where BrActive=1 and isDeleted=0 and isActive=1");
        if (dt.Rows.Count > 0)
        {
            ddlbranch.DataSource = dt;
            ddlbranch.DataValueField = "Brid";
            ddlbranch.DataTextField = "BrName";
            ddlbranch.DataBind();
        }
        ddlbranch.Items.Insert(0, new ListItem("--Select Branch--", "0"));
    }
    public class GetSummerFee
    {
        public string SCFID { get; set; }
        public string id { get; set; }
        public string Classname { get; set; }
        public string Fee { get; set; }
        public string TaxApplicable { get; set; }
        public string IsActive { get; set; }
    }

    [WebMethod]
    public static GetSummerFee[] FeeDetails(string fyid,string brid)
    {
        List<GetSummerFee> Details = new List<GetSummerFee>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 1);
        param[1] = new SqlParameter("@Brid", brid);
        param[2] = new SqlParameter("@Fyid", fyid);
        Dt = Objdut.GetDataTableSP(param, "Usp_SummerCampFee");
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtRow in Dt.Rows)
            {
                GetSummerFee obj = new GetSummerFee();
                obj.SCFID = dtRow["SCFID"].ToString();
                obj.id = dtRow["id"].ToString();
                obj.Classname = dtRow["Classname"].ToString();
                obj.Fee = dtRow["Fee"].ToString();
                obj.TaxApplicable = dtRow["TaxApplicable"].ToString();
                obj.IsActive = dtRow["IsActive"].ToString();
                Details.Add(obj);
            }
        }
        return Details.ToArray();
    }
    [WebMethod]
    public static int SaveFee(string fyid, string brid, string allclassid, string allfee, string alltaxable, string allactive)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[9];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@Brid", brid);
        param[2] = new SqlParameter("@Fyid", fyid);
        param[3] = new SqlParameter("@Classid", allclassid);
        param[4] = new SqlParameter("@Fee", allfee);
        param[5] = new SqlParameter("@TaxApplicable", alltaxable);
        param[6] = new SqlParameter("@Active", allactive);
        param[7] = new SqlParameter("@Userid", HttpContext.Current.Session["ADID"]);
        param[8] = new SqlParameter("@intresult", SqlDbType.Int);
        param[8].Direction=ParameterDirection.Output;
        int result = Objdut.ExecuteSqlSP(param, "Usp_SummerCampFee");
        return result;
    }
}