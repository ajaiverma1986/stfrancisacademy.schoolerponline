using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_duelist : System.Web.UI.Page
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

        dt = objdut.GetDataTableSP(param, "usp_nextdue");
        if (dt.Rows.Count > 0)
        {
            gridduelist.DataSource = dt;
            gridduelist.DataBind();
        }
        else
        {
            gridduelist.EmptyDataText = "No Record found.!";
            gridduelist.DataSource = null;
            gridduelist.DataBind();
        }
    }

    [WebMethod]
    public static int getregno(string admno)
    {
        Utility objUT = new Utility();
        int ret = Convert.ToInt32(CommonClass.scaler("getstudentregno", Convert.ToString(admno), Convert.ToInt32(HttpContext.Current.Session["BrBrid"])));
        HttpContext.Current.Session["stue"] = ret;
        return ret;
    }
}