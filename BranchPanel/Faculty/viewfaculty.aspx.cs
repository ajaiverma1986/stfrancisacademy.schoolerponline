using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_viewfaculty : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private SqlParameter[] param1 = new SqlParameter[5];
    private string type, query1, query2, query3, query4, query5, query6, query;
    private DataTable dt;
    private int totalpage = 0;
    private Utility objUT = new Utility();
    private string PageName = "", url = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        url = Request.Url.ToString();
        //if (Session["id"] == null)
        //{
        //    Response.Redirect("CreateAppoinmentLetter.aspx");
        //}
        //PageName = Utility.GetCurrentPagename();
        if (!IsPostBack)
        {
            Session["facID"] = null;
            // fillgrid();
            fillgrid(20, 1, 0, "");
            ViewState["noofrecord"] = 20;
            ViewState["PageNo"] = 1;
            ViewState["sortby"] = "facultyid";
            setpage();
            // TextBox1.Enabled = false;
        }
    }

    //private void fillgrid()
    //{
    //    string str = "select (case photo when '' then '~/images/9update.png' else ('~/facultyimage/'+photo) end ) as photo,eid,UPPER((fname+' '+ISNULL(MName,'')+' '+lname))as name,mobile from tblEmp_Master where desigtype=2 and status=1 and brid=" + Session["BrBrid"] + " order by eid";
    //    dt = objdut.GetDataTable(str);

    //    if (dt.Rows.Count > 0)
    //    {
    //        gvDetails.DataSource = dt;
    //        gvDetails.DataBind();
    //    }
    //    else
    //    {
    //        gvDetails.DataSource = null;
    //        gvDetails.DataBind();
    //        gvDetails.EmptyDataText = "No Record.!";
    //    }
    //}

    protected void gvDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int facid = Convert.ToInt16(e.CommandArgument);
        Session["facID"] = Convert.ToInt16(e.CommandArgument);
        if (e.CommandName == "ed1")
        {
            Response.Redirect("UpdateProfile1.aspx");
        }
        else if (e.CommandName == "ed2")
        {
            Response.Redirect("viewschedule.aspx?facultyID=" + facid);
        }
        else if (e.CommandName == "editsubjects")
        {
            Response.Redirect("facultySubject.aspx");
        }
        else if (e.CommandName == "ed3")
        {
            Response.Redirect("add-salaryto-faculty.aspx");
        }
    }

    protected void gvDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "FacultyList.xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        gvDetails.AllowPaging = false;
        //Change the Header Row back to white color
        gvDetails.HeaderRow.Style.Add("background-color", "#FFFFFF");
        //Applying stlye to gridview header cells
        for (int i = 0; i < gvDetails.HeaderRow.Cells.Count; i++)
        {
            gvDetails.HeaderRow.Cells[i].Style.Add("background-color", "#49c0f0");
        }
        int j = 1;
        //This loop is used to apply stlye to cells based on particular row
        foreach (GridViewRow gvrow in gvDetails.Rows)
        {
            gvrow.BackColor = System.Drawing.Color.White;
            if (j <= gvDetails.Rows.Count)
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
        gvDetails.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }

    protected void TextBox1_TextChanged(object sender, EventArgs e)
    {
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (ddlsearchoption.SelectedIndex == 1)
        {
            if (Textbox1.Text == "")
            {
                Utility.ViewAlertMessage(this.Master.Page, "please enter name");
            }
            string q = @"select eid,mobile,(fname+' '+ISNULL(MName,'')+' '+lname) as name,(case photo when '' then '~/images/9update.png' else ('~/facultyimage/'+photo) end ) as photo
                        from tblEmp_Master where fname like '" + Textbox1.Text.Trim() + "' and  status=1 and brid=" + Convert.ToInt16(Session["BrBrid"]) + " order by eid";
            DataTable dtn = objdut.GetDataTable(q);
            if (dtn.Rows.Count > 0)
            {
                gvDetails.DataSource = dtn;
                gvDetails.DataBind();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No record found!");
                gvDetails.DataSource = null;
                gvDetails.DataBind();
            }
        }
        else if (ddlsearchoption.SelectedIndex == 2)
        {
            if (Textbox1.Text == "")
            {
                Utility.ViewAlertMessage(this.Master.Page, "please enter mobile no");
            }
            string q = @"Select eid,mobile,(fname+' '+ISNULL(MName,'')+' '+lname) as name,mobile,(case photo when '' then '~/images/9update.png' else ('~/facultyimage/'+photo) end ) as photo
                        from tblEmp_Master  where   mobile like '" + Textbox1.Text.Trim() + "' and brid=" + Convert.ToInt16(Session["BrBrid"]) + " order by eid";
            DataTable dtp = objdut.GetDataTable(q);
            if (dtp.Rows.Count > 0)
            {
                gvDetails.DataSource = dtp;
                gvDetails.DataBind();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No record found!");
                gvDetails.DataSource = null;
                gvDetails.DataBind();
            }
        }
        else if (ddlsearchoption.SelectedIndex == 0)
        {
            fillgrid(20, 1, 0, "");
            Utility.ViewAlertMessage(this.Master.Page, "No record found!");
        }
    }

    protected void ddlsearchoption_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlsearchoption.SelectedIndex == 1 || ddlsearchoption.SelectedIndex == 2)
        {
            Textbox1.Focus();
        }
    }

    protected void PageNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (PageNo.SelectedIndex > 0)
        {
            ViewState["PageNo"] = PageNo.SelectedItem.Text;
            if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, "");
            }
            else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
            }
            else if (ddlsearchoption.SelectedIndex == 2 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, Textbox1.Text.Trim());
            }
            //else if (ddlsearchoption.SelectedIndex > 0 && !string.IsNullOrEmpty(Textbox1.Text))
            //{
            //    fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlUser.SelectedValue), Convert.ToDateTime(txtToDate.Text.Trim()));
            //}
        }
        else
        {
            Textbox1.Text = string.Empty;
            ddlsearchoption.SelectedIndex = 0;
            setpage();
            fillgrid(20, 1, 0, "");
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
        if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, "");
        }
        else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim().ToString());
        }
        else if (ddlsearchoption.SelectedIndex == 2 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim().ToString());
        }
    }

    protected void ddlRecordperPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlRecordperPage.SelectedValue != "0")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
            {
                setpage();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, "");
            }
            else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                setpage1();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
            }
            else if (ddlsearchoption.SelectedIndex == 2 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                setpage2();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
            }
        }
        else
        {
            Textbox1.Text = string.Empty;
            ddlsearchoption.SelectedIndex = 0;
            ViewState["noofrecord"] = 20;
            ViewState["PageNo"] = 1;
            setpage();
            fillgrid(20, 1, 0, "");
        }
    }

    private void setpage1()
    {
        string query = "select count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"] + " and eid=" + ddlsearchoption.SelectedValue + " and fname like '" + Textbox1.Text.Trim() + "'";
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

    private void setpage2()
    {
        string query = "select count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"] + " and eid=" + ddlsearchoption.SelectedValue + " and mobile like '" + Textbox1.Text.Trim() + "'";
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

    private void setpage()
    {
        string query = "select count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"];
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

    private void fillgrid(int pagesize, int currentpage, int eid, string activitydate)
    {
        param1[0] = new SqlParameter("@PageSize", pagesize);
        param1[1] = new SqlParameter("@CurrentPage", currentpage);
        param1[2] = new SqlParameter("@userid", eid);
        param1[3] = new SqlParameter("@activitydate", activitydate);
        param1[4] = new SqlParameter("@id", Convert.ToInt32(Session["BrBrid"]));
        DataTable dt = objdut.GetDataTableSP(param1, "usp_employeesearch");
        if (dt.Rows.Count > 0)
        {
            gvDetails.DataSource = dt;
            gvDetails.DataBind();
        }
        else
        {
            // Utility.ViewAlertMessage(this.Master.Page, "No record Found!");
            gvDetails.EmptyDataText = "No Record Found";
            gvDetails.DataSource = null;
            gvDetails.DataBind();
        }
        dt.Dispose();
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
            if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, "");
            }
            else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
            }
            else if (ddlsearchoption.SelectedIndex == 2 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
            }
        }
    }

    protected void last_Click(object sender, ImageClickEventArgs e)
    {
        string query = "";
        if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
        {
            query = "select Count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"];
        }
        else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            query = "select count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"] + " and eid=" + ddlsearchoption.SelectedValue + " and fname like '" + Textbox1.Text.Trim() + "'";
        }
        else if (ddlsearchoption.SelectedIndex == 0 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            query = "select count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"] + " and eid=" + ddlsearchoption.SelectedValue + " and mobile like '" + Textbox1.Text.Trim() + "'";
        }
        //else if (ddlUser.SelectedIndex > 0 && !string.IsNullOrEmpty(txtToDate.Text))
        //{
        //    query = "select count(*) from ActivityLog where convert(date,activitydate)=cast('" + txtToDate.Text + "' as datetime) and userid=" + ddlUser.SelectedValue + "";
        //}
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

        if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, "");
        }
        else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
        }
        else if (ddlsearchoption.SelectedIndex == 2 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
        }
        //else if (ddlUser.SelectedIndex > 0 && !string.IsNullOrEmpty(txtToDate.Text))
        //{
        //    fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlUser.SelectedValue), Convert.ToDateTime(txtToDate.Text.Trim()));
        //}
    }

    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        string query = "";
        if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
        {
            query = "select Count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"];
        }
        else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            query = "select count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"] + " and eid=" + ddlsearchoption.SelectedValue + " and fname like '" + Textbox1.Text.Trim() + "'";
        }
        else if (ddlsearchoption.SelectedIndex == 2 && !string.IsNullOrEmpty(Textbox1.Text))
        {
            query = "select count(*) from tblEmp_Master where status=1 and brid=" + Session["BrBrid"] + " and eid=" + ddlsearchoption.SelectedValue + " and mobile like '" + Textbox1.Text.Trim() + "'";
        }

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
            if (ddlsearchoption.SelectedIndex == 0 && string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, "");
            }
            else if (ddlsearchoption.SelectedIndex == 1 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
            }
            else if (ddlsearchoption.SelectedIndex == 2 && !string.IsNullOrEmpty(Textbox1.Text))
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Textbox1.Text.Trim());
            }
            //else if (ddlUser.SelectedIndex > 0 && !string.IsNullOrEmpty(txtToDate.Text))
            //{
            //    fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlUser.SelectedValue), Convert.ToDateTime(txtToDate.Text.Trim()));
            //}
        }
    }
}