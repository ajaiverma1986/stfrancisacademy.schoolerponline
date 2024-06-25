using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Transport_AddRoot : System.Web.UI.Page
{
    private SqlConnection con = new SqlConnection("Data Source=208.91.198.196;Initial Catalog=horizonmodel; uid=horizonmodel; pwd=user@123");

    protected void Page_Load(object sender, EventArgs e)
    {
        // tblheading.Text = "Add Root";
        if (!IsPostBack)
        {
            BindEmployeeDetails();
        }
    }

    protected void BindEmployeeDetails()
    {
        con.Open();
        SqlCommand cmd = new SqlCommand("select id,fees,Area,case when status=1 then 'Active' when status=0 then 'Deactive' end as status,status as status1 from conveyance", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        con.Close();
        if (ds.Tables[0].Rows.Count > 0)
        {
            gvDetails.DataSource = ds;
            gvDetails.DataBind();
        }
        else
        {
            ds.Tables[0].Rows.Add(ds.Tables[0].NewRow());
            gvDetails.DataSource = ds;
            gvDetails.DataBind();
            int columncount = gvDetails.Rows[0].Cells.Count;
            gvDetails.Rows[0].Cells.Clear();
            gvDetails.Rows[0].Cells.Add(new TableCell());
            gvDetails.Rows[0].Cells[0].ColumnSpan = columncount;
            gvDetails.Rows[0].Cells[0].Text = "No Records Found";
        }
    }

    protected void gvDetails_RowEditing(object sender, GridViewEditEventArgs e)
    {
        Label lblstatus = (Label)gvDetails.Rows[e.NewEditIndex].FindControl("lblstatus");

        string sta = lblstatus.Text;

        gvDetails.EditIndex = e.NewEditIndex;

        BindEmployeeDetails();
    }

    protected void gvDetails_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int status = 0;
        int id = Convert.ToInt32(gvDetails.DataKeys[e.RowIndex].Value.ToString());
        string Area = gvDetails.DataKeys[e.RowIndex].Values["Area"].ToString();
        TextBox txtcity = (TextBox)gvDetails.Rows[e.RowIndex].FindControl("txtcity");
        CheckBox txtstatus = (CheckBox)gvDetails.Rows[e.RowIndex].FindControl("chkstatus");
        TextBox txtcit = (TextBox)gvDetails.Rows[e.RowIndex].FindControl("txtcity1");
        if (txtstatus.Checked)
        {
            status = 1;
        }
        con.Open();
        SqlCommand cmd = new SqlCommand("update conveyance set fees='" + txtcity.Text + "',Area='" + txtcit.Text + "',status=" + status + " where Id=" + id, con);
        cmd.ExecuteNonQuery();
        con.Close();
        lblresult.ForeColor = Color.Green;
        lblresult.Text = Area + " Details Updated successfully";
        gvDetails.EditIndex = -1;
        BindEmployeeDetails();
    }

    protected void gvDetails_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvDetails.EditIndex = -1;
        BindEmployeeDetails();
    }

    protected void gvDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = Convert.ToInt32(gvDetails.DataKeys[e.RowIndex].Values["Id"].ToString());
        string Area = gvDetails.DataKeys[e.RowIndex].Values["Area"].ToString();
        con.Open();
        SqlCommand cmd = new SqlCommand("update conveyance set status=0 where id=" + id, con);
        int result = cmd.ExecuteNonQuery();
        con.Close();
        if (result == 1)
        {
            BindEmployeeDetails();
            lblresult.ForeColor = Color.Red;
            lblresult.Text = Area + " details deleted successfully";
        }
    }

    protected void gvDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //getting username from particular row
            string Area = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "Area"));
            //identifying the control in gridview
            ImageButton lnkbtnresult = (ImageButton)e.Row.FindControl("imgbtnDelete");
            //raising javascript confirmationbox whenver user clicks on link button
            if (lnkbtnresult != null)
            {
                lnkbtnresult.Attributes.Add("onclick", "javascript:return ConfirmationBox('" + Area + "')");
            }
        }
    }

    protected void gvDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.Equals("AddNew"))
        {
            TextBox txtUsrname = (TextBox)gvDetails.FooterRow.FindControl("txtftrusrname");
            TextBox txtCity = (TextBox)gvDetails.FooterRow.FindControl("txtftrcity");
            // TextBox txtDesgnation = (TextBox) gvDetails.FooterRow.FindControl("txtftrDesignation");
            con.Open();
            SqlCommand cmd = new SqlCommand("insert into conveyance(Area,fees) values('" + txtUsrname.Text + "','" + txtCity.Text + "')", con);
            int result = cmd.ExecuteNonQuery();
            con.Close();
            if (result == 1)
            {
                BindEmployeeDetails();
                lblresult.ForeColor = Color.Green;
                lblresult.Text = txtUsrname.Text + " Details inserted successfully";
            }
            else
            {
                lblresult.ForeColor = Color.Red;
                lblresult.Text = txtUsrname.Text + " Details not inserted";
            }
        }
    }
}