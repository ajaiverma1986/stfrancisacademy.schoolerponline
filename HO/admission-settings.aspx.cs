using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class HO_admission_settings : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();

    protected void Page_Load(object sender, EventArgs e)
    {
        FinacialYear();
    }

    public void FinacialYear()
    {
        DataTable Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }

    [WebMethod]
    public static string SaveData(string TASID, string Fyid, string ActiveProcessId, string AdmissionFromDate, string AdmissionToDate, string FeePayTypeId, string IsProvisionalAdmission, string ProvisionalAdmissionFromDate, string ProvisionalAdmissionTillDate, string RgistrationFromDate, string RegistrationTillDate)
    {
        DataUtility ObjDut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[14];
        Param[0] = new SqlParameter("@TASID", TASID);
        Param[1] = new SqlParameter("@Fyid", Fyid);
        Param[2] = new SqlParameter("@ActiveProcessId", ActiveProcessId);
        Param[3] = new SqlParameter("@AdmissionFromDate", AdmissionFromDate);
        Param[4] = new SqlParameter("@AdmissionToDate", AdmissionToDate);
        Param[5] = new SqlParameter("@FeePayTypeId", FeePayTypeId);
        Param[6] = new SqlParameter("@UserId", HttpContext.Current.Session["ADID"]);
        Param[7] = new SqlParameter("@intresult", SqlDbType.Int);
        Param[7].Direction = ParameterDirection.Output;
        Param[8] = new SqlParameter("@Mode", 1);
        Param[9] = new SqlParameter("@IsProvisionalAdmission", IsProvisionalAdmission);
        Param[10] = new SqlParameter("@ProvisionalAdmissionStartFromDate", ProvisionalAdmissionFromDate);
        Param[11] = new SqlParameter("@ProvisionalAdmissionStartTillDate", ProvisionalAdmissionTillDate);
        Param[12] = new SqlParameter("@RegistrationFromDate", RgistrationFromDate);
        Param[13] = new SqlParameter("@RegistrationTillDate", RegistrationTillDate);
        int IntResult = ObjDut.ExecuteSqlSP(Param, "[Usp_MaganeAdmissionSettings]");
        return ((IntResult > 0 ? (ConfigurationManager.AppSettings["InsertMsg"].ToString())
        : ConfigurationManager.AppSettings["ErrorMessage"].ToString()).ToString());
    }

    [WebMethod]
    public static string BindData(string Fyid)
    {
        DataUtility ObjDut = new DataUtility();
        DataSet Ds;
        SqlParameter[] Param = new SqlParameter[2];
        Param[0] = new SqlParameter("@Fyid", Fyid);
        Param[1] = new SqlParameter("@Mode", 2);
        Ds = ObjDut.GetDataSetSP(Param, "[Usp_MaganeAdmissionSettings]");
        return Ds.GetXml();
    }
}