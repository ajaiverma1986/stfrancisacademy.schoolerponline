using InfoSoftGlobal;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class BranchPanel_StudentPanel_student_performance : System.Web.UI.Page
{
    private string url;
    private SqlParameter[] param = new SqlParameter[2];
    private SqlParameter[] param1 = new SqlParameter[2];
    private string GraphWidth = "800";
    private string GraphHeight = "400";
    private DataUtility objDut = new DataUtility();
    private string testid = "", chktestid = "";
    private string[] color = new string[12];
    private DataTable dt = new DataTable("Chart");
    private string[] data;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["StuRegNo"] == null)
        {
            Response.Redirect("../user-login.aspx");
        }
        string imgsrc = Convert.ToString(objDut.GetScalar("select logo+'^'+LogoBgColor from tbl_recieptsettingcenter"));
        data = imgsrc.Split('^');
        if (!IsPostBack)
        {
            DivForGrid.Visible = true;
            Div1.Visible = false;
            btnsendmail.Visible = false;
            btnsetgraph.Visible = false;
            btnback.Visible = false;
            fillinfo();
            ConfigureColors();
          
        }
    }

   

    private void ConfigureColors()
    {
        color[0] = "AFD8F8";
        color[1] = "F6BD0F";
        color[2] = "8BBA00";
        color[3] = "FF8E46";
        color[4] = "008E8E";
        color[5] = "D64646";
        color[6] = "8E468E";
        color[7] = "588526";
        color[8] = "B3AA00";
        color[9] = "008ED6";
        color[10] = "9D080D";
        color[11] = "A186BE";
    }

    private void fillinfo()
    {
        string proc = "usp_studentperformance";
        param[0] = new SqlParameter("@sturegno ", Session["StuRegNo"]);
        param[1] = new SqlParameter("@intresult", 0);
        param[1].Direction = ParameterDirection.Output;

        DataTable dt = objDut.GetDataTableSP(param, proc);
        if (dt.Rows.Count > 0)
        {
            GridView2.DataSource = dt;
            GridView2.DataBind();
            GridView3.DataSource = dt;
            GridView3.DataBind();
        }
        else
        {
            lblmsg.Text = "No test given by this student till now.";
        }
    }

    protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        DivForGrid.Visible = false;
        Div1.Visible = true;
        //btnsendmail.Visible = true;
        btnsetgraph.Visible = true;
        btnback.Visible = true;
        int subjid = Convert.ToInt32(e.CommandArgument);
        ViewState["subjid"] = subjid;
        string proc = "usp_allperform1";
        param1[0] = new SqlParameter("@sturegno ", Session["StuRegNo"]);
        param1[1] = new SqlParameter("@intresult", 0);
        param1[1].Direction = ParameterDirection.Output;
        DataTable dt = objDut.GetDataTableSP(param1, proc);
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
            if (GridView2.Rows.Count > 0)
            {
                foreach (GridViewRow gvrow in GridView2.Rows)
                {
                    HiddenField hd1 = (HiddenField)gvrow.FindControl("hd1");
                    CheckBox chktest = (CheckBox)gvrow.FindControl("chk");
                    if (chktest.Checked == true)
                    {
                        chktestid = chktestid + "," + Convert.ToString(hd1.Value);
                    }
                }
                if (chktestid != "")
                {
                    chktestid = chktestid.Remove(0, 1);
                    LoadChartData(chktestid);
                }
                else
                {
                    chktestid = "";
                    LoadChartData(chktestid);
                }
            }
        }
    }

    public void LoadChartData(string subid)
    {
        if (subid == "")
        {
            if (GridView1.Rows.Count > 0)
            {
                foreach (GridViewRow gvrow in GridView1.Rows)
                {
                    HiddenField hd1 = (HiddenField)gvrow.FindControl("hd1");
                    testid = testid + "," + Convert.ToString(hd1.Value);
                }
                if (testid != "")
                    testid = testid.Remove(0, 1);
            }
        }
        else
        {
            testid = subid;
        }

        //        string cmd = @"select top 5 cast(((MAX(marks)/Totalmarks)*100) as decimal(18,2)) as maxmarks,cast(((MIN(marks)/Totalmarks)*100) as decimal(18,2)) as minmarks,
        //         cast(((AVG(marks)/Totalmarks)*100) as decimal(18,2))  as avgmarks,testid,Testname from tbl_studentexamresult ser inner join exam_Master em on em.Tid=ser.testid
        //          where testid in (" + testid + ") group by testid,tid,Totalmarks,Testname order by Tid asc";
        SqlParameter[] param3 = new SqlParameter[2];
        param3[0] = new SqlParameter("@sturegno ", Session["StuRegNo"]);
        param3[1] = new SqlParameter("@testid ", testid);
        DataTable dt = objDut.GetDataTableSP(param3, "usp_StudentperformanceChart");
        if (dt.Rows.Count > 0)
        {
            string xmlData, categories, minmarks, avgmarks, maxmarks, yourmarks;
            //Initialize <chart> element
            xmlData = @"<graph palette='2' paletteThemeColor='6699FF'  bgColor='F0EEEE' nameDisplay='WRAP'   caption='Student Performance Report'  syAxisMaxValue='100' syAxisMinValue='0' pyAxisMaxValue='100' pyAxisMinValue='0' primaryAxisOnLeft='0'  showvalues='0' numberprefix='' numDivLines='4' syaxisvaluesdecimals='1'  pyaxisname='Percentage'   showborder='0'>";
            //Initialize <categories> element - necessary to generate a multi-series chart
            categories = "<categories nameDisplay='WRAP' verticalLineColor='666666' verticalLineThickness='1'>";
            //Initiate <dataset> elements
            minmarks = "<dataset seriesName='Lowest Percentage' color='#8BBA00'>";
            avgmarks = "<dataset seriesName='Average Percentage' color='#FF8E46'>";
            maxmarks = "<dataset seriesName='Highest Percentage' color='#6969C2'>";
            yourmarks = "<dataset seriesName='your Percentage' color='#9D080D' parentYAxis='S' renderas='Line'  >";
            // testname = "<dataset seriesName='Test Name' color='#A186BE' labeldispaly  >";
            //Iterate through the data
            int i = 0;
            DataTable dt222 = objDut.GetDataTable("select  top 5 cast(((marks/Totalmarks)*100) as decimal(18,2)) as marks,testid from tbl_studentexamresult  inner join exam_Master em on em.Tid=tbl_studentexamresult.testid and tbl_studentexamresult.sturegno=" + Session["StuRegNo"] + " where tbl_studentexamresult.sturegno=" + Session["StuRegNo"] + " and testid in (" + testid + ") order by testid asc");

            foreach (DataRow DR in dt.Rows)
            {
                //Append <category name='...' /> to strCategories
                categories += "<category name='" + DR["testname"].ToString() + "'  showVerticalLine='2' nameDisplay='WRAP' hoverText='" + DR["testname"].ToString() + ":-Your Subject Marks:" + DR["SubjectNamewithmarks"].ToString() + "'/>";

                //Add <set value='...' /> to both the datasets
                minmarks += "<set  value='" + DR["minmarks"].ToString() + "' />";
                maxmarks += "<set  value='" + DR["maxmarks"].ToString() + "' />";
                avgmarks += "<set  value='" + DR["avgmarks"].ToString() + "' />";

                if (dt222.Rows[i]["marks"].ToString() == DR["minmarks"].ToString())
                {
                    yourmarks += "<set  value='" + DR["minmarks"].ToString() + "' />";
                }
                else if (dt222.Rows[i]["marks"].ToString() == DR["maxmarks"].ToString())
                {
                    yourmarks += "<set  value='" + DR["maxmarks"].ToString() + "' />";
                }
                else if (dt222.Rows[i]["marks"].ToString() == DR["avgmarks"].ToString())
                {
                    yourmarks += "<set value='" + DR["avgmarks"].ToString() + "' />";
                }
                else
                {
                    yourmarks += "<set  value='" + dt222.Rows[i]["marks"].ToString() + "' />";
                }

                i++;
            }
            //Close <categories> element
            categories += "</categories>";
            //Close <dataset> elements
            minmarks += "</dataset> ";
            maxmarks += "</dataset> ";
            avgmarks += "</dataset>";
            yourmarks += "</dataset>";
            //Assemble the entire XML now
            xmlData += categories + minmarks + maxmarks + avgmarks + yourmarks + "</graph>";
            //XmlNodeList xnList = xml.SelectNodes("value");
            //Create the chart - MS Column 3D Chart with data contained in xmlData
            //  return FusionCharts.RenderChart("../../FusionCharts/MSColumn3D.swf", "", xmlData, "productSales", "600", "300", false, false);
            FCLiteral1.Text = FusionCharts.RenderChartHTML(
                "FusionCharts/FCF_MSColumn3DLineDY.swf", // Path to chart's SWF
                "",                              // Leave blank when using Data String method
                xmlData,                          // xmlStr contains the chart data
                "productSales",                      // Unique chart ID
                GraphWidth, GraphHeight,                   // Width & Height of chart
                false
                );
        }
        else
        {
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }

    protected void img_pdffile_Click(object sender, ImageClickEventArgs e)
    {
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=studentperformance-report.pdf");
        Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        HtmlForm frm = new HtmlForm();
        fillinfo();
        DivForGrid.Parent.Controls.Add(frm);
        frm.Attributes["runat"] = "server";
        frm.Controls.Add(GridView3);
        //if (ViewState["subjid"] != null)
        //{
        //    frm.Controls.Add(GridView1);
        //}
        frm.RenderControl(hw);
        GridView3.DataBind();
        StringReader sr = new StringReader(sw.ToString());
        iTextSharp.text.Document pdfDoc = new iTextSharp.text.Document(PageSize.A4, 10f, 10f, 40f, 0f);
        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        pdfDoc.Open();
        var titleFont = FontFactory.GetFont("Arial", 18);
        var logo = iTextSharp.text.Image.GetInstance(Server.MapPath("~/images/" + data[0] + ""));
        logo.SetAbsolutePosition(350, 790);
        pdfDoc.Add(logo);
        pdfDoc.Add(new Paragraph("Student Performance", titleFont));
        htmlparser.Parse(sr);
        pdfDoc.Close();
        Response.Write(pdfDoc);
        Response.End();
        ViewState["subjid"] = null;
    }

    protected void btnsendmail_Click(object sender, EventArgs e)
    {
        DataUtility Objdut = new DataUtility();
        string res = "", Student_EmailId = "", MailContent = "";
        var sb = new StringBuilder();
        DivMailContnt.RenderControl(new HtmlTextWriter(new StringWriter(sb)));
        MailContent = sb.ToString();
        Student_EmailId = Convert.ToString(Objdut.GetScalar("select ISNULL(Email,'') from student_master where StuRegNo=" + HttpContext.Current.Session["StuRegNo"] + " "));
        if (Student_EmailId != "")
            res = SendMail.SendDemo("institute@awapalsolutions.com", Student_EmailId, "", "", "Student Performance Report", MailContent, "", "webmail.awapalsolutions.com");
        if (res == "")
        {
            Utility.ViewAlertMessage(this, "Mail Send Successfully.");
        }
    }

    protected void btnsetgraph_Click(object sender, EventArgs e)
    {
        DivForGrid.Visible = false;
        Div1.Visible = true;
        //btnsendmail.Visible = true;
        btnsetgraph.Visible = true;
        if (GridView1.Rows.Count > 0)
        {
            foreach (GridViewRow gvrow in GridView1.Rows)
            {
                HiddenField hd1 = (HiddenField)gvrow.FindControl("hd1");
                CheckBox chktest = (CheckBox)gvrow.FindControl("chktestid");
                if (chktest.Checked == true)
                {
                    chktestid = chktestid + "," + Convert.ToString(hd1.Value);
                }
            }
            if (chktestid != "")
            {
                chktestid = chktestid.Remove(0, 1);
                LoadChartData(chktestid);
            }
            else
            {
                chktestid = "";
                LoadChartData(chktestid);
            }
        }
    }

    protected void btnback_Click(object sender, EventArgs e)
    {
        Response.Redirect("student-performance.aspx");
    }
}