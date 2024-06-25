using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Net.Mail;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class branchpanel_employee_employment_details : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();
    private CommonClass objCL = new CommonClass();
    private int employeeid = 0, statusid = 0;
    private static string myString = "", emailforhost = "", hostname = "", password = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                FillDDL();

                if (Request.QueryString.Count > 0)
                {
                    employeeid = Convert.ToInt32(Request.QueryString["id"].ToString());
                    Session["empid"] = employeeid;
                }
                statusid = Convert.ToInt32(objDUT.GetScalar("select main_status from tblEmp_Master where eid=" + Convert.ToInt32(Session["empid"])));
                string statusname = Convert.ToString(objDUT.GetScalar("select StatusName from tbl_EmployeeStatusMaster where StatusId=" + statusid));
                hfvforcheckemptype.Value = (objDUT.GetScalar("select emplyeetype from tblEmp_Master  where eid=" + Convert.ToInt32(Session["empid"]))).ToString();
                hfchangestatus.Value = statusid.ToString();
                lblformobile.Text = statusname;
                bind_status(statusid);
            }
            filldetail();
            BindGrid();
        }
        catch
        {
        }
    }

    public void BindGrid()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@empid", Convert.ToInt32(Session["empid"]));
        DataTable Dt = objDUT.GetDataTableSP(param, "[usp_BindGridOfEmployementDetails]");
        if (Dt.Rows.Count > 0)
        {
            gridemploymentdetails.DataSource = Dt;
            gridemploymentdetails.DataBind();
            Dt.Dispose();

            SqlParameter[] paramarray = new SqlParameter[1];
            paramarray[0] = new SqlParameter("@empid", Convert.ToInt32(Session["empid"]));
            Dt = objDUT.GetDataTableSP(paramarray, "[usp_GetMissingHistory]");
            if (Dt.Rows.Count > 0)
            {
                if (Dt.Rows[0]["History_Missing_From_Date"].ToString() == "No History Missing")
                {
                    missinghistory.Visible = false;
                    lbtnprevioushistory.Style.Add("display", "none");
                }
                else
                {
                    missinghistory.Visible = true;
                    gridviewmissinghistory.DataSource = Dt;
                    gridviewmissinghistory.DataBind();
                    lbtnprevioushistory.Style.Add("display", "block");
                }
            }
            else
            {
                missinghistory.Visible = false;
            }
        }
    }

    private void filldetail()
    {
        DataTable dt = objCL.dtCommon(Session["empid"].ToString().Trim(), 4);
        if (dt.Rows.Count > 0)
        {
            txtPanNo.Text = dt.Rows[0]["panNo"].ToString();

            if (dt.Rows[0]["doj"].ToString() != "")
            {
                string doj = dt.Rows[0]["doj"].ToString();
                string[] doj1 = doj.Split('/', ' ');
                doj = doj1[0] + '/' + doj1[1] + '/' + doj1[2];
                txtDatejoining.Text = doj;
            }

            ddlProbationPeriod.SelectedValue = dt.Rows[0]["probationPeriond"].ToString();

            if (dt.Rows[0]["doi"].ToString() != "")
            {
                string doi = dt.Rows[0]["doi"].ToString();
                string[] doi1 = doi.Split('/', ' ');
                doi = doi1[0] + '/' + doi1[1] + '/' + doi1[2];
                txtdoi.Text = doi;
            }
            ddl_dept.SelectedValue = (dt.Rows[0]["departmentID"]).ToString();
            if (dt.Rows[0]["emplyeetype"].ToString() == "1")
            {
                rdblistforemployee.SelectedValue = "1";
                divforprobationperiod.Style.Add("display", "none");
                tds.Style.Add("display", "none");
                pf.Style.Add("display", "block");
                esi.Style.Add("display", "block");
            }
            else
            {
                rdblistforemployee.SelectedValue = "2";
                divforprobationperiod.Style.Add("display", "block");
                tds.Style.Add("display", "block");
                pf.Style.Add("display", "none");
                esi.Style.Add("display", "none");
            }
            txtpfno.Text = dt.Rows[0]["pf_account_no"].ToString();
            txtesino.Text = dt.Rows[0]["esi_account_no"].ToString();
            txtEmailAlloted.Text = dt.Rows[0]["emailAlloted"].ToString();
            txtHrName.Text = dt.Rows[0]["hrName"].ToString();
            txttdsaccntno.Text = dt.Rows[0]["tds_account_number"].ToString();
        }
    }

    protected void FillDDL()
    {
        ddlBranch.DataSource = CommonClass.ABC("BranchDll");
        ddlBranch.DataTextField = "BrName";
        ddlBranch.DataValueField = "BrId";
        ddlBranch.DataBind();
        ddlBranch.Items.Insert(0, new ListItem("---Select Branch---", "0"));

        DataTable dtDesignation = objDUT.GetDataTable("select deptid,deptname from dept_master where status=1");
        if (dtDesignation.Rows.Count > 0)
        {
            ddl_dept.DataSource = dtDesignation;
            ddl_dept.DataTextField = "deptname";
            ddl_dept.DataValueField = "deptid";
            ddl_dept.DataBind();
            ddl_dept.Items.Insert(0, new ListItem("---Select Department---", "0"));
        }
    }

    protected void bind_status(int statusid)
    {
        SqlParameter[] p = new SqlParameter[1];
        p[0] = new SqlParameter("@currentstatus", statusid);
        DataTable dt = objDUT.GetDataTableSP(p, "usp_statusmanagement");
        if (dt.Rows.Count > 0)
        {
            ddlstatus.DataSource = dt;
            ddlstatus.DataTextField = "StatusName";
            ddlstatus.DataValueField = "StatusId";
            ddlstatus.DataBind();
            ddlstatus.Items.Insert(0, new ListItem("---Select Status---", "0"));
        }
    }

    [WebMethod]
    public static int Chnage_Emp_Status(string status, string comment, string suspensiondate, string resumptiondate, string terminationdate, string noticePeriodDate, string noofdaysinnoticeperiod, string workingDate, string leavedate)
    {
        if (suspensiondate != "")
        {
            string[] Datesuspensiondate = suspensiondate.Split('/');
            suspensiondate = Datesuspensiondate[2] + '-' + Datesuspensiondate[1] + '-' + Datesuspensiondate[0];
        }
        if (resumptiondate != "")
        {
            string[] Dateresumptiondate = resumptiondate.Split('/');
            resumptiondate = Dateresumptiondate[2] + '-' + Dateresumptiondate[1] + '-' + Dateresumptiondate[0];
        }
        if (terminationdate != "")
        {
            string[] Dateterminationdate = terminationdate.Split('/');
            terminationdate = Dateterminationdate[2] + '-' + Dateterminationdate[1] + '-' + Dateterminationdate[0];
        }
        if (noticePeriodDate != "")
        {
            string[] DatenoticePeriodDate = noticePeriodDate.Split('/');
            noticePeriodDate = DatenoticePeriodDate[2] + '-' + DatenoticePeriodDate[1] + '-' + DatenoticePeriodDate[0];
        }
        if (workingDate != "")
        {
            string[] DateworkingDate = workingDate.Split('/');
            workingDate = DateworkingDate[2] + '-' + DateworkingDate[1] + '-' + DateworkingDate[0];
        }
        if (leavedate != "")
        {
            string[] Dateleavedate = leavedate.Split('/');
            leavedate = Dateleavedate[2] + '-' + Dateleavedate[1] + '-' + Dateleavedate[0];
        }

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_changeempstatus]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[12];

                param[0] = new SqlParameter("@eid", Convert.ToInt32(HttpContext.Current.Session["empid"]));

                param[1] = new SqlParameter("@currentstatus", Convert.ToInt32(status));

                param[2] = new SqlParameter("@comment", comment);

                param[3] = new SqlParameter("@suspensionDate", suspensiondate);

                param[4] = new SqlParameter("@resumptionDate", resumptiondate);

                param[5] = new SqlParameter("@terminationDate", terminationdate);

                param[6] = new SqlParameter("@leaveDate", leavedate);

                param[7] = new SqlParameter("@noticePeriodDate", noticePeriodDate);

                param[8] = new SqlParameter("@noofDaysNoticePeriod", noofdaysinnoticeperiod);

                param[9] = new SqlParameter("@workingDate", workingDate);

                param[10] = new SqlParameter("@intresult", SqlDbType.Int);

                param[10].Direction = ParameterDirection.Output;

                param[11] = new SqlParameter("@userid", Convert.ToInt32(HttpContext.Current.Session["BrADID"]));

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

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }

    //===============This code for saving appraisal and previous history==============================
    [WebMethod]
    public static int Maintain_appraisal_prevHistory(int deptid, int designationid, int branchid, int typeofemployement, int probationperiod, decimal annual_ctc, decimal inhandsalary, string Datefrom, string DateTo, int mode)
    {
        string[] DateFromArray = Datefrom.Split('/');
        Datefrom = DateFromArray[2] + '-' + DateFromArray[1] + '-' + DateFromArray[0];

        if (mode == 1)
        {
            string[] DateToArray = DateTo.Split('/');
            DateTo = DateToArray[2] + '-' + DateToArray[1] + '-' + DateToArray[0];
        }
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_appraisal_or_previoushistory]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[12];

                param[0] = new SqlParameter("@empid", Convert.ToInt32(HttpContext.Current.Session["empid"]));

                param[1] = new SqlParameter("@deptid", deptid);

                param[2] = new SqlParameter("@designationid", designationid);

                param[3] = new SqlParameter("@branchid", branchid);

                param[4] = new SqlParameter("@typeofemployement", typeofemployement);

                param[5] = new SqlParameter("@probationperiod", probationperiod);

                param[6] = new SqlParameter("@annual_ctc", annual_ctc);

                param[7] = new SqlParameter("@inhandsalary", inhandsalary);

                param[8] = new SqlParameter("@Datefrom", Datefrom);

                param[9] = new SqlParameter("@DateTo", DateTo);

                param[10] = new SqlParameter("@intresult", SqlDbType.Int);

                param[10].Direction = ParameterDirection.Output;

                param[11] = new SqlParameter("@mode", mode);

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

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }

    //================this method is for updating the emp_master table record=========================
    [WebMethod]
    public static int update_emp_master_record(string pancard, string tds, string email, string esi, string pf)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_update_employment_details]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[7];
                param[0] = new SqlParameter("@empid", Convert.ToInt32(HttpContext.Current.Session["empid"]));
                param[1] = new SqlParameter("@pancardno", CultureInfo.CurrentCulture.TextInfo.ToUpper(pancard.Trim()));
                param[2] = new SqlParameter("@tdsno", CultureInfo.CurrentCulture.TextInfo.ToUpper(tds.Trim()));
                param[3] = new SqlParameter("@emailalloted", email.Trim());
                param[4] = new SqlParameter("@esi_account_no", CultureInfo.CurrentCulture.TextInfo.ToUpper(esi.Trim()));
                param[5] = new SqlParameter("@pf_account_no", CultureInfo.CurrentCulture.TextInfo.ToUpper(pf.Trim()));
                param[6] = new SqlParameter("@intresult", SqlDbType.Int);
                param[6].Direction = ParameterDirection.Output;
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);
                cmd.Parameters.Add(param[6]);

                cmd.ExecuteNonQuery();
                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);
                return result;
            }
        }
    }

    [WebMethod]
    public static gethistorydetails[] BindGridByJs()
    {
        DataTable Dt = new DataTable();
        List<gethistorydetails> details = new List<gethistorydetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_BindGridOfEmployementDetails]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@empid", Convert.ToInt32(HttpContext.Current.Session["empid"]));
                cmd.Parameters.Add(param[0]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(Dt);
                if (Dt.Rows.Count > 0)
                {
                    foreach (DataRow dtrow in Dt.Rows)
                    {
                        gethistorydetails user = new gethistorydetails();
                        user.RowNumber = dtrow["RowNumber"].ToString();
                        user.FromDate = dtrow["FromDate"].ToString();
                        user.ToDate = dtrow["ToDate"].ToString();
                        user.Inhand_Salary = dtrow["Inhand_Salary"].ToString();
                        user.Designation = dtrow["Designation"].ToString();
                        user.Department = dtrow["Department"].ToString();
                        user.Employment_Type = dtrow["Employment_Type"].ToString();
                        user.Probation_Period_In_Month = dtrow["Probation_Period_In_Month"].ToString();
                        user.Branch_Name = dtrow["Branch_Name"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class gethistorydetails
    {
        public string RowNumber { get; set; }

        public string FromDate { get; set; }

        public string ToDate { get; set; }

        public string Inhand_Salary { get; set; }

        public string Designation { get; set; }

        public string Department { get; set; }

        public string Employment_Type { get; set; }

        public string Probation_Period_In_Month { get; set; }

        public string Branch_Name { get; set; }
    }

    [WebMethod]
    public static int SendMail(string subject, string msg, int currentstatus)
    {
        int send = 0;
        string emailid = "", refno = "", name = "", address = "", city = "", state = "", country = "", pincode = "";
        try
        {
            DataUtility objUTL = new DataUtility();
            DataTable dtformail = objUTL.GetDataTable("select module_hostname,emialid_for_module,password_of_email from tbl_email_sms_send_master where ModuleId=4");
            if (dtformail.Rows.Count > 0)
            {
                emailforhost = dtformail.Rows[0]["emialid_for_module"].ToString();
                hostname = dtformail.Rows[0]["module_hostname"].ToString();
                password = dtformail.Rows[0]["password_of_email"].ToString();
                dtformail = null;
            }

            SqlParameter[] p = new SqlParameter[2];

            p[0] = new SqlParameter("@id", Convert.ToInt32(HttpContext.Current.Session["empid"]));
            p[1] = new SqlParameter("@mode", Convert.ToInt16(3));

            dtformail = objUTL.GetDataTableSP(p, "usp_getRecords");
            if (dtformail.Rows.Count > 0)
            {
                emailid = dtformail.Rows[0]["emailID"].ToString();
                refno = dtformail.Rows[0]["refNo"].ToString();
                name = dtformail.Rows[0]["titlename"].ToString() + " " + dtformail.Rows[0]["fName"].ToString() + " " + dtformail.Rows[0]["lName"].ToString();
                address = dtformail.Rows[0]["address"].ToString();
                city = dtformail.Rows[0]["cityName"].ToString();
                state = dtformail.Rows[0]["stateName"].ToString();
                country = dtformail.Rows[0]["countryName"].ToString();
                pincode = dtformail.Rows[0]["pinCode"].ToString();
            }

            if (send == 0)
            {
                MailMessage mm = new MailMessage(emailforhost, emailid);
                mm.IsBodyHtml = true;

                StreamReader reader = new StreamReader(System.Web.HttpContext.Current.Server.MapPath("sendemailforstatuschange.html"));
                string readFile = reader.ReadToEnd();
                myString = readFile;
                myString = myString.Replace("$$empcode$$", refno);
                myString = myString.Replace("$$empname$$", name);
                myString = myString.Replace("$$address$$", address);
                myString = myString.Replace("$$city$$", city);
                myString = myString.Replace("$$state$$", state);
                myString = myString.Replace("$$country$$", country);
                myString = myString.Replace("$$pincode$$", pincode);
                myString = myString.Replace("$$date$$", DateTime.Today.ToShortDateString());

                myString = myString.Replace("$$subject$$", subject);
                myString = myString.Replace("$$name$$", name);
                myString = myString.Replace("$$message$$", msg);

                mm.Subject = subject;
                mm.Body = myString;
                System.Net.NetworkCredential webmail = new System.Net.NetworkCredential(emailforhost, password);
                System.Net.Mail.SmtpClient ms = new SmtpClient(hostname);
                ms.UseDefaultCredentials = true;
                ms.Credentials = webmail;
                if (send == 0)
                {
                    ms.Send(mm);
                    send = 1;
                }
            }
            return send;
        }
        catch (Exception exx)
        {
            return 2;
        }
    }
}