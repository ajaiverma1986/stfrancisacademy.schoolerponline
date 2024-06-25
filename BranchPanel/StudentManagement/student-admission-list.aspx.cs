using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_StudentManagement_student_admission_list : System.Web.UI.Page
{
    DataUtility ObjDut = new DataUtility();
    CommonClass CommonClass = new CommonClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        //dfBrid.Value = Session["BrBrid"].ToString();
        if (Request.QueryString.Count > 0)
        {
            Session["StuRegNo"] = Request.QueryString[0];
        }
        if (Session["StuRegNo"] == null || Convert.ToInt32(Session["StuRegNo"]) == 0)
        {
            Response.Redirect("student-list.aspx");
        }
        if (!IsPostBack)
        {
            BindClass();
            fillfyear();
        }
    }
    public void fillfyear()
    {
        DataTable Dt = ObjDut.GetDataTable("Select * from financial_Year");
        if (Dt.Rows.Count > 0)
        {
            ddlprmotBrid.DataSource = Dt;
            ddlprmotBrid.DataValueField = "fyid";
            ddlprmotBrid.DataTextField = "FYName";
            ddlprmotBrid.DataBind();
            ddlprmotBrid.Items.Insert(0, new ListItem("-Select Session-", "0"));
            int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
            ddlprmotBrid.SelectedValue = Convert.ToString(ActiveFinancialyear);
        }
    }
    public void BindClass()
    {
        DataTable Dt = new DataTable();
        CommonClass CommonClass = new CommonClass();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ActiveFinancialyear), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        if (Dt.Rows.Count > 0)
        {
            ddlprmotclas.DataSource = Dt;
            ddlprmotclas.DataTextField = "Classname";
            ddlprmotclas.DataValueField = "classid";
            ddlprmotclas.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlprmotclas.Items.Insert(0, li);
        }
    }
    [WebMethod]
    public static int TerminateStudent(string Comment, string val)
    {
        DataUtility Objdut = new DataUtility();
        int result = 0;
        if (val == "1")
        {
            result = Objdut.ExecuteSql("update tbl_StudentAdmissionMaster set IsTerminated=1 where SturegNo='" + Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]) + "'");
        }
        else
        {
            result = Objdut.ExecuteSql("update tbl_StudentAdmissionMaster set IsCompleted=1 where SturegNo='" + Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]) + "'");
        }

        if (result > 0)
        {
            string qry = "insert into tbl_StudentStatusChnageDetails(SturegNo,ASAID,StatusChangeByuserId,StatusChangeByUserName,StatusChangeDate,SystemName,IsTerminated,IsTranfered,IsPassout,IsPromoted,Comment,Status) Values (";
            qry = qry + "'" + Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]) + "',null,'" + Convert.ToInt32(HttpContext.Current.Session["BrADID"]) + "','',getdate(),'" + System.Environment.MachineName + "',1,0,0,0,'" + Comment + "',1)";
            if (val == "1")
            {
                result = Objdut.ExecuteSql("update tbl_StudentMaster set IsTerminated=1 where SturegNo='" + Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]) + "'");
            }
            else
            {
                qry = "insert into tbl_StudentStatusChnageDetails(SturegNo,ASAID,StatusChangeByuserId,StatusChangeByUserName,StatusChangeDate,SystemName,IsTerminated,IsTranfered,IsPassout,IsPromoted,Comment,Status) Values (";
                qry = qry + "'" + Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]) + "',null,'" + Convert.ToInt32(HttpContext.Current.Session["BrADID"]) + "','',getdate(),'" + System.Environment.MachineName + "',0,0,1,0,'" + Comment + "',1)";
                result = Objdut.ExecuteSql("update tbl_StudentMaster set IsCompleted=1 where SturegNo='" + Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]) + "'");
            }

            if (result > 0)
            {

                Objdut.ExecuteSql(qry);
            }
        }
        return result;
    }
    [WebMethod]
    public static string CheckActionPermission(int ActionID)
    {
        string str = "Select Count(*) from tbl_actionuserrights where Action_Id=" + ActionID + " and UserId=" + Convert.ToInt32(HttpContext.Current.Session["BrADID"]) + " and IsActive=0";
        DataUtility obj = new DataUtility();
        int Count = (int)(obj.GetScalar(str));
        return Count.ToString();
    }


    [WebMethod]
    public static string BindAdmissionDetails()
    {
        DataSet Ds = new DataSet();
        DataUtility obj = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@Mode", 1);
        param[1] = new SqlParameter("@StuRegNo", Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]));
        Ds = obj.GetDataSetSP(param, "[StudentsAllDetails]");
        return Ds.GetXml().ToString();
    }
    [WebMethod]
    public static string BindStudentDetails()
    {
        DataSet Ds = new DataSet();
        DataUtility obj = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@Mode", 4);
        param[1] = new SqlParameter("@StuRegNo", Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]));
        Ds = obj.GetDataSetSP(param, "[StudentsAllDetails]");
        return Ds.GetXml().ToString();
    }
    [WebMethod]
    public static string BindStudentFeeDetails()
    {
        DataSet Ds = new DataSet();
        DataUtility obj = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@Mode", 5);
        param[1] = new SqlParameter("@StuRegNo", Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]));
        Ds = obj.GetDataSetSP(param, "[StudentsAllDetails]");
        return Ds.GetXml().ToString();
    }
    [WebMethod]
    public static int CheckDue(string StuRegNo, string Fyid)
    {
        DataUtility Objdut = new DataUtility();
        int result = Convert.ToInt32(Objdut.GetScalar("select Count(*) from tbl_StudentAdmissionInstallment where StuRegNo=" + StuRegNo + " and Fyid=" + Fyid + " and PaymentStatusId=1 and brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + " and InstallmentAmount>0"));
        return result;
    }
    [WebMethod]
    public static int CheckPrmFee(string ClassID, string Fyid)
    {
        DataUtility Objdut = new DataUtility();
        int result = Convert.ToInt32(Objdut.GetScalar("Select Count(*) from classfee_master where Classid=" + ClassID + " and brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + " and Fyid=" + Fyid + ""));
        return result;
    }
    [WebMethod]
    public static int UpdateComment(string Fyid, string Comment, string Mode, string PromClassID, string PromSectionID)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[11];
        string PrevFyid = "0";
        PrevFyid = Convert.ToString(Objdut.GetScalar("Select ISNULL(Fyid,0) from tbl_StudentAdmissionMaster Where SturegNo=" + Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]) + " and Brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + ""));
        PrevFyid = PrevFyid != "" ? PrevFyid : "0";

        param[0] = new SqlParameter("@PrevFyid", Convert.ToInt32(PrevFyid));
        param[1] = new SqlParameter("@Sturegno", Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]));
        param[2] = new SqlParameter("@Mode", Convert.ToInt32(Mode));
        param[3] = new SqlParameter("@intresult", SqlDbType.Int);
        param[3].Direction = ParameterDirection.Output;
        param[4] = new SqlParameter("@Comment", Comment.Replace("~", "'"));
        param[5] = new SqlParameter("@StatusChangeByUserId", Convert.ToInt32(HttpContext.Current.Session["BrADID"]));
        param[6] = new SqlParameter("@Brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        param[7] = new SqlParameter("@Systemname", System.Environment.MachineName);
        param[8] = new SqlParameter("@PromClassID", Convert.ToInt32(PromClassID));
        if (PromSectionID.ToString() != "null")
        {
            param[9] = new SqlParameter("@PromSectionID", Convert.ToInt32(PromSectionID));
        }
        else
        {
            param[9] = new SqlParameter("@PromSectionID", Convert.ToInt32(0));
        }
        param[10] = new SqlParameter("@Fyid", Convert.ToInt32(Fyid));
        int result = Objdut.ExecuteSqlSP(param, "[Usp_ChangeStudentStatus]");
        return result;
    }
    [WebMethod]
    public static bindclass[] bindclassFyid(string Fyid)
    {
        List<bindclass> details = new List<bindclass>();
        DataTable dt = new DataTable();
        CommonClass CommonClass = new CommonClass();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        //dt = BLL.getclass(Convert.ToInt16(HttpContext.Current.Session["BrBrid"]));
        dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(Fyid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));

        bindclass objProductMasterDetails0 = new bindclass();
        objProductMasterDetails0.ClassID = Convert.ToInt32("0");
        objProductMasterDetails0.ClassName = "---Select Class---";
        details.Add(objProductMasterDetails0);

        foreach (DataRow dtrow in dt.Rows)
        {
            bindclass objProductMasterDetails = new bindclass();
            objProductMasterDetails.ClassID = Convert.ToInt32(dtrow["classid"].ToString());
            objProductMasterDetails.ClassName = dtrow["Classname"].ToString();
            details.Add(objProductMasterDetails);
        }

        return details.ToArray();
    }

    public class bindclass
    {
        public int ClassID { get; set; }

        public string ClassName { get; set; }
    }
}