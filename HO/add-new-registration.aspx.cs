using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HO_add_new_registration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindSessionDDL();
    }
    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlregistrationsession.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlregistrationsession.DataValueField = "Fyid";
        ddlregistrationsession.DataTextField = "FYName";
        ddlregistrationsession.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlregistrationsession.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }


    [WebMethod]
    public static int AddOrRemovePermission(string value, string ColumnName)
    {
        DataUtility Objdut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[3];
        Param[0] = new SqlParameter("@value", value);
        Param[1] = new SqlParameter("@ColumnName", ColumnName);
        Param[2] = new SqlParameter("@intResult", SqlDbType.Int);
        Param[2].Direction = ParameterDirection.Output;
        int result = Objdut.ExecuteSqlSP(Param, "Usp_AddOrRemoveField");

        return result;
    }

    [WebMethod]
    public static List<GetPermittedCheckBoxForCheck> CheckCheckboxOnTheBehalfOfPermission()
    {
        DataTable Dt;
        DataUtility Objdut = new DataUtility();
        List<GetPermittedCheckBoxForCheck> Details = new List<GetPermittedCheckBoxForCheck>();
        using (Dt = Objdut.GetDataTable("Select Field_Id_Or_Name,(Case When Isactive=1 Then 'true' Else 'false' End)As Status from tbl_registrationsettings where Status=1"))
        {
            for (int i = 0; i < Dt.Rows.Count; i++)
            {
                GetPermittedCheckBoxForCheck obje = new GetPermittedCheckBoxForCheck();
                obje.ColumnName = Convert.ToString(Dt.Rows[i]["Field_Id_Or_Name"]);
                obje.CheckStatus = Convert.ToString(Dt.Rows[i]["Status"]);
                Details.Add(obje);
            }
        }
        return Details;
    }
    public class GetPermittedCheckBoxForCheck
    {
        public string ColumnName { get; set; }
        public string CheckStatus { get; set; }
    }
}