using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_bustoroute : System.Web.UI.Page
{
    private DataTable obj;
    private DataUtility objdut = new DataUtility();
    private DataUtility objdut1 = new DataUtility();
    private Utility objut = new Utility();
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
    private SqlCommand cmd = new SqlCommand();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int x = Convert.ToInt32(objdut.GetScalar("select FYID from financial_Year where isActive=1 and isClosed=0"));
            ViewState["fyid"] = x;
            fillfun();
            fillgrd();
            divmn.Visible = false;
            btnsubmit.Visible = false;
            abc.Visible = false;
        }
    }

    private void fillgrd()
    {
        string str = "select Routeno,BusNo,Rid from tbl_route where branchid=" + Convert.ToInt32(Session["BrBrid"]) + " and fyid=" + ViewState["fyid"] + " and status=1";
        DataTable dt = objdut.GetDataTable(str);
        if (dt.Rows.Count > 0)
        {
            Gridview1.DataSource = dt;
            Gridview1.DataBind();
        }
        else
        {
            Gridview1.EmptyDataText = "No Record Found.";
            Gridview1.DataSource = null;
            Gridview1.DataBind();
        }
    }

    private void fillfun()
    {
        obj = CommonClass.ABC("route");//objdut.GetDataTable("select rid,routeno from tbl_route ");
        ddlroute.DataSource = obj;
        ddlroute.DataTextField = "routeno";
        ddlroute.DataValueField = "rid";
        ddlroute.DataBind();
        //ddlroute.Items.Insert(0,"--select Route--");
        ddlroute.Items.Insert(0, new ListItem("--Select Route--", "0"));
    }

    protected void ddlroute_SelectedIndexChanged(object sender, EventArgs e)
    {
        abc.Visible = false;
        // ddlroute.Items.Clear();
        int ddlroutname = Convert.ToInt32(ddlroute.SelectedValue);
        ViewState["root"] = ddlroutname;
        int query = Convert.ToInt32(objdut.GetScalar("select COUNT(busno) from tbl_route where rid=" + ddlroutname));
        if (query == 1)
        {
            btnsubmit.Visible = false;
            // btnsubmit.Text = "Edit";
            string q1 = Convert.ToString(objdut.GetScalar("select busno from tbl_route where routeno='" + ddlroute.SelectedItem.Text + "'"));
            Utility.ViewAlertMessage(this.Master.Page, "Bus No. " + (q1) + " Already Added on  " + ddlroute.SelectedItem.Text + " route.Please Select other Route");
            ddlroute.SelectedIndex = 0;
            abc.Visible = false;
            return;
        }
        else
        {
            btnsubmit.Visible = false;
            obj = objdut.GetDataTable("select id,registrationno from tbl_vehicleinfo");
            ddlbus.DataSource = obj;
            ddlbus.DataTextField = "registrationno";
            ddlbus.DataValueField = "id";
            ddlbus.DataBind();
            ddlbus.Items.Insert(0, new ListItem("--Select Bus--", "0"));
        }
    }

    protected void ddlbus_SelectedIndexChanged(object sender, EventArgs e)
    {
        btnsubmit.Visible = true;
        string id = (ddlbus.SelectedItem.Text);
        ViewState["ibs"] = id;
        int query = Convert.ToInt32(objdut.GetScalar("select COUNT(busno) from tbl_route where Busno='" + ddlbus.SelectedItem.Text + "'"));

        if (query == 3)
        {
            abc.Visible = true;
            btnsubmit.Visible = false;
            //  btnsubmit.Text = "Edit";
            string query1 = "select registrationno,noofseats,chesisno,make,modelno,convert(varchar(13),NextFCDate,105) as NextFCDate,convert(varchar(13),NextTaxdate,105) as NextTaxdate,insuranceCompanyName,insuranceno,contactno,document,convert(varchar(13),NextInsuranceDate,105)as NextInsuranceDate  from tbl_vehicleinfo where registrationno='" + ddlbus.SelectedItem.Text + "'";

            SqlDataReader dr = objdut.GetDataReader(query1);
            if (dr.HasRows)
            {
                dr.Read();
                txtRegNo.Text = dr["registrationno"].ToString();
                txtChassisNo.Text = dr["chesisno"].ToString();
                txtModel.Text = dr["modelno"].ToString();
                txtNumOfSeat.Text = dr["noofseats"].ToString();
                txtmake.Text = dr["make"].ToString();
                txtIncCmpny.Text = dr["insuranceCompanyName"].ToString();
                txtInsurenceNum.Text = dr["insuranceno"].ToString();
                txtMDOB.Text = dr["NextInsuranceDate"].ToString();
                txtToDate.Text = dr["NextTaxdate"].ToString();
                txtDate.Text = dr["NextFCDate"].ToString();
                txtCnctNum.Text = dr["contactno"].ToString();
                lblfile.Text = dr["document"].ToString();
                dr.Close();
            }

            string abc1 = Convert.ToString(objdut.GetScalar("select routeno from tbl_route where busno='" + ddlbus.SelectedItem.Text + "'"));

            fillfun();
            //ddlroute.Items.Clear();
            ddlroute.SelectedItem.Text = abc1;
            ddlroute.Enabled = false;
            Utility.ViewAlertMessage(this.Master.Page, " This Bus Already Added on " + abc1);
            return;
        }
        else
        {
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        if (checkvalidation())
        {
            if (btnsubmit.Text == "Submit")
            {
                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@mode", "addbustoroute");
                param[1] = new SqlParameter("@busno", ddlbus.SelectedItem.Text);
                param[2] = new SqlParameter("@routeno", ddlroute.SelectedItem.Text);
                param[3] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                param[3].Direction = ParameterDirection.Output;
                int res = objdut.ExecuteSqlSP(param, "usp_bustoroute");
                if (res > 0)
                {
                    btnsubmit.Visible = false;
                    Utility.ViewAlertMessage(this.Master.Page, "Successfully Added !");
                    reset();
                    fillgrd();
                    divmn.Visible = false;
                    Gridview1.Visible = true;
                    abc.Visible = false;
                    return;
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, " Error..... !");
                    return;
                }
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, " Not Editable..... !");
                return;
            }
        }
    }

    private void reset()
    {
        ddlbus.SelectedIndex = 0;
        ddlroute.SelectedIndex = 0;
    }

    private bool checkvalidation()
    {
        if (ddlbus.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select Bus");
            return false;
        }
        return true;
    }

    protected void txtRegNo_TextChanged(object sender, EventArgs e)
    {
    }

    protected void btnbus_Click(object sender, EventArgs e)
    {
        Response.Redirect("bustoroute.aspx");
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        ddlroute.Items.Clear();
        divmn.Visible = true;
        Gridview1.Visible = false;
        abc.Visible = false;
        fillfun();
        ddlroute.Enabled = true;
        ddlbus.Items.Clear();
        ddlbus.Items.Insert(0, new ListItem("--Select Bus--", "0"));
    }

    protected void Gridview1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "view")
        {
            abc.Visible = true;
            string id = Convert.ToString(e.CommandArgument);
            //Control ctrl = e.CommandSource as Control;

            // GridViewRow row = ctrl.Parent.NamingContainer as GridViewRow;
            // LinkButton lnkno = (LinkButton)row.FindControl("lnkvw");
            string query1 = "select registrationno,noofseats,chesisno,make,modelno,convert(varchar(13),NextFCDate,105) as NextFCDate,convert(varchar(13),NextTaxdate,105) as NextTaxdate,insuranceCompanyName,insuranceno,contactno,document,convert(varchar(13),NextInsuranceDate,105)as NextInsuranceDate  from tbl_vehicleinfo where registrationno='" + id + "'";
            SqlDataReader dr = objdut.GetDataReader(query1);
            if (dr.HasRows)
            {
                dr.Read();
                txtRegNo.Text = dr["registrationno"].ToString();
                txtChassisNo.Text = dr["chesisno"].ToString();
                txtModel.Text = dr["modelno"].ToString();
                txtNumOfSeat.Text = dr["noofseats"].ToString();
                txtmake.Text = dr["make"].ToString();
                txtIncCmpny.Text = dr["insuranceCompanyName"].ToString();
                txtInsurenceNum.Text = dr["insuranceno"].ToString();
                txtMDOB.Text = dr["NextInsuranceDate"].ToString();
                txtToDate.Text = dr["NextTaxdate"].ToString();
                txtDate.Text = dr["NextFCDate"].ToString();
                txtCnctNum.Text = dr["contactno"].ToString();
                lblfile.Text = dr["document"].ToString();
            }
            dr.Close();

            string abc1 = Convert.ToString(objdut.GetScalar("select routeno from tbl_route where busno='" + id + "'"));

            fillfun();
            //ddlroute.Items.Clear();
            ddlroute.SelectedItem.Text = abc1;
            ddlroute.Enabled = false;
            Gridview1.Visible = false;
        }
    }

    protected void Gridview1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblbno = (Label)e.Row.FindControl("lblbusno");
            LinkButton lnkvw = (LinkButton)e.Row.FindControl("lnkvw");
            if (lblbno.Text == "" || lblbno.Text == null)
            {
                lblbno.Text = "No Vehicle Added in this Route";
                lblbno.ForeColor = System.Drawing.Color.Red;
                lnkvw.ForeColor = System.Drawing.Color.Black;
                lnkvw.Enabled = false;
            }
        }
    }
}