using System;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;

public partial class BranchPanel_AdmissionConfirm : System.Web.UI.Page
{
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();

    private string query, view_rid, query1;
    private static int academicyear = 0;
    private SqlDataReader dr;
    private DataTable dt;
    private SqlParameter[] param = new SqlParameter[2];

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            academicyear = CommonClass.Scaler("ActiveAcademicYear");

            if (Session["BrBrid"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
            if (Request.QueryString.Count > 0)
            {
                string adid = Request.QueryString["adid"].ToString();
                ViewState["adid"] = adid;
                showdetails();
                tdfee.Visible = false;
                //if (Session["pnow"].ToString() != "NOTNOW")
                //{
                tdfee.Visible = true;
                filfeegrd();
                // }
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }
    }

    private void filfeegrd()
    {
        string recno = Convert.ToString(objdut.GetScalar("select top(1)ISNULL(receiptno,0) from tbl_payfee order by pid desc"));
        dt = CommonClass.NameFun("bindstudentfee", Convert.ToInt32(Session["BrBrid"]), recno);
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
        }
        dt.Dispose();
    }

    protected void showdetails()
    {
        query = @"select b.BrAddress , s.stateName, c.cityName , b.pincode  from branch_master b ,CITY c,STATE s where BrActive=1
                         and s.SID=b.Sid and c.ctid=b.distid and BrId=" + Session["BrBrid"];

        dr = objdut.GetDataReader(query);

        if (dr.HasRows)
        {
            dr.Read();
            lblBranchAdd.Text = dr["BrAddress"].ToString();
            lblBrCity.Text = dr["cityName"].ToString();
            lblBrState.Text = dr["stateName"].ToString();
            lblPinCode.Text = dr["pincode"].ToString();
        }
        dr.Close();

        view_rid = ViewState["adid"].ToString();

        query1 = "usp_submitfeedetails";

        param[0] = new SqlParameter("@adid", ViewState["adid"]);
        param[1] = new SqlParameter("@brid", Session["BrBrid"]);

        dr = objdut.GetDataReaderSP(param, query1);
        if (dr.HasRows)
        {
            dr.Read();
            lblRegistrationNo1.Text = dr["adno"].ToString();
            lblDate.Text = dr["admissiondate"].ToString();
            lblName.Text = dr["name"].ToString();
            lblFatherName.Text = dr["FfirstName"].ToString();
            lblMotherName.Text = dr["MFirstName"].ToString();
            lblDOB.Text = Convert.ToDateTime(dr["DateofBirth"]).ToString("dd MMM yyyy");
            lblAddress.Text = dr["address"].ToString();
            lblMobile.Text = dr["FMobileNo"].ToString();
            lblClass.Text = dr["class"].ToString();
        }
        dr.Close();
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("studentadmissionlistaspx.aspx");
    }

    protected void LBPayNow_Click(object sender, EventArgs e)
    {
        Session["Adid"] = ViewState["adid"];
        Response.Redirect("FeePayment.aspx");
    }
}