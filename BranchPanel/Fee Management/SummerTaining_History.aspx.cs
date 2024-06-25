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
public partial class BranchPanel_Fee_Management_SummerTaining_History : System.Web.UI.Page
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
        //SchoolName.InnerHtml = Convert.ToString(objdut.GetScalar("select isnull(BrName,'') SchoolName from Branch_master where brid=" + Session["BrBrid"]));
        // string imgsrc = Convert.ToString(objdut.GetScalar("select photo from Branch_master where brid=" + Session["BrBrid"]));
        //  if (imgsrc != "")
        //  {

        //       string[] data = imgsrc.Split('^');
        //       if (data.Length > 0)
        //      {
        //          btnlogoforrecipt.ImageUrl = "~/BranchPanel/images/" + data[0];
        //          btnlogoforrecipt.Style.Add("background", data[0]);
        //          favicon.Href = "images/" + data[0];

        //     }
        //    else
        //    {
        //         btnlogoforrecipt.ImageUrl = "~/images/9update.png";
        //         favicon.Href = "images/9update.png";
        //     }
        // }
        // else
        //  {
        //     btnlogoforrecipt.ImageUrl = "~/images/9update.png";
        //     favicon.Href = "images/9update.png";
        // }
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

        // spanaddress.Text = address;
        // lblcontact.Text = Ph.ToString();
        // lblMob.Text = mobile.ToString();
        //  lblEmailID.Text = EmailID.ToString();
        // lblSchoolAffi.Text = SchoolAffi.Trim();
        // lblservicetax.Text = Website.Trim();
    }

    protected void Receipt(string Sscid)
    {
        DataSet ds = new DataSet();
        getrecieptgenraldetails();
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[2] = new SqlParameter("@Fyid", 0);
        param[3] = new SqlParameter("@sscid", Sscid);
        Dt = Objdut.GetDataTableSP(param, "Usp_SummerCamp");
        if (Dt.Rows.Count > 0)
        {
            ds.Tables.Add(Dt);
            ds.AcceptChanges();
            if (ds.Tables[0].Rows.Count > 0)
            {
                recipetrecivername.InnerText = ds.Tables[0].Rows[0]["StudentFirstName"].ToString() + " " + ds.Tables[0].Rows[0]["StudentMiddlename"].ToString() + " " + ds.Tables[0].Rows[0]["StudentLastName"].ToString();
                //Span2.InnerText = RegNo;
                Span3.InnerHtml = ds.Tables[0].Rows[0]["Classname"].ToString();
                //Span5.InnerHtml = ds.Tables[0].Rows[0]["RegistrationFee"].ToString();
                // Span6.InnerHtml = nme.changeNumericToWords(Convert.ToDouble(ds.Tables[0].Rows[0]["RegistrationFee"])) + " Rupees.";
                // if (ds.Tables[0].Rows[0]["PaymentMode"].ToString() == "Cash"|| ds.Tables[0].Rows[0]["PaymentMode"].ToString() == "Card")
                // {
                //    Span7.InnerHtml = ds.Tables[0].Rows[0]["PaymentMode"].ToString();
                //   chequedetails.Visible = false;
                // }
                // else if (ds.Tables[0].Rows[0]["PaymentMode"].ToString() == "Cheque")
                // {
                //    chequedetails.Visible = true;
                //    Span7.InnerHtml = ds.Tables[0].Rows[0]["PaymentMode"].ToString();
                //    Span29.InnerHtml = ds.Tables[0].Rows[0]["ChkRefNo"].ToString();
                //   Span30.InnerHtml = ds.Tables[0].Rows[0]["RegistrationDate"].ToString();
                //}
                // recieptdate.InnerHtml = ds.Tables[0].Rows[0]["RegistrationDate"].ToString();


                // MKG
                DOB.InnerHtml = ds.Tables[0].Rows[0]["StudentDOB"].ToString();
                var sex = ds.Tables[0].Rows[0]["Gender"].ToString();
                if (sex == "1")
                {
                    Gender.InnerHtml = "Male";
                }
                else {
                    Gender.InnerHtml = "Femmale";
                }
                // Nationality.InnerHtml = ds.Tables[0].Rows[0]["Nationality"].ToString(); //
              //  Religion.InnerHtml = ds.Tables[0].Rows[0]["Gender"].ToString();
                Address.InnerHtml = ds.Tables[0].Rows[0]["ParentAddress"].ToString();
                City.InnerHtml = ds.Tables[0].Rows[0]["ParentCity"].ToString();
                State.InnerHtml = ds.Tables[0].Rows[0]["ParentState"].ToString();
                Pin.InnerHtml = ds.Tables[0].Rows[0]["ParentPinCode"].ToString();
                Country.InnerHtml = ds.Tables[0].Rows[0]["ParentCountry"].ToString();
                ParentName.InnerHtml = ds.Tables[0].Rows[0]["ParentName"].ToString();
                ParentMobileNo.InnerHtml = ds.Tables[0].Rows[0]["ParentMobile"].ToString();

                if (!string.IsNullOrEmpty(PersonName.InnerHtml))
                {
                    divEmergency.Visible = true;
                }
                else {
                    divEmergency.Visible = false;
                }
                //EMergency Person
                PersonName.InnerHtml = ds.Tables[0].Rows[0]["PersonName"].ToString();
                PersonMobile.InnerHtml = ds.Tables[0].Rows[0]["PersonMobile"].ToString();
                PersonAltMobile.InnerHtml = ds.Tables[0].Rows[0]["PersonAltMobile"].ToString();
                PersonPhone.InnerHtml = ds.Tables[0].Rows[0]["PersonPhone"].ToString();
                PersonAddress.InnerHtml = ds.Tables[0].Rows[0]["PersonAddress"].ToString();
                PersonCity.InnerHtml = ds.Tables[0].Rows[0]["PersonCity"].ToString();
                PersonState.InnerHtml = ds.Tables[0].Rows[0]["PersonState"].ToString();
                PersonPin.InnerHtml = ds.Tables[0].Rows[0]["PersonPin"].ToString();
                PersonCity.InnerHtml = ds.Tables[0].Rows[0]["PersonCity"].ToString();
                PersonCountry.InnerHtml = ds.Tables[0].Rows[0]["PersonCountry"].ToString();

                //Fee Details
                PaidFee.InnerHtml = ds.Tables[0].Rows[0]["PaidFee"].ToString();
                RegDate.InnerHtml = ds.Tables[0].Rows[0]["ActivityDate"].ToString();
                PaymentMode.InnerHtml = ds.Tables[0].Rows[0]["PaymentModeName"].ToString();
                if (PaymentMode.InnerHtml == "Cash")
                {
                    divCheque.Visible = false;
                }
                else {
                    divCheque.Visible = true;
                    BranchName.InnerHtml = ds.Tables[0].Rows[0]["BranchName"].ToString();
                    ChequeNo.InnerHtml = ds.Tables[0].Rows[0]["CHKREFDDREFNo"].ToString();
                    ChequeDate.InnerHtml = ds.Tables[0].Rows[0]["CHKREFDDDate"].ToString();
                    BankName.InnerHtml = ds.Tables[0].Rows[0]["BankName"].ToString();
                }
            }
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "message", "javascript:window.print()", true);
    }
}