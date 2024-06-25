using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;
using System.Configuration;
public partial class BranchPanel_send_sms : System.Web.UI.Page
{
    DataTable dt3,dt;
    string  statusid = "", url="",courseid="" ;
    SqlParameter[] param = new SqlParameter[5];
    DataUtility Objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            url = Request.Url.ToString();
            if (Session["BrUser"] == null)
            {
                Response.Redirect("~/Login.aspx?redirectUrl=" + url);
            }
         
            fillcourse();
            fillstatus();
          
        }
    }

    private void fillcourse()
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@intResult",0);
        param[1].Direction = ParameterDirection.Output;
        DataTable dt = Objdut.GetDataTableSP(param, "usp_dogenraltaskforenquiry");
        if (dt.Rows.Count > 0)
        {
            ddlcourse.DataSource = dt;
            ddlcourse.DataTextField = "Classname";
            ddlcourse.DataValueField = "id";
            ddlcourse.DataBind();
        }
    }

    private void fillstatus()
    {
        dt = Objdut.GetDataTable("select esid,statusname from enquirysourcestatus_master where status=1");
        chkstatuslist.DataSource = dt;
        chkstatuslist.DataTextField = "statusname";
        chkstatuslist.DataValueField = "esid";
        chkstatuslist.DataBind();

    }


    private void filltemplate()
    {
        string que = "select campid,chead from tbl_campaing where status=1 and isusedfor=1";

        DataTable dt = Objdut.GetDataTable(que);
        if (dt.Rows.Count > 0)
        {
            ddltemplate.DataSource = dt;
            ddltemplate.DataTextField = "chead";
            ddltemplate.DataValueField = "campid";
            ddltemplate.DataBind();
            ddltemplate.Items.Insert(0, new ListItem("--Select Template--", "0"));
        }
    }



    protected void sendsms()
    {
        if (HttpContext.Current.Session["brbrid"].ToString() != null)
        {
            int i = sendMessageToMobile.SMSSend(Convert.ToString(Session["mobile"]), Convert.ToString(Session["message"]), HttpContext.Current.Session["brbrid"].ToString());
        }
        if (i == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Message send successfully.");
            return;
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Network error while sending sms, Please try again. ");
            return;
        }
    }

    public class gettempalate
    {
        public int tempid { get; set; }

        public string temptext { get; set; }
    }

    [WebMethod]
    public static gettempalate[] gettamplate(string usedfor)
    {
        DataTable dt = new DataTable();
        List<gettempalate> details = new List<gettempalate>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_dogenraltaskforenquiry", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@mode", 4);
                param[1] = new SqlParameter("@isuserfor", usedfor);
                param[2] = new SqlParameter("@intResult", 0);
                param[2].Direction = ParameterDirection.Output;
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                gettempalate objdeg = new gettempalate();
                objdeg.tempid = Convert.ToInt32("0");
                objdeg.temptext = "-Select Template-";
                details.Add(objdeg);
                foreach (DataRow dtrow in dt.Rows)
                {
                    gettempalate objdesignation = new gettempalate();
                    objdesignation.tempid = Convert.ToInt32(dtrow["campid"].ToString());
                    objdesignation.temptext = dtrow["chead"].ToString();
                    details.Add(objdesignation);
                }
            }
        }
        return details.ToArray();
    }
    [WebMethod]
    public static string gettemplatetext(string tempid)
    {
        string templatetext;
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_dogenraltaskforenquiry", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@mode", 5);
                param[1] = new SqlParameter("@campid", tempid);
                param[2] = new SqlParameter("@intResult", 0);
                param[2].Direction = ParameterDirection.Output;
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                templatetext = dt.Rows[0]["ctext"].ToString();
            }
        }
        return templatetext;
    }

    [WebMethod]
    public static string getemailidandmobile(string course, string statusid, string fromdate, string todate, string message, string getcomid)
    {
        string mobile = "", emailid = "";
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_campaing", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@courseid", course);
                param[1] = new SqlParameter("@statusid", statusid);
                param[2] = new SqlParameter("@fromdate", fromdate);
                param[3] = new SqlParameter("@todate", todate);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                mobile = dt.Rows[0]["mobile"].ToString();
                emailid = dt.Rows[0]["emailid"].ToString();
            }
        }
        if (getcomid == "1")
        {
            if (HttpContext.Current.Session["brbrid"].ToString() != null)
            {
                sendMessageToMobile.SMSSend(Convert.ToString(mobile), Convert.ToString("Hello"), HttpContext.Current.Session["brbrid"].ToString());
            }
        }
        if (getcomid == "2")
        {
            string ret = SendMail.Send("", "abhishek@awapalsolutions.com", mobile, "", "", message);
        }
        
        return mobile;
    }




}

    

  
    
