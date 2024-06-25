using System;
using System.Data;

public partial class TeacherPanel_teacher : System.Web.UI.UserControl
{
    private DataTable dt1;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["empid"] == null)
            {
                Response.Redirect("~/LoginT.aspx");
            }

           // filldetail();
        }
    }

    //private void filldetail()
    //{
    //    dt1 = CommonClass.facultymaster("facultydetail", Convert.ToInt32(Session["empid"]));
    //    if (dt1.Rows.Count > 0)
    //    {
    //        lblname.Text = dt1.Rows[0]["name"].ToString();
    //        Session["ename"] = lblname.Text;
    //        lblmobile.Text = dt1.Rows[0]["Mobileno"].ToString();

    //        if (string.IsNullOrEmpty(dt1.Rows[0]["facultyimage"].ToString()))
    //        {
    //            imgstu.ImageUrl = "~/images/9update.png";
    //        }
    //        else
    //        {
    //            imgstu.ImageUrl = "~/facultyimage/" + dt1.Rows[0]["facultyimage"].ToString();
    //        }
    //    }
    //}

    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("fxsalaryreport.aspx");
    }
}