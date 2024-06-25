using System;
using System.Data;

public partial class ParentPanel_parentuser : System.Web.UI.UserControl
{
    private string url;
    private DataUtility objdut = new DataUtility();
    private DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["ADID4"] == null || Session["stregno"] == null)
        {
            Response.Redirect("~/LoginP.aspx");
        }
        if (!IsPostBack)
        {
            string id = Convert.ToString(Session["stregno"]);
            filstudetail(id);
        }
    }

    private void filstudetail(string id)
    {
        dt = CommonClass.parentpanel("parentusercontrol", id);

        if (dt.Rows.Count > 0)
        {
            lblmobile.Text = dt.Rows[0]["Section"].ToString();
            lblname.Text = dt.Rows[0]["name"].ToString();
            lblroll.Text = dt.Rows[0]["Applyclass"].ToString();

            if (string.IsNullOrEmpty(dt.Rows[0]["UploadChildPhoto"].ToString()))
            {
                imgstu.ImageUrl = "~/images/9update.png";
            }
            else
            {
                imgstu.ImageUrl = "~/StudentPhoto/" + dt.Rows[0]["UploadChildPhoto"].ToString();
            }
        }
    }
}