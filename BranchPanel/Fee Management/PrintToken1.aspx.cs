using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.HtmlControls;

public partial class BranchPanel_Fee_Management_PrintToken1 : System.Web.UI.Page
{
    DataUtility ObjDut = new DataUtility();
    DataTable dtPerInfo;
    DataTable dtReg;
    DataTable dtExam;
    DataTable dtSubject;
    DataTable dtMarks;
    int eid = 0;
    int fyid = 0;
    int ClassID = 0;
    int SectionID = 0, ResultTerm = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["dtStudent"] != null)
        {
            dtReg = (DataTable)(Session["dtStudent"]);
            if (dtReg.Rows.Count > 0)
            {

                var grouped = from table in dtReg.AsEnumerable()
                              group table by new { placeCol = table["STUREGNO"] } into groupby
                              select new
                              {
                                  Value = groupby.Key,
                                  ColumnValues = groupby
                              };
                DataTable dtregNew = new DataTable();
                dtregNew.Columns.Add("STUREGNO");
                dtregNew.Columns.Add("ASAID");
                foreach (var key in grouped)
                {
                    DataRow dr = dtregNew.NewRow();
                    dr["STUREGNO"] = key.Value.placeCol;
                    var values = "";
                    foreach (var columnValue in key.ColumnValues)
                    {
                        values = values == "" ? columnValue["ASAID"].ToString() : values + "," + columnValue["ASAID"].ToString();
                    }
                    dr["ASAID"] = values;
                    dtregNew.Rows.Add(dr);
                }
                grdSTDResult.DataSource = dtregNew;
                grdSTDResult.DataBind();
            }
        }
        else
        {
            Response.Redirect("ViewResult.aspx");
        }
    }
    private void getrecieptgenraldetails(HtmlGenericControl SSAddress, HtmlGenericControl SpScool, HtmlGenericControl SAddress, HtmlGenericControl SpFone, HtmlGenericControl SMobile, HtmlGenericControl SEmailID, HtmlGenericControl SchoolAffia, HtmlGenericControl affhead, HtmlGenericControl SWebsite, Image Image1)
    {
        string value = "";
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 10);
        value = objdut.GetScalerSP(param, "[usp_general_master_setting]").ToString();
        string[] getdata = value.Split('~');
        string isbranch = getdata[0];
        string address = "", serviceno = "", Ph = "", mobile = "", Contact = "", EmailID = "", tin = "", SchoolAffi = "", Website = "";

        string branchdata = Convert.ToString(objdut.GetScalar(@"select BrAddress+'^'+City+', '+state+', '+Country+', '+pincode+'^'+
            LandLineNo+','+MobileNo+'^'+Emailid+'^'+isnull(Website,'')+'^'+isnull(SchoolAffi,'')+'^'+isnull(BrName,'')+'^'+isnull(photo,'') from branch_master where brid = " + Session["brbrid"] + ""));
        if (branchdata != "")
        {
            string[] getbranchdata = branchdata.Split('^');
            address = getbranchdata[0];
            SSAddress.InnerText = getbranchdata[1];

            string[] getCont;
            Contact = getbranchdata[2];
            getCont = Contact.Split(',');
            Ph = getCont[0].ToString();
            mobile = getCont[1].ToString();
            EmailID = getbranchdata[3].ToString();
            Website = getbranchdata[4].ToString();
            SchoolAffi = getbranchdata[5].ToString();
            SpScool.InnerText = getbranchdata[6].ToString();
            SAddress.InnerText = address;

            SpFone.InnerText = Ph.ToString();
            SMobile.InnerText = mobile.ToString();
            SEmailID.InnerText = EmailID.ToString();

            if (SchoolAffi != "")
            {
                SchoolAffia.InnerText = SchoolAffi.Trim();
                affhead.InnerText = "Affiliation No:";

            }
            else
            {
                affhead.InnerText = ".";
            }
            SWebsite.InnerText = Website.Trim();
            if (getbranchdata[7].ToString() != "")
            {
                Image1.ImageUrl = "~/BranchPanel/images/" + getbranchdata[7].ToString();
            }
            else
            {
                Image1.ImageUrl = "~/BranchPanel/images/9update.png";
            }
        }
    }
    protected void grdSTDResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField dfrollno = (HiddenField)e.Row.FindControl("dfrollno");
            HiddenField dfregno = (HiddenField)e.Row.FindControl("dfregno");

            HtmlGenericControl lblStdName = (HtmlGenericControl)e.Row.FindControl("lblStdName");
            HtmlGenericControl lblFName = (HtmlGenericControl)e.Row.FindControl("lblFName");
            HtmlGenericControl lblClass = (HtmlGenericControl)e.Row.FindControl("lblClass");
            HtmlGenericControl SpanSec = (HtmlGenericControl)e.Row.FindControl("SpanSec");
            HtmlGenericControl SpanMob = (HtmlGenericControl)e.Row.FindControl("SpanMob");
            HtmlGenericControl SpDate = (HtmlGenericControl)e.Row.FindControl("SpDate");
            SpDate.InnerText = DateTime.Now.DayOfWeek.ToString() + " " + DateTime.Now.ToString("dd-MMM-yyyy");

            HtmlGenericControl SpMName = (HtmlGenericControl)e.Row.FindControl("SpMName");
            HtmlGenericControl SpBalance = (HtmlGenericControl)e.Row.FindControl("SpBalance");

            HtmlGenericControl SSAddress = (HtmlGenericControl)e.Row.FindControl("SSAddress");
            HtmlGenericControl SpScool = (HtmlGenericControl)e.Row.FindControl("SpScool");
            HtmlGenericControl SAddress = (HtmlGenericControl)e.Row.FindControl("SAddress");
            HtmlGenericControl SpFone = (HtmlGenericControl)e.Row.FindControl("SpFone");
            HtmlGenericControl SMobile = (HtmlGenericControl)e.Row.FindControl("SMobile");
            HtmlGenericControl SEmailID = (HtmlGenericControl)e.Row.FindControl("SEmailID");
            HtmlGenericControl SchoolAffia = (HtmlGenericControl)e.Row.FindControl("SchoolAffia");
            HtmlGenericControl affhead = (HtmlGenericControl)e.Row.FindControl("affhead");
            HtmlGenericControl SWebsite = (HtmlGenericControl)e.Row.FindControl("SWebsite");
            HtmlTableCell tdFeedetails = (HtmlTableCell)e.Row.FindControl("tdFeedetails");
            HtmlTableRow mainheader = (HtmlTableRow)e.Row.FindControl("mainheader");
            HtmlTableRow mainheader1 = (HtmlTableRow)e.Row.FindControl("mainheader1");
            if(e.Row.RowIndex>0)
            {
                mainheader.Visible = false;
                mainheader1.Visible = false;
            }
            //HtmlGenericControl RollNoA = (HtmlGenericControl)e.Row.FindControl("RollNoA");
            //HtmlGenericControl RollNo = (HtmlGenericControl)e.Row.FindControl("RollNo");
            //HtmlGenericControl classID = (HtmlGenericControl)e.Row.FindControl("classID");
            //HtmlGenericControl DOB = (HtmlGenericControl)e.Row.FindControl("DOB");

            //HtmlGenericControl sectionID = (HtmlGenericControl)e.Row.FindControl("sectionID");
            //HtmlGenericControl SpName = (HtmlGenericControl)e.Row.FindControl("SpName");
            //HtmlGenericControl SpTerm = (HtmlGenericControl)e.Row.FindControl("SpTerm");
            //HtmlGenericControl SpMName = (HtmlGenericControl)e.Row.FindControl("SpMName");
            //HtmlGenericControl SpFName = (HtmlGenericControl)e.Row.FindControl("SpFName");
            //HtmlGenericControl spWorkI = (HtmlGenericControl)e.Row.FindControl("spWorkI");

            //HtmlGenericControl SpPhyI = (HtmlGenericControl)e.Row.FindControl("SpPhyI");
            //PlaceHolder placeholder = (PlaceHolder)e.Row.FindControl("placeholder");
            //HtmlGenericControl SpArtI = (HtmlGenericControl)e.Row.FindControl("SpArtI");
            //HtmlGenericControl SpDisI = (HtmlGenericControl)e.Row.FindControl("SpDisI");
            //HtmlGenericControl SpanMob = (HtmlGenericControl)e.Row.FindControl("SpanMob");
            //HtmlGenericControl SpanAddr = (HtmlGenericControl)e.Row.FindControl("SpanAddr");
            //HtmlGenericControl SpanFrom = (HtmlGenericControl)e.Row.FindControl("SpanFrom");
            //HtmlGenericControl SpanTo = (HtmlGenericControl)e.Row.FindControl("SpanTo");

            Image Image2 = (Image)e.Row.FindControl("Image2");
            Image Image1 = (Image)e.Row.FindControl("Image1");
            if (dfrollno.Value != null)
            {
                BindFee(SpMName, SpBalance, dfrollno.Value, tdFeedetails);
            }
            if (dfregno.Value != null)
            {
                //SpanFrom.InnerText = Convert.ToString(Session["AdmitFromDate"]);
                //   SpanTo.InnerText = Convert.ToString(Session["AdmitToDate"]);
                getrecieptgenraldetails(SSAddress, SpScool, SAddress, SpFone, SMobile, SEmailID, SchoolAffia, affhead, SWebsite, Image1);
                //affhead.InnerText = "Affiliation No:";

                BindPersonalInfo(lblFName, lblClass, lblStdName, Convert.ToInt32(dfregno.Value), SpanSec,SpanMob);
                // ExamMarks(Convert.ToInt32(dfregno.Value), placeholder);
                //BindCoSc(Convert.ToInt32(dfregno.Value), spWorkI, SpPhyI, SpArtI, SpDisI);

                //int ResultTerm = Convert.ToInt32(dtReg.Rows[0]["ResultTerm"]);
                //if (ResultTerm == 1)
                //{
                //    SpTerm.InnerText = "Term - I ( 100 Marks )";
                //}
                //else if (ResultTerm == 2)
                //{
                //    SpTerm.InnerText = "Term - II ( 100 Marks )";
                //}
                //else if (ResultTerm == 3)
                //{
                //    SpTerm.InnerText = "Term - III ( 100 Marks )";
                //}
            }
        }
    }

    private void BindFee(HtmlGenericControl spMName, HtmlGenericControl spBalance, string ASAID, HtmlTableCell tdFeedetails)
    {
        string str = "Select installmentAMount iAmt, DateName( month , DateAdd( month ,MonthId, -1 )) as MName,* from tbl_StudentAdmissionInstallment where ASAID in (" + ASAID + ")";
        DataTable dtFee = ObjDut.GetDataTable(str);
        decimal total = 0;
        int rowspan = 0;
        int feeCount = 0;
        if (dtFee.Rows.Count > 0)
        {
            var html = "<table style='width:88%;float:left'><tr style='font-weight: 800;'><td>Month Name</td><td>Fee Name</td><td>Balance Amount</td></tr>";
            for (int n = 0; n < dtFee.Rows.Count; n++)
            {
                spMName.InnerText = dtFee.Rows[n]["MName"].ToString();
                spBalance.InnerText = dtFee.Rows[n]["iAmt"].ToString();
                var transportAmt = Convert.ToString(dtFee.Rows[n]["TransPortAmt"]);
                DataTable dtFeeHead = new DataTable();
                dtFeeHead.Columns.Add("SNo");
                dtFeeHead.Columns.Add("FeeHead");
                dtFeeHead.Columns.Add("FeeHeadAmt", typeof(decimal));

                DataTable dtFeeHead1 = new DataTable();
                dtFeeHead1.Columns.Add("SNo");
                dtFeeHead1.Columns.Add("FeeHead");
                dtFeeHead1.Columns.Add("FeeHeadAmt", typeof(decimal));
                if (string.IsNullOrWhiteSpace(dtFee.Rows[n]["FeeDescription"].ToString()) && !string.IsNullOrWhiteSpace(dtFee.Rows[n]["FeeDescription"].ToString()))
                {
                    DataRow dr = dtFeeHead.NewRow();
                    dr["SNo"] = Convert.ToInt32(dtFeeHead.Rows.Count) + 1;
                    dr["FeeHead"] = "Old Due";
                    dr["FeeHeadAmt"] = dtFee.Rows[n]["iAmt"];
                    total = total + Convert.ToDecimal(dtFee.Rows[n]["iAmt"]);
                    dtFeeHead.Rows.Add(dr);
                }
                else
                {
                    string[] FeeRowHead;
                    if (dtFee.Rows[n]["FeeDescription"].ToString().Contains('&'))
                    {
                        FeeRowHead = dtFee.Rows[n]["FeeDescription"].ToString().Split('&');
                    }
                    else
                    {
                        FeeRowHead = dtFee.Rows[n]["FeeDescription"].ToString().Split('~');
                    }

                    if (FeeRowHead[0].ToString() != "N/A")
                    {
                        for (int i = 0; i < FeeRowHead.Length; i++)
                        {
                            string[] FeeHead;
                            FeeHead = FeeRowHead[i].ToString().Split(':');
                            DataRow dr = dtFeeHead.NewRow();
                            dr["SNo"] = Convert.ToInt32(dtFeeHead.Rows.Count) + 1;
                            dr["FeeHead"] = FeeHead[0].ToString();
                            if (!string.IsNullOrWhiteSpace(Convert.ToString(FeeHead[1])))
                            {
                                dr["FeeHeadAmt"] = Convert.ToDecimal(FeeHead[1]);
                                total = total + Convert.ToDecimal(FeeHead[1]);
                            }
                            else
                            {
                                dr["FeeHeadAmt"] = "0.00";
                            }

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

                if (!string.IsNullOrWhiteSpace(transportAmt))
                {                   
                    total = total + Convert.ToDecimal(transportAmt);
                    feeCount++;
                }
                int c = 0;
                if (dtFeeHead1 != null)
                {
                    feeCount = feeCount + dtFeeHead1.Rows.Count;
                }
                foreach (DataRow dr in dtFeeHead1.Rows)
                {


                    html = html + "<tr><td>" + dtFee.Rows[n]["MName"].ToString() + "</td><td>" + dr["FeeHead"].ToString() + "</td><td>" + dr["FeeHeadAmt"].ToString() + "</td><tr/>";


                    // total =total+ Convert.ToDecimal(dr["FeeHeadAmt"]);
                    c++;
                }
                if (!string.IsNullOrWhiteSpace(transportAmt))
                {
                    //rowspan++;
                    // total = total + Convert.ToDecimal(transportAmt);                    
                    html = html + "<tr><td>" + dtFee.Rows[n]["MName"].ToString() + "</td><td>Transport Fee</td><td>" + transportAmt + "</td><tr/>";

                }

            }
            html = html + "</table>";
            var totalHieght = feeCount * 25.85;
            html = html + "<table>";
            html = html + "<tr style='font-weight: 800;width:12%'><td>Total</td><tr/><tr HEIGHT='"+totalHieght+"px'><td>" + total.ToString() + "</td><tr/>";
            html = html + "</table>";
            //html = html + "<div style='font-weight: 800;width:12%;height:100%;float:right'>";
            //html = html + "<div style='text-align:center;'>Total</div><div style='text-align:center'>" + total.ToString() + "</div>";
            //html = html + "</div>";


            tdFeedetails.InnerHtml = html;

        }

    }

    private void BindPersonalInfo(HtmlGenericControl lblFName, HtmlGenericControl lblClass, HtmlGenericControl lblStdName, int eid, HtmlGenericControl SpanSec, HtmlGenericControl SpanMob)
    {
        string strPer = @"Select distinct SR.fyid,SR.RID,SR.StudentPhotograph,SR.Registration_No,SR.StudentFirstName+' '+SR.StudentMiddleName+' '+StudentLastName as StdName,
                            SR.PrimaryParentFirstName+' '+SR.PrimaryParentMiddleName+' '+PrimaryParentLastName as FatherName,
                            SR.SecondaryParentFirstName+' '+SR.SecondaryParentMiddleName+' '+SecondaryParentLastName as MotherName,
                            ISNULL(SR.RegNewNo,0) RegNewNo,SR.StudentDOB,SA.ClassID,Class_Master.Classname,SA.SectionId, sr.Address+' '+sr.city+ ' '+ sr.state as addr, Primarymobileno from tbl_StudentRegistration SR 
                            inner join tbl_StudentMaster SM on SR.RID = SM.RID and SR.Brid = SM.brid 
                            inner join tbl_StudentAdmissionMaster SA on SM.SturegNo = SA.StuRegNo and SM.Brid = SA.brid
                            inner join classwithsection ON  classwithsection.classid = SA.ClassID
                            inner join Class_Master ON  Class_Master.id = classwithsection.ClassID
                            Left Outer join mst_RresultToClass ON  mst_RresultToClass.ClassID = SM.ClassID and mst_RresultToClass.ResultTypeID=1
                            where sr.Brid=" + Convert.ToInt32(Session["BrBrid"]) + " and SA.StuRegNo=" + eid + "";
        dtPerInfo = new DataTable();

        dtPerInfo = ObjDut.GetDataTable(strPer);

        if (dtPerInfo.Rows.Count > 0)
        {

            //SpClasss.InnerText = classID.InnerText;
            SectionID = Convert.ToInt32(dtPerInfo.Rows[0]["SectionId"]);

            ClassID = Convert.ToInt32(dtPerInfo.Rows[0]["ClassID"]);
            var sectionID = (string)(ObjDut.GetScalar("Select sectionname from classwithsection where cwsid=" + SectionID + " and branchid=" + Convert.ToInt32(Session["BrBrid"]) + ""));

            lblStdName.InnerText = dtPerInfo.Rows[0]["StdName"].ToString();
            lblFName.InnerText = dtPerInfo.Rows[0]["FatherName"].ToString();
            lblClass.InnerText = dtPerInfo.Rows[0]["Classname"].ToString();
            SpanSec.InnerHtml = sectionID;
            SpanMob.InnerHtml = Convert.ToString(dtPerInfo.Rows[0]["Primarymobileno"]); 
            //SpName.InnerText = dtPerInfo.Rows[0]["StdName"].ToString();
            //SpMName.InnerText = dtPerInfo.Rows[0]["MotherName"].ToString();
            //SpFName.InnerText = dtPerInfo.Rows[0]["FatherName"].ToString();
            //SpanAddr.InnerText = dtPerInfo.Rows[0]["addr"].ToString();
            //SpanMob.InnerText = dtPerInfo.Rows[0]["Primarymobileno"].ToString();

            //Image2.ImageUrl = "~/BranchPanel/Student-Registration/student-registration-document/" + dtPerInfo.Rows[0]["StudentPhotograph"].ToString();
            fyid = Convert.ToInt32(dtPerInfo.Rows[0]["fyid"]);
            string StrResult = "";
            string ValueResult = "";
            StrResult = "Select ISNULL(mst_RresultToClass.Status,0) from mst_RresultToClass where Brid=" + Convert.ToInt32(Session["BrBrid"]) + " and ClassID=" + ClassID + " and ResultTypeID=1";
            ValueResult = Convert.ToString(ObjDut.GetScalar(StrResult));
            if (ValueResult == "")
            {
                ResultType.Value = "0";
            }
            else
            {
                ResultType.Value = ValueResult.ToString();
            }
        }
    }
    protected void OnRowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Visible = false;
        }
    }
}