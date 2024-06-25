using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class BranchPanel_Admission_AdmissionCustomReport : System.Web.UI.Page
{
    private string url, Query, Query1, query2, query3;
    private DataTable dt;
    private double d;
    private NumberToEnglish nme = new NumberToEnglish();
    private DataUtility objdut = new DataUtility();
    private string enrollid = "";
    private Decimal enrollfee = 0, servicetax = 0, educationcess = 0, serLim = 0, CessLim = 0, x = 0;
    private string institutename = "";

    protected void Page_Init(object sender, EventArgs e)
    {
        SchoolName.InnerHtml = Convert.ToString(objdut.GetScalar("select isnull(BrName,'') SchoolName from Branch_master where brid=" + Session["BrBrid"]));
        string imgsrc = Convert.ToString(objdut.GetScalar("select photo from Branch_master where brid=" + Session["BrBrid"]));
        if (imgsrc != "")
        {

            string[] data = imgsrc.Split('^');
            if (data.Length > 0)
            {
                btnlogoforrecipt.ImageUrl = "~/BranchPanel/images/" + data[0];
                btnlogoforrecipt.Style.Add("background", data[0]);
                favicon.Href = "images/" + data[0];

            }
            else
            {
                btnlogoforrecipt.ImageUrl = "~/images/9update.png";
                favicon.Href = "images/9update.png";
            }
        }
        else
        {
            btnlogoforrecipt.ImageUrl = "~/images/9update.png";
            favicon.Href = "images/9update.png";
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        if (!IsPostBack)
        {
            getrecieptgenraldetails();
            if (Request.QueryString.Count > 0)
            {
                string str = CultureInfo.CurrentCulture.NumberFormat.CurrencySymbol;
                enrollid = Request.QueryString[0].ToString();
                if (enrollid != "")
                {
                    ViewState["enrollid"] = enrollid;
                    Receipt(enrollid);
                }
            }
        }
    }

    private void getrecieptgenraldetails()
    {
        string value = "";
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 10);
        value = objdut.GetScalerSP(param, "[usp_general_master_setting]").ToString();
        string[] getdata = value.Split('~');
        string isbranch = getdata[0];
        string address = "", serviceno = "", Ph = "", mobile = "", Contact = "", EmailID = "", tin = "", SchoolAffi = "", Website = "";
        serviceno = Convert.ToString(objdut.GetScalar("select isnull(Service_tax_no,'') Service_tax_no  from tbl_institutemaster"));
        tin = Convert.ToString(objdut.GetScalar("select TIN  from tbl_institutemaster"));
        institutename = Convert.ToString(objdut.GetScalar("select institute_name from tbl_institutemaster"));


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

        spanaddress.Text = address;
        lblcontact.Text = Ph.ToString();
        lblMob.Text = mobile.ToString();
        lblEmailID.Text = EmailID.ToString();
        lblSchoolAffi.Text = SchoolAffi.Trim();
        lblservicetax.Text = Website.Trim();
    }

    protected void Receipt(string RegNo)
    {
        getrecieptgenraldetails();
        DataSet ds = new DataSet();

        DataUtility Objdut = new DataUtility();
        DataTable dtPermission = Objdut.GetDataTableSP("[SP_AdmissionReportpermission]");

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_studentregistrationHistory]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
                param[1] = new SqlParameter("@registrationno", RegNo);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        Registratio_No.InnerText = RegNo;
                        studentname.InnerText = ds.Tables[0].Rows[0]["studentname"].ToString();
                        Classname.InnerHtml = ds.Tables[0].Rows[0]["Classname"].ToString();
                        fathername.InnerHtml = ds.Tables[0].Rows[0]["fathername"].ToString();
                        MobileNo.InnerHtml = ds.Tables[0].Rows[0]["PrimaryMobileNo"].ToString();
                        StudentDOB.InnerHtml = ds.Tables[0].Rows[0]["StudentDOB"].ToString();
                        Gender.InnerHtml = ds.Tables[0].Rows[0]["Gender"].ToString();
                        CountryName.InnerHtml = ds.Tables[0].Rows[0]["CountryName"].ToString();
                        Religion.InnerHtml = ds.Tables[0].Rows[0]["Religion"].ToString();
                        Address.InnerHtml = ds.Tables[0].Rows[0]["Address"].ToString();
                        City.InnerHtml = ds.Tables[0].Rows[0]["City"].ToString();
                        State.InnerHtml = ds.Tables[0].Rows[0]["State"].ToString();
                        Pin.InnerHtml = ds.Tables[0].Rows[0]["Pin"].ToString();
                        Country.InnerHtml = ds.Tables[0].Rows[0]["Country"].ToString();
                        Aadhar_Card.InnerHtml = ds.Tables[0].Rows[0]["Aadhar_Card"].ToString();
                        Birth_Certificate.InnerHtml = ds.Tables[0].Rows[0]["Birth_Certificate"].ToString();
                        Migration_Certificate.InnerHtml = ds.Tables[0].Rows[0]["Migration_Certificate"].ToString();
                        Caste_Certificate.InnerHtml = ds.Tables[0].Rows[0]["Caste_Certificate"].ToString();
                        LastYear_Marksheet.InnerHtml = ds.Tables[0].Rows[0]["LastYear_Marksheet"].ToString();






                        //if ((Boolean)dtPermission.Rows[0]["Registratio_No"])
                        //{
                        //    Registratio_No.InnerText = RegNo;
                        //}
                        //if ((Boolean)dtPermission.Rows[0]["studentname"])
                        //{
                        //    studentname.InnerText = ds.Tables[0].Rows[0]["studentname"].ToString();
                        //}
                        //if ((Boolean)dtPermission.Rows[0][""])
                        //{

                        //}



                        /*  recipetrecivername.InnerText = ds.Tables[0].Rows[0]["studentname"].ToString();
                          Span2.InnerText = RegNo;
                          Span3.InnerHtml = ds.Tables[0].Rows[0]["Classname"].ToString();
                          Span5.InnerHtml = ds.Tables[0].Rows[0]["RegistrationFee"].ToString();
                          Span6.InnerHtml = nme.changeNumericToWords(Convert.ToDouble(ds.Tables[0].Rows[0]["RegistrationFee"])) + " Rupees.";
                          if (ds.Tables[0].Rows[0]["PaymentMode"].ToString() == "Cash" || ds.Tables[0].Rows[0]["PaymentMode"].ToString() == "Card")
                          {
                              Span7.InnerHtml = ds.Tables[0].Rows[0]["PaymentMode"].ToString();
                              chequedetails.Visible = false;
                          }
                          else if (ds.Tables[0].Rows[0]["PaymentMode"].ToString() == "Cheque")
                          {
                              chequedetails.Visible = true;
                              Span7.InnerHtml = ds.Tables[0].Rows[0]["PaymentMode"].ToString();
                              Span29.InnerHtml = ds.Tables[0].Rows[0]["ChkRefNo"].ToString();
                              Span30.InnerHtml = ds.Tables[0].Rows[0]["RegistrationDate"].ToString();
                          }
                          recieptdate.InnerHtml = ds.Tables[0].Rows[0]["RegistrationDate"].ToString();


                          // MKG
                          DOB.InnerHtml = ds.Tables[0].Rows[0]["StudentDOB"].ToString();
                          Gender.InnerHtml = ds.Tables[0].Rows[0]["Gender"].ToString();
                          Nationality.InnerHtml = ds.Tables[0].Rows[0]["Nationality"].ToString(); //
                          Religion.InnerHtml = ds.Tables[0].Rows[0]["Religion"].ToString();
                          Address.InnerHtml = ds.Tables[0].Rows[0]["Address"].ToString();
                          City.InnerHtml = ds.Tables[0].Rows[0]["City"].ToString();
                          State.InnerHtml = ds.Tables[0].Rows[0]["State"].ToString();
                          Pin.InnerHtml = ds.Tables[0].Rows[0]["Pin"].ToString();
                          Country.InnerHtml = ds.Tables[0].Rows[0]["Country"].ToString();
                          ParentName.InnerHtml = ds.Tables[0].Rows[0]["PrimaryParentFirstName"].ToString();
                          PhoneNo.InnerHtml = ds.Tables[0].Rows[0]["PrimaryMobileNo"].ToString();
                          if (Convert.ToString(ds.Tables[0].Rows[0]["StudentPhotograph"]) == "")
                          {
                              imguser.ImageUrl = "~/images/9update.png";
                          }
                          else
                          {
                              imguser.ImageUrl = "~/BranchPanel/Student-Registration/student-registration-document/" + Convert.ToString(ds.Tables[0].Rows[0]["StudentPhotograph"]);
                          }
                          Aadharcard.InnerHtml = ds.Tables[0].Rows[0]["Aadhar_Card"].ToString();
                          Birthcertificate.InnerHtml = ds.Tables[0].Rows[0]["Birth_Certificate"].ToString();
                          Castecertificate.InnerHtml = ds.Tables[0].Rows[0]["Caste_Certificate"].ToString();
                          Migrationcertificate.InnerHtml = ds.Tables[0].Rows[0]["Migration_Certificate"].ToString();
                          Lastyearmarksheet.InnerHtml = ds.Tables[0].Rows[0]["LastYear_Marksheet"].ToString(); */

                    }
                }
            }
        }

    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "message", "javascript:window.print()", true);
    }
}