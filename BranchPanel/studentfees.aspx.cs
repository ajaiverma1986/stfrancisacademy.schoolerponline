using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_studentfees : System.Web.UI.Page
{
    private string url, q = "", str, str2, Query;
    private long loginID;
    private Utility objUT = new Utility();
    private CommonClass CommonClass = new CommonClass();
    private SqlDataReader dr;
    private DataUtility objdut = new DataUtility();
    private DataTable dt, dt1;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrBrid"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        if (Session["stue"] == null)
        {
            Response.Redirect("Default.aspx");
        }

        if (!IsPostBack)
        {
            ViewState["acad"] = CommonClass.Scaler("ActiveAcademicYear");
            fillgrd();
            fillsought();
            fillzonewisearea();
            fillDATEDDL();
            fillfyid();
        }
    }

    private void fillfyid()
    {
        string str = "select FYID,FYName from financial_Year";
        dt = objdut.GetDataTable(str);
        if (dt.Rows.Count > 0)
        {
            ddlreadmisn.DataSource = dt;
            ddlreadmisn.DataTextField = "FYName";
            ddlreadmisn.DataValueField = "FYID";
            ddlreadmisn.DataBind();
            ddlreadmisn.Items.Insert(0, new ListItem("--Select Financial Year--", "0"));
        }
        dt.Dispose();
    }

    private void fillzonewisearea()
    {
        DropDownList1.DataSource = CommonClass.Dll("zone");
        DropDownList1.DataTextField = "zonename";
        DropDownList1.DataValueField = "zoneid";
        DropDownList1.DataBind();
        DropDownList1.Items.Insert(0, new ListItem("--Select Sector--", "0"));
    }

    private void fillDATEDDL()
    {
        DataTable dt = CommonClass.ABC("MonthName");//CommmonOBJ.Dll("MonthName");
        ddlMonth.DataSource = dt;
        ddlMonth.DataBind();
        ddlMonth.DataTextField = "MonthName";
        ddlMonth.DataValueField = "MonthId";
        ddlMonth.DataBind();
        ddlMonth.Items.Insert(0, "--Month--");
        ddlDate.Items.Insert(0, "--Date--");
        ddlYear.Items.Insert(0, "--Year--");
    }

    private void fillsought()
    {
        dt = BLL.getclass(Convert.ToInt16(Session["BrBrid"]));
        if (dt.Rows.Count > 0)
        {
            ddl_Course.DataSource = dt;
            ddl_Course.DataValueField = "classid";
            ddl_Course.DataTextField = "Classname";
            ddl_Course.DataBind();
            ddl_Course.Items.Insert(0, "--Select Class--");
            dt.Clear();
        }
    }

    private void fillgrd()
    {
        int regno = Convert.ToInt32(objdut.GetScalar("select sturegno from tbl_admission where adid=" + Session["stue"]));
        dt = CommonClass.NameFun("studentfeewithdiscount", Convert.ToInt32(Session["BrBrid"]), Convert.ToString(regno));
        if (dt.Rows.Count > 0)
        {
            gvdetails.DataSource = dt;
            gvdetails.DataBind();
        }
        else
        {
            gvdetails.DataSource = null;
            gvdetails.DataBind();
            gvdetails.EmptyDataText = "No Records.";
        }
        dt.Clear();
    }

    //protected void Button3_Click(object sender, EventArgs e)
    //{
    //    string month = "";
    //    string proc = "usp_readmission";
    //    SqlParameter[] param = new SqlParameter[22];
    //    month = ddlMonth.SelectedValue;
    //    if (Convert.ToInt32(month) < 10)
    //    {
    //        month = "0" + month;
    //    }
    //    string admission_Date = Request.Form[admissionyear.UniqueID] + "-" + month + "-" + Request.Form[hdate.UniqueID];

    //    param[0] = new SqlParameter("@sturegno", Session["stue"]);
    //    param[1] = new SqlParameter("@admissionDate", admission_Date);
    //    param[2] = new SqlParameter("@brid", Convert.ToInt32(Session["BrBrid"]));
    //    param[3] = new SqlParameter("@applyclass", Request.Form[lblfeename1.UniqueID]);
    //    param[4] = new SqlParameter("@classid", Convert.ToInt16(Request.Form[lblfeeamout1.UniqueID]));
    //    param[5] = new SqlParameter("@section", ddlssection.SelectedItem.Text);
    //    param[6] = new SqlParameter("@sectionid", Convert.ToInt16(ddlssection.SelectedValue));
    //    param[8] = new SqlParameter("@transportaion", Convert.ToInt16(Request.Form[transid.UniqueID]));

    //    if (radiodaycare.SelectedItem.Text == "Yes")
    //    {
    //        param[9] = new SqlParameter("@daycarestatus", 1);
    //    }
    //    else
    //    {
    //        param[9] = new SqlParameter("@daycarestatus", 0);
    //    }
    //    if (txtdiscountcode.Text.Trim() != "")
    //    {
    //        param[10] = new SqlParameter("@discountrefno", txtdiscountcode.Text.Trim());
    //    }
    //    else
    //    {
    //        param[10] = new SqlParameter("@discountrefno", Convert.ToInt64("0"));
    //    }
    //    param[11] = new SqlParameter("@feepaynow", "PayNow");

    //    param[12] = new SqlParameter("@paymodeid", ddlPayMode.SelectedValue);
    //    if (ddlPayMode.SelectedIndex > 0)
    //    {
    //        param[13] = new SqlParameter("@bankname", txtBankName.Text.Trim());
    //        param[14] = new SqlParameter("@checkno", txtCheque.Text.Trim());
    //        if (txtDate.Text.Trim() != "")
    //        {
    //            param[15] = new SqlParameter("@draftdate", Convert.ToDateTime(txtDate.Text.Trim()));
    //        }
    //        else
    //        {
    //            param[15] = new SqlParameter("@draftdate", Convert.ToDateTime("1900-01-01 00:00:00.000"));
    //        }
    //        param[16] = new SqlParameter("@bankbranch", txtbranch.Text.Trim());
    //    }
    //    else
    //    {
    //        param[13] = new SqlParameter("@bankname", "");
    //        param[14] = new SqlParameter("@checkno", "");
    //        param[15] = new SqlParameter("@bankbranch", "");
    //        param[16] = new SqlParameter("@draftdate", Convert.ToDateTime("1900-01-01 00:00:00.000"));
    //    }

    //    param[17] = new SqlParameter("@payableamt", Convert.ToDouble(txtpayablefee.Text.Trim()));
    //    param[18] = new SqlParameter("@paynowamount", Convert.ToDouble(txtpaimat.Text.Trim()));

    //    param[19] = new SqlParameter("@monthids", Request.Form[paymonthsidshide.UniqueID]);
    //    param[20] = new SqlParameter("@fyid", Convert.ToInt16(ddlreadmisn.SelectedValue));
    //    param[7] = new SqlParameter("@intResult", Convert.ToInt32("0"));
    //    param[7].Direction = ParameterDirection.Output;
    //    param[21] = new SqlParameter("@max_adid", Convert.ToInt32("0"));
    //    param[21].Direction = ParameterDirection.Output;
    //    int count = objdut.ExecuteSqlSP(param, proc);
    //    double count1 = Convert.ToDouble(param[21].Value);
    //    if (count > 0)
    //    {
    //        Response.Redirect("AdmissionConfirm.aspx?adid=" + count1);
    //    }
    //    else
    //    {
    //        Utility.ViewAlertMessage(this.Master.Page, "Network error!!.. please try after some time or refresh page.......!");
    //        return;
    //    }

    //}

    public class Datainsert
    {
        public string admissionmonth { get; set; }

        public string tranType { get; set; }

        public string apclass { get; set; }

        public string classid { get; set; }

        public string section { get; set; }

        public string sectionid { get; set; }

        public string feeid { get; set; }

        public string feeamount { get; set; }

        public string feename { get; set; }

        public string discounamount { get; set; }

        public string checkbox2 { get; set; }

        public string admissiondate { get; set; }

        public string mode { get; set; }

        public string paymodeid { get; set; }

        public double payableamount { get; set; }

        public double paynowamount { get; set; }

        public string bankname { get; set; }

        public string checkno { get; set; }

        public string bankbranch { get; set; }

        public string cpaymonthids { get; set; }

        public int paytypeid { get; set; }

        public string paytypename { get; set; }

        public string transmode { get; set; }

        public string busno { get; set; }

        public int busid { get; set; }

        public int zoneid { get; set; }

        public int areaid { get; set; }

        public int stopageid { get; set; }

        public int fyid { get; set; }

        public string discountrefno { get; set; }

        public DateTime draftdate { get; set; }
    }

    [WebMethod(EnableSession = true)]
    public static string insertdata(Datainsert theData)
    {
        DataUtility objdut = new DataUtility();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            con.Open();
            using (SqlCommand cmd = new SqlCommand("usp_readmission", con))
            {
                // string month = "", date = "", year = "";
                string brusername = (string)HttpContext.Current.Session["Brusername"];
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.CommandText = "usp_readmission";
                // cmd.Parameters.AddWithValue("@admissionmonth", theData.admissionmonth);
                cmd.Parameters.AddWithValue("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
                cmd.Parameters.AddWithValue("@transportaion", theData.tranType);
                cmd.Parameters.AddWithValue("@mode", theData.transmode);

                if (theData.transmode == "addwithbus")
                {
                    cmd.Parameters.AddWithValue("@busid", theData.busid);
                    cmd.Parameters.AddWithValue("@busno", theData.busno);

                    cmd.Parameters.AddWithValue("@areaid", theData.areaid);

                    cmd.Parameters.AddWithValue("@zoneid", theData.zoneid);
                    cmd.Parameters.AddWithValue("@stopageid", theData.stopageid);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@busid", 0);
                    cmd.Parameters.AddWithValue("@busno", "");

                    cmd.Parameters.AddWithValue("@areaid", 0);

                    cmd.Parameters.AddWithValue("@zoneid", 0);
                    cmd.Parameters.AddWithValue("@stopageid", 0);
                }

                if (theData.apclass != "")
                {
                    cmd.Parameters.AddWithValue("@applyclass", theData.apclass);
                    cmd.Parameters.AddWithValue("@classid", theData.classid);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@applyclass", "");
                    cmd.Parameters.AddWithValue("@classid", Convert.ToInt16(0));
                }

                if (theData.section != "")
                {
                    cmd.Parameters.AddWithValue("@section", theData.section);
                    cmd.Parameters.AddWithValue("@sectionID", theData.sectionid);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@section", "");
                    cmd.Parameters.AddWithValue("@sectionID", Convert.ToInt16(0));
                }

                cmd.Parameters.AddWithValue("@AdmissionDate", theData.admissiondate);
                //cmd.Parameters.AddWithValue("@Feeid", theData.feeid);
                // cmd.Parameters.AddWithValue("@FeeName", theData.feename);
                // cmd.Parameters.AddWithValue("@FeeAmount", theData.feeamount);
                cmd.Parameters.AddWithValue("@paymodeid", theData.paymodeid);
                cmd.Parameters.AddWithValue("@bankname", theData.bankname);
                cmd.Parameters.AddWithValue("@checkno", theData.checkno);
                cmd.Parameters.AddWithValue("@bankbranch", theData.bankbranch);
                cmd.Parameters.AddWithValue("@payableamt", Convert.ToDouble(theData.payableamount));
                cmd.Parameters.AddWithValue("@paynowamount", Convert.ToDouble(theData.paynowamount));
                cmd.Parameters.AddWithValue("@monthids", theData.cpaymonthids);
                cmd.Parameters.AddWithValue("@feepaynow", "PAYNOW");
                cmd.Parameters.AddWithValue("@payType", theData.paytypeid);
                cmd.Parameters.AddWithValue("@paytypename", theData.paytypename);
                cmd.Parameters.AddWithValue("@draftdate", Convert.ToDateTime(theData.draftdate));
                cmd.Parameters.AddWithValue("@fyid", theData.fyid);
                cmd.Parameters.AddWithValue("@discountrefno", theData.discountrefno);

                cmd.Parameters.Add("@intResult", SqlDbType.BigInt, 0);
                cmd.Parameters["@intResult"].Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@max_adid", SqlDbType.BigInt, 0);
                cmd.Parameters["@max_adid"].Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@outputstudentid", SqlDbType.BigInt, 0);
                cmd.Parameters["@outputstudentid"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();
                string intResult = Convert.ToString(cmd.Parameters["@intResult"].Value);
                int studentid = Convert.ToInt32(cmd.Parameters["@outputstudentid"].Value);
                string url = "";
                con.Close();

                if (studentid > 0)
                {
                    // HttpContext.Current.Response.Redirect("AdmissionConfirm.aspx?adid=" + Convert.ToDouble(studentid), true);
                    url = "AdmissionConfirm.aspx?adid=" + Convert.ToDouble(studentid);
                    return url;
                }
                else
                {
                    return "Error during admission";
                }
            }
        }
        // return details.ToArray();
    }

    [WebMethod]
    public static string checkadmission(string ddlfyid)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select count(1) from tbl_admission where sturegno=" + HttpContext.Current.Session["stue"] + " and fyid=" + ddlfyid, con))
            {
                con.Open();
                string chk = cmd.ExecuteScalar().ToString();
                con.Close();
                return chk;
            }
        }
    }
}