using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default2 : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private Utility objut = new Utility();
    private SqlParameter[] param = new SqlParameter[7];
    private DataUtility objdut = new DataUtility();
    private int id;
    private CommonClass CommonClass = new CommonClass();

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["User"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        txtAddClass.Focus();
        if (!IsPostBack)
        {
           
            btnUpdate.Visible = false;
           
            formtop.Visible = false;
            grdBranch.Visible = true;
            addoptional.Visible = false;
            fillfyear();
            GridBind();
            bindddl();
        }
    }

    public void fillfyear()
    {
        
        DataTable Dt = new DataTable();
        Dt=CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        ViewState["Fyid"] = CommonClass.GetActiveAcedmicYear();
        //int ViewState["Fyid"] = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ViewState["Fyid"]);

        ddlforfyear.DataSource = Dt;
        ddlforfyear.DataValueField = "fyid";
        ddlforfyear.DataTextField = "FYName";
        ddlforfyear.DataBind();
        ddlforfyear.SelectedValue = Convert.ToString(ViewState["Fyid"]);
        
        ddlfinancialyear.SelectedValue = Convert.ToString(ViewState["Fyid"]);
        ddlfinacialyearforsearching.DataSource = Dt;
        ddlfinacialyearforsearching.DataValueField = "fyid";
        ddlfinacialyearforsearching.DataTextField = "FYName";
        ddlfinacialyearforsearching.DataBind();
        ddlfinacialyearforsearching.SelectedValue = Convert.ToString(ViewState["Fyid"]);
    }

    protected void GridBind()
    {
        //int ViewState["Fyid"] = CommonClass.GetActiveAcedmicYear();
        ddlfinacialyearforsearching.SelectedValue = Convert.ToString(ViewState["Fyid"]);
        DataTable table = new DataTable();
        table = CommonClass.ABC("gridsubject", Convert.ToInt32(ViewState["Fyid"]));
        if (table.Rows.Count > 0)
        {
            grdBranch.DataSource = table;
            grdBranch.DataBind();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (ddlfinancialyear.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Session.");
            return;
        }
        if (txtAddClass.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please enter subject.");
            txtAddClass.Focus();
            return;
        }
        else
        {
            param[0] = new SqlParameter("@subjectname", txtAddClass.Text.Trim());
            param[1] = new SqlParameter("@subtype", "Compulsory");
            param[2] = new SqlParameter("@classid", Convert.ToInt32(0));
            param[3] = new SqlParameter("@fyid",ddlfinancialyear.SelectedValue);
            param[4] = new SqlParameter("@userid",Session["ADID"]);
            param[5] = new SqlParameter("@mode",1);
            param[6] = new SqlParameter("@intresult",SqlDbType.Int);
            param[6].Direction = ParameterDirection.Output;
            int result = objdut.ExecuteSqlSP(param, "Usp_Subject");
            if (result == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Subject Added Successfully.");
                txtAddClass.Text = "";
                GridBind();
                grdBranch.Visible = true;
                formtop.Visible = false;
                Button1.Visible = true;
                btnaddoptionalsubject.Visible = true;
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "This Subject is Already Exist in This Session");
            }
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (ddlfinancialyear.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Session.");
            return;
        }
        if (txtAddClass.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please enter subject.");
            txtAddClass.Focus();
            return;
        }
        grdBranch.Visible = true;
        formtop.Visible = false;
        Button1.Visible = true;
        btnSubmit.Visible = false;
        if (txtAddClass.Text != "")
        {
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@id", ViewState["id"]);
            param[1] = new SqlParameter("@subjectname", txtAddClass.Text);
            param[2] = new SqlParameter("@userid",Session["ADID"]);
            param[3] = new SqlParameter("@fyid",ddlfinancialyear.SelectedValue);
            param[4] = new SqlParameter("@mode",3);
            param[5] = new SqlParameter("@intresult",SqlDbType.Int);
            param[5].Direction = ParameterDirection.Output;
            int result1 = objdut.ExecuteSqlSP(param,"Usp_Subject");
                if (result1 == 1)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Subject updated successfully.");
                    txtAddClass.Text = "";
                    GridBind();
                    btnSubmit.Visible = true;
                    btnUpdate.Visible = false;
                    ddlfinacialyearforsearching.Visible = true;
                    btnaddoptionalsubject.Visible = true;
                }
                if (result1 == 2)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Subject Added Selected Session Successfully.");
                    txtAddClass.Text = "";
                    GridBind();
                    btnSubmit.Visible = true;
                    btnUpdate.Visible = false;
                    ddlfinacialyearforsearching.Visible = true;
                    btnaddoptionalsubject.Visible = true;
                }
                if (result1 == 3)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Subject Already Exist in This Session.");
                    btnSubmit.Visible = true;
                    btnUpdate.Visible = false;
                    ddlfinacialyearforsearching.Visible = true;
                    btnaddoptionalsubject.Visible = true;
                }
            //}
        }
    }

    protected void grdBranch_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        ddlfinacialyearforsearching.Visible = false;
        if (e.CommandName == "edit12")
        {
            lblmsg.Text = "";
            int id = Convert.ToInt32(e.CommandArgument);

            GridViewRow gvrow2 = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            Label lbClass = (Label)gvrow2.FindControl("lblsubtyp");
            if (lbClass.Text == "Optional")
            {
                formtop.Visible = false;
                addoptional.Visible = true;
                griddiv.Visible = false;
                btnoptional.Visible = false;
                btnaddoptionalsubject.Visible = true;
                Button1.Visible = false;
                btnaddoptionalsubject.Visible = false;
                btnop.Visible = true;
                ddlforfyear.Enabled = false;
                string query = "select * from subject_master where  id=" + id;
                DataTable table = objdut.GetDataTable(query);
                if (table.Rows.Count > 0)
                {
                    txtoptionalsub.Text = table.Rows[0]["subjectname"].ToString();
                    ddloptionalclass.SelectedValue = table.Rows[0]["classid"].ToString();
                    ddlforfyear.SelectedValue = table.Rows[0]["fyid"].ToString();
                    if (table.Rows[0]["status"].ToString() == "True")
                    {
                        //chkoptional.Checked = true;
                    }
                    else
                    {
                        //chkoptional.Checked = false;
                    }
                    
                    ViewState["id"] = table.Rows[0]["id"].ToString();
                }
            }
            else
            {
                string query = "select id,subjectname,fyid from subject_master where  id=" + id;
                DataTable table = objdut.GetDataTable(query);
                if (table.Rows.Count > 0)
                {
                    txtAddClass.Text = table.Rows[0]["subjectname"].ToString();
                    //if (table.Rows[0]["status"].ToString() == "True")
                    //{
                    //    chkAddClass.Checked = true;
                    //}
                    //else
                    //{
                    //    chkAddClass.Checked = false;
                    //}
                    ddlfinancialyear.SelectedValue = Convert.ToString(table.Rows[0]["fyid"]);
                    ViewState["id"] = table.Rows[0]["id"].ToString();
                }
                btnaddoptionalsubject.Visible = false;
                formtop.Visible = true;
                grdBranch.Visible = false;
                Button1.Visible = false;
                btnUpdate.Visible = true;
                btnSubmit.Visible = false;
                ddlfinancialyear.Enabled = false;
            }
        }
        //GridBind();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        txtAddClass.Text = "";
        formtop.Visible = true;
        grdBranch.Visible = false;
        addoptional.Visible = false;
        Button1.Visible = false;
        btnSubmit.Visible = true;
        btnaddoptionalsubject.Visible = false;
        ddlfinancialyear.SelectedValue = ViewState["Fyid"].ToString();
        ddlfinacialyearforsearching.Visible = false;
        ddlfinancialyear.Enabled = true;
    }

    public void bindddl()
    {
//        string str = @"select top 9 Classname+' ('+ isnull(stream_name,'No streams are mapped')+')' 'classname',Class_Master.id
// from Class_Master left outer join tbl_classstreammapping on classid=Class_Master.id  and status1=1 and Status=1  order by Class_Master.id desc ";
        
        DataTable dt=new DataTable();
        SqlParameter[] param=new SqlParameter[2];
        param[0] = new SqlParameter("@mode",5);
        param[1] = new SqlParameter("@fyid", ddlforfyear.SelectedValue);
        dt = objdut.GetDataTableSP(param,"Usp_Class");
        if (dt.Rows.Count > 0)
        {
            ddloptionalclass.DataSource = dt;
            ddloptionalclass.DataTextField = "classname";
            ddloptionalclass.DataValueField = "id";
            ddloptionalclass.DataBind();
            ddloptionalclass.Items.Insert(0, new ListItem("--Select Class--", "0"));
        }
    }

    protected void btnoptional_Click(object sender, EventArgs e)
    {
        if (ddlforfyear.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Session");
            return;
        }
        if (ddloptionalclass.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Class");
            return;
        }
        if (txtoptionalsub.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Subject Name");
            return;
        }     
        param[0] = new SqlParameter("@subjectname", txtoptionalsub.Text.Trim());
        param[1] = new SqlParameter("@subtype", "Optional");
        param[2] = new SqlParameter("@classid", ddloptionalclass.SelectedValue);
        param[3] = new SqlParameter("@fyid",ddlforfyear.SelectedValue);
        param[4] = new SqlParameter("@userid",Session["ADID"]);
        param[5] = new SqlParameter("@mode",1);
        param[6] = new SqlParameter("@intresult",SqlDbType.Int);
        param[6].Direction=ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, "Usp_Subject");
        if (result == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Optional subject Added successfully");
            Button1.Visible = true;
            btnaddoptionalsubject.Visible = true;
            addoptional.Visible = false;
            formtop.Visible = false;
            griddiv.Visible = true;
            GridBind();
            return;
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "This Optional Subject is Already Exist in This Session");
        }
    }

    protected void btnaddoptionalsubject_Click(object sender, EventArgs e)
    {
        addoptional.Visible = true;
        formtop.Visible = false;
        griddiv.Visible = false;
        btnop.Visible = false;
        Button1.Visible = false;
        btnaddoptionalsubject.Visible = false;
        btnback.Visible = true;
        ddlforfyear.SelectedValue = ViewState["Fyid"].ToString();
        ddlfinacialyearforsearching.Visible = false;
        ddlforfyear.Enabled = true;
        btnoptional.Visible = true;
    }

    protected void btnop_Click(object sender, EventArgs e)
    {
        if (txtoptionalsub.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Subject Name");
            return;
        }
        if (ddloptionalclass.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Class");
            return;
        }
        if (ddlforfyear.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Session");
            return;
        }
        SqlParameter[] param = new SqlParameter[7];
        param[0] = new SqlParameter("@id", ViewState["id"]);
        param[1] = new SqlParameter("@subjectname", txtoptionalsub.Text);
        param[2] = new SqlParameter("@userid", Session["ADID"]);
        param[3] = new SqlParameter("@fyid", ddlforfyear.SelectedValue);
        param[4] = new SqlParameter("@mode", 3);
        param[5] = new SqlParameter("@intresult", SqlDbType.Int);
        param[5].Direction = ParameterDirection.Output;
        param[6] = new SqlParameter("@classid",ddloptionalclass.SelectedValue);
        int result = objdut.ExecuteSqlSP(param, "Usp_Subject");
        if (result == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Optional subject Updated successfully");
            addoptional.Visible = false;
            formtop.Visible = false;
            griddiv.Visible = true;
            GridBind();
            Button1.Visible = true;
            ddlfinacialyearforsearching.Visible = true;
            btnaddoptionalsubject.Visible = true;
            return;
        }
        else if (result == 2)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Optional Subject Added Select Session Successfully ");
            addoptional.Visible = false;
            formtop.Visible = false;
            griddiv.Visible = true;
            GridBind();
            Button1.Visible = true;
            ddlfinacialyearforsearching.Visible = true;
            btnaddoptionalsubject.Visible = true;
        }
        else if (result == 3)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Optional Subject Already Exist in This Session");
            addoptional.Visible = false;
            formtop.Visible = false;
            griddiv.Visible = true;
            GridBind();
            Button1.Visible = true;
            ddlfinacialyearforsearching.Visible = true;
            btnaddoptionalsubject.Visible = true;
        }
    }
    protected void btnback_Click(object sender, EventArgs e)
    {
        btnUpdate.Visible = false;
        grdBranch.Visible = true;
        formtop.Visible = false;
        Button1.Visible = true;
        btnaddoptionalsubject.Visible = true;
        ddlfinacialyearforsearching.Visible = true;
    }
    protected void btnbackforoptional_Click(object sender, EventArgs e)
    {
        addoptional.Visible = false;
        Button1.Visible = true;
        btnaddoptionalsubject.Visible = true;
        griddiv.Visible = true;
        ddlfinacialyearforsearching.Visible = true;
    }
    protected void ddlfinacialyearforsearching_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable table = CommonClass.ABC("gridsubject", Convert.ToInt32(ddlfinacialyearforsearching.SelectedValue));
        if (table.Rows.Count > 0)
        {
            grdBranch.DataSource = table;
            grdBranch.DataBind();
        }
        else
        {
            grdBranch.EmptyDataText = "No Subject Added Till Now In The System";
            grdBranch.DataBind();
        }
    }
    protected void ddlforfyear_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindddl();
    }
}