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

public partial class HO_studentidcard_settings : System.Web.UI.Page
{
    private DataUtility Objdut = new DataUtility();
    private DataTable dt = new DataTable();
    private string url;
    private CommonClass CommonClass = new CommonClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindddl();
        }
    }

    protected void bindddl()
    {
        DataTable Dt = new DataTable();
        Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
        dt = Objdut.GetDataTable("select brid,brname from Branch_master where bractive=1 and isdeleted=0 and isactive=1");
        if (dt.Rows.Count > 0)
        {
            ddlbranch.DataSource = dt;
            ddlbranch.DataTextField = "brname";
            ddlbranch.DataValueField = "brid";
            ddlbranch.DataBind();
        }
        else
        {
            ddlbranch.Items.Insert(0, new ListItem("Select Branch", "0"));
        }
        dt.Dispose();
        
    }

    [WebMethod]
    public static int Addidcartsetting(string width, string height, string photoplace, string bgcolor, string logoplace, string view_type, string standard_type, string fontcolor,string fyid)
    {
        DataUtility objdut = new DataUtility();
                SqlParameter[] param = new SqlParameter[12];
                param[0] = new SqlParameter("@brid", 0);
                param[1] = new SqlParameter("@height", height);
                param[2] = new SqlParameter("@width", width);
                param[3] = new SqlParameter("@photo_place", photoplace);
                param[4] = new SqlParameter("@logo_place", logoplace);
                param[5] = new SqlParameter("@bgcolor", bgcolor);
                param[6] = new SqlParameter("@view_type", view_type);
                param[7] = new SqlParameter("@standard_type", standard_type);
                param[8] = new SqlParameter("@intresult", SqlDbType.Int);
                param[8].Direction = ParameterDirection.Output;
                param[9] = new SqlParameter("@fontcolor", fontcolor);
                param[10] = new SqlParameter("@Userid",HttpContext.Current.Session["ADID"]);
                param[11] = new SqlParameter("@Fyid", fyid);
                int result = objdut.ExecuteSqlSP(param, "usp_stuidcardsetting");
                return result;
    }

    [WebMethod]
    public static SettingList[] Fillsetting()
    {
        DataTable dt = new DataTable();
        List<SettingList> details = new List<SettingList>();
        string q = "";
        DataUtility ObjDUT = new DataUtility();
        string que1 = @"select width,height,photo_place,logo_place,bgcolor,view_type,standard_type,fontcolor from tbl_stuidcardsetting
                        where   status=1";
        dt = ObjDUT.GetDataTable(que1);

        foreach (DataRow dtrow in dt.Rows)
        {
            SettingList user = new SettingList();
            user.width = dtrow["width"].ToString();
            user.height = dtrow["height"].ToString();
            user.photo_place = dtrow["photo_place"].ToString();
            user.logo_place = dtrow["logo_place"].ToString();
            user.bgcolor = dtrow["bgcolor"].ToString();
            user.view_type = dtrow["view_type"].ToString();
            user.standard_type = dtrow["standard_type"].ToString();
            user.fontcolor = dtrow["fontcolor"].ToString();
            details.Add(user);
        }
        return details.ToArray();
    }

    public class SettingList
    {
        public string width { get; set; }

        public string height { get; set; }

        public string photo_place { get; set; }

        public string logo_place { get; set; }

        public string bgcolor { get; set; }

        public string view_type { get; set; }

        public string standard_type { get; set; }

        public string fontcolor { get; set; }
    }

    public class GetStatusDetails
    {

        public string Name { get; set; }

        public string AdmissionNo { get; set; }

        public string Registration_No { get; set; }

        public string Mobile { get; set; }

        public string StudentPhotograph { get; set; }

        public string Classname { get; set; }

        public string FYName { get; set; }

        public string BranchAdress { get; set; }

        public string BranchMobileNo { get; set; }

        public string EmailId { get; set; }

        public string StudentDob { get; set; }

        public string Logo { get; set; }

        public string pagecount { get; set; }

    }
    [WebMethod]
    public static GetStatusDetails[] BindGridByJs(string fyid,string Brid,string classid,string AdmissionNo,string Mobileno,string Name,string pagesize,string pageno)
    {
        DataSet Ds = new DataSet();
        List<GetStatusDetails> StatusDetails = new List<GetStatusDetails>();
        SqlParameter[] param = new SqlParameter[8];
        DataUtility Objdut = new DataUtility();
        param[0] = new SqlParameter("@Fyid", fyid);
        param[1] = new SqlParameter("@ClassID",classid);
        param[2] = new SqlParameter("@Brid", Brid);
        param[3] = new SqlParameter("@Pagesize",pagesize);
        param[4] = new SqlParameter("@Pageno", pageno);
        param[5] = new SqlParameter("@AdmissionNo", AdmissionNo);
        param[6] = new SqlParameter("@FatherMobileno",Mobileno);
        param[7] = new SqlParameter("@StudentName", Name);
        Ds = Objdut.GetDataSetSP(param, "[usp_fetchidCard]");
        if (Ds.Tables[0].Rows.Count > 0)
        {
            foreach (DataRow dtrow in Ds.Tables[0].Rows)
            {
                GetStatusDetails user = new GetStatusDetails();
                user.Name = dtrow["Name"].ToString();
                user.AdmissionNo = dtrow["AdmissionNo"].ToString();
                user.Registration_No = dtrow["Registration_No"].ToString();
                user.Mobile = dtrow["Mobile"].ToString();
                if (dtrow["studentPhotograph"].ToString() != "")
                {
                    user.StudentPhotograph = dtrow["StudentPhotograph"].ToString();
                }
                else
                {
                    user.StudentPhotograph = "9update.png";
                }
                user.Classname = dtrow["Classname"].ToString();
                user.FYName = dtrow["FYName"].ToString();
                user.BranchAdress = dtrow["BranchAdress"].ToString();
                user.BranchMobileNo = dtrow["BranchMobileNo"].ToString();
                user.EmailId = dtrow["EmailId"].ToString();
                user.StudentDob = dtrow["StudentDob"].ToString();
                user.Logo = dtrow["Logo"].ToString();
                user.pagecount = Ds.Tables[1].Rows[0]["pages"].ToString();
                StatusDetails.Add(user);
            }
        }
        return StatusDetails.ToArray();
    }

    

    [WebMethod]
    public static int Viewtype()
    {
        DataUtility ObjDUT = new DataUtility();
        int result1 = Convert.ToInt32(ObjDUT.GetScalar("select view_type from tbl_stuidcardsetting where status=1"));
        return result1;
    }

    [WebMethod]
    public static BindDDL_List[] BindAllDDL(int Brid)
    {
        DataTable dt = new DataTable();
        List<BindDDL_List> details = new List<BindDDL_List>();
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@Brid", Brid);
        dt = ObjDUT.GetDataTableSP(param, "Usp_Bind_AllClasses");
        foreach (DataRow dtrow in dt.Rows)
        {
            BindDDL_List user = new BindDDL_List();
            user.Classid = dtrow["classID"].ToString();
            user.Classname = dtrow["Classname"].ToString();
            details.Add(user);
        }
        dt.Dispose();
        string q = @"select ncm.CourseID,ncm.CourseName from new_course_master ncm inner join Coursebranch_master
          cbm on ncm.courseID=cbm.Courseid where ncm.Status=1 and cbm.branchid=" + Brid;
        dt = ObjDUT.GetDataTable(q);
        foreach (DataRow dtrow in dt.Rows)
        {
            BindDDL_List user = new BindDDL_List();
            user.Courseid = dtrow["CourseID"].ToString();
            user.Coursename = dtrow["CourseName"].ToString();
            details.Add(user);
        }
        dt.Dispose();
        dt = ObjDUT.GetDataTable("select Batchid,BatchName from Batch_Master where status=1 and brid=" + Brid);
        foreach (DataRow dtrow in dt.Rows)
        {
            BindDDL_List user = new BindDDL_List();
            user.Batchid = dtrow["Batchid"].ToString();
            user.Batchname = dtrow["BatchName"].ToString();
            details.Add(user);
        }
        return details.ToArray();
    }

    public class BindDDL_List
    {
        public string Classid { get; set; }
        public string Classname { get; set; }
        public string Courseid { get; set; }
        public string Coursename { get; set; }
        public string Batchid { get; set; }
        public string Batchname { get; set; }
    }
}