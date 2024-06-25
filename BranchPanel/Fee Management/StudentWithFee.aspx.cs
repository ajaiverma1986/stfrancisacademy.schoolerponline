using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_Fee_Management_StudentWithFee : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        fillfyear();
    }
    private CommonClass CommonClass = new CommonClass();
    public void fillfyear()
    {
        DataTable Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);
        ddlfinancialyear.Enabled = false;
    }

    [WebMethod]
    public static GetOverDueFeeDetails[] BindGrid(string ClassId,string sectionId)
    {
        CommonClass CClass = new CommonClass();
        int ActiveFinancialyear = CClass.GetActiveAcedmicYear();
        List<GetOverDueFeeDetails> Details = new List<GetOverDueFeeDetails>();
        DataTable dt = new DataTable();
        DataUtility objdut = new DataUtility();
        string query = "select distinct t.StuRegno,c.Classname,cs.sectionname,isnull(r.StudentFirstName,'')+' '+ isnull(r.StudentMiddleName,'')+' '+isnull(r.StudentLastName,'') as Name,t.Fee " +
            " , isnull(r.PrimaryParentFirstName, '')+' ' + isnull(r.PrimaryParentMiddleName, '') + ' ' + isnull(r.PrimaryParentLastName, '') as ParentName,r.PrimaryMobileNo " +
            " from(select StuRegno, sum(Amount) as Fee from Receipt_master where PaymentDate between '2019-01-01' and '2020-03-31'  group by StuRegno) t " +
            " inner join tbl_StudentMaster m on t.StuRegno = m.SturegNo " +
            " inner join Class_Master c on m.Classid=c.id inner join classwithsection cs on m.sectionid=cs.cwsid " +
            " inner join tbl_StudentRegistration r on m.Registration_No = r.Registration_No where m.BrId=" + Convert.ToString(HttpContext.Current.Session["Brbrid"])+ " and r.FyId="+Convert.ToString(ActiveFinancialyear);
        if (!String.IsNullOrWhiteSpace(ClassId)  && Convert.ToString(ClassId) != "0")
        {
            query = query + " and m.Classid=" + Convert.ToString(ClassId);
        }
        if (!String.IsNullOrWhiteSpace(sectionId)  && Convert.ToString(sectionId) != "0")
        {
            query = query + " and m.sectionId=" + Convert.ToString(sectionId);
        }


        dt = objdut.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow Dtrow in dt.Rows)
            {
                GetOverDueFeeDetails user = new GetOverDueFeeDetails();

                user.Name = Dtrow["Name"].ToString();
                user.Mobile = Dtrow["PrimaryMobileNo"].ToString();
                user.Sturegno = Dtrow["Sturegno"].ToString();
                user.Parent = Dtrow["ParentName"].ToString();
                user.classes = Dtrow["Classname"].ToString();
                user.section = Dtrow["sectionname"].ToString();
                user.Amount = Dtrow["Fee"].ToString();

                Details.Add(user);
            }
        }
        return Details.ToArray();
    }

    public class GetOverDueFeeDetails
    {

        public string Name { get; set; }
        public string Mobile { get; set; }
        public string Sturegno { get; set; }
        public string Parent { get; set; }
        public string classes { get; set; }
        public string section { get; set; }
        public string Amount { get; set; }
    }
}