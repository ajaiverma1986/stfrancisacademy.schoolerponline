using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;

public partial class EmployeePanel_studentFeeDeposite : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
         
    }
    protected void btnFeeDetails_Click(object sender, EventArgs e)
    {
        try
        {
            Service ser = new Service();
            XmlDocument xmdoc = new XmlDocument();
            xmdoc.LoadXml(ser.BindFeeDetails(txtStdregis.Text.ToString()));
            DataSet dsCameraDetails = new DataSet();
            XmlNodeReader xmlreader = new XmlNodeReader(xmdoc);
            dsCameraDetails.ReadXml(xmlreader, XmlReadMode.Auto);
            GridView1.DataSource = dsCameraDetails;
            GridView1.DataBind();// Bind the DataSet to Grid that will display all xml data.
        }
        catch (Exception ex)
        {
            //handle exception here…
        }
    }
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chk = (CheckBox)sender;
        GridViewRow gr = (GridViewRow)chk.Parent.Parent;
        //lblmsg.Text = GridView1.DataKeys[gr.RowIndex].Value.ToString();

        //lblmsg.Text = "Hello";
    } 
}