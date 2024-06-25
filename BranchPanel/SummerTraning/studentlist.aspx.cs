using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_SummerTraning_studentlist : System.Web.UI.Page
{
    CommonClass CommonClass = new CommonClass();
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
        ddlfinacialyearforsearching.DataSource = Dt;
        ddlfinacialyearforsearching.DataValueField = "fyid";
        ddlfinacialyearforsearching.DataTextField = "FYName";
        ddlfinacialyearforsearching.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinacialyearforsearching.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    public class GetStudent
    {
        public string Sscid { get; set; }
        public string Name { get; set; }
        public string Classname { get; set; }
        public string ParentName { get; set; }
        public string ParentMobile { get; set; }
        public string Address { get; set; }
        public string PaymentMode { get; set; }
        public string PaidFee { get; set; }
        public string BankName { get; set; }
        public string CHKREFDDDate { get; set; }
        public string CHKREFDDREFNo { get; set; }
        public string BranchName { get; set; }
        public string ActivityDate { get; set; }
        public string FeeType { get; set; }
    }

    [WebMethod]
    public static GetStudent[] StudentList(string fyid, string studentname, string classid, string parentname, string parentmobile,string actDate,string payType)
    {

        List<GetStudent> Details = new List<GetStudent>();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[2] = new SqlParameter("@Fyid", fyid);
        param[3] = new SqlParameter("@ACTIVITYDATE", actDate);
        Dt = Objdut.GetDataTableSP(param, "Usp_SummerCamp");
        if (Dt.Rows.Count > 0)
        {

            foreach (DataRow dtRow in Dt.Rows)
            {
                GetStudent obj = new GetStudent();
                obj.Sscid = dtRow["Sscid"].ToString();
                obj.Name = dtRow["StudentFirstName"].ToString() + " " + dtRow["StudentMiddlename"].ToString() + " " + dtRow["StudentLastName"].ToString();
                obj.Classname = dtRow["Classname"].ToString();
                obj.ParentName = dtRow["ParentName"].ToString();
                obj.ParentMobile = dtRow["ParentMobile"].ToString();
                obj.Address = dtRow["ParentAddress"].ToString() + " " + dtRow["ParentCity"].ToString() + " " + dtRow["ParentState"].ToString() + " " + dtRow["ParentPinCode"].ToString();
                obj.PaymentMode = dtRow["PaymentModeName"].ToString();
                obj.PaidFee = dtRow["PaidFee"].ToString();
                obj.ActivityDate = dtRow["ActivityDate"].ToString();
                obj.FeeType=dtRow["FeeType"].ToString();
                Details.Add(obj);
            }
        }
        if (payType != "--Select One--")
        {
            Details = Details.Where(x => x.FeeType == payType).ToList();
        }        
        return Details.ToArray();
    }
}