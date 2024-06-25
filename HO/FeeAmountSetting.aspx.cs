using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
public partial class HO_FeeAmountSetting : System.Web.UI.Page
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
        divMain.Visible = false;
        divButton.Visible = false;
        if (!IsPostBack)
        {
            fillBranch();
        }
    }
    public void fillBranch()
    {
        DDlBranch.DataSource = CommonClass.Dll("BranchDll");
        DDlBranch.DataTextField = "BrName";
        DDlBranch.DataValueField = "BrId";
        DDlBranch.DataBind();
        ListItem li = new ListItem("--Select Branch--", "0");
        DDlBranch.Items.Insert(0, li);
        ddlfinancialyear.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    protected void ddlfinancialyear_SelectedIndexChanged(object sender, EventArgs e)
    {
        int BranchID = Convert.ToInt16(DDlBranch.SelectedValue);
        int fyid = Convert.ToInt16(ddlfinancialyear.SelectedValue);
        ViewState["brid"] = BranchID;
       string query = "select classid,Class_Master.Classname from ClassBranch_master inner join Class_Master on Class_Master.id = ClassBranch_master.classid " +
                " where BranchId=" + BranchID + " and ClassBranch_master.Status=1 and ClassBranch_master.fyid=" + fyid + "";
            DataTable dt = objDUT.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "Classname";
            ddlClass.DataValueField = "classid";
            ddlClass.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlClass.Items.Insert(0, li);
        }
        else
        {
            dt.Dispose();
            dt.Clear();
            ddlClass.DataSource = dt;
            ddlClass.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlClass.Items.Insert(0, li);
            if (DDlBranch.SelectedValue == "0" || ddlfinancialyear.SelectedValue == "0")
                lblmsg1.Text = "";
            else
            lblmsg1.Text = "There is no class found according to selected session.";
        }
    }
    protected void DDlBranch_SelectedIndexChanged(object sender, EventArgs e)
    {
        int BranchID = Convert.ToInt16(DDlBranch.SelectedValue);
        int fyid = Convert.ToInt16(ddlfinancialyear.SelectedValue);
        ViewState["brid"] = BranchID;
        string query = "select classid,Classname from ClassBranch_master where BranchId=" + BranchID + " and Status=1 and classid in (select id from Class_Master where Status=1 and fyid=" + fyid + ")";
        DataTable dt = objDUT.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "Classname";
            ddlClass.DataValueField = "classid";
            ddlClass.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlClass.Items.Insert(0, li);
        }
        else
        {
            dt.Dispose();
            dt.Clear();
            ddlClass.DataSource = dt;
            ddlClass.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlClass.Items.Insert(0, li);
            if (DDlBranch.SelectedValue == "0" || ddlfinancialyear.SelectedValue=="0")
            lblmsg1.Text = "";
            else
            lblmsg1.Text = "There is no class found according to selected session and branch.";
            divMain.Visible = false;
            ImageButton1.Visible = false;
            ImageButton2.Visible = false;
        }
    }
    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dt;
        if (ddlClass.SelectedValue != "0")
        {
            lblmsg1.Visible = false;
            int claID = Convert.ToInt32(ddlClass.SelectedItem.Value);
            int brid = Convert.ToInt32(ViewState["brid"]);
            string query = @"select f1.feename,f2.Feename as Maintype,Cfid,Classname,cm.Fees from classfee_master cm inner join feestructure f1  inner join feestructure f2 on f1.Feesubtype=f2.id on  cm.Feeid=f1.Id  where Brid=" + brid + " and Classid=" + claID + " and Cm.status=1 and Feeid not in(select id from feestructure where Feesubtype=0) and Cm.fyid=" + ddlfinancialyear.SelectedValue;
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
        }
    }
    protected void ImageButton1_Click(object sender, EventArgs e)
    {
        if (ddlfinancialyear.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(Page, "Select Session Please.");
            ddlfinancialyear.Focus();
            return;
        }
        if (DDlBranch.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(Page, "Select Branch Please.");
            DDlBranch.Focus();
            return;
        }
        if (ddlClass.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(Page, "Select Class Please.");
            ddlClass.Focus();
            return;
        }
        string fees = "";
        string CFid = "";
        foreach (GridViewRow gvrow in grdDetails.Rows)
        {
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
            Utility.ViewAlertMessage(Page, "Fee successfully added in the selected class of branch " + DDlBranch.SelectedItem.Text + ".");
            ddlClass.SelectedValue = "0";
            DDlBranch.SelectedValue = "0";
        }
    }
    protected void ImageButton2_Click(object sender, EventArgs e)
    {
        ddlClass.SelectedValue = "0";
        DDlBranch.SelectedValue = "0";
    }
}