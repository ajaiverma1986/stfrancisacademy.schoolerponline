using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class BranchPanel_ShorlistingProcess_waiting_candidate_list : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindSessionDDL();
            BindQualification();
        }  
    }
    public void BindQualification()
    {
        CommonClass CommonClass = new CommonClass();
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetQualificationDDL");
        if (Dt.Rows.Count > 0)
        {
            ddlparentqualification.DataSource = Dt;
            ddlparentqualification.DataTextField = "Name";
            ddlparentqualification.DataValueField = "Qid";
            ddlparentqualification.DataBind();
            ListItem Pli = new ListItem("Primary Parent Qualification", "0");
            ddlparentqualification.Items.Insert(0, Pli);
            ddlsecondaryparenthighestqualification.DataSource = Dt;
            ddlsecondaryparenthighestqualification.DataTextField = "Name";
            ddlsecondaryparenthighestqualification.DataValueField = "Qid";
            ddlsecondaryparenthighestqualification.DataBind();
            ListItem Sli = new ListItem("Secondary Parent Qualification", "0");
            ddlsecondaryparenthighestqualification.Items.Insert(0, Sli);
            Dt.Dispose();
        }
    }
    public void BindSessionDDL()
    {
        CommonClass CommonClass = new CommonClass();
        ddlfyear.DataSource = CommonClass.Dll("GetAcademicYearDDL");
        ddlfyear.DataValueField = "Fyid";
        ddlfyear.DataTextField = "FYName";
        ddlfyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }
    [WebMethod]
    public static BIndClass[] BindClassDDL(string Fyid)
    {
        DataTable Dt;
        Dt = CommonClass.ABC("GetClassDDL", Convert.ToInt32(Fyid), Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        List<BIndClass> BindObj = new List<BIndClass>();
        for (int i = 0; i < Dt.Rows.Count; i++)
        {
            BIndClass Obj = new BIndClass();
            Obj.ID = Dt.Rows[i]["classid"].ToString();
            Obj.ClassName = Dt.Rows[i]["Classname"].ToString();
            BindObj.Add(Obj);
        }
        return BindObj.ToArray();
    }
    public class BIndClass
    {
        public string ID { get; set; }
        public string ClassName { get; set; }
    }
}