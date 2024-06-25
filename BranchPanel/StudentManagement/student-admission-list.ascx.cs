using System;
using System.Data;
public partial class BranchPanel_StudentManagement_student_admission_list : System.Web.UI.UserControl
{
    private int studentid = 0,RID=0;
    private string Query = "";
    private DataUtility objDUT = new DataUtility();
    private int result = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString.Count > 0)
        {
            Session["StuRegNo"] = Request.QueryString[0];
        }
        if (Session["StuRegNo"] == null)
        {
            Response.Redirect("student-list.aspx");
        }
        if (!IsPostBack)
        {
            filstudetail();
        }      
    }
    public void filstudetail()
    {
        Query = "select (case sr.StudentPhotograph when '' then '../../images/9update.png' else ('../../BranchPanel/Student-Registration/student-registration-document/'+sr.StudentPhotograph) end ) as photo,sa.AdmissionNo,(sr.StudentFirstName+' '+sr.StudentMiddleName+' '+sr.StudentLastName) as studentname,ISNULL(CM.Classname,'')+'-'+ISNULL(CS.sectionname,'') class_sectionname,(Case When sr.PrimaryMobileNo='' Then 'N/A' Else sr.PrimaryMobileNo End) As PrimaryMobileNo,sr.Registration_No,sm.RID from tbl_StudentMaster sm INNER JOIN tbl_StudentRegistration sr ON sm.RID=sr.RID and sm.Brid = sr.Brid INNER JOIN tbl_StudentAdmissionMaster sa ON sm.SturegNo=sa.StuRegNo INNER JOIN class_master Cm ON sm.Classid=Cm.Id INNER JOIN classwithsection CS ON CS.cwsid = sa.SectionId where sm.IsActive=1 and sm.SturegNo=" + Session["StuRegNo"] + " and  sm.brid=" + Session["BrBrid"];
        DataTable dt = objDUT.GetDataTable(Query);
        if (dt.Rows.Count > 0)
        {
            lblname.Text = dt.Rows[0]["studentname"].ToString();
            lblAdmissionNo.Text = dt.Rows[0]["AdmissionNo"].ToString();
            lblActiveClass.Text = dt.Rows[0]["class_sectionname"].ToString();
            lblpmobile.Text = dt.Rows[0]["PrimaryMobileNo"].ToString();
            imgstu.ImageUrl = dt.Rows[0]["photo"].ToString();
            hdnregistrationno.Value = dt.Rows[0]["Registration_No"].ToString();
            hdnRID.Value = dt.Rows[0]["RID"].ToString();
            RID = Convert.ToInt32(hdnRID.Value);
            //RID = Convert.ToInt32(Request.Form[hdnRID.UniqueID]);
        }
    }

    protected void btnprofile_Click(object sender, EventArgs e)
    {
        Response.Redirect("student-profile-details.aspx");
    }
    protected void btnadmission_Click(object sender, EventArgs e)
    {
        Response.Redirect("student-admission-list.aspx");
    }
    protected void btnDiscount_Click(object sender, EventArgs e)
    {
        Response.Redirect("student-discount-details.aspx");
    }
    protected void btnTrasport_Click(object sender, EventArgs e)
    {
        Response.Redirect("student-transport-details.aspx");
    }
    protected void btnstudentperformance_Click(object sender, EventArgs e)
    {
        Response.Redirect("student-performance-report.aspx");
    }
    protected void btnbookdetails_Click(object sender, EventArgs e)
    {
        Response.Redirect("student-library-details.aspx");
    }
    protected void btnhostel_Click(object sender, EventArgs e)
    {
        Response.Redirect("student-hostel-details.aspx");
    }
}