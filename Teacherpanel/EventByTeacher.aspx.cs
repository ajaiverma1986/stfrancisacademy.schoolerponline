using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Teacherpanel_EventByTeacher : System.Web.UI.Page
{
    DataUtility objdut = new DataUtility();
    DataTable Dt = new DataTable();
    private static int eid = 0;
    int fyid = 0;
    protected void Page_Init(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
        Response.Cache.SetExpires(System.DateTime.UtcNow.AddSeconds(-1));
        Response.Cache.SetNoStore();
    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["update"] = Session["update"];
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["eid"] == null)
        {
            Response.Redirect("~/Teacher-login.aspx");
        }
        if (!IsPostBack)
        {
            Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString());
            eid = Convert.ToInt32(Session["eid"]);
            BindClass();
            // Section();
        }
    }
    public class BindSection
    {
        public string SECTIONID { get; set; }
        public string SECTIONNAME { get; set; }
    }
    [WebMethod]
    public static BindSection[] BindSectionDDL(string Classid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("sectiondll", Convert.ToInt32(Classid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        List<BindSection> BindObj = new List<BindSection>();
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            BindSection Obj = new BindSection();
            Obj.SECTIONID = Dt.Rows[i]["cwsid"].ToString();
            Obj.SECTIONNAME = Dt.Rows[i]["sectionname"].ToString();
            BindObj.Add(Obj);
        }
        return BindObj.ToArray();
    }

    public void BindClass()
    {
        DataTable dt = new DataTable();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 7);
        param[1] = new SqlParameter("@empid", eid);
        //  param[1] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
        dt = objdut.GetDataTableSP(param, "Usp_Class");
        if (dt.Rows.Count > 0)
        {
            ddlapplyingforclass.DataSource = dt;
            ddlapplyingforclass.DataTextField = "Classname";
            ddlapplyingforclass.DataValueField = "classid";
            ddlapplyingforclass.DataBind();
            ListItem li = new ListItem("--Select Class--", "0");
            ddlapplyingforclass.Items.Insert(0, li);

        }
    }




   
    public class BindAttendance
    {
        public string ROWNUMBER { get; set; }
        public string ADMISSIONNO { get; set; }
        public string STUREGNO { get; set; }
        public string NAME { get; set; }
        public string Review { get; set; }
        public string CHECKBOXSTATUS { get; set; }
    }

    
    public int SaveEvents(int id,int classid,int sectionid,string eventdate,string eventdetails,string calltype="save")
    {       
        DataUtility Objdut = new DataUtility();
        int intresult = 0;
        SqlParameter[] Param = new SqlParameter[9];
        Param[0] = new SqlParameter("@Id", id);
        Param[1] = new SqlParameter("@ClassId", classid);
        Param[2] = new SqlParameter("@SectionId", sectionid);

        Param[3] = new SqlParameter("@EventDate", DateTime.ParseExact(eventdate, "dd MMMM yyyy", null));
        Param[4] = new SqlParameter("@EventDetails", eventdetails);
        if (HttpContext.Current.Session["eid"] != null)
        {
            eid = Convert.ToInt32(HttpContext.Current.Session["eid"]);
        }
        //Param[5] = new SqlParameter("@userId", Convert.ToInt32(HttpContext.Current.Session["BrAdid"]));
        Param[5] = new SqlParameter("@userId", eid);
        Param[6] = new SqlParameter("@BrId", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        Param[7] = new SqlParameter("@callType", calltype);
        Param[8] = new SqlParameter("@intresult", SqlDbType.Int);
        Param[8].Direction = ParameterDirection.Output;
        intresult = Objdut.ExecuteSqlSP(Param, "[sp_Events]");

        //if (intresult == 1)
        //{

        //    string[] Attendance = AttendanceStatus.Split(',');
        //    string[] StudentID = SturegNo.Split(',');
        //    for (int i = 0; i < StudentID.Length; i++)
        //    {
        //        if (Convert.ToInt32(Attendance[i]) == 0)
        //        {
        //            string msg1 = "", msg2 = "", msg3 = "";
        //            msg1 = "'Dear Parent , Student ";
        //            msg2 = " is absent Today(" + DateTime.Today.ToString("dd/MM/yyyy") + ").";
        //            msg3 = " Please Contact School. ";
        //            int ied = CommonClass.getStudentMobileNo(Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), Convert.ToDecimal(StudentID[i]), Convert.ToInt32(CommonClass.Scaler("ActiveAcademicYear")), msg1, msg2, msg3);
        //        }
        //    }
        //}
        return intresult;
    }

    //'''''''''''''''''''''''''''''''''''''''''''''''''''' shivam
    protected void ddlapplyingforclass_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlapplyingforclass.SelectedValue == "0")
        {

            ddlsection.DataSource = null;
            ddlsection.DataBind();
        }
        else
        {
            DataTable Dt;
            Dt = CommonClass.ABC("sectiondll", Convert.ToInt32(ddlapplyingforclass.SelectedValue), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
            ddlsection.DataSource = Dt;
            ddlsection.DataTextField = "sectionname";
            ddlsection.DataValueField = "cwsid";
            ddlsection.DataBind();
            ddlsection.Items.Insert(0, new ListItem("Select", "0"));
        }
    }

    //protected void ddlsection_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (ddlsection.SelectedValue == "0")
    //    {
    //        DataTable dtStd = new DataTable();
    //        dtStd = null;

    //        ddlsection.DataSource = dtStd;
    //        ddlsection.DataBind();
    //    }
    //    else
    //    {

    //        Response.Write("no section");
    //    }
    //}
    protected void grdEvents_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdEvents.PageIndex = e.NewPageIndex;

            bindevent();
        }
        catch(Exception ex)
        {

        }
    }

    public void bindevent()
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[3];
        param[0] = new SqlParameter("@ClassId", Convert.ToInt32(ddlapplyingforclass.SelectedValue));
        param[1] = new SqlParameter("@SectionId", Convert.ToInt32(ddlsection.SelectedValue));
        param[2] = new SqlParameter("@callType", "select");
        DataTable dtrev = objdut.GetDataTableSP(param, "sp_Events");
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

    protected void grdEvents_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "upd")
            {
                GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
                int id = Convert.ToInt32(e.CommandArgument);
                TextBox txt = (TextBox)row.FindControl("txtgrdevent");
                Label txtdt = (Label)row.FindControl("lblgrdDate");
                int res = SaveEvents(id, Convert.ToInt32(ddlapplyingforclass.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue), txtdt.Text, txt.Text.Trim());
                bindevent();
            }
            if (e.CommandName == "del")
            {
                GridViewRow row = (GridViewRow)(((Control)e.CommandSource).NamingContainer);
                int id = Convert.ToInt32(e.CommandArgument);
                TextBox txt = (TextBox)row.FindControl("txtgrdevent");
                Label txtdt = (Label)row.FindControl("lblgrdDate");
                int res = SaveEvents(id, Convert.ToInt32(ddlapplyingforclass.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue), txtdt.Text, txt.Text.Trim(), "delete");
                bindevent();
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnforsubmit_Click(object sender, EventArgs e)
    {
        int result = SaveEvents(0, Convert.ToInt32(ddlapplyingforclass.SelectedValue), Convert.ToInt32(ddlsection.SelectedValue), txtdate.Text, txtEvent.Text.Trim());
        bindevent();
    }
    protected void ddlsection_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindevent();
    }
}