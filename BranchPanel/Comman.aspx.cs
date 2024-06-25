using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class branchpanel_Comman : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static UserDetails[] BindDatatable(string gridtype, string ddlsearchbydate, string ddlfromdate, string ddltodate, string ddlsearchbyproduct, string ddlsearchbyenquirysource, string ddlsearchbystatus, string ddlsearchby, string txtsearchtext, string pageno)
    {
        DataSet ds = new DataSet();
        List<UserDetails> details = new List<UserDetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_GetenquiryDetails", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[11];
                param[0] = new SqlParameter("@gridtype", gridtype);
                param[1] = new SqlParameter("@searchbydatetype", ddlsearchbydate);
                param[2] = new SqlParameter("@fromdate", ddlfromdate);
                param[3] = new SqlParameter("@TODATE", ddltodate);
                if (ddlsearchbyproduct == "Select MLM Product")
                {
                    param[4] = new SqlParameter("@searbyproduct", Convert.ToString(21));
                }
                else if (ddlsearchbyproduct == "Select ERP Product")
                {
                    param[4] = new SqlParameter("@searbyproduct", Convert.ToString(22));
                }
                else if (ddlsearchbyproduct == "Select WEB PORTAL Product")
                {
                    param[4] = new SqlParameter("@searbyproduct", Convert.ToString(23));
                }
                else if (ddlsearchbyproduct == "Select ONLINE MARKETING Product")
                {
                    param[4] = new SqlParameter("@searbyproduct", Convert.ToString(24));
                }
                else if (ddlsearchbyproduct == "Select OTHER Product")
                {
                    param[4] = new SqlParameter("@searbyproduct", Convert.ToString(25));
                }
                else
                {
                    param[4] = new SqlParameter("@searbyproduct", (ddlsearchbyproduct));
                }

                param[5] = new SqlParameter("@searbyenquirysource", ddlsearchbyenquirysource);
                param[6] = new SqlParameter("@searchbystatus", ddlsearchbystatus);
                param[7] = new SqlParameter("@searchby", ddlsearchby);
                param[8] = new SqlParameter("@searchvalue", txtsearchtext);
                param[9] = new SqlParameter("@pagesize", 50);
                param[10] = new SqlParameter("@pageno", Convert.ToInt32(pageno));

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

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                con.Open();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        UserDetails user = new UserDetails();
                        user.RowNumber = Convert.ToInt32(dtrow["rownumber"]);
                        user.real_Enqiry_Id = dtrow["real_Enqiry_Id"].ToString();
                        user.enquirydate = dtrow["enquirydate"].ToString();
                        user.enquirysource = dtrow["enquirysource"].ToString();
                        user.enqtype = dtrow["enqtype"].ToString();
                        user.name = dtrow["name"].ToString();
                        user.mobile = dtrow["mobile"].ToString();
                        user.City = dtrow["City"].ToString();
                        user.statusname = dtrow["statusname"].ToString();
                        user.followupdate = dtrow["followupdate"].ToString();
                        user.enquiryid = Convert.ToInt32(dtrow["enquiryid"]);
                        user.contactby = dtrow["contactedby"].ToString();
                        user.contactdate = dtrow["contacteddate"].ToString();
                        user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString();

                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class UserDetails
    {
        public int RowNumber { get; set; }

        public string real_Enqiry_Id { get; set; }

        public string enquirydate { get; set; }

        public string enquirysource { get; set; }

        public string enqtype { get; set; }

        public string name { get; set; }

        public string City { get; set; }

        public string mobile { get; set; }

        public string statusname { get; set; }

        public string followupdate { get; set; }

        public string contactdate { get; set; }

        public string contactby { get; set; }

        public int enquiryid { get; set; }

        public string pagecount { get; set; }
    }

    //--Mode 1 For Sms
    //--Mode 2 For Email
    [WebMethod]
    public static int Maintain_Sms_Email_Log(int eid, string Refno, string MobileNo, string email_id, string msg, string subject, string MessageModule, int mode, int shortlist_id)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[sms_email_log_maintain]", con))
            {
                con.Open();

                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter[] param = new SqlParameter[11];

                if (eid != 0)
                {
                    param[0] = new SqlParameter("@eid", eid);
                }
                else
                {
                    param[0] = new SqlParameter("@eid", 0);
                }

                param[1] = new SqlParameter("@Refno", Refno);

                param[2] = new SqlParameter("@Mobileno", MobileNo);

                param[3] = new SqlParameter("@Email_id", email_id);

                param[4] = new SqlParameter("@text", msg);

                param[5] = new SqlParameter("@subject", subject);

                param[6] = new SqlParameter("@MessageorEmailModule", MessageModule);

                param[7] = new SqlParameter("@mode", mode);

                param[8] = new SqlParameter("@intresult", SqlDbType.Int);

                param[8].Direction = ParameterDirection.Output;

                if (shortlist_id != 0)
                {
                    param[9] = new SqlParameter("@shortlist_id", shortlist_id);
                }
                else
                {
                    param[9] = new SqlParameter("@shortlist_id", 0);
                }

                param[10] = new SqlParameter("@userid", Convert.ToInt32(HttpContext.Current.Session["BrADID"]));

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

                cmd.ExecuteNonQuery();

                int result = Convert.ToInt32(cmd.Parameters["@intresult"].Value);

                return result;
            }
        }
    }

    //=================================COde for Getting Followup detail=======================
    [WebMethod]
    public static followupdetails[] GetFollowupdata(int eid)
    {
        DataSet ds = new DataSet();
        List<followupdetails> details = new List<followupdetails>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("usp_get_followupdetail", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[1];
                param[0] = new SqlParameter("@enquiryid", eid);

                cmd.Parameters.Add(param[0]);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        followupdetails user = new followupdetails();
                        user.rownumber = dtrow["rownumber"].ToString();
                        user.enquiryid = dtrow["enquiryid"].ToString();

                        if (dtrow["contacteddate"].ToString() != "" && dtrow["contacteddate"].ToString() != null)
                        {
                            DateTime date = Convert.ToDateTime(dtrow["contacteddate"]);
                            user.contacteddate = date.ToString("MMM dd yyyy");
                        }
                        else
                        {
                            user.contacteddate = "N/A";
                        }

                        user.contactedtime = dtrow["contactedtime"].ToString();

                        if (dtrow["followdate"].ToString() != "" && dtrow["followdate"].ToString() != null)
                        {
                            DateTime fdate = Convert.ToDateTime(dtrow["followdate"]);
                            user.followdate = fdate.ToString("MMM dd yyyy");
                        }
                        else
                        {
                            user.followdate = "N/A";
                        }

                        user.followtime = dtrow["followtime"].ToString();
                        user.remarks = dtrow["remarks"].ToString();

                        user.contactedby = dtrow["contactedby"].ToString();
                        user.statusname = dtrow["statusname"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class followupdetails
    {
        public string rownumber { get; set; }

        public string enquiryid { get; set; }

        public string contacteddate { get; set; }

        public string contactedtime { get; set; }

        public string followdate { get; set; }

        public string followtime { get; set; }

        public string remarks { get; set; }

        public string contactedby { get; set; }

        public string statusname { get; set; }
    }

    //=====Code for getting sms history table========
    [WebMethod]
    public static smshistorylist[] Get_sms_history(string refNo, string mobile, string datefrom, string dateto, int pageno)
    {
        DataSet ds = new DataSet();
        List<smshistorylist> details = new List<smshistorylist>();

        SqlParameter[] p = new SqlParameter[6];

        p[0] = new SqlParameter("@refno", SqlDbType.VarChar, 200);
        p[0].Value = refNo;

        p[1] = new SqlParameter("@mobileno", SqlDbType.VarChar, 200);
        p[1].Value = mobile;

        p[2] = new SqlParameter("@datefrom", SqlDbType.VarChar, 200);

        if (datefrom != "")
        {
            string datefrm = datefrom;
            string[] Doidate = datefrm.Split('/');
            datefrm = Doidate[2] + '-' + Doidate[1] + '-' + Doidate[0];

            p[2].Value = datefrm;
        }

        p[3] = new SqlParameter("@pagesize", SqlDbType.Int);
        p[3].Value = 100;

        p[4] = new SqlParameter("@pageno", SqlDbType.Int);
        p[4].Value = pageno;

        p[5] = new SqlParameter("@dateto", SqlDbType.VarChar, 200);
        if (dateto != "")
        {
            string datetooo = dateto;
            string[] datetoo = datetooo.Split('/');
            datetooo = datetoo[2] + '-' + datetoo[1] + '-' + datetoo[0];
            p[5].Value = datetooo;
        }

        DataUtility ObjDUT = new DataUtility();

        ds = ObjDUT.GetDataSetSP(p, "[get_sms_history]");

        foreach (DataRow dtrow in ds.Tables[0].Rows)
        {
            smshistorylist user = new smshistorylist();
            user.RowNumber = dtrow["RowNumber"].ToString();
            user.name = dtrow["name"].ToString();
            user.smsid = dtrow["smsid"].ToString();
            user.eid = dtrow["eid"].ToString();
            user.sms_date = dtrow["sms_date"].ToString();
            user.sms_time = dtrow["sms_time"].ToString();
            user.sub_mobile = dtrow["sub_mobile"].ToString();
            user.sms_text = dtrow["sms_text"].ToString();
            user.status = dtrow["status"].ToString();
            user.mobile_no = dtrow["mobile_no"].ToString();
            user.ref_no = dtrow["ref_no"].ToString();
            user.sms_modele = dtrow["sms_modele"].ToString();
            user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString();

            details.Add(user);
        }
        return details.ToArray();
    }

    public class smshistorylist
    {
        public string RowNumber { get; set; }

        public string name { get; set; }

        public string smsid { get; set; }

        public string eid { get; set; }

        public string sms_date { get; set; }

        public string sms_time { get; set; }

        public string sms_text { get; set; }

        public string status { get; set; }

        public string mobile_no { get; set; }

        public string ref_no { get; set; }

        public string sms_modele { get; set; }

        public string sub_mobile { get; set; }

        public string pagecount { get; set; }
    }

    //=====Code for getting email history table========
    [WebMethod]
    public static emailhistorylist[] Get_email_history(string refNo, string emailid, string datefrom, string dateto, int pageno)
    {
        DataSet ds = new DataSet();
        List<emailhistorylist> details = new List<emailhistorylist>();

        SqlParameter[] p = new SqlParameter[6];

        p[0] = new SqlParameter("@refno", SqlDbType.VarChar, 200);
        p[0].Value = refNo;

        p[1] = new SqlParameter("@emailid", SqlDbType.VarChar, 200);
        p[1].Value = emailid;

        p[2] = new SqlParameter("@datefrom", SqlDbType.VarChar, 200);

        if (datefrom != "")
        {
            string datefrm = datefrom;
            string[] Doidate = datefrm.Split('/');
            datefrm = Doidate[2] + '-' + Doidate[1] + '-' + Doidate[0];

            p[2].Value = datefrm;
        }

        p[3] = new SqlParameter("@pagesize", SqlDbType.Int);
        p[3].Value = 100;

        p[4] = new SqlParameter("@pageno", SqlDbType.Int);
        p[4].Value = pageno;

        p[5] = new SqlParameter("@dateto", SqlDbType.VarChar, 200);
        if (dateto != "")
        {
            string datetooo = dateto;
            string[] datetoo = datetooo.Split('/');
            datetooo = datetoo[2] + '-' + datetoo[1] + '-' + datetoo[0];
            p[5].Value = datetooo;
        }

        DataUtility ObjDUT = new DataUtility();

        ds = ObjDUT.GetDataSetSP(p, "[get_email_history]");

        foreach (DataRow dtrow in ds.Tables[0].Rows)
        {
            emailhistorylist user = new emailhistorylist();
            user.RowNumber = dtrow["RowNumber"].ToString();
            user.name = dtrow["name"].ToString();
            user.emailid = dtrow["emailid"].ToString();
            user.eid = dtrow["eid"].ToString();
            user.email_date = dtrow["email_date"].ToString();
            user.email_time = dtrow["email_time"].ToString();
            user.email_text = dtrow["email_text"].ToString();
            user.email_subject = dtrow["email_subject"].ToString();
            user.status = dtrow["status"].ToString();
            user.email_id = dtrow["email_id"].ToString();
            user.email_modele = dtrow["email_modele"].ToString();
            user.designationid = dtrow["designationid"].ToString();
            user.deptid = dtrow["deptid"].ToString();
            user.ref_no = dtrow["ref_no"].ToString();
            user.sub_email = dtrow["sub_email"].ToString();
            user.pagecount = ds.Tables[1].Rows[0]["pages"].ToString();

            details.Add(user);
        }
        return details.ToArray();
    }

    public class emailhistorylist
    {
        public string RowNumber { get; set; }

        public string name { get; set; }

        public string emailid { get; set; }

        public string sub_email { get; set; }

        public string eid { get; set; }

        public string email_date { get; set; }

        public string email_time { get; set; }

        public string email_text { get; set; }

        public string email_subject { get; set; }

        public string status { get; set; }

        public string email_id { get; set; }

        public string email_modele { get; set; }

        public string ref_no { get; set; }

        public string designationid { get; set; }

        public string deptid { get; set; }

        public string pagecount { get; set; }
    }

    #region for state bind function start

    [WebMethod]
    public static statedetail[] bindstate(string cid)
    {
        List<statedetail> details = new List<statedetail>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select SID,stateName  from STATE where CID=" + Convert.ToInt32(cid) + " and sactive=1 order by stateName", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                statedetail subjectdetails0 = new statedetail();
                subjectdetails0.SID = Convert.ToInt32("0");
                subjectdetails0.stateName = "---Select State---";
                details.Add(subjectdetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    statedetail subjectdetails = new statedetail();
                    subjectdetails.SID = Convert.ToInt32(dtrow["SID"].ToString());
                    subjectdetails.stateName = dtrow["stateName"].ToString();
                    details.Add(subjectdetails);
                }
            }
        }
        return details.ToArray();
    }

    public class statedetail
    {
        public int SID { get; set; }

        public string stateName { get; set; }
    }

    #endregion for state bind function start

    #region for binding the city data by web method start here================

    [WebMethod]
    public static citydetail[] bindcity(string sid)
    {
        List<citydetail> details = new List<citydetail>();
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("select ctId,cityname from city where sid=" + Convert.ToInt32(sid) + "  and Active=1 order by cityname", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);

                citydetail subjectdetails0 = new citydetail();
                subjectdetails0.ctId = Convert.ToInt32("0");
                subjectdetails0.cityname = "---Select City---";
                details.Add(subjectdetails0);

                foreach (DataRow dtrow in dt.Rows)
                {
                    citydetail citydetails = new citydetail();
                    citydetails.ctId = Convert.ToInt32(dtrow["ctId"].ToString());
                    citydetails.cityname = dtrow["cityname"].ToString();
                    details.Add(citydetails);
                }
            }
        }
        return details.ToArray();
    }

    public class citydetail
    {
        public int ctId { get; set; }

        public string cityname { get; set; }
    }

    #endregion for binding the city data by web method start here================
}