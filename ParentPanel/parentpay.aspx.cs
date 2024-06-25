using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class ParentPanel_parentpay : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private Utility objUT = new Utility();
    private string PageName = "", url = "";

    private decimal amount;

    private double result, amount1, Payableamount;
    private DataUtility objDUT = new DataUtility();

    private string query, query2;
    private int brID, adid;
    private DataTable dt;
    private SqlDataReader dr;
    private static int academicyear = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["ADID4"] == null)
        {
            Response.Redirect("~/LoginP.aspx");
        }

        if (!IsPostBack)
        {
            ViewState["acad"] = CommonClass.Scaler("ActiveAcademicYear");
            int paytype = Convert.ToInt32(objdut.GetScalar("select ISNULL(paytype,0) from tbl_Admission where status=1 and adid=" + Session["ADID4"] + " and brid=" + Convert.ToInt32(Session["Branchid"]) + " and fyid=" + ViewState["acad"]));
            //if (paytype == 2)
            //{
            //    fillpaygrd();
            //}

            //else
            //{
            //    filgrdquater();
            //}
            BindColumnToGridviewMonth();
            BindColumnToGridviewQuater();
        }
    }

    private void BindColumnToGridviewQuater()
    {
        query = "select MonthId,MonthName,'notpaid' as paystatus,'1050.00' as payableamount,'3150' as paidamount from Month_name where days=28";

        dt = objdut.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            GridView2.DataSource = dt;
            GridView2.DataBind();
        }
        else
        {
            GridView2.DataSource = null;
            GridView2.DataBind();
        }
    }

    private void BindColumnToGridviewMonth()
    {
        query = "select MonthId,MonthName,'notpaid' as paystatus,'1050.00' as payableamount,'3150' as paidamount from Month_name where days=28";

        dt = objdut.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            grdclass.DataSource = dt;
            grdclass.DataBind();
        }
        else
        {
            grdclass.DataSource = null;
            grdclass.DataBind();
        }
    }

    [WebMethod]
    public static int getadid()
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            int ret = Convert.ToInt32(HttpContext.Current.Session["ADID4"]);
            return ret;
        }
    }

    [WebMethod]
    public static int getpayType(int admno)
    {
        DataUtility objdut = new DataUtility();
        Utility objUT = new Utility();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            int ret = Convert.ToInt32(objdut.GetScalar("select isnull(payType,0) from tbl_Admission where Adid=" + Convert.ToInt32(admno) + " and fyid=" + CommonClass.Scaler("ActiveAcademicYear")));
            return ret;
        }
    }

    [WebMethod]
    public static UserDetails[] BindDatatable(string FeType)
    {
        DataSet ds = new DataSet();
        List<UserDetails> details = new List<UserDetails>();
        DataUtility objdut = new DataUtility();
        int trtype = Convert.ToInt16(objdut.GetScalar("select isnull(transportaion,0) from tbl_Admission where adid=" + HttpContext.Current.Session["ADID4"] + " and fyid=" + CommonClass.Scaler("ActiveAcademicYear")));

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("dbo.usp_getstudentfees", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[4];
                param[0] = new SqlParameter("@studentid ", HttpContext.Current.Session["ADID4"]);
                param[1] = new SqlParameter("@fyid", CommonClass.Scaler("ActiveAcademicYear"));
                param[2] = new SqlParameter("@tansptype", Convert.ToInt32(trtype));
                param[3] = new SqlParameter("@FeeType", Convert.ToInt32(FeType));

                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                con.Open();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.monthid = dtrow["monthid"].ToString();
                        user.monthname = dtrow["monthname"].ToString();
                        user.paystatus = dtrow["paystatus"].ToString();
                        user.paybleamount = dtrow["payableamount"].ToString();
                        user.paidamount = dtrow["paidamount"].ToString();

                        details.Add(user);
                    }
                }
            }
        }

        return details.ToArray();
    }

    public class UserDetails
    {
        public string monthid { get; set; }

        public string monthname { get; set; }

        public string paystatus { get; set; }

        public string paybleamount { get; set; }

        public string paidamount { get; set; }

        public double fine { get; set; }
    }

    [WebMethod]
    public static UserDetails2[] Bindsecondgrid()
    {
        DataSet ds = new DataSet();
        List<UserDetails2> details = new List<UserDetails2>();
        DataUtility objdut = new DataUtility();
        int trtype = Convert.ToInt16(objdut.GetScalar("select isnull(transportaion,0) from tbl_Admission where adid=" + HttpContext.Current.Session["ADID4"] + " and fyid=" + CommonClass.Scaler("ActiveAcademicYear")));

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_getstudentfeesmonthwise", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@studentid ", HttpContext.Current.Session["ADID4"]);
                param[1] = new SqlParameter("@fyid", CommonClass.Scaler("ActiveAcademicYear"));
                param[2] = new SqlParameter("@tansptype", Convert.ToInt32(trtype));
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                con.Open();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails2 user = new UserDetails2();
                        user.monthid = dtrow["monthid"].ToString();
                        user.monthname = dtrow["monthname"].ToString();
                        user.paystatus = dtrow["paystatus"].ToString();
                        user.paybleamount = dtrow["payableamount"].ToString();
                        user.paidamount = dtrow["paidamount"].ToString();

                        details.Add(user);
                    }
                }
            }
        }

        return details.ToArray();
    }

    public class UserDetails2
    {
        public string monthid { get; set; }

        public string monthname { get; set; }

        public string paystatus { get; set; }

        public string paybleamount { get; set; }

        public string paidamount { get; set; }
    }

    [WebMethod]
    public static getfinedetial1[] getfine(string admno)
    {
        DataSet ds = new DataSet();
        List<getfinedetial1> details = new List<getfinedetial1>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("Usp_ShowFine_payTime", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];
                param[0] = new SqlParameter("@studentid ", HttpContext.Current.Session["ADID4"]);

                param[1] = new SqlParameter("@intResult", Convert.ToDouble("0"));
                param[1].Direction = ParameterDirection.Output;

                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                con.Open();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getfinedetial1 user = new getfinedetial1();
                        user.fine = Convert.ToDouble(dtrow["fine"]);
                        details.Add(user);
                    }
                }
            }
        }

        return details.ToArray();
    }

    public class getfinedetial1
    {
        public double fine { get; set; }
    }

    private void filgrdquater()
    {
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@studentid ", Session["ADID4"]);
        param[1] = new SqlParameter("@fyid", ViewState["acad"]);
        param[2] = new SqlParameter("@tansptype", Convert.ToInt32(Session["transptype"]));
        param[3] = new SqlParameter("@FeeType", 5);
        dt = objdut.GetDataTableSP(param, "dbo.usp_getstudentfees");
        if (dt.Rows.Count > 0)
        {
            GridView2.DataSource = dt;
            GridView2.DataBind();
        }
        else
        {
            GridView2.DataSource = null;
            GridView2.DataBind();
        }

        foreach (GridViewRow row in GridView2.Rows)
        {
            CheckBox chk1 = (CheckBox)row.FindControl("chkclss");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["monthid"].ToString() == "1" || dt.Rows[i]["monthid"].ToString() == "4" || dt.Rows[i]["monthid"].ToString() == "7" || dt.Rows[i]["monthid"].ToString() == "10")
                {
                    GridView2.HeaderRow.Cells[2].Visible = false;
                    GridView2.HeaderRow.Cells[3].Visible = false;
                }
            }
        }

        dt.Dispose();
    }

    private void fillpaygrd()
    {
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@studentid ", Session["ADID4"]);
        param[1] = new SqlParameter("@fyid", ViewState["acad"]);
        param[2] = new SqlParameter("@tansptype", Convert.ToInt32(Session["transptype"]));
        param[3] = new SqlParameter("@FeeType", 5);
        dt = objdut.GetDataTableSP(param, "usp_getstudentfeesmonthwise");
        if (dt.Rows.Count > 0)
        {
            //divbank.Visible = false;
            divpay.Visible = true;
            grdclass.DataSource = dt;
            grdclass.DataBind();
        }
        else
        {
            grdclass.DataSource = null;
            grdclass.DataBind();
        }
        dt.Dispose();
    }

    private void fillgrd()
    {
        query = "select MonthId,MonthName,'notpaid' as paystatus,'1050.00' as payableamount,'3150' as paidamount from Month_name where days=28";

        dt = objDUT.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            grdclass.DataSource = dt;
            grdclass.DataBind();
        }
        else
        {
            grdclass.DataSource = null;
            grdclass.DataBind();
        }
        //Table1.Visible = false;
        //Table1.Style.Add("display", "none");
    }

    //[WebMethod]
    //public static int getpayType(string admno)
    //{
    //    long loginID;
    //    DataUtility objdut = new DataUtility();
    //    Utility objUT = new Utility();
    //    using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
    //    {
    //        HttpContext.Current.Session["adnon"] = admno;
    //        loginID = objUT.GetAdmissionno(admno);
    //        HttpContext.Current.Session["Adid"] = loginID;

    //        int ret = Convert.ToInt16(objdut.GetScalar("select isnull(payType,0) from tbl_Admission where Adid=" + loginID + " and fyid=" + CommonClass.Scaler("ActiveAcademicYear")));

    //        return ret;
    //    }
    //}

    protected void Button1_Click(object sender, EventArgs e)
    {
        System.Threading.Thread.Sleep(2000);
        string monthids = "";
        amount = Convert.ToDecimal(txtAmount.Text);

        brID = Convert.ToInt32(Session["Branchid"]);
        adid = Convert.ToInt32(Session["ADID4"]);
        query2 = "usp_submitfee";
        SqlParameter[] param = new SqlParameter[11];
        param[10] = new SqlParameter("@mode", "afteradmission");
        param[0] = new SqlParameter("@Adid", adid);
        param[1] = new SqlParameter("@brid", brID);
        param[2] = new SqlParameter("@debitAmt", 25);
        param[9] = new SqlParameter("@setAmt", amount);
        param[3] = new SqlParameter("@paymode", ddlPayMode.SelectedItem.Text);
        if (ddlPayMode.SelectedIndex > 1)
        {
            param[4] = new SqlParameter("@BankName", txtBankName.Text.Trim());
            param[5] = new SqlParameter("@checkno", txtCheque.Text.Trim());
        }
        else
        {
            param[4] = new SqlParameter("@BankName", "");
            param[5] = new SqlParameter("@checkno", "");
        }
        param[8] = new SqlParameter("@nextmonthid", Convert.ToInt32("0"));
        param[6] = new SqlParameter("@intresult", Convert.ToInt32("0"));
        param[6].Direction = ParameterDirection.Output;

        monthids = Request.Form[Label3.UniqueID];
        if (monthids.Length > 0)
        {
            monthids = monthids.Remove(0, 1);
        }
        else
        {
            return;
        }
        param[7] = new SqlParameter("@monthids", monthids);
        Session["mothids"] = monthids;
        int count = objdut.ExecuteSqlSP(param, query2);
        if (count == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Fee inserted successfully..");
            Response.Redirect("parentfeeslip.aspx");
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "An error occured. Please try again.");
            return;
        }
    }
}