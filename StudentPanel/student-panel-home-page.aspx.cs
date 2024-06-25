using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Services;

public partial class EmployeePanel_employee_panel_home_page : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
            if (Session["StuRegNo"] == null)
            {
                Response.Redirect("../user-login.aspx");
            }
       
    }

    [WebMethod]
    public static int ChangePassword(string oldpassword, string newpassword, string Confirmnewpassword)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_changepassword]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[5];

                param[0] = new SqlParameter("@oldpassword", oldpassword);

                param[1] = new SqlParameter("@newpassword", newpassword);

                param[2] = new SqlParameter("@StuRegNo", Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]));

                param[3] = new SqlParameter("@confirmnewpassword", Confirmnewpassword);

                param[4] = new SqlParameter("@intresult", SqlDbType.Int);

                param[4].Direction = ParameterDirection.Output;

                cmd.Parameters.Add(param[0]);

                cmd.Parameters.Add(param[1]);

                cmd.Parameters.Add(param[2]);

                cmd.Parameters.Add(param[3]);

                cmd.Parameters.Add(param[4]);

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }


    protected void imgforandroid_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        try
        {
            string filepath = "StudentPanel.apk";
            filepath = "studentpanel_App/" + filepath;
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filepath));
            Response.WriteFile(filepath);
            Response.End();
        }
        catch (Exception ex)
        {
        }
    }
}