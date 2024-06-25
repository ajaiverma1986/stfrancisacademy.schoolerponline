using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Data;
using System.IO;
using System.Web.UI;

public partial class BranchPanel_Exams_attendance_sheetaspx : System.Web.UI.Page
{
    private DataTable dt, dt1;
    private DataUtility objDut = new DataUtility();
    private string url, query, query1, query2, query3, querystatus;
    private int batchid = 0, status = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (Session["tid"] == null)
        {
            Response.Redirect("testlist.aspx");
        }

        if (!IsPostBack)
        {
            dt = CommonClass.examMaster("examDetail", Convert.ToInt32(Session["tid"]), Convert.ToInt32(Session["BrBrid"]));
            if (dt.Rows.Count > 0)
            {
                lblDate.Text = dt.Rows[0]["testdate"].ToString();
                lblbatch.Text = dt.Rows[0]["batchname"].ToString();
                lblClass.Text = dt.Rows[0]["classname"].ToString();
                lblSub.Text = dt.Rows[0]["subname"].ToString();
                lblTopic.Text = dt.Rows[0]["topic"].ToString();
            }
        }
        fillgrid();
    }

    private void fillgrid()
    {
        dt1 = CommonClass.examMaster("examatendance", Convert.ToInt32(Session["tid"]), Convert.ToInt32(Session["BrBrid"]));
        if (dt1.Rows.Count > 0)
        {
            gvdetails.DataSource = dt1;
            gvdetails.DataBind();
        }
    }

    protected void btnPdf_Click(object sender, EventArgs e)
    {
        string attachment = "attachment; filename=" + "AttendanceSheet" + ".pdf";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/pdf";
        StringWriter s_tw = new StringWriter();
        HtmlTextWriter h_textw = new HtmlTextWriter(s_tw);
        h_textw.AddStyleAttribute("font-size", "7pt");
        h_textw.AddStyleAttribute("color", "Black");
        Panel1.RenderControl(h_textw);//Name of the Panel
        Document doc = new Document();
        doc = new Document(PageSize.A4, 5, 5, 15, 5);
        //FontFactory.GetFont("Verdana", 80, iTextSharp.text.);
        PdfWriter.GetInstance(doc, Response.OutputStream);
        doc.Open();
        StringReader s_tr = new StringReader(s_tw.ToString());
        HTMLWorker html_worker = new HTMLWorker(doc);
        html_worker.Parse(s_tr);
        doc.Close();
        Response.Write(doc);
    }
}