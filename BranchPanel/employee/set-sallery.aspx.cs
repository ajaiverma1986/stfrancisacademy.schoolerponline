using System;
using System.Data;
using System.Data.SqlClient;

public partial class BranchPanel_set_sallery : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private double d;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["empid"] == null)
        {
            Response.Redirect("employee-list.aspx");
        }
        if (!IsPostBack)
        {
            ViewState["update"] = null;
            fillfaculty();
            FillGrid();
        }
    }

    private void fillfaculty()
    {
        dt = objdut.GetDataTable("select empname,net_annual_ctc,salary_implementation_fromdate from [tbl_empsallery_master] where status=1 and empid=" + Session["empid"]);
        if (dt.Rows.Count > 0)
        {
            txtemployeename.Text = dt.Rows[0]["empname"].ToString();
            txtsallerytype.Text = dt.Rows[0]["net_annual_ctc"].ToString();
            //txtsallery.Text = string.Format("{0:f}", dt.Rows[0]["amount"]);
            txtdate.Text = string.Format("{0:dd/MM/yyyy}", dt.Rows[0]["salary_implementation_fromdate"]);
        }
        else
        {
            txtemployeename.Text = Convert.ToString(objdut.GetScalar("select (fname+' '+mname+' '+lname) as Name from tblEmp_Master where eid=" + Session["empid"]));
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        int result = 0;
        if (Check())
        {
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@eid", Convert.ToInt32(Session["empid"]));
            param[1] = new SqlParameter("@empname", SqlDbType.VarChar, 200);
            param[1].Value = txtemployeename.Text;
            param[2] = new SqlParameter("@sallery", SqlDbType.Money);
            param[2].Value = Convert.ToDouble(txtsallery.Text);
            param[3] = new SqlParameter("@intresult", SqlDbType.Int);
            param[3].Direction = ParameterDirection.Output;
            param[4] = new SqlParameter("@date", SqlDbType.VarChar, 100);
            param[4].Value = txtdate.Text;
            param[5] = new SqlParameter("@mode", SqlDbType.Int, 4);
            if (btnsubmit.Text == "Update Sallery")
                param[5].Value = 1;
            else
                param[5].Value = 0;
            result = objdut.ExecuteSqlSP(param, "[Usp_Sallery_Set_Update]");
            if (result > 0)
            {
                FillGrid();
            }
        }
    }

    private bool Check()
    {
        if (txtdate.Text == "")
        {
            Utility.ViewAlertMessage(Page, "Please Select The Date Of Sallery Implementation.");
            txtdate.Focus();
            return false;
        }

        if (!double.TryParse(txtsallery.Text, out d))
        {
            Utility.ViewAlertMessage(Page, "please Enter Numeric Value In Salary.");
            txtsallery.Focus();
            return false;
        }
        return true;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        btnsubmit.Visible = false;
        Button1.Visible = false;
        lbtnupdatesallery.Visible = true;
        lbtnforsalleryupdate.Visible = true;
    }

    private void FillGrid()
    {
        SqlParameter[] param = new SqlParameter[1];

        param[0] = new SqlParameter("@empid", Convert.ToInt32(Session["empid"]));

        dt = objdut.GetDataTableSP(param, "[usp_show_monthly]");
        if (dt.Rows.Count > 0)
        {
            grdminthlysalleryreport.DataSource = dt;
            grdminthlysalleryreport.DataBind();
            btnsubmit.Visible = false;
            Button1.Visible = false;
            lbtnforsalleryupdate.Visible = true;
            lbtnupdatesallery.Visible = true;
        }
        else
        {
            grdminthlysalleryreport.EmptyDataText = "No Salary History Found.";
            grdminthlysalleryreport.DataSource = null;
            grdminthlysalleryreport.DataBind();
            lbtnforsalleryupdate.Visible = false;
            lbtnupdatesallery.Visible = false;
        }
    }

    protected void lbtnforsalleryupdate_Click(object sender, EventArgs e)
    {
        txtdate.Text = "";
        btnsubmit.Visible = true;
        Button1.Visible = true;
        lbtnforsalleryupdate.Visible = false;
        btnsubmit.Text = "Revise Sallery";
    }

    protected void updatesallery_Click(object sender, EventArgs e)
    {
        btnsubmit.Visible = true;
        Button1.Visible = true;
        lbtnupdatesallery.Visible = false;
        btnsubmit.Text = "Update Sallery";
    }
}