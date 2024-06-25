using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.Services;

public partial class StudentPanel_new_admissionlist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["StuRegNo"] == null)
        {
            Response.Redirect("../user-login.aspx");
        }
       
    }

    public class BindAdmissionList
    {
        public string Coursename { get; set; }

        public string Joindate { get; set; }

        public string FYName { get; set; }

        public string Balanceamount { get; set; }

        public string Paid { get; set; }

        public string Tot { get; set; }
    }

    [WebMethod]
    public static BindAdmissionList[] BindGridByJs()
    {
        DataTable Ds = new DataTable();
        List<BindAdmissionList> AdmissionList = new List<BindAdmissionList>();
        DataUtility Objdut = new DataUtility();
        int id = Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]);
        Ds = CommonClass.ABC1("NewAdmisionStudent", id);
        if (Ds.Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Rows)
            {
                BindAdmissionList userSecond = new BindAdmissionList();
                userSecond.Coursename = dtrow["Coursename"].ToString();
                userSecond.Joindate = dtrow["Joindate"].ToString();
                userSecond.FYName = dtrow["FYName"].ToString();
                userSecond.Balanceamount = dtrow["Balanceamount"].ToString();
                userSecond.Paid = dtrow["Paid"].ToString();
                userSecond.Tot = dtrow["Tot"].ToString();
                AdmissionList.Add(userSecond);
            }
        }
        return AdmissionList.ToArray();
    }

   
}