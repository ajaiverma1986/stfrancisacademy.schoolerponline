using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_registration : System.Web.UI.Page
{
    private string PageName = "", url = "";
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private CommonClass commonobj = new CommonClass();
    private Utility obju = new Utility();

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        getdate();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        PageName = Utility.GetCurrentPagename();

        if (!objut.isAccessible(((User)Session["BrUser"]).UserID, PageName))
        {
            //  Response.Redirect("~/Login.aspx");
        }

        //RequiredFieldValidator8.Enabled = false;
        //lblmsg1.Visible = false;
        if (!IsPostBack)
        {
            txtOfficer.Text = Convert.ToString(Session["Brusername"]);
            string str = Convert.ToString(objdut.GetScalar("select cid from country where cid=96"));
            Session["cid"] = str;
            ddlCountry1.SelectedValue = str.ToString();
            //ddlPayMode.Enabled = false;
            txtFiName.Focus();
            //clear();
            fillCountry();
            state();
            fillClass();

            txtRegFee.Enabled = false;
            txtRegFee.Text = "Rs " + string.Format("{0:f}", 0.00);
        }
    }

    [WebMethod]
    public static bindclasses_new[] bindstate(string cid)
    {
        List<bindclasses_new> details = new List<bindclasses_new>();
        DataTable dt = new DataTable();
        HttpContext.Current.Session["cid"] = cid;
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select classid,Classname from ClassBranch_master where status=1  and BranchId=" + HttpContext.Current.Session["BrBrid"] + " order by classname asc", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                bindclasses_new objProductMasterDetails0 = new bindclasses_new();
                objProductMasterDetails0.SID = Convert.ToInt32("0");
                objProductMasterDetails0.statename = "-Select Classname-";
                details.Add(objProductMasterDetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    bindclasses_new objProductMasterDetails = new bindclasses_new();
                    objProductMasterDetails.SID = Convert.ToInt32(dtrow["classid"].ToString());
                    objProductMasterDetails.statename = dtrow["Classname"].ToString();
                    details.Add(objProductMasterDetails);
                }
            }
        }
        return details.ToArray();
    }

    public class bindclasses_new
    {
        public int SID { get; set; }

        public string statename { get; set; }
    }

    private void state()
    {
        ddlState1.Items.Clear();
        lblCountryMSg.Visible = false;
        string str = "select SID,stateName  from STATE where CID=" + Session["cid"] + " order by stateName  ";
        DataTable dt1 = objdut.GetDataTable(str);
        if (dt1.Rows.Count > 0)
        {
            //ddlState1.DataSource = commonobj.Dll("Statedll", Convert.ToInt32(ddlCountry1.SelectedValue));
            ddlState1.DataSource = dt1;
            ddlState1.DataTextField = "stateName";
            ddlState1.DataValueField = "SID";
            ddlState1.DataBind();

            ddlState1.Items.Insert(0, new ListItem("--Select State--", "0"));
            ddlState1.Focus();
        }
    }

    protected void fillClass()
    {
        ddlClass.DataSource = CommonClass.ABC1("ClassInBranch", Convert.ToInt32(Session["BrBrid"]));
        ddlClass.DataTextField = "Classname";
        ddlClass.DataValueField = "classid";
        ddlClass.DataBind();
        ListItem li = new ListItem("--Select Class--", "0");
        ddlClass.Items.Insert(0, li);

        string str1 = "select pqualification,id from parentqualification";
        DataTable dt3 = objdut.GetDataTable(str1);
        if (dt3.Rows.Count > 0)
        {
            ddlFQualifiaction1.DataSource = dt3;
            ddlFQualifiaction1.DataTextField = "pqualification";
            ddlFQualifiaction1.DataValueField = "id";
            ddlFQualifiaction1.DataBind();
            ListItem li4 = new ListItem("--Select one--", "0");
            ddlFQualifiaction1.Items.Insert(0, li4);

            ddlMQualifiaction1.DataSource = dt3;
            ddlMQualifiaction1.DataTextField = "pqualification";
            ddlMQualifiaction1.DataValueField = "id";
            ddlMQualifiaction1.DataBind();
            ListItem li5 = new ListItem("--Select one--", "0");
            ddlMQualifiaction1.Items.Insert(0, li5);
        }
    }

    public void fillCountry()
    {
        ddlCountry1.DataSource = commonobj.Dll("Countrydll");
        ddlCountry1.DataTextField = "countryName";
        ddlCountry1.DataValueField = "CID";
        ddlCountry1.DataBind();
        ddlCountry1.Items.Insert(0, new ListItem("--Select Country--", "0"));
        ddlState1.Items.Insert(0, new ListItem("--Select State--", "0"));
        ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
    }

    //protected void ddlState1_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    int intStateId = Convert.ToInt32(ddlState1.SelectedValue);
    //    string querycityCount = "select COUNT(*) from CITY where SID=" + intStateId + "";
    //    int citycount = Convert.ToInt32(objdut.GetScalar(querycityCount));
    //    if (citycount == 0)
    //    {
    //        lblStateMsg.Visible = true;
    //        lblStateMsg.Text = "There is no city against this state!! Please add city in master settings.";
    //        ddlCity1.Items.Clear();
    //        ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
    //        ddlState1.Focus();
    //    }
    //    else
    //    {
    //        lblStateMsg.Visible = false;
    //        ddlCity1.Items.Clear();
    //        string strSql = "select ctId,cityName from city where cityName<>'Others' and sid=" + intStateId + " order by cityName";
    //        DataTable dtCity = objdut.GetDataTable(strSql);
    //        ddlCity1.DataSource = dtCity;
    //        ddlCity1.DataTextField = "cityName";
    //        ddlCity1.DataValueField = "ctId";
    //        ddlCity1.DataBind();
    //        ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
    //        ddlCity1.Focus();
    //    }
    //}

    //protected void ddlCountry1_SelectedIndexChanged1(object sender, EventArgs e)
    //{
    //    string querystsateCount = "select COUNT(*) from STATE where CID=" + ddlCountry1.SelectedValue + "";
    //    int statecount = Convert.ToInt32(objdut.GetScalar(querystsateCount));
    //    if (statecount == 0)
    //    {
    //        lblStateMsg.Visible = false;
    //        lblCountryMSg.Visible = true;
    //        lblCountryMSg.Text = "There is no state against this country!! Please add state in master settings.";
    //        ddlState1.Items.Clear();
    //        ddlState1.Items.Insert(0, new ListItem("--Select State--", "0"));
    //        ddlCity1.Items.Clear();
    //        ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
    //        ddlCountry1.Focus();
    //    }
    //    else
    //    {
    //        ddlState1.Items.Clear();
    //        lblCountryMSg.Visible = false;
    //        string str = "select SID,stateName  from STATE where CID=" + ViewState["cid"] + " order by stateName  ";
    //        DataTable dt1 = objdut.GetDataTable(str);
    //        if (dt1.Rows.Count > 0)
    //        {
    //            //ddlState1.DataSource = commonobj.Dll("Statedll", Convert.ToInt32(ddlCountry1.SelectedValue));
    //            ddlState1.DataTextField = "stateName";
    //            ddlState1.DataValueField = "SID";
    //            ddlState1.DataBind();

    //            ddlState1.Items.Insert(0, new ListItem("--Select State--", "0"));
    //            ddlState1.Focus();
    //        }
    //    }
    //}

    public void reset()
    {
        txtFFname.Text = "";
        txtFMname.Text = "";
        txtFLname.Text = "";
        txtmob.Text = "";
        txtFiName.Text = "";
        TextBox11.Text = "";
        txtLName.Text = "";
        txtToDate.Text = "";
        txtMFname.Text = "";
        txtMMname.Text = "";
        txtMLname.Text = "";
        rbgender.SelectedValue = "1";
        ddlClass.SelectedIndex = 0;
        //ddlCity1.SelectedIndex = 0;
        txtPAddress.Text = "";
        txtPZIP.Text = "";

        //txtreceipt.Text = "";
        //txtAdmDate.Text = "";
        // txtadmNo.Text = "";

        txtClassSec.Text = "";
        txtOfficer.Text = "";
        ddlCity1.SelectedIndex = 0;
    }

    public string Arial { get; set; }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        //   string dob = Convert.ToDateTime(txtToDate.Text.Trim()).ToString("dd/MM/yyyy");
        //if (checkValidation())
        //{
        string brusername = (string)Session["Brusername"];
        string pname = "usp_studentRegistration";
        SqlParameter[] param = new SqlParameter[35];
        param[0] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
        param[1] = new SqlParameter("@branchname", brusername);
        param[2] = new SqlParameter("@firstname", txtFiName.Text.Trim());
        param[3] = new SqlParameter("@middlename", TextBox11.Text.Trim());
        param[4] = new SqlParameter("@lastname", txtLName.Text.Trim());
        param[5] = new SqlParameter("@dateofbirth", txtToDate.Text.Trim());
        param[6] = new SqlParameter("@FfirstName", txtFFname.Text.Trim());
        param[7] = new SqlParameter("@FMiddleName", txtFMname.Text.Trim());
        param[8] = new SqlParameter("@FLastName", txtFLname.Text.Trim());

        param[9] = new SqlParameter("@MFirstName", txtMFname.Text.Trim());
        param[10] = new SqlParameter("@MmiddleName", txtMMname.Text.Trim());
        param[11] = new SqlParameter("@MLastName", txtMLname.Text.Trim());

        param[12] = new SqlParameter("@gender", rbgender.SelectedValue);
        param[13] = new SqlParameter("@applyclass", ddlClass.SelectedItem.Text);
        param[14] = new SqlParameter("@Address", txtPAddress.Text.Trim());
        param[15] = new SqlParameter("@countryid", Convert.ToInt32(ddlCountry1.SelectedValue));
        param[16] = new SqlParameter("@countryname", ddlCountry1.SelectedItem.Text);
        param[17] = new SqlParameter("@stateid", Convert.ToInt32(ddlState1.SelectedValue));
        param[18] = new SqlParameter("@statename", ddlState1.SelectedItem.Text);
        param[19] = new SqlParameter("@cityid", Convert.ToInt32(Request.Form[ddlCity1.UniqueID]));
        param[20] = new SqlParameter("@cityname", ddlCity1.SelectedItem.Text);
        param[21] = new SqlParameter("@pincodeP", txtPZIP.Text.Trim());
        // param[17]=new SqlParameter("@pincodeP",txt
        //@slipNo as varchar(50)='', @slipid as int=0,
        //if (string.IsNullOrEmpty(txtreceipt.Text))
        //{
        //    param[22] = new SqlParameter("@slipNo", "N/A");
        //}
        //else
        //{
        //    param[22] = new SqlParameter("@slipNo", txtreceipt.Text.Trim());
        //}
        param[22] = new SqlParameter("@slipNo", "");
        param[23] = new SqlParameter("@registrationdate", txtAdmDate.Text.Trim());
        param[24] = new SqlParameter("@classid", ddlClass.SelectedValue);

        param[25] = new SqlParameter("@Amount", ViewState["amount"]);
        param[26] = new SqlParameter("@Paymentmode", ddlPayMode.SelectedItem.Text);
        param[27] = new SqlParameter("@bankname", txtbnkname.Text);
        param[28] = new SqlParameter("@checkno", txtchck.Text);

        param[29] = new SqlParameter("@intresult", Convert.ToInt32("0"));
        param[29].Direction = ParameterDirection.Output;

        param[30] = new SqlParameter("@FMobileNo", txtmob.Text.Trim());
        param[31] = new SqlParameter("@Fquali", ddlFQualifiaction1.SelectedValue);
        param[32] = new SqlParameter("@Mquali", ddlMQualifiaction1.SelectedValue);

        if (ddlFQualifiaction1.SelectedIndex > 0 && ddlMQualifiaction1.SelectedIndex > 0)
        {
            int str1 = Convert.ToInt32(objdut.GetScalar("select priority from parentqualification where id=" + ddlFQualifiaction1.SelectedValue));
            int str2 = Convert.ToInt32(objdut.GetScalar("select priority from parentqualification where id=" + ddlMQualifiaction1.SelectedValue));
            if (str1 <= str2)
            {
                param[33] = new SqlParameter("@Fpriority", str1);
            }
            else
            {
                param[33] = new SqlParameter("@Fpriority", str2);
            }
        }

        if (ddlFQualifiaction1.SelectedIndex > 0 && ddlMQualifiaction1.SelectedIndex == 0)
        {
            int str1 = Convert.ToInt32(objdut.GetScalar("select priority from parentqualification where id=" + ddlFQualifiaction1.SelectedValue));
            param[33] = new SqlParameter("@Fpriority", str1);
        }

        if (ddlFQualifiaction1.SelectedIndex == 0 && ddlMQualifiaction1.SelectedIndex > 0)
        {
            int str2 = Convert.ToInt32(objdut.GetScalar("select priority from parentqualification where id=" + ddlMQualifiaction1.SelectedValue));
            param[33] = new SqlParameter("@Fpriority", str2);
        }

        if (ddlFQualifiaction1.SelectedIndex == 0 && ddlMQualifiaction1.SelectedIndex == 0)
        {
            param[33] = new SqlParameter("@Fpriority", 100);
        }

        if (string.IsNullOrEmpty(txtincome.Text))
        {
            param[34] = new SqlParameter("@Pincome", Convert.ToDouble(0));
        }
        else
        {
            param[34] = new SqlParameter("@Pincome", txtincome.Text.Trim());
        }

        //txtadmNo.Text = Convert.ToString("R/" + mid + 1);
        int count = objdut.ExecuteSqlSP(param, pname);
        if (count == 1)
        {
            string query0 = "select max(RId) from tbl_StudentRegistration where Brid=" + Convert.ToDouble(Session["BrBrid"]);
            int rid = Convert.ToInt32(objdut.GetScalar(query0));
            Response.Redirect("regConfirm.aspx?Rid=" + rid);
            //Utility.ViewAlertMessage(this.Master.Page, "Record inserted successfully..");
            //ddlCountry1.Items.Clear();
            //ddlState1.Items.Clear();
            //ddlCity1.Items.Clear();
            //reset();
            //fillCountry();
        }
        //}
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "There was an error. Please try again.");
            return;
        }
    }

    //public bool checkValidation()
    //{
    //    if (txtFiName.Text == "")
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Please enter  first name.");
    //        txtFiName.Focus();
    //        return false;
    //    }
    //    if (txtLName.Text == "")
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Please enter last name.");
    //        txtLName.Focus();
    //        return false;
    //    }
    //    if (txtToDate.Text == "")
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Please select date of birth.");
    //        txtToDate.Focus();
    //        return false;
    //    }
    //    if (txtFFname.Text == "")
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Please enter father's name.");
    //        txtFFname.Focus();
    //        return false;
    //    }
    //    if (txtFLname.Text == "")
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Please enter father's last name.");
    //        txtFLname.Focus();
    //        return false;
    //    }

    //    if (ddlClass.SelectedItem.Value == "0")
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Please select the class applying for.");
    //        ddlClass.Focus();
    //        return false;
    //    }
    //    if (txtPAddress.Text == "")
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Please enter address details.");
    //        txtPAddress.Focus();
    //        return false;
    //    }
    //    if (ddlCountry1.SelectedItem.Value == "0")
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Please select country.");
    //        ddlCountry1.Focus();
    //        return false;
    //    }

    //    if (ddlState1.SelectedItem.Value == "0")
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Please select state.");
    //        ddlState1.Focus();
    //        return false;
    //    }
    //    if (ddlCity1.SelectedItem.Value == "0")
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Please select city.");
    //        ddlCity1.Focus();
    //        return false;
    //    }
    //    if (txtPZIP.Text == "")
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Please enter the PIN code.");
    //        txtPZIP.Focus();
    //        return false;
    //    }

    //    if (txtmob.Text == "")
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Please enter Mobile No.");
    //        txtmob.Focus();
    //        return false;
    //    } if (ddlPayMode.SelectedItem.Value == "0")
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Please select payment mode.");

    //        return false;
    //    }

    //    if (!checkValidString(txtLName.Text))//check with regular expression
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Plz Enter Valid Student's  Last Name");
    //        return false;
    //    }
    //    if (!checkValidString(txtFFname.Text))//check with regular expression
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Plz Enter Valid Father's First Name");
    //        return false;
    //    }

    //    if (!checkValidString(txtFLname.Text))//check with regular expression
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Plz Enter Valid Father's Last Name");
    //        return false;
    //    }

    //    return true;
    //}

    //protected void ddlClass_SelectedIndexChanged1(object sender, EventArgs e)
    //{
    //    if (ddlClass.SelectedIndex != 0)
    //    {
    //        txtClassSec.Text = ddlClass.SelectedItem.Text;
    //        double amount = Convert.ToDouble(objdut.GetScalar("select fees from classfee_master where Classid=" + ddlClass.SelectedValue + " and Brid=" + Convert.ToDouble(Session["BrBrid"]) + " and FeeName='Registration Fee'"));
    //        ViewState["amount"] = amount;

    //        txtRegFee.Text = "Rs " + string.Format("{0:f}", amount);
    //        if (amount > 0)
    //        {
    //            ddlPayMode.Enabled = true;
    //            txtRegFee.Enabled = false;
    //        }
    //    }
    //    else
    //    {
    //        txtRegFee.Text = "Rs " + string.Format("{0:f}", 0.00);
    //        ddlPayMode.SelectedIndex = 0;
    //        lblbnk.Visible = false;
    //        txtbnkname.Visible = false;

    //        lblchk.Visible = false;
    //        txtchck.Visible = false;
    //    }
    //}

    [WebMethod]
    public static string bindclass(string Classid)
    {
        // List<classmaster> details = new List<classmaster>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select isnull(fees,0) from classfee_master where Classid=" + Classid + " and Brid=" + Convert.ToDouble(HttpContext.Current.Session["BrBrid"]) + " and FeeName='Registration Fee'", con))
            {
                con.Open();
                string fees = cmd.ExecuteScalar().ToString();
                con.Close();
                return fees;
            }
        }
    }

    public void getdate()
    {
        string date = (DateTime.Today.Date).ToShortDateString();
        txtAdmDate.Text = Convert.ToDateTime(date).ToString("dd/MM/yyyy");
    }

    protected void txtFiName_TextChanged1(object sender, EventArgs e)
    {
        int mid = Convert.ToInt32(objdut.GetScalar("select isnull(max(Rid),0) from tbl_StudentRegistration"));

        mid = mid + 1;
        string rno = txtFiName.Text.Trim();
        int len = rno.Length;
        if (len > 4)
        {
            rno = txtFiName.Text.Substring(0, 4);
        }
        else if ((len < 4) && (len > 0))
        {
            rno = txtFiName.Text;
        }
        else
        {
            rno = "";
        }
        TextBox11.Focus();
    }

    //protected void txtToDate_TextChanged(object sender, EventArgs e)
    //{
    //    DateTime StartDate;
    //    if (txtToDate.Text == "")
    //    {
    //        DateTimeLabel.Text = "";
    //        return;
    //    }
    //    try
    //    {
    //        StartDate = Convert.ToDateTime(txtToDate.Text.ToString());
    //    }
    //    catch
    //    {
    //        txtToDate.Text = "";
    //        Utility.ViewAlertMessage(Page, "please select valid date.");
    //        return;
    //    }
    //    DateTime EndDate;
    //    TimeSpan Difference;

    //    string datetime = objdut.GetScalar("select GETDATE()").ToString(); //DateTime.Now.ToString("MM/dd/yyyy");

    //    EndDate = Convert.ToDateTime(datetime.ToString());

    //    if (StartDate > EndDate)
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Student age should be less than current date.");
    //        txtToDate.Focus();
    //        txtToDate.Text = "";
    //        DateTimeLabel.Text = "";

    //        return;
    //    }
    //    else
    //    {
    //        Difference = EndDate.Subtract(StartDate);
    //        int month = Convert.ToInt32(Difference.TotalDays);
    //        int numberOfDays = month;
    //        DateTime date = new DateTime(new TimeSpan(numberOfDays, 0, 0, 0).Ticks);
    //        string trt = string.Format("{0} year(s), {1} month(s) and {2} day(s)", date.Year - 1, date.Month - 1, date.Day - 1);

    //        int currentyear = Convert.ToInt32(trt.Substring(0, 2));

    //        int limits = Convert.ToInt32(objdut.GetScalar("select LIMITS from Settings where sID=2 and Active=1"));
    //        if (limits <= currentyear)
    //        {
    //            DateTimeLabel.Text = "Age : " + trt;
    //            txtFFname.Focus();
    //        }
    //        else
    //        {
    //            Utility.ViewAlertMessage(this.Master.Page, "Student age should be atleast three years old.");
    //            txtToDate.Focus();
    //            txtToDate.Text = "";
    //            DateTimeLabel.Text = "";
    //            return;
    //        }
    //    }
    //}

    public bool checkValidString(string input)
    {
        const string regExpr = @"^[a-zA-Z]+$"; //regular expression for valid string
        // match input with regular expression
        System.Text.RegularExpressions.Match m = System.Text.RegularExpressions.Regex.Match(input, regExpr);
        if (m.Success)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    //protected void ddlPayMode_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if ((ddlPayMode.SelectedIndex == 0))
    //    {
    //        lblbnk.Visible = false;
    //        lblchk.Visible = false;
    //        txtbnkname.Visible = false;
    //        txtchck.Visible = false;
    //    }
    //    if ((ddlPayMode.SelectedIndex == 1))
    //    {
    //        lblbnk.Visible = false;
    //        lblchk.Visible = false;
    //        txtbnkname.Visible = false;
    //        txtchck.Visible = false;
    //        if (ddlClass.SelectedIndex == 0)
    //        {
    //            ddlPayMode.SelectedIndex = 0;
    //            Utility.ViewAlertMessage(this.Master.Page, "Please Select Class");
    //            return;
    //        }
    //    }

    //    if (ddlPayMode.SelectedIndex > 1)
    //    {
    //        if (ddlClass.SelectedIndex == 0)
    //        {
    //            ddlPayMode.SelectedIndex = 0;
    //            Utility.ViewAlertMessage(this.Master.Page, "Please Select Class");
    //            return;
    //        }
    //        lblbnk.Visible = true;
    //        lblchk.Visible = true;
    //        txtbnkname.Visible = true;
    //        txtchck.Visible = true;
    //    }
    //}

    //private void clear()
    // {
    //     divcash.Visible = false;
    //     divcheq.Visible = false;
    //     //txtbnkname.Visible = false;
    //     //txtchck.Visible = false;
    // }

    //protected void txtRegFee_TextChanged(object sender, EventArgs e)
    //{
    //    if (ddlClass.SelectedIndex == 0)
    //    {
    //        txtRegFee.Text = "";
    //        Utility.ViewAlertMessage(this.Master.Page, "First Select Class");
    //        return;
    //    }
    //    else
    //    {
    //        txtRegFee.Enabled = false;
    //    }
    //}
}