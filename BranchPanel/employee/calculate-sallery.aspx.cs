using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_calculate_sallery : System.Web.UI.Page
{
    private CommonClass objCL = new CommonClass();
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private static int fyid = 2;
    public string empid = "0", status = "0", payid = "0";

    protected void Page_Load(object sender, EventArgs e)
    {
        fyid = CommonClass.Scaler("ActiveAcademicYear");

        if (Request.QueryString.Count > 0)
        {
            empid = Request.QueryString[0];
            status = Request.QueryString[1];
            payid = Request.QueryString[2];
            Session["empid"] = empid;
        }

        if (!IsPostBack)
        {
            Insert_Into_Temp();
            BindGrid();
        }
    }
    [WebMethod]
    public static int LockSalary(string isclosed)
    {
        int TempID = Convert.ToInt32(HttpContext.Current.Session["empid"]);

        DataUtility objdut = new DataUtility();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_pay_sallery]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "UPDATE tbl_tempdata SET isclosed=" + isclosed + " WHERE empid = " + TempID +" and fyid = " + fyid + "";
                int result = Convert.ToInt32(objdut.ExecuteSql(cmd.CommandText));
                return result;
            }
        }
    }

    protected void Insert_Into_Temp()
    {
        SqlParameter[] param = new SqlParameter[5];

        param[0] = new SqlParameter("@payid", Convert.ToInt32(payid));

        param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));

        param[2] = new SqlParameter("@fyid", fyid);

        param[3] = new SqlParameter("@empid", Convert.ToInt32(Session["empid"]));

        param[4] = new SqlParameter("@effectivedays", Convert.ToDecimal(0));

        dt = objdut.GetDataTableSP(param, "[usp_calculatesallery]");

        if (dt.Rows.Count > 0)
        {
            gvdetails.DataSource = dt;
            gvdetails.DataBind();
        }

        if (status == "r")
        {
            divgrid.Style.Add("display", "block");
            tablemaingrid.Style.Add("display", "none");
        }
        else if (status == "p")
        {
            divgrid.Style.Add("display", "none");
            tablemaingrid.Style.Add("display", "none");
        }
        else
        {
            divgrid.Style.Add("display", "none");
        }
    }

    protected void BindGrid()
    {
        SqlParameter[] param = new SqlParameter[2];

        param[0] = new SqlParameter("@fyid", fyid);

        param[1] = new SqlParameter("@eid", Convert.ToInt32(HttpContext.Current.Session["empid"]));

        dt = objdut.GetDataTableSP(param, "[usp_Bindsalarylistofpayid]");

        if (dt.Rows.Count > 0)
        {
            gridmain.DataSource = dt;
            gridmain.DataBind();
        }

        if (status == "r" || status == "p")
        {
            tablemaingrid.Style.Add("display", "none");
        }
        else
        {
            tablemaingrid.Style.Add("display", "block");
        }
    }

    [WebMethod]
    public static UserDetailsMainGeird[] BinMainGridDemo(string payid)
    {
        DataSet ds = new DataSet();
        List<UserDetailsMainGeird> details = new List<UserDetailsMainGeird>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_Bindsalarylistofpayid]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[2];

                param[0] = new SqlParameter("@fyid", fyid);

                param[1] = new SqlParameter("@eid", Convert.ToInt32(HttpContext.Current.Session["empid"]));

                cmd.Parameters.Add(param[0]);

                cmd.Parameters.Add(param[1]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetailsMainGeird user = new UserDetailsMainGeird();
                        user.RowNumber = dtrow["RowNumber"].ToString();
                        user.Month = dtrow["Month"].ToString();
                        user.monthlysalary = dtrow["monthlysalary"].ToString();
                        user.calculatedsalary = dtrow["calculatedsalary"].ToString();
                        user.Recalculatedsalary = dtrow["Recalculatedsalary"].ToString();
                        user.payid = dtrow["payid"].ToString();
                        user.isclosed = dtrow["isclosed"].ToString();
                        user.paystatus = dtrow["paystatus"].ToString();
                        user.isconfirm = dtrow["isconfirm"].ToString();
                        user.deduction = dtrow["deduction"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class UserDetailsMainGeird
    {
        public string RowNumber { get; set; }

        public string Month { get; set; }

        public string monthlysalary { get; set; }

        public string calculatedsalary { get; set; }

        public string Recalculatedsalary { get; set; }

        public string payid { get; set; }

        public string isclosed { get; set; }

        public string paystatus { get; set; }

        public string isconfirm { get; set; }

        public string deduction { get; set; }
    }

    [WebMethod]
    public static UserDetails[] BindDatatable(string payid, string effectivedate, string isclosed, string issavecahnge)
    {
        DataSet ds = new DataSet();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_calculatesallery]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[7];

                param[0] = new SqlParameter("@payid", payid);

                param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));

                param[2] = new SqlParameter("@fyid", fyid);

                param[3] = new SqlParameter("@empid", Convert.ToInt32(HttpContext.Current.Session["empid"]));

                param[4] = new SqlParameter("@effectivedays", Convert.ToDecimal(effectivedate));

                param[5] = new SqlParameter("@isclosed", Convert.ToInt32(isclosed));

                param[6] = new SqlParameter("@issavechange", Convert.ToInt32(issavecahnge));

                cmd.Parameters.Add(param[0]);

                cmd.Parameters.Add(param[1]);

                cmd.Parameters.Add(param[2]);

                cmd.Parameters.Add(param[3]);

                cmd.Parameters.Add(param[4]);

                cmd.Parameters.Add(param[5]);

                cmd.Parameters.Add(param[6]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.workingdayofoffice = dtrow["workingdayofoffice"].ToString();
                        user.workingdayofemployees = dtrow["workingdayofemployees"].ToString();
                        user.totalunpaidleave = dtrow["totalunpaidleave"].ToString();
                        user.totalpaidleave = dtrow["totalpaidleave"].ToString();
                        user.totallate = dtrow["totallate"].ToString();
                        user.totalhalfday = dtrow["totalhalfday"].ToString();
                        user.effectivedays_system = dtrow["effectivedays_changebyadmin"].ToString();
                        user.monthlysalary = dtrow["monthlysalary"].ToString();
                        user.calculatedsalary = dtrow["Modifiedsallery"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string workingdayofoffice { get; set; }

        public string workingdayofemployees { get; set; }

        public string totalunpaidleave { get; set; }

        public string totalpaidleave { get; set; }

        public string totallate { get; set; }

        public string totalhalfday { get; set; }

        public string effectivedays_system { get; set; }

        public string monthlysalary { get; set; }

        public string calculatedsalary { get; set; }
    }

    [WebMethod]
    public static UserDetailspayinformation[] BindPayDetailsDatatable(string payid)
    {
        DataSet ds = new DataSet();
        List<UserDetailspayinformation> details = new List<UserDetailspayinformation>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_pay_sallery_details]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[3];

                param[0] = new SqlParameter("@payid", payid);

                param[1] = new SqlParameter("@fyid", fyid);

                param[2] = new SqlParameter("@empid", Convert.ToInt32(HttpContext.Current.Session["empid"]));

                cmd.Parameters.Add(param[0]);

                cmd.Parameters.Add(param[1]);

                cmd.Parameters.Add(param[2]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetailspayinformation user = new UserDetailspayinformation();
                        user.AdvanceAmount = dtrow["advanceamount"].ToString();
                        user.OpenBalance = dtrow["openbalance"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class UserDetailspayinformation
    {
        public string Name { get; set; }

        public string AdvanceAmount { get; set; }

        public string OpenBalance { get; set; }
    }

    [WebMethod]
    public static int InsertSallery(string payid, string adjustmenttype, string adjustmentamount, string salleryamount, string payableamount, string paymentmode, string paymentdate, string bankname, string checkno, string checkdate)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_pay_sallery]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[13];

                param[0] = new SqlParameter("@payid", payid);

                param[1] = new SqlParameter("@empid", Convert.ToInt32(HttpContext.Current.Session["empid"]));

                param[2] = new SqlParameter("@adjustmenttype", Convert.ToInt32(adjustmenttype));

                param[3] = new SqlParameter("@adjustmentamount", Convert.ToDouble(adjustmentamount));

                param[4] = new SqlParameter("@Salleryamount", Convert.ToDouble(salleryamount));

                param[5] = new SqlParameter("@payableamount", Convert.ToDouble(payableamount));

                param[6] = new SqlParameter("@paymentdate", paymentdate);

                param[7] = new SqlParameter("@paymentmode", Convert.ToInt32(paymentmode));

                param[8] = new SqlParameter("@fyid", fyid);

                param[9] = new SqlParameter("@bankname", bankname);

                param[10] = new SqlParameter("@checknumber", checkno);

                param[11] = new SqlParameter("@checkdate", checkdate);

                param[12] = new SqlParameter("@intresult", SqlDbType.Int);

                param[12].Direction = ParameterDirection.Output;

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

                cmd.Parameters.Add(param[12]);

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }

    [WebMethod]
    public static int InsertAdvanceSallery(string advanceamount = "", string advancedate = "", string advancepaymentmode = "", string payid = "", string advancedescription = "", string advancebankname = "", string advancecheckno = "", string advancecheckdate = "")
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_advance_salary]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[10];

                param[0] = new SqlParameter("@empid", Convert.ToInt32(HttpContext.Current.Session["empid"]));

                param[1] = new SqlParameter("@amount", Convert.ToInt32(advanceamount));

                param[2] = new SqlParameter("@Date", advancedate);

                param[3] = new SqlParameter("@paymentmode", Convert.ToInt32(advancepaymentmode));

                param[4] = new SqlParameter("@payid", Convert.ToInt32(payid));

                param[5] = new SqlParameter("@description", advancedescription);

                param[6] = new SqlParameter("@bankname", advancebankname);

                param[7] = new SqlParameter("@checkno", advancecheckno);

                param[8] = new SqlParameter("@checkDate", advancecheckdate);

                param[9] = new SqlParameter("@intresult", SqlDbType.Int);

                param[9].Direction = ParameterDirection.Output;

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

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }
}