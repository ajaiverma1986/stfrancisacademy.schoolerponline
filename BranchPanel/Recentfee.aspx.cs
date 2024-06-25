using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_Recentfee : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private string url;

    private DataTable dt;
    private int totalpage = 0, countrecords = 0, i = 0;
    private int page;
    private double x = 0, y = 0, z = 0, w = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }

        if (!IsPostBack)
        {
            Session.Remove("stue");
            ViewState["acad"] = CommonClass.Scaler("ActiveAcademicYear");
            ViewState["PageNo"] = 1;
            ViewState["noofrecord"] = 20;
            setpage();
            bindgrid(20, 1, "--Select FeeType--", "", "", "");
        }
    }

    public void bindgrid(int pagesize, int pageno, string searchvalue, string classname, string adno, string name)
    {
        SqlParameter[] param = new SqlParameter[11];
        param[0] = new SqlParameter("@PageSize ", pagesize);
        param[1] = new SqlParameter("@CurrentPage", pageno);
        param[2] = new SqlParameter("@searchvalue1", searchvalue);
        param[3] = new SqlParameter("@classname", classname);
        param[9] = new SqlParameter("@searchbyadno", adno);
        param[10] = new SqlParameter("@searchbyname", name);

        param[4] = new SqlParameter("@overallfee", 0);
        param[4].Direction = ParameterDirection.Output;

        param[5] = new SqlParameter("@receivedfee", 0);
        param[5].Direction = ParameterDirection.Output;

        param[6] = new SqlParameter("@nextbalance", 0);
        param[6].Direction = ParameterDirection.Output;
        param[8] = new SqlParameter("@discount", 0);
        param[8].Direction = ParameterDirection.Output;

        param[7] = new SqlParameter("@brid", Session["BrBrid"]);

        dt = objdut.GetDataTableSP(param, "usp_overallcollection");
        if (dt.Rows.Count > 0)
        {
            gridAnnualFee.Visible = true;
            gridAnnualFee.DataSource = dt;
            gridAnnualFee.DataBind();
            x = Convert.ToDouble(param[4].Value);
            lblTotal.Text = string.Format("{0:n}", x);
            y = Convert.ToDouble(param[5].Value);
            lblReceived.Text = string.Format("{0:n}", y);
            z = Convert.ToDouble(param[6].Value);
            lblremain.Text = string.Format("{0:n}", z);
            w = Convert.ToDouble(param[8].Value);
            lbldiscount1.Text = string.Format("{0:n}", w);

            // string.Format("{0:n}", y);
        }
        else
        {
            gridAnnualFee.EmptyDataText = "No Record Found .!";
            gridAnnualFee.DataSource = null;
            gridAnnualFee.DataBind();
            lblTotal.Text = "0.00";
            lblReceived.Text = "0.00";
            lblremain.Text = "0.00";
            lbldiscount1.Text = "0.00";
            hjh.Visible = false;
            gg.Visible = false;
        }
    }

    [WebMethod]
    public static UserDetails[] BindDatatable(string pagesize, string pageno, string searchvalue1, string classname, string adno, string name2)
    {
        if (pageno == "Page No")
        {
            pageno = "1";
        }

        if (pageno == "")
        {
            pageno = "1";
        }
        DataTable dt;

        List<UserDetails> details = new List<UserDetails>();
        BEL.branchid = Convert.ToInt16(HttpContext.Current.Session["BrBrid"]);
        BEL.pagesize = Convert.ToInt32(pagesize);
        BEL.currentpage = Convert.ToInt32(pageno);
        BEL.searchvalue = searchvalue1;
        BEL.searchbyClass = classname;
        BEL.searchbyAdmissionNo = adno;
        BEL.searchbyName = name2;
        BEL.totalfee = Convert.ToDouble("0.00");
        BEL.paidfee = Convert.ToDouble("0.00");
        BEL.balfee = Convert.ToDouble("0.00");
        BEL.discount = Convert.ToDouble("0.00");

        dt = BLL.bindovercollection();

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in dt.Rows)
            {
                UserDetails user = new UserDetails();
                user.adno = dtrow["adno"].ToString();
                user.class1 = dtrow["applyclass"].ToString();
                user.name = dtrow["name"].ToString();
                user.totalfee = dtrow["totalfee"].ToString();
                user.paidfee = dtrow["paidfee"].ToString();
                user.balanfee = dtrow["balanfee"].ToString();
                user.rnumber = dtrow["rnumber"].ToString();
                user.discount = dtrow["discount"].ToString();

                user.Totalamount = string.Format("{0:n}", BEL.totalfee);
                user.Paidamount = string.Format("{0:n}", BEL.paidfee);
                user.Balanceamount = string.Format("{0:n}", BEL.balfee);
                user.discount1 = string.Format("{0:n}", BEL.discount);
                //user.Totalamount = Convert.ToString(BEL.totalfee);
                //user.Paidamount = Convert.ToString(BEL.paidfee);
                //user.Balanceamount = Convert.ToString(BEL.balfee);
                //user.discount1 = Convert.ToString(BEL.discount);

                details.Add(user);
            }
        }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string adno { get; set; }

        public string name { get; set; }

        public string class1 { get; set; }

        public string totalfee { get; set; }

        public string paidfee { get; set; }

        public string balanfee { get; set; }

        public string rnumber { get; set; }

        public string Totalamount { get; set; }

        public string Paidamount { get; set; }

        public string Balanceamount { get; set; }

        public string discount { get; set; }

        public string discount1 { get; set; }
    }

    private void setpage()
    {
        string query = "select count(1) from tbl_Admission where fyid=" + ViewState["acad"] + " and brid=" + Session["BrBrid"];
        int i = 0;
        PageNo.Items.Clear();
        PageNo.Items.Insert(i, Convert.ToString("Page No"));
        totalpage = Convert.ToInt32(objdut.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(objdut.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
        {
            //  totalpage = totalpage + 1;
        }
        else
        {
            totalpage = totalpage + 1;
        }
        for (page = 1; totalpage > 0; totalpage = totalpage - 1)
        {
            PageNo.Items.Insert(page, Convert.ToString(page));
            page = page + 1;
        }
        if (Convert.ToInt32(ViewState["PageNo"]) > totalpage)
        {
            ViewState["PageNo"] = 1;
        }
        if (page >= 1)
        {
            PageNo.SelectedIndex = 1;
        }
    }

    [WebMethod]
    public static ArrayList bingrid1(string pagesize, string pageno, string searchvalue1, string classname, string adno, string name2)
    {
        ArrayList details1 = new ArrayList();
        int i = 0;

        int totalpage = 0;

        int countnew = 0;
        if (pageno == "")
        {
            pageno = "1";
        }
        BEL.searchvalue = Convert.ToString(searchvalue1);
        BEL.searchbyClass = Convert.ToString(classname);
        BEL.searchbyAdmissionNo = Convert.ToString(adno);
        BEL.searchbyName = Convert.ToString(name2);

        BEL.branchid = Convert.ToInt16(HttpContext.Current.Session["BrBrid"]);
        countnew = BLL.countrecentfee();

        details1.Insert(i, Convert.ToString("Page No"));
        totalpage = countnew / Convert.ToInt32(pagesize);

        if ((Convert.ToInt32(countnew)) % (Convert.ToInt32(pagesize)) == 0)
        {
            //  totalpage = totalpage + 1;
        }
        else
        {
            totalpage = totalpage + 1;
        }

        for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
        {
            details1.Insert(page, Convert.ToString(page));

            page = page + 1;
        }

        if (Convert.ToInt32(HttpContext.Current.Session["PageNo"]) > totalpage)
        {
            HttpContext.Current.Session["PageNo"] = 1;
        }

        return details1;
    }

    [WebMethod]
    public static int getregno(string admno)
    {
        Utility objUT = new Utility();
        int ret = Convert.ToInt32(CommonClass.scaler("getstudentregno", Convert.ToString(admno), Convert.ToInt32(HttpContext.Current.Session["BrBrid"])));
        HttpContext.Current.Session["stue"] = ret;
        return ret;
    }
}