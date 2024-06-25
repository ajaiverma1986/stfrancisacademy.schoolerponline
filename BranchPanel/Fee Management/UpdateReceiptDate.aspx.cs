using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Fee_Management_UpdateReceiptDate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        DataUtility dtutil = new DataUtility();
        string msg = "";
        if(txtReceiptNum.Text.Trim()=="")
        {
            msg = "Enter Receipt number";
        }
        if (txtDate.Text.Trim() == "")
        {
            msg = msg+" Enter Receipt date";
        }
        if(msg=="")
        {
            try
            {
                string qry = "update Receipt_master set PaymentDate='" + txtDate.Text.Trim() + "' where Receiptno= '" + txtReceiptNum.Text.Trim() + "'";

                int result = dtutil.ExecuteSql(qry);

                if (result>0)
                {
                    qry = "update tbl_StudentAdmissionInstallment set PaidDate='" + txtDate.Text.Trim() + "' where ReciptNo= '" + txtReceiptNum.Text.Trim() + "'";
                    result = dtutil.ExecuteSql(qry);
                }
                if(result>0)
                {
                    lblmsg.ForeColor = System.Drawing.Color.Green;
                    lblmsg.Text = "Updated";
                }
                else
                {
                    lblmsg.ForeColor = System.Drawing.Color.Red;
                    lblmsg.Text = "Error!!";
                }

                
            }
            catch(Exception ex)
            {
                lblmsg.ForeColor = System.Drawing.Color.Red;
                lblmsg.Text = ex.Message;
            }
            

        }
        else
        {
            lblmsg.ForeColor=System.Drawing.Color.Red;
            lblmsg.Text=msg;
        }
    }
}