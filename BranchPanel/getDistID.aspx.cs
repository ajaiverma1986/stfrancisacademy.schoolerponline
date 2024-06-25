using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.Services;

public partial class adminPanel_Default4 : System.Web.UI.Page
{
    private string url = "";
    private int brID, adid;
    private BLL objUserBLL = new BLL();
    private string type;
    private DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();

        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        if (!IsPostBack)
        {
            Session.Remove("adnon");
            Session.Remove("monthids");
            Session.Remove("allmonthid");
            Session.Remove("stue");
            BindColumnToGridview1();

            if (Request.QueryString.Count > 0)
            {
                type = Request.QueryString["type"];
                if (type == "FS")
                {
                    tblheading.Text = "Collect Fee Here";
                    lblHeading.Text = "Collect Fee";
                }
                else if (type == "FSR")
                {
                    tblheading.Text = "Student Fee Report";
                    lblHeading.Text = "Fee Report";
                }
                else
                {
                }
            }
        }
    }

    private void BindColumnToGridview1()
    {
        dt = objUserBLL.binddatalistsearch();
        DataList2.DataSource = dt;
        DataList2.DataBind();
        dt.Clear();
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("MasterFee.aspx");
    }

    [WebMethod]
    public static int getadmission(string admno)
    {
        long loginID;
        Utility objUT = new Utility();
        HttpContext.Current.Session["adnon"] = admno;
        loginID = objUT.GetAdmissionno(admno);
        HttpContext.Current.Session["Adid"] = loginID;
        int ret = Convert.ToInt32(CommonClass.Scaler("checkadno", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), Convert.ToInt32(loginID)));
        return ret;
    }

    [WebMethod]
    public static int getpayType(string admno)
    {
        int ret = Convert.ToInt32(CommonClass.Scaler("getPaytype", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), Convert.ToInt32(HttpContext.Current.Session["Adid"])));
        HttpContext.Current.Session["paytype"] = ret;
        return ret;
    }

    public class getfinedetial
    {
        public double fine { get; set; }
    }

    [WebMethod]
    public static getfinedetial[] getfine(string admno, string quarter)
    {
        DataTable dt;
        List<getfinedetial> details = new List<getfinedetial>();
        BEL.adid = Convert.ToInt32(HttpContext.Current.Session["Adid"]);
        dt = BLL.showfinepaytime();
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in dt.Rows)
            {
                getfinedetial user = new getfinedetial();
                user.fine = Convert.ToDouble(dtrow["fine"]);
                details.Add(user);
            }
        }
        return details.ToArray();
    }

    [WebMethod]
    public static studentsearch[] BindDataList(string searchvalue, string classid)
    {
        List<studentsearch> details = new List<studentsearch>();
        DataTable dt;
        BEL.adid = Convert.ToInt32(HttpContext.Current.Session["Adid"]);
        BEL.searchbyName = searchvalue;
        BEL.searchbyClass = classid;
        BEL.branchid = Convert.ToInt16(HttpContext.Current.Session["BrBrid"]);
        dt = BLL.searchstudentdatalist();
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in dt.Rows)
            {
                studentsearch user = new studentsearch();
                user.name = dtrow["name"].ToString();
                user.applyclass = dtrow["applyclass"].ToString();
                user.Fname = dtrow["FatherName"].ToString();
                user.image = dtrow["photo"].ToString();
                user.adno = dtrow["adno"].ToString();
                user.adid = Convert.ToInt32(dtrow["adid"].ToString());
                details.Add(user);
            }
        }

        return details.ToArray();
    }

    public class studentsearch
    {
        public string name { get; set; }

        public string applyclass { get; set; }

        public string Fname { get; set; }

        public string image { get; set; }

        public string adno { get; set; }

        public int adid { get; set; }
    }

    [WebMethod]
    public static int getregno(string admno)
    {
        Utility objUT = new Utility();
        int ret = Convert.ToInt32(HttpContext.Current.Session["Adid"]);
        // HttpContext.Current.Session["stue"] = ret;
        return ret;
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        Response.Redirect("getDistID.aspx?type=FS");
    }
}