using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_employee_SetPayrollMst : System.Web.UI.Page
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
        fyid = objCommon.GetActiveAcedmicYear();
        if (!IsPostBack)
        {
            FillPayrollMst();
            string sMonth = DateTime.Now.ToString("MM");            
            GetMond();
            ddlMonth.SelectedValue = (Convert.ToInt32(sMonth)).ToString();
        }
    }
    public void GetMond()
    {    
        DataTable dtMon = new DataTable();
        int fyid = objCommon.GetActiveAcedmicYear();
        string querynew = @"SELECT MonthID, MonthName from Month_name";
        dtMon = objdut.GetDataTable(querynew);
        if (dtMon.Rows.Count > 0)
        {
            ddlMonth.DataSource = dtMon;
            ddlMonth.DataValueField = "MonthID";
            ddlMonth.DataTextField = "MonthName";
            ddlMonth.DataBind();
            ddlMonth.Items.Insert(0, new ListItem("--Select Month Name--", "0"));
        }
    }
    public void FillPayrollMst()
    {
        DataTable dtStd = new DataTable();
        int fyid = objCommon.GetActiveAcedmicYear();

        string querynew = @"SELECT * from mst_PayRoll where Brid=" + Session["BrBrid"] + " and fyid = " + fyid + "";

        ViewState["vie"] = querynew;
        dtStd = objdut.GetDataTable(querynew);
        if (dtStd.Rows.Count > 0)
        {
            grdHouse.DataSource = dtStd;
            grdHouse.DataBind();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Sorry, No Student Found')", true);            
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        string Error = "";
        if (checkvalidation())
        {
            foreach (GridViewRow row in grdHouse.Rows)
            {
                Label lblPayMstID = (row.Cells[0].FindControl("lblPayMstID") as Label);
                CheckBox cType = (row.Cells[0].FindControl("cType") as CheckBox);
                TextBox txtValue = (row.Cells[0].FindControl("txtValue") as TextBox);

                SqlParameter[] param = new SqlParameter[7];
                param[0] = new SqlParameter("@mode", Convert.ToInt32(0));
                param[1] = new SqlParameter("@PayMstID", Convert.ToInt32(lblPayMstID.Text));
                param[2] = new SqlParameter("@MonthID", ddlMonth.SelectedValue);
                if (cType.Checked == true)
                {
                    param[3] = new SqlParameter("@IsPercent", Convert.ToInt32(1));
                }
                else
                {
                    param[3] = new SqlParameter("@IsPercent", Convert.ToInt32(0));
                }
                param[4] = new SqlParameter("@Value", Convert.ToDecimal(txtValue.Text));
                param[5] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
                param[6] = new SqlParameter("@intResult", Convert.ToInt32(0));
                param[6].Direction = ParameterDirection.Output;
                int ret = objdut.ExecuteSqlSP(param, "usp_addSetPayrollName");
                if (ret == 1 || ret == 2)
                {
                    Error = "Value Update SuccessFully";
                }
            }
            Utility.ViewAlertMessage(this.Master.Page, Error.ToString());            
        }
        else
        {
            Error = Error + "Value Not Updated";
            Utility.ViewAlertMessage(this.Master.Page, Error);
        }
        FillPayrollMst();
    }
    private bool checkvalidation()
    {
        int counter = 0;
        int Value = 0;
        foreach (GridViewRow row in grdHouse.Rows)
        {
            Label lblPayMstID = (row.Cells[0].FindControl("lblPayMstID") as Label);
            CheckBox cType = (row.Cells[0].FindControl("cType") as CheckBox);
            TextBox txtValue = (row.Cells[0].FindControl("txtValue") as TextBox);

            if (cType.Checked == true)
            {
                if (Convert.ToDecimal(txtValue.Text) > Convert.ToDecimal(100))
                {
                    counter = counter + 1;
                }
            }
            if (txtValue.Text != "0.00")
            {
                Value = Value + 1;
            }
        }

        if (counter > 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Give Percent less 100");
            return false;
        }
        if (Value == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Give Value in Atleast One");
            return false;
        }
        else
            return true;
    }
    protected void grdHouse_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Edit1")
        {
            int index = Convert.ToInt32(e.CommandArgument.ToString());
            TextBox txtValue = (TextBox)grdHouse.Rows[index].FindControl("txtValue");
            txtValue.Enabled = true;
        }
    }
    protected void grdHouse_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtValue = (TextBox)e.Row.FindControl("txtValue");
            HiddenField hdfhouseID = (HiddenField)e.Row.FindControl("hdfhouseID");
            Label lblType = (Label)e.Row.FindControl("lblType");
            Label lblPayMstID = (Label)e.Row.FindControl("lblPayMstID");

            DropDownList ddlType = (DropDownList)e.Row.FindControl("ddlType");
            CommonClass CommonClass = new CommonClass();
            CheckBox cType = (CheckBox)e.Row.FindControl("cType");

            if (lblType.Text == "")
            {
                lblType.Text = "0";
            }
            ddlType.SelectedValue = lblType.Text.ToString();

           

            string querynew = @"Select ISNULL(PMS.ISPercent,0) ISPercent,
                    ISNULL(PMS.Value,0) Value from tbl_SetPayroll PMS
                    where PMS.PayMstID=" + lblPayMstID.Text + " and PMS.Brid=" + Session["BrBrid"] + " and PMS.fyid = " + fyid + "";
             if (lblType.Text == "1")
            {
                querynew = querynew + "and  PMS.MonthID = " + ddlMonth.SelectedValue + "";
            }            
            
            DataTable dtStd = objdut.GetDataTable(querynew);
            if (dtStd.Rows.Count > 0)
            {
                if (dtStd.Rows[0]["ISPercent"].ToString() == "1")
                {
                    cType.Checked = true;
                }
                else
                {
                    cType.Checked = false;
                }
                txtValue.Text = dtStd.Rows[0]["Value"].ToString();
            }
            else
            {
                cType.Checked = false;
                txtValue.Text = "0";
            }
        }
    }
    protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillPayrollMst();
    }
}