using System;
using System.Data;
using System.Web.UI;

public partial class BranchPanel_ClassFee : System.Web.UI.Page
{
    private CommonClass CommmonOBJ = new CommonClass();
    private string url;
    private DataTable dt;
    private static int totalpage = 0;
    private int countnew = 0;

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
            Table4.Visible = false;
            // setpage();
            DDL_Class_Bind();
            bind_month();
        }
    }

    private void setpage()
    {
        if (txtnamesearch.Text != "")
        {
            countnew = CommonClass.scaler("countnamewisestudent", Convert.ToString(txtnamesearch.Text.Trim()), Convert.ToInt32(Session["BrBrid"]));
        }
        else
        {
            countnew = Convert.ToInt32(CommonClass.Scaler("countclass_student", Convert.ToInt32(Session["BrBrid"]), Convert.ToInt32(DDLClass.SelectedValue)));
        }
        int i = 0;
        PageNo.Items.Clear();
        PageNo.Items.Insert(i, Convert.ToString("Page No"));
        totalpage = countnew / Convert.ToInt32(ViewState["noofrecord"]);
        totalpage = totalpage + 1;
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

    private void bind_month()
    {
        dt = CommmonOBJ.Dll("MonthName");
        if (dt.Rows.Count > 0)
        {
            ddlMonth.DataSource = dt;
            ddlMonth.DataBind();
            ddlMonth.DataTextField = "MonthName";
            ddlMonth.DataValueField = "MonthId";
            ddlMonth.DataBind();
            ddlMonth.Items.Insert(0, "--Select Month--");
            dt.Clear();
        }
    }

    private void DDL_Class_Bind()
    {
        dt = BLL.getclass(Convert.ToInt16(Session["BrBrid"]));
        if (dt.Rows.Count > 0)
        {
            DDLClass.DataSource = dt;
            DDLClass.DataTextField = "Classname";
            DDLClass.DataValueField = "classid";
            DDLClass.DataBind();
            DDLClass.Items.Insert(0, "--Select Class--");
            dt.Clear();
        }
    }

    protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlMonth.SelectedValue != "--Select Month--")
        {
            Table4.Visible = true;
            BEL.monthid = Convert.ToInt32(ddlMonth.SelectedValue);
            BEL.applyclassid = Convert.ToInt32(DDLClass.SelectedValue);
            BEL.branchid = Convert.ToInt16(Session["BrBrid"]);
            BEL.pagesize = 20;
            BEL.currentpage = 1;
            BEL.searchbyName = "";
            dt = BLL.bindclasswisefee();
            if (dt.Rows.Count > 0)
            {
                gridreport.DataSource = dt;
                gridreport.DataBind();
                setpage();
            }
            else
            {
                gridreport.EmptyDataText = "No Record Found.!";
                gridreport.DataBind();
            }
            dt.Clear();
        }
        else
        {
            DDLClass.Items.Clear();
            DDL_Class_Bind();
            ddlMonth.SelectedValue = "--Select Month--";
        }
    }

    protected void DDLClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlMonth.Items.Clear();
        bind_month();
        ddlMonth.SelectedValue = "--Select Month--";
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (txtnamesearch.Text != "")
        {
            setpage();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(DDLClass.SelectedValue), Convert.ToInt32(ddlMonth.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Name.");
            return;
        }
    }

    private void fillgrid(int pagesize, int currentpage, int classid, int monthid, string value)
    {
        BEL.monthid = monthid;
        BEL.applyclassid = classid;
        BEL.branchid = Convert.ToInt16(Session["BrBrid"]);
        BEL.pagesize = pagesize;
        BEL.currentpage = currentpage;
        if (txtnamesearch.Text != "")
        {
            BEL.searchbyName = value;
        }
        else
        {
            BEL.searchbyName = "";
        }
        dt = BLL.bindclasswisefee();
        if (dt.Rows.Count > 0)
        {
            Table4.Visible = true;
            gridreport.DataSource = dt;
            gridreport.DataBind();
        }
        else
        {
            gridreport.EmptyDataText = "No Record Found.!";
            gridreport.DataBind();
        }
        dt.Clear();
    }

    protected void ddlRecordperPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlRecordperPage.SelectedValue != "0")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            setpage();
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(DDLClass.SelectedValue), Convert.ToInt32(ddlMonth.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
            return;
        }
    }

    protected void PageNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (PageNo.SelectedIndex > 0)
        {
            ViewState["PageNo"] = PageNo.SelectedItem.Text;
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(DDLClass.SelectedValue), Convert.ToInt32(ddlMonth.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
            return;
        }
    }

    protected void firstpage_Click(object sender, ImageClickEventArgs e)
    {
        ViewState["PageNo"] = 1;
        PageNo.SelectedIndex = 1;
        fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(DDLClass.SelectedValue), Convert.ToInt32(ddlMonth.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
    }

    protected void previous_Click(object sender, ImageClickEventArgs e)
    {
        int currentpage = Convert.ToInt32(ViewState["PageNo"]);
        if (currentpage > 1)
        {
            currentpage = currentpage - 1;
            ViewState["PageNo"] = currentpage;
            PageNo.SelectedIndex = currentpage;
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(DDLClass.SelectedValue), Convert.ToInt32(ddlMonth.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
        }
    }

    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        countnew = CommonClass.scaler("sizeofpage", Convert.ToInt32(Session["BrBrid"]));
        totalpage = countnew / Convert.ToInt32(ViewState["noofrecord"]);
        totalpage = totalpage + 1;
        int currentpage = Convert.ToInt32(ViewState["PageNo"]);
        if (currentpage < totalpage)
        {
            currentpage = currentpage + 1;
            ViewState["PageNo"] = currentpage;
            PageNo.SelectedIndex = currentpage;
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(DDLClass.SelectedValue), Convert.ToInt32(ddlMonth.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
        }
    }

    protected void last_Click(object sender, ImageClickEventArgs e)
    {
        countnew = CommonClass.scaler("sizeofpage", Convert.ToInt32(Session["BrBrid"]));
        totalpage = countnew / Convert.ToInt32(ViewState["noofrecord"]);
        totalpage = totalpage + 1;
        ViewState["PageNo"] = totalpage;
        PageNo.SelectedIndex = totalpage;
        fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(DDLClass.SelectedValue), Convert.ToInt32(ddlMonth.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
    }
}