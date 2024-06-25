using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class branchpanel_employee_ex_employee_list : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private string url = "";
    private DataSet ds;
    private static string myString = "", emailforhost = "", hostname = "", password = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/login.aspx");
        }
        if (!IsPostBack)
        {
            Session["empid"] = null;
            fillgrid();
            fillgrid2();
            FillDDLAll();
            Update_OnLeave_Status();
            Upadte_Regine();
            Update_Resumption();
            Get_Emp_List();
        }
    }

    private void Update_OnLeave_Status()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@intResult", 0);
        param[0].Direction = ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, "[usp_updateonleavestatus]");
    }

    private void Get_Emp_List()
    {
        DataTable Dt = objdut.GetDataTableSP("[usp_Get_ex_Emp_List]");
        lblTotal.Text = Dt.Rows[0]["Total"].ToString();
        lblterminated.Text = Dt.Rows[0]["Terminated"].ToString();
        lblresigned.Text = Dt.Rows[0]["Resgined"].ToString();
    }

    private void fillgrid()
    {
        SqlParameter[] param1 = new SqlParameter[4];

        param1[0] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));

        param1[1] = new SqlParameter("@pagesize", SqlDbType.Int);
        param1[1].Value = 15;

        param1[2] = new SqlParameter("@pageno", SqlDbType.Int);
        param1[2].Value = 1;

        param1[3] = new SqlParameter("@mode", SqlDbType.Int);
        param1[3].Value = 2;

        ds = objdut.GetDataSetSP(param1, "usp_employeesearch");
        if (ds.Tables[0].Rows.Count > 0)
        {
            gvDetails.DataSource = ds.Tables[0];
            gvDetails.DataBind();
            trforimagepagging.Style.Add("display", "block");
            hfpages.Value = ds.Tables[1].Rows[0]["pages"].ToString();
        }
        else
        {
            gvDetails.EmptyDataText = "No employee list found.";
            trforimagepagging.Style.Add("display", "none");
            gvDetails.DataBind();
        }
    }

    private void FillDDLAll()
    {
        DataTable dt = objdut.GetDataTable("select desigID,desigName from designation_master where status=1");
        if (dt.Rows.Count > 0)
        {
            ddldesignation.DataSource = dt;
            ddldesignation.DataValueField = "desigID";
            ddldesignation.DataTextField = "desigName";
            ddldesignation.DataBind();
            ddldesignation.Items.Insert(0, new ListItem("---Select Designation---", ""));
        }
        DataTable dtfordept = objdut.GetDataTable("select deptid,deptname from dept_master where status=1");
        if (dtfordept.Rows.Count > 0)
        {
            ddldept.DataSource = dtfordept;
            ddldept.DataTextField = "deptname";
            ddldept.DataValueField = "deptid";
            ddldept.DataBind();
            ddldept.Items.Insert(0, new ListItem("---Select Department---", ""));
        }
    }

    [WebMethod]
    public static offEmpList[] GetAppointedEmpList(string refNo, string name, string mobile, string designationid, string deptid, string emaild, string eid, int pagesize, int pageno, string status)
    {
        DataSet ds = new DataSet();
        List<offEmpList> details = new List<offEmpList>();

        SqlParameter[] p = new SqlParameter[12];

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
        if (eid == "")
        {
            p[7].Value = pageno;
        }
        else
        {
            p[7].Value = 1;
        }
        p[8] = new SqlParameter("@emptype", SqlDbType.VarChar, 100);
        p[8].Value = "";

        p[9] = new SqlParameter("@departmentID", SqlDbType.VarChar, 50);
        p[9].Value = deptid;

        p[10] = new SqlParameter("@eid", SqlDbType.VarChar, 100);
        p[10].Value = eid;

        p[11] = new SqlParameter("@status", SqlDbType.VarChar, 100);
        p[11].Value = status;

        DataUtility ObjDUT = new DataUtility();

        ds = ObjDUT.GetDataSetSP(p, "[usp_empSearch]");

        foreach (DataRow dtrow in ds.Tables[0].Rows)
        {
            offEmpList user = new offEmpList();
            user.RowNumber = dtrow["RowNumber"].ToString();
            user.eid = dtrow["eid"].ToString();
            user.refNo = dtrow["refNo"].ToString();
            user.comname = dtrow["comname"].ToString();
            user.mobile = dtrow["mobile"].ToString();
            user.email = dtrow["email"].ToString();
            user.emailID = dtrow["emailID"].ToString();
            user.countryName = dtrow["countryName"].ToString();
            user.stateName = dtrow["stateName"].ToString();

            if (dtrow["cityName"].ToString() != "")
            {
                user.cityName = dtrow["cityName"].ToString();
            }
            else
            {
                user.cityName = dtrow["permanentadd_othercity"].ToString();
            }
            user.address = dtrow["address"].ToString();
            user.pinCode = dtrow["pinCode"].ToString();

            DateTime dob = Convert.ToDateTime(dtrow["dob"]);
            user.dob = dob.ToString("dd/MM/yyyy");

            user.gender = dtrow["gender"].ToString();

            DateTime doj = Convert.ToDateTime(dtrow["doj"]);
            user.doj = doj.ToString("dd/MM/yyyy");
            user.probationPeriond = dtrow["probationPeriond"].ToString() + " months";
            user.hrName = dtrow["hrName"].ToString();
            user.messanger = dtrow["messanger"].ToString();

            string[] qualification = dtrow["qualificaton"].ToString().Split('~');
            string qname = "";
            foreach (string id in qualification)
            {
                if (id != "")
                {
                    qname += ObjDUT.GetScalar("select name from tblQualification where qid=" + Convert.ToInt16(id) + " and status=1").ToString() + "~";
                }
            }
            user.qualificaton = qname;

            user.education_board = dtrow["education_board"].ToString();
            user.passing_year = dtrow["passing_year"].ToString();
            user.session = dtrow["session"].ToString();
            user.rollnumber = dtrow["rollnumber"].ToString();
            user.percentage = dtrow["percentage"].ToString();
            user.institute_address = dtrow["institute_address"].ToString();

            user.birthplace = dtrow["birthplace"].ToString();
            user.mstatus = dtrow["mstatus"].ToString();

            if (Convert.ToInt16(dtrow["noOfChilds"]) != 0)
            {
                user.noOfChilds = dtrow["noOfChilds"].ToString();
            }
            else
            {
                user.noOfChilds = "--";
            }
            user.panNo = dtrow["panNo"].ToString();

            if (Convert.ToInt16(dtrow["id_proof_id"]) != 0 && dtrow["id_proof_id"].ToString() != "")
            {
                user.id_proof_id = dtrow["idname"].ToString();
                user.id_proof_number = dtrow["id_proof_number"].ToString();
            }
            else
            {
                user.id_proof_id = "--";
                user.id_proof_number = "--";
            }
            if (Convert.ToInt16(dtrow["residential_id"]) != 0 && dtrow["residential_id"].ToString() != "")
            {
                user.residential_id = dtrow["residentialproof"].ToString();
                user.residential_proof_number = dtrow["residential_proof_number"].ToString();
            }
            else
            {
                user.residential_id = "--";
                user.residential_proof_number = "--";
            }

            user.comments = dtrow["comments"].ToString();
            user.photo = dtrow["photo"].ToString();
            user.emailAlloted = dtrow["emailAlloted"].ToString();
            user.preOrganisation = dtrow["preOrganisation"].ToString();
            user.pAddress = dtrow["pAddress"].ToString();
            user.pcountry = dtrow["pcountry"].ToString();
            user.pstate = dtrow["pstate"].ToString();

            //======Current address details=====
            user.per_countryName = dtrow["per_countryName"].ToString();
            user.per_stateName = dtrow["per_stateName"].ToString();
            if (dtrow["per_cityName"].ToString() != "")
            {
                user.per_cityName = dtrow["per_cityName"].ToString();
            }
            else
            {
                user.per_cityName = dtrow["currentadd_othercity"].ToString();
            }
            user.Taddress = dtrow["Taddress"].ToString();
            user.TpinCode = dtrow["TpinCode"].ToString();
            user.current_address_landmark = dtrow["current_address_landmark"].ToString();
            user.permanent_address_landmark = dtrow["permanent_address_landmark"].ToString();
            //==========Gardian Details==============
            user.father = dtrow["father"].ToString();
            user.mother = dtrow["mother"].ToString();
            user.fathercontactno = dtrow["fathercontactno"].ToString();
            user.mothercontactno = dtrow["mothercontactno"].ToString();
            user.parentsaddress = dtrow["parentsaddress"].ToString();
            user.father_alternate_no = dtrow["father_alternate_no"].ToString();
            //============Employement Details=========
            user.CTC = dtrow["CTC"].ToString();
            DateTime CTCappliedfrom = Convert.ToDateTime(dtrow["CTCappliedfrom"]);
            user.CTCappliedfrom = CTCappliedfrom.ToString("dd/MM/yyyy");
            user.salary = dtrow["salary"].ToString();
            user.pfno = user.pfno = dtrow["pfno"].ToString();
            user.esino = dtrow["esino"].ToString();
            user.tds_account_number = dtrow["tds_account_number"].ToString();
            user.emplyeetype = dtrow["emplyeetype"].ToString();
            user.Brname = dtrow["Brname"].ToString();

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

            if (dtrow["nationality"].ToString() == "1")
            {
                user.nationality = "Indian";
            }
            else
            {
                user.nationality = dtrow["other_nationality_name"].ToString();
            }

            user.designation = dtrow["designation"].ToString();
            user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString();
            user.department = dtrow["department"].ToString();
            user.status = dtrow["status"].ToString();
            user.AddBiometric_Card_No = dtrow["AddBiometric_Card_No"].ToString();
            user.isDocumentSubmit = dtrow["isDocumentSubmit"].ToString();

            if (eid != "" && eid != null)
            {
                DataTable dtlogin = ObjDUT.GetDataTable("select username,password from Employee_login where status=1 and eid=" + Convert.ToInt32(eid) + "");
                if (dtlogin.Rows.Count > 0)
                {
                    user.username = dtlogin.Rows[0]["username"].ToString();
                    user.password = dtlogin.Rows[0]["password"].ToString();
                }
            }

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

        public string isDocumentSubmit { get; set; }

        public string nationality { get; set; }

        public string other_nationality_name { get; set; }

        //Current address details
        public string per_countryName { get; set; }

        public string per_stateName { get; set; }

        public string per_cityName { get; set; }

        public string current_address_landmark { get; set; }

        public string permanent_address_landmark { get; set; }

        public string Taddress { get; set; }

        public string TpinCode { get; set; }

        //==========gardians details==========
        public string father { get; set; }

        public string mother { get; set; }

        public string fathercontactno { get; set; }

        public string father_alternate_no { get; set; }

        public string mothercontactno { get; set; }

        public string parentsaddress { get; set; }

        //=========Employement Detaisl=========

        public string Brname { get; set; }

        public string CTC { get; set; }

        public string CTCappliedfrom { get; set; }

        public string emplyeetype { get; set; }

        public string pfno { get; set; }

        public string esino { get; set; }

        public string tds_account_number { get; set; }

        public string doj { get; set; }

        public string probationPeriond { get; set; }

        public string hrName { get; set; }

        public string messanger { get; set; }

        public string qualificaton { get; set; }

        public string education_board { get; set; }

        public string passing_year { get; set; }

        public string session { get; set; }

        public string rollnumber { get; set; }

        public string percentage { get; set; }

        public string institute_address { get; set; }

        public string birthplace { get; set; }

        public string salary { get; set; }

        public string mstatus { get; set; }

        public string noOfChilds { get; set; }

        public string panNo { get; set; }

        public string id_proof_id { get; set; }

        public string residential_id { get; set; }

        public string id_proof_number { get; set; }

        public string residential_proof_number { get; set; }

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

        public string status { get; set; }

        public string designation { get; set; }

        public string department { get; set; }

        public string AddBiometric_Card_No { get; set; }

        public string pagecount { get; set; }
    }

    private void fillgrid2()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("RowNumber");
        dt.Columns.Add("refNo");
        dt.Columns.Add("eid");
        dt.Columns.Add("comname");
        dt.Columns.Add("department");
        dt.Columns.Add("designation");
        dt.Columns.Add("mobile");
        dt.Columns.Add("email");
        dt.Columns.Add("emailid");
        dt.Rows.Add();

        grdAppoinmentLetter.DataSource = dt;
        grdAppoinmentLetter.DataBind();
    }

    [WebMethod]
    public static int sendsmsonmobile(string mobile, string msg)
    {
        string mobileno = mobile;
        string sender = "Awapal Office";
        string message = msg;
        int result1 = 0;
        //result1 = sendMessageToMobile.SMSSend(mobileno, sender, message);
        return result1;
    }

    protected void Upadte_Regine()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@intresult", 0);
        param[0].Direction = ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, "[usp_Get_employee_resumption]");
    }

    protected void Update_Resumption()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@intresult", 0);
        param[0].Direction = ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, "[usp_Get_employee_resign]");
    }
}