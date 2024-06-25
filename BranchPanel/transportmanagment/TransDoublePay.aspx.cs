﻿using System;
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

public partial class BranchPanel_transportmanagment_TransDoublePay : System.Web.UI.Page
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
                string PayAmtID = "";
                string str = CultureInfo.CurrentCulture.NumberFormat.CurrencySymbol;
                if (Request.QueryString[0] != null)
                {
                    PayAmtID = Request.QueryString[0].ToString();
					
					string strVehicleId = @"Select distinct VM.VehicleRegNo,VM.Vehiclename
                                        from tbl_TransFee MT
										INNER JOIN tbl_vehicleroutemap_StudentDetails TAS ON MT.StuRegNo = TAS.StuRegNo and MT.Brid = TAS.Brid
                                        --INNER JOIN tbl_vehicle_route_map VRM ON VRM.VehicleRouteMapID = TAS.VechileRouteMapId
                                        INNER JOIN tbl_vehicle_details VM ON VM.VehicleID = TAS.VehicleID
                                        where PayAmtID=" + PayAmtID + "";

                    var dtVehicleDT = objdut.GetDataTable(strVehicleId);
                    if (dtVehicleDT.Rows.Count > 0)
                    {
                        SpBusNo.InnerHtml = dtVehicleDT.Rows[0]["Vehiclename"].ToString();
                        SpBusNo1.InnerHtml = dtVehicleDT.Rows[0]["Vehiclename"].ToString();
                        var VehicleRegNo = dtVehicleDT.Rows[0]["VehicleRegNo"].ToString();
                        if (!string.IsNullOrWhiteSpace(VehicleRegNo))
                        {
                            if (VehicleRegNo == "1" || VehicleRegNo == "2" || VehicleRegNo == "3" || VehicleRegNo == "4" || VehicleRegNo == "6" || VehicleRegNo == "7" )
                            {
                                SchoolName.InnerHtml = Convert.ToString("CAPUCHIN FRIARS MINOR SOCIETY");
                                schoolName2.InnerHtml = Convert.ToString("CAPUCHIN FRIARS MINOR SOCIETY");
                            }
                            else
                            //if (VehicleRegNo == "8" || VehicleRegNo == "9")
                            {
                                SchoolName.InnerHtml = Convert.ToString(objdut.GetScalar("select isnull(BrName,'') SchoolName from Branch_master where brid=" + Session["BrBrid"]));
                                schoolName2.InnerHtml = Convert.ToString(objdut.GetScalar("select isnull(BrName,'') SchoolName from Branch_master where brid=" + Session["BrBrid"]));
                            }                           
                        }
                    }
					
                    string str1 = @"Select CASE WHEN Fee.ASAID = 0 THEN Fee.AllAsaid ELSE CAST(FEE.ASAID as Varchar(MAX)) END As Asaid, ReceiptNo
                         from tbl_transfee Fee
                         where Fee.PayAmtId=" + PayAmtID + "";
                    var newAsaid = objdut.GetDataTable(str1);

                    var FeeFineAmt = Convert.ToString(objdut.GetScalar("select ISNULL(Fee.FeeFineAmount,0) FeeFineAmount from tbl_transfee Fee where Fee.PayAmtId = " + PayAmtID + ""));

                    if (newAsaid.Rows.Count > 0)
                    {
                        Receipt(newAsaid.Rows[0]["Asaid"].ToString(), newAsaid.Rows[0]["ReceiptNo"].ToString(), FeeFineAmt);
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

    protected void Receipt(string Receipt_No, string ReceiptNo, string feeFineAmt)
    {
        string RegistrationNo = "";
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", 9);
        param[1] = new SqlParameter("@ALLASAID", Receipt_No);
        param[2] = new SqlParameter("@Usertype", "std");
        param[3] = new SqlParameter("@Brid", Session["brbrid"]);
        dt = objdut.GetDataTableSP(param, "usp_StudentTransFee");
        if (dt.Rows.Count > 0)
        {
            RegistrationNo = dt.Rows[0]["Registration_No"].ToString();
            Span35.InnerHtml = RegistrationNo;
            Span46.InnerHtml = RegistrationNo;
            Span36.InnerHtml = dt.Rows[0]["RegNewNo"].ToString();
            Span47.InnerHtml = dt.Rows[0]["RegNewNo"].ToString();
            recieptno.InnerHtml = ReceiptNo;
            recieptno2.InnerHtml = ReceiptNo;
            recieptdate.InnerHtml = Convert.ToDateTime(dt.Rows[0]["TransDate"]).ToString("dd MMM yyy");
            recieptdate2.InnerHtml = Convert.ToDateTime(dt.Rows[0]["TransDate"]).ToString("dd MMM yyy");
            recipetrecivername.InnerHtml = dt.Rows[0]["Name"].ToString();
            recipetrecivername2.InnerHtml = dt.Rows[0]["Name"].ToString();
            Span23.InnerHtml = dt.Rows[0]["ParentName"].ToString();
            Span42.InnerHtml = dt.Rows[0]["ParentName"].ToString();
            Span3.InnerHtml = dt.Rows[0]["Classname"].ToString();
            Span43.InnerHtml = dt.Rows[0]["Classname"].ToString();
            Span4.InnerHtml = dt.Rows[0]["sectionname"].ToString();
            Span44.InnerHtml = dt.Rows[0]["sectionname"].ToString();

            SpBankTrans.Visible = false;
            SpBankTrans1.Visible = false;

            if (dt.Rows[0]["PaymentModeName"].ToString().ToLower() == "case") {
                dt.Rows[0]["PaymentModeName"] = "Cash";
            }

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

                SpBankTrans.Visible = true;
                SpBankTrans1.Visible = true;

                Span2.InnerHtml = dt.Rows[0]["PaymentBy"].ToString();
                Span1.InnerHtml = dt.Rows[0]["PaymentBy"].ToString();

                Span10.InnerHtml = dt.Rows[0]["bank_txn"].ToString();
                Span57.InnerHtml = dt.Rows[0]["bank_txn"].ToString();
            }
            else
            {
                //online2.Visible = true;
                //online3.Visible = true;

                //Span7.InnerHtml = dt.Rows[0]["PaymentModeName"].ToString();
                Span29.InnerHtml = dt.Rows[0]["ChkDDNeftRefNo"].ToString();
                Span58.InnerHtml = dt.Rows[0]["ChkDDNeftRefNo"].ToString();
                Span30.InnerHtml = dt.Rows[0]["ChkDDNeftDate"].ToString();
                Span59.InnerHtml = dt.Rows[0]["ChkDDNeftDate"].ToString();
                Span60.InnerHtml = dt.Rows[0]["BankName"].ToString();
                Span31.InnerHtml = dt.Rows[0]["BankName"].ToString();
            }
            
            Span7.InnerHtml = dt.Rows[0]["PaymentModeName"].ToString();
            Span56.InnerHtml = dt.Rows[0]["PaymentModeName"].ToString();
            
            if (string.IsNullOrEmpty(dt.Rows[0]["PaymentModeName"].ToString()))
            {
                Span7.InnerHtml = "Cash";
                Span56.InnerHtml = "Cash";
            }

            var userName = Convert.ToString(dt.Rows[0]["UserName"]);
            if (string.IsNullOrEmpty(userName)) {
                userName = "Online";
            }
            Span11.InnerHtml = userName;// Session["Brusername"].ToString();
            Span61.InnerHtml = userName;// Session["Brusername"].ToString();
        }
        DataTable dtFeeHead1 = new DataTable();
        dtFeeHead1.Columns.Add("SNo");
        dtFeeHead1.Columns.Add("FeeHead");
        dtFeeHead1.Columns.Add("FeeHeadAmt", typeof(decimal));
        dtFeeHead1.Columns.Add("PaidDate");
        dtFeeHead1.Columns.Add("FeeMonth");
        dtFeeHead1.Columns.Add("UserName");
        DataSet ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_StudentTransFee", con))
            {
                var Status = 3;

                if (Receipt_No.Split(',').Length == 1)
                {
                    Status = 2;
                }

                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param1 = new SqlParameter[4];
                param1[0] = new SqlParameter("@Mode", Convert.ToInt32(5));
                param1[1] = new SqlParameter("@ALLASAID", Receipt_No);
                param1[2] = new SqlParameter("@Brid", Convert.ToInt32(Session["brbrid"]));
                param1[3] = new SqlParameter("@Status", Convert.ToInt32(Status));
                cmd.Parameters.Add(param1[0]);
                cmd.Parameters.Add(param1[1]);
                cmd.Parameters.Add(param1[2]);
                cmd.Parameters.Add(param1[3]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        var dataTable1 = ds.Tables[0];
                        dataTable1.Columns.Remove("UserName");
                        dataTable1.Columns.Remove("Rownumber");

                        String[] szColumns = new String[dataTable1.Columns.Count];
                        for (int index = 0; index < dataTable1.Columns.Count; index++)
                        {
                            szColumns[index] = dataTable1.Columns[index].ColumnName;
                        }                        
                        
                        DataView view = new DataView(dataTable1);
                        DataTable dataTable = view.ToTable(true, szColumns);

                        double total = 0;
                        string feeMonth = "";
                        string usrName = string.Empty;
                        for (int i = 0; i < dataTable.Rows.Count; i++)
                        {
                            usrName = objdut.GetScalar("Select UserName from tbl_TransFee TF where TF.ASAID = " + dataTable.Rows[i]["ASAID"].ToString() + "").ToString();

                            DataRow dr1 = dtFeeHead1.NewRow();
                            dr1["SNo"] = i + 1;
                            dr1["FeeHead"] = "Transport Fee";
                            dr1["FeeHeadAmt"] = dataTable.Rows[i]["FeeAmount"].ToString();
                            dr1["UserName"] = usrName.ToString();

                            DataTable dtPaidDateMonth = objdut.GetDataTable("Select DateName(month,DateAdd(month,ISNULL(SEM.MonthID,0),-1)) FeeMonth, TF.Payment_Date from tbl_StudentAdmissionInstallment SEM " +
                            " INNER JOIN tbl_TransFee TF on SEM.ASAID = TF.ASAID" +
                            " where TF.ASAID = " + dataTable.Rows[i]["ASAID"].ToString() + "");

                            if (dtPaidDateMonth.Rows.Count > 0)
                            {
                                dr1["PaidDate"] = Convert.ToDateTime(dtPaidDateMonth.Rows[0]["Payment_Date"]).ToString("dd MMM yyy");
                                dr1["FeeMonth"] = Convert.ToString(dtPaidDateMonth.Rows[0]["FeeMonth"]).ToString();
                            }
                            dtFeeHead1.Rows.Add(dr1);
                            total = total + Convert.ToDouble(dataTable.Rows[0]["FeeAmount"]);
                        }
                        if (dtFeeHead1.Rows.Count > 0)
                        {
                            if (Convert.ToDouble(feeFineAmt) > 0)
                            {
                                DataRow dr2 = dtFeeHead1.NewRow();
                                dr2["SNo"] = dtFeeHead1.Rows.Count + 1;
                                dr2["FeeHead"] = "Fee Fine";
                                dr2["FeeHeadAmt"] = feeFineAmt.ToString();
                                dr2["UserName"] = usrName.ToString();
                                dtFeeHead1.Rows.Add(dr2);
                                total = total + Convert.ToDouble(feeFineAmt);
                            }
                            Span55.InnerHtml = nme.changeNumericToWords(total) + " Rupees.";
                            Span6.InnerHtml = nme.changeNumericToWords(total) + " Rupees.";

                            Span26.InnerText = total.ToString("N2");
                            Span50.InnerText = total.ToString("N2");
                            Span24.InnerText = feeMonth;
                            Span40.InnerText = feeMonth;

                            datagrid.DataSource = dtFeeHead1;
                            datagrid.DataBind();

                            datagrid.FooterRow.Cells[2].Text = "Total :";
                            datagrid.FooterRow.Cells[2].Text = "Total :";
                            datagrid.FooterRow.Cells[2].HorizontalAlign = HorizontalAlign.Right;
                            datagrid.FooterRow.Cells[3].Text = total.ToString("N2");
                            datagrid.FooterRow.Cells[3].HorizontalAlign = HorizontalAlign.Right;

                            datagrid.FooterRow.Cells[0].BorderWidth = 2;
                            datagrid.FooterRow.Cells[1].BorderWidth = 2;
                            datagrid.FooterRow.Cells[2].BorderWidth = 2;
                            datagrid.FooterRow.Cells[3].BorderWidth = 2;
                            //datagrid.FooterRow.Cells[4].BorderWidth = 2;
                            //datagrid.FooterRow.Cells[5].BorderWidth = 2;

                            GridView1.DataSource = dtFeeHead1;
                            GridView1.DataBind();

                            GridView1.FooterRow.Cells[2].Text = "Total :";
                            GridView1.FooterRow.Cells[2].Text = "Total :";
                            GridView1.FooterRow.Cells[2].HorizontalAlign = HorizontalAlign.Right;
                            GridView1.FooterRow.Cells[3].Text = total.ToString("N2");
                            GridView1.FooterRow.Cells[3].HorizontalAlign = HorizontalAlign.Right;

                            GridView1.FooterRow.Cells[0].BorderWidth = 2;
                            GridView1.FooterRow.Cells[1].BorderWidth = 2;
                            GridView1.FooterRow.Cells[2].BorderWidth = 2;
                            GridView1.FooterRow.Cells[3].BorderWidth = 2;
                            //GridView1.FooterRow.Cells[4].BorderWidth = 2;
                            //GridView1.FooterRow.Cells[5].BorderWidth = 2;
                        }
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