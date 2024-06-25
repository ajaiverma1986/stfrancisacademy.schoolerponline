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

public partial class BranchPanel_transportmanagment_TransFeeReceipt : System.Web.UI.Page
{
    private string url, Query, Query1, query2, query3;
    private DataTable dt;
    private double d;
    private NumberToEnglish nme = new NumberToEnglish();
    private DataUtility objdut = new DataUtility();
    private string ASAID = "";
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
                ASAID = Request.QueryString[0].ToString();
                if (ASAID != "")
                {
                    ViewState["ASAID"] = ASAID;
                    Receipt(ASAID);
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

    protected void Receipt(string asaid)
    {
        getrecieptgenraldetails();
        DataSet ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_StudentTransFee", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@Mode", Convert.ToInt32(5));
                param[1] = new SqlParameter("@ASAID", Convert.ToInt32(asaid));
                param[2] = new SqlParameter("@Brid", Convert.ToInt32(Session["BrBrid"]));
                param[3] = new SqlParameter("@Status", Convert.ToInt32(2));
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        string ClassID = "0";
                        string SectionID = "0";
                        string PaidAmount = "0";
                        PaidAmount = ds.Tables[0].Rows[0]["FeeAmount"].ToString();
                        recipetrecivername.InnerText = ds.Tables[0].Rows[0]["studentFname"].ToString() + " " + ds.Tables[0].Rows[0]["studentMname"].ToString() + " " + ds.Tables[0].Rows[0]["studentLname"].ToString();
                        SPparentName.InnerText = ds.Tables[0].Rows[0]["fatherFname"].ToString() + " " + ds.Tables[0].Rows[0]["fatherMname"].ToString() + " " + ds.Tables[0].Rows[0]["fatherLname"].ToString();
                        Span2.InnerText = ds.Tables[0].Rows[0]["Registration_No"].ToString();
                        SpReceiptNo.InnerText = "TF" + objdut.GetScalar("Select ISNULL(PayAmtID,0) from tbl_transfee where asaid =" + asaid + "").ToString();
                        Span5.InnerText = PaidAmount.ToString();
                        ClassID = ds.Tables[0].Rows[0]["ClassID"].ToString();
                        SectionID = ds.Tables[0].Rows[0]["SectionID"].ToString();
                        Span3.InnerHtml = objdut.GetScalar("Select Classname from Class_Master where id=" + ClassID + "").ToString();
                        Span1.InnerHtml = objdut.GetScalar("Select Sectionname from classwithsection where cwsid=" + SectionID + "").ToString();
                        Span6.InnerHtml = nme.changeNumericToWords(Convert.ToDouble(PaidAmount)) + " Rupees.";
                        //if (ds.Tables[0].Rows[0]["PaymentMode"].ToString() == "Cash" || ds.Tables[0].Rows[0]["PaymentMode"].ToString() == "Card")
                        //{
                        //    Span7.InnerHtml = ds.Tables[0].Rows[0]["PaymentMode"].ToString();
                        //    chequedetails.Visible = false;
                        //}
                        ////else if (ds.Tables[0].Rows[0]["PaymentMode"].ToString() == "Cheque")
                        ////{
                        ////    chequedetails.Visible = true;
                        ////    Span7.InnerHtml = ds.Tables[0].Rows[0]["PaymentMode"].ToString();
                        ////    Span29.InnerHtml = ds.Tables[0].Rows[0]["ChkRefNo"].ToString();
                        ////    Span30.InnerHtml = ds.Tables[0].Rows[0]["RegistrationDate"].ToString();
                        ////}
                        recieptdate.InnerHtml = Convert.ToDateTime(ds.Tables[0].Rows[0]["PaymentDate"]).ToString("dd MMM yyyy");
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