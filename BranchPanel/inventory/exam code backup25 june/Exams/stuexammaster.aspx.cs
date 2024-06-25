using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_Exams_stuexammaster : System.Web.UI.Page
{
    private DataTable dtDDL, dt, dt1, dtSearchResult1, dtSearchResult;
    private SqlDataReader dr;
    private DataUtility objDUT = new DataUtility();
    private int res = 0, slmid = 0;
    private string url = "", query = "", query1 = "", query2 = "", queryUpdate = "", queryDDL = "", querySearch = "", querySearch1 = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (Session["tid"] != null)
        {
            if (!IsPostBack)
            {
                FillGrid1();
                FillGrid2();
                //FillDDl();
            }
        }
    }

    //protected void FillDDl()
    //{
    //   dtDDL=CommonClass.examMaster("batchbind",Convert.ToInt32(Session["tid"]),Convert.ToInt32(Session["BrBrid"]));
    //    if (dtDDL.Rows.Count > 0)
    //    {
    //        ddlselectbatch.DataSource = dtDDL;
    //        ddlselectbatch.DataTextField = "batchname";
    //        ddlselectbatch.DataValueField = "batchid";
    //        ddlselectbatch.DataBind();
    //        ddlselectbatch.Items.Insert(0, new ListItem("--Select Batch--", "0"));
    //    }
    //}

    protected void FillGrid1()
    {
        dt = CommonClass.examMaster("fillgrid", Convert.ToInt32(Session["tid"]), Convert.ToInt32(Session["BrBrid"]));
        if (dt.Rows.Count > 0)
        {
            GRDSTUDENT.DataSource = dt;
            GRDSTUDENT.DataBind();
        }
        else
        {
            GRDSTUDENT.DataSource = null;
            GRDSTUDENT.DataBind();
            return;
        }
    }

    protected void FillGrid2()
    {
        dt1 = CommonClass.examMaster("fillgrid1", Convert.ToInt32(Session["tid"]), Convert.ToInt32(Session["BrBrid"]));
        if (dt1.Rows.Count > 0)
        {
            grdLateStudents.DataSource = dt1;
            grdLateStudents.DataBind();
        }
        else
        {
            grdLateStudents.DataSource = null;
            grdLateStudents.DataBind();
            return;
        }
    }

    protected void GRDSTUDENT_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "removestufromlec")
        {
            slmid = Convert.ToInt32(e.CommandArgument);
            queryUpdate = "Update studentexam_master set status=0 where testid=" + Session["tid"] + " and semid=" + slmid + "";
            res = Convert.ToInt32(objDUT.ExecuteSql(queryUpdate));
            if (res == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Student removed successfully!");
                FillGrid1();
                FillGrid2();
                ddlselectbatch.SelectedValue = "0";
                return;
            }
        }
    }

    protected void grdLateStudents_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "addStudent")
        {
            slmid = Convert.ToInt32(e.CommandArgument);
            queryUpdate = "Update studentexam_master set status=1 where testid=" + Session["tid"] + " and semid=" + slmid + "";
            res = Convert.ToInt32(objDUT.ExecuteSql(queryUpdate));
            if (res == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Student added successfully!");
                FillGrid1();
                FillGrid2();
                ddlselectbatch.SelectedValue = "0";
                return;
            }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (ddlselectbatch.SelectedValue == "0")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please select a batch first.");
            FillGrid1();
            FillGrid2();
            return;
        }
        else
        {
            dtSearchResult = CommonClass.examMaster("add", Convert.ToInt32(Session["tid"]), Convert.ToInt32(ddlselectbatch.SelectedValue));
            if (dtSearchResult.Rows.Count > 0)
            {
                GRDSTUDENT.DataSource = dtSearchResult;
                GRDSTUDENT.DataBind();
            }
            else
            {
                GRDSTUDENT.EmptyDataText = "No result found with the selected criteria!! ";//Utility.ViewAlertMessage(this.Master.Page, "No result found with the selected criteria!!");
                GRDSTUDENT.DataSource = null;
                GRDSTUDENT.DataBind();
                return;
            }
            dtSearchResult1 = CommonClass.examMaster("remove", Convert.ToInt32(Session["tid"]), Convert.ToInt32(ddlselectbatch.SelectedValue));
            if (dtSearchResult1.Rows.Count > 0)
            {
                grdLateStudents.DataSource = dtSearchResult1;
                grdLateStudents.DataBind();
            }
            else
            {
                grdLateStudents.EmptyDataText = "No result found with the selected criteria!! ";
                grdLateStudents.DataSource = null;
                grdLateStudents.DataBind();
                return;
            }
        }
    }

    protected void ddlselectbatch_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
}