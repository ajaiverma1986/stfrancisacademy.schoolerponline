using System;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;

public partial class branchpanel_employee_add_new_shortlist_candidates : System.Web.UI.Page
{
    private DataUtility DUObj = new DataUtility();
    private int fyid = 0, id = 0;
    private string refno = "", finalfilename = "", finalpicname = "", multifile = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        fyid = CommonClass.Scaler("ActiveAcademicYear");
        if (!IsPostBack)
        {
            FillExperience();
            FillDDL();
            if (Request.QueryString.Count > 0)
            {
                id = Convert.ToInt32(Request.QueryString[0]);
                hfvalue.Value = id.ToString();
                img.Style.Add("display", "block");

                Fill_Controls();
            }
            else
            {
                img.Style.Add("display", "none");
            }
        }
    }

    protected void DeleteOldfilefromfolder(string prevfile)
    {
        string[] strArray = prevfile.Split(',');
        foreach (string file in strArray)
        {
            if (file != "")
            {
                if (System.IO.File.Exists(HttpContext.Current.Server.MapPath("~/branchpanel/employee/ShortlistedCandidateDocs/" + file)))
                {
                    System.IO.File.Delete(HttpContext.Current.Server.MapPath("~/branchpanel/employee/ShortlistedCandidateDocs/" + file));
                }
            }
        }
    }

    protected void bindImage()
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@id", Convert.ToInt32(hfvalue.Value));
        param[1] = new SqlParameter("@pagename", "shortlist");
        DataTable dt = DUObj.GetDataTableSP(param, "get_image_names");
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

    protected void Fill_Controls()
    {
        SqlParameter[] param = new SqlParameter[4];

        param[0] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));

        param[1] = new SqlParameter("@id", id.ToString());

        param[2] = new SqlParameter("@pagesize", SqlDbType.Int);
        param[2].Value = 20;

        param[3] = new SqlParameter("@pageno", SqlDbType.Int);
        param[3].Value = 1;

        DataTable dt = DUObj.GetDataTableSP(param, "search_shortlisted_emp");
        if (dt.Rows.Count > 0)
        {
            bindImage();
            ddlTitle.SelectedValue = dt.Rows[0]["titleid"].ToString();
            txtFName.Text = dt.Rows[0]["name"].ToString();
            txtMName.Text = dt.Rows[0]["middlename"].ToString();
            txtLName.Text = dt.Rows[0]["lastname"].ToString();
            if (dt.Rows[0]["cv_name"].ToString() != "")
            {
                divresume.Visible = true;
                ViewState["resume"] = dt.Rows[0]["cv_name"].ToString();
            }

            if (dt.Rows[0]["imagename"].ToString() != "")
            {
                if (System.IO.File.Exists(HttpContext.Current.Server.MapPath("~/branchpanel/employee/ShortlistedCandidateDocs/" + dt.Rows[0]["imagename"].ToString())))
                {
                    img.Style.Add("display", "block");
                    img.ImageUrl = "~/branchpanel/employee/ShortlistedCandidateDocs/" + dt.Rows[0]["imagename"].ToString();

                    hfforpicture.Value = dt.Rows[0]["imagename"].ToString();
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

            if (dt.Rows[0]["genderid"].ToString() == "1")
            {
                rdGender.SelectedValue = "1";
            }
            else
            {
                rdGender.SelectedValue = "2";
            }
            txtAddress.Text = dt.Rows[0]["address"].ToString();

            int cid = Convert.ToInt16(dt.Rows[0]["cid"]);
            ddlcountry.SelectedValue = cid.ToString();
            int sid = Convert.ToInt16(dt.Rows[0]["sid"]);
            int ctid = Convert.ToInt16(dt.Rows[0]["ctid"]);
            bindstate(cid);
            bindcity(sid);
            ddlState.SelectedValue = sid.ToString();
            ddlCity.SelectedValue = ctid.ToString();
            txtPinCode.Text = dt.Rows[0]["pincode"].ToString();
            ddl_dept.SelectedValue = dt.Rows[0]["department"].ToString();

            DataTable dtfordesignation = DUObj.GetDataTable("select desid,desname from tbl_ddmaster where did=" + Convert.ToInt32(dt.Rows[0]["department"]) + "");
            if (dtfordesignation.Rows.Count > 0)
            {
                ddlDesigNation.DataSource = dtfordesignation;
                ddlDesigNation.DataValueField = "desid";
                ddlDesigNation.DataTextField = "desname";
                ddlDesigNation.DataBind();
                ddlDesigNation.Items.Insert(0, new ListItem("Designation", "0"));
            }
            ddlDesigNation.SelectedValue = dt.Rows[0]["designation"].ToString();

            string shortlistday = dt.Rows[0]["shortlisted_day"].ToString();
            string[] ctcdate1 = shortlistday.Split('/');
            shortlistday = ctcdate1[0] + '/' + ctcdate1[1] + '/' + ctcdate1[2];

            txtshortlisteddate.Text = shortlistday;

            txtexepectedctc.Text = dt.Rows[0]["expected_ctc_per_annum"].ToString();
            txtcurrentannualctc.Text = dt.Rows[0]["current_ctc_per_annum"].ToString();

            ddlyear.SelectedValue = dt.Rows[0]["experience_year"].ToString();
            ddlmonth.SelectedValue = dt.Rows[0]["experience_month"].ToString();
            ddlday.SelectedValue = dt.Rows[0]["experience_day"].ToString();

            txtContactNo.Text = dt.Rows[0]["contact_no"].ToString();

            txtEmailid.Text = dt.Rows[0]["email_id"].ToString();

            txtremark.Text = dt.Rows[0]["remak"].ToString();
            lnkbtnforpermothercity.Style.Add("display", "none");
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

        DataTable dtDesignation = DUObj.GetDataTable("select deptid,deptname from dept_master where status=1");
        if (dtDesignation.Rows.Count > 0)
        {
            ddl_dept.DataSource = dtDesignation;
            ddl_dept.DataTextField = "deptname";
            ddl_dept.DataValueField = "deptid";
            ddl_dept.DataBind();
            ddl_dept.Items.Insert(0, new ListItem("---Select Department---", "0"));
        }
    }

    protected void bindstate(int cid)
    {
        ddlState.DataSource = CommonClass.ABC1("Statedll", cid);
        ddlState.DataTextField = "statename";
        ddlState.DataValueField = "sid";
        ddlState.DataBind();
        ddlState.Items.Insert(0, new ListItem("---Select State---", ""));
    }

    protected void bindcity(int sid)
    {
        ddlCity.DataSource = CommonClass.ABC1("Citydll", sid);
        ddlCity.DataTextField = "cityname";
        ddlCity.DataValueField = "ctid";
        ddlCity.DataBind();
        ddlCity.Items.Insert(0, new ListItem("---Select City---", ""));
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string Fname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtFName.Text.Trim());
            string mname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtMName.Text.Trim());
            string lastname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtLName.Text.Trim());

            SqlParameter[] param = new SqlParameter[30];

            param[0] = new SqlParameter("@title", Convert.ToInt32(ddlTitle.SelectedValue));

            param[1] = new SqlParameter("@name", Fname);

            param[2] = new SqlParameter("@contactno", txtContactNo.Text.Trim());

            param[3] = new SqlParameter("@emailid", txtEmailid.Text.Trim());

            param[4] = new SqlParameter("@address", txtAddress.Text.Trim());

            param[5] = new SqlParameter("@cid", Convert.ToInt32(ddlcountry.SelectedValue));

            int statid = Convert.ToInt32(Request.Form[ddlState.UniqueID]);
            param[6] = new SqlParameter("@sid", statid);

            int cityid = Convert.ToInt32(Request.Form[ddlCity.UniqueID]);
            param[7] = new SqlParameter("@ctid", cityid);

            param[8] = new SqlParameter("@pincode", txtPinCode.Text.Trim());

            int limit = Convert.ToInt32(DUObj.GetScalar("select LIMITS from settings where sid=4"));

            if (fileuploadforpic.HasFile)
            {
                if (hfforpicture.Value != "")
                {
                    DeleteOldfilefromfolder(hfforpicture.Value);
                }
                finalpicname = limit.ToString() + fileuploadforpic.PostedFile.FileName;
                fileuploadforpic.PostedFile.SaveAs(Server.MapPath("~/branchpanel/employee/ShortlistedCandidateDocs/" + finalpicname));
                param[9] = new SqlParameter("@imagename", finalpicname);
            }
            else
            {
                if (hfforpicture.Value != "")
                {
                    param[9] = new SqlParameter("@imagename", hfforpicture.Value);
                }
                else
                {
                    param[9] = new SqlParameter("@imagename", "");
                }
            }

            if (fileuploadforcv.HasFiles)
            {
                if (ViewState["resume"] != null)
                {
                    DeleteOldfilefromfolder(ViewState["resume"].ToString());
                }

                foreach (HttpPostedFile postedfile in fileuploadforcv.PostedFiles)
                {
                    finalfilename = limit.ToString() + postedfile.FileName;
                    fileuploadforcv.SaveAs(Server.MapPath("~/branchpanel/employee/ShortlistedCandidateDocs/" + finalfilename));
                    multifile += finalfilename + ",";
                }
                param[10] = new SqlParameter("@cv", multifile);
            }
            else
            {
                if (ViewState["resume"] != null)
                {
                    param[10] = new SqlParameter("@cv", ViewState["resume"].ToString());
                }
                else
                {
                    param[10] = new SqlParameter("@cv", "");
                }
            }

            int deptid = Convert.ToInt32(ddl_dept.SelectedValue);

            if (deptid > 0)
            {
                param[11] = new SqlParameter("@deptid", deptid);
            }
            else
            { param[11] = new SqlParameter("@deptid", 0); }

            var value = Request.Form[ddlDesigNation.UniqueID];

            if (value != "0")
            {
                param[12] = new SqlParameter("@designationid", Convert.ToInt16(Request.Form[ddlDesigNation.UniqueID]));
            }
            else
            {
                param[12] = new SqlParameter("@designationid", 0);
            }
            if (txtexepectedctc.Text.Trim() != "")
            {
                param[13] = new SqlParameter("@expectedctc", Convert.ToDecimal(txtexepectedctc.Text.Trim()));
            }
            else
            {
                param[13] = new SqlParameter("@expectedctc", 0);
            }
            if (txtcurrentannualctc.Text.Trim() != "")
            {
                param[14] = new SqlParameter("@currentctc", Convert.ToDecimal(txtcurrentannualctc.Text.Trim()));
            }
            else
            {
                param[14] = new SqlParameter("@currentctc", 0);
            }
            if (ddlyear.SelectedIndex > 0)
            {
                param[15] = new SqlParameter("@year", Convert.ToInt32(ddlmonth.SelectedValue));
            }
            else
            {
                param[15] = new SqlParameter("@year", 0);
            }
            if (ddlmonth.SelectedIndex > 0)
            {
                param[16] = new SqlParameter("@month", Convert.ToInt32(ddlmonth.SelectedValue));
            }
            else
            {
                param[16] = new SqlParameter("@month", 0);
            }
            if (ddlday.SelectedIndex > 0)
            {
                param[17] = new SqlParameter("@day", Convert.ToInt32(ddlday.SelectedValue));
            }
            else
            {
                param[17] = new SqlParameter("@day", 0);
            }

            if (Request.Form[txtshortlisteddate.UniqueID] != "")
            {
                string shortlistday = Request.Form[txtshortlisteddate.UniqueID];
                string[] ctcdate1 = shortlistday.Split('/');
                shortlistday = ctcdate1[2] + '-' + ctcdate1[1] + '-' + ctcdate1[0];
                param[18] = new SqlParameter("@shortlistedday", shortlistday);
            }
            else
            {
                param[18] = new SqlParameter("@shortlistedday", "");
            }

            param[19] = new SqlParameter("@remark", txtremark.Text.Trim());

            if (Request.QueryString.Count > 0)
            {
                param[20] = new SqlParameter("@mode", 2);
            }
            else
            {
                param[20] = new SqlParameter("@mode", 1);
            }

            param[21] = new SqlParameter("@intResult", SqlDbType.Int);
            param[21].Direction = ParameterDirection.Output;

            param[22] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));

            param[23] = new SqlParameter("@fyid", fyid);

            if (rdGender.SelectedValue == "1")
            {
                param[24] = new SqlParameter("@gender", 1);
            }
            else
            {
                param[24] = new SqlParameter("@gender", 2);
            }

            param[25] = new SqlParameter("@middlename", mname);

            param[26] = new SqlParameter("@lastname", lastname);

            if (Request.QueryString.Count > 0)
            {
                param[27] = new SqlParameter("@shortlistcanid", Convert.ToInt32(Request.QueryString[0]));
            }
            else
            {
                param[27] = new SqlParameter("@shortlistcanid", 0);
            }

            if (txtothercity2.Text.Trim() != "")
            {
                param[28] = new SqlParameter("@othercity", txtothercity2.Text.Trim());
            }
            else
            {
                param[28] = new SqlParameter("@othercity", "");
            }

            if (Session["BrADID"] != null)
            {
                param[29] = new SqlParameter("@userid", Convert.ToInt32(Session["BrADID"]));
            }
            else
            {
                param[29] = new SqlParameter("@userid", 0);
            }

            int result = DUObj.ExecuteSqlSP(param, "usp_add_shortlisted_candidate");

            if (result == 1)
            {
                string query = "select max(shortcanid) from tbl_shorlisted_candidate where brid=" + Convert.ToDouble(Session["BrBrid"]) + "";
                int MAXID = Convert.ToInt32(DUObj.GetScalar(query));
                if (txtothercity2.Text.Trim() != "")
                {
                    insert_city(Convert.ToInt16(ddlcountry.SelectedValue), Convert.ToInt32(Request.Form[ddlState.UniqueID]), txtothercity2.Text.Trim());
                    int ctid = Convert.ToInt32(DUObj.GetScalar("select ctid from city where cityname='" + txtothercity2.Text.Trim() + "'"));
                    DUObj.ExecuteSql("update tbl_shorlisted_candidate set ctid=" + ctid + " where shortcanid=" + MAXID + "");
                }

                Response.Redirect("shortlisted-candidates-list.aspx");
            }
            if (result == 2)
            {
                ViewState["resume"] = null;
                hfforpicture.Value = "";
                Response.Redirect("shortlisted-candidates-list.aspx");
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

        int result = DUObj.ExecuteSqlSP(p, "add_city");
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("shortlisted-candidates-list.aspx");
    }

    protected void img_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        try
        {
            if (hfforpicture.Value != "")
            {
                string filepath = hfforpicture.Value;
                filepath = "~/branchpanel/employee/ShortlistedCandidateDocs/" + filepath;
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

    protected void lbldateofinterview_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkbtn = sender as LinkButton;
            GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
            Label lbl = (Label)gridforimagename.Rows[gvrow.RowIndex].FindControl("lblRefno");
            string filepath = lbl.Text;

            filepath = "~/branchpanel/employee/ShortlistedCandidateDocs/" + filepath;
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filepath));
            Response.WriteFile(filepath);
            Response.End();
        }
        catch (Exception ex)
        {
        }
    }
}