using System;

public partial class BranchPanel_MasterS : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();
    private CommonClass CommonClass = new CommonClass();
    private Utility objUT = new Utility();
    private string PageName = "", url = "", type;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        //PageName = Utility.GetCurrentPagename();
        if (!objUT.isAccessible(((User)Session["BrUser"]).UserID, "MasterS.aspx"))
        {
            Response.Redirect("~/Login.aspx");
        }
        if (!IsPostBack)
        {
            btn3.Enabled = false;
            if (Request.QueryString.Count > 0)
            {
                type = Request.QueryString["type"];
                if (type == "F")
                {
                    lblHead.Text = "Fee Settings";
                    btn1.Visible = true;
                    btn2.Visible = true;
                    btn3.Visible = true;
                    btn1.Text = "Applicable Fee";
                    btn2.Text = "Set Fee";
                    btn3.Text = "Transport Fee";
                }
                else if (type == "C")
                {
                    lblHead.Text = "Class Settings";
                    btn2.Visible = false;
                    btn3.Visible = false;
                    btn1.Visible = true;
                    btn1.Text = "Add Section";
                }
                else if (type == "HR")
                {
                    lblHead.Text = "Department Settings";
                    btn3.Visible = false;
                    btn1.Visible = true;
                    btn2.Visible = true;
                    btn1.Text = "Add Department";
                    btn2.Text = "Add Designation";
                }
                else
                {
                    lblHead.Text = "Subject Settings";
                    btn3.Visible = false;
                    btn1.Visible = true;
                    btn2.Visible = false;
                    btn1.Text = "Add Subject";
                    //btn2.Text = "Sub in Branch";
                }
            }
        }
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        if (btn1.Text == "Applicable Fee")
        {
            Response.Redirect("feesSetting.aspx");
        }
        else if (btn1.Text == "Add Subject")
        {
            Response.Redirect("AddSubjectBranch.aspx");
        }
        else if (btn1.Text == "Add Department")
        {
            Response.Redirect("DepartMent.aspx");
        }
        else if (btn1.Text == "Add Section")
        {
            Response.Redirect("SectionAdd.aspx");
        }
    }

    protected void btn2_Click(object sender, EventArgs e)
    {
        if (btn2.Text == "Set Fee")
        {
            Response.Redirect("FeeAmountSetting.aspx");
        }
        if (btn2.Text == "Add Designation")
        {
            Response.Redirect("Designation.aspx");
        }
    }

    protected void btn3_Click(object sender, EventArgs e)
    {
        if (btn3.Text == "Transport Fee")
        {
            Response.Redirect("#");
        }
    }
}