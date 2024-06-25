using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class StudentPanel_AdmitCard : System.Web.UI.Page
{
    private string url, Query, Query1, query2, query3, Brid = "";
    private DataTable dt;
    private double d;
    private NumberToEnglish nme = new NumberToEnglish();
    //public DataUtility_SH objdut = new DataUtility_SH();
    public DataUtility objdut = new DataUtility();
    private int enrollid = 0;
    private Decimal enrollfee = 0, servicetax = 0, educationcess = 0, serLim = 0, CessLim = 0, x = 0;
    private string institutename = "";

    protected void Page_Init(object sender, EventArgs e)
    {
        if (Session["UserRID"] != null)
        {
            string RID = Convert.ToString(Session["UserRID"]);          
            string Brid_SH = Convert.ToString(objdut.GetScalar("Select ISNULL(BRID,0) from tbl_StudentRegistration where RID=" + Convert.ToString(RID) + " and Status=1"));
            Session["Brid_SH"] = Brid_SH;
            if (Convert.ToString(Session["UserRID"]) != "")
            {
                if (Convert.ToString(Session["UserRID"]) != "")
                {
                    if (Convert.ToString(Session["Brid_SH"]) != "")
                    {
                        Brid = Convert.ToString(Session["Brid_SH"]);
                        if (Brid == "")
                        {
                            Response.Redirect("RegExam.aspx");
                        }
                        else
                        {
                            if (Convert.ToInt32(Brid) > 0)
                            {
                                SchoolName.InnerHtml = Convert.ToString(objdut.GetScalar("select isnull(BrName,'') SchoolName from Branch_master where brid=" + Brid));
                                Span17.InnerHtml = SchoolName.InnerHtml;
                                string imgsrc = Convert.ToString(objdut.GetScalar("select photo from Branch_master where brid=" + Brid));
                                if (imgsrc != "")
                                {

                                    string[] data = imgsrc.Split('^');
                                    if (data.Length > 0)
                                    {
                                        btnlogoforrecipt.ImageUrl = "~/BranchPanel/images/" + data[0];
                                        btnlogoforrecipt.Style.Add("background", data[0]);
                                        favicon.Href = "images/" + data[0];

                                        Image1.ImageUrl = "~/BranchPanel/images/" + data[0];
                                        Image1.Style.Add("background", data[0]);

                                    }
                                    else
                                    {
                                        btnlogoforrecipt.ImageUrl = "~/images/9update.png";
                                        Image1.ImageUrl = "../../images/9update.png";
                                        favicon.Href = "images/9update.png";
                                    }
                                }
                                else
                                {
                                    btnlogoforrecipt.ImageUrl = "~/images/9update.png";
                                    Image1.ImageUrl = "~/images/9update.png";
                                    favicon.Href = "images/9update.png";
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {  
        if (!IsPostBack)
        {
            getrecieptgenraldetails();       
        }
    }

    private void getrecieptgenraldetails()
    {
        Brid = Convert.ToString(Session["Brid_SH"]);
        if (Brid == "")
        {
            Response.Redirect("~/user-login.aspx");
        }
        else
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
            LandLineNo+','+MobileNo+'^'+Emailid+'^'+isnull(Website,'')+'^'+isnull(SchoolAffi,'') from branch_master where brid = '" + Brid + "'"));
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
            if (SchoolAffi != "")
            {
                lblSchoolAffi.Text = SchoolAffi.Trim();
                insservicetaxno.Visible = true;
                lblSchoolAffi.Visible = true;
            }
            else
            {
                insservicetaxno.Visible = false;
                lblSchoolAffi.Visible = false;
            }
            lblservicetax.Text = Website.Trim();
            Receipt();
        }
    }
    protected void Receipt()
    {
        try
        {
            Brid = Convert.ToString(Session["Brid_SH"]);
            int classid=0;
            string RegistrationNo = "";
            string str = "Select * from tbl_StudentRegistration sr " +
                         " inner join Class_Master cm on sr.ApplyingForClass = cm.id " +
                         "where sr.RID=" + Session["UserRID"] + " and Sr.Brid=" + Brid + "";
                        
            dt = objdut.GetDataTable(str);
            if (dt.Rows.Count > 0)
            {
                classid = Convert.ToInt32(dt.Rows[0]["applyingforclass"]);
                RegistrationNo = dt.Rows[0]["Registration_No"].ToString();
                Span35.InnerHtml = RegistrationNo;
                Span36.InnerHtml = dt.Rows[0]["RegNewNo"].ToString();
                recipetrecivername.InnerHtml = dt.Rows[0]["StudentFirstName"].ToString() + " " + dt.Rows[0]["StudentMiddleName"].ToString() + " " + dt.Rows[0]["StudentLastName"].ToString();               
                Span23.InnerHtml = dt.Rows[0]["PrimaryParentFirstName"].ToString() + " " + dt.Rows[0]["PrimaryParentMiddleName"].ToString() + " " + dt.Rows[0]["PrimaryParentLastName"].ToString();
                Span3.InnerHtml = dt.Rows[0]["Classname"].ToString();
                recieptdate.InnerHtml = DateTime.Today.ToString("dd MMM yyyy");
                if (dt.Rows[0]["ExamMode"].ToString() == "1")
                {
                    Span36.InnerHtml = "Online";
                }
                else
                {
                    Span36.InnerHtml = "Offline";
                }
                if (dt.Rows[0]["ExamDate"].ToString() != "")
                { 
                    Span4.InnerHtml = Convert.ToDateTime(dt.Rows[0]["ExamDate"]).ToString("dd MMMM yyyy");
                }
                if (dt.Rows[0]["ExamTime"].ToString() != "")
                { 
                    Span2.InnerHtml = dt.Rows[0]["ExamTime"].ToString(); 
                }
            }          
        }
        catch
        {

        }
        finally
        {
        }
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "message", "javascript:window.print()", true);
    }
}