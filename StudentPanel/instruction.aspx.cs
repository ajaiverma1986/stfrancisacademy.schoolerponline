using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class StudentPanel_instruction : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["StuRegNo"] == null)
        {
            Response.Redirect("logout.aspx");
        }
    }
    [WebMethod]
    public static BindInstructionList[] BindInstructionByJs()
    {
        DataTable Dt;
        List<BindInstructionList> InstructionList = new List<BindInstructionList>();
        DataUtility Objdut = new DataUtility();
        string Query = @"select Instruction From [tbl_ExamInstruction] inner join tbl_OnlineExamInstruction_Master on 
             tbl_ExamInstruction.Id=tbl_OnlineExamInstruction_Master.instructionid
           and tbl_OnlineExamInstruction_Master.Exam_id=" + HttpContext.Current.Session["Examid"] + @" and tbl_OnlineExamInstruction_Master.status=1 where tbl_ExamInstruction.Status=1 and 
          Brid=(Select Brid From Student_Master Where SturegNo=" +HttpContext.Current.Session["StuRegNo"]+")";
        Dt = Objdut.GetDataTable(Query);
        if (Dt.Rows.Count > 0)
        {
            for (int i = 0; i < Dt.Rows.Count;i++ )
            {
                BindInstructionList user = new BindInstructionList();
                user.Instruction = Convert.ToString(Dt.Rows[i]["Instruction"]);
                InstructionList.Add(user);
            }
        }
        return InstructionList.ToArray();
    }

    public class BindInstructionList
    {
        public string Instruction { get; set; }      
    }
}