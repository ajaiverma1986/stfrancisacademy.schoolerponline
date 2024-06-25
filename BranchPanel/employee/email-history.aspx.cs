using System;
using System.Data;
using System.Data.SqlClient;

public partial class branchpanel_employee_email_history : System.Web.UI.Page
{
    private DataUtility ObjUtl = new DataUtility();
    private DataSet ds = new DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillgrid();
        }
    }

    private void fillgrid()
    {
        SqlParameter[] param1 = new SqlParameter[2];

        param1[0] = new SqlParameter("@pagesize", SqlDbType.Int);
        param1[0].Value = 100;

        param1[1] = new SqlParameter("@pageno", SqlDbType.Int);
        param1[1].Value = 1;

        ds = ObjUtl.GetDataSetSP(param1, "[get_email_history]");

        if (ds.Tables[0].Rows.Count > 0)
        {
            gridforsmshistory.DataSource = ds.Tables[0];
            gridforsmshistory.DataBind();
            hfpages.Value = ds.Tables[1].Rows[0]["pages"].ToString();
            trforpagging.Style.Add("display", "block");
        }
        else
        {
            gridforsmshistory.EmptyDataText = "Currently, E-mail history is not available.";
            gridforsmshistory.DataSource = null;
            gridforsmshistory.DataBind();
            trforpagging.Style.Add("display", "none");
        }
    }
}