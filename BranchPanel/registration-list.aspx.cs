using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_registration_list : System.Web.UI.Page
{
    private CommonClass commonobj = new CommonClass();
    private DataUtility objDUT = new DataUtility();
    private DataTable dt;
    private int regid = 0;
    private static int brid = 0;
    private DataSet ds;
    public static int fyid = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if ((Session["BrBrid"]).ToString() != null && Convert.ToInt32(Session["BrBrid"]) != 0)
            {
                brid = Convert.ToInt32(Session["BrBrid"]);
                fyid = CommonClass.Scaler("ActiveAcademicYear");
            }

            if (!IsPostBack)
            {
                Fill_Grid();
                bind_class();
            }
        }
        catch (Exception ex)
        {
        }
    }
    private void Fill_Grid()
    {
        SqlParameter[] param = new SqlParameter[4];

        param[0] = new SqlParameter("@branchID", SqlDbType.VarChar, 50);
        param[0].Value = (Session["BrBrid"]).ToString();

        param[1] = new SqlParameter("@pagesize", SqlDbType.Int);
        param[1].Value = 20;

        param[2] = new SqlParameter("@pageno", SqlDbType.Int);
        param[2].Value = 1;

        param[3] = new SqlParameter("@fyid", SqlDbType.Int);
        param[3].Value = fyid;

        ds = objDUT.GetDataSetSP(param, "usp_Get_Student_List");
        if (ds.Tables[0].Rows.Count > 0)
        {
            gvdetails.DataSource = ds.Tables[0];
            gvdetails.DataBind();
            hfpages.Value = ds.Tables[1].Rows[0]["pages"].ToString();
        }
        else
        {
            gvdetails.EmptyDataText = "No Record Found";
            gvdetails.DataBind();
        }

        DataTable dt = objDUT.GetDataTable("select FYID, FYName from financial_Year ");
        ddlfy.DataSource = dt;
        ddlfy.DataValueField = "FYID";
        ddlfy.DataTextField = "FYName";
        ddlfy.DataBind();
        ddlfy.Items.Insert(0, new ListItem(" -Session- ", ""));
        ddlfy.SelectedValue = fyid.ToString();
    }

    private void bind_class()
    {
        dt = objDUT.GetDataTable("select classid,Classname from ClassBranch_master where Status=1 and BranchId=" + brid + "");
        if (dt.Rows.Count > 0)
        {
            ddlclass.DataSource = dt;
            ddlclass.DataValueField = "classid";
            ddlclass.DataTextField = "classname";
            ddlclass.DataBind();
            ddlclass.Items.Insert(0, new ListItem(" Select Class ", ""));
        }
    }
}