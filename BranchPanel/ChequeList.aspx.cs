using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_ChequeList : BasePage
{
    private Utility objUT = new Utility();
    private DataUtility objDUT = new DataUtility();
    private string url = "", query, query1, query2, query3, query4, pname, query5, query6;
    private DataTable dt;
    private int payid = 0, count = 0, scid = 0, fyid = 0, eid = 0;
    private double paidamount = 0;
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
            ReceivedBy();
            fyid = Convert.ToInt32(objDUT.GetScalar("select fyid from financial_Year where isActive=1 and isClosed=0"));
            ViewState["fyid"] = fyid;
            ddlCheque.SelectedValue = "4";
            fillGrid(Convert.ToInt32(Session["BrBrid"]));
        }
    }

    protected void ReceivedBy()
    {
        query1 = "Select eid from tbluser where userid=" + Convert.ToInt16(Session["BrADID"]);
        eid = Convert.ToInt16(objDUT.GetScalar(query1));
        query2 = "Select name from tblEmployee where eid=" + eid;
        ViewState["Bouncer"] = (objDUT.GetScalar(query2)).ToString();
    }

    protected void fillGrid(int brid)
    {
        dt = CommonClass.ABC1("ChequeList", brid);
        if (dt.Rows.Count > 0)
        {
            gvdetails.DataSource = dt;
            ViewState["dt"] = dt;
            gvdetails.DataBind();
            IBExcel.Enabled = true;
        }
        else
        {
            gvdetails.EmptyDataText = "No record found.!";
            gvdetails.DataSource = null;
            gvdetails.DataBind();
            IBExcel.Enabled = false;
            IBExcel.ToolTip = "No data to export to excel.";
        }
    }

    protected void fill2(string query)
    {
        dt = objDUT.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            gvdetails.DataSource = dt;
            ViewState["dt"] = dt;
            gvdetails.DataBind();
            IBExcel.Enabled = true;
        }
        else
        {
            gvdetails.EmptyDataText = "No record found.!";
            gvdetails.DataSource = null;
            gvdetails.DataBind();
            IBExcel.Enabled = false;
            IBExcel.ToolTip = "No data to export to excel.";
        }
    }

    protected void gvdetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        payid = Convert.ToInt16(e.CommandArgument);
        ViewState["payid"] = payid;
        query3 = "Select paidamount,scid from student_installment where sid=" + payid;
        dt = objDUT.GetDataTable(query3);
        if (dt.Rows.Count > 0)
        {
            scid = Convert.ToInt16(dt.Rows[0]["scid"]);
            paidamount = Convert.ToDouble(dt.Rows[0]["paidamount"]);
            ViewState["paidamt"] = paidamount;
            ViewState["scid"] = scid;
        }
        if (e.CommandName == "ShowPopup")
        {
            Popup(true);
        }
        if (e.CommandName == "Clear")
        {
            pname = "usp_ClearCheque";
            param = new SqlParameter[6];
            param[0] = new SqlParameter("@mode", "ClearCheque");
            param[1] = new SqlParameter("@sid", payid);
            param[2] = new SqlParameter("@paidamount", paidamount);
            param[3] = new SqlParameter("@scid", scid);
            param[4] = new SqlParameter("@intResult", Convert.ToInt32("0"));
            param[4].Direction = ParameterDirection.Output;
            param[5] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));
            count = objDUT.ExecuteSqlSP(param, pname);
            if (count == 1)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('The cheque has been cleared successfully.')", true);
                ddlCheque.SelectedValue = "4";
                query5 = @"select si.sid,(sm.FName+' '+sm.LName) as name,scm.coursename,si.sturegno,si.refrenceno,si.paidamount,(case paymentstatus when 'Payment in process' then 'Pending' when 'Paid' then 'Cleared' when 'Notpaid' then 'Cheque Bounced' end ) as status,CONVERT(varchar(13),si.paiddate,106) as date,si.bankname
                       from student_master sm left outer join studentCourse_master scm on sm.sturegno=scm.sturegno join student_installment si on  sm.StuRegNo=si.sturegno where sm.brid=" + Convert.ToInt32(Session["BrBrid"]) + "  and si.paymodeid=2 and si.scid=scm.scid and si.fyid=" + Convert.ToInt32(ViewState["fyid"]) + " order by paiddate desc";
                fill2(query5);
                return;
            }
        }
        if (e.CommandName == "Clear2")
        {
            pname = "usp_BounceCheque";
            param = new SqlParameter[5];
            param[0] = new SqlParameter("@mode", "BounceCheque");
            param[1] = new SqlParameter("@sid", payid);
            param[2] = new SqlParameter("@bouncedby", ViewState["Bouncer"].ToString());
            param[3] = new SqlParameter("@intResult", Convert.ToInt32("0"));
            param[3].Direction = ParameterDirection.Output;
            param[4] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));
            count = objDUT.ExecuteSqlSP(param, pname);
            if (count == 1)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('The cheque has been bounced.')", true);
                ddlCheque.SelectedValue = "4";
                query5 = @"select si.sid,(sm.FName+' '+sm.LName) as name,scm.coursename,si.sturegno,si.refrenceno,si.paidamount,(case paymentstatus when 'Payment in process' then 'Pending' when 'Paid' then 'Cleared' when 'NotPaid' then 'Cheque Bounced' end ) as status,CONVERT(varchar(13),si.paiddate,106) as date,si.bankname
                       from student_master sm left outer join studentCourse_master scm on sm.sturegno=scm.sturegno join student_installment si on  sm.StuRegNo=si.sturegno where sm.brid=" + Convert.ToInt32(Session["BrBrid"]) + "  and si.paymodeid=2  and si.scid=scm.scid and si.fyid=" + Convert.ToInt32(ViewState["fyid"]) + " order by paiddate desc";
                fill2(query5);
                return;
            }
        }
    }

    private void Popup(bool isDisplay)
    {
        System.Text.StringBuilder builder = new System.Text.StringBuilder();
        if (isDisplay)
        {
            builder.Append("<script language=JavaScript> ShowPopup(); </script>\n");
            Page.ClientScript.RegisterStartupScript(this.GetType(), "ShowPopup", builder.ToString());
        }
        else
        {
            builder.Append("<script language=JavaScript> HidePopup(); </script>\n");
            Page.ClientScript.RegisterStartupScript(this.GetType(), "HidePopup", builder.ToString());
        }
    }

    protected void gvdetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {//
            //HiddenField hfval = (HiddenField)e.Row.FindControl("hf1");
            LinkButton lblStat1 = (LinkButton)e.Row.FindControl("lnkbtn");
            if (lblStat1.Text == "Pending")
            {
                lblStat1.Enabled = true;
            }
            else
            {
                lblStat1.Enabled = false;
                lblStat1.ForeColor = System.Drawing.Color.Black;
            }
            //LinkButton lb2 = (LinkButton)e.Row.FindControl("lnkClear12");
            //Label lblStat123 = (Label)e.Row.FindControl("lblDate");
            //if (ddlCheque.SelectedValue == "1")
            //{
            //    lblStat123.Font.Bold = true;
            //    lblStat1.Enabled = true;
            //    lb2.Enabled = true;
            //    lblStat1.ToolTip = "Click here to clear this cheque.";
            //    lb2.ToolTip = "Click here to indicate this cheque has bounced.";
            //}
            //else if (ddlCheque.SelectedValue == "2")
            //{
            //    lblStat123.Font.Bold = true;
            //    lblStat1.Enabled = false;
            //    //lblStat1.Font.Bold = true;
            //    lblStat1.Text = "N/A";
            //    lb2.Text = "N/A";

            //    lb2.Enabled = false;

            //    lblStat1.ToolTip = "This cheque has been already cleared.";
            //    lb2.ToolTip = "This cheque has been already cleared.";
            //}
            //else if (ddlCheque.SelectedValue == "3")
            //{
            //    lblStat123.Font.Bold = true;
            //    lblStat1.Enabled = false;
            //    lb2.Enabled = false;
            //    lblStat1.Text = "N/A";
            //    lb2.Text = "N/A";

            //    lblStat1.ToolTip = "This cheque has already bounced.";
            //    lb2.ToolTip = "This cheque has already bounced.";
            //}
            //else if (ddlCheque.SelectedValue == "4")
            //{
            //    lblStat123.Font.Bold = true;
            //    lblStat1.Enabled = false;
            //    lb2.Enabled = false;
            //    lblStat1.Text = "N/A";
            //    lb2.Text = "N/A";
            //}
        }
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        Response.Redirect("OverDueList.aspx");
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

    protected void ddlCheque_SelectedIndexChanged(object sender, EventArgs e)
    {
        gvdetails.DataSource = null;
        gvdetails.DataBind();
        if (ddlCheque.SelectedValue == "0")
        {
            GridBatch.Visible = false;
        }
        else
        {
            GridBatch.Visible = true;
            if (ddlCheque.SelectedValue == "1")
            {
                query = @"select si.sid,(sm.FName+' '+sm.LName) as name,scm.coursename,si.sturegno,si.refrenceno,si.paidamount,case paymentstatus when 'Payment in process' then 'Pending' end as status ,CONVERT(varchar(13),si.paiddate,106) as date,si.bankname
                          from student_master sm left outer join studentCourse_master scm on sm.sturegno=scm.sturegno join student_installment si on  sm.StuRegNo=si.sturegno where sm.brid=" + Convert.ToInt32(Session["BrBrid"]) + " and si.paymodeid=2 and si.scid=scm.scid and paymode='Cheque' and paymentstatusid=3 and si.fyid=" + Convert.ToInt32(ViewState["fyid"]) + " order by paiddate desc";

                fill2(query);
            }
            else if (ddlCheque.SelectedValue == "2")
            {
                query4 = @"select si.sid,(sm.FName+' '+sm.LName) as name,scm.coursename,si.sturegno,si.refrenceno,si.paidamount,case paymentstatus when 'Paid' then 'Clear' end as status ,CONVERT(varchar(13),si.paiddate,106) as date,si.bankname
                          from student_master sm left outer join studentCourse_master scm on sm.sturegno=scm.sturegno join student_installment si on  sm.StuRegNo=si.sturegno where sm.brid=" + Convert.ToInt32(Session["BrBrid"]) + " and si.paymodeid=2 and si.scid=scm.scid and paymode='Cheque' and paymentstatusid=2 and si.fyid=" + Convert.ToInt32(ViewState["fyid"]) + " order by paiddate desc";

                fill2(query4);
            }
            else if (ddlCheque.SelectedValue == "3")
            {
                query6 = @"select si.bounceid as sid,(sm.FName+' '+sm.LName) as name,scm.coursename,si.sturegno,si.ChequeNo as refrenceno,si.ChequeAmount as paidamount,'Cheque Bounced' as status ,CONVERT(varchar(13),si.ChequeDate,106) as date,si.bankname
                           from student_master sm left outer join studentCourse_master scm on sm.sturegno=scm.sturegno join Cheque_Bounce si on  sm.StuRegNo=si.sturegno where sm.brid=" + Convert.ToInt32(Session["BrBrid"]) + " and si.fyid=" + Convert.ToInt32(ViewState["fyid"]) + "";

                fill2(query6);
            }
            else if (ddlCheque.SelectedValue == "4")
            {
                query5 = @"select si.sid,(sm.FName+' '+sm.LName) as name,scm.coursename,si.sturegno,si.refrenceno,si.paidamount,(case paymentstatus when 'Payment in process' then 'Pending' when 'Paid' then 'Cleared' when 'NotPaid' then 'Cheque Bounced' end ) as status,CONVERT(varchar(13),si.paiddate,106) as date,si.bankname
                           from student_master sm left outer join studentCourse_master scm on sm.sturegno=scm.sturegno join student_installment si on  sm.StuRegNo=si.sturegno where sm.brid=" + Convert.ToInt32(Session["BrBrid"]) + "  and si.paymodeid=2 and si.scid=scm.scid and si.fyid=" + Convert.ToInt32(ViewState["fyid"]) + " order by paiddate desc";
                fill2(query5);
            }
        }
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        base.LogActivity(" Cheque list excel sheet downloaded.", true, Convert.ToInt32(Session["BrADID"]));
        //if (gvdetails.DataSource == null)
        //{
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('No data found.')", true);
        //    return;
        //}
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Cheques.xls"));
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
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }

    protected void gvdetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvdetails.PageIndex = e.NewPageIndex;
        fillGrid(Convert.ToInt32(Session["BrBrid"]));
    }

    //protected void img_pdffile_Click(object sender, ImageClickEventArgs e)
    //{
    //    iTextSharp.text.Table table = new iTextSharp.text.Table(gvdetails.Columns.Count);
    //    // set table style properties
    //    table.BorderWidth = 1;
    //    table.BorderColor = new iTextSharp.text.Color(0, 0, 255);
    //    table.Padding = 0;
    //    table.Width = 100;

    //    table.Cellpadding = 2;
    //    table.Width = 100;
    //    // BindData();
    //    fillGrid(Convert.ToInt16(Session["BrBrid"]));
    //    //Transfer rows from GridView to table

    //    for (int i = 0; i < gvdetails.Columns.Count; i++)
    //    {
    //        string cellText = Server.HtmlDecode
    //                                  (gvdetails.Columns[i].HeaderText);
    //        iTextSharp.text.Cell cell = new iTextSharp.text.Cell(cellText);
    //        cell.BackgroundColor = new Color(System.Drawing
    //                                       .ColorTranslator.FromHtml("#93a31d"));
    //        table.AddCell(cell);
    //    }

    //    for (int i = 0; i < gvdetails.Rows.Count; i++)
    //    {
    //        if (gvdetails.Rows[i].RowType == DataControlRowType.DataRow)
    //        {
    //            for (int j = 0; j < gvdetails.Columns.Count; j++)
    //            {
    //                string cellText = Server.HtmlDecode
    //                                  (gvdetails.Rows[i].Cells[j].Text);
    //                iTextSharp.text.Cell cell = new iTextSharp.text.Cell(cellText);

    //                //Set Color of Alternating row
    //                if (i % 2 != 0)
    //                {
    //                    //cell.BackgroundColor = new Color(System.Drawing.ColorTranslator.FromHtml("#dce0bc"));
    //                }
    //                table.AddCell(cell);
    //            }
    //        }
    //    }

    //    Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
    //    PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
    //    pdfDoc.Open();

    //    var titleFont = FontFactory.GetFont("Arial", 18, Font.BOLD);
    //    var logo = iTextSharp.text.Image.GetInstance(Server.MapPath("~/images/harvin_logo.png"));
    //    logo.SetAbsolutePosition(350, 790);
    //    pdfDoc.Add(logo);

    //    pdfDoc.Add(new Paragraph("HVN Cheque List", titleFont));

    //    pdfDoc.Add(table);

    //    pdfDoc.Close();
    //    Response.ContentType = "application/pdf";
    //    Response.AddHeader("content-disposition", "attachment;" +
    //                                   "filename=GridView.pdf");
    //    //   Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //    Response.Write(pdfDoc);
    //    Response.End();
    //}

    protected void btnClear_Click(object sender, EventArgs e)
    {
        pname = "usp_ClearCheque";
        param = new SqlParameter[6];
        param[0] = new SqlParameter("@mode", "ClearCheque");
        param[1] = new SqlParameter("@sid", Convert.ToInt32(ViewState["payid"]));
        param[2] = new SqlParameter("@paidamount", Convert.ToDouble(ViewState["paidamt"]));
        param[3] = new SqlParameter("@scid", Convert.ToInt32(ViewState["scid"]));
        param[4] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[4].Direction = ParameterDirection.Output;
        param[5] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));
        count = objDUT.ExecuteSqlSP(param, pname);
        if (count == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "The cheque has been cleared successfully.");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('The cheque has been cleared successfully.')", true);
            ddlCheque.SelectedValue = "4";
            query5 = @"select si.sid,(sm.FName+' '+sm.LName) as name,scm.coursename,si.sturegno,si.refrenceno,si.paidamount,(case paymentstatus when 'Payment in process' then 'Pending' when 'Paid' then 'Cleared' when 'Notpaid' then 'Cheque Bounced' end ) as status,CONVERT(varchar(13),si.paiddate,106) as date,si.bankname
                       from student_master sm left outer join studentCourse_master scm on sm.sturegno=scm.sturegno join student_installment si on  sm.StuRegNo=si.sturegno where sm.brid=" + Convert.ToInt32(Session["BrBrid"]) + "  and si.paymodeid=2 and si.scid=scm.scid and si.fyid=" + Convert.ToInt32(ViewState["fyid"]) + " order by paiddate desc";
            fill2(query5);
            return;
        }
    }

    protected void btnBounce_Click(object sender, EventArgs e)
    {
        pname = "usp_BounceCheque";
        param = new SqlParameter[5];
        param[0] = new SqlParameter("@mode", "BounceCheque");
        param[1] = new SqlParameter("@sid", Convert.ToInt32(ViewState["payid"]));
        param[2] = new SqlParameter("@bouncedby", ViewState["Bouncer"].ToString());
        param[3] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[3].Direction = ParameterDirection.Output;
        param[4] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));
        count = objDUT.ExecuteSqlSP(param, pname);
        if (count == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "The cheque has been bounced successfully.");
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('The cheque has been bounced.')", true);
            ddlCheque.SelectedValue = "4";
            query5 = @"select si.sid,(sm.FName+' '+sm.LName) as name,scm.coursename,si.sturegno,si.refrenceno,si.paidamount,(case paymentstatus when 'Payment in process' then 'Pending' when 'Paid' then 'Cleared' when 'NotPaid' then 'Cheque Bounced' end ) as status,CONVERT(varchar(13),si.paiddate,106) as date,si.bankname
                       from student_master sm left outer join studentCourse_master scm on sm.sturegno=scm.sturegno join student_installment si on  sm.StuRegNo=si.sturegno where sm.brid=" + Convert.ToInt32(Session["BrBrid"]) + "  and si.paymodeid=2  and si.scid=scm.scid and si.fyid=" + Convert.ToInt32(ViewState["fyid"]) + " order by paiddate desc";
            fill2(query5);
            return;
        }
    }
}