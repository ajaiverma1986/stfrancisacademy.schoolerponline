using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_transactiondetail : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private string url;
    private DataTable dt;
    private int totalpage = 0, countrecords = 0, i = 0;
    private int page;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        if (!IsPostBack)
        {
            ViewState["acad"] = CommonClass.Scaler("ActiveAcademicYear");
            ViewState["noofrecord"] = 10;
            ViewState["PageNo"] = 1;
            setpage();
            bindtransactiongrid(10, 1, "", "", "", "", "");
        }
    }

    public void bindtransactiongrid(int pagesize, int pageno, string searchbyname, string searchbyadno, string searchbyclass, string searchbyfrmdate, string searchbytodate)
    {
        SqlParameter[] param = new SqlParameter[8];
        param[0] = new SqlParameter("@PageSize", pagesize);
        param[1] = new SqlParameter("@CurrentPage", pageno);
        param[2] = new SqlParameter("@searchbyname", searchbyname);
        param[3] = new SqlParameter("@searchbyadno", searchbyadno);
        param[4] = new SqlParameter("@searchbyclass", searchbyclass);
        param[5] = new SqlParameter("@searchbyfrmdate", searchbyfrmdate);
        param[6] = new SqlParameter("@searchbytodate", searchbytodate);
        param[7] = new SqlParameter("@brid", Session["BrBrid"]);

        dt = objdut.GetDataTableSP(param, "usp_gettransactionreport");
        if (dt.Rows.Count > 0)
        {
            var sum = dt.Compute("SUM(payfee)", string.Empty);
            gridtransaction.DataSource = dt;
            gridtransaction.DataBind();
            lblTotal.Text = string.Format("{0:n}", sum);
        }
        else
        {
            gridtransaction.EmptyDataText = "No Record found.!";
            gridtransaction.DataSource = null;
            gridtransaction.DataBind();
        }
    }

    private void setpage()
    {
        string query = @";WITH g AS(select ROW_NUMBER() OVER (ORDER BY receiptno desc ) AS RowNumber from tbl_payfee tpf join tbl_Admission tad on tpf.Studentid=tad.adid join student_master sm on tad.sturegno=sm.sturegno where tad.brid=1 and tad.fyid=2 group by receiptno ,Studentid,FirstName,MiddleName,LastName,paymode ,CONVERT(VARCHAR(24),transaction_date,106))
                          select count(1) from g";
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
    public static ArrayList bingrid1(string pagesize, string pageno, string searchbyname, string searchbyadno, string searchbyclass, string searchbyfrmdate, string searchbytodate)
    {
        ArrayList details1 = new ArrayList();
        int i = 0;

        int totalpage = 0;

        int countnew = 0;
        if (pageno == "")
        {
            pageno = "1";
        }

        BEL.searchbyName = Convert.ToString(searchbyname);
        BEL.searchbyAdmissionNo = Convert.ToString(searchbyadno);
        BEL.searchbyClass = Convert.ToString(searchbyclass);
        BEL.searchbydate = Convert.ToString(searchbyfrmdate);
        BEL.searchbydate2 = Convert.ToString(searchbytodate);

        BEL.branchid = Convert.ToInt16(HttpContext.Current.Session["BrBrid"]);
        countnew = BLL.counttransaction();

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
    public static UserDetails[] BindDatatable(string pagesize, string pageno, string searchbyname, string searchbyadno, string searchbyclass, string searchbyfrmdate, string searchbytodate)
    {
        if (pageno == "Page No")
        {
            pageno = "1";
        }

        if (pageno == "")
        {
            pageno = "1";
        }
        DataSet ds = new DataSet();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_gettransactionreport]", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[8];
                param[0] = new SqlParameter("@PageSize", pagesize);
                param[1] = new SqlParameter("@CurrentPage", pageno);
                param[2] = new SqlParameter("@searchbyname", searchbyname);
                param[3] = new SqlParameter("@searchbyadno", searchbyadno);
                param[4] = new SqlParameter("@searchbyclass", searchbyclass);
                param[5] = new SqlParameter("@searchbyfrmdate", searchbyfrmdate);
                param[6] = new SqlParameter("@searchbytodate", searchbytodate);
                param[7] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);

                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);
                cmd.Parameters.Add(param[6]);
                cmd.Parameters.Add(param[7]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                con.Open();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.name = dtrow["name"].ToString();
                        user.adno = dtrow["adno"].ToString();
                        user.class1 = dtrow["applyclass"].ToString();
                        user.transactiondate = dtrow["transaction_date"].ToString();
                        user.receiptno = dtrow["receiptno"].ToString();
                        user.paymode = dtrow["paymode"].ToString();
                        user.payfee = dtrow["payfee"].ToString();
                        user.rnumber = dtrow["ROW_NUMBER"].ToString();

                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string name { get; set; }

        public string adno { get; set; }

        public string class1 { get; set; }

        public string transactiondate { get; set; }

        public string receiptno { get; set; }

        public string paymode { get; set; }

        public string payfee { get; set; }

        public string rnumber { get; set; }
    }

    [WebMethod]
    public static int getregno(string admno)
    {
        Utility objUT = new Utility();
        int ret = Convert.ToInt32(CommonClass.scaler("getstudentregno", Convert.ToString(admno), Convert.ToInt32(HttpContext.Current.Session["BrBrid"])));
        HttpContext.Current.Session["stue"] = ret;
        return ret;
    }

    //[WebMethod]
    //public static int getregno( string rno)
    //{
    //    //HttpContext.Current.Session["paymonthid"] = mid;
    //    HttpContext.Current.Session["receptno"] = rno;
    //    return 1;
    //}
}