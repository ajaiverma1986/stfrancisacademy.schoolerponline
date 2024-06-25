using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Alumni : System.Web.UI.Page
{
    DataUtility du = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static int saveDetails()
    {
        var vv = HttpContext.Current.Request;
        int result = 0;
        return result;
    }
    public class Alumni
    {
        public string Name { get; set; }
        public string Details { get; set; }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (txtName.Text.Trim() == "")
        {
            err.InnerHtml = "<p style='color:red'> Enter Name</p>";
            return;
        }
        if (fileupload.HasFile)
        {
            bool exists = System.IO.Directory.Exists(Server.MapPath("~/Alumni"));

            if (!exists)
                System.IO.Directory.CreateDirectory(Server.MapPath("~/Alumni"));
            string path = Server.MapPath("~/Alumni") + "/" + txtName.Text + fileupload.FileName;
            fileupload.SaveAs(path);
            string query = "insert into tbl_Alumni(Name,PhotoPath,Details) values('" + txtName.Text + "','" + txtName.Text + fileupload.FileName + "','" + TextBox1.Text + "')";
            int result = du.ExecuteSql(query);
            if (result > 0)
            {
                Response.Redirect("~/branchpanel/alumni.aspx");
            }
            else
            {
                err.InnerHtml = "<p style='color:red'> Error</p>";
            }
        }
        else
        {
            err.InnerHtml = "<p style='color:red'> Select image</p>";
        }
    }
}