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

public partial class BranchPanel_Fee_Management_AddLastYearFee : System.Web.UI.Page
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
    public void BindParentType()
    {
        CommonClass CommonClass = new CommonClass();
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetParentType");
        if (Dt.Rows.Count > 0)
        {
            ddlparenttype.DataSource = Dt;
            ddlparenttype.DataTextField = "Relation";
            ddlparenttype.DataValueField = "Id";
            ddlparenttype.DataBind();
            ListItem li = new ListItem("--Select Parent Type--", "0");
            ddlparenttype.Items.Insert(0, li);
            Dt.Dispose();
        }
    }
    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlregistrationsession.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlregistrationsession.DataValueField = "Fyid";
        ddlregistrationsession.DataTextField = "FYName";
        ddlregistrationsession.DataBind();
        ddlregistrationsession.Items.Insert(0, new ListItem("--Select Session--", "0"));

        ddlFyid.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlFyid.DataValueField = "Fyid";
        ddlFyid.DataTextField = "FYName";
        ddlFyid.DataBind();
        ddlFyid.Items.Insert(0, new ListItem("--Select Session--", "0"));
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlregistrationsession.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    public static string FeeBal(string Samid, string AdmissionNo, string Fyid)
    {
        string strFeeBal = "0";
        string strPaid = "0";
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("Select ISNULL(Sum(FeeAmount),0) AS FeeAmount from tbl_LastYearPayDT where Samid=" + Samid + " and AdmissionNo='" + AdmissionNo + "' and Fyid=" + Fyid + "", con))
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

            using (SqlCommand cmd = new SqlCommand("Select ISNULL(Sum(FeeAmount),0) AS FeeAmount from tbl_LastYearFee where Samid=" + Samid + " and AdmissionNo='" + AdmissionNo + "' and Fyid=" + Fyid + "", con))
            {
                con.Open();
                cmd.CommandType = CommandType.Text;
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    strFeeBal = dr["FeeAmount"].ToString();
                }
                con.Close();
            }
        }
        return (Convert.ToDecimal(strFeeBal) - Convert.ToDecimal(strPaid)).ToString();
    }
    public static string PayStatus1(string Samid, string AdmissionNo, string Fyid)
    {
        string strFee = "0";
        string strPaid = "0";
        string StrQuery = @"Select Samid,Registration_No,FeeAmount,SUm(PaidAmount) as PaidAmt from tbl_LastYearPayDT" +
                           " where Samid=" + Samid + " and AdmissionNo='" + AdmissionNo + "' and Brid=" + HttpContext.Current.Session["BrBrid"].ToString() +
                           " and Fyid=" + Fyid + " Group by Samid,Registration_No,FeeAmount";

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand(StrQuery, con))
            {
                con.Open();
                cmd.CommandType = CommandType.Text;
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    strPaid = dr["FeeAmount"].ToString();
                    strFee = dr["PaidAmt"].ToString();
                }
                con.Close();
            }
        }
        return (Convert.ToDecimal(strFee) - Convert.ToDecimal(strPaid)).ToString();
    }
    [WebMethod]
    public static studentregistration2[] BindGridByJs(string Samid, string Mode, string Fyid)
    {
        DataSet ds = new DataSet();
        List<studentregistration2> details = new List<studentregistration2>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_StudentLastYearFee]", con))
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
                param[9] = new SqlParameter("@applyingforclass", 0);
                param[10] = new SqlParameter("@Fyid", Fyid);
                param[11] = new SqlParameter("@AdmissionNo", "");
                param[12] = new SqlParameter("@pagesize", 1);
                param[13] = new SqlParameter("@pageno", 0);
                param[14] = new SqlParameter("@SectionID", 0);
                param[15] = new SqlParameter("@intresult", Convert.ToInt32("0"));
                param[15].Direction = ParameterDirection.Output;
                param[16] = new SqlParameter("@Samid", Samid);
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
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        DataUtility Objdut = new DataUtility();
                        foreach (DataRow dtrow in ds.Tables[0].Rows)
                        {
                            studentregistration2 user = new studentregistration2();
                            user.Samid = dtrow["Samid"].ToString();
                            user.Fyid = dtrow["Fyid"].ToString();
                            user.RegistrationDate = Convert.ToDateTime(dtrow["RegistrationDate"]).ToString("dd MMM yyyy");
                            user.Registration_No = dtrow["Registration_No"].ToString();
                            user.AdmissionNo = dtrow["AdmissionNo"].ToString();
                            user.studentFname = dtrow["StudentFirstName"].ToString();
                            user.studentMname = dtrow["StudentMiddleName"].ToString();
                            user.studentLname = dtrow["StudentLastName"].ToString();
                            user.ClassID = dtrow["ApplyingForClass"].ToString();
                            user.SectionID = dtrow["SectionID"].ToString();
                            user.Classname = (string)(Objdut.GetScalar("Select ISNULL(Classname,'') from Class_Master where id=" + dtrow["ApplyingForClass"].ToString() + ""));
                            user.FeeAmount = dtrow["FeeAmount"].ToString();
                            user.fatherFname = dtrow["PrimaryParentFirstName"].ToString();
                            user.fatherMname = dtrow["PrimaryParentMiddleName"].ToString();
                            user.fatherLname = dtrow["PrimaryParentLastName"].ToString();
                            user.PrimaryMobileNo = dtrow["PrimaryMobileNo"].ToString();
                            user.Sectionname = (string)(Objdut.GetScalar("Select ISNULL(sectionname,'') from classwithsection where cwsid=" + dtrow["SectionID"].ToString() + ""));
                            //user.DOB = Convert.ToDateTime(dtrow["StudentDOB"]).ToString("dd MMM yyyy");
                            //user.StudentUID = dtrow["StudentUID"].ToString();
                            //user.Address = dtrow["Address"].ToString();
                            //user.City = dtrow["City"].ToString();
                            //user.State = dtrow["State"].ToString();
                            //user.Pin = dtrow["Pin"].ToString();
                            //user.Country = dtrow["Country"].ToString();
                            //user.PrimarySelectParentType = dtrow["PrimarySelectParentType"].ToString();
                            //user.PrimaryParentDOB = dtrow["PrimaryParentDOB"].ToString();
                            //user.PrimaryParentOccupation = dtrow["PrimaryParentOccupation"].ToString();
                            //user.PrimaryEmailId = dtrow["PrimaryEmailId"].ToString();
                            //user.Comment = dtrow["Comment"].ToString();
                            user.PaidFee = FeeBal(dtrow["Samid"].ToString(), dtrow["AdmissionNo"].ToString(), dtrow["Fyid"].ToString());
                            string PayStatus = "0";
                            PayStatus = Convert.ToString(PayStatus1(dtrow["Samid"].ToString(), dtrow["AdmissionNo"].ToString(), dtrow["Fyid"].ToString()));
                            if (PayStatus == "0")
                            {
                                user.PayStatus = "Paid";
                            }
                            else
                            {
                                user.PayStatus = "Unpaid";
                            }
                            //user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString();
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
        public string SAMID { get; set; }
        public string Fyid { get; set; }
        public string AdmissionDate { get; set; }
        public string AdmissionNo { get; set; }
        public string RefAdmNo { get; set; }
        public string Samid { get; set; }
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
        public string PaidFee { get; set; }

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
    protected void btnforupdateorsave_Click(object sender, EventArgs e)
    {
        IdStudent = Convert.ToInt16(Objdut.GetScalar("select Isnull(MAX(Samid),0)+1 from tbl_LastYearFee where Brid=" + Convert.ToInt16(Session["BrBrid"])));
        SqlParameter[] Param = new SqlParameter[33];
        Param[00] = new SqlParameter("@Brid", Convert.ToInt32(Session["BrBrid"]));
        Param[01] = new SqlParameter("@Fyid", ddlregistrationsession.SelectedValue);
        Param[02] = new SqlParameter("@Registration_No", txtRegNo.Text.Trim());
        Param[03] = new SqlParameter("@AdmissionNo", txtAdmNo.Text.Trim());
        Param[04] = new SqlParameter("@Samid", IdStudent);
        Param[05] = new SqlParameter("@FeeAmount", txtAmount.Text.Trim());
        Param[06] = new SqlParameter("@StudentFirstName", txtstudentfirstname.Text.Trim());
        Param[07] = new SqlParameter("@StudentMiddleName", txtstudentMiddlename.Text.Trim());
        Param[08] = new SqlParameter("@StudentLastName", txtstudentlastname.Text.Trim());
        Param[09] = new SqlParameter("@StudentDOB", txtstudentdob.Text.Trim());
        Param[10] = new SqlParameter("@Gender", rbtnlistgender.SelectedValue);
        Param[11] = new SqlParameter("@CountryName", txtcountryname.Text.Trim());
        Param[12] = new SqlParameter("@Religion", txtreligion.Text.Trim());
        Param[13] = new SqlParameter("@CastCategoryId", rbtnlistcast.SelectedValue);
        Param[14] = new SqlParameter("@CastCategoryName", rbtnlistcast.SelectedItem.Text.Trim());
        Param[15] = new SqlParameter("@ApplyingForClass", Request.Form[ddlapplyingforclass.UniqueID]);
        Param[16] = new SqlParameter("@Section_Id", Request.Form[ddlsection.UniqueID]);
        if (fileuploaderofstudentphotograph.HasFile)
        {
            string FileName = Convert.ToString(IdStudent) + fileuploaderofstudentphotograph.FileName;
            fileuploaderofstudentphotograph.PostedFile.SaveAs(Server.MapPath("~/BranchPanel/Student-Registration/student-registration-document/" + FileName));
            Param[17] = new SqlParameter("@StudentPhotograph", FileName);
        }
        else
        {
            Param[17] = new SqlParameter("@StudentPhotograph", "");
        }
        Param[18] = new SqlParameter("@Address", txtaddress.InnerText.Trim());
        Param[19] = new SqlParameter("@City", txtcity.Text.Trim());
        Param[20] = new SqlParameter("@State", txtstate.Text.Trim());
        Param[21] = new SqlParameter("@Pin", txtpiorzipcode.Text.Trim());      
        Param[22] = new SqlParameter("@PrimarySelectParentType", Request.Form[ddlparenttype.UniqueID]);
        Param[23] = new SqlParameter("@PrimaryParentFirstName", txtparentfirstname.Text.Trim());
        Param[24] = new SqlParameter("@PrimaryParentMiddleName", txtparentmiddlename.Text.Trim());
        Param[25] = new SqlParameter("@PrimaryParentLastName", txtparentlastname.Text.Trim());
        Param[26] = new SqlParameter("@PrimaryParentOccupation", txtparentoccupation.Text.Trim());
        Param[27] = new SqlParameter("@PrimaryMobileNo", txtparentmobileno.Text.Trim());
        Param[28] = new SqlParameter("@PrimaryEmailId", txtEmailID.Text.Trim()); 
        Param[29] = new SqlParameter("@StudentUID", txtstudentUid.Text.Trim());
        Param[30] = new SqlParameter("@intresult", Convert.ToInt32("0"));
        Param[30].Direction = ParameterDirection.Output;
        Param[31] = new SqlParameter("@Mode", Convert.ToInt32(1));
        if (Convert.ToInt32(fdSamid.Value) > 0)
        {
            Param[32] = new SqlParameter("@UpdateID", Convert.ToInt32(1));
        }
        else
        {
            Param[32] = new SqlParameter("@UpdateID", Convert.ToInt32(0));
        }
        int intresult = Objdut.ExecuteSqlSP(Param, "[usp_StudentLastYearFee]");
        if (intresult == 1)
        {
            Utility.ViewAlertMessage(this, "Data Insert Successfully");
        }
        else if (intresult == 2)
        {
            Utility.ViewAlertMessage(this, "Data Update Successfully");
        }
        else if (intresult == 4)
        {
            Utility.ViewAlertMessage(this, "Data Already Exists");
        }
        else
        {
            Utility.ViewAlertMessage(this, "Registration and Admission Already Exists");
        }
    }
}