using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EmployeePanel_Download : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private bool isFeeDeposited()
    {
        var StuRegNo = Session["SturegNo"];
        var BrId = Session["brbrid"];
        if (!string.IsNullOrWhiteSpace(Convert.ToString(StuRegNo)) && !string.IsNullOrWhiteSpace(Convert.ToString(BrId)))
        {
            string str = @"SELECT Count(*)
                            from tbl_StudentRegistration SR
                            inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.Brid
                            inner join tbl_StudentAdmissionMaster SA on SM.StuRegNo = SA.StuRegNo and SM.Brid = SA.Brid
                            inner join tbl_StudentAdmissionInstallment SFA on SFA.StuRegNo = SA.StuRegNo
                            where SFA.SturegNo=" + StuRegNo + " and SFA.Brid=" + BrId + " and PaymentStatusId=1 " +
                            " and Month(InstallmentDate) between 4 and 9 and SFA.InstallmentAmount > 0";
            var count = Convert.ToInt32(objdut.GetScalar(str));
            if (count > 0)
            {
                Utility.ViewAlertMessage(Page, "Your Fee is not submitted contact school!");
                return false;
            }
            else
                return true;
        }
        return false;
    }
    protected void btnAdmitCard_Click(object sender, EventArgs e)
    {
        var BrUser = Session["BrUser"];
        var SAMID = Session["SAMID"];
        var RID = Session["RID"];
        var StuRegNo = Session["SturegNo"];
        var BrId = Session["brbrid"];
        var ClassId = Session["Classid"];
        var SectionId = Session["Sectionid"];

        Session["StdRegList"] = null;
        DataTable dtReg = new DataTable();
        dtReg.Columns.Add("regno");
        dtReg.Columns.Add("rollno");
        dtReg.Columns.Add("ResultTerm");
        dtReg.Columns.Add("termid");
        dtReg.Columns.Add("classid");
        dtReg.Columns.Add("sectionid");

        DataTable dtStd = new DataTable();

        if (RID != null && StuRegNo != null && BrId != null && ClassId != null && SectionId != null)
        {
            string querynew = @"SELECT DISTINCT ISNULL(SA.ClassID,0) Class,ISNULL(SA.SectionId,0) Sec,ISNULL(MH.Housename,'') HouseName,ISNULL(SR.RegNewNo,'') RegNewNo,ISNULL(SM.StuRegNo,0) StuRegNo,ISNULL(SA.AdmissionNo,'') AdmissionNo,ISNULL(SR.HouseID,0) HouseID ,
                                CASE WHEN SR.HouseID > 0 THEN 'TRUE' ELSE 'FALSE' END AS Status, ISNULL(SR.StudentFirstName,'')+' '+ISNULL(SR.StudentMiddleName,'')+' '+ISNULL(SR.StudentLastName,'') AS StudentName
                               from tbl_StudentRegistration SR
                                inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.Brid
                                inner join tbl_StudentAdmissionMaster SA on SM.StuRegNo = SA.StuRegNo
                                left outer join mst_House MH on MH.HouseID = SR.HouseID
                                where SR.RID=" + RID + " and SM.Sturegno=" + StuRegNo + " and SR.Brid=" + BrId + " and SR.ApplyingForClass=" + ClassId + " and SA.SectionId=" + SectionId + " Order by StudentName asc";

            dtStd = objdut.GetDataTable(querynew);
            if (dtStd.Rows.Count > 0)
            {
                DataRow dr = dtReg.NewRow();
                dr["regno"] = dtStd.Rows[0]["StuRegNo"].ToString().Trim();
                dr["rollno"] = dtStd.Rows[0]["RegNewNo"].ToString().Trim();
                dr["ResultTerm"] = ddlResultType.SelectedValue.ToString().Trim();
                dr["termid"] = ddlResultType.SelectedValue.ToString().Trim();
                dr["classid"] = ClassId.ToString().Trim();
                dr["sectionid"] = SectionId.ToString().Trim();
                dtReg.Rows.Add(dr);
                dtReg.AcceptChanges();
            }
            if (dtReg.Rows.Count > 0)
            {
                Session["StdRegList"] = dtReg;
                if (ddlResultType.SelectedValue == "1" || ddlResultType.SelectedValue == "2" || ddlResultType.SelectedValue == "3")
                {
                    Response.Write("<script>window.open ('AdmitCard.aspx','_blank');</script>");
                }
                else// if (ddlResultType.SelectedValue == "2")
                {
                    Response.Write("<script>window.open ('AdmitCard.aspx','_blank');</script>");
                }
            }
            else
            {
                Session["StdRegList"] = null;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Please Select Atleast One Student')", true);
            }

        }
    }

    protected void btnResult_Click(object sender, EventArgs e)
    {
        if (isFeeDeposited())
            if (Session["SturegNo"] != null && Session["RegNewNo"] != null)
            {
                DataTable dtReg = new DataTable();
                dtReg.Columns.Add("regno");
                dtReg.Columns.Add("rollno");
                dtReg.Columns.Add("ResultTerm");
                dtReg.Columns.Add("srNum");

                DataRow dr = dtReg.NewRow();
                dr["regno"] = Session["SturegNo"].ToString().Trim();
                dr["rollno"] = Session["RegNewNo"].ToString().Trim();
                dr["ResultTerm"] = ddlTerm.SelectedValue.ToString();
                dr["srNum"] = "1";
                dtReg.Rows.Add(dr);
                dtReg.AcceptChanges();

                if (dtReg.Rows.Count > 0)
                {
                    Session["RegList"] = dtReg;
                    if (ddlResultType.SelectedValue == "1" || ddlResultType.SelectedValue == "2" || ddlResultType.SelectedValue == "3")
                    {
                        Response.Write("<script>window.open ('reportcard_term.aspx','_blank');</script>");
                    }
                    else// if (ddlResultType.SelectedValue == "2")
                    {
                        Response.Write("<script>window.open ('reportcard.aspx','_blank');</script>");
                    }
                }
                else
                {
                    Session["RegList"] = null;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Please Select Atleast One Student')", true);
                }
            }
    }
}