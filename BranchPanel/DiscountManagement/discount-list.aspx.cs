using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Services;
using System.IO;
using System.Web.UI.WebControls;

public partial class BranchPanel_DiscountManagement_discount_list : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable Dt;   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindSessionDDL();
            FillUSERDDL(); 
        } 
    }
    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlfyear.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlfyear.DataValueField = "Fyid";
        ddlfyear.DataTextField = "FYName";
        ddlfyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    
    protected void FillUSERDDL()
    {
        DataTable NewDt = new DataTable();
        NewDt.Columns.Add("userid");
        NewDt.Columns.Add("UserName");

        string Query = "Select userid,UserName,CreatedByID from tbluser where isActive=1 and isDeleted=0 and AssociatedToID=101 order by userid asc ";
        Dt = objdut.GetDataTable(Query);
        string UserID = "";
        if (Dt.Rows.Count > 0)
        {
            string BranchNAme = objdut.GetScalar("Select ISNULL(BrCode,'') Code from Branch_master where BrId=" + System.Web.HttpContext.Current.Session["BrBrid"].ToString() + "").ToString();
            if (BranchNAme != "")
            {
                UserID = objdut.GetScalar("Select ISNULL(userid,0) UserID from tbluser where UserName='" + BranchNAme + "'").ToString();
                ddldiscountgivenbyuser.SelectedValue = UserID.ToString();

                DataRow[] dr = Dt.Select("userid = " + UserID + "");
                if (dr.Length > 0)
                {
                    DataRow drNewdt = NewDt.NewRow();
                    drNewdt["userid"] = dr[0][0].ToString();
                    drNewdt["UserName"] = dr[0][1].ToString();
                    NewDt.Rows.Add(drNewdt);
                }

                DataRow[] dr1 = Dt.Select("CreatedByID = " + UserID + "");
                if (dr1.Length > 0)
                {
                    for (int i = 0; i < dr1.Length; i++)
                    {
                        DataRow drNewdt1 = NewDt.NewRow();
                        drNewdt1["userid"] = dr1[i][0].ToString();
                        drNewdt1["UserName"] = dr1[i][1].ToString();
                        NewDt.Rows.Add(drNewdt1);
                    }
                }
                if (NewDt.Rows.Count > 0)
                {
                    ddldiscountgivenbyuser.DataSource = NewDt;
                    ddldiscountgivenbyuser.DataTextField = "UserName";
                    ddldiscountgivenbyuser.DataValueField = "userid";
                    ddldiscountgivenbyuser.DataBind();
                    ddldiscountgivenbyuser.Items.Insert(0, new ListItem("Given By", "0"));
                }
            }
        }

        
        Dt.Dispose();
    }
    [WebMethod]
    public static studentregistration[] BindGridByJs(int SectionID, string Fromdate, string Todate, string Registrationnumber, string StudentName, string Parentname, string Discountcode, string ParentMobileNo, int Applyingforclass, int Fyid, int discountgivenbyuser, string pagesize, string pageno)
    {
        DataUtility objdut = new DataUtility();
        System.Web.HttpContext.Current.Session["BrRegistrationNoBrid"] = Registrationnumber.ToString();
        DataSet ds = new DataSet();
        List<studentregistration> details = new List<studentregistration>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_studentdiscountlist]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[14];

                param[0] = new SqlParameter("@mode", 1);
                param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
                param[2] = new SqlParameter("@FromDate", Fromdate);
                param[3] = new SqlParameter("@ToDate", Todate);
                param[4] = new SqlParameter("@registrationno", Registrationnumber);
                param[5] = new SqlParameter("@Studentname", StudentName);
                param[6] = new SqlParameter("@Parentname", Parentname);
                param[7] = new SqlParameter("@discountcode", Discountcode);
                param[8] = new SqlParameter("@ParentMobileNo", ParentMobileNo);
                param[9] = new SqlParameter("@applyingforclass", Applyingforclass);
                param[10] = new SqlParameter("@Fyid", Fyid);
                param[11] = new SqlParameter("@discountgivenbyuser", discountgivenbyuser);
                param[12] = new SqlParameter("@pagesize", pagesize);
                param[13] = new SqlParameter("@pageno", pageno);
				
               
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
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dtrow in ds.Tables[0].Rows)
                        {
                            studentregistration user = new studentregistration();
                            user.DSID = dtrow["DSID"].ToString();
                            user.DiscountCode = dtrow["DiscountCode"].ToString();
                            user.RegistrationNo = dtrow["Registration_No"].ToString();
                            user.StudentName = dtrow["studentname"].ToString();
                            user.ApplyClass = dtrow["Classname"].ToString();
                            user.ParentName = dtrow["parentname"].ToString();
                            user.Parentmobile = dtrow["PMobileNo"].ToString();
                            user.Comment_Remark = dtrow["CommentORRemark"].ToString();
                            user.IsDiscountImplemented = dtrow["IsDiscountImplemented"].ToString();
                            string UserID = dtrow["GivenBy"].ToString();
                            string str = "Select ISNULL(UserName,'N/A') UserName from tbluser where UserID=" + UserID.ToString() + "";
                            string USerName="";
                            if (objdut.GetScalar(str) == null)
                            {
                                USerName = "N/A";
                            }
                            else
                            {
                                USerName = objdut.GetScalar(str).ToString();
                            }
                            user.discountgivenbyuser = USerName.ToString();
                            user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString(); 
                            details.Add(user);
                        }
                    }
                }
            }
        }
        return details.ToArray();
    }
    public class studentregistration
    {
        public string DSID { get; set; }
        public string DiscountCode { get; set; }
        public string RegistrationNo { get; set; }
        public string StudentName { get; set; }
        public string ApplyClass { get; set; }
        public string ParentName { get; set; }
        public string Parentmobile { get; set; }
        public string Discount { get; set; }
        public string Comment_Remark { get; set; }
        public string IsDiscountImplemented { get; set; }
        public string discountgivenbyuser { get; set; }
        public string pagecount { get; set; }
    }
    [WebMethod]
    public static studentdiscount[] BindGridByJsfordiscountdetail(string discountcode)
    {
        DataUtility objdut = new DataUtility();
        DataSet ds = new DataSet();
        List<studentdiscount> details = new List<studentdiscount>();


        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_studentdiscountlist]", con))
            {
                decimal ActualFeeBeforeDiscount = 0;
                decimal TotalDiscount = 0;
                decimal ActualFeeAfterDiscount = 0;
                studentdiscount user;
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[2];

                param[0] = new SqlParameter("@mode", 2);
             
                param[1] = new SqlParameter("@discountcode", discountcode);
               
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
               
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dtrow in ds.Tables[0].Rows)
                        {
                            user = new studentdiscount();
                            user.FeeCategoryName = dtrow["FeeCategoryName"].ToString();
                            user.FeeHeadName = dtrow["FeeHeadName"].ToString();
                            user.DiscountTypeName = dtrow["DiscountTypeName"].ToString();
                            user.DiscountInMonthName = dtrow["DiscountInMonthName"].ToString();
                            user.ActualFeeBeforeDiscount = dtrow["ActualFeeBeforeDiscount"].ToString();
                            user.Discount1 = dtrow["Discount"].ToString();
                            user.FeeAfterDiscount = dtrow["FeeAfterDiscount"].ToString();
                            user.studentname = dtrow["studentname"].ToString();

                            details.Add(user);
                        }
                    }

                    string StrActual="";
                    StrActual = "Select isnull(Sum(T1.TotalFee),0) Fees From Classfee_master T1 " +
                                        " Left Outer Join feestructure T2  On T2.id=T1.Feeid And T1.fyid=" + ds.Tables[0].Rows[0]["Fyid"] + "" +
                                        " Join  Feestructure T3 On T2.Feesubtype=T3.id  where Brid=" + Convert.ToInt32(ds.Tables[0].Rows[0]["Brid"]) + " and Classid=" + ds.Tables[0].Rows[0]["ClassId"] + "" +
                                        " And T1.status=1 and T1.Feeid <> 6";

                    ActualFeeBeforeDiscount = Convert.ToDecimal(objdut.GetScalar(StrActual));
                     user = new studentdiscount();

                     TotalDiscount = Convert.ToDecimal(objdut.GetScalar("Select isnull(SUM(Discount),0) Discount from Discount_student_master DM " +
                                        " inner join DiscountedStudent_Info DI on DM.DiscountCode = DI.DiscountCode "+
                                        " where DM.DiscountCode = " + discountcode + " and DI.Brid=" + Convert.ToInt32(ds.Tables[0].Rows[0]["Brid"]) + " and DI.Classid=" + ds.Tables[0].Rows[0]["ClassId"] + "" +
                                         " And DI.Fyid=" + Convert.ToInt32(ds.Tables[0].Rows[0]["Fyid"]) + ""));
                    
                     user = new studentdiscount();
                     
                    user.ActualFeeBeforeDiscount = (ActualFeeBeforeDiscount).ToString();                   
                    user.Discount1 = TotalDiscount.ToString();
                    details.Add(user);
                }
            }
        }
        return details.ToArray();
    }
    public class studentdiscount
    {
        
        public string FeeCategoryName { get; set; }
        public string FeeHeadName { get; set; }
        public string DiscountTypeName { get; set; }
        public string DiscountInMonthName { get; set; }
        public string ActualFeeBeforeDiscount { get; set; }        
        public string Discount1 { get; set; }
        public string FeeAfterDiscount { get; set; }       
        public string studentname { get; set; }       
    }
     [WebMethod]
    public static int Deletediscount(int discountid)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
        param[2] = new SqlParameter("@discountid", discountid);
        param[3] = new SqlParameter("@intresult", Convert.ToInt32("0"));
        param[3].Direction = ParameterDirection.Output;
        //param[4] = new SqlParameter("@registrationno", Convert.ToString(System.Web.HttpContext.Current.Session["RegistrationNo"]));
       int result=objdut.ExecuteSqlSP(param, "usp_studentdiscountlist");
       return result;
    }


}