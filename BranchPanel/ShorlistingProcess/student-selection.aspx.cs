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

public partial class BranchPanel_Student_Registration_student_selection : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindSessionDDL();
            BindQualification();

        }       
    }
    [WebMethod]
    public static int sendFeeRemainder(string ASAID)
    {
        int result = 0;
        DataTable DtFeeRemind = new DataTable();
        CommonClass ObjClass = new CommonClass();
        if (ASAID != "")
        {
            string[] ID = ASAID.Split(',');
            if(ID.Length>0)
            {
                for (int i = 0; i < ID.Length; i++)
                {
                    DtFeeRemind = CommonClass.recentfee("Regis_Mobile", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]), Convert.ToInt32(ID[i]));
                    if (DtFeeRemind.Rows.Count > 0)
                    {
                        if (DtFeeRemind.Rows[0]["MobileNO"].ToString().Length > 9)
                        {
                            string msg1 = "", msg2 = "", msg3 = "";
                            msg1 = "Dear ";
                            msg2 = " , You have Shortlisted for admission. Your Registration No. " + DtFeeRemind.Rows[0]["Registration_No"].ToString() + ". Please Contact School to Complete admission procedure .Thanks.";
                            result = CommonClass.getStudentMobileNoForShorlist(DtFeeRemind.Rows[0]["MobileNO"].ToString(),Convert.ToInt32(ID[i]), msg1, msg2, msg3);
                        }
                        else
                        {
                            if (ID.Length == 1)
                            {
                                result = 2;
                            }
                            else
                            {
                                result = 3;
                            }
                        }
                    }
                }
            }
        }

        return result;
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
    [WebMethod]
    public static string BindGeneralDetails(int Fyid, int Classid, int IsShortListed, int IsRejected, int IsWaiting, string Fromdate, string Todate, string Registrationnumber, int Applyingforclass, string ParentMobileNo, int cast, string percentage, int PrimaryHighestQualification, int Secondaryparentqualification, int Primaryparentincome, int Secondaryparentincome, string maxincome, string minincome, string pagesize, string pageno, int IsAdmissionTaken)
   {
        DataSet Ds = new DataSet();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_SelectionProcess]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[22];
                param[0] = new SqlParameter("@Brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
                param[1] = new SqlParameter("@Fyid", Fyid);
                param[2] = new SqlParameter("@Classid", Classid);
                param[3] = new SqlParameter("@Mode", 1);
                param[4] = new SqlParameter("@FromDate", Fromdate);
                param[5] = new SqlParameter("@ToDate", Todate);
                param[6] = new SqlParameter("@registrationno", Registrationnumber);
                param[7] = new SqlParameter("@applyingforclass", Applyingforclass);
                param[8] = new SqlParameter("@ParentMobileNo", ParentMobileNo);
                param[9] = new SqlParameter("@category", cast);
                param[10] = new SqlParameter("@PercentageInPrevious", percentage);
                param[11] = new SqlParameter("@primaryparentqualification", PrimaryHighestQualification);
                param[12] = new SqlParameter("@Secondaryparentqualification", Secondaryparentqualification);
                param[13] = new SqlParameter("@Primaryparentincome", Primaryparentincome);
                param[14] = new SqlParameter("@Secondaryparentincome", Secondaryparentincome);
                param[15] = new SqlParameter("@maxincome", maxincome);
                param[16] = new SqlParameter("@minincome", minincome);
                param[17] = new SqlParameter("@IsShortListed", IsShortListed);
                param[18] = new SqlParameter("@IsRejected", IsRejected);
                param[19] = new SqlParameter("@IsWaiting", IsWaiting);
                param[20] = new SqlParameter("@pagesize", pagesize);
                param[21] = new SqlParameter("@pageno", pageno);
                param[21] = new SqlParameter("@IsAdmissionTaken", IsAdmissionTaken);
                 
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                cmd.Parameters.Add(param[5]);
                cmd.Parameters.Add(param[6]);
                cmd.Parameters.Add(param[7]);
                cmd.Parameters.Add(param[8]);
                cmd.Parameters.Add(param[9]);
                cmd.Parameters.Add(param[10]);
                cmd.Parameters.Add(param[11]);
                cmd.Parameters.Add(param[12]);
                cmd.Parameters.Add(param[13]);
                cmd.Parameters.Add(param[14]);
                cmd.Parameters.Add(param[15]);
                cmd.Parameters.Add(param[16]);
                cmd.Parameters.Add(param[17]);
                cmd.Parameters.Add(param[18]);
                cmd.Parameters.Add(param[19]);
                cmd.Parameters.Add(param[20]);
                cmd.Parameters.Add(param[21]);
                SqlDataAdapter Da = new SqlDataAdapter(cmd);
                Da.Fill(Ds); 
            }
        }
        return Ds.GetXml().ToString();
    }

    [WebMethod]
    public static string PeformActionOnCandidate(string AllRID, int IsUpdate)
    {
        DataTable Dt = new DataTable();
        DataUtility Objdut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[3];
        Param[0] = new SqlParameter("@AllcandiadteId", AllRID);
        Param[1] = new SqlParameter("@ActionId", IsUpdate);
        Param[2] = new SqlParameter("@intresult", 0);
        Param[2].Direction = ParameterDirection.Output;
        Dt = Objdut.GetDataTableSP(Param, "[Usp_PerformActionOnCandidate]");
        string result=Param[2].Value.ToString();
        if (result == "1")
        {
            if (Dt.Rows.Count > 0)
            {
                foreach (DataRow dtrow in Dt.Rows)
                {
                        try
                        {
                            System.Threading.Thread ThreadUpdateGrowthMocha = new System.Threading.Thread(delegate()
                            {

                                sendMessageToMobile.SMSsendForSend(Convert.ToString(Dt.Rows[0]["Mobile"]), Convert.ToString(Dt.Rows[0]["SmsContent"]), HttpContext.Current.Session["BrBrid"].ToString());
                               
                            });
                            ThreadUpdateGrowthMocha.Start();
                        }
                        catch
                        {
                           
                        }
                   
                }
            }
        }
        return result;
    }
}