using System;
using System.Data;
using System.Data.SqlClient;

public partial class ParentPanel_studentviewinfo : System.Web.UI.Page
{
    private string url, q = "";
    private DataUtility objdut = new DataUtility();
    private int regid1;
    private SqlParameter[] param;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        getdate();

        if (Session["stregno"] == null)
        {
            Response.Redirect("~/LoginP.aspx");
        }
        if (!IsPostBack)
        {
            ViewState["acad"] = CommonClass.Scaler("ActiveAcademicYear");
            int studentadno = Convert.ToInt32(Session["stregno"]);

            double result = CommonClass.Scaler("studentregno", Convert.ToInt32(Session["Branchid"]), Convert.ToInt32(studentadno));
            if (result == 1)
            {
                showdetails(studentadno);
            }
            else
            {
                Response.Redirect("LoginP.aspx");
            }
        }
    }

    public void getdate()
    {
        string date = (DateTime.Today.Date).ToShortDateString();
        txdate.Text = date;
    }

    protected void showdetails(int Prid)
    {
        int classid = 0;
        int idStudent = Prid;
        DataTable dt = CommonClass.parentdetails("parentdetals", Convert.ToInt32(idStudent), Convert.ToInt32((Session["Branchid"])));
        if (dt.Rows.Count > 0)
        {
            classid = Convert.ToInt32(dt.Rows[0]["classid"].ToString());
            txtRegNo.Text = dt.Rows[0]["ADNO"].ToString();
            txtName.Text = dt.Rows[0]["FirstName"].ToString();
            txtmidname.Text = dt.Rows[0]["MiddleName"].ToString();
            txtLName.Text = dt.Rows[0]["LastName"].ToString();
            txtFname.Text = dt.Rows[0]["FatherName"].ToString();
            txtmother.Text = dt.Rows[0]["MotherName"].ToString();
            txdate.Text = Convert.ToDateTime(dt.Rows[0]["DateofBirth"]).ToString("MMM dd yyyy");
            if (Convert.ToInt16(dt.Rows[0]["transportaion"].ToString()) == 1)
            {
                lbtrans.Text = "Yes";
            }
            else
            {
                lbtrans.Text = "No";
            }
            //  txtPAddress.Text = dt.Rows[0]["HouseNo"].ToString();
            txtmob.Text = dt.Rows[0]["FMobileNo"].ToString();
            txtPZIP.Text = dt.Rows[0]["PINCode"].ToString();
            txtadmNo.Text = dt.Rows[0]["ADNO"].ToString();
        }
        dt.Dispose();
        string sd = Convert.ToString(objdut.GetScalar("select classname from class_master where id=" + classid));
        ddlClass.Text = sd;
        string sd1 = Convert.ToString(objdut.GetScalar(" select case gender when 1 then 'male' when 0 then 'female' end as gender from student_master where sturegno=" + idStudent));
        lblgenders.Text = sd1;
    }
}