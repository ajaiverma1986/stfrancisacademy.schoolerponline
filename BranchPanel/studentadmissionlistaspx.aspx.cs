using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class BranchPanel_studentadmissionlistaspx : System.Web.UI.Page
{
    private SqlParameter[] param1 = new SqlParameter[7];
    private DataUtility objDUT = new DataUtility();
    private CommonClass commonobj = new CommonClass();
    private string fromdate = string.Empty;
    private string todate = string.Empty;
    private int totalpage = 0;
    private string query, query1, query2, currentyear, query3, query4, query5, query7, query8, query9, Fromdate, query10;
    private int domainID = 0;
    private int status, regid1, classid, count, count2, count3, sectionid;
    private DataTable dt2;

    protected void Page_Load(object sender, EventArgs e)
    {
        Label masterlbl = (Label)Master.FindControl("lblDynamicMenu");
        GetAcademicYear();
        Session.Remove("admno");
        Session.Remove("Adid");
        Session.Remove("stue");
        if (!IsPostBack)
        {
            int x = Convert.ToInt32(objDUT.GetScalar("select FYID from financial_Year where isActive=1 and isClosed=0"));
            ViewState["fyid"] = x;
            Session["CurrentYear"] = x;
            if (Session["currentPageindex"] != null)
            {
                gvdetails.PageIndex = (int)Session["currentPageindex"];
            }
            {
                ViewState["noofrecord"] = 20;
                ViewState["PageNo"] = 1;
                query = string.Empty;
                ViewState["q"] = query;
                setpage();
                fillgrid(20, 1, 0, 0, "");
            }
        }
    }

    public void GetAcademicYear()
    {
        query2 = "Select FYName from financial_Year where isactive=1";
        currentyear = (objDUT.GetScalar(query2)).ToString();
        Session["CurrentYear"] = currentyear;
    }

    public void fillgrd(int mode)
    {
        if (mode == 1)
        {
            dt2 = CommonClass.ABC1("admissionlist", Convert.ToInt32(Session["BrBrid"]));
        }

        if (dt2.Rows.Count > 0)
        {
            gvdetails.DataSource = dt2;
            ViewState["dt"] = dt2;
            gvdetails.DataBind();
            gvdetails1.DataSource = dt2;
            gvdetails1.DataBind();
            IBExcel.Visible = true;
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "No records found matching this criteria.");
            gvdetails.DataSource = (DataTable)ViewState["dt"];
            gvdetails.DataBind();
        }
        dt2.Dispose();
    }

    protected DateTime dateformat(string str)
    {
        string[] str1;
        str1 = str.Split('/');
        return Convert.ToDateTime(str1[2] + "/" + str1[0] + "/" + str1[1]);
    }

    protected DateTime dateformat1(string str)
    {
        string[] str1;
        str1 = str.Split('/');
        return Convert.ToDateTime(str1[2] + "-" + str1[0] + "-" + str1[1]);
    }

    protected void gvdetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        query3 = (string)ViewState["q"];
        gvdetails.PageIndex = e.NewPageIndex;
        gvdetails1.PageIndex = e.NewPageIndex;
        fillgrid(20, 1, 0, 0, "");
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("student-admission-form.aspx");
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        PrepareGridViewForExport(gvdetails1);
        ExportGridView();
    }

    private void PrepareGridViewForExport(Control gv)
    {
        Label lb = new Label();

        Literal l = new Literal();

        string name = String.Empty;

        for (int i = 0; i < gv.Controls.Count; i++)
        {
            if (gv.Controls[i].GetType() == typeof(Label))
            {
                l.Text = (gv.Controls[i] as Label).Text;

                gv.Controls.Remove(gv.Controls[i]);

                gv.Controls.AddAt(i, l);
            }

            if (gv.Controls[i].HasControls())
            {
                PrepareGridViewForExport(gv.Controls[i]);
            }
        }
    }

    private void ExportGridView()
    {
        string attachment = "attachment; filename=Member_List.xls";

        Response.ClearContent();

        Response.AddHeader("content-disposition", attachment);

        Response.ContentType = "application/ms-excel";

        StringWriter sw = new StringWriter();

        HtmlTextWriter htw = new HtmlTextWriter(sw);

        HtmlForm frm = new HtmlForm();

        gvdetails1.Parent.Controls.Add(frm);

        frm.Attributes["runat"] = "server";

        frm.Controls.Add(gvdetails1);

        frm.RenderControl(htw);

        Response.Write(sw.ToString());

        Response.End();
    }

    private void fillgrid(int pagesize, int currentpage, int userid, int cid, string value)
    {
        param1[0] = new SqlParameter("@PageSize", pagesize);
        param1[1] = new SqlParameter("@CurrentPage", currentpage);
        param1[2] = new SqlParameter("@searchitem", userid);
        param1[3] = new SqlParameter("@classid", cid);
        param1[4] = new SqlParameter("@value", value);
        param1[5] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));
        param1[6] = new SqlParameter("@fyid", Convert.ToInt16(ViewState["fyid"]));
        DataTable dt = objDUT.GetDataTableSP(param1, "usp_admissionsearch");
        if (dt.Rows.Count > 0)
        {
            gvdetails.DataSource = dt;
            gvdetails.DataBind();
            gvdetails1.DataSource = dt;
            gvdetails1.DataBind();
            IBExcel.Visible = true;
        }
        else
        {
            // Utility.ViewAlertMessage(this.Master.Page, "No record Found!");
            gvdetails.EmptyDataText = "No Record Found";
            gvdetails.DataSource = null;
            gvdetails.DataBind();
        }
        dt.Dispose();
    }

    private void setpage()
    {
        string query = "select count(1) from tbl_Admission where status=1 and brid=" + Session["BrBrid"] + " and fyid=" + ViewState["fyid"];
        int i = 0;
        PageNo.Items.Clear();
        PageNo.Items.Insert(i, Convert.ToString("Page No"));
        totalpage = Convert.ToInt32(objDUT.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(objDUT.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
        {
            //  totalpage = totalpage + 1;
        }
        else
        {
            totalpage = totalpage + 1;
        }
        for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
        {
            PageNo.Items.Insert(page, Convert.ToString(page));
            page = page + 1;
        }
        if (Convert.ToInt32(ViewState["PageNo"]) > totalpage)
        {
            ViewState["PageNo"] = 1;
        }
    }

    [WebMethod]
    public static ArrayList bingrid1(string cid, string textboxvalue1, string pageno, string searchitem, string classid)
    {
        ArrayList details1 = new ArrayList();
        DataTable dt = new DataTable();
        SqlCommand cmd;
        int countnew = 0;
        if (pageno == "")
        {
            pageno = "Page No";
        }
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            if (searchitem == "0")
            {
                con.Open();
                string query = "select count(1) from tbl_admission where status=1 and brid=" + HttpContext.Current.Session["BrBrid"] + " and fyid=" + HttpContext.Current.Session["CurrentYear"];
                cmd = new SqlCommand(query, con);
                countnew = Convert.ToInt32(cmd.ExecuteScalar());
            }
            else if (searchitem == "1")
            {
                con.Open();
                string query = "select count(1) from tbl_admission tm inner join student_master sm on tm.ADMIID=sm.ADMIID where tm.status=1 and tm.brid=" + HttpContext.Current.Session["BrBrid"] + " and tm.fyid=" + HttpContext.Current.Session["CurrentYear"] + " and sm.firstname like '%" + textboxvalue1 + "%'";
                cmd = new SqlCommand(query, con);
                countnew = Convert.ToInt32(cmd.ExecuteScalar());
            }
            else if (searchitem == "2")
            {
                con.Open();
                cmd = new SqlCommand("select count(1) from tbl_admission tm inner join student_master sm on tm.ADMIID=sm.ADMIID where tm.status=1 and tm.brid=" + HttpContext.Current.Session["BrBrid"] + " and tm.fyid=" + HttpContext.Current.Session["CurrentYear"] + " and sm.FirstName like '%" + textboxvalue1 + "%'", con);
                countnew = Convert.ToInt32(cmd.ExecuteScalar());
            }
            else if (searchitem == "4")
            {
                con.Open();
                cmd = new SqlCommand("select count(1) from tbl_admission tm inner join student_master sm on tm.ADMIID=sm.ADMIID where tm.status=1 and tm.brid=" + HttpContext.Current.Session["BrBrid"] + " and tm.fyid=" + HttpContext.Current.Session["CurrentYear"] + " and sm.FMobileNo like '%" + textboxvalue1 + "%'", con);
                countnew = Convert.ToInt32(cmd.ExecuteScalar());
            }
            else if (searchitem == "3" && classid != "0")
            {
                con.Open();
                cmd = new SqlCommand("select count(1) from tbl_admission tm inner join student_master sm on tm.ADMIID=sm.ADMIID where tm.status=1 and tm.brid=" + HttpContext.Current.Session["BrBrid"] + " and tm.fyid=" + HttpContext.Current.Session["CurrentYear"] + " and tm.classid=" + Convert.ToInt32(classid), con);
                countnew = Convert.ToInt32(cmd.ExecuteScalar());
            }
            else if (searchitem == "3" && classid == "0")
            {
                con.Open();
                cmd = new SqlCommand("select count(1) from tbl_admission where status=1 and brid=" + HttpContext.Current.Session["BrBrid"] + " and fyid=" + HttpContext.Current.Session["CurrentYear"], con);
                countnew = Convert.ToInt32(cmd.ExecuteScalar());
            }

            int i = 0;

            con.Close();

            int totalpage = 0;

            details1.Insert(i, Convert.ToString("Page No"));
            totalpage = countnew / Convert.ToInt32(cid);

            if ((Convert.ToInt32(countnew)) % (Convert.ToInt32(cid)) == 0)
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
        }
        return details1;
    }

    [WebMethod]
    public static UserDetails[] BindDatatable(string pagesize, string textboxvalue1, string pageno, string searchitem, string classid)
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
            using (SqlCommand cmd = new SqlCommand("[usp_admissionsearch]", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[7];
                param[0] = new SqlParameter("@PageSize ", pagesize);
                param[1] = new SqlParameter("@CurrentPage", pageno);
                param[2] = new SqlParameter("@value", textboxvalue1);
                param[3] = new SqlParameter("@searchitem", searchitem);
                param[4] = new SqlParameter("@brid", HttpContext.Current.Session["BrBrid"]);
                param[5] = new SqlParameter("@classid", classid);
                param[6] = new SqlParameter("@fyid", HttpContext.Current.Session["CurrentYear"]);

                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);
                cmd.Parameters.Add(param[6]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                con.Open();
                da.Fill(ds);
                //   DataTable dt = objDUT.GetDataTableSP(param, "[usp_homelifestyle_searching]");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.adno = dtrow["adno"].ToString();
                        user.admiDate = dtrow["admissionDate"].ToString();
                        user.applyclass = dtrow["applyclass"].ToString();
                        user.classid = Convert.ToInt32(dtrow["classid"].ToString());
                        user.imageurl = dtrow["photo"].ToString();
                        user.sname = dtrow["name"].ToString();
                        user.Rid = dtrow["sturegno"].ToString();
                        user.admiid = dtrow["admiid"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class UserDetails
    {
        public string adno { get; set; }

        public string sname { get; set; }

        public string imageurl { get; set; }

        public string admiDate { get; set; }

        public int classid { get; set; }

        public string applyclass { get; set; }

        public string Rid { get; set; }

        public string admiid { get; set; }
    }

    [WebMethod]
    public static bindclasses_new[] bindclassses(string cid)
    {
        List<bindclasses_new> details = new List<bindclasses_new>();
        DataTable dt = new DataTable();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select classid,Classname from ClassBranch_master where status=1  and BranchId=" + HttpContext.Current.Session["BrBrid"] + "   order by classid asc", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                bindclasses_new objProductMasterDetails0 = new bindclasses_new();
                objProductMasterDetails0.SID = Convert.ToInt32("0");
                objProductMasterDetails0.statename = "-Select Classname-";
                details.Add(objProductMasterDetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    bindclasses_new objProductMasterDetails = new bindclasses_new();
                    objProductMasterDetails.SID = Convert.ToInt32(dtrow["classid"].ToString());
                    objProductMasterDetails.statename = dtrow["Classname"].ToString();
                    details.Add(objProductMasterDetails);
                }
            }
        }
        return details.ToArray();
    }

    public class bindclasses_new
    {
        public int SID { get; set; }

        public string statename { get; set; }
    }
}