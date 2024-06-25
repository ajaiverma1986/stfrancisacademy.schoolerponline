using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;

public partial class ParentPanel_uploadactivity : System.Web.UI.Page
{
    private string pname, url;
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private FileInfo finfoevent;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["ADID4"] == null)
        {
            Response.Redirect("~/LoginP.aspx");
        }
        if (!IsPostBack)
        {
            ViewState["acad"] = CommonClass.Scaler("ActiveAcademicYear");
            bindgrid();
            divtopbtn.Visible = false;
            divtop.Visible = true;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        System.Threading.Thread.Sleep(2000);
        if (btnSubmit.Text == "Upload")
        {
            int idfac = Convert.ToInt32(objdut.GetScalar("select ISNULL(Max(fid),0) from tblFiles"));
            idfac++;
            pname = "usp_fileupload";
            SqlParameter[] param = new SqlParameter[7];
            param[0] = new SqlParameter("@mode", "insert");
            param[1] = new SqlParameter("@brid", Session["Branchid"]);
            param[2] = new SqlParameter("@stregid", Session["stregno"]);
            param[3] = new SqlParameter("@intresult", Convert.ToInt32("0"));
            param[3].Direction = ParameterDirection.Output;
            param[4] = new SqlParameter("@status", Convert.ToInt16(0));
            if (FileUpload1.HasFile)
            {
                string fileexe = Path.GetExtension(FileUpload1.FileName);
                string contentType = FileUpload1.PostedFile.ContentType;
                if (fileexe.ToUpper() == ".JPG" || fileexe.ToUpper() == ".JPEG" || fileexe.ToUpper() == ".PNG" || fileexe.ToUpper() == ".GIF" || fileexe.ToUpper() == ".TXT" || fileexe.ToUpper() == ".DOC" || fileexe.ToUpper() == ".DOCX" || fileexe.ToUpper() == ".XLS")
                {
                    string filename = Path.GetFileName(FileUpload1.PostedFile.FileName);

                    if (fileexe.ToUpper() == ".TXT" || fileexe.ToUpper() == ".DOC" || fileexe.ToUpper() == ".DOCX" || fileexe.ToUpper() == ".XLS")
                    {
                        string targetPath = Server.MapPath(("~/Teacherloginpanel/teacherdocument/" + idfac + filename));
                        Stream strm = FileUpload1.PostedFile.InputStream;
                        var targetFile = targetPath;
                        FileUpload1.SaveAs(Server.MapPath("~/Teacherloginpanel/teacherdocument/" + filename));
                    }
                    else if (fileexe.ToUpper() != ".TXT" && fileexe.ToUpper() != ".DOC")
                    {
                        string targetPath = Server.MapPath(("~/Teacherloginpanel/teacherdocument/" + idfac + filename));
                        Stream strm = FileUpload1.PostedFile.InputStream;
                        var targetFile = targetPath;
                        GenerateThumbnails(0.5, strm, targetFile);
                    }
                    param[5] = new SqlParameter("@fname", idfac + filename);
                    param[6] = new SqlParameter("@conttype", contentType);
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Only Image files can be uploaded.");
                    return;
                }
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "An error occured. Please try again.");
                return;
            }

            int count = objdut.ExecuteSqlSP(param, pname);
            if (count == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "File Upload Successfully.!");
                bindgrid();
                divtopbtn.Visible = false;
                divgrid.Visible = true;
                divtop.Visible = true;
                return;
            }
        }
        else if (btnSubmit.Text == "update")
        {
            int idfac = Convert.ToInt32(objdut.GetScalar("select ISNULL(Max(fid),0) from tblFiles"));
            idfac++;
            string pname = "usp_fileupload";
            SqlParameter[] param = new SqlParameter[8];
            param[0] = new SqlParameter("@mode", "update");
            param[1] = new SqlParameter("@fid", ViewState["photoid"]);
            param[2] = new SqlParameter("@brid", Convert.ToDouble(Session["brid1"]));
            param[3] = new SqlParameter("@stregid", Session["stregno"]);
            param[4] = new SqlParameter("@intresult", Convert.ToInt32("0"));
            param[4].Direction = ParameterDirection.Output;

            if (FileUpload1.HasFile)
            {
                if (FileUpload1.PostedFile.ContentLength <= 4958168)
                {
                    string fileexe = Path.GetExtension(FileUpload1.FileName);
                    string contentType = FileUpload1.PostedFile.ContentType;
                    if (fileexe.ToUpper() == ".JPG" || fileexe.ToUpper() == ".JPEG" || fileexe.ToUpper() == ".PNG" || fileexe.ToUpper() == ".GIF")
                    {
                        if (ViewState["pic"] != null)
                        {
                            File.Delete(Server.MapPath("~/Teacherloginpanel/teacherdocument/" + ViewState["pic"].ToString()));
                            finfoevent = new FileInfo(ViewState["pic"].ToString());
                            finfoevent.Delete();
                        }
                        string filename = Path.GetFileName(FileUpload1.PostedFile.FileName);
                        string targetPath = Server.MapPath(("~/Teacherloginpanel/teacherdocument/" + idfac + filename));
                        Stream strm = FileUpload1.PostedFile.InputStream;
                        var targetFile = targetPath;
                        GenerateThumbnails(0.5, strm, targetFile);
                        param[5] = new SqlParameter("@fname", idfac + filename);
                        param[6] = new SqlParameter("@conttype", contentType);
                    }
                    else
                    {
                        Utility.ViewAlertMessage(this.Master.Page, "Only Image files can be uploaded.");
                        return;
                    }
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "File size greater than 5 mb.");
                    FileUpload1.Focus();
                    return;
                }
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "please Select File for upload.");
                FileUpload1.Focus();
                return;
            }

            param[7] = new SqlParameter("@status", 1);
            int intresult = objdut.ExecuteSqlSP(param, pname);
            if (intresult > 0)
            {
                Utility.ViewAlertMessage(this.Master.Page, "File Sucessfully Updated.");
                btnSubmit.Text = "Upload";
                imgsource1.ImageUrl = "";
                imgsource1.Visible = false;
                bindgrid();
                divtopbtn.Visible = false;
                divgrid.Visible = true;
                divtop.Visible = true;
                return;
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "An error occured. Please try again.");
                return;
            }
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
            thumbnailImg.Save(targetPath, image.RawFormat);
        }
    }

    public void bindgrid()
    {
        dt = CommonClass.parentdetails("getfilegrid", Convert.ToInt32(Session["stregno"]), Convert.ToInt32(Session["Branchid"]));

        if (dt.Rows.Count > 0)
        {
            grdfiles.DataSource = dt;
            grdfiles.DataBind();
        }
        else
        {
            grdfiles.EmptyDataText = "No Record Found.!";
            grdfiles.DataBind();
        }
    }

    protected void grdfiles_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        btnSubmit.Text = "update";
        imgsource1.Visible = true;
        if (e.CommandName == "Edit1")
        {
            divtopbtn.Visible = true;
            divgrid.Visible = false;
            divtop.Visible = false;
            int fid = Convert.ToInt32(e.CommandArgument);
            ViewState["photoid"] = fid;

            string query = "select (case fname when '' then '~/images/9update.png' else ('~/Teacherloginpanel/teacherdocument/'+fname) end ) as photo  from tblFiles where fid=" + fid;
            imgsource1.ImageUrl = Convert.ToString(objdut.GetScalar(query));

            string sr = "select fname from tblFiles where fid=" + fid;

            ViewState["pic"] = Convert.ToString(objdut.GetScalar(sr));
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        imgsource1.Visible = false;
        divtopbtn.Visible = true;
        divgrid.Visible = false;
        divtop.Visible = false;
    }

    protected void btncancel_Click(object sender, EventArgs e)
    {
        divtopbtn.Visible = false;
        divgrid.Visible = true;
        divtop.Visible = true;
    }
}