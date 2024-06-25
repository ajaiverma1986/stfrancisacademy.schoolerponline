using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class adminPanel_VehicleReport : System.Web.UI.Page
{
    private SqlConnection cnn = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
    private DataUtility objDUT = new DataUtility();
    private DataTable dt, dt1, dt2;
    private string PageName = "", url = "";
    private int totalpage = 0;
    private SqlParameter[] param1 = new SqlParameter[5];

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!IsPostBack)
        {
            ViewState["acad"] = CommonClass.Scaler("ActiveAcademicYear");
            bindddl();
            fillgrid(20, 1, 0);
            ViewState["noofrecord"] = 20;
            ViewState["PageNo"] = 1;
            ViewState["sortby"] = "facultyid";
            setpage();
        }
    }

    protected void bindddl()
    {
        string qry = @"select id,registrationno from tbl_vehicleinfo where fyid=" + ViewState["acad"] + "and branchid=" + Session["BrBrid"];
        dt2 = objDUT.GetDataTable(qry);
        if (dt2.Rows.Count > 0)
        {
            ddlEnquirySource.DataSource = dt2;
            ddlEnquirySource.DataValueField = "id";
            ddlEnquirySource.DataTextField = "registrationno";
            ddlEnquirySource.DataBind();
            ListItem li = new ListItem("--Select Reg No--", "0");
            ddlEnquirySource.Items.Insert(0, li);
        }
    }

    protected void gvDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ed")
        {
            int busid = Convert.ToInt32(e.CommandArgument);
            Session["idbus"] = busid;
            string query = "select * from tbl_vehicleinfo where id =" + busid;
            SqlDataReader dr = objDUT.GetDataReader(query);
            dr.Read();
            if (dr.HasRows)
            {
                string busno = dr["BusNo"].ToString();
                Session["BusNo"] = busno;
                string busregno = dr["RegistrationNo"].ToString();
                Session["RegistrationNo"] = busregno;

                string noofseats = dr["noofseats"].ToString();
                Session["noofseats"] = noofseats;

                string chasisno = dr["chesisno"].ToString();
                Session["chesisno"] = chasisno;
                string model = dr["Modelno"].ToString();
                Session["Modelno"] = model;

                string ntd = dr["NextTaxDate"].ToString();
                Session["NextTaxDate"] = ntd;

                string nid = dr["NextInsuranceDate"].ToString();
                Session["NextInsuranceDate"] = nid;

                string ind = dr["insuranceno"].ToString();
                Session["insuranceno"] = ind;

                string icn = dr["insuranceCompanyName"].ToString();
                Session["insuranceCompanyName"] = icn;

                string cp = dr["contactPerson"].ToString();
                Session["contactPerson"] = cp;

                string cn = dr["contactno"].ToString();
                Session["contactno"] = cn;
                Session["busid"] = busid;
                Response.Redirect("AddVehicle.aspx?id=" + Session["busid"]);
            }
            dr.Close();
        }
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        PrepareGridViewForExport(gvDetails);
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

        gvDetails.Parent.Controls.Add(frm);

        frm.Attributes["runat"] = "server";

        frm.Controls.Add(gvDetails);

        frm.RenderControl(htw);

        //GridView1.RenderControl(htw);

        Response.Write(sw.ToString());

        Response.End();
    }

    protected void gvDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        string q1 = (string)ViewState["dt"];
        gvDetails.PageIndex = e.NewPageIndex;

        fillgrid(q1);
    }

    private void fillgrid(string q1)
    {
        dt1 = objDUT.GetDataTable(q1);

        if (dt1.Rows.Count > 0)
        {
            gvDetails.DataSource = dt1;
            gvDetails.DataBind();
            //IBExcel.Visible = true;
        }
        dt1.Dispose();
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        if (ddlEnquirySource.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "please select bus registration no!");
            fillgrid(20, 1, 0);
        }

        string qry1 = @"select id,noofseats,convert(varchar(13),NextFCDate,6) as NextFCDate, modelno,conveyanceid,convert(varchar(13),NextTaxDate,6) as NextTaxDate,convert(varchar(13),NextInsuranceDate,6) as NextInsuranceDate,registrationNo FROM tbl_vehicleinfo where id=" + ddlEnquirySource.SelectedValue + "";

        dt1 = objDUT.GetDataTable(qry1);
        if (dt1.Rows.Count > 0)
        {
            gvDetails.DataSource = dt1;
            gvDetails.DataBind();
            //IBExcel.Visible = false;
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "No Record Found!");

            return;
        }
    }

    protected void ddlRecordperPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlRecordperPage.SelectedValue != "0")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            if (ddlEnquirySource.SelectedIndex == 0)
            {
                setpage();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0);
            }
            else if (ddlEnquirySource.SelectedIndex > 0)
            {
                setpage1();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue));
            }
        }
        else
        {
            //Textbox1.Text = string.Empty;
            ddlEnquirySource.SelectedIndex = 0;
            ViewState["noofrecord"] = 20;
            ViewState["PageNo"] = 1;
            setpage();
            fillgrid(20, 1, 0);
        }
    }

    private void setpage1()
    {
        string query = "select count(*) from tbl_vehicleinfo where fyid=" + ViewState["acad"] + " and branchid=" + Session["BrBrid"] + " and id=" + ddlEnquirySource.SelectedValue;
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

    protected void PageNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (PageNo.SelectedIndex > 0)
        {
            ViewState["PageNo"] = PageNo.SelectedItem.Text;
            if (ddlEnquirySource.SelectedIndex == 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0);
            }
            else if (ddlEnquirySource.SelectedIndex > 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue));
            }
        }
        else
        {
            ddlEnquirySource.SelectedIndex = 0;
            setpage();
            fillgrid(20, 1, 0);
        }
    }

    private void setpage()
    {
        string query = "select count(*) from tbl_vehicleinfo where fyid=" + ViewState["acad"] + " and branchid=" + Session["BrBrid"];
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

    private void fillgrid(int pagesize, int currentpage, int eid)
    {
        param1[0] = new SqlParameter("@PageSize", pagesize);
        param1[1] = new SqlParameter("@CurrentPage", currentpage);
        param1[2] = new SqlParameter("@userid", eid);

        param1[3] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
        param1[4] = new SqlParameter("@fyid", ViewState["acad"]);
        DataTable dt = objDUT.GetDataTableSP(param1, "usp_rootlistsearch");
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
            if (ddlEnquirySource.SelectedIndex == 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0);
            }
            else if (ddlEnquirySource.SelectedValue != "0")
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue));
            }
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
            string query = "";
            if (ddlEnquirySource.SelectedIndex == 0)
            {
                query = "select count(*) from tbl_vehicleinfo where fyid=" + ViewState["acad"] + " and branchid=" + Session["BrBrid"];
            }
            else if (ddlEnquirySource.SelectedIndex > 0)
            {
                query = "select count(*) from tbl_vehicleinfo where fyid=" + ViewState["acad"] + " and branchid=" + Session["BrBrid"] + " and id=" + ddlEnquirySource.SelectedValue + "";
            }

            totalpage = Convert.ToInt32(objDUT.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
            if (Convert.ToInt32(objDUT.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
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

            if (ddlEnquirySource.SelectedIndex == 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0);
            }
            else if (ddlEnquirySource.SelectedIndex > 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue));
            }
            //else if (ddlUser.SelectedIndex > 0 && !string.IsNullOrEmpty(txtToDate.Text))
            //{
            //    fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlUser.SelectedValue), Convert.ToDateTime(txtToDate.Text.Trim()));
            //}
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
            string query = "";
            if (ddlEnquirySource.SelectedIndex == 0)
            {
                query = "select count(*) from tbl_vehicleinfo where fyid=" + ViewState["acad"] + " and branchid=" + Session["BrBrid"];
            }
            else if (ddlEnquirySource.SelectedIndex > 0)
            {
                query = "select count(*) from tbl_vehicleinfo where fyid=" + ViewState["acad"] + " and branchid=" + Session["BrBrid"] + " and  id=" + ddlEnquirySource.SelectedValue + "";
            }
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
                if (PageNo.Items.Count >= currentpage)
                {
                    PageNo.SelectedIndex = currentpage;
                }
                //PageNo.SelectedIndex = currentpage;
                if (ddlEnquirySource.SelectedIndex == 0)
                {
                    fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0);
                }
                else if (ddlEnquirySource.SelectedIndex > 0)
                {
                    fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue));
                }
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
                if (ddlEnquirySource.SelectedIndex == 0)
                {
                    fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0);
                }
                else if (ddlEnquirySource.SelectedIndex > 0)
                {
                    fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue));
                }
            }
        }
    }

    protected void btnreset_Click(object sender, EventArgs e)
    {
        fillgrid(20, 1, 0);
        setpage();
        bindddl();
    }

    protected void gvDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        int a = 0, b = 0;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblnoofseat = (Label)e.Row.FindControl("lblnoofseats");
            Label lblbusno = (Label)e.Row.FindControl("lblregistrationno");
            Label lblavailable = (Label)e.Row.FindControl("lblavailable");

            int count2 = Convert.ToInt32(objDUT.GetScalar("select COUNT(busno) from tbl_addbusforstudent where busno='" + lblbusno.Text + "'and trstatus=1"));

            b = Convert.ToInt32(count2);
            a = Convert.ToInt32(lblnoofseat.Text);
            lblavailable.Text = (a - b).ToString();
        }
    }
}