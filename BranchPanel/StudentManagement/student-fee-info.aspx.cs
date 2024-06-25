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

public partial class BranchPanel_StudentManagement_student_fee_info : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) 
        {
            BindFyid();
        }
    }
    public void BindFyid()
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

    [WebMethod]
    public static string BindFeeDetails(int SAMID,int Fyid)
    {
        DataSet Ds = new DataSet();
        try
        {
            DataUtility obj = new DataUtility();
            string sami = Convert.ToString(obj.GetScalar("select SAMID from tbl_StudentAdmissionMaster where StuRegNo=" + SAMID));
               
            using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand("[StudentsAllDetails]", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter[] param = new SqlParameter[3];
                    param[0] = new SqlParameter("@Mode", 2);
                    param[1] = new SqlParameter("@SAMID", Convert.ToInt32(sami));
                    param[2] = new SqlParameter("@fyid", Convert.ToInt32(Fyid));
                    cmd.Parameters.Add(param[0]);
                    cmd.Parameters.Add(param[1]);
                    cmd.Parameters.Add(param[2]);
                    SqlDataAdapter Da = new SqlDataAdapter(cmd);
                    Da.Fill(Ds);
                }
            }
        }
        catch (Exception e)
        {         
            throw e;
        }
        return Ds.GetXml().ToString();
    }
    [WebMethod]
    public static string BindPayNow(int ASAID)
    {
        DataSet Ds = new DataSet();
        try
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand("[StudentsAllDetails]", con))
                {
                    con.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter[] param = new SqlParameter[3];
                    param[0] = new SqlParameter("@Mode", 3);
                    param[1] = new SqlParameter("@ASAID", ASAID);
                    param[2] = new SqlParameter("@Brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
                    cmd.Parameters.Add(param[0]);
                    cmd.Parameters.Add(param[1]);
                    cmd.Parameters.Add(param[2]);
                    SqlDataAdapter Da = new SqlDataAdapter(cmd);
                    Da.Fill(Ds);
                    if(Ds.Tables.Count>0 && Ds.Tables[0].Rows.Count>0)
                    {
                        //Ds.Tables[0].Rows[0]["Recipt_No"]=Convert.ToString(Ds.Tables[0].Rows[0]["Recipt_No"])+DateTime.Now.ToString(")
                    }
                }
            }
        }         
        catch (Exception e)
        {         
            throw e;
        }        
        return Ds.GetXml().ToString();
    }

    [WebMethod]
    public static decimal GetFine(int ASAID, string TodayDate)
    {
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
            if (string.IsNullOrWhiteSpace(TodayDate))
            {
                TodayDate = DateTime.Now.ToString();
            }

            InstallmentDate = Convert.ToDateTime(Objdut.GetScalar("select InstallmentDate From tbl_StudentAdmissionInstallment Where ASAID IN(" + ASAID + ")"));

            dtFeeFine = Objdut.GetDataSet("select FeeID,FeeName,isnull(FeeAmt,0) FeeAmt,isActive,Brid,Fyid,FeeAfterDays,FeeType " +
                      " from mst_FeeFine where isActive=1 and Brid = " + (Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + " and " +
                      " Fyid =" + Convert.ToInt32(CommonClass.Scaler("ActiveAcademicYear")) + ""));
            if (dtFeeFine.Tables[0].Rows.Count > 0)
            {
                FeeFine = Convert.ToDecimal(dtFeeFine.Tables[0].Rows[0]["FeeAmt"]);
                FeeType = Convert.ToInt32(dtFeeFine.Tables[0].Rows[0]["FeeType"]);
                FineAfterDays = Convert.ToInt32(dtFeeFine.Tables[0].Rows[0]["FeeAfterDays"]);
                InstallmentDate = InstallmentDate.AddDays(FineAfterDays);
                DiffDay = Convert.ToInt32(Convert.ToDateTime(TodayDate).Subtract(InstallmentDate).Days);
                if (DiffDay > 0)
                {
                    if (FeeType == 2)
                    {
                        TotalFeeFine = FeeFine;
                    }
                    if (FeeType == 1)
                    {
                        TotalFeeFine = Convert.ToDecimal(DiffDay * FeeFine); ;
                    }
                }
            }
        }
        catch (Exception e)
        {
            throw e;
        }
        return TotalFeeFine;
    }

    [WebMethod]
    public static int sendFeeRemainder(string ASAID)
    {
        int result = 0;
        DataTable DtFeeRemind = new DataTable();
        CommonClass ObjClass = new CommonClass();
        try
        {
            DtFeeRemind = CommonClass.recentfee("FeeRemaind", Convert.ToInt32(ASAID), 0);
            if (DtFeeRemind.Rows.Count > 0)
            {
                if (DtFeeRemind.Rows[0]["MobileNO"].ToString().Length > 9)
                {
                    string msg1 = "", msg2 = "", msg3 = "";
                    msg1 = "Dear ";
                    msg2 = " ,User Id: " + Convert.ToString(DtFeeRemind.Rows[0]["StuRegNo"]) + ",Pwd:12345, Kindly Pay your Fee of Month " + DtFeeRemind.Rows[0]["fMonth"].ToString() + " of Rs. " + DtFeeRemind.Rows[0]["InstallmentAmount"].ToString() + "" +
                    " upto " + (Convert.ToDateTime(DtFeeRemind.Rows[0]["InstallmentDate"])).ToString("dd/MM/yyyy") + " to avoid Late Fee fine. Ignore if already paid. Thanks.";
                   // result = CommonClass.getStudentMobileNo(Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), Convert.ToDecimal(DtFeeRemind.Rows[0]["StuRegNo"]), Convert.ToInt32(CommonClass.Scaler("ActiveAcademicYear")), msg1, msg2, msg3);
                }
                else
                {
                    result = 2;
                }
            }
        }
        catch (Exception e)
        {
            throw e;
        }
        return result;
    }
    
    [WebMethod]
    public static int DepositFee(Datainsert theData)
    {
        DataUtility Objdut = new DataUtility();
        int result = 0;
        try
        {
            SqlParameter[] Param = new SqlParameter[17];
            Param[0] = new SqlParameter("@ASAID", theData.ASAID);
            Param[1] = new SqlParameter("@PAYMENTMODE", theData.PAYMENTMODE);
            Param[2] = new SqlParameter("@BANKNAME", theData.BANKNAME);
            Param[3] = new SqlParameter("@BRANCHNAME", theData.BRANCHNAME);
            Param[4] = new SqlParameter("@CHKREFDDNEFTREFRENCENO", theData.CHKREFDDNEFTREFRENCENO);
            Param[5] = new SqlParameter("@CHKREFDDNEFTDATE", theData.CHKREFDDNEFTDATE);
            Param[6] = new SqlParameter("@RECIPTNO", theData.RECIPTNO);
			//string PAYMENTDATE = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss tt");
            string PAYMENTDATE = Convert.ToDateTime(theData.PAYMENTDATE).ToString("yyyy-MM-dd hh:mm:ss tt");  
           Param[7] = new SqlParameter("@PAYMENTDATE", Convert.ToDateTime(theData.PAYMENTDATE));			
           //Param[7] = new SqlParameter("@PAYMENTDATE", Convert.ToDateTime(PAYMENTDATE));
            Param[8] = new SqlParameter("@RemarkOrComment", theData.RemarkOrComment);
            Param[9] = new SqlParameter("@FeeFine", theData.FineAmount);
            Param[10] = new SqlParameter("@UserId", HttpContext.Current.Session["BrAdid"]);
            Param[11] = new SqlParameter("@PaidAmount", theData.PaidAmount);
            string DateOfDueAmount = "";
            if (theData.DateOfDueAmount.ToString() != "")
            {
                DateOfDueAmount = Convert.ToDateTime(theData.DateOfDueAmount).ToString("yyyy-MM-dd");
                Param[12] = new SqlParameter("@RemaingAmountDueDate", theData.DateOfDueAmount);
            }
            else
            {
            Param[12] = new SqlParameter("@RemaingAmountDueDate", ("2017-01-01"));
            }
            Param[13] = new SqlParameter("@SelectedASID", theData.SelectedASID);
            int _PAYMENTMODE = 0;
            int.TryParse(Convert.ToString(theData.PAYMENTMODE), out _PAYMENTMODE);
            if (_PAYMENTMODE == 2)
            {
                Param[14] = new SqlParameter("@ChequeMode", theData.CHEQUEMODE);                
            }
            else
            {
                Param[14] = new SqlParameter("@ChequeMode", DBNull.Value);
            }
            Param[15] = new SqlParameter("@ACCOUNTNO", theData.ACCOUNTNO);
            Param[16] = new SqlParameter("@Intresult", SqlDbType.Int);
            Param[16].Direction = ParameterDirection.Output;
           result = Objdut.ExecuteSqlSP(Param, "usp_submitinstallment");
            DataTable dtfeeDetails = new DataTable();
            dtfeeDetails.Columns.Add("ASAID");
            dtfeeDetails.Columns.Add("FeeDetails");
            dtfeeDetails.Columns.Add("total");
            dtfeeDetails.Columns.Add("TransportFee");
            dtfeeDetails.Columns.Add("HostelFee");

            decimal TransportFee = 0;
            decimal HostelFee = 0;
            if (!string.IsNullOrWhiteSpace(theData.SelectedASIDFee))
            {
                if (theData.SelectedASIDFee.Contains(","))
                {
                    string[] arr = theData.SelectedASIDFee.Split(',');
                    string prevAsaid = arr[0].Split('|')[1];
                    var tempdetails = "";
                    int i = 0;
                    decimal tempamt = 0;
                    foreach (string st in arr)
                    {
                        string[] arr1 = st.Split('|');

                        DataRow dr = dtfeeDetails.NewRow();
                        if (prevAsaid != arr1[1])
                        {
                            dr["ASAID"] = prevAsaid;
                            dr["FeeDetails"] = tempdetails.TrimEnd('~');
                            dr["total"] = tempamt;
                            dr["TransportFee"] = TransportFee;
                            dr["HostelFee"] = HostelFee;
                            TransportFee = 0;
                            HostelFee = 0;
                            dtfeeDetails.Rows.Add(dr);
                            tempdetails = "";
                            tempamt = 0;
                            prevAsaid = arr1[1];
                        }
                        if (!arr1[0].Contains("TransPort") && !arr1[0].Contains("Hostel"))
                        {
                            tempdetails = tempdetails + arr1[0] + " : " + (Convert.ToDecimal(arr1[3]) - Convert.ToDecimal(arr1[2])).ToString() + "~";
                        }
                        else
                        {
                            if (arr1[0].Contains("TransPort"))
                            {
                                TransportFee = (Convert.ToDecimal(arr1[3]) - Convert.ToDecimal(arr1[2]));
                            }                            
                            if (arr1[0].Contains("Hostel"))
                            {
                                HostelFee = (Convert.ToDecimal(arr1[3]) - Convert.ToDecimal(arr1[2]));
                            }                            
                        }
                        tempamt = tempamt + (Convert.ToDecimal(arr1[3]) - Convert.ToDecimal(arr1[2]));
                        if (i + 1 == arr.Length)
                        {
                            DataRow dr1 = dtfeeDetails.NewRow();
                            dr1["ASAID"] = arr1[1];
                            dr1["FeeDetails"] = tempdetails.TrimEnd('~');
                            dr1["total"] = tempamt;
                            dr1["TransportFee"] = TransportFee;
                            dr1["HostelFee"] = HostelFee;
                            TransportFee = 0;
                            HostelFee = 0;
                            dtfeeDetails.Rows.Add(dr1);
                        }
                        i = i + 1;


                    }
                }
                else
                {
                    string[] arr1 = theData.SelectedASIDFee.Split('|');
                    var tempdetails = "";
                    if (!arr1[0].Contains("TransPort") && !arr1[0].Contains("Hostel"))
                    {
                        tempdetails = arr1[0] + " : " + (Convert.ToDecimal(arr1[3]) - Convert.ToDecimal(arr1[2])).ToString();
                    }
                    
                    decimal tempamt = (Convert.ToDecimal(arr1[3]) - Convert.ToDecimal(arr1[2]));
                    DataRow dr1 = dtfeeDetails.NewRow();
                    dr1["ASAID"] = arr1[1];
                    dr1["FeeDetails"] = tempdetails;
                    dr1["total"] = tempamt;
                    if (arr1[0].Contains("TransPort"))
                    {
                        dr1["TransportFee"] = (Convert.ToDecimal(arr1[3]) - Convert.ToDecimal(arr1[2]));
                    }
                    else
                    {
                        dr1["TransportFee"] = 0;
                    }
                    if (arr1[0].Contains("Hostel"))
                    {
                        dr1["HostelFee"] = (Convert.ToDecimal(arr1[3]) - Convert.ToDecimal(arr1[2]));
                    }
                    else
                    {
                        dr1["HostelFee"] = 0;
                    }
                    dtfeeDetails.Rows.Add(dr1);
                }
            }
            
            if (result > 0)
            {
				//if (!string.IsNullOrWhiteSpace(theData.ASAID))
    //            {
    //                result = Convert.ToInt32(theData.ASAID);
    //            } 
                foreach(DataRow row in dtfeeDetails.Rows)
                {
                    
                    SqlParameter[] Param1 = new SqlParameter[7];
                    Param1[0] = new SqlParameter("@ASAID", row["ASAID"].ToString());
                    Param1[1] = new SqlParameter("@FeeDetails", row["FeeDetails"].ToString());
                    Param1[2] = new SqlParameter("@amt", row["total"].ToString());
                    Param1[3] = new SqlParameter("@DateOfDueAmount", DateOfDueAmount);
                    Param1[4] = new SqlParameter("@TransportFee", row["TransportFee"].ToString());
                    Param1[5] = new SqlParameter("@HostelFee", row["HostelFee"].ToString());
                    Param1[6] = new SqlParameter("@intResult", SqlDbType.Int);                    
                    Param1[6].Direction = ParameterDirection.Output;
                   var result1 = Objdut.ExecuteSqlSP(Param1, "sp_PayFeeHeadWise");
                }
                string msg1 = "", msg2 = "", msg3 = "";
                msg1 = "'Hi ";
                msg2 = " ,Fee Amount of Rs." + theData.PaidAmount + " Successfully Received with Recipt No : " + theData.RECIPTNO + " on " + DateTime.Today.ToString("dd/MM/yyyy") + ".";
                msg3 = "Next Due Fee Date is " + DateOfDueAmount + ".Thanks.";
                CommonClass.getStudentMobileNo(Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), Convert.ToDecimal(HttpContext.Current.Session["StuRegNo"]), Convert.ToInt32(CommonClass.Scaler("ActiveAcademicYear")), msg1, msg2, msg3);
            }
        }
        catch (Exception e)
        {
            throw e;
        }
        return (result);
    }

    public class Datainsert
    {
        public string ASAID { get; set; }

        public string PAYMENTMODE { get; set; }

        public int CHEQUEMODE { get; set; }

        public string BANKNAME { get; set; }

        public string ACCOUNTNO { get; set; }

        public string BRANCHNAME { get; set; }

        public string CHKREFDDNEFTREFRENCENO { get; set; }

        public string CHKREFDDNEFTDATE { get; set; }

        public string RECIPTNO { get; set; }

        public string PAYMENTDATE { get; set; }

        public string RemarkOrComment { get; set; }

        public string PaidAmount { get; set; }
        public string FineAmount { get; set; }

        public string DateOfDueAmount { get; set; }

        public string SelectedASID { get; set; }

        public string SelectedASIDFee { get; set; }
    }


    [WebMethod]
    public static int RoolBackFee(int ASAID)
    {
        int result = 0;
        DataUtility Objdut = new DataUtility();
        try
        {
            SqlParameter[] Param = new SqlParameter[4];
            Param[0] = new SqlParameter("@ASAID", ASAID);
            Param[1] = new SqlParameter("@RollbackedByUserId", HttpContext.Current.Session["BrADID"]);
            Param[2] = new SqlParameter("@SystemName", System.Environment.MachineName);
            Param[3] = new SqlParameter("@Intresult", SqlDbType.Int);
            Param[3].Direction = ParameterDirection.Output;
            result = Objdut.ExecuteSqlSP(Param, "[Usp_RollBackFee1]");
        }
        catch (Exception e)
        {
            throw e;
        }
        return (result);
    }

    [WebMethod]
    public static string PaymentDetails(string ids,int chk,int id)
    {
        DataUtility Objdut = new DataUtility();       
        ids = ids.TrimEnd(',');
        if (chk == 3)
        {
            if (ids != "") {
                //int Result = (int)(Objdut.ExecuteSql("Delete from tblTemp where ID in (" + ids + ")"));
                int Result = (int)(Objdut.ExecuteSql("truncate table tblTemp"));
            }
        }             
        

        DataSet Ds = new DataSet();
        DataTable dtFeeDetails = new DataTable();
        DataTable dtFeeHead = new DataTable();
        dtFeeHead.Columns.Add("SNo");
        dtFeeHead.Columns.Add("FeeHead");
        dtFeeHead.Columns.Add("FeeHeadAmt", typeof(decimal));
        dtFeeHead.Columns.Add("ASAID");
        DataTable dtFeeHead1 = new DataTable();
        dtFeeHead1.Columns.Add("SNo");
        dtFeeHead1.Columns.Add("FeeHead");
        dtFeeHead1.Columns.Add("FeeHeadAmt", typeof(decimal));
        
        
        DataTable dtAsaid;
        string ALLSAID = "";
        string[] InASAID;
        double[] ArrSAID = new double[100];
        dtAsaid = Objdut.GetDataTable("Select ISNULL(HostelFee,0) HostelFee,ISNULL(TransPortAmt,0) TransPortAmt,ISNULL(FeeFineAmt,0) FeeFineAmt,AllASAID from tbl_StudentAdmissionInstallment where ASAID = " + id + "");
        if (dtAsaid.Rows.Count > 0)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand("[StudentsAllDetails]", con))
                {
                    con.Open();
                    ALLSAID = dtAsaid.Rows[0]["ALLASAID"].ToString();
                    if (ALLSAID != "")
                    {
                        InASAID = ALLSAID.Split(',');
                        for (int i = 0; i < InASAID.Length; i++)
                        {
                            if (chk == 0)
                            {
                                int Result = (int)(Objdut.ExecuteSql("Delete from tblTemp where ID=" + Convert.ToInt32(InASAID[i])));
                            }
                            else
                            {
                                int Result = (int)(Objdut.ExecuteSql("if exists(Select * from tblTemp where ID=" + Convert.ToInt32(InASAID[i]) + ") print 'exists' ELSE INSERT INTO tblTemp VALUES(" + Convert.ToInt32(InASAID[i]) + ")"));
                            }
                        }
                    }
                    else
                    {
                        if (chk == 0)
                        {
                            int Result = (int)(Objdut.ExecuteSql("Delete from tblTemp where ID=" + Convert.ToInt32(id)));
                        }
                        else
                        {
                            int Result = (int)(Objdut.ExecuteSql("if exists(Select * from tblTemp where ID=" + Convert.ToInt32(id) + ") print 'exists' ELSE INSERT INTO tblTemp VALUES(" + Convert.ToInt32(id) + ")"));
                        }                        
                    }
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter[] param2 = new SqlParameter[1];
                    param2[0] = new SqlParameter("@Mode", 7);
                    cmd.Parameters.Add(param2[0]);
                    SqlDataAdapter Da = new SqlDataAdapter(cmd);
                    Da.Fill(dtFeeDetails);

                    
                }
            }


            decimal total = 0;
            if (dtFeeDetails.Rows.Count > 0)
            {
                string MonthName = "";
                string MonthID = "";
                for (int k = 0; k < dtFeeDetails.Rows.Count; k++)
                {

                    if (MonthName == "")
                    {
                        MonthName = dtFeeDetails.Rows[k]["MName"].ToString().Substring(0, 3);
                        MonthID = dtFeeDetails.Rows[k]["MonthNo"].ToString();
                    }
                    else
                    {
                        MonthName = MonthName + "-" + dtFeeDetails.Rows[k]["MName"].ToString().Substring(0, 3);
                        MonthID = MonthID + "," + dtFeeDetails.Rows[k]["MonthNo"].ToString();
                    }
                    string[] FeeRowHead;
                    FeeRowHead = dtFeeDetails.Rows[k]["FeeDescription"].ToString().Split('&');
                    if (FeeRowHead[0].ToString() != "N/A")
                    {
                        for (int i = 0; i < FeeRowHead.Length; i++)
                        {
                            string[] FeeHead;
                            FeeHead = FeeRowHead[i].ToString().Split(':');
                            DataRow dr = dtFeeHead.NewRow();
                            dr["SNo"] = Convert.ToInt32(dtFeeHead.Rows.Count) + 1;
                            dr["FeeHead"] = FeeHead[0].ToString();
                            dr["FeeHeadAmt"] = Convert.ToDecimal(FeeHead[1]);
                            dr["ASAID"] = dtFeeDetails.Rows[k]["ASAID"];
                            total = total + Convert.ToDecimal(FeeHead[1]);
                            dtFeeHead.Rows.Add(dr);
                        }
                    }
                }
                if (ids != "")
                {
                    DataTable dtAsaid1 = Objdut.GetDataTable("Select ASAID, ISNULL(HostelFee,0) HostelFee,ISNULL(TransPortAmt,0) TransPortAmt,ISNULL(FeeFineAmt,0) FeeFineAmt,AllASAID from tbl_StudentAdmissionInstallment where ASAID in ( " + ids + ")");
                    
                        if (dtAsaid1.Rows.Count > 0)
                        {
                            for (int j = 0; j < dtAsaid1.Rows.Count;j++ )
                            {
                                decimal HostelFee = 0;
                                decimal.TryParse(Convert.ToString(dtAsaid1.Rows[j]["HostelFee"]), out HostelFee);
                                decimal TransPortAmt = 0;
                                decimal.TryParse(Convert.ToString(dtAsaid1.Rows[j]["TransPortAmt"]), out TransPortAmt);
                                if (HostelFee > 0)
                                {
                                    DataRow dr = dtFeeHead.NewRow();
                                    dr["SNo"] = Convert.ToInt32(dtFeeHead.Rows.Count) + 1;
                                    dr["FeeHead"] = "Hostel Fee";
                                    dr["FeeHeadAmt"] = HostelFee;
                                    dr["ASAID"] = dtAsaid1.Rows[j]["ASAID"];
                                    dtFeeHead.Rows.Add(dr);
                                }
                                if (TransPortAmt > 0)
                                {
                                    DataRow dr = dtFeeHead.NewRow();
                                    dr["SNo"] = Convert.ToInt32(dtFeeHead.Rows.Count) + 1;
                                    dr["FeeHead"] = "TransPort Fee";
                                    dr["FeeHeadAmt"] = TransPortAmt;
                                    dr["ASAID"] = dtAsaid1.Rows[j]["ASAID"];
                                    dtFeeHead.Rows.Add(dr);
                                }
                            }
                            

                        } 
                }
                else
                {
                    if (dtAsaid.Rows.Count > 0)
                    {
                        decimal HostelFee = 0;
                        decimal.TryParse(Convert.ToString(dtAsaid.Rows[0]["HostelFee"]), out HostelFee);
                        decimal TransPortAmt = 0;
                        decimal.TryParse(Convert.ToString(dtAsaid.Rows[0]["TransPortAmt"]), out TransPortAmt);
                        if (HostelFee > 0)
                        {
                            DataRow dr = dtFeeHead.NewRow();
                            dr["SNo"] = Convert.ToInt32(dtFeeHead.Rows.Count) + 1;
                            dr["FeeHead"] = "Hostel Fee";
                            dr["FeeHeadAmt"] = HostelFee;
                            dr["ASAID"] = id;
                            dtFeeHead.Rows.Add(dr);
                        }
                        if (TransPortAmt > 0)
                        {
                            DataRow dr = dtFeeHead.NewRow();
                            dr["SNo"] = Convert.ToInt32(dtFeeHead.Rows.Count) + 1;
                            dr["FeeHead"] = "TransPort Fee";
                            dr["FeeHeadAmt"] = TransPortAmt;
                            dr["ASAID"] = id;
                            dtFeeHead.Rows.Add(dr);
                        }

                    } 
                }
                
                DataTable dt_Barcode = new DataTable();
                dt_Barcode = dtFeeHead.DefaultView.ToTable(true, "FeeHead");

                if (dt_Barcode.Rows.Count > 0)
                {
                    for (int a = 0; a < dt_Barcode.Rows.Count; a++)
                    {
                        DataRow dr1 = dtFeeHead1.NewRow();
                        dr1["SNo"] = Convert.ToInt32(a) + 1;
                        dr1["FeeHead"] = dt_Barcode.Rows[a]["FeeHead"].ToString();
                        dr1["FeeHeadAmt"] = Convert.ToDecimal(dtFeeHead.Compute("Sum(FeeHeadAmt)", "FeeHead='" + dt_Barcode.Rows[a]["FeeHead"] + "'"));
                        
                        dtFeeHead1.Rows.Add(dr1);
                    }
                }
            }

        }

        
        if (dtFeeHead.Rows.Count > 0)
        {
            DataView dv = dtFeeHead.DefaultView;
            dv.Sort = "ASAID desc";
            DataTable dtAllhead = dv.ToTable();
            Ds.Tables.Add(dtAllhead);
        }

        return Ds.GetXml().ToString();
    }
}