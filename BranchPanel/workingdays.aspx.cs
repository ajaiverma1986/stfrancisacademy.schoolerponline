using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class BranchPanel_workingdays : System.Web.UI.Page
{
    private string PageName;
    private Utility objut = new Utility();
    private DataUtility objDUT = new DataUtility();
    private string url;

    protected void Page_Load(object sender, EventArgs e)
    {
        //url = Request.Url.ToString();
        //if (Session["User"] == null)
        //{
        //    Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        //}
        //PageName = Utility.GetCurrentPagename();

        //if (!objut.isAccessible(((User)Session["User"]).UserID, PageName))
        //{
        //    Response.Redirect("~/Login.aspx");
        //}
        //this.Page.Title = ConfigurationManager.AppSettings["titleBar"];
        if (!IsPostBack)
        {
            bindgrid();
        }
    }

    private void bindgrid()
    {
        int count = Convert.ToInt32(objDUT.GetScalar("select count(*) from workingdays where brid=" + Session["BrBrid"]));
        if (count > 0)
        {
            ViewState["id"] = 1;
            DataTable dt = new DataTable();
            dt = objDUT.GetDataTable("select * from workingdays where brid=" + Session["BrBrid"]);
            GridStateDetail.DataSource = dt;
            GridStateDetail.DataBind();
        }
        else
        {
            DataTable dt = new DataTable();
            dt = objDUT.GetDataTable("select * from days");
            GridStateDetail.DataSource = dt;
            GridStateDetail.DataBind();
        }
    }

    protected void GridStateDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (Convert.ToInt32(ViewState["id"]) > 0)
            {
                string day = e.Row.FindControl("lbldayname").ToString();
            }
        }
    }
}