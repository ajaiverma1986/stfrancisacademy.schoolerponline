using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Fee_Management_PayHostel : System.Web.UI.Page
{
    int IdStudent = 0;
    private DataUtility Objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindSessionDDL();
            BindClass();
            BindParentType();
        }
    }
    [WebMethod]
    public static decimal GetFine(int PayAmtID, string DueDate,string TodayDate)
    {
        if (Convert.ToString(TodayDate) == "undefined")
        {
            TodayDate = DateTime.Today.ToString("yyyy-MM-dd");
        }
        DataSet dtFeeFine = new DataSet();
        DateTime InstallmentDate;
        //DateTime TodayDate = DateTime.Today;
        decimal FeeFine = 0;
        decimal TotalFeeFine = 0;
        int DiffDay = 0;
        int FeeType = 0;
        int FineAfterDays = 0;
        DataUtility Objdut = new DataUtility();
        try
        {
            InstallmentDate = Convert.ToDateTime(DueDate);

            dtFeeFine = Objdut.GetDataSet("select FeeID,FeeName,isnull(FeeAmt,0) FeeAmt,isnull(FeeAssignTo,0) FeeAssignTo,isActive,Brid,Fyid,FeeAfterDays,FeeType " +
                      " from mst_FeeFine where isActive=1 and Brid = " + (Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + " and " +
                      " Fyid =" + Convert.ToInt32(CommonClass.Scaler("ActiveAcademicYear")) + " and FeeAssignTo=2 and FeeName<>'Limit' order by FeeAfterDays ASC"));
            if (dtFeeFine.Tables[0].Rows.Count > 0)
            {
                FeeFine = Convert.ToDecimal(dtFeeFine.Tables[0].Rows[0]["FeeAmt"]);
                FeeType = Convert.ToInt32(dtFeeFine.Tables[0].Rows[0]["FeeType"]);
                FineAfterDays = Convert.ToInt32(dtFeeFine.Tables[0].Rows[0]["FeeAfterDays"]);
                if (FeeType == 2)
                {
                    TotalFeeFine = FeeFine;
                }
                else
                {
                    int CountDay = 0;
                    InstallmentDate = InstallmentDate.AddDays(FineAfterDays);
                    DiffDay = Convert.ToInt32(Convert.ToDateTime(TodayDate).Subtract(InstallmentDate).Days);
                    if (DiffDay > 0)
                    {
                        if (FeeType == 1)
                        {
                            if (dtFeeFine.Tables[0].Rows.Count > 1)
                            {
                                CountDay = Convert.ToInt32(dtFeeFine.Tables[0].Rows[1]["FeeAfterDays"]) - Convert.ToInt32(dtFeeFine.Tables[0].Rows[0]["FeeAfterDays"]);
                                TotalFeeFine = (Convert.ToDecimal(dtFeeFine.Tables[0].Rows[1]["FeeAmt"]) * (DiffDay - CountDay));

                                TotalFeeFine = TotalFeeFine + Convert.ToDecimal(dtFeeFine.Tables[0].Rows[0]["FeeAmt"]) * Convert.ToDecimal(CountDay);
                            }
                            else
                            {
                                TotalFeeFine = (Convert.ToDecimal(dtFeeFine.Tables[0].Rows[0]["FeeAmt"]) * (DiffDay - CountDay));
                            }
                        }
                        else
                        {
                            TotalFeeFine = FeeFine;
                        }
                    }
                }
                decimal Limit = Convert.ToDecimal(Objdut.GetScalar("select isnull(FeeAmt,0) from mst_FeeFine where isActive=1 and Brid = " + (Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + " and " +
                      " Fyid =" + Convert.ToInt32(CommonClass.Scaler("ActiveAcademicYear")) + " and FeeAssignTo=2 and FeeName='Limit'")));

                if (TotalFeeFine > Limit)
                {
                    TotalFeeFine = Limit;
                }
            }
            else
            {
                TotalFeeFine = 0;
            }
        }
        catch (Exception e)
        {
            throw e;
        }
        return TotalFeeFine;
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
        string strFeeBal = "0";
        string strPaid = "0";
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("Select Sum(FeeAmount) as FeeAmount from tbl_PayHostelFee1 where StuRegNo='" + StuRegNo + "' and Fyid=" + Fyid + " and Brid=" + HttpContext.Current.Session["BrBrid"].ToString() + "", con))
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
        string strFeeBal = "0";
        string strPaid = "0";
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("Select ISNULL(Sum(FeeAmount),0) as FeeAmount from tbl_PayHostelFee1 where StuRegNo='" + StuRegNo + "' and Fyid=" + Fyid + " and Brid=" + HttpContext.Current.Session["BrBrid"].ToString() + " and PayStatus=2", con))
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
    public static string GetHostelFee(string StuRegNo, string MonthID)
    {
        DataSet Ds = new DataSet();
        DataUtility Objdut = new DataUtility();
        CommonClass objCommon = new CommonClass();

        SqlParameter[] param = new SqlParameter[5];
        param[0] = new SqlParameter("@MODE", 4);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@fyid", Convert.ToInt32(objCommon.GetActiveAcedmicYear()));
        param[3] = new SqlParameter("@STUREGNO", StuRegNo.ToString());
        param[4] = new SqlParameter("@MonthID", MonthID.ToString());
        Ds = Objdut.GetDataSetSP(param, "[USP_HostelToStudent]");

        return Ds.GetXml().ToString();
    } 
    [WebMethod]
    public static studentregistration2[] BindTransAmount(string StuRegNo, string Mode, string Fyid)
    {
        DataSet ds = new DataSet();
        DataUtility obDut = new DataUtility();
        List<studentregistration2> details = new List<studentregistration2>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[USP_HostelToStudent]", con))
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
                param[10] = new SqlParameter("@Fyid", Fyid);
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
                if (ds.Tables.Count > 0)
                {
                    int StartingYear = Convert.ToInt32(obDut.GetScalar("Select ISNULL(StartingYear,0) from financial_Year where FYID=" + Fyid + ""));
                    int EndYear = Convert.ToInt32(obDut.GetScalar("Select ISNULL(EndYear,0) from financial_Year where FYID=" + Fyid + ""));
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        DataUtility Objdut = new DataUtility();
                        foreach (DataRow dtrow in ds.Tables[0].Rows)
                        {
                            string Str = "Select ISNULL(PayStatus,0) from tbl_PayHostelFee1 where MonthID=" + dtrow["MonthId"].ToString() + " and Brid=" + HttpContext.Current.Session["BrBrid"].ToString() + " and Fyid=" + Fyid + " and StuRegNo=" + StuRegNo + " and PayID=" + dtrow["PayID"].ToString() + "";
                            string Status = Convert.ToString(Objdut.GetScalar(Str));
                            studentregistration2 user = new studentregistration2();
                            user.PayAmtID = dtrow["MonthId"].ToString();
                            user.DueDate = "01 " + dtrow["MonthN"].ToString() + " " + StartingYear;
                            user.Month = dtrow["MonthN"].ToString();
                            user.FeeAmount = dtrow["FeeAmount"].ToString();
                            user.PayID = dtrow["PayID"].ToString();
                            if (Status.ToString() == "2")
                            {
                                user.Status = "Paid";
                            }
                            else
                            {
                                user.Status = "Unpaid";
                            }
                            details.Add(user);
                        }
                        foreach (DataRow dtrow1 in ds.Tables[1].Rows)
                        {
                            string Str = "Select ISNULL(PayStatus,0) from tbl_PayHostelFee1 where MonthID=" + dtrow1["MonthId"].ToString() + " and Brid=" + HttpContext.Current.Session["BrBrid"].ToString() + " and Fyid=" + Fyid + " and StuRegNo=" + StuRegNo + " and PayID=" + dtrow1["PayID"].ToString() + "";
                            string Status = Convert.ToString(Objdut.GetScalar(Str));
                            studentregistration2 user = new studentregistration2();
                            user.PayAmtID = dtrow1["MonthId"].ToString();                            
                            user.DueDate = "01 " + dtrow1["MonthN"].ToString() + " " + EndYear;                            
                            user.Month = dtrow1["MonthN"].ToString();
                            user.FeeAmount = dtrow1["FeeAmount"].ToString();
                            user.PayID = dtrow1["PayID"].ToString();
                            if (Status.ToString() == "2")
                            {
                                user.Status = "Paid";
                            }
                            else
                            {
                                user.Status = "Unpaid";
                            }
                            details.Add(user);
                        }
                    }
                }
            }
        }
        return details.ToArray();
    }
    [WebMethod]
    public static studentregistration2[] BindGridByJs(string StuRegNo, string Mode, string Fyid, string ClassID, string SectionID)
    {
        DataSet ds = new DataSet();
        List<studentregistration2> details = new List<studentregistration2>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[USP_HostelToStudent]", con))
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
                param[16] = new SqlParameter("@StuRegNo", StuRegNo);
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
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        DataUtility Objdut = new DataUtility();
                        foreach (DataRow dtrow in ds.Tables[0].Rows)
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
                            user.fatherFname = dtrow["PrimaryParentFirstName"].ToString();
                            user.fatherMname = dtrow["PrimaryParentMiddleName"].ToString();
                            user.fatherLname = dtrow["PrimaryParentLastName"].ToString();
                            user.HostelName = dtrow["HostelName"].ToString();
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
        return details.ToArray();
    }
    public class studentregistration2
    {
        public string HostelName { get; set; }
        public string PayAmtID { get; set; }
        public string DueDate { get; set; }
        public string PayID { get; set; }
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
    public static int Deposite(string PaymentDate, string Fyid, string SturegNo, string MonthID, string FeeFine)
    {
        int intresult = 0;
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("USP_HostelToStudent", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[8];
                param[0] = new SqlParameter("@Mode", Convert.ToInt32(13));
                param[1] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"].ToString());
                param[2] = new SqlParameter("@ADDEDDATE", PaymentDate.ToString());
                param[3] = new SqlParameter("@fyid", Fyid);
                param[4] = new SqlParameter("@StuRegNo", SturegNo);
                param[5] = new SqlParameter("@MonthList", MonthID);
                param[6] = new SqlParameter("@intresult", Convert.ToInt32("0"));
                param[6].Direction = ParameterDirection.Output;
                param[7] = new SqlParameter("@FeeFineAmt", FeeFine);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);
                cmd.Parameters.Add(param[6]);
                cmd.Parameters.Add(param[7]);
                cmd.ExecuteNonQuery();
                intresult = Convert.ToInt32(param[6].Value);
                con.Close();
            }
        }
        return intresult;
    }

    [WebMethod]
    public static int DepositFee(Datainsert theData)
    {
        DataUtility Objdut = new DataUtility();
        int result = 0;
        try
        {
            int intresult = 0;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand("USP_HostelToStudent", con))
                {

                    int _ChequeMode = 0, _PaymentMode=0;
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter[] param = new SqlParameter[22];
                    param[0] = new SqlParameter("@Mode", Convert.ToInt32(13));
                    param[1] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"].ToString());
                    param[2] = new SqlParameter("@ADDEDDATE", Convert.ToString(theData.PaymentDate));
                    param[3] = new SqlParameter("@fyid", Convert.ToString(theData.Fyid));
                    param[4] = new SqlParameter("@StuRegNo", Convert.ToString(theData.SturegNo));
                    param[5] = new SqlParameter("@MonthList", Convert.ToString(theData.MonthID));
                    param[6] = new SqlParameter("@intresult", Convert.ToInt32("0"));
                    param[6].Direction = ParameterDirection.Output;
                    param[7] = new SqlParameter("@FeeFineAmt", Convert.ToString(theData.FineAmount));

                    param[8] = new SqlParameter("@AccountNo", Convert.ToString(theData.ACCOUNTNO));
                    param[9] = new SqlParameter("@BankName", Convert.ToString(theData.BANKNAME));
                    param[10] = new SqlParameter("@BranchName", Convert.ToString(theData.BRANCHNAME));
                    int.TryParse(Convert.ToString(theData.CHEQUEMODE), out _ChequeMode);
                    param[11] = new SqlParameter("@ChequeMode", _ChequeMode);
                    param[12] = new SqlParameter("@ChequeDate", Convert.ToString(theData.CHKREFDDNEFTDATE));
                    param[13] = new SqlParameter("@ChequeNo", Convert.ToString(theData.CHKREFDDNEFTREFRENCENO));
                    param[14] = new SqlParameter("@MicreCode", Convert.ToString(theData.MicreCode));
                    int.TryParse(Convert.ToString(theData.PAYMENTMODE), out _PaymentMode);
                    param[15] = new SqlParameter("@PaymentMode", _PaymentMode);
                    param[16] = new SqlParameter("@ReceivedBy", Convert.ToString(theData.ReceivedBy));

                    if (Convert.ToString(theData.RemainingAmountDate) == "")
                    {
                        param[17] = new SqlParameter("@RemainingAmount", Convert.ToString("0"));
                    }
                    else
                    {
                        param[17] = new SqlParameter("@RemainingAmount", Convert.ToString(theData.RemainingAmount));
                    }

                    
                    param[18] = new SqlParameter("@RemainingAmountDate", Convert.ToString(theData.RemainingAmountDate));
                    param[19] = new SqlParameter("@RemarkOrComment", Convert.ToString(theData.RemarkOrComment));

                    int _MonthID = 0;
                    if (Convert.ToString(theData.RemainingAmountDate) != "")
                    {                        
                        DateTime dt= DateTime.ParseExact(theData.RemainingAmountDate, "dd MMMM yyyy", null);
                        _MonthID = dt.Month;
                    }
                    else
                    {
                        _MonthID = 0;
                    }
                    param[20] = new SqlParameter("@MonthID", _MonthID);
                    param[21] = new SqlParameter("@PaidAmount", Convert.ToString(theData.PaidAmount));

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
                    cmd.Parameters.Add(param[18]);
                    cmd.Parameters.Add(param[19]);
                    cmd.Parameters.Add(param[20]);
                    cmd.Parameters.Add(param[21]);

                    cmd.ExecuteNonQuery();
                    intresult = Convert.ToInt32(param[6].Value);
                    con.Close();
                }
            }
            return intresult;

        }
        catch (Exception e)
        {
            return (result);
            throw e;
        }
        
    }


    public class Datainsert
    {
        public string PaymentDate { get; set; }
        public string Fyid { get; set; }
        public string SturegNo { get; set; }
        public string MonthID { get; set; }
        public string FineAmount { get; set; } // FeeFine 


        public string ACCOUNTNO { get; set; }
        public string BANKNAME { get; set; }
        public string BRANCHNAME { get; set; }
        public int CHEQUEMODE { get; set; }
        public string CHKREFDDNEFTDATE { get; set; }
        public string CHKREFDDNEFTREFRENCENO { get; set; }
        public string MicreCode { get; set; }
        public int PAYMENTMODE { get; set; }
        public string ReceivedBy { get; set; }
        public string RemainingAmount { get; set; }
        public string RemainingAmountDate { get; set; }
        public string RemarkOrComment { get; set; } 
        public string PaidAmount { get; set; }
    }

}