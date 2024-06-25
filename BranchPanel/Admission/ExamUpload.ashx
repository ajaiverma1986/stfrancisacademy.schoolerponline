<%@ WebHandler Language="C#" Class="Upload" %>

using System;
using System.Web;
using System.IO;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public class Upload : IHttpHandler
{    
    public void ProcessRequest(HttpContext context)
    {        
        context.Response.ContentType = "text/plain";
        context.Response.Expires = -1;
        try
        {
            HttpPostedFile postedFile = context.Request.Files["fileupload"];
            var Regnum = (string)context.Request.Form["regnum"];
            if (postedFile.ContentLength > 0)
            {
                if (postedFile.ContentLength <= 5242880)
                {
                    string fileexe = Path.GetExtension(postedFile.FileName);
                    if (fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".pdf")
                    {
                        int iLen = postedFile.ContentLength;
                        byte[] b = new byte[iLen];
                        postedFile.InputStream.Read(b, 0, iLen);
                        string Extension = Path.GetExtension(postedFile.FileName);
                        string FileName = Path.GetFileName(postedFile.FileName);
                        string savepath = "";
                        string tempPath = "";
                        if (!Directory.Exists(context.Server.MapPath("~/uploads/Result")))
                        {
                            Directory.CreateDirectory(context.Server.MapPath("~/uploads/Result"));
                        }
                        savepath = context.Server.MapPath("~/uploads/Result") + "/" + "result_" + Regnum + fileexe;
                        postedFile.SaveAs(savepath);
                        DataUtility dtutil = new DataUtility();
                        dtutil.ExecuteSql("update tbl_studentmaster set ResultFilePath='~/uploads/Result/result_" + Regnum + fileexe + "' where Registration_No='" + Regnum + "'");
                        context.Response.StatusCode = 200;
                    }
                }
                else
                {
                    context.Response.Write("Image Size Must Be Less Than 5MB.");
                    context.Response.StatusCode = 500;
                }
            }
            else
            {
                context.Response.Write("No File Selected.");
            }
        }
        catch (Exception ex)
        {
            context.Response.Write("Error: " + ex.Message);
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}