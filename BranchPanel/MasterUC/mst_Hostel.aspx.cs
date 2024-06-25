using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_MasterUC_mst_Hostel : System.Web.UI.Page
{
    private string url;
    private int query;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private SqlDataReader dr;
    CommonClass objCommon = new CommonClass();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            divall.Visible = false;
            divgrid.Visible = true;
            //fillclass();
            fillHostel();
            if (Request.QueryString.Count > 0)
            {
                string value = Request.QueryString["c1"];
            }
        }
    }

    private void fillHostel()
    {
        int fyid = objCommon.GetActiveAcedmicYear();
        string querynew = @"SELECT HostelID,HostelName,isActive from mst_HostelMst WHERE Brid=" + Session["BrBrid"] + " and fyid = " + fyid + "order by HostelID asc";
        ViewState["vie"] = querynew;
        dt = objdut.GetDataTable(querynew);
        if (dt.Rows.Count > 0)
        {
            griview_Hostel.DataSource = dt;
            griview_Hostel.DataBind();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Please add Hostel Name in the branch.')", true);
            return;
        }
    }   

    protected void btSave_Click(object sender, EventArgs e)
    {
        if (checkvalidation())
        {
            SqlParameter[] param = new SqlParameter[7];
            param[0] = new SqlParameter("@HostelID", dfHouse.Value.ToString());
            param[1] = new SqlParameter("@HostelName", txtHostelName.Text.ToUpper().ToString());
            param[2] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
            if (chkstatus.Checked == true)
            {
                param[3] = new SqlParameter("@status", Convert.ToInt32(1));
            }
            else
            {
                param[3] = new SqlParameter("@status", Convert.ToInt32(0));
            }
            param[4] = new SqlParameter("@intResult", Convert.ToInt32(0));
            param[4].Direction = ParameterDirection.Output;
            param[5] = new SqlParameter("@Fyid", Convert.ToInt32(objCommon.GetActiveAcedmicYear()));
            param[6] = new SqlParameter("@Mode", Convert.ToInt32(1));
            int ret = objdut.ExecuteSqlSP(param, "USP_HostelToStudent");
            if (ret == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Hostel Name Added Succesfully!");
                divall.Visible = false;
                divgrid.Visible = true;
                Table1.Visible = true;
                Feediv1.Visible = false;
                reset();
                fillHostel();
            }
            else if (ret == 2)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Hostel Name Updated!");
                divall.Visible = false;
                divgrid.Visible = true;
                Table1.Visible = false;
                Feediv1.Visible = false;
                reset();
                fillHostel();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "Error....");
                return;
            }
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Error.");
        }
        dfHouse.Value = "0";
    }

    private bool checkvalidation()
    {
        if (txtHostelName.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Hostel Name");
            return false;
        }
        else
            return true;
    }  

    private void reset()
    {
        txtHostelName.Text = "";
        chkstatus.Checked = false;
        txtFeeHead.Text = "";
        txtFeeHeadAmt.Text = "";
        ddlClass.SelectedValue = "0";
        ChkFeeHead.Checked = false;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        reset();
        divall.Visible = false;
        divgrid.Visible = true;       
        Button1.Visible = false;
    }

    protected void griview_Hostel_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        string query = (string)ViewState["vie"];
        griview_Hostel.PageIndex = e.NewPageIndex;
        fillHostel();
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        divall.Visible = false;
        divgrid.Visible = true;
        Table1.Visible = false;
        Feediv1.Visible = false;
    }

    protected void griview_Hostel_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int asd = Convert.ToInt32(e.CommandArgument);
        ViewState["sid"] = asd;
        if (e.CommandName == "Edit1")
        {
            int fyid = objCommon.GetActiveAcedmicYear();
            GridViewRow clickedRow = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            HiddenField hd1 = (HiddenField)clickedRow.Cells[2].FindControl("lblclassid");
            int ide;
            ide = Convert.ToInt32(hd1.Value);
            divgrid.Visible = false;
            divall.Visible = true;
            string str = "SELECT HostelID,HostelName,ISACTIVE from mst_HostelMst WHERE Brid=" + Session["brBrid"] + " and fyid = " + fyid + " and HostelID=" + asd + "";
            DataTable dts = objdut.GetDataTable(str);
            if (dts.Rows.Count > 0)
            {
                txtHostelName.Text = dts.Rows[0]["HostelName"].ToString();
                chkstatus.Checked = Convert.ToBoolean(dts.Rows[0]["ISACTIVE"]);
                btnAdd.Text = "Update";
                dfHouse.Value = asd.ToString();
            }
        }
        if (e.CommandName == "Delete")
        {
            int fyid = objCommon.GetActiveAcedmicYear();
            GridViewRow clickedRow = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            HiddenField hd1 = (HiddenField)clickedRow.Cells[2].FindControl("lblclassid");
            int ide;
            ide = Convert.ToInt32(hd1.Value);
            string str = "delete from mst_HostelMst WHERE Brid=" + Session["brBrid"] + " and fyid = " + fyid + " and HostelID=" + asd + "";
            int InsResult = Convert.ToInt32(objdut.ExecuteSql(str));
            if (InsResult > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Hostel Name delete Successfully.')", true);
                fillHostel();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Error during deleting Hostel Name.')", true);
                fillHostel();
            }
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

    protected void griview_Hostel_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
        }
    }
    protected void btnFeeList_Click(object sender, EventArgs e)
    {        
        divall.Visible = true;
        divgrid.Visible = false;
        Table1.Visible = false;
        Feediv1.Visible = false;
        reset();
    }
    public void BindClass() 
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@brid", Session["BrBrid"]);
        DataTable dt = objdut.GetDataTableSP(param, "Usp_Class");
        if (dt.Rows.Count > 0)
        {
            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "Classname";
            ddlClass.DataValueField = "classid";
            ddlClass.DataBind();
            ddlClass.Items.Insert(0, new ListItem("--Select Class--", "0"));
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Please add Class Fee Name in the branch.')", true);
            return;
        }
    }
    private void fillHostelFeeHead()
    {
        int fyid = objCommon.GetActiveAcedmicYear();
        string querynew = @"Select CM.ClassID,DTL.HostelFeeID,CM.ClassName,CASE WHEN DTL.IsActive=1 THEN 'True' ELSE 'False' END AS Status,
                            DTL.HostelFeeAmt,DTL.HostelFeeName from ClassBranch_master CM
                            inner join mst_HostelFee1 DTL on CM.Classid = DTL.ClassID and CM.BranchId = DTL.Brid
                            WHERE DTL.Brid=" + Session["BrBrid"] + " and DTL.fyid = " + fyid + "order by HostelFeeID asc";
        ViewState["vieFee"] = querynew;
        dt = objdut.GetDataTable(querynew);
        if (dt.Rows.Count > 0)
        {
            GrtFeeHead.DataSource = dt;
            GrtFeeHead.DataBind();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Please add Hostel Fee Name in the branch.')", true);
            return;
        }
    }
    protected void btnFeeHead_Click(object sender, EventArgs e)
    {
        if (checkFeeHeadvalidation())
        {
            SqlParameter[] param = new SqlParameter[9];
            param[0] = new SqlParameter("@HostelFeeID", HdFeeHead.Value.ToString());
            param[1] = new SqlParameter("@HostelFeeName", txtFeeHead.Text.ToUpper().ToString());
            param[2] = new SqlParameter("@HostelFeeAmt", Convert.ToDecimal(txtFeeHeadAmt.Text));
            param[3] = new SqlParameter("@BRID", Convert.ToInt32(Session["BrBrid"]));
            if (ChkFeeHead.Checked == true)
            {
                param[4] = new SqlParameter("@status", Convert.ToInt32(1));
            }
            else
            {
                param[4] = new SqlParameter("@status", Convert.ToInt32(0));
            }
            param[5] = new SqlParameter("@intResult", Convert.ToInt32(0));
            param[5].Direction = ParameterDirection.Output;
            param[6] = new SqlParameter("@Fyid", Convert.ToInt32(objCommon.GetActiveAcedmicYear()));
            param[7] = new SqlParameter("@Mode", Convert.ToInt32(2));
            param[8] = new SqlParameter("@ClassID", ddlClass.SelectedValue.ToString());
            int ret = objdut.ExecuteSqlSP(param, "USP_HostelToStudent");
            if (ret == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Hostel FeeHead Name Added Succesfully!");
              
                reset();
                fillHostelFeeHead();
                divall.Visible = false;
                divgrid.Visible = false;
                Table1.Visible = true;
                Feediv1.Visible = false;
            }
            else if (ret == 2)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Hostel FeeHead Name Updated!");
                divall.Visible = false;
                divgrid.Visible = false;
                Table1.Visible = true;
                Feediv1.Visible = false;

                reset();
                fillHostelFeeHead();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "Error....");
                return;
            }
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Error.");
        }
        HdFeeHead.Value = "0";
    }
    private bool checkFeeHeadvalidation()
    {
        if (ddlClass.SelectedValue=="0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Class Name");
            return false;
        }
        if (txtFeeHead.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Hostel FeeHead Name");
            return false;
        }
        if (txtFeeHeadAmt.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Hostel FeeHead Amount.");
            return false;
        }
        else
            return true;
    }
    protected void btnHostelName_Click1(object sender, EventArgs e)
    {
        BindClass();
        divall.Visible = false;
        divgrid.Visible = false;
        Table1.Visible = false;
        Feediv1.Visible = true;
        reset();
    }
    protected void btnHostelFeeHead_Click(object sender, EventArgs e)
    {
        fillHostelFeeHead();
        divall.Visible = false;
        divgrid.Visible = false;
        Table1.Visible = true;
        Feediv1.Visible = false;
    }
    protected void GrtFeeHead_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        string query = (string)ViewState["vieFee"];
        GrtFeeHead.PageIndex = e.NewPageIndex;
        fillHostelFeeHead();
    }
    protected void GrtFeeHead_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int asd = Convert.ToInt32(e.CommandArgument);
        ViewState["sid"] = asd;
        if (e.CommandName == "Edit1")
        {
            int fyid = objCommon.GetActiveAcedmicYear();
            GridViewRow clickedRow = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            HiddenField hd1 = (HiddenField)clickedRow.Cells[2].FindControl("lblclassid");
            string querynew = @"Select CM.ClassID,DTL.HostelFeeID,CM.ClassName,CASE WHEN DTL.IsActive=1 THEN 'True' ELSE 'False' END AS Status,
                            DTL.HostelFeeAmt,DTL.HostelFeeName from ClassBranch_master CM
                            inner join mst_HostelFee1 DTL on CM.Classid = DTL.ClassID and CM.BranchId = DTL.Brid
                            WHERE DTL.Brid=" + Session["BrBrid"] + " and DTL.fyid = " + fyid + " and HostelFeeID=" + asd + "";
            DataTable dts = objdut.GetDataTable(querynew);
            if (dts.Rows.Count > 0)
            {
                BindClass();
                ddlClass.SelectedValue = dts.Rows[0]["ClassID"].ToString();
                txtFeeHead.Text = dts.Rows[0]["HostelFeeName"].ToString();
                txtFeeHeadAmt.Text = dts.Rows[0]["HostelFeeAmt"].ToString();
                ChkFeeHead.Checked = Convert.ToBoolean(dts.Rows[0]["Status"]);
                btnFeeHead.Text = "Update";
                HdFeeHead.Value = asd.ToString();

                divall.Visible = false;
                divgrid.Visible = false;
                Table1.Visible = false;
                Feediv1.Visible = true;
            }
            else
            {
                divall.Visible = false;
                divgrid.Visible = false;
                Table1.Visible = true;
                Feediv1.Visible = false;
            }
        }
        if (e.CommandName == "Delete")
        {
            int fyid = objCommon.GetActiveAcedmicYear();
            GridViewRow clickedRow = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            HiddenField hd1 = (HiddenField)clickedRow.Cells[2].FindControl("lblclassid");
            string strCount = @"Select * from tbl_PayHostelFee1
                                WHERE Brid=" + Session["BrBrid"] + " and fyid = " + fyid + " and FeeID=" + asd + "";
            int intResult = Convert.ToInt32(objdut.GetScalar(strCount));
            if (intResult == 0)
            {
                string querynew = @"delete from mst_HostelFee1 WHERE Brid=" + Session["BrBrid"] + " and fyid = " + fyid + " and HostelFeeID=" + asd + "";
                int intquerynew = Convert.ToInt32(objdut.ExecuteSql(querynew));
                if (intquerynew > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Fee Name delete Successfully.')", true);
                    fillHostelFeeHead();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Error during deleting Fee Name.')", true);
                    fillHostelFeeHead();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('This Fee is asigned to Student Hostel. Can not Delete.')", true);
                fillHostelFeeHead();
            }
        }
    }
    protected void GrtFeeHead_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void griview_Hostel_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void GrtFeeHead_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
}