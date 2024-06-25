using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Web.UI.WebControls;

public partial class BranchPanel_Faculty_updateprofile1 : System.Web.UI.Page
{
    private SqlParameter[] param;
    private DataUtility OBJDut = new DataUtility();
    private Utility objUT = new Utility();
    private DataTable dt;
    private string url = "", query;
    private FileInfo finfoevent;
    private int refNo = 0;
    private int facID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (Session["facID"] == null)
        {
            Response.Redirect("viewfaculty.aspx");
        }
        if (!IsPostBack)
        {
            facID = Convert.ToInt16(Session["facID"]);

            txtRefNo.Enabled = false;
            showDetails(facID);
            //ddlcourse();
            ddlproqul();
            fillddl();
        }
    }

    private void fillddl()
    {
        ddlTitle.DataSource = CommonClass.ABC("ddlTitle");
        ddlTitle.DataTextField = "Title";
        ddlTitle.DataValueField = "Titleid";
        ddlTitle.DataBind();
        ddlTitle.Items.Insert(0, new ListItem("-Select Title-", "0"));
    }

    private void ddlproqul()
    {
        string str = "select name,id from tblprofessionalqualification where status=1 ";
        DataTable dtn = OBJDut.GetDataTable(str);
        if (dtn.Rows.Count > 0)
        {
            DropDownList1.DataSource = dtn;
            DropDownList1.DataTextField = "name";
            DropDownList1.DataValueField = "id";
            DropDownList1.DataBind();
            DropDownList1.Items.Insert(0, new ListItem("--Professional Qualification--", "0"));
        }
    }

    //private void ddlcourse()
    //{
    //    ddlqua.DataSource = CommonClass.ABC("ddlQualification");
    //    ddlqua.DataTextField = "name";
    //    ddlqua.DataValueField = "qid";
    //    ddlqua.DataBind();
    //    ddlqua.Items.Insert(0, new ListItem("-Select Heighest Qualification-", "0"));
    //}
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        facID = Convert.ToInt16(Session["facID"]);
        param = new SqlParameter[17];
        //param[0] = new SqlParameter("@mode",2);
        param[0] = new SqlParameter("@fName", txtFName.Text.Trim());
        param[1] = new SqlParameter("@mName", txtMName.Text.Trim());
        param[2] = new SqlParameter("@lName", txtLName.Text.Trim());

        param[3] = new SqlParameter("@dob", txtToDate.Text.Trim());

        param[4] = new SqlParameter("@gender", rbgender.SelectedValue);

        param[5] = new SqlParameter("@address", txtPAddress.Text.Trim());
        param[6] = new SqlParameter("@mobile", txtMobileNo2.Text.Trim());
        param[7] = new SqlParameter("@emailID", txtMEmailid.Text.Trim());
        param[8] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));

        param[9] = new SqlParameter("@intResult", Convert.ToInt16("0"));
        param[9].Direction = ParameterDirection.Output;
        param[10] = new SqlParameter("@PQualificationID", DropDownList1.SelectedValue);

        param[11] = new SqlParameter("@totalExperience", ddlexp.SelectedValue);
        param[12] = new SqlParameter("@refNo", txtRefNo.Text.Trim());
        param[13] = new SqlParameter("@doj", txtDate.Text.Trim());

        if (ddlTitle.SelectedValue != "0")
        {
            param[14] = new SqlParameter("@title", ddlTitle.SelectedItem.Text);
        }
        else
        {
            param[14] = new SqlParameter("@title", "");
        }
        param[15] = new SqlParameter("@facid", facID);
        if (fuPhoto.HasFile)
        {
            string fileexe = Path.GetExtension(fuPhoto.FileName);
            if (fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".gif")
            {
                if (ViewState["pic"] != null)
                {
                    File.Delete(Server.MapPath("~/facultyimage/" + ViewState["pic"].ToString()));
                    finfoevent = new FileInfo(ViewState["pic"].ToString());
                    finfoevent.Delete();
                }
                string filename = Path.GetFileName(fuPhoto.PostedFile.FileName);
                string path = Server.MapPath("~/facultyimage/");
                fuPhoto.SaveAs(Server.MapPath("~/facultyimage/" + facID + filename));
                param[16] = new SqlParameter("@photo", facID + filename);
            }
            else
            {
                param[16] = new SqlParameter("@photo", lblPhoto.Text);
            }
        }
        else
        {
            param[16] = new SqlParameter("@photo", lblPhoto.Text);
        }

        int result = OBJDut.ExecuteSqlSP(param, "usp_appl");

        if (result >= 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Faculty details updated successfully!!");
            showDetails(facID);
            Response.Redirect("viewfaculty.aspx");
            return;
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Error...!! !");
            return;
        }
    }

    private void GenerateThumbnails(double scaleFactor, Stream sourcePath, string targetPath)
    {
        using (var image = System.Drawing.Image.FromStream(sourcePath))
        {
            var newWidth = (int)(image.Width * scaleFactor);
            var newHeight = (int)(image.Height * scaleFactor);
            var thumbnailImg = new Bitmap(newWidth, newHeight);
            var thumbGraph = Graphics.FromImage(thumbnailImg);
            thumbGraph.CompositingQuality = CompositingQuality.HighQuality;
            thumbGraph.SmoothingMode = SmoothingMode.HighQuality;
            thumbGraph.InterpolationMode = InterpolationMode.HighQualityBicubic;
            var imageRectangle = new Rectangle(0, 0, newWidth, newHeight);
            thumbGraph.DrawImage(image, imageRectangle);
            //thumbnailImg.Save(targetPath, image.RawFormat);
        }
    }

    protected void showDetails(int id)
    {
        //string eid = Session["id"].ToString();
        //        string str = @"select eid,  TE.refNo,T.Titleid,T.Title, TE.fname, isnull(TE.mname,'')as name ,TE.lname,convert(varchar(13),te.dob,101) as DOB1,te.address,te.phone,te.emailID,te.photo,TE.gender,te.PQualficationID,te.totalExperience,
        //          convert(varchar(13),te.doj,101) as doj from tblEmp_Master TE ,Title T ,tblProbationPeriod TP where TP.id=Te.probationPeriond and T.Title=Te.title and    TE.eid="+eid ;
        string str = @"select eid,Te.Title,T.Titleid, refNo,fname, isnull(mname,'')as name ,lname,convert(varchar(13),dob,101) as DOB1,address,mobile,emailID,Te.photo,gender,PQualficationID,totalExperience,
                         convert(varchar(13),doj,101) as doj   from tblEmp_Master te, Title T where T.Title=Te.title and  brid=" + Convert.ToInt16(Session["BrBrid"]) + " and eid=" + Session["facID"];
        dt = OBJDut.GetDataTable(str);

        if (dt.Rows.Count > 0)
        {
            //ViewState["eid"] = dt.Rows[0]["eid"].ToString();
            txtRefNo.Text = dt.Rows[0]["refNo"].ToString();
            ddlTitle.SelectedValue = dt.Rows[0]["Titleid"].ToString();
            //ddlTitle.SelectedItem.Value = dt.Rows[0]["title"].ToString();
            txtFName.Text = dt.Rows[0]["fName"].ToString().ToUpper();
            txtMName.Text = dt.Rows[0]["name"].ToString().ToUpper();
            txtLName.Text = dt.Rows[0]["lName"].ToString().ToUpper();

            rbgender.SelectedValue = dt.Rows[0]["gender"].ToString();
            txtToDate.Text = dt.Rows[0]["DOB1"].ToString();
            txtPAddress.Text = dt.Rows[0]["address"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["photo"].ToString()))
            {
                ViewState["pic"] = dt.Rows[0]["photo"].ToString();
            }
            else
            {
                ViewState["pic"] = null;
            }
            txtMobileNo2.Text = dt.Rows[0]["mobile"].ToString();
            txtMEmailid.Text = dt.Rows[0]["emailID"].ToString();
            //if (!string.IsNullOrEmpty(dt.Rows[0]["PQualficationID"].ToString()))
            //{
            //   DropDownList1.SelectedValue = dt.Rows[0]["PQualficationID"].ToString();
            //}
            //else
            //{
            //    DropDownList1.SelectedIndex = 0;
            //}
            // ddlqua.SelectedValue = dt.Rows[0]["PQualficationID"].ToString();
            // ddlcourse();
            //if (!string.IsNullOrEmpty(dt.Rows[0]["PQualficationID"].ToString()))
            //{
            //    DropDownList1.SelectedValue = dt.Rows[0]["PQualficationID"].ToString();
            //}
            //else
            //{
            //    DropDownList1.SelectedValue = "0";
            //}
            //DropDownList1.SelectedValue = dt.Rows[0]["PQualficationID"].ToString();

            if (dt.Rows[0]["PQualficationID"].ToString() == "0")
            {
                DropDownList1.SelectedIndex = 0;
            }
            else
            {
                DropDownList1.SelectedValue = dt.Rows[0]["PQualficationID"].ToString();
            }
            txtDate.Text = dt.Rows[0]["doj"].ToString();

            if (!string.IsNullOrEmpty(dt.Rows[0]["totalExperience"].ToString()))
            {
                ddlexp.SelectedValue = dt.Rows[0]["totalExperience"].ToString();
            }
            else
            {
                ddlexp.SelectedIndex = 0;
            }
        }
    }
}