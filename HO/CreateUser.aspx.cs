using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class AdminPanel_CreateUser : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private Utility objuti = new Utility();
    private DataUtility objut = new DataUtility();
    private SqlDataReader sdr;
    private DataUtility obj = new DataUtility();
    private string Query;
    private int roleID;
    private string userid, pass;
    private SqlCommand cmd = new SqlCommand();
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["User"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        PageName = Utility.GetCurrentPagename();

        if (!objuti.isAccessible(((User)Session["User"]).UserID, PageName))
        {
            Response.Redirect("~/Login.aspx");
        }

        if (!IsPostBack)
        {
            fieldsetCreateUser.Visible = false;
            bindddl();
            bindGridRole();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        txtUsername.Enabled = true;
        btSave.Visible = true;
        fieldsetCreateUser.Visible = true;
        btUpdate.Visible = false;
        reset();
    }

    protected void bindddl()
    {
        string query = "select roleid,rolename from role where rActive=1 ";
        DataTable table = obj.GetDataTable(query);
        if (table.Rows.Count > 0)
        {
            dropRole.DataSource = table;
            dropRole.DataTextField = "rolename";
            dropRole.DataValueField = "roleid";

            dropRole.DataBind();
        }
        dropRole.Items.Insert(0, new ListItem("--Select Role--", "0"));
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        try
        {
            string query = "InsertUpdate_role";
            SqlParameter[] param = new SqlParameter[8];
            param[0] = new SqlParameter("@username", txtUsername.Text);
            param[1] = new SqlParameter("@pass", txtPass.Text);
            param[2] = new SqlParameter("@rlevel", Convert.ToInt32(dropRole.SelectedValue));
            param[3] = new SqlParameter("@Brid", 1);
            param[4] = new SqlParameter("@roleID", Convert.ToInt32(dropRole.SelectedValue));
            param[5] = new SqlParameter("@intresult", SqlDbType.Int);
            param[5].Direction = ParameterDirection.Output;
            param[6] = new SqlParameter("@type", SqlDbType.VarChar, 40);
            param[6].Value = "update";
            param[7] = new SqlParameter("@adid", SqlDbType.BigInt);
            param[7].Value = Convert.ToInt32(ViewState["adid"]);
            int intresult = obj.ExecuteSqlSP(param, query);
            if (intresult > 0)
            {
                bindGridRole();
                lblMsg.ForeColor = System.Drawing.Color.Blue;
                lblMsg.Text = "Record Updated Successfully";
            }
            else
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Error In Updating Record";
                bindGridRole();
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message;
        }
        finally
        {
        }
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        int username = Convert.ToInt32(obj.GetScalar("select count(*)from admin_login where username='" + txtUsername.Text + "'"));
        int username1 = Convert.ToInt32(obj.GetScalar("select count(*)from branch_login where username='" + txtUsername.Text + "'"));
        try
        {
            if (username == 0 && username1 == 0)
            {
                string query = "InsertUpdate_role";
                SqlParameter[] param = new SqlParameter[8];
                param[0] = new SqlParameter("@username", txtUsername.Text);
                param[1] = new SqlParameter("@pass", txtPass.Text);
                param[2] = new SqlParameter("@rlevel", Convert.ToInt32(dropRole.SelectedValue));
                param[3] = new SqlParameter("@Brid", 1);
                param[4] = new SqlParameter("@roleID", Convert.ToInt32(dropRole.SelectedValue));
                param[5] = new SqlParameter("@intresult", SqlDbType.Int);
                param[5].Direction = ParameterDirection.Output;
                param[6] = new SqlParameter("@type", SqlDbType.VarChar, 40);
                param[6].Value = "insert";
                param[7] = new SqlParameter("@adid", SqlDbType.BigInt);
                param[7].Value = 0;
                int intresult = obj.ExecuteSqlSP(param, query);
                if (intresult > 0)
                {
                    lblMsg.ForeColor = System.Drawing.Color.Blue;
                    lblMsg.Text = "Record Inserted Successfully";
                }
                else
                {
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    lblMsg.Text = "Error In Inserting Record";
                }
            }
            else
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "UserName Not Available,Try Other One";
                return;
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message;
        }
        finally
        {
            bindGridRole();
        }
    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        reset();
        fieldsetCreateUser.Visible = false;
        btCreate.Enabled = true;
    }

    protected void bindGridRole()
    {
        //        string query = @"select b.Brname,  a.* ,r.rolename,b.brcode,b.brname from admin_login a   left  outer join userroles u on a.adid=u.adid left outer join [role] r
        //                         on u.roleid=r.roleid left outer join branch_master b on b.brid=a.brid where a.aactive=1 and A.rlevel>1 and  b.bractive=1
        //                         order by a.adid desc";

        string query = @" SELECT a.*,m.brname,m.brcode,m.bractive,r.rolename FROM admin_login a LEFT OUTER JOIN BRANCH_master M
       ON a.brid=m.brid LEFT OUTER JOIN role r ON a.rlevel=r.roleid WHERE  a.AaCTIVE=1 and M.bractive=1 ORDER BY a.adid desc";

        DataTable table = obj.GetDataTable(query);
        if (table.Rows.Count > 0)
        {
            GridView1.DataSource = table;
            GridView1.DataBind();
        }
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.ToLower() == "edit")
        {
            lblMsg.Text = "";
            btCreate.Enabled = false;
            btSave.Visible = false;
            btUpdate.Visible = true;
            fieldsetCreateUser.Visible = true;
            txtUsername.Enabled = false;
            int adid = Convert.ToInt32(e.CommandArgument);
            ViewState["adid"] = Convert.ToString(adid);
            //            string query = @"select b.Brname,  a.* ,r.rolename,b.brcode,b.brname from admin_login a   left  outer join userroles u on a.adid=u.adid left outer join [role] r
            //                         on u.roleid=r.roleid left outer join branch_master b on b.brid=a.brid where a.aactive=1 and A.rlevel>1 and  b.bractive=1 and a.adid="+adid+
            //                         "order by a.adid desc";

            string query = @"SELECT a.*,m.brname,m.brcode,m.bractive,r.rolename FROM admin_login a LEFT OUTER JOIN BRANCH_master M
       ON a.brid=m.brid LEFT OUTER JOIN role r ON a.rlevel=r.roleid WHERE  a.AaCTIVE=1 and a.adid=" + adid + " ORDER BY a.adid desc";

            DataTable table = obj.GetDataTable(query);
            if (table.Rows.Count > 0)
            {
                txtUsername.Text = table.Rows[0]["username", DataRowVersion.Original].ToString();
                txtPass.Text = table.Rows[0]["pass", DataRowVersion.Original].ToString();
                //dropBranch.SelectedValue = table.Rows[0]["brid", DataRowVersion.Original].ToString();
                dropRole.SelectedValue = table.Rows[0]["rlevel", DataRowVersion.Original].ToString();
            }
        }
        if (e.CommandName.ToLower() == "delete")
        {
            int adid = Convert.ToInt32(e.CommandArgument);
            string query = "update admin_login set aactive=0 where adid=" + adid;
            int intresult = obj.ExecuteSql(query);
            if (intresult > 0)
            {
                bindGridRole();
                lblMsg.ForeColor = System.Drawing.Color.Blue;
                lblMsg.Text = "Record Deleted Successfully";
            }
            else
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Error In Deleting Record";
                bindGridRole();
            }
        }
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
    }

    protected void reset()
    {
        lblMsg.Text = "";
        txtUsername.Text = "";
        txtPass.Text = "";
        //dropBranch.SelectedIndex = 0;
        dropRole.SelectedIndex = 0;
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        bindGridRole();
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowState == DataControlRowState.Normal)
        {
            e.Row.Attributes.Add("onmouseover", "this.className='IfOnmouseOver'");
            e.Row.Attributes.Add("onmouseout", "this.className='Ifonmouseout'");
        }
        else if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowState == DataControlRowState.Alternate)
        {
            e.Row.Attributes.Add("onmouseover", "this.className='elseIfOnMouseOver'");
            e.Row.Attributes.Add("onmouseout", "this.className='elseIfOnMouseOut'");
        }
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        Response.Redirect("~/Common/default.aspx");
    }
}