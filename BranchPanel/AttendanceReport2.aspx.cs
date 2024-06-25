using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_AttendanceReport2 : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();
    private Utility objUT = new Utility();
    private CommonClass CommmonOBJ = new CommonClass();

    private SqlParameter[] param = new SqlParameter[5];
    private DataTable dtrow;

    private int d1 = 0, d2 = 0, d3 = 0, d4 = 0, d5 = 0, d6 = 0, d7 = 0, d8 = 0, d9 = 0, d10 = 0, d11 = 0, d12 = 0, d13 = 0, d14 = 0, d15 = 0, d16 = 0, d17 = 0, d18 = 0, d19 = 0;
    private int d20 = 0, d21 = 0, d22 = 0, d23 = 0, d24 = 0, d25 = 0, d26 = 0, d27 = 0, d28 = 0, d29 = 0, d30 = 0, d31 = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DDL_Class_Bind();
            bind_month();
        }
    }

    private void DDL_Class_Bind()
    {
        //if(ddlSection.SelectedIndex==-1)
        //{
        //    return;
        //}

        DataTable dt = CommmonOBJ.Dll("ClassInBranch", Convert.ToInt32(Session["BrBrid"])); //objDUT.GetDataTable(query);
        ddlClass.DataSource = dt;

        ddlClass.DataTextField = "Classname";
        ddlClass.DataValueField = "classid";
        ddlClass.DataBind();
        ddlClass.Items.Insert(0, "--Select Class--");
        ddlSection.Items.Insert(0, "--Select Section--");
    }

    private void bind_month()
    {
        DataTable dt = CommmonOBJ.Dll("MonthName");
        DDLMonth.DataSource = dt;
        DDLMonth.DataBind();
        DDLMonth.DataTextField = "MonthName";
        DDLMonth.DataValueField = "MonthId";
        DDLMonth.DataBind();
        DDLMonth.Items.Insert(0, "--Select Month--");
    }

    protected void DDLMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView1.DataSource = null;
        GridView1.DataBind();
        ddlClass.SelectedValue = "--Select Class--";
        ddlSection.Items.Clear();
        ddlSection.Items.Insert(0, "--Select Section--");
        if (DDLMonth.SelectedValue != "--Select Month--")
        {
            int days = CommonClass.Scaler("getdays", Convert.ToInt32(DDLMonth.SelectedValue));
            ViewState["days"] = days;
            if (DDLMonth.SelectedValue != "11")
            {
                if (days == 31)
                {
                    td29.Visible = true;
                    td30.Visible = true;
                    td31.Visible = true;
                    GridView1.Columns[30].Visible = true;
                    GridView1.Columns[31].Visible = true;
                    GridView1.Columns[32].Visible = true;
                }
                else if (days == 30)
                {
                    td31.Visible = false;
                    GridView1.Columns[32].Visible = false;
                    td29.Visible = true;
                    td30.Visible = true;
                    GridView1.Columns[30].Visible = true;
                    GridView1.Columns[31].Visible = true;
                }
            }
            else if (DDLMonth.SelectedValue == "11")
            {
                if (objUT.isLeapYear(CommonClass.Scaler("getYear")))
                {
                    td29.Visible = true;
                    td30.Visible = false;
                    td31.Visible = false;
                    GridView1.Columns[30].Visible = true;
                    GridView1.Columns[31].Visible = false;
                    GridView1.Columns[32].Visible = false;
                }
                else
                {
                    td29.Visible = false;
                    td30.Visible = false;
                    td31.Visible = false;
                    GridView1.Columns[30].Visible = false;
                    GridView1.Columns[31].Visible = false;
                    GridView1.Columns[32].Visible = false;
                }
            }
        }
        else
        {
            lblmsg.Text = "";
            GridView1.Visible = false;
            ddlSection.Items.Clear();
            //ddlClass.Items.Clear();
            DDL_Class_Bind();
            DDLMonth.Focus();
        }
    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlSection.Items.Clear();
        if (ddlClass.SelectedValue == "--Select Class--")
        {
            ddlSection.Items.Insert(0, "--Select Section--");
            DDLMonth.SelectedValue = "--Select Month--";
            GridView1.Visible = false;
        }
        else
        {
            DataTable dt = CommmonOBJ.Dll("sectiondll", Convert.ToInt32(ddlClass.SelectedValue), Convert.ToInt32(Session["BrBrid"])); //objDUT.GetDataTable(query);
            ddlSection.DataSource = dt;
            ddlSection.DataBind();
            ddlSection.DataTextField = "sectionname";
            ddlSection.DataValueField = "cwsid";
            ddlSection.DataBind();
            ddlSection.Items.Insert(0, "--Select Section--");
            //DDLMonth.SelectedValue = "--Select Month--";
            //DDLMonth.Enabled = false;
        }
    }

    protected void ddlSection_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSection.SelectedValue != "--Select Section--")
        {
            if (Validate1())
            {
                param[0] = new SqlParameter("@brid", Session["BrBrid"]);
                param[1] = new SqlParameter("@classid", ddlClass.SelectedValue);
                param[2] = new SqlParameter("@cwsid", ddlSection.SelectedValue);
                param[3] = new SqlParameter("@monthid", DDLMonth.SelectedValue);

                param[4] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                param[4].Direction = ParameterDirection.Output;

                DataTable dt = objDUT.GetDataTableSP(param, "usp_monthlyAttendenceReport");
                ViewState["dt"] = dt;
                if (dt.Rows.Count > 0)
                {
                    GridView1.Visible = true;
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
        }
        else
        {
            GridView1.Visible = false;

            ddlSection.Focus();
        }
    }

    public bool Validate1()
    {
        if (ddlClass.SelectedValue == "--Select Class--")
        {
            Utility.ViewAlertMessage(Page, "please select class first");
            ddlClass.Attributes.Add("class", "abhi");
            ddlSection.Items.Clear();
            ddlClass.Items.Clear();
            DDL_Class_Bind();
            DDLMonth.SelectedValue = "--Select Month--";
            ddlClass.Focus();
            return false;
        }
        if (ddlSection.SelectedValue == "--Select Section--")
        {
            Utility.ViewAlertMessage(Page, "please select section first");
            ddlSection.Attributes.Remove("class");
            ddlClass.Items.Clear();
            ddlSection.Items.Clear();
            DDL_Class_Bind();
            DDLMonth.SelectedValue = "--Select Month--";
            ddlSection.CssClass = "abhi";
            ddlSection.Focus();

            return false;
        }
        if (DDLMonth.SelectedValue == "--Select Month--")
        {
            Utility.ViewAlertMessage(Page, "please select Month.");
            ddlClass.Items.Clear();
            ddlSection.Items.Clear();
            DDL_Class_Bind();
            DDLMonth.SelectedValue = "--Select Month--";
            return false;
        }
        return true;
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        dtrow = (DataTable)ViewState["dt"];
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (Convert.ToInt32(ViewState["days"]) == 31)
            {
                HiddenField hd1 = (HiddenField)e.Row.FindControl("hd1");
                Label lbld31 = (Label)e.Row.FindControl("lbld31");
                Label lbld30 = (Label)e.Row.FindControl("lbld30");
                Label lbld29 = (Label)e.Row.FindControl("lbld29");
                DataRow[] row = dtrow.Select("[id]='" + hd1.Value + "'");
                //lbld31.Text =Convert.ToString(row["d31"]);
                lbld31.Text = Convert.ToString(row[0].ItemArray[32]);
                if (lbld31.Text == "P")
                {
                    d31 = d31 + 1;
                }
                lbld30.Text = Convert.ToString(row[0].ItemArray[31]);
                if (lbld30.Text == "P")
                {
                    d30 = d30 + 1;
                }
                lbld29.Text = Convert.ToString(row[0].ItemArray[30]);
                if (lbld29.Text == "P")
                {
                    d29 = d29 + 1;
                }
            }
            if (Convert.ToInt32(ViewState["days"]) == 30)
            {
                HiddenField hd1 = (HiddenField)e.Row.FindControl("hd1");
                //Label lbld31 = (Label)e.Row.FindControl("lbld31");
                Label lbld30 = (Label)e.Row.FindControl("lbld30");
                Label lbld29 = (Label)e.Row.FindControl("lbld29");
                DataRow[] row = dtrow.Select("[id]='" + hd1.Value + "'");
                //lbld31.Text =Convert.ToString(row["d31"]);
                // lbld31.Text = Convert.ToString(row[0].ItemArray[32]);
                lbld30.Text = Convert.ToString(row[0].ItemArray[31]);
                lbld29.Text = Convert.ToString(row[0].ItemArray[30]);

                if (lbld30.Text == "P")
                {
                    d30 = d30 + 1;
                }

                if (lbld29.Text == "P")
                {
                    d29 = d29 + 1;
                }
            }
            if (Convert.ToInt32(ViewState["days"]) == 29)
            {
                HiddenField hd1 = (HiddenField)e.Row.FindControl("hd1");
                //Label lbld31 = (Label)e.Row.FindControl("lbld31");
                // Label lbld30 = (Label)e.Row.FindControl("lbld30");
                Label lbld29 = (Label)e.Row.FindControl("lbld29");
                DataRow[] row = dtrow.Select("[id]='" + hd1.Value + "'");
                //lbld31.Text =Convert.ToString(row["d31"]);
                // lbld31.Text = Convert.ToString(row[0].ItemArray[32]);
                // lbld30.Text = Convert.ToString(row[0].ItemArray[31]);
                lbld29.Text = Convert.ToString(row[0].ItemArray[30]);
                if (lbld29.Text == "P")
                {
                    d29 = d29 + 1;
                }
            }
            //Count 28th day Attendence
            Label lbld28 = (Label)e.Row.FindControl("lbld28");
            if (lbld28.Text == "P")
            {
                d28 = d28 + 1;
            }
            //Count 27th day Attendence
            Label lbld27 = (Label)e.Row.FindControl("lbld27");
            if (lbld27.Text == "P")
            {
                d27 = d27 + 1;
            }
            //Count 26th day Attendence
            Label lbld26 = (Label)e.Row.FindControl("lbld26");
            if (lbld26.Text == "P")
            {
                d26 = d26 + 1;
            }
            //Count 25th day Attendence
            Label lbld25 = (Label)e.Row.FindControl("lbld25");
            if (lbld25.Text == "P")
            {
                d25 = d25 + 1;
            }
            //Count 24th day Attendence
            Label lbld24 = (Label)e.Row.FindControl("lbld24");
            if (lbld24.Text == "P")
            {
                d24 = d24 + 1;
            }
            //Count 23th day Attendence
            Label lbld23 = (Label)e.Row.FindControl("lbld23");
            if (lbld23.Text == "P")
            {
                d23 = d23 + 1;
            }
            //Count 28th day Attendence
            Label lbld22 = (Label)e.Row.FindControl("lbld22");
            if (lbld22.Text == "P")
            {
                d22 = d22 + 1;
            }
            //Count 21th day Attendence
            Label lbld21 = (Label)e.Row.FindControl("lbld21");
            if (lbld21.Text == "P")
            {
                d21 = d21 + 1;
            }

            //Count 20th day Attendence
            Label lbld20 = (Label)e.Row.FindControl("lbld20");
            if (lbld20.Text == "P")
            {
                d20 = d20 + 1;
            }
            //Count 21th day Attendence
            Label lbld19 = (Label)e.Row.FindControl("lbld19");
            if (lbld19.Text == "P")
            {
                d19 = d19 + 1;
            }
            //Count 18th day Attendence
            Label lbld18 = (Label)e.Row.FindControl("lbld18");
            if (lbld18.Text == "P")
            {
                d18 = d18 + 1;
            }
            //Count 17th day Attendence
            Label lbld17 = (Label)e.Row.FindControl("lbld17");
            if (lbld17.Text == "P")
            {
                d17 = d17 + 1;
            }
            //Count 21th day Attendence
            Label lbld16 = (Label)e.Row.FindControl("lbld16");
            if (lbld16.Text == "P")
            {
                d16 = d16 + 1;
            }
            //Count 21th day Attendence
            Label lbld15 = (Label)e.Row.FindControl("lbld15");
            if (lbld15.Text == "P")
            {
                d15 = d15 + 1;
            }
            //Count 21th day Attendence
            Label lbld14 = (Label)e.Row.FindControl("lbld14");
            if (lbld14.Text == "P")
            {
                d14 = d14 + 1;
            }
            //Count 13th day Attendence
            Label lbld13 = (Label)e.Row.FindControl("lbld13");
            if (lbld13.Text == "P")
            {
                d13 = d13 + 1;
            }
            //Count 12th day Attendence
            Label lbld12 = (Label)e.Row.FindControl("lbld12");
            if (lbld12.Text == "P")
            {
                d12 = d12 + 1;
            }
            //Count 21th day Attendence
            Label lbld11 = (Label)e.Row.FindControl("lbld11");
            if (lbld11.Text == "P")
            {
                d11 = d11 + 1;
            }

            //Count 1th day Attendence
            Label lbld1 = (Label)e.Row.FindControl("lbld1");
            if (lbld1.Text == "P")
            {
                d1 = d1 + 1;
            }
            //Count 2th day Attendence
            Label lbld2 = (Label)e.Row.FindControl("lbld2");
            if (lbld2.Text == "P")
            {
                d2 = d2 + 1;
            }
            //Count 3th day Attendence
            Label lbld3 = (Label)e.Row.FindControl("lbld3");
            if (lbld3.Text == "P")
            {
                d3 = d3 + 1;
            }
            //Count 4th day Attendence
            Label lbld4 = (Label)e.Row.FindControl("lbld4");
            if (lbld4.Text == "P")
            {
                d4 = d4 + 1;
            }
            //Count 5th day Attendence
            Label lbld5 = (Label)e.Row.FindControl("lbld5");
            if (lbld5.Text == "P")
            {
                d5 = d5 + 1;
            }
            //Count 21th day Attendence
            Label lbld6 = (Label)e.Row.FindControl("lbld6");
            if (lbld6.Text == "P")
            {
                d6 = d6 + 1;
            }
            //Count 8th day Attendence
            Label lbld7 = (Label)e.Row.FindControl("lbld7");
            if (lbld7.Text == "P")
            {
                d7 = d7 + 1;
            }

            //Count 8th day Attendence
            Label lbld8 = (Label)e.Row.FindControl("lbld8");
            if (lbld8.Text == "P")
            {
                d8 = d8 + 1;
            }

            //Count 9th day Attendence
            Label lbld9 = (Label)e.Row.FindControl("lbld9");
            if (lbld9.Text == "P")
            {
                d9 = d9 + 1;
            }
            //Count 12th day Attendence
            Label lbld10 = (Label)e.Row.FindControl("lbld10");
            if (lbld10.Text == "P")
            {
                d10 = d10 + 1;
            }
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            //******* total credit
            Label lblFd1 = (Label)e.Row.FindControl("lblFd1");
            lblFd1.Text = d1.ToString();

            Label lblFd2 = (Label)e.Row.FindControl("lblFd2");
            lblFd2.Text = d2.ToString();

            Label lblFd3 = (Label)e.Row.FindControl("lblFd3");
            lblFd3.Text = d3.ToString();

            Label lblFd4 = (Label)e.Row.FindControl("lblFd4");
            lblFd4.Text = d4.ToString();

            Label lblFd5 = (Label)e.Row.FindControl("lblFd5");
            lblFd5.Text = d5.ToString();

            Label lblFd6 = (Label)e.Row.FindControl("lblFd6");
            lblFd6.Text = d6.ToString();

            Label lblFd7 = (Label)e.Row.FindControl("lblFd7");
            lblFd7.Text = d7.ToString();

            Label lblFd8 = (Label)e.Row.FindControl("lblFd8");
            lblFd8.Text = d8.ToString();

            Label lblFd9 = (Label)e.Row.FindControl("lblFd9");
            lblFd9.Text = d9.ToString();

            Label lblFd10 = (Label)e.Row.FindControl("lblFd10");
            lblFd10.Text = d10.ToString();

            Label lblFd11 = (Label)e.Row.FindControl("lblFd11");
            lblFd11.Text = d11.ToString();

            Label lblFd12 = (Label)e.Row.FindControl("lblFd12");
            lblFd12.Text = d12.ToString();

            Label lblFd13 = (Label)e.Row.FindControl("lblFd13");
            lblFd13.Text = d13.ToString();

            Label lblFd14 = (Label)e.Row.FindControl("lblFd14");
            lblFd14.Text = d14.ToString();

            Label lblFd15 = (Label)e.Row.FindControl("lblFd15");
            lblFd15.Text = d15.ToString();

            Label lblFd16 = (Label)e.Row.FindControl("lblFd16");
            lblFd16.Text = d16.ToString();

            Label lblFd17 = (Label)e.Row.FindControl("lblFd17");
            lblFd17.Text = d17.ToString();

            Label lblFd18 = (Label)e.Row.FindControl("lblFd18");
            lblFd18.Text = d18.ToString();

            Label lblFd19 = (Label)e.Row.FindControl("lblFd19");
            lblFd19.Text = d19.ToString();

            Label lblFd20 = (Label)e.Row.FindControl("lblFd20");
            lblFd20.Text = d20.ToString();

            Label lblFd21 = (Label)e.Row.FindControl("lblFd21");
            lblFd21.Text = d21.ToString();

            Label lblFd22 = (Label)e.Row.FindControl("lblFd22");
            lblFd22.Text = d22.ToString();

            Label lblFd23 = (Label)e.Row.FindControl("lblFd23");
            lblFd23.Text = d23.ToString();

            Label lblFd24 = (Label)e.Row.FindControl("lblFd24");
            lblFd24.Text = d24.ToString();

            Label lblFd25 = (Label)e.Row.FindControl("lblFd25");
            lblFd25.Text = d25.ToString();

            Label lblFd26 = (Label)e.Row.FindControl("lblFd26");
            lblFd26.Text = d26.ToString();

            Label lblFd27 = (Label)e.Row.FindControl("lblFd27");
            lblFd27.Text = d27.ToString();

            Label lblFd28 = (Label)e.Row.FindControl("lblFd28");
            lblFd28.Text = d28.ToString();

            Label lblFd29 = (Label)e.Row.FindControl("lblFd29");
            lblFd29.Text = d29.ToString();

            Label lblFd30 = (Label)e.Row.FindControl("lblFd30");
            lblFd30.Text = d30.ToString();

            Label lblFd31 = (Label)e.Row.FindControl("lblFd31");
            lblFd31.Text = d31.ToString();
        }
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        Response.Redirect("DaywiseAttendence.aspx");
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
        Response.Redirect("AttendanceReport2.aspx");
    }

    protected void btn3_Click(object sender, EventArgs e)
    {
        Response.Redirect("StudentReport.aspx");
    }
}