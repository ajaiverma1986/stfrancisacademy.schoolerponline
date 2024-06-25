using System;
using System.Data;
using System.Reflection;

public partial class BranchPanel_RegConfirm : System.Web.UI.Page
{
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private CommonClass commonobj = new CommonClass();
    private Utility obju = new Utility();
    private DataTable dt1, dt2;
    private string query, view_rid, query1;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["BrBrid"] == null)
            {
                Response.Redirect("~/Login.aspx");
            }
            if (Request.QueryString.Count > 0)
            {
                string RID = Request.QueryString["rid"].ToString();
                ViewState["rid"] = RID;
                showdetails();
            }
            else
            {
            }
        }
    }

    protected void showdetails()
    {
        query = @"select b.BrAddress , s.stateName, c.cityName , b.pincode  from branch_master b ,CITY c,STATE s where BrActive=1
                         and s.SID=b.Sid and c.ctid=b.distid and BrId=" + Session["BrBrid"];
        dt1 = objdut.GetDataTable(query);
        if (dt1.Rows.Count > 0)
        {
            lblBranchAdd.Text = dt1.Rows[0]["BrAddress"].ToString();
            lblBrCity.Text = dt1.Rows[0]["cityName"].ToString();
            lblBrState.Text = dt1.Rows[0]["stateName"].ToString();
            lblPinCode.Text = dt1.Rows[0]["pincode"].ToString();
        }
        view_rid = ViewState["rid"].ToString();
        query1 = @"select tr.RegistrationNo, tr.RegistrationDate,isnull(( tr.FirstName+' '+isnull( tr.middlename,'')+' '+ tr.LastName),'') as name,  tr.DateofBirth,isnull(( tr.FfirstName+' '+isnull( tr.FMiddleName,'')+' '+ tr.FLastName),'')
 as FatherName, tr.FMobileNo ,isnull(( tr.MFirstName+' '+isnull( tr.MmiddleName,'')+' '+ tr.MLastName),'') as MotherName, Address+ ',   '+ tr.cityname+ ',   '+ tr.statename+ ',  '+ tr.countryname+ ' '+ tr.PINCode as CompleteAddress,
   tsr.Paymentmode,tsr.payment,tsr.Bankname,tsr.CDDNo,tr.applyclass from tbl_StudentRegistration tr,tblRegistrationslip tsr where tr.RId=tsr.registrationid and tr.RId=" + view_rid + "";
        dt2 = objdut.GetDataTable(query1);
        if (dt2.Rows.Count > 0)
        {
            lblRegistrationNo1.Text = dt2.Rows[0]["RegistrationNo"].ToString();
            lblDate.Text = dt2.Rows[0]["RegistrationDate"].ToString();
            lblName.Text = dt2.Rows[0]["name"].ToString();
            lblFatherName.Text = dt2.Rows[0]["FatherName"].ToString();
            lblMotherName.Text = dt2.Rows[0]["MotherName"].ToString();
            lblDOB.Text = Convert.ToDateTime(dt2.Rows[0]["DateofBirth"]).ToString("dd MMM yyyy");
            lblAddress.Text = dt2.Rows[0]["CompleteAddress"].ToString();
            lblMobile.Text = dt2.Rows[0]["FMobileNo"].ToString();
            //lblFee.Text = "Rs. " + string.Format("{0:f}", dt2.Rows[0]["payment"]);
            lblMode.Text = dt2.Rows[0]["Paymentmode"].ToString();
            lblClass.Text = dt2.Rows[0]["applyclass"].ToString();
            if (!string.IsNullOrEmpty(dt2.Rows[0]["Bankname"].ToString()))
            {
                lblBank.Text = dt2.Rows[0]["Bankname"].ToString();
            }
            else
            {
                tr1.Visible = false;
            }
            if (!string.IsNullOrEmpty(dt2.Rows[0]["CDDNo"].ToString()))
            {
                lblCDD.Text = dt2.Rows[0]["CDDNo"].ToString();
            }
            else
            {
                tr2.Visible = false;
            }
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("registration-list.aspx");
    }
}