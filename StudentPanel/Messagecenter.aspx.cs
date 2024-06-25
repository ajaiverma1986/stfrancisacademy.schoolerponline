using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class StudentPanel_Messagecenter : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["StuRegNo"] == null)
            {
                Response.Redirect("../user-login.aspx");
            }             
    }

    public class StudentMessage
    {
        public string SnId { get; set; }

        public string Message { get; set; }

        public string ActiveFrom { get; set; }
    }

    [WebMethod]
    public static StudentMessage[] BindStudentMessage()
    {
        DataSet Ds = new DataSet();
        List<StudentMessage> MessageList = new List<StudentMessage>();
        DataUtility Objdut = new DataUtility();
        int id = Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]);
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@sturegno", id);
        Ds = Objdut.GetDataSetSP(param, "Usp_BindStudentMessage");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                StudentMessage userSecond = new StudentMessage();
                userSecond.SnId = dtrow["SnId"].ToString();
                userSecond.Message = dtrow["Message"].ToString();
                userSecond.ActiveFrom = dtrow["ActiveFrom"].ToString();
                MessageList.Add(userSecond);
            }
        }
        return MessageList.ToArray();
    }

    [WebMethod]
    public static int DeleteMesage(string tid)
    {
        int result = 0;
        DataUtility objdut = new DataUtility();
        char[] delimiterChars = { ',' };
        string[] words = tid.Split(delimiterChars);
        foreach (string s in words)
        {
            if (s != "")
            {
                result = objdut.ExecuteSql("update tbl_studentmessage set status=0,isdeleted=1 where tbid=" + s);
            }
        }
        return result;
    }  
}