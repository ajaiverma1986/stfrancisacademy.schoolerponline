using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Services;
using System.IO;
using System.Web.UI.WebControls;
public partial class BranchPanel_StudentManagement_student_discount_details : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private DataTable Dt;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static studentregistration[] BindGridByJs()
    {
        DataSet ds = new DataSet();
        List<studentregistration> details = new List<studentregistration>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_studentdiscountlist]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter[] param = new SqlParameter[3];
                param[0] = new SqlParameter("@mode", 4);
                param[1] = new SqlParameter("@Brid", System.Web.HttpContext.Current.Session["BrBrid"].ToString());
                param[2] = new SqlParameter("@Sturegno", System.Web.HttpContext.Current.Session["StuRegNo"].ToString());
                cmd.Parameters.Add(param[0]);
                cmd.Parameters.Add(param[1]);
                cmd.Parameters.Add(param[2]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dtrow in ds.Tables[0].Rows)
                        {
                            studentregistration user = new studentregistration();
                            user.DSID = dtrow["DSID"].ToString();
                            user.DiscountCode = dtrow["DiscountCode"].ToString();
                            user.RegistrationNo = dtrow["Registration_No"].ToString();
                            user.StudentName = dtrow["studentname"].ToString();
                            user.ApplyClass = dtrow["Classname"].ToString();
                            user.ParentName = dtrow["parentname"].ToString();
                            user.Parentmobile = dtrow["PMobileNo"].ToString();
                            user.Comment_Remark = dtrow["CommentORRemark"].ToString();
                            user.IsDiscountImplemented = dtrow["IsDiscountImplemented"].ToString();
                            details.Add(user);
                        }
                    }
                }
            }
        }
        return details.ToArray();
    }
    public class studentregistration
    {
        public string DSID { get; set; }
        public string DiscountCode { get; set; }
        public string RegistrationNo { get; set; }
        public string StudentName { get; set; }
        public string ApplyClass { get; set; }
        public string ParentName { get; set; }
        public string Parentmobile { get; set; }
        public string Discount { get; set; }
        public string Comment_Remark { get; set; }
        public string IsDiscountImplemented { get; set; }



    }
}