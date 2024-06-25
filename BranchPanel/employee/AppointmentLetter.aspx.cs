using System;
using System.Data;
using System.Data.SqlClient;

public partial class Letters_AppointmentLetter : System.Web.UI.Page
{
    private int Staffid, Mainid;
    private DataUtility objDUT = new DataUtility();
    private NumberToEnglish nme = new NumberToEnglish();
    private DataTable Dt;
    private string name = "", emailid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString.Count > 0)
            {
                Staffid = Convert.ToInt32(Request.QueryString[0]);
                hdvforid.Value = Staffid.ToString();
            }
            fillDetails();
        }
    }

    protected void fillDetails()
    {
        DivForMessage.Visible = false;
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@Mainid", Convert.ToInt32(hdvforid.Value));
        param[1] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
        Dt = objDUT.GetDataTableSP(param, "[usp_Is_Appointletter_Created]");
        if (Dt.Rows.Count > 0)
        {
            if (Convert.ToInt32(Dt.Rows[0]["returnstatus"]) == 1 || Convert.ToInt32(Dt.Rows[0]["returnstatus"]) == 4)
            {
                divforprintappointedletter.Visible = true;
                lbl_refno1.Text = Dt.Rows[0]["refNo"].ToString();
                lbl_Date1.Text = Dt.Rows[0]["date"].ToString();
                lbl_title.Text = Dt.Rows[0]["Title"].ToString();
                lbl_firstname1.Text = Dt.Rows[0]["fName"].ToString();
                hfforemail.Value = Dt.Rows[0]["emailID"].ToString();
                lbl_lastname1.Text = Dt.Rows[0]["lName"].ToString();
                lbl_middlename1.Text = Dt.Rows[0]["mName"].ToString();
                hfforname.Value = Dt.Rows[0]["name"].ToString();
                lbl_address1.Text = Dt.Rows[0]["address"].ToString();
                lbl_city1.Text = Dt.Rows[0]["cityName"].ToString();
                lbl_State1.Text = Dt.Rows[0]["stateName"].ToString();
                lbl_country1.Text = Dt.Rows[0]["countryName"].ToString();
                lbl_pincode.Text = Dt.Rows[0]["pinCode"].ToString();
                Label11.Text = Dt.Rows[0]["name"].ToString();
                lbl_position1.Text = Dt.Rows[0]["designation"].ToString();
                lbl_salary1.Text = Dt.Rows[0]["annualCTC"].ToString();
                lbl_saleryinwords1.Text = nme.changeNumericToWords(Convert.ToDouble(Dt.Rows[0]["annualCTC"].ToString()));
                Lbl_Date.Text = Dt.Rows[0]["doj"].ToString();
                lbl_candidatename1.Text = Dt.Rows[0]["name"].ToString();
                lbl_hrname1.Text = Dt.Rows[0]["hrName"].ToString();
                Lbl_CompanyName2.Text = (objDUT.GetScalar("select isnull(BrName,'') SchoolName from Branch_master where brid=" + Session["BrBrid"])).ToString();
                //string months = objDUT.GetScalar("select timeInMonth from tblProbationPeriod where id=" + Convert.ToInt16(Dt.Rows[0]["probationPeriond"]) + "").ToString(); //
                int _probationPeriond = 0;
                int.TryParse(Convert.ToString(Dt.Rows[0]["probationPeriond"]), out _probationPeriond);
                string months = Convert.ToString(objDUT.GetScalar("select timeInMonth from tblProbationPeriod where id=" + _probationPeriond + ""));
                lbl_months1.Text = months;
            }
            else
            {
                DivForMessage.Visible = true;
                if (Convert.ToInt32(Dt.Rows[0]["returnstatus"]) == 2)
                {
                    labelforofferletter.Text = "[  For the appointment letter   ]";
                    lblmessageaccordingtostatus.Text = "[  At first insert the previous employment history from the employee profile please.  ]";
                }
            }
        }
        else
        {
            DivForMessage.Visible = true;
            lblmessageaccordingtostatus.Text = "[  There is no appointment letter till now for the selected candidate.  ]";
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("employee-list.aspx");
    }

    protected void btnforsendmail_Click(object sender, EventArgs e)
    {
        //======this code is for sending Email========
        DataTable dtforemail = objDUT.GetDataTable("select username,password from Employee_login where brid=" + Session["BrBrid"] + " and eid=" + Convert.ToInt32(Request.QueryString[0]) + " and status=1");
        DataTable dtforcredentials = objDUT.GetDataTable("select module_hostname,emialid_for_module,password_of_email from tbl_email_sms_send_master where ModuleId=4");
        if (dtforemail.Rows.Count > 0)
        {
            string username = "", pass = "", hostname = "", emailforhost = "", passwordforhost = "";
            username = dtforemail.Rows[0]["username"].ToString();
            pass = dtforemail.Rows[0]["password"].ToString();
            if (dtforcredentials.Rows.Count > 0)
            {
                hostname = dtforcredentials.Rows[0]["module_hostname"].ToString();
                emailforhost = dtforcredentials.Rows[0]["emialid_for_module"].ToString();
                passwordforhost = dtforcredentials.Rows[0]["password_of_email"].ToString();
                int reslt = CommonUtility.CommonUtility.SendMail(hfforname.Value, hfforemail.Value, hostname, emailforhost, passwordforhost, 4, "appoint", username, pass);
                if (reslt == 1)
                {
                    Utility.ViewAlertMessage(this, "Appointment has been successfully sent to " + hfforemail.Value + "");

                    SqlParameter[] param = new SqlParameter[7];
                    param[0] = new SqlParameter("@eid", Convert.ToInt32(hdvforid.Value));
                    param[1] = new SqlParameter("@refNo", lbl_refno1.Text.Trim());
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
                    param[5] = new SqlParameter("@letter_type", 2);
                    param[6] = new SqlParameter("@intResult", SqlDbType.Int);
                    param[6].Direction = ParameterDirection.Output;

                    int result1 = objDUT.ExecuteSqlSP(param, "usp_add_offer_appoint_history");
                    if (result1 == 1)
                    {
                        Utility.ViewAlertMessage(this, "This appointment letter history has been successfully created.");
                    }
                }

                if (reslt == 3)
                {
                    Utility.ViewAlertMessage(this, "Sending email is preventing by the administrator.");
                }
            }
        }
    }

    protected void btnbackwhennoofofferletter_Click(object sender, EventArgs e)
    {
        Response.Redirect("employee-list.aspx");
    }
}