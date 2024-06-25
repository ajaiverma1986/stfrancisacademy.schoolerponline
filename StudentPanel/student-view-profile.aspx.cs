using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class EmployeePanel_employee_view_profile : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private int eid = 0;
    private DataTable dt;
    private int idStudent = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["StuRegNo"] == null)
        {
            Response.Redirect("../user-login.aspx");
        }
        if (!IsPostBack)
        {
          
                eid = Convert.ToInt32(Session["StuRegNo"]);

            idStudent = Convert.ToInt16(Session["StuRegNo"]);
            showDetails(eid);
          
        }
    }

    protected void showDetails(int id)
    {
        dt = CommonClass.ABC("stuDentDetails", 0, id);

        if (dt.Rows.Count > 0)
        {
            if (!string.IsNullOrEmpty(dt.Rows[0]["photo"].ToString()))
            {
                ViewState["pic"] = dt.Rows[0]["photo"].ToString();
                img1.ImageUrl = "../StudentPhoto/" + ViewState["pic"].ToString();
            }
            else
            {
                ViewState["pic"] = null;
                img1.ImageUrl = "~/images/9update.png";
            }
            lblRollno.InnerText = dt.Rows[0]["roll_No"].ToString();
            lblname.InnerText = dt.Rows[0]["fname"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["mname"].ToString()))
            {
                lblname.InnerText = lblname.InnerText + dt.Rows[0]["mname"].ToString();
            }
            else
            {
                lblname.InnerText = lblname.InnerText + "";
            }

            if (!string.IsNullOrEmpty(dt.Rows[0]["board"].ToString()) && dt.Rows[0]["board"].ToString() != "Select Board")
            {
                lblBoard.InnerText = dt.Rows[0]["board"].ToString();
            }
            else
            {
                lblBoard.InnerText = "NA";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["mediam"].ToString()) && dt.Rows[0]["mediam"].ToString() != "Select Medium")
            {
                lblMedium.InnerText = dt.Rows[0]["mediam"].ToString();
            }
            else
            {
                lblMedium.InnerText = "NA";
            }
            lblname.InnerText = lblname.InnerText + " " + dt.Rows[0]["lname"].ToString();
            if (Convert.ToBoolean(dt.Rows[0]["gender"]))
            {
                lblGender.InnerText = "Male";
            }
            else
            {
                lblGender.InnerText = "Female";
            }
            lblDOB.InnerText = dt.Rows[0]["DOB"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["address"].ToString()))
            {
                lblAddress.InnerText = dt.Rows[0]["address"].ToString();
            }
            else
            {
                lblAddress.InnerText = "NA";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["school"].ToString()) && dt.Rows[0]["school"].ToString() != "--Select School--")
            {
                lblschool.InnerText = dt.Rows[0]["school"].ToString();
            }
            else
            {
                lblschool.InnerText = "NA";
            }
            lblMobileno.InnerText = dt.Rows[0]["mobile"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["email"].ToString()))
            {
                lblemailid.InnerText = dt.Rows[0]["email"].ToString();
            }
            else
            {
                lblemailid.InnerText = "NA";
            }
            
            if (!string.IsNullOrEmpty(dt.Rows[0]["landline"].ToString()))
            {
                lblLandlineno.InnerText = dt.Rows[0]["landline"].ToString();
            }
            else
            {
                lblLandlineno.InnerText = "NA";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["Gphoto"].ToString()))
            {
                ViewState["fpic"] = dt.Rows[0]["Gphoto"].ToString();
                Img2.ImageUrl = "../StudentPhoto/" + ViewState["fpic"].ToString();
            }
            else
            {
                ViewState["fpic"] = null;
                Img2.ImageUrl = "~/images/9update.png";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["GName"].ToString()))
            {
                lblGName.InnerText = dt.Rows[0]["GName"].ToString();
            }
            else
            {
                lblGName.InnerText = "NA";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["Relation"].ToString()))
            {
                if (dt.Rows[0]["Relation"].ToString() == "--Select Relation--")
                {
                    lblRelation.InnerText = "NA";
                }
                else
                {
                    lblRelation.InnerText = dt.Rows[0]["Relation"].ToString();
                }
            }
            else
            {
                lblRelation.InnerText = "NA";
            }

            if (!string.IsNullOrEmpty(dt.Rows[0]["GuardianPhone"].ToString()))
            {
                lblGMobileno.InnerText = dt.Rows[0]["GuardianPhone"].ToString();
            }
            else
            {
                lblGMobileno.InnerText = "NA";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["Gmail"].ToString()))
            {
                lblGemailid.InnerText = dt.Rows[0]["Gmail"].ToString();
            }
            else
            {
                lblGemailid.InnerText = "NA";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["Gaddress"].ToString()))
            {
                lblGAddress.InnerText = dt.Rows[0]["Gaddress"].ToString();
            }
            else
            {
                lblGAddress.InnerText = "NA";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["AlternateMobileNo"].ToString()))
            {
                lblaltno.InnerText = dt.Rows[0]["AlternateMobileNo"].ToString();
            }
            else
            {
                lblaltno.InnerText = "NA";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["MotherName"].ToString()))
            {
                lblmother.InnerText = dt.Rows[0]["MotherName"].ToString();
            }
            else
            {
                lblmother.InnerText = "NA";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["QualificationName"].ToString()))
            {
                txtqualification.Text = dt.Rows[0]["QualificationName"].ToString();
            }
            else
            {
                txtqualification.Text = "";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["BoardorUniversity"].ToString()))
            {
                txtboardlist.Text = dt.Rows[0]["BoardorUniversity"].ToString();
            }
            else
            {
                txtboardlist.Text = "";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["PassingYear"].ToString()))
            {
                txtyear.Text = dt.Rows[0]["PassingYear"].ToString();
            }
            else
            {
                txtyear.Text = "";
            }
            //if (!string.IsNullOrEmpty(dt.Rows[0]["QlalificationSession"].ToString()))
            //{
            //    txtsession.Text = dt.Rows[0]["QlalificationSession"].ToString();
            //}
            //else
            //{
            //    txtsession.Text = "";
            //}
            if (!string.IsNullOrEmpty(dt.Rows[0]["RollNumber"].ToString()))
            {
                txtrollnumber.Text = dt.Rows[0]["RollNumber"].ToString();
            }
            else
            {
                txtrollnumber.Text = "";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["ObtainedMarks"].ToString()))
            {
                txtobtainedmarks.Text = dt.Rows[0]["ObtainedMarks"].ToString();
            }
            else
            {
                txtobtainedmarks.Text = "";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["TotalMarks"].ToString()))
            {
                txttotalmarks.Text = dt.Rows[0]["TotalMarks"].ToString();
            }
            else
            {
                txttotalmarks.Text = "";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["Percentage"].ToString()))
            {
                txtpercent.Text = dt.Rows[0]["Percentage"].ToString();
            }
            else
            {
                txtpercent.Text = "";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["SchoolCollege"].ToString()))
            {
                txtinstituteaddress.Text = dt.Rows[0]["SchoolCollege"].ToString();
            }
            else
            {
                txtinstituteaddress.Text = "";
            }
        }
        else
        {
            Session["StudID"] = null;
            Response.Redirect("../user-login.aspx");
        }
        showLoginDetails(idStudent);
    }

    protected void showLoginDetails(int id)
    {
        dt = CommonClass.ABC("studentlogin", id, Convert.ToInt16(0));
        if (dt.Rows.Count > 0)
        {
            lblUserName.InnerText = dt.Rows[0]["username"].ToString();
            lblpassword.ToolTip = dt.Rows[0]["password"].ToString();
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


}