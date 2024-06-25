using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_feeinfo : System.Web.UI.Page
{
    private string url, q = "", Query;
    private long loginID;
    private int brID, adid;
    private double amount, totalpayable = 0, totalfine = 0.0, tamt = 0.0, famt = 0.0;
    private BEL bal = new BEL();
    private BLL objUserBLL = new BLL();
    private Utility objUT = new Utility();
    private SqlDataReader dr;
    private DataUtility objdut = new DataUtility();

    private DataTable dt, dt1;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrBrid"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (Session["stue"] == null)
        {
            Response.Redirect("studentadmissionlistaspx.aspx");
        }

        if (Request.QueryString.Count > 0)
        {
            loginID = objUT.GetAdmissionno(Request.QueryString[0]);
            ViewState["adid"] = loginID;
        }

        if (!IsPostBack)
        {
            Session.Remove("Adid");
            Session.Remove("paymonthid");
            Session.Remove("receptno");
            ViewState["acad"] = CommonClass.Scaler("ActiveAcademicYear");
            int trtype = Convert.ToInt32(CommonClass.Scaler("getTransType", Convert.ToInt16(Session["BrBrid"]), Convert.ToInt32(ViewState["adid"])));
            ViewState["transType"] = trtype;
            fillfee();
            getfine();
            unpaidfee();
        }
    }

    private void unpaidfee()
    {
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@studentid ", ViewState["adid"]);
        param[1] = new SqlParameter("@tansptype", ViewState["transType"]);

        dt = objdut.GetDataTableSP(param, "dbo.usp_getunpaidfee");
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
            foreach (GridViewRow row in GridView1.Rows)
            {
                Label lbstatus = (Label)row.FindControl("lbstatus");
                if (lbstatus.Text == "Overdue")
                {
                    lbstatus.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    lbstatus.ForeColor = System.Drawing.Color.Green;
                }
            }
        }
        else
        {
            GridView1.EmptyDataText = "No Record.";
            GridView1.DataSource = null;
            GridView1.DataBind();
        }
    }

    private void fillfee()
    {
        dt = CommonClass.parentdetails("stufeereport", Convert.ToInt32(ViewState["adid"]), Convert.ToInt16(Session["BrBrid"]));
        if (dt.Rows.Count > 0)
        {
            gridenquiry.DataSource = dt;
            gridenquiry.DataBind();
        }
        else
        {
            gridenquiry.EmptyDataText = "No Record.";
            gridenquiry.DataSource = null;
            gridenquiry.DataBind();
        }
        dt.Clear();
        Query = "select totalfee,paid,balance from tbl_Admission where adid=" + ViewState["adid"] + " and fyid=" + ViewState["acad"] + " and brid=" + Convert.ToInt32(Session["BrBrid"]);
        dr = objdut.GetDataReader(Query);
        if (dr.HasRows)
        {
            while (dr.Read())
            {
                lbltot.Text = string.Format("{0:f}", dr["totalfee"]);
                lblpaid.Text = string.Format("{0:f}", dr["paid"]);
                lblbal.Text = string.Format("{0:f}", dr["balance"]);
            }
        }
        dr.Close();
    }

    public void getfine()
    {
        BEL.adid = Convert.ToInt32(ViewState["adid"]);
        dt = BLL.showfinepaytime();
        if (dt.Rows.Count > 0)
        {
            tamt = Convert.ToDouble(dt.Rows[0]["fine"]);
            txtfine.Text = tamt.ToString("0.00");
            famt = Convert.ToDouble(dt.Rows[0]["fine"]);
            txtpayfinehere.Text = famt.ToString("0.00");
        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        //  System.Threading.Thread.Sleep(2000);
        string monthids = "";
        string allmonthid = "";
        if (rfineadjust.SelectedValue == "1")
        {
            totalpayable = Convert.ToDouble(txtAmount.Text);
            totalfine = Convert.ToDouble(txtpayfinehere.Text);

            if (totalfine > 0)
            {
                if (totalpayable >= totalfine)
                {
                    amount = totalpayable - totalfine;
                }
                else
                {
                    amount = totalfine - totalpayable;
                }
            }
            else
            {
                amount = Convert.ToDouble(txtAmount.Text);
            }
        }
        else
        {
            amount = Convert.ToDouble(txtAmount.Text);
        }

        brID = Convert.ToInt32(Session["BrBrid"]);
        adid = Convert.ToInt32(ViewState["adid"]);
        Session["Adid"] = adid;

        bal.actualfine = Convert.ToDouble(txtfine.Text);
        bal.mode = "afteradmission";
        bal.adid2 = adid;
        bal.brid = brID;
        if (rfineadjust.SelectedValue == "1")
        {
            bal.finepayornot = "finepay";
        }
        else
        {
            bal.finepayornot = "finenotepay";
        }
        bal.totalfine = totalfine;
        bal.payableamt = amount;
        bal.paymodeid = ddlPayMode.SelectedValue;
        if (ddlPayMode.SelectedIndex > 1)
        {
            bal.bankname = txtBankName.Text.Trim();
            bal.checkno = txtCheque.Text.Trim();
        }
        else
        {
            bal.bankname = "";
            bal.checkno = "";
        }
        bal.nextmonthid = Convert.ToInt32("0");
        monthids = Request.Form[Label3.UniqueID];

        allmonthid = Request.Form[label44.UniqueID];
        if (monthids.Length > 0)
        {
            monthids = monthids.Remove(0, 1);
        }
        else
        {
            return;
        }
        Session["monthids"] = monthids;
        if (Convert.ToInt16(HttpContext.Current.Session["paytype"]) == 1)
        {
            if (allmonthid.Length > 0)
            {
                allmonthid = allmonthid.Remove(0, 1);
                Session["allmonthid"] = allmonthid;
            }
            else
            {
                return;
            }
        }
        else
        {
            Session["allmonthid"] = Session["monthids"];
        }

        bal.monthids = monthids;

        int count = objUserBLL.insertpayfee(bal);
        if (count == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Fee inserted successfully..");
            Response.Redirect("depositfeestudent.aspx");
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "An error occured. Please try again.");
            return;
        }
    }

    [WebMethod]
    public static int getregno(int mid, string rno)
    {
        HttpContext.Current.Session["paymonthid"] = mid;
        HttpContext.Current.Session["receptno"] = rno;
        return 1;
    }
}