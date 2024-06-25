using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Certificates_viewTC1 : System.Web.UI.Page
{
    DataTable dtTC = new DataTable();
    DataUtility ObjDut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["dtTC"] != null)
        {
            dtTC = (DataTable)(Session["dtTC"]);
            if (dtTC.Rows.Count > 0)
            {
                SchoolPic();
                FillDetails();
            }
            EnterTC();
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "Print", "javascript:window.print();", true);
        }
        else
        {
            Response.Redirect("~/BranchPanel/Student-Registration/AddCertificate.aspx");
        }
    }
    public void EnterTC()
    {
        string Str = "";
        int Count = (int)(ObjDut.GetScalar("Select Count(*) FROM tbl_TcVerify Where TCNO='" + dtTC.Rows[0]["TCNo"].ToString() + "'"));
        if (Count == 0)
        {
            Str = "INSERT INTO tbl_TcVerify(TCNO,StdAdmNo,StdRegNo,Count,Brid) Values(@TCNO,@StdAdmNo,@StdRegNo,@Count,@Brid)";
        }
        else
        {
            Count = Count + 1;
            Str = "UPDATE tbl_TcVerify SET StdAdmNo=@StdAdmNo, StdRegNo=@StdRegNo, Count=@Count WHERE TCNO = @TCNO";
        }
        SqlParameter[] Para = new SqlParameter[5];
        Para[0] = new SqlParameter("@TCNO", dtTC.Rows[0]["TCNo"].ToString());
        Para[1] = new SqlParameter("@StdAdmNo", dtTC.Rows[0]["AdmNo"].ToString());
        Para[2] = new SqlParameter("@StdRegNo", dtTC.Rows[0]["StdRegNo"].ToString());
        Para[3] = new SqlParameter("@Count", Count);
        Para[4] = new SqlParameter("@Brid", Convert.ToInt32(Session["BrBrid"]));

        int Result = ObjDut.ExecuteSql(Para, Str);
    }
    public void SchoolPic()
    {
        SchoolName.InnerText = Convert.ToString(ObjDut.GetScalar("select isnull(BrName,'') SchoolName from Branch_master where brid=" + Session["BrBrid"]));
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

        lblAddress.InnerText = address;
        lblPhone.InnerText = Ph.ToString() + " Mob : " + mobile.ToString();
        //  lblMob.Text = mobile.ToString();
        lblEmail.InnerText = EmailID.ToString();
        lblSchoolAffi.Text = SchoolAffi.Trim();
        lblWebsite.InnerText = Website.Trim();
    }
    public void FillDetails()
    {
        SNo.Text = dtTC.Rows[0]["TCNo"].ToString();
        AdmNo.InnerText = dtTC.Rows[0]["AdmNo"].ToString();
        lblStdName.InnerText = dtTC.Rows[0]["SdtName"].ToString();
        lblMname.InnerText = dtTC.Rows[0]["Mname"].ToString();
        lblFname.InnerText = dtTC.Rows[0]["Fname"].ToString();
        lblDob.InnerText = dtTC.Rows[0]["Dob"].ToString();
        lblWDob.InnerText = WrittenNumerics.DateToWritten(Convert.ToDateTime(dtTC.Rows[0]["dob"])).ToString().ToUpper();
        lblNation.InnerText = dtTC.Rows[0]["Nation"].ToString();
        lblCate.Value = dtTC.Rows[0]["Gen"].ToString();
        lblDoa.InnerText = dtTC.Rows[0]["Doa"].ToString();
        lblPrClass.InnerText = dtTC.Rows[0]["Pclass"].ToString();
        lblBorad.InnerText = dtTC.Rows[0]["PSBoard"].ToString();
        lblFail.InnerText = dtTC.Rows[0]["FailClass"].ToString();
        //lblSub.InnerText = dtTC.Rows[0]["Subject"].ToString();
        lblProClass.InnerText = dtTC.Rows[0]["ProClass"].ToString();
        lblDueMonth.InnerText = dtTC.Rows[0]["MonthPaid"].ToString();
        lblCon.InnerText = dtTC.Rows[0]["Conces"].ToString();
        lblTdays.InnerText = dtTC.Rows[0]["Tdays"].ToString();
        lblPdays.InnerText = dtTC.Rows[0]["Pdays"].ToString();
        lblNCC.InnerText = dtTC.Rows[0]["NCC"].ToString();
        lblGames.InnerText = dtTC.Rows[0]["Games"].ToString();
        lblCond.InnerText = dtTC.Rows[0]["Conduct"].ToString();
        lblDoc.InnerText = dtTC.Rows[0]["Dor"].ToString();
        lblDoi.InnerText = dtTC.Rows[0]["Doi"].ToString();
        lblLeave.InnerText = dtTC.Rows[0]["leave"].ToString();
        lblRemark.InnerText = dtTC.Rows[0]["remarks"].ToString();
        lblAdd.InnerText = dtTC.Rows[0]["address"].ToString();
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
}