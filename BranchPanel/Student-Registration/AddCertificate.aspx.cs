using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Services;
using System.IO;
using System.Web.UI.WebControls;
using System.Web;
using ClosedXML.Excel;

public partial class BranchPanel_Student_Registration_AddCertificate : System.Web.UI.Page
{
    private int IdStudent = 0;
    private DataUtility Objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["RID"] != null)
        {
            if (!IsPostBack)
            {
                BindAllDDLOfPage();
                FillDetails(Convert.ToInt32(Request.QueryString["RID"]));
                txtTCNo.Text = "TC" + txtadmissionreferenceno.Text.Trim();
            }
           // txtTCNo.Text = "TC" + txtadmissionreferenceno.Text.Trim();
        }
    }
    [WebMethod]
    public static List<GetPermittedCheckBoxForCheck> CheckCheckboxOnTheBehalfOfPermission()
    {
        DataTable Dt;
        DataUtility Objdut = new DataUtility();
        List<GetPermittedCheckBoxForCheck> Details = new List<GetPermittedCheckBoxForCheck>();
        using (Dt = Objdut.GetDataTable("Select Field_Id_Or_Name,(Case When Isactive=1 Then 'block' Else 'none' End)As Status from tbl_registrationsettings where Status=1"))
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                GetPermittedCheckBoxForCheck obje = new GetPermittedCheckBoxForCheck();
                obje.DivName = Convert.ToString(Dt.Rows[i]["Field_Id_Or_Name"]);
                obje.Displaystatus = Convert.ToString(Dt.Rows[i]["Status"]);
                Details.Add(obje);
            }
        }
        return Details;
    }
    public class GetPermittedCheckBoxForCheck
    {
        public string DivName { get; set; }

        public string Displaystatus { get; set; }
    }
    protected void btnforupdateorsave_Click(object sender, EventArgs e)
    {
        Session["dtTC"] = null;
        DataTable dtTC = new DataTable();
        dtTC.Columns.Add("BookNo");
        dtTC.Columns.Add("OldRegNo");
        dtTC.Columns.Add("TCNo");
        dtTC.Columns.Add("AdmNo");
        dtTC.Columns.Add("StdRegNo");
        dtTC.Columns.Add("SdtName");
        dtTC.Columns.Add("Mname");
        dtTC.Columns.Add("Fname");
        dtTC.Columns.Add("Dob");
        dtTC.Columns.Add("Nation");
        dtTC.Columns.Add("Gen");
        dtTC.Columns.Add("Doa");
        dtTC.Columns.Add("Pclass");
        dtTC.Columns.Add("PSBoard");
        dtTC.Columns.Add("FailClass");
        dtTC.Columns.Add("ProClass");
        dtTC.Columns.Add("Subject");
        dtTC.Columns.Add("MonthPaid");
        dtTC.Columns.Add("Conces");
        dtTC.Columns.Add("Tdays");
        dtTC.Columns.Add("Pdays");
        dtTC.Columns.Add("NCC");
        dtTC.Columns.Add("Games");
        dtTC.Columns.Add("Conduct");
        dtTC.Columns.Add("Dor");
        dtTC.Columns.Add("Doi");
        dtTC.Columns.Add("leave");
        dtTC.Columns.Add("remarks");

        DataRow dr = dtTC.NewRow();

        dr["BookNo"] = txtBookNo.Text.Trim();
        dr["OldRegNo"] = txtOldRegNo.Text.Trim();
        dr["StdRegNo"] = txtregistrationno.Text.Trim();

        dr["TCNo"] = txtTCNo.Text.Trim();

        if (txtadmissionreferenceno.Text.Trim() != "")
        {
            dr["AdmNo"] = txtadmissionreferenceno.Text.Trim();
        }
        else 
        {
            dr["AdmNo"] = ".";
        }

        if (txtadmissionreferenceno.Text.Trim() != "")
        {
            dr["AdmNo"] = txtadmissionreferenceno.Text.Trim();
        }
        else 
        {
            dr["AdmNo"] = ".";
        }

        if (txtstudentfirstname.Text.Trim() != "")
        {
            dr["SdtName"] = txtstudentfirstname.Text.Trim();
        }
        else
        {
            dr["SdtName"] = ".";
        }

        if (txtsecondaryparentfirstname.Text.Trim() != "")
        {
            dr["Mname"] = txtsecondaryparentfirstname.Text.Trim();
        }
        else
        {
            dr["Mname"] = ".";
        }

        if (txtparentfirstname.Text.Trim() != "")
        {
            dr["Fname"] = txtparentfirstname.Text.Trim();
        }
        else
        {
            dr["Fname"] = ".";
        }

        if (txtstudentdob.Text.Trim() != "")
        {
            dr["Dob"] = txtstudentdob.Text.Trim();
        }
        else
        {
            dr["Dob"] = ".";
        }

        if (rbtnlistnationality.SelectedItem.Text.Trim() != "")
        {
            dr["Nation"] = rbtnlistnationality.SelectedItem.Text.Trim();
        }
        else
        {
            dr["Nation"] =".";
        }

        if (rbtnlistnationality.SelectedItem.Text.Trim() != "")
        {
            dr["Nation"] = rbtnlistnationality.SelectedItem.Text.Trim();
        }
        else 
        {
            dr["Nation"] = ".";
        }


        if (rbtnlistcast.SelectedItem.Text.Trim() != "")
        {
            dr["Gen"] = rbtnlistcast.SelectedItem.Text.Trim();
        }
        else
        {
            dr["Gen"] = ".";
        }


        if (txtRegisDate.Text.Trim() != "")
        {
            dr["Doa"] = txtRegisDate.Text.Trim();
        }
        else
        {
            dr["Doa"] = ".";
        }

        if (txtschoolname.Text.Trim() != "")
        {
            dr["Pclass"] = txtschoolname.Text.Trim();
        }
        else
        {
            dr["Pclass"] = ".";
        }
        if (txtboard.Text.Trim() != "")
        {
            dr["PSBoard"] = txtboard.Text.Trim();
        }
        else
        {
            dr["PSBoard"] = ".";
        }

        if (txtPassFailed.Text.Trim() != "")
        {
            dr["FailClass"] = txtPassFailed.Text.Trim();
        }
        else
        {
            dr["FailClass"] = ".";
        }

        if (txtPassFailed.Text.Trim() != "")
        {
            dr["FailClass"] = txtPassFailed.Text.Trim();
        }
        else
        {
            dr["FailClass"] = ".";
        }

        if (txtClass.Text.Trim() != "")
        {
            dr["ProClass"] = txtClass.Text.Trim();
        }
        else
        {
            dr["ProClass"] = ".";
        }

        if (txtSubject.Text.Trim() != "")
        {
            dr["Subject"] = txtSubject.Text.Trim();
        }
        else
        {
            dr["Subject"] = ".";
        }
        if (txtDuePaid.Text.Trim() != "")
        {
            dr["MonthPaid"] = txtDuePaid.Text.Trim();
        }
        else
        {
            dr["MonthPaid"] = ".";
        }

        if (txtConcession.Text.Trim() != "")
        {
            dr["Conces"] = txtConcession.Text.Trim();
        }
        else
        {
            dr["Conces"] = ".";
        }

        if (txtTotalNodays.Text.Trim() != "")
        {
            dr["Tdays"] = txtTotalNodays.Text.Trim();
        }
        else
        {
            dr["Tdays"] = ".";
        }

        if (txtPresentDays.Text.Trim() != "")
        {
            dr["Pdays"] = txtPresentDays.Text.Trim();
        }
        else
        {
            dr["Pdays"] = ".";
        }

        if (txtPresentDays.Text.Trim() != "")
        {
            dr["Pdays"] = txtPresentDays.Text.Trim();
        }
        else
        {
            dr["Pdays"] = ".";
        }

        if (txtPresentDays.Text.Trim() != "")
        {
            dr["NCC"] = txtNcc.Text.Trim();
        }
        else
        {
            dr["NCC"] = ".";
        }

        if (txtGames.Text.Trim() != "")
        {
            dr["Games"] = txtGames.Text.Trim();
        }
        else
        {
            dr["Games"] = ".";
        }
        if (txtConduct.Text.Trim() != "")
        {
            dr["Conduct"] = txtConduct.Text.Trim();
        }
        else {
            dr["Conduct"] = ".";
        }

        if (txtDor.Text.Trim() != "")
        {
            dr["Dor"] = txtDor.Text.Trim();
        }
        else
        {
            dr["Dor"] = ".";
        }

        if (txtDoi.Text.Trim() != "")
        {
            dr["Doi"] = txtDoi.Text.Trim();
        }
        else
        {
            dr["Doi"] = ".";
        }

        if (txtLeave.Text.Trim() != "")
        {
            dr["leave"] = txtLeave.Text.Trim();
        }
        else
        {
            dr["leave"] = ".";
        }

        if (txtRemarks.InnerText.Trim() != "")
        {
            dr["remarks"] = txtRemarks.InnerText.Trim();
        }
        else
        {
            dr["remarks"] = ".";
        }

        dtTC.Rows.Add(dr);
        dtTC.AcceptChanges();
        if (dtTC.Rows.Count > 0)
        {
            Session["dtTC"] = dtTC;
            Response.Redirect("~/BranchPanel/Certificates/ViewTC.aspx");
        }
    }
    public int sendFeeRemainder(string RID)
    {
        int result = 0;
        DataTable DtFeeRemind = new DataTable();
        CommonClass ObjClass = new CommonClass();
        if (RID != "")
        {
            string[] ID = RID.Split(',');
            if (ID.Length > 0)
            {
                for (int i = 0; i < ID.Length; i++)
                {
                    DtFeeRemind = CommonClass.recentfee("Adm_Mobile", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), Convert.ToInt32(ID[i]));
                    if (DtFeeRemind.Rows.Count > 0)
                    {
                        if (DtFeeRemind.Rows[0]["MobileNO"].ToString().Length > 9)
                        {
                            string msg1 = "", msg2 = "", msg3 = "";
                            msg1 = "Welcome Message ! Dear ";
                            msg2 = " , Admission process is done. your Student ID-'" + DtFeeRemind.Rows[0]["Registration_No"].ToString() + ". 'To Pay fee online download 'PayToPaid' App from Playstore.";
                            result = CommonClass.getStudentMobileNoForShorlist(DtFeeRemind.Rows[0]["MobileNO"].ToString(), Convert.ToInt32(ID[i]), msg1, msg2, msg3);
                        }
                    }
                }
            }
        }

        return result;
    }
    protected void btnforcancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("student-list.aspx");
    }
    private void BindAllDDLOfPage()
    {
        BindSessionDDL();
        BindClass();
    }
    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlregistrationsession.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlregistrationsession.DataValueField = "Fyid";
        ddlregistrationsession.DataTextField = "FYName";
        ddlregistrationsession.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlregistrationsession.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    public void BindClass()
    {
        DataTable Dt = new DataTable();
        CommonClass CommonClass = new CommonClass();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ActiveFinancialyear), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        if (Dt.Rows.Count > 0)
        {
            //ddlapplyingforclass.DataSource = Dt;
            //ddlapplyingforclass.DataTextField = "Classname";
            //ddlapplyingforclass.DataValueField = "classid";
            //ddlapplyingforclass.DataBind();
            //ListItem li = new ListItem("--Select Class--", "0");
            //ddlapplyingforclass.Items.Insert(0, li);
        }
    }
    public void FillDetails(int studenregistrationid)
    {
        string REgistrationNo = (string)(Objdut.GetScalar(@"Select ISNULL(SR.Registration_No,'') from tbl_StudentRegistration SR
        inner join tbl_StudentMaster SM on SM.RID = SR.RID
        inner join Class_Master CM on cm.id = SR.ApplyingForClass where SM.SturegNo=" + studenregistrationid + " and SR.Brid=" + Convert.ToInt32(Session["BrBrid"]) + " and IsActive=1"));
        if (REgistrationNo != "")
        {
            DataTable dt = new DataTable();
            string[] Name;
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@mode", 3);
            param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
            param[2] = new SqlParameter("@registrationno", REgistrationNo);
            DataTable Dt = Objdut.GetDataTableSP(param, "usp_studentregistrationlist");
            if (Dt.Rows.Count > 0)
            {
                dt = Objdut.GetDataTable("Select * from tbl_StudentRegistration where rid=" + studenregistrationid + " and brid=" + Convert.ToInt32(Session["BrBrid"]) + " and IsAdmissionTaken=1");
                if (dt.Rows.Count > 0)
                {
                    ddlregistrationsession.SelectedValue = Convert.ToString(dt.Rows[0]["Fyid"]);
                    rbtnlistcast.SelectedValue = Convert.ToString(dt.Rows[0]["CastCategoryId"]);
                    //ddlapplyingforclass.SelectedValue = Convert.ToString(dt.Rows[0]["ApplyingForClass"]);
                    txtparentfirstname.Text = Convert.ToString(dt.Rows[0]["PrimaryParentFirstName"]) + " " + Convert.ToString(dt.Rows[0]["PrimaryParentMiddleName"]) + " " + Convert.ToString(dt.Rows[0]["PrimaryParentLastName"]);                
                    txtsecondaryparentfirstname.Text = Convert.ToString(dt.Rows[0]["SecondaryParentFirstName"])+" "+Convert.ToString(dt.Rows[0]["SecondaryParentMiddleName"])+" "+Convert.ToString(dt.Rows[0]["SecondaryParentLastName"]);
                    //txtRemarks.InnerText = Convert.ToString(dt.Rows[0]["Comment"]);
                    txtRegisDate.Text = (Convert.ToDateTime(dt.Rows[0]["RegistrationDate"])).ToString("dd MMM yyyy");
                }
                BindAllDDLOfPage();
                txtregistrationno.Text = Dt.Rows[0]["Registration_No"].ToString();
                txtOldRegNo.Text = Convert.ToString(Dt.Rows[0]["RegNewNo"]);
                
                Name = Convert.ToString(Dt.Rows[0]["studentname"]).Split(' ');
                txtadmissionreferenceno.Text = Convert.ToString(Dt.Rows[0]["AdmissionNo"]);
                txtstudentfirstname.Text = Name[0].ToString() + " " + Name[1].ToString() + " " + Name[2].ToString();
                txtstudentdob.Text = Convert.ToString(Dt.Rows[0]["StudentDOB"]);;
                rbtnlistnationality.SelectedValue = Convert.ToString(Dt.Rows[0]["Nationality"]);
                txtschoolname.Text = Convert.ToString(Dt.Rows[0]["SchoolName"]) + "-" + Convert.ToString(Dt.Rows[0]["SchoolPreviousClassName"]);
                txtboard.Text = Convert.ToString(Dt.Rows[0]["SchoolBoard"]);
                lblStudentcertificate.Text = Dt.Rows[0]["BirthCertificate"].ToString();
            }
            else
            {
                Response.Redirect("student-list.aspx");
            }
        }
    }
    protected void txtregistrationno_TextChanged(object sender, EventArgs e)
    {
        if (txtregistrationno.Text.Trim() != "")
        {
            int studenregistrationid = Convert.ToInt32(Objdut.GetScalar("Select RID From tbl_StudentRegistration Where Registration_No='" + txtregistrationno.Text.Trim() + "' and IsAdmissionTaken=1 and Status=1"));
            if (studenregistrationid > 0)
            {
                FillDetails(studenregistrationid);
            }
            else
            {
                Utility.ViewAlertMessage(this, "Sorry....!!!!!! Invalid Registration No.Please enter Valid One.");
                txtregistrationno.Text = "";
            }
        }
    }
    protected void txtdiscountcode_TextChanged(object sender, EventArgs e)
    {
        if (txtdiscountcode.Text.Trim() != "")
        {
            string DiscountCode = Convert.ToString(Objdut.GetScalar("Select DiscountCode From DiscountedStudent_Info Where DiscountCode='" + txtdiscountcode.Text.Trim() + "' and               IActive=1 And IsDiscountImplemented=0"));
            if (DiscountCode != "")
            {
                FillDetailsOnTheBehalfOfDiscount(DiscountCode);
            }
            else
            {
                Utility.ViewAlertMessage(this, "Sorry....!!!!!! Invalid Discount Code.Please enter Valid One.");
                txtdiscountcode.Text = "";
            }
        }
    }
    public void FillDetailsOnTheBehalfOfDiscount(string DiscountCode)
    {
       
    }
    [WebMethod]
    public static BindSection[] BindSectionDDL(string Classid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("sectiondll", Convert.ToInt32(Classid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        List<BindSection> BindObj = new List<BindSection>();
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            BindSection Obj = new BindSection();
            Obj.SECTIONID = Dt.Rows[i]["cwsid"].ToString();
            Obj.SECTIONNAME = Dt.Rows[i]["sectionname"].ToString();
            BindObj.Add(Obj);
        }
        return BindObj.ToArray();
    }
    public class BindSection
    {
        public string SECTIONID { get; set; }
        public string SECTIONNAME { get; set; }
    }
    [WebMethod]
    public static string IsReadyForAction(string Date, int Fyid, string Registration_No)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[4];
        Param[0] = new SqlParameter("@ActivityDate", Date);
        Param[1] = new SqlParameter("@Fyid", Fyid);
        Param[2] = new SqlParameter("@Registration_No", Registration_No);
        Param[3] = new SqlParameter("@Mode", 2);
        int ScalerValue = Convert.ToInt32(Objdut.GetScalerSP(Param, "[Usp_PreAdmissionSettings]"));
        return ScalerValue.ToString();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/BranchPanel/MasterUC/ListOfCerti.aspx?RID=" + Request.QueryString["RID"].ToString() + "");
    }
}