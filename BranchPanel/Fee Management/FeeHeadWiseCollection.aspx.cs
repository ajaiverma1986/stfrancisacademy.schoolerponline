using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Configuration;
using System.Text;
using System.Web;
using ClosedXML.Excel;
using System.Linq;

public partial class BranchPanel_Fee_Management_Default : System.Web.UI.Page
{
    private DataTable dt;
    private string url;
    private string PageName, str;
    private string teaname = string.Empty;
    private string teaid = string.Empty;
    private string Empname = string.Empty;
    private string EmpID = string.Empty;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private CommonClass clsobj = new CommonClass();
    private CommonClass CommonClass = new CommonClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        // fillTeacher();
        // fillClass();
        url = Request.Url.ToString();
        if (Session["User"] == null)
        {
        }
        //btnSubmit.Visible = false;
        if (!this.IsPostBack)
        {
            fillfyear();
            //fillgrid();
            //FillClass();
            //   fillFeeHead();
            //   fillUsers();
        }
    }

    private void fillUsers()
    {
        string StrUserQuery = "Select userid,UserName FROM tblUser where IsActive=1";
        DataTable Dt = objdut.GetDataTable(StrUserQuery);
        if (Dt.Rows.Count > 0) {
            ddlUser.DataValueField = "userid";
            ddlUser.DataTextField = "UserName";
            ddlUser.DataSource = Dt;
            ddlUser.DataBind();
            ddlUser.Items.Insert(0, new ListItem("-- ALL User --", "0"));
        }
    }

    [WebMethod]
    public static string getFeeHeadCollection(int FyID, int UserID, int GroupID, int ClassID, string StartDate, string EndDate, string FeeHeadID,int PaymentType)
    {
        var data = GetFeeHeadData(FyID, UserID, GroupID, ClassID, StartDate, EndDate, FeeHeadID, PaymentType);
        return data;
    }

    [WebMethod]
    public static csClass[] BindClass(int Fyid)
    {
        List<csClass> Details = new List<csClass>();
        DataUtility objdut = new DataUtility();
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 6);
        param[1] = new SqlParameter("@fyid", Fyid);
        param[2] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        dt = objdut.GetDataTableSP(param, "Usp_Class");
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in dt.Rows)
            {
                csClass user = new csClass();
                user.ClassID = Convert.ToInt32(dtrow["ID"]);
                user.ClassName = dtrow["ClassName"].ToString();
                Details.Add(user);
            }
        }
        return Details.ToArray();
    }
    public class csClass
    {
        public int ClassID { get; set; }
        public string ClassName { get; set; }
    }
    [WebMethod]
    public static tblUser[] BindUser(string UserID)
    {
        string StrUserQuery = "", StrUserSubQuery = "";
        DataSet Ds = new DataSet();
        List<tblUser> Details = new List<tblUser>();
        DataUtility Objdut = new DataUtility();

        if (!String.IsNullOrEmpty(UserID) && UserID != "0") {
            StrUserSubQuery = " and userid=" + UserID;
        }

        StrUserQuery = "Select userid,UserName FROM tblUser where IsActive=1";
        StrUserQuery = StrUserQuery + StrUserSubQuery;

        Ds = Objdut.GetDataSet(StrUserQuery);
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                tblUser user = new tblUser();
                user.UserID = Convert.ToInt32(dtrow["UserID"]);
                user.UserName = dtrow["UserName"].ToString();
                Details.Add(user);
            }
        }
        return Details.ToArray();
    }

    public class tblUser {
        public int UserID { get; set; }
        public string UserName { get; set; }
    }

    [WebMethod]
    public static csFeeHead[] BindFeeHead(int ClassID, int Fyid)
    {
        DataUtility objdut = new DataUtility();
        List<csFeeHead> Details = new List<csFeeHead>();
        string StrQuery = "";
        DataTable Dt = new DataTable();
        if (ClassID < 1)
        {
            StrQuery = @"select distinct Feeid,FM.Feename from classfee_master CF
                    INNER JOIN feestructure FM on FM.id = CF.Feeid
                    where CF.status=1 and feeid > 6 and CF.fyid= " + Fyid + " and Brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + "";
        }
        else
        {
            StrQuery = @"select distinct Feeid,FM.Feename from classfee_master CF
                    INNER JOIN feestructure FM on FM.id = CF.Feeid
                    where CF.status=1 and feeid > 6 and CF.fyid= " + Fyid + " and CF.ClassID=" + ClassID + " and Brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + "";
        }
        Dt = objdut.GetDataTable(StrQuery);
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in Dt.Rows)
            {
                csFeeHead user = new csFeeHead();
                user.Feeid = Convert.ToInt32(dtrow["Feeid"]);
                user.Feename = dtrow["Feename"].ToString();
                Details.Add(user);
            }
        }
        return Details.ToArray();
    }

    public class csFeeHead {
        public int Feeid { get; set; }
        public string Feename { get; set; }
    }
    public void fillfyear()
    {
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    public static string GetFeeHeadData(int FyID, int UserID, int GroupID, int ClassID, string StartDate, string EndDate, string FeeHeadID, int paymentType)
    {       
        DataUtility objdut = new DataUtility();
        DataTable DtFee = new DataTable();
        DataTable FDtFee = new DataTable();
        DataTable dtClassWithSection = new DataTable();
        string StrQuery = "";
        DataTable DtFeeName = new DataTable();
        string HtmlBody = "";
        if (FeeHeadID == "")
        {
            StrQuery = "select id,Feename from feestructure where status=1 and Feesubtype<>0 and id>6";
        }
        else
        {
            StrQuery = "select id,Feename from feestructure where status=1 and Feesubtype<>0 and id IN(" + FeeHeadID + ")";
        }
        DtFeeName = objdut.GetDataTable(StrQuery);
        if (DtFeeName.Rows.Count > 0)
        {
            FDtFee.Columns.Add("S.No");
            FDtFee.Columns.Add("AdmissionNo");
            FDtFee.Columns.Add("Name");
            FDtFee.Columns.Add("ClassID");
            FDtFee.Columns.Add("SectionID");            
            FDtFee.Columns.Add("ReciptNo");
            FDtFee.Columns.Add("Payment Date");
            for (int p = 0; p < DtFeeName.Rows.Count; p++)
            {
                DataColumnCollection columns = FDtFee.Columns;
                if (!columns.Contains(DtFeeName.Rows[p]["Feename"].ToString()))
                {
                    FDtFee.Columns.Add(DtFeeName.Rows[p]["Feename"].ToString());
                }
            }
            FDtFee.Columns.Add("FeeMonth");
            FDtFee.Columns.Add("Fine Amt"); 
            FDtFee.Columns.Add("Total");            
            FDtFee.Columns.Add("Deposted Amt");
            FDtFee.Columns.Add("Discount");            
            FDtFee.Columns.Add("Logged in User");
            FDtFee.Columns.Add("Payment Mode");

            if (ClassID == 0)
            {
                string StrClassFee = "", strSubClassFee = "";
                if (GroupID == 1)
                {
                    strSubClassFee = " and SR.ApplyingForClass IN(66,67,68)";
                }
                else if (GroupID == 2)
                {
                    strSubClassFee = " and SR.ApplyingForClass NOT IN(66,67,68)";
                }
                //Get the class section list based on paidDate
                StrClassFee = @"Select DISTINCT SA.ClassID,SM.SectionID from tbl_StudentRegistration SR
                            inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.Brid 
                            inner join tbl_StudentAdmissionMaster SA on SM.SturegNo = SA.StuRegNo and SA.Brid = SM.Brid
                            inner join tbl_StudentAdmissionInstallment SEM on SEM.SAMID = SA.SAMID and SA.Brid = SEM.Brid-- and SEM.Fyid = SM.Fyid
                            inner join Class_Master CM on CM.id = SA.ClassID
                            inner join Receipt_master rm on rm.ASAID = SEM.ASAID
                            where SR.Brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + " and SEM.PaymentStatusId=2 "+
                            " and CAST(SEM.PaidDate as date) between '" + StartDate + "' and '" + EndDate + "' ";
                if (strSubClassFee != "")
                {
                    StrClassFee = StrClassFee + strSubClassFee;
                }

                StrClassFee = StrClassFee + @"UNION
                            Select DISTINCT SA.CurrentClassID,SA.CurrentSectionID from tbl_StudentRegistration SR
                            inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.Brid 
                            --inner join tbl_StudentAdmissionMaster SA on SM.SturegNo = SA.StuRegNo and SA.Brid = SM.Brid
							inner join Adm_StudentPromoteDtl SA on SM.SturegNo = SA.StuRegNo and SA.Brid = SM.Brid-- and SM.Fyid = SPD.PreFyid
                            inner join tbl_StudentAdmissionInstallment SEM on SEM.SturegNo = SA.SturegNo and SA.Brid = SEM.Brid
                            inner join Class_Master CM on CM.id = SA.CurrentClassID
                            inner join Receipt_master rm on rm.ASAID = SEM.ASAID
                            where SA.PreFyid=" + FyID+ " and SR.Brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + " and SEM.PaymentStatusId=2"+
                            " and CAST(SEM.PaidDate as date) between '" + StartDate + "' and '" + EndDate + "' ";
                 if (GroupID == 1)
                {

                    StrClassFee = StrClassFee + " and SA.CurrentClassID IN(40,41,42)";
                }
                else if (GroupID == 2)
                {

                    StrClassFee = StrClassFee + " and SA.CurrentClassID NOT IN(40,41,42)";
                }
                //StrClassFee = StrClassFee + " order by SA.ClassID";

                dtClassWithSection = objdut.GetDataTable(StrClassFee);
            }
            else
            {
                var dtSection = objdut.GetDataTable("Select cwsid,sectionname from classwithsection where classID=" + ClassID + "");
                if (dtSection.Rows.Count > 0)
                {
                    dtClassWithSection.Columns.Add("ClassID");
                    dtClassWithSection.Columns.Add("SectionID");
                    for (int i = 0; i < dtSection.Rows.Count; i++)
                    {
                        DataRow drF = dtClassWithSection.NewRow();
                        drF["ClassID"] = ClassID.ToString();
                        drF["SectionID"] = dtSection.Rows[i]["cwsid"].ToString();
                        dtClassWithSection.Rows.Add(drF);
                        dtClassWithSection.AcceptChanges();
                    }
                }
            }

            if (dtClassWithSection.Rows.Count > 0)
            {
                //
                int k = 0;
                for (int i = 0; i < dtClassWithSection.Rows.Count; i++)
                {
                    string strSubClassFee1 = "";
                    if (UserID > 0)
                    {
                        strSubClassFee1 = " and rm.ReceivedBy=" + UserID + "";
                    }
                    if (paymentType > 0)
                    {
                        strSubClassFee1 = strSubClassFee1 + " and SEM.PaymentModeID =" + paymentType + "";
                    }
                    string strStudent = @"Select DISTINCT DateName( month , DateAdd( month , SEM.MonthId , 0 ) - 1 ) as MonthName,ISNULL(FeeFineAmt,0) FeeFineAmt, SA.ClassID,SM.sectionid,SR.RegNewNo,SR.StudentFirstName+' '+SR.StudentMiddleName+' '+SR.StudentLastName as Name,
                            SEM.PaidDate,SEM.ReciptNo,SEM.ALLASAID,FeeDescription,tu.UserName,SEM.PaymentModeName,sem.discountoninstallment from tbl_StudentRegistration SR
                            inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.Brid 
                            inner join tbl_StudentAdmissionMaster SA on SM.SturegNo = SA.StuRegNo and SA.Brid = SM.Brid
                            inner join tbl_StudentAdmissionInstallment SEM on SEM.SAMID = SA.SAMID and SA.Brid = SEM.Brid and SEM.Fyid = sm.Fyid
                            inner join Class_Master CM on CM.id = SA.ClassID                          
                            Inner join Receipt_master rm on rm.Receiptno=SEM.ReciptNo and SEM.ASAID = rm.ASAID
                            left join tbluser tu on rm.receivedby=cast(tu.userId as varchar)
                            inner join classwithsection CWS on CWS.classid = CM.id and CWS.cwsid = SA.SectionId" +
                            " where SEM.Fyid="+FyID+" and CAST(SEM.PaidDate as date) between '" + StartDate + "' and '" + EndDate + "'" +
                            " and SR.Brid = " + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) +
                            " and SEM.PaymentStatusId=2 and SA.ClassID=" + dtClassWithSection.Rows[i]["ClassID"] + " and SM.SectionID=" + dtClassWithSection.Rows[i]["SectionID"] + "";                            
                    strStudent = strStudent + strSubClassFee1;
                    //strSubClassFee1 = " order by SA.ClassID";
                    //strStudent = strStudent + strSubClassFee1;

                    strStudent = strStudent+ @" UNION Select DISTINCT DateName(month,DateAdd(month,SEM.MonthId,0)-1) as MonthName,ISNULL(FeeFineAmt,0) FeeFineAmt,SPD.CurrentClassID,SPD.CurrentSectionID,SR.RegNewNo,SR.StudentFirstName+' '+SR.StudentMiddleName+' '+SR.StudentLastName as Name
                            ,SEM.PaidDate,SEM.ReciptNo,SEM.ALLASAID,FeeDescription,tu.UserName,SEM.PaymentModeName,sem.discountoninstallment
                            from tbl_StudentAdmissionInstallment SEM
                            inner join Adm_StudentPromoteDtl SPD on SPD.SturegNo = SEM.StuRegNo and SEM.Brid = SPD.Brid and SEM.Fyid = SPD.PreFyid
                            inner join tbl_StudentMaster SM on SM.SturegNo = SEM.StuRegNo and SM.Brid = SEM.Brid
                            inner join tbl_StudentRegistration SR on SR.RID = SM.RID and SR.Brid = SM.Brid
                            Inner join Receipt_master rm on rm.Receiptno=SEM.ReciptNo and SEM.ASAID = rm.ASAID
                            left join tbluser tu on rm.receivedby=cast(tu.userId as varchar)
                            inner join classwithsection CWS on CWS.classid = SPD.CurrentClassID and CWS.cwsid = SPD.CurrentSectionID " +
                            " where SEM.Fyid=" + FyID + " and CAST(SEM.PaidDate as date) between '" + StartDate + "' and '" + EndDate + "'" +
                            " and SR.Brid = " + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) +
                            " and SEM.PaymentStatusId=2 and SPD.CurrentClassID=" + dtClassWithSection.Rows[i]["ClassID"] + " and SPD.CurrentSectionID=" + dtClassWithSection.Rows[i]["SectionID"] + "";

                    strSubClassFee1 = "";
                    if (UserID > 0)
                    {
                        strSubClassFee1 = " and rm.ReceivedBy=" + UserID + "";
                    }
                    if (paymentType > 0)
                    {
                        strSubClassFee1 = strSubClassFee1 + " and SEM.PaymentModeID =" + paymentType + "";
                    }
                    strStudent = strStudent + strSubClassFee1;

                    var dtstrStudent = objdut.GetDataTable(strStudent);
                    if (dtstrStudent.Rows.Count > 0)
                    {
                        for (int b = 0; b < dtstrStudent.Rows.Count; b++)
                        {                            
                            double TotalByReceiptNo = 0;
                            double TotalFeeFine = 0;
                            DataRow drStuData = FDtFee.NewRow();
                            drStuData["ClassID"] = dtstrStudent.Rows[b]["ClassID"].ToString();
                            FDtFee.Rows.Add(drStuData);
                            FDtFee.AcceptChanges();
                            decimal totaldisc = 0;
                            for (int a = 7; a < FDtFee.Columns.Count - 3; a++)
                            {
                                if (FDtFee.Columns[a].ColumnName != "FeeMonth")
                                {
                                    double Amt = 0;
                                    string FStrFee = "0";
                                    DataTable dtFeeDes = new DataTable();
                                    //for (int b = 0; b < dtstrStudent.Rows.Count; b++)
                                    //{
                                    string COonFE = "";
                                    string FeemOnths = "";
                                    string[] FeeDescp;
                                    
                                    if (dtstrStudent.Rows[b]["ALLASAID"].ToString() != "")
                                    {
                                        string StrClassFee2 = @"Select SA.ClassID,SEM.ALLASAID,FeeDescription,discountoninstallment from tbl_StudentRegistration SR
                                    inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.Brid 
                                    inner join tbl_StudentAdmissionMaster SA on SM.SturegNo = SA.StuRegNo and SA.Brid = SM.Brid
                                    inner join tbl_StudentAdmissionInstallment SEM on SEM.SAMID = SA.SAMID and SA.Brid = SEM.Brid
                                    inner join Class_Master CM on CM.id = SA.ClassID
                                    where SEM.Fyid=" + FyID + " and SR.Brid=" + Convert.ToInt32(HttpContext.Current.Session["BrBrid"]) + " and SEM.PaymentStatusId=2 and SEM.ALLASAID='" + dtstrStudent.Rows[b]["ALLASAID"].ToString() + "'";
                                        dtFeeDes = objdut.GetDataTable(StrClassFee2);
                                        if (dtFeeDes.Rows.Count > 0)
                                        {
                                            for (int c = 0; c < dtFeeDes.Rows.Count; c++)
                                            {

                                                string[] ASAID;
                                                ASAID = dtFeeDes.Rows[c]["ALLASAID"].ToString().Split(',');
                                              //  decimal tempdisc = 0;
                                                decimal.TryParse(dtFeeDes.Rows[0]["discountoninstallment"].ToString(), out totaldisc);
                                              //  totaldisc = tempdisc + totaldisc;
                                                for (int l = 0; l < ASAID.Length; l++)
                                                {
                                                    DataTable dtCOonFE1 = new DataTable();
                                                    dtCOonFE1 = objdut.GetDataTable("Select DateName( month , DateAdd( month , monthID , -1 ) ) as MonthName, FeeDescription from tbl_StudentAdmissionInstallment where ASAID=" + ASAID[l] + "");

                                                    if (dtCOonFE1.Rows.Count > 0)
                                                    {
                                                        var FeeDesc = dtCOonFE1.Rows[0]["FeeDescription"].ToString();
                                                        var MName = dtCOonFE1.Rows[0]["MonthName"].ToString();
                                                        
                                                        if (String.IsNullOrEmpty(COonFE))
                                                        {
                                                            COonFE = FeeDesc;
                                                        }
                                                        else
                                                        {
                                                            COonFE = COonFE + "~" + FeeDesc.ToString();
                                                        }
                                                        if (String.IsNullOrEmpty(FeemOnths))
                                                        {
                                                            FeemOnths = MName.ToString();
                                                        }
                                                        else
                                                        {
                                                            FeemOnths = FeemOnths + "," + MName.ToString();
                                                        }
                                                    }
                                                }

                                            }
                                        }
                                    }
                                    else
                                    {
                                        COonFE = dtstrStudent.Rows[b]["FeeDescription"].ToString();
                                        FeemOnths = dtstrStudent.Rows[b]["MonthName"].ToString();
                                        decimal.TryParse(dtstrStudent.Rows[b]["discountoninstallment"].ToString(), out totaldisc);
                                    }

                                    FDtFee.Rows[k]["FeeMonth"] = FeemOnths.ToString();

                                    string[] FeeAmount;
                                    FeeDescp = COonFE.ToString().Split('~');
                                    for (int l = 0; l < FeeDescp.Length; l++)
                                    {
                                        FeeAmount = FeeDescp[l].ToString().Split(':');
                                        if (FDtFee.Columns[a].ToString().Trim() == FeeAmount[0].ToString().Trim())
                                        {
                                            //Particular Fee Amount
                                            Amt = Convert.ToDouble(FeeAmount[1]);
                                            TotalByReceiptNo = TotalByReceiptNo + Amt;
                                            if (Amt.ToString() == "")
                                            {
                                                Amt = 0;
                                            }
                                            if (FDtFee.Rows[k][a].ToString() == "")
                                            {
                                                FDtFee.Rows[k][a] = "0";
                                            }
                                            FDtFee.Rows[k][a] = (Convert.ToDouble(FDtFee.Rows[k][a]) + Amt).ToString();
                                            FDtFee.AcceptChanges();
                                        }
                                    }
                                }
                            }

                            FDtFee.Rows[k]["S.No"] = (k + 1).ToString();
                            FDtFee.Rows[k]["SectionID"] = dtstrStudent.Rows[b]["SectionID"].ToString();
                            FDtFee.Rows[k]["AdmissionNo"] = dtstrStudent.Rows[b]["RegNewNo"].ToString();
                            FDtFee.Rows[k]["Name"] = dtstrStudent.Rows[b]["Name"].ToString();                            
                            FDtFee.Rows[k]["ReciptNo"] = dtstrStudent.Rows[b]["ReciptNo"].ToString();
                            FDtFee.Rows[k]["Payment Date"] = Convert.ToDateTime(dtstrStudent.Rows[b]["PaidDate"]).ToString("dd MMM yy");

                            TotalFeeFine = Convert.ToDouble(dtstrStudent.Rows[b]["FeeFineAmt"].ToString()); 
                            FDtFee.Rows[k]["Fine Amt"] = TotalFeeFine.ToString();
                            FDtFee.Rows[k]["Total"] = (TotalByReceiptNo + TotalFeeFine).ToString();                            
                            TotalByReceiptNo = (TotalByReceiptNo+ TotalFeeFine) - Convert.ToDouble(totaldisc);
                            
                            FDtFee.Rows[k]["Deposted Amt"] = TotalByReceiptNo.ToString();
                            FDtFee.Rows[k]["Logged in User"] = dtstrStudent.Rows[b]["UserName"].ToString();
                            FDtFee.Rows[k]["Discount"] = totaldisc;

                            var paymentMode = "";

                            if (dtstrStudent.Rows[b]["PaymentModeName"].ToString().ToLower() != "case")
                            {
                                paymentMode = dtstrStudent.Rows[b]["PaymentModeName"].ToString();
                            }
                            else {
                                paymentMode = "Cash";
                            }

                            FDtFee.Rows[k]["Payment Mode"] = paymentMode.ToString();
                            FDtFee.AcceptChanges();
                            k = k + 1;
                        }
                    }
                }
                DataTable distinctTable = FDtFee.DefaultView.ToTable( /*distinct*/ true);
                DataRow drStuData1 = FDtFee.NewRow();
                FDtFee.Rows.Add(drStuData1);
                FDtFee.AcceptChanges();
                for (int a = 7; a < FDtFee.Columns.Count - 2; a++)
                {
                    decimal Total = 0;
                    for (int n = 0; n < FDtFee.Rows.Count - 1; n++)
                    {
                        decimal Amount = 0;
                        string colName = FDtFee.Columns[a].ColumnName.ToString();
                        if (colName != "FeeMonth")
                        {
                            if (FDtFee.Rows[n][colName].ToString() == "")
                            {
                                FDtFee.Rows[n][colName] = "0";
                            }
                            Amount = Convert.ToDecimal(FDtFee.Rows[n][colName]);

                            Total = Total + Amount;
                            FDtFee.Rows[FDtFee.Rows.Count - 1][FDtFee.Columns[a]] = Total.ToString();
                            FDtFee.AcceptChanges();
                        }
                    }
                }
                if (FDtFee.Rows.Count > 0)
                {
                    foreach (DataRow dr1 in FDtFee.Rows)
                    {
                        string classID = dr1["ClassID"].ToString();
                        string SectionID = dr1["SectionID"].ToString();
                        if (classID != "")
                        {
                            if (classID != "0")
                            {
                                if (classID != "Total")
                                {
                                    if (classID != "GTotal")
                                    {
                                        dr1["ClassID"] = Convert.ToString(objdut.GetScalar("Select Classname from Class_Master where id=" + classID + ""));
                                        dr1["SectionID"] = Convert.ToString(objdut.GetScalar("Select sectionname from classwithsection where cwsid=" + SectionID + ""));
                                    }
                                }
                            }
                        }

                    }
                    //Session["FDtFee"] = FDtFee;
                    //Button1.Visible = true;

                    HtmlBody = ExportDatatableToHtml(FDtFee);
                }
            }
        }
        return HtmlBody;
    }
    protected static string ExportDatatableToHtml(DataTable dt)
    {
        StringBuilder strHTMLBuilder = new StringBuilder();
        if (dt.Rows.Count > 0)
        {            
            strHTMLBuilder.Append("<table width='100%' table class='stm' cellpadding='0' cellspacing='0'>");

            strHTMLBuilder.Append("<tr class='stm_head' align='center'>");
            foreach (DataColumn myColumn in dt.Columns)
            {
                strHTMLBuilder.Append("<td align='center' scope='col'>");
                strHTMLBuilder.Append(myColumn.ColumnName);
                strHTMLBuilder.Append("</td>");

            }
            strHTMLBuilder.Append("</tr>");


            foreach (DataRow myRow in dt.Rows)
            {

                strHTMLBuilder.Append("<tr >");
                foreach (DataColumn myColumn in dt.Columns)
                {
                    strHTMLBuilder.Append("<td style='font-size: 12px; border: solid 1px;'>");
                    strHTMLBuilder.Append(myRow[myColumn.ColumnName].ToString());
                    strHTMLBuilder.Append("</td>");

                }
                strHTMLBuilder.Append("</tr>");
            }

            //Close tags.  
            strHTMLBuilder.Append("</table>");
            //strHTMLBuilder.Append("</body>");
            //strHTMLBuilder.Append("</html>");
        }
        string Htmltext = strHTMLBuilder.ToString();

        return Htmltext;

    } 
    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        Div1.Visible = true;
      //  divUsers.Visible = false;
    }

    protected void ddlGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
}