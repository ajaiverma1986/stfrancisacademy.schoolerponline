using System;
using System.Data;
using System.Data.SqlClient;

public partial class BranchPanel_cheque_list : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private string url;
    private DataTable dt;
    private int totalpage = 0, countrecords = 0, i = 0;
    private int page;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }

        if (!IsPostBack)
        {
            bindgrid();
        }
    }

    public void bindgrid()
    {
        SqlParameter[] param = new SqlParameter[1];

        param[0] = new SqlParameter("@brid", Session["BrBrid"]);

        dt = objdut.GetDataTableSP(param, "usp_getchequelist");
        if (dt.Rows.Count > 0)
        {
            gridcheque.DataSource = dt;
            gridcheque.DataBind();
        }
        else
        {
            gridcheque.EmptyDataText = "No Record found.!";
            gridcheque.DataSource = null;
            gridcheque.DataBind();
        }
    }
}