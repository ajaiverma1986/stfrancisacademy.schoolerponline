using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class BranchPanel_discount_report : System.Web.UI.Page
{
    private string url, PageName;
    private int totalpage = 0;
    private DataUtility objdut = new DataUtility();
    private DataTable dt;

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
            setpage();
            fillgrid(20, 1, "");
            //  fillgrd();
        }
    }

    private void fillgrid(int pagesize, int currentpage, string value)
    {
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@brid ", Convert.ToInt16(Session["BrBrid"]));
        param[1] = new SqlParameter("@PageSize", pagesize);
        param[2] = new SqlParameter("@CurrentPage", currentpage);
        param[3] = new SqlParameter("@classname", value);

        dt = objdut.GetDataTableSP(param, "usp_discountsearch");

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

    private void setpage()
    {
        // string query = "select count(1) from tbl_admission where fyid=" + ViewState["acad"] + " and branchid=" + Session["BrBrid"];
        int query = CommonClass.scaler("countstudentnotransport", Convert.ToInt32(Session["BrBrid"]));
        int i = 0;
        PageNo.Items.Clear();
        PageNo.Items.Insert(i, Convert.ToString("Page No"));
        totalpage = query / Convert.ToInt32(ViewState["noofrecord"]);
        if (query % Convert.ToInt32(ViewState["noofrecord"]) == 0)
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
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(TextBox1.Text.Trim()));
    }

    protected void ddlRecordperPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlRecordperPage.SelectedValue != "0")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            setpage();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(TextBox1.Text.Trim()));
        }
        else
        {
            ViewState["noofrecord"] = 20;
            ViewState["PageNo"] = 1;
            setpage();
            fillgrid(20, 1, "");
        }
    }

    protected void PageNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (PageNo.SelectedIndex > 0)
        {
            ViewState["PageNo"] = PageNo.SelectedItem.Text;

            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(TextBox1.Text.Trim()));
        }
        else
        {
            setpage();
            fillgrid(20, 1, "");
        }
    }

    protected void firstpage_Click(object sender, ImageClickEventArgs e)
    {
        ViewState["PageNo"] = 1;
        if (PageNo.SelectedIndex >= 1)
        {
            PageNo.SelectedIndex = 1;
        }
        else
        {
            PageNo.SelectedIndex = 0;
        }

        fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(TextBox1.Text.Trim()));
    }

    protected void last_Click(object sender, ImageClickEventArgs e)
    {
        int query = CommonClass.scaler("countstudentnotransport", Convert.ToInt32(Session["BrBrid"]));

        totalpage = query / Convert.ToInt32(ViewState["noofrecord"]);
        if (query % Convert.ToInt32(ViewState["noofrecord"]) == 0)
        {
            //  totalpage = totalpage + 1;
        }
        else
        {
            totalpage = totalpage + 1;
        }
        ViewState["PageNo"] = totalpage;

        if (PageNo.Items.Count >= totalpage)
        {
            PageNo.SelectedIndex = totalpage;
        }

        fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(TextBox1.Text.Trim()));
    }

    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        int query = CommonClass.scaler("countstudentnotransport", Convert.ToInt32(Session["BrBrid"]));

        totalpage = query / Convert.ToInt32(ViewState["noofrecord"]);
        if (query % Convert.ToInt32(ViewState["noofrecord"]) == 0)
        {
            //  totalpage = totalpage + 1;
        }
        else
        {
            totalpage = totalpage + 1;
        }
        int currentpage = Convert.ToInt32(ViewState["PageNo"]);
        if (currentpage < totalpage)
        {
            currentpage = currentpage + 1;
            ViewState["PageNo"] = currentpage;
            if (PageNo.Items.Count >= currentpage)
            {
                PageNo.SelectedIndex = currentpage;
            }
            //PageNo.SelectedIndex = currentpage;

            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(TextBox1.Text.Trim()));
        }
    }

    protected void previous_Click(object sender, ImageClickEventArgs e)
    {
        int currentpage = Convert.ToInt32(ViewState["PageNo"]);
        if (currentpage > 1)
        {
            currentpage = currentpage - 1;
            ViewState["PageNo"] = currentpage;
            if (PageNo.Items.Count >= currentpage)
            {
                PageNo.SelectedIndex = currentpage;
            }
            //PageNo.SelectedIndex = currentpage;

            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(TextBox1.Text.Trim()));
        }
    }

    protected void btnreset_Click(object sender, EventArgs e)
    {
        fillgrid(20, 1, "");
        setpage();
    }
}