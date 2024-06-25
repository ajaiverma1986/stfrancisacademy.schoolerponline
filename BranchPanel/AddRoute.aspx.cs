using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_AddRoute : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    private DataUtility objdut = new DataUtility();
    private Utility objut = new Utility();

    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
    private SqlCommand cmd = new SqlCommand();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fildll();
        }
    }

    protected void fildll()
    {
        ddl_Busroot.DataSource = CommonClass.Dll("zone");
        ddl_Busroot.DataTextField = "zonename";
        ddl_Busroot.DataValueField = "zoneid";
        ddl_Busroot.DataBind();

        ddl_Busroot.Items.Insert(0, new ListItem("--Select Zone--", "0"));
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        string n = txtstop.Text.ToString();
        string id = "ctl00$ContentPlaceHolder1$txtdynamic";

        for (int i = 1; i <= Convert.ToInt32(n); i++)
        {
            string s = Page.Request.Form[id + i.ToString()].ToString();
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
    }

    protected void txtstop_TextChanged(object sender, EventArgs e)
    {
        if (txtstop.Text == "")
        {
            return;
        }
        string a1 = txtstop.Text.ToString();
        for (int x = 1; x <= Convert.ToInt32(a1); x++)
        {
            Label title = new Label();
            TextBox dynamictextbox = new TextBox();
            //Font a1 = new Font(titl);

            // title.Style["left"] = "20px";
            title.Text = "Stop" + x.ToString();
            title.ID = "lblstops" + x.ToString();
            Area1.Controls.Add(new LiteralControl("<br>"));
            // dynamictextbox.Text = x.ToString();
            dynamictextbox.ID = "txtdynamic" + x.ToString();
            Area1.Controls.Add(new LiteralControl("<br>"));
            Area1.Controls.Add(title);

            Area1.Controls.Add(dynamictextbox);
        }
    }
}