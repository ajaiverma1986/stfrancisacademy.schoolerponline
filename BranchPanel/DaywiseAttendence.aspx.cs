using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_DaywiseAttendence : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();
    private Utility objUT = new Utility();
    private CommonClass CommmonOBJ = new CommonClass();
    private string PageName = "", url = "";
    private SqlParameter[] param = new SqlParameter[4];
    private int totalStudent = 0, PStudent = 0, AStudent = 0, days = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        txtDAyname.Text = "Day";
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        // PageName = Utility.GetCurrentPagename();

        if (!IsPostBack)
        {
            //tr1.Visible = false;
            bind_month();
        }
    }

    private void bind_month()
    {
        DataTable dt = CommmonOBJ.Dll("MonthName");
        DDLMonth.DataSource = dt;
        DDLMonth.DataBind();
        DDLMonth.DataTextField = "MonthName";
        DDLMonth.DataValueField = "MonthId";
        DDLMonth.DataBind();

        DDLMonth.Items.Insert(0, "--Select--");
        ddldays.Items.Insert(0, "--Date--");
    }

    protected void DDLMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddldays.SelectedValue = "--Date--";
        txtDAyname.Text = "Day";
        if (DDLMonth.SelectedValue != "--Select--")
        {
            ddldays.Enabled = true;
            days = CommonClass.Scaler("getdays", Convert.ToInt32(DDLMonth.SelectedValue));
            Session["Month"] = (DDLMonth.SelectedValue);
            if (objUT.isLeapYear(CommonClass.Scaler("getYear")))
            {
                if (DDLMonth.SelectedValue == "11")
                {
                    days = 29;
                }
            }
            ddldays.Items.Clear();
            ddldays.Items.Insert(0, "--Date--");
            for (int i = 1; i <= days; i++)
            {
                ddldays.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
        }
        else
        {
            ddldays.SelectedValue = "--Date--";
            txtDAyname.Text = "Day";
            ddldays.Enabled = false;
        }
    }

    protected void ddldays_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddldays.SelectedValue != "--Date--")
        {
            Session["Date"] = ddldays.SelectedItem.Text;
            string date = ddldays.SelectedItem.Text + "-" + DDLMonth.SelectedItem.Text + "-" + CommonClass.Scaler("getYear");
            string dayName = CommmonOBJ.stringType("dayName", date);
            txtDAyname.Text = dayName;
            Session["Day"] = dayName;
            if (dayName == "Sunday")
            {
                Utility.ViewAlertMessage(Page, "Sorry, the selected day is holiday.");
                ddldays.SelectedValue = "--Date--";
                txtDAyname.Text = "Day";
                // tr1.Visible = false;
                GrdAttendence.DataSource = null;
                GrdAttendence.DataBind();
                return;
            }
            //Check Whether Attendence has been taken or not
            //string query1 = "select isnull(COUNT(*),0) from tbl_attendance where FYID=" + CommmonOBJ.Scaler("ActiveAcademicYear") + " and BRID=" + Session["BrBrid"] + " and MONTHID=" + DDLMonth.SelectedValue + " and CLASSID=" + DDLClass.SelectedValue + " and CWSID=" + DDLSection.SelectedValue + " and DATE=" + ddldays.SelectedValue;
            // if (Convert.ToInt32(objDUT.GetScalar(query1)) > 0)
            // {
            // Utility.ViewAlertMessage(Page, "Sorry, Attendence has been taken already of selected day");
            // ddldays.SelectedValue = "--Date--";
            // GrdAttendence.DataSource = null;
            // GrdAttendence.DataBind();
            // return;
            // }
            string query = "usp_attendenceReport";
            param[0] = new SqlParameter("@brid", Session["BrBrid"]);
            param[1] = new SqlParameter("@monthid", DDLMonth.SelectedValue);
            param[2] = new SqlParameter("@date", ddldays.SelectedValue);
            param[3] = new SqlParameter("@intResult", Convert.ToInt32("0"));
            param[3].Direction = ParameterDirection.Output;

            DataTable dt = objDUT.GetDataTableSP(param, query);
            if (dt.Rows.Count > 0)
            {
                //tr1.Visible = true;
                GrdAttendence.DataSource = dt;
                GrdAttendence.DataBind();
            }
            else
            {
                Utility.ViewAlertMessage(Page, "Sorry, attendance is yet to be taken on this date.");
                //tr1.Visible = true;
                GrdAttendence.DataSource = null;
                GrdAttendence.DataBind();
            }
        }
        else
        {
            txtDAyname.Text = "DAY";
        }
    }

    protected void GrdAttendence_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //******* total student
            LinkButton lbl_credit = (LinkButton)e.Row.FindControl("lblTotal");
            totalStudent += Convert.ToInt32(lbl_credit.Text);

            //******* totalPresent student
            Label lbl_debit = (Label)e.Row.FindControl("lblPStudent");
            PStudent += Convert.ToInt32(lbl_debit.Text);

            //******* total Absent Student
            Label lbl_balanced = (Label)e.Row.FindControl("lblAstudent");
            AStudent += Convert.ToInt32(lbl_balanced.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            //******* total credit
            Label lblamount = (Label)e.Row.FindControl("lbltotalF");
            lblamount.Text = totalStudent.ToString();

            //******* total debit
            Label lbl_totaldebit = (Label)e.Row.FindControl("lbltotalPF");
            lbl_totaldebit.Text = Convert.ToString(PStudent);

            //******* total balanced
            Label lbl_Totalbalanced = (Label)e.Row.FindControl("lbltotalAF");
            lbl_Totalbalanced.Text = Convert.ToString(AStudent);
        }
    }

    protected void GrdAttendence_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "View")
        {
            int secID = Convert.ToInt32(e.CommandArgument);
            string qu1 = "select classid from classwithsection where cwsid=" + secID + "";
            Session["ClassID"] = Convert.ToInt32(objDUT.GetScalar(qu1));
            Response.Redirect("Attendence1.aspx?cwsid=" + secID);
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