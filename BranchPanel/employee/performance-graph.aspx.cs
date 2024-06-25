using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

public partial class branchpanel_employee_performance_graph : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable dt;
    private CommonClass commonOBJ = new CommonClass();
    public static int fyid = 2, employeeid = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        fyid = CommonClass.Scaler("ActiveAcademicYear");
        if (!IsPostBack)
        {
            if (Request.QueryString.Count > 0)
            {
                employeeid = Convert.ToInt32(Request.QueryString["id"].ToString());
            }
            FillAllDDL();
        }
    }

    protected void FillAllDDL()
    {
        ddlfinancialyear.DataSource = CommonClass.ABC("DdlFinancialyear");
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataValueField = "FYID";
        ddlfinancialyear.DataBind();
        ddlfinancialyear.SelectedValue = fyid.ToString();

        string str = "select photo,jobTitle,mobile,department,(fname+' '+mName+' '+lname) as Name from tblEmp_Master where eid = " + employeeid;
        DataTable Dt = objdut.GetDataTable(str);
        if (Dt.Rows.Count > 0)
        {
            lblempname.Text = Dt.Rows[0]["Name"].ToString();
        }
    }

    [WebMethod]
    public static BindChart[] BindGraphByWebMethod(string financialyeraid)
    {
        DataTable Dt = new DataTable();
        List<BindChart> details = new List<BindChart>();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@fyid", Convert.ToInt32(financialyeraid));
        param[1] = new SqlParameter("@eid", employeeid);
        DataUtility ObjDUT = new DataUtility();
        Dt = ObjDUT.GetDataTableSP(param, "[usp_Bind_performancegraph]");
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            BindChart user = new BindChart();
            user.Jan = Dt.Rows[i]["Jan"].ToString();
            user.Feb = Dt.Rows[i]["Feb"].ToString();
            user.Mar = Dt.Rows[i]["Mar"].ToString();
            user.Apr = Dt.Rows[i]["Apr"].ToString();
            user.May = Dt.Rows[i]["May"].ToString();
            user.Jun = Dt.Rows[i]["Jun"].ToString();
            user.Jul = Dt.Rows[i]["Jul"].ToString();
            user.Aug = Dt.Rows[i]["Aug"].ToString();
            user.Sep = Dt.Rows[i]["Sep"].ToString();
            user.Oct = Dt.Rows[i]["Oct"].ToString();
            user.Nov = Dt.Rows[i]["Nov"].ToString();
            user.Dec = Dt.Rows[i]["Dec"].ToString();
            details.Add(user);
        }
        return details.ToArray();
    }

    public class BindChart
    {
        public string Jan { get; set; }

        public string Feb { get; set; }

        public string Mar { get; set; }

        public string Apr { get; set; }

        public string May { get; set; }

        public string Jun { get; set; }

        public string Jul { get; set; }

        public string Aug { get; set; }

        public string Sep { get; set; }

        public string Oct { get; set; }

        public string Nov { get; set; }

        public string Dec { get; set; }
    }
}