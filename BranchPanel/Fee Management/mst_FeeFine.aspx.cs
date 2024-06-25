using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Fee_Management_mst_FeeFine : System.Web.UI.Page
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
            fillgrid();
            if (Request.QueryString.Count > 0)
            {
                string value = Request.QueryString["c1"];
            }
        }
    }

    private void fillgrid()
    {
        int fyid = objCommon.GetActiveAcedmicYear();
        string querynew = @"Select FeeID,FeeName,FeeAmt,isActive,Brid,Fyid,FeeAfterDays,CASE WHEN FeeType=1 THEN 'DayWise' ELSE 'Fixed' END FeeType ,CASE WHEN FeeAssignTo=1 THEN 'Monthly' ELSE 'Hostel' END FeeAssignTo from mst_Feefine where Brid=" + Session["BrBrid"] + " and fyid = " + fyid + "order by FeeID asc";
        ViewState["vie"] = querynew;
        dt = objdut.GetDataTable(querynew);
        if (dt.Rows.Count > 0)
        {
            griview_LateFee.DataSource = dt;
            griview_LateFee.DataBind();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Please add Fee Fine in the branch.')", true);
            return;
        }
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
        if (checkvalidation())
        {
            if (btnAdd.Text != "Update")
            {
                SqlParameter[] param = new SqlParameter[9];
                param[0] = new SqlParameter("@mode", "AddFine");
                param[1] = new SqlParameter("@FeeName", txtFeeName.Text.ToUpper().ToString());
                param[2] = new SqlParameter("@FeeAmt", Convert.ToDecimal(txtFeeAmt.Text));
                param[3] = new SqlParameter("@FeeAfterDays", Convert.ToInt32(txtNoDays.Text));
                param[4] = new SqlParameter("@FeeType", Convert.ToInt32(ddlFeeType.SelectedValue));
                param[5] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
                if (chkstatus.Checked == true)
                {
                    param[6] = new SqlParameter("@status", 1);
                }
                else
                {
                    param[6] = new SqlParameter("@status", 0);
                }
                param[7] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                param[7].Direction = ParameterDirection.Output;
                param[8] = new SqlParameter("@FeeAssignTo", Convert.ToInt32(ddlFeeToType.SelectedValue));

                int ret = objdut.ExecuteSqlSP(param, "usp_addLateFee");
                if (ret == 1)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Fee Fine Added Succesfully!");
                    divall.Visible = false;
                    divgrid.Visible = true  ;
                    Button2.Visible = true;
                    reset();
                    fillgrid();
                }
                else if (ret == 2)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Fee Fine Already Exist!");
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Error....");
                    return;
                }
            }
            else if (btnAdd.Text == "Update")
            {
                SqlParameter[] param = new SqlParameter[10];
                param[0] = new SqlParameter("@mode", "updateFine");
                param[1] = new SqlParameter("@FeeName", txtFeeName.Text.ToUpper().ToString());
                param[2] = new SqlParameter("@FeeAmt", Convert.ToDecimal(txtFeeAmt.Text));
                param[3] = new SqlParameter("@FeeAfterDays", Convert.ToInt32(txtNoDays.Text));
                param[4] = new SqlParameter("@FeeType", Convert.ToInt32(ddlFeeType.SelectedValue));
                param[5] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
                if (chkstatus.Checked == true)
                {
                    param[6] = new SqlParameter("@status", 1);
                }
                else
                {
                    param[6] = new SqlParameter("@status", 0);
                }
                param[7] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                param[7].Direction = ParameterDirection.Output;
                if (ViewState["sid"] == null)
                {
                    param[8] = new SqlParameter("@FeeID", 0);
                }
                else
                {
                    param[8] = new SqlParameter("@FeeID", Convert.ToInt32(ViewState["sid"]));
                }
                param[9] = new SqlParameter("@FeeAssignTo", Convert.ToInt32(ddlFeeToType.SelectedValue));
                int ret = objdut.ExecuteSqlSP(param, "usp_addLateFee");
                if (ret == 1)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Fee Fine updated Succesfully!");
                    divgrid.Visible = true;
                    divall.Visible = false;
                    Button2.Visible = true;
                    btnAdd.Text = "Submit";
                    reset();
                    fillgrid();
                }
                else if (ret == 2)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Fee Fine Already Exist in This class!");
                }
                else if (ret == 3)
                {
                    Utility.ViewAlertMessage(this.Master.Page, " This Fee Fine Can Not Be Updated!");
                    divgrid.Visible = true;
                    divall.Visible = false;
                    Button2.Visible = true;
                    reset();
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Error.");
                    return;
                }
            }
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Error.");
        }
    }

    private bool checkvalidation()
    {
        if (txtFeeName.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Plz Select Fee Name.");
            return false;
        }
        else if (ddlFeeType.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Plz Enter Fee Type.");
            return false;
        }
        else if (txtFeeAmt.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Plz Enter Fee Amount.");
            return false;
        }
        else if (txtNoDays.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Plz Enter No. of Days Fine Will Charge.");
            return false;
        }
        else
            return true;
    }

    private void reset()
    {
        txtFeeName.Text = "Late Fee";
        ddlFeeType.SelectedIndex = 0;
        txtFeeAmt.Text = "";
        txtNoDays.Text = "";        
        chkstatus.Checked = false;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        reset();
        divall.Visible = false;
        divgrid.Visible = true;
        Button2.Visible = true;
        //Button1.Visible = false;
    }

    protected void griview_LateFee_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        string query = (string)ViewState["vie"];
        griview_LateFee.PageIndex = e.NewPageIndex;
        fillgrid();
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        //ddl_class.Items.Clear();
        //fillclass();
        reset();
        divall.Visible = true;
        divgrid.Visible = false;
        Button2.Visible = true;
    }

    protected void griview_LateFee_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int asd = Convert.ToInt32(e.CommandArgument);
        ViewState["sid"] = asd;
        if (e.CommandName == "Edit1")
        {
            GridViewRow clickedRow = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            HiddenField hd1 = (HiddenField)clickedRow.Cells[2].FindControl("lblclassid");
            int ide;
            ide = Convert.ToInt32(hd1.Value);
            divgrid.Visible = false;
            divall.Visible = true;
            Button2.Visible = false;
            string str = "select FeeID,FeeName,FeeAssignTo,isActive,FeeType,FeeAmt,FeeAfterDays from mst_FeeFine where Brid=" + Session["brBrid"] + "and FeeID=" + asd;
            DataTable dts = objdut.GetDataTable(str);
            if (dts.Rows.Count > 0)
            {
                txtFeeName.Text = dts.Rows[0]["FeeName"].ToString();
                txtFeeAmt.Text = dts.Rows[0]["FeeAmt"].ToString();
                txtNoDays.Text = dts.Rows[0]["FeeAfterDays"].ToString();
                ddlFeeType.SelectedValue = dts.Rows[0]["FeeType"].ToString();
                ddlFeeToType.SelectedValue = dts.Rows[0]["FeeAssignTo"].ToString();
                chkstatus.Checked = Convert.ToBoolean(dts.Rows[0]["isActive"]);
                btnAdd.Text = "Update";
            }
        }
        if (e.CommandName == "delete")
        {
            GridViewRow clickedRow = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            HiddenField hd1 = (HiddenField)clickedRow.Cells[2].FindControl("lblclassid");
            int ide;
            ide = Convert.ToInt32(hd1.Value);
            string Str="delete from mst_FeeFine where Brid=" + Session["brBrid"] + "and FeeID=" + asd;
            int intResult = Convert.ToInt32(objdut.ExecuteSql(Str));
            if (intResult > 0)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Fee Fine delete Successfully.");
            }
            fillgrid();
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

    protected void griview_LateFee_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
        }
    }
    protected void griview_LateFee_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
}