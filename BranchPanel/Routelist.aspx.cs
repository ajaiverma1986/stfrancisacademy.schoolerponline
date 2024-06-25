using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class BranchPanel_Routelist : System.Web.UI.Page
{
    private int i = 0;
    private int totalpage = 0;
    private string PageName;
    private CommonClass CommonClass = new CommonClass();
    private DataUtility objdut = new DataUtility();
    private Utility objut = new Utility();
    private SqlParameter[] param;
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
    private SqlCommand cmd = new SqlCommand();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //bindgrid();
            fillddl();
            ViewState["noofrecord"] = 20;
            ViewState["PageNo"] = 1;
            setpage();
            bindgridd(20, 1, 0);
            //ViewState["sortby"] = "Rid";
        }
    }

    protected void fillddl()
    {
        DataTable dt;
        string qry = "select Rid,Routeno from tbl_route where status=1";
        dt = objdut.GetDataTable(qry);
        ddlEnquirySource.DataSource = dt;
        ddlEnquirySource.DataValueField = "rid";
        ddlEnquirySource.DataTextField = "routeno";
        ddlEnquirySource.DataBind();
        ListItem li = new ListItem("--Select Route No--", "0");
        ddlEnquirySource.Items.Insert(0, li);
    }

    public void bindgridd(int pagesize, int currentpage, int usid)
    {
        SqlParameter[] param3 = new SqlParameter[4];
        param3[0] = new SqlParameter("@PageSize", pagesize);
        param3[1] = new SqlParameter("@CurrentPage", currentpage);
        param3[2] = new SqlParameter("@SortExpression", usid);
        param3[3] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));

        DataTable dt = objdut.GetDataTableSP(param3, "[usp_routesearch]");
        if (dt.Rows.Count > 0)
        {
            Gridview1.DataSource = dt;
            Gridview1.DataBind();
        }
        else
        {
            // Utility.ViewAlertMessage(this.Master.Page, "No record Found!");
            Gridview1.EmptyDataText = "No Record Found";
            Gridview1.DataSource = null;
            Gridview1.DataBind();
            dt.Dispose();
        }
    }

    private void setpage()
    {
        string query = "select Count(*) from tbl_route ";
        int i = 0;
        PageNo.Items.Clear();
        PageNo.Items.Insert(i, Convert.ToString("Page No"));
        totalpage = Convert.ToInt32(objdut.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(objdut.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
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

    protected void Gridview1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "View")
        {
            int regid1 = Convert.ToInt32(e.CommandArgument);
            ViewState["ridnew"] = regid1;
            Response.Redirect("tran.aspx?Rid=" + regid1);
        }
    }

    protected void Gridview1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
    }

    private void bindgrid(string query)
    {
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        PrepareGridViewForExport(Gridview1);
        ExportGridView();
    }

    private void PrepareGridViewForExport(Control gv)
    {
        Label lb = new Label();

        Literal l = new Literal();

        string name = String.Empty;

        for (int i = 0; i < gv.Controls.Count; i++)
        {
            if (gv.Controls[i].GetType() == typeof(Label))
            {
                l.Text = (gv.Controls[i] as Label).Text;

                gv.Controls.Remove(gv.Controls[i]);

                gv.Controls.AddAt(i, l);
            }

            if (gv.Controls[i].HasControls())
            {
                PrepareGridViewForExport(gv.Controls[i]);
            }
        }
    }

    private void ExportGridView()
    {
        string attachment = "attachment; filename=Member_List.xls";

        Response.ClearContent();

        Response.AddHeader("content-disposition", attachment);

        Response.ContentType = "application/ms-excel";

        StringWriter sw = new StringWriter();

        HtmlTextWriter htw = new HtmlTextWriter(sw);

        // Create a form to contain the grid

        HtmlForm frm = new HtmlForm();

        Gridview1.Parent.Controls.Add(frm);

        frm.Attributes["runat"] = "server";

        frm.Controls.Add(Gridview1);

        frm.RenderControl(htw);

        //GridView1.RenderControl(htw);

        Response.Write(sw.ToString());

        Response.End();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (ddlEnquirySource.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "please select route no.!!");
        }
        DataTable dt1;

        string qry1 = @"select distinct Rid, tbl_route.RouteNo, Origin, Destination,Distance , ROW_NUMBER()
OVER (ORDER BY Rid asc ) AS RowNumber ,  count(studentAdmissionnNo) as noofstudent
from tbl_route   left outer join tbl_addbusforstudent str1 on
   trstatus=1 and str1.Routeno=tbl_route.Routeno and str1.branchid=tbl_route.branchid where tbl_route.branchid=" + Convert.ToInt32(Session["BrBrid"]) + " and status=1 and tbl_route.Routeno='" + ddlEnquirySource.SelectedItem.Text + "'group by Rid, tbl_route.RouteNo, Origin, Destination,Distance";

        dt1 = objdut.GetDataTable(qry1);
        if (dt1.Rows.Count > 0)
        {
            Gridview1.DataSource = dt1;
            Gridview1.DataBind();
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "No record Found");
            return;
        }
    }

    protected void PageNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (PageNo.SelectedIndex > 0)
        {
            ViewState["PageNo"] = PageNo.SelectedItem.Text;
            bindgridd(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue));
        }
    }

    protected void last_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlEnquirySource.SelectedIndex > 0)
        {
            return;
        }
        else
        {
            string query = "select Count(*) from tbl_route";
            totalpage = Convert.ToInt32(objdut.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
            if (Convert.ToInt32(objdut.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
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

            bindgridd(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue));
        }
    }

    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlEnquirySource.SelectedIndex > 0)
        {
            return;
        }
        else
        {
            string query = "select Count(*) from tbl_route";
            totalpage = Convert.ToInt32(objdut.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
            if (Convert.ToInt32(objdut.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
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
                bindgridd(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue));
            }
        }
    }

    protected void previous_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlEnquirySource.SelectedIndex > 0)
        {
            return;
        }
        else
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
                bindgridd(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue));
            }
        }
    }

    protected void firstpage_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlEnquirySource.SelectedIndex > 0)
        {
            return;
        }
        else
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
            bindgridd(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue));
        }
    }

    protected void ddlRecordperPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlRecordperPage.SelectedValue != "0")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            setpage();
            bindgridd(Convert.ToInt32(ddlRecordperPage.SelectedItem.Text), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue));
        }
    }

    protected void btnreset_Click(object sender, EventArgs e)
    {
        setpage();
        bindgridd(20, 1, 0);
        fillddl();
    }
}