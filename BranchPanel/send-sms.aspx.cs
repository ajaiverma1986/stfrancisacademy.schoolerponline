using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
public partial class BranchPanel_send_sms : System.Web.UI.Page
{
    DataTable dt3;
    DataUtility Objdut = new DataUtility();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillcourse();
        }
    }

    private void fillcourse()
    {
        ddlclass.DataSource = CommonClass.ABC("classdll");
        ddlclass.DataTextField = "Classname";
        ddlclass.DataValueField = "ID";
        ddlclass.DataBind();
        ListItem li = new ListItem("--Select Class--", "0");
        ddlclass.Items.Insert(0, li);
        dt3 = Objdut.GetDataTable("select courseid,coursename from course_master where status=1");
        if (dt3.Rows.Count > 0)
        {
            ddlcourse.DataSource = dt3;
            ddlcourse.DataValueField = "courseid";
            ddlcourse.DataTextField = "coursename";
            ddlcourse.DataBind();
            ddlcourse.Items.Insert(0, new ListItem("--select Course--", "0"));
        }
    }
    protected void Button5_Click(object sender, EventArgs e)
    {
        if (RadioButtonList2.SelectedIndex == 0)
        {
            divmsg.Visible = true;
            divradio.Visible = false;
            divclass.Visible = true;
            divcourse.Visible = false;
            Button1.Visible = true;
            Button5.Visible = false;
            Button2.Visible = true;
        }
        else if (RadioButtonList2.SelectedIndex == 1)
        {
            divmsg.Visible = true;
            divradio.Visible = false;
            divclass.Visible = false;
            divcourse.Visible = true;
            Button1.Visible = true;
            Button5.Visible = false;
            Button2.Visible = true;
        }

        else
        {
            divmsg.Visible = false;
            a.Visible = true;
            lblmsg.Text = "please select one";
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        txtmsg.Text = "";
        divmsg.Visible = false;
        a.Visible = false;
        RadioButtonList2.ClearSelection();
        divcourse.Visible = false;
        ddlclass.SelectedIndex = 0;
        ddlcourse.SelectedIndex = 0;
        divradio.Visible = true;
        divclass.Visible = false;
        Button1.Visible = false;
        Button5.Visible = true;
        Button2.Visible = false;
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        string a2;
        string a3;
        string q1 = "";
        DataTable dty;
        string url = "~/BranchPanel/send-sms.aspx";
        int status = Convert.ToInt32(Objdut.GetScalar("select isactive from tbl_smspermission where url='" + url + "'"));
        if (ddlclass.SelectedIndex > 0)
        {
            q1 = ("select mobile,name from tbl_enquiry where classid=" + ddlclass.SelectedValue + " and status!=5");
            dty = Objdut.GetDataTable(q1);
            if (status == 1)
            {
                if (dty.Rows.Count > 0)
                {
                    for (int count = 0; count < dty.Rows.Count; count++)
                    {
                        a2 = dty.Rows[count]["mobile"].ToString();
                        a3 = dty.Rows[count]["name"].ToString();
                        sendMessageToMobile.SMSSend(a2.ToString(), "GICI", txtmsg.Text);
                    }
                    Utility.ViewAlertMessage(this.Master.Page, "sms sent!");
                    txtmsg.Text = "";
                    ddlclass.SelectedIndex = 0;
                }

              else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Sms not sent!");
                    return;
                }
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "you have no permission for sending sms.");
                return;
            }
        }

        if (ddlcourse.SelectedIndex > 0)
        {
            q1 = ("select mobile,name from tbl_enquiry where courseid=" + ddlcourse.SelectedValue + " and status!=5");
            dty = Objdut.GetDataTable(q1);

            if (status == 1)
            {
                if (dty.Rows.Count > 0)
                {
                    for (int count = 0; count < dty.Rows.Count; count++)
                    {
                        a2 = dty.Rows[count]["mobile"].ToString();
                        a3 = dty.Rows[count]["name"].ToString();
                        sendMessageToMobile.SMSSend(a2.ToString(), "GICI", txtmsg.Text);
                    }
                    Utility.ViewAlertMessage(this.Master.Page, "sms sent!");
                    txtmsg.Text = "";
                    ddlcourse.SelectedIndex = 0;
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Sms not sent!");
                    return;
                }
            }

            else
            {

            }

        }
    }
}

    

  
    
