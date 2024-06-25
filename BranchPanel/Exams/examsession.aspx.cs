using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_Exams_examsession : System.Web.UI.Page
{
    private string query = "", query1 = "", classid = "";
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private SqlParameter[] param = new SqlParameter[9];
    private int c = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tblMain.Visible = false;

            filltime();
            filgrid();
            Button1.Visible = false;
            fillexam();
        }
    }

    private void filltime()
    {
        ddlftime.DataSource = GetTimeIntervals();
        ddlftime.DataBind();
        ddltotime.DataSource = GetTimeIntervals();
        ddltotime.DataBind();
    }

    public List<string> GetTimeIntervals()
    {
        List<string> timeIntervals = new List<string>();
        DateTime date = DateTime.MinValue.AddHours(6); // start at 6am
        DateTime endDate = DateTime.MinValue.AddDays(1).AddHours(6); // end at 5:45am (< 6am)

        while (date < endDate)
        {
            timeIntervals.Add(date.ToShortTimeString());
            date = date.AddMinutes(5);
        }
        return timeIntervals;
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

    private void filgrid()
    {
        query = "select classid,Classname,isnull(status,0) as status from ClassBranch_master where BranchId=" + Session["BrBrid"] + " and status=1";

        dt = objdut.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            grdclass.DataSource = dt;
            grdclass.DataBind();
        }
        else
        {
            grdclass.DataSource = null;
            grdclass.DataBind();
        }
        dt.Dispose();
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow gvrow in grdclass.Rows)
        {
            HiddenField h1 = (HiddenField)gvrow.FindControl("HD12");
            CheckBox chk1 = (CheckBox)gvrow.FindControl("chkclass1");
            if (chk1.Checked)
            {
                classid = classid + "," + h1.Value;
                c++;
            }
        }

        if (c == 0)
        {
            Utility.ViewAlertMessage(this.Master.Page, "please select at least one class.");
            return;
        }
        else
        {
            classid = classid.Remove(0, 1);
        }

        DataTable dt1 = objdut.GetDataTable("select Classname from Class_Master where id in(" + classid + ")");

        if (dt1.Rows.Count > 0)
        {
            string str = string.Empty;
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                str = str + dt1.Rows[i]["Classname"].ToString();
                str += (i < dt1.Rows.Count - 1) ? "," : string.Empty;
            }

            lblclss.Text = str;
        }

        fidetail();
        param[0] = new SqlParameter("@eid", ddlexamname.SelectedValue);
        param[1] = new SqlParameter("@startDate", txtDate.Text.Trim());
        param[2] = new SqlParameter("@enddate", txtToDate.Text.Trim());
        param[7] = new SqlParameter("@fromtime", ddlftime.SelectedItem.Text);
        param[8] = new SqlParameter("@totime", ddltotime.SelectedItem.Text);

        param[3] = new SqlParameter("@classid", classid);
        param[4] = new SqlParameter("@brid", Session["BrBrid"]);

        param[6] = new SqlParameter("@intresult", 0);
        param[6].Direction = ParameterDirection.Output;
        param[5] = new SqlParameter("@genrateColums", c);

        DataTable dt = objdut.GetDataTableSP(param, "usp_genrateSchem");
        int count = Convert.ToInt16(param[6].Value.ToString());

        if (count == 2)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Wrong Date Selection.No. of Subjects are greater than between date.. ");
            return;
        }
        if (count == 3)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Select Valid Time Period.!");
            return;
        }

        if (count == 1)
        {
            if (dt.Rows.Count > 0)
            {
                Button1.Visible = true;
                tblMain.Visible = true;
                abc.Visible = false;
                lblmsg.Visible = false;
                lblmsg.Text = "Annual Report";
                grd1.DataSource = dt;
                grd1.DataBind();
                Session["eid"] = ddlexamname.SelectedValue;
            }
        }
        else
        {
            lblmsg.Visible = true;
            lblmsg.Text = "Error..........";
        }
    }

    private void fidetail()
    {
        string str = Convert.ToString(objdut.GetScalar("select FYName from financial_Year where isActive=1"));

        lbftime.Text = ddlftime.SelectedItem.Text;
        lbtotme.Text = ddltotime.SelectedItem.Text;
        lbfdate.Text = txtDate.Text.Trim();
        lbtdate.Text = txtToDate.Text.Trim();
        lblexma.Text = ddlexamname.SelectedItem.Text;
        lblexma.Text = lblexma.Text + " " + "Schedule" + "" + " " + "(" + str + ")";
    }

    [WebMethod]
    public static string generateschem(string date, string C1, string C2, string C3, string C4, string C5, string C6, string C7, string C8, string C9, string C10, string C11, string C12, string C13, string C14, string C15)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("[usp_savescheme]", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@date1", date);

            cmd.Parameters.AddWithValue("@C1", C1);
            cmd.Parameters.AddWithValue("@C2", C2);
            cmd.Parameters.AddWithValue("@C3", C3);
            cmd.Parameters.AddWithValue("@C4", C4);
            cmd.Parameters.AddWithValue("@C5", C5);
            cmd.Parameters.AddWithValue("@C6", C6);
            cmd.Parameters.AddWithValue("@C7", C7);
            cmd.Parameters.AddWithValue("@C8", C8);
            cmd.Parameters.AddWithValue("@C9", C9);
            cmd.Parameters.AddWithValue("@C10", C10);
            cmd.Parameters.AddWithValue("@C11", C11);
            cmd.Parameters.AddWithValue("@C12", C12);
            cmd.Parameters.AddWithValue("@C13", C13);
            cmd.Parameters.AddWithValue("@C14", C14);
            cmd.Parameters.AddWithValue("@C15", C15);

            cmd.Parameters.AddWithValue("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));

            cmd.Parameters.AddWithValue("@eid", Convert.ToInt32(HttpContext.Current.Session["eid"]));

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            return "Submit";
        }
    }
}