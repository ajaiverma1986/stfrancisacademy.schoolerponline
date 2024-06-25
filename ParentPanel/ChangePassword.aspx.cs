using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class ParentPanel_ChangePassword : System.Web.UI.Page
{
    private string url, str11, str22, PageName, Query, userid, pass, str;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private SqlDataReader sdr;
    private DataUtility obj = new DataUtility();
    private int roleID, count, res;
    private SqlCommand cmd = new SqlCommand();
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());

    protected void Page_Load(object sender, EventArgs e)
    {
        txtUserName.Text = Session["loginidp"].ToString();
        txtoldpwd.Text = string.Empty;
        url = Request.Url.ToString();
        if (Session["loginidp"] == null)
        {
            Response.Redirect("~/LoginP.aspx?redirectUrl=" + url);
        }
        PageName = Utility.GetCurrentPagename();
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtoldpwd.Text.Trim() == "")
            {
                Utility.ViewAlertMessage(this.Master.Page, "Please enter old password");
                txtoldpwd.Focus();
                return;
            }
            count = Convert.ToInt32(objdut.GetScalar("select Count (*) from Parent_login where username= '" + txtUserName.Text.Trim() + "' and password= '" + txtoldpwd.Text.Trim() + "'"));
            if (count == 1)
            {
                str11 = Convert.ToString(txtnewpwd.Text.Trim());
                str22 = Convert.ToString(txtconpwd.Text.Trim());
                if (String.Compare(str11, str22) == 0)
                {
                    str = "update Parent_login set password = '" + txtnewpwd.Text.Trim() + "' where username= '" + txtUserName.Text.Trim() + "'";
                    res = objdut.ExecuteSql(str);
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
                        txtoldpwd.Text = "";
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
}