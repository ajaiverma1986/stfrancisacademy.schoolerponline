using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net.Mail;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_selection : System.Web.UI.Page
{
    private string qry, qry1, qry2, pname;
    private DataTable dt, dt2, dt3;
    private string studname = string.Empty;
    private string stuid = string.Empty;
    private SqlParameter[] param1 = new SqlParameter[6];
    private DataUtility objdut = new DataUtility();
    private static string subject = "";
    private static string strforemail = "";
    private static int send = 0;
    public static int fyid = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fyid = CommonClass.Scaler("ActiveAcademicYear");
            int a = Convert.ToInt32(objdut.GetScalar("select FYID from financial_Year where isactive=1 and isclosed=0"));
            ViewState["fyd"] = a;
            fillddlclass();
            bindparentqualification();
            BindGrid();
        }
    }

    private void BindGrid()
    {
        qry2 = "select Top (1) rid,Registrationno,(firstname+' '+lastname)as name,(ffirstname+' '+flastname)as Fname,cast((isnull(status,0)) as bit)as status,registrationdate from tbl_StudentRegistration where Brid=" + Convert.ToInt32(Session["BrBrid"]) + " and fyid=" + fyid + "and status=0  order by parentpriority asc , parentincome desc";
        dt3 = objdut.GetDataTable(qry2);
        if (dt3.Rows.Count > 0)
        {
            gridenquiry.DataSource = dt3;
            gridenquiry.DataBind();
        }
        else
        {
            gridenquiry.EmptyDataText = "No Record Found";
            gridenquiry.DataBind();
        }
        tablemaingrid.Style.Add("display", "none");
    }

    private void bindparentqualification()
    {
        string str = "select id,pqualification from parentqualification";
        dt2 = objdut.GetDataTable(str);
        if (dt2.Rows.Count > 0)
        {
            ddlsearchbyparentqualification.DataSource = dt2;
            ddlsearchbyparentqualification.DataTextField = "pqualification";
            ddlsearchbyparentqualification.DataValueField = "pqualification";
            ddlsearchbyparentqualification.DataBind();
            ddlsearchbyparentqualification.Items.Insert(0, new ListItem("Search By Father Qualification", "0"));

            ddlmotherqualification.DataSource = dt2;
            ddlmotherqualification.DataTextField = "pqualification";
            ddlmotherqualification.DataValueField = "pqualification";
            ddlmotherqualification.DataBind();
            ddlmotherqualification.Items.Insert(0, new ListItem("Search By Mother Qualification", "0"));
        }
    }

    private void fillddlclass()
    {
        ddlclass.DataSource = CommonClass.ABC1("ClassInBranch", Convert.ToInt32(Session["BrBrid"]));
        ddlclass.DataTextField = "classname";
        ddlclass.DataValueField = "classid";
        ddlclass.DataBind();
        ddlclass.Items.Insert(0, new ListItem("Select Class", "0"));
        DataTable dt = objdut.GetDataTable("select FYID, FYName from financial_Year ");
        ddlfy.DataSource = dt;
        ddlfy.DataValueField = "FYID";
        ddlfy.DataTextField = "FYName";
        ddlfy.DataBind();
        ddlfy.Items.Insert(0, new ListItem(" -Session- ", ""));
    }

    protected void gvdetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int regid = 0;
        if (e.CommandName == "RegSlip")
        {
            regid = Convert.ToInt32(e.CommandArgument);
            Response.Redirect("regconfirm.aspx?Rid=" + regid);
        }
    }

    [WebMethod]
    public static UserDetails[] BindDatatable(int classid, string ddlfromdate, string ddltodate, string ddlcast, string ddlnationality, double ddlparentstartsallery, double ddlparentendsallery, string ddlfatherqualification, string ddlmotherqualification, string txtsearchtext, string fyid1)
    {
        BranchPanel_selection onm = new BranchPanel_selection();
        DataSet ds = new DataSet();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_SelectionProcess", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[12];

                param[0] = new SqlParameter("@classid", Convert.ToInt32(classid));
                param[1] = new SqlParameter("@fromdate", ddlfromdate);
                param[2] = new SqlParameter("@todate", ddltodate);
                param[3] = new SqlParameter("@cast", ddlcast);
                param[4] = new SqlParameter("@nationality", ddlnationality);
                param[5] = new SqlParameter("@parentstartsallery", ddlparentstartsallery);
                param[6] = new SqlParameter("@parentendsallert", ddlparentendsallery);
                param[7] = new SqlParameter("@fatherqualification", ddlfatherqualification);
                param[8] = new SqlParameter("@motherqualification", ddlmotherqualification);
                param[9] = new SqlParameter("@searchvalue", txtsearchtext);
                param[10] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);
                param[11] = new SqlParameter("@fyid", Convert.ToInt32(fyid1));

                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);
                cmd.Parameters.Add(param[6]);
                cmd.Parameters.Add(param[7]);
                cmd.Parameters.Add(param[8]);
                cmd.Parameters.Add(param[9]);
                cmd.Parameters.Add(param[10]);
                cmd.Parameters.Add(param[11]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.status = dtrow["status"].ToString();
                        user.Registrationno = dtrow["Registrationno"].ToString();
                        user.name = dtrow["name"].ToString();
                        user.rid = dtrow["rid"].ToString();
                        user.Fname = dtrow["Fname"].ToString();
                        user.registrationdate = dtrow["registrationdate"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string status { get; set; }

        public string Registrationno { get; set; }

        public string name { get; set; }

        public string rid { get; set; }

        public string Fname { get; set; }

        public string registrationdate { get; set; }
    }

    [WebMethod]
    public static void GetEmailIdByRid(string allselectedrid, string status)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("usp_updatestatusforshortlistedstudent", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@allselectedrid", Convert.ToString(allselectedrid));
            cmd.Parameters.AddWithValue("@status", Convert.ToInt32(status));
            int result = cmd.ExecuteNonQuery();

            if (Convert.ToInt32(status) == 2)
            {
                if (result > 0)
                {
                    string cmdstring = "SELECT [dbo].[usp_getselectedemailid](@allselectedrid)";
                    cmd = new SqlCommand(cmdstring, con);
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Add("@allselectedrid", SqlDbType.VarChar).Value = Convert.ToString(allselectedrid);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    string str = dt.Rows[0][0].ToString();
                    strforemail = str.Remove(0, 1);
                   // sendmail1(strforemail);
                    if (send == 1)
                    {
                    }
                }
            }
        }
    }

    protected static void sendmail1(string email)
    {
        try
        {
            string emailid = email;
            subject = "Email Confirmation";
            email = emailid;

            if (send == 0)
            {
                MailMessage mm = new MailMessage("noreply@qads.bz", email);
                mm.IsBodyHtml = true;
                StreamReader reader = new StreamReader(HttpContext.Current.Server.MapPath("mailforstudent.html"));
                string readFile = reader.ReadToEnd();
                string myString = "";
                myString = readFile;
                myString = myString.Replace("$$lblamount$$", "Selected");
                mm.Subject = "Verification mail";
                mm.Body = myString;
                System.Net.NetworkCredential webmail = new System.Net.NetworkCredential("noreply@qads.bz", "User@123");
                System.Net.Mail.SmtpClient ms = new SmtpClient("mail.qads.bz");
                ms.UseDefaultCredentials = false;
                ms.Credentials = webmail;
                if (send == 0)
                {
                    ms.Send(mm);
                    send = 1;
                }
            }
            else
            {
            }
        }
        catch (Exception ex1)
        {
        }
    }
}