using System;
using System.Data;

public partial class BranchPanel_studentattendance : System.Web.UI.Page
{
    private string str, url;
    private DataTable dt;
    private DataUtility objdut = new DataUtility();

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["stue"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!IsPostBack)
        {
            int x = Convert.ToInt32(objdut.GetScalar("select FYID from financial_Year where isActive=1 and isClosed=0"));
            ViewState["fyid"] = x;

            int ab = Convert.ToInt32(objdut.GetScalar("select adid from tbl_Admission where sturegno=" + Session["stue"] + " and brid=" + Convert.ToInt32(Session["BrBrid"]) + " and fyid=" + Convert.ToInt32(ViewState["fyid"]) + " and status=1"));
            fillgrd(ab);
        }
    }

    private void fillgrd(int ab)
    {
        str = @"select ta.classid,section,ta.adid,COUNT(ta.date) as workingdays,SUM(case ta.attendance when 1 then 1 else 0 end) as PresentDays,(((SUM(case ta.attendance when 1 then 1 else 0 end))*100)/COUNT(ta.date)) as Percentage ,mn.MonthName,mn.MonthId from tbl_attendance ta
              right outer join Month_name mn on mn.MONTHID=ta.MonthId inner join tbl_Admission tam on tam.adid=ta.ADID  where ta.FYID=" + Convert.ToInt32(ViewState["fyid"]) + " and tam.adid=" + ab + " and tam.brid=" + Convert.ToInt32(Session["BrBrid"]) + "  group by mn.MonthName,mn.MonthId,ta.adid,ta.classid,section order by mn.monthid asc";

        dt = objdut.GetDataTable(str);
        if (dt.Rows.Count > 0)
        {
            GrdAttendence.DataSource = dt;
            GrdAttendence.DataBind();
        }
        else
        {
            GrdAttendence.DataSource = null;
            GrdAttendence.DataBind();
            GrdAttendence.EmptyDataText = "No Records.";
        }
    }
}