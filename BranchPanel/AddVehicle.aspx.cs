using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class Transport_AddVehicle : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    private DataUtility objdut = new DataUtility();
    private Utility objut = new Utility();
    private SqlParameter[] param;
    private static int academicyear_id = 0;
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
    private SqlCommand cmd = new SqlCommand();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lbl1.Text = "Add Vehicle";
            lbladdvehicle.Text = "Add Vehicle";

            fildll();
            // FillDLL1();
            //FillDLL2();
            academicyear_id = Convert.ToInt32(objdut.GetScalar("select isnull(fyid,0) as fyid from financial_year where isactive=1 and isclosed=0"));
            ViewState["fy"] = academicyear_id;
            if (Request.QueryString.Count > 0)
            {
                int bsid = Convert.ToInt32(Session["idbus"]);
                ViewState["bsinewid"] = bsid;
                fillbusinfo();
                lbl1.Text = "Update Vehicle";
                lbladdvehicle.Text = "Update Vehicle";
            }

            Session["update"] = Server.UrlEncode(System.DateTime.Now.ToString());

            //if (Request.QueryString.Count > 0)
            //{
            //    int studentid = Convert.ToInt32(Request.QueryString[0]);
            //    fill1(studentid);
            //}
        }
    }

    private void fillbusinfo()
    {
        Button2.Visible = true;
        Button1.Visible = false;
        string query = @"SELECT  registrationno,chesisno,modelno,noofseats ,make,insuranceCompanyName
 ,insuranceno,CONVERT(varchar(13), NextFCDate,106) as NextFCDate ,CONVERT(varchar(13), NextTaxdate,106) as  NextTaxdate,contactno,document,CONVERT(varchar(13),nextinsurancedate,106) as nextinsurancedate
  FROM tbl_vehicleinfo where id=" + ViewState["bsinewid"] + "  and branchid=" + Session["BrBrid"] + " and   fyid=" + ViewState["fy"];
        SqlDataReader dr = objdut.GetDataReader(query);
        if (dr.HasRows)
        {
            dr.Read();
            //txtBusNo.Text = dr["BusNo"].ToString();
            txtRegNo.Text = dr["registrationno"].ToString();
            //ddl_Busroot.SelectedValue = dr["conveyanceid"].ToString();
            // txtxdrivername.Text = dr["Drivername"].ToString();
            //txtCondctr.Text = dr["conducterName"].ToString();
            //txtkilomtr.Text = dr["travelperday"].ToString();
            txtChassisNo.Text = dr["chesisno"].ToString();
            txtModel.Text = dr["modelno"].ToString();
            txtNumOfSeat.Text = dr["noofseats"].ToString();
            txtmake.Text = dr["make"].ToString();
            txtIncCmpny.Text = dr["insuranceCompanyName"].ToString();
            txtInsurenceNum.Text = dr["insuranceno"].ToString();
            txtDate.Text = dr["NextFCDate"].ToString();
            txtToDate.Text = dr["NextTaxdate"].ToString();
            txtCnctNum.Text = dr["contactno"].ToString();
            //txtCnctPersn.Text = dr["contactPerson"].ToString();
            lblfile.Text = dr["document"].ToString();

            txtMDOB.Text = dr["nextinsurancedate"].ToString();
            btnAdd.Text = "Update";
        }
        dr.Close();
    }

    protected void fildll()
    {
    }

    public string dob(string d)
    {
        if (d != "")
        {
        }
        return "01/01/1900  0:00:00.999";
    }

    protected void btSave_Click(object sender, EventArgs e)
    {
        {
            try
            {
                if (btnAdd.Text != "Update")
                {
                    saveRecods(0, "addbusinfo");
                }
                else
                {
                    saveRecods(0, "updatebusinfo");
                }
            }
            catch (Exception ex)
            {
            }
        }
    }

    protected void saveRecods(int id, string mode)
    {
        param = new SqlParameter[25];
        //Session["Mid"] = objdut.GetScalar("select max(id) from tbl_admission");
        param[0] = new SqlParameter("@mode", mode);
        param[1] = new SqlParameter("@drivername", "n/a");

        param[2] = new SqlParameter("@busno", "");
        param[3] = new SqlParameter("@busroot", "");
        param[4] = new SqlParameter("@conveyanceid", 1);
        param[5] = new SqlParameter("@noofseats", txtNumOfSeat.Text.Trim());
        param[6] = new SqlParameter("@chesisno", txtChassisNo.Text.Trim());
        param[7] = new SqlParameter("@modelno", txtModel.Text.Trim());
        param[8] = new SqlParameter("@insuranceno", txtInsurenceNum.Text.Trim());
        param[9] = new SqlParameter("@insuranceCompanyName", txtIncCmpny.Text.Trim());
        param[10] = new SqlParameter("@contactperson", "");
        param[11] = new SqlParameter("@contactno", txtCnctNum.Text.Trim());
        param[12] = new SqlParameter("@conductername", "n/a");

        if (FileUpload1.HasFile)
        {
            string filename = Path.GetFileName(FileUpload1.PostedFile.FileName);
            FileUpload1.SaveAs(Server.MapPath("~/vehicledocuments/" + filename));
            param[13] = new SqlParameter("@attchfile", filename);
        }
        else
        {
            param[13] = new SqlParameter("@attchfile", "");
        }

        param[14] = new SqlParameter("@registrationNo", txtRegNo.Text.Trim());
        param[15] = new SqlParameter("@make", txtmake.Text.Trim());
        param[16] = new SqlParameter("@nextfcdate", txtToDate.Text.Trim());
        param[17] = new SqlParameter("@nexttaxdate", txtDate.Text.Trim());

        param[18] = new SqlParameter("@intResult", Convert.ToInt32("0"));

        param[18].Direction = ParameterDirection.Output;
        param[19] = new SqlParameter("@travelperday", "");

        if (mode == "addbusinfo")
        {
            param[20] = new SqlParameter("@id", Convert.ToInt32("0"));
        }
        else
        {
            param[20] = new SqlParameter("@id", Convert.ToInt32(ViewState["bsinewid"]));
        }

        param[21] = new SqlParameter("@nextinsurancedate", txtMDOB.Text.Trim());

        param[22] = new SqlParameter("@availseats", txtNumOfSeat.Text.Trim());
        param[23] = new SqlParameter("@branchid", Session["BrBrid"]);
        param[24] = new SqlParameter("@fyid", ViewState["fy"]);
        int ret = objdut.ExecuteSqlSP(param, "usp_vehicleinfo");

        if (ret > 0)
        {
            //mdpSuccess.Show();

            if (btnAdd.Text == "Submit")
            {
                Utility.ViewAlertMessage(this.Master.Page, "Successfully added information");
                reset();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "updated successfully");
                reset();
            }
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "Error");
        }
    }

    protected void reset()
    {
        // txtkilomtr.Text = "";
        txtmake.Text = "";
        txtModel.Text = "";
        txtToDate.Text = "";
        txtDate.Text = "";
        //txtBusNo.Text = "";
        txtChassisNo.Text = "";
        txtCnctNum.Text = "";

        txtIncCmpny.Text = "";
        //txtIncDoc.Value = "";
        txtInsurenceNum.Text = "";
        txtModel.Text = "";
        txtNumOfSeat.Text = "";
        // ddl_Busroot.SelectedIndex = -1;
        //txtNextInsurenceDate.Text = "";
        //txtTaxDate.Text = "";
        txtRegNo.Text = "";
        lblfile.Text = "";
        txtMDOB.Text = "";
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        reset();
    }

    protected void txtRegNo_TextChanged(object sender, EventArgs e)
    {
        int q = Convert.ToInt32(objdut.GetScalar(" select COUNT(registrationno) from tbl_vehicleinfo where registrationno='" + txtRegNo.Text + "'"));

        if (q >= 1)
        {
            txtRegNo.Text = "";
            Utility.ViewAlertMessage(this.Master.Page, "This Bus Already Registered!");
            return;
        }
    }

    protected void btnaddvehicle_Click(object sender, EventArgs e)
    {
        txtmake.Text = "";
        txtModel.Text = "";
        txtToDate.Text = "";
        txtDate.Text = "";
        //txtBusNo.Text = "";
        txtChassisNo.Text = "";
        txtCnctNum.Text = "";

        txtIncCmpny.Text = "";
        //txtIncDoc.Value = "";
        txtInsurenceNum.Text = "";
        txtModel.Text = "";
        txtNumOfSeat.Text = "";
        // ddl_Busroot.SelectedIndex = -1;
        //txtNextInsurenceDate.Text = "";
        //txtTaxDate.Text = "";
        txtRegNo.Text = "";
        lblfile.Text = "";
        txtMDOB.Text = "";
        lblfile.Text = "";
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("VehicleReport.aspx");
    }
}