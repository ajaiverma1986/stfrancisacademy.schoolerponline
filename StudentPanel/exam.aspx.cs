using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class StudentPanel_exam : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["StuRegNo"] == null)
        {
            Response.Redirect("logout.aspx");
        }
    }
}