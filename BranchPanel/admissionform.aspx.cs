using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_admissionform : System.Web.UI.Page
{
    private string url;
    private DataTable dt, dt2, dt3;

    private double idstudent = 0;

    private BEL bal = new BEL();
    private BLL objUserBLL = new BLL();
    private string imuniid = "", rcheck = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        if (!IsPostBack)
        {
            fillsought();
            fillvaccin();
            fillDATEDDL();
            BindColumnToGridview1();
        }
    }

    private void BindColumnToGridview1()
    {
        dt = objUserBLL.bindfirst();
        grdclass.DataSource = dt;
        grdclass.DataBind();
        dt.Clear();

        dt = objUserBLL.bindfirstsecondgrid();
        grdDetails.DataSource = dt;
        grdDetails.DataBind();
        dt.Clear();

        dt = objUserBLL.bindfirststhirdgrid();
        grd1.DataSource = dt;
        grd1.DataBind();
        dt.Clear();
    }

    public void fillDATEDDL()
    {
        DataTable dt = CommonClass.ABC("MonthName");//CommmonOBJ.Dll("MonthName");
        ddlMonth.DataSource = dt;
        ddlMonth.DataBind();
        ddlMonth.DataTextField = "MonthName";
        ddlMonth.DataValueField = "MonthId";
        ddlMonth.DataBind();
        ddlMonth.Items.Insert(0, "--Month--");
        ddlDate.Items.Insert(0, "--Date--");
        ddlYear.Items.Insert(0, "--Year--");

        dt3 = objUserBLL.bindqualification();
        if (dt3.Rows.Count > 0)
        {
            ddlFQualifiaction1.DataSource = dt3;
            ddlFQualifiaction1.DataTextField = "pqualification";
            ddlFQualifiaction1.DataValueField = "id";
            ddlFQualifiaction1.DataBind();
            ListItem li4 = new ListItem("--Select one--", "0");
            ddlFQualifiaction1.Items.Insert(0, li4);

            ddlMQualifiaction1.DataSource = dt3;
            ddlMQualifiaction1.DataTextField = "pqualification";
            ddlMQualifiaction1.DataValueField = "id";
            ddlMQualifiaction1.DataBind();
            ListItem li5 = new ListItem("--Select one--", "0");
            ddlMQualifiaction1.Items.Insert(0, li5);
        }
        dt3.Clear();
    }

    private void fillvaccin()
    {
        dt = BLL.getmedicalvacination();
        if (dt.Rows.Count > 0)
        {
            grdimmuni.DataSource = dt;
            grdimmuni.DataBind();
            dt.Clear();
        }
    }

    private void fillsought()
    {
        dt = BLL.getclass(Convert.ToInt16(Session["BrBrid"]));
        if (dt.Rows.Count > 0)
        {
            ddlstclass.DataSource = dt;
            ddlstclass.DataValueField = "classid";
            ddlstclass.DataTextField = "Classname";
            ddlstclass.DataBind();
            ddlstclass.Items.Insert(0, "--Select Class--");
            dt.Clear();
        }
    }

    public class UserDetails
    {
        public string feename { get; set; }

        public string fees { get; set; }

        public double cfid { get; set; }
    }

    public class Binfeedata
    {
        public string feename { get; set; }

        public string fees { get; set; }

        public string month { get; set; }
    }

    public class Binfeedata1
    {
        public string fees { get; set; }

        public string month { get; set; }

        public string monthid { get; set; }
    }

    [WebMethod]
    public static Binfeedata[] Bindfeestructure(string classid, int trantype)
    {
        DataSet ds = new DataSet();
        List<Binfeedata> details = new List<Binfeedata>();

        BEL.applyclassid = Convert.ToInt16(classid);
        BEL.branchid = Convert.ToInt16(HttpContext.Current.Session["BrBrid"]);
        BEL.modestatic = trantype;

        DataTable dt = new DataTable();
       //dt= BLL.bindfeestructure();

        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in dt.Rows)
            {
                Binfeedata user = new Binfeedata();
                user.feename = dtrow["transtype"].ToString();
                user.fees = dtrow["credit"].ToString();
                user.month = dtrow["monthname"].ToString();

                details.Add(user);
            }
        }
        dt.Clear();
        return details.ToArray();
    }

    [WebMethod]
    public static Binfeedata1[] bindpay(string classid, int trantype)
    {
        DataSet ds = new DataSet();

        List<Binfeedata1> details = new List<Binfeedata1>();

        BEL.applyclassid = Convert.ToInt16(classid);
        BEL.branchid = Convert.ToInt16(HttpContext.Current.Session["BrBrid"]);
        BEL.modestatic = trantype;

        DataTable dt = new DataTable();
        //dt = BLL.bindpayfee();
        foreach (DataRow dtrow in dt.Rows)
        {
            Binfeedata1 user = new Binfeedata1();

            user.fees = dtrow["credit"].ToString();
            user.month = dtrow["monthname"].ToString();
            user.monthid = dtrow["paymonth"].ToString();

            details.Add(user);
        }
        dt.Clear();
        return details.ToArray();
    }

    [WebMethod]
    public static UserDetails[] BindDatatable(string classid)
    {
        DataTable dt = new DataTable();
        List<UserDetails> details = new List<UserDetails>();

        dt = BLL.getclassfeestructure(Convert.ToInt32(classid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        foreach (DataRow dtrow in dt.Rows)
        {
            UserDetails user = new UserDetails();
            user.feename = dtrow["feename"].ToString();
            user.fees = dtrow["fees"].ToString();
            user.cfid = Convert.ToDouble(dtrow["cfid"]);
            details.Add(user);
        }
        dt.Clear();
        return details.ToArray();
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        idstudent = objUserBLL.getstudentid();
        //string pname = "usp_StuAdmission";
        bal.brid = Convert.ToInt16(Session["BrBrid"]);
        bal.branchname = Convert.ToString(Session["Brusername"]);
        bal.student_first_name = txtName.Text.Trim();
        bal.student_mid_name = txtmidname.Text.Trim();
        bal.student_Last_name = txtLName.Text.Trim();
        bal.admission_Date = ddlYear.SelectedItem.Text + "-" + ddlMonth.SelectedValue + "-" + Request.Form[hdate.UniqueID];

        bal.date_of_Birth = Convert.ToDateTime(txtToDate.Text.Trim());
        //
        bal.gender = Convert.ToInt16(rbgender.SelectedValue);
        bal.student_age = "";
        if (TextBox1.Text == "")
        {
            bal.height = 0;
        }
        else
        {
            bal.height = Convert.ToDouble(TextBox1.Text.Trim());
        }

        if (TextBox2.Text == "")
        {
            bal.weight = 0;
        }
        else
        {
            bal.weight = Convert.ToDouble(TextBox2.Text.Trim());
        }

        bal.applyclass = ddlstclass.SelectedItem.Text;
        bal.classid = Convert.ToInt16(ddlstclass.SelectedValue);

        if (fileupload.HasFile)
        {
            string filename1 = Path.GetFileName(fileupload.PostedFile.FileName);
            string path = Server.MapPath("../StudentPhoto/");
            fileupload.SaveAs(Server.MapPath("../StudentPhoto/" + idstudent + filename1));
            bal.upload_student_image = idstudent + filename1;
        }
        else
        {
            bal.upload_student_image = "";
        }

        bal.transportation = Convert.ToInt16(Request.Form[rtransportation.UniqueID]);
        bal.nationality = txtFname.Text.Trim();
        bal.houseno = txthouseno.Text.Trim();
        bal.appartment = txtappartment.Text.Trim();
        bal.street = txtstreet.Text.Trim();
        if (txtland.Text.Trim() != "")
        {
            bal.landmark = txtland.Text.Trim();
        }
        else
        {
            bal.landmark = "";
        }

        bal.pincode = txtPZIP.Text.Trim();

        if (chkenglish.Checked && chkhindi.Checked && CheckBox1.Checked)
        {
            bal.languages_spoken = Request.Form[lblangid.UniqueID];
        }
        else

            if (chkenglish.Checked && chkhindi.Checked && (!(CheckBox1.Checked)))
            {
                bal.languages_spoken = Request.Form[lblangid.UniqueID];
            }
            else

                if (chkenglish.Checked && (!(chkhindi.Checked)) && ((CheckBox1.Checked)))
                {
                    bal.languages_spoken = Request.Form[lblangid.UniqueID];
                }
                else

                    if ((!(chkenglish.Checked)) && (!(chkhindi.Checked)) && (!(CheckBox1.Checked)))
                    {
                        bal.languages_spoken = "";
                    }
                    else

                        if ((!(chkenglish.Checked)) && (!(chkhindi.Checked)) && ((CheckBox1.Checked)))
                        {
                            bal.languages_spoken = Request.Form[lblangid.UniqueID];
                        }
                        else

                            if ((chkenglish.Checked) && (!(chkhindi.Checked)) && (!(CheckBox1.Checked)))
                            {
                                bal.languages_spoken = Request.Form[lblangid.UniqueID];
                            }

        bal.father_Name = txtfather.Text.Trim();
        bal.father_QualificatioID = Convert.ToInt16(ddlFQualifiaction1.SelectedValue);
        bal.father_Occupation = txtprofession.Text.Trim();

        if (TextBox3.Text == "")
        {
            bal.father_Organisation = "";
        }
        else
        {
            bal.father_Organisation = TextBox3.Text.Trim();
        }

        if (txtphoneno.Text == "")
        {
            bal.father_PhoneNo_Residential = "";
        }
        else
        {
            bal.father_PhoneNo_Residential = txtphoneno.Text.Trim();
        }

        if (TextBox5.Text == "")
        {
            bal.father_PhoneNo_Office = "";
        }
        else
        {
            bal.father_PhoneNo_Office = TextBox5.Text.Trim();
        }
        if (TextBox6.Text == "")
        {
            bal.father_MobileNo = "";
        }
        else
        {
            bal.father_MobileNo = TextBox6.Text.Trim();
        }
        if (txtemail.Text == "")
        {
            bal.father_Email = "";
        }
        else
        {
            bal.father_Email = txtemail.Text.Trim();
        }

        bal.mother_Name = TextBox7.Text.Trim();
        bal.mother_QualificatioID = Convert.ToInt16(ddlMQualifiaction1.SelectedValue);
        if (TextBox9.Text == "")
        {
            bal.mother_Occupation = "";
        }
        else
        {
            bal.mother_Occupation = TextBox9.Text.Trim();
        }

        if (TextBox10.Text == "")
        {
            bal.mother_Organisation = "";
        }
        else
        {
            bal.mother_Organisation = TextBox10.Text.Trim();
        }

        if (TextBox12.Text == "")
        {
            bal.mother_PhoneNo_Residential = "";
        }
        else
        {
            bal.mother_PhoneNo_Residential = TextBox12.Text.Trim();
        }

        if (TextBox14.Text == "")
        {
            bal.mother_PhoneNo_Office = "";
        }
        else
        {
            bal.mother_PhoneNo_Office = TextBox14.Text.Trim();
        }

        if (TextBox15.Text == "")
        {
            bal.mother_MobileNo = "";
        }
        else
        {
            bal.mother_MobileNo = TextBox15.Text.Trim();
        }
        if (TextBox16.Text == "")
        {
            bal.mother_Email = "";
        }
        else
        {
            bal.mother_Email = TextBox16.Text.Trim();
        }

        if (TextBox17.Text == "" && TextBox18.Text == "" && TextBox19.Text == "")
        {
            bal.SibName1 = "";
            bal.Sibage1 = "";
            bal.Sibschool1 = "";
        }
        else
        {
            bal.SibName1 = TextBox17.Text.Trim();
            bal.Sibage1 = TextBox18.Text;
            bal.Sibschool1 = TextBox19.Text;
        }

        if (TextBox20.Text == "" && TextBox21.Text == "" && TextBox22.Text == "")
        {
            bal.SibName2 = "";
            bal.Sibage2 = "";
            bal.Sibschool2 = "";
        }
        else
        {
            bal.SibName2 = TextBox20.Text.Trim();
            bal.Sibage2 = TextBox21.Text.Trim();
            bal.Sibschool2 = TextBox22.Text.Trim();
        }
        if (TextBox23.Text == "" && TextBox24.Text == "" && TextBox25.Text == "")
        {
            bal.SibName3 = "";
            bal.Sibage3 = "";
            bal.Sibschool3 = "";
        }
        else
        {
            bal.SibName3 = TextBox23.Text.Trim();
            bal.Sibage3 = TextBox24.Text.Trim();
            bal.Sibage3 = TextBox25.Text.Trim();
        }

        if (RadioButtonList1.SelectedItem.Text == "Yes")
        {
            bal.previous_schooling = 1;

            bal.previous_schooling_details = txtprevious.Text.Trim();
        }
        else
        {
            bal.previous_schooling = 0;

            bal.previous_schooling_details = "";
        }

        if (RadioButtonList4.SelectedItem.Text == "Yes")
        {
            bal.studybefore = 1;
        }
        else
        {
            bal.studybefore = 0;
        }

        bal.bloodid = Convert.ToInt16(ddlblood.SelectedValue);

        if (txtaliment.Text.Trim() != "")
        {
            bal.Specific_ailments_Suffered = txtaliment.Text.Trim();
        }
        else
        {
            bal.Specific_ailments_Suffered = "";
        }
        if (txtSurgery.Text.Trim() != "")
        {
            bal.Surgery_undergone = txtSurgery.Text.Trim();
        }
        else
        {
            bal.Surgery_undergone = "";
        }
        if (txtAllergies.Text.Trim() != "")
        {
            bal.Surgery_undergone = txtAllergies.Text.Trim();
        }
        else
        {
            bal.Surgery_undergone = "";
        }

        if (RadioButtonList2.SelectedValue == "1")
        {
            bal.regular_medication_status = 1;
            bal.regular_medication_Detial = txtspecify.Text.Trim();
        }
        else
        {
            bal.regular_medication_status = 0;
            bal.regular_medication_Detial = "";
        }

        if (RadioButtonList3.SelectedValue == "1")
        {
            bal.phobias_status = 1;
            bal.phobias_Detial = txtspecify1.Text.Trim();
        }
        else
        {
            bal.phobias_status = 0;
            bal.phobias_Detial = "";
        }

        if (txtinstruments.Text.Trim() != "")
        {
            bal.Any_specific_Instruction = txtinstruments.Text.Trim();
        }
        else
        {
            bal.Any_specific_Instruction = "";
        }

        if (txtname1.Text.Trim() != "" && txtcontact1.Text.Trim() != "")
        {
            bal.EMERGENCY_CONTACT_name1 = txtname1.Text.Trim();
            bal.EMERGENCY_mobileno1 = txtcontact1.Text.Trim();
        }
        else
        {
            bal.EMERGENCY_CONTACT_name1 = "";
            bal.EMERGENCY_mobileno1 = "";
        }

        if (txtname2.Text.Trim() != "" && txtcontact2.Text.Trim() != "")
        {
            bal.EMERGENCY_CONTACT_name2 = txtname2.Text.Trim();
            bal.EMERGENCY_mobileno2 = txtcontact2.Text.Trim();
        }
        else
        {
            bal.EMERGENCY_CONTACT_name1 = "";
            bal.EMERGENCY_mobileno1 = "";
        }

        if (filesig.HasFile)
        {
            string filename = Path.GetFileName(filesig.PostedFile.FileName);
            string path = Server.MapPath("../StudentPhoto/");
            filesig.SaveAs(Server.MapPath("../StudentPhoto/" + idstudent + filename));
            bal.signature_upolad = idstudent + filename;
        }
        else
        {
            bal.signature_upolad = "";
        }

        bal.name_of_signee = TextBox30.Text.Trim();
        bal.relation_to_child = TextBox28.Text.Trim();
        bal.signaturedate = Convert.ToDateTime(txtDate.Text.Trim());

        foreach (GridViewRow gvrow in grdimmuni.Rows)
        {
            HiddenField lblid = (HiddenField)gvrow.FindControl("hd1");
            RadioButtonList lblcheck = (RadioButtonList)gvrow.FindControl("rbgender");

            imuniid = imuniid + "," + lblid.Value;
            rcheck = rcheck + "," + lblcheck.SelectedValue;
        }

        imuniid = imuniid.Remove(0, 1);
        rcheck = rcheck.Remove(0, 1);

        bal.vaccination_id = imuniid;
        bal.vaccination_name = rcheck;

        bal.feeid = Request.Form[lblfeeid1.UniqueID];
        bal.FeeName = Request.Form[lblfeename1.UniqueID];
        bal.FeeAmount = Request.Form[lblfeeamout1.UniqueID];
        bal.Discount = Request.Form[lbldis1.UniqueID];
        bal.ckdisid = Request.Form[lblcheck1.UniqueID];
        bal.paymodeid = ddlPayMode.SelectedValue;

        if (ddlPayMode.SelectedIndex > 0)
        {
            bal.bankname = txtBankName.Text.Trim();
            bal.checkno = txtCheque.Text.Trim();
        }
        else
        {
            bal.bankname = "";
            bal.checkno = "";
        }

        bal.payableamt = Convert.ToDouble(txtpayablefee.Text.Trim());
        bal.paynowamount = Convert.ToDouble(txtpaimat.Text.Trim());
        bal.monthids = Request.Form[paymonthsidshide.UniqueID];
        bal.mode = "admissiontime";
        bal.Fqualification_other = txtqualification.Text.Trim();

        if (txtemergencyaddress1.Text.Trim() != "")
        {
            bal.emergency_address1 = txtemergencyaddress1.Text.Trim();
        }
        else
        {
            bal.emergency_address1 = "";
        }
        if (txtemergencyaddress2.Text.Trim() != "")
        {
            bal.emergency_address2 = txtemergencyaddress2.Text.Trim();
        }
        else
        {
            bal.emergency_address2 = "";
        }

        bal.mother_other = txtmqualification.Text.Trim();
        bal.section = ddlssection.SelectedItem.Text;
        bal.sectionid = Convert.ToInt16(ddlssection.SelectedValue);
        bal.paytypeID = Convert.ToInt16(ddlpaystatus.SelectedValue);
        bal.paytypename = ddlpaystatus.SelectedItem.Text.Trim();
        bal.feepaynow = "PAYNOW";

        Session["pnow"] = "PAYNOW";

        double count = objUserBLL.InsertstUdentInformation(bal);
        if (count > 0)
        {
            Response.Redirect("AdmissionConfirm.aspx?adid=" + count);
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Network error!!.. please try after some time or refresh page.......!");
            return;
        }
    }

    protected void Button6_Click(object sender, EventArgs e)
    {
        idstudent = objUserBLL.getstudentid();
        //string pname = "usp_StuAdmission";
        bal.brid = Convert.ToInt16(Session["BrBrid"]);
        bal.branchname = Convert.ToString(Session["Brusername"]);
        bal.student_first_name = txtName.Text.Trim();
        bal.student_mid_name = txtmidname.Text.Trim();
        bal.student_Last_name = txtLName.Text.Trim();
        bal.admission_Date = ddlYear.SelectedItem.Text + "-" + ddlMonth.SelectedValue + "-" + Request.Form[hdate.UniqueID];

        bal.date_of_Birth = Convert.ToDateTime(txtToDate.Text.Trim());
        //
        bal.gender = Convert.ToInt16(rbgender.SelectedValue);
        bal.student_age = "";
        if (TextBox1.Text == "")
        {
            bal.height = 0;
        }
        else
        {
            bal.height = Convert.ToDouble(TextBox1.Text.Trim());
        }

        if (TextBox2.Text == "")
        {
            bal.weight = 0;
        }
        else
        {
            bal.weight = Convert.ToDouble(TextBox2.Text.Trim());
        }

        bal.applyclass = ddlstclass.SelectedItem.Text;
        bal.classid = Convert.ToInt16(ddlstclass.SelectedValue);

        if (fileupload.HasFile)
        {
            string filename1 = Path.GetFileName(fileupload.PostedFile.FileName);
            string path = Server.MapPath("../StudentPhoto/");
            fileupload.SaveAs(Server.MapPath("../StudentPhoto/" + idstudent + filename1));
            bal.upload_student_image = idstudent + filename1;
        }
        else
        {
            bal.upload_student_image = "";
        }

        bal.transportation = Convert.ToInt16(Request.Form[rtransportation.UniqueID]);
        bal.nationality = txtFname.Text.Trim();
        bal.houseno = txthouseno.Text.Trim();
        bal.appartment = txtappartment.Text.Trim();
        bal.street = txtstreet.Text.Trim();
        if (txtland.Text.Trim() != "")
        {
            bal.landmark = txtland.Text.Trim();
        }
        else
        {
            bal.landmark = "";
        }

        bal.pincode = txtPZIP.Text.Trim();

        if (chkenglish.Checked && chkhindi.Checked && CheckBox1.Checked)
        {
            bal.languages_spoken = Request.Form[lblangid.UniqueID];
        }
        else

            if (chkenglish.Checked && chkhindi.Checked && (!(CheckBox1.Checked)))
            {
                bal.languages_spoken = Request.Form[lblangid.UniqueID];
            }
            else

                if (chkenglish.Checked && (!(chkhindi.Checked)) && ((CheckBox1.Checked)))
                {
                    bal.languages_spoken = Request.Form[lblangid.UniqueID];
                }
                else

                    if ((!(chkenglish.Checked)) && (!(chkhindi.Checked)) && (!(CheckBox1.Checked)))
                    {
                        bal.languages_spoken = "";
                    }
                    else

                        if ((!(chkenglish.Checked)) && (!(chkhindi.Checked)) && ((CheckBox1.Checked)))
                        {
                            bal.languages_spoken = Request.Form[lblangid.UniqueID];
                        }
                        else

                            if ((chkenglish.Checked) && (!(chkhindi.Checked)) && (!(CheckBox1.Checked)))
                            {
                                bal.languages_spoken = Request.Form[lblangid.UniqueID];
                            }

        bal.father_Name = txtfather.Text.Trim();
        bal.father_QualificatioID = Convert.ToInt16(ddlFQualifiaction1.SelectedValue);
        bal.father_Occupation = txtprofession.Text.Trim();

        if (TextBox3.Text == "")
        {
            bal.father_Organisation = "";
        }
        else
        {
            bal.father_Organisation = TextBox3.Text.Trim();
        }

        if (txtphoneno.Text == "")
        {
            bal.father_PhoneNo_Residential = "";
        }
        else
        {
            bal.father_PhoneNo_Residential = txtphoneno.Text.Trim();
        }

        if (TextBox5.Text == "")
        {
            bal.father_PhoneNo_Office = "";
        }
        else
        {
            bal.father_PhoneNo_Office = TextBox5.Text.Trim();
        }
        if (TextBox6.Text == "")
        {
            bal.father_MobileNo = "";
        }
        else
        {
            bal.father_MobileNo = TextBox6.Text.Trim();
        }
        if (txtemail.Text == "")
        {
            bal.father_Email = "";
        }
        else
        {
            bal.father_Email = txtemail.Text.Trim();
        }

        bal.mother_Name = TextBox7.Text.Trim();
        bal.mother_QualificatioID = Convert.ToInt16(ddlMQualifiaction1.SelectedValue);
        if (TextBox9.Text == "")
        {
            bal.mother_Occupation = "";
        }
        else
        {
            bal.mother_Occupation = TextBox9.Text.Trim();
        }

        if (TextBox10.Text == "")
        {
            bal.mother_Organisation = "";
        }
        else
        {
            bal.mother_Organisation = TextBox10.Text.Trim();
        }

        if (TextBox12.Text == "")
        {
            bal.mother_PhoneNo_Residential = "";
        }
        else
        {
            bal.mother_PhoneNo_Residential = TextBox12.Text.Trim();
        }

        if (TextBox14.Text == "")
        {
            bal.mother_PhoneNo_Office = "";
        }
        else
        {
            bal.mother_PhoneNo_Office = TextBox14.Text.Trim();
        }

        if (TextBox15.Text == "")
        {
            bal.mother_MobileNo = "";
        }
        else
        {
            bal.mother_MobileNo = TextBox15.Text.Trim();
        }
        if (TextBox16.Text == "")
        {
            bal.mother_Email = "";
        }
        else
        {
            bal.mother_Email = TextBox16.Text.Trim();
        }

        if (TextBox17.Text == "" && TextBox18.Text == "" && TextBox19.Text == "")
        {
            bal.SibName1 = "";
            bal.Sibage1 = "";
            bal.Sibschool1 = "";
        }
        else
        {
            bal.SibName1 = TextBox17.Text.Trim();
            bal.Sibage1 = TextBox18.Text;
            bal.Sibschool1 = TextBox19.Text;
        }

        if (TextBox20.Text == "" && TextBox21.Text == "" && TextBox22.Text == "")
        {
            bal.SibName2 = "";
            bal.Sibage2 = "";
            bal.Sibschool2 = "";
        }
        else
        {
            bal.SibName2 = TextBox20.Text.Trim();
            bal.Sibage2 = TextBox21.Text.Trim();
            bal.Sibschool2 = TextBox22.Text.Trim();
        }
        if (TextBox23.Text == "" && TextBox24.Text == "" && TextBox25.Text == "")
        {
            bal.SibName3 = "";
            bal.Sibage3 = "";
            bal.Sibschool3 = "";
        }
        else
        {
            bal.SibName3 = TextBox23.Text.Trim();
            bal.Sibage3 = TextBox24.Text.Trim();
            bal.Sibage3 = TextBox25.Text.Trim();
        }

        if (RadioButtonList1.SelectedItem.Text == "Yes")
        {
            bal.previous_schooling = 1;

            bal.previous_schooling_details = txtprevious.Text.Trim();
        }
        else
        {
            bal.previous_schooling = 0;

            bal.previous_schooling_details = "";
        }

        if (RadioButtonList4.SelectedItem.Text == "Yes")
        {
            bal.studybefore = 1;
        }
        else
        {
            bal.studybefore = 0;
        }

        bal.bloodid = Convert.ToInt16(ddlblood.SelectedValue);

        if (txtaliment.Text.Trim() != "")
        {
            bal.Specific_ailments_Suffered = txtaliment.Text.Trim();
        }
        else
        {
            bal.Specific_ailments_Suffered = "";
        }
        if (txtSurgery.Text.Trim() != "")
        {
            bal.Surgery_undergone = txtSurgery.Text.Trim();
        }
        else
        {
            bal.Surgery_undergone = "";
        }
        if (txtAllergies.Text.Trim() != "")
        {
            bal.Surgery_undergone = txtAllergies.Text.Trim();
        }
        else
        {
            bal.Surgery_undergone = "";
        }

        if (RadioButtonList2.SelectedValue == "1")
        {
            bal.regular_medication_status = 1;
            bal.regular_medication_Detial = txtspecify.Text.Trim();
        }
        else
        {
            bal.regular_medication_status = 0;
            bal.regular_medication_Detial = "";
        }

        if (RadioButtonList3.SelectedValue == "1")
        {
            bal.phobias_status = 1;
            bal.phobias_Detial = txtspecify1.Text.Trim();
        }
        else
        {
            bal.phobias_status = 0;
            bal.phobias_Detial = "";
        }

        if (txtinstruments.Text.Trim() != "")
        {
            bal.Any_specific_Instruction = txtinstruments.Text.Trim();
        }
        else
        {
            bal.Any_specific_Instruction = "";
        }

        if (txtname1.Text.Trim() != "" && txtcontact1.Text.Trim() != "")
        {
            bal.EMERGENCY_CONTACT_name1 = txtname1.Text.Trim();
            bal.EMERGENCY_mobileno1 = txtcontact1.Text.Trim();
        }
        else
        {
            bal.EMERGENCY_CONTACT_name1 = "";
            bal.EMERGENCY_mobileno1 = "";
        }

        if (txtname2.Text.Trim() != "" && txtcontact2.Text.Trim() != "")
        {
            bal.EMERGENCY_CONTACT_name2 = txtname2.Text.Trim();
            bal.EMERGENCY_mobileno2 = txtcontact2.Text.Trim();
        }
        else
        {
            bal.EMERGENCY_CONTACT_name1 = "";
            bal.EMERGENCY_mobileno1 = "";
        }

        if (filesig.HasFile)
        {
            string filename = Path.GetFileName(filesig.PostedFile.FileName);
            string path = Server.MapPath("../StudentPhoto/");
            filesig.SaveAs(Server.MapPath("../StudentPhoto/" + idstudent + filename));
            bal.signature_upolad = idstudent + filename;
        }
        else
        {
            bal.signature_upolad = "";
        }

        bal.name_of_signee = TextBox30.Text.Trim();
        bal.relation_to_child = TextBox28.Text.Trim();
        bal.signaturedate = Convert.ToDateTime(txtDate.Text.Trim());

        foreach (GridViewRow gvrow in grdimmuni.Rows)
        {
            HiddenField lblid = (HiddenField)gvrow.FindControl("hd1");
            RadioButtonList lblcheck = (RadioButtonList)gvrow.FindControl("rbgender");

            imuniid = imuniid + "," + lblid.Value;
            rcheck = rcheck + "," + lblcheck.SelectedValue;
        }

        imuniid = imuniid.Remove(0, 1);
        rcheck = rcheck.Remove(0, 1);

        bal.vaccination_id = imuniid;
        bal.vaccination_name = rcheck;

        bal.feeid = "";
        bal.FeeName = "";
        bal.FeeAmount = "";
        bal.Discount = "";
        bal.ckdisid = "";
        bal.paymodeid = ddlPayMode.SelectedValue;

        if (ddlPayMode.SelectedIndex > 0)
        {
            bal.bankname = txtBankName.Text.Trim();
            bal.checkno = txtCheque.Text.Trim();
        }
        else
        {
            bal.bankname = "";
            bal.checkno = "";
        }

        bal.payableamt = Convert.ToDouble(0);
        bal.paynowamount = Convert.ToDouble(0);
        bal.monthids = "";
        bal.mode = "admissiontime";
        bal.Fqualification_other = txtqualification.Text.Trim();

        if (txtemergencyaddress1.Text.Trim() != "")
        {
            bal.emergency_address1 = txtemergencyaddress1.Text.Trim();
        }
        else
        {
            bal.emergency_address1 = "";
        }
        if (txtemergencyaddress2.Text.Trim() != "")
        {
            bal.emergency_address2 = txtemergencyaddress2.Text.Trim();
        }
        else
        {
            bal.emergency_address2 = "";
        }

        bal.mother_other = txtmqualification.Text.Trim();
        bal.section = ddlssection.SelectedItem.Text;
        bal.sectionid = Convert.ToInt16(ddlssection.SelectedValue);
        bal.paytypeID = 1;
        bal.paytypename = "Quarterly";
        bal.feepaynow = "NOTNOW";
        Session["pnow"] = "NOTNOW";

        double count = objUserBLL.InsertstUdentInformation(bal);
        if (count > 0)
        {
            Response.Redirect("AdmissionConfirm.aspx?adid=" + count);
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Network error!!.. please try after some time or refresh page.......!");
            return;
        }
    }

    [WebMethod]
    public static ProductMasterDetails[] binclass()
    {
        List<ProductMasterDetails> details = new List<ProductMasterDetails>();
        DataTable dt = new DataTable();
        dt = BLL.getclass(Convert.ToInt16(HttpContext.Current.Session["BrBrid"]));

        ProductMasterDetails objProductMasterDetails0 = new ProductMasterDetails();
        objProductMasterDetails0.SID = Convert.ToInt32("0");
        objProductMasterDetails0.statename = "-Select Class-";
        details.Add(objProductMasterDetails0);

        foreach (DataRow dtrow in dt.Rows)
        {
            ProductMasterDetails objProductMasterDetails = new ProductMasterDetails();
            objProductMasterDetails.SID = Convert.ToInt32(dtrow["classid"].ToString());
            objProductMasterDetails.statename = dtrow["Classname"].ToString();
            details.Add(objProductMasterDetails);
        }

        return details.ToArray();
    }

    public class ProductMasterDetails
    {
        public int SID { get; set; }

        public string statename { get; set; }
    }
}