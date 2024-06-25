using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class EmployeePanel_ViewEvents : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private int eid = 0;
    private DataTable dt;
    private int idStudent = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["StuRegNo"] != null)
            {
                eid = Convert.ToInt32(Session["StuRegNo"]);
            }
            idStudent = Convert.ToInt16(Session["StuRegNo"]);
            bindevent();
           
        }
    }

    protected void grdEvents_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdEvents.PageIndex = e.NewPageIndex;

            bindevent();
        }
        catch (Exception ex)
        {

        }
    }

    public void bindevent()
    {
        if (Session["StuRegNo"] != null)
        {
            eid = Convert.ToInt32(Session["StuRegNo"]);
        }
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@SturegNo", eid);      
       
        DataTable dtrev = objdut.GetDataTableSP(param, "sp_getEvents");
        if (dtrev != null && dtrev.Rows.Count > 0)
        {
            grdEvents.DataSource = dtrev;
            grdEvents.DataBind();

        }
        else
        {
            grdEvents.DataSource = null;
            grdEvents.DataBind();
        }
    }
}