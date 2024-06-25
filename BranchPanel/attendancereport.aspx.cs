using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_attendancereport : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();
    private Utility objUT = new Utility();

    private SqlCommand cmd = new SqlCommand();
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DDL_Class_Bind();
            bind_month();
            DDL_Section_Bind();

            //this.PopulateStudentDetails();
        }
    }

    private void DDL_Class_Bind()
    {
        string query = "select classid,Classname from ClassBranch_master where BranchId=10 and Status=1";
        DataTable dt = objDUT.GetDataTable(query);
        DDLClass.DataSource = dt;
        DDLClass.DataBind();
        DDLClass.DataTextField = "Classname";
        DDLClass.DataValueField = "classid";
        DDLClass.DataBind();

        DDLClass.Items.Insert(0, "--Select Class--");

        //DDLClass.Items.Add(0, "--Select--");
    }

    private void DDL_Section_Bind()
    {
        string query = "select cwsid,sectionname from classwithsection where  BranchId=10 and Status=1 ";
        DataTable dt = objDUT.GetDataTable(query);
        DDLSection.DataSource = dt;
        DDLSection.DataBind();
        DDLSection.DataTextField = "sectionname";
        DDLSection.DataValueField = "cwsid";
        DDLSection.DataBind();
        DDLSection.Items.Insert(0, "--Select Section--");
    }

    private void bind_month()
    {
        string query = "select MonthId, MonthName from Month_name ";
        //SqlDataAdapter adpt = new SqlDataAdapter(query, con);
        DataTable dt = objDUT.GetDataTable(query);
        DDLMonth.DataSource = dt;
        DDLMonth.DataBind();
        DDLMonth.DataTextField = "MonthName";
        DDLMonth.DataValueField = "MonthId";
        DDLMonth.DataBind();

        DDLMonth.Items.Insert(0, "--Select Month--");
    }

    //public void GridViewBind()
    //{
    //    SqlCommand cmd = new SqlCommand("select * from tbl_attendance where CLASSID=" + DDLClass.SelectedValue + "", con);
    //    SqlDataAdapter da = new SqlDataAdapter(cmd);
    //    DataSet ds = new DataSet();
    //    da.Fill(ds, "tbl_attendance");
    //    GRD_ATT_REPORT.DataSource = ds.Tables["tbl_attendance"];
    //    GRD_ATT_REPORT.DataBind();
    //}

    private void GridViewBind()
    {
        string str = "select * from tbl_Admission where BrId=10 and classid=" + DDLClass.SelectedValue + "";
        DataTable dt = new DataTable();
        dt = objDUT.GetDataTable(str);
        GRD_ATT_REPORT.DataSource = dt;
        GRD_ATT_REPORT.DataBind();
        if (dt.Rows.Count == 0)
        {
            dt.Rows.Add(dt.NewRow());
            GRD_ATT_REPORT.DataSource = dt;
            GRD_ATT_REPORT.DataBind();
            int columncount = GRD_ATT_REPORT.Rows[0].Cells.Count;
            GRD_ATT_REPORT.Rows[0].Cells.Clear();
            GRD_ATT_REPORT.Rows[0].Cells.Add(new TableCell());
            GRD_ATT_REPORT.Rows[0].Cells[0].ColumnSpan = columncount;
            GRD_ATT_REPORT.Rows[0].Cells[0].Text = "No Records Found...";
        }
        else
        {
            GRD_ATT_REPORT.DataSource = dt;
            GRD_ATT_REPORT.DataBind();
        }
    }

    private void GridViewBind2()
    {
        string str = "select * from tbl_attendance where BrId=10 and classid=" + DDLClass.SelectedValue + " and CWsid =" + DDLSection.SelectedValue + "";
        DataTable dt = new DataTable();
        dt = objDUT.GetDataTable(str);
        GRD_ATT_REPORT.DataSource = dt;
        GRD_ATT_REPORT.DataBind();
        if (dt.Rows.Count == 0)
        {
            dt.Rows.Add(dt.NewRow());
            GRD_ATT_REPORT.DataSource = dt;
            GRD_ATT_REPORT.DataBind();
            int columncount = GRD_ATT_REPORT.Rows[0].Cells.Count;
            GRD_ATT_REPORT.Rows[0].Cells.Clear();
            GRD_ATT_REPORT.Rows[0].Cells.Add(new TableCell());
            GRD_ATT_REPORT.Rows[0].Cells[0].ColumnSpan = columncount;
            GRD_ATT_REPORT.Rows[0].Cells[0].Text = "No Records Found...";
        }
        else
        {
            GRD_ATT_REPORT.DataSource = dt;
            GRD_ATT_REPORT.DataBind();
        }
    }

    private void GridViewBind3()
    {
        string str = "select * from tbl_Admission where BrId=10 and classid=" + DDLClass.SelectedValue + " and CWsid =" + DDLSection.SelectedValue + " and Monthid=" + DDLMonth.SelectedValue + " ";
        DataTable dt = new DataTable();
        dt = objDUT.GetDataTable(str);
        GRD_ATT_REPORT.DataSource = dt;
        GRD_ATT_REPORT.DataBind();
        if (dt.Rows.Count == 0)
        {
            dt.Rows.Add(dt.NewRow());
            GRD_ATT_REPORT.DataSource = dt;
            GRD_ATT_REPORT.DataBind();
            int columncount = GRD_ATT_REPORT.Rows[0].Cells.Count;
            GRD_ATT_REPORT.Rows[0].Cells.Clear();
            GRD_ATT_REPORT.Rows[0].Cells.Add(new TableCell());
            GRD_ATT_REPORT.Rows[0].Cells[0].ColumnSpan = columncount;
            GRD_ATT_REPORT.Rows[0].Cells[0].Text = "No Records Found...";
        }
        else
        {
            GRD_ATT_REPORT.DataSource = dt;
            GRD_ATT_REPORT.DataBind();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (ViewState["ddl"].ToString() == "1")
        {
            this.GridViewBind();
        }
        else if (ViewState["ddl"] == "2")
        {
            this.GridViewBind2();
        }
        else if (ViewState["ddl"] == "3")
        {
            this.GridViewBind3();
        }
    }

    protected void DDLClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        ViewState["ddl"] = "1";
    }

    protected void DDLSection_SelectedIndexChanged(object sender, EventArgs e)
    {
        ViewState["ddl"] = "2";
    }

    protected void DDLMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        ViewState["ddl"] = "3";
    }
}