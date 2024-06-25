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
       
        if (!IsPostBack)
        {
           
            BindGrid();
        }
    }

  

    protected void BindGrid()
    {
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        int brid = Convert.ToInt32(HttpContext.Current.Session["brbrid"]);
        int cllassid = Convert.ToInt32(HttpContext.Current.Session["Classid"]);
       
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@classid", cllassid);
        param[1] = new SqlParameter("@brid", brid);
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
            filepath = "../BranchPanel/Assignment/" + filepath;
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