using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class classroom_mapping : System.Web.UI.Page
{
    private string url;
    private string PageName;
    private Utility objut = new Utility();
    private SqlParameter[] param = new SqlParameter[2];
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            binddl();
            bindroom();
            bindgrid();
            insertdiv.Visible = false;
            griddiv.Visible = true;
        }
    }

    public void binddl()
    {
        string srt = @"select Classname+' ('+ isnull(stream_name,'No streams are mapped')+')' 'classname',Class_Master.id from Class_Master left outer join tbl_classstreammapping on classid=Class_Master.id and brid=" + Session["BrBrid"] + " and status1=1 and Status=1";
        // string srt = "select classid,Classname from ClassBranch_master where BranchId=" + Session["BrBrid"] + "  and status=1 and classid not in(13,14)";
        DataTable dt;
        dt = objdut.GetDataTable(srt);

        if (dt.Rows.Count > 0)
        {
            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "ClassName";
            ddlClass.DataValueField = "id";
            ddlClass.DataBind();
            ddlClass.Items.Insert(0, new ListItem("--Select Class--", "0"));
        }
    }

    public void binddlforstream()
    {
        string srt = "select stream_name,classid from tbl_classstreammapping where brid=" + Session["BrBrid"] + " ";
        DataTable dt;
        dt = objdut.GetDataTable(srt);

        if (dt.Rows.Count > 0)
        {
            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "stream_name";
            ddlClass.DataValueField = "classid";
            ddlClass.DataBind();
            ddlClass.Items.Insert(0, new ListItem("--Select Stream--", "0"));
        }
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        ddlClass.Items.Clear();
        binddlforstream();
        insertdiv.Visible = true;
        griddiv.Visible = false;
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        ddlClass.Items.Clear();
        ddlsection.Items.Clear();
        ddlroom.Items.Clear();
        bindroom();
        txtcapacity.Text = "";
        binddl();
        insertdiv.Visible = true;
        griddiv.Visible = false;
    }

    public void bindroom()
    {
        string srt = "select room_id,room_name from  tbl_classroom where brid=" + Session["BrBrid"] + " and rtypename='class' and status1=1";
        DataTable dt;
        dt = objdut.GetDataTable(srt);

        if (dt.Rows.Count > 0)
        {
            ddlroom.DataSource = dt;
            ddlroom.DataTextField = "room_name";
            ddlroom.DataValueField = "room_id";
            ddlroom.DataBind();
            ddlroom.Items.Insert(0, new ListItem("--Select room--", "0"));
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (btnAdd.Text != "Update")
        {
            txtcapacity.Enabled = false;
            SqlParameter[] param = new SqlParameter[11];
            param[0] = new SqlParameter("@mode", "addroomtoclass");
            param[1] = new SqlParameter("@classname", ddlClass.SelectedItem.Text);
            param[9] = new SqlParameter("@section1", ddlsection.SelectedItem.Text);
            param[2] = new SqlParameter("@classid", ddlClass.SelectedValue);
            param[3] = new SqlParameter("@roomname", ddlroom.SelectedItem.Text);
            param[4] = new SqlParameter("@roomid", ddlroom.SelectedValue);
            param[10] = new SqlParameter("@capacity", txtcapacity.Text.Trim());
            param[5] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
            if (chkstatus.Checked == true)
            {
                param[6] = new SqlParameter("@status", 1);
            }
            else
            {
                param[6] = new SqlParameter("@status", 0);
            }
            param[7] = new SqlParameter("@intResult", Convert.ToInt32("0"));
            param[7].Direction = ParameterDirection.Output;
            param[8] = new SqlParameter("@id", Convert.ToInt32("0"));
            int ret = objdut.ExecuteSqlSP(param, "usp_class_room_mapping");
            if (ret > 0)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Room alloted to class Succesfully!");
                bindgrid();
                insertdiv.Visible = false;
                griddiv.Visible = true;

                return;
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "Error....");
                return;
            }
        }
        else if (btnAdd.Text == "Update")
        {
            txtcapacity.Enabled = false;
            SqlParameter[] param = new SqlParameter[11];
            param[0] = new SqlParameter("@mode", "updateroomtoclass");
            param[1] = new SqlParameter("@classname", ddlClass.SelectedItem.Text);
            param[2] = new SqlParameter("@classid", ddlClass.SelectedValue);
            param[9] = new SqlParameter("@section1", ddlsection.SelectedItem.Text);
            param[3] = new SqlParameter("@roomname", ddlroom.SelectedItem.Text);
            param[4] = new SqlParameter("@roomid", ddlroom.SelectedValue);
            param[10] = new SqlParameter("@capacity", txtcapacity.Text.Trim());
            param[5] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
            if (chkstatus.Checked == true)
            {
                param[6] = new SqlParameter("@status", 1);
            }
            else
            {
                param[6] = new SqlParameter("@status", 0);
            }
            param[7] = new SqlParameter("@intResult", Convert.ToInt32("0"));
            param[7].Direction = ParameterDirection.Output;
            param[8] = new SqlParameter("@id", ViewState["id"]);
            int ret = objdut.ExecuteSqlSP(param, "usp_class_room_mapping");
            if (ret > 0)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Room allotment updated to class Succesfully!");
                btnAdd.Text = "Submit";
                bindgrid();
                insertdiv.Visible = false;
                griddiv.Visible = true;
                return;
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "Error....");
                return;
            }
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Error");
        }
    }

    public void bindsection()
    {
        string srt = "select Sectionid,sectionname from classwithsection  where BranchId=" + Session["BrBrid"] + "  and status=1 and classid=" + ddlClass.SelectedValue + "";
        DataTable dt;
        dt = objdut.GetDataTable(srt);

        if (dt.Rows.Count > 0)
        {
            ddlsection.DataSource = dt;
            ddlsection.DataTextField = "sectionname";
            ddlsection.DataValueField = "Sectionid";
            ddlsection.DataBind();
            ddlsection.Items.Insert(0, new ListItem("--Select Class--", "0"));
        }
    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlClass.SelectedIndex > 0)
        {
            bindsection();
        }
    }

    protected void ddlroom_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlroom.SelectedIndex > 0)
        {
            string srt = "select capacity from tbl_classroom where room_id=" + ddlroom.SelectedValue;

            int i = Convert.ToInt32(objdut.GetScalar(srt));

            txtcapacity.Text = Convert.ToString(i);
        }
    }

    public void bindgrid()
    {
        string srt = "select * from tbl_classroommapping where status=1 and brid=" + Session["BrBrid"] + "";

        DataTable dt;
        dt = objdut.GetDataTable(srt);
        if (dt.Rows.Count > 0)
        {
            grid_classroom.DataSource = dt;
            grid_classroom.DataBind();
        }
        else
        {
            grid_classroom.EmptyDataText = "No Record Found";
            grid_classroom.DataSource = null;
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        bindgrid();
        insertdiv.Visible = false;
        griddiv.Visible = true;
        btnAdd.Text = "Submit";
    }

    protected void grid_classroom_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        insertdiv.Visible = true;
        griddiv.Visible = false;
        if (e.CommandName == "Edit1")
        {
            int id = Convert.ToInt32(e.CommandArgument);

            ViewState["id"] = id;

            btnAdd.Text = "Update";

            string set = "select * from tbl_classroommapping where roomid=" + id + " and brid=" + Session["BrBrid"] + "";

            DataTable dt;
            dt = objdut.GetDataTable(set);
            if (dt.Rows.Count > 0)
            {
                ddlClass.SelectedItem.Text = dt.Rows[0]["classname"].ToString();
                ddlroom.SelectedItem.Text = dt.Rows[0]["roomname"].ToString();
                int checkid = Convert.ToInt32(dt.Rows[0]["status"].ToString());

                if (checkid == 1)
                {
                    chkstatus.Checked = true;
                }
                else
                {
                    chkstatus.Checked = false;
                }

                ViewState["clsid"] = dt.Rows[0]["classid"].ToString();

                string srt = "select Sectionid,sectionname from classwithsection  where BranchId=" + Session["BrBrid"] + "  and status=1 and classid=" + ViewState["clsid"] + "";
                DataTable dt1;
                dt1 = objdut.GetDataTable(srt);

                if (dt.Rows.Count > 0)
                {
                    ddlsection.DataSource = dt1;
                    ddlsection.DataTextField = "sectionname";
                    ddlsection.DataValueField = "Sectionid";
                    ddlsection.DataBind();
                    ddlsection.Items.Insert(0, new ListItem("--Select Class--", "0"));
                }

                ddlsection.SelectedItem.Text = dt.Rows[0]["section"].ToString();
                txtcapacity.Text = dt.Rows[0]["capacity"].ToString();
                txtcapacity.Enabled = false;
            }
        }
    }
}