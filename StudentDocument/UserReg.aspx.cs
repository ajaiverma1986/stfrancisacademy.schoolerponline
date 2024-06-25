using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography; // Import this Dll


public partial class UserReg : System.Web.UI.Page
{
    private string url = "", pname = "", filename, path, query, query1, query2, query3, queryArea, querySubarea;
    private int idStudent = 0, count = 0, count1 = 0;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    //private DataUtility_SH objdut = new DataUtility_SH();
    private DataTable dt, dtarea, dtsubarea;
    public static int enquiryid = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillBranch();
            //SchoolName.InnerHtml = Convert.ToString(objdut.GetScalar("select isnull(BrName,'') SchoolName from Branch_master where brid=" + Session["BrBrid"]));

            fillLog();
            Session["CheckSameEntry"] = null;
            if (Request.QueryString.Count > 0)
            {
                School();
                enquiryid = Convert.ToInt32(Request.QueryString[0]);
                fillenqurydetail(Convert.ToInt32(Request.QueryString[0]));
            }
            //School();
            fillsource();
            fillarea();
           // getRollNo();
            fillrelation();
            filltitle();
            BindSessionDDL();
            BindClass();
            getrecieptgenraldetails();
            //fillQualification();
        }
    }
    public void fillLog() {
        schoolName2.InnerHtml = Convert.ToString(objdut.GetScalar("select isnull(BrName,'') SchoolName from Branch_master where brid=" + ddlBrid.SelectedValue + ""));
        string imgsrc = Convert.ToString(objdut.GetScalar("select photo from Branch_master where brid=" + ddlBrid.SelectedValue + ""));
        if (imgsrc != "")
        {

            string[] data = imgsrc.Split('^');
            if (data.Length > 0)
            {
                btnlogoforrecipt.ImageUrl = "~/BranchPanel/images/" + data[0];
                btnlogoforrecipt.Style.Add("background", data[0]);
                favicon.Href = "images/" + data[0];

                Image2.ImageUrl = "~/BranchPanel/images/" + data[0];
                Image2.Style.Add("background", data[0]);
            }
            else
            {
                btnlogoforrecipt.ImageUrl = "~/images/9update.png";
                Image2.ImageUrl = "../../images/9update.png";
                favicon.Href = "images/9update.png";
            }
        }
        else
        {
            btnlogoforrecipt.ImageUrl = "~/images/9update.png";
            Image2.ImageUrl = "~/images/9update.png";
            favicon.Href = "images/9update.png";
        }
    }
    private void getrecieptgenraldetails()
    {
        string value = "";
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 10);
        value = objdut.GetScalerSP(param, "[usp_general_master_setting]").ToString();
        string[] getdata = value.Split('~');
        string isbranch = getdata[0];
        string address = "", serviceno = "", Ph = "", mobile = "", Contact = "", EmailID = "", tin = "", SchoolAffi = "", Website = "";
        //serviceno = Convert.ToString(objdut.GetScalar("select isnull(Service_tax_no,'') Service_tax_no  from tbl_institutemaster"));
        //tin = Convert.ToString(objdut.GetScalar("select TIN  from tbl_institutemaster"));
        //institutename = Convert.ToString(objdut.GetScalar("select institute_name from tbl_institutemaster"));
        //if (isbranch == "2")
        //{
        string branchdata = Convert.ToString(objdut.GetScalar(@"select BrAddress+','+City+' - '+pincode+', '+state+', '+Country+'^'+
            LandLineNo+','+MobileNo+'^'+Emailid+'^'+isnull(Website,'')+'^'+isnull(SchoolAffi,'') from branch_master where brid = " + ddlBrid.SelectedValue + ""));
        string[] getbranchdata = branchdata.Split('^');
        address = getbranchdata[0];

        string[] getCont;
        Contact = getbranchdata[1];
        getCont = Contact.Split(',');
        Ph = getCont[0].ToString();
        mobile = getCont[1].ToString();
        EmailID = getbranchdata[2].ToString();
        Website = getbranchdata[3].ToString();
        SchoolAffi = getbranchdata[4].ToString();

        spanaddress.Text = address;
        lblcontact.Text = Ph.ToString();
        lblMob.Text = mobile.ToString();
        lblEmailID.Text = EmailID.ToString();
        lblSchoolAffi.Text = SchoolAffi.Trim();
        lblservicetax.Text = Website.Trim();

        //}
        //else
        //{
        //    mobile = Convert.ToString(objdut.GetScalar("select Landline from tbl_institutemaster"));
        //    address = Convert.ToString(objdut.GetScalar("select address  from tbl_institutemaster"));
        //}

        //        string permission = Convert.ToString(objdut.GetScalar(@"select servicenumber+'~'+is_tin+'~'+contact+'~'+is_address from tbl_recieptsettingcenter
        //                                                   where brid ='" + Session["brbrid"] + "'"));
        //        string[] recieptpermissions = permission.Split('~');
        //        if (recieptpermissions[0] == "1")
        //        {
        //            insservicetaxno.Style.Add("display", "block");
        //            lblservicetax.Text = serviceno.ToString();
        //            lblserviceno.Text = serviceno.ToString();
        //            stuservicetaxno.Style.Add("display", "block");
        //        }
        //        if (recieptpermissions[1] == "1")
        //        {
        //            instin.Style.Add("display", "block");
        //            lbltin.Text = tin.ToString();
        //            tinno.Text = tin.ToString();
        //            stutin.Style.Add("display", "block");
        //        }
        //        if (recieptpermissions[2] == "1")
        //        {
        //            inscontact.Style.Add("display", "block");
        //            lblcontact.Text = mobile.ToString();
        //            contact.Text = mobile.ToString();
        //            stucontact.Style.Add("display", "block");
        //        }
        //        if (recieptpermissions[3] == "1")
        //        {
        //            insaddress.Style.Add("display", "block");
        //            spanaddress.Text = address.ToString();
        //            lbladdress.Text = address.ToString();
        //            stuinsaddress.Style.Add("display", "block");
        //        }
    }
    [WebMethod]
    public static string ProcessIT(int ClassId, int Fyid, int Brid)
    {
        DataUtility Objdut = new DataUtility();
        string Query = "Select Convert(Decimal(10,2),Fees) From classfee_master Where Brid=" + Brid + " And Fyid=" + Fyid + " And Status=1 And FeeId=(Select Id From feestructure Where Fyid=" + Fyid + " And Status=1 And Id=6)";
        return (Convert.ToString(Objdut.GetScalar(Query)));
    }
    public class BIndClass
    {
        public string ID { get; set; }

        public string ClassName { get; set; }
    }
    [WebMethod]
    public static BIndClass[] BindClassDDL(string Fyid, int Brid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(Fyid), Convert.ToInt32(Brid));
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
    public void fillBranch()
    {
        string Str = "";
        DataTable Dt = new DataTable();
        Str = "Select BrId,BrName from Branch_master where BrActive=1";
        Dt = objdut.GetDataTable(Str);
        if (Dt.Rows.Count > 0)
        {
            ddlBrid.DataSource = Dt;
            ddlBrid.DataTextField = "BrName";
            ddlBrid.DataValueField = "BrId";
            ddlBrid.DataBind();
            //ddlBrid.Items.Insert(0, new ListItem("0", "Select Branch"));
        }

    }

    //protected void fillQualification()
    //{
    //    DataTable Dt = new DataTable();
    //    Dt = objdut.GetDataTable("select * from tblQualification where status=1");
    //    ddlqualification1.DataSource = Dt;
    //    ddlqualification1.DataValueField = "qid";
    //    ddlqualification1.DataTextField = "name";
    //    ddlqualification1.DataBind();
    //}
    protected void fillrelation()
    {
        DataTable Dt = objdut.GetDataTable("Select id,Relation from Relation_Master");
        if (Dt.Rows.Count > 0)
        {
            ddlrel.DataSource = Dt;
            ddlrel.DataTextField = "Relation";
            ddlrel.DataValueField = "Id";
            ddlrel.DataBind();
        }
    }

    protected void filltitle()
    {
        DataTable Dt = objdut.GetDataTable("select Titleid,Title from Title where status=1");
        if (Dt.Rows.Count > 0)
        {
            ddltitle.DataSource = Dt;
            ddltitle.DataTextField = "Title";
            ddltitle.DataValueField = "Titleid";
            ddltitle.DataBind();
        }
        ddltitle.Items.Insert(0, new ListItem("--Select Title--", "0"));
    }
    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlregistrationsession.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlregistrationsession.DataValueField = "Fyid";
        ddlregistrationsession.DataTextField = "FYName";
        ddlregistrationsession.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlregistrationsession.SelectedValue = Convert.ToString(3);
        ddlregistrationsession.Enabled = false;
    }
    public void BindClass()
    {
        DataTable Dt = new DataTable();
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(ddlregistrationsession.SelectedValue), Convert.ToInt32(ddlBrid.SelectedValue));
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
    protected void fillarea()
    {
        dtarea = CommonClass.ABC("studentarea");
        if (dtarea.Rows.Count > 0)
        {
            ddlArea1.DataSource = dtarea;
            ddlArea1.DataTextField = "areaname";
            ddlArea1.DataValueField = "areaid";
            ddlArea1.DataBind();
            ddlArea1.Items.Insert(0, new ListItem("-Select Area-", "0"));
            ddlArea2.Items.Insert(0, new ListItem("-Select Sub area-", "0"));
        }
        ddlState.DataSource = CommonClass.ABC1("Statedll", 96);
        ddlState.DataTextField = "stateName";
        ddlState.DataValueField = "SID";
        ddlState.DataBind();
        ddlState.Items.Insert(0, new ListItem("--Select State--", "0"));
        ddlState.SelectedValue = "7";
        //ddlCity.Items.Insert(0, new ListItem("--Select City--", "0"));
        ddlCity.DataSource = CommonClass.ABC1("Citydll", 7);
        ddlCity.DataTextField = "cityName";
        ddlCity.DataValueField = "ctid";
        ddlCity.DataBind();
        ddlCity.Items.Insert(0, new ListItem("--Select City--", "0"));
        ddlCity.SelectedValue = "110";
        ddlArea1.SelectedValue = "1";
    }

    private void getRollNo()
    {
        SqlParameter[] param = new SqlParameter[4];
        param[0] = new SqlParameter("@brid", Session["BrBrid"]);
        param[1] = new SqlParameter("@intresult", SqlDbType.Int);
        param[1].Direction = ParameterDirection.Output;
        param[2] = new SqlParameter("@rollas", SqlDbType.VarChar, 500);
        param[2].Direction = ParameterDirection.Output;
        param[3] = new SqlParameter("@IsFranchisee", Session["IsFranchisee"]);
        ViewState["sturollno"] = objdut.GetScalerSP(param, "getAdmissionNo");
        if (Convert.ToInt32(param[1].Value) == 2)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(),
                  "script", @"var a=confirm('Please first Add Branch Code in Master Setting For Roll Number Setting Then You can Add Student.?');
                      if (a==true) {location.replace('../Common/Default.aspx');}
                    else{location.replace('../Common/Default.aspx');}", true);
            return;
        }
        txtRollNo.Text = ViewState["sturollno"].ToString();
    }

    private void fillsource()
    {
        dt = CommonClass.ABC("enquirysource");
        if (dt.Rows.Count > 0)
        {
            DropDownList1.DataSource = dt;
            DropDownList1.DataTextField = "EnquirySource";
            DropDownList1.DataValueField = "id";
            DropDownList1.DataBind();
            DropDownList1.Items.Insert(0, new ListItem("-Select Student Source-", "0"));
        }
        else
        {
            DropDownList1.Items.Insert(0, new ListItem("-Select Student Source-", "0"));
        }
    }

    protected void School()
    {
        dt = CommonClass.ABC("stuschool");
        if (dt.Rows.Count > 0)
        {
            ddlsChool.DataSource = dt;
            ddlsChool.DataTextField = "schoolname";
            ddlsChool.DataValueField = "schoolid";
            ddlsChool.DataBind();
            ddlsChool.Items.Insert(0, new ListItem("--Select School/College--", "0"));
        }
        else
        {
            ddlsChool.Items.Insert(0, new ListItem("--Select School/College--", "0"));
        }
    }

    [WebMethod]
    public static int Getemailid(string emailid)
    {
        DataUtility ObjDUT = new DataUtility();
        string q = "select COUNT(sturegno) from student_master where email= '" + emailid + "' ";
        int count = Convert.ToInt32(ObjDUT.GetScalar(q));
        return count;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        ClientScriptManager CSM = Page.ClientScript;
        string UserName = "", Password = "";
        string fname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtFiName.Text.Trim());
        string mname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtMname.Text.Trim());
        string lname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(txtLName.Text.Trim());

        idStudent = Convert.ToInt32(objdut.GetScalar("select isnull(max(RID),0)+1 from tbl_studentregistration where brid=" + Convert.ToInt32(ddlBrid.SelectedValue)));
        if (Convert.ToString(idStudent) == "")
        {
            idStudent = 1;
        }
        string tempFname = "";
        Random a = new Random();
        var bytes = new byte[4];
        var rng = RandomNumberGenerator.Create();
        rng.GetBytes(bytes);
        uint random = BitConverter.ToUInt32(bytes, 0) % 100000000;
        if (fname.Length > 3)
        {
            tempFname = fname.ToString().Substring(0, 4);
        }
        else {
            tempFname = fname.ToString();
        }
        UserName = tempFname.ToString() + idStudent.ToString() + ddlBrid.SelectedValue.ToString() ;

        Password = tempFname.ToString() + String.Format("{0:D8}", random).ToString();
        string gFirstname = "", gsecondname = "", glastname = "";
        if (txtgname.Text.Contains(" "))
        {
            string[] namearr = txtgname.Text.Split(' ');
            if (namearr.Length > 2)
            {
                gFirstname = namearr[0];
                gsecondname = namearr[1];
                glastname = namearr[2];
            }
            else if (namearr.Length > 1)
            {
                gFirstname = namearr[0];
                gsecondname = namearr[1];                
            }
            else
            {
                gFirstname = namearr[0];
            }
        }
        else
        {
            gFirstname = txtgname.Text;
        }
        Session["UserBrid"] = ddlBrid.SelectedValue;
        SqlParameter[] param = new SqlParameter[26];
        param[0] = new SqlParameter("@Fyid", Convert.ToInt32(ddlregistrationsession.SelectedValue));
        param[1] = new SqlParameter("@brid", Convert.ToInt32(ddlBrid.SelectedValue));
        param[2] = new SqlParameter("@branchname", ddlBrid.SelectedItem.Text.ToString());
        param[3] = new SqlParameter("@firstname", fname);
        if (!string.IsNullOrEmpty(txtMname.Text))
        {
            param[4] = new SqlParameter("@middlename", mname);
        }
        else
        {
            param[4] = new SqlParameter("@middlename", "");
        }
        param[5] = new SqlParameter("@lastname", lname);
        param[6] = new SqlParameter("@dateofbirth", txtdob1.Value);
        param[7] = new SqlParameter("@gender", rbgender.SelectedValue);
        param[8] = new SqlParameter("@mobile", txtmob.Text.Trim());
        param[9] = new SqlParameter("@parentType", ddlrel.SelectedValue);
        param[10] = new SqlParameter("@ParentName", txtgname.Text.Trim());
        param[11] = new SqlParameter("@UserName", UserName.Trim());
        param[12] = new SqlParameter("@Password", Password.Trim());
        param[13] = new SqlParameter("@ClasssID", ddlapplyingforclass.SelectedValue);
        if (fuPhoto.HasFile)
        {
            fuPhoto.PostedFile.SaveAs(Server.MapPath("~/BranchPanel/Student-Registration/student-registration-document/" + fuPhoto.FileName + Convert.ToString(idStudent)));
            param[14] = new SqlParameter("@PrimaryUploadParentPhotograph", fuPhoto.FileName + Convert.ToString(idStudent));
        }
        else
        {
            param[14] = new SqlParameter("@PrimaryUploadParentPhotograph", "");
        }
        param[15] = new SqlParameter("@PrimaryParentFirstName", gFirstname.Trim());
        param[16] = new SqlParameter("@PrimaryParentMiddleName", gsecondname.Trim());
        param[17] = new SqlParameter("@PrimaryParentLastName", glastname.Trim());
        param[18] = new SqlParameter("@PrimaryAddress", txtaddress.InnerText.Trim());
        param[19] = new SqlParameter("@PrimaryCity", txtcity.Text.Trim());
        param[20] = new SqlParameter("@PrimaryState", txtcountry.Text.Trim());
        param[21] = new SqlParameter("@PrimaryPinZipCode", txtpiorzipcode.Text.Trim());
        param[22] = new SqlParameter("@PrimaryCountry", txtcountry.Text.Trim());
        param[23] = new SqlParameter("@rid", idStudent);
        param[24] = new SqlParameter("@regnum", UserName.Trim());
        param[25] = new SqlParameter("@intResult", Convert.ToInt32(0));
        param[25].Direction = ParameterDirection.Output;
        
        objdut.ExecuteSqlSP(param, "Usp_NewReg");

        count = Convert.ToInt32(param[25].Value);
        //count = objdut.ExecuteSqlSP(param, pname);
        if (count == 1)
        {
            query2 = "Select 'UserName : '+isnull(username,'')+' Password : '+isnull(password,'') from student_login SL " +
                //"inner join student_master SM on SL.brid = SM.brid and SL.StuRegNo = SM.StuRegNo " +
                        "where UserName='" + UserName.Trim() + "' and Password='" + Password + "'";

            string msg = "";
            string LoginDetal = Convert.ToString(objdut.GetScalar(query2));
            msg = "Your are Successfully Registered ! Your Login Detail are : " + LoginDetal + ".";
            try
            {
                //System.Threading.Thread ThreadUpdateGrowthMocha = new System.Threading.Thread(delegate()
                //{
                //    if (Convert.ToString(LoginDetal) != "")
                //    {
                sendMessageToMobile.SMSsendForSend(Convert.ToString(txtmob.Text.Trim()), Convert.ToString(msg), ddlBrid.SelectedValue);
                //    }
                //});
                //ThreadUpdateGrowthMocha.Start();
            }
            catch (Exception expformessage)
            {
                Utility.ViewAlertMessage(this, expformessage.Message);
            }
            //ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "Key", "<script language='javascript'>alert('You are Successfully Registered and Login Detail sent to your Moblile!!');</script>", false);
            //Utility.ViewAlertMessage(this.Master.Page, "You are Successfully Registered and Login Detail sent to your Moblile!!");


            
            if (!ReturnValue())
            {
                string strconfirm = "<script>if(!window.confirm('" + msg + "')){window.location.href='user-login.aspx'}else{window.location.href='/StudentPanel/RegistrationForm.aspx?REG=" + UserName.Trim() + "'}</script>";
                CSM.RegisterClientScriptBlock(this.GetType(), "Confirm", strconfirm, false);
            }
        }
        else if (count==-1)
        {
            string strconfirm = "<script>alert('Duplicate mobile number or Registration id')</script>";
            CSM.RegisterClientScriptBlock(this.GetType(), "Confirm", strconfirm, false);
        }
    }
    bool ReturnValue()
    {
        return false;
    }
    private void SendStudentloginDetail(int sturegno)
    {
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@Mode", 4);
        param[1] = new SqlParameter("@Commanid", sturegno);
        param[2] = new SqlParameter("@IsFranchisee", Convert.ToInt32(Session["IsFranchisee"]));
        DataTable dt = objdut.GetDataTableSP(param, "usp_CommanprocforSendSMS");
        if (dt.Rows.Count > 0)
        {
            sendMessageToMobile.SMSSend(dt.Rows[0]["Mobile"].ToString(), "", dt.Rows[0]["Message"].ToString(), Convert.ToInt32(dt.Rows[0]["ApiType"]));
        }
    }

    protected void reset()
    {
        txtRollNo.Text = "";
        txtdob.Text = "";
        txtPAddress.Text = "";
        txtmob.Text = "";
        txtMname.Text = "";
        txtLName.Text = "";
        txtFiName.Text = "";
        txtFEmailid.Text = "";
        DropDownList1.SelectedIndex = 0;
        DateTimeLabel.Text = "";
        rbgender.SelectedValue = "1";
        DropDownList1.SelectedValue = "0";
        ddlsChool.SelectedValue = "0";
        ddlrel.SelectedValue = "0";
        txtFMobile.Text = "";
        txtgname.Text = "";
        guardianaddress.Text = "";
        guardianmail.Text = "";
    }

    protected void txtRollNo_TextChanged(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtRollNo.Text.Trim()))
        {
            query1 = "select COUNT(1) from student_master where roll_No='" + txtRollNo.Text.Trim() + "' and brid=" + Convert.ToInt16(Session["BrBrid"]) + "";
            count = Convert.ToInt16(objdut.GetScalar(query1));
            if (count == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "This Given Roll No Already Exists In The System.");
                txtRollNo.Text = "";
                txtRollNo.Focus();
                return;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Please Enter Student Roll No.')", true);
            txtRollNo.Text = "";
            txtRollNo.Focus();
            return;
        }
    }

    [WebMethod]
    public static int Getmobileno(string mobile)
    {
        DataUtility ObjDUT = new DataUtility();
        string q = "select COUNT(1) from student_master where mobile='" + mobile + "' ";
        int count = Convert.ToInt32(ObjDUT.GetScalar(q));
        return count;
    }

    protected void lnkaddsubarea_Click(object sender, EventArgs e)
    {
        divadd.Visible = true;
        abc1.Visible = false;
        divs.Visible = false;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        divadd.Visible = false;
        abc1.Visible = true;
        divs.Visible = true;
        txtareea.Text = "";
        ddlArea1.SelectedIndex = 0;
        chkcountrye.Checked = false;
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        if (txtareea.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "please enter sub areaname");
            return;
        }

        if (ddlArea1.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "please Select  areaname");
            return;
        }

        if (btn1.Text == "Save")
        {
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@mode", "addtopic");
            param[1] = new SqlParameter("@subareaname", txtareea.Text.Trim());
            param[2] = new SqlParameter("@areaid", ddlArea1.SelectedValue);

            if (chkcountrye.Checked)
            {
                param[3] = new SqlParameter("@status", 1);
            }
            else
            {
                param[3] = new SqlParameter("@status", Convert.ToInt32("0"));
            }
            param[4] = new SqlParameter("@intResult", Convert.ToInt32("0"));
            param[4].Direction = ParameterDirection.Output;
            param[5] = new SqlParameter("@subareaid", Convert.ToInt32("0"));
            int ret = objdut.ExecuteSqlSP(param, "usp_subaddarea");
            if (ret > 0)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Successfully added information");
                //ddlareas.Items.Clear();
                txtareea.Text = "";
                chkcountrye.Checked = false;
                divadd.Visible = false;
                abc1.Visible = true;
                divs.Visible = true;

                ddlArea2.Items.Clear();
                if (ddlArea1.SelectedValue != "0")
                {
                    dtsubarea = CommonClass.ABC1("subarea", Convert.ToInt32(ddlArea1.SelectedValue));
                    if (dtsubarea.Rows.Count > 0)
                    {
                        ddlArea2.DataSource = dtsubarea;
                        ddlArea2.DataTextField = "subareaname";
                        ddlArea2.DataValueField = "subareid";
                        ddlArea2.DataBind();
                        ddlArea2.Items.Insert(0, new ListItem("-Select Sub area-", "0"));
                    }
                }
            }
        }
    }

    protected void ddlStudtype_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddlStudtype.SelectedValue != "0")
        //{
        //    if (ddlStudtype.SelectedValue == "1")
        //    {
        //        getRollNo();
        //    }
        //    else
        //    {
        //        getRollNo2();
        //    }
        //}
        //else
        //{
        //    getRollNo();
        //}
    }

    private void getRollNo2()
    {
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@brid", Session["BrBrid"]);
        param[1] = new SqlParameter("@intresult", SqlDbType.Int);
        param[1].Direction = ParameterDirection.Output;
        param[2] = new SqlParameter("@rollas", SqlDbType.VarChar, 500);
        param[2].Direction = ParameterDirection.Output;
        ViewState["sturollno"] = objdut.GetScalerSP(param, "getAdmissionNo2");
        txtRollNo.Text = ViewState["sturollno"].ToString();
    }

    [WebMethod]
    public static citymaster[] bindcity(string sid)
    {
        List<citymaster> details = new List<citymaster>();
        DataTable dtcity = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select CTID,cityName from CITY where Active=1 and SID=" + sid, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dtcity);
                citymaster objProductMasterDetails0 = new citymaster();
                objProductMasterDetails0.CTID = Convert.ToInt32("0");
                objProductMasterDetails0.cityName = "-Select City-";
                details.Add(objProductMasterDetails0);
                foreach (DataRow dtrow in dtcity.Rows)
                {
                    citymaster citymasterobj = new citymaster();
                    citymasterobj.CTID = Convert.ToInt32(dtrow["CTID"].ToString());
                    citymasterobj.cityName = dtrow["cityName"].ToString();
                    details.Add(citymasterobj);
                }
            }
        }
        return details.ToArray();
    }

    public class citymaster
    {
        public int CTID { get; set; }

        public string cityName { get; set; }
    }

    protected void fillenqurydetail(int enquiryid)
    {
        string name = "";
        string q = "select sourceid,enquirysource,name,emailid,mobile,institutename from tbl_enquiry where enquiryid=" + enquiryid + " ";
        DataTable dt = objdut.GetDataTable(q);
        if (dt.Rows.Count > 0)
        {
            name = dt.Rows[0]["name"].ToString();
            string[] str = name.Split(' ');
            int count = name.Split(' ').Length;
            for (int i = 0; i < count; i++)
            {
                if (i == 0)
                {
                    txtFiName.Text = str[i];
                }
                if (i == 1 && count >= 3)
                {
                    txtMname.Text = str[1];
                }
                if (count == 2)
                {
                    txtLName.Text = str[1];
                }
                if (count >= 3)
                {
                    txtLName.Text = str[2];
                }
            }

            txtFEmailid.Text = dt.Rows[0]["emailid"].ToString();
            DropDownList1.SelectedValue = dt.Rows[0]["sourceid"].ToString();
            DropDownList1.SelectedItem.Text = dt.Rows[0]["enquirysource"].ToString();
            txtmob.Text = dt.Rows[0]["mobile"].ToString();
        }
    }

    [WebMethod]
    public static GetRelation[] bindrelation()
    {
        List<GetRelation> details = new List<GetRelation>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select Id,Relation from Relation_master", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                GetRelation objemp = new GetRelation();
                objemp.Id = Convert.ToInt32("0");
                objemp.Relation = "---Select Relation---";
                details.Add(objemp);
                foreach (DataRow dtrow in dt.Rows)
                {
                    GetRelation obje = new GetRelation();
                    obje.Id = Convert.ToInt32(dtrow["Id"].ToString());
                    obje.Relation = dtrow["Relation"].ToString();
                    details.Add(obje);
                }
            }
        }
        return details.ToArray();
    }

    public class GetRelation
    {
        public int Id { get; set; }

        public string Relation { get; set; }
    }

    [WebMethod]
    public static string GetYearMonthDate(string Date)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@Date", Date);
        DataTable Dt = objdut.GetDataTableSP(param, "[usp_GetNoOfDaysMonthYear]");
        return (Dt.Rows[0]["Date"].ToString());
    }
    public class qualification
    {
        public int qid { get; set; }
        public string name { get; set; }
    }
    [WebMethod]
    public static qualification[] bind_qualification()
    {
        List<qualification> details = new List<qualification>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            string query = "select qid,name from tblQualification where status=1";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                qualification subjectdetails0 = new qualification();
                subjectdetails0.qid = Convert.ToInt32("0");
                subjectdetails0.name = "---Qualification---";
                details.Add(subjectdetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    qualification dsdetails = new qualification();
                    dsdetails.qid = Convert.ToInt32(dtrow["qid"].ToString());
                    dsdetails.name = dtrow["name"].ToString();
                    details.Add(dsdetails);
                }
            }
        }
        return details.ToArray();
    }
    protected void ddlBrid_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlBrid.SelectedValue != "0") 
        {
            fillLog();
            getrecieptgenraldetails();
        }
    }
}