using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class BranchPanel_registrationdetails : System.Web.UI.Page
{
    private DataUtility objDUT = new DataUtility();
    public static int fyid = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fyid = CommonClass.Scaler("ActiveAcademicYear");
            fillgrid();

            DataTable dt = new DataTable();
            dt.Columns.Add("RegistrationDate");
            dt.Columns.Add("RegistrationNo");
            dt.Columns.Add("studentname");
            dt.Columns.Add("father");
            dt.Columns.Add("FMobileNo");
            dt.Columns.Add("stustatus");
            dt.Rows.Add();
            gvclasswisedetails.DataSource = dt;
            gvclasswisedetails.DataBind();
        }
    }
    private void fillgrid()
    {
        SqlParameter[] param = new SqlParameter[1];
        param[0] = new SqlParameter("@fyid", fyid);
        DataTable dt = objDUT.GetDataTableSP(param, "usp_getallregistration");
        gvdetails.DataSource = dt;
        gvdetails.DataBind();

        lbllkgfee.Text = dt.Rows[0]["totalfeeLKG"].ToString();
        lblukg.Text = dt.Rows[0]["totalfeeUKG"].ToString();
        lblifee.Text = dt.Rows[0]["totalfeeIst"].ToString();
        lbliifee.Text = dt.Rows[0]["totalfeeIInd"].ToString();
        lbliiifee.Text = dt.Rows[0]["totalfeeIIIrd"].ToString();
        lblivfee.Text = dt.Rows[0]["totalfeeIVth"].ToString();
        lblvfee.Text = dt.Rows[0]["totalfeeVth"].ToString();
        lblvifee.Text = dt.Rows[0]["totalfeeVIth"].ToString();
        lblviifee.Text = dt.Rows[0]["totalfeeVIIth"].ToString();
        lblviiifee.Text = dt.Rows[0]["totalfeeVIIIth"].ToString();
        lblixfee.Text = dt.Rows[0]["totalfeeIXth"].ToString();
        lblxfee.Text = dt.Rows[0]["totalfeeXth"].ToString();
        lblxifee.Text = dt.Rows[0]["totalfeeXIth"].ToString();
        lblxiifee.Text = dt.Rows[0]["totalfeeXIIth"].ToString();
        lbltotalfee.Text = dt.Rows[0]["Totalfee"].ToString();

        dt.Dispose();

        dt = objDUT.GetDataTable("select FYID, FYName from financial_Year");
        ddlfy.DataSource = dt;
        ddlfy.DataValueField = "FYID";
        ddlfy.DataTextField = "FYName";
        ddlfy.DataBind();
        ddlfy.Items.Insert(0, new ListItem(" -Session- ", ""));
        ddlfy.SelectedValue = fyid.ToString();
    }

    [WebMethod] //Get All class data with fee
    public static getclassfee[] gettotalregistration(string fyid)
    {
        DataSet ds = new DataSet();
        List<getclassfee> details = new List<getclassfee>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_getallregistration]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@fyid", fyid);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getclassfee user = new getclassfee();
                        user.LKG = dtrow["LKG"].ToString();
                        user.UKG = dtrow["UKG"].ToString();
                        user.I = dtrow["Ist"].ToString();
                        user.II = dtrow["IInd"].ToString();
                        user.III = dtrow["IIIrd"].ToString();
                        user.IV = dtrow["IVth"].ToString();
                        user.V = dtrow["Vth"].ToString();
                        user.VI = dtrow["VIth"].ToString();
                        user.VII = dtrow["VIIth"].ToString();
                        user.VIII = dtrow["VIIIth"].ToString();
                        user.IX = dtrow["IXth"].ToString();
                        user.X = dtrow["Xth"].ToString();
                        user.XI = dtrow["XIth"].ToString();
                        user.XII = dtrow["XIIth"].ToString();

                        user.totalstudent = dtrow["totalstudent"].ToString();

                        user.LKGfee = dtrow["totalfeeLKG"].ToString();
                        user.UKGfee = dtrow["totalfeeUKG"].ToString();
                        user.Ifee = dtrow["totalfeeIst"].ToString();
                        user.IIfee = dtrow["totalfeeIInd"].ToString();
                        user.IIIfee = dtrow["totalfeeIIIrd"].ToString();
                        user.IVfee = dtrow["totalfeeIVth"].ToString();
                        user.Vfee = dtrow["totalfeeVth"].ToString();
                        user.VIfee = dtrow["totalfeeVIth"].ToString();
                        user.VIIfee = dtrow["totalfeeVIIth"].ToString();
                        user.VIIIfee = dtrow["totalfeeVIIIth"].ToString();
                        user.IXfee = dtrow["totalfeeIXth"].ToString();
                        user.Xfee = dtrow["totalfeeXth"].ToString();
                        user.XIfee = dtrow["totalfeeXIth"].ToString();
                        user.XIIfee = dtrow["totalfeeXIIth"].ToString();
                        user.totalfee = dtrow["Totalfee"].ToString();

                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getclassfee
    {
        public string LKG { get; set; }

        public string UKG { get; set; }

        public string I { get; set; }

        public string II { get; set; }

        public string III { get; set; }

        public string IV { get; set; }

        public string V { get; set; }

        public string VI { get; set; }

        public string VII { get; set; }

        public string VIII { get; set; }

        public string IX { get; set; }

        public string X { get; set; }

        public string XI { get; set; }

        public string XII { get; set; }

        public string totalstudent { get; set; }

        public string LKGfee { get; set; }

        public string UKGfee { get; set; }

        public string Ifee { get; set; }

        public string IIfee { get; set; }

        public string IIIfee { get; set; }

        public string IVfee { get; set; }

        public string Vfee { get; set; }

        public string VIfee { get; set; }

        public string VIIfee { get; set; }

        public string VIIIfee { get; set; }

        public string IXfee { get; set; }

        public string Xfee { get; set; }

        public string XIfee { get; set; }

        public string XIIfee { get; set; }

        public string totalfee { get; set; }
    }

    [WebMethod] // Get only A class data which is seleted by first table
    public static getclassdata[] getclasswisedata(string classid, string status)
    {
        DataSet ds = new DataSet();
        List<getclassdata> details = new List<getclassdata>();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("[usp_getallregistration]", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@classid", classid);
                cmd.Parameters.AddWithValue("@mode", 1);
                cmd.Parameters.AddWithValue("@status", status);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dtrow in ds.Tables[0].Rows)
                    {
                        getclassdata user = new getclassdata();
                        user.RegistrationDate = dtrow["RegistrationDate"].ToString();
                        user.RegistrationNo = dtrow["RegistrationNo"].ToString();
                        user.studentname = dtrow["studentname"].ToString();
                        user.father = dtrow["father"].ToString();
                        user.FMobileNo = dtrow["FMobileNo"].ToString();
                        user.stustatus = dtrow["stustatus"].ToString();
                        details.Add(user);
                    }
                }
            }
        }
        return details.ToArray();
    }

    public class getclassdata
    {
        public string RegistrationDate { get; set; }

        public string RegistrationNo { get; set; }

        public string studentname { get; set; }

        public string father { get; set; }

        public string FMobileNo { get; set; }

        public string stustatus { get; set; }
    }
}