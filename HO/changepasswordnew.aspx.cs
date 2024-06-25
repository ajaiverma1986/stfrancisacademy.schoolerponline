using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class HO_changepasswordnew : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private SqlDataReader sdr;
    private DataUtility obj = new DataUtility();
    private int roleID;
    private string Query;
    private string userid, pass;
    private SqlCommand cmd = new SqlCommand();
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack != null)
        {
            url = Request.Url.ToString();
            if (Session["User"] == null)
            {
                Response.Redirect("~/Login.aspx?redirectUrl=" + url);
            }
            PageName = Utility.GetCurrentPagename();

            if (!objut.isAccessible(((User)Session["User"]).UserID, PageName))
            {
                Response.Redirect("~/Login.aspx");
            }
            txtUserName.Text = Session["username"].ToString();
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            int count = Convert.ToInt32(objdut.GetScalar("select Count (*) from tbluser where username= '" + txtUserName.Text.Trim() + "' and password= '" + txtoldpwd.Text + "'"));
            if (count == 1)
            {
                string str11 = Convert.ToString(txtnewpwd.Text.Trim());
                string str22 = Convert.ToString(txtconpwd.Text.Trim());

                if (String.Compare(str11, str22) == 0)
                {
                    string str = "update tbluser set password = '" + txtnewpwd.Text.Trim() + "' where username= '" + txtUserName.Text.Trim() + "'";

                    int res = objdut.ExecuteSql(str);
                    if (res > 0)
                    {
                        lblmsg.ForeColor = System.Drawing.Color.Blue;
                        Utility.ViewAlertMessage(this.Master.Page, "Your password has been changed successfully.");
                        lblmsg.Text = "Your Password Has been Changed Successfully .";
                        txtoldpwd.Text = "";
                    }
                    else
                    {
                        lblmsg.ForeColor = System.Drawing.Color.Red;
                        Utility.ViewAlertMessage(this.Master.Page, "Error updating your password.!");
                        lblmsg.Text = "Error Updating Your Password .";
                    }
                }
                else
                {
                    lblmsg.ForeColor = System.Drawing.Color.Red;
                    lblmsg.Text = "New Password and Confirmed Password is not same.";
                }
            }
            else
            {
                lblmsg.ForeColor = System.Drawing.Color.Red;
                lblmsg.Text = "Old Password Is Not Correct.";
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
        }
    }

    protected void btnUpdateCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Common/Default.aspx");
    }
}