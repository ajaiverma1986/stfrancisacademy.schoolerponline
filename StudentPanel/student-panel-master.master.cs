using System;
using System.Data;
using System.IO;
using System.Text;
using System.Web;

public partial class EmployeePanel_employee_panel_master : System.Web.UI.MasterPage
{
    private StringBuilder strtable = new StringBuilder();

    protected void Page_Init(object sender, EventArgs e)
    {
        string imgsrc = HomeMasterPage.MasterMethod("BindLogo");
        string[] data = imgsrc.Split('^');
        if (data.Length > 0)
        {
            imgPP.Src = "../images/" + data[0];
            imgPP.Style.Add("background", data[1]);
            favicon.Href = "../images/" + data[2];
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //string[] pagename = HttpContext.Current.Request.RawUrl.ToLower().Split('/');
            //int arraylength = pagename.Length;
            //string pageurl = pagename[arraylength - 1];
            if (Session["UserName"] == null && Session["UserBrid"] == null && Session["UserID"] == null)
            {
                Response.Redirect("~/user-login.aspx");
            }
        }
        catch
        {
        }

        if (!IsPostBack)
        {
           // fillmenu();
           // getusername();
        }
    }
protected void lnkForm_ServerClick(object sender, EventArgs e)
    {
       // Response.Redirect("RegistrationForm.aspx?REG="+Convert.ToString(Session["UserName"]), false);
        Response.Write("<script>window.open ('RegistrationForm.aspx?val=" + Convert.ToString(Session["UserName"]) + "','_blank');</script>");

    }
    protected void fillmenu()
    {
        DataTable Dt = new DataTable();
        DataUtility ObjDut = new DataUtility();
        Dt = ObjDut.GetDataTable("select Distinct Title,Url,DisplayOrder,liclass,iclass from tbl_studentmenu where IsActive=1 and IsDeleted=0 and Status=1 order by DisplayOrder");
        if (Dt.Rows.Count > 0)
        {
            foreach (DataRow dtrow in Dt.Rows)
            {
                strtable.Append("<li ><a href=" + dtrow["Url"] + " class=" + dtrow["liclass"] + "><i class='" + dtrow["iclass"] + "' ></i>" + dtrow["Title"] + "</a></li>");
            }
            stumenu.InnerHtml = strtable.ToString();
        }
    }
    public void getusername()
    {
        DataUtility Objdut_SH = new DataUtility();
        if (Convert.ToString(Session["RID"]) != "")
        {
            Session["Brid_SH"] = Convert.ToString(Objdut_SH.GetScalar("Select ISNUll(BRID,0) from tbl_StudentRegistration where RID=" + Session["RID"]));
        }

        DataUtility Objdut = new DataUtility();
        if (Request.QueryString["Id"] == null)
        lbluser.Text = Objdut.GetScalar("select (FName+' '+Mname+' '+Lname) as stuname from student_master where StuRegNo=" + HttpContext.Current.Session["StuRegNo"]).ToString();
        else
            lbluser.Text = Objdut.GetScalar("select (FName+' '+Mname+' '+Lname) as stuname from student_master where StuRegNo=" +  Request.QueryString[0]).ToString();
    }

    //public void imgforandroid_Click()
    //{
    //    try
    //    {
    //        string filepath = "StudentPanel.apk";
    //        filepath = "studentpanel_App/" + filepath;
    //        Response.ContentType = ContentType;
    //        Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filepath));
    //        Response.WriteFile(filepath);
    //        Response.End();
    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}
    protected void btnlink_Click(object sender, EventArgs e)
    {
        try
        {
            string filepath = "StudentPanel.apk";
            filepath = "studentpanel_App/" + filepath;
            Response.ContentType = "application/octet-stream";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filepath));
            Response.WriteFile(filepath);
            Response.End();
        }
        catch (Exception ex)
        {
        }
    }
}