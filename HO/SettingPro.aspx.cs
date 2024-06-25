using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;

public partial class HO_SettingPro : BasePage
{
    private string url, query, pname, query1, PageName;

    private Utility objut = new Utility();
    private DataUtility objDUT = new DataUtility();
    private DataSet dt;
    private int settingid = 0, count = 0;
    private SqlParameter[] param;
    private DateTime StartDate;
    private DateTime enddate;
    private StringBuilder strtable = new StringBuilder();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtDate.Enabled = true;
            fillGrid();
            Session["taxid"] = null;
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("EnquiryMaster.aspx");
    }

    protected void btnTitle_Click(object sender, EventArgs e)
    {
        Response.Redirect("ChangeTitle.aspx");
    }

    protected void fillGrid()
    {
        dt = objDUT.GetDataSetSP("usp_taxmissingdate");

        if (dt.Tables[0].Rows.Count > 0)
        {
            gvdetails.DataSource = dt.Tables[0];
            ViewState["dt"] = dt.Tables[0];
            gvdetails.DataBind();
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "No Applicable Tax Added Yet.");
            gvdetails.DataSource = null;
            gvdetails.DataBind();
        }

        if (dt.Tables[1].Rows.Count > 0)
        {
            int i = dt.Tables[1].Rows.Count;
            int j = 0;
            string class1 = "";
            strtable.AppendFormat(@"<table class='stm' style='width:98.2%;border-collapse:collapse;'><tr class='stm_head'><th> S.no.</th><th>MissingTax FromDate</th><th>MissingTax ToDate</th></tr>");
            while (i > j)
            {
                if (j % 2 == 0)
                {
                    class1 = "stm_light";
                }
                else
                {
                    class1 = "stm_dark";
                }
                strtable.AppendFormat(@"<tr class=" + class1 + "><td>" + (j + 1) + "</td><td>" + dt.Tables[1].Rows[j]["misssing_fromdate"] + "</td><td>" + dt.Tables[1].Rows[j]["missing_todate"] + "</td>");
                strtable.AppendFormat("</tr>");
                j = j + 1;
            }
            strtable.AppendFormat(@"</table>");
            missing_detail.InnerHtml = strtable.ToString();
        }
    }
    protected void btnSetting_Click(object sender, EventArgs e)
    {
        Response.Redirect("SettingPro.aspx");
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        StartDate = Convert.ToDateTime(objDUT.GetScalar("select cast('" + txtDate.Text + "' as datetime)"));
        if (!string.IsNullOrEmpty(txtToDate.Text))
        {
            enddate = Convert.ToDateTime(objDUT.GetScalar(" select cast('" + txtToDate.Text + "' as datetime)"));
            if (enddate < StartDate)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Applicable till date cannot be less than applicable from date!!!");
                txtToDate.Text = "";
                return;
            }
        }
        pname = "usp_limit";
        param = new SqlParameter[8];
        if (btnSubmit.Text == "Submit")
        {
            param[0] = new SqlParameter("@mode", "InsertTax");
            param[1] = new SqlParameter("@ST", txt_servicetax.Text.Trim());
            param[2] = new SqlParameter("@EC", txt_edycess.Text.Trim() == "" ? "0.00" : txt_edycess.Text.Trim());
            param[3] = new SqlParameter("@HEC", txtLimit.Text.Trim() == "" ? "0.00" : txtLimit.Text.Trim());//txtLimit.Text.Trim()
            param[4] = new SqlParameter("@fromdate", txtDate.Text.Trim());
            param[5] = new SqlParameter("@todate", txtToDate.Text.Trim());
            param[6] = new SqlParameter("@intResult", Convert.ToInt16("0"));
            param[6].Direction = ParameterDirection.Output;
            param[7] = new SqlParameter("@taxid", 0);
            count = objDUT.ExecuteSqlSP(param, pname);
            if (count == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Tax Added Successfully.");
                fillGrid();
                txtDate.Enabled = true;
                return;
            }
            else if (count == 2)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Please Select A Different Date Range.");
                fillGrid();
                txtDate.Enabled = true;
                return;
            }
            else if (count == 3)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Please Select A Different Date Range.");
                return;
            }
        }
    }

    protected void txtDate_TextChanged(object sender, EventArgs e)
    {
        try
        {
            StartDate = Convert.ToDateTime(txtDate.Text.ToString());
        }
        catch
        {
            txtDate.Text = "";
            Utility.ViewAlertMessage(Page, "Please select a valid date.");
            return;
        }
    }

    protected void txtToDate_TextChanged(object sender, EventArgs e)
    {
        try
        {
            StartDate = Convert.ToDateTime(txtToDate.Text.ToString());
        }
        catch
        {
            txtToDate.Text = "";
            Utility.ViewAlertMessage(Page, "please select valid date.");
            return;
        }
    }

    [System.Web.Services.WebMethod]
    public static taxsetting viewtax(string taxid)
    {
        taxsetting ts = new taxsetting();
        DataUtility objdut = new DataUtility();
        string que = @"Select servicetax,educationcess,HigherEdu_and_educess,CONVERT( VARCHAR(30), applyfromdate ,101) as fromdate,
                      CONVERT( VARCHAR(30), applytilldate ,101)as todate from tax_Setting where tax_id=" + taxid;
        DataTable dt = objdut.GetDataTable(que);
        if (dt.Rows.Count > 0)
        {
            ts.ST = dt.Rows[0]["servicetax"].ToString();
            ts.ES = dt.Rows[0]["educationcess"].ToString();
            ts.HES = dt.Rows[0]["HigherEdu_and_educess"].ToString();
            ts.FD = dt.Rows[0]["fromdate"].ToString();
            if (dt.Rows[0]["todate"].ToString() != "31-12-9999")
                ts.TD = dt.Rows[0]["todate"].ToString();
            HttpContext.Current.Session["taxid"] = taxid;
        }
        return ts;
    }

    public class taxsetting
    {
        public string ST { get; set; }

        public string ES { get; set; }

        public string HES { get; set; }

        public string FD { get; set; }

        public string TD { get; set; }

        public string LIMIT { get; set; }

        public string taxid { get; set; }

        public string missingfromdate { get; set; }

        public string missingtodate { get; set; }

        public int result { get; set; }
    }

    [System.Web.Services.WebMethod]
    public static List<taxsetting> updatetax(string taxid, string st, string fmdt, string ec, string hec, string tdt)
    {
        SqlParameter[] param = new SqlParameter[8];
        DataUtility objdut = new DataUtility();
        List<taxsetting> taxobj = new List<taxsetting>();
        taxsetting tax;
        param[0] = new SqlParameter("@mode", "UpdateTax");
        param[1] = new SqlParameter("@ST", st);
        param[2] = new SqlParameter("@EC", ec);
        param[3] = new SqlParameter("@HEC", hec);

        param[4] = new SqlParameter("@fromdate", fmdt);
        param[5] = new SqlParameter("@todate", tdt);
        param[6] = new SqlParameter("@intResult", Convert.ToInt16("0"));
        param[6].Direction = ParameterDirection.Output;
        param[7] = new SqlParameter("@taxid", taxid);

        int count = objdut.ExecuteSqlSP(param, "usp_limit");
        DataSet ds = objdut.GetDataSetSP("usp_taxmissingdate");

        if (ds.Tables[0].Rows.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                tax = new taxsetting();
                tax.ST = ds.Tables[0].Rows[i]["servicetax"].ToString();
                tax.ES = ds.Tables[0].Rows[i]["educationcess"].ToString();
                tax.HES = ds.Tables[0].Rows[i]["HigherEdu_and_educess"].ToString();
                tax.FD = ds.Tables[0].Rows[i]["applyfromdate"].ToString();
                tax.TD = ds.Tables[0].Rows[i]["todate"].ToString();
                tax.LIMIT = ds.Tables[0].Rows[i]["limit"].ToString();
                tax.taxid = ds.Tables[0].Rows[i]["tax_id"].ToString();
                tax.result = count;
                if (ds.Tables[1].Rows.Count > i)
                {
                    if (ds.Tables[1].Rows[i]["misssing_fromdate"] != null)
                    {
                        tax.missingfromdate = ds.Tables[1].Rows[i]["misssing_fromdate"].ToString();
                        tax.missingtodate = ds.Tables[1].Rows[i]["missing_todate"].ToString();
                    }
                }
                taxobj.Add(tax);
            }
        }

        return taxobj;
    }
}