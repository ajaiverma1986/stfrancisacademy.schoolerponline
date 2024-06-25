using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TeacherPanel_upload_assignment : System.Web.UI.Page
{
    private string url = "", query = "", filename, AllSturegno="";
    private int idStudent = 0, count = 0;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private FileInfo finfoevent;
    private int id = 0;
    private int lecid = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["empid"] != null)
        {
            if (!IsPostBack)
            {
                btnSend.Visible = false;
                fillgrid();
            }
        }
    }

    private void RegisterPostBackControl()
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            LinkButton lnkFull = row.FindControl("lblcname6") as LinkButton;
            ScriptManager.GetCurrent(this).RegisterPostBackControl(lnkFull);
        }
    }

    private void fillgrid()
    {
       
        string query = "select assignid,document,topicname,convert(varchar(13),uploadon,106) as uploadon  from tbl_assignment where status=1 and facultyid=" + Session["empid"];
        dt = objdut.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            GridView1.DataSource = dt;
            GridView1.DataBind();
            GridView1.Visible = true;
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
        }
        dt.Dispose();
        forurl.Value = Convert.ToString(objdut.GetScalar("Select Url From tbl_institutemaster"));
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
        idStudent = Convert.ToInt16(objdut.GetScalar("select isnull(max(assignid),0)+1 from tbl_assignment where status=1"));
        if (ddlbatch.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Batch.");
            return;
        }
        if (ddlsubject.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Subject.");
            return;
        }
        foreach (GridViewRow gvr in grdForStudent.Rows)
        {
            CheckBox chkclass = gvr.FindControl("chkclass") as CheckBox;
            HiddenField StuRegNo = gvr.FindControl("HD1") as HiddenField;
            if (chkclass.Checked==true)
            {
                AllSturegno = AllSturegno + "," + StuRegNo.Value;
            }
        }
        if (AllSturegno == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Atleast One Student.");
            return;
        }
        else
        {
            AllSturegno = AllSturegno.Remove(0, 1);
        }
        if (txttopic.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Topic");
            return;
        }
        if (fu1.HasFile)
        {
            if (fu1.PostedFile.ContentLength <= 524288)
            {
                filename = Path.GetFileName(fu1.PostedFile.FileName);
                lecid = Convert.ToInt32(objdut.GetScalar("select LecID from Lecture_Master where SubId=" + ddlsubject.SelectedValue + "and batchid=" + ddlbatch.SelectedValue));
               
                fu1.SaveAs(Server.MapPath("../BranchPanel/examresult/" + idStudent + filename));
                SqlParameter[] param = new SqlParameter[9];
                string pname = "usp_uploadassignment";
                param[0] = new SqlParameter("@document", idStudent + filename);
                param[1] = new SqlParameter("@batchid", ddlbatch.SelectedValue);
                param[2] = new SqlParameter("@subjectid", ddlsubject.SelectedValue);
                param[3] = new SqlParameter("@topicname", txttopic.Text.Trim());
                param[4] = new SqlParameter("@lecid ", lecid);
                param[5] = new SqlParameter("@url", Request.Url.ToString());
                param[6] = new SqlParameter("@intresult", 0);
                param[6].Direction = ParameterDirection.Output;
                param[7] = new SqlParameter("@facultyid", Session["empid"]);
                param[8] = new SqlParameter("@AllSturegno", AllSturegno);
                int result = objdut.ExecuteSqlSP(param, pname);
                if (result > 0)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "File uploaded successfully");
                    fillgrid();
                    dd2.Visible = false;
                    Button1.Visible = true;

                    grdshw.Visible = true;

                    btnSend.Visible = false;
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "error!!!!!!");
                }
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "File size greater than 512 KB!!!");

                return;
            }
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select File");
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        txttopic.Text = "";
        dd2.Visible = true;
        grdshw.Visible = false;
        Button1.Visible = false;
        btnSend.Visible = true;
       // fillSubject();
        fillbatch();
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "dele1")
        {
            id = Convert.ToInt16(e.CommandArgument);
            string query2 = "Update tbl_assignment set status=0,uploadon=getdate() where assignid=" + id + "";
            count = objdut.ExecuteSql(query2);
            if (count == 1)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Assignment Has Been Deleted Successfully.')", true);
                Control ctrl = e.CommandSource as Control;
                if (ctrl != null)
                {
                    GridViewRow row = ctrl.Parent.NamingContainer as GridViewRow;
                    Label lblAssaignedto = (Label)row.FindControl("lblfilename");

                    string filepath = lblAssaignedto.Text;
                    filepath = "Z:/institutedemo/devloping_currentcode/currentcode/BranchPanel/examresult/" + filepath;//Active when local
                    //filepath = Convert.ToString(objdut.GetScalar("Select Url From tbl_institutemaster")) + filepath;//Active when online
                    FileInfo file = new FileInfo(filepath);
                    if (file.Exists)
                    {
                        file.Delete();
                    }
                }
                fillgrid();
                return;
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Please Try Again.')", true);
                fillgrid();
                return;
            }
        }
    }

    protected void txttopic_TextChanged(object sender, EventArgs e)
    {
        int count3 = Convert.ToInt32(objdut.GetScalar("select count(1) from tbl_assignment where topicname='" + txttopic.Text + "' and status=1 and lectureid=" + Convert.ToInt32(Session["empid"]) + ""));
        if (count3 > 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "This document  already exists!!!");
            fillgrid();
            dd2.Visible = false;
            btnSend.Visible = false;
            grdshw.Visible = true;
            Button1.Visible = true;
            return;
        }
    }

    protected void fillSubject()
    {
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        int empid = Convert.ToInt32(Session["empid"]);
        Dt = Objdut.GetDataTable("select id,SubjectName from Subject_Master where id in(select subjectID from tblTeacherSubjectMapping where facultyid=" + empid + ")");
        if (Dt.Rows.Count > 0)
        {
            ddlsubject.DataSource = Dt;
            ddlsubject.DataValueField = "id";
            ddlsubject.DataTextField = "SubjectName";
            ddlsubject.DataBind();
            ddlsubject.Items.Insert(0, new ListItem("--Select Subject--", "0"));
        }
        else
        {
            ddlsubject.Items.Insert(0, new ListItem("--Select Subject--", "0"));
        }
    }

    protected void fillbatch()
    {
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        int empid = Convert.ToInt32(Session["empid"]);
        string query = "select BrName as BatchName,BrID as Batchid from Branch_master";
        Dt = Objdut.GetDataTable(query);
        if (Dt.Rows.Count > 0)
        {
            ddlbatch.DataSource = Dt;
            ddlbatch.DataValueField = "Batchid";
            ddlbatch.DataTextField = "BatchName";
            ddlbatch.DataBind();
            ddlbatch.Items.Insert(0, new ListItem("--Select Branch--", "0"));
        }
        else
        {
            ddlbatch.Items.Insert(0, new ListItem("--Select Batch--", "0"));
        }
    }

    protected void lbtndownloaddocument_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkbtn = sender as LinkButton;
            GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
            Label lbl = (Label)GridView1.Rows[gvrow.RowIndex].FindControl("lblfilename");
            string filepath = lbl.Text;
            filepath = "~/BranchPanel/examresult/" + filepath;
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filepath));
            Response.WriteFile(filepath);
            Response.End();
        }
        catch (Exception Exp)
        {
        }
    }
    protected void ddlbatch_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Convert.ToInt32(ddlbatch.SelectedValue) > 0)
        {
            query = @"select StuRegNo,Roll_No,(FName+' '+ISNULL(MName,'')+' '+ISNULL(LName,'')) as StudentName 
                       from student_master where Isdeleted=0 and StuRegNo in 
                   (select stuRegNo from Student_BatchMaster where batchid=" + Convert.ToInt32(ddlbatch.SelectedValue) + " and status=1 and isDeleted=0)";
        }
        dt = objdut.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            grdForStudent.DataSource = dt;
            grdForStudent.DataBind();
            DivForStudent.Visible = true;
        }
        else
        {
            grdForStudent.DataSource = null;
            grdForStudent.EmptyDataText = "No Record Founds.";
            grdForStudent.DataBind();
        }
    }
}