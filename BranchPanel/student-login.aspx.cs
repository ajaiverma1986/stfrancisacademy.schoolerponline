using System;
using System.Data;
using System.Data.SqlClient;

public partial class BranchPanel_student_login : System.Web.UI.Page
{
    private string str, url;
    private Object[] values;
    private SqlDataReader rd;
    private SqlParameter[] param;
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrBrid"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        if (Session["stue"] == null)
        {
            Response.Redirect("Default.aspx");
        }
        if (!IsPostBack)
        {
            fildeatil();
        }
    }

    private void fildeatil()
    {
        string str = "select username,password from Parent_login where brid=" + Convert.ToInt32(Session["BrBrid"]) + " and adid=" + Session["Adid2"];
        rd = objdut.GetDataReader(str);
        if (rd.HasRows)
        {
            rd.Read();
            txtuser.Text = rd["username"].ToString();
            txtpass.ToolTip = rd["password"].ToString();
        }
        rd.Close();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        param = new SqlParameter[5];
        param[0] = new SqlParameter("@username", txtuser.Text.Trim());
        param[1] = new SqlParameter("@password", txtnewpass.Text.Trim());
        param[2] = new SqlParameter("@adid", Convert.ToInt32(Session["Adid2"]));
        param[3] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));
        param[4] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[4].Direction = ParameterDirection.Output;
        int res = objdut.ExecuteSqlSP(param, "usp_updatelogin");
        if (res == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Updated Succesfully.!!");
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Error.....!!");
            return;
        }
    }
}