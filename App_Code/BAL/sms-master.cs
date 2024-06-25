using System.Data;

/// <summary>
/// Summary description for sms_master
/// </summary>

namespace bal
{
    public class sms_master
    {
        private DataUtility objdut = new DataUtility();

        private string que = @"select t2.id,t1.modulename,
case when LEN(t2.action_name)>40 then SUBSTRING(t2.action_name,0,40)+'..' else t2.action_name end as action_name,t2.action_name as Fullaction,
case when t2.apitype=0 then 'Not Set' when t2.apitype=1 then 'transactional'
        when t2.apitype=2 then 'promotional' end as apitype  ,description_sms,
		case when LEN(sms_content)>50 then SUBSTRING(sms_content,0,50)+'..' else sms_content end as sms_content,sms_content as fullcontent,
		smsstuparents,is_active,t2.moduleid,t2.sms_send_to
        ,t2.sms_send_status,(Case When (t2.apitype<>0 And Api_Status<>0) Then t2.apitype Else 0 End)As ApiTypeId,
        (case when t2.sms_send_status=1 then 'checked' Else '' End) As smssendstatus
        from tbl_SMSemail_Master t1 inner join tbl_smsAction t2 on t1.moduleid=t2.moduleid and t2.email_or_sms=1 order by
        t2.moduleid;select count(id)as colspan,moduleid from tbl_smsAction where email_or_sms=1 group by moduleid";

        public sms_master()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public DataSet show_sms_master()
        {
            DataSet dt = objdut.GetDataSet(que);
            return dt;
        }
    }
}