using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_MasterUC_mst_PayRoll : System.Web.UI.Page
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
        string querynew = @"Select ID,Name,isActive,ISNULL(Type,0) Type from mst_PayRoll where Brid=" + Session["BrBrid"] + " and fyid = " + fyid + "order by ID asc";
        ViewState["vie"] = querynew;
        dt = objdut.GetDataTable(querynew);
        if (dt.Rows.Count > 0)
        {
            griview_LateFee.DataSource = dt;
            griview_LateFee.DataBind();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Please add Field Name in the branch.')", true);
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
                SqlParameter[] param = new SqlParameter[6];
                param[0] = new SqlParameter("@mode", "Add");
                param[1] = new SqlParameter("@Name", txtName.Text.ToUpper().ToString());
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
                param[5] = new SqlParameter("@Type", ddlType.SelectedValue);
                int ret = objdut.ExecuteSqlSP(param, "usp_addPayrollName");
                if (ret == 1)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Field Name Name Added Succesfully!");
                    divall.Visible = false;
                    divgrid.Visible = true;
                    Button2.Visible = true;
                    reset();
                    fillgrid();
                }
                else if (ret == 2)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Field Name Name Already Exist!");
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Error....");
                    return;
                }
            }
            else if (btnAdd.Text == "Update")
            {
                SqlParameter[] param = new SqlParameter[7];
                param[0] = new SqlParameter("@mode", "update");
                param[1] = new SqlParameter("@Name", txtName.Text.ToUpper().ToString());
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
                if (ViewState["sid"] == null)
                {
                    param[5] = new SqlParameter("@ID", 0);
                }
                else
                {
                    param[5] = new SqlParameter("@ID", Convert.ToInt32(ViewState["sid"]));
                }
                param[6] = new SqlParameter("@Type", ddlType.SelectedValue);
                int ret = objdut.ExecuteSqlSP(param, "usp_addPayrollName");
                if (ret == 1)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Field Name Name updated Succesfully!");
                    divgrid.Visible = true;
                    divall.Visible = false;
                    Button2.Visible = true;
                    btnAdd.Text = "Submit";
                    reset();
                    fillgrid();
                }
                else if (ret == 2)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Field Name Name Already Exist in This class!");
                }
                else if (ret == 3)
                {
                    Utility.ViewAlertMessage(this.Master.Page, " This Field Name Name Can Not Be Updated!");
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
        if (txtName.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Field Name Name");
            return false;
        }
        else
            return true;
    }

    private void reset()
    {
        txtName.Text = "";
        chkstatus.Checked = false;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        reset();
        divall.Visible = false;
        divgrid.Visible = true;
        Button2.Visible = true;
        Button1.Visible = false;
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
            string str = "Select ID,Name,isActive,ISNULL(Type,0) Type from mst_PayRoll where Brid=" + Session["brBrid"] + "and ID=" + asd;
            DataTable dts = objdut.GetDataTable(str);
            if (dts.Rows.Count > 0)
            {
                txtName.Text = dts.Rows[0]["Name"].ToString();
                chkstatus.Checked = Convert.ToBoolean(dts.Rows[0]["isActive"]);
                btnAdd.Text = "Update";
                ddlType.SelectedValue = dts.Rows[0]["Type"].ToString();
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

    protected void griview_LateFee_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblType = (Label)e.Row.FindControl("lblType");
            DropDownList ddlType = (DropDownList)e.Row.FindControl("ddlType");
            if (lblType.Text == "")
            {
                lblType.Text = "0";
            }
            ddlType.SelectedValue = lblType.Text;
        }
    }
}