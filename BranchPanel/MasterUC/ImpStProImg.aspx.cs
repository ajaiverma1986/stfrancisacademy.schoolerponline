using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.IO;
using System.Drawing;

using System.Text;
using Excel;
using System.Globalization;
public partial class BranchPanel_MasterUC_ImpStProImg : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        //try
        //{
        //    if (Request.Files["myFile"] != null && Request.Files.Count > 0)
        //    {
        //        UpLoadProfilePic();
        //    }
        //}
        //catch (Exception ex)
        //{
        //    //string strError = csGlobalFunction.ExceptionError(ex.GetType().FullName).ToString();
        //    //if (strError != "")
        //    //{
        //    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Alert", "javascript:AlertMsg('" + strError + "');", true);
        //    //}
        //}
    }
    //    string FileType = "";
    //    string[] StdID;
    //    int FileSize;
    //    string[] FileName;
    //    Byte[] FileByteArray;
    //    private void UpLoadProfilePic()
    //    {
    //        DataTable dtPP = new DataTable();
    //        dtPP.Columns.Add("StudentID", typeof(decimal));
    //        dtPP.Columns.Add("FileName", typeof(string));
    //        dtPP.Columns.Add("FileType", typeof(string));
    //        dtPP.Columns.Add("FileSize", typeof(decimal));
    //        dtPP.Columns.Add("FileStream", typeof(byte[]));
    //        dtPP.Columns.Add("Mode", typeof(string));
    //        try
    //        {
    //            if ((Session["dtpp"]) == null)
    //            {
    //                if (Request.Files["myFile"] != null)
    //                {
    //                    if (Request.Files.Count > 0)
    //                    {
    //                        if (validate())
    //                        {
    //                            for (int i = 1; i < Request.Files.Count; i++)
    //                            {
    //                                HttpPostedFile MyFile = Request.Files[i];
    //                                DataRow dr = dtPP.NewRow();
    //                                try
    //                                {
    //                                    int StudentID = Convert.ToInt32(objdut.GetScalar(@"Select ISNULL(SR.RID,0) RID from tbl_StudentRegistration SR
    //                                                    inner join tbl_StudentMaster SM on SR.RID = SM.RID
    //                                                    where SR.Registration_No='" + FileName[0].Trim().ToString() + "' and SR.Brid = " + Convert.ToInt32(Session["BrBrid"]) + "Adm_StdInfo.StudentCode='" + FileName[0].Trim().ToString() + "' and Std_ProfileImages.RelationType = 'Student'"));
    //                                    FileType = MyFile.ContentType;

    //                                    FileSize = MyFile.ContentLength;

    //                                    Stream fs = MyFile.InputStream;
    //                                    BinaryReader br = new BinaryReader(fs);
    //                                    FileByteArray = br.ReadBytes((Int32)fs.Length);

    //                                    if (FileByteArray.Length > 0)
    //                                    {
    //                                        dr["FileStream"] = (byte[])(FileByteArray);
    //                                    }

    //                                    if (FileName[0] != "")
    //                                    {
    //                                        dr["FileName"] = MyFile.FileName.ToString();
    //                                    }
    //                                    if (FileType != "")
    //                                    {
    //                                        dr["FileType"] = FileType.ToString();
    //                                    }
    //                                    if (FileSize > 0)
    //                                    {
    //                                        dr["FileSize"] = Convert.ToInt32(FileSize);
    //                                    }

    //                                    if (MyFile.FileName.ToString() != "" && FileByteArray.Length > 0 && FileType != "" && FileSize > 0)
    //                                    {
    //                                        if (fileuploaderofstudentphotograph.HasFile)
    //                                        {
    //                                            string FileName = Convert.ToString(IdStudent) + fileuploaderofstudentphotograph.FileName;
    //                                            fileuploaderofstudentphotograph.PostedFile.SaveAs(Server.MapPath("~/BranchPanel/Student-Registration/student-registration-document/" + FileName));
    //                                            Param[19] = new SqlParameter("@StudentPhotograph", FileName);
    //                                        }
    //                                        else
    //                                        {
    //                                            Param[19] = new SqlParameter("@StudentPhotograph", "");
    //                                        }
    //                                    }
    //                                }
    //                                catch (Exception ex)
    //                                {
    //                                    string strFnc = "";
    //                                    strFnc = ex.Message;
    //                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Alert", "javascript:AlertMsg('" + strFnc + ".');", true);
    //                                }
    //                                dtPP.Rows.Add(dr);
    //                            }
    //                            Session["dtpp"] = dtPP;
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //        catch (Exception ex)
    //        {
    //            //string strError = csGlobalFunction.ExceptionError(ex.GetType().FullName).ToString();
    //            //if (strError != "")
    //            //{
    //            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Alert", "javascript:AlertMsg('" + strError + "');", true);
    //            //}
    //        }
    //    }

    protected void btnUploadPP_Click(object sender, EventArgs e)
    {
        if (fileuploadimages.HasFile == false)
        {
            string Error = "No File FOund";
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", Error, true);
        }
        else
        {
            int Count = 0;
            foreach (HttpPostedFile file in fileuploadimages.PostedFiles)
            {
                string filename1 = Path.GetFileName(file.FileName);
                string filename = Path.GetFileNameWithoutExtension(file.FileName);

                file.SaveAs(Server.MapPath("~/BranchPanel/Student-Registration/student-registration-document/" + filename1));

                int RID = Convert.ToInt32(objdut.GetScalar(@"Select ISNULL(SR.RID,0) RID from tbl_StudentRegistration SR
                                                    inner join tbl_StudentMaster SM on SR.RID = SM.RID
                                                    where SR.Registration_No='" + filename.Trim().ToString() + "' and SR.Brid = " + Convert.ToInt32(Session["BrBrid"]) + ""));
                if (RID > 0)
                {
                    //fileuploadimages.PostedFile.SaveAs(Server.MapPath("~/BranchPanel/Student-Registration/student-registration-document/" + filename1));

                    int Updated = Convert.ToInt32(objdut.ExecuteSql(@"UPDATE tbl_StudentRegistration SET StudentPhotograph ='" + filename1.Trim().ToString() + "'" +
                                                      " where Registration_No='" + filename.Trim().ToString() + "' and RID=" + RID + " and Brid = " + Convert.ToInt32(Session["BrBrid"]) + ""));
                }
                else
                {
                    Count++;
                }
            }
            if (Count > 0)
            {
                Utility.ViewAlertMessage(this, "Some Student Profile Picture not Updated");
            }
            else
            {
                Utility.ViewAlertMessage(this, "Student Profile Picture Updated");
            }
        }
    }

    protected void btnUploadResult_Click(object sender, EventArgs e)
    {
        if (fileupload1.HasFile == false)
        {
            string Error = "No File Found";
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", Error, true);
        }
        else
        {
            int Count = 0;
            var regNumbers = "";
            foreach (HttpPostedFile file in fileupload1.PostedFiles)
            {
                string fileexe = Path.GetExtension(file.FileName);
                int result = 0;
                if (fileexe == ".pdf" || fileexe == ".PDF")
                {
                    string FileName = Path.GetFileName(file.FileName);
                    string Regnum = Path.GetFileNameWithoutExtension(file.FileName);
                    string savepath = "";
                    string tempPath = "";
                    if (!Directory.Exists(Server.MapPath("~/uploads/Result")))
                    {
                        Directory.CreateDirectory(Server.MapPath("~/uploads/Result"));
                    }
                    savepath = Server.MapPath("~/uploads/Result") + "/" + "result_" + FileName;
                    file.SaveAs(savepath);
                    DataUtility dtutil = new DataUtility();
                    if (!string.IsNullOrWhiteSpace(Regnum))
                    {
                        result = dtutil.ExecuteSql("update tbl_studentmaster set ResultFilePath='~/uploads/Result/result_" + FileName + "' where Registration_No='" + Regnum + "'");
                    }                    
                    if (result > 0)
                    {
                        regNumbers = regNumbers == "" ? Regnum : (regNumbers + "," + Regnum);
                    }

                }
            }
            if (regNumbers != "")
            {
                Utility.ViewAlertMessage(this, "Result uploaded for these: " + regNumbers);
            }
            else
            {
                Utility.ViewAlertMessage(this, "Result not uploaded");
            }
        }
    }
    protected void BtnUploadResult_Clickadmit(object sender, EventArgs e)
    {
        if (fileupload2.HasFile == false)
        {
            string Error = "No File Found";
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Alert", Error, true);
        }
        else
        {
            int Count = 0;
            var regNumbers = "";
            foreach (HttpPostedFile file in fileupload2.PostedFiles)
            {
                string fileexe = Path.GetExtension(file.FileName);
                int admit = 0;
                if (fileexe == ".pdf" || fileexe == ".PDF")
                {
                    string FileName = Path.GetFileName(file.FileName);
                    string Regnum = Path.GetFileNameWithoutExtension(file.FileName);
                    string savepath = "";
                    string tempPath = "";
                    if (!Directory.Exists(Server.MapPath("~/uploads/Admit")))
                    {
                        Directory.CreateDirectory(Server.MapPath("~/uploads/Admit"));
                    }
                    savepath = Server.MapPath("~/uploads/Admit") + "/" + "admit_" + FileName;
                    file.SaveAs(savepath);
                    DataUtility dtutil = new DataUtility();
                    if (!string.IsNullOrWhiteSpace(Regnum))
                    {
                        admit = dtutil.ExecuteSql("update tbl_studentmaster set Admitfilepath='~/uploads/Admit/admit_" + FileName + "' where Registration_No='" + Regnum + "'");
                    }
                    if (admit > 0)
                    {
                        regNumbers = regNumbers == "" ? Regnum : (regNumbers + "," + Regnum);
                    }

                }
            }
            if (regNumbers != "")
            {
                Utility.ViewAlertMessage(this, "Result uploaded for these: " + regNumbers);
            }
            else
            {
                Utility.ViewAlertMessage(this, "Admit not uploaded");
            }
        }
    }
}