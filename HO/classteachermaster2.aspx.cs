using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Configuration;
using System.Text;
using System.Web;
using ClosedXML.Excel;
public partial class HO_classteachermaster2 : System.Web.UI.Page
{
    private DataTable dt;
    private string url;
    private string PageName, str;
    private string teaname = string.Empty;
    private string teaid = string.Empty;
    private string Empname = string.Empty;
    private string EmpID = string.Empty;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private CommonClass clsobj = new CommonClass();
    private CommonClass CommonClass = new CommonClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        // fillTeacher();
        // fillClass();
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
    //public void fillClass()
    //{
    //    SqlParameter[] param = new SqlParameter[1];
    //    param[0] = new SqlParameter("@mode", 10);
    //    //param[1] = new SqlParameter("@brid", Session["BrBrid"]);
    //    DataTable dt = objdut.GetDataTableSP(param, "Usp_Class");
    //    if (dt.Rows.Count > 0)
    //    {
    //        ddlclass.DataSource = dt;
    //        ddlclass.DataTextField = "Classname";
    //        ddlclass.DataValueField = "id";
    //        ddlclass.DataBind();
    //        ddlclass.Items.Insert(0, new ListItem("--Select Class--", "0"));
    //    }
    //    else
    //    {
    //        Console.WriteLine("no class name");
    //    }
    //}
    private void fillgrid()
    {
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 5);
        param[1] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
        param[2] = new SqlParameter("@brid", Convert.ToString(Session["BrBrid"]));
        dt = objdut.GetDataTableSP(param, "Usp_Class");
        if (dt.Rows.Count > 0)
        {
            grdBranch.DataSource = dt;
            grdBranch.DataBind();
        }
    }
    private void fillTeacher()
    {
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@Mode", Convert.ToInt32(1));
        // param[1] = new SqlParameter("@brid", Session["BrBrid"]);
        dt = objdut.GetDataTableSP(param, "usp_AddTeacherInclass");
        if (dt.Rows.Count > 0)
        {
            GrdTeacher.DataSource = dt;
            GrdTeacher.DataBind();
        }

        else
        {
            GrdTeacher.DataSource = null;
            GrdTeacher.DataBind();
        }
    }
    protected void grdBranch_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        tr2.Visible = true;
        int classid = Convert.ToInt32(e.CommandArgument);
        ViewState["class"] = classid;
        foreach (GridViewRow grv in grdBranch.Rows)
        {
            LinkButton lbClass1 = (LinkButton)grv.FindControl("lblsubject");
            LinkButton lbEdit1 = (LinkButton)grv.FindControl("lblsubject22");
            lnk.Visible = true;
            lnk = lbEdit1;
            lbClass1.ForeColor = System.Drawing.Color.Blue;
            lnk.ForeColor = System.Drawing.Color.Blue;
        }
        if (e.CommandName == "c1")
        {
            divTitle.InnerText = "Add Class to Teacher";
            GridViewRow gvrow2 = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            LinkButton lbClass = (LinkButton)gvrow2.FindControl("lblsubject");
            LinkButton lbEdit = (LinkButton)gvrow2.FindControl("lblsubject22");
            lbClass.ForeColor = System.Drawing.Color.Green;
            lbEdit.ForeColor = System.Drawing.Color.Green;
            lnk = lbEdit;
            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@mode", 2);
            param[1] = new SqlParameter("@classid", ViewState["class"]);
            param[2] = new SqlParameter("@brid", Convert.ToString(Session["BrBrid"]));
            ds = objdut.GetDataSetSP(param, "usp_AddTeacherInclass");
            if (ds.Tables[0].Rows.Count > 0)
            {
                lnk.Visible = true;
                GrdTeacher.DataSource = ds.Tables[0];
                GrdTeacher.DataBind();
                btnSubmit.Visible = true;
                foreach (GridViewRow gvrow in GrdTeacher.Rows)
                {
                    CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
                    //chkdelete.Enabled = false;
                }
            }
            else
            {
                GrdTeacher.DataSource = null;
                GrdTeacher.DataBind();
                btnSubmit.Visible = false;
            }
            //if (ds.Tables[1].Rows.Count > 0)
            //{
            //    gridoptionalsubject.DataSource = ds.Tables[1];
            //    gridoptionalsubject.DataBind();
            //    btnSubmit.Visible = false;
            //    foreach (GridViewRow gvrow in gridoptionalsubject.Rows)
            //    {
            //        CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkclass");
            //        chkdelete.Enabled = false;
            //    }
            //}
            //else
            //{
            //    gridoptionalsubject.DataSource = null;
            //    gridoptionalsubject.DataBind();
            //    btnSubmit.Visible = true;
            //}
        }
        if (e.CommandName == "s1")
        {
            divTitle.InnerText = "Add Section to Teacher";
            GridViewRow gvrow2 = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            LinkButton lbClass = (LinkButton)gvrow2.FindControl("lblsubject");
            LinkButton lblsection = (LinkButton)gvrow2.FindControl("lblsection");
            ViewState["section"] = lblsection.Text;


            DataSet ds = new DataSet();
            SqlParameter[] param = new SqlParameter[3];
            param[0] = new SqlParameter("@mode", 2);
            param[1] = new SqlParameter("@classid", ViewState["class"]);
            param[2] = new SqlParameter("@brid", Convert.ToString(Session["BrBrid"]));
            ds = objdut.GetDataSetSP(param, "usp_AddTeacherInclass");
            if (ds.Tables[0].Rows.Count > 0)
            {
                lnk.Visible = true;
                GrdTeacher.DataSource = ds.Tables[0];
                GrdTeacher.DataBind();
                btnSubmit.Visible = true;
                SqlParameter[] param1 = new SqlParameter[4];
                param1[0] = new SqlParameter("@CALLTYPE", "SELECT");
                param1[1] = new SqlParameter("@CLASSID", classid);
                param1[2] = new SqlParameter("@SECTION", lblsection.Text);
                param1[3] = new SqlParameter("@FYID", ddlfinancialyear.SelectedValue);
                DataSet ds1 = new DataSet();
                ds1 = objdut.GetDataSetSP(param1, "sp_TeacherWithSection");
                foreach (GridViewRow gvrow in GrdTeacher.Rows)
                {

                    CheckBox chkclass = (CheckBox)gvrow.FindControl("chkTeacher");

                    chkclass.Checked = false;
                }
                if (ds1.Tables[0].Rows.Count > 0)
                {

                    foreach (GridViewRow gvrow in GrdTeacher.Rows)
                    {
                        HiddenField HDTea = (HiddenField)gvrow.FindControl("HDTea");
                        CheckBox chkclass = (CheckBox)gvrow.FindControl("chkTeacher");
                        foreach (DataRow dr in ds1.Tables[0].Rows)
                        {
                            if (HDTea.Value == Convert.ToString(dr["EmpId"]))
                            {
                                chkclass.Checked = true;
                                break;
                            }

                        }
                        //chkdelete.Enabled = false;
                    }
                }

            }
            else
            {
                GrdTeacher.DataSource = null;
                GrdTeacher.DataBind();
                btnSubmit.Visible = false;
            }


        }
    }
    protected void lnk_Click(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 2);
        param[1] = new SqlParameter("@classid", ViewState["class"]);
        ds = objdut.GetDataSetSP(param, "usp_AddTeacherInclass");
        if (ds.Tables[0].Rows.Count > 0)
        {
            GrdTeacher.DataSource = ds.Tables[0];
            GrdTeacher.DataBind();
            btnSubmit.Visible = true;
        }
        else
        {
            GrdTeacher.DataSource = null;
            GrdTeacher.DataBind();
            btnSubmit.Visible = true;
        }

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int count = 0;
        Empname = "";
        EmpID = "";

        foreach (GridViewRow gvrow in GrdTeacher.Rows)
        {
            CheckBox chkTeacher = (CheckBox)gvrow.FindControl("chkTeacher");
            Label lblTachername = (Label)gvrow.FindControl("lblTachername");
            HiddenField HDTea = (HiddenField)gvrow.FindControl("HDTea");
            if (chkTeacher.Checked)
            {
                count = count + 1;
                Empname = Empname + "," + lblTachername.Text;
                EmpID = EmpID + "," + HDTea.Value;
            }
        }

        if (count == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select atleast one Teacher.");

            btnSubmit.Visible = true;
            return;
        }
        EmpID = EmpID.Remove(0, 1);

        if (divTitle.InnerText == "Add Class to Teacher")
        {
            SqlParameter[] param1 = new SqlParameter[5];
            param1[0] = new System.Data.SqlClient.SqlParameter("@classid", Convert.ToInt32(ViewState["class"]));
            param1[1] = new System.Data.SqlClient.SqlParameter("@teacherid", EmpID);

            param1[2] = new SqlParameter("@intResult", Convert.ToInt32("0"));
            param1[2].Direction = ParameterDirection.Output;
            param1[3] = new SqlParameter("@Userid", Session["ADID"]);
            param1[4] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
            //param1[5] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"].ToString());
            int intresult = objdut.ExecuteSqlSP(param1, "addteacherinclass");
            if (intresult > 0)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Teacher added successfully in the selected Class.");
                GrdTeacher.DataSource = null;
                refresh();
                GrdTeacher.DataBind();
                btnSubmit.Visible = false;
                tr2.Visible = false;
            }
        }
        else
        {
            SqlParameter[] param1 = new SqlParameter[7];
            param1[0] = new System.Data.SqlClient.SqlParameter("@EMPID", EmpID);
            param1[1] = new System.Data.SqlClient.SqlParameter("@CLASSID", Convert.ToInt32(ViewState["class"]));
            param1[2] = new System.Data.SqlClient.SqlParameter("@SECTION", Convert.ToString(ViewState["section"]));
            param1[3] = new System.Data.SqlClient.SqlParameter("@CALLTYPE", "SAVE");
            param1[4] = new SqlParameter("@FYID", ddlfinancialyear.SelectedValue);
            param1[5] = new SqlParameter("@USERID", Session["ADID"]);
            param1[6] = new SqlParameter("@intResult", 0);
            param1[6].Direction = ParameterDirection.Output;


            //param1[5] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"].ToString());
            int intresult = objdut.ExecuteSqlSP(param1, "sp_TeacherWithSection");
            if (intresult > 0)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Teacher added successfully in the selected Section.");
                GrdTeacher.DataSource = null;
                refresh();
                GrdTeacher.DataBind();
                btnSubmit.Visible = false;
                tr2.Visible = false;
            }
        }

    }
    protected void ddlfinancialyear_SelectedIndexChanged(object sender, EventArgs e)
    {
        GrdTeacher.DataSource = null;
        GrdTeacher.DataBind();
        btnSubmit.Visible = false;
        tr2.Visible = false;
        fillgrid();
    }
    public void refresh()
    {
        ddlfinancialyear.SelectedValue = null;
        GrdTeacher.DataSource = null;
        grdBranch.DataSource = null;
    }
}

