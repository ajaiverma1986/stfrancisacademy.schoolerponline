using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_all_student_list : System.Web.UI.Page
{
    private CommonClass commonobj = new CommonClass();
    private DataUtility objDUT = new DataUtility();
    private DataTable dt;
    private int regid = 0;
    private static int brid = 0;
    private DataSet ds;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if ((Session["BrBrid"]).ToString() != null && Convert.ToInt32(Session["BrBrid"]) != 0)
            {
                brid = Convert.ToInt32(Session["BrBrid"]);
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

        param[1] = new SqlParameter("@status", SqlDbType.VarChar, 50);
        param[1].Value = "4";

        param[2] = new SqlParameter("@pagesize", SqlDbType.Int);
        param[2].Value = 20;

        param[3] = new SqlParameter("@pageno", SqlDbType.Int);
        param[3].Value = 1;

        ds = objDUT.GetDataSetSP(param, "usp_Get_Student_List");
        if (ds.Tables[0].Rows.Count > 0)
        {
            gridforallstudent.DataSource = ds.Tables[0];
            gridforallstudent.DataBind();
            hfpages.Value = ds.Tables[1].Rows[0]["pages"].ToString();
        }
        else
        {
            gridforallstudent.EmptyDataText = "No Record Found";
            gridforallstudent.DataBind();
        }
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