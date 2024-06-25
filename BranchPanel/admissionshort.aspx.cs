using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_admissionshort : System.Web.UI.Page
{
    private string PageName, url;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private CommonClass commonOBJ = new CommonClass();
    private DataTable dt;
    private int currentYear;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        PageName = Utility.GetCurrentPagename();
        if (Session["BrADID"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }

        if (!IsPostBack)
        {
            BindColumnToGridview();
            fillDATEDDL();
            Session["fyid"] = Convert.ToInt32(objdut.GetScalar("select FYID from financial_Year where isActive=1 and isClosed=0"));
            txtOfficer.Text = Convert.ToString(Session["Brusername"]);
            string str = Convert.ToString(objdut.GetScalar("select cid from country where cid=96"));
            Session["cid"] = str;
            ddlCountry1.SelectedValue = str.ToString();
            fillCountry();
            state();
            fillclass();
            BindColumnToGridview1();
            BindColumnToGridview2();
        }
    }

    private void BindColumnToGridview()
    {
        string query = "select 0 as cfid,CONVERT(varchar(100),'a') as feename,0.00 as fees";
        dt = objdut.GetDataTable(query);
        grdDetails.DataSource = dt;
        grdDetails.DataBind();
    }

    private void BindColumnToGridview1()
    {
        string query = "select CONVERT(varchar(100),'a') as transtype,0.00 as credit,CONVERT(varchar(100),'b') as monthname";
        dt = objdut.GetDataTable(query);
        grdclass.DataSource = dt;
        grdclass.DataBind();
    }

    private void BindColumnToGridview2()
    {
        string query = "select 0 as monthid,0.00 as credit,CONVERT(varchar(100),'b') as monthname";
        dt = objdut.GetDataTable(query);
        grd1.DataSource = dt;
        grd1.DataBind();
    }

    [WebMethod]
    public static string checkregitartion(string regist)
    {
        // List<classmaster> details = new List<classmaster>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select count(1) from tbl_StudentRegistration where registrationno='" + regist + "' and Brid=" + Convert.ToDouble(HttpContext.Current.Session["BrBrid"]) + " and status=0", con))
            {
                con.Open();
                string chk = cmd.ExecuteScalar().ToString();
                con.Close();
                return chk;
            }
        }
    }

    private void state()
    {
        ddl_state.Items.Clear();
        lblCountryMsg.Visible = false;
        string str = "select SID,stateName  from STATE where CID=" + Session["cid"] + " order by stateName  ";
        DataTable dt1 = objdut.GetDataTable(str);
        if (dt1.Rows.Count > 0)
        {
            //ddlState1.DataSource = commonobj.Dll("Statedll", Convert.ToInt32(ddlCountry1.SelectedValue));
            ddl_state.DataSource = dt1;
            ddl_state.DataTextField = "stateName";
            ddl_state.DataValueField = "SID";
            ddl_state.DataBind();

            ddl_state.Items.Insert(0, new ListItem("--Select State--", "0"));
            ddl_state.Focus();
        }
    }

    public void fillDiscountGrid(int classid)
    {
        string q = @"select t1.cfid, t1.feename,t1.fees,t3.Feename as feecategory,t3.id,case when t3.id=1 then fees*1 when t3.id=2 then fees*1 when t3.id=3 then fees*2 when t3.id=4 then fees*4 when t3.id=5 then fees*12 end as totalfee from classfee_master t1 left outer
                 join feestructure t2  on t2.id=t1.Feeid and t1.fyid=1 join  feestructure t3 on t2.Feesubtype=t3.id  where Brid=" + Convert.ToInt32(Session["BrBrid"]) + @" and Classid=" + classid + @"  and t1.status=1 and Feeid
                  not in(select id from feestructure where Feesubtype=0) and t1.FeeName!='Registration Fee'";

        dt = objdut.GetDataTable(q);

        grdDetails.DataSource = dt;
        ViewState["griddata"] = dt;
        grdDetails.DataBind();
    }

    public void clear()
    {
        txtRegNo.Text = "";
    }

    public void fillCountry()
    {
        ddlCountry1.DataSource = CommonClass.ABC("Countrydll");// commonobj.Dll("Countrydll");
        ddlCountry1.DataTextField = "countryName";
        ddlCountry1.DataValueField = "CID";
        ddlCountry1.DataBind();
        ddlCountry1.Items.Insert(0, new ListItem("--Select Country--", "0"));
        ddl_state.Items.Insert(0, new ListItem("--Select State--", "0"));
        ddlCity1.Items.Insert(0, new ListItem("--Select City--", "0"));
    }

    public void fillclass()
    {
        ddl_Course.DataSource = CommonClass.ABC1("ClassInBranch", Convert.ToInt32(Session["BrBrid"]));
        ddl_Course.DataTextField = "ClassName";
        ddl_Course.DataValueField = "classid";
        ddl_Course.DataBind();
        ddl_Course.Items.Insert(0, new ListItem("--Select Class--", "0"));

        ddlSection.Items.Insert(0, new ListItem("--Select Section--", "0"));
    }

    protected void reset()
    {
        txtName.Text = "";
        txtToDate.Text = "";
        txtFname.Text = "";
        txtmother.Text = "";
        txtLName.Text = "";
        txtmidname.Text = "";
        txtmidname1.Text = "";
        txtmidname2.Text = "";
        txtOfficer.Text = "";
        txtPAddress.Text = "";
        txtPZIP.Text = "";
        txtRegNo.Text = "";
        txtadmNo.Text = "";
        txtClassSec.Text = "";
        txtlastname1.Text = "";
        txtlastname2.Text = "";
        ddl_Course.SelectedIndex = 0;
        ddlSection.SelectedIndex = 0;
    }

    public void fillSection(string classid)
    {
        ddlSection.DataSource = objdut.GetDataTable("select cwsid,sectionname from classwithsection where classid=" + classid + " and branchid=" + Convert.ToInt32(Session["BrBrid"])); //commonobj.Dll("ClasswithBranch", Convert.ToInt32(ddl_Course.SelectedValue),Convert.ToInt32(Session["BrBrid"]));
        ddlSection.DataTextField = "sectionname";
        ddlSection.DataValueField = "cwsid";
        ddlSection.DataBind();
        ddlSection.Items.Insert(0, new ListItem("--Select Section--", "0"));
        ddlSection.Enabled = true;
    }

    protected void ddlSection_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSection.SelectedValue != "0")
        {
            string classsecname = ddl_Course.SelectedItem.Text + " " + ddlSection.SelectedItem.Text;
            txtClassSec.Text = classsecname;
        }
    }

    public void fillDATEDDL()
    {
        DataTable dt = CommonClass.ABC("MonthName");//CommmonOBJ.Dll("MonthName");
        ddlMonth.DataSource = dt;
        ddlMonth.DataBind();
        ddlMonth.DataTextField = "MonthName";
        ddlMonth.DataValueField = "MonthId";
        ddlMonth.DataBind();
        ddlMonth.Items.Insert(0, "--Month--");
        ddlDate.Items.Insert(0, "--Date--");
        ddlYear.Items.Insert(0, "--Year--");

        currentYear = Convert.ToInt32(objdut.GetScalar("select endyear from financial_year where isActive=1 and isClosed=0"));
    }

    protected void ddlMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        int currentYear;
        if (ddlMonth.SelectedValue != "--Month--")
        {
            ddlDate.Enabled = true;
            Int32 days = Convert.ToInt32(CommonClass.Scaler("getdays", Convert.ToInt32(ddlMonth.SelectedValue)));
            if (Convert.ToInt32(ddlMonth.SelectedValue) <= 9)
            {
                currentYear = Convert.ToInt32(objdut.GetScalar("select startingyear from financial_year where isActive=1 and isClosed=0"));
            }
            else
            {
                currentYear = Convert.ToInt32(objdut.GetScalar("select endyear from financial_year where isActive=1 and isClosed=0"));
            }
            if (objut.isLeapYear(currentYear))
            {
                if (ddlMonth.SelectedValue == "11")
                {
                    days = 29;
                }
            }
            ddlDate.Items.Clear();
            ddlDate.Items.Insert(0, "--Date--");
            for (int i = 1; i <= days; i++)
            {
                ddlDate.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            ddlYear.Items.Clear();
            ddlYear.Items.Insert(0, "--Year--");
            for (int i = currentYear; i <= currentYear; i++)
            {
                ddlYear.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
        }
        else
        {
            ddlDate.SelectedValue = "--Date--";
            ddlDate.Enabled = false;
        }
    }

    [WebMethod]
    public static UserDetails[] BindDatatable(string classid, int transport)
    {
        DataTable dt = new DataTable();
        List<UserDetails> details = new List<UserDetails>();

        dt = BLL.getclassfeestructure(Convert.ToInt32(classid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        foreach (DataRow dtrow in dt.Rows)
        {
            UserDetails user = new UserDetails();
            user.feename = dtrow["feename"].ToString();
            user.fees = dtrow["fees"].ToString();
            user.cfid = Convert.ToDouble(dtrow["cfid"]);
            details.Add(user);
        }

        return details.ToArray();
    }

    //fee structure show
    [WebMethod]
    public static Binfeedata[] Bindfeestructure(string classid, int transport)
    {
        List<Binfeedata> details = new List<Binfeedata>();

        BEL.applyclassid = Convert.ToInt16(classid);
        BEL.branchid = Convert.ToInt16(HttpContext.Current.Session["BrBrid"]);
        BEL.modestatic = transport;

        DataTable dt = new DataTable();
        //dt =BLL.bindfeestructure();

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in dt.Rows)
            {
                Binfeedata user = new Binfeedata();
                user.feename = dtrow["transtype"].ToString();
                user.fees = dtrow["credit"].ToString();
                user.month = dtrow["monthname"].ToString();

                details.Add(user);
            }
        }

        return details.ToArray();
    }

    [WebMethod]
    public static Binfeedata1[] bindpay(string classid, int transport)
    {
        List<Binfeedata1> details = new List<Binfeedata1>();

        BEL.applyclassid = Convert.ToInt16(classid);
        BEL.branchid = Convert.ToInt16(HttpContext.Current.Session["BrBrid"]);
        BEL.modestatic = transport;

        DataTable dt = new DataTable();
        //dt= BLL.bindpayfee();

        foreach (DataRow dtrow in dt.Rows)
        {
            Binfeedata1 user = new Binfeedata1();

            user.fees = dtrow["credit"].ToString();
            user.month = dtrow["monthname"].ToString();
            user.monthid = dtrow["paymonth"].ToString();

            details.Add(user);
        }

        return details.ToArray();
    }

    public class UserDetails
    {
        public string feename { get; set; }

        public string fees { get; set; }

        public double cfid { get; set; }
    }

    public class Binfeedata
    {
        public string feename { get; set; }

        public string fees { get; set; }

        public string month { get; set; }
    }

    public class Binfeedata1
    {
        public string fees { get; set; }

        public string month { get; set; }

        public string monthid { get; set; }
    }

    [WebMethod]
    public static regdetails[] BindStudentdetail(string classid)
    {
        Utility objut = new Utility();
        BranchPanel_admissionshort onb = new BranchPanel_admissionshort();
        DataTable dt = new DataTable();
        List<regdetails> details = new List<regdetails>();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            HttpContext.Current.Session["regno"] = classid;
            string var = Convert.ToString(HttpContext.Current.Session["regno"]);
            long rid = objut.GetRegistrationNo(var);
            using (SqlCommand cmd = new SqlCommand(@"select rid,Registrationno,firstname,isnull(middlename,'')as middlename,convert(varchar,GETDATE(),104) as currentdate ,lastname,convert(varchar(12),dateofbirth,106) as dateofbirth ,ffirstname,isnull(fmiddlename,'')as fmiddlename,
                    flastname,mfirstname,isnull(MmiddleName,'')as mmiddlename,mlastname,gender,classid,Address,countryid,stateid,cityid,pincode,Fmobileno,
                     isnull(uploadletestreportcard,'') as ulrc,isnull(uploadmotherphoto,'') as ump,isnull(uploadfatherphoto,'') as ufp,isnull(uploadbirthcirtificate,'') as ubc,
                     isnull(uploadchildphoto,'') as usp from tbl_StudentRegistration where rid=" + rid + " and status=0", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                HttpContext.Current.Session["rid"] = rid;
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    regdetails user = new regdetails();

                    user.rid = dtrow["rid"].ToString();
                    user.firstname = dtrow["firstname"].ToString();
                    user.middlename = dtrow["middlename"].ToString();
                    user.lastname = dtrow["lastname"].ToString();
                    user.dateofbirth = dtrow["dateofbirth"].ToString();
                    user.ffirstname = dtrow["ffirstname"].ToString();
                    user.fmiddlename = dtrow["fmiddlename"].ToString();
                    user.flastname = dtrow["flastname"].ToString();
                    user.mfirstname = dtrow["mfirstname"].ToString();
                    user.MmiddleName = dtrow["MmiddleName"].ToString();
                    user.mlastname = dtrow["mlastname"].ToString();
                    user.gender = dtrow["gender"].ToString();
                    user.classid = dtrow["classid"].ToString();
                    user.Address = dtrow["Address"].ToString();

                    user.countryid = dtrow["countryid"].ToString();
                    // onb.ViewState["counid"] = Convert.ToInt32(user.countryid);

                    // txtadmNo.Text = Convert.ToString("HMS/" + rid + 1);

                    user.stateid = dtrow["stateid"].ToString();
                    user.cityid = dtrow["cityid"].ToString();
                    user.pincode = dtrow["pincode"].ToString();
                    user.Fmobileno = dtrow["Fmobileno"].ToString();

                    details.Add(user);
                }
            }
        }
        return details.ToArray();
    }

    public class regdetails
    {
        public string rid { get; set; }

        public string firstname { get; set; }

        public string middlename { get; set; }

        public string lastname { get; set; }

        public string dateofbirth { get; set; }

        public string ffirstname { get; set; }

        public string fmiddlename { get; set; }

        public string flastname { get; set; }

        public string mfirstname { get; set; }

        public string MmiddleName { get; set; }

        public string mlastname { get; set; }

        public string gender { get; set; }

        public string classid { get; set; }

        public string Address { get; set; }

        public string countryid { get; set; }

        public string stateid { get; set; }

        public string cityid { get; set; }

        public string pincode { get; set; }

        public string Fmobileno { get; set; }
    }

    [WebMethod]
    public static ProductMasterDetails[] bindsection(string sid)
    {
        List<ProductMasterDetails> details = new List<ProductMasterDetails>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select cwsid,sectionname from classwithsection where BranchId=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + " and status=1 and classid=" + sid, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                ProductMasterDetails objProductMasterDetails0 = new ProductMasterDetails();
                objProductMasterDetails0.SID = Convert.ToInt32("0");
                objProductMasterDetails0.sectionname = "-Select section-";
                details.Add(objProductMasterDetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    ProductMasterDetails objProductMasterDetails = new ProductMasterDetails();
                    objProductMasterDetails.SID = Convert.ToInt32(dtrow["cwsid"].ToString());
                    objProductMasterDetails.sectionname = dtrow["sectionname"].ToString();
                    details.Add(objProductMasterDetails);
                }
            }
        }
        return details.ToArray();
    }

    public class ProductMasterDetails
    {
        public int SID { get; set; }

        public string sectionname { get; set; }
    }

    [WebMethod]
    public static int monthdetails(string mid)
    {
        Utility objut = new Utility();
        DataUtility objdut = new DataUtility();
        BranchPanel_admissionshort onb = new BranchPanel_admissionshort();
        DataTable dt = new DataTable();
        CommonClass commonOBJ = new CommonClass();
        //  List<mondetails> detail = new List<mondetails>();
        int currentYear;

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            HttpContext.Current.Session["regno"] = mid;

            Int32 days = Convert.ToInt32(CommonClass.Scaler("getdays", Convert.ToInt32(HttpContext.Current.Session["regno"])));

            if (Convert.ToInt32(HttpContext.Current.Session["regno"]) <= 9)
            {
                currentYear = Convert.ToInt32(objdut.GetScalar("select startingyear from financial_year where isActive=1 and isClosed=0"));
            }
            else
            {
                currentYear = Convert.ToInt32(objdut.GetScalar("select endyear from financial_year where isActive=1 and isClosed=0"));
            }
            if (objut.isLeapYear(currentYear))
            {
                if (HttpContext.Current.Session["regno"] == "11")
                {
                    days = 29;
                }
            }

            return days;
        }
    }

    [WebMethod]
    public static ProductMasterDetails1[] binclass()
    {
        List<ProductMasterDetails1> details = new List<ProductMasterDetails1>();
        DataTable dt = new DataTable();
        dt = BLL.getclass(Convert.ToInt16(HttpContext.Current.Session["BrBrid"]));

        ProductMasterDetails1 objProductMasterDetails0 = new ProductMasterDetails1();
        objProductMasterDetails0.SID1 = Convert.ToInt32("0");
        objProductMasterDetails0.statename1 = "-Select Class-";
        details.Add(objProductMasterDetails0);

        foreach (DataRow dtrow in dt.Rows)
        {
            ProductMasterDetails1 objProductMasterDetails = new ProductMasterDetails1();
            objProductMasterDetails.SID1 = Convert.ToInt32(dtrow["classid"].ToString());
            objProductMasterDetails.statename1 = dtrow["Classname"].ToString();
            details.Add(objProductMasterDetails);
        }

        return details.ToArray();
    }

    public class ProductMasterDetails1
    {
        public int SID1 { get; set; }

        public string statename1 { get; set; }
    }

    public class Datainsert
    {
        public string fname { get; set; }

        public string mname { get; set; }

        public string lname { get; set; }

        public DateTime dob { get; set; }

        public string ffname { get; set; }

        public string fmname { get; set; }

        public string flname { get; set; }

        public string Mnname { get; set; }

        public string mmname { get; set; }

        public string mlname { get; set; }

        public string gender { get; set; }

        public string tranType { get; set; }

        public string apclass { get; set; }

        public string classid { get; set; }

        public string section { get; set; }

        public string sectionid { get; set; }

        public string address { get; set; }

        public string country { get; set; }

        public string countryid { get; set; }

        public string state { get; set; }

        public string stateid { get; set; }

        public string city { get; set; }

        public string cityid { get; set; }

        public string pinzcode { get; set; }

        public string mobile { get; set; }

        public string feeid { get; set; }

        public string feeamount { get; set; }

        public string feename { get; set; }

        public string discounamount { get; set; }

        public string checkbox2 { get; set; }

        public string admissiondate { get; set; }

        public string mode { get; set; }

        public string paymodeid { get; set; }

        public double payableamount { get; set; }

        public double paynowamount { get; set; }

        public string bankname { get; set; }

        public string checkno { get; set; }

        public string cpaymonthids { get; set; }

        public int paytypeid { get; set; }

        public string paytypename { get; set; }
    }

    [WebMethod]
    public static string insertdata(Datainsert theData)
    {
        DataUtility objdut = new DataUtility();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            con.Open();
            using (SqlCommand cmd = new SqlCommand("usp_stuAdmission", con))
            {
                // string month = "", date = "", year = "";
                string brusername = (string)HttpContext.Current.Session["Brusername"];
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.CommandText = "usp_stuAdmission";

                cmd.Parameters.AddWithValue("@rid", HttpContext.Current.Session["rid"]);
                cmd.Parameters.AddWithValue("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
                cmd.Parameters.AddWithValue("@branchname", brusername);
                cmd.Parameters.AddWithValue("@firstname", theData.fname);
                cmd.Parameters.AddWithValue("@middlename", theData.mname);
                cmd.Parameters.AddWithValue("@lastname", theData.lname);
                cmd.Parameters.AddWithValue("@dateofbirth", theData.dob);
                cmd.Parameters.AddWithValue("@FfirstName", theData.ffname);
                cmd.Parameters.AddWithValue("@FMiddleName", theData.fmname);
                cmd.Parameters.AddWithValue("@FLastName", theData.flname);
                cmd.Parameters.AddWithValue("@MFirstName", theData.Mnname);
                cmd.Parameters.AddWithValue("@MmiddleName", theData.mmname);
                cmd.Parameters.AddWithValue("@MLastName", theData.mlname);

                cmd.Parameters.AddWithValue("@gender", theData.gender);

                cmd.Parameters.AddWithValue("@transportaion", theData.tranType);
                cmd.Parameters.AddWithValue("@mode", "");

                if (theData.apclass != "")
                {
                    cmd.Parameters.AddWithValue("@applyclass", theData.apclass);
                    cmd.Parameters.AddWithValue("@classid", theData.classid);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@applyclass", "");
                    cmd.Parameters.AddWithValue("@classid", Convert.ToInt16(0));
                }

                if (theData.section != "")
                {
                    cmd.Parameters.AddWithValue("@section", theData.section);
                    cmd.Parameters.AddWithValue("@sectionID", theData.sectionid);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@section", "");
                    cmd.Parameters.AddWithValue("@sectionID", Convert.ToInt16(0));
                }

                cmd.Parameters.AddWithValue("@Address", theData.address);

                cmd.Parameters.AddWithValue("@countryid", theData.countryid);
                cmd.Parameters.AddWithValue("@countryname", theData.country);
                cmd.Parameters.AddWithValue("@stateid", theData.stateid);
                cmd.Parameters.AddWithValue("@statename", theData.state);

                cmd.Parameters.AddWithValue("@cityid", theData.cityid);
                cmd.Parameters.AddWithValue("@cityname", theData.city);
                cmd.Parameters.AddWithValue("@pincodeP", theData.pinzcode);
                cmd.Parameters.AddWithValue("@FMobileNo", theData.mobile);
                cmd.Parameters.AddWithValue("@AdmissionDate", theData.admissiondate);
                cmd.Parameters.AddWithValue("@Feeid", theData.feeid);
                cmd.Parameters.AddWithValue("@FeeName", theData.feename);
                cmd.Parameters.AddWithValue("@FeeAmount", theData.feeamount);
                cmd.Parameters.AddWithValue("@Discount", theData.discounamount);

                cmd.Parameters.AddWithValue("@ckdisid", theData.checkbox2);

                cmd.Parameters.AddWithValue("@paymodeid", theData.paymodeid);
                cmd.Parameters.AddWithValue("@bankname", theData.bankname);
                cmd.Parameters.AddWithValue("@checkno", theData.checkno);
                cmd.Parameters.AddWithValue("@payableamt", Convert.ToDouble(theData.payableamount));
                cmd.Parameters.AddWithValue("@paynowamount", Convert.ToDouble(theData.paynowamount));
                cmd.Parameters.AddWithValue("@monthids", theData.cpaymonthids);
                cmd.Parameters.AddWithValue("@feepaynow", "PAYNOW");
                cmd.Parameters.AddWithValue("@payType", theData.paytypeid);
                cmd.Parameters.AddWithValue("@paytypename", theData.paytypename);

                cmd.Parameters.Add("@intResult", SqlDbType.NVarChar, 100, "");
                cmd.Parameters["@intResult"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                string intResult = Convert.ToString(cmd.Parameters["@intResult"].Value);

                con.Close();

                if (intResult == "1")
                {
                    string query0 = "select max(adid) from tbl_Admission where Brid=" + Convert.ToDouble(HttpContext.Current.Session["BrBrid"]);
                    int adid = Convert.ToInt32(objdut.GetScalar(query0));
                    return "AdmissionConfirm.aspx?adid=" + adid;
                    //HttpContext.Current.Response.Redirect("AdmissionConfirm.aspx?adid=" + adid, true);
                }
                else
                {
                    return intResult;
                }
            }
        }
        // return details.ToArray();
    }
}