using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class BranchPanel_Exams_room_allotment : System.Web.UI.Page
{
    private string query1 = "", roomid = "";
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private SqlParameter[] param = new SqlParameter[4];

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillroom();
            fillexam();
        }
    }

    private void fillroom()
    {
        query1 = "select roomid,room,Stregth from Room_master where status=1 and brid=" + Session["BrBrid"];
        dt = objdut.GetDataTable(query1);

        if (dt.Rows.Count > 0)
        {
            grdclass.DataSource = dt;
            grdclass.DataBind();
        }
        dt.Dispose();
    }

    private void fillexam()
    {
        query1 = "select eid,examname from exam_name where status=1";
        dt = objdut.GetDataTable(query1);
        if (dt.Rows.Count > 0)
        {
            ddlexamname.DataTextField = "examname";
            ddlexamname.DataValueField = "eid";
            ddlexamname.DataSource = dt;
            ddlexamname.DataBind();
            ddlexamname.Items.Insert(0, new ListItem("Select Exam", "0"));
        }
        else
        {
            ddlexamname.Items.Insert(0, new ListItem("Select Exam", "0"));
        }
        dt.Dispose();
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        int c = 0;
        foreach (GridViewRow gvrow in grdclass.Rows)
        {
            HiddenField h1 = (HiddenField)gvrow.FindControl("HD12");
            CheckBox chk1 = (CheckBox)gvrow.FindControl("chkclass1");
            if (chk1.Checked)
            {
                roomid = roomid + "," + h1.Value;
                c++;
            }
        }

        if (c == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "please select at least one Room.");
            return;
        }
        else
        {
            roomid = roomid.Remove(0, 1);
        }

        DataTable dt1 = objdut.GetDataTable("select Classname from Class_Master where id in(" + roomid + ")");

        param[0] = new SqlParameter("@eid", ddlexamname.SelectedValue);
        param[1] = new SqlParameter("@roomselection", roomid);
        param[2] = new SqlParameter("@brid", Session["BrBrid"]);
        param[3] = new SqlParameter("@intresult", 0);
        param[3].Direction = ParameterDirection.Output;
        DataTable dt = objdut.GetDataTableSP(param, "usp_SeatAllotment");
        int count = Convert.ToInt16(param[3].Value.ToString());
        if (count == 1)
        {
            if (dt.Rows.Count > 0)
            {
                grd1.DataSource = dt;
                grd1.DataBind();

                foreach (DataControlField col in grd1.Columns)
                {
                    if (col.HeaderText == "roomid")
                    {
                        col.Visible = false;
                    }
                }
                Session["eid"] = ddlexamname.SelectedValue;
            }
        }

        if (count == 3)
        {
            Utility.ViewAlertMessage(this.Master.Page, "selected Room streght less than respective student streght . ");
            return;
        }
        else
        {
        }
    }

    protected void grd1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[2].Visible = false;
    }
    protected void ddlexamname_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}