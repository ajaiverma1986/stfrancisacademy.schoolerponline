using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class employeepanel_geneology : System.Web.UI.Page
{
    private string url = "";
    private DataUtility objdut = new DataUtility();
    private TreeNode root;

    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "Department Structure";
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        else
        {
            if (!IsPostBack)
            {
                bindTree();
            }
        }
    }

    protected void bindTree()
    {
        string query = @"select deptName,deptid from dept_master where status=1 order by deptid";
        DataTable dt = objdut.GetDataTable(query);
        BuildTree(dt, trgeneology.Nodes);
        trgeneology.CollapseAll();
    }

    public void BuildTree(DataTable dt, TreeNodeCollection nodes)
    {
        foreach (DataRow dr in dt.Rows)
        {
            root = new TreeNode();
            string s = @"<table class='t' style='width:100px'><tr><td>Department:" + dr["deptName"].ToString() + "<hr/></td></tr></table>";

            root.Text = s;
            root.Value = dr["deptid"].ToString();
            trgeneology.Nodes.Add(root);
            PopulateSubSubLevel(root.Value, root);
        }
    }

    private void PopulateSubSubLevel(string parentid, TreeNode parentnode)
    {
        SqlParameter[] arrParam = new SqlParameter[2];
        arrParam[0] = new SqlParameter("@whyCall", "designation");
        arrParam[1] = new SqlParameter("@deptid", Convert.ToInt32(parentid));
        DataTable dt = objdut.GetDataTableSP(arrParam, "MasterProc");
        parentnode.ChildNodes.Clear();
        foreach (DataRow dr in dt.Rows)
        {
            TreeNode tr = new TreeNode();

            string s = @"<table class='t' style='width:100px'><tr><td>Sub Department:" + dr["desigName"].ToString() + "<hr/></td></tr></table>";
            tr.Text = s;
            tr.Value = dr["desigID"].ToString();
            parentnode.ChildNodes.Add(tr);
            PopulateSubSubLevel2(tr.Value.ToString(), tr);
        }
    }

    private void PopulateSubSubLevel2(string parentid, TreeNode parentnode)
    {
        SqlParameter[] arrParam = new SqlParameter[2];
        arrParam[0] = new SqlParameter("@whyCall", "genelogy");
        arrParam[1] = new SqlParameter("@desigtype", Convert.ToInt32(parentid));
        DataTable dt = objdut.GetDataTableSP(arrParam, "MasterProc");
        parentnode.ChildNodes.Clear();
        foreach (DataRow dr in dt.Rows)
        {
            TreeNode tr = new TreeNode();

            string s = @"<table class='t' style='width:100px'><tr><td rowspan='7'><img src='" + dr["imagepath"].ToString() + "'  Height='80px' Width='80px'/></td></tr>"
                + "<tr><td><b style='font-size:12px;color:#980000'>" + dr["rowNumber"].ToString() + " - " + dr["refNo"].ToString() + "</b></td></tr> "
                + "<tr><td>Employee Name: " + dr["name"].ToString() + "</td></tr> "
                + "<tr><td>Mobile No.: " + dr["mobile"].ToString() + "</td></tr> "
                + "<tr><td>Email Id: " + dr["emailID"].ToString() + "</td></tr> "
                + "<tr><td>Status: " + dr["StatusName"].ToString() + "</td></tr> "
                + "<tr><td>Joining Date: " + Convert.ToDateTime(dr["date"]).ToString("dd-MM-yyyy") + "<hr/></td></tr></table>";

            tr.Text = s;
            tr.Value = dr["eid"].ToString();
            parentnode.ChildNodes.Add(tr);
        }
    }

    protected void trgeneology_TreeNodeCollapsed(object sender, TreeNodeEventArgs e)
    {
        string val = e.Node.Value;
    }

    protected void trgeneology_TreeNodePopulate(object sender, TreeNodeEventArgs e)
    {
        string val = e.Node.Value;
    }
}