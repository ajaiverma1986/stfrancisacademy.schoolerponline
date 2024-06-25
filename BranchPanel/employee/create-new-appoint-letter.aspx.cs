using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Globalization;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_create_new_appoint_letter : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();
    private DataTable dtTemp = null;
    private CommonClass objCL = new CommonClass();
    private string refno = "", finalfilename = "", finalpicname = "", multifile = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString());
            reset();
            FillDDL();
            FillExperience();
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["update"] = Session["update"];
    }

    [WebMethod]
    public static int checkstatus(string refno)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            SqlParameter[] param = new SqlParameter[2];
            param[0] = new SqlParameter("@Refno", refno);
            param[1] = new SqlParameter("@intresult", 0);
            param[1].Direction = ParameterDirection.Output;
            DataUtility duobj = new DataUtility();
            int result = duobj.ExecuteSqlSP(param, "usp_forcheckrefnostatus");
            return result;
        }
    }

    //protected void txtRefNo_TextChanged(object sender, EventArgs e)
    //{
    //    if (!string.IsNullOrEmpty(txtRefNo.Text.Trim()))
    //    {
    //        SqlParameter[] param = new SqlParameter[2];
    //        param[0] = new SqlParameter("@Refno", Convert.ToString(txtRefNo.Text.Trim()));
    //        param[1] = new SqlParameter("@intResult", Convert.ToInt32(0));
    //        param[1].Direction = ParameterDirection.Output;
    //        int result = objDUT.ExecuteSqlSP(param, "[usp_forcheckrefnostatus]");
    //        if (result == 1)
    //        {
    //            fillallcontrols();
    //            lblalreadyexistmsg.Visible = false;
    //        }
    //        else if (result == 2)
    //        {
    //            lblalreadyexistmsg.Visible = true;
    //            txtRefNo.Text = "";
    //        }
    //        else if (result == 3)
    //        {
    //            lblalreadyexistmsg.Visible = true;
    //            lblalreadyexistmsg.Text = "Only offered and reoffered candidate can be an employee.";
    //            txtRefNo.Text = "";
    //        }
    //        else
    //        {
    //            lblalreadyexistmsg.Visible = true;
    //            lblalreadyexistmsg.Text = "There is no offered given with this offered refrence no";
    //            txtRefNo.Text = "";
    //        }
    //    }
    //}

    //================== this function is for filling all controls==================
    [WebMethod]
    public static fillcontrol[] Fill_allControls(string refno)
    {
        DataTable dt = new DataTable();
        List<fillcontrol> details = new List<fillcontrol>();

        SqlParameter[] p = new SqlParameter[2];
        p[0] = new SqlParameter("@refno", refno);
        p[1] = new SqlParameter("@mode", 2);
        DataUtility ObjDUT = new DataUtility();
        dt = ObjDUT.GetDataTableSP(p, "usp_getRecords");
        foreach (DataRow dtrow in dt.Rows)
        {
            fillcontrol user = new fillcontrol();
            user.DOB = Convert.ToDateTime(dtrow["DOB"].ToString()).ToString("dd/MM/yyyy");
            user.fname = dtrow["fname"].ToString();
            user.mname = dtrow["mname"].ToString();
            user.lname = dtrow["lname"].ToString();
            user.gender = dtrow["gender"].ToString();//
            user.address = dtrow["address"].ToString();
            user.pincode = dtrow["pincode"].ToString();
            user.doj = Convert.ToDateTime(dtrow["doj"].ToString()).ToString("dd/MM/yyyy");
            user.dateofinterview = Convert.ToDateTime(dtrow["dateofinterview"].ToString()).ToString("dd/MM/yyyy"); ;
            user.annualCTC = Convert.ToDecimal(dtrow["annualCTC"].ToString()).ToString("0.00");
            user.emplyeetype = dtrow["emplyeetype"].ToString();
            user.inhandsalary = Convert.ToDecimal(dtrow["inhandsalary"].ToString()).ToString("0.00");
            user.hrname = dtrow["hrname"].ToString();
            user.mobile = dtrow["mobile"].ToString();
            user.emailid = dtrow["emailid"].ToString();
            user.cid = dtrow["cid"].ToString();
            user.sid = dtrow["sid"].ToString();
            user.ctid = dtrow["ctid"].ToString();
            user.title = dtrow["title"].ToString();
            user.deptid = dtrow["deptid"].ToString();
            user.desigtype = dtrow["desigtype"].ToString();
            details.Add(user);
        }
        return details.ToArray();
    }

    public class fillcontrol
    {
        public string DOB { get; set; }

        public string fname { get; set; }

        public string mname { get; set; }

        public string lname { get; set; }

        public string gender { get; set; }

        public string address { get; set; }

        public string pincode { get; set; }

        public string doj { get; set; }

        public string dateofinterview { get; set; }

        public string annualCTC { get; set; }

        public string emplyeetype { get; set; }

        public string inhandsalary { get; set; }

        public string hrname { get; set; }

        public string mobile { get; set; }

        public string emailid { get; set; }

        public string cid { get; set; }

        public string sid { get; set; }

        public string ctid { get; set; }

        public string title { get; set; }

        public string deptid { get; set; }

        public string desigtype { get; set; }
    }

    //public void fillallcontrols()
    //{
    //    try
    //    {
    //        SqlParameter[] param = new SqlParameter[2];
    //        param[0] = new SqlParameter("@refno", txtRefNo.Text.Trim());
    //        param[1] = new SqlParameter("@mode", 2);
    //        DataTable dtTemp = objDUT.GetDataTableSP(param, "usp_getRecords");

    //        if (dtTemp.Rows.Count > 0)
    //        {
    //            txtdob.Text = Convert.ToDateTime(dtTemp.Rows[0]["DOB"].ToString()).ToString("dd/MM/yyyy");
    //            txtFName.Text = dtTemp.Rows[0]["fname"].ToString();
    //            txtMName.Text = dtTemp.Rows[0]["mname"].ToString();
    //            txtLName.Text = dtTemp.Rows[0]["lname"].ToString();
    //            rdGender.SelectedValue = Convert.ToInt16(dtTemp.Rows[0]["gender"]).ToString();
    //            txtFName.Text = dtTemp.Rows[0]["fname"].ToString();
    //            txtcurrentaddress.Text = dtTemp.Rows[0]["address"].ToString();
    //            txtpincode2.Text = dtTemp.Rows[0]["pincode"].ToString();
    //            txtDatejoining.Text = Convert.ToDateTime(dtTemp.Rows[0]["doj"].ToString()).ToString("dd/MM/yyyy");

    //            txtdoi.Text = dtTemp.Rows[0]["dateofinterview"].ToString();

    //            txtannualctc.Text = Convert.ToDecimal(dtTemp.Rows[0]["annualCTC"].ToString()).ToString("0.00");
    //            if (dtTemp.Rows[0]["emplyeetype"].ToString() == "1")
    //            {
    //                rdblistforemployee.SelectedValue = "1";
    //            }
    //            else
    //            {
    //                rdblistforemployee.SelectedValue = "2";
    //            }
    //            txtinhandsalary.Text = Convert.ToDecimal(dtTemp.Rows[0]["inhandsalary"].ToString()).ToString("0.00");

    //            txtHrName.Text = dtTemp.Rows[0]["hrname"].ToString();
    //            txtContactNo.Text = dtTemp.Rows[0]["mobile"].ToString();
    //            txtEmailid.Text = dtTemp.Rows[0]["emailid"].ToString();
    //            int cid = Convert.ToInt16(dtTemp.Rows[0]["cid"]);
    //            int sid = Convert.ToInt16(dtTemp.Rows[0]["sid"]);
    //            int ctid = Convert.ToInt16(dtTemp.Rows[0]["ctid"]);

    //            ddlTitle.SelectedValue = dtTemp.Rows[0]["title"].ToString();
    //            ddlCountry2.SelectedValue = cid.ToString();
    //            ddlCountry.SelectedValue = cid.ToString();
    //            DataTable dtstate = new DataTable();
    //            dtstate = objCL.Dll("Statedll", cid);
    //            if (dtstate.Rows.Count == 0)
    //            {
    //                ddlState2.Items.Insert(0, "Select State");
    //                Utility.ViewAlertMessage(Page, "No State for this country");
    //                return;
    //            }
    //            ddlState2.DataSource = dtstate;
    //            ddlState2.DataTextField = "stateName";
    //            ddlState2.DataValueField = "SID";
    //            ddlState2.DataBind();
    //            ddlState2.SelectedValue = sid.ToString();

    //            ddlState.DataSource = dtstate;
    //            ddlState.DataTextField = "stateName";
    //            ddlState.DataValueField = "SID";
    //            ddlState.DataBind();
    //            ddlState.SelectedValue = sid.ToString();

    //            DataTable dtcity = new DataTable();
    //            dtcity = objCL.Dll("Citydll", sid);
    //            if (dtcity.Rows.Count == 0)
    //            {
    //                ddlCity.Items.Insert(0, "--Select--");
    //                Utility.ViewAlertMessage(Page, "No city for this state");
    //                return;
    //            }
    //            ddlCity2.DataSource = dtcity;
    //            ddlCity2.DataTextField = "cityname";
    //            ddlCity2.DataValueField = "ctid";
    //            ddlCity2.DataBind();
    //            ddlCity2.SelectedValue = ctid.ToString();

    //            ddlCity.DataSource = dtcity;
    //            ddlCity.DataTextField = "cityname";
    //            ddlCity.DataValueField = "ctid";
    //            ddlCity.DataBind();
    //            ddlCity.SelectedValue = ctid.ToString();

    //            ddl_dept.SelectedValue = dtTemp.Rows[0]["deptid"].ToString();

    //            DataTable dtfordesignation = objDUT.GetDataTable("select desid,desname from tbl_ddmaster where did=" + Convert.ToInt32(dtTemp.Rows[0]["deptid"]) + "");
    //            if (dtfordesignation.Rows.Count > 0)
    //            {
    //                ddlDesigNation.DataSource = dtfordesignation;
    //                ddlDesigNation.DataValueField = "desid";
    //                ddlDesigNation.DataTextField = "desname";
    //                ddlDesigNation.DataBind();
    //            }
    //            ddlDesigNation.SelectedValue = dtTemp.Rows[0]["desigtype"].ToString();
    //            txtRefNo.ReadOnly = true;
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}

    protected void FillDDL()
    {
        ddlBranch.DataSource = CommonClass.ABC("BranchDll");
        ddlBranch.DataTextField = "BrName";
        ddlBranch.DataValueField = "BrId";
        ddlBranch.DataBind();
        ddlBranch.Items.Insert(0, new ListItem("---Select Branch---", "0"));
        ddlBranch.SelectedValue = Session["BrBrid"].ToString();
        ddlBranch.Enabled = false;

        ddlTitle.DataSource = CommonClass.ABC("ddlTitle");
        ddlTitle.DataTextField = "Title";
        ddlTitle.DataValueField = "Titleid";
        ddlTitle.DataBind();
        ddlTitle.Items.Insert(0, new ListItem("---Select Title---", "0"));

        ddlCountry.DataSource = CommonClass.ABC("Countrydll");
        ddlCountry.DataTextField = "countryName";
        ddlCountry.DataValueField = "CID";
        ddlCountry.DataBind();
        ddlCountry.Items.Insert(0, new ListItem("---Select Country---", "0"));

        ddlPCountry.DataSource = CommonClass.ABC("Countrydll");
        ddlPCountry.DataTextField = "countryName";
        ddlPCountry.DataValueField = "CID";
        ddlPCountry.DataBind();
        ddlPCountry.Items.Insert(0, new ListItem("---Select Country---", "0"));

        ddlCountry2.DataSource = CommonClass.ABC("Countrydll");
        ddlCountry2.DataTextField = "countryName";
        ddlCountry2.DataValueField = "CID";
        ddlCountry2.DataBind();
        ddlCountry2.Items.Insert(0, new ListItem("---Select Country---", "0"));

        ddlProbationPeriod.DataSource = CommonClass.ABC("ddlProbationPeriod");
        ddlProbationPeriod.DataTextField = "timeInMonth";
        ddlProbationPeriod.DataValueField = "id";
        ddlProbationPeriod.DataBind();
        ddlProbationPeriod.Items.Insert(0, new ListItem("---Select Probation Period---", "0"));

        ddlbloodgroup.DataSource = CommonClass.ABC("ddlbloodgroup");
        ddlbloodgroup.DataTextField = "bgname";
        ddlbloodgroup.DataValueField = "bgid";
        ddlbloodgroup.DataBind();
        ddlbloodgroup.Items.Insert(0, new ListItem("---Select Blood Group ---", "0"));

        ddlidproof.DataSource = CommonClass.ABC("idproof");
        ddlidproof.DataTextField = "name";
        ddlidproof.DataValueField = "proof_id";
        ddlidproof.DataBind();
        ddlidproof.Items.Insert(0, new ListItem("---Select ID Proof---", "0"));

        ddlresidentioalproof.DataSource = CommonClass.ABC("residenceproof");
        ddlresidentioalproof.DataTextField = "name";
        ddlresidentioalproof.DataValueField = "proof_id";
        ddlresidentioalproof.DataBind();
        ddlresidentioalproof.Items.Insert(0, new ListItem("---Select Residential Proof---", "0"));

        DataTable dtDesignation = objDUT.GetDataTable("select deptid,deptname from dept_master where status=1");
        if (dtDesignation.Rows.Count > 0)
        {
            ddl_dept.DataSource = dtDesignation;
            ddl_dept.DataTextField = "deptname";
            ddl_dept.DataValueField = "deptid";
            ddl_dept.DataBind();
            ddl_dept.Items.Insert(0, new ListItem("---Select Department---", "0"));
        }
    }

    protected void FillExperience()
    {
        ddlyear.Items.Insert(0, new ListItem("---Years---", "0"));
        for (int i = 1; i <= 12; i++)
        {
            ddlyear.Items.Insert(i, new ListItem((i - 1).ToString(), (i - 1).ToString()));
        }

        ddlmonth.Items.Insert(0, new ListItem("---Months---", "0"));
        for (int i = 1; i <= 12; i++)
        {
            ddlmonth.Items.Insert(i, new ListItem((i - 1).ToString(), (i - 1).ToString()));
        }
        ddlday.Items.Insert(0, new ListItem("---Days---", "0"));
        for (int i = 0; i <= 30; i++)
        {
            ddlday.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
        }
    }

    protected void btnSubmit_Click2(object sender, EventArgs e)
    {
        add_Employee();
    }

    public void add_Employee()
    {
        if (Session["update"].ToString() == ViewState["update"].ToString())
        {
            //try
            //{
            string Fname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtFName.Text.Trim());
            string mname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtMName.Text.Trim());
            string lastname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtLName.Text.Trim());

            refno = objDUT.GetScalar("SELECT cast(RAND()*10000 as int) AS [RandomNumber]").ToString();

            SqlParameter[] param = new SqlParameter[113];

            param[0] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));
            param[1] = new SqlParameter("@refNo", txtRefNo.Text.Trim());
            param[2] = new SqlParameter("@staffID", "");
            param[3] = new SqlParameter("@title", ddlTitle.SelectedValue);
            param[4] = new SqlParameter("@fname", Fname);
            param[5] = new SqlParameter("@mname", mname);
            param[6] = new SqlParameter("@lname", lastname);
            param[7] = new SqlParameter("@gender", Convert.ToInt16(rdGender.SelectedValue));
            param[8] = new SqlParameter("@birthPlace", txtforbirthplace.Text.Trim());
            param[9] = new SqlParameter("@cid", Convert.ToInt16(ddlCountry.SelectedValue));
            param[10] = new SqlParameter("@sid", Convert.ToInt16(Request.Form[ddlState.UniqueID]));
            param[11] = new SqlParameter("@ctid", Convert.ToInt16(Request.Form[ddlCity.UniqueID]));
            param[12] = new SqlParameter("@address", txtAddressLine.Text.Trim());
            param[13] = new SqlParameter("@pinCode", txtPincode.Text.Trim());
            param[14] = new SqlParameter("@Tcid", Convert.ToInt16(ddlCountry2.SelectedValue));
            param[15] = new SqlParameter("@Tsid", Convert.ToInt16(Request.Form[ddlState2.UniqueID]));
            param[16] = new SqlParameter("@Tctid", Convert.ToInt16(Request.Form[ddlCity2.UniqueID]));
            param[17] = new SqlParameter("@Taddress", txtcurrentaddress.Text.Trim());
            param[18] = new SqlParameter("@TpinCode", txtpincode2.Text.Trim());

            decimal salary = 0;
            if (this.hidden.Value != "")
            {
                salary = Convert.ToDecimal(this.hidden.Value);
            }
            else
            {
                // salary = Convert.ToDecimal(txtinhandsalary.Text); MKG
                decimal.TryParse(Convert.ToString(txtinhandsalary.Text), out salary);
            }
            if (salary != 0)
            {
                param[19] = new SqlParameter("@salary", salary);
            }
            else
            {
                param[19] = new SqlParameter("@salary", 0.00);
            }
            param[20] = new SqlParameter("@branchID", Convert.ToInt16(Session["BrBrid"]));
            param[21] = new SqlParameter("@probationPeriond", Convert.ToInt16(ddlProbationPeriod.SelectedValue));
            param[22] = new SqlParameter("@hrName", txtHrName.Text.Trim());
            param[23] = new SqlParameter("@mobile", txtContactNo.Text.Trim());
            param[24] = new SqlParameter("@phone", txtPhoneNo.Text.Trim());
            param[25] = new SqlParameter("@emailID", txtEmailid.Text.Trim());
            param[26] = new SqlParameter("@messanger", "");

            param[27] = new SqlParameter("@HQualificaton", txtqualification.Text.Trim());
            param[28] = new SqlParameter("@education_board", txtboard.Text.Trim());

            param[29] = new SqlParameter("@passing_year", txtyear.Text.Trim());
            param[30] = new SqlParameter("@session", txtsession.Text.Trim());

            param[31] = new SqlParameter("@mStatus", Convert.ToInt32(rblMStatus.SelectedValue));
            if (txtChild.Text != "")
            {
                param[32] = new SqlParameter("@noOfChilds", Convert.ToInt16(txtChild.Text));
            }
            else
            {
                param[32] = new SqlParameter("@noOfChilds", 0);
            }
            param[33] = new SqlParameter("@father", txtF1name.Text.Trim());
            param[34] = new SqlParameter("@mother", txtMotherName.Text.Trim());

            string pancard = CultureInfo.CurrentCulture.TextInfo.ToUpper(txtPanNo.Text.Trim());

            param[35] = new SqlParameter("@panNo", pancard);

            int idindex = ddlidproof.SelectedIndex;
            string idproof = CultureInfo.CurrentCulture.TextInfo.ToUpper(txtidproof.Text.Trim());

            if (idindex > 0)
            {
                param[36] = new SqlParameter("id_proof_id", ddlidproof.SelectedValue);
                param[37] = new SqlParameter("@id_proof_number", idproof);
            }
            else
            {
                param[36] = new SqlParameter("id_proof_id", "0");
                param[37] = new SqlParameter("@id_proof_number", "");   // ====================
            }

            int resindex = ddlresidentioalproof.SelectedIndex;
            string residproof = CultureInfo.CurrentCulture.TextInfo.ToUpper(txtresidenceproof.Text.Trim());
            if (resindex > 0)
            {
                param[38] = new SqlParameter("@residential_id", ddlresidentioalproof.SelectedValue);
                param[39] = new SqlParameter("@residential_proof_number", residproof);
            }
            else
            {
                param[38] = new SqlParameter("@residential_id", "0");// ====================
                param[39] = new SqlParameter("@residential_proof_number", "");
            }

            param[40] = new SqlParameter("@comments", txtComment.Text.Trim());

            if (fileuploadforcv1.HasFile)
            {
                // Comment by MKG
                /* foreach (HttpPostedFile postedfile in fileuploadforcv1.PostedFiles)
                 {
                     finalfilename = refno.ToString() + postedfile.FileName;
                     fileuploadforcv1.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
                     multifile += finalfilename + ",";
                 }
                 param[41] = new SqlParameter("@cv", multifile);
                 multifile = "";*/

                param[41] = new SqlParameter("@cv", ""); // add by MKG
            }
            else
            {
                param[41] = new SqlParameter("@cv", "");
            }

            List<String> documentlist = new List<String>();

            foreach (ListItem item in chkboxlistfordocuments.Items)
            {
                if (item.Selected)
                {
                    documentlist.Add(item.Value);
                }
            }
            string finaldocs = String.Join(",", documentlist.ToArray());

            param[42] = new SqlParameter("@isDocumentSubmit", finaldocs);

            param[43] = new SqlParameter("@emailAlloted", txtEmailAlloted.Text.Trim());
            param[44] = new SqlParameter("@preOrganisation", txtPorganisation.Text.Trim());
            param[45] = new SqlParameter("@pCid", Convert.ToInt16(Request.Form[ddlPCountry.UniqueID]));
            param[46] = new SqlParameter("@pSid", Convert.ToInt16(Request.Form[ddlPstate.UniqueID]));
            param[47] = new SqlParameter("@pCtid", Convert.ToInt16(Request.Form[ddlPCity.UniqueID]));
            param[48] = new SqlParameter("@pPincode", txtPPincode.Text.Trim());
            param[49] = new SqlParameter("@pDesignation", txtPdesignation.Text.Trim());
            if (txtPsalary.Text != "")
            {
                param[50] = new SqlParameter("@pSalary", Convert.ToDecimal(txtPsalary.Text.Trim()));
            }
            else
            {
                param[50] = new SqlParameter("@pSalary", 0.00);
            }

            param[51] = new SqlParameter("@pDuration", 0);

            string totalexperience = ddlyear.SelectedValue + "," + ddlmonth.SelectedValue;

            param[52] = new SqlParameter("@totalExperience", totalexperience);
            param[53] = new SqlParameter("@ref1Name", txtRef1Name.Text.Trim());
            param[54] = new SqlParameter("@ref1Contact", txtReContact1.Text.Trim());
            param[55] = new SqlParameter("@ref2Name", txtRef2Name.Text.Trim());
            param[56] = new SqlParameter("@ref2Contact", txtRefContact2.Text.Trim());

            if (ddlbloodgroup.SelectedValue != "0")
            {
                param[57] = new SqlParameter("@bloodGroup", ddlbloodgroup.SelectedItem.Text.Trim());
            }
            else
            {
                param[57] = new SqlParameter("@bloodGroup", "");
            }
            param[58] = new SqlParameter("@medicalCondition", txtmedicalCondition.Text.Trim());
            param[59] = new SqlParameter("@pastDeseas", txtPastDisease.Text.Trim());
            param[60] = new SqlParameter("@geneticDeseas", txtGeneticDisease.Text.Trim());
            param[61] = new SqlParameter("@anyAlergy", txtAnyEllergy.Text.Trim());
            param[62] = new SqlParameter("@accountNo", txtAccountNo.Text.Trim());
            param[63] = new SqlParameter("@bankName", txtBankName.Text.Trim());
            param[64] = new SqlParameter("@branchName", txtBranchName.Text.Trim());
            param[65] = new SqlParameter("@branchCode", txtBranchCode.Text.Trim());

            string ifsc = CultureInfo.CurrentCulture.TextInfo.ToUpper(txtIFSCCode.Text.Trim());

            param[66] = new SqlParameter("@IFSC", ifsc);
            param[67] = new SqlParameter("@mode", 1);
            param[68] = new SqlParameter("@intResult", Convert.ToInt32(0));
            param[68].Direction = ParameterDirection.Output;

            if (fileuploadforpic.HasFile)
            {
                string filename = Path.GetFileName(fileuploadforpic.PostedFile.FileName);
                string targetPath = Server.MapPath(("~/employeeimage/" + refno.ToString() + filename));
                Stream strm = fileuploadforpic.PostedFile.InputStream;
                var targetFile = targetPath;
                GenerateThumbnails(0.5, strm, targetFile);
                param[69] = new SqlParameter("@photo", refno.ToString() + filename);
            }
            else
            {
                param[69] = new SqlParameter("@photo", "");
            }

            if (ddl_dept.SelectedIndex > 0)
            {
                param[70] = new SqlParameter("@department", ddl_dept.SelectedItem.Text);
                param[71] = new SqlParameter("@departmentID", ddl_dept.SelectedValue);
            }
            else
            {
                param[70] = new SqlParameter("@department", "");
                param[71] = new SqlParameter("@departmentID", 0);
            }

            var value = Request.Form[ddlDesigNation.UniqueID];
            var text = ddlDesigNation.Items.FindByValue(value);

            if (value != "0")
            {
                param[72] = new SqlParameter("@jobTitle", Request.Form[ddlDesigNation.Text]);
                param[73] = new SqlParameter("@desigType", Convert.ToInt16(Request.Form[ddlDesigNation.UniqueID]));
                param[74] = new SqlParameter("@designation", Request.Form[ddlDesigNation.Text]);
            }
            else
            {
                param[72] = new SqlParameter("@jobTitle", "");
                param[73] = new SqlParameter("@desigType", 0);
                param[74] = new SqlParameter("@designation", "");
            }

            param[75] = new SqlParameter("@facid", Convert.ToInt16(ViewState["eid"]));
            decimal _ctc = 0;
            if (txtannualctc.UniqueID != "")
            {
                decimal.TryParse(Convert.ToString(txtannualctc.Text), out _ctc);
                //param[76] = new SqlParameter("@ctc", Convert.ToDecimal(Request.Form[txtannualctc.UniqueID]));
                param[76] = new SqlParameter("@ctc", _ctc);
            }
            else
            {
                param[76] = new SqlParameter("@ctc", 0.00);
            }

            string ctcapp = Request.Form[txtctcappliedfrom.UniqueID];
            if (ctcapp != "")
            {
                string[] ctcappfrom = ctcapp.Split('/');
                ctcapp = ctcappfrom[2] + '-' + ctcappfrom[1] + '-' + ctcappfrom[0];
            }

            param[77] = new SqlParameter("@ctcappliedfrom", ctcapp);

            param[78] = new SqlParameter("@pAddress", txtPaddress.Text.Trim());

            param[79] = new SqlParameter("@nationality", rdblistfornationality.SelectedValue);

            param[80] = new SqlParameter("@fathercontactno", txtf1mobileno.Text.Trim());
            param[81] = new SqlParameter("@mothercontactno", txtmothermobileno.Text.Trim());
            param[82] = new SqlParameter("@parentsaddress", txtparentsaddress.Text.Trim());

            string pfno = CultureInfo.CurrentCulture.TextInfo.ToUpper(txtpfno.Text.Trim());
            string esino = CultureInfo.CurrentCulture.TextInfo.ToUpper(txtesino.Text.Trim());

            param[83] = new SqlParameter("@pfno", pfno);
            param[84] = new SqlParameter("@esino", esino);

            param[85] = new SqlParameter("@AddBiometric_Card_No", txtbiometricdetails.Text.Trim());

            if (rdblistforemployee.SelectedValue == "1")
            {
                param[86] = new SqlParameter("@employeetype", 1);
            }
            else
            {
                param[86] = new SqlParameter("@employeetype", 2);
            }

            param[87] = new SqlParameter("@current_address_landmark", txtcurrentlandmark.Text);
            param[88] = new SqlParameter("@permanent_address_landmark", txtpermanentlandmark.Text);

            param[89] = new SqlParameter("@other_nationality", txtothernationality.Text);

            if (fileuploadforexperienceltr.HasFile)
            {
                // comment by MKG
                /* foreach (HttpPostedFile postedfile in fileuploadforexperienceltr.PostedFiles)
                 {
                     finalfilename = refno.ToString() + postedfile.FileName;
                     fileuploadforexperienceltr.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
                     multifile += finalfilename + ",";
                 }
                 param[90] = new SqlParameter("@experience_letter", multifile);
                 multifile = "";*/
                param[90] = new SqlParameter("@experience_letter", ""); // add by MKG
            }
            else
            {
                param[90] = new SqlParameter("@experience_letter", "");
            }
            string tds = CultureInfo.CurrentCulture.TextInfo.ToUpper(txttdsaccntno.Text.Trim());
            param[91] = new SqlParameter("@tds_account_number", tds);

            param[92] = new SqlParameter("@father_alternate_no", txtfatheralternateno.Text.Trim());

            //============code for salary slip insert===========
            if (fileuploadforsalaryslip.HasFile)
            {
                // comment by MKG
                /*foreach (HttpPostedFile postedfile in fileuploadforsalaryslip.PostedFiles)
                {
                    finalfilename = refno + postedfile.FileName;
                    fileuploadforsalaryslip.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
                    multifile += finalfilename + ",";
                }
                param[93] = new SqlParameter("@salary_slip", multifile);
                multifile = "";*/
                param[93] = new SqlParameter("@salary_slip", ""); // add by MKG
            }
            else
            {
                param[93] = new SqlParameter("@salary_slip", "");
            }
            //============code for Appointment letter insert===========
            if (fileuploadforappointmentleter.HasFile)
            {
                // comment by MKG
                /* foreach (HttpPostedFile postedfile in fileuploadforappointmentleter.PostedFiles)
                 {
                     finalfilename = refno + postedfile.FileName;
                     fileuploadforappointmentleter.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
                     multifile += finalfilename + ",";
                 }
                 param[94] = new SqlParameter("@appointment_letter", multifile);
                 multifile = "";*/
                param[94] = new SqlParameter("@appointment_letter", ""); // add by MKG
            }
            else
            {
                param[94] = new SqlParameter("@appointment_letter", "");
            }

            //============code for resignation_letter letter insert===========
            if (fileuploadforresignationltr.HasFile)
            {
                // comment by MKG
                /* foreach (HttpPostedFile postedfile in fileuploadforresignationltr.PostedFiles)
                 {
                     finalfilename = refno + postedfile.FileName;
                     fileuploadforresignationltr.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
                     multifile += finalfilename + ",";
                 }
                 param[95] = new SqlParameter("@resignation_letter", multifile);
                 multifile = "";*/

                param[95] = new SqlParameter("@resignation_letter", ""); // add by MKG
            }
            else
            {
                param[95] = new SqlParameter("@resignation_letter", "");
            }

            //============code for Offer letter insert===========

            if (fileuploadforofferletter.HasFile)
            {
                // comment by MKG
                /* foreach (HttpPostedFile postedfile in fileuploadforofferletter.PostedFiles)
                 {
                     finalfilename = refno + postedfile.FileName;
                     fileuploadforofferletter.SaveAs(Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfilename));
                     multifile += finalfilename + ",";
                 }
                 param[96] = new SqlParameter("@offer_letter", multifile);
                 multifile = "";*/

                param[96] = new SqlParameter("@offer_letter", ""); // add by MKG
            }
            else
            {
                param[96] = new SqlParameter("@offer_letter", "");
            }
            param[97] = new SqlParameter("@rollnumber", txtrollnumber.Text.Trim());
            param[98] = new SqlParameter("@percentage", txtpercent.Text.Trim());
            param[99] = new SqlParameter("@institute_address", txtinstituteaddress.Text.Trim());

            param[100] = new SqlParameter("@father_emailid", txtfatheremailid.Text.Trim());
            param[101] = new SqlParameter("@father_occupation", txtfatheroccupation.Text.Trim());

            if (txtfatherannualincome.Text != "")
            {
                param[102] = new SqlParameter("@father_annual_income", Convert.ToDecimal(txtfatherannualincome.Text.Trim()));
            }
            else
            {
                param[102] = new SqlParameter("@father_annual_income", 0.00);
            }

            param[103] = new SqlParameter("@currentaddresstype", rdbforcurrentaddresstype.SelectedValue);
            param[104] = new SqlParameter("@permanentaddresstype", rdbpermanentaddresstype.SelectedValue);

            if (fileuploadforid.HasFile)
            {
                string filename = Path.GetFileName(fileuploadforid.PostedFile.FileName);
                string finalfinalfilename = refno.ToString() + filename;
                Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + finalfinalfilename);
                param[105] = new SqlParameter("@id_proof_file", finalfinalfilename);
            }
            else
            {
                param[105] = new SqlParameter("@id_proof_file", "");
            }

            if (fileuploadforresidential.HasFile)
            {
                string filenameforres = Path.GetFileName(fileuploadforresidential.PostedFile.FileName);
                string ffn = refno.ToString() + filenameforres;
                Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + ffn);
                param[106] = new SqlParameter("@residential_proof_file", ffn);
            }
            else
            {
                param[106] = new SqlParameter("@residential_proof_file", "");
            }

            if (txtcurrentadd_othercity.Text.Trim() != "")
            {
                param[107] = new SqlParameter("@currentadd_othercity", txtcurrentadd_othercity.Text.Trim());
            }
            else
            {
                param[107] = new SqlParameter("@currentadd_othercity", "");
            }
            if (txtothercity2.Text.Trim() != "")
            {
                param[108] = new SqlParameter("@permanentadd_othercity", txtothercity2.Text.Trim());
            }
            else
            {
                param[108] = new SqlParameter("@permanentadd_othercity", "");
            }

            if (Session["BrADID"] != null)
            {
                param[109] = new SqlParameter("@userid", Convert.ToInt32(Session["BrADID"]));
            }
            else
            {
                param[109] = new SqlParameter("@userid", 0);
            }

            string Dob = Request.Form[txtdob.UniqueID];
            if (Dob != "")
            {
                string[] Dobdate = Dob.Split('/');
                Dob = Dobdate[2] + '-' + Dobdate[1] + '-' + Dobdate[0];
                param[110] = new SqlParameter("@dob", Dob);
            }

            string Doj = Request.Form[txtDatejoining.UniqueID];
            //if (Dob != "")
            //{
            //    string[] Dojdate = Doj.Split('/');
            //    Doj = Dojdate[2] + '-' + Dojdate[1] + '-' + Dojdate[0];
            //    param[111] = new SqlParameter("@doj", Doj);
            //}

            if (Doj != "")
            {
                string[] Dojdate = Doj.Split('/');
                Doj = Dojdate[2] + '-' + Dojdate[1] + '-' + Dojdate[0];
                param[111] = new SqlParameter("@doj", Doj);
            }
            else
            {
                param[111] = new SqlParameter("@doj", "");
            }

            string doi = Request.Form[txtdoi.UniqueID];
            if (doi != "")
            {
                string[] dateoi = doi.Split('/');
                doi = dateoi[2] + '-' + dateoi[1] + '-' + dateoi[0];
                param[112] = new SqlParameter("@doi", doi);
            }
            else
            {
                param[112] = new SqlParameter("@doi", "");
            }
            int result = objDUT.ExecuteSqlSP(param, "usp_addEmp_Master");

            if (result == 1)
            {
                int eid = Convert.ToInt32(objDUT.GetScalar("select max(eid) from tblEmp_Master where status=1"));
                if (txtcurrentadd_othercity.Text.Trim() != "")
                {
                    insert_city(Convert.ToInt16(ddlCountry2.SelectedValue), Convert.ToInt16(Request.Form[ddlState2.UniqueID]), txtcurrentadd_othercity.Text.Trim());
                    int ctid = Convert.ToInt32(objDUT.GetScalar("select ctid from city where cityname='" + txtcurrentadd_othercity.Text.Trim() + "'"));
                    objDUT.ExecuteSql("update tblemp_master set tctid=" + ctid + " where eid=" + eid + "");
                    if (txtRefNo.Text.Trim() == "")
                    {
                        int offercanid = Convert.ToInt32(objDUT.GetScalar("select max(id) from tblOfferLettersList where brid=" + Convert.ToDouble(Session["BrBrid"]) + ""));
                        objDUT.ExecuteSql("update tblOfferLettersList set ctid=" + ctid + " where id=" + offercanid + "");
                    }
                }
                if (txtothercity2.Text.Trim() != "")
                {
                    insert_city(Convert.ToInt16(ddlCountry.SelectedValue), Convert.ToInt16(Request.Form[ddlState.UniqueID]), txtothercity2.Text.Trim());
                    int ctid2 = Convert.ToInt32(objDUT.GetScalar("select ctid from city where cityname='" + txtothercity2.Text.Trim() + "'"));
                    objDUT.ExecuteSql("update tblemp_master set ctid=" + ctid2 + " where eid=" + eid + "");
                }

                reset();

                Response.Redirect("AppointmentLetter.aspx?eid=" + eid + "");
            }
            else if (result == 2)
            {
                // lblalreadyexistmsg.Visible = true;
                reset(); ;
            }
            else if (result == 2)
            {
                // lblalreadyexistmsg.Visible = true;
                // lblalreadyexistmsg.Text = "Only offerde and reoffered candidate can be an employee.";
                reset();
            }
        }
    }

    public void insert_city(int cid, int sid, string cityname)
    {
        SqlParameter[] p = new SqlParameter[4];

        p[0] = new SqlParameter("@cid", cid);
        p[1] = new SqlParameter("@sid", sid);
        p[2] = new SqlParameter("@cityname", cityname);

        p[3] = new SqlParameter("@intResult", SqlDbType.Int);
        p[3].Direction = ParameterDirection.Output;

        int result = objDUT.ExecuteSqlSP(p, "add_city");
    }

    protected void lbldateofinterview_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkbtn = sender as LinkButton;
            GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
            Label lbl = (Label)gridforimagename.Rows[gvrow.RowIndex].FindControl("lblimagename");
            string filepath = lbl.Text;

            filepath = "~/branchpanel/employee/AppointedEmployeeDocs/" + filepath;
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filepath));
            Response.WriteFile(filepath);
            Response.End();
        }
        catch (Exception ex)
        {
        }
    }

    protected void DeleteOldfilefromfolder(string prevfile)
    {
        string[] strArray = prevfile.Split(',');
        foreach (string file in strArray)
        {
            if (file != "")
            {
                if (System.IO.File.Exists(HttpContext.Current.Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + file)))
                {
                    System.IO.File.Delete(HttpContext.Current.Server.MapPath("~/branchpanel/employee/AppointedEmployeeDocs/" + file));
                }
            }
        }
    }

    private void GenerateThumbnails(double scaleFactor, Stream sourcePath, string targetPath)
    {
        using (var image = System.Drawing.Image.FromStream(sourcePath))
        {
            var newWidth = (int)(image.Width * scaleFactor);
            var newHeight = (int)(image.Height * scaleFactor);
            var thumbnailImg = new Bitmap(newWidth, newHeight);
            var thumbGraph = Graphics.FromImage(thumbnailImg);
            thumbGraph.CompositingQuality = CompositingQuality.HighQuality;
            thumbGraph.SmoothingMode = SmoothingMode.HighQuality;
            thumbGraph.InterpolationMode = InterpolationMode.HighQualityBicubic;
            var imageRectangle = new Rectangle(0, 0, newWidth, newHeight);
            thumbGraph.DrawImage(image, imageRectangle);
            thumbnailImg.Save(targetPath, image.RawFormat);
        }
    }

    private void reset()
    {
        txtFName.Text = "";
        txtMName.Text = "";
        txtLName.Text = "";
        ddlTitle.SelectedIndex = -1;
        ddlCountry.SelectedIndex = -1;
        ddlState.SelectedIndex = -1;
        ddlCity.SelectedIndex = -1;
        txtPincode.Text = "";
        txtContactNo.Text = "";
        txtDatejoining.Text = "";
        txtEmailid.Text = "";
        ddlDesigNation.SelectedIndex = -1;

        ddlProbationPeriod.SelectedIndex = -1;
        ddlDesigNation.SelectedIndex = -1;
        txtAddressLine.Text = "";
    }

    protected void Cancel_Click(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static int checkrecord(string mobile, string emailid)
    {
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select count(*) from tblOfferLettersList where mobile=" + mobile + " and emailID=" + emailid + " or mobile=" + mobile + " or emailID=" + emailid + "", con))
            {
                con.Open();
                int result = Convert.ToInt32(cmd.ExecuteScalar());
                con.Close();
                return result;
            }
        }
    }

    [WebMethod]
    public static decimal getmonthlysalary(decimal annualctc, int roll)
    {
        DataTable dt = new DataTable();
        decimal result = 0;
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select dbo.Get_InhandSalary(@annualctc,@roll)", con);
            cmd.Parameters.AddWithValue("@annualctc", annualctc);
            cmd.Parameters.AddWithValue("@roll", roll);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                result = Convert.ToDecimal(dt.Rows[0][0]);
            }
        }
        return result;
    }
    [WebMethod]
    public static desigdetail[] binddesignation(string did)
    {
        string query = "";
        List<desigdetail> details = new List<desigdetail>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            if (did == "0" || did == "")
            {
                query = "select desigID,desigName from designation_master where status=1";
            }
            else
            {
                query = "select desigID,desigName from designation_master where deptid=" + Convert.ToInt32(did) + "  and status=1";
            }
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                desigdetail subjectdetails0 = new desigdetail();
                subjectdetails0.desigid = Convert.ToInt32("0");
                subjectdetails0.designame = "---Select Designation---";
                details.Add(subjectdetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    desigdetail dsdetails = new desigdetail();
                    dsdetails.desigid = Convert.ToInt32(dtrow["desigID"].ToString());
                    dsdetails.designame = dtrow["desigName"].ToString();
                    details.Add(dsdetails);
                }
            }
        }
        return details.ToArray();
    }

    public class desigdetail
    {
        public int desigid { get; set; }

        public string designame { get; set; }
    }
    [WebMethod]
    public static qualification[] bind_qualification()
    {
        List<qualification> details = new List<qualification>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            string query = "select qid,name from tblQualification where status=1";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                qualification subjectdetails0 = new qualification();
                subjectdetails0.qid = Convert.ToInt32("0");
                subjectdetails0.name = "---Qualification---";
                details.Add(subjectdetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    qualification dsdetails = new qualification();
                    dsdetails.qid = Convert.ToInt32(dtrow["qid"].ToString());
                    dsdetails.name = dtrow["name"].ToString();
                    details.Add(dsdetails);
                }
            }
        }
        return details.ToArray();
    }

    public class qualification
    {
        public int qid { get; set; }

        public string name { get; set; }
    }
}