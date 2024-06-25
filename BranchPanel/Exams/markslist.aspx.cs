using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI.WebControls;

public partial class BranchPanel_Exam_markslist : System.Web.UI.Page
{
    private DataTable dt, dt1, dt3;
    private SqlParameter[] param;
    private string batchid = "", regno = "", marks1 = "", maxmarks = "";
    private DataUtility objDut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["tid"] == null)
        {
            Response.Redirect("testlist.aspx");
        }
        if (!IsPostBack)
        {
            ViewState["maxmarks"] = string.Format("{0:0}", objDut.GetScalar("select totalmarks from exam_Master where Tid=" + Session["tid"]));
            fillinfo(ViewState["ba1"]);
        }
    }

    private void fillinfo(object p)
    {
        string q = @"select sm.admiid,sm.adno,(sm.firstname+''+sm.middlename+''+sm.lastname) as
                     name,isnull(ser.marks,0) as marks from tbl_admission sm
                     inner join  tbl_studentexamresult ser on ser.admiid=sm.admiid and
                     ser.testid=" + Convert.ToInt32(Session["tid"]) + "and ser.status!=0";
        dt1 = objDut.GetDataTable(q);
        if (dt1.Rows.Count > 0)
        {
            GrdAttendence.DataSource = dt1;
            GrdAttendence.DataBind();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow gvrow in GrdAttendence.Rows)
        {
            HiddenField hd2 = (HiddenField)gvrow.FindControl("HD2");
            TextBox txtmarks = (TextBox)gvrow.FindControl("txtmarks");

            string m1 = txtmarks.Text;
            if (Convert.ToDouble(ViewState["maxmarks"]) < Convert.ToDouble(m1))
            {
                Utility.ViewAlertMessage(this.Master.Page, "Minimum Mark is not greater than Maximum marks..!!");
                return;
            }
            regno = regno + "," + Convert.ToString(hd2.Value);
            marks1 = marks1 + "," + txtmarks.Text;
        }

        marks1 = marks1.Remove(0, 1);
        regno = regno.Remove(0, 1);
        if (checkvalidate())
        {
            param = new SqlParameter[4];

            param[0] = new SqlParameter("@sturegno", regno);
            param[1] = new SqlParameter("@marks", marks1);
            param[2] = new SqlParameter("@testid", Session["tid"]);
            param[3] = new SqlParameter("@intResult", Convert.ToInt32("0"));
            param[3].Direction = ParameterDirection.Output;

            int res = objDut.ExecuteSqlSP(param, "ups_exammaster");
            if (res == 1)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Student Marks Submit Succefully.");
                Response.Redirect("studentmarkreport.aspx");
                reset();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "Error....!");
                return;
            }
        }
    }

    private void reset()
    {
        foreach (GridViewRow gvrow in GrdAttendence.Rows)
        {
            TextBox txtmarks = (TextBox)gvrow.FindControl("txtmarks");
            txtmarks.Text = "";
        }
    }

    private bool checkvalidate()
    {
        foreach (GridViewRow gvrow in GrdAttendence.Rows)
        {
            TextBox txtmarks = (TextBox)gvrow.FindControl("txtmarks");
            if (txtmarks.Text == "")
            {
                Utility.ViewAlertMessage(this.Master.Page, "Please Enter Marks !");
                return false;
            }
            else
            {
                return true;
            }
        }
        return true;
    }

    protected void txtmarks_TextChanged(object sender, EventArgs e)
    {
        TextBox ddl = (TextBox)sender;
        GridViewRow row = (GridViewRow)ddl.NamingContainer;
        double d;
        if (!double.TryParse(ddl.Text, out d))
        {
            ddl.Text = "";
            ddl.BorderColor = Color.Red;
            ddl.Focus();
            return;
        }
        else
        {
            if (Convert.ToDouble(ViewState["maxmarks"]) < Convert.ToDouble(ddl.Text))
            {
                Utility.ViewAlertMessage(this.Master.Page, "Minimum Mark is not greater than Maximum marks..!!");
                ddl.Text = "";
                ddl.BorderColor = Color.Red;
                ddl.Focus();
                return;
            }
            ddl.BorderColor = Color.LightGray;
        }
    }
}