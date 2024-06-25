using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_exam_report : System.Web.UI.Page
{
    private string query = "", query1 = "", classid = "";
    private DataUtility objdut = new DataUtility();
    private SqlParameter[] param = new SqlParameter[5];
    private DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tblmaintable.Visible = true;
            tblMain.Visible = false;
            ddlfill();
            Exam_Sechudle();
        }
    }

    private void ddlfill()
    {
        query1 = "select eid,examname from exam_name where status=1";
        dt = objdut.GetDataTable(query1);
        if (dt.Rows.Count > 0)
        {
            ddlexamname.DataTextField = "examname";
            ddlexamname.DataValueField = "eid";
            ddlexamname.DataSource = dt;
            ddlexamname.DataBind();
            ddlexamname.Items.Insert(0, new ListItem("Select Exam", "0"));
        }
        else
        {
            ddlexamname.Items.Insert(0, new ListItem("Select Exam", "0"));
        }
        dt.Dispose();
    }

    protected void btnview_Click(object sender, EventArgs e)
    {
        tblmaintable.Visible = false;
        param[0] = new SqlParameter("@eid", ddlexamname.SelectedValue);
        param[1] = new SqlParameter("@brid", Session["BrBrid"]);
        param[2] = new SqlParameter("@outClass", SqlDbType.VarChar, 500, "");
        param[2].Direction = ParameterDirection.Output;

        param[3] = new SqlParameter("@outstartdate", SqlDbType.Date, 0, "");
        param[3].Direction = ParameterDirection.Output;

        param[4] = new SqlParameter("@outenddate", SqlDbType.Date, 0, "");
        param[4].Direction = ParameterDirection.Output;

        //  string str = "select *, from exam_SchemReport where brid=1 and status=1 and eid=1";

        DataTable dt = objdut.GetDataTableSP(param, "usp_examreport");
        lblclss.Text = param[2].Value.ToString();
        lbfdate.Text = param[3].Value.ToString();
        lbtdate.Text = param[4].Value.ToString();

        if (dt.Rows.Count > 0)
        {
            tblMain.Visible = true;
            fidetail();
            grd1.DataSource = dt;
            grd1.DataBind();
        }
    }

    private void fidetail()
    {
        string str = Convert.ToString(objdut.GetScalar("select FYName from financial_Year where isActive=1"));

        lblexma.Text = ddlexamname.SelectedItem.Text;
        lblexma.Text = lblexma.Text + " " + "Schedule" + "" + " " + "(" + str + ")";
    }

    protected void Exam_Sechudle()
    {
        DataTable gridexamsechudlereport = objdut.GetDataTableSP("[dbo].[usp_Exam_sechudle]");
        gridexamdefaultsechudle.DataSource = gridexamsechudlereport;
        gridexamdefaultsechudle.DataBind();
    }
}