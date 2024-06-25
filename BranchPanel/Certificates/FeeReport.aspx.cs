using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Certificates_FeeReport : System.Web.UI.Page
{
    DataUtility ObjDut = new DataUtility(); int ID = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        Label5.Text = "Dated:" + DateTime.Now.ToString("dd-MMM-yyyy");


        if (Request.QueryString["RID"] != null)
        {
            ID = Convert.ToInt32(Request.QueryString["RID"]);
            if (!IsPostBack)
            {
                Update(ID);
            }
        }
        SchoolPic();
    }
    public void SchoolPic()
    {
        SchoolName.Text = Convert.ToString(ObjDut.GetScalar("select isnull(BrName,'') SchoolName from Branch_master where brid=" + Session["BrBrid"]));
        string imgsrc = Convert.ToString(ObjDut.GetScalar("select photo from Branch_master where brid=" + Session["BrBrid"]));
        if (imgsrc != "")
        {

            string[] data = imgsrc.Split('^');
            if (data.Length > 0)
            {
                logo.ImageUrl = "~/BranchPanel/images/" + data[0];
            }
            else
            {
                logo.ImageUrl = "~/images/9update.png";
            }
        }
        else
        {
            logo.ImageUrl = "~/images/9update.png";
        }

        string value = "";
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 10);
        value = objdut.GetScalerSP(param, "[usp_general_master_setting]").ToString();
        string[] getdata = value.Split('~');
        string isbranch = getdata[0];
        string address = "", serviceno = "", Ph = "", mobile = "", Contact = "", EmailID = "", tin = "", SchoolAffi = "", Website = "";
        //serviceno = Convert.ToString(objdut.GetScalar("select isnull(Service_tax_no,'') Service_tax_no  from tbl_institutemaster"));
        //tin = Convert.ToString(objdut.GetScalar("select TIN  from tbl_institutemaster"));
        //institutename = Convert.ToString(objdut.GetScalar("select institute_name from tbl_institutemaster"));
        //if (isbranch == "2")
        //{
        string branchdata = Convert.ToString(objdut.GetScalar(@"select BrAddress+','+City+' - '+pincode+', '+state+', '+Country+'^'+
            LandLineNo+','+MobileNo+'^'+Emailid+'^'+isnull(Website,'')+'^'+isnull(SchoolAffi,'') from branch_master where brid = '" + Session["brbrid"] + "'"));
        string[] getbranchdata = branchdata.Split('^');
        address = getbranchdata[0];

        string[] getCont;
        Contact = getbranchdata[1];
        getCont = Contact.Split(',');
        Ph = getCont[0].ToString();
        mobile = getCont[1].ToString();
        EmailID = getbranchdata[2].ToString();
        Website = getbranchdata[3].ToString();
        SchoolAffi = getbranchdata[4].ToString();

        lblAddress.Text = address;
        lblPhone.Text = Ph.ToString() + " Mob : " + mobile.ToString();
        //  lblMob.Text = mobile.ToString();
        lblEmail.Text = EmailID.ToString();
        //lblSchoolAffi.Text = SchoolAffi.Trim();
        lblWebsite.Text = Website.Trim();
    }
    public static class WrittenNumerics
    {
        static readonly string[] ones = new string[] { "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine" };
        static readonly string[] teens = new string[] { "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen" };
        static readonly string[] tens = new string[] { "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety" };
        static readonly string[] thousandsGroups = { "", " Thousand", " Million", " Billion" };

        private static string FriendlyInteger(int n, string leftDigits, int thousands)
        {
            if (n == 0)
                return leftDigits;

            string friendlyInt = leftDigits;
            if (friendlyInt.Length > 0)
                friendlyInt += " ";

            if (n < 10)
                friendlyInt += ones[n];
            else if (n < 20)
                friendlyInt += teens[n - 10];
            else if (n < 100)
                friendlyInt += FriendlyInteger(n % 10, tens[n / 10 - 2], 0);
            else if (n < 1000)
                friendlyInt += FriendlyInteger(n % 100, (ones[n / 100] + " Hundred"), 0);
            else
                friendlyInt += FriendlyInteger(n % 1000, FriendlyInteger(n / 1000, "", thousands + 1), 0);

            return friendlyInt + thousandsGroups[thousands];
        }

        public static string DateToWritten(DateTime date)
        {
            return string.Format("{0} {1} {2}", IntegerToWritten(date.Day), date.ToString("MMMM"), IntegerToWritten(date.Year));
        }

        public static string IntegerToWritten(int n)
        {
            if (n == 0)
                return "Zero";
            else if (n < 0)
                return "Negative " + IntegerToWritten(-n);

            return FriendlyInteger(n, "", 0);
        }
    }
    public void Update(int ID)
    {
        DataTable dtstd = new DataTable();
        DataUtility Objdut = new DataUtility();
        string Usertype = @"Select ISNULL(SR.StudentFirstName,'')+' '+ISNULL(SR.StudentMiddleName,'')+' '+ISNULL(SR.StudentLastName,'') AS 
        StudentName,SR.StudentDOB, CM.Classname from tbl_StudentRegistration SR
                            inner join Class_Master CM on cm.id = SR.ApplyingForClass where SR.RID=" + ID;

        dtstd = Objdut.GetDataTable(Usertype);
        if (dtstd.Rows.Count > 0)
        {
            lblname.Text = dtstd.Rows[0]["StudentName"].ToString();
            lblclass.Text = dtstd.Rows[0]["Classname"].ToString();
            lbldob.Text = Convert.ToDateTime(dtstd.Rows[0]["StudentDOB"]).ToString("dd-MMM-yyyy");
            lbldobw.Text = WrittenNumerics.DateToWritten(Convert.ToDateTime(dtstd.Rows[0]["StudentDOB"])).ToString().ToUpper();
        }
    }
}