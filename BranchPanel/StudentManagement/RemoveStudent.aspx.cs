using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
//TRUNCATE TABLE Tbl_Parentlogin
//TRUNCATE TABLE  Receipt_master
//TRUNCATE TABLE  tbl_StudentAdmissionInstallment
//TRUNCATE TABLE  tbl_StudentAdmissionMaster
//TRUNCATE TABLE  tbl_StudentMaster
//TRUNCATE TABLE  tbl_StudentRegistration
//TRUNCATE TABLE  tbl_StudentRegistrationDetailsUpdationHistory
//TRUNCATE TABLE DiscountedStudent_Info
//TRUNCATE TABLE Discount_student_master
//TRUNCATE TABLE tbl_TransPortDetails
//TRUNCATE TABLE tbl_TransPortDetails1

public partial class BranchPanel_StudentManagement_RemoveStudent : System.Web.UI.Page
{
    DataUtility objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            trClass.Visible = false;
            trSection.Visible = false;
        }
    }
    [WebMethod]
    public static BIndClass[] BindClassDDL()
    {
        CommonClass CommonClass = new CommonClass();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();

        DataTable Dt;
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ActiveFinancialyear), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
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
    protected void btSave_Click(object sender, EventArgs e)
    {
        DataTable dtReg = new DataTable();
        DataRow dr = dtReg.NewRow();
        if (checkvalidation())
        {
            string Str = "";
            Str= @"Select DISTINCT isnull(SR.Registration_No,'') RegistrationNo from tbl_StudentRegistration SR
				inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.Brid
				inner join tbl_StudentAdmissionMaster SA on SA.StuRegNo = SM.SturegNo
				where SR.Brid=" + Convert.ToInt32(Session["BrBrid"]) + "";

            if (rdbOption.SelectedValue == "2")
            {
                dtReg = objdut.GetDataTable(Str);
            }
            else if (rdbOption.SelectedValue == "3")
            {
                dtReg = objdut.GetDataTable(Str + " and SA.ClassID=" + hdfClassID.Value + " and SA.SectionId=" + hdfSectionID.Value + "");
            }
            else
            {
                dtReg.Columns.Add("RegistrationNo");                
                dr["RegistrationNo"]= txtFeeName.Text.ToString().Trim();
                dtReg.Rows.Add(dr);
                dtReg.AcceptChanges();
            }
            if (dtReg.Rows.Count > 0)
            {
                for (int i = 0; i < dtReg.Rows.Count; i++)
                {
                    SqlParameter[] param = new SqlParameter[3];
                    param[0] = new SqlParameter("@RegistrationNo", dtReg.Rows[i]["RegistrationNo"].ToString().Trim());
                    param[1] = new SqlParameter("@Brid", Convert.ToInt32(Session["BrBrid"]));
                    param[2] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                    param[2].Direction = ParameterDirection.Output;
                    int ret = objdut.ExecuteSqlSP(param, "Usp_Delete");
                    if (ret == 1)
                    {
                        Utility.ViewAlertMessage(this.Master.Page, "Delete Successfully");
                    }
                    if (ret == 2)
                    {
                        Utility.ViewAlertMessage(this.Master.Page, "Student Registration No not Found..");
                    }
                    else
                    {
                        Utility.ViewAlertMessage(this.Master.Page, "Student Detail not delete...");
                    }
                    txtFeeName.Text = "";
                }
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No Student Detail Found.");
            }
        }
    }
    private bool checkvalidation()
    {
        if (rdbOption.SelectedValue == "1")
        {
            if (txtFeeName.Text == "")
            {
                Utility.ViewAlertMessage(this.Master.Page, "Plz Enter Admission No.");
                return false;
            }
        }
       
        return true;
    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {        
        if (rdbOption.SelectedValue == "2")
        {
            tr.Style.Add("Display", "Block");
            trClass.Visible = false;
            trSection.Visible = false;            
        }
        if (rdbOption.SelectedValue == "3")
        {
            trClass.Visible = true;
            trSection.Visible = true;
            tr.Style.Add("Display", "none");
        }
        else
        {
            trClass.Visible = false;
            trSection.Visible = false;
            tr.Style.Add("Display", "none");
        }
    }
}