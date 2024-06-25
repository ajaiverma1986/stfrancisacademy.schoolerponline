using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Fee_Management_HostelFeeReceipt : System.Web.UI.Page
{
    CommonClass obCom = new CommonClass();
    private string url, Query, Query1, query2, query3;
    private DataTable dt;
    private double d;
    private NumberToEnglish nme = new NumberToEnglish();
    private DataUtility objdut = new DataUtility();
    private int enrollid = 0;
    private Decimal enrollfee = 0, servicetax = 0, educationcess = 0, serLim = 0, CessLim = 0, x = 0;
    private string institutename = "";

    protected void Page_Init(object sender, EventArgs e)
    {
        SchoolName.InnerHtml = Convert.ToString(objdut.GetScalar("select isnull(BrName,'') SchoolName from Branch_master where brid=" + Session["BrBrid"]));
        schoolName2.InnerHtml = Convert.ToString(objdut.GetScalar("select isnull(BrName,'') SchoolName from Branch_master where brid=" + Session["BrBrid"]));
        schoolName2.InnerHtml = "Diksha Educational Research Foundation Charitable Trust";
        string imgsrc = Convert.ToString(objdut.GetScalar("select photo from Branch_master where brid=" + Session["BrBrid"]));
        if (imgsrc != "")
        {

            string[] data = imgsrc.Split('^');
            if (data.Length > 0)
            {
                btnlogoforrecipt.ImageUrl = "~/BranchPanel/images/" + data[0];
                btnlogoforrecipt.Style.Add("background", data[0]);
                favicon.Href = "images/" + data[0];

                Image2.ImageUrl = "~/BranchPanel/images/" + data[0];
                Image2.Style.Add("background", data[0]);
            }
            else
            {
                btnlogoforrecipt.ImageUrl = "~/images/9update.png";
                Image2.ImageUrl = "../../images/9update.png";
                favicon.Href = "images/9update.png";
            }
        }
        else
        {
            btnlogoforrecipt.ImageUrl = "~/images/9update.png";
            Image2.ImageUrl = "~/images/9update.png";
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
            DataUtility Objdut = new DataUtility();
            getrecieptgenraldetails();
            if (Request.QueryString.Count > 0)
            {
                string[] ReceiptT;
                string Receipt_No = "";
                string PayAmtID = "";
                string StrQuery = "";
                string str = CultureInfo.CurrentCulture.NumberFormat.CurrencySymbol;
                if (Request.QueryString[0] != null)
                {
                    Receipt_No = Request.QueryString[0].ToString();
                    ReceiptT = Receipt_No.Split('-');
                    if (Receipt_No.Length > 0)
                    {
                        PayAmtID = ReceiptT[0].ToString();
                   
                    //else
                    //{
                    //    StrQuery = "Select ISNULL(ASAID,0) ASAID from Receipt_master where Receiptno=" + Receipt_No + " and Brid=" + Convert.ToInt32(Session["BrBrid"]) + " and ReceivedBy=" + Convert.ToInt32(Session["BrAdid"]) + "";
                    //    ID = (Objdut.GetScalar(StrQuery)).ToString();
                    //}

                    //Details(Convert.ToInt16(Session["StudID"]));
                    if (Convert.ToInt32(PayAmtID) > 0)
                    {
                        enrollid = Convert.ToInt32(PayAmtID);
                        ViewState["enrollid"] = enrollid;
                        Receipt(enrollid);
                    }
                    }
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

        spanaddress.Text = address;
        lblcontact.Text = Ph.ToString();
        lblMob.Text = mobile.ToString();
        lblEmailID.Text = EmailID.ToString();
        lblSchoolAffi.Text = SchoolAffi.Trim();
        lblservicetax.Text = Website.Trim();


        spanaddress1.Text = address;
        lblcontact1.Text = Ph.ToString();
        lblMob1.Text = mobile.ToString();
        lblEmailID1.Text = EmailID.ToString();
        lblSchoolAffi1.Text = SchoolAffi.Trim();
        lblservicetax1.Text = Website.Trim();

        //}
        //else
        //{
        //    mobile = Convert.ToString(objdut.GetScalar("select Landline from tbl_institutemaster"));
        //    address = Convert.ToString(objdut.GetScalar("select address  from tbl_institutemaster"));
        //}

        //        string permission = Convert.ToString(objdut.GetScalar(@"select servicenumber+'~'+is_tin+'~'+contact+'~'+is_address from tbl_recieptsettingcenter
        //                                                   where brid ='" + Session["brbrid"] + "'"));
        //        string[] recieptpermissions = permission.Split('~');
        //        if (recieptpermissions[0] == "1")
        //        {
        //            insservicetaxno.Style.Add("display", "block");
        //            lblservicetax.Text = serviceno.ToString();
        //            lblserviceno.Text = serviceno.ToString();
        //            stuservicetaxno.Style.Add("display", "block");
        //        }
        //        if (recieptpermissions[1] == "1")
        //        {
        //            instin.Style.Add("display", "block");
        //            lbltin.Text = tin.ToString();
        //            tinno.Text = tin.ToString();
        //            stutin.Style.Add("display", "block");
        //        }
        //        if (recieptpermissions[2] == "1")
        //        {
        //            inscontact.Style.Add("display", "block");
        //            lblcontact.Text = mobile.ToString();
        //            contact.Text = mobile.ToString();
        //            stucontact.Style.Add("display", "block");
        //        }
        //        if (recieptpermissions[3] == "1")
        //        {
        //            insaddress.Style.Add("display", "block");
        //            spanaddress.Text = address.ToString();
        //            lbladdress.Text = address.ToString();
        //            stuinsaddress.Style.Add("display", "block");
        //        }
    }

    protected void Receipt(int PayAmtID)
    {
        try
        {
            DataTable dtFeeHead = new DataTable();
            string RegistrationNo = "";
            string Usertype = "";
            DataUtility Objdut = new DataUtility();
            decimal FeeFine = 0;
            int PaymentModeId = Convert.ToInt32(Objdut.GetScalar("Select isnull(PayStatus,0) PaymentModeId from tbl_PayHostelFee1 where PayAmtID = " + PayAmtID + ""));
            int _ReceiptNo= Convert.ToInt32(Objdut.GetScalar("select MAX(PayID) as PayID from tbl_PayHostelFee1_Copy where oldReceiptNo = " + PayAmtID + ""));
            if (PaymentModeId == 6)
            {
                Usertype = "std";
            }
            SqlParameter[] param = new SqlParameter[4];
            param[0] = new SqlParameter("@mode", 7);
            param[1] = new SqlParameter("@PayAmtID", PayAmtID);
            param[2] = new SqlParameter("@fyid", Convert.ToInt32(obCom.GetActiveAcedmicYear()));
            param[3] = new SqlParameter("@Brid", Session["BrBrid"]);
            dt = objdut.GetDataTableSP(param, "USP_HostelToStudent");
            if (dt.Rows.Count > 0)
            {
                FeeFine = Convert.ToDecimal(objdut.GetScalar("Select ISNULL((FeeFine),0) from tbl_PayHostelFee1 WHERE PayID=" + PayAmtID + ""));
                RegistrationNo = dt.Rows[0]["Registration_No"].ToString();
                Span35.InnerHtml = RegistrationNo;
                Span46.InnerHtml = RegistrationNo;
                Span36.InnerHtml = dt.Rows[0]["RegNewNo"].ToString();
                Span47.InnerHtml = dt.Rows[0]["RegNewNo"].ToString();
                Span40.InnerHtml = objdut.GetScalar("Select DateName( month , DateAdd( month , monthId , 0 ) - 1 ) from tbl_PayHostelFee1 WHERE PayAmtID=" + PayAmtID + "").ToString();
                Span24.InnerHtml = Span40.InnerHtml.ToString();
                //recieptno.InnerHtml = PayAmtID.ToString();
                recieptno.InnerHtml = _ReceiptNo.ToString();
                recieptno2.InnerHtml = PayAmtID.ToString();
                recieptdate2.InnerHtml = Convert.ToDateTime(objdut.GetScalar("Select ISNULL(Payment_Date,'1999-01-01') from tbl_PayHostelFee1 WHERE PayAmtID=" + PayAmtID + "")).ToString("dd MMM yyyy");
                recieptdate.InnerHtml = recieptdate2.InnerHtml.ToString();
                recipetrecivername.InnerHtml = dt.Rows[0]["studentFname"].ToString() + " " + dt.Rows[0]["studentMname"].ToString() + " " + dt.Rows[0]["studentLname"].ToString();
                recipetrecivername2.InnerHtml = recipetrecivername.InnerHtml.ToString();
                Span23.InnerHtml = dt.Rows[0]["PrimaryParentFirstName"].ToString() + " " + dt.Rows[0]["PrimaryParentMiddleName"].ToString() + " " + dt.Rows[0]["PrimaryParentLastName"].ToString();
                Span42.InnerHtml = Span23.InnerHtml.ToString();
                //Span2.InnerHtml = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dt.Rows[0]["AdmissionNo"].ToString();
                Span3.InnerHtml = dt.Rows[0]["Classname"].ToString();
                Span43.InnerHtml = dt.Rows[0]["Classname"].ToString();
                string section = Convert.ToString(objdut.GetScalar("Select ISNULL(sectionName,'N|A') from classwithsection WHERE branchid=" + Session["Brbrid"].ToString() + " and classid=" + dt.Rows[0]["Classid"].ToString() + " and status=1 and cwsid=" + dt.Rows[0]["sectionid"].ToString() + ""));
                Span4.InnerHtml = section.ToString();
                Span44.InnerHtml = section.ToString();                

                double[] ArrSAID = new double[100];
                dtFeeHead = Objdut.GetDataTable(@"Select ROW_NUMBER() OVER(ORDER BY PayID ASC) AS SNo, MS.HostelFeeName,MS.HostelFeeAmt from mst_HostelFee1 MS
                            INNER JOIN tbl_PayHostelFee1 TFA on TFA.FeeID = MS.HostelFeeID and MS.brid= TFA.brid and MS.fyid = TFA.fyid WHERE PayID = " + PayAmtID + "");
                DataTable dtFee = new DataTable();
                dtFee = Objdut.GetDataTable(@"select top 1 ((select SUM(FeeAmount) from tbl_PayHostelFee1 where PayID = " + PayAmtID + ")-(RemainingAmount)) as TotalPaid, RemainingAmount from  tbl_PayHostelFee1 WHERE PayID = " + PayAmtID + "");

                if (dtFee.Rows.Count > 0)
                {
                    // Due Amount
                    Span25.InnerHtml = Convert.ToString(dtFee.Rows[0]["RemainingAmount"]);
                    Span51.InnerHtml= Convert.ToString(dtFee.Rows[0]["RemainingAmount"]);
                    // Paid Amount
                    Span26.InnerHtml = Convert.ToString(dtFee.Rows[0]["TotalPaid"]); 
                    Span50.InnerHtml = Convert.ToString(dtFee.Rows[0]["TotalPaid"]);
                }
               
                if (dtFeeHead.Rows.Count > 0)
                {
                    if (FeeFine > 0)
                    {
                        DataRow dr = dtFeeHead.NewRow();
                        dr["SNo"] = (dtFeeHead.Rows.Count + 1).ToString();
                        dr["HostelFeeName"] = "FEE FINE";
                        dr["HostelFeeAmt"] = FeeFine.ToString();

                        dtFeeHead.Rows.Add(dr);
                        dtFeeHead.AcceptChanges();
                    }
                    decimal TtlAmount = 0;
                    foreach (DataRow row in dtFeeHead.Rows)
                    {
                        TtlAmount = TtlAmount + Convert.ToDecimal(row["HostelFeeAmt"]);
                    }
                    Span5.InnerHtml = TtlAmount.ToString();
                    Span52.InnerHtml = TtlAmount.ToString();
                    Span6.InnerHtml = nme.changeNumericToWords(Convert.ToDouble(TtlAmount)) + " Rupees.";
                    Span55.InnerHtml = nme.changeNumericToWords(Convert.ToDouble(TtlAmount)) + " Rupees.";

                    //Span26.InnerHtml = Span5.InnerHtml.ToString();
                    //Span50.InnerHtml = Span5.InnerHtml.ToString(); 

                    datagrid.DataSource = dtFeeHead;
                    datagrid.DataBind();

                    datagrid.FooterRow.Cells[1].Text = "Total :";
                    datagrid.FooterRow.Cells[1].Text = "Total :";
                    datagrid.FooterRow.Cells[1].HorizontalAlign = HorizontalAlign.Right;
                    datagrid.FooterRow.Cells[2].Text = Span5.InnerHtml.ToString();

                    datagrid.FooterRow.Cells[0].BorderWidth = 2;
                    datagrid.FooterRow.Cells[1].BorderWidth = 2;
                    datagrid.FooterRow.Cells[2].BorderWidth = 2;

                    GridView1.DataSource = dtFeeHead;
                    GridView1.DataBind();

                    GridView1.FooterRow.Cells[1].Text = "Total :";
                    GridView1.FooterRow.Cells[1].Text = "Total :";
                    GridView1.FooterRow.Cells[1].HorizontalAlign = HorizontalAlign.Right;
                    GridView1.FooterRow.Cells[2].Text = Span5.InnerHtml.ToString();

                    GridView1.FooterRow.Cells[0].BorderWidth = 2;
                    GridView1.FooterRow.Cells[1].BorderWidth = 2;
                    GridView1.FooterRow.Cells[2].BorderWidth = 2;

                }
            }
        }
        catch
        { }
        finally
        {
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "message", "javascript:window.print()", true);
    }
}