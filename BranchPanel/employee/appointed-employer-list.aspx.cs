using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_appointed_employer_list : System.Web.UI.Page
{
    private SqlParameter[] param1 = new SqlParameter[4];
    private DataUtility objDUT = new DataUtility();
    private DataSet ds;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillgrid();
            fill_designation();
        }
    }

    private void fillgrid()
    {
        param1[0] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));

        param1[1] = new SqlParameter("@pagesize", SqlDbType.Int);
        param1[1].Value = 10;

        param1[2] = new SqlParameter("@pageno", SqlDbType.Int);
        param1[2].Value = 1;

        param1[3] = new SqlParameter("@emptype", SqlDbType.VarChar, 100);
        param1[3].Value = "C";

        ds = objDUT.GetDataSetSP(param1, "usp_facultySearch");
        if (ds.Tables[0].Rows.Count > 0)
        {
            grdAppoinmentLetter.DataSource = ds.Tables[0];
            grdAppoinmentLetter.DataBind();
            hfpages.Value = ds.Tables[1].Rows[0]["pages"].ToString();
            trforpagging.Style.Add("display", "block");
        }
        else
        {
            grdAppoinmentLetter.EmptyDataText = "No Record Found";
            grdAppoinmentLetter.DataSource = null;
            grdAppoinmentLetter.DataBind();
            trforpagging.Style.Add("display", "none");
        }
    }

    private void fill_designation()
    {
        DataTable dt = objDUT.GetDataTable("select desigID,desigName from designation_master where status=1");
        if (dt.Rows.Count > 0)
        {
            ddldesignation.DataSource = dt;
            ddldesignation.DataValueField = "desigID";
            ddldesignation.DataTextField = "desigName";
            ddldesignation.DataBind();
            ddldesignation.Items.Insert(0, new ListItem("Search by designation", ""));
        }

        DataTable dtfordept = objDUT.GetDataTable("select deptid,deptname from dept_master where status=1");
        if (dtfordept.Rows.Count > 0)
        {
            ddldept.DataSource = dtfordept;
            ddldept.DataTextField = "deptname";
            ddldept.DataValueField = "deptid";
            ddldept.DataBind();
            ddldept.Items.Insert(0, new ListItem("Search By Department", ""));
        }
    }

    [WebMethod]
    public static offEmpList[] GetAppointedEmpList(string refNo, string name, string mobile, string designationid, string deptid, string emaild, string eid, int pagesize, int pageno)
    {
        DataSet ds = new DataSet();
        List<offEmpList> details = new List<offEmpList>();
        offEmpList user = new offEmpList();
        SqlParameter[] p = new SqlParameter[11];

        p[0] = new SqlParameter("@brid", SqlDbType.VarChar, 50);
        p[0].Value = HttpContext.Current.Session["BrBrid"].ToString();

        p[1] = new SqlParameter("@refno", SqlDbType.VarChar, 200);
        p[1].Value = refNo;

        p[2] = new SqlParameter("@name", SqlDbType.VarChar, 200);
        p[2].Value = name;

        p[3] = new SqlParameter("@mobileno", SqlDbType.VarChar, 200);
        p[3].Value = mobile;

        p[4] = new SqlParameter("@designationid", SqlDbType.VarChar, 50);
        p[4].Value = designationid;

        p[5] = new SqlParameter("@emailid", SqlDbType.VarChar, 200);
        p[5].Value = emaild;

        p[6] = new SqlParameter("@pagesize", SqlDbType.Int);
        p[6].Value = pagesize;

        p[7] = new SqlParameter("@pageno", SqlDbType.Int);
        p[7].Value = pageno;

        p[8] = new SqlParameter("@emptype", SqlDbType.VarChar, 100);
        p[8].Value = "C";

        p[9] = new SqlParameter("@departmentID", SqlDbType.VarChar, 50);
        p[9].Value = deptid;

        p[10] = new SqlParameter("@eid", SqlDbType.VarChar, 100);
        p[10].Value = eid;

        DataUtility ObjDUT = new DataUtility();

        ds = ObjDUT.GetDataSetSP(p, "usp_facultySearch");

        if (eid != "" && eid != null)
        {
            DataTable dtlogin = ObjDUT.GetDataTable("select username,password from Employee_login where status=1 and eid=" + Convert.ToInt32(eid) + "");
            if (dtlogin.Rows.Count > 0)
            {
                user.username = dtlogin.Rows[0]["username"].ToString();
                user.password = dtlogin.Rows[0]["password"].ToString();
            }
        }
        foreach (DataRow dtrow in ds.Tables[0].Rows)
        {
            user.RowNumber = dtrow["RowNumber"].ToString();
            user.eid = dtrow["eid"].ToString();
            user.refNo = dtrow["refNo"].ToString();
            user.comname = dtrow["comname"].ToString();
            user.mobile = dtrow["mobile"].ToString();
            user.email = dtrow["email"].ToString();
            user.emailID = dtrow["emailID"].ToString();
            user.countryName = dtrow["countryName"].ToString();
            user.stateName = dtrow["stateName"].ToString();
            user.cityName = dtrow["cityName"].ToString();
            user.address = dtrow["address"].ToString();
            user.pinCode = dtrow["pinCode"].ToString();

            user.dob = dtrow["dob"].ToString();
            user.gender = dtrow["gender"].ToString();
            user.doj = dtrow["doj"].ToString();
            user.probationPeriond = dtrow["probationPeriond"].ToString();
            user.hrName = dtrow["hrName"].ToString();
            user.messanger = dtrow["messanger"].ToString();
            user.Hqualificaton = dtrow["Hqualificaton"].ToString();
            user.qqualificaton = dtrow["qqualificaton"].ToString();
            user.birthplace = dtrow["birthplace"].ToString();
            user.salary = dtrow["salary"].ToString();
            user.mstatus = dtrow["mstatus"].ToString();
            user.noOfChilds = dtrow["noOfChilds"].ToString();
            user.father = dtrow["father"].ToString();
            user.mother = dtrow["mother"].ToString();
            user.panNo = dtrow["panNo"].ToString();
            user.voterIdNo = dtrow["voterIdNo"].ToString();
            user.aadharNo = dtrow["aadharNo"].ToString();
            user.dlNo = dtrow["dlNo"].ToString();
            user.passportNo = dtrow["passportNo"].ToString();
            user.comments = dtrow["comments"].ToString();
            user.photo = dtrow["photo"].ToString();
            user.emailAlloted = dtrow["emailAlloted"].ToString();
            user.preOrganisation = dtrow["preOrganisation"].ToString();
            user.pAddress = dtrow["pAddress"].ToString();
            user.pcountry = dtrow["pcountry"].ToString();
            user.pstate = dtrow["pstate"].ToString();

            user.pcity = dtrow["pcity"].ToString();
            user.pPincode = dtrow["pPincode"].ToString();
            user.pDesignation = dtrow["pDesignation"].ToString();
            user.pSalary = dtrow["pSalary"].ToString();
            user.pDuration = dtrow["pDuration"].ToString();
            user.totalExperience = dtrow["totalExperience"].ToString();
            user.ref1Name = dtrow["ref1Name"].ToString();
            user.ref1Contact = dtrow["ref1Contact"].ToString();
            user.ref2Name = dtrow["ref2Name"].ToString();
            user.ref2Contact = dtrow["ref2Contact"].ToString();
            user.bloodGroup = dtrow["bloodGroup"].ToString();
            user.medicalCondition = dtrow["medicalCondition"].ToString();
            user.pastDeseas = dtrow["pastDeseas"].ToString();
            user.geneticDeseas = dtrow["geneticDeseas"].ToString();
            user.anyAlergy = dtrow["anyAlergy"].ToString();

            user.accountNo = dtrow["accountNo"].ToString();
            user.bankName = dtrow["bankName"].ToString();
            user.branchName = dtrow["branchName"].ToString();
            user.branchCode = dtrow["branchCode"].ToString();
            user.IFSC = dtrow["IFSC"].ToString();
            user.date = dtrow["date"].ToString();

            user.designation = dtrow["designation"].ToString();
            user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString();
            user.department = dtrow["department"].ToString();
            details.Add(user);
        }

        return details.ToArray();
    }

    public class offEmpList
    {
        public string RowNumber { get; set; }

        public string eid { get; set; }

        public string refNo { get; set; }

        public string comname { get; set; }

        public string mobile { get; set; }

        public string email { get; set; }

        public string emailID { get; set; }

        public string countryName { get; set; }

        public string stateName { get; set; }

        public string cityName { get; set; }

        public string address { get; set; }

        public string pinCode { get; set; }

        public string dob { get; set; }

        public string gender { get; set; }

        public string doj { get; set; }

        public string probationPeriond { get; set; }

        public string hrName { get; set; }

        public string messanger { get; set; }

        public string Hqualificaton { get; set; }

        public string qqualificaton { get; set; }

        public string birthplace { get; set; }

        public string salary { get; set; }

        public string mstatus { get; set; }

        public string noOfChilds { get; set; }

        public string father { get; set; }

        public string mother { get; set; }

        public string panNo { get; set; }

        public string voterIdNo { get; set; }

        public string aadharNo { get; set; }

        public string dlNo { get; set; }

        public string passportNo { get; set; }

        public string comments { get; set; }

        public string photo { get; set; }

        public string emailAlloted { get; set; }

        public string preOrganisation { get; set; }

        public string pAddress { get; set; }

        public string pcountry { get; set; }

        public string pstate { get; set; }

        public string pcity { get; set; }

        public string pPincode { get; set; }

        public string pDesignation { get; set; }

        public string pSalary { get; set; }

        public string pDuration { get; set; }

        public string totalExperience { get; set; }

        public string ref1Name { get; set; }

        public string ref1Contact { get; set; }

        public string ref2Name { get; set; }

        public string ref2Contact { get; set; }

        public string bloodGroup { get; set; }

        public string medicalCondition { get; set; }

        public string pastDeseas { get; set; }

        public string geneticDeseas { get; set; }

        public string anyAlergy { get; set; }

        public string accountNo { get; set; }

        public string bankName { get; set; }

        public string branchName { get; set; }

        public string branchCode { get; set; }

        public string IFSC { get; set; }

        public string date { get; set; }

        public string username { get; set; }

        public string password { get; set; }

        public string designation { get; set; }

        public string department { get; set; }

        public string pagecount { get; set; }
    }
}