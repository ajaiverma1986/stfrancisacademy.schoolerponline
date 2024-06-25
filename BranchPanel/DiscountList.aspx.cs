using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_DiscountList : System.Web.UI.Page
{
    private Utility objUT = new Utility();
    private DataUtility objDUT = new DataUtility();
    private string url = "", query;
    private DataTable dt;
    private int fyid = 0, totalpage = 0;
    private SqlParameter[] param3 = new SqlParameter[4];

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["User"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!objUT.isAccessible(((User)Session["User"]).UserID, "MOverDueList1.aspx"))
        {
            Response.Redirect("~/Login.aspx");
        }
        if (!IsPostBack)
        {
            fyid = Convert.ToInt32(objDUT.GetScalar("select fyid from financial_Year where isActive=1 and isClosed=0"));
            ViewState["fyid"] = fyid;
            // fillGrid();
            fillddl();
            ViewState["noofrecord"] = 20;
            ViewState["PageNo"] = 1;
            ViewState["sortby"] = "name";
            setpage();
            fillgrid(20, 1, "name", 0);
            fillgrd2();
        }
    }

    private void fillgrd2()
    {
        string q1 = @"select (bm.brcode+' '+bm.brname) as name1, (sm.FName+' '+sm.LName) as name,scm.coursename,scm.TotalAmount,scm.Discountamount,

(case scm.discounttype when 1 then 'Flat' when 2 then 'Percentage' end ) AS discounttype,(scm.TotalAmount-scm.Discountamount) as payable from

    studentCourse_master scm  join student_master sm on scm.sturegno=sm.StuRegNo inner join  branch_master bm  on

    bm.brid=sm.brid where  sm.status=1 and scm.Discounttype!=0 and scm.fyid=" + ViewState["fyid"];
        dt = objDUT.GetDataTable(q1);
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
        }
    }

    private void fillgrid(int pagesize, int currentpage, string sortby, int cid)
    {
        param3[0] = new SqlParameter("@PageSize", pagesize);
        param3[1] = new SqlParameter("@CurrentPage", currentpage);
        param3[2] = new SqlParameter("@SortExpression", sortby);
        param3[3] = new SqlParameter("@brid", cid);

        dt = objDUT.GetDataTableSP(param3, "discounlist");
        if (dt.Rows.Count > 0)
        {
            gvdetails.DataSource = dt;
            gvdetails.DataBind();
            IBExcel.Enabled = true;
        }
        else
        {
            gvdetails.EmptyDataText = "No Record Found..!!";
            gvdetails.DataSource = null;
            gvdetails.DataBind();
            IBExcel.Enabled = false;
            IBExcel.ToolTip = "No data to export to excel.";
            return;
        }
    }

    private void setpage()
    {
        query = "select Count(*)  from studentCourse_master where Discounttype>0 and status=1 and fyid=" + ViewState["fyid"];
        int i = 0;
        PageNo.Items.Clear();
        PageNo.Items.Insert(i, Convert.ToString("Page No"));
        totalpage = Convert.ToInt32(objDUT.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(objDUT.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
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

    private void setpage1()
    {
        query = @"select count(*) from studentCourse_master scm inner join student_master sm on sm.sturegno=scm.sturegno
                 where Discounttype>0 and scm.status=1 and scm.fyid=" + Convert.ToInt32(ViewState["fyid"]) + " and sm.brid=" + ddlsearch.SelectedValue + " and sm.status=1";
        int i = 0;
        PageNo.Items.Clear();
        PageNo.Items.Insert(i, Convert.ToString("Page No"));
        totalpage = Convert.ToInt32(objDUT.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(objDUT.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
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

    private void fillddl()
    {
        string str = "select BrId,(BrCode+' '+BrName) as name from Branch_master where roleid=3 and BrActive=1 and isDeleted=0 and isActive=1";
        DataTable dtl = objDUT.GetDataTable(str);
        if (dtl.Rows.Count > 0)
        {
            ddlsearch.DataSource = dtl;
            ddlsearch.DataValueField = "BrId";
            ddlsearch.DataTextField = "name";
            ddlsearch.DataBind();
            ddlsearch.Items.Insert(0, new ListItem("--Select Branch--", "0"));
        }
    }

    //    protected void fillGrid()
    //    {
    //        dt = objDUT.GetDataTable(@"select (bm.brcode+' '+bm.brname) as name1, (sm.FName+' '+sm.LName) as name,scm.coursename,scm.TotalAmount,scm.Discountamount,
    //(case scm.discounttype when 1 then 'Flat' when 2 then 'Percentage' end ) AS discounttype,(scm.TotalAmount-scm.Discountamount) as payable from
    //
    //    studentCourse_master scm  join student_master sm on scm.sturegno=sm.StuRegNo inner join  branch_master bm  on
    //    bm.brid=sm.brid where  sm.status=1 and scm.Discounttype!=0 and scm.fyid=1");
    //        if (dt.Rows.Count > 0)
    //        {
    //            gvdetails.DataSource = dt;
    //            ViewState["dt"] = dt;
    //            gvdetails.DataBind();
    //            IBExcel.Enabled = true;
    //        }
    //        else
    //        {
    //            gvdetails.EmptyDataText = "No record found!!";
    //            gvdetails.DataSource = null;
    //            gvdetails.DataBind();
    //            IBExcel.Enabled = false;
    //            IBExcel.ToolTip = "No data to export to excel.";
    //        }
    //    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        Response.Redirect("MOverDueList1.aspx");
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
        Response.Redirect("ChequeList.aspx");
    }

    protected void btn3_Click(object sender, EventArgs e)
    {
        Response.Redirect("DiscountList.aspx");
    }

    protected void btn4_Click(object sender, EventArgs e)
    {
        Response.Redirect("DayCollection.aspx");
    }

    protected void btnOvr_Click(object sender, EventArgs e)
    {
        Response.Redirect("OverallAdmissions.aspx");
    }

    protected void btnRange_Click(object sender, EventArgs e)
    {
        Response.Redirect("RangeCollection.aspx");
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        //if (gvdetails.DataSource == null)
        //{
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('No data found.')", true);
        //    return;
        //}
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "OverDueFee.xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        GridView1.AllowPaging = false;

        //Change the Header Row back to white color
        GridView1.HeaderRow.Style.Add("background-color", "#FFFFFF");
        //Applying stlye to gridview header cells

        if (ddlsearch.SelectedIndex > 0)
        {
            fillgrid1();

            for (int i = 0; i < GridView1.HeaderRow.Cells.Count; i++)
            {
                GridView1.HeaderRow.Cells[i].Style.Add("background-color", "#49c0f0");
            }
            int j1 = 1;
            //This loop is used to apply stlye to cells based on particular row
            foreach (GridViewRow gvrow in GridView1.Rows)
            {
                gvrow.BackColor = System.Drawing.Color.White;
                if (j1 <= GridView1.Rows.Count)
                {
                    if (j1 % 2 != 0)
                    {
                        for (int k = 0; k < gvrow.Cells.Count; k++)
                        {
                            gvrow.Cells[k].Style.Add("background-color", "#EFF3FB");
                        }
                    }
                }
                j1++;
            }
            GridView1.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();
            return;
        }

        for (int i = 0; i < GridView1.HeaderRow.Cells.Count; i++)
        {
            GridView1.HeaderRow.Cells[i].Style.Add("background-color", "#49c0f0");
        }
        int j = 1;
        //This loop is used to apply stlye to cells based on particular row
        foreach (GridViewRow gvrow in GridView1.Rows)
        {
            gvrow.BackColor = System.Drawing.Color.White;
            if (j <= GridView1.Rows.Count)
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
        GridView1.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }

    private void fillgrid1()
    {
        string q1 = @"select (bm.brcode+' '+bm.brname) as name1, (sm.FName+' '+sm.LName) as name,scm.coursename,scm.TotalAmount,scm.Discountamount,

      (case scm.discounttype when 1 then 'Flat' when 2 then 'Percentage' end ) AS discounttype,(scm.TotalAmount-scm.Discountamount) as payable from

         studentCourse_master scm  join student_master sm on scm.sturegno=sm.StuRegNo inner join  branch_master bm  on

    bm.brid=sm.brid where  sm.status=1 and scm.Discounttype!=0 and scm.fyid=" + ViewState["fyid"] + " and sm.brid=" + ddlsearch.SelectedValue;

        dt = objDUT.GetDataTable(q1);
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        if (ddlsearch.SelectedIndex > 0)
        {
            setpage1();
        }
        else
        {
            setpage();
        }

        fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearch.SelectedValue));
    }

    protected void ddlRecordperPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlRecordperPage.SelectedValue != "0")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            setpage();
            fillgrid(Convert.ToInt32(ddlRecordperPage.SelectedItem.Text), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearch.SelectedValue));
        }
    }

    protected void PageNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (PageNo.SelectedIndex > 0)
        {
            ViewState["PageNo"] = PageNo.SelectedItem.Text;
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearch.SelectedValue));
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
        fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearch.SelectedValue));
    }

    protected void previous_Click(object sender, ImageClickEventArgs e)
    {
        int currentpage = Convert.ToInt32(ViewState["PageNo"]);
        if (currentpage > 1)
        {
            currentpage = currentpage - 1;
            ViewState["PageNo"] = currentpage;
            PageNo.SelectedIndex = currentpage;
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearch.SelectedValue));
        }
    }

    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        query = "select Count(*)  from studentCourse_master where Discounttype>0 and status=1 and fyid=" + ViewState["fyid"];
        totalpage = Convert.ToInt32(objDUT.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(objDUT.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
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
            PageNo.SelectedIndex = currentpage;
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearch.SelectedValue));
        }
    }

    protected void last_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlsearch.SelectedIndex > 0)
        {
            setpage1();
        }
        else
        {
            setpage();
        }

        fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearch.SelectedValue));
    }
}