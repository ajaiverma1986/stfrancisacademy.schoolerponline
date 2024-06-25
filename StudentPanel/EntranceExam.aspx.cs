using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class StudentPanel_EntranceExam : System.Web.UI.Page
{
    int Brid = 0;
    public DataUtility objdut = new DataUtility();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        Receipt();
    }
    protected void Receipt()
    {
        try
        {
            if (Session["UserBrid"] != null)
            {
                Brid = Convert.ToInt32(Session["UserBrid"]);
                string str = "Select * from tbl_StudentRegistration sr " +
                             " inner join Class_Master cm on sr.ApplyingForClass = cm.id " +
                             "where sr.RID=" + Session["UserRID"] + " and Sr.Brid=" + Brid + "";

                dt = objdut.GetDataTable(str);
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["ExamDate"].ToString() != "")
                    {
                        lblExamDate.Text = Convert.ToDateTime(dt.Rows[0]["ExamDate"]).ToString("dd MMMM yyyy") + "-" + dt.Rows[0]["ExamTime"].ToString();
                    }
                    lblMaxMarks.Text = dt.Rows[0]["MaxMarks"].ToString();
                    lblObtainMarks.Text = dt.Rows[0]["ObtainMarks"].ToString();
                    lblResult.Text = dt.Rows[0]["Result"].ToString();
                }
            }
        }
        catch
        {

        }
        finally
        {
        }
    }
}