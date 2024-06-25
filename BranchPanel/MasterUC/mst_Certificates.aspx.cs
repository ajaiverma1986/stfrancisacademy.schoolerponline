﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_MasterUC_mst_Certificates : System.Web.UI.Page
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
        if (!IsPostBack)
        {
            //IBExcel.Visible = false;
            tblHouseList.Visible = false;
            BindFinancialYear();
            //BindClass();
            //divall.Visible = false;
            //divgrid.Visible = true;
            //fillclass();
            fillgrid();
            if (Request.QueryString.Count > 0)
            {
                string value = Request.QueryString["c1"];
            }
        }
    }

    private void BindFinancialYear()
    {
        CommonClass CommonClass = new CommonClass();
        ddlFyid.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlFyid.DataValueField = "Fyid";
        ddlFyid.DataTextField = "FYName";
        ddlFyid.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlFyid.SelectedValue = Convert.ToString(ActiveFinancialyear);
        if (ActiveFinancialyear > 0) {
            BindClass();
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        //required to avoid the run time error "  
        //Control 'GridView1' of type 'Grid View' must be placed inside a form tag with runat=server."  
    }
    protected void grdHouse_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdHouse.PageIndex = e.NewPageIndex;
        FillStudent(0);
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
        grdHouse.GridLines = GridLines.Both;
        grdHouse.HeaderStyle.Font.Bold = true;
        grdHouse.RenderControl(htmltextwrtter);
        Response.Write(strwritter.ToString());
        Response.End();

    }
    public void BindClass()
    {
        CommonClass CommonClass = new CommonClass();
        DataTable Dt = new DataTable();
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ddlFyid.SelectedValue), Convert.ToInt32(Session["BrBrid"]));
        ddlapplyingforclass.DataSource = Dt;
        ddlapplyingforclass.DataTextField = "Classname";
        ddlapplyingforclass.DataValueField = "classid";
        ddlapplyingforclass.DataBind();
        ListItem li = new ListItem("--Select Class--", "0");
        ddlapplyingforclass.Items.Insert(0, li);
    }


    private void fillgrid()
    {
        //string querynew = @"Select HouseID,Housename from mst_House where Brid=" + Session["BrBrid"] + " and isActive=1 order by HouseID asc";
        //ViewState["vie"] = querynew;
        //dt = objdut.GetDataTable(querynew);
        //if (dt.Rows.Count > 0)
        //{
        //    griview_AllHouse.DataSource = dt;
        //    griview_AllHouse.DataBind();
        //    btnAdd.Visible = false;
        //    Button1.Visible = false;
        //}
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

    protected void btSave_Click(object sender, EventArgs e)
    {
        string Error = "";
        if (checkvalidation())
        {
            foreach (GridViewRow row in grdHouse.Rows)
            {
                DropDownList ddlHouse = (row.Cells[0].FindControl("ddlHouse") as DropDownList);
                if (ddlHouse.Enabled == true)
                {
                    Label lblAdmNo = (row.Cells[0].FindControl("lblAdmNo") as Label);
                    HiddenField lblStdNo = (row.Cells[0].FindControl("lblStdNo") as HiddenField);

                    SqlParameter[] param = new SqlParameter[6];
                    param[0] = new SqlParameter("@mode", Convert.ToInt32(0));
                    param[1] = new SqlParameter("@HouseID", ddlHouse.SelectedValue.Trim());
                    param[2] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
                    param[3] = new SqlParameter("@AdmNo", lblAdmNo.Text.Trim());
                    param[4] = new SqlParameter("@StdNo", Convert.ToInt32(lblStdNo.Value));
                    param[5] = new SqlParameter("@intResult", Convert.ToInt32(0));
                    param[5].Direction = ParameterDirection.Output;
                    int ret = objdut.ExecuteSqlSP(param, "usp_GiveHouse");
                    if (ret == 1)
                    {
                        Error = "Student House Update SuccessFully";
                        divall.Visible = false;
                        //divgrid.Visible = true;
                        //Button2.Visible = true;
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
            Utility.ViewAlertMessage(this.Master.Page, Error.ToString());
        }
        else
        {
            Error = Error + "Admission No Not Updated";
            Utility.ViewAlertMessage(this.Master.Page, Error);
        }
        reset();
        fillgrid();
    }

    private bool checkvalidation()
    {
        int counter = 0;

        foreach (GridViewRow row in grdHouse.Rows)
        {
            DropDownList ddlHouse = (row.Cells[0].FindControl("ddlHouse") as DropDownList);

            if (ddlHouse.SelectedValue != "0")
            {
                counter = counter + 1;
            }
        }

        if (counter == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Give House atleast One Student");
            return false;
        }
        else
            return true;
    }

    private void reset()
    {
        ddlapplyingforclass.SelectedValue = "0";
        ddlSection.SelectedValue = "0";
        tblHouseList.Visible = false;
        ddlFyid.SelectedValue = "0";
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        reset();
        divall.Visible = false;
        //divgrid.Visible = true;
        //Button2.Visible = true;
    }

    protected void griview_AllHouse_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        string query = (string)ViewState["vie"];
        //griview_AllHouse.PageIndex = e.NewPageIndex;
        fillgrid();
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        //ddl_class.Items.Clear();
        //fillclass();
        divall.Visible = true;
        //divgrid.Visible = false;
        //Button2.Visible = true;
    }

    protected void griview_AllHouse_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int HouseID = Convert.ToInt32(e.CommandArgument);
        ViewState["sid"] = HouseID;
        if (e.CommandName == "ViewAll")
        {
            FillStudent(HouseID);
        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        //ddl_class.Items.Clear();
        //binddtream();
        divall.Visible = true;
        //divgrid.Visible = false;
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

    protected void griview_AllHouse_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    int HouseID = 0;
        //    HiddenField hdfhouseID = (HiddenField)e.Row.FindControl("hdfhouseID");

        //    Label lblNoStd = (Label)e.Row.FindControl("lblNoStd");
        //    HouseID = Convert.ToInt32(hdfhouseID.Value);
        //    if (HouseID > 0)
        //    {
        //        lblNoStd.Text = Convert.ToString(objdut.GetScalar("Select Count(*) from tbl_StudentRegistration where Brid=" + Session["BrBrid"] + " and Fyid=" + fyid + " and HouseID=" + HouseID + " and IsAdmissionTaken=1 "));
        //    }
        //}
    }
    public void Section()
    {
        DataTable dtSec = new DataTable();
        string querynew = @"SELECT DISTINCT ISNULL(cs.cwsid,0) SectionID,ISNUll(cs.sectionname,'') SectionName from tbl_StudentMaster SM
                            inner join classwithsection cs on cs.classid = SM.Classid
                            where SM.Classid=" + ddlapplyingforclass.SelectedValue + " and cs.branchid=" + Session["BrBrid"] + " and SM.Fyid = " + ddlFyid.SelectedValue + " and cs.status=1 order by sectionid asc";
        dtSec = objdut.GetDataTable(querynew);
        ddlSection.DataSource = dtSec;
        ddlSection.DataTextField = "SectionName";
        ddlSection.DataValueField = "SectionID";
        ddlSection.DataBind();
        ListItem li = new ListItem("--Select Section--", "0");
        ddlSection.Items.Insert(0, li);
    }
    protected void ddlapplyingforclass_SelectedIndexChanged(object sender, EventArgs e)
    {
        grdHouse.DataSource = null;
        grdHouse.DataBind();
        if (ddlapplyingforclass.SelectedValue == "0")
        {
            tblHouseList.Visible = false;
            ddlSection.DataSource = null;
            ddlSection.DataBind();
        }
        else
        {
            Section();
        }
    }
    protected void grdHouse_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Edit1")
        {
            int index = Convert.ToInt32(e.CommandArgument.ToString());
            //DropDownList ddlHouse = (DropDownList)grdHouse.Rows[index].FindControl("ddlHouse");
            //ddlHouse.Enabled = true;
            Response.Redirect("ListOfCerti.aspx?RID=" + index);
        }
    }
    protected void grdHouse_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField lblStdNo = (HiddenField)e.Row.FindControl("lblStdNo");
            DataUtility ObjDut = new DataUtility();
            Label lblClassSec = (Label)e.Row.FindControl("lblClassSec");
            Label lblTCCount = (Label)e.Row.FindControl("lblTCCount");
            string[] ClassSection = lblClassSec.Text.Split('~');

            lblClassSec.Text = objdut.GetScalar(@"SELECT ISNUll(MC.Classname,'')+'-'+ISNULL(CS.sectionname,'') AS ClassSection from Class_Master MC
                        inner join classwithsection CS on CS.classid =MC.ID
                        where CS.branchid=" + Convert.ToInt32(Session["BrBrid"]) + " and MC.id=" + ClassSection[0] + " and cwsid=" + ClassSection[1] + "").ToString();
            lblTCCount.Text = ((int)(ObjDut.GetScalar(@"Select Count(*) from tbl_StudentRegistration SR
                        inner join tbl_StudentMaster SM on SM.RID = SR.RID
                        inner join tbl_TcVerify ST on ST.StdRegNo = SR.Registration_No where SM.SturegNo="+lblStdNo.Value+" and SR.Brid=" + Convert.ToInt32(Session["BrBrid"]) + " and IsActive=1"))).ToString();
        }
    }
    public void FillStudent(int HouseID)
    {
        string querynew1 = "";
        DataTable dtStd = new DataTable();
        int fyid = objCommon.GetActiveAcedmicYear();
        if (HouseID > 0)
        {
            querynew1 = " and MH.HouseID=" + HouseID + " Order by StudentName asc";
            //divgrid.Visible = false;
            //IBExcel.Visible = true;
            ViewMode = "ViewMode";
        }
        else
        {
            ViewMode = "";
            querynew1 = " and SR.ApplyingForClass=" + ddlapplyingforclass.SelectedValue + " and SA.SectionId=" + ddlSection.SelectedValue + " Order by StudentName asc";
        }

        string querynew = @"SELECT DISTINCT ISNULL(SA.ClassID,0) Class,ISNULL(SA.SectionId,0) Sec,ISNULL(MH.Housename,'') HouseName,ISNULL(SM.StuRegNo,0) StuRegNo,ISNULL(SA.AdmissionNo,'') AdmissionNo,ISNULL(SR.HouseID,0) HouseID ,
                            CASE WHEN SR.HouseID > 0 THEN 'TRUE' ELSE 'FALSE' END AS Status, ISNULL(SR.StudentFirstName,'')+' '+ISNULL(SR.StudentMiddleName,'')+' '+ISNULL(SR.StudentLastName,'') AS StudentName
                           from tbl_StudentRegistration SR
                            inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.Brid
                            inner join tbl_StudentAdmissionMaster SA on SM.StuRegNo = SA.StuRegNo
                            left outer join mst_House MH on MH.HouseID = SR.HouseID
                            where SR.Brid=" + Session["BrBrid"] + " and SR.fyid = " + ddlFyid.SelectedValue + querynew1;

        ViewState["vie"] = querynew;
        dtStd = objdut.GetDataTable(querynew);
        grdHouse.DataSource = dtStd;
        grdHouse.DataBind();
        if (dtStd.Rows.Count > 0)
        {            
            tblHouseList.Visible = true;
            divall.Visible = true;
            if (HouseID > 0)
            {
                //grdHouse.HeaderRow.Cells[5].Visible = false;
                //grdHouse.HeaderRow.Cells[6].Visible = false;
            }
            else
            {
                //grdHouse.HeaderRow.Cells[5].Visible = true;
                //grdHouse.HeaderRow.Cells[6].Visible = true;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Sorry, No Student Found')", true);
            fillgrid();
        }
    }
    protected void ddlSection_SelectedIndexChanged(object sender, EventArgs e)
    {
        grdHouse.DataSource = null;
        grdHouse.DataBind(); 
        if (ddlSection.SelectedValue == "0")
        {
            DataTable dtStd = new DataTable();
            dtStd = null;
            tblHouseList.Visible = false;
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
    protected void ddlFyid_SelectedIndexChanged(object sender, EventArgs e)
    {
        grdHouse.DataSource = null;
        grdHouse.DataBind();
        BindClass();
    }
    protected void IBExcel_Click(object sender, EventArgs e)
    {
        ExportGridToExcel();
    }
}