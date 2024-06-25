using System;
using System.Data;

public partial class ParentPanel_profile : System.Web.UI.Page
{
    private int studentadno;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            studentadno = Convert.ToInt32(Session["stregno"]);
            double result = CommonClass.Scaler("studentregno", Convert.ToInt32(Session["Branchid"]), Convert.ToInt32(studentadno));
            if (result == 1)
            {
                showdetails();
            }
            else
            {
                Response.Redirect("LoginP.aspx");
            }
        }
    }

    protected void showdetails()
    {
        DataTable dt = CommonClass.parentdetails("fillstudentdeatils", Convert.ToInt32(studentadno), Convert.ToInt32((Session["Branchid"])));
        if (dt.Rows.Count > 0)
        {
            //Fill Student Details
            lblclass.Text = dt.Rows[0]["ApplyClass"].ToString();
            lblname.Text = dt.Rows[0]["stuname"].ToString();
            lblsec.Text = dt.Rows[0]["section"].ToString();
            lblgender.Text = dt.Rows[0]["gender"].ToString();
            lblBloodGroup.Text = dt.Rows[0]["BloodGroup"].ToString();
            lblNationality.Text = dt.Rows[0]["Nationality"].ToString();
            lblcountry.Text = dt.Rows[0]["countryname"].ToString();
            lblstate.Text = dt.Rows[0]["statename"].ToString();
            lblcity.Text = dt.Rows[0]["cityname"].ToString();
            lbladdress.Text = dt.Rows[0]["Address"].ToString();
            lblemail.Text = dt.Rows[0]["LEmail"].ToString();
            lblmobile.Text = "";
            lbltransport.Text = dt.Rows[0]["Transport"].ToString();

            //Fill Father Details
            lblprofession.Text = dt.Rows[0]["FOccupation"].ToString();
            lbldesignation.Text = dt.Rows[0]["FDesignation"].ToString();
            lblfnatinality.Text = dt.Rows[0]["FNationality"].ToString();
            lblfmobile.Text = dt.Rows[0]["FMobileNo"].ToString();
            lblfemail.Text = dt.Rows[0]["FEmail"].ToString();
            lblfqualification.Text = dt.Rows[0]["FQualification"].ToString();

            //Fill Mother Details
            lblmprofession.Text = dt.Rows[0]["MOccupation"].ToString(); ;
            lblmdesignation.Text = dt.Rows[0]["MDesignation"].ToString();
            lblmnationality.Text = dt.Rows[0]["MNationality"].ToString();
            lblmmobile.Text = dt.Rows[0]["MMobileNo"].ToString();
            lblmemail.Text = dt.Rows[0]["MEmail"].ToString();
            lblmqualification.Text = dt.Rows[0]["MQualification"].ToString();
        }
    }
}