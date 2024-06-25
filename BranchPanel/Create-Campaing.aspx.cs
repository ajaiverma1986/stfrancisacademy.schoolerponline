using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;


public partial class BranchPanel_Create_Campaing : System.Web.UI.Page
{
    Utility objut = new Utility();
    DataUtility objdut = new DataUtility();
    string url = "", PageName = "";
    string query1;
    DataTable dt;
    private int campid = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        //PageName = Utility.GetCurrentPagename();
        //if (!objut.isAccessible(((User)Session["BrUser"]).UserID, PageName))
        //{
        //    Response.Redirect("~/Login.aspx");
        //}
        if (!IsPostBack)
        {
            if (!IsPostBack)
            {
                lblMsg.Text = "";
                fillgrid();
                divcamp.Style.Add("display", "block");
                divall.Style.Add("display", "none");
                Fillcampaing(5);
            }
        }
    }

  
         protected void fillgrid()
    {
        string q = "select campid,chead,case when isusedfor=0 then 'SMS' else 'Email' end as  isusedfor,ctext from tbl_campaing where status=1";
        DataTable grid = objdut.GetDataTable(q);
        if (grid.Rows.Count > 0)
        {
            grdcompaining.DataSource = grid;
            grdcompaining.DataBind();
        }
        else
        {
            grdcompaining.EmptyDataText = "No record found";
            grdcompaining.DataSource = null;
            grdcompaining.DataBind();
        }
    } 
    

    public void Fillcampaing(int cid)
    {
        string que = "select * from tbl_campaing where campid="+cid;

        SqlDataReader dr = objdut.GetDataReader(que);

        while (dr.Read())
        {
            if (dr.HasRows)
            {
                txtSubject.Text = dr[1].ToString();
                ftCreateMail.Text = dr[5].ToString();
            }
        }
    }


    protected void btnSendMail_Click(object sender, EventArgs e)
    {
        if (txtSubject.Text == "")
        {
            lblMsg.Text = "please enter heading......";
            txtSubject.Focus();
            return;
        }
        if (isusedfor.SelectedIndex == -1)
        {
            lblMsg.Text = "please select mobile or e-mail for which you create template....";
            isusedfor.Focus();
            return;
        }
        if (isusedfor.SelectedIndex == 0)
        {

            int len = ftCreateMail.HtmlStrippedText.Length;
            //lblMsg.Text = ftCreateMail.HtmlStrippedText;
            if (len > 160)
            {
                lblMsg.Text = "you can't enter more than 160 character for mobile template.... " + len;
                ftCreateMail.Focus();
                return;
            }
        }
        if (btnSendMail.Text == "Save")
        {
            SqlParameter[] param = new SqlParameter[6];
            param[0] = new SqlParameter("@heading", txtSubject.Text);
            param[1] = new SqlParameter("@maintext", ftCreateMail.HtmlStrippedText.Trim());
            param[2] = new SqlParameter("@isusedfor", isusedfor.SelectedIndex);
            param[3] = new SqlParameter("@ctextwithdesign", ftCreateMail.Text.Trim());
            param[4] = new SqlParameter("@mode", 6);
            param[5] = new SqlParameter("@intResult", Convert.ToInt16(0));
            param[5].Direction = ParameterDirection.Output;
            int ret = objdut.ExecuteSqlSP(param, "usp_dogenraltaskforenquiry");
           if(ret>0)
           {

                
                fillgrid();
                divall.Style.Add("display", "none");
                divcamp.Style.Add("display", "block");
                lblMsg.Text = "Campaign save successfully.........";
           }

        }
        else
        {
            SqlParameter[] param1 = new SqlParameter[7];
            param1[0] = new SqlParameter("@heading", txtSubject.Text);
            param1[1] = new SqlParameter("@maintext", ftCreateMail.HtmlStrippedText.Trim());
            param1[2] = new SqlParameter("@isusedfor", isusedfor.SelectedIndex);
            param1[3] = new SqlParameter("@ctextwithdesign", ftCreateMail.Text.Trim());
            param1[4] = new SqlParameter("@mode",7);
            param1[5] = new SqlParameter("@campid", Convert.ToInt32(ViewState["compid"]));
            param1[6] = new SqlParameter("@intResult", Convert.ToInt16(0));
            param1[6].Direction = ParameterDirection.Output;
            int ret = objdut.ExecuteSqlSP(param1,"usp_dogenraltaskforenquiry");
            if (ret > 0)
            {
                
                divcamp.Style.Add("display", "block");
                fillgrid();
               
                divcamp.Style.Add("display", "block");
                divall.Style.Add("display", "none");
                lblMsg.Text = "Campaing updated successfully.........";
            }
            
        }
    }
    protected void grdcompaining_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "edit0")
        {
           
            int countrytid = Convert.ToInt32(e.CommandArgument);
            divall.Visible = true;
            GridViewRow gvrow = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
            Label lb1 = (Label)gvrow.FindControl("lbldepartment");
            string query = "select campid,chead,ctext,isusedfor from tbl_campaing where campid=" + countrytid;
            DataTable table = objdut.GetDataTable(query);
            if (table.Rows.Count > 0)
            {
                ViewState["compid"] = table.Rows[0]["campid"].ToString();
                txtSubject.Text = table.Rows[0]["chead"].ToString();
                ftCreateMail.Text = table.Rows[0]["ctext"].ToString();
                if (table.Rows[0]["isusedfor"].ToString() == "1")
                {
                    isusedfor.SelectedValue = "2";
                }
                else
                {
                    isusedfor.SelectedValue = "1";
                }
               
                btnSendMail.Text = "Update";
            }
          
            
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        divcamp.Visible = false;
        divall.Visible = true;
        txtSubject.Text = "";
    }


    protected void grdcompaining_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lb1 = (Label)e.Row.FindControl("lbldepartment");
       
         
        string desc = lb1.Text;
        int len = desc.Length;
        if (len > 200)
        {
            lb1.ToolTip = desc;
            lb1.Text = lb1.Text.Substring(0, 20) + "  ...";
        }
       }

    }
}