using System;
using System.Data;
using System.IO;
using System.Web;

public partial class EmployeePanel_employee_view_profile : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private int eid = 0;
    private DataTable dt;
    private int idStudent = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["StuRegNo"] != null)
            {
                eid = Convert.ToInt32(Session["StuRegNo"]);
            }
            idStudent = Convert.ToInt16(Session["StuRegNo"]);
            showDetails(eid);
            getusername();
        }
    }

    protected void showDetails(int id)
    {
        dt = CommonClass.ABC("stuDentDetails", id, Convert.ToInt32(Session["brbrid"]));

        if (dt.Rows.Count > 0)
        {
            if (!string.IsNullOrEmpty(dt.Rows[0]["StudentPhotograph"].ToString()))
            {
             
                ViewState["pic"] = dt.Rows[0]["StudentPhotograph"].ToString();
                img1.ImageUrl = "../BranchPanel/Student-Registration/student-registration-document/" + ViewState["pic"].ToString();
            }
            else
            {
                ViewState["pic"] = null;
                img1.ImageUrl = "~/images/9update.png";
            }
            lblRollno.InnerText = "";
            lblname.InnerText = dt.Rows[0]["StudentFirstName"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["StudentMiddleName"].ToString()))
            {
                lblname.InnerText = lblname.InnerText + dt.Rows[0]["StudentMiddleName"].ToString();
            }
            else
            {
                lblname.InnerText = lblname.InnerText + "";
            }

            if (!string.IsNullOrEmpty(dt.Rows[0]["SchoolBoard"].ToString()) && dt.Rows[0]["SchoolBoard"].ToString() != "Select Board")
            {
                lblBoard.InnerText = dt.Rows[0]["SchoolBoard"].ToString();
            }
            else
            {
                lblBoard.InnerText = "NA";
            }
            //if (!string.IsNullOrEmpty(dt.Rows[0]["SchoolMediam"].ToString()) && dt.Rows[0]["SchoolMediam"].ToString() != "Select Medium")
            //{
            //    lblMedium.InnerText = dt.Rows[0]["SchoolMediam"].ToString();
            //}
            //else
            //{
            //    lblMedium.InnerText = "NA";
            //}
            lblMedium.InnerText = "ENGLISH";
            lblname.InnerText = lblname.InnerText + " " + dt.Rows[0]["StudentLastName"].ToString();
            //if (Convert.ToBoolean(dt.Rows[0]["Gender"]))
            //{
            //    lblGender.InnerText = "Male";
            //}
            //else
            //{
            //    lblGender.InnerText = "Female";
            //}
            lblGender.InnerText = dt.Rows[0]["GenderName"].ToString();
            lblDOB.InnerText = Convert.ToDateTime(dt.Rows[0]["StudentDOB"]).ToString("dd MMM yyyy");
            if (!string.IsNullOrEmpty(dt.Rows[0]["Address"].ToString()))
            {
                lblAddress.InnerText = dt.Rows[0]["Address"].ToString();
            }
            else
            {
                lblAddress.InnerText = "NA";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["SchoolName"].ToString()) && dt.Rows[0]["SchoolName"].ToString() != "--Select School--")
            {
                lblschool.InnerText = dt.Rows[0]["SchoolName"].ToString();
            }
            else
            {
                lblschool.InnerText = "NA";
            }
            lblMobileno.InnerText = dt.Rows[0]["PrimaryMobileNo"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["PrimaryEmailId"].ToString()))
            {
                lblemailid.InnerText = dt.Rows[0]["PrimaryEmailId"].ToString();
            }
            else
            {
                lblemailid.InnerText = "NA";
            }
            //if (!string.IsNullOrEmpty(dt.Rows[0]["SoureType"].ToString()))
            //{
            //    lblstudentsource.InnerText = dt.Rows[0]["SoureType"].ToString();
            //}
            //else
            //{
            //    lblstudentsource.InnerText = "NA";
            //}
            lblstudentsource.InnerText = "Direct Online Admission";
            lblLandlineno.InnerText = "";
            ////if (!string.IsNullOrEmpty(dt.Rows[0]["landline"].ToString()))
            ////{
            ////    lblLandlineno.InnerText = dt.Rows[0]["landline"].ToString();
            ////}
            ////else
            ////{
            ////    lblLandlineno.InnerText = "NA";
            ////}
            //if (!string.IsNullOrEmpty(dt.Rows[0]["Gphoto"].ToString()))
            //{
            //    ViewState["fpic"] = dt.Rows[0]["Gphoto"].ToString();
            //    Img2.ImageUrl = "../StudentPhoto/" + ViewState["fpic"].ToString();
            //}
            //else
            //{
            //    ViewState["fpic"] = null;
            //    Img2.ImageUrl = "~/images/9update.png";
            //}
            Img2.ImageUrl = "~/images/pita.jpg";
            if (!string.IsNullOrEmpty(dt.Rows[0]["PrimaryParentFirstName"].ToString()))
            {
                lblGName.InnerText = dt.Rows[0]["PrimaryParentFirstName"].ToString();
            }
            else
            {
                lblGName.InnerText = "NA";
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["PrimarySelectParentType"].ToString()))
            {
                if (dt.Rows[0]["PrimarySelectParentType"].ToString() == "--Select Relation--")
                {
                    lblRelation.InnerText = "NA";
                }
                else
                {
                    string RelationType = "";
                    RelationType = (string)(objdut.GetScalar("Select ISNULL(Relation,'N/A') from Relation_Master where id=" + dt.Rows[0]["PrimarySelectParentType"].ToString() + ""));
                    lblRelation.InnerText = RelationType.ToString();
                }
            }
            else
            {
                lblRelation.InnerText = "NA";
            }

            //if (!string.IsNullOrEmpty(dt.Rows[0]["GuardianPhone"].ToString()))
            //{
            //    lblGMobileno.InnerText = dt.Rows[0]["GuardianPhone"].ToString();
           // }
           // else
           // {
           //    lblGMobileno.InnerText = "NA";
           // }

            lblGemailid.InnerText = "";
            lblGMobileno.InnerText = "";
            //if (!string.IsNullOrEmpty(dt.Rows[0]["Gmail"].ToString()))
            //{
            //    lblGemailid.InnerText = dt.Rows[0]["Gmail"].ToString();
            //}
            //else
            //{
            //    lblGemailid.InnerText = "NA";
            //}
            //if (!string.IsNullOrEmpty(dt.Rows[0]["Gaddress"].ToString()))
            //{
            //    lblGAddress.InnerText = dt.Rows[0]["Gaddress"].ToString();
            //}
            //else
            //{
            //    lblGAddress.InnerText = "NA";
            //}
            lblGAddress.InnerText = "Chhota Bariyarpur Hawai Adda Motihari";
            hdnResult.Value = Convert.ToString(dt.Rows[0]["ResultFilePath"]);
            if(string.IsNullOrWhiteSpace(Convert.ToString(dt.Rows[0]["ResultFilePath"])))
            {
                downloadResult.Visible=false;
            }
            hdnAdmit.Value = Convert.ToString(dt.Rows[0]["Admitfilepath"]);
            if (string.IsNullOrWhiteSpace(Convert.ToString(dt.Rows[0]["Admitfilepath"])))
            {
                downloadAdmit.Visible = false;
            }


        }
        else
        {
            Session["StudID"] = null;
            Response.Redirect("../user-login.aspx");
        }
        showLoginDetails(idStudent);
    }

    protected void showLoginDetails(int id)
    {
        //dt = CommonClass.ABC("studentlogin", id, Convert.ToInt16(0));
        //if (dt.Rows.Count > 0)
        //{
           lblUserName.InnerText = Session["loginid"].ToString();
           lblpassword.ToolTip = Session["Password"].ToString(); 
    }

    public void getusername()
    {
        DataUtility Objdut = new DataUtility();
        lbluser.Text = Convert.ToString(Objdut.GetScalar("select (StudentFirstName+' '+StudentMiddleName+' '+StudentLastName) as stuname from tbl_StudentRegistration where Registration_No='" + HttpContext.Current.Session["loginid"]+"'"));
    }
    protected void downloadResult_Click(object sender, EventArgs e)
    {
        var filename = Path.GetFileName(hdnResult.Value);        
        string filetype = Path.GetExtension(hdnResult.Value);
        Response.ContentType = "application/pdf"; 
        if(filetype==".jpg")
        {
            Response.ContentType = "image/jpeg";
        }
        if (filetype == ".png")
        {
            Response.ContentType = "image/png";
        }
        if (filetype == ".xlsx" || filetype == ".xls")
        {
            Response.ContentType = "Application/x-msexcel";
        }       
        Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename);
            Response.WriteFile(Server.MapPath(hdnResult.Value));
        Response.End();
    }
    protected void downloadAdmit_Click(object sender, EventArgs e)
    {
        var filename = Path.GetFileName(hdnAdmit.Value);
        string filetype = Path.GetExtension(hdnAdmit.Value);
        Response.ContentType = "application/pdf";
        if (filetype == ".jpg")
        {
            Response.ContentType = "image/jpeg";
        }
        if (filetype == ".png")
        {
            Response.ContentType = "image/png";
        }
        if (filetype == ".xlsx" || filetype == ".xls")
        {
            Response.ContentType = "Application/x-msexcel";
        }
        Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename);
Response.WriteFile(Server.MapPath(hdnAdmit.Value));
        Response.End();
    }
}