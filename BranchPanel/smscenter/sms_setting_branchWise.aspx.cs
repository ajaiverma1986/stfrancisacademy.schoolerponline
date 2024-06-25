using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.Services;

public partial class BranchPanel_smscenter_sms_setting_branchWise : System.Web.UI.Page
{
    private StringBuilder strbdr = new StringBuilder();
    private bal.sms_master bal = new bal.sms_master();
    private string action;
    private string content;
    protected void Page_Load(object sender, EventArgs e)
    {
        Bindcustomgrid();
    }
    public void Bindcustomgrid()
    {
        strbdr.Append("<table id='headwithbranch' class='stm' style='width:100%; border-collapse:collapse;'><tr class='stm_head'>");
        strbdr.Append(@"<td style='width:5%;'>S.No. </td><td style='width:15%;'>Module Name</td><td style='width:30%;'>Action Name</td><td style='width:10%;'>Api Type</td>
                       <td style='width:30%;'>Message</td><td style='width:5%;'>Edit</td><td style='width:5%;'>on/off</td>");
        DataSet Ds = bal.show_sms_master();
        if (Ds.Tables[0].Rows.Count > 0)
        {
            int count = 1;
            for (int i = 0; i < Ds.Tables[1].Rows.Count; i++)
            {
                int j = 0;
                foreach (DataRow Dr in Ds.Tables[0].Select("moduleid=" + Ds.Tables[1].Rows[i]["moduleid"]))
                {
                    string disabled = "";
                    if (Convert.ToInt32(Dr["ApiTypeId"]) == 0)
                        disabled = "disabled";
                    if (Convert.ToInt32(Dr["sms_send_to"]) == 0)
                        disabled = "disabled";
                    if (j == 0)
                    {
                        if (Convert.ToInt32(Dr.ItemArray[10]) == 0)
                        {
                            strbdr.Append("<tr><td rowspan=" + Ds.Tables[1].Rows[i]["colspan"] + ">" + count + "</td><td rowspan=" + Ds.Tables[1].Rows[i]["colspan"] + ">" + Dr.ItemArray[1] + "</td>");
                            if (Dr.ItemArray[3].ToString().Length > 25)
                            {
                                strbdr.Append("<td><span data-tooltip='" + Dr.ItemArray[3] + "'>" + Dr.ItemArray[2] + "</span></td>");
                            }
                            else
                            {
                                strbdr.Append("<td><span>" + Dr.ItemArray[2] + "</span></td>");
                            }
                            strbdr.Append("<td><input type='hidden' value='" + Dr.ItemArray[0] + "'>" + Dr.ItemArray[4] + "</td>");
                            if (Dr.ItemArray[7].ToString().Length > 20)
                            {
                                strbdr.Append("<td><span data-tooltip='" + Dr.ItemArray[7] + "'>" + Dr.ItemArray[6] + "</span></td>");
                            }
                            else
                            {
                                strbdr.Append("<td><span>" + Dr.ItemArray[6] + "</span></td>");
                            }
                            strbdr.Append("<td><input class='editimage' type='image' style='height:15px;width:15px;border-width:0px;' alt='No Image' src='../images/edit.png' /                              ></td><td>" +
                            "<input type='checkbox' name='selST' class='apiactivedeactive'  " + disabled + "></td></tr>");
                        }
                        else
                        {
                            strbdr.Append("<tr><td rowspan=" + Ds.Tables[1].Rows[i]["colspan"] + ">" + count + "</td><td rowspan=" + Ds.Tables[1].Rows[i]["colspan"] + ">" + Dr.ItemArray[1] + "</td>");
                            if (Dr.ItemArray[3].ToString().Length > 25)
                            {
                                strbdr.Append("<td><span data-tooltip='" + Dr.ItemArray[3] + "'>" + Dr.ItemArray[2] + "</span></td>");
                            }
                            else
                            {
                                strbdr.Append("<td><span>" + Dr.ItemArray[2] + "</span></td>");
                            }
                            strbdr.Append("<td><input type='hidden' value='" + Dr.ItemArray[0] + "'>" + Dr.ItemArray[4] + "</td>");
                            if (Dr.ItemArray[7].ToString().Length > 20)
                            {
                                strbdr.Append("<td><span data-tooltip='" + Dr.ItemArray[7] + "'>" + Dr.ItemArray[6] + "</span></td>");
                            }
                            else
                            {
                                strbdr.Append("<td><span>" + Dr.ItemArray[6] + "</span></td>");
                            }
                            strbdr.Append("<td><input class='editimage' type='image' style='height:15px;width:15px;border-width:0px;' alt='No Image' src='../images/edit.png' /                              ></td><td>" +
                            "<input type='checkbox' name='selST' class='apiactivedeactive' " + Convert.ToString(Dr["smssendstatus"]) + " " + disabled + "></td></tr>");
                        }
                        j = 1;
                        count++;
                    }
                    else
                    {
                        if (Convert.ToInt32(Dr.ItemArray[10]) == 0)
                        {
                            strbdr.Append("<tr class='stm_dark'>");
                            if (Dr.ItemArray[3].ToString().Length > 25)
                            {
                                strbdr.Append("<td><span data-tooltip='" + Dr.ItemArray[3] + "'>" + Dr.ItemArray[2] + "</span></td>");
                            }
                            else
                            {
                                strbdr.Append("<td><span>" + Dr.ItemArray[2] + "</span></td>");
                            }
                            strbdr.Append("<td><input type='hidden' value='" + Dr.ItemArray[0] + "'>" + Dr.ItemArray[4] + "</td>");
                            if (Dr.ItemArray[7].ToString().Length > 20)
                            {
                                strbdr.Append("<td><span data-tooltip='" + Dr.ItemArray[7] + "'>" + Dr.ItemArray[6] + "</span></td>");
                            }
                            else
                            {
                                strbdr.Append("<td><span>" + Dr.ItemArray[6] + "</span></td>");
                            }
                            strbdr.Append("<td><input class='editimage' type='image' style='height:15px;width:15px;border-width:0px;' alt='No Image' src='../images/edit.png' /                              ></td><td>" +
                            "<input type='checkbox' name='selST' class='apiactivedeactive'  " + disabled + "></td></tr>");
                        }
                        else
                        {
                            strbdr.Append("<tr class='stm_light'>");
                            if (Dr.ItemArray[3].ToString().Length > 25)
                            {
                                strbdr.Append("<td><span data-tooltip='" + Dr.ItemArray[3] + "'>" + Dr.ItemArray[2] + "</span></td>");
                            }
                            else
                            {
                                strbdr.Append("<td><span>" + Dr.ItemArray[2] + "</span></td>");
                            }
                            strbdr.Append("<td><input type='hidden' value='" + Dr.ItemArray[0] + "'>" + Dr.ItemArray[4] + "</td>");
                            if (Dr.ItemArray[7].ToString().Length > 20)
                            {
                                strbdr.Append("<td><span data-tooltip='" + Dr.ItemArray[7] + "'>" + Dr.ItemArray[6] + "</span></td>");
                            }
                            else
                            {
                                strbdr.Append("<td><span>" + Dr.ItemArray[6] + "</span></td>");
                            }
                            strbdr.Append("<td><input class='editimage' type='image' style='height:15px;width:15px;border-width:0px;' alt='No Image' src='../images/edit.png'/></td><td>" +
                             "<input type='checkbox' name='selST' class='apiactivedeactive'  " + Convert.ToString(Dr["smssendstatus"]) + " " + disabled + "></td></tr>");
                        }
                    }
                }
            }
        }
        else
        {
            strbdr.Append("<td colspan='8'>No record found</td>");
        }
        showdata.InnerHtml = strbdr.ToString();
    }
    //call sms setting master data based on actionid
    [WebMethod]
    public static List<sms_master> call_smssettings(string actionid)
    {
        List<sms_master> Details = new List<sms_master>();
        DataUtility Objdut = new DataUtility();
        DataTable DtCoursefee;
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@actionid", actionid);
        using (DtCoursefee = new DataTable())
        {
            DtCoursefee = Objdut.GetDataTableSP(param, "[usp_sms_settingcenter]");
            for (int i = 0; i < DtCoursefee.Rows.Count; i++)
            {
                sms_master fee_obj = new sms_master();
                fee_obj.actionID = Convert.ToInt32(DtCoursefee.Rows[i]["id"].ToString());
                fee_obj.modulename = DtCoursefee.Rows[i]["modulename"].ToString();
                fee_obj.actionname = (DtCoursefee.Rows[i]["action_name"].ToString());
                fee_obj.apitype = (DtCoursefee.Rows[i]["apitype"].ToString());
                fee_obj.smscontent = DtCoursefee.Rows[i]["sms_content"].ToString();
                fee_obj.smsstuparents = DtCoursefee.Rows[i]["smsstuparents"].ToString();
                fee_obj.sms_send_to = Convert.ToInt32(DtCoursefee.Rows[i]["sms_send_to"].ToString());
                fee_obj.DivForBindVariable = DtCoursefee.Rows[i]["DivForBindVariable"].ToString();
                fee_obj.apitypestatus = Convert.ToInt32(DtCoursefee.Rows[i]["apitypestatus"].ToString());
                fee_obj.AutoRemainderType = Convert.ToInt32(DtCoursefee.Rows[i]["AutoRemainderType"].ToString());
                Details.Add(fee_obj);
            }
        }
        return Details;
    }

    public class sms_master
    {
        public int actionID { get; set; }

        public int moduleidID { get; set; }

        public string modulename { get; set; }

        public string actionname { get; set; }

        public string Fullaction { get; set; }

        public string apitype { get; set; }

        public string smscontent { get; set; }

        public string fullcontent { get; set; }

        public string smsstuparents { get; set; }

        public int sms_send_to { get; set; }

        public int apitypestatus { get; set; }

        public string DivForBindVariable { get; set; }

        public int rowspan { get; set; }

        public int ApiTypeId { get; set; }

        public string smssendstatus { get; set; }

        public int AutoRemainderType { get; set; }
    }

    //edit sms master settings and rebind grid
    [WebMethod]
    public static sms_master[] set_smssettings(string actionid, string msg, string apitype, string sms_send_to, string AutoRemainderType)
    {
        List<sms_master> details = new List<sms_master>();
        DataTable dtcoursefee = new DataTable();
        SqlParameter[] param = new SqlParameter[5];
        string que = @"update tbl_smsAction set sms_content=@msg,apitype=@apitype,sms_send_to=@smssendto,AutoRemainderType=@AutoRemainderType where id=@actionid";
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand(que, con))
            {
                con.Open();
                param[0] = new SqlParameter("@actionid", actionid);
                param[1] = new SqlParameter("@msg", msg.Replace("~", "'"));
                param[2] = new SqlParameter("@apitype", apitype);
                param[3] = new SqlParameter("@smssendto", sms_send_to);
                param[4] = new SqlParameter("@AutoRemainderType", AutoRemainderType);
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                cmd.Parameters.Add(param[3]);
                cmd.Parameters.Add(param[4]);
                int ret = cmd.ExecuteNonQuery();
                if (ret == 1)
                {
                    bal.sms_master bal = new bal.sms_master();
                    DataSet dt = bal.show_sms_master();

                    foreach (DataRow dtrow in dt.Tables[0].Rows)
                    {
                        sms_master fee_obj = new sms_master();
                        fee_obj.actionID = Convert.ToInt32(dtrow["id"].ToString());
                        fee_obj.modulename = dtrow["modulename"].ToString();
                        fee_obj.moduleidID = Convert.ToInt32(dtrow["moduleid"].ToString());
                        fee_obj.actionname = (dtrow["action_name"].ToString());
                        fee_obj.Fullaction = (dtrow["Fullaction"].ToString());
                        fee_obj.apitype = dtrow["apitype"].ToString();
                        fee_obj.smscontent = dtrow["sms_content"].ToString();
                        fee_obj.fullcontent = dtrow["fullcontent"].ToString();
                        fee_obj.smsstuparents = dtrow["smsstuparents"].ToString();
                        fee_obj.sms_send_to = Convert.ToInt32(dtrow["sms_send_to"].ToString());
                        fee_obj.ApiTypeId = Convert.ToInt32(dtrow["ApiTypeId"].ToString());
                        fee_obj.smssendstatus = Convert.ToString(dtrow["smssendstatus"].ToString());
                        DataRow[] dr = dt.Tables[1].Select("moduleid=" + dtrow["moduleid"]);
                        fee_obj.rowspan = Convert.ToInt32(dr[0]["colspan"]);
                        details.Add(fee_obj);
                    }
                }
            }
        }
        return details.ToArray();
    }

    [WebMethod]
    public static int checkApiStatus(string actionID, string sts)
    {
        DataUtility objdut = new DataUtility();
        string que = "update tbl_smsAction set sms_send_status=@status where id=@actionid";
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@actionid", actionID);
        param[1] = new SqlParameter("@status", sts);
        int ret = objdut.ExecuteSql(param, que);
        return ret;
    }

    [WebMethod]
    public static int RestoreSmsSetting()
    {
        DataUtility objdut = new DataUtility();
        string Query = @"UPDATE  tbl_main SET
        tbl_main.action_name=tbl_deafult.action_name,
        tbl_main.sms_content=tbl_deafult.sms_content,
        tbl_main.email_content=tbl_deafult.email_content,
        tbl_main.action_status=tbl_deafult.action_status,
        tbl_main.sms_send_to=tbl_deafult.sms_send_to,
        tbl_main.sms_send_status=tbl_deafult.sms_send_status,
        tbl_main.apitype=tbl_deafult.apitype,
        tbl_main.email_or_sms=tbl_deafult.email_or_sms,
        tbl_main.Api_Status=tbl_deafult.Api_Status,
        tbl_main.AutoRemainderType=tbl_deafult.AutoRemainderType FROM
        [tbl_DefaultsmsAction] tbl_deafult
        JOIN [tbl_smsAction] tbl_main ON tbl_deafult.Id=tbl_main.id";
        int NoOfRowUpdated = objdut.ExecuteSql(Query);
        return NoOfRowUpdated;
    }

    [WebMethod]
    public static int updatesmsapi(string smsapi, string active, string proapi, string proactive)
    {
        DataUtility objdut = new DataUtility();
        SqlParameter[] param = new SqlParameter[7];
        param[0] = new SqlParameter("@smsapi", smsapi);
        param[1] = new SqlParameter("@status", active);
        param[2] = new SqlParameter("@mode", 3);
        param[3] = new SqlParameter("@intResult", 0);
        param[3].Direction = ParameterDirection.Output;
        param[4] = new SqlParameter("@prosmsapi", proapi);
        param[5] = new SqlParameter("@prostatus", proactive);
        param[6] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        int a = objdut.ExecuteSqlSP(param, "[usp_general_master_setting]");
        return a;
    }

    [WebMethod]
    public static Smsapi[] getsmsapi()
    {
        DataTable dt = new DataTable();
        List<Smsapi> details = new List<Smsapi>();
        string q = "";
        DataUtility ObjDUT = new DataUtility();
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 4);
        param[1] = new SqlParameter("@brid", Convert.ToInt32(HttpContext.Current.Session["BrBrid"]));
        dt = ObjDUT.GetDataTableSP(param, "usp_general_master_setting");
        if (dt.Rows.Count > 0)
        {
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                Smsapi api = new Smsapi();
                api.smsapi = dt.Rows[i]["sms_api"].ToString();
                api.status = dt.Rows[i]["status"].ToString();
                api.api_type = dt.Rows[i]["api_type"].ToString();
                api.proactive = dt.Rows[i]["status"].ToString();
                details.Add(api);
            }
        }
        return details.ToArray();
    }

    public class Smsapi
    {
        public string smsapi { get; set; }

        public string status { get; set; }

        public string api_type { get; set; }

        public string proactive { get; set; }
    }

    [WebMethod]
    public static int sendsmsonmobile(string api, string type)
    {
        int result = 1;
        //if (type == "1")
        //{
        //    result = sendMessageToMobile.SMSSend(api, "Api Check", 0);
        //}
        //else
        //{
        //    result = sendMessageToMobile.SMSSend(api, "Api Check", 1);
        //}
        return result;
    }
}