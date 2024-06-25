using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class branchpanel_employee_add_eidtleave : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString());
            fillleavetypes();
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["update"] = Session["update"];
    }

    protected void fillleavetypes()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@mode", 5);
        DataTable dt = objdut.GetDataTableSP(param, "usp_leavehistory");
        grdleavtype.DataSource = dt;
        grdleavtype.DataBind();

        ddlleavetype.DataSource = dt;
        ddlleavetype.DataTextField = "Leave_Type";
        ddlleavetype.DataValueField = "Ltid";
        ddlleavetype.DataBind();
        ddlleavetype.Items.Insert(0, new ListItem("--Select Leave Type--", "0"));
    }

    private void submitLeaveReq()
    {
        SqlParameter[] param = new SqlParameter[7];
        param[0] = new SqlParameter("@name", txtname.Text);
        param[1] = new SqlParameter("@code", txtleavecode.Text);
        param[2] = new SqlParameter("@limit", txtylimit.Text);
        param[3] = new SqlParameter("@cflimit", txtcflimit.Text);
        param[4] = new SqlParameter("@desc", txtdesc.Text);
        param[5] = new SqlParameter("@mode", 1);
        param[6] = new SqlParameter("@intResult", Convert.ToInt16(0));
        param[6].Direction = ParameterDirection.Output;
        int result = objdut.ExecuteSqlSP(param, "usp_addupdateleave");
        if (result > 0)
        {
            Response.Write("<script type='text/javascript'> alert('Leave Added.') </script>");
            fillleavetypes();
            txtdesc.Text = "";
            txtleavecode.Text = "";
            txtname.Text = "";
            txtylimit.Text = "";
            txtcflimit.Text = "";
        }
    }

    protected void btnadd_Click(object sender, EventArgs e)
    {
        if (Session["update"].ToString() == ViewState["update"].ToString())
        {
            if (txtname.Text != "" || txtleavecode.Text != "" || txtdesc.Text != "" || txtcflimit.Text != "" || txtylimit.Text != "")
            {
                submitLeaveReq();
            }
        }
    }

    protected void btnupdate_Click(object sender, EventArgs e)
    {
        if (Session["update"].ToString() == ViewState["update"].ToString())
        {
            submitLeaveReq();
            int leavestatus = 0;
            if (chkactdeact.Checked == true)
            {
                leavestatus = 1;
            }
            else if (chkactdeact.Checked == false)
            {
                leavestatus = 0;
            }
            SqlParameter[] param = new SqlParameter[9];
            param[0] = new SqlParameter("@name", txtname.Text);
            param[1] = new SqlParameter("@code", txtleavecode.Text);
            param[2] = new SqlParameter("@limit", txtylimit.Text);
            param[3] = new SqlParameter("@cflimit", txtcflimit.Text);
            param[4] = new SqlParameter("@desc", txtdesc.Text);
            param[5] = new SqlParameter("@mode", 2);
            param[6] = new SqlParameter("@status", Convert.ToInt32(leavestatus));
            param[7] = new SqlParameter("@leaveid", ddlleavetype.SelectedValue);
            param[8] = new SqlParameter("@intResult", Convert.ToInt16(0));
            param[8].Direction = ParameterDirection.Output;
            int result = objdut.ExecuteSqlSP(param, "usp_addupdateleave");
            if (result > 0)
            {
                Response.Write("<script type='text/javascript'> alert('Leave Updated.') </script>");
                txtdesc.Text = "";
                txtleavecode.Text = "";
                txtname.Text = "";
                txtylimit.Text = "";
                txtcflimit.Text = "";
            }
        }
    }

    protected void ddlleavetype_SelectedIndexChanged(object sender, EventArgs e)
    {
        int leavetype = Convert.ToInt32(ddlleavetype.SelectedValue);
        SqlDataReader dr = objdut.GetDataReader("select * from tbl_leavetype where Ltid=" + leavetype);
        if (dr.Read())
        {
            txtname.Text = dr["Leave_Type"].ToString();
            txtleavecode.Text = dr["leavecode"].ToString();
            txtylimit.Text = dr["limit"].ToString();
            txtcflimit.Text = dr["carryfwd"].ToString();
            txtdesc.Text = dr["description"].ToString();
        }
    }

    protected void lnkopn_Click(object sender, EventArgs e)
    {
        leavetypes.Style.Add("display", "block");
        btnupdate.Style.Add("display", "block");
        btnadd.Style.Add("display", "none");
        lnkopn.Style.Add("display", "none");
        chkactdeact.Style.Add("display", "block");
    }
}