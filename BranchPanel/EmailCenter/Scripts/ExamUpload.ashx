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
            HttpPostedFile postedFile = context.Request.Files["Filedata"];
            if (postedFile.ContentLength > 0)
            {
                if (postedFile.ContentLength <= 5242880)
                {
                    string fileexe = Path.GetExtension(postedFile.FileName);
                    if (fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".gif")
                    {
                        int iLen = postedFile.ContentLength;
                        byte[] b = new byte[iLen];
                        postedFile.InputStream.Read(b, 0, iLen);
                        string Extension = Path.GetExtension(postedFile.FileName);
                        string FileName = Path.GetFileName(postedFile.FileName);
                        string savepath = "";
                        string tempPath = "";
                        tempPath = System.Configuration.ConfigurationManager.AppSettings["EmailCenter"];
                        savepath = context.Server.MapPath(tempPath + "\\" + FileName);
                        MasterImageUpload.CreateImage(b, FileName, Extension, savepath,1);
                        context.Response.Write(tempPath + "/" + FileName);
                        context.Response.StatusCode = 200;
                    }
                }
                else
                {
                    context.Response.Write("Image Size Must Be Less Than 5MB.");
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