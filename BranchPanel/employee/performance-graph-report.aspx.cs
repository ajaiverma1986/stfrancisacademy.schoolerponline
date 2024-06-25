using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class branchpanel_employee_performance_graph_report : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    public static int fyid = 2;
    public static int payid = 1;

    protected void Page_Load(object sender, EventArgs e)
    {
        fyid = CommonClass.Scaler("ActiveAcademicYear");
        payid = CommonClass.Scaler("getpayid", fyid);
        if (!IsPostBack)
        {
            hfeid.Value = Session["empid"].ToString();
            fillgrid();
            FillAllDDL();
        }
    }

    protected void FillAllDDL()
    {
        ddlfinancialyear.DataSource = CommonClass.ABC("DdlFinancialyear");
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataValueField = "FYID";
        ddlfinancialyear.DataBind();
        ddlfinancialyear.SelectedValue = fyid.ToString();

        ddlpayid.DataSource = CommonClass.ABC1("DdlMonth", fyid);
        ddlpayid.DataTextField = "Month_Name";
        ddlpayid.DataValueField = "payid";
        ddlpayid.DataBind();
        ddlpayid.SelectedValue = payid.ToString();
    }

    private void fillgrid()
    {
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@empid", Convert.ToInt32(Session["empid"]));
        param[1] = new SqlParameter("@fyid", fyid);
        param[2] = new SqlParameter("@payid", payid);
        DataTable Dt = objdut.GetDataTableSP(param, "[usp_performance_Bind]");
        if (Dt.Rows.Count > 0)
        {
            gridperformance.DataSource = Dt;
            gridperformance.DataBind();
        }
        else
        {
            gridperformance.EmptyDataText = "No performance report found.";
            gridperformance.DataBind();
        }
    }

    [WebMethod]
    public static fillperformance[] Fill_Performance(int fyid, int payid)
    {
        DataTable dt = new DataTable();
        List<fillperformance> details = new List<fillperformance>();

        SqlParameter[] p = new SqlParameter[3];
        p[0] = new SqlParameter("@empid", Convert.ToInt32(HttpContext.Current.Session["empid"]));
        p[1] = new SqlParameter("@fyid", fyid);
        p[2] = new SqlParameter("@payid", payid);

        DataUtility ObjDUT = new DataUtility();
        dt = ObjDUT.GetDataTableSP(p, "usp_performance_Bind");

        foreach (DataRow dtrow in dt.Rows)
        {
            fillperformance user = new fillperformance();
            user.RowNumber = dtrow["RowNumber"].ToString();
            user.job_performance = dtrow["job_performance"].ToString();

            user.perform1 = dtrow["perform1"].ToString();
            user.perform2 = dtrow["perform2"].ToString();
            user.perform3 = dtrow["perform3"].ToString();
            user.perform4 = dtrow["perform4"].ToString();
            user.perform5 = dtrow["perform5"].ToString();
            user.perform6 = dtrow["perform6"].ToString();
            user.perform7 = dtrow["perform7"].ToString();
            user.perform8 = dtrow["perform8"].ToString();
            user.perform9 = dtrow["perform9"].ToString();
            user.perform10 = dtrow["perform10"].ToString();

            user.perform11 = dtrow["perform11"].ToString();
            user.perform12 = dtrow["perform12"].ToString();
            user.perform13 = dtrow["perform13"].ToString();
            user.perform14 = dtrow["perform14"].ToString();
            user.perform15 = dtrow["perform15"].ToString();
            user.perform16 = dtrow["perform16"].ToString();
            user.perform17 = dtrow["perform17"].ToString();
            user.perform18 = dtrow["perform18"].ToString();
            user.perform19 = dtrow["perform19"].ToString();

            user.perform20 = dtrow["perform20"].ToString();
            user.perform21 = dtrow["perform21"].ToString();
            user.perform22 = dtrow["perform22"].ToString();
            user.perform23 = dtrow["perform23"].ToString();
            user.perform24 = dtrow["perform24"].ToString();
            user.perform25 = dtrow["perform25"].ToString();
            user.perform26 = dtrow["perform26"].ToString();
            user.perform27 = dtrow["perform27"].ToString();
            user.perform28 = dtrow["perform28"].ToString();
            user.perform29 = dtrow["perform29"].ToString();
            user.perform30 = dtrow["perform30"].ToString();

            user.perform31 = dtrow["perform31"].ToString();
            user.totalpoints = dtrow["totalpoints"].ToString();

            details.Add(user);
        }
        return details.ToArray();
    }

    public class fillperformance
    {
        public string RowNumber { get; set; }

        public string job_performance { get; set; }

        public string perform1 { get; set; }

        public string perform2 { get; set; }

        public string perform3 { get; set; }

        public string perform4 { get; set; }

        public string perform5 { get; set; }

        public string perform6 { get; set; }

        public string perform7 { get; set; }

        public string perform8 { get; set; }

        public string perform9 { get; set; }

        public string perform10 { get; set; }

        public string perform11 { get; set; }

        public string perform12 { get; set; }

        public string perform13 { get; set; }

        public string perform14 { get; set; }

        public string perform15 { get; set; }

        public string perform16 { get; set; }

        public string perform17 { get; set; }

        public string perform18 { get; set; }

        public string perform19 { get; set; }

        public string perform20 { get; set; }

        public string perform21 { get; set; }

        public string perform22 { get; set; }

        public string perform23 { get; set; }

        public string perform24 { get; set; }

        public string perform25 { get; set; }

        public string perform26 { get; set; }

        public string perform27 { get; set; }

        public string perform28 { get; set; }

        public string perform29 { get; set; }

        public string perform30 { get; set; }

        public string perform31 { get; set; }

        public string totalpoints { get; set; }
    }
}