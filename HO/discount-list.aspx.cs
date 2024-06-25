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
    private CommonClass CommonClass = new CommonClass();
    DataUtility obj = new DataUtility();
    private DataUtility objdut = new DataUtility();
    private DataTable Dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillfyear();
            FillUSERDDL();
        }    
    }
    protected void FillUSERDDL()
    {
        string Query = "Select userid,UserName from tbluser where isActive=1 and isDeleted=0 and AssociatedToID=101 order by userid asc ";
        Dt = objdut.GetDataTable(Query);
        ddldiscountgivenbyuser.DataSource = Dt;
        ddldiscountgivenbyuser.DataTextField = "UserName";
        ddldiscountgivenbyuser.DataValueField = "userid";
        ddldiscountgivenbyuser.DataBind();
        ddldiscountgivenbyuser.Items.Insert(0, new ListItem("Given By", "0"));
        Dt.Dispose();
    }
    public void fillfyear()
    {
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfyear.DataSource = Dt;
        ddlfyear.DataValueField = "fyid";
        ddlfyear.DataTextField = "FYName";
        ddlfyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
        DataTable dt = new DataTable();
        dt = obj.GetDataTable("select Brid,BrName from Branch_master where BrActive=1 and isDeleted=0 and isActive=1");
        if (dt.Rows.Count > 0)
        {
            ddlbranch.DataSource = dt;
            ddlbranch.DataValueField = "Brid";
            ddlbranch.DataTextField = "BrName";
            ddlbranch.DataBind();
        }   
    }
    [WebMethod]
    public static studentregistration[] BindGridByJs(string Fromdate,int BrId, string Todate, string Registrationnumber, string StudentName, string Parentname, string Discountcode, string ParentMobileNo, int Applyingforclass, int Fyid, int discountgivenbyuser, string pagesize, string pageno)
    {    
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
                param[1] = new SqlParameter("@Brid", BrId);
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
        public string pagecount { get; set; }
    }
    [WebMethod]
    public static studentdiscount[] BindGridByJsfordiscountdetail(string discountcode)
    {

        DataSet ds = new DataSet();
        List<studentdiscount> details = new List<studentdiscount>();


        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_studentdiscountlist]", con))
            {
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
                            studentdiscount user = new studentdiscount();
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
       int result=objdut.ExecuteSqlSP(param, "usp_studentdiscountlist");
       return result;
    }
     [WebMethod]
     public static BIndClass[] BindClassDDL(string Fyid, string BrId)
     {
         DataTable Dt;
         Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(Fyid), Convert.ToInt32(BrId));
         List<BIndClass> BindObj = new List<BIndClass>();
         for (int i = 0; i < Dt.Rows.Count; i++)
         {
             BIndClass Obj = new BIndClass();
             Obj.ID = Dt.Rows[i]["classid"].ToString();
             Obj.ClassName = Dt.Rows[i]["Classname"].ToString();
             BindObj.Add(Obj);
         }
         return BindObj.ToArray();
     }
     public class BIndClass
     {
         public string ID { get; set; }
         public string ClassName { get; set; }
     }


}