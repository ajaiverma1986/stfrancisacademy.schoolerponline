using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class EmployeePanel_employee_panel_home_page : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["eid"] != null)
            {
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@eid", Convert.ToInt32(Session["eid"]));
                DataTable Dt = objdut.GetDataTableSP(param, "[usp_BindNameOnPageLoadOfDefaultPage]");
                if (Dt.Rows.Count > 0)
                {
                    lbluername.Text = Dt.Rows[0]["Name"].ToString();
                    if (Convert.ToInt32(Dt.Rows[0]["PasswordIsChanged"]) == 1)
                    {
                        divchangepassword.Style.Add("display", "block");
                        tdbtnclose.InnerText = "Skip Now";
                    }
                }
            }
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

                param[2] = new SqlParameter("@eid", Convert.ToInt32(HttpContext.Current.Session["eid"]));

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
}