using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_DepartMent : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private Utility objut = new Utility();
    private SqlParameter[] param = new SqlParameter[3];
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        //PageName = Utility.GetCurrentPagename();

        if (!objut.isAccessible(((User)Session["BrUser"]).UserID, "DepartMent.aspx"))
        {
            //Response.Redirect("~/Login.aspx");
        }

        if (!IsPostBack)
        {
            divall.Visible = false;
            divgrid.Visible = true;

            btnupdate.Visible = false;
            FillGridStateDetail();
        }
    }

    protected void btncountry_Click(object sender, EventArgs e)
    {
        if (txtcountry.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Department Name.");

            txtcountry.Focus();
            return;
        }
        param[0] = new SqlParameter("@countryName", txtcountry.Text.Trim());
        if (chkcountrye.Checked)
        {
            param[1] = new SqlParameter("@cActive", 1);
        }
        else
        {
            param[1] = new SqlParameter("@cActive", Convert.ToInt32(0));
        }
        int coun = Convert.ToInt32(objdut.GetScalar("select count(*) from dept_master where deptname='" + txtcountry.Text + "'"));
        if (coun == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "This Department is already exist");
        }
        else
        {
            string Query = "insert into dept_master(deptname,status,brid) values(@countryName,@cActive,@branchID)";
            param[0] = new SqlParameter("@countryName", SqlDbType.VarChar, 250);
            param[0].Value = txtcountry.Text;
            param[1] = new SqlParameter("@cActive", SqlDbType.Bit);
            if (chkcountrye.Checked)
            {
                param[1] = new SqlParameter("@cActive", 1);
            }
            else
            {
                param[1] = new SqlParameter("@cActive", Convert.ToInt32(0));
            }
            param[2] = new SqlParameter("@branchID", Convert.ToInt32(Session["BrBrid"]));
            int result = objdut.ExecuteSql(param, Query);
            if (result > 0)
            {
                Utility.ViewAlertMessage(this.Master.Page, "department name added successfully.");
                Button2.Visible = true;
                divall.Visible = false;
                divgrid.Visible = true;
                txtcountry.Text = "";
                chkcountrye.Checked = false;
                FillGridStateDetail();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "department name not saved.");
                //lblMsg1.Text = "Country Name Not Saved";
            }
        }
    }

    protected void btnupdate_Click(object sender, EventArgs e)
    {
        if (txtcountry.Text != "")
        {
            int i = Convert.ToInt32(objdut.GetScalar("select count(*) from dept_master where deptname='" + txtcountry.Text.Trim() + "'"));

            if (i >= 0)
            {
                string query = "update dept_master set deptname=@countryName,status=@cActive where deptid=" + Convert.ToInt32(ViewState["CID"].ToString());
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@countryName", SqlDbType.VarChar, 50);
                param[0].Value = txtcountry.Text;
                param[1] = new SqlParameter("@cActive", SqlDbType.Bit);
                if (chkcountrye.Checked)
                {
                    param[1] = new SqlParameter("@cActive", 1);
                }
                else
                {
                    param[1] = new SqlParameter("@cActive", Convert.ToInt32(0));
                    //chkcountrye.Checked = false;
                }

                int result1 = objdut.ExecuteSql(param, query);
                if (result1 > 0)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Department updated successfully.");
                    divall.Visible = false;
                    divgrid.Visible = true;
                    Button2.Visible = true;
                    txtcountry.Text = "";
                    chkcountrye.Checked = false;
                    btnupdate.Visible = false;
                    btncountry.Visible = true;
                    FillGridStateDetail();
                }
            }
        }
    }

    protected void FillGridStateDetail()
    {
        // string query = "select countryName,CID,cActive=case cActive when  1 then 'Active' when 0 then 'Deactive' end from COUNTRY order by countryName";
        string v = "select deptid as cid,deptname as countryName,status=case status when  1 then 'Active' when 0 then 'Deactive' end,brid,brname from dept_master ";
        DataTable table = objdut.GetDataTable(v);
        Grid_Country.DataSource = table;
        Grid_Country.DataBind();
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
    }

    protected void Grid_Country_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "edit0")
        {
            divall.Visible = true;
            divgrid.Visible = false;
            Button2.Visible = false;
            ViewState["CID"] = e.CommandArgument;
            lblMsg1.Text = "";
            int deptid = Convert.ToInt32(e.CommandArgument);
            string query = "select deptname,status from dept_master where deptid=" + deptid;
            DataTable table = objdut.GetDataTable(query);
            if (table.Rows.Count > 0)
            {
                txtcountry.Text = table.Rows[0]["deptname"].ToString();
                if (table.Rows[0]["status"].ToString() == "1")
                {
                    chkcountrye.Checked = true;
                }
                else
                {
                    chkcountrye.Checked = false;
                }
            }
            btnupdate.Visible = true;
            btncountry.Visible = false;
        }
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
        Response.Redirect("Designation.aspx");
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Button2.Visible = false;
        divall.Visible = true;
        divgrid.Visible = false;
    }
}