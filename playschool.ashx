<%@ WebHandler Language="C#" Class="playschool" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Diagnostics;
using System.Text;
using System.Data;
using System.Drawing;
using System.Data.SqlClient;
using System.Text.RegularExpressions;


public class playschool : IHttpHandler {
    public static DataTable dt = null;
    public static DataTable dt2 = new DataTable();
    DataUtility objdut = new DataUtility();
    Utility objut = new Utility();
    public static int pridcount = 0; 
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello World");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}