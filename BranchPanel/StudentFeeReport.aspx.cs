using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_StudentFeeReport : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private Utility objut = new Utility();
    private CommonClass CommonClass = new CommonClass();
    private DataTable dt, dt1;
    private SqlParameter[] param = new SqlParameter[4];
    private string url, query, query1, query2;
    private static int academicyear_id = 0;
    private int ID, monthid = 0, ourmonthid = 0;
    private double total_debit = 0, total_credit = 0, total_balanced = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (Session["Adid"] == null)
        {
            Response.Redirect("MasterFee.aspx");
        }
        if (!IsPostBack)
        {
            academicyear_id = CommonClass.Scaler("ActiveAcademicYear");
            ViewState["academicYearID"] = academicyear_id;
            Details();
            fillgrid12();
        }
    }

    protected void Details()
    {
        ID = Convert.ToInt32(Session["Adid"]);

        dt = CommonClass.examMaster("feereportbyid", Convert.ToInt32(Session["Adid"]), Convert.ToInt32(ViewState["academicYearID"]), Convert.ToInt32(Session["BrBrid"]));

        //query = @"select (ta.adid) as adid,(ta.ADNO) as adno,(ta.FfirstName+' '+ta.FLastName) as fname,(ta.ADMIID) as admissionid,(ta.FirstName+' '+ta.LastName)as name,(ta.ApplyClass+' '+ta.section)as class,isnull(SUM(sa.Credit),0) as TotalMoney,isnull(SUM(sa.debit),0) as TotalPaid,
        //((isnull((SUM(sa.credit)-SUM(sa.debit)),0))) as TotalDue from student_Account sa left outer join tbl_Admission ta
        //on sa.studentid=ta.adid and sa.Brid=ta.brid
        //where ta.brid=" + Convert.ToDouble(Session["BrBrid"]) + "  and ta.adid=" + ID + " and sa.academicyearid=" + Convert.ToInt32(ViewState["academicYearID"]) + "  group by ta.ADMIID,ta.FirstName,ta.LastName,ta.ApplyClass,ta.section,sa.studentid,ta.ADNO,ta.adid,ta.FfirstName,ta.FLastName";
        //dt = objdut.GetDataTable(query);
        GridView1.DataSource = dt;

        if (dt.Rows.Count > 0)
        {
            monthid = Convert.ToInt32(objdut.GetScalar("select DATEPART(mm,getdate())"));
            if (monthid > 3)
            {
                ourmonthid = monthid - 3;
            }
            else
            {
                ourmonthid = monthid + 9;
            }
            lblstname.Text = dt.Rows[0]["name"].ToString();
            lblClassName.Text = dt.Rows[0]["class"].ToString();
            lblTotalFeeAmount.Text = "Rs " + string.Format("{0:f}", dt.Rows[0]["TotalMoney"]);
            lblReceivedAmount.Text = "Rs " + string.Format("{0:f}", dt.Rows[0]["TotalPaid"]);
            lblPayableAmount.Text = "Rs " + string.Format("{0:f}", Convert.ToDouble(objdut.GetScalar("select isnull(SUM(credit),0) as credit from student_Account where studentid=" + ID + " and academicyearid=" + Convert.ToInt32(ViewState["academicYearID"]) + " and paymonth<=" + ourmonthid)));// "Rs 0.00";
            lblDueAmount.Text = "Rs " + string.Format("{0:f}", dt.Rows[0]["TotalDue"]);
            lblFather.Text = dt.Rows[0]["fname"].ToString();
            lblid.Text = dt.Rows[0]["adno"].ToString();
        }
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        Session["Adid"] = null;
        Response.Redirect("RecentFee.aspx");
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
        Session["Adid"] = null;
        Response.Redirect("MonthWiseFee.aspx");
    }

    protected void btn3_Click(object sender, EventArgs e)
    {
        Session["Adid"] = null;
        Response.Redirect("ClassFee.aspx");
    }

    protected void btn4_Click(object sender, EventArgs e)
    {
        Session["Adid"] = null;
        Response.Redirect("FeeDuration.aspx");
    }

    protected void btn5_Click(object sender, EventArgs e)
    {
        Session["Adid"] = null;
        Response.Redirect("getDistID.aspx?type=FSR");
    }

    public void fillgrid12()
    {
        query1 = "select MonthId,MonthName from Month_name order by MonthId";
        dt = objdut.GetDataTable(query1);
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hd1 = (HiddenField)e.Row.FindControl("hd1");
            GridView gv2 = (GridView)e.Row.FindControl("gv2");
            query2 = "usp_showfee1";
            param[0] = new SqlParameter("@brid", Session["BrBrid"]);
            param[1] = new SqlParameter("@studentid", Convert.ToInt32(Session["Adid"]));
            param[2] = new SqlParameter("@Paymonth", hd1.Value);
            param[3] = new SqlParameter("@intresult", SqlDbType.Int);
            param[3].Direction = ParameterDirection.Output;
            dt1 = objdut.GetDataTableSP(param, query2);
            if (dt1.Rows.Count > 0)
            {
                gv2.DataSource = dt1;
                gv2.DataBind();
            }
        }
    }

    protected void gv2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //******* total credit
            Label lbl_credit = (Label)e.Row.FindControl("lblmessage");
            total_credit += Convert.ToDouble(lbl_credit.Text);

            //*******  debit
            HiddenField lbl_debit = (HiddenField)e.Row.FindControl("hd1");
            total_debit = Convert.ToDouble(lbl_debit.Value);

            //******* total balanced
            Label lbl_balanced = (Label)e.Row.FindControl("lblbalanced");
            total_balanced += Convert.ToDouble(lbl_balanced.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            //******* total credit
            Label lblamount = (Label)e.Row.FindControl("lblcredit");
            lblamount.Text = total_credit.ToString();

            //******* total debit
            Label lbl_totaldebit = (Label)e.Row.FindControl("lbldebit");
            lbl_totaldebit.Text = Convert.ToString(total_debit);

            //******* total balanced
            Label lbl_Totalbalanced = (Label)e.Row.FindControl("lblBalancedF");
            lbl_Totalbalanced.Text = string.Format("{0:f}", (Convert.ToDouble(lblamount.Text) - (Convert.ToDouble(lbl_totaldebit.Text))));

            total_debit = 0; total_credit = 0; total_balanced = 0;
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Session["Adid"] = null;
        Response.Redirect("getDistID.aspx?type=FSR");
    }
}