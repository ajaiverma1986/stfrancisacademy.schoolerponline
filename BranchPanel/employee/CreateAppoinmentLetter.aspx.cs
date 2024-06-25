using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class CreateAppoinmentLetter : System.Web.UI.Page
{
    private SqlParameter[] param1 = new SqlParameter[5];
    private string url = "", PageName = "";
    private int totalpage = 0;
    private Utility objut = new Utility();
    private DataUtility objDUT = new DataUtility();
    private Utility objUT = new Utility();
    private string brCode = string.Empty;

    private CommonClass objCL = new CommonClass();
    private DataTable dtTemp = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        PageName = Utility.GetCurrentPagename();

        if (!objut.isAccessible(((User)Session["BrUser"]).UserID, PageName))
        {
            Response.Redirect("~/Login.aspx");
        }
        if (!IsPostBack)
        {
            ViewState["noofrecord"] = 20;
            ViewState["PageNo"] = 1;
            abc1.Visible = false;
            fillDOB();
            FillDDL();
            //fillgrid();
            setpage();
            fillgrid(20, 1, 0, "");
            grdAppoinmentLetter.Visible = true;
            divAppoinmentLetter.Visible = false;
        }
    }

    //private void fillgrid()
    //{
    //    grdAppoinmentLetter.DataSource = objCL.dtCommon(Session["BrBrid"].ToString(), 5);
    //    grdAppoinmentLetter.DataBind();
    //    GridView1.DataSource = objCL.dtCommon(Session["BrBrid"].ToString(), 5);
    //    GridView1.DataBind();
    //    if (grdAppoinmentLetter.DataSource == null)
    //    {
    //        IBExcel.Visible = false;
    //    }
    //    else
    //    {
    //        IBExcel.Visible = true;
    //    }
    //}

    protected void FillDDL()
    {
        ddlTitle.DataSource = CommonClass.ABC("ddlTitle");
        ddlTitle.DataTextField = "Title";
        ddlTitle.DataValueField = "Titleid";
        ddlTitle.DataBind();
        ddlTitle.Items.Insert(0, new ListItem("-Select Title-", "0"));

        ddlCountry.DataSource = CommonClass.ABC("Countrydll");
        ddlCountry.DataTextField = "countryName";
        ddlCountry.DataValueField = "CID";
        ddlCountry.DataBind();
        ddlCountry.Items.Insert(0, new ListItem("--Select --", "0"));

        if (CommonClass.ABC1("GetAllDepartment", Convert.ToInt32(Session["BrBrid"])).Rows.Count > 0)
        {
            ddlDepartment.DataSource = CommonClass.ABC1("GetAllDepartment", Convert.ToInt32(Session["BrBrid"]));
            ddlDepartment.DataTextField = "deptName";
            ddlDepartment.DataValueField = "deptid";

            ddlDepartment.DataBind();
            ListItem li = new ListItem("--Select Department--", "0");
            ddlDepartment.Items.Insert(0, li);
            ddlDesigNation.Items.Insert(0, new ListItem("--Select Designation--", "0"));
        }

        ddlProbationPeriod.DataSource = CommonClass.ABC("ddlProbationPeriod");
        ddlProbationPeriod.DataTextField = "timeInMonth";
        ddlProbationPeriod.DataValueField = "id";
        ddlProbationPeriod.DataBind();
        ddlProbationPeriod.Items.Insert(0, new ListItem("-Select Probation Period-", "0"));
    }

    protected void fillDOB()
    {
        ddlDOBDay.Items.Insert(0, new ListItem("-Day-", "0"));
        for (int i = 1; i <= 31; i++)
        {
            ddlDOBDay.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
        }

        ddlDOBMonth.Items.Insert(0, new ListItem("-Month-", "0"));
        for (int i = 1; i <= 12; i++)
        {
            ddlDOBMonth.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
        }

        int year = System.DateTime.Now.Year;
        int yearto = year - 16;
        int yearfrom = year - 75;
        ddlDOBYear.Items.Insert(0, new ListItem("-Year-", "0"));
        for (int i = yearfrom; i <= yearto; i++)
        {
            int y = 1;
            ddlDOBYear.Items.Insert(y, new ListItem(i.ToString(), i.ToString()));
            y++;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
    }

    protected void dlSubjects_ItemDataBound(object sender, DataListItemEventArgs e)
    {
    }

    protected void txtRefNo_TextChanged(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtRefNo.Text.Trim()))
        {
            int count = Convert.ToInt16(objDUT.GetScalar("select COUNT(refno) from tblEmp_Master where refNo='" + txtRefNo.Text.Trim() + "'"));
            if (count == 1)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Employee already exists.')", true);
                return;
            }
            else
            {
                using (dtTemp = objCL.dtCommon(txtRefNo.Text.Trim(), 2))
                {
                    try
                    {
                        if (dtTemp.Rows.Count > 0)
                        {
                            txtFName.Text = dtTemp.Rows[0]["fname"].ToString();
                            txtMName.Text = dtTemp.Rows[0]["mname"].ToString();
                            txtLName.Text = dtTemp.Rows[0]["lname"].ToString();
                            rdGender.SelectedValue = Convert.ToInt16(dtTemp.Rows[0]["gender"]).ToString();
                            txtFName.Text = dtTemp.Rows[0]["fname"].ToString();
                            txtAddressLine.Text = dtTemp.Rows[0]["address"].ToString();
                            txtPincode.Text = dtTemp.Rows[0]["pincode"].ToString();
                            txtDatejoining.Text = Convert.ToDateTime(dtTemp.Rows[0]["doj"].ToString()).ToString("dd/MM/yyyy");
                            txtSalary.Text = string.Format("{0:f}", dtTemp.Rows[0]["salary"]);
                            txtHrName.Text = dtTemp.Rows[0]["hrname"].ToString();
                            txtContactNo.Text = dtTemp.Rows[0]["mobile"].ToString();
                            txtEmailid.Text = dtTemp.Rows[0]["emailid"].ToString();
                            int cid = Convert.ToInt16(dtTemp.Rows[0]["cid"]);
                            int sid = Convert.ToInt16(dtTemp.Rows[0]["sid"]);
                            int ctid = Convert.ToInt16(dtTemp.Rows[0]["ctid"]);
                            int id = Convert.ToInt32(objDUT.GetScalar("select Titleid from Title where Title='" + dtTemp.Rows[0]["title"].ToString() + "'"));
                            ddlTitle.SelectedValue = id.ToString();
                            ddlCountry.SelectedValue = cid.ToString();
                            DataTable dtstate = new DataTable();
                            dtstate = objCL.Dll("Statedll", cid);
                            if (dtstate.Rows.Count == 0)
                            {
                                ddlState.Items.Insert(0, "--Select--");
                                Utility.ViewAlertMessage(Page, "No State for this country");
                                return;
                            }
                            ddlState.DataSource = dtstate;
                            ddlState.DataTextField = "stateName";
                            ddlState.DataValueField = "SID";
                            ddlState.DataBind();
                            ddlState.SelectedValue = sid.ToString();
                            DataTable dtcity = new DataTable();
                            dtcity = objCL.Dll("Citydll", sid);
                            if (dtcity.Rows.Count == 0)
                            {
                                ddlCity.Items.Insert(0, "--Select--");
                                Utility.ViewAlertMessage(Page, "No city for this state");
                                return;
                            }
                            ddlCity.DataSource = dtcity;
                            ddlCity.DataTextField = "cityname";
                            ddlCity.DataValueField = "ctid";
                            ddlCity.DataBind();
                            ddlCity.SelectedValue = ctid.ToString();
                            ddlDepartment.Items.Clear();
                            ddlDesigNation.Items.Clear();
                            if (CommonClass.ABC1("GetAllDepartment", Convert.ToInt32(Session["BrBrid"])).Rows.Count > 0)
                            {
                                ddlDepartment.DataSource = CommonClass.ABC1("GetAllDepartment", Convert.ToInt32(Session["BrBrid"]));
                                ddlDepartment.DataTextField = "deptName";
                                ddlDepartment.DataValueField = "deptid";

                                ddlDepartment.DataBind();
                                ListItem li = new ListItem("--Select Department--", "0");
                                ddlDepartment.Items.Insert(0, li);
                                ddlDesigNation.Items.Insert(0, new ListItem("--Select Designation--", "0"));
                            }
                            ddlDepartment.SelectedValue = dtTemp.Rows[0]["deptid"].ToString();
                            string que = "Select desigid,designame from designation_Master where status=1 and deptid=" + ddlDepartment.SelectedValue;
                            DataTable dtDesignation = objDUT.GetDataTable(que);
                            if (dtDesignation.Rows.Count > 0)
                            {
                                ddlDesigNation.DataSource = dtDesignation;
                                ddlDesigNation.DataTextField = "designame";
                                ddlDesigNation.DataValueField = "desigid";
                                ddlDesigNation.DataBind();
                                ddlDesigNation.Items.Insert(0, new ListItem("--Select Designation--", "0"));
                            }
                            ddlDesigNation.SelectedValue = dtTemp.Rows[0]["desigtype"].ToString();
                            txtRefNo.ReadOnly = true;
                        }
                        else
                        {
                            Utility.ViewAlertMessage(Page, "No Record Found.");
                            return;
                        }
                    }
                    catch (Exception ex)
                    {
                        Utility.ViewAlertMessage(Page, "Some Error");
                        return;
                    }
                }
            }
        }
    }

    protected void ddlPCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    protected void ddlPstate_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        dtTemp = CommonClass.ABC1("Statedll", Convert.ToInt16(ddlCountry.SelectedValue));
        if (dtTemp.Rows.Count == 0)
        {
            ddlState.Items.Clear();
            ddlState.Items.Insert(0, new ListItem("--Select --", "0"));
            Utility.ViewAlertMessage(Page, "No state find for this country");
            return;
        }
        ddlState.DataSource = dtTemp;
        ddlState.DataTextField = "stateName";
        ddlState.DataValueField = "SID";
        ddlState.DataBind();
    }

    protected void ddlState_SelectedIndexChanged2(object sender, EventArgs e)
    {
        dtTemp = CommonClass.ABC1("Citydll", Convert.ToInt16(ddlState.SelectedValue));
        if (dtTemp.Rows.Count == 0)
        {
            ddlCity.Items.Clear();
            ddlCity.Items.Insert(0, new ListItem("--Select --", "0"));
            Utility.ViewAlertMessage(Page, "No city find for this state");
            return;
        }
        ddlCity.DataSource = dtTemp;
        ddlCity.DataTextField = "cityname";
        ddlCity.DataValueField = "ctid";
        ddlCity.DataBind();
    }

    protected void btnSubmit_Click2(object sender, EventArgs e)
    {
        int idfac = Convert.ToInt32(objDUT.GetScalar("select ISNULL(Max(eid),0) from tblEmp_Master"));
        idfac++;

        string dob = ddlDOBMonth.SelectedValue + "/" + ddlDOBDay.SelectedValue + "/" + ddlDOBYear.SelectedValue;
        DateTime dt = Convert.ToDateTime(dob);
        string doj = txtDatejoining.Text;
        string dd = doj.Substring(0, 2);
        string mm = doj.Substring(3, 2);
        string yy = doj.Substring(6, 4);
        doj = mm + "/" + dd + "/" + yy;
        DateTime dt1 = Convert.ToDateTime(doj);
        SqlParameter[] param = new SqlParameter[75];
        param[0] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));
        param[1] = new SqlParameter("@refNo", txtRefNo.Text.Trim());
        param[2] = new SqlParameter("@staffID", "");
        param[3] = new SqlParameter("@title", ddlTitle.SelectedItem.Text);
        param[4] = new SqlParameter("@fname", txtFName.Text.Trim());
        param[5] = new SqlParameter("@mname", txtMName.Text.Trim());
        param[6] = new SqlParameter("@lname", txtLName.Text.Trim());
        param[7] = new SqlParameter("@gender", Convert.ToInt16(rdGender.SelectedValue));
        param[8] = new SqlParameter("@dob", dt);
        param[9] = new SqlParameter("@cid", Convert.ToInt16(ddlCountry.SelectedValue));
        param[10] = new SqlParameter("@sid", Convert.ToInt16(ddlState.SelectedValue));
        param[11] = new SqlParameter("@ctid", Convert.ToInt16(ddlCity.SelectedValue));
        param[12] = new SqlParameter("@address", txtAddressLine.Text.Trim());
        param[13] = new SqlParameter("@pinCode", txtPincode.Text.Trim());
        param[14] = new SqlParameter("@Tcid", Convert.ToInt16(ddlCountry.SelectedValue));
        param[15] = new SqlParameter("@Tsid", Convert.ToInt16(ddlState.SelectedValue));
        param[16] = new SqlParameter("@Tctid", Convert.ToInt16(ddlCity.SelectedValue));
        param[17] = new SqlParameter("@Taddress", txtAddressLine.Text.Trim());
        param[18] = new SqlParameter("@TpinCode", txtPincode.Text.Trim());
        param[19] = new SqlParameter("@doj", dt1);
        param[20] = new SqlParameter("@salary", txtSalary.Text.Trim());
        param[21] = new SqlParameter("@branchID", Convert.ToInt16(Session["BrBrid"]));
        param[22] = new SqlParameter("@probationPeriond", Convert.ToInt16(ddlProbationPeriod.SelectedValue));
        param[23] = new SqlParameter("@hrName", txtHrName.Text.Trim());
        param[24] = new SqlParameter("@mobile", txtContactNo.Text.Trim());
        param[25] = new SqlParameter("@phone", "");
        param[26] = new SqlParameter("@emailID", txtEmailid.Text);
        param[27] = new SqlParameter("@messanger", "");
        param[28] = new SqlParameter("@HQualificaton", "");
        param[29] = new SqlParameter("@QQualificaton", "");
        param[30] = new SqlParameter("@birthPlace", "");
        param[31] = new SqlParameter("@mStatus", Convert.ToInt32(rblMStatus.SelectedValue));
        param[32] = new SqlParameter("@noOfChilds", Convert.ToInt16(0));
        param[33] = new SqlParameter("@father", "");
        param[34] = new SqlParameter("@mother", "");
        param[35] = new SqlParameter("@panNo", "");
        param[36] = new SqlParameter("@voterIdNo", "");
        param[37] = new SqlParameter("@aadharNo", "");
        param[38] = new SqlParameter("@dlNo", "");
        param[39] = new SqlParameter("@comments", txtComment.Text.Trim());
        // param[40] = new SqlParameter("@photo", "");
        param[41] = new SqlParameter("@cv", "");
        param[42] = new SqlParameter("@isDocumentSubmit", "");
        param[43] = new SqlParameter("@emailAlloted", "");
        param[44] = new SqlParameter("@preOrganisation", "");
        param[45] = new SqlParameter("@pCid", Convert.ToInt16(0));
        param[46] = new SqlParameter("@pSid", Convert.ToInt16(0));
        param[47] = new SqlParameter("@pCtid", Convert.ToInt16(0));
        param[48] = new SqlParameter("@pPincode", "");
        param[49] = new SqlParameter("@pDesignation", "");
        param[50] = new SqlParameter("@pSalary", Convert.ToInt16(0));
        param[51] = new SqlParameter("@pDuration", Convert.ToInt16(0));
        param[52] = new SqlParameter("@totalExperience", Convert.ToInt16(0));
        param[53] = new SqlParameter("@ref1Name", "");
        param[54] = new SqlParameter("@ref1Contact", "");
        param[55] = new SqlParameter("@ref2Name", "");
        param[56] = new SqlParameter("@ref2Contact", "");
        param[57] = new SqlParameter("@bloodGroup", "");
        param[58] = new SqlParameter("@medicalCondition", "");
        param[59] = new SqlParameter("@pastDeseas", "");
        param[60] = new SqlParameter("@geneticDeseas", "");
        param[61] = new SqlParameter("@anyAlergy", "");
        param[62] = new SqlParameter("@accountNo", "");
        param[63] = new SqlParameter("@bankName", "");
        param[64] = new SqlParameter("@branchName", "");
        param[65] = new SqlParameter("@branchCode", "");
        param[66] = new SqlParameter("@IFSC", "");
        param[67] = new SqlParameter("@mode", Convert.ToInt16(ViewState["mode"]));
        param[68] = new SqlParameter("@intResult", Convert.ToInt16(0));
        param[68].Direction = ParameterDirection.Output;
        if (fuPhoto.HasFile)
        {
            if (fuPhoto.PostedFile.ContentLength <= 2097152)
            {
                string fileexe = Path.GetExtension(fuPhoto.FileName);
                if (fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".gif")
                {
                    string filename = Path.GetFileName(fuPhoto.PostedFile.FileName);

                    string targetPath = Server.MapPath(("~/facultyimage/" + idfac + filename));
                    Stream strm = fuPhoto.PostedFile.InputStream;
                    var targetFile = targetPath;
                    GenerateThumbnails(0.5, strm, targetFile);
                    param[40] = new SqlParameter("@photo", idfac + filename);
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Only Image files can be uploaded.");
                    return;
                }
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "File size greater than 2 mb.");
                fuPhoto.Focus();
                return;
            }
        }
        else
        {
            param[40] = new SqlParameter("@photo", "");
        }

        if (ddlDepartment.SelectedValue != "--Select Department--")
        {
            param[69] = new SqlParameter("@department", ddlDepartment.SelectedItem.Text);
            param[70] = new SqlParameter("@departmentID", Convert.ToInt16(ddlDepartment.SelectedValue));
        }
        else
        {
            param[69] = new SqlParameter("@department", "");
            param[70] = new SqlParameter("@departmentID", 0);
        }
        if (ddlDesigNation.SelectedValue != "--Select Designation--")
        {
            param[71] = new SqlParameter("@jobTitle", ddlDesigNation.SelectedItem.Text.Trim());
            param[72] = new SqlParameter("@desigType", Convert.ToInt16(ddlDesigNation.SelectedValue));
            param[73] = new SqlParameter("@designation", ddlDesigNation.SelectedItem.Text.Trim());
        }
        else
        {
            param[71] = new SqlParameter("@jobTitle", "");
            param[72] = new SqlParameter("@desigType", 0);
            param[73] = new SqlParameter("@designation", "");
        }
        param[74] = new SqlParameter("@facid", Convert.ToInt16("0"));

        int result = objDUT.ExecuteSqlSP(param, "usp_addEmp_Master");
        if (result == 1)
        {
            if (ddlDesigNation.SelectedItem.Text == "Teacher")
            {
                reset();
                Session["facID"] = Convert.ToInt32(objDUT.GetScalar("select max(eid) from tblEmp_Master where status=1"));
                Response.Redirect("../BranchPanel/Faculty/facultysubject.aspx");
            }
            else
            {
                // abc1.Visible = false;
                reset();
                Session["facID"] = Convert.ToInt32(objDUT.GetScalar("select max(eid) from tblEmp_Master where status=1"));
                Response.Redirect("CreateAppoinmentLetter.aspx");
            }

            //fillgrid();
            //btnSubmit.Enabled = false;
            //Utility.ViewAlertMessage(Page, "Record Saved Successfully");
            //return;
        }
        else
        {
            Utility.ViewAlertMessage(Page, "Record Not Saved ");
            return;
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

        ddlDOBDay.SelectedIndex = -1;
        ddlDOBMonth.SelectedIndex = -1;
        ddlDOBYear.SelectedIndex = -1;
        ddlTitle.SelectedIndex = -1;

        ddlCountry.SelectedIndex = -1;

        ddlState.SelectedIndex = -1;

        ddlCity.SelectedIndex = -1;
        txtPincode.Text = "";
        txtContactNo.Text = "";
        txtDatejoining.Text = "";
        txtEmailid.Text = "";
        txtSalary.Text = "";

        ddlDesigNation.SelectedIndex = -1;
        txtHrName.Text = "";
        ddlProbationPeriod.SelectedIndex = -1;
        ddlDesigNation.SelectedIndex = -1;
        txtAddressLine.Text = "";
    }

    protected void btnCreate_Click(object sender, EventArgs e)
    {
        IBExcel.Visible = false;
        divAppoinmentLetter.Visible = true;
        divgrdOfferLetter.Visible = false;

        ViewState["mode"] = 1;
        abc1.Visible = true;
    }

    protected void grdAppoinmentLetter_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ActionPerform")
        {
            ViewState["mode"] = 2;
            grdAppoinmentLetter.Visible = false;
            int eid = Convert.ToInt32(e.CommandArgument);
            Session["id"] = eid;
            Response.Redirect("editAppointment.aspx");
        }
        if (e.CommandName == "View")
        {
            int empID = Convert.ToInt32(e.CommandArgument);
            Response.Redirect("AppointmentLetter.aspx?eid=" + empID);
        }
    }

    protected void Cancel_Click(object sender, EventArgs e)
    {
        divgrdOfferLetter.Visible = true;
        divAppoinmentLetter.Visible = false;
        abc1.Visible = false;
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        PrepareGridViewForExport(GridView1);
        ExportGridView();
    }

    private void PrepareGridViewForExport(Control gv)
    {
        Label lb = new Label();

        Literal l = new Literal();

        string name = String.Empty;

        for (int i = 0; i < gv.Controls.Count; i++)
        {
            if (gv.Controls[i].GetType() == typeof(Label))
            {
                l.Text = (gv.Controls[i] as Label).Text;

                gv.Controls.Remove(gv.Controls[i]);

                gv.Controls.AddAt(i, l);
            }

            if (gv.Controls[i].HasControls())
            {
                PrepareGridViewForExport(gv.Controls[i]);
            }
        }
    }

    private void ExportGridView()
    {
        string attachment = "attachment; filename=Member_List.xls";

        Response.ClearContent();

        Response.AddHeader("content-disposition", attachment);

        Response.ContentType = "application/ms-excel";

        StringWriter sw = new StringWriter();

        HtmlTextWriter htw = new HtmlTextWriter(sw);

        // Create a form to contain the grid

        HtmlForm frm = new HtmlForm();

        GridView1.Parent.Controls.Add(frm);

        frm.Attributes["runat"] = "server";

        frm.Controls.Add(GridView1);

        frm.RenderControl(htw);

        //GridView1.RenderControl(htw);

        Response.Write(sw.ToString());

        Response.End();
    }

    protected void GridView1_OnRowCommand(object sender, GridViewCommandEventArgs e)
    {
    }

    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlDesigNation.Items.Clear();
        if (ddlDepartment.SelectedValue != "--Select Department--")
        {
            int deptid = Convert.ToInt16(ddlDepartment.SelectedValue);
            string que = "Select desigid,designame from designation_Master where status=1 and deptid=" + deptid;
            DataTable dtDesignation = objDUT.GetDataTable(que);
            if (dtDesignation.Rows.Count > 0)
            {
                ddlDesigNation.DataSource = dtDesignation;
                ddlDesigNation.DataTextField = "designame";
                ddlDesigNation.DataValueField = "desigid";
                ddlDesigNation.DataBind();
                ddlDesigNation.Items.Insert(0, new ListItem("--Select Designation--", "0"));
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "There's no designation in this department!! Please add in the master setting menu");
                return;
            }
        }
        else
        {
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (ddlsearchoption.SelectedIndex == 1)
        {
            if (Textbox1.Text == "")
            {
                Utility.ViewAlertMessage(this.Master.Page, "please enter name");
            }
            string q = @"select (te.fName+' '+te.lName) as comname,eid, c.countryName,td.designame,department, mobile,TE.refNo,emailID from designation_master TD,tblEmp_Master TE,CITY Ct,STATE s,COUNTRY c
                       where fname like '" + Textbox1.Text.Trim() + "' and td.desigid=te.desigtype and c.CID=te.cid and s.SID=te.sid and ct.ctid=te.ctid and te.brid= 1 order by eid desc";
            DataTable dtn = objDUT.GetDataTable(q);
            if (dtn.Rows.Count > 0)
            {
                grdAppoinmentLetter.DataSource = dtn;
                grdAppoinmentLetter.DataBind();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No record found!");
                grdAppoinmentLetter.DataSource = null;
                grdAppoinmentLetter.DataBind();
            }
        }
        else if (ddlsearchoption.SelectedIndex == 2)
        {
            if (Textbox1.Text == "")
            {
                Utility.ViewAlertMessage(this.Master.Page, "please enter mobileno");
            }

            string q = @"select (te.fName+' '+te.lName) as comname,eid, c.countryName,td.designame,department, mobile,TE.refNo,emailID from designation_master TD,tblEmp_Master TE,CITY Ct,STATE s,COUNTRY c
                        where mobile like '" + Textbox1.Text.Trim() + "' and td.desigid=te.desigtype and c.CID=te.cid and s.SID=te.sid and ct.ctid=te.ctid and te.brid= 1 order by eid desc ";
            DataTable dtp = objDUT.GetDataTable(q);
            if (dtp.Rows.Count > 0)
            {
                grdAppoinmentLetter.DataSource = dtp;
                grdAppoinmentLetter.DataBind();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No record found!");
                grdAppoinmentLetter.DataSource = null;
                grdAppoinmentLetter.DataBind();
            }
        }
        else if (ddlsearchoption.SelectedIndex == 0)
        {
            fillgrid(20, 1, 0, "");
            Utility.ViewAlertMessage(this.Master.Page, "No record found!");
        }
    }

    protected void ddlsearchoption_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlsearchoption.SelectedIndex == 1 || ddlsearchoption.SelectedIndex == 2)
        {
            Textbox1.Focus();
        }
    }

    protected void ddlRecordperPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlRecordperPage.SelectedValue != "0")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
            {
                setpage();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, "");
            }
            else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                setpage1();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
            }
            else if (ddlsearchoption.SelectedIndex == 2 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                setpage2();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
            }
            //else if (ddlsearchoption.SelectedIndex > 0 && !string.IsNullOrEmpty(Textbox1.Text))
            //{
            //    setpage3();
            //    fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
            //}
        }
        else
        {
            Textbox1.Text = string.Empty;
            ddlsearchoption.SelectedIndex = 0;
            ViewState["noofrecord"] = 20;
            ViewState["PageNo"] = 1;
            setpage();
            fillgrid(20, 1, 0, "");
        }
    }

    //private void setpage3()
    //{
    //    throw new NotImplementedException();
    //}

    private void setpage2()
    {
        string query = "select count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"] + " and eid=" + ddlsearchoption.SelectedValue + " and mobile like '" + Textbox1.Text.Trim() + "'";
        int i = 0;
        PageNo.Items.Clear();
        PageNo.Items.Insert(i, Convert.ToString("Page No"));
        totalpage = Convert.ToInt32(objDUT.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(objDUT.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
        {
            //  totalpage = totalpage + 1;
        }
        else
        {
            totalpage = totalpage + 1;
        }
        for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
        {
            PageNo.Items.Insert(page, Convert.ToString(page));
            page = page + 1;
        }
        if (Convert.ToInt32(ViewState["PageNo"]) > totalpage)
        {
            ViewState["PageNo"] = 1;
        }
    }

    private void setpage1()
    {
        string query = "select count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"] + " and eid=" + ddlsearchoption.SelectedValue + " and fname like '" + Textbox1.Text.Trim() + "'";
        int i = 0;
        PageNo.Items.Clear();
        PageNo.Items.Insert(i, Convert.ToString("Page No"));
        totalpage = Convert.ToInt32(objDUT.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(objDUT.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
        {
            //  totalpage = totalpage + 1;
        }
        else
        {
            totalpage = totalpage + 1;
        }
        for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
        {
            PageNo.Items.Insert(page, Convert.ToString(page));
            page = page + 1;
        }
        if (Convert.ToInt32(ViewState["PageNo"]) > totalpage)
        {
            ViewState["PageNo"] = 1;
        }
    }

    private void setpage()
    {
        string query = "select count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"];
        int i = 0;
        PageNo.Items.Clear();
        PageNo.Items.Insert(i, Convert.ToString("Page No"));
        totalpage = Convert.ToInt32(objDUT.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(objDUT.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
        {
            //  totalpage = totalpage + 1;
        }
        else
        {
            totalpage = totalpage + 1;
        }
        for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
        {
            PageNo.Items.Insert(page, Convert.ToString(page));
            page = page + 1;
        }
        if (Convert.ToInt32(ViewState["PageNo"]) > totalpage)
        {
            ViewState["PageNo"] = 1;
        }
    }

    private void fillgrid(int pagesize, int currentpage, int userid, string value)
    {
        param1[0] = new SqlParameter("@PageSize", pagesize);
        param1[1] = new SqlParameter("@CurrentPage", currentpage);
        param1[2] = new SqlParameter("@userid", userid);
        param1[3] = new SqlParameter("@activitydate", value);
        param1[4] = new SqlParameter("@id", Convert.ToInt16(Session["BrBrid"]));
        DataTable dt = objDUT.GetDataTableSP(param1, "usp_facultySearch");
        if (dt.Rows.Count > 0)
        {
            grdAppoinmentLetter.DataSource = dt;
            grdAppoinmentLetter.DataBind();
        }
        else
        {
            // Utility.ViewAlertMessage(this.Master.Page, "No record Found!");
            grdAppoinmentLetter.EmptyDataText = "No Record Found";
            grdAppoinmentLetter.DataSource = null;
            grdAppoinmentLetter.DataBind();
        }
        dt.Dispose();
    }

    protected void PageNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (PageNo.SelectedIndex > 0)
        {
            ViewState["PageNo"] = PageNo.SelectedItem.Text;
            if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, "");
            }
            else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
            }
            else if (ddlsearchoption.SelectedIndex == 2 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, Textbox1.Text.Trim());
            }
            //else if (ddlsearchoption.SelectedIndex > 0 && !string.IsNullOrEmpty(Textbox1.Text))
            //{
            //    fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlUser.SelectedValue), Convert.ToDateTime(txtToDate.Text.Trim()));
            //}
        }
        else
        {
            Textbox1.Text = string.Empty;
            ddlsearchoption.SelectedIndex = 0;
            setpage();
            fillgrid(20, 1, 0, "");
        }
    }

    protected void firstpage_Click(object sender, ImageClickEventArgs e)
    {
        ViewState["PageNo"] = 1;
        if (PageNo.SelectedIndex >= 1)
        {
            PageNo.SelectedIndex = 1;
        }
        else
        {
            PageNo.SelectedIndex = 0;
        }
        if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, "");
        }
        else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim().ToString());
        }
        else if (ddlsearchoption.SelectedIndex == 2 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim().ToString());
        }
    }

    protected void previous_Click(object sender, ImageClickEventArgs e)
    {
        int currentpage = Convert.ToInt32(ViewState["PageNo"]);
        if (currentpage > 1)
        {
            currentpage = currentpage - 1;
            ViewState["PageNo"] = currentpage;
            if (PageNo.Items.Count >= currentpage)
            {
                PageNo.SelectedIndex = currentpage;
            }
            //PageNo.SelectedIndex = currentpage;
            if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, "");
            }
            else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
            }
            else if (ddlsearchoption.SelectedIndex == 2 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
            }
        }
    }

    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        string query = "";
        if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
        {
            query = "select Count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"];
        }
        else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            query = "select count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"] + " and eid=" + ddlsearchoption.SelectedValue + " and fname like '" + Textbox1.Text.Trim() + "'";
        }
        else if (ddlsearchoption.SelectedIndex == 2 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            query = "select count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"] + " and eid=" + ddlsearchoption.SelectedValue + " and mobile like '" + Textbox1.Text.Trim() + "'";
        }
        //else if (ddlUser.SelectedIndex > 0 && !string.IsNullOrEmpty(txtToDate.Text))
        //{
        //    query = "select count(*) from ActivityLog where convert(date,activitydate)=cast('" + txtToDate.Text + "' as datetime) and userid=" + ddlUser.SelectedValue + "";
        //}

        totalpage = Convert.ToInt32(objDUT.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(objDUT.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
        {
            //  totalpage = totalpage + 1;
        }
        else
        {
            totalpage = totalpage + 1;
        }
        int currentpage = Convert.ToInt32(ViewState["PageNo"]);
        if (currentpage < totalpage)
        {
            currentpage = currentpage + 1;
            ViewState["PageNo"] = currentpage;
            if (PageNo.Items.Count >= currentpage)
            {
                PageNo.SelectedIndex = currentpage;
            }
            //PageNo.SelectedIndex = currentpage;
            if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, "");
            }
            else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
            }
            else if (ddlsearchoption.SelectedIndex == 2 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
            }
            //else if (ddlUser.SelectedIndex > 0 && !string.IsNullOrEmpty(txtToDate.Text))
            //{
            //    fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlUser.SelectedValue), Convert.ToDateTime(txtToDate.Text.Trim()));
            //}
        }
    }

    protected void last_Click(object sender, ImageClickEventArgs e)
    {
        string query = "";
        if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
        {
            query = "select Count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"];
        }
        else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            query = "select count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"] + " and eid=" + ddlsearchoption.SelectedValue + " and fname like '" + Textbox1.Text.Trim() + "'";
        }
        else if (ddlsearchoption.SelectedIndex == 2 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            query = "select count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"] + " and eid=" + ddlsearchoption.SelectedValue + " and mobile like '" + Textbox1.Text.Trim() + "'";
        }
        //else if (ddlUser.SelectedIndex > 0 && !string.IsNullOrEmpty(txtToDate.Text))
        //{
        //    query = "select count(*) from ActivityLog where convert(date,activitydate)=cast('" + txtToDate.Text + "' as datetime) and userid=" + ddlUser.SelectedValue + "";
        //}
        totalpage = Convert.ToInt32(objDUT.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(objDUT.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
        {
            //  totalpage = totalpage + 1;
        }
        else
        {
            totalpage = totalpage + 1;
        }
        ViewState["PageNo"] = totalpage;

        if (PageNo.Items.Count >= totalpage)
        {
            PageNo.SelectedIndex = totalpage;
        }

        if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, "");
        }
        else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
        }
        else if (ddlsearchoption.SelectedIndex == 2 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
        }
        //else if (ddlUser.SelectedIndex > 0 && !string.IsNullOrEmpty(txtToDate.Text))
        //{
        //    fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlUser.SelectedValue), Convert.ToDateTime(txtToDate.Text.Trim()));
        //}
    }
}