using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Fee_Management_EnrolledStudents : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        fillfyear();
    }
    private CommonClass CommonClass = new CommonClass();
    public void fillfyear()
    {
        DataTable Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
        ddlfinancialyear.Enabled = false;
    }

    [WebMethod]
    public static GetOverDueFeeDetails[] BindGrid(int Fyid,string ClassId, string sectionId,string fromDate, string toDate,int status)
    {
        CommonClass CClass = new CommonClass();
        int ActiveFinancialyear = CClass.GetActiveAcedmicYear();
        List<GetOverDueFeeDetails> Details = new List<GetOverDueFeeDetails>();
        DataUtility objdut = new DataUtility();

        SqlParameter[] param = new SqlParameter[8];
        param[0] = new SqlParameter("@Fyid", Fyid);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@PaymentStatusId", status);
        param[3] = new SqlParameter("@ClassId", ClassId);
        param[4] = new SqlParameter("@sectionId", sectionId);
        param[5] = new SqlParameter("@fromDate", fromDate);
        param[6] = new SqlParameter("@toDate", toDate);
        param[7] = new SqlParameter("@StuRegNo", 0);
        
        string query = "exec SP_GettEnrolledStudentByMonth";
        
        DataSet dt = objdut.GetDataSetSP(param, "SP_GettEnrolledStudentByMonth");
        if (dt.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow Dtrow in dt.Tables[0].Rows)
            {
                GetOverDueFeeDetails user = new GetOverDueFeeDetails();
                user.Name = Dtrow["Name"].ToString();
                user.Mobile = Dtrow["Mobile"].ToString();
                user.Sturegno = Dtrow["StuRegNo"].ToString();
                user.Parent = Dtrow["ParentName"].ToString();
                user.ClassName = Dtrow["Classname"].ToString();
                user.ClassId = Dtrow["ClassId"].ToString();
                user.sectionId = Dtrow["sectionId"].ToString();
                user.section = Dtrow["sectionname"].ToString();
                Details.Add(user);
            }
        }
        return Details.ToArray();
    }

    private static bool checkIsNeedToAdd(int status, string isEnrolled)
    {
        if (status == 0)
        {
            return true;
        }
        if (status == 1)
        {
            if (isEnrolled == "0")
            {
                return true;
            }
        }
        if (status == 2)
        {
            if (isEnrolled == "1")
            {
                return true;
            }
        }
        return false;
    }

    [WebMethod]
    public static int ViewAdmitCard(string rolls)
    {
        HttpContext.Current.Session["RegList"] = null;
        DataTable dtReg = new DataTable();
        dtReg.Columns.Add("regno");
        dtReg.Columns.Add("rollno");
        dtReg.Columns.Add("ResultTerm");
        HttpContext.Current.Session["AdmitFromDate"] = "";
        HttpContext.Current.Session["AdmitToDate"] = "";
        foreach (string str in rolls.Split(','))
        {
            if(!string.IsNullOrWhiteSpace(str))
            {
                DataRow dr = dtReg.NewRow();
                dr["regno"] = str.ToString().Trim();
                dr["rollno"] = "";
                dr["ResultTerm"] = 1;
                dtReg.Rows.Add(dr);
                dtReg.AcceptChanges();
            }           
        }
        if (dtReg.Rows.Count > 0)
        {
            HttpContext.Current.Session["RegList"] = dtReg;
        }
        return 1;
    }
    public class GetOverDueFeeDetails
    {

        public string Name { get; set; }
        public string Mobile { get; set; }
        public string Sturegno { get; set; }
        public string Parent { get; set; }
        public string ClassName { get; set; }
        public string ClassId { get; set; }
        public string section { get; set; }
        public string sectionId { get; set; }
        public string Amount { get; set; }
        public string PayDate { get; set; }
        public string Receiptno { get; set; }
        public string brid { get; set; }
    }
}