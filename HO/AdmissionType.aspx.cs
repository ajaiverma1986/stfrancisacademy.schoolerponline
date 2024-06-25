using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HO_AdmissionType : System.Web.UI.Page
{
    private static DataUtility objdut = new DataUtility();

    private static SqlParameter[] param;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static List<AdmissionTypes> BindAdmTypelist(int Mode, int AdmTypeId, string AdmType, int IsActive)
    {
        List<AdmissionTypes> admissionTypes = new List<AdmissionTypes>();
        DataSet ds = new DataSet();
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@Mode", Convert.ToInt32(Mode));
        param[1] = new SqlParameter("@AdmTypeId", Convert.ToInt32(AdmTypeId));
        param[2] = new SqlParameter("@AdmType", Convert.ToString(AdmType));
        param[3] = new SqlParameter("@IsActive", IsActive);
        ds = objdut.GetDataSetSP(param, "USP_AdmissionList");
        if (ds.Tables.Count > 0)
        {
            var dt = ds.Tables[0];
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                AdmissionTypes admissionType = new AdmissionTypes();
                admissionType.AdmTypeID = Convert.ToInt32(dt.Rows[i]["AdmTypeID"]);
                admissionType.AdmType = Convert.ToString(dt.Rows[i]["AdmType"]);
                admissionType.Classname = Convert.ToString(dt.Rows[i]["Classname"]);
                admissionType.IsActive = Convert.ToInt32(dt.Rows[i]["IsActive"]);
                admissionTypes.Add(admissionType);
            }
        }
        return admissionTypes.ToList();
    }
    [WebMethod]
    public static int addOrUpdateAdmTypeFeeHeadList(int Fyid, int Brid, int ClassId, int AdmTypeId, string FeeHeadIds, string DiscountTypeIds, string DiscountRates)
    {
        int result = 0, totalCount = 0;
        DataUtility objdut = new DataUtility();
        var FeeHeadIdArr = FeeHeadIds.Split('~');
        var DiscountTypeIdArr = DiscountTypeIds.Split('~');
        var DiscountRateArr = DiscountRates.Split('~');
        if (FeeHeadIdArr.Length > 1)
        {
            for (int i = 0; i < FeeHeadIdArr.Length; i++)
            {
                int FeeHeadId = 0;
                decimal DiscountRate = 0;
                int DiscountTypeId = 0;

                int.TryParse(Convert.ToString(FeeHeadIdArr[i]), out FeeHeadId);
                decimal.TryParse(Convert.ToString(DiscountRateArr[i]), out DiscountRate);
                int.TryParse(Convert.ToString(DiscountTypeIdArr[i]), out DiscountTypeId);

                if (FeeHeadId > 0 && DiscountTypeId > 0)
                {
                    SqlParameter[] param = new SqlParameter[8];
                    param[0] = new SqlParameter("@Fyid", Convert.ToInt32(Fyid));
                    param[1] = new SqlParameter("@Brid", Convert.ToInt32(Brid));
                    param[2] = new SqlParameter("@CLassId", Convert.ToString(ClassId));
                    param[3] = new SqlParameter("@AdmTypeId", Convert.ToString(AdmTypeId));
                    param[4] = new SqlParameter("@FeeHeadId", FeeHeadId);
                    param[5] = new SqlParameter("@DiscountRate", DiscountRate);
                    param[6] = new SqlParameter("@DiscountTypeId", DiscountTypeId);
                    param[7] = new SqlParameter("@intResult", 0);
                    param[7].Direction = ParameterDirection.Output;
                    var intResult = objdut.ExecuteSqlSP(param, "USP_AdmissionTypeFeeHead");
                    if (intResult > 0)
                    {
                        totalCount = totalCount + 1;
                    }
                    if (totalCount == (FeeHeadIdArr.Length - 1))
                    {
                        result = 1;
                    }
                }
            }
        }
        return result;
    }

    [WebMethod]
    public static int addOrUpdateAdmType(int Fyid, int Mode, int AdmTypeId, string AdmType, int IsActive)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[6];
        param[0] = new SqlParameter("@Mode", Convert.ToInt32(Mode));
        param[1] = new SqlParameter("@AdmTypeId", Convert.ToInt32(AdmTypeId));
        param[2] = new SqlParameter("@AdmType", Convert.ToString(AdmType));
        param[3] = new SqlParameter("@IsActive", IsActive);
        param[4] = new SqlParameter("@Fyid", Fyid);
        param[5] = new SqlParameter("@intResult", 0);
        param[5].Direction = ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, "USP_AdmissionType");
        return result;
    }
    [WebMethod]
    public static List<csFinancialYear> getFinancialYears()
    {
        IList<csFinancialYear> csFinancialYears = new List<csFinancialYear>();
        DataTable Dt = Dll("GetAcademicYearDDL");
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                csFinancialYear csFyidYear = new csFinancialYear();
                csFyidYear.Fyid = Convert.ToInt32(Dt.Rows[i]["fyid"]);
                csFyidYear.FYName = Convert.ToString(Dt.Rows[i]["FYName"]);
                int ActiveFinancialyear = GetActiveAcedmicYear();
                csFyidYear.CurrentFyid = ActiveFinancialyear;
                csFinancialYears.Add(csFyidYear);
            }
        }
        return csFinancialYears.ToList();
    }
    [WebMethod]
    public static csBranch[] BindBranchDDL()
    {
        DataUtility Objdut = new DataUtility();
        DataTable Dt = new DataTable();
        string str = @"Select BrId,BrName from Branch_master where isActive=1";
        Dt = Objdut.GetDataTable(str);
        List<csBranch> BindObj = new List<csBranch>();
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            csBranch Obj = new csBranch();
            Obj.Brid = Dt.Rows[i]["BrId"].ToString();
            Obj.BrName = Dt.Rows[i]["BrName"].ToString();
            BindObj.Add(Obj);
        }
        return BindObj.ToArray();
    }
    [WebMethod]
    public static BIndClass[] BindClassDDL(string Fyid, string Brid)
    {
        DataUtility Objdut = new DataUtility();
        DataTable Dt = new DataTable();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 5);
        param[1] = new SqlParameter("@fyid", Fyid);
        param[2] = new SqlParameter("@brid", Brid);
        Dt = Objdut.GetDataTableSP(param, "Usp_Class");
        List<BIndClass> BindObj = new List<BIndClass>();
        if (Dt.Rows.Count > 0) {
            string[] selectedColumns = new[] { "id", "Classname" };
            Dt = new DataView(Dt).ToTable(true, selectedColumns);
        }
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            BIndClass Obj = new BIndClass();
            Obj.ID = Dt.Rows[i]["id"].ToString();
            Obj.ClassName = Dt.Rows[i]["Classname"].ToString();
            BindObj.Add(Obj);
        }
        return BindObj.ToArray();
    }
    [WebMethod]
    public static csFeHead[] BindFeeHeadList(string ClassId, string Brid, string Fyid)
    {
        List<csFeHead> BindObj = new List<csFeHead>();
        DataTable Dt;
        DataUtility Objdut = new DataUtility();
        string query = @"select Distinct f1.id as FeeHeadId,f1.feename,f2.Feename as Maintype,Cfid,Classname,cm.Fees--,ISNULL(ATD.DiscountRate,0) DiscountRate,ISNULL(ATD.DiscountType,0) DiscountTypeId
                            from classfee_master cm inner join feestructure f1  
                            inner join feestructure f2 on f1.Feesubtype=f2.id on  cm.Feeid=f1.Id
                            --LEFT OUTER JOIN AdmissionTypeDT ATD ON ATD.FeeHeadId = f1.id and ATD.ClassId = cm.Classid
                            where Cm.Brid=" + Brid + " and cm.Classid=" + ClassId + " and Cm.status=1 " +
                        "and Feeid not in(select id from feestructure where Feesubtype=0) and Cm.fyid=" + Fyid;
        Dt = Objdut.GetDataTable(query);
        
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            csFeHead Obj = new csFeHead();
            Obj.FeeHeadId = Convert.ToInt32(Dt.Rows[i]["FeeHeadId"]);
            Obj.Cfid = Convert.ToInt32(Dt.Rows[i]["Cfid"]);
            Obj.feename = Dt.Rows[i]["feename"].ToString();
            Obj.Fees = Dt.Rows[i]["Fees"].ToString();
            Obj.Maintype = Dt.Rows[i]["Maintype"].ToString();

            var DiscountRate = Convert.ToString(objdut.GetScalar(@"Select ISNULL(DiscountRate,0) from AdmissionTypeDT where Classid=" + ClassId + " and Brid=" + Brid + " and Fyid=" + Fyid + " and FeeHeadId=" + Obj.FeeHeadId + ""));
            var DiscountTypeId = Convert.ToString(objdut.GetScalar(@"Select ISNULL(DiscountType,0) from AdmissionTypeDT where Classid=" + ClassId + " and Brid=" + Brid + " and Fyid=" + Fyid + " and FeeHeadId=" + Obj.FeeHeadId + ""));

            Obj.DiscountRate = string.IsNullOrWhiteSpace(DiscountRate) ? "0" : DiscountRate;
            Obj.DiscountTypeId = string.IsNullOrWhiteSpace(DiscountTypeId) ? "1" : DiscountTypeId;
            BindObj.Add(Obj);
        }
        return BindObj.ToArray();
    }
    private static DataTable Dll(string p)
    {
        string str = @"select * from financial_Year";
        DataTable dt = objdut.GetDataTable(str);
        return dt;
    }

    private static int GetActiveAcedmicYear()
    {
        string str = @"select ISNULL(FYID,0) FYID from financial_Year where IsActive=1";        
        int result = Convert.ToInt32(objdut.GetScalar(str));
        return result;
    }
}

public class csFeHead
{
    public int Cfid { set; get; }
    public string feename { set; get; }
    public string Maintype { set; get; }
    public string DiscountRate { get; set; }
    public int FeeHeadId { get; set; }
    public string DiscountTypeId { get; set; }
    public string Fees { get; set; }
}

public class csBranch
{
    public string Brid { get; set; }
    public string BrName { get; set; }
}

public class BIndClass
{
    public string ID { get; set; }
    public string ClassName { get; set; }
}

public class csFinancialYear
{
    public int Fyid { set; get; }
    public string FYName { set; get; }
    public int CurrentFyid { set; get; }
}