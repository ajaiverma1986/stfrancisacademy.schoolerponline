//updated by abhishek(08/11/2013)

using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class HO_feetype : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private Utility objut = new Utility();
    private SqlParameter[] param = new SqlParameter[2];
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["User"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        PageName = Utility.GetCurrentPagename();

        if (!objut.isAccessible(((User)Session["User"]).UserID, PageName))
        {
            Response.Redirect("~/Login.aspx");
        }
        txtfeetype.Focus();

        if (!IsPostBack)
        {
            btnUpdate.Visible = false;
            fillGrid();
        }
    }

    protected void fillGrid()
    {
        string str = "select id,feename,status=case when (status=1) then 'Active' else 'Deactive' end from feestructure where feesubtype=0";
        DataTable dt = objdut.GetDataTable(str);
        grdFeeStruct.DataSource = dt;
        grdFeeStruct.DataBind();
    }

    protected void btnfeetype_Click(object sender, EventArgs e)
    {
        if (txtfeetype.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Fees Type.");
            //lblmsg.Text = "Please Enter Fees Type.";
            txtfeetype.Focus();
            return;
        }
        int coun = Convert.ToInt32(objdut.GetScalar("select count(*) from feestructure where feename='" + txtfeetype.Text + "'"));
        if (coun == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "This feetype is already exist.");
            //lblMsg1.Text = "This FeeType Is Already Exist";
        }
        else
        {
            string Query = "insert into feestructure (Feename,status) values(@feename,@status)";

            param[0] = new SqlParameter("@feename", txtfeetype.Text.Trim());
            if (chkfetype.Checked)
            {
                param[1] = new SqlParameter("@status", 1);
            }
            else
            {
                param[1] = new SqlParameter("@status", Convert.ToInt32(0));
            }

            int result = objdut.ExecuteSql(param, Query);

            if (result > 0)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Fees type added successfully.");
                //lblMsg1.Text = "Fees Type Submit Successfully.";
                txtfeetype.Text = "";
                chkfetype.Checked = false;
                fillGrid();
            }
        }
    }

    protected void grdFeeStruct_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "edit13")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            string str = "select id,feename,status from feestructure where id=" + id;
            DataTable table = objdut.GetDataTable(str);
            if (table.Rows.Count > 0)
            {
                txtfeetype.Text = table.Rows[0]["feename"].ToString();
                if (table.Rows[0]["status"].ToString() == "True")
                {
                    chkfetype.Checked = true;
                }
                else
                {
                    chkfetype.Checked = false;
                }
                ViewState["id"] = table.Rows[0]["id"].ToString();
            }
            btnUpdate.Visible = true;
            btnfeetype.Visible = false;
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        btnfeetype.Visible = false;
        lblMsg1.Text = "";
        if (txtfeetype.Text != "")
        {
            int i = Convert.ToInt32(objdut.GetScalar("select count(*) from feestructure where feename='" + txtfeetype.Text.Trim() + "'"));

            if (i >= 0)
            {
                string query = "update feestructure set feename=@feename,status=@status where id=" + Convert.ToInt32(ViewState["id"].ToString());
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@feename", SqlDbType.VarChar, 50);
                param[0].Value = txtfeetype.Text;
                param[1] = new SqlParameter("@status", SqlDbType.Bit);
                if (chkfetype.Checked)
                {
                    param[1] = new SqlParameter("@status", 1);
                }
                else
                {
                    param[1] = new SqlParameter("@status", Convert.ToInt32(0));
                    //chkcountrye.Checked = false;
                }

                int result1 = objdut.ExecuteSql(param, query);
                if (result1 > 0)
                {
                    Utility.ViewAlertMessage(Page, "Fees type updated successfully.");
                    //lblMsg1.Text = "Updated Successfully";
                    txtfeetype.Text = "";
                    chkfetype.Checked = false;
                    btnUpdate.Visible = false;
                    btnfeetype.Visible = true;
                    fillGrid();
                }
                else
                {
                    Utility.ViewAlertMessage(Page, "Fees type not updated successfully.");
                }
            }
        }
    }
}