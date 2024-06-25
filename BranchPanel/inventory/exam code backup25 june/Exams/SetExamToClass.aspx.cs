using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Exams_SetExamToClass : System.Web.UI.Page
{
    private DataTable dt;
    private string url;
    private string PageName, str;
    private string examname = string.Empty;
    private string examid = string.Empty;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private CommonClass clsobj = new CommonClass();

    private CommonClass CommonClass = new CommonClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["User"] == null)
        {
        }

        btnSubmit.Visible = false;
        if (!IsPostBack)
        {
            fillfyear();
            fillgrid();
        }
    }
    public void fillfyear()
    {
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }


    private void fillgrid()
    {
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 6);
        param[1] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
        param[2] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
        dt = objdut.GetDataTableSP(param, "Usp_Class");
        if (dt.Rows.Count > 0)
        {
            grdBranch.DataSource = dt;
            grdBranch.DataBind();
        }
    }

    protected void grdBranch_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        tr2.Visible = true;
        int classid = Convert.ToInt32(e.CommandArgument);
        ViewState["class"] = classid;

        foreach (GridViewRow grv in grdBranch.Rows)
        {
            LinkButton lbClass1 = (LinkButton)grv.FindControl("lblexam");
            LinkButton lbEdit1 = (LinkButton)grv.FindControl("lblexam22");
            lnk.Visible = true;
            lnk = lbEdit1;

            lbClass1.ForeColor = System.Drawing.Color.Blue;
            lnk.ForeColor = System.Drawing.Color.Blue;
        }
        if (e.CommandName == "c1")
        {
            GridViewRow gvrow2 = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            LinkButton lbClass = (LinkButton)gvrow2.FindControl("lblexam");
            LinkButton lbEdit = (LinkButton)gvrow2.FindControl("lblexam22");
            lbClass.ForeColor = System.Drawing.Color.Green;
            lbEdit.ForeColor = System.Drawing.Color.Green;
            lnk = lbEdit;
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@mode", 2);
            param[1] = new SqlParameter("@classid", ViewState["class"]);
            param[2] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
            ds = objdut.GetDataSetSP(param, "usp_examsettings");
            if (ds.Tables[0].Rows.Count > 0)
            {
                ds.Tables[0].Columns.Add("status", typeof(bool));
                if (ds.Tables[1].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[1].Rows)
                    {
                        int Status = 0;
                        int ExamID = 0;
                        Status = Convert.ToInt32(dr["status"]);
                        ExamID = Convert.ToInt32(dr["id"]);
                        foreach (DataRow dr1 in ds.Tables[0].Rows)
                        {
                            int Exam_ID = 0;
                            Exam_ID = Convert.ToInt32(dr1["id"]);
                            if (Exam_ID == ExamID)
                            {
                                dr1["status"] = Convert.ToBoolean(Status);
                            }
                        }
                    }
                }
                else
                {
                    foreach (DataRow dr1 in ds.Tables[0].Rows)
                    {
                        dr1["status"] = Convert.ToBoolean(0);                        
                    }
                }
                foreach (DataRow dr1 in ds.Tables[0].Rows)
                {
                    if (dr1["status"] == DBNull.Value)
                    {
                        dr1["status"] = Convert.ToBoolean(0);
                    }
                }
                lnk.Visible = true;
                grdexam.DataSource = ds.Tables[0];
                grdexam.DataBind();
                btnSubmit.Visible = false;
                foreach (GridViewRow gvrow in grdexam.Rows)
                {
                    CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
                    if (chkdelete.Checked)
                    {
                        chkdelete.Enabled = false;
                    }
                    else
                    {
                        chkdelete.Enabled = true;
                    }
                }
            }
            btnSubmit.Visible = true;
            //if (ds.Tables[1].Rows.Count > 0)
            //{
            //    gridoptionalexam.DataSource = ds.Tables[1];
            //    gridoptionalexam.DataBind();
            //    btnSubmit.Visible = false;
            //    foreach (GridViewRow gvrow in gridoptionalexam.Rows)
            //    {
            //        CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
            //        chkdelete.Enabled = false;
            //    }
            //}
            //else
            //{
            //    gridoptionalexam.DataSource = null;
            //    gridoptionalexam.DataBind();
            //    btnSubmit.Visible = true;
            //}
        }
        if (e.CommandName == "c2")
        {
        }
    }

    protected void lnk_Click(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@classid", ViewState["class"]);
        param[2] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
        ds = objdut.GetDataSetSP(param, "usp_examsettings");
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (ds.Tables[1].Rows.Count > 0)
            {
                ds.Tables[0].Columns.Add("status", typeof(bool));
                foreach (DataRow dr in ds.Tables[1].Rows)
                {
                    int Status = 0;
                    int ExamID = 0;
                    Status = Convert.ToInt32(dr["status"]);
                    ExamID = Convert.ToInt32(dr["id"]);
                    foreach (DataRow dr1 in ds.Tables[0].Rows)
                    {
                        int Exam_ID = 0;
                        Exam_ID = Convert.ToInt32(dr1["id"]);
                        if (Exam_ID == ExamID)
                        {
                            dr1["status"] = Convert.ToBoolean(Status);
                        }
                    }
                }
            }
            foreach (DataRow dr1 in ds.Tables[0].Rows)
            {
                if (dr1["status"] == DBNull.Value)
                {
                    dr1["status"] = Convert.ToBoolean(0);
                }
            }
            grdexam.DataSource = ds.Tables[0];
            grdexam.DataBind();
            btnSubmit.Visible = true;
        }
        else
        {
            grdexam.DataSource = null;
            grdexam.DataBind();
            btnSubmit.Visible = true;
        }
        //if (ds.Tables[1].Rows.Count > 0)
        //{
        //    gridoptionalexam.DataSource = ds.Tables[1];
        //    gridoptionalexam.DataBind();
        //    btnSubmit.Visible = true;
        //}
        //else
        //{
        //    gridoptionalexam.DataSource = null;
        //    gridoptionalexam.DataBind();
        //    btnSubmit.Visible = true;
        //}
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int count = 0;
        examname = "";
        examid = "";
        int k = objdut.ExecuteSql("delete from exam_class where brid=" + Convert.ToInt32(Session["BrBrid"]) + " and classid=" + Convert.ToInt32(ViewState["class"]) + "");

        SqlParameter[] param1 = new SqlParameter[6];
        foreach (GridViewRow gvrow in grdexam.Rows)
        {
            int status = 0;
            CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
            Label examname1 = (Label)gvrow.FindControl("lblexam123");
            HiddenField hd1 = (HiddenField)gvrow.FindControl("HD12");
            if (chkdelete.Checked)
            {
                status = 1;
            }
            count = count + 1;
            param1[0] = new System.Data.SqlClient.SqlParameter("@classid", Convert.ToInt32(ViewState["class"]));
            param1[1] = new System.Data.SqlClient.SqlParameter("@examid", hd1.Value);
            param1[2] = new SqlParameter("@intResult", Convert.ToInt32("0"));
            param1[2].Direction = ParameterDirection.Output;
            param1[3] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
            param1[4] = new SqlParameter("@Mode", Convert.ToInt32(1));
            param1[5] = new SqlParameter("@status", Convert.ToInt32(status));
            int intresult = objdut.ExecuteSqlSP(param1, "usp_examsettings");
        }
        if (count == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select atleast one exam.");

            btnSubmit.Visible = true;
            return;
        }
        Utility.ViewAlertMessage(this.Master.Page, "exam added successfully in the selected Class.");
        grdexam.DataSource = null;
        grdexam.DataBind();
        btnSubmit.Visible = false;
        tr2.Visible = false;        
    }
    protected void ddlfinancialyear_SelectedIndexChanged(object sender, EventArgs e)
    {
        grdexam.DataSource = null;
        grdexam.DataBind();
        btnSubmit.Visible = false;
        tr2.Visible = false;
        fillgrid();
    }
}