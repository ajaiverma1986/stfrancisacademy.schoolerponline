using InfoSoftGlobal;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_Exams_studentmarkreport : System.Web.UI.Page
{
    private DataUtility objDut = new DataUtility();
    private SqlParameter[] param = new SqlParameter[7];
    private DataTable dt1;
    private string url = "";
    private string GraphWidth = "800";
    private string GraphHeight = "400";

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
            LoadChartData();
            ViewState["testname"] = Convert.ToString(objDut.GetScalar("select testname from exam_master where tid=" + Session["tid"]));
            ViewState["testdate"] = Convert.ToString(objDut.GetScalar("select convert(varchar(13),testdate,106) as testdate from exam_master where tid=" + Session["tid"]));
            fillinfo();
        }
    }

    private void fillinfo()
    {
        string proc = "usp_testreport";
        param[0] = new SqlParameter("@testid", Session["tid"]);

        param[1] = new SqlParameter("@totalstu", 0);
        param[1].Direction = ParameterDirection.Output;

        param[2] = new SqlParameter("@presentstu", 0);
        param[2].Direction = ParameterDirection.Output;

        param[3] = new SqlParameter("@maxmarks", 0);
        param[3].Direction = ParameterDirection.Output;

        param[4] = new SqlParameter("@minmarks", 0);
        param[4].Direction = ParameterDirection.Output;

        param[5] = new SqlParameter("@avgmarks", 0);
        param[5].Direction = ParameterDirection.Output;

        param[6] = new SqlParameter("@intresult", 0);
        param[6].Direction = ParameterDirection.Output;

        DataTable dt = objDut.GetDataTableSP(param, proc);
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        lblappear.Text = param[2].Value.ToString() + "/" + param[1].Value.ToString();
        lblhighestmarks.Text = string.Format("{0:f}", param[3].Value);
        lblavgmarks.Text = string.Format("{0:f}", param[5].Value);
        lbllowestmarks.Text = string.Format("{0:f}", param[4].Value);
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hd1 = (HiddenField)e.Row.FindControl("HD3");
            Label per = (Label)e.Row.FindControl("lblper");
            Label rank = (Label)e.Row.FindControl("lblrank");
            if (Convert.ToInt32(rank.Text) > 10)
            {
                rank.Text = "";
            }
            if (hd1.Value == "0")
            {
                per.Text = "N/A";
                rank.Text = "";
            }
        }
    }

    protected void btnPdf_Click(object sender, EventArgs e)
    {
        cht1.Visible = false;
        Div1.Visible = true;
        abc.Visible = false;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("studentmarkreport.aspx");
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        int count = 0;
        if (RadioButtonList2.SelectedIndex == 0)
        {
            dt1 = CommonClass.examMaster("marksreport", Convert.ToInt32(Session["tid"]));
            for (; count < dt1.Rows.Count; count++)
            {
                if (dt1.Rows.Count > 0)
                {
                    string name = dt1.Rows[count]["name"].ToString();
                    string mobile = dt1.Rows[count]["mobile"].ToString();
                    string rollno = dt1.Rows[count]["rollno"].ToString();
                    string percentage = dt1.Rows[count]["percentage"].ToString();
                    string marks = string.Format("{0:f}", dt1.Rows[count]["marks"]);
                    string msg = "'Thank you '" + (name.ToString()) + "' for appearing in " + ViewState["testname"].ToString() + "' Test conducted on  date!:'" + ViewState["testdate"].ToString() + "' 'you secured  " + marks.ToString() + "' marks ";
                    //sendMessageToMobile.SMSSend(mobile.ToString(), "GICI", msg);
                    Utility.ViewAlertMessage(this.Master.Page, "sms sent!");
                }
            }
        }
        else if (RadioButtonList2.SelectedIndex == 2)
        {
            dt1 = CommonClass.examMaster("examstuinfo", Convert.ToInt32(Session["tid"]));
            for (; count < dt1.Rows.Count; count++)
            {
                if (dt1.Rows.Count > 0)
                {
                    string name = dt1.Rows[count]["name"].ToString();
                    string mobile = dt1.Rows[count]["mobile"].ToString();
                    string rollno = dt1.Rows[count]["rollno"].ToString();
                    string percentage = dt1.Rows[count]["percentage"].ToString();
                    string marks = string.Format("{0:f}", dt1.Rows[count]["marks"]);
                    string msg = "'Thank you '" + (name.ToString()) + "' for appearing in " + ViewState["testname"].ToString() + "' Test conducted on  date!:'" + ViewState["testdate"].ToString() + "' 'you secured  " + marks.ToString() + "' marks ";
                    string guardianphone = dt1.Rows[count]["guardianphone"].ToString();
                    //sendMessageToMobile.SMSSend(mobile.ToString(), "GICI", msg);
                    //sendMessageToMobile.SMSSend(guardianphone.ToString(), "GICI", msg);
                    Utility.ViewAlertMessage(this.Master.Page, "sms sent!");
                }
            }
        }
        else
        {
            dt1 = CommonClass.examMaster("examstuinfo1", Convert.ToInt32(Session["tid"]));

            for (; count < dt1.Rows.Count; count++)
            {
                if (dt1.Rows.Count > 0)
                {
                    string name = dt1.Rows[count]["name"].ToString();
                    string mobile = dt1.Rows[count]["mobile"].ToString();
                    string rollno = dt1.Rows[count]["rollno"].ToString();
                    string percentage = dt1.Rows[count]["percentage"].ToString();
                    string marks = string.Format("{0:f}", dt1.Rows[count]["marks"]);
                    string guardianmobile = dt1.Rows[count]["guardianphone"].ToString();
                    string msg = "'Thank you  Mr. '" + (name.ToString()) + "' for appearing in " + ViewState["testname"].ToString() + "' Test conducted on  date!:'" + ViewState["testdate"].ToString() + "' 'you secured  " + marks.ToString() + "' marks ";
                    //sendMessageToMobile.SMSSend(guardianmobile.ToString(), "GICI", msg);
                    Utility.ViewAlertMessage(this.Master.Page, "sms sent!");
                }
            }
        }
    }

    private void LoadChartData()
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@testid", Session["tid"]);
        param[1] = new SqlParameter("intresult", 0);
        param[1].Direction = ParameterDirection.Output;
        DataTable dt = objDut.GetDataTableSP(param, "usp_showpiechart");
        if (dt.Rows.Count > 0)
        {
            string xmlData;//categories, Absent, zero_20, two1_40, four1_60,six1_80,eight1_100;
            //Initialize <chart> element
            xmlData = @"<graph caption='Pie Chart' decimalPrecision='0' showPercentageValues='0' showNames='1' numberPrefix='' showValues='1' showPercentageInLabel='0' pieYScale='45' pieBorderAlpha='100' pieRadius='100' animation='1' shadowXShift='4' shadowYShift='4' shadowAlpha='40' pieFillAlpha='95' pieBorderColor='FFFFFF'>";
            // Absent = "<data seriesName='Absent' color='#8BBA00'>";
            //zero_20 = "<data seriesName='0-20' color='#FF8E46'>";
            //two1_40 = "<data seriesName='21-40' color='#6969C2'>";
            //four1_60 = "<data seriesName='41-60' color='#696966'>";
            //six1_80 = "<data seriesName='61-80' color='#6969C2'>";
            //eight1_100 = "<data seriesName='81-100' color='#6969C2'>";
            string Absent = "", zero_20 = "", two1_40 = "", four1_60 = "", six1_80 = "", eight1_100 = "";
            foreach (DataRow DR in dt.Rows)
            {
                //Append <category name='...' /> to strCategories
                //categories += "<category name='" + DR["testname"].ToString() + "'  showVerticalLine='2' nameDisplay='WRAP' hoverText='" + DR["testname"].ToString() + "'/>";

                //Add <set value='...' /> to both the datasets
                xmlData += "<set name='Absent' value='" + DR["Absent"].ToString() + "' />";
                xmlData += "<set name='0-20'  value='" + DR["0-20"].ToString() + "' />";
                xmlData += "<set  name='20-40' value='" + DR["20-40"].ToString() + "' />";

                xmlData += "<set name='40-60'  value='" + DR["40-60"].ToString() + "' />";
                xmlData += "<set   name='60-80' value='" + DR["60-80"].ToString() + "'/>";
                xmlData += "<set name='60-80'  value='" + DR["80-100"].ToString() + "' />";
                //Assemble the entire XML now
            }
            //Absent += "</data> ";
            //zero_20 += "</data> ";
            //two1_40 += "</data>";
            //four1_60 += "</data>";
            //six1_80 += "</data> ";
            //eight1_100 += "</data> ";

            xmlData += "</graph>";

            // XmlNodeList xnList = xml.SelectNodes("value");

            //Create the chart - MS Column 3D Chart with data contained in xmlData
            //  return FusionCharts.RenderChart("../../FusionCharts/MSColumn3D.swf", "", xmlData, "productSales", "600", "300", false, false);

            FCLiteral1.Text = FusionCharts.RenderChartHTML(
                "FusionCharts/FCF_Pie3D.swf", // Path to chart's SWF
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

        //int[] yValues = new int[6];
        //yValues[0] = Convert.ToInt32(dt.Rows[0]["Absent"]); //{ 2, 0, 1,4,5,6 };
        //yValues[1] = Convert.ToInt32(dt.Rows[0]["0-20"]);
        //yValues[2] = Convert.ToInt32(dt.Rows[0]["20-40"]);
        //yValues[3] = Convert.ToInt32(dt.Rows[0]["40-60"]);
        //yValues[4] = Convert.ToInt32(dt.Rows[0]["60-80"]);
        //yValues[5] = Convert.ToInt32(dt.Rows[0]["80-100"]);
        //string[] xValues = { "Absent", "0-20", "21-40", "41-60", "61-80", "81-100" };
        ////Chart2.Labels.XAxisLabelsFromArray(new string[] { "Label 1", "Label 2", "Label 3", "Label 4", "Label 5", "Label 6" });

        //Chart2.Series["Students"].Points.DataBindXY(xValues, yValues);

        //Chart2.Series["Students"].Points[0].Color = Color.Blue;

        //Chart2.Series["Students"].Points[1].Color = Color.Red;
        //Chart2.Series["Students"].Points[2].Color = Color.Green;
        //Chart2.Series["Students"].Points[3].Color = Color.Violet;
        //Chart2.Series["Students"].Points[4].Color = Color.LightBlue;
        //Chart2.Series["Students"].Points[5].Color = Color.Yellow;

        //Chart2.Series["Students"].ChartType = SeriesChartType.Pie;

        //Chart2.Series["Students"]["PieLabelStyle"] = "Disabled";

        //Chart2.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;

        //Chart2.Legends[0].Enabled = true;
        // Chart2.ChartArea("ChartArea1").AxisX.LabelStyle.Interval = 1;
    }
}