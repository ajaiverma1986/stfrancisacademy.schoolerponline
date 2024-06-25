using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_feetypereport : System.Web.UI.Page
{
    private string url, PageName;
    private DataUtility objdut = new DataUtility();
    private DataTable dt, dt1;
    private static int totalpage = 0, countnew;
    private CommonClass CommmonOBJ = new CommonClass();
    private SqlParameter[] param;

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
            bindclass();
            ViewState["noofrecord"] = 20;
            ViewState["PageNo"] = 1;
            setpage();
            fillgrid(20, 1, 0, 0, "");
        }
    }

    private void bindclass()
    {
        dt = CommmonOBJ.Dll("ClassInBranch", Convert.ToInt32(Session["BrBrid"])); //objDUT.GetDataTable(query);
        ddlEnquirySource.DataSource = dt;
        ddlEnquirySource.DataBind();
        ddlEnquirySource.DataTextField = "Classname";
        ddlEnquirySource.DataValueField = "classid";
        ddlEnquirySource.DataBind();
        ddlEnquirySource.Items.Insert(0, "--Select Class--");
    }

    private void setpage()
    {
        SqlParameter[] param = new SqlParameter[5];
        string param1 = "usp_setpagesize";
        param[0] = new SqlParameter("@qtype", Convert.ToInt16(ddlsearch.SelectedIndex));
        if (ddlEnquirySource.SelectedIndex != 0)
        {
            param[1] = new SqlParameter("@classid", Convert.ToInt16(ddlEnquirySource.SelectedValue));
        }
        else
        {
            param[1] = new SqlParameter("@classid", Convert.ToInt16(0));
        }
        param[2] = new SqlParameter("@stname", Convert.ToString(txtnamesearch.Text.Trim()));
        param[3] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));
        param[4] = new SqlParameter("@intresult", Convert.ToInt16(0));
        param[4].Direction = ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, param1);
        countnew = result;
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

    public void fillgrid(int pagesize, int currentpage, int classid, int ftype, string value)
    {
        if (ddlsearch.SelectedIndex == 0)
        {
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@classid", classid);
            param[1] = new SqlParameter("@brid ", Convert.ToInt16(Session["BrBrid"]));
            param[2] = new SqlParameter("@ftype", ftype);
            param[3] = new SqlParameter("@PageSize", pagesize);
            param[4] = new SqlParameter("@CurrentPage", currentpage);
            param[5] = new SqlParameter("@studname", value);

            DataTable dt = objdut.GetDataTableSP(param, "usp_feetypegrid");

            if (dt.Rows.Count > 0)
            {
                gridAnnualFee.DataSource = dt;
                gridAnnualFee.DataBind();
            }
            else
            {
                gridAnnualFee.EmptyDataText = "No Record Found.!";
                gridAnnualFee.DataBind();
            }
        }
        else
        {
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@classid", classid);
            param[1] = new SqlParameter("@brid ", Convert.ToInt16(Session["BrBrid"]));
            param[2] = new SqlParameter("@ftype", ftype);
            param[3] = new SqlParameter("@PageSize", pagesize);
            param[4] = new SqlParameter("@CurrentPage", currentpage);
            param[5] = new SqlParameter("@studname", value);

            DataTable dt = objdut.GetDataTableSP(param, "usp_feetypegrid");

            if (dt.Rows.Count > 0)
            {
                gridAnnualFee.DataSource = dt;
                gridAnnualFee.DataBind();
            }
            else
            {
                gridAnnualFee.EmptyDataText = "No Record Found.!";
                gridAnnualFee.DataBind();
            }
        }
    }

    protected void ddlsearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlsearch.SelectedIndex > 0)
        {
            if (ddlEnquirySource.SelectedIndex == 0)
            {
                setpage();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
            }
            else
            {
                setpage();
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
            }
        }
    }

    protected void gridAnnualFee_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField studentid = (HiddenField)e.Row.FindControl("hd45");
            Label adno = (Label)e.Row.FindControl("lbldate");
            Label dueamount = (Label)e.Row.FindControl("lbldues");
            Label due = (Label)e.Row.FindControl("lbldues23");
            //   LinkButton paidamount = (LinkButton)e.Row.FindControl("lblamnt");
            Label lbltype = (Label)e.Row.FindControl("lblamnt23");

            int paytype = Convert.ToInt32(objdut.GetScalar("select isnull(payType,0) from tbl_Admission where status=1 and fyid=" + ViewState["acad"] + " and adid=" + studentid.Value + " and brid=" + Session["BrBrid"]));

            int check = Convert.ToInt32(objdut.GetScalar("select isnull(transportaion,0) from tbl_admission where adid=" + studentid.Value + " and fyid=" + ViewState["acad"] + " and brid=" + Session["BrBrid"] + ""));
            double pamt = Convert.ToDouble(objdut.GetScalar("select ISNULL(sum(payfee),0) from Payfee_master where Studentid=" + studentid.Value + " and brid=" + Session["BrBrid"] + " and fyid=" + ViewState["acad"]));
            if (check == 0)
            {
                string ss = Convert.ToString(objdut.GetScalar("select ISNULL(sum(credit),0) from tbl_Admission_student_Account where studentid=" + studentid.Value + " and transtype!='" + "Monthly-Transport Fee" + "'and academicyearid=" + ViewState["acad"] + "and brid=" + Session["BrBrid"] + ""));
                double d = Convert.ToDouble(ss) - Convert.ToDouble(pamt);
                due.Text = Convert.ToString(d);
                e.Row.Cells[5].ForeColor = System.Drawing.Color.Green;

                if (d == 0)
                {
                    due.Text = "No Dues";
                }
            }
            else if (check == 1)
            {
                string ss = Convert.ToString(objdut.GetScalar("select ISNULL(sum(credit),0) from tbl_Admission_student_Account where studentid=" + studentid.Value + " and academicyearid=" + ViewState["acad"] + "and brid=" + Session["BrBrid"] + ""));
                double d = Convert.ToDouble(ss) - Convert.ToDouble(pamt);
                due.Text = Convert.ToString(d);
                e.Row.Cells[5].ForeColor = System.Drawing.Color.Green;

                if (d == 0)
                {
                    due.Text = "No Dues";
                }
            }

            int srt1 = Convert.ToInt32(objdut.GetScalar("select top(1) paymonths from tbl_payfee where studentid=" + studentid.Value + " and fyid=" + ViewState["acad"] + " and brid=" + Session["BrBrid"] + " order by pid desc"));
            string srt2 = Convert.ToString(objdut.GetScalar("select distinct paydate from tbl_Admission_student_Account where paymonth=" + srt1 + " and studentid=" + studentid.Value + "and academicyearid=" + ViewState["acad"] + "and brid=" + Session["BrBrid"] + ""));
            string month;
            DateTime now = DateTime.Now;
            if (lbltype.Text == "Monthly")
            {
                if (srt2 == "")
                {
                    dueamount.Text = "No fee collection since admission time!!";
                    dueamount.ForeColor = Color.Red;

                    e.Row.BackColor = Color.LightCyan;
                }
                else
                {
                    now = Convert.ToDateTime(srt2);
                    month = Convert.ToString(now.AddMonths(1));
                    dueamount.Text = month;
                    dueamount.Text = (Convert.ToDateTime(month).ToString)("dd-MM-yyyy");
                }
            }
            if (lbltype.Text == "Quarterly")
            {
                if (srt2 == "")
                {
                    dueamount.Text = "No fee collection since admission time!!";
                    dueamount.ForeColor = Color.Red;
                    e.Row.BackColor = Color.LightCyan;
                }
                else
                {
                    now = Convert.ToDateTime(srt2);
                    month = Convert.ToString(now.AddMonths(3));
                    dueamount.Text = month;
                    dueamount.Text = (Convert.ToDateTime(month).ToString)("dd-MM-yyyy");
                }
            }

            GridView gv = (GridView)e.Row.FindControl("gvChildGrid");
            param = new SqlParameter[2];
            param[0] = new SqlParameter("@studentid", studentid.Value);
            param[1] = new SqlParameter("@brid", Session["BrBrid"]);

            DataTable dt = objdut.GetDataTableSP(param, "usp_gridfeeinside");
            if (dt.Rows.Count > 0)
            {
                gv.DataSource = dt;
                gv.DataBind();
            }
            else
            {
                gv.EmptyDataText = "No Record.";
                gv.DataSource = null;
                gv.DataBind();
            }
        }
    }

    protected void ddlRecordperPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlRecordperPage.SelectedValue != "0")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            setpage();
            if (ddlsearch.SelectedIndex == 0 && ddlEnquirySource.SelectedIndex == 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, 0, Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
            else if (ddlsearch.SelectedIndex != 0 && ddlEnquirySource.SelectedIndex == 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
            else if (ddlsearch.SelectedIndex == 0 && ddlEnquirySource.SelectedIndex != 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), 0, Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
            else if (ddlsearch.SelectedIndex != 0 && ddlEnquirySource.SelectedIndex != 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
        }
    }

    protected void PageNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (PageNo.SelectedIndex > 0)
        {
            ViewState["PageNo"] = PageNo.SelectedItem.Text;

            if (ddlsearch.SelectedIndex == 0 && ddlEnquirySource.SelectedIndex == 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, 0, Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
            else if (ddlsearch.SelectedIndex != 0 && ddlEnquirySource.SelectedIndex == 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
            else if (ddlsearch.SelectedIndex == 0 && ddlEnquirySource.SelectedIndex != 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), 0, Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
            else if (ddlsearch.SelectedIndex != 0 && ddlEnquirySource.SelectedIndex != 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
        }
    }

    protected void firstpage_Click(object sender, ImageClickEventArgs e)
    {
        ViewState["PageNo"] = 1;
        PageNo.SelectedIndex = 1;

        if (ddlsearch.SelectedIndex == 0 && ddlEnquirySource.SelectedIndex == 0)
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, 0, Convert.ToString(txtnamesearch.Text.Trim()));
            return;
        }
        else if (ddlsearch.SelectedIndex != 0 && ddlEnquirySource.SelectedIndex == 0)
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
            return;
        }
        else if (ddlsearch.SelectedIndex == 0 && ddlEnquirySource.SelectedIndex != 0)
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), 0, Convert.ToString(txtnamesearch.Text.Trim()));
            return;
        }
        else if (ddlsearch.SelectedIndex != 0 && ddlEnquirySource.SelectedIndex != 0)
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
            return;
        }

        // fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
    }

    protected void previous_Click(object sender, ImageClickEventArgs e)
    {
        int currentpage = Convert.ToInt32(ViewState["PageNo"]);
        if (currentpage > 1)
        {
            currentpage = currentpage - 1;
            ViewState["PageNo"] = currentpage;
            PageNo.SelectedIndex = currentpage;

            if (ddlsearch.SelectedIndex == 0 && ddlEnquirySource.SelectedIndex == 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, 0, Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
            else if (ddlsearch.SelectedIndex != 0 && ddlEnquirySource.SelectedIndex == 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
            else if (ddlsearch.SelectedIndex == 0 && ddlEnquirySource.SelectedIndex != 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), 0, Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
            else if (ddlsearch.SelectedIndex != 0 && ddlEnquirySource.SelectedIndex != 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
            // fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
        }
    }

    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        int countnew = Convert.ToInt32(objdut.GetScalar("select count(1) from tbl_Admission where status=1 and brid=" + Session["BrBrid"] + " and fyid=" + ViewState["acad"]));
        totalpage = countnew / Convert.ToInt32(ViewState["noofrecord"]);
        totalpage = totalpage + 1;
        int currentpage = Convert.ToInt32(ViewState["PageNo"]);
        if (currentpage < totalpage)
        {
            currentpage = currentpage + 1;
            ViewState["PageNo"] = currentpage;
            PageNo.SelectedIndex = currentpage;

            if (ddlsearch.SelectedIndex == 0 && ddlEnquirySource.SelectedIndex == 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, 0, Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
            else if (ddlsearch.SelectedIndex != 0 && ddlEnquirySource.SelectedIndex == 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
            else if (ddlsearch.SelectedIndex == 0 && ddlEnquirySource.SelectedIndex != 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), 0, Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
            else if (ddlsearch.SelectedIndex != 0 && ddlEnquirySource.SelectedIndex != 0)
            {
                fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
                return;
            }
            //   fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
        }
    }

    protected void last_Click(object sender, ImageClickEventArgs e)
    {
        int countnew = Convert.ToInt32(objdut.GetScalar("select count(1) from tbl_Admission where status=1 and brid=" + Session["BrBrid"] + " and fyid=" + ViewState["acad"]));
        totalpage = countnew / Convert.ToInt32(ViewState["noofrecord"]);
        totalpage = totalpage + 1;
        ViewState["PageNo"] = totalpage;
        PageNo.SelectedIndex = totalpage;

        if (ddlsearch.SelectedIndex == 0 && ddlEnquirySource.SelectedIndex == 0)
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, 0, Convert.ToString(txtnamesearch.Text.Trim()));
            return;
        }
        else if (ddlsearch.SelectedIndex != 0 && ddlEnquirySource.SelectedIndex == 0)
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
            return;
        }
        else if (ddlsearch.SelectedIndex == 0 && ddlEnquirySource.SelectedIndex != 0)
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), 0, Convert.ToString(txtnamesearch.Text.Trim()));
            return;
        }
        else if (ddlsearch.SelectedIndex != 0 && ddlEnquirySource.SelectedIndex != 0)
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
            return;
        }

        //  fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        setpage();
        if (ddlsearch.SelectedIndex == 0 && ddlEnquirySource.SelectedIndex == 0)
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, 0, Convert.ToString(txtnamesearch.Text.Trim()));
            return;
        }
        else if (ddlsearch.SelectedIndex != 0 && ddlEnquirySource.SelectedIndex == 0)
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), 0, Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
            return;
        }
        else if (ddlsearch.SelectedIndex == 0 && ddlEnquirySource.SelectedIndex != 0)
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), 0, Convert.ToString(txtnamesearch.Text.Trim()));
            return;
        }
        else if (ddlsearch.SelectedIndex != 0 && ddlEnquirySource.SelectedIndex != 0)
        {
            fillgrid(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToInt32(ddlEnquirySource.SelectedValue), Convert.ToInt32(ddlsearch.SelectedValue), Convert.ToString(txtnamesearch.Text.Trim()));
            return;
        }
    }
}