using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_StudentManagement_AllPromote : System.Web.UI.Page
{
    private string url;
    private int query;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private SqlDataReader dr;
    CommonClass objCommon = new CommonClass();
    int fyid = 0;
    string ViewMode = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        //fyid = Convert.ToInt32(ddlCurrFyid.SelectedValue);
        if (!IsPostBack)
        {
            IBExcel.Visible = false;
            tblStatusList.Visible = false;
            BindSessionDDL();
            BindClass();
            divall.Visible = false;
            divgrid.Visible = true;
            //fillclass();
            fillgrid();
            if (Request.QueryString.Count > 0)
            {
                string value = Request.QueryString["c1"];
            }
        }
    }
    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlFyid.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlFyid.DataValueField = "Fyid";
        ddlFyid.DataTextField = "FYName";
        ddlFyid.DataBind();
        ddlFyid.Items.Insert(0, new ListItem("--Select Session--", "0"));
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlFyid.SelectedValue = Convert.ToString(ActiveFinancialyear);

        ddlCurrFyid.DataSource = ddlFyid.DataSource;
        ddlCurrFyid.DataValueField = "Fyid";
        ddlCurrFyid.DataTextField = "FYName";
        ddlCurrFyid.DataBind();
        ddlCurrFyid.Items.Insert(0, new ListItem("--Select Session--", "0"));
        ddlCurrFyid.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        //required to avoid the run time error "  
        //Control 'GridView1' of type 'Grid View' must be placed inside a form tag with runat=server."  
    }
    private void ExportGridToExcel()
    {
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "Vithal" + DateTime.Now + ".xls";
        StringWriter strwritter = new StringWriter();
        HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
        grdStatus.GridLines = GridLines.Both;
        grdStatus.HeaderStyle.Font.Bold = true;
        grdStatus.RenderControl(htmltextwrtter);
        Response.Write(strwritter.ToString());
        Response.End();

    }
    public void BindClass()
    {
        CommonClass CommonClass = new CommonClass();
        DataTable Dt = new DataTable();
        //Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ddlCurrFyid.SelectedValue), Convert.ToInt32(HttpContext.Current.Session["BrBrid"].ToString()));
        Dt = objdut.GetDataTable(@"select ClassBranch_master.classid as classid,Class_Master.Classname from ClassBranch_master 
                    inner join Class_Master on Class_Master.id = ClassBranch_master.classid
                    where ClassBranch_master.BranchId=" + HttpContext.Current.Session["BrBrid"].ToString() + " and ClassBranch_master.Status=1 and " +
                    " ClassBranch_master.classid in (select id from Class_Master where Status=1 And Fyid=" + ddlCurrFyid.SelectedValue + ")");
        if (Dt.Rows.Count > 0)
        {
            ddlapplyingforclass.DataSource = Dt;
            ddlapplyingforclass.DataTextField = "Classname";
            ddlapplyingforclass.DataValueField = "classid";
            ddlapplyingforclass.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlapplyingforclass.Items.Insert(0, li);

            ddlPrmClass.DataSource = Dt;
            ddlPrmClass.DataTextField = "Classname";
            ddlPrmClass.DataValueField = "classid";
            ddlPrmClass.DataBind();
            ListItem li1 = new ListItem("--Select Class--", "0");
            ddlPrmClass.Items.Insert(0, li1);
        }
    }


    private void fillgrid()
    {
        DataTable dtStatus = new DataTable();
        dtStatus.Columns.Add("StatusID");
        dtStatus.Columns.Add("Statusname");

        DataRow dr = dtStatus.NewRow();
        dr["StatusID"] = "1";
        dr["Statusname"] = "Terminated";
        dtStatus.Rows.Add(dr);

        DataRow dr1 = dtStatus.NewRow();
        dr1["StatusID"] = "2";
        dr1["Statusname"] = "Transfered";
        dtStatus.Rows.Add(dr1);

        DataRow dr2 = dtStatus.NewRow();
        dr2["StatusID"] = "3";
        dr2["Statusname"] = "PassOut";
        dtStatus.Rows.Add(dr2);

        DataRow dr3 = dtStatus.NewRow();
        dr3["StatusID"] = "4";
        dr3["Statusname"] = "Promoted";
        dtStatus.Rows.Add(dr3);
        if (dtStatus.Rows.Count > 0)
        {
            griview_AllStatus.DataSource = dtStatus;
            griview_AllStatus.DataBind();
            btnAdd.Visible = false;
            Button1.Visible = false;
        }
        //else
        //{
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Please add Exam Name in the branch.')", true);
        //    return;
        //}
    }

    //public void fillclass()
    //{
    //    SqlParameter[] param = new SqlParameter[2];
    //    param[0] = new SqlParameter("@mode", 3);
    //    param[1] = new SqlParameter("@brid", Session["BrBrid"]);
    //    DataTable dt = objdut.GetDataTableSP(param, "Usp_Class");
    //    if (dt.Rows.Count > 0)
    //    {
    //        ddl_class.DataSource = dt;
    //        ddl_class.DataTextField = "Classname";
    //        ddl_class.DataValueField = "classid";
    //        ddl_class.DataBind();
    //        ddl_class.Items.Insert(0, new ListItem("--Select Class--", "0"));
    //    }
    //}
    public int SaveData(string SAMID, string lblStdNo, string ddlClass, string ddlSection, string hdfSessionID, string ChkStatus)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[12];
        param[0] = new SqlParameter("@SAMID", Convert.ToInt32(SAMID));
        param[1] = new SqlParameter("@Sturegno", Convert.ToInt32(lblStdNo));
        param[2] = new SqlParameter("@Mode", Convert.ToInt32(ChkStatus));
        param[3] = new SqlParameter("@intresult", SqlDbType.Int);
        param[3].Direction = ParameterDirection.Output;
        param[4] = new SqlParameter("@Comment", "");
        param[5] = new SqlParameter("@StatusChangeByUserId", Convert.ToInt32(HttpContext.Current.Session["BrADID"]));
        param[6] = new SqlParameter("@Brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"].ToString()));
        param[7] = new SqlParameter("@Systemname", System.Environment.MachineName);
        param[8] = new SqlParameter("@PromClassID", Convert.ToInt32(ddlClass));
        param[9] = new SqlParameter("@PromSectionID", Convert.ToInt32(ddlSection));
        param[10] = new SqlParameter("@Fyid", Convert.ToInt32(ddlFyid.SelectedValue));
        param[11] = new SqlParameter("@PrevFyid", Convert.ToInt32(ddlCurrFyid.SelectedValue));
        //param[12] = new SqlParameter("@CurrentClassID", Convert.ToInt32(hdfClassID));
        //param[13] = new SqlParameter("@CurretnSectID", Convert.ToInt32(hdfSectionID));
        int ret = Objdut.ExecuteSqlSP(param, "[Usp_ChangeStudentStatus]");
        return ret;
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        int ErrorCount = 0;
        string Error = "";
        if (checkvalidation())
        {
            foreach (GridViewRow row in grdStatus.Rows)
            {
                int ret = 0;
                DropDownList ddlClass = (row.Cells[0].FindControl("ddlClass") as DropDownList);
                DropDownList ddlSection1 = (row.Cells[0].FindControl("ddlSection1") as DropDownList);
                CheckBox ChkStatus = (row.Cells[0].FindControl("ChkStatus") as CheckBox);
                HiddenField lblSAMID = (row.Cells[0].FindControl("lblSAMID") as HiddenField);

                Label lblAdmNo = (row.Cells[0].FindControl("lblAdmNo") as Label);
                HiddenField hdfSessionID = (row.Cells[0].FindControl("hdfSessionID") as HiddenField);
                HiddenField hdfClassID = (row.Cells[0].FindControl("hdfClassID") as HiddenField);
                HiddenField hdfSectionID = (row.Cells[0].FindControl("hdfSectionID") as HiddenField);
                HiddenField lblStdNo = (row.Cells[0].FindControl("lblStdNo") as HiddenField);

                int PStatus = 0;
                if (ViewState["Status"] == null)
                {
                    ViewState["Status"] = 0;
                }
                else
                {
                    if (Convert.ToString(ViewState["Status"]) == "")
                    {
                        ViewState["Status"] = 0;
                    }
                    PStatus = Convert.ToInt32(ViewState["Status"]);
                }
                if (ChkStatus.Enabled == true)
                {
                    if (ChkStatus.Checked == true)
                    {
                        int Status = 0;
                        if (PStatus != 5)
                        {
                            if (Status < CheckPrmFee(lblSAMID.Value.ToString()))
                            {
                                ErrorCount++;
                            }
                            else
                            {
                                if (PStatus == 4)
                                {
                                    ret = SaveData(lblSAMID.Value.ToString(), lblStdNo.Value.ToString(), ddlClass.SelectedValue.ToString(), ddlSection1.SelectedValue.ToString(), ddlFyid.SelectedValue.ToString(), PStatus.ToString());
                                }
                                else
                                {
                                    ret = SaveData(lblSAMID.Value.ToString(), lblStdNo.Value.ToString(), ddlClass.SelectedValue.ToString(), ddlSection1.SelectedValue.ToString(), hdfSessionID.Value.ToString(), PStatus.ToString());
                                }
                                if (ret == 1)
                                {
                                    Error = "Student Status Update SuccessFully";
                                    divall.Visible = false;
                                    divgrid.Visible = true;
                                    Button2.Visible = true;
                                    Div2.Visible = false;
                                    Div3.Visible = false;
                                    Div4.Visible = false;
                                    ddlStatus1.SelectedValue = "0";
                                }
                            }
                        }
                        else
                        {
                            ret = SaveData(lblSAMID.Value.ToString(), lblStdNo.Value.ToString(), ddlClass.SelectedValue.ToString(), ddlSection1.SelectedValue.ToString(), hdfSessionID.Value.ToString(), PStatus.ToString());
                            if (ret == 1)
                            {
                                Error = "Student Status Update SuccessFully";
                                divall.Visible = false;
                                divgrid.Visible = true;
                                Button2.Visible = true;
                                Div2.Visible = false;
                                Div3.Visible = false;
                                Div4.Visible = false;
                                ddlStatus1.SelectedValue = "0";
                            }
                            else if (ret == 2)
                            {

                            }
                            else
                            {
                                if (Error == "")
                                {
                                    Error = lblAdmNo.Text.Trim();
                                }
                                else
                                {
                                    Error = Error + "," + lblAdmNo.Text.Trim();
                                }
                            }
                        }
                    }
                }
            }
            if (Error != "")
            {
                Utility.ViewAlertMessage(this.Master.Page, Error.ToString());
            }
            else
            {
                reset();
                fillgrid();
            }
        }
        if (ErrorCount > 0)
        {
            Error = "Some Student Status not updated because of DUE Fee .please Find it.";
            Utility.ViewAlertMessage(this.Master.Page, Error);
        }
    }
    public int CheckPrmFee(string SAMID)
    {
        int result = 0;
        //DataUtility Objdut = new DataUtility();
        //result = Convert.ToInt32(Objdut.GetScalar("Select (ISNULL(FeeWithoutDiscount,0)-(ISNULL(PaidFeeWithOutTax,0)+ISNULL(Discount,0))) from tbl_StudentAdmissionMaster where SAMID=" + SAMID + " and brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"].ToString()) + " and Fyid=" + ddlCurrFyid.SelectedValue + ""));
        return result;
    }

    private bool checkvalidation()
    {
        int counter = 0;
        int Fyidcounter = 0;
        int PrmCLasscounter = 0;
        int PrmSeccounter = 0;
        if (ddlStatus1.SelectedValue == "4")
        {
            if (ddlFyid.SelectedValue == "0")
            {
                Utility.ViewAlertMessage(this.Master.Page, "Please Select Session.");
                return false;
            }
            if (ddlPrmClass.SelectedValue == "0")
            {
                Utility.ViewAlertMessage(this.Master.Page, "Please Select Promoted Class");
                return false;
            }
            else
            {
                if (ddlapplyingforclass.SelectedValue != "0")
                {
                    if (ddlapplyingforclass.SelectedValue == ddlPrmClass.SelectedValue)
                    {
                        Utility.ViewAlertMessage(this.Master.Page, "Current Class and Promote Class can not same");
                        return false;
                    }
                }
            }
            if (ddlPrmSection.SelectedValue == "0")
            {
                Utility.ViewAlertMessage(this.Master.Page, "Please Select Promoted Section");
                return false;
            }
        }

        foreach (GridViewRow row in grdStatus.Rows)
        {
            CheckBox ChkStatus = (row.Cells[0].FindControl("ChkStatus") as CheckBox);
            if (ChkStatus.Enabled == true)
            {
                if (ChkStatus.Checked == true)
                {
                    counter = counter + 1;

                    if (ddlStatus1.SelectedValue == "4")
                    {

                        DropDownList ddlClass = (row.Cells[0].FindControl("ddlClass") as DropDownList);

                        if (ddlClass.SelectedValue == "0")
                        {
                            PrmCLasscounter = PrmCLasscounter + 1;
                        }

                        DropDownList ddlSection1 = (row.Cells[0].FindControl("ddlSection1") as DropDownList);

                        if (ddlSection1.SelectedValue == "0")
                        {
                            PrmSeccounter = PrmSeccounter + 1;
                        }
                    }
                }
            }
        }

        if (counter == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Give Status atleast One Student");
            return false;
        }
        if (Fyidcounter != 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Give Session to Student");
            return false;
        }
        if (PrmCLasscounter != 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Give Promote Class Student");
            return false;
        }
        if (PrmSeccounter != 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Give Promote Section Student");
            return false;
        }
        else
            return true;
    }

    private void reset()
    {
        ddlapplyingforclass.SelectedValue = "0";
        ddlSection.SelectedValue = "0";
        tblStatusList.Visible = false;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        reset();
        divall.Visible = false;
        divgrid.Visible = true;
        Button2.Visible = true;
    }

    protected void griview_AllStatus_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        string query = (string)ViewState["vie"];
        griview_AllStatus.PageIndex = e.NewPageIndex;
        fillgrid();
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        ddlStatus1.SelectedValue = "0";
        ddlapplyingforclass.SelectedValue = "0";
        ddlSection.SelectedValue = "0";
        ddlPrmClass.SelectedValue = "0";
        ddlPrmSection.SelectedValue = "0";
        divall.Visible = true;
        divgrid.Visible = false;
        Button2.Visible = true;
    }

    protected void griview_AllStatus_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int StatusID = Convert.ToInt32(e.CommandArgument);
        ViewState["sid"] = StatusID;
        if (e.CommandName == "ViewAll")
        {
            FillStudent(StatusID);
        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        //ddl_class.Items.Clear();
        //binddtream();
        divall.Visible = true;
        divgrid.Visible = false;
    }

    //public void binddtream()
    //{
    //    string ser = "select classid,stream_name from tbl_classstreammapping where brid=" + Session["BrBrid"] + " and status1=1 ";
    //    DataTable dt;
    //    dt = objdut.GetDataTable(ser);
    //    ddl_class.DataSource = dt;
    //    ddl_class.DataTextField = "stream_name";
    //    ddl_class.DataValueField = "classid";
    //    ddl_class.DataBind();
    //    ddl_class.Items.Insert(0, new ListItem("--Select Stream--", "0"));
    //}

    protected void griview_AllStatus_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int StatusID = 0;
            HiddenField hdfStatusID = (HiddenField)e.Row.FindControl("hdfStatusID");

            Label lblNoStd = (Label)e.Row.FindControl("lblNoStd");
            StatusID = Convert.ToInt32(hdfStatusID.Value);
            if (StatusID > 0)
            {
                string StrQuery = "Select Count(*) from tbl_StudentRegistration SR " +
                    " inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.Brid " +
                    " inner join tbl_StudentAdmissionMaster SA on SM.StuRegNo = SA.StuRegNo" +
                    " where SR.Brid=" + HttpContext.Current.Session["BrBrid"].ToString() + " and IsAdmissionTaken=1";
                if (StatusID == 1)
                {
                    StrQuery = StrQuery + " and SM.IsTerminated=1";
                }
                if (StatusID == 2)
                {
                    StrQuery = StrQuery + " and SM.IsTrasfered=1";
                }
                if (StatusID == 3)
                {
                    StrQuery = StrQuery + " and SM.IsCompleted=1";
                }
                if (StatusID == 4)
                {
                    StrQuery = StrQuery + " and SM.IsPromoted=1";
                }
                if (StatusID == 5)
                {
                    StrQuery = StrQuery + " and SM.IsTerminated=0 and SM.IsTrasfered=0 and SM.IsCompleted=0 and SM.IsPromoted=0";
                }
                lblNoStd.Text = Convert.ToString(objdut.GetScalar(StrQuery));
            }
        }
    }
    public void Section()
    {
        DataTable dtSec = new DataTable();
        string querynew = @"SELECT DISTINCT ISNULL(cs.cwsid,0) SectionID,ISNUll(cs.sectionname,'') SectionName from Class_Master SM
                            inner join classwithsection cs on cs.classid = SM.id
                            where SM.id=" + ddlapplyingforclass.SelectedValue + " and cs.branchid=" + HttpContext.Current.Session["BrBrid"].ToString() + " and SM.Fyid = " + ddlCurrFyid.SelectedValue + " and cs.status=1 order by sectionid asc";
        dtSec = objdut.GetDataTable(querynew);
        if (dtSec.Rows.Count > 0)
        {
            ddlSection.DataSource = dtSec;
            ddlSection.DataTextField = "SectionName";
            ddlSection.DataValueField = "SectionID";
            ddlSection.DataBind();
            ListItem li = new ListItem("--Select Section--", "0");
            ddlSection.Items.Insert(0, li);
        }
    }
    protected void ddlapplyingforclass_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlapplyingforclass.SelectedValue == "0")
        {
            tblStatusList.Visible = false;
            ddlSection.DataSource = null;
            ddlSection.DataBind();
        }
        else
        {
            Section();
        }
    }
    protected void grdStatus_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Edit1")
        {
            int index = Convert.ToInt32(e.CommandArgument.ToString());
            CheckBox ChkStatus = (CheckBox)grdStatus.Rows[index].FindControl("ChkStatus");
            ChkStatus.Enabled = true;

            DropDownList ddlClass = (DropDownList)grdStatus.Rows[index].FindControl("ddlClass");
            ddlClass.Enabled = true;

            DropDownList ddlSection1 = (DropDownList)grdStatus.Rows[index].FindControl("ddlSection1");
            ddlSection1.Enabled = true;
        }
    }
    protected void grdStatus_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            if (Convert.ToInt32(ddlStatus1.SelectedValue) == 4)
            {
                e.Row.Cells[5].Visible = true;
                e.Row.Cells[6].Visible = true;
            }
            else
            {
                e.Row.Cells[5].Visible = false;
                e.Row.Cells[6].Visible = false;
            }
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataTable Dt;
            CheckBox ChkStatus = (CheckBox)e.Row.FindControl("ChkStatus");
            DropDownList ddlClass = (DropDownList)e.Row.FindControl("ddlClass");
            DropDownList ddlSection1 = (DropDownList)e.Row.FindControl("ddlSection1");

            HiddenField hdfStatusID = (HiddenField)e.Row.FindControl("hdfStatusID");
            HiddenField hdfSessionID = (HiddenField)e.Row.FindControl("hdfSessionID");
            HiddenField hdfClassID = (HiddenField)e.Row.FindControl("hdfClassID");
            HiddenField hdfSectionID = (HiddenField)e.Row.FindControl("hdfSectionID");

            Label lblClassSec = (Label)e.Row.FindControl("lblClassSec");
            Label lblStatusName = (Label)e.Row.FindControl("lblStatusName");

            string[] ClassSection = lblClassSec.Text.Split('~');

            if (hdfStatusID.Value == "1")
            {
                lblStatusName.Text = "Terminated";
            }
            if (hdfStatusID.Value == "2")
            {
                lblStatusName.Text = "Transfered";
            }
            if (hdfStatusID.Value == "3")
            {
                lblStatusName.Text = "Passout";
            }
            if (hdfStatusID.Value == "4")
            {
                lblStatusName.Text = "Promoted";
            }
            if (hdfStatusID.Value == "5")
            {
                lblStatusName.Text = "Running";
            }
            CommonClass CommonClass = new CommonClass();
            if (ViewMode == "")
            {
                DataTable dtStatus = new DataTable();
                dtStatus.Columns.Add("StatusID");
                dtStatus.Columns.Add("Statusname");

                DataRow dr = dtStatus.NewRow();
                dr["StatusID"] = "1";
                dr["Statusname"] = "Terminated";
                dtStatus.Rows.Add(dr);

                DataRow dr1 = dtStatus.NewRow();
                dr1["StatusID"] = "2";
                dr1["Statusname"] = "Transfered";
                dtStatus.Rows.Add(dr1);

                DataRow dr2 = dtStatus.NewRow();
                dr2["StatusID"] = "3";
                dr2["Statusname"] = "PassOut";
                dtStatus.Rows.Add(dr2);

                DataRow dr3 = dtStatus.NewRow();
                dr3["StatusID"] = "4";
                dr3["Statusname"] = "Promoted";
                dtStatus.Rows.Add(dr3);

                DataRow dr4 = dtStatus.NewRow();
                dr4["StatusID"] = "5";
                dr4["Statusname"] = "Running";
                dtStatus.Rows.Add(dr4);

                //Fill Class
                CommonClass CommonClass1 = new CommonClass();
                Dt = new DataTable();
                //Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ddlFyid.SelectedValue), Convert.ToInt32(HttpContext.Current.Session["BrBrid"].ToString()));
                Dt = objdut.GetDataTable(@"select ClassBranch_master.classid as classid,Class_Master.Classname from ClassBranch_master 
                    inner join Class_Master on Class_Master.id = ClassBranch_master.classid
                    where ClassBranch_master.BranchId=" + HttpContext.Current.Session["BrBrid"].ToString() + " and ClassBranch_master.Status=1 and " +
                   " ClassBranch_master.classid in (select id from Class_Master where Status=1 And Fyid=" + ddlFyid.SelectedValue + ")");
                if (Dt.Rows.Count > 0)
                {
                    ddlClass.DataSource = Dt;
                    ddlClass.DataTextField = "Classname";
                    ddlClass.DataValueField = "classid";
                    ddlClass.DataBind();
                    ddlClass.Items.Insert(0, new ListItem("--Select Class--", "0"));
                    ddlClass.SelectedValue = ClassSection[0].ToString();
                }

                //Fill Section
                DataTable dtSec = new DataTable();
                string querynew = @"SELECT DISTINCT ISNULL(cs.cwsid,0) SectionID,ISNUll(cs.sectionname,'') SectionName from Class_Master SM
                            inner join classwithsection cs on cs.classid = SM.id
                            where SM.id=" + ddlClass.SelectedValue + " and cs.branchid=" + HttpContext.Current.Session["BrBrid"].ToString() + " and SM.Fyid = " + ddlFyid.SelectedValue + " and cs.status=1 order by sectionid asc";
                dtSec = objdut.GetDataTable(querynew);
                if (dtSec.Rows.Count > 0)
                {
                    ddlSection1.DataSource = dtSec;
                    ddlSection1.DataTextField = "SectionName";
                    ddlSection1.DataValueField = "SectionID";
                    ddlSection1.DataBind();
                    ddlSection1.Items.Insert(0, new ListItem("--Select Section--", "0"));
                }

                if (Convert.ToInt32(ddlStatus1.SelectedValue) == 4)
                {
                    ddlSection1.SelectedValue = hdfSectionID.Value.ToString();
                    e.Row.Cells[5].Visible = true;
                    e.Row.Cells[6].Visible = true;
                }
                else
                {
                    e.Row.Cells[5].Visible = false;
                    e.Row.Cells[6].Visible = false;
                }

                if (Convert.ToInt32(hdfStatusID.Value) > 0)
                {
                    if (Convert.ToInt32(hdfStatusID.Value) != 5)
                    {
                        ChkStatus.Checked = true;
                        ChkStatus.Enabled = false;
                        ddlFyid.Enabled = false;
                        ddlClass.Enabled = false;
                        ddlSection1.Enabled = false;
                    }
                    else
                    {
                        ChkStatus.Checked = false;
                    }
                }
                //e.Row.Cells[5].Visible = true;
                //e.Row.Cells[6].Visible = true;
                one.Visible = true;
                two.Visible = true;
            }
            else
            {
                e.Row.Cells[5].Visible = false;
                e.Row.Cells[6].Visible = false;
//one.Visible = false;
               // two.Visible = false;
            }

            string strQuery = "";
            strQuery = @"SELECT ISNUll(MC.Classname,'')+'-'+ISNULL(CS.sectionname,'') AS ClassSection from Class_Master MC
                        inner join classwithsection CS on CS.classid =MC.ID
                        where CS.branchid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"].ToString()) + " and MC.id=" + ClassSection[0] + " and cwsid=" + ClassSection[1] + "";

            lblClassSec.Text = Convert.ToString(objdut.GetScalar(strQuery));

        }
    }
    public void FillStudent(int StatusID)
    {
        string querynew1 = "";
        DataTable dtStd = new DataTable();
        int fyid = objCommon.GetActiveAcedmicYear();
        if (StatusID > 0)
        {
            if (StatusID == 1)
            {
                querynew1 = " and SM.IsTerminated=1";
            }
            if (StatusID == 2)
            {
                querynew1 = " and SM.IsTrasfered=1";
            }
            if (StatusID == 3)
            {
                querynew1 = " and SM.IsCompleted=1";
            }
            if (StatusID == 4)
            {
                querynew1 = " and SM.IsPromoted=1";
            }
            if (StatusID == 5)
            {
                querynew1 = " and SM.IsTerminated=0 and SM.IsTrasfered=0 and SM.IsCompleted=0 and SM.IsPromoted=0";
            }
            querynew1 = querynew1 + " Order by StudentName asc";
            divgrid.Visible = false;
            IBExcel.Visible = true;
            ViewMode = "ViewMode";
        }
        else
        {
            ViewMode = "";
            querynew1 = " and SR.ApplyingForClass=" + ddlapplyingforclass.SelectedValue + " and SA.SectionId=" + ddlSection.SelectedValue + " Order by StudentName asc";
        }

        string querynew = @"SELECT DISTINCT ISNULL(SA.ClassID,0) Class,SR.Fyid,ISNULL(SA.SectionId,0) Sec,CASE WHen SM.IsPromoted=1 Then 4 WHen SM.IsTerminated=1 Then 1 WHen SM.IsTrasfered=1 then 2 WHen SM.IsCompleted=1 Then 3 else 5 END as statusID,ISNULL(SM.StuRegNo,0) StuRegNo,ISNULL(SA.SAMID,0) SAMID,ISNULL(SA.AdmissionNo,'') AdmissionNo,ISNULL(SR.HouseID,0) HouseID ,
                            CASE WHEN SR.HouseID > 0 THEN 'TRUE' ELSE 'FALSE' END AS Status, ISNULL(SR.StudentFirstName,'')+' '+ISNULL(SR.StudentMiddleName,'')+' '+ISNULL(SR.StudentLastName,'') AS StudentName
                           from tbl_StudentRegistration SR
                            inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.Brid
                            inner join tbl_StudentAdmissionMaster SA on SM.StuRegNo = SA.StuRegNo                            
                            where SM.IsTerminated=0 and SR.Brid=" + Session["BrBrid"] + querynew1;

        ViewState["vie"] = querynew;
        dtStd = objdut.GetDataTable(querynew);
        if (dtStd.Rows.Count > 0)
        {
            grdStatus.DataSource = dtStd;
            grdStatus.DataBind();

            //if (StatusID > 0)
            //{
            //    grdStatus.HeaderRow.Cells[5].Visible = false;
            //    grdStatus.HeaderRow.Cells[6].Visible = false;
            //}
            //else
            //{
            //    grdStatus.HeaderRow.Cells[5].Visible = true;
            //    grdStatus.HeaderRow.Cells[6].Visible = true;
            //}
        }
        else
        {
            grdStatus.DataSource = null;
            grdStatus.DataBind();
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Sorry, No Student Found')", true);
            //fillgrid();
            //Response.Redirect("AllPromote.aspx");
        }
        tblStatusList.Visible = true;
        divall.Visible = true;
    }
    protected void ddlSection_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSection.SelectedValue == "0")
        {
            DataTable dtStd = new DataTable();
            dtStd = null;
            tblStatusList.Visible = false;
            ddlSection.DataSource = dtStd;
            ddlSection.DataBind();
        }
        else
        {
            btnAdd.Visible = true;
            Button1.Visible = true;
            FillStudent(0);
        }

    }
    protected void IBExcel_Click(object sender, EventArgs e)
    {
        ExportGridToExcel();
    }
    protected void grdStatus_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdStatus.PageIndex = e.NewPageIndex;
        FillStudent(0);
    }
    protected void ddlPrmClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlPrmClass.SelectedValue == "0")
        {
            foreach (GridViewRow row in grdStatus.Rows)
            {
                DropDownList ddlClass = (row.Cells[0].FindControl("ddlClass") as DropDownList);
                CheckBox ChkStatus = (row.Cells[0].FindControl("ChkStatus") as CheckBox);
                if (ChkStatus.Enabled == true)
                {
                    ddlClass.SelectedValue = "0";
                }
            }
            //DataTable dtStd = new DataTable();
            //dtStd = null;
            //tblStatusList.Visible = false;
            //ddlSection.DataSource = dtStd;
            //ddlSection.DataBind();
        }
        else
        {
            DataTable dtSec = new DataTable();
            string querynew = @"SELECT DISTINCT ISNULL(cs.cwsid,0) SectionID,ISNUll(cs.sectionname,'') SectionName from Class_Master SM
                            inner join classwithsection cs on cs.classid = SM.id
                            where SM.id=" + ddlPrmClass.SelectedValue + " and cs.branchid=" + HttpContext.Current.Session["BrBrid"].ToString() + " and SM.Fyid = " + ddlFyid.SelectedValue + " and cs.status=1 order by sectionid asc";
            dtSec = objdut.GetDataTable(querynew);
            if (dtSec.Rows.Count > 0)
            {
                ddlPrmSection.DataSource = dtSec;
                ddlPrmSection.DataTextField = "SectionName";
                ddlPrmSection.DataValueField = "SectionID";
                ddlPrmSection.DataBind();
                ListItem li = new ListItem("--Select Section--", "0");
                ddlPrmSection.Items.Insert(0, li);
            }

            foreach (GridViewRow row in grdStatus.Rows)
            {
                DropDownList ddlClass = (row.Cells[0].FindControl("ddlClass") as DropDownList);
                CheckBox ChkStatus = (row.Cells[0].FindControl("ChkStatus") as CheckBox);

                if (ChkStatus.Enabled == true)
                {
                    //Fill Class
                    CommonClass CommonClass1 = new CommonClass();
                    DataTable Dt = new DataTable();
                    //Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ddlFyid.SelectedValue), Convert.ToInt32(HttpContext.Current.Session["BrBrid"].ToString()));
                    Dt = objdut.GetDataTable(@"select ClassBranch_master.classid as classid,Class_Master.Classname from ClassBranch_master 
                    inner join Class_Master on Class_Master.id = ClassBranch_master.classid
                    where ClassBranch_master.BranchId=" + HttpContext.Current.Session["BrBrid"].ToString() + " and ClassBranch_master.Status=1 and " +
                       " ClassBranch_master.classid in (select id from Class_Master where Status=1 And Fyid=" + ddlFyid.SelectedValue + ")");
                    if (Dt.Rows.Count > 0)
                    {
                        ddlClass.DataSource = Dt;
                        ddlClass.DataTextField = "Classname";
                        ddlClass.DataValueField = "classid";
                        ddlClass.DataBind();
                        ddlClass.Items.Insert(0, new ListItem("--Select Class--", "0"));
                        //ddlClass.SelectedValue = ClassSection[0].ToString();
                    }

                    ddlClass.SelectedValue = ddlPrmClass.SelectedValue;
                }
            }
        }
    }
    protected void ddlStatus1_SelectedIndexChanged(object sender, EventArgs e)
    {
        ViewState["Status"] = ddlStatus1.SelectedValue;
        if (ddlStatus1.SelectedValue != "0")
        {
            //divSelectAll.Visible = true;
            
            if (Convert.ToInt32(ddlStatus1.SelectedValue) == 4)
            {
                if (Convert.ToInt32(grdStatus.Rows.Count) > 0)
                {
                    Div2.Visible = true;
                    Div3.Visible = true;
                    Div4.Visible = true;

                    grdStatus.HeaderRow.Cells[5].Visible = true;
                    grdStatus.HeaderRow.Cells[6].Visible = true;

                    foreach (GridViewRow row in grdStatus.Rows)
                    {

                        row.Cells[5].Visible = true;
                        row.Cells[6].Visible = true;
                    }
                    //ddlFyid_SelectedIndexChanged(null, null);
                    ddlFyid.Enabled = true;
                    ddlFyid.SelectedValue = "0";
                }
            }
            else
            {
                //divSelectAll.Visible = false;
                Div2.Visible = false;
                Div3.Visible = false;
                Div4.Visible = false;

                grdStatus.HeaderRow.Cells[5].Visible = false;
                grdStatus.HeaderRow.Cells[6].Visible = false;

                foreach (GridViewRow row in grdStatus.Rows)
                {
                    row.Cells[5].Visible = false;
                    row.Cells[6].Visible = false;
                }
            }
        }
    }
    protected void ddlCurrFyid_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCurrFyid.SelectedValue != "0")
        {
            BindClass();
        }
        else
        {
            Response.Redirect("AllPromote.aspx");
        }
        ddlapplyingforclass.SelectedValue = "0";
        ddlSection.SelectedValue = "0";
        ddlStatus1.SelectedValue = "0";
        ddlPrmClass.SelectedValue = "0";
        ddlPrmSection.SelectedValue = "0";
    }
    protected void ddlFyid_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlFyid.SelectedValue != "0")
        {
            DataTable Dt = new DataTable();
            Dt = objdut.GetDataTable(@"select ClassBranch_master.classid as classid,Class_Master.Classname from ClassBranch_master 
                    inner join Class_Master on Class_Master.id = ClassBranch_master.classid
                    where ClassBranch_master.BranchId=" + HttpContext.Current.Session["BrBrid"].ToString() + " and ClassBranch_master.Status=1 and " +
                    " ClassBranch_master.classid in (select id from Class_Master where Status=1 And Fyid=" + ddlFyid.SelectedValue + ")");
            if (Dt.Rows.Count > 0)
            {
                ddlPrmClass.DataSource = Dt;
                ddlPrmClass.DataTextField = "Classname";
                ddlPrmClass.DataValueField = "classid";
                ddlPrmClass.DataBind();
                ListItem li1 = new ListItem("--Select Class--", "0");
                ddlPrmClass.Items.Insert(0, li1);
            }
        }
        else
        {
            Response.Redirect("AllPromote.aspx");
        }
        //ddlapplyingforclass.SelectedValue = "0";
        //ddlSection.SelectedValue = "0";
        //ddlStatus1.SelectedValue = "0";
        ddlPrmClass.SelectedValue = "0";
        ddlPrmSection.SelectedValue = "0";
    }
    protected void ddlPrmSection_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlPrmSection.SelectedValue != "0")
        {
            foreach (GridViewRow row in grdStatus.Rows)
            {
                CheckBox ChkStatus = (row.Cells[0].FindControl("ChkStatus") as CheckBox);
                if (ChkStatus.Enabled == true)
                {
                    DropDownList ddlClass = (row.Cells[0].FindControl("ddlClass") as DropDownList);
                    DropDownList ddlSection1 = (row.Cells[0].FindControl("ddlSection1") as DropDownList);
                    DataTable dtSec = new DataTable();
                    string querynew = @"SELECT DISTINCT ISNULL(cs.cwsid,0) SectionID,ISNUll(cs.sectionname,'') SectionName from Class_Master SM
                            inner join classwithsection cs on cs.classid = SM.id
                            where SM.id=" + ddlClass.SelectedValue + " and cs.branchid=" + HttpContext.Current.Session["BrBrid"].ToString() + " and SM.Fyid = " + ddlFyid.SelectedValue + " and cs.status=1 order by sectionid asc";
                    dtSec = objdut.GetDataTable(querynew);
                    if (dtSec.Rows.Count > 0)
                    {
                        ddlSection1.DataSource = dtSec;
                        ddlSection1.DataTextField = "SectionName";
                        ddlSection1.DataValueField = "SectionID";
                        ddlSection1.DataBind();
                        ddlSection1.Items.Insert(0, new ListItem("--Select Section--", "0"));
                        ddlSection1.SelectedValue = ddlPrmSection.SelectedValue;
                    }
                }
            }
        }
        else
        {
            foreach (GridViewRow row in grdStatus.Rows)
            {
                DropDownList ddlSection1 = (row.Cells[0].FindControl("ddlSection1") as DropDownList);
                CheckBox ChkStatus = (row.Cells[0].FindControl("ChkStatus") as CheckBox);
                if (ChkStatus.Enabled == true)
                {
                    ddlSection1.SelectedValue = "0";
                }
            }
        }
    }

    protected void chkEditAll_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow row in grdStatus.Rows)
        {
            CheckBox ChkStatus = (row.Cells[0].FindControl("ChkStatus") as CheckBox);
            DropDownList ddlClass = (row.Cells[0].FindControl("ddlClass") as DropDownList);
            DropDownList ddlSection1 = (row.Cells[0].FindControl("ddlSection1") as DropDownList);

            ChkStatus.Enabled = true;
            ddlClass.Enabled = true;
            ddlSection1.Enabled = true;
        } 
    }
}