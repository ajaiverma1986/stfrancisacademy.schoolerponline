using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_SectionAdd : System.Web.UI.Page
{
    private string url;
    private int query;
    private Utility objut = new Utility();
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private SqlDataReader dr;
    CommonClass CommonClass = new CommonClass();
    protected void Page_Load(object sender, EventArgs e)
    {        
        if (!IsPostBack)
        {           
            divall.Visible = false;
            divgrid.Visible = true;
            fillfyear(); 
            fillclass();
            fillgrid();
            if (Request.QueryString.Count > 0)
            {
                string value = Request.QueryString["c1"];
            }
        }
    }
    public void fillfyear()
    {
        DataTable Dt = objdut.GetDataTable("Select * from financial_Year");
        if (Dt.Rows.Count > 0)
        {
            ddlFyid.DataSource = Dt;
            ddlFyid.DataValueField = "fyid";
            ddlFyid.DataTextField = "FYName";
            ddlFyid.DataBind();
            ddlFyid.Items.Insert(0, new ListItem("-Select Session-", "0"));
            int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
            ddlFyid.SelectedValue = Convert.ToString(ActiveFinancialyear);
        }
    }
    private void fillgrid()
    {
        string querynew = @"select cwsid,classid,(Cm.Classname)As classname,sectionname,Case when Cws.status=1 then 'Active' else 'Not Active' end as Status from
                   ClassWithSection Cws inner join Class_Master Cm ON Cws.Classid=Cm.Id  where branchid=" + Session["BrBrid"] + " and Cm.Fyid=" + ddlFyid.SelectedValue + " order by classid asc,cwsid asc";
        ViewState["vie"] = querynew;
        dt = objdut.GetDataTable(querynew);
        if (dt.Rows.Count > 0)
        {
            griview_section.DataSource = dt;
            griview_section.DataBind();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Please add classes in the branch.')", true);
            return;
        }
    }

    public void fillclass()
    {
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@brid", Session["BrBrid"]);
        param[2] = new SqlParameter("@Fyid", ddlFyid.SelectedValue);
        DataTable dt = objdut.GetDataTableSP(param, "Usp_Class");
        if (dt.Rows.Count > 0)
        {
            ddl_class.DataSource = dt;
            ddl_class.DataTextField = "Classname";
            ddl_class.DataValueField = "classid";
            ddl_class.DataBind();
            ddl_class.Items.Insert(0, new ListItem("--Select Class--", "0"));
        }
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        if (checkvalidation())
        {
            if (btnAdd.Text != "Update")
            {
                SqlParameter[] param = new SqlParameter[8];
                param[0] = new SqlParameter("@mode", "Addsec");
                param[1] = new SqlParameter("@classname", ddl_class.SelectedItem.Text);
                param[2] = new SqlParameter("@classid", ddl_class.SelectedValue);
                param[3] = new SqlParameter("@sectionname", txtsection.Text.ToUpper());
                param[4] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
                if (chkstatus.Checked == true)
                {
                    param[5] = new SqlParameter("@status", 1);
                }
                else
                {
                    param[5] = new SqlParameter("@status", 0);
                }
                param[6] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                param[6].Direction = ParameterDirection.Output;
                param[7] = new SqlParameter("@id", Convert.ToInt32("0"));
                int ret = objdut.ExecuteSqlSP(param, "usp_addsec");
                if (ret == 1)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Section Added Succesfully!");
                    divall.Visible = true;
                    divgrid.Visible = false;
                    Button2.Visible = true;
                    reset();
                    fillgrid();
                }
                else if (ret == 2)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Section Already Exist!");
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Error....");
                    return;
                }
            }
            else if (btnAdd.Text == "Update")
            {
                SqlParameter[] param = new SqlParameter[8];
                param[0] = new SqlParameter("@mode", "updatesct");
                param[1] = new SqlParameter("@classname", ddl_class.SelectedItem.Text);
                param[2] = new SqlParameter("@classid", ddl_class.SelectedValue);
                param[3] = new SqlParameter("@sectionname", txtsection.Text.ToUpper());
                param[4] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
                if (chkstatus.Checked == true)
                {
                    param[5] = new SqlParameter("@status", 1);
                }
                else
                {
                    param[5] = new SqlParameter("@status", 0);
                }
                param[6] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                param[6].Direction = ParameterDirection.Output;
                if (ViewState["sid"] == null)
                {
                    param[7] = new SqlParameter("@id", 0);
                }
                else
                {
                    param[7] = new SqlParameter("@id", Convert.ToInt32(ViewState["sid"]));
                }
                int ret = objdut.ExecuteSqlSP(param, "usp_addsec");
                if (ret == 1)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Section updated Succesfully!");
                    divgrid.Visible = true;
                    divall.Visible = false;
                    Button2.Visible = true;
                    reset();
                    fillgrid();
                }
                else if (ret == 2)
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Section Already Exist in This class!");
                }
                else if (ret == 3)
                {
                    Utility.ViewAlertMessage(this.Master.Page, " This Section Can Not Be Updated!");
                    divgrid.Visible = true;
                    divall.Visible = false;
                    Button2.Visible = true;
                    reset();
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Error.");
                    return;
                }
            }
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Error.");
        }
    }

    private bool checkvalidation()
    {
        if (ddl_class.SelectedIndex == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Plz Select Class.");
            return false;
        }
        else if (txtsection.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Plz Enter Section.");
            return false;
        }
        else
            return true;
    }

    private void reset()
    {
        ddl_class.SelectedIndex = 0;
        txtsection.Text = "";
        chkstatus.Checked = false;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        reset();
        divall.Visible = false;
        divgrid.Visible = true;
        Button2.Visible = true;
    }

    protected void griview_section_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        string query = (string)ViewState["vie"];
        griview_section.PageIndex = e.NewPageIndex;
        fillgrid();
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        ddl_class.Items.Clear();
        fillclass();
        divall.Visible = true;
        divgrid.Visible = false;
        Button2.Visible = false;
    }

    protected void griview_section_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int asd = Convert.ToInt32(e.CommandArgument);
        ViewState["sid"] = asd;
        if (e.CommandName == "Edit1")
        {
            GridViewRow clickedRow = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
            HiddenField hd1 = (HiddenField)clickedRow.Cells[2].FindControl("lblclassid");
            int ide;
            ide = Convert.ToInt32(hd1.Value);
            divgrid.Visible = false;
            divall.Visible = true;
            Button2.Visible = false;
            string str = "select classid,ClassName,sectionname,cws.status from classwithsection cws inner join Class_Master cm on cm.id=cws.classid  where cm.status=1 and branchid=" + Session["brBrid"] + "and cwsid=" + asd;
            DataTable dts = objdut.GetDataTable(str);
            if (dts.Rows.Count > 0)
            {
                ddl_class.SelectedValue = Convert.ToString(dts.Rows[0]["classid"]);

                txtsection.Text = dts.Rows[0]["sectionname"].ToString();
                if (dts.Rows[0]["status"].ToString() == "1")
                {
                    chkstatus.Checked = true;
                }
                else
                {
                    chkstatus.Checked = false;
                } 
                btnAdd.Text = "Update";
            }
        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        ddl_class.Items.Clear();
        binddtream();
        divall.Visible = true;
        divgrid.Visible = false;
    }

    public void binddtream()
    {
        string ser = "select classid,stream_name from tbl_classstreammapping where brid=" + Session["BrBrid"] + " and status1=1 ";
        DataTable dt;
        dt = objdut.GetDataTable(ser);
        ddl_class.DataSource = dt;
        ddl_class.DataTextField = "stream_name";
        ddl_class.DataValueField = "classid";
        ddl_class.DataBind();
        ddl_class.Items.Insert(0, new ListItem("--Select Stream--", "0"));
    }

    protected void griview_section_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
        }
    }
    protected void ddlFyid_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlFyid.SelectedValue != "0")
        {
            fillgrid();
        }
    }
}