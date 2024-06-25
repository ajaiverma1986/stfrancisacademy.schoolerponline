using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_create_new_offer_letter : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();
    private int id = 0, result = 0, statusid = 0;
    private CommonClass objCL = new CommonClass();
    private decimal monthlysalary = 0;
    private string refno = "", finalfilename = "", finalpicname = "", multifile = "";
    private static string query = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                FillDDL();
                if (Request.QueryString.Count > 0)
                {
                    if (Request.QueryString["id"] != null)
                    {
                        id = Convert.ToInt32(Request.QueryString[0]);
                        hfvalue.Value = id.ToString();
                        statusid = Convert.ToInt32(Request.QueryString[1]);
                        ddlstatus.SelectedValue = statusid.ToString();
                        img.Style.Add("display", "block");
                        fill_Controls();
                        btnSubmit.Text = "Update";
                    }
                    else if (Request.QueryString["shortlistcandidateid"] != null)
                    {
                        id = Convert.ToInt32(Request.QueryString[0]);
                        hfvforsortlist.Value = Request.QueryString["shortlistcandidateid"];
                        fillAllFieldWhenComeFromShortlistCandidateList();
                        img.Style.Add("display", "none");
                    }
                }
                else
                {
                    img.Style.Add("display", "none");
                }

                bind_status(statusid);

                if (statusid == 7)
                {
                    ddlstatus.SelectedValue = "7";
                    ddlstatus.Enabled = false;
                }
                else if (statusid == 8)
                {
                    ddlstatus.SelectedValue = "8";
                    ddlstatus.Enabled = false;
                }
                else if (statusid == 0)
                {
                    ddlstatus.SelectedValue = "6";
                    ddlstatus.Enabled = false;
                }
                else if (statusid == 10)
                {
                    int reofferedcount = Convert.ToInt32(objDUT.GetScalar("select reofferedcount from tblOfferLettersList where id=" + Convert.ToInt32(Request.QueryString["id"]) + ""));
                    if (reofferedcount == 2)
                    {
                        ddlstatus.SelectedValue = "8";
                        ddlstatus.Enabled = false;
                    }
                    else
                    {
                        ddlstatus.Enabled = true;
                    }
                }
                else
                {
                    ddlstatus.Enabled = true;
                }
            }
        }
        catch (Exception exx)
        {
        }
    }

    public void fillAllFieldWhenComeFromShortlistCandidateList()
    {
        lblheading1.Text = "Create New Offer Letter";
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@shortlistedcandidatelist", id);
        DataTable Dtshortlist = objDUT.GetDataTableSP(param, "usp_getdetailsfromshortlistcandidatelist");
        if (Dtshortlist.Rows.Count > 0)
        {
            txtFName.Text = Dtshortlist.Rows[0]["fname"].ToString();
            txtMName.Text = Dtshortlist.Rows[0]["middlename"].ToString();
            txtLName.Text = Dtshortlist.Rows[0]["lastname"].ToString();
            txtPinCode.Text = Dtshortlist.Rows[0]["pincode"].ToString();
            txtEmailid.Text = Dtshortlist.Rows[0]["email_id"].ToString();
            txtAddress.Text = Dtshortlist.Rows[0]["address"].ToString();
            int cid = Convert.ToInt16(Dtshortlist.Rows[0]["cid"]);
            int sid = Convert.ToInt16(Dtshortlist.Rows[0]["sid"]);
            int disid = Convert.ToInt16(Dtshortlist.Rows[0]["ctid"]);
            txtannualctc.Text = Dtshortlist.Rows[0]["expected_ctc_per_annum"].ToString();
            rdGender.SelectedValue = Dtshortlist.Rows[0]["gender"].ToString();
            ddl_dept.SelectedValue = Dtshortlist.Rows[0]["department"].ToString();
            DataTable dtfordesignation = objDUT.GetDataTable("select desid,desname from tbl_ddmaster where did=" + Convert.ToInt32(Dtshortlist.Rows[0]["department"]) + "");
            if (dtfordesignation.Rows.Count > 0)
            {
                ddlDesigNation.DataSource = dtfordesignation;
                ddlDesigNation.DataValueField = "desid";
                ddlDesigNation.DataTextField = "desname";
                ddlDesigNation.DataBind();
                ddlDesigNation.Items.Insert(0, new ListItem("Designation", "0"));
            }
            ddlDesigNation.SelectedValue = Dtshortlist.Rows[0]["designation"].ToString();
            txtContactNo.Text = Dtshortlist.Rows[0]["contact_no"].ToString();
            ddlTitle.SelectedValue = Dtshortlist.Rows[0]["titleid"].ToString();
            bindstate(cid);
            bindcity(sid);
            ddlcountry.SelectedValue = cid.ToString();
            ddlState.SelectedValue = sid.ToString();
            ddlCity.SelectedValue = disid.ToString();
        }
    }

    protected void bind_status(int statusid)
    {
        SqlParameter[] p = new SqlParameter[1];
        p[0] = new SqlParameter("@currentstatus", statusid);
        DataTable dt = objDUT.GetDataTableSP(p, "usp_statusmanagement");
        if (dt.Rows.Count > 0)
        {
            ddlstatus.DataSource = dt;
            ddlstatus.DataTextField = "StatusName";
            ddlstatus.DataValueField = "StatusId";
            ddlstatus.DataBind();
            ddlstatus.Items.Insert(0, new ListItem("Select Status", "0"));
        }
    }

    protected void bindImage()
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@id", Convert.ToInt32(hfvalue.Value));
        param[1] = new SqlParameter("@pagename", "offer");

        DataTable dt = objDUT.GetDataTableSP(param, "get_image_names");
        if (dt.Rows.Count > 0)
        {
            gridforimagename.Visible = true;
            gridforimagename.DataSource = dt;
            gridforimagename.DataBind();
        }
        else
        {
            gridforimagename.Visible = false;
        }
    }

    public void fill_Controls()
    {
        bindImage();
        lblheading1.Text = "Edit Offer Letter";
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@id", id);

        DataTable dt1 = objDUT.GetDataTableSP(param, "usp_getemployeedetails");
        if (dt1.Rows.Count > 0)
        {
            ViewState["refno"] = dt1.Rows[0]["refNo"].ToString();
            txtFName.Text = dt1.Rows[0]["fname"].ToString();
            txtMName.Text = dt1.Rows[0]["mname"].ToString();
            txtLName.Text = dt1.Rows[0]["lname"].ToString();
            if (dt1.Rows[0]["DOB"] != "")
            {
                txtdob.Text = Convert.ToDateTime(dt1.Rows[0]["DOB"]).ToString("dd/MM/yyyy");
            }
            txtPinCode.Text = dt1.Rows[0]["pincode"].ToString();
            txtdoi.Text = Convert.ToDateTime(dt1.Rows[0]["dateofinterview"]).ToString("dd/MM/yyyy");
            txtEmailid.Text = dt1.Rows[0]["emailID"].ToString();
            txtAddress.Text = dt1.Rows[0]["address"].ToString();
            int cid = Convert.ToInt16(dt1.Rows[0]["CID"]);
            int sid = Convert.ToInt16(dt1.Rows[0]["SID"]);
            int disid = Convert.ToInt16(dt1.Rows[0]["ctid"]);

            if (dt1.Rows[0]["cvfile"].ToString() != "")
            {
                ViewState["resume"] = dt1.Rows[0]["cvfile"].ToString();
                divresume.Visible = true;
            }

            if (dt1.Rows[0]["imagename"].ToString() != "")
            {
                if (System.IO.File.Exists(HttpContext.Current.Server.MapPath("~/branchpanel/employee/OfferedCandidateDocs/" + dt1.Rows[0]["imagename"].ToString())))
                {
                    img.Style.Add("display", "block");
                    img.ImageUrl = "~/branchpanel/employee/OfferedCandidateDocs/" + dt1.Rows[0]["imagename"].ToString();
                    hfforpicture.Value = dt1.Rows[0]["imagename"].ToString();
                }
                else
                {
                    img.Style.Add("display", "none");
                }
            }
            else
            {
                img.Style.Add("display", "none");
            }
            decimal ctc = Convert.ToDecimal(dt1.Rows[0]["annualCTC"]);
            txthrname.Text = dt1.Rows[0]["hrName"].ToString();
            txtannualctc.Text = ctc.ToString("0.00");
            rdGender.SelectedValue = dt1.Rows[0]["gender"].ToString();
            ddl_dept.SelectedValue = dt1.Rows[0]["deptid"].ToString();
            DataTable dtfordesignation = objDUT.GetDataTable("select desid,desname from tbl_ddmaster where did=" + Convert.ToInt32(dt1.Rows[0]["deptid"]) + "");
            if (dtfordesignation.Rows.Count > 0)
            {
                ddlDesigNation.DataSource = dtfordesignation;
                ddlDesigNation.DataValueField = "desid";
                ddlDesigNation.DataTextField = "desname";
                ddlDesigNation.DataBind();
                ddlDesigNation.Items.Insert(0, new ListItem("Designation", "0"));
            }
            ddlDesigNation.SelectedValue = dt1.Rows[0]["desigtype"].ToString();

            txtDatejoining.Text = Convert.ToDateTime(dt1.Rows[0]["doj"]).ToString("dd/MM/yyyy");

            if (dt1.Rows[0]["probationperiond"].ToString() != "0")
            {
                ddlprobation.SelectedValue = dt1.Rows[0]["probationperiond"].ToString();
            }

            txtContactNo.Text = dt1.Rows[0]["mobile"].ToString();
            ddlTitle.SelectedValue = dt1.Rows[0]["title"].ToString();
            bindstate(cid);
            bindcity(sid);
            ddlcountry.SelectedValue = cid.ToString();
            ddlState.SelectedValue = sid.ToString();

            ddlCity.SelectedValue = disid.ToString();
            lnkbtnforpermothercity.Style.Add("display", "none");
            lnkcancel.Style.Add("display", "none");
        }
    }

    protected void FillDDL()
    {
        ddlcountry.DataSource = CommonClass.ABC("Countrydll");
        ddlcountry.DataTextField = "countryname";
        ddlcountry.DataValueField = "cid";
        ddlcountry.DataBind();
        ddlcountry.Items.Insert(0, new ListItem("---Select Country---", "0"));

        ddlTitle.DataSource = CommonClass.ABC("ddlTitle");
        ddlTitle.DataTextField = "Title";
        ddlTitle.DataValueField = "Titleid";
        ddlTitle.DataBind();
        ddlTitle.Items.Insert(0, new ListItem("---Select Title---", "0"));

        ddlstatus.DataSource = CommonClass.ABC("ddlStatus");
        ddlstatus.DataTextField = "StatusName";
        ddlstatus.DataValueField = "StatusId";
        ddlstatus.DataBind();
        ddlstatus.Items.Insert(0, new ListItem("---Select Status---", "0"));

        ddlprobation.DataSource = CommonClass.ABC("ddlProbationPeriod");
        ddlprobation.DataTextField = "timeInMonth";
        ddlprobation.DataValueField = "id";
        ddlprobation.DataBind();
        ddlprobation.Items.Insert(0, new ListItem("---Select Probation Period---", "0"));

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

    protected void DeleteOldfilefromfolder(string prevfile)
    {
        string[] strArray = prevfile.Split(',');
        foreach (string file in strArray)
        {
            if (file != "")
            {
                if (System.IO.File.Exists(HttpContext.Current.Server.MapPath("~/branchpanel/employee/OfferedCandidateDocs/" + file)))
                {
                    System.IO.File.Delete(HttpContext.Current.Server.MapPath("~/branchpanel/employee/OfferedCandidateDocs/" + file));
                }
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string Fname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtFName.Text.Trim());
            string mname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtMName.Text.Trim());
            string lastname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtLName.Text.Trim());

            SqlParameter[] param = new SqlParameter[40];

            param[0] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));

            if (ViewState["refno"] != null)
            {
                param[1] = new SqlParameter("@refNo", ViewState["refno"].ToString());
            }
            else
            {
                param[1] = new SqlParameter("@refNo", "");
            }

            param[2] = new SqlParameter("@staffID", "1");
            param[3] = new SqlParameter("@title", ddlTitle.SelectedValue);
            param[4] = new SqlParameter("@fname", Fname);
            param[5] = new SqlParameter("@mname", mname);
            param[6] = new SqlParameter("@lname", lastname);
            param[7] = new SqlParameter("@gender", rdGender.SelectedValue);

            string Doi = Request.Form[txtdoi.UniqueID];
            string[] Doidate = Doi.Split('/');
            Doi = Doidate[2] + '-' + Doidate[1] + '-' + Doidate[0];

            param[8] = new SqlParameter("@dateofinterview", Doi);
            param[9] = new SqlParameter("@cid", Convert.ToInt16(ddlcountry.SelectedValue));

            int statid = Convert.ToInt32(Request.Form[ddlState.UniqueID]);
            param[10] = new SqlParameter("@sid", statid);

            int cityid = Convert.ToInt32(Request.Form[ddlCity.UniqueID]);
            param[11] = new SqlParameter("@ctid", cityid);

            param[12] = new SqlParameter("@address", txtAddress.Text.Trim());
            param[13] = new SqlParameter("@pinCode", txtPinCode.Text.Trim());

            string Doj = Request.Form[txtDatejoining.UniqueID];
            string[] Dojdate = Doj.Split('/');
            Doj = Dojdate[2] + '-' + Dojdate[1] + '-' + Dojdate[0];

            param[14] = new SqlParameter("@doj", Doj);

            if (ddlprobation.SelectedIndex > 0)
            {
                param[15] = new SqlParameter("@probationPeriond", ddlprobation.SelectedValue);
            }
            else
            {
                param[15] = new SqlParameter("@probationPeriond", 0);
            }
            param[16] = new SqlParameter("@hrName", txthrname.Text.Trim());
            param[17] = new SqlParameter("@mobile", txtContactNo.Text.Trim());
            param[18] = new SqlParameter("@emailID", txtEmailid.Text.Trim());
            param[19] = new SqlParameter("@comments", "");

            param[20] = new SqlParameter("@status1", ddlstatus.SelectedItem.Text.Trim());
            param[21] = new SqlParameter("@status", ddlstatus.SelectedValue);

            int deptid = Convert.ToInt32(ddl_dept.SelectedValue);

            if (deptid > 0)
            {
                param[22] = new SqlParameter("@department", ddl_dept.SelectedItem.Text);
                param[23] = new SqlParameter("@deptid", Convert.ToInt16(ddl_dept.SelectedValue));
            }
            var value = Request.Form[ddlDesigNation.UniqueID];
            var text = ddlDesigNation.Items.FindByValue(value);

            if (value != "0")
            {
                param[24] = new SqlParameter("@designation", SqlDbType.VarChar, 200);
                param[24].Value = Request.Form[ddlDesigNation.Text];
                param[25] = new SqlParameter("@desigType", SqlDbType.Int);
                param[25].Value = Convert.ToInt16(Request.Form[ddlDesigNation.UniqueID]);
            }
            else
            {
                param[24] = new SqlParameter("@designation", "");
                param[25] = new SqlParameter("@desigType", 0);
            }

            if (Request.QueryString["id"] != null)
            {
                param[26] = new SqlParameter("@mode", 2);
            }
            else
            {
                param[26] = new SqlParameter("@mode", 1);
            }

            param[27] = new SqlParameter("@intResult", 0);
            param[27].Direction = ParameterDirection.Output;

            param[28] = new SqlParameter("@IsOffered", 0);

            param[29] = new SqlParameter("@annualCTC", Convert.ToDecimal(txtannualctc.Text));

            param[30] = new SqlParameter("@inhandsalary", 0.00);

            param[31] = new SqlParameter("@employeetype", 0);

            param[32] = new SqlParameter("@ctcappliedfrom", "");

            int limit = Convert.ToInt32(objDUT.GetScalar("select LIMITS from settings where sid=4"));

            if (fileuploadforcv.HasFile)
            {
                if (ViewState["resume"] != null)
                {
                    DeleteOldfilefromfolder(ViewState["resume"].ToString());
                }

                //foreach (HttpPostedFile postedfile in fileuploadforcv.PostedFile)
                //{
                //    finalfilename = limit.ToString() + postedfile.FileName;
                //    fileuploadforcv.SaveAs(Server.MapPath("~/branchpanel/employee/OfferedCandidateDocs/" + finalfilename));
                //    multifile += finalfilename + ",";
                //}
                //param[33] = new SqlParameter("@cvfile", multifile);
            }
            else
            {
                if (ViewState["resume"] != null)
                {
                    param[33] = new SqlParameter("@cvfile", ViewState["resume"].ToString());
                }
                else
                {
                    param[33] = new SqlParameter("@cvfile", "");
                }
            }

            if (ddlstatus.SelectedValue == "9")
            {
                param[34] = new SqlParameter("@reoffered", "reoffer");
            }
            else
            {
                param[34] = new SqlParameter("@reoffered", "");
            }

            if (fileuploadforpic.HasFile)
            {
                if (hfforpicture.Value != "")
                {
                    DeleteOldfilefromfolder(hfforpicture.Value);
                }
                finalpicname = limit.ToString() + fileuploadforpic.PostedFile.FileName;
                fileuploadforpic.PostedFile.SaveAs(Server.MapPath("~/branchpanel/employee/OfferedCandidateDocs/" + finalpicname));
                param[35] = new SqlParameter("@imagename", finalpicname);
            }
            else
            {
                if (hfforpicture.Value != "")
                {
                    param[35] = new SqlParameter("@imagename", hfforpicture.Value);
                }
                else
                {
                    param[35] = new SqlParameter("@imagename", "");
                }
            }

            string Dob = Request.Form[txtdob.UniqueID];
            string[] Dobdate = Dob.Split('/');
            Dob = Dobdate[2] + '-' + Dobdate[1] + '-' + Dobdate[0];
            param[36] = new SqlParameter("@dob", Dob);

            if (hfvforsortlist.Value != "")
            {
                param[37] = new SqlParameter("@shortlistid", Convert.ToInt32(hfvforsortlist.Value));
            }
            else
            {
                param[37] = new SqlParameter("@shortlistid", 0);
            }

            if (txtothercity2.Text.Trim() != "")
            {
                param[38] = new SqlParameter("@othercity", txtothercity2.Text.Trim());
            }
            else
            {
                param[38] = new SqlParameter("@othercity", "");
            }
            if (Session["BrADID"] != null)
            {
                param[39] = new SqlParameter("@userid", Convert.ToInt32(Session["BrADID"]));
            }
            else
            {
                param[39] = new SqlParameter("@userid", 0);
            }
            result = objDUT.ExecuteSqlSP(param, "usp_CreateOfferLetters");

            if (result == 1)
            {
                Utility.ViewAlertMessage(Page, "Offer letter created successfully ");
                string query = "select max(id) from tblOfferLettersList where brid=" + Convert.ToDouble(Session["BrBrid"]) + "";
                int MAXID = Convert.ToInt32(objDUT.GetScalar(query));

                if (txtothercity2.Text.Trim() != "")
                {
                    insert_city(Convert.ToInt16(ddlcountry.SelectedValue), Convert.ToInt32(Request.Form[ddlState.UniqueID]), txtothercity2.Text.Trim());
                    int ctid = Convert.ToInt32(objDUT.GetScalar("select ctid from city where cityname='" + txtothercity2.Text.Trim() + "'"));
                    objDUT.ExecuteSql("update tblOfferLettersList set ctid=" + ctid + " where id=" + MAXID + "");
                }

                Response.Redirect("OfferLetter.aspx?id=" + MAXID);
                return;
            }
            if (result == 2)
            {
                ViewState["resume"] = null;
                hfforpicture.Value = "";
                Utility.ViewAlertMessage(Page, "Offer letter updated successfully");
                btnSubmit.Text = "Submit";
                Response.Redirect("offered-employer-list.aspx");
                return;
            }
            if (result == 3)
            {
                Utility.ViewAlertMessage(Page, "Re-Offer letter created successfully ");
                string query = "select max(id) from tblOfferLettersList where brid=" + Convert.ToDouble(Session["BrBrid"]) + "";
                int MAXID = Convert.ToInt32(objDUT.GetScalar(query));

                Response.Redirect("OfferLetter.aspx?id=" + MAXID);
            }
            if (result == 4)
            {
                Utility.ViewAlertMessage(Page, "This employee has already been offered two times. Now, you can not reoffered.");
                return;
            }
        }
        catch (Exception ex)
        {
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

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("offered-employer-list.aspx");
    }

    protected void bindstate(int cid)
    {
        ddlState.DataSource = CommonClass.ABC1("Statedll", cid);
        ddlState.DataTextField = "statename";
        ddlState.DataValueField = "sid";
        ddlState.DataBind();
        ddlState.Items.Insert(0, new ListItem("---Select State----", ""));
    }

    protected void bindcity(int sid)
    {
        ddlCity.DataSource = CommonClass.ABC1("Citydll", sid);
        ddlCity.DataTextField = "cityname";
        ddlCity.DataValueField = "ctid";
        ddlCity.DataBind();
        ddlCity.Items.Insert(0, new ListItem("---Select City---", ""));
    }

    [WebMethod]
    public static statedetail[] bindstate(string cid)
    {
        List<statedetail> details = new List<statedetail>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select SID,stateName  from STATE where CID=" + Convert.ToInt32(cid) + " and sactive=1 order by stateName", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                statedetail subjectdetails0 = new statedetail();
                subjectdetails0.SID = Convert.ToInt32("0");
                subjectdetails0.stateName = "---Select State---";
                details.Add(subjectdetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    statedetail subjectdetails = new statedetail();
                    subjectdetails.SID = Convert.ToInt32(dtrow["SID"].ToString());
                    subjectdetails.stateName = dtrow["stateName"].ToString();
                    details.Add(subjectdetails);
                }
            }
        }
        return details.ToArray();
    }

    public class statedetail
    {
        public int SID { get; set; }

        public string stateName { get; set; }
    }

    [WebMethod]
    public static citydetail[] bindcity(string sid)
    {
        List<citydetail> details = new List<citydetail>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select ctId,cityname from city where sid=" + Convert.ToInt32(sid) + "  and Active=1 order by cityname", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                citydetail subjectdetails0 = new citydetail();
                subjectdetails0.ctId = Convert.ToInt32("0");
                subjectdetails0.cityname = "---Select City---";
                details.Add(subjectdetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    citydetail citydetails = new citydetail();
                    citydetails.ctId = Convert.ToInt32(dtrow["ctId"].ToString());
                    citydetails.cityname = dtrow["cityname"].ToString();
                    details.Add(citydetails);
                }
            }
        }
        return details.ToArray();
    }

    public class citydetail
    {
        public int ctId { get; set; }

        public string cityname { get; set; }
    }

    [WebMethod]
    public static desigdetail[] binddesignation(string did)
    {
        List<desigdetail> details = new List<desigdetail>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            if (did == "0" || did == "")
            {
                query = "select desigID,designame from designation_master where status=1";
            }
            else
            {
                query = "select desigID,designame from designation_master where deptid=" + Convert.ToInt32(did) + "  and status=1";
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
                    dsdetails.designame = dtrow["designame"].ToString();
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
    public static int checkrecord(string mob, string email)
    {
        SqlParameter[] p = new SqlParameter[3];

        p[0] = new SqlParameter("@mobile", mob);

        p[1] = new SqlParameter("@emailid", email);

        p[2] = new SqlParameter("@intresult", SqlDbType.Int);
        p[2].Direction = ParameterDirection.Output;

        DataUtility objDUT = new DataUtility();
        objDUT.GetScalerSP(p, "usp_checkduplicaterecord");

        int result = Convert.ToInt32(p[2].Value);

        return result;
    }

    [WebMethod]
    public static salarydetails[] getmonthlysalary(decimal annualctc, int roll)
    {
        List<salarydetails> details = new List<salarydetails>();

        DataTable dt = new DataTable();
        decimal result = 0;
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select * from dbo.Get_InhandSalary(@gross_annual_ctc,@roll)", con);
            cmd.Parameters.AddWithValue("@gross_annual_ctc", annualctc);
            cmd.Parameters.AddWithValue("@roll", roll);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dtrow in dt.Rows)
                {
                    salarydetails sd = new salarydetails();
                    sd.gross_annual_ctc = Convert.ToDecimal(dtrow["gross_annual_ctc"]);
                    sd.net_annual_ctc = Convert.ToDecimal(dtrow["net_annual_ctc"]);
                    sd.gross_monthly_salary = Convert.ToDecimal(dtrow["gross_monthly_salary"]);
                    sd.net_monthly_salary = Convert.ToDecimal(dtrow["net_monthly_salary"]);
                    sd.monthly_pf_amount = Convert.ToDecimal(dtrow["monthly_pf_amount"]);
                    sd.monthly_esi_amount = Convert.ToDecimal(dtrow["monthly_esi_amount"]);
                    sd.monthly_tds_amount = Convert.ToDecimal(dtrow["monthly_tds_amount"]);
                    sd.pf_percent = Convert.ToDecimal(dtrow["pf_percent"]);
                    sd.esi_percent = Convert.ToDecimal(dtrow["esi_percent"]);
                    sd.tds_percent = Convert.ToDecimal(dtrow["tds_percent"]);
                    sd.roll = Convert.ToInt32(dtrow["roll"]);
                    details.Add(sd);
                }
            }
        }
        return details.ToArray();
    }

    public class salarydetails
    {
        public decimal gross_annual_ctc { set; get; }

        public decimal net_annual_ctc { set; get; }

        public decimal gross_monthly_salary { set; get; }

        public decimal net_monthly_salary { set; get; }

        public decimal monthly_pf_amount { set; get; }

        public decimal monthly_esi_amount { set; get; }

        public decimal monthly_tds_amount { set; get; }

        public decimal pf_percent { set; get; }

        public decimal esi_percent { set; get; }

        public decimal tds_percent { set; get; }

        public int roll { set; get; }
    }

    protected void lbldateofinterview_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkbtn = sender as LinkButton;
            GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
            Label lbl = (Label)gridforimagename.Rows[gvrow.RowIndex].FindControl("lblRefno");
            string filepath = lbl.Text;

            filepath = "~/branchpanel/employee/OfferedCandidateDocs/" + filepath;
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filepath));
            Response.WriteFile(filepath);
            Response.End();
        }
        catch (Exception ex)
        {
        }
    }

    protected void img_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        try
        {
            if (hfforpicture.Value != "")
            {
                string filepath = hfforpicture.Value;
                filepath = "~/branchpanel/employee/OfferedCandidateDocs/" + filepath;
                Response.ContentType = ContentType;
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filepath));
                Response.WriteFile(filepath);
                Response.End();
            }
        }
        catch (Exception ex)
        {
        }
    }
}