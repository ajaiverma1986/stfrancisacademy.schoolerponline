using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_transportmanagment_StdFeeList : System.Web.UI.Page
{
    int IdStudent = 0;
    private DataUtility Objdut = new DataUtility();
    private static int Fyid1 = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            CommonClass CommonClass = new CommonClass();
            Fyid1 = CommonClass.GetActiveAcedmicYear(); 
            
            BindSessionDDL();
            //BindClass();
            //BindParentType();
        }
    }
    [WebMethod]
    public static int RollBackFee(int ASAID)
    {
        int result = 0;
        DataUtility Objdut = new DataUtility();
        try
        {
            SqlParameter[] Param = new SqlParameter[4];
            Param[0] = new SqlParameter("@PayAmtId", ASAID);
            Param[1] = new SqlParameter("@RollbackedByUserId", HttpContext.Current.Session["BrADID"]);
            Param[2] = new SqlParameter("@SystemName", System.Environment.MachineName);
            Param[3] = new SqlParameter("@Intresult", SqlDbType.Int);
            Param[3].Direction = ParameterDirection.Output;
            result = Objdut.ExecuteSqlSP(Param, "[Usp_RollBackTransFee]");
        }
        catch (Exception e)
        {
            throw e;
        }
        return (result);
    }
    public void BindParentType()
    {
        CommonClass CommonClass = new CommonClass();
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetParentType");
        //if (Dt.Rows.Count > 0)
        //{
        //    ddlparenttype.DataSource = Dt;
        //    ddlparenttype.DataTextField = "Relation";
        //    ddlparenttype.DataValueField = "Id";
        //    ddlparenttype.DataBind();
        //    ListItem li = new ListItem("--Select Parent Type--", "0");
        //    ddlparenttype.Items.Insert(0, li);
        //    Dt.Dispose();
        //}
    }
    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlFyid.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlFyid.DataValueField = "Fyid";
        ddlFyid.DataTextField = "FYName";
        ddlFyid.DataBind();
        ddlFyid.Items.Insert(0, new ListItem("--Select Session--", "0"));
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlFyid.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    public static string TotalFee(string RID, string StuRegNo, string Fyid)
    {
        Fyid = Fyid1.ToString(); 
        string strFeeBal = "0";
        string strPaid = "0";
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("Select Sum(FeeAmount) as FeeAmount from tbl_transfee where PayStatus in(1,2) and StuRegNo='" + StuRegNo + "' and Fyid=" + Fyid + " and Brid=" + HttpContext.Current.Session["BrBrid"].ToString() + "", con))
            {
                con.Open();
                cmd.CommandType = CommandType.Text;
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    strPaid = dr["FeeAmount"].ToString();
                }
                con.Close();
            }
        }
        return strPaid.ToString();
    }
    public static string PaidFee(string RID, string StuRegNo, string Fyid)
    {
        Fyid = Fyid1.ToString(); 
        string strFeeBal = "0";
        string strPaid = "0";
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("Select ISNULL(Sum(FeeAmount),0) as FeeAmount from tbl_transfee where StuRegNo='" + StuRegNo + "' and Fyid=" + Fyid + " and Brid=" + HttpContext.Current.Session["BrBrid"].ToString() + " and PayStatus=2", con))
            {
                con.Open();
                cmd.CommandType = CommandType.Text;
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    strPaid = dr["FeeAmount"].ToString();
                }
                con.Close();
            }
        }
        return strPaid.ToString();
    }
    [WebMethod]
    public static studentregistration2[] BindTransAmount(string StuRegNo, string Mode, string Fyid, string PayStatus)
    {
        if (StuRegNo == "0")
            StuRegNo = HttpContext.Current.Session["StuRegNo"].ToString();

        DataSet ds = new DataSet();
        List<studentregistration2> details = new List<studentregistration2>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_StudentTransFee]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[17];
                param[0] = new SqlParameter("@Mode", Convert.ToInt32(Mode));
                param[1] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"].ToString());
                param[2] = new SqlParameter("@FromDate", "");
                param[3] = new SqlParameter("@ToDate", "");
                param[4] = new SqlParameter("@Registration_No", "");
                param[5] = new SqlParameter("@StudentFirstName", "");
                param[6] = new SqlParameter("@PrimaryParentFirstName", "");
                param[7] = new SqlParameter("@PrimaryMobileNo", "");
                param[8] = new SqlParameter("@PrimaryEmailId", "");
                param[9] = new SqlParameter("@applyingforclass", "0");
                param[10] = new SqlParameter("@Fyid", Fyid1);
                param[11] = new SqlParameter("@AdmissionNo", "");
                param[12] = new SqlParameter("@pagesize", 1);
                param[13] = new SqlParameter("@pageno", 0);
                param[14] = new SqlParameter("@SectionID", "0");
                param[15] = new SqlParameter("@intresult", Convert.ToInt32("0"));
                param[15].Direction = ParameterDirection.Output;
                param[16] = new SqlParameter("@StuRegNo", StuRegNo);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);
                cmd.Parameters.Add(param[6]);
                cmd.Parameters.Add(param[7]);
                cmd.Parameters.Add(param[8]);
                cmd.Parameters.Add(param[9]);
                cmd.Parameters.Add(param[10]);
                cmd.Parameters.Add(param[11]);
                cmd.Parameters.Add(param[12]);
                cmd.Parameters.Add(param[13]);
                cmd.Parameters.Add(param[14]);
                cmd.Parameters.Add(param[15]);
                cmd.Parameters.Add(param[16]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                DataSet dtTransfee = getTransFee(ds, StuRegNo, Fyid, HttpContext.Current.Session["BrBrid"].ToString());
                if (dtTransfee.Tables.Count > 0)
                {
                    if (dtTransfee.Tables[0].Rows.Count > 0)
                    {
                        DataUtility Objdut = new DataUtility();
                        foreach (DataRow dtrow in dtTransfee.Tables[0].Rows)
                        {
                            if (dtrow["PayStatus"].ToString().Trim() == PayStatus.ToString().Trim())
                            {
                                studentregistration2 user = new studentregistration2();
                                user.PayAmtId = dtrow["PayAmtID"].ToString();
                                user.ASAID = dtrow["ASAID"].ToString();
                                user.PaidDate = Convert.ToDateTime(dtrow["Payment_Date"]).ToString("dd MMM yyyy");
                                user.Month = getMonthName(user.PayAmtId);
                                user.FeeAmount = dtrow["FeeAmount"].ToString();
                                if (dtrow["PayStatus"].ToString() == "2")
                                {
                                    user.Status = "Paid";
                                }
                                else if(dtrow["PayStatus"].ToString() == "1")
                                {
                                    user.Status = "Unpaid";
                                }
                                details.Add(user);
                            }
                        }
                    }
                }
            }
        }
        return details.ToArray();
    }

    private static DataSet getTransFee(DataSet ds, string stuRegNo, string Fyid, string Brid)
    {
        Fyid = Fyid1.ToString(); 
        DataUtility Objdut = new DataUtility();
        string str = @"Select Distinct Fee.PayAmtId,Fee.ASAID, '',(ISNULL(Fee.FeeAmount,0)+ISNULL(Fee.FeeFineAmount,0)) FeeAmount,Fee.PayStatus, Fee.AllAsaid,Fee.Payment_Date           
                         from tbl_transfee Fee       
                         where Fee.SturegNo=" + stuRegNo + " and Fee.Fyid=" + Fyid + " and Fee.Brid=" + Brid + " and PayStatus=2 and ASAID=0";
        DataTable dtData = Objdut.GetDataTable(str);
        if (ds.Tables.Count > 0)
        {
            ds.Tables[0].Merge(dtData);
        }
        else
        {
            ds.Tables.Add(dtData);
        }
        return ds;
    }

    [WebMethod]
    public static studentregistration2[] BindGridByJs(string Mode, string Fyid)
    {
        Fyid = Fyid1.ToString();
        DataUtility Objdut = new DataUtility();
        List<studentregistration2> details = new List<studentregistration2>();
        string ClassID = "";
        string SectionID = "";
        string strQuery = @"Select distinct Cm.id,Sam.SectionId,Sam.Fyid        
                            From tbl_StudentAdmissionMaster Sam
                            Inner Join Class_Master Cm On Cm.Id=Sam.ClassId
                            Inner Join Financial_Year Fy On Fy.Fyid=Sam.Fyid 
                            Where StuRegNo=" + HttpContext.Current.Session["StuRegNo"] + 
                            " And Sam.Brid=" + HttpContext.Current.Session["BrBrid"].ToString() + 
                            " AND Sam.IsActive=1 And Sam.Status=1";
        DataTable dt = Objdut.GetDataTable(strQuery);
        if (dt.Rows.Count > 0)
        {
            ClassID = dt.Rows[0]["Id"].ToString();
            SectionID = dt.Rows[0]["SectionID"].ToString();
            Fyid = dt.Rows[0]["Fyid"].ToString();
            Fyid1 = Convert.ToInt32(Fyid);

            DataSet ds = new DataSet();            
            using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand("[usp_StudentTransFee]", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter[] param = new SqlParameter[18];
                    param[0] = new SqlParameter("@Mode", Convert.ToInt32(Mode));
                    param[1] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"].ToString());
                    param[2] = new SqlParameter("@FromDate", "");
                    param[3] = new SqlParameter("@ToDate", "");
                    param[4] = new SqlParameter("@Registration_No", "");
                    param[5] = new SqlParameter("@StudentFirstName", "");
                    param[6] = new SqlParameter("@PrimaryParentFirstName", "");
                    param[7] = new SqlParameter("@PrimaryMobileNo", "");
                    param[8] = new SqlParameter("@PrimaryEmailId", "");
                    param[9] = new SqlParameter("@applyingforclass", ClassID);
                    param[10] = new SqlParameter("@Fyid", Fyid);
                    param[11] = new SqlParameter("@AdmissionNo", "");
                    param[12] = new SqlParameter("@pagesize", 1);
                    param[13] = new SqlParameter("@pageno", 0);
                    param[14] = new SqlParameter("@SectionID", SectionID);
                    param[15] = new SqlParameter("@intresult", Convert.ToInt32("0"));
                    param[15].Direction = ParameterDirection.Output;
                    param[16] = new SqlParameter("@StuRegNo", HttpContext.Current.Session["StuRegNo"]);
                    param[17] = new SqlParameter("@Status", Convert.ToInt32(1));
                    cmd.Parameters.Add(param[0]);
                    cmd.Parameters.Add(param[1]);
                    cmd.Parameters.Add(param[2]);
                    cmd.Parameters.Add(param[3]);
                    cmd.Parameters.Add(param[4]);
                    cmd.Parameters.Add(param[5]);
                    cmd.Parameters.Add(param[6]);
                    cmd.Parameters.Add(param[7]);
                    cmd.Parameters.Add(param[8]);
                    cmd.Parameters.Add(param[9]);
                    cmd.Parameters.Add(param[10]);
                    cmd.Parameters.Add(param[11]);
                    cmd.Parameters.Add(param[12]);
                    cmd.Parameters.Add(param[13]);
                    cmd.Parameters.Add(param[14]);
                    cmd.Parameters.Add(param[15]);
                    cmd.Parameters.Add(param[16]);
                    cmd.Parameters.Add(param[17]);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(ds);
                    if (ds.Tables.Count > 0)
                    {
                        ds.Tables[0].Columns.Remove("ASAID");
                        ds.Tables[0].Columns.Remove("UserName");
                        ds.Tables[0].Columns.RemoveAt(0);
                        DataTable filteredDt = ds.Tables[0].DefaultView.ToTable(true, "RID", "Fyid", "ClassID", "SectionID", "Registration_No", "SturegNo", "AdmissionNo", "studentFname", "studentMname", "studentLname", "StudentDOB", "StudentMob", "fatherFname", "fatherMname", "fatherLname");
                        if (filteredDt.Rows.Count > 0)
                        {
                            foreach (DataRow dtrow in filteredDt.Rows)
                            {
                                studentregistration2 user = new studentregistration2();
                                user.StuRegNo = dtrow["StuRegNo"].ToString();
                                user.Fyid = dtrow["Fyid"].ToString();
                                user.Registration_No = dtrow["Registration_No"].ToString();
                                user.AdmissionNo = dtrow["AdmissionNo"].ToString();
                                user.studentFname = dtrow["studentFname"].ToString();
                                user.studentMname = dtrow["studentMname"].ToString();
                                user.studentLname = dtrow["studentLname"].ToString();
                                user.ClassID = dtrow["ClassID"].ToString();
                                user.SectionID = dtrow["SectionID"].ToString();
                                user.Classname = (string)(Objdut.GetScalar("Select ISNULL(Classname,'') from Class_Master where id=" + dtrow["ClassID"].ToString() + ""));
                                user.fatherFname = dtrow["fatherFname"].ToString();
                                user.fatherMname = dtrow["fatherMname"].ToString();
                                user.fatherLname = dtrow["fatherLname"].ToString();
                                user.PrimaryMobileNo = dtrow["StudentMob"].ToString();
                                user.Sectionname = (string)(Objdut.GetScalar("Select ISNULL(sectionname,'') from classwithsection where cwsid=" + dtrow["SectionID"].ToString() + ""));
                                user.DOB = Convert.ToDateTime(dtrow["StudentDOB"]).ToString("dd MMM yyyy");
                                user.TotalFee = TotalFee(dtrow["RID"].ToString(), dtrow["SturegNo"].ToString(), dtrow["Fyid"].ToString());
                                user.PaidFee = PaidFee(dtrow["RID"].ToString(), dtrow["SturegNo"].ToString(), dtrow["Fyid"].ToString());
                                user.BalFee = (Convert.ToDecimal(user.TotalFee) - Convert.ToDecimal(user.PaidFee)).ToString();
                                if (user.BalFee.ToString() == "0.00")
                                {
                                    user.PayStatus = "Paid";
                                }
                                else
                                {
                                    user.PayStatus = "Unpaid";
                                }
                                details.Add(user);
                            }
                        }
                    }
                }
            }
        }
        return details.ToArray();
    }

    public DataTable RemoveDuplicateRows(DataTable dTable, string colName)
    {
        Hashtable hTable = new Hashtable();
        ArrayList duplicateList = new ArrayList();

        //Add list of all the unique item value to hashtable, which stores combination of key, value pair.
        //And add duplicate item value in arraylist.
        foreach (DataRow drow in dTable.Rows)
        {
            if (hTable.Contains(drow[colName]))
                duplicateList.Add(drow);
            else
                hTable.Add(drow[colName], string.Empty);
        }

        //Removing a list of duplicate items from datatable.
        foreach (DataRow dRow in duplicateList)
            dTable.Rows.Remove(dRow);

        //Datatable which contains unique records will be return as output.
        return dTable;
    }

    public class studentregistration2
    {
        public string PayAmtId { get; set; }
        public string ASAID { get; set; }
        public string SAMID { get; set; }
        public string Fyid { get; set; }
        public string AdmissionDate { get; set; }
        public string AdmissionNo { get; set; }
        public string RefAdmNo { get; set; }
        public string RID { get; set; }
        public string StuRegNo { get; set; }
        public string RegistrationDate { get; set; }
        public string Registration_No { get; set; }
        public string studentFname { get; set; }
        public string studentMname { get; set; }
        public string studentLname { get; set; }
        public string StudentUID { get; set; }
        public string Classname { get; set; }
        public string ClassID { get; set; }
        public string SectionID { get; set; }
        public string Sectionname { get; set; }
        public string DOB { get; set; }
        public string Status { get; set; }
        public string FeeAmount { get; set; }
        public string fatherFname { get; set; }
        public string fatherMname { get; set; }
        public string fatherLname { get; set; }
        public string PrimaryMobileNo { get; set; }
        public string PrimarySelectParentType { get; set; }
        public string PrimaryParentDOB { get; set; }
        public string PrimaryParentOccupation { get; set; }
        public string PrimaryEmailId { get; set; }

        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Pin { get; set; }
        public string Country { get; set; }

        public string Comment { get; set; }
        public string pagecount { get; set; }
        public string PayStatus { get; set; }
        public string Month { get; set; }
        public string TotalFee { get; set; }
        public string PaidFee { get; set; }
        public string BalFee { get; set; }

        public string PaidDate { get; set; }

    }
    public void BindClass()
    {
        DataTable Dt = new DataTable();
        CommonClass CommonClass = new CommonClass();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ActiveFinancialyear), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        if (Dt.Rows.Count > 0)
        {
            ddlapplyingforclass.DataSource = Dt;
            ddlapplyingforclass.DataTextField = "Classname";
            ddlapplyingforclass.DataValueField = "classid";
            ddlapplyingforclass.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlapplyingforclass.Items.Insert(0, li);
        }
    }
    [WebMethod]
    public static int Deposite(string FineAmt, string PaymentDate, string Fyid, string SturegNo, string ASAID, decimal TotalAmount)
    {
        Fyid = Fyid1.ToString(); 
        if (string.IsNullOrWhiteSpace(FineAmt))
            FineAmt = "0";

        if (SturegNo == "0")
            SturegNo = HttpContext.Current.Session["StuRegNo"].ToString(); 
        
        var isMultiPament = 0;
        string[] AsaidList = ASAID.Split(',');
        DataUtility Objdut = new DataUtility();
        string[] AllAsaid = ASAID.Split(',');
        if (AllAsaid.Length > 1)
        {
            isMultiPament = 1;
        }
        SqlParameter[] param = new SqlParameter[11];
        param[0] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"]);
        param[1] = new SqlParameter("@Fyid", Convert.ToInt32(Fyid));
        param[2] = new SqlParameter("@Mode", 1);
        param[3] = new SqlParameter("@StuRegNo", SturegNo);
        param[4] = new SqlParameter("@PaymentDate", Convert.ToDateTime(PaymentDate));
        param[5] = new SqlParameter("@AllAsaid", ASAID);
        param[6] = new SqlParameter("@UserName", HttpContext.Current.Session["Brusername"]);
        param[7] = new SqlParameter("@intResult", SqlDbType.Int);
        param[7].Direction = ParameterDirection.Output;
        param[8] = new SqlParameter("@isMultiPament", isMultiPament);
        param[9] = new SqlParameter("@TotalAmount", TotalAmount);
        param[10] = new SqlParameter("@FeeFineAmount", FineAmt);
        Objdut.ExecuteSqlSP(param, "[USP_DEPOSITE_TRANSFEE]");
        int intresult = Convert.ToInt32(param[7].Value);
        return intresult;
    }

    [WebMethod]
    public static string getMonthName(string PayAmtId)
    {
        string monthNameList = "";
        DataUtility Objdut = new DataUtility();
        string allAsaid = Convert.ToString(Objdut.GetScalar("Select ISNULL(AllAsaid,'') from tbl_TransFee where PayAmtId=" + PayAmtId));
        if (string.IsNullOrEmpty(allAsaid))
        {
            allAsaid = Convert.ToString(Objdut.GetScalar("Select ISNULL(Asaid,'') from tbl_TransFee where PayAmtId=" + PayAmtId));
        }
        string[] AsaidList = allAsaid.Split(',');
        if (AsaidList.Length > 0)
        {
            for (int i = 0; i < AsaidList.Length; i++)
            {
                string monthName = Convert.ToString(Objdut.GetScalar("Select ISNULL(DateName(month, DateAdd(month, MonthId,-1)),'') from tbl_StudentAdmissionInstallment where ASAID=" + AsaidList[i]));
                if (string.IsNullOrEmpty(monthNameList))
                {
                    monthNameList = monthName;
                }
                else
                {
                    monthNameList = monthNameList + "," + monthName;
                }
            }
        }
        return monthNameList;
    }
}