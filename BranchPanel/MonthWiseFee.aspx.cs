using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_MonthWiseFee : System.Web.UI.Page
{
    private string url;
    private CommonClass CommmonOBJ = new CommonClass();
    private DataTable dt;
    private int totalpage = 0, countofrecd = 0;
    private int page;
    private double x = 0, y = 0, z = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!IsPostBack)
        {
            ViewState["noofrecord"] = 20;
            ViewState["PageNo"] = 1;
            divde.Visible = true;
            bind_month();
            setpage();
            fillgrid(20, 1, 0, "", 0, "");
        }
    }

    private void fillgrid(int pagesize, int currentpage, int monthid, string feetype, int trtype, string name)
    {
        BEL.branchid = Convert.ToInt16(Session["BrBrid"]);
        BEL.pagesize = pagesize;
        BEL.currentpage = currentpage;
        BEL.feetype = "--Select FeeType--";
        BEL.monthid = 1;
        BEL.searchbyName = "";
        dt = BLL.bindmonthwisefee();
        if (dt.Rows.Count > 0)
        {
            ddlRecordperPage.SelectedIndex = 1;
            gridreport.DataSource = dt;
            gridreport.DataBind();
        }
        else
        {
            gridreport.EmptyDataText = "No Record Found.!";
            gridreport.DataBind();
        }
        dt.Clear();
        filfeesum();
    }

    private void filfeesum()
    {
        BEL.branchid = Convert.ToInt16(Session["BrBrid"]);
        BEL.monthid = 1;
        BEL.feetype = "--Select FeeType--";
        BEL.searchbyName = "";
        BEL.totalfee = Convert.ToDouble("0.00");
        BEL.paidfee = Convert.ToDouble("0.00");
        BEL.balfee = Convert.ToDouble("0.00");
        dt = BLL.bindstudentfeetotal();
        if (dt.Rows.Count > 0)
        {
            x = Convert.ToDouble(dt.Rows[0]["t1"].ToString());
            y = Convert.ToDouble(dt.Rows[0]["r1"].ToString());
            z = Convert.ToDouble(dt.Rows[0]["b1"].ToString());

            lblReceived.Text = string.Format("{0:n}", y);
            lblTotal.Text = string.Format("{0:n}", x);
            lblremain.Text = string.Format("{0:n}", z);
        }
        dt.Clear();
    }

    private void bind_month()
    {
        dt = CommmonOBJ.Dll("MonthName");
        ddlsearchoption.DataSource = dt;
        ddlsearchoption.DataBind();
        ddlsearchoption.DataTextField = "MonthName";
        ddlsearchoption.DataValueField = "MonthId";
        ddlsearchoption.DataBind();
        ddlsearchoption.SelectedIndex = 0;
        dt.Clear();
    }

    private void setpage()
    {
        countofrecd = CommonClass.scaler("sizeofpage", Convert.ToInt32(Session["BrBrid"]));
        int i = 0;
        PageNo.Items.Clear();
        PageNo.Items.Insert(i, Convert.ToString("Page No"));
        totalpage = Convert.ToInt32(countofrecd) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(countofrecd) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
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

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MonthWiseFee.aspx");
    }

    [WebMethod]
    public static ArrayList bingrid1(string pagesize, string pageno, int monthid, string feetype, string name)
    {
        ArrayList details1 = new ArrayList();
        int countnew = 0;
        if (pageno == "")
        {
            pageno = "Page No";
        }

        if (monthid > 0 && name == "")
        {
            BEL.sttype = feetype;
            countnew = BLL.countstudentwithType(feetype);
        }
        else if (monthid > 0 && name != "")
        {
            countnew = CommonClass.scaler("countnamewisestudent", Convert.ToString(name), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        }
        int i = 0;

        int totalpage = 0;

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
    public static UserDetails[] BindDatatable(string pagesize, string pageno, int monthid, string feetype, string name)
    {
        List<UserDetails> details = new List<UserDetails>();
        DataTable dt;
        if (pageno == "Page No")
        {
            pageno = "1";
        }

        if (pagesize == "Page Size")
        {
            pagesize = "20";
        }

        if (pageno == "")
        {
            pageno = "1";
        }

        BEL.branchid = Convert.ToInt16(HttpContext.Current.Session["BrBrid"]);
        BEL.pagesize = Convert.ToInt32(pagesize);
        BEL.currentpage = Convert.ToInt32(pageno);
        BEL.feetype = feetype;
        BEL.monthid = monthid;
        BEL.searchbyName = name;
        dt = BLL.bindmonthwisefee();
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in dt.Rows)
            {
                UserDetails user = new UserDetails();
                user.name = dtrow["name"].ToString();
                user.applyclass = dtrow["applyclass"].ToString();
                user.adno = dtrow["adno"].ToString();
                user.paiddate = dtrow["paiddate"].ToString();
                user.totalfee = dtrow["totalfee"].ToString();
                user.paidfee = dtrow["paidfee"].ToString();
                user.balanfee = dtrow["balanfee"].ToString();
                user.rnumber = dtrow["rnumber"].ToString();
                details.Add(user);
            }
        }

        return details.ToArray();
    }

    public class UserDetails
    {
        public string name { get; set; }

        public string applyclass { get; set; }

        public string adno { get; set; }

        public string paiddate { get; set; }

        public string totalfee { get; set; }

        public string paidfee { get; set; }

        public string balanfee { get; set; }

        public string rnumber { get; set; }
    }

    [WebMethod]
    public static feedetails[] filldata(int monthid, string transTtpe, string name)
    {
        List<feedetails> details = new List<feedetails>();
        DataTable dt = new DataTable();
        BEL.branchid = Convert.ToInt16(HttpContext.Current.Session["BrBrid"]);
        BEL.monthid = monthid;
        BEL.feetype = transTtpe;
        BEL.searchbyName = name;
        BEL.totalfee = Convert.ToDouble("0.00");
        BEL.paidfee = Convert.ToDouble("0.00");
        BEL.balfee = Convert.ToDouble("0.00");

        dt = BLL.bindstudentfeetotal();
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in dt.Rows)
            {
                feedetails user = new feedetails();
                user.totalfee = dtrow["t1"].ToString();
                user.payfee = dtrow["r1"].ToString();
                user.balfee = dtrow["b1"].ToString();
                details.Add(user);
            }
        }
        dt.Clear();
        return details.ToArray();
    }

    public class feedetails
    {
        public string totalfee { get; set; }

        public string payfee { get; set; }

        public string balfee { get; set; }
    }
}