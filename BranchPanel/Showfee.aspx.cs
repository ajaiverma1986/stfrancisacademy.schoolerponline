using System;
using System.Data;
using System.IO;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class BranchPanel_Showfee : System.Web.UI.Page
{
    private string url;
    private double feetotal = 0;
    private double feetotal1 = 0;
    private string PageName;
    private DataUtility OBJDut = new DataUtility();
    private Utility objUT = new Utility();
    private string feeid = string.Empty;
    private string url1 = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        url1 = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url1);
        }
        if (Session["BrBrid"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url1);
        }
        if (!IsPostBack)
        {
            ll.Visible = false;
            //rizwan.Visible = false;
            tdButton.Visible = false;
            fillClass();
        }
    }

    public void fillClass()
    {
        int BranchID = Convert.ToInt16(Session["BrBrid"]);

        // ddlClass.DataSource = CommonClass.Dll("ClassInBranch", BranchID);
        ddlClass.DataSource = CommonClass.ABC1("ClassInBranch", BranchID);
        ddlClass.DataTextField = "Classname";
        ddlClass.DataValueField = "classid";
        ddlClass.DataBind();

        ListItem li = new ListItem("--Select Class--", "0");
        ddlClass.Items.Insert(0, li);
        ViewState["brid"] = BranchID;
    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        divid.Visible = false;

        if (ddlClass.SelectedValue != "0")
        {
            string str = @"select t1.feename,t1.fees,t3.Feename as feecategory,t3.id,case when t3.id=1 then fees*1 when t3.id=2 then fees*1 when t3.id=3 then fees*2 when t3.id=4 then fees*4 when t3.id=5 then fees*12 end as totalfee from classfee_master t1 left outer join
                          feestructure t2  on t2.id=t1.Feeid and t1.fyid=1 join  feestructure t3 on t2.Feesubtype=t3.id  where Brid=" + Convert.ToInt16(Session["BrBrid"]) + " and Classid=" + ddlClass.SelectedValue + " and t1.status=1 and Feeid  not in(select id from feestructure where Feesubtype=0)";

            DataTable dt = OBJDut.GetDataTable(str);
            if (dt.Rows.Count > 0)
            {
                grdDetails.DataSource = dt;
                grdDetails.DataBind();
                grdDetails1.DataSource = dt;
                grdDetails1.DataBind();
                divMain.Visible = true;
                tdButton.Visible = true;
                divButton.Visible = true;

                IBExcel.Visible = true;
            }
            else
            {
                tdButton.Visible = false; ;
                grdDetails.DataSource = null;
                grdDetails.DataBind();
                divMain.Visible = false;
                divButton.Visible = true;
                lblmsg.Text = "Please select fee type for selected class in feesetting menu in master settings";
                IBExcel.Visible = false;
                return;
            }
            //grdDetails.Visible = true;
        }
    }

    //protected void btnCancel_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("Default.aspx");
    //}
    protected void grdDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbCREdit = (Label)e.Row.FindControl("txtTotalfee");
            if (!string.IsNullOrEmpty(lbCREdit.Text))
            {
                feetotal += Convert.ToDouble(lbCREdit.Text);
            }
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblamount = (Label)e.Row.FindControl("lblTotalfee");
            lblamount.Text = feetotal.ToString();
        }
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        //  BindData("select distinct M.regno, M.Randomid, M.loginid,(M.fname+' '+isnull(M.lname,''))as name,M.regdate,M.mobile from member_master M where M.Introregno=" + Convert.ToInt64(Session["MaxReg"].ToString()) + " and M.Active<2 order by ", this.ViewState["order"].ToString());

        PrepareGridViewForExport(grdDetails1);
        ExportGridView();
    }

    private void PrepareGridViewForExport(Control gv)
    {
        Label lb = new Label();

        Literal l = new Literal();

        string name = String.Empty;

        for (int i = 0; i < gv.Controls.Count; i++)
        {
            if (gv.Controls[i].GetType() == typeof(Label))
            {
                l.Text = (gv.Controls[i] as Label).Text;

                gv.Controls.Remove(gv.Controls[i]);

                gv.Controls.AddAt(i, l);
            }

            if (gv.Controls[i].HasControls())
            {
                PrepareGridViewForExport(gv.Controls[i]);
            }
        }
    }

    private void ExportGridView()
    {
        string attachment = "attachment; filename=Member_List.xls";

        Response.ClearContent();

        Response.AddHeader("content-disposition", attachment);

        Response.ContentType = "application/ms-excel";

        StringWriter sw = new StringWriter();

        HtmlTextWriter htw = new HtmlTextWriter(sw);

        // Create a form to contain the grid

        HtmlForm frm = new HtmlForm();

        grdDetails1.Parent.Controls.Add(frm);

        frm.Attributes["runat"] = "server";

        frm.Controls.Add(grdDetails1);

        frm.RenderControl(htw);

        //GridView1.RenderControl(htw);

        Response.Write(sw.ToString());

        Response.End();
    }

    protected void grdDetails1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbCREdit1 = (Label)e.Row.FindControl("txtTotalfee1");
            if (!string.IsNullOrEmpty(lbCREdit1.Text))
            {
                feetotal1 += Convert.ToDouble(lbCREdit1.Text);
            }
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblamount1 = (Label)e.Row.FindControl("lblTotalfee1");
            lblamount1.Text = feetotal.ToString();
        }
    }
}