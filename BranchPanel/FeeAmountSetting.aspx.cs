using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_FeeAmountSetting : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private Utility objut = new Utility();
    private DataUtility objDUT = new DataUtility();
    private CommonClass CommonClass = new CommonClass();
    private SqlParameter[] param = new SqlParameter[3];
    private string feeid = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        divMain.Visible = false;
        divButton.Visible = false;
        if (!IsPostBack)
        {
            l1.Visible = false;
            // btn3.Enabled = false;
            fillClass();
        }
    }

    protected void DDlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dt;
        if (ddlClass.SelectedValue != "0")
        {
            lblmsg1.Visible = false;
            int claID = Convert.ToInt32(ddlClass.SelectedItem.Value);
            int brid = Convert.ToInt32(Session["BrBrid"]);
            string query = @"select * from classfee_master where Brid=" + brid + " and Classid=" + claID + " and status=1 and Feeid not in(select id from feestructure where Feesubtype=0)";
            dt = objDUT.GetDataTable(query);
            if (dt.Rows.Count > 0)
            {
                grdDetails.DataSource = objDUT.GetDataTable(query);
                grdDetails.DataBind();
                divMain.Visible = true;
                divButton.Visible = true;
                ImageButton1.Visible = true;
                ImageButton2.Visible = true;
            }
            else
            {
                grdDetails.DataSource = null;
                grdDetails.DataBind();
                divMain.Visible = false;
                divButton.Visible = true;
                lblmsg.Text = "Please select fee type for selected class in feesetting menu in master settings";
                ImageButton1.Visible = false;
                ImageButton2.Visible = false;
                return;
            }
            //grdDetails.Visible = true;
        }
    }

    protected void ImageButton1_Click(object sender, EventArgs e)
    {
        //if (DDlBranch.SelectedIndex == 0)
        //{
        //    Utility.ViewAlertMessage(Page, "Please select branch first.");
        //    DDlBranch.Focus();
        //    return;
        //}
        if (ddlClass.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(Page, "Please select class first.");
            ddlClass.Focus();
            return;
        }
        string fees = "";
        string CFid = "";
        foreach (GridViewRow gvrow in grdDetails.Rows)
        {
            //Finiding checkbox control in gridview for particular row
            TextBox txtfee = (TextBox)gvrow.FindControl("txtfees");
            HiddenField hd1 = (HiddenField)gvrow.FindControl("HD1");

            fees = fees + "," + txtfee.Text;
            CFid = CFid + "," + hd1.Value;
        }

        fees = fees.Remove(0, 1);
        CFid = CFid.Remove(0, 1);

        param[0] = new SqlParameter("@fees", fees);
        param[1] = new SqlParameter("@cfid", CFid);

        param[2] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[2].Direction = ParameterDirection.Output;

        int intresult = objDUT.ExecuteSqlSP(param, "usp_ADDFEEinClassBranchWise");

        if (intresult > 0)
        {
            Utility.ViewAlertMessage(Page, "Fee successfully added in the selected class of branch " + Session["Brusername"].ToString() + ".");
            ddlClass.SelectedValue = "0";
            //DDlBranch.SelectedValue = "0";
        }
    }

    protected void ImageButton2_Click(object sender, EventArgs e)
    {
        ddlClass.SelectedValue = "0";
        //DDlBranch.SelectedValue = "0";
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        Response.Redirect("feesSetting.aspx");
    }

    protected void fillClass()
    {
        //int BranchID = Convert.ToInt16(DDlBranch.SelectedValue);
        //ViewState["brid"] = BranchID;
        string query = "select classid,Classname from ClassBranch_master where BranchId=" + Convert.ToDouble(Session["BrBrid"]) + " and Status=1 and classid in (select id from Class_Master where Status=1)";
        DataTable dt = objDUT.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "Classname";
            ddlClass.DataValueField = "classid";
            ddlClass.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlClass.Items.Insert(0, li);
            //tr1.Visible = true;
            // btnSubmit.Visible = true;
        }
        else
        {
            dt.Dispose();
            dt.Clear();
            ddlClass.DataSource = dt;
            ddlClass.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlClass.Items.Insert(0, li);
            lblmsg1.Text = "this branch has no class.";
            divMain.Visible = false;
            ImageButton1.Visible = false;
            ImageButton2.Visible = false;
        }
    }
}