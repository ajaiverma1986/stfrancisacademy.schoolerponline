using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_setholiday : System.Web.UI.Page
{
    private string query = "", query1 = "", res, query2 = "", query3 = "", query4 = "", query5 = "", query6 = "", query7 = "";
    private int res1, e1;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private CommonClass commonobj = new CommonClass();
    private DataTable table = new DataTable();
    private SqlParameter[] param = new SqlParameter[4];

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            int fyid = Convert.ToInt32(objdut.GetScalar("select FYID  from financial_Year where isActive=1 and isClosed=0"));
            ViewState["fyid"] = Convert.ToInt32(fyid);
            bind();
            Grid_holiday.Visible = true;
            dd1.Visible = false;
        }
    }

    public void bind()
    {
        //query3 = @"select convert(varchar(13),date,106) as Date,status=case Status when 1 then 'Active' else 'Deactive' end,reason from tbl_setholiday order by datepart(m,date) desc, datepart(d,date) desc";
        query3 = @"select snp,convert(varchar(13),date,106) as Date,status=case Status when 1 then 'Active' else 'Deactive' end,reason from tbl_setholiday where status!=2
 order by datepart(m,date) asc, datepart(d,date) asc";

        table = objdut.GetDataTable(query3);
        if (table.Rows.Count > 0)
        {
            Grid_holiday.DataSource = table;
            Grid_holiday.DataBind();
        }
        else
        {
            Grid_holiday.DataSource = null;
            Grid_holiday.DataBind();
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        query1 = "SELECT DATENAME(dw,'" + txtDate.Text.Trim() + "')";
        res = objdut.GetScalar(query1).ToString();
        btnadd.Visible = true;

        if (res == "Sunday")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Selected date is already holiday.ie,Sunday");
            lbl.Text = "List of Holidays";
            ddlsearchoption.Visible = true;
            btn.Visible = true;
            dd1.Visible = false;
            bind();
            Grid_holiday.Visible = true;
            return;
        }
        else
        {
            query2 = " select count(date) from tbl_setholiday where convert(date,date)=cast('" + txtDate.Text.Trim() + "' as datetime) and status=1";
            int d = Convert.ToInt32(objdut.GetScalar(query2));
            if (d > 0)
            {
                Utility.ViewAlertMessage(this.Master.Page, "selected date is already exist");

                ddlsearchoption.Visible = true;
                btn.Visible = true;
                dd1.Visible = false;
                bind();
                Grid_holiday.Visible = true;
                txtDate.Text = "";
                txt1.Text = "";
                chkstatus.Checked = false;
                return;
            }
            else
            {
                query = "insert into tbl_setholiday(date,status,reason,fyid) values(@date,@status,@reason," + ViewState["fyid"] + ")";
                param[0] = new SqlParameter("@date", txtDate.Text.Trim());
                param[1] = new SqlParameter("@reason", txt1.Text.Trim());
                param[2] = new SqlParameter("@status", SqlDbType.Bit);
                if (chkstatus.Checked)
                {
                    param[2] = new SqlParameter("@status", 1);
                }
                else
                {
                    param[2] = new SqlParameter("@status", Convert.ToInt32(0));
                }
                param[3] = new SqlParameter("@fyid", Convert.ToInt32(Session["fyid"]));
                int result = objdut.ExecuteSql(param, query);
                if (result > 0)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Holiday added successfully.");
                    lbl.Text = "List of Holidays";
                    ddlsearchoption.Visible = true;
                    btn.Visible = true;
                    dd1.Visible = false;
                    bind();
                    Grid_holiday.Visible = true;

                    txtDate.Text = "";
                    txt1.Text = "";
                    chkstatus.Checked = false;
                }
            }
        }
    }

    protected void btn_Click(object sender, EventArgs e)
    {
        btnadd.Visible = true;
        if (ddlsearchoption.SelectedIndex != 0)
        {
            query4 = @"select snp,convert(varchar(13),date,106) as Date,status=case Status when 1 then 'Active' else 'Deactive' end,reason from tbl_setholiday
                          where DATEPART(m,date)=" + ddlsearchoption.SelectedValue + " and status=1 and fyid=" + ViewState["fyid"] + " order by datepart(m,date) asc, datepart(d,date) asc";
            table = objdut.GetDataTable(query4);
            if (table.Rows.Count > 0)
            {
                dd1.Visible = false;

                Grid_holiday.Visible = true;
                Grid_holiday.DataSource = table;
                Grid_holiday.DataBind();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "There is no holiday in this month .");
                dvn.Visible = true;
                bind();

                lbl.Text = "List of Holidays";

                Grid_holiday.Visible = true;
                ddlsearchoption.SelectedIndex = 0;

                return;
            }
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select a month .");
            bind();
            dvn.Visible = true;
            Grid_holiday.Visible = true;
        }
    }

    protected void btnupd_Click(object sender, EventArgs e)
    {
        btnadd.Visible = true;
        query7 = @"update tbl_setholiday set date=@date,status=@status,reason=@reason where snp= " + (ViewState["show"].ToString() + " and fyid=" + ViewState["fyid"]);

        param[0] = new SqlParameter("@date", txtDate.Text.Trim());
        param[1] = new SqlParameter("@reason", txt1.Text.Trim());
        param[2] = new SqlParameter("@status", SqlDbType.Bit);
        if (chkstatus.Checked)
        {
            param[2] = new SqlParameter("@status", 1);
        }
        else
        {
            param[2] = new SqlParameter("@status", Convert.ToInt32(0));
        }
        param[3] = new SqlParameter("@fyid", Convert.ToInt32(0));
        int result = objdut.ExecuteSql(param, query7);
        if (result > 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Holiday updated  successfully.");
            bind();
            dvn.Visible = true;
            lbl.Text = "List of Holidays";
            ddlsearchoption.Visible = true;
            btn.Visible = true;
            dd1.Visible = false;

            Grid_holiday.Visible = true;

            txtDate.Text = "";
            txt1.Text = "";
            chkstatus.Checked = false;
        }
    }

    protected void Grid_holiday_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "edit12")
        {
            e1 = Convert.ToInt32(e.CommandArgument);
            query5 = "update tbl_setholiday set status=2 where snp=" + e1;
            int res1 = objdut.ExecuteSql(query5);
            if (res1 == 1)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Record has been deleted successfully.')", true);
                bind();
            }
        }

        if (e.CommandName == "edit5")
        {
            btnupd.Visible = true;
            ddlsearchoption.Visible = false;
            btn.Visible = false;
            dvn.Visible = false;
            btnadd.Visible = false;
            lbl.Text = "Update holidays";
            ddlsearchoption.SelectedIndex = 0;

            btnsubmit.Visible = false;
            Button1.Visible = false;
            dd1.Visible = true;

            e1 = Convert.ToInt32(e.CommandArgument);
            ViewState["show"] = e1;
            query6 = "select snp,convert(varchar(13),date,106) as Date,status,reason from tbl_setholiday where snp=" + e1;
            table = objdut.GetDataTable(query6);
            if (table.Rows.Count > 0)
            {
                txtDate.Text = table.Rows[0]["date"].ToString();
                txt1.Text = table.Rows[0]["reason"].ToString();
                if (Convert.ToInt32(table.Rows[0]["status"].ToString()) == 1)
                {
                    chkstatus.Checked = true;
                }
                else
                {
                    chkstatus.Checked = false;
                }
                //chkstatus.Checked = table.Rows[0]["status"].ToString();
            }
        }
    }

    protected void ddlsearchoption_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlsearchoption.SelectedValue == "0")
        {
            dvn.Visible = false;
            Grid_holiday.Visible = false;
        }
    }

    protected void btnadd_Click(object sender, EventArgs e)
    {
        chkstatus.Checked = false;
        txtDate.Text = "";
        txt1.Text = "";
        Button1.Visible = true;
        btnupd.Visible = false;
        lbl.Text = "Add Holiday";
        btnadd.Visible = false;
        dd1.Visible = true;
        Grid_holiday.Visible = false;
        ddlsearchoption.Visible = false;
        btn.Visible = false;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        lbl.Text = "List of Holidays";
        Grid_holiday.Visible = true;
        bind();
        btnadd.Visible = true;
        ddlsearchoption.Visible = true;
        btn.Visible = true;
        dd1.Visible = false;
        ddlsearchoption.SelectedIndex = 0;
    }
}