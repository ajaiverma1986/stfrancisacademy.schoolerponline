using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_OverDueList : BasePage
{
    private Utility objUT = new Utility();
    private string query2 = "";
    private DataUtility objDUT = new DataUtility();
    private string url = "", query = "", PageName, query1 = "", queryScid = "", qCount = "";
    private DataTable dt, dt1;
    private int fyid = 0, scidcount = 0;
    private SqlParameter[] param1 = new SqlParameter[1];
    private int totalpage = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        if (!IsPostBack)
        {
            ViewState["noofrecord"] = 20;
            ViewState["PageNo"] = 1;
            ViewState["q"] = query;
            fillGrid(Convert.ToInt16(Session["BrBrid"]));
            fillgrid(20, 1, "", "", "");
            setpage();
            getdata();
        }
    }

    protected void fillGrid(int brid)
    {
        param1[0] = new SqlParameter("@brid", brid);
        DataTable dt = objDUT.GetDataTableSP(param1, "usp_overduelist");

        if (dt.Rows.Count > 0)
        {
            GridBatch.Visible = true;
            lblmsg.Visible = false;
            gvdetails.DataSource = dt;

            gvdetails.DataBind();
            IBExcel.Enabled = true;
        }
        else
        {
            lblmsg.Visible = true;
            GridBatch.Visible = false;
            lblmsg.Text = "No record found.";
            gvdetails.DataSource = null;
            gvdetails.DataBind();
            IBExcel.Enabled = false;
            IBExcel.ToolTip = "No data to export to excel.";
        }
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        //if (gvdetails.DataSource == null)
        //{
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('No data found.')", true);
        //    return;
        //}
        // base.LogActivity("  OverDueList excel sheet downloaded.", true, Convert.ToInt32(Session["BrADID"]));
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "OverDueFee.xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        gvdetails.AllowPaging = false;
        //Change the Header Row back to white color
        gvdetails.HeaderRow.Style.Add("background-color", "#FFFFFF");
        //Applying stlye to gridview header cells
        for (int i = 0; i < gvdetails.HeaderRow.Cells.Count; i++)
        {
            gvdetails.HeaderRow.Cells[i].Style.Add("background-color", "#49c0f0");
        }
        int j = 1;
        //This loop is used to apply stlye to cells based on particular row
        foreach (GridViewRow gvrow in gvdetails.Rows)
        {
            gvrow.BackColor = System.Drawing.Color.White;
            if (j <= gvdetails.Rows.Count)
            {
                if (j % 2 != 0)
                {
                    for (int k = 0; k < gvrow.Cells.Count; k++)
                    {
                        gvrow.Cells[k].Style.Add("background-color", "#EFF3FB");
                    }
                }
            }
            j++;
        }
        gvdetails.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    public void setpage()
    {
        string query1 = @"select Count(*)From (
                              select adid,adno,name,applyclass,sum(isnull(payablefee,0)) as payablefee,sum(isnull(actualfee,0)) as actualfee,
	                             ROW_NUMBER() OVER (ORDER BY adid desc ) AS RowNumber from tbl_Branch1_Overduelist
                         Group By adid,adno,name,applyclass
                           ) As Z";
        int i = 0;
        PageNo.Items.Clear();
        PageNo.Items.Insert(i, Convert.ToString("PageNo"));
        totalpage = Convert.ToInt32(objDUT.GetScalar(query1)) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(objDUT.GetScalar(query1)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
        {
            //  totalpage = totalpage + 1;
        }
        else
        {
            totalpage = totalpage + 1;
        }
        for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
        {
            PageNo.Items.Insert(page, Convert.ToString(page));
            page = page + 1;
        }
        if (Convert.ToInt32(ViewState["PageNo"]) > totalpage)
        {
            ViewState["PageNo"] = 1;
        }
        PageNo.SelectedIndex = Convert.ToInt32(ViewState["PageNo"]);
    }

    private void fillgrid(int pagesize, int currentpage, string classname, string adno, string name)
    {
        SqlParameter[] param = new SqlParameter[5];

        param[0] = new SqlParameter("@PageSize", pagesize);
        param[1] = new SqlParameter("@CurrentPage", currentpage);
        param[2] = new SqlParameter("@searchvalue1", classname);
        param[3] = new SqlParameter("@searchvalue2", adno);
        param[4] = new SqlParameter("@searchvalue3", name);

        dt = objDUT.GetDataTableSP(param, "usp_overduelistsearching");

        if (dt.Rows.Count > 0)
        {
            gvdetails.DataSource = dt;
            gvdetails.DataBind();
        }
        else
        {
            gvdetails.EmptyDataText = "No Record Found.!";
            gvdetails.DataBind();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text == "")
        {
            setpage1();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), "", "");
        }
        else if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text == "")
        {
            setpage4();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), Convert.ToString(txtadmission.Text.Trim()), "");
        }
        else if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text != "")
        {
            setpage5();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), Convert.ToString(txtadmission.Text.Trim()), Convert.ToString(txtnamesearch.Text.Trim()));
        }
        else if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text == "")
        {
            setpage2();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", Convert.ToString(txtadmission.Text.Trim()), "");
        }
        else if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text != "")
        {
            setpage6();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", Convert.ToString(txtadmission.Text.Trim()), Convert.ToString(txtnamesearch.Text.Trim()));
        }
        else if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text != "")
        {
            setpage7();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), "", Convert.ToString(txtnamesearch.Text.Trim()));
        }
        else if (txtclass.Text == "" && txtadmission.Text == "" && txtnamesearch.Text != "")
        {
            setpage3();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", "", Convert.ToString(txtnamesearch.Text.Trim()));
        }
    }

    protected void ddlRecordperPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlRecordperPage.SelectedValue != "0")
        {
            if (txtclass.Text == "" && txtadmission.Text == "" && txtnamesearch.Text == "")
            {
                ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
                setpage();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", "", "");
            }
            else if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text == "")
            {
                ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
                setpage1();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), "", "");
            }
            else if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text == "")
            {
                ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
                setpage4();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), Convert.ToString(txtadmission.Text.Trim()), "");
            }
            else if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text != "")
            {
                ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
                setpage5();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), Convert.ToString(txtadmission.Text.Trim()), Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text == "")
            {
                ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
                setpage2();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", Convert.ToString(txtadmission.Text.Trim()), "");
            }
            else if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text != "")
            {
                ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
                setpage6();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", Convert.ToString(txtadmission.Text.Trim()), Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text != "")
            {
                ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
                setpage6();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), "", Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else if (txtclass.Text == "" && txtadmission.Text == "" && txtnamesearch.Text != "")
            {
                ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
                setpage3();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", "", Convert.ToString(txtnamesearch.Text.Trim()));
            }
        }
        else
        {
            ViewState["noofrecord"] = 20;
            ViewState["PageNo"] = 1;
            setpage();
            fillgrid(20, 1, "", "", "");
        }
    }

    public void getdata()
    {
        int count = Convert.ToInt32(objDUT.GetScalar(";WITH g AS (select ROW_NUMBER() OVER (ORDER BY adid desc ) AS RowNumber  from tbl_Branch1_Overduelist  group by adid) select count(1) from g"));
        lblConduted.Text = Convert.ToString(count);

        double count1 = Convert.ToDouble(objDUT.GetScalar("select isnull(sum(payablefee),0) from tbl_Branch1_Overduelist"));
        lblPresent.Text = (count1).ToString("0.00");
    }

    public void setpage1()
    {
        if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text == "")
        {
            string query2 = @"select Count(*)From (
                              select adid,adno,name,applyclass,sum(isnull(payablefee,0)) as payablefee,sum(isnull(actualfee,0)) as actualfee,
	                             ROW_NUMBER() OVER (ORDER BY adid desc ) AS RowNumber from tbl_Branch1_Overduelist  where applyclass='" + txtclass.Text.Trim() + "' Group By adid,adno,name,applyclass ) As Z";

            int i = 0;
            PageNo.Items.Clear();
            PageNo.Items.Insert(i, Convert.ToString("PageNo"));
            totalpage = Convert.ToInt32(objDUT.GetScalar(query2)) / Convert.ToInt32(ViewState["noofrecord"]);
            if (Convert.ToInt32(objDUT.GetScalar(query2)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
            {
                //  totalpage = totalpage + 1;
            }
            else
            {
                totalpage = totalpage + 1;
            }
            for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
            {
                PageNo.Items.Insert(page, Convert.ToString(page));
                page = page + 1;
            }
            if (Convert.ToInt32(ViewState["PageNo"]) > totalpage)
            {
                ViewState["PageNo"] = 1;
            }
            //PageNo.SelectedIndex = 1;
        }
    }

    public void setpage2()
    {
        if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text == "")
        {
            string query2 = @"select Count(*)From (
                              select adid,adno,name,applyclass,sum(isnull(payablefee,0)) as payablefee,sum(isnull(actualfee,0)) as actualfee,
	                             ROW_NUMBER() OVER (ORDER BY adid desc ) AS RowNumber from tbl_Branch1_Overduelist  where adno='" + txtadmission.Text.Trim() + "' Group By adid,adno,name,applyclass ) As Z";

            int i = 0;
            PageNo.Items.Clear();
            PageNo.Items.Insert(i, Convert.ToString("PageNo"));
            totalpage = Convert.ToInt32(objDUT.GetScalar(query2)) / Convert.ToInt32(ViewState["noofrecord"]);
            if (Convert.ToInt32(objDUT.GetScalar(query2)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
            {
                //  totalpage = totalpage + 1;
            }
            else
            {
                totalpage = totalpage + 1;
            }
            for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
            {
                PageNo.Items.Insert(page, Convert.ToString(page));
                page = page + 1;
            }
            if (Convert.ToInt32(ViewState["PageNo"]) > totalpage)
            {
                ViewState["PageNo"] = 1;
            }
            //PageNo.SelectedIndex = 1;
        }
    }

    public void setpage3()
    {
        if (txtclass.Text == "" && txtadmission.Text == "" && txtnamesearch.Text != "")
        {
            string query2 = @"select Count(*)From (
                              select adid,adno,name,applyclass,sum(isnull(payablefee,0)) as payablefee,sum(isnull(actualfee,0)) as actualfee,
	                             ROW_NUMBER() OVER (ORDER BY adid desc ) AS RowNumber from tbl_Branch1_Overduelist where  name='" + txtnamesearch.Text.Trim() + "' Group By adid,adno,name,applyclass ) As Z";

            int i = 0;
            PageNo.Items.Clear();
            PageNo.Items.Insert(i, Convert.ToString("PageNo"));
            totalpage = Convert.ToInt32(objDUT.GetScalar(query2)) / Convert.ToInt32(ViewState["noofrecord"]);
            if (Convert.ToInt32(objDUT.GetScalar(query2)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
            {
                //  totalpage = totalpage + 1;
            }
            else
            {
                totalpage = totalpage + 1;
            }
            for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
            {
                PageNo.Items.Insert(page, Convert.ToString(page));
                page = page + 1;
            }
            if (Convert.ToInt32(ViewState["PageNo"]) > totalpage)
            {
                ViewState["PageNo"] = 1;
            }
            //PageNo.SelectedIndex = 1;
        }
    }

    public void setpage4()
    {
        if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text == "")
        {
            string query2 = @"select Count(*)From (
                              select adid,adno,name,applyclass,sum(isnull(payablefee,0)) as payablefee,sum(isnull(actualfee,0)) as actualfee,
	                             ROW_NUMBER() OVER (ORDER BY adid desc ) AS RowNumber from tbl_Branch1_Overduelist where  name='" + txtnamesearch.Text.Trim() + "' and adno='" + txtadmission.Text.Trim() + "' Group By adid,adno,name,applyclass ) As Z";
            int i = 0;
            PageNo.Items.Clear();
            PageNo.Items.Insert(i, Convert.ToString("PageNo"));
            totalpage = Convert.ToInt32(objDUT.GetScalar(query2)) / Convert.ToInt32(ViewState["noofrecord"]);
            if (Convert.ToInt32(objDUT.GetScalar(query2)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
            {
                //  totalpage = totalpage + 1;
            }
            else
            {
                totalpage = totalpage + 1;
            }
            for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
            {
                PageNo.Items.Insert(page, Convert.ToString(page));
                page = page + 1;
            }
            if (Convert.ToInt32(ViewState["PageNo"]) > totalpage)
            {
                ViewState["PageNo"] = 1;
            }
            //PageNo.SelectedIndex = 1;
        }
    }

    public void setpage5()
    {
        if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text != "")
        {
            string query2 = @"select Count(*)From (
                              select adid,adno,name,applyclass,sum(isnull(payablefee,0)) as payablefee,sum(isnull(actualfee,0)) as actualfee,
	                             ROW_NUMBER() OVER (ORDER BY adid desc ) AS RowNumber from tbl_Branch1_Overduelist where  name='" + txtnamesearch.Text.Trim() + "' and adno='" + txtadmission.Text.Trim() + "'and applyclass='" + txtclass.Text.Trim() + "' Group By adid,adno,name,applyclass ) As Z";
            int i = 0;
            PageNo.Items.Clear();
            PageNo.Items.Insert(i, Convert.ToString("PageNo"));
            totalpage = Convert.ToInt32(objDUT.GetScalar(query2)) / Convert.ToInt32(ViewState["noofrecord"]);
            if (Convert.ToInt32(objDUT.GetScalar(query2)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
            {
                //  totalpage = totalpage + 1;
            }
            else
            {
                totalpage = totalpage + 1;
            }
            for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
            {
                PageNo.Items.Insert(page, Convert.ToString(page));
                page = page + 1;
            }
            if (Convert.ToInt32(ViewState["PageNo"]) > totalpage)
            {
                ViewState["PageNo"] = 1;
            }
            //PageNo.SelectedIndex = 1;
        }
    }

    public void setpage6()
    {
        if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text != "")
        {
            string query2 = @"select Count(*)From (
                              select adid,adno,name,applyclass,sum(isnull(payablefee,0)) as payablefee,sum(isnull(actualfee,0)) as actualfee,
	                             ROW_NUMBER() OVER (ORDER BY adid desc ) AS RowNumber from tbl_Branch1_Overduelist where  adno='" + txtadmission.Text.Trim() + "'and adno='" + txtnamesearch.Text.Trim() + "' Group By adid,adno,name,applyclass ) As Z";

            int i = 0;
            PageNo.Items.Clear();
            PageNo.Items.Insert(i, Convert.ToString("PageNo"));
            totalpage = Convert.ToInt32(objDUT.GetScalar(query2)) / Convert.ToInt32(ViewState["noofrecord"]);
            if (Convert.ToInt32(objDUT.GetScalar(query2)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
            {
                //  totalpage = totalpage + 1;
            }
            else
            {
                totalpage = totalpage + 1;
            }
            for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
            {
                PageNo.Items.Insert(page, Convert.ToString(page));
                page = page + 1;
            }
            if (Convert.ToInt32(ViewState["PageNo"]) > totalpage)
            {
                ViewState["PageNo"] = 1;
            }
            //PageNo.SelectedIndex = 1;
        }
    }

    public void setpage7()
    {
        if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text != "")
        {
            string query2 = @"select Count(*)From (
                              select adid,adno,name,applyclass,sum(isnull(payablefee,0)) as payablefee,sum(isnull(actualfee,0)) as actualfee,
	                             ROW_NUMBER() OVER (ORDER BY adid desc ) AS RowNumber from tbl_Branch1_Overduelist where  applyclass ='" + txtclass.Text.Trim() + "'and adno='" + txtnamesearch.Text.Trim() + "' Group By adid,adno,name,applyclass ) As Z";
            int i = 0;
            PageNo.Items.Clear();
            PageNo.Items.Insert(i, Convert.ToString("PageNo"));
            totalpage = Convert.ToInt32(objDUT.GetScalar(query2)) / Convert.ToInt32(ViewState["noofrecord"]);
            if (Convert.ToInt32(objDUT.GetScalar(query2)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
            {
                //  totalpage = totalpage + 1;
            }
            else
            {
                totalpage = totalpage + 1;
            }
            for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
            {
                PageNo.Items.Insert(page, Convert.ToString(page));
                page = page + 1;
            }
            if (Convert.ToInt32(ViewState["PageNo"]) > totalpage)
            {
                ViewState["PageNo"] = 1;
            }
            //PageNo.SelectedIndex = 1;
        }
    }

    protected void PageNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (PageNo.SelectedIndex > 0)
        {
            ViewState["PageNo"] = PageNo.SelectedItem.Text;
            if (txtclass.Text == "" && txtadmission.Text == "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", "", "");
            }
            else if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), "", "");
            }
            else if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), Convert.ToString(txtadmission.Text.Trim()), "");
            }
            else if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), Convert.ToString(txtadmission.Text.Trim()), Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", Convert.ToString(txtadmission.Text.Trim()), "");
            }
            else if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", Convert.ToString(txtadmission.Text.Trim()), Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), "", Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else if (txtclass.Text == "" && txtadmission.Text == "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", "", Convert.ToString(txtnamesearch.Text.Trim()));
            }
        }
        else
        {
            ViewState["noofrecord"] = 20;
            ViewState["PageNo"] = 1;
            setpage();
            fillgrid(20, 1, "", "", "");
        }
    }

    protected void last_Click(object sender, ImageClickEventArgs e)
    {
        int countnew = Convert.ToInt32(objDUT.GetScalar(@"select Count(*)From (
                              select adid,adno,name,applyclass,sum(isnull(payablefee,0)) as payablefee,sum(isnull(actualfee,0)) as actualfee,
	                             ROW_NUMBER() OVER (ORDER BY adid desc ) AS RowNumber from tbl_Branch1_Overduelist
                         Group By adid,adno,name,applyclass
                           ) As Z"));
        totalpage = countnew / Convert.ToInt32(ViewState["noofrecord"]);
        totalpage = totalpage + 1;
        int currentpage = Convert.ToInt32(ViewState["PageNo"]);
        if (currentpage < totalpage)
        {
            currentpage = currentpage + 1;
            ViewState["PageNo"] = currentpage;
            PageNo.SelectedIndex = currentpage;

            if (txtclass.Text == "" && txtadmission.Text == "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", "", "");
            }
            else if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), "", "");
            }
            else if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), Convert.ToString(txtadmission.Text.Trim()), "");
            }
            else if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), Convert.ToString(txtadmission.Text.Trim()), Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", Convert.ToString(txtadmission.Text.Trim()), "");
            }
            else if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", Convert.ToString(txtadmission.Text.Trim()), Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), "", Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else if (txtclass.Text == "" && txtadmission.Text == "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", "", Convert.ToString(txtnamesearch.Text.Trim()));
            }
            //   fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
        }
    }

    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        int countnew = Convert.ToInt32(objDUT.GetScalar(@"select Count(*)From (
                              select adid,adno,name,applyclass,sum(isnull(payablefee,0)) as payablefee,sum(isnull(actualfee,0)) as actualfee,
	                             ROW_NUMBER() OVER (ORDER BY adid desc ) AS RowNumber from tbl_Branch1_Overduelist
                         Group By adid,adno,name,applyclass
                           ) As Z"));
        totalpage = countnew / Convert.ToInt32(ViewState["noofrecord"]);
        totalpage = totalpage + 1;
        int currentpage = Convert.ToInt32(ViewState["PageNo"]);
        if (currentpage < totalpage)
        {
            currentpage = currentpage + 1;
            ViewState["PageNo"] = currentpage;
            PageNo.SelectedIndex = currentpage;

            if (txtclass.Text == "" && txtadmission.Text == "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", "", "");
            }
            else if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), "", "");
            }
            else if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), Convert.ToString(txtadmission.Text.Trim()), "");
            }
            else if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), Convert.ToString(txtadmission.Text.Trim()), Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", Convert.ToString(txtadmission.Text.Trim()), "");
            }
            else if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", Convert.ToString(txtadmission.Text.Trim()), Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), "", Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else if (txtclass.Text == "" && txtadmission.Text == "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", "", Convert.ToString(txtnamesearch.Text.Trim()));
            }
            //   fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
        }
    }

    protected void previous_Click(object sender, ImageClickEventArgs e)
    {
        int currentpage = Convert.ToInt32(ViewState["PageNo"]);
        if (currentpage > 1)
        {
            currentpage = currentpage - 1;
            ViewState["PageNo"] = currentpage;
            PageNo.SelectedIndex = currentpage;
            if (txtclass.Text == "" && txtadmission.Text == "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", "", "");
            }
            if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), "", "");
            }
            else if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), Convert.ToString(txtadmission.Text.Trim()), "");
            }
            else if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), Convert.ToString(txtadmission.Text.Trim()), Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text == "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", Convert.ToString(txtadmission.Text.Trim()), "");
            }
            else if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", Convert.ToString(txtadmission.Text.Trim()), Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), "", Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else if (txtclass.Text == "" && txtadmission.Text == "" && txtnamesearch.Text != "")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", "", Convert.ToString(txtnamesearch.Text.Trim()));
            }
        }
    }

    protected void firstpage_Click(object sender, ImageClickEventArgs e)
    {
        ViewState["PageNo"] = 1;
        if (PageNo.SelectedIndex >= 1)
        {
            PageNo.SelectedIndex = 1;
        }
        if (txtclass.Text == "" && txtadmission.Text == "" && txtnamesearch.Text == "")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            setpage();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", "", "");
        }
        if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text == "")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            setpage1();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), "", "");
        }
        else if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text == "")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            setpage4();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), Convert.ToString(txtadmission.Text.Trim()), "");
        }
        else if (txtclass.Text != "" && txtadmission.Text != "" && txtnamesearch.Text != "")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            setpage5();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), Convert.ToString(txtadmission.Text.Trim()), Convert.ToString(txtnamesearch.Text.Trim()));
        }
        else if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text == "")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            setpage2();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", Convert.ToString(txtadmission.Text.Trim()), "");
        }
        else if (txtclass.Text == "" && txtadmission.Text != "" && txtnamesearch.Text != "")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            setpage6();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", Convert.ToString(txtadmission.Text.Trim()), Convert.ToString(txtnamesearch.Text.Trim()));
        }
        else if (txtclass.Text != "" && txtadmission.Text == "" && txtnamesearch.Text != "")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            setpage7();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(txtclass.Text.Trim()), "", Convert.ToString(txtnamesearch.Text.Trim()));
        }
        else if (txtclass.Text == "" && txtadmission.Text == "" && txtnamesearch.Text != "")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            setpage3();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), "", "", Convert.ToString(txtnamesearch.Text.Trim()));
        }
    }

    [WebMethod]
    public static int getregno(string admno)
    {
        Utility objUT = new Utility();
        int ret = Convert.ToInt32(CommonClass.scaler("getstudentregno", Convert.ToString(admno), Convert.ToInt32(HttpContext.Current.Session["BrBrid"])));
        HttpContext.Current.Session["stue"] = ret;
        return ret;
    }
}