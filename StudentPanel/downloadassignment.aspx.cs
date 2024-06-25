using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;

public partial class StudentPanel_downloadassignment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
            if (Session["StuRegNo"] == null)
            {
                Response.Redirect("../user-login.aspx");
            }
      
        if (!IsPostBack)
        {
           
            BindGrid();
        }
    }

  

    protected void BindGrid()
    {
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        int id = Convert.ToInt32(HttpContext.Current.Session["StuRegNo"]);
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@sturegno", id);
        Dt = Objdut.GetDataTableSP(param, "Usp_AssinmentList");
        if (Dt.Rows.Count > 0)
        {
            gridforimagename.DataSource = Dt;
            gridforimagename.DataBind();
        }
        else
        {
            gridforimagename.EmptyDataText = "No Assignment Uploaded Till Now.";
            gridforimagename.DataBind();
        }
        forurl.Value = Convert.ToString(Objdut.GetScalar("Select Url From tbl_institutemaster"));
    }

    protected void lbtndownloaddocument_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkbtn = sender as LinkButton;
            GridViewRow gvrow = lnkbtn.NamingContainer as GridViewRow;
            Label lbl = (Label)gridforimagename.Rows[gvrow.RowIndex].FindControl("lblfilename");
            string filepath = lbl.Text;
            filepath = "~/StudentPhoto/" + filepath;
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(filepath));
            Response.WriteFile(filepath);
            Response.End();
        }
        catch (Exception ex)
        {
        }
    }
}