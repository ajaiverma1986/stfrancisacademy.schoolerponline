using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_addstream : System.Web.UI.Page
{
    private Utility objut = new Utility();
    private DataUtility objDUT = new DataUtility();
    private CommonClass CommonClass = new CommonClass();
    private SqlParameter[] param = new SqlParameter[5];

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillClass();
            bindgrid();
            idrepeater.Visible = false;
            griddiv.Visible = true;
            Button2.Visible = true;
        }
    }

    public void bindgrid()
    {
        string srt = "select * from tbl_classstreammapping where brid=" + Session["Brbrid"] + "";
        DataTable dt = new DataTable();
        dt = objDUT.GetDataTable(srt);
        if (dt.Rows.Count > 0)
        {
            gridview_mapstream.DataSource = dt;
            gridview_mapstream.DataBind();
        }
        else
        {
            gridview_mapstream.EmptyDataText = "No Record Found .!";
            gridview_mapstream.DataSource = null;
        }
    }

    private void fillrepetor()
    {
        table1.Visible = true;
        rptfeesubtype.DataSource = objDUT.GetDataTable("select * from class_stream");
        rptfeesubtype.DataBind();
    }

    protected void fillClass()
    {
        string query = "select classid,Classname from ClassBranch_master where BranchId=" + Session["BrBrid"] + " and Status=1 and classid in (select id from Class_Master where id in(13,14))";

        DataTable dt = objDUT.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "Classname";
            ddlClass.DataValueField = "classid";
            ddlClass.DataBind();

            ListItem li = new ListItem("--Select Class--", "0");
            ddlClass.Items.Insert(0, li);
        }
    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        idrepeater.Visible = true;
        griddiv.Visible = false;
        fillrepetor();
        Button1.Style.Add("display", "block");
        Button3.Style.Add("display", "block");
        Button2.Visible = false;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        int count = 0;
        string streamname = "";
        foreach (RepeaterItem ri in rptfeesubtype.Items)
        {
            if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
            {
                CheckBox chkmodule = (CheckBox)ri.FindControl("chkpage");
                if (chkmodule != null && chkmodule.Checked)
                {
                    count++;
                    break;
                }
            }
        }
        if (count <= 0)
        {
            Utility.ViewAlertMessage(Page, "Please select at least one stream.");
            return;
        }
        else
        {
            foreach (RepeaterItem ri in rptfeesubtype.Items)
            {
                if (ri.ItemType == ListItemType.Item || ri.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chkmodule = (CheckBox)ri.FindControl("chkpage");
                    Label lblmoduleid = (Label)ri.FindControl("lblForm");
                    if (chkmodule.Checked)
                    {
                        streamname = streamname + "," + lblmoduleid.Text;
                    }
                }
            }
            streamname = streamname.Remove(0, 1);
        }

        param[0] = new System.Data.SqlClient.SqlParameter("@classid", ddlClass.SelectedValue);
        param[4] = new System.Data.SqlClient.SqlParameter("@classname", ddlClass.SelectedItem.Text.Trim());
        param[1] = new System.Data.SqlClient.SqlParameter("@streamname", streamname);
        param[2] = new SqlParameter("@brid", Session["BrBrid"]);
        param[3] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[3].Direction = ParameterDirection.Output;

        int intresult = objDUT.ExecuteSqlSP(param, "usp_mapstream");

        if (intresult == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Stream Mapped Sucessfully");
            bindgrid();
            idrepeater.Visible = false;
            griddiv.Visible = true;
            Button2.Visible = true;
            return;
        }
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        idrepeater.Visible = true;
        griddiv.Visible = false;
        Button2.Visible = false;
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        griddiv.Visible = true;
        idrepeater.Visible = false;
        Button2.Visible = true;
    }
}