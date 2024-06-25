using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class AdminPanel_CreateState : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private Utility objut = new Utility();
    private DataUtility obj = new DataUtility();
    private static int i = 0;
    private DataTable state = new DataTable();
    private int roleID;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["User"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        PageName = Utility.GetCurrentPagename();

        if (!objut.isAccessible(((User)Session["User"]).UserID, PageName))
        {
            Response.Redirect("~/Login.aspx");
        }

        if (!IsPostBack)
        {
            FillGridStateDetail();
            bindddlstate();
            FIELDSET1.Visible = true;
            fieldsetTableNoDistrict.Visible = false;
            fieldsetTableEdit.Visible = false;
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        fieldsetTableNoDistrict.Visible = true;
        i = Convert.ToInt32(txtDistrictNo.Text);
        DataTable state = new DataTable();
        state.Columns.Add("State Name", typeof(string));
        //  GridView1.Visible = true;
        for (int y = 0; y <= i - 1; y++)
        {
            DataRow row = state.NewRow();
            row["state Name"] = "";
            state.Rows.Add(row);
        }
        Session["state"] = state;
        bindgrid();
        txtDistrictNo.Text = "";
    }

    protected void bindgrid()
    {
        GridView1.DataSource = (DataTable)Session["state"];
        GridView1.DataBind();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
    }

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        for (int y = 0; y < i; y++)
        {
            GridViewRow row = GridView1.Rows[y];
            TextBox box = (TextBox)row.FindControl("TextBox2");
            Image imgstatus = (Image)row.FindControl("imgstatus");
            if (box.Text.Trim() != null && box.Text.Trim() != "")
            {
                int a = Convert.ToInt32(obj.GetScalar("select count(*) from state where statename='" + box.Text + "'"));
                if (a > 0)
                {
                    //lbmsg1.ForeColor = System.Drawing.Color.Red;
                    //lbmsg1.Text = "District Already Exists.Enter Other One";
                    imgstatus.Visible = true;
                    imgstatus.ImageUrl = "~/images/Duplicate.gif";
                    imgstatus.ToolTip = "Already Exists";
                }
                else
                {
                    string insertrecord = "insert into state(cid,statename,sactive,sCode) values (@sid,@distname,@active,@sCode)";

                    SqlParameter[] district = new SqlParameter[5];
                    district[0] = new SqlParameter("@sid", SqlDbType.Int, 4);
                    district[0].Value = Convert.ToInt32(ddlState.SelectedValue);
                    district[1] = new SqlParameter("@distname", SqlDbType.VarChar, 200);
                    district[1].Value = box.Text;
                    district[2] = new SqlParameter("@active", SqlDbType.Int, 4);
                    district[2].Value = 1;
                    district[3] = new SqlParameter("@intresult", SqlDbType.Int);
                    district[3].Direction = ParameterDirection.Output;
                    district[4] = new SqlParameter("@sCode", SqlDbType.VarChar, 2);
                    district[4].Value = box.Text.Substring(0, 2);

                    int result = obj.ExecuteSql(district, insertrecord);
                    if (result > 0)
                    {
                        imgstatus.Visible = true;
                        imgstatus.ImageUrl = "~/images/ok.gif";
                        imgstatus.ToolTip = "Inserted Successfully";
                    }
                    else
                    {
                        imgstatus.Visible = true;
                        imgstatus.ImageUrl = "~/images/Duplicate.gif";
                        imgstatus.ToolTip = "Error in Inserting Record";
                    }
                }
            }
            else
            {
                lbmsg1.Text = "Please Enter State Name";
            }
        }

        FillGridStateDetail();
        // fieldsetTableNoDistrict.Visible = false;
    }

    protected void bindddlstate()
    {
        string query = "select cid,countryname from country where cactive=1";
        DataTable table = obj.GetDataTable(query);
        ddlState.DataSource = table;
        ddlState.DataTextField = "countryname";
        ddlState.DataValueField = "cid";
        ddlState.DataBind();
        ddlState.Items.Insert(0, new ListItem("--Select Country--", "0"));
    }

    protected void FillGridStateDetail()
    {
        string query = "select sid, c.cid,c.countryname,s.statename from country c left outer join state s on c.cid=s.cid where  c.cactive=1 and c.countryname<>'Others' and s.sactive=1 order by c.countryname asc";
        DataTable table = obj.GetDataTable(query);
        GridStateDetail.DataSource = table;
        GridStateDetail.DataBind();
    }

    protected void GridStateDetail_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "edit")
        {
            lbMsg.Text = "";
            FIELDSET1.Visible = false;
            fieldsetTableNoDistrict.Visible = false;
            fieldsetTableEdit.Visible = true;
            //tableupdate.Visible = true;
            int sid = Convert.ToInt32(e.CommandArgument);
            string query = "select sid, c.cid,c.countryname,s.statename from country c left outer join state s on c.cid=s.cid where  c.cactive=1 and s.sactive=1 and sid=" + sid;
            DataTable table = obj.GetDataTable(query);
            if (table.Rows.Count > 0)
            {
                txtState.Text = table.Rows[0]["countryname"].ToString();
                txtDistrict.Text = table.Rows[0]["statename"].ToString();
                ViewState["sid"] = table.Rows[0]["sid"].ToString();
            }
        }
        if (e.CommandName == "delete")
        {
            // tableupdate.Visible = true;
            int sid = Convert.ToInt32(e.CommandArgument);
            string query = "update state set sactive=0 where sid=" + sid;
            int result = obj.ExecuteSql(query);
            if (result > 0)
            {
                lbMsg.Text = "Deleted Successfully";
                lbMsg.ForeColor = System.Drawing.Color.Blue;
            }
            else
            {
                lbMsg.Text = "Error in Deleting Record";
                lbMsg.ForeColor = System.Drawing.Color.Red;
            }
            //fieldsetTableEdit.Visible = false;
            //FieldsetCreateDistrict.Visible = true;
            //fieldsetTableNoDistrict.Visible = false;
            FillGridStateDetail();
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        int i = Convert.ToInt32(obj.GetScalar("select count(*) from state where statename='" + txtDistrict.Text.Trim() + "'"));
        try
        {
            if (i == 0)
            {
                string query = "update state set statename=@distname where sid=" + Convert.ToInt32(ViewState["sid"].ToString());
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@distname", SqlDbType.VarChar, 50);
                param[0].Value = txtDistrict.Text;
                int result = obj.ExecuteSql(param, query);
                if (result > 0)
                {
                    lbMsg.Text = "Updated Successfully";
                    lbMsg.ForeColor = System.Drawing.Color.Blue;
                    FillGridStateDetail();
                }
                else
                {
                    lbMsg.Text = "Error in Updating Record";
                    lbMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lbMsg.Text = "State Already Exists";
                lbMsg.ForeColor = System.Drawing.Color.Red;
            }
        }
        catch (Exception ex)
        {
            lbMsg.Text = ex.Message;
        }
        finally
        {
            FillGridStateDetail();
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //tableupdate.Visible = false;
        FIELDSET1.Visible = true;
        fieldsetTableNoDistrict.Visible = false;
        fieldsetTableEdit.Visible = false;
        FillGridStateDetail();
    }

    protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
    }

    protected void GridStateDetail_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridStateDetail.PageIndex = e.NewPageIndex;
        FillGridStateDetail();
    }

    protected void GridStateDetail_RowEditing(object sender, GridViewEditEventArgs e)
    {
    }

    protected void GridStateDetail_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
    }

    protected void GridStateDetail_Sorting(object sender, GridViewSortEventArgs e)
    {
        // GridStateDetail.Sort = e.SortExpression;
        // FillGridStateDetail();
    }

    protected void GridStateDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowState == DataControlRowState.Normal)
        {
            //e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#E8D84A'");
            //e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#B6D5E8'");

            //e.Row.Attributes.Add("onmouseover", "this.className='IfOnmouseOver'");
            //e.Row.Attributes.Add("onmouseout", "this.className='Ifonmouseout'");
        }
        else if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowState == DataControlRowState.Alternate)
        {
            //e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#E8D84A'");
            //e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#CDEACD'");
            //e.Row.Attributes.Add("onmouseover", "this.className='elseIfOnMouseOver'");
            //e.Row.Attributes.Add("onmouseout", "this.className='elseIfOnMouseOut'");
        }
    }

    protected void Button1_Click1(object sender, EventArgs e)
    {
        FIELDSET1.Visible = true;
        fieldsetTableNoDistrict.Visible = false;
        fieldsetTableEdit.Visible = false;
    }

    protected void back_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Common/default.aspx");
    }
}