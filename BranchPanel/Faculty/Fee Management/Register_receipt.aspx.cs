﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Fee_Management_receipt : System.Web.UI.Page
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
       /* string imgsrc = Convert.ToString(objdut.GetScalar("select isnull(logo,'')+'^'+ isnull(LogoBgColor,'')  from tbl_recieptsettingcenter"));
        string[] data = imgsrc.Split('^');
        //btnlogoforrecipt.ImageUrl = "../../images/" + data[0];
        //Image1.ImageUrl = "../../images/" + data[0];
        divforlogo.Style.Add("background-color", data[1]);
        divforlogo1.Style.Add("background-color", data[1]);

      string imgsrc1 = Convert.ToString(objdut.GetScalar("select photo from tblEmployee where eid =" + Session["BRADID"]));
            btnlogoforrecipt.ImageUrl = "../images/" + imgsrc1;
            Image1.ImageUrl = "../images/" + imgsrc1;
            


*/

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
//        if (isbranch == "2")
//        {
//            string branchdata = Convert.ToString(objdut.GetScalar(@"select BrAddress+','+City+' - '+pincode+', '+state+', '+Country+'^'+case when LandLineNo='' then (select Landline from tbl_institutemaster) else LandLineNo  end
//                                                  from branch_master where brid = '" + Session["brbrid"] + "'"));
//            string[] getbranchdata = branchdata.Split('^');
//            address = getbranchdata[0];
//            mobile = getbranchdata[1];
//        }
//        else
//        {
//            mobile = Convert.ToString(objdut.GetScalar("select Landline from tbl_institutemaster"));
//            address = Convert.ToString(objdut.GetScalar("select address  from tbl_institutemaster"));
//        }

//        string permission = Convert.ToString(objdut.GetScalar(@"select servicenumber+'~'+is_tin+'~'+contact+'~'+is_address from tbl_recieptsettingcenter
//                                                   where brid ='" + Session["brbrid"] + "'"));
//        string[] recieptpermissions = permission.Split('~');
//        if (recieptpermissions[0] == "1")
//        {
//            insservicetaxno.Style.Add("display", "block");
//            lblservicetax.Text = serviceno.ToString();
//        }
//        if (recieptpermissions[1] == "1")
//        {
//            instin.Style.Add("display", "block");
//            lbltin.Text = tin.ToString();
//        }
//        if (recieptpermissions[2] == "1")
//        {
//            inscontact.Style.Add("display", "block");
//            lblcontact.Text = mobile.ToString();
//        }
//        if (recieptpermissions[3] == "1")
//        {
//            insaddress.Style.Add("display", "block");
//            spanaddress.Text = address.ToString();
//        }

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
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_studentregistrationlist]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@mode", 1);
                param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
                param[2] = new SqlParameter("@registrationno", RegNo);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        recipetrecivername.InnerText = ds.Tables[0].Rows[0]["studentname"].ToString();
                        Span2.InnerText = RegNo;
                        Span3.InnerHtml = ds.Tables[0].Rows[0]["Classname"].ToString();
                        //Span4.InnerHtml = dt.Rows[0]["sectionname"].ToString();
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
                    }
                }
            }
        }        

        //DataUtility Objdut = new DataUtility();
        //string Usertype = "";
        //int PaymentModeId = Convert.ToInt32(Objdut.GetScalar("Select isnull(PaymentModeId,0) PaymentModeId from tbl_StudentAdmissionInstallment where ASAID = " + id + ""));
        //if (PaymentModeId == 6)
        //{
        //    Usertype = "std";
        //}
        //SqlParameter[] param = new SqlParameter[3];
        //param[0] = new SqlParameter("@mode",1);
        //param[1] = new SqlParameter("@asaid", id);
        //param[2] = new SqlParameter("@Usertype", Usertype);
        //dt = objdut.GetDataTableSP(param, "Usp_Receipt");
        //if (dt.Rows.Count > 0)
        //{
        //    recieptno.InnerHtml = dt.Rows[0]["Receiptno"].ToString();
        //    Span14.InnerHtml = dt.Rows[0]["Receiptno"].ToString();
        //    recieptdate.InnerHtml = dt.Rows[0]["PaidDate"].ToString();
        //    Span15.InnerHtml = dt.Rows[0]["PaidDate"].ToString();
        //    recipetrecivername.InnerHtml = dt.Rows[0]["Name"].ToString();
        //    Span16.InnerHtml = dt.Rows[0]["Name"].ToString();
        //    Span2.InnerHtml = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dt.Rows[0]["AdmissionNo"].ToString();
        //    Span18.InnerHtml = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dt.Rows[0]["AdmissionNo"].ToString();
        //    Span3.InnerHtml = dt.Rows[0]["Classname"].ToString();
        //    Span19.InnerHtml = dt.Rows[0]["Classname"].ToString();
        //    //string section = Convert.ToString(objdut.GetScalar("select batchname from Student_BatchMaster where stuRegNo=" + dt.Rows[0]["sturegno"].ToString()));
        //    Span4.InnerHtml = dt.Rows[0]["sectionname"].ToString();
        //    Span20.InnerHtml = dt.Rows[0]["sectionname"].ToString();
        //    Span5.InnerHtml = dt.Rows[0]["InstallmentAmount"].ToString();
        //    Span21.InnerHtml = dt.Rows[0]["InstallmentAmount"].ToString();
        //    Span6.InnerHtml = nme.changeNumericToWords(Convert.ToDouble(dt.Rows[0]["InstallmentAmount"])) + " Rupees.";
        //    Span22.InnerHtml = nme.changeNumericToWords(Convert.ToDouble(dt.Rows[0]["InstallmentAmount"])) + " Rupees.";
        //    if (dt.Rows[0]["PaymentModeName"].ToString() == "Cash" || dt.Rows[0]["PaymentModeName"].ToString() == "Card")
        //    {
        //        Span7.InnerHtml = dt.Rows[0]["PaymentModeName"].ToString();
        //        Span8.InnerHtml = dt.Rows[0]["PaymentModeName"].ToString();
        //        chequedetails.Visible = false;
        //        Tr1.Visible = false;
        //        online.Visible = true;
        //        online1.Visible = true;
        //    }
        //    else if (dt.Rows[0]["PaymentModeName"].ToString() == "Online")
        //    {
        //        online.Visible = false;
        //        online1.Visible = false;
        //        chequedetails.Visible = false;
        //        Span7.InnerHtml = dt.Rows[0]["PaymentModeName"].ToString();
        //        Span8.InnerHtml = dt.Rows[0]["PaymentModeName"].ToString();
        //        Span10.InnerHtml = dt.Rows[0]["bank_txn"].ToString();
        //        Span13.InnerHtml = dt.Rows[0]["bank_txn"].ToString();
        //    }
        //    else
        //    {
        //        online.Visible = true;
        //        online1.Visible = true;
        //        Span7.InnerHtml = dt.Rows[0]["PaymentModeName"].ToString();
        //        Span8.InnerHtml = dt.Rows[0]["PaymentModeName"].ToString();
        //        Span12.InnerHtml = dt.Rows[0]["ChkDDNeftRefNo"].ToString();
        //        Span29.InnerHtml = dt.Rows[0]["ChkDDNeftRefNo"].ToString();
        //        Span30.InnerHtml = dt.Rows[0]["ChkDDNeftDate"].ToString();
        //        Span32.InnerHtml = dt.Rows[0]["ChkDDNeftDate"].ToString();
        //        Span31.InnerHtml = dt.Rows[0]["BankName"].ToString();
        //        Span33.InnerHtml = dt.Rows[0]["BankName"].ToString();
        //    }
        //    Span11.InnerHtml = dt.Rows[0]["UserName"].ToString();
        //    Span27.InnerHtml = dt.Rows[0]["UserName"].ToString();
        //}
        //DataTable Dt = new DataTable();
        //SqlParameter[] param1 = new SqlParameter[1];
        //param1[0] = new SqlParameter("@asaid", id);
        //Dt = objdut.GetDataTableSP(param1, "[usp_GetTaxAmountAndPercentage]");
        //if (Dt.Rows.Count > 0)
        //{
        //    spantaxamount.InnerHtml = Dt.Rows[0]["TaxAmount"].ToString();
        //    spantaxpercentage.InnerHtml = Dt.Rows[0]["TaxPercentage"].ToString() + "%";
        //    span1.InnerHtml = Dt.Rows[0]["TaxAmount"].ToString();
        //    span9.InnerHtml = Dt.Rows[0]["TaxPercentage"].ToString() + "%";
        //}
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "message", "javascript:window.print()", true);
    }
}