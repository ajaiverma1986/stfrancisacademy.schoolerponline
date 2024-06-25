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

public partial class BranchPanel_Fee_Management_DoublePay : System.Web.UI.Page
{
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
                string ID = "";
                string StrQuery = "";
                string str = CultureInfo.CurrentCulture.NumberFormat.CurrencySymbol;
                if (Request.QueryString[0] != null)
                {
                    Receipt_No = Request.QueryString[0].ToString();
                    ReceiptT = Receipt_No.Split('-');
                    if (ReceiptT.Length > 1)
                    {
                        ID = ReceiptT[1].ToString();
                    }
                    else
                    {
                        StrQuery = "Select ISNULL(ASAID,0) ASAID from Receipt_master where Receiptno=" + Receipt_No + " and Brid=" + Convert.ToInt32(Session["BrBrid"]) + " and ReceivedBy=" + Convert.ToInt32(Session["BrAdid"]) + "";
                        ID = (Objdut.GetScalar(StrQuery)).ToString();
                    }

                    //Details(Convert.ToInt16(Session["StudID"]));
                    if (Convert.ToInt32(ID) > 0)
                    {
                        enrollid = Convert.ToInt32(ID);
                        ViewState["enrollid"] = enrollid;
                        Receipt(enrollid);
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

    protected void Receipt(int id)
    {
        string RegistrationNo = "";
        DataUtility Objdut = new DataUtility();
        string Usertype = "";
        int PaymentModeId = Convert.ToInt32(Objdut.GetScalar("Select isnull(PaymentModeId,0) PaymentModeId from tbl_StudentAdmissionInstallment where ASAID = " + id + ""));
        if (PaymentModeId == 6)
        {
            Usertype = "std";
        }
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", 1);
        param[1] = new SqlParameter("@asaid", id);
        param[2] = new SqlParameter("@Usertype", Usertype);
        param[3] = new SqlParameter("@Brid", Session["BrBrid"]);
        dt = objdut.GetDataTableSP(param, "Usp_Receipt");
        if (dt.Rows.Count > 0)
        {
            RegistrationNo = dt.Rows[0]["Registration_No"].ToString();
            Span35.InnerHtml = RegistrationNo;
            Span46.InnerHtml = RegistrationNo;
            Span36.InnerHtml = dt.Rows[0]["RegNewNo"].ToString();
            Span47.InnerHtml = dt.Rows[0]["RegNewNo"].ToString();
            recieptno.InnerHtml = dt.Rows[0]["Receiptno"].ToString();
            recieptno2.InnerHtml = dt.Rows[0]["Receiptno"].ToString();
            recieptdate.InnerHtml = dt.Rows[0]["PaidDate"].ToString();
            recieptdate2.InnerHtml = dt.Rows[0]["PaidDate"].ToString();
            recipetrecivername.InnerHtml = dt.Rows[0]["Name"].ToString();
            recipetrecivername2.InnerHtml = dt.Rows[0]["Name"].ToString();
            Span23.InnerHtml = dt.Rows[0]["ParentName"].ToString();
            Span42.InnerHtml = dt.Rows[0]["ParentName"].ToString();
            //Span2.InnerHtml = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + dt.Rows[0]["AdmissionNo"].ToString();
            Span3.InnerHtml = dt.Rows[0]["Classname"].ToString();
            Span43.InnerHtml = dt.Rows[0]["Classname"].ToString();
            //string section = Convert.ToString(objdut.GetScalar("select batchname from Student_BatchMaster where stuRegNo=" + dt.Rows[0]["sturegno"].ToString()));
            Span4.InnerHtml = dt.Rows[0]["sectionname"].ToString();
            Span44.InnerHtml = dt.Rows[0]["sectionname"].ToString();
            Span5.InnerHtml = dt.Rows[0]["InstallmentAmount"].ToString();
            Span52.InnerHtml = dt.Rows[0]["InstallmentAmount"].ToString();
            Span6.InnerHtml = nme.changeNumericToWords(Convert.ToDouble(dt.Rows[0]["InstallmentAmount"])) + " Rupees.";
            Span55.InnerHtml = nme.changeNumericToWords(Convert.ToDouble(dt.Rows[0]["InstallmentAmount"])) + " Rupees.";
            if (dt.Rows[0]["PaymentModeName"].ToString() == "Cash" || dt.Rows[0]["PaymentModeName"].ToString() == "Card")
            {
                Span7.InnerHtml = dt.Rows[0]["PaymentModeName"].ToString();

                Span56.InnerHtml = dt.Rows[0]["PaymentModeName"].ToString();

                chequedetails.Visible = false;

                chequedetails1.Visible = false;
                //online2.Visible = true;
                //online3.Visible = true;
            }
            else if (dt.Rows[0]["PaymentModeName"].ToString() == "Online")
            {
                chequedetails.Visible = false;

                //online2.Visible = false;
                //online3.Visible = false;
                chequedetails1.Visible = false;


                Span7.InnerHtml = dt.Rows[0]["PaymentModeName"].ToString();
                Span10.InnerHtml = dt.Rows[0]["bank_txn"].ToString();
                Span57.InnerHtml = dt.Rows[0]["bank_txn"].ToString();
            }
            else
            {
                //online2.Visible = true;
                //online3.Visible = true;

                Span7.InnerHtml = dt.Rows[0]["PaymentModeName"].ToString();
                Span29.InnerHtml = dt.Rows[0]["ChkDDNeftRefNo"].ToString();
                Span58.InnerHtml = dt.Rows[0]["ChkDDNeftRefNo"].ToString();
                Span30.InnerHtml = dt.Rows[0]["ChkDDNeftDate"].ToString();
                Span59.InnerHtml = dt.Rows[0]["ChkDDNeftDate"].ToString();
                Span60.InnerHtml = dt.Rows[0]["BankName"].ToString();
                Span31.InnerHtml = dt.Rows[0]["BankName"].ToString();
            }
            Span11.InnerHtml = dt.Rows[0]["UserName"].ToString();
            Span61.InnerHtml = dt.Rows[0]["UserName"].ToString();
        }
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
        DataTable dtFeeDetails = new DataTable();
        DataTable dtFeeHead = new DataTable();
        dtFeeHead.Columns.Add("SNo");
        dtFeeHead.Columns.Add("FeeHead");
        dtFeeHead.Columns.Add("FeeHeadAmt", typeof(decimal));

        DataTable dtFeeHead1 = new DataTable();
        dtFeeHead1.Columns.Add("SNo");
        dtFeeHead1.Columns.Add("FeeHead");
        dtFeeHead1.Columns.Add("FeeHeadAmt", typeof(decimal));

        DataTable TempDt = new DataTable();

        DataTable dtAsaid;
        string ALLSAID = "";
        double[] ArrSAID = new double[100];
        string[] InASAID;
        dtAsaid = Objdut.GetDataTable("Select ISNULL(HostelFee,0) HostelFee,ISNULL(TransPortAmt,0) TransPortAmt,ISNULL(FeeFineAmt,0) FeeFineAmt,AllASAID from tbl_StudentAdmissionInstallment where ASAID = " + id + "");
        if (dtAsaid.Rows.Count > 0)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand("[StudentsAllDetails]", con))
                {
                    con.Open();
                    ALLSAID = dtAsaid.Rows[0]["ALLASAID"].ToString();
                    if (ALLSAID != "")
                    {
                        InASAID = ALLSAID.Split(',');
                        for (int i = 0; i < InASAID.Length; i++)
                        {
                            int Result = (int)(Objdut.ExecuteSql("INSERT INTO tblTemp VALUES(" + Convert.ToInt32(InASAID[i]) + ")"));
                        }
                    }
                    else
                    {
                        int Result = (int)(Objdut.ExecuteSql("INSERT INTO tblTemp VALUES(" + Convert.ToInt32(id) + ")"));
                    }
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter[] param2 = new SqlParameter[1];
                    param2[0] = new SqlParameter("@Mode", 7);
                    cmd.Parameters.Add(param2[0]);
                    SqlDataAdapter Da = new SqlDataAdapter(cmd);
                    Da.Fill(dtFeeDetails);
                }
            }


            decimal total = 0;
            if (dtFeeDetails.Rows.Count > 0)
            {
                if (Convert.ToDecimal(dtAsaid.Rows[0]["TransPortAmt"]) != 0)
                {
                    DataRow dr = dtFeeHead.NewRow();
                    dr["SNo"] = Convert.ToInt32(dtFeeHead.Rows.Count) + 1;
                    dr["FeeHead"] = "Transport Fee";
                    dr["FeeHeadAmt"] = Convert.ToDecimal(dtAsaid.Rows[0]["TransPortAmt"]);
                    dtFeeHead.Rows.Add(dr);
                    total = total + Convert.ToDecimal(dr["FeeHeadAmt"]);
                }

                if (Convert.ToDecimal(dtAsaid.Rows[0]["FeeFineAmt"]) != 0)
                {
                    DataRow dr = dtFeeHead.NewRow();
                    dr["SNo"] = Convert.ToInt32(dtFeeHead.Rows.Count) + 1;
                    dr["FeeHead"] = "Late Fee";
                    dr["FeeHeadAmt"] = Convert.ToDecimal(dtAsaid.Rows[0]["FeeFineAmt"]);
                    dtFeeHead.Rows.Add(dr);
                    total = total + Convert.ToDecimal(dr["FeeHeadAmt"]);
                }

                if (Convert.ToDecimal(dtAsaid.Rows[0]["HostelFee"]) != 0)
                {
                    DataRow dr = dtFeeHead.NewRow();
                    dr["SNo"] = Convert.ToInt32(dtFeeHead.Rows.Count) + 1;
                    dr["FeeHead"] = "Hostel Fee";
                    dr["FeeHeadAmt"] = Convert.ToDecimal(dtAsaid.Rows[0]["HostelFee"]);
                    dtFeeHead.Rows.Add(dr);
                    total = total + Convert.ToDecimal(dr["FeeHeadAmt"]);
                }


                string MonthName = "";
                string MonthID = "";
                //string str = dtFeeDetails.Compute("Sum(BalAmt)", "srno=1 or srno in(1,2)").ToString();
                for (int k = 0; k < dtFeeDetails.Rows.Count; k++)
                {

                    if (MonthName == "")
                    {
                        MonthName = dtFeeDetails.Rows[k]["MName"].ToString().Substring(0, 3);
                        MonthID = dtFeeDetails.Rows[k]["MonthNo"].ToString();
                    }
                    else
                    {
                        MonthName = MonthName + "-" + dtFeeDetails.Rows[k]["MName"].ToString().Substring(0, 3);
                        MonthID = MonthID + "," + dtFeeDetails.Rows[k]["MonthNo"].ToString();
                    }
                    Span24.InnerHtml = MonthName;
                    Span40.InnerHtml = MonthName;
                    string[] FeeRowHead;
                    FeeRowHead = dtFeeDetails.Rows[k]["FeeDescription"].ToString().Split('&');
                    if (FeeRowHead[0].ToString() != "N/A")
                    {
                        for (int i = 0; i < FeeRowHead.Length; i++)
                        {
                            string[] FeeHead;
                            FeeHead = FeeRowHead[i].ToString().Split(':');
                            DataRow dr = dtFeeHead.NewRow();
                            dr["SNo"] = Convert.ToInt32(dtFeeHead.Rows.Count) + 1;
                            dr["FeeHead"] = FeeHead[0].ToString();
                            dr["FeeHeadAmt"] = Convert.ToDecimal(FeeHead[1]);
                            total = total + Convert.ToDecimal(FeeHead[1]);
                            dtFeeHead.Rows.Add(dr);
                        }
                    }
                }
                DataTable dt_Barcode = new DataTable();
                dt_Barcode = dtFeeHead.DefaultView.ToTable(true, "FeeHead");

                if (dt_Barcode.Rows.Count > 0)
                {
                    for (int a = 0; a < dt_Barcode.Rows.Count; a++)
                    {
                        DataRow dr1 = dtFeeHead1.NewRow();
                        dr1["SNo"] = Convert.ToInt32(a) + 1;
                        dr1["FeeHead"] = dt_Barcode.Rows[a]["FeeHead"].ToString();
                        dr1["FeeHeadAmt"] = Convert.ToDecimal(dtFeeHead.Compute("Sum(FeeHeadAmt)", "FeeHead='" + dt_Barcode.Rows[a]["FeeHead"] + "'"));
                        dtFeeHead1.Rows.Add(dr1);
                    }
                }
                string strPaid = "Select PaidDate,ISNULL(PaidNonTaxableAmount,0) AMOUNT from tbl_StudentAdmissionInstallment where Brid=" + Session["BrBrid"] + " and SturegNo=" + dt.Rows[0]["SturegNo"].ToString() + " and MonthId IN(" + MonthID + ") and PaymentStatusId=2 and ASAID <> " + id + "";

                DataTable dtPaidFee = Objdut.GetDataTable(strPaid);

                int Truncate = (int)(Objdut.ExecuteSql("TRUNCATE TABLE tblTemp"));

                StringBuilder html = new StringBuilder();

                //Table start.
                html.Append("<table style='float:right; width:100%; border: solid 2px;'>");

                //Building the Header row.
                //html.Append("<tr>");
                //foreach (DataColumn column in dt.Columns)
                //{
                //    html.Append("<th>");
                //    html.Append(column.ColumnName);
                //    html.Append("</th>");
                //}
                //html.Append("</tr>");
                decimal TotalPAid = 0;
                //Building the Data rows.
                foreach (DataRow row in dtPaidFee.Rows)
                {
                    html.Append("<tr>");
                    int i = 0;
                    foreach (DataColumn column in dtPaidFee.Columns)
                    {
                        if (i % 2 == 0)
                        {
                            html.Append("<td style='width:81%; border-right: solid 1px;'>");
                            html.Append("Paid Date : " + Convert.ToDateTime(row[column.ColumnName]).ToString("dd MMM yyyy"));
                            html.Append("</td>");
                        }
                        else
                        {
                            html.Append("<td style='width:19%; text-align:left'>");
                            html.Append(row[column.ColumnName]);
                            TotalPAid = TotalPAid + Convert.ToDecimal(row[column.ColumnName]);
                            html.Append("</td>");
                        }
                        i++;
                    }
                    html.Append("</tr>");
                }

                //Table end.
                html.Append("</table>");
                string strDiscount = "";
                decimal Dsicount = 0;
                decimal NewPayableAmount = 0;

                if (RegistrationNo != "")
                {
                    string strMonth = "";
                    for (int k = 0; k < dtFeeDetails.Rows.Count; k++)
                    {
                        int MOnthID = Convert.ToInt32(dtFeeDetails.Rows[k]["MonthNo"]);
                        if (MOnthID == 4)
                        {
                            strMonth = "0," + MOnthID.ToString();
                        }
                        else
                        {
                            if (strMonth == "")
                            {
                                strMonth = MOnthID.ToString();
                            }
                            else
                            {
                                strMonth = strMonth + "," + MOnthID.ToString();
                            }
                        }
                    }
                    strDiscount = @"Select isnull(SUM(DM.Discount),0) Discount from DiscountedStudent_Info DD
                        Inner Join Discount_student_master DM on DD.DiscountCode = DM.DiscountCode where DD.Brid=" + Session["BrBrid"] + " and DD.Registration_No='" + RegistrationNo + "'" +
                                " and DM.DiscountInMonthId IN(" + strMonth + ") ";

                    Dsicount = Convert.ToInt32(Objdut.GetScalar(strDiscount));
                }
                if (Dsicount > 0)
                {
                    Span28.InnerHtml = Dsicount.ToString();
                    Span48.InnerHtml = Dsicount.ToString();

                    NewPayableAmount = total - Dsicount;

                    Span34.InnerHtml = NewPayableAmount.ToString();
                    Span49.InnerHtml = NewPayableAmount.ToString();
                }
                else
                {
                    NewPayableAmount = total;
                    Discount.Visible = false;
                    Discount1.Visible = false;
                }

                //Append the HTML string to Placeholder.
                PlaceHolder1.Controls.Add(new Literal { Text = html.ToString() });
                PlaceHolder2.Controls.Add(new Literal { Text = html.ToString() });

                decimal Due = NewPayableAmount - (Convert.ToDecimal(Span5.InnerHtml) + TotalPAid);
                Span26.InnerHtml = Span5.InnerHtml.ToString();
                Span50.InnerHtml = Span5.InnerHtml.ToString();
                if (Due > 0)
                {
                    Span25.InnerHtml = Due.ToString();
                    Span51.InnerHtml = Due.ToString();
                }
                else if (Due == 0)
                {
                    DueAmount1.Visible = false;
                    DueAmount.Visible = false;
                }
            }
            if (dtFeeHead1.Rows.Count > 0)
            {
                datagrid.DataSource = dtFeeHead1;
                datagrid.DataBind();               

                datagrid.FooterRow.Cells[1].Text = "Total :";
                datagrid.FooterRow.Cells[1].Text = "Total :";
                datagrid.FooterRow.Cells[1].HorizontalAlign = HorizontalAlign.Right;
                datagrid.FooterRow.Cells[2].Text = total.ToString("N2");

                datagrid.FooterRow.Cells[0].BorderWidth = 2;
                datagrid.FooterRow.Cells[1].BorderWidth = 2;
                datagrid.FooterRow.Cells[2].BorderWidth = 2;

                GridView1.DataSource = dtFeeHead1;
                GridView1.DataBind();

                GridView1.FooterRow.Cells[1].Text = "Total :";
                GridView1.FooterRow.Cells[1].Text = "Total :";
                GridView1.FooterRow.Cells[1].HorizontalAlign = HorizontalAlign.Right;
                GridView1.FooterRow.Cells[2].Text = total.ToString("N2");

                GridView1.FooterRow.Cells[0].BorderWidth = 2;
                GridView1.FooterRow.Cells[1].BorderWidth = 2;
                GridView1.FooterRow.Cells[2].BorderWidth = 2;
            }
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "message", "javascript:window.print()", true);
    }
}