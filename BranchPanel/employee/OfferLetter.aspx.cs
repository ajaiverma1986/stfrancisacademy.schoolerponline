using System;
using System.Data;
using System.Data.SqlClient;

public partial class Letters_OfferLetter : System.Web.UI.Page
{
    private int Staffid;
    private DataUtility objDUT = new DataUtility();
    private NumberToEnglish nme = new NumberToEnglish();
    private DataTable Dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString.Count > 0)
            {
                Staffid = Convert.ToInt32(Request.QueryString[0]);
                hdvforid.Value = Staffid.ToString();
                fillDetails(Staffid, "");
            }
        }
    }

    protected void fillDetails(int Mainid, string refno)
    {
        DivForMessage.Visible = false;
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@Mainid", Mainid);
        param[1] = new SqlParameter("@Ref_No", refno);
        param[2] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
        Dt = objDUT.GetDataTableSP(param, "[usp_Is_Offerletter_Created]");
        if (Dt.Rows.Count > 0)
        {
            if (Convert.ToInt32(Dt.Rows[0]["returnstatus"]) == 1 || Convert.ToInt32(Dt.Rows[0]["returnstatus"]) == 4)
            {
                if (Convert.ToInt32(Dt.Rows[0]["previousnext"]) == 0)
                {
                    btnforpreviousofferltr.Visible = false;
                    btnnextltr.Visible = false;
                    btn_print.Style.Add("margin-left", "369px");
                }
                divforprintofferletter.Visible = true;
                lblRefNo.Text = Dt.Rows[0]["refNo"].ToString();
                lblDate.Text = Dt.Rows[0]["date"].ToString();
                lbl_title.Text = Dt.Rows[0]["Title"].ToString();
                lbl_firstname1.Text = Dt.Rows[0]["fName"].ToString();
                hfforemail.Value = Dt.Rows[0]["emailID"].ToString();
                hfforname.Value = Dt.Rows[0]["name"].ToString();
                lbl_lastname1.Text = Dt.Rows[0]["lName"].ToString();
                lbl_address1.Text = Dt.Rows[0]["address"].ToString();
                lbl_city1.Text = Dt.Rows[0]["cityName"].ToString();
                lbl_State1.Text = Dt.Rows[0]["stateName"].ToString();
                lbl_country1.Text = Dt.Rows[0]["countryName"].ToString();
                lbl_pnc.Text = Dt.Rows[0]["pinCode"].ToString();
                Label11.Text = Dt.Rows[0]["name"].ToString();
                lbl_position1.Text = Dt.Rows[0]["designation"].ToString();
                lbl_salary1.Text = Dt.Rows[0]["annualCTC"].ToString();
                lbl_saleryinwords1.Text = nme.changeNumericToWords(Convert.ToDouble(lbl_salary1.Text));
                lbl_date2.Text = Dt.Rows[0]["doj"].ToString();
                lbl_candidatename1.Text = Dt.Rows[0]["name"].ToString();
                lbl_hrname1.Text = Dt.Rows[0]["hrName"].ToString();
                Lbl_CompanyName1.Text = Convert.ToString(objDUT.GetScalar("select isnull(BrName,'') SchoolName from Branch_master where brid=" + Session["BrBrid"]));
                Lbl_CompanyName2.Text = Lbl_CompanyName1.Text;
                string months = objDUT.GetScalar("select timeInMonth from tblProbationPeriod where id=" + Convert.ToInt16(Dt.Rows[0]["probationperiod"]) + "").ToString(); //
                lbl_months1.Text = months + " months";
            }
            else
            {
                DivForMessage.Visible = true;
                if (Convert.ToInt32(Dt.Rows[0]["returnstatus"]) == 2)
                {
                    labelforofferletter.Text = "[  For the offer letter  ]";
                    lblmessageaccordingtostatus.Text = "[  At first insert the previous employment history from the employee profile please.  ]";
                }
                else if (Convert.ToInt32(Dt.Rows[0]["returnstatus"]) == 3)
                {
                    labelforofferletter.Text = "[  For the offer letter  ]";
                    lblmessageaccordingtostatus.Text = "[  At  first appoint the selected candidate then insert the previous employment history.  ]";
                }
            }
        }
        else
        {
            DivForMessage.Visible = true;
            lblmessageaccordingtostatus.Text = "[  There is no offer letter generated till now for the selected candidate.  ]";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("offered-employer-list.aspx");
    }

    protected void btnforpreviousofferltr_Click(object sender, EventArgs e)
    {
        DataTable dt = objDUT.GetDataTable("select prev_ref_no from tblOfferLettersList where refNo='" + lblRefNo.Text + "'");

        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["prev_ref_no"].ToString() != "")
            {
                fillDetails(0, dt.Rows[0]["prev_ref_no"].ToString());
            }
            else
            {
                divforprintofferletter.Visible = false;
                DivForMessage.Visible = true;
                lblmessageaccordingtostatus.Text = "[  There is no previous offer letter generated till now.  ]";
            }
        }
        else
        {
            divforprintofferletter.Visible = false;
            DivForMessage.Visible = true;
            lblmessageaccordingtostatus.Text = "[  There is no previous offer letter generated till now.  ]";
        }
    }

    protected void btnnextltr_Click(object sender, EventArgs e)
    {
        DataTable dt = objDUT.GetDataTable("select isnull(refNo,'')as refNo,reofferedcount from tblOfferLettersList where prev_ref_no='" + lblRefNo.Text + "'");
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows[0]["Refno"].ToString() != "")
            {
                fillDetails(0, dt.Rows[0]["Refno"].ToString());
            }
        }
        else
        {
            divforprintofferletter.Visible = false;
            DivForMessage.Visible = true;
            lblmessageaccordingtostatus.Text = "[  There is no more offer letter generated till now.  ]";
        }
    }

    protected void btnbackwhennoofofferletter_Click(object sender, EventArgs e)
    {
        Response.Redirect("offered-employer-list.aspx");
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        try
        {
            DataTable dtformail = objDUT.GetDataTable("select module_hostname,emialid_for_module,password_of_email from tbl_email_sms_send_master where ModuleId=4");
            if (dtformail.Rows.Count > 0)
            {
                int result = CommonUtility.CommonUtility.SendMail(hfforname.Value, hfforemail.Value, dtformail.Rows[0]["module_hostname"].ToString(), dtformail.Rows[0]["emialid_for_module"].ToString(), dtformail.Rows[0]["password_of_email"].ToString(), 4, "offer");

                if (result == 1)
                {
                    Utility.ViewAlertMessage(this, "Offer letter has been successfully sent to " + hfforemail.Value + ".");
                    SqlParameter[] param = new SqlParameter[7];
                    param[0] = new SqlParameter("@eid", Convert.ToInt32(hdvforid.Value));
                    param[1] = new SqlParameter("@refNo", lblRefNo.Text.Trim());
                    param[2] = new SqlParameter("@emp_name", lbl_firstname1.Text.Trim() + " " + lbl_lastname1.Text.Trim());
                    param[3] = new SqlParameter("@email_id", hfforemail.Value);
                    if (Session["BrADID"] != null)
                    {
                        param[4] = new SqlParameter("@userid", Convert.ToInt32(Session["BrADID"]));
                    }
                    else
                    {
                        param[4] = new SqlParameter("@userid", 0);
                    }
                    param[5] = new SqlParameter("@letter_type", 1);
                    param[6] = new SqlParameter("@intResult", SqlDbType.Int);
                    param[6].Direction = ParameterDirection.Output;

                    int result1 = objDUT.ExecuteSqlSP(param, "usp_add_offer_appoint_history");

                    if (result1 == 1)
                    {
                        Utility.ViewAlertMessage(this, "This offer letter history has been successfully created.");
                    }
                }
                else if (result == 3)
                {
                    Utility.ViewAlertMessage(this, "Some internal error has been occured by the host.");
                }
            }
            else
            {
                Utility.ViewAlertMessage(this, "Host credential information not available");
            }
        }
        catch (Exception ex)
        {
        }
    }
}