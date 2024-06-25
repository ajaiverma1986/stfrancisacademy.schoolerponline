using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_StudentManagement_student_idcard : System.Web.UI.Page
{
    private DataUtility Objdut = new DataUtility();
    private DataTable dt = new DataTable();
    private string url;
    private CommonClass CommonClass = new CommonClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindddl();
        }
    }
    public class GetStatusDetails
    {

        public string Name { get; set; }

        public string AdmissionNo { get; set; }

        public string Registration_No { get; set; }

        public string Mobile { get; set; }

        public string StudentPhotograph { get; set; }

        public string Classname { get; set; }

        public string FYName { get; set; }

        public string BranchAdress { get; set; }

        public string BranchMobileNo { get; set; }

        public string EmailId { get; set; }

        public string StudentDob { get; set; }

        public string Logo { get; set; }

        public string pagecount { get; set; }

    }
    [WebMethod]
    public static GetStatusDetails[] BindGridByJs(string fyid, string classid, string AdmissionNo, string Mobileno, string Name, string pagesize, string pageno)
    {
        DataSet Ds = new DataSet();
        List<GetStatusDetails> StatusDetails = new List<GetStatusDetails>();
        SqlParameter[] param = new SqlParameter[8];
        DataUtility Objdut = new DataUtility();
        param[0] = new SqlParameter("@Fyid", fyid);
        param[1] = new SqlParameter("@ClassID", classid);
        param[2] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[3] = new SqlParameter("@Pagesize", pagesize);
        param[4] = new SqlParameter("@Pageno", pageno);
        param[5] = new SqlParameter("@AdmissionNo", AdmissionNo);
        param[6] = new SqlParameter("@FatherMobileno", Mobileno);
        param[7] = new SqlParameter("@StudentName", Name);
        Ds = Objdut.GetDataSetSP(param, "[usp_fetchidCard]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                GetStatusDetails user = new GetStatusDetails();
                user.Name = dtrow["Name"].ToString();
                user.AdmissionNo = dtrow["AdmissionNo"].ToString();
                user.Registration_No = dtrow["Registration_No"].ToString();
                user.Mobile = dtrow["Mobile"].ToString();
                user.StudentPhotograph = dtrow["StudentPhotograph"].ToString();
                user.Classname = dtrow["Classname"].ToString();
                user.FYName = dtrow["FYName"].ToString();
                user.BranchAdress = dtrow["BranchAdress"].ToString();
                user.BranchMobileNo = dtrow["BranchMobileNo"].ToString();
                user.EmailId = dtrow["EmailId"].ToString();
                user.StudentDob = dtrow["StudentDob"].ToString();
                user.Logo = dtrow["Logo"].ToString();
                user.pagecount = Ds.Tables[1].Rows[0]["pages"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }
    protected void bindddl()
    {
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
}