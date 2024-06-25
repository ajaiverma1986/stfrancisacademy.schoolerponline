using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Services;
using System.IO;
using System.Web.UI.WebControls;
using System.Web;
using ClosedXML.Excel;

public partial class BranchPanel_Fee_Management_StudentHostel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static studentregistration2[] BindGridByJs(string Mode)
    {
        DataSet ds = new DataSet();
        List<studentregistration2> details = new List<studentregistration2>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[SP_GetAllHostelStudent]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[1];
               
                param[0] = new SqlParameter("@Brid", HttpContext.Current.Session["BrBrid"].ToString());                
                cmd.Parameters.Add(param[0]);              
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        HttpContext.Current.Session["ALLHOSTELSTUDENT"] = ds.Tables[0];

                        DataUtility Objdut = new DataUtility();
                        foreach (DataRow dtrow in ds.Tables[0].Rows)
                        {
                            studentregistration2 user = new studentregistration2();
                            user.StuRegNo = dtrow["StuRegNo"].ToString();
                            user.Fyid = dtrow["Fyid"].ToString();
                            user.Registration_No = dtrow["Registration_No"].ToString();
                            user.AdmissionNo = dtrow["AdmissionNo"].ToString();
                            user.studentFname = dtrow["studentFname"].ToString();
                            user.studentMname = dtrow["studentMname"].ToString();
                            user.studentLname = dtrow["studentLname"].ToString();
                            user.ClassID = dtrow["ClassID"].ToString();
                            user.SectionID = dtrow["SectionID"].ToString();
                            user.Classname = (string)(Objdut.GetScalar("Select ISNULL(Classname,'') from Class_Master where id=" + dtrow["ClassID"].ToString() + ""));
                            user.fatherFname = dtrow["PrimaryParentFirstName"].ToString();
                            user.fatherMname = dtrow["PrimaryParentMiddleName"].ToString();
                            user.fatherLname = dtrow["PrimaryParentLastName"].ToString();
                            user.HostelName = dtrow["HostelName"].ToString();
                            user.Sectionname = (string)(Objdut.GetScalar("Select ISNULL(sectionname,'') from classwithsection where cwsid=" + dtrow["SectionID"].ToString() + ""));
                            user.DOB = Convert.ToDateTime(dtrow["StudentDOB"]).ToString("dd MMM yyyy");
                            user.TotalFee = "0";
                            user.PaidFee = "0";
                            user.BalFee = "0";
                            if (user.BalFee.ToString() == "0.00")
                            {
                                user.PayStatus = "Paid";
                            }
                            else
                            {
                                user.PayStatus = "Unpaid";
                            }
                            details.Add(user);
                        }
                    }
                }
            }
        }
        return details.ToArray();
    }
    public class studentregistration2
    {
        public string HostelName { get; set; }
        public string PayAmtID { get; set; }
        public string DueDate { get; set; }
        public string PayID { get; set; }
        public string Fyid { get; set; }
        public string AdmissionDate { get; set; }
        public string AdmissionNo { get; set; }
        public string RefAdmNo { get; set; }
        public string RID { get; set; }
        public string StuRegNo { get; set; }
        public string RegistrationDate { get; set; }
        public string Registration_No { get; set; }
        public string studentFname { get; set; }
        public string studentMname { get; set; }
        public string studentLname { get; set; }
        public string StudentUID { get; set; }
        public string Classname { get; set; }
        public string ClassID { get; set; }
        public string SectionID { get; set; }
        public string Sectionname { get; set; }
        public string DOB { get; set; }
        public string Status { get; set; }
        public string FeeAmount { get; set; }
        public string fatherFname { get; set; }
        public string fatherMname { get; set; }
        public string fatherLname { get; set; }
        public string PrimaryMobileNo { get; set; }
        public string PrimarySelectParentType { get; set; }
        public string PrimaryParentDOB { get; set; }
        public string PrimaryParentOccupation { get; set; }
        public string PrimaryEmailId { get; set; }

        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Pin { get; set; }
        public string Country { get; set; }

        public string Comment { get; set; }
        public string pagecount { get; set; }
        public string PayStatus { get; set; }
        public string Month { get; set; }
        public string TotalFee { get; set; }
        public string PaidFee { get; set; }
        public string BalFee { get; set; }

    }

    protected void CustomExcel_Click(object sender, EventArgs e)
    {
        DataUtility Objdut = new DataUtility();
        DataTable dt = new DataTable();
        DataTable dtFilter = new DataTable();
        if (HttpContext.Current.Session["ALLHOSTELSTUDENT"] != null)
        {
            dt = (DataTable)HttpContext.Current.Session["ALLHOSTELSTUDENT"];
            if (dt.Rows.Count > 0)
            {
              /*  dt.Columns.Remove("RowNumber");
                DataTable dtPermission = Objdut.GetDataTableSP("[SP_FilterCustomExcelPermission]");

                foreach (DataColumn column in dtPermission.Columns)
                {
                    dt.Columns.Remove(column.ColumnName);
                }

                dt.Columns.Add("Sl.No", typeof(System.Int32)).SetOrdinal(0);

                int i = 0;
                foreach (DataRow row in dt.Rows)
                {
                    //need to set value to NewColumn column
                    row["Sl.No"] = i + 1;   // or set it to some other value
                    i++;
                } */

                using (XLWorkbook wb = new XLWorkbook())
                {
                    wb.Worksheets.Add(dt);
                    Response.Clear();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=HostelStudentList.xlsx");
                    using (MemoryStream MyMemoryStream = new MemoryStream())
                    {
                        wb.SaveAs(MyMemoryStream);
                        MyMemoryStream.WriteTo(Response.OutputStream);
                        Response.Flush();
                        Response.End();
                    }
                }
            }
        }
    }
}