using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EmployeePanel_FeePayResponse : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataUtility Objdut = new DataUtility();
        CommonClass objcommon = new CommonClass();
        NameValueCollection nvc = Request.Form;       

        string mmp_txn = "", mer_txn = "", amt = "", prod = "", date = "", bank_txn = "", f_code = "", clientcode = "", bank_name = "",
       auth_code = "", ipg_txn_id = "", merchant_id = "", desc = "", discriminator = "", surcharge = "", CardNumber = "";

        if (nvc["mmp_txn"] != null)
        { mmp_txn = nvc["mmp_txn"].ToString(); }
        if (nvc["mer_txn"] != null)
        { mer_txn = nvc["mer_txn"].ToString(); }
        if (nvc["amt"] != null)
        { amt = nvc["amt"].ToString(); }
        if (nvc["prod"] != null)
        { prod = nvc["prod"].ToString(); }
        if (nvc["date"] != null)
        { date = DateTime.Now.ToString("dd MMM yyyy"); }
        if (nvc["bank_txn"] != null)
        { bank_txn = nvc["bank_txn"].ToString(); }
        if (nvc["clientcode"] != null)
        { clientcode = nvc["clientcode"].ToString(); }
        if (nvc["bank_name"] != null)
        { bank_name = nvc["bank_name"].ToString(); }
        if (nvc["auth_code"] != null)
        { auth_code = nvc["auth_code"].ToString(); }
        if (nvc["ipg_txn_id"] != null)
        { ipg_txn_id = nvc["ipg_txn_id"].ToString(); }
        if (nvc["merchant_id"] != null)
        { merchant_id = nvc["merchant_id"].ToString(); }
        if (nvc["desc"] != null)
        { desc = nvc["desc"].ToString(); }
        if (nvc["discriminator"] != null)
        { discriminator = nvc["discriminator"].ToString(); }
        if (nvc["surcharge"] != null)
        { surcharge = nvc["surcharge"].ToString(); }
        if (nvc["CardNumber"] != null)
        { CardNumber = nvc["CardNumber"].ToString(); }

        int transCount = 0;
        string ASAID = nvc["udf5"].ToString();
        string RECIPTNO = nvc["udf1"].ToString();
        string STUREGNO = nvc["udf9"].ToString();
       
        Service objService = new Service();
        if (nvc.Count > 0)
        {
            if (nvc["f_code"] != null)
            { f_code = nvc["f_code"].ToString(); }
            if (f_code == "Ok")
            {
                int paymneCount = 0;                               

                paymneCount = Convert.ToInt32(objService.DepositFee1("0",ASAID, "6", bank_name, "", "", date, RECIPTNO, date, "", amt, date, ASAID));
                transCount = Convert.ToInt32(objService.transPayment(ASAID, STUREGNO, mmp_txn.ToString(), mer_txn.ToString(), amt, prod.ToString(), date, bank_txn.ToString(), f_code.ToString(), clientcode.ToString(), bank_name.ToString(), auth_code.ToString(), merchant_id.ToString(), desc.ToString(), discriminator.ToString(), surcharge, CardNumber.ToString()));

                string InstallmentDate = Objdut.GetScalar("select ISNULL(Convert(varchar(20),InstallmentDate,103),'') InstallmentDate from tbl_StudentAdmissionInstallment where ASAID =" + ASAID + "").ToString();
                int Brid = Convert.ToInt32(Objdut.GetScalar("select ISNULL(Brid,0) InstallmentDate from tbl_StudentAdmissionInstallment where ASAID =" + ASAID + ""));
                string msg1 = "", msg2 = "", msg3 = "";
                msg1 = "'Hi ";
                msg2 = " Your Amount of Rs." + amt + " of Due Date : " + InstallmentDate + " Received Successfully on " + DateTime.Now.ToString("dd MMM yyyy hh:mm:ss") + "";
                if (paymneCount == 0 || transCount == 0)
                {
                    msg2 += " but Error During insertion in School Database,Thanks !!!";
                }
                else
                {
                    msg3 += " with Reciept No : " + RECIPTNO + " and TxnID " + bank_txn + ". Thanks !!!";
                }
                CommonClass.getStudentMobileNo(Brid, Convert.ToDecimal(STUREGNO), Convert.ToInt32(CommonClass.Scaler("ActiveAcademicYear")), msg1, msg2, msg3);
                ScriptManager.RegisterClientScriptBlock((sender as Control), this.GetType(), "alert", "alert('" + msg2 + "')", true);
            }
            else
            {
                transCount = Convert.ToInt32(objService.transPayment(ASAID, STUREGNO, mmp_txn.ToString(), mer_txn.ToString(), amt, prod.ToString(), date, bank_txn.ToString(), f_code.ToString(), clientcode.ToString(), bank_name.ToString(), auth_code.ToString(), merchant_id.ToString(), desc.ToString(), discriminator.ToString(), surcharge, CardNumber.ToString()));
            }
        }
    }
}