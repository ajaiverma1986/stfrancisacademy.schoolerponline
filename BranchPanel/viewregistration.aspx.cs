using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_viewregistration : System.Web.UI.Page
{
    private string url, query1;

    private DataUtility objdut = new DataUtility();
    private CommonClass commonobj = new CommonClass();

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();

        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        getdate();
        if (!IsPostBack)
        {
            fillclass();
            if (Request.QueryString.Count > 0)
            {
                int stuRegID = Convert.ToInt32(Request.QueryString[0]);
                int studentadno = Convert.ToInt32(Request.QueryString[0]);
                ViewState["StuID"] = stuRegID;
                ViewState["stuadno"] = studentadno;
                showdetails();
            }
        }
    }

    public void fillclass()
    {
        string query = "Select * from ClassBranch_master where BranchId=" + Convert.ToDouble(Session["BrBrid"]) + " and status=1";
        ddlClass.DataSource = objdut.GetDataTable(query);
        ddlClass.DataTextField = "Classname";
        ddlClass.DataValueField = "classid";
        ddlClass.DataBind();
        ListItem li = new ListItem("Select Class", "0");
        ddlClass.Items.Insert(0, li);
    }

    public void getdate()
    {
        string date = (DateTime.Today.Date).ToShortDateString();
        txtAdmDate.Text = date;
    }

    protected void showdetails()
    {
        int idStudent = Convert.ToInt32(ViewState["StuID"]);
        string query = "Select * from tbl_StudentRegistration where Rid=" + idStudent;
        SqlDataReader dr = objdut.GetDataReader(query);
        dr.Read();
        if (dr.HasRows)
        {
            txtRegNo.Text = dr["RegistrationNo"].ToString();
            txtFiName.Text = dr["FirstName"].ToString();
            TextBox11.Text = dr["MiddleName"].ToString();
            txtLName.Text = dr["LastName"].ToString();
            txtToDate.Text = Convert.ToDateTime(dr["DateofBirth"]).ToString("MMM dd yyyy");

            txtFFname.Text = dr["FfirstName"].ToString();
            txtFMname.Text = dr["FMiddleName"].ToString();
            txtFLname.Text = dr["FLastName"].ToString();
            txtMFname.Text = dr["MFirstName"].ToString();
            txtMMname.Text = dr["MmiddleName"].ToString();
            txtMLname.Text = dr["MLastName"].ToString();
            rbgender.SelectedValue = dr["Gender"].ToString();
            if (Convert.ToInt32(dr["classid"].ToString()) != 0)
            {
                ddlClass.SelectedValue = dr["classid"].ToString();
            }
            txtPAddress.Text = dr["Address"].ToString();
            txtcountry.Text = dr["countryname"].ToString();
            txtstate.Text = dr["statename"].ToString();
            txtcity.Text = dr["cityname"].ToString();
            txtPZIP.Text = dr["PINCode"].ToString();
            txtmob.Text = dr["FMobileNo"].ToString();

            txtadmNo.Text = dr["RegistrationNo"].ToString();
            txtClassSec.Text = ddlClass.SelectedItem.Text;
        }
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        Response.Redirect("completeReg.aspx?Rid=" + Convert.ToInt32(ViewState["StuID"]));
    }

    protected void btnupd_Click(object sender, EventArgs e)
    {
        if (checkValidation())
        {
            int idStudent = Convert.ToInt32(ViewState["StuID"]);
            string brusername = (string)Session["Brusername"];
            double brID = Convert.ToDouble(Session["BrBrid"]);
            string pname = "usp_studentRegistration";
            SqlParameter[] param = new SqlParameter[23];
            param[0] = new SqlParameter("@brid", brID);
            param[1] = new SqlParameter("@branchname", brusername);
            param[2] = new SqlParameter("@firstname", txtFiName.Text);
            param[3] = new SqlParameter("@middlename", TextBox11.Text);
            param[4] = new SqlParameter("@lastname", txtLName.Text);
            param[5] = new SqlParameter("@dateofbirth", txtToDate.Text);
            param[6] = new SqlParameter("@FfirstName", txtFFname.Text);
            param[7] = new SqlParameter("@FMiddleName", txtFMname.Text);
            param[8] = new SqlParameter("@FLastName", txtFLname.Text);
            param[9] = new SqlParameter("@MfirstName", txtMFname.Text);
            param[10] = new SqlParameter("@MMiddleName", txtMMname.Text);
            param[11] = new SqlParameter("@MLastName", txtMLname.Text);
            param[12] = new SqlParameter("@gender", rbgender.SelectedValue);

            if (ddlClass.SelectedItem.Text == "Select Class")
            {
                param[13] = new SqlParameter("@applyclass", "");
            }
            else
            {
                param[13] = new SqlParameter("@applyclass", ddlClass.SelectedItem.Text);
            }
            param[14] = new SqlParameter("@Address", txtPAddress.Text);
            param[15] = new SqlParameter("@countryname", txtcountry.Text.Trim());
            param[16] = new SqlParameter("@statename", txtstate.Text.Trim());
            param[17] = new SqlParameter("@cityname", txtcity.Text.Trim());
            param[18] = new SqlParameter("@pincodeP", txtPZIP.Text);
            param[19] = new SqlParameter("@FMobileNo", txtmob.Text.Trim());
            param[20] = new SqlParameter("@rid", idStudent);
            param[21] = new SqlParameter("@classid", ddlClass.SelectedValue);
            param[22] = new SqlParameter("@intresult", Convert.ToInt32("0"));
            param[22].Direction = ParameterDirection.Output;
            int count = objdut.ExecuteSqlSP(param, pname);
            if (count == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Record Updated Successfully.");
                Session["upd"] = count;
                Response.Redirect("registration-list.aspx");
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "Error.");
                return;
            }
        }
    }

    public bool checkValidation()
    {
        if (txtToDate.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select date of birth.");
            return false;
        }
        if (ddlClass.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select the class applying for.");
            return false;
        }

        if (txtFFname.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please enter father's first name.");
            return false;
        }

        if (txtFLname.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please enter father's last name.");
            return false;
        }        
        if (txtPZIP.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please enter the PIN code in permanent address details.");
            return false;
        }
        if (txtcountry.Text.Trim()== "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please enter country in permanent address details.");
            return false;
        }
        if (txtstate.Text.Trim()=="")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please enter state in permanent address details.");
            return false;
        }
        if (txtcity.Text.Trim()=="")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please enter city in permanent address details.");
            return false;
        }

        return true;
    }
}