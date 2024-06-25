using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class BranchPanel_Parentsinfo : System.Web.UI.Page
{
    private string url, q = "";
    private DataTable dt;
    private DataUtility objdut = new DataUtility();
    private CommonClass commonobj = new CommonClass();
    private int regid1;
    private SqlParameter[] param;
    private FileInfo finfoevent;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();

        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!IsPostBack)
        {
            int x = Convert.ToInt32(objdut.GetScalar("select fyid from tbl_admission where adid=" + Session["stue"]));
            ViewState["fyid"] = x;
            int id = Convert.ToInt32(Session["stue"]);
            showdetail(id);
            DropDownList2.Visible = false;
            l3.Visible = false;
        }
    }

    public void showdetail(int id)
    {
        int idStudent = id;
        string query = "Select *,tm.ADNO,tm.adid,tm.classid from student_master sm inner join tbl_Admission tm on sm.sturegno=tm.sturegno where tm.adid=" + idStudent + " and tm.brid=" + Convert.ToInt32(Session["BrBrid"]) + " and tm.fyid=" + Convert.ToInt32(ViewState["fyid"]);
        SqlDataReader dr = objdut.GetDataReader(query);
        dr.Read();
        if (dr.HasRows)
        {
            txtFFname.Text = dr["FfirstName"].ToString();
            txtFMname.Text = dr["FMiddleName"].ToString();
            txtFLname.Text = dr["FLastName"].ToString();

            if ((dr["FDateOfBirth"].ToString() == "Jan  1 1900 12:00AM"))
            {
                txtDate.Text = "";
            }
            else
            {
                txtDate.Text = dr["FDateOfBirth"].ToString();
            }
            txtFNation.Text = dr["FNationality"].ToString();
            if (string.IsNullOrEmpty(dr["FQualification"].ToString()))
            {
                ddlQualifiaction1.SelectedValue = "0";
            }
            else
            {
                ddlQualifiaction1.SelectedItem.Text = dr["FQualification"].ToString();
            }
            txtFOccup.Text = dr["FOccupation"].ToString();
            txtFDesig.Text = dr["FDesignation"].ToString();
            txtFON.Text = dr["FNameOfOrganisation"].ToString();
            txtAddressF.Text = dr["FBusinessAddress"].ToString();
            txtFPhone.Text = dr["FPhoneNo"].ToString();
            txtFMobile.Text = dr["FMobileNo"].ToString();
            txtFEmailid.Text = dr["FEmail"].ToString();
            if (dr["UploadFatherPhoto"].ToString() != "")
            {
                imgFather.ImageUrl = "~/FatherPhoto/" + dr["UploadFatherPhoto"].ToString();
                // lblFather.Text = dr["UploadFatherPhoto"].ToString();
                //ViewState["FPhoto"] = lblFather.Text;
            }
            else
            {
                ViewState["FPhoto"] = null;
                lblFather.Text = "";
            }
            //imgstu.ImageUrl = "~/FatherPhoto/" + dr["UploadFatherPhoto"].ToString();
            //------------Mother------------//
            txtMFname.Text = dr["MFirstName"].ToString();
            txtMMname.Text = dr["MmiddleName"].ToString();
            txtMLname.Text = dr["MLastName"].ToString();

            if ((dr["MDateOfBirth"].ToString() == "Jan  1 1900 12:00AM"))
            {
                txtMDOB.Text = "";
            }
            else
            {
                txtMDOB.Text = dr["MDateOfBirth"].ToString();
            }
            txtMNation.Text = dr["MNationality"].ToString();
            // DropDownList1.SelectedItem.Text = dr["MQualification"].ToString();

            if (string.IsNullOrEmpty(dr["MQualification"].ToString()))
            {
                DropDownList1.SelectedValue = "0";
            }
            else
            {
                DropDownList1.SelectedItem.Text = dr["MQualification"].ToString();
            }

            txtMOccup.Text = dr["MOccupation"].ToString();
            txtMDesig.Text = dr["MDesignation"].ToString();
            txtMON.Text = dr["MNameOfOrganisation"].ToString();
            txtAddressM.Text = dr["MBusinessAddress"].ToString();
            txtMPhone.Text = dr["MPhoneNo"].ToString();
            txtMMobile.Text = dr["MMobileNo"].ToString();
            txtMEmailid.Text = dr["MEmail"].ToString();
            if (dr["UploadMotherPhoto"].ToString() != "")
            {
                imgMother.ImageUrl = "~/MotherPhoto/" + dr["UploadMotherPhoto"].ToString();
                //lblmother.Text = dr["UploadMotherPhoto"].ToString();
                //ViewState["MPhoto"] = lblmother.Text;
            }
            else
            {
                ViewState["MPhoto"] = null;
                lblmother.Text = "";
            }

            //-----------guardian-------------//
            if (dr["LfirstName"].ToString() != "")
            {
                TextBox1.Visible = true;
                l1.Visible = true;
                TextBox1.Text = dr["LfirstName"].ToString();
            }
            else
            {
                TextBox1.Visible = false;
                l1.Visible = false;
            }
            if (dr["LMiddleName"].ToString() != "")
            {
                txtmidnameg.Visible = true;
                txtmidnameg.Text = dr["LMiddleName"].ToString();
            }
            else
            {
                txtmidnameg.Visible = false;
                l1.Visible = false;
            }
            if (dr["LLastName"].ToString() != "")
            {
                txtlastg.Visible = true;
                txtlastg.Text = dr["LLastName"].ToString();
            }
            else
            {
                txtlastg.Visible = false;
                l1.Visible = false;
            }
            if (dr["LNationality"].ToString() != "")
            {
                l2.Visible = true;
                TextBox3.Visible = true;
                TextBox3.Text = dr["LNationality"].ToString();
            }
            else
            {
                TextBox3.Visible = false;
                l2.Visible = false;
            }
            if (dr["LQualificationID"].ToString() != "0")
            {
                DropDownList2.Visible = true;
                l3.Visible = true;
                DropDownList2.SelectedValue = dr["LQualificationID"].ToString();
            }
            else
            {
                DropDownList2.Visible = false;
                l3.Visible = false;
            }
            if (dr["LOccupation"].ToString() != "")
            {
                TextBox4.Visible = true;
                l4.Visible = true;
                TextBox4.Text = dr["LOccupation"].ToString();
            }
            else
            {
                TextBox4.Visible = false;
                l4.Visible = false;
            }
            if (dr["LDesignation"].ToString() != "")
            {
                TextBox5.Visible = true;
                l5.Visible = true;
                TextBox5.Text = dr["LDesignation"].ToString();
            }
            else
            {
                TextBox5.Visible = false;
                l5.Visible = false;
            }
            if (dr["LNameOfOrganisation"].ToString() != "")
            {
                TextBox6.Visible = true;
                l6.Visible = true;
                TextBox6.Text = dr["LNameOfOrganisation"].ToString();
            }
            else
            {
                TextBox6.Visible = false;
                l6.Visible = false;
            }
            if (dr["LBusinessAddress"].ToString() != "")
            {
                TextBox7.Visible = true;
                l7.Visible = true;
                TextBox7.Text = dr["LBusinessAddress"].ToString();
            }
            else
            {
                TextBox7.Visible = false;
                l7.Visible = false;
            }
            if (dr["LPhoneNo"].ToString() != "")
            {
                TextBox8.Visible = true;
                l8.Visible = true;
                TextBox8.Text = dr["LPhoneNo"].ToString();
            }
            else
            {
                TextBox8.Visible = false;
                l8.Visible = false;
            }
            if (dr["LMobileNo"].ToString() != "")
            {
                txtGISD.Visible = true;
                TextBox9.Visible = true;
                l9.Visible = true;
                TextBox9.Text = dr["LMobileNo"].ToString();
            }
            else
            {
                txtGISD.Visible = false;
                TextBox9.Visible = false;
                l9.Visible = false;
            }
            if (dr["LEmail"].ToString() != "")
            {
                l10.Visible = true;
                TextBox10.Visible = true;
                TextBox10.Text = dr["LEmail"].ToString();
            }
            else
            {
                TextBox10.Visible = false;
                l10.Visible = false;
            }
            //imgstu.ImageUrl = "~/StudentPhoto/" + dr["UploadChildPhoto"].ToString();
            //imgstu.ImageUrl = "~/FatherPhoto/" + dr["UploadFatherPhoto"].ToString();
            //imgstu.ImageUrl = "~/MotherPhoto/" + dr["UploadMotherPhoto"].ToString();
            dr.Close();
        }
    }

    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        if (CheckBox1.Checked)
        {
            l1.Visible = true; l2.Visible = true; l3.Visible = true; l4.Visible = true; l5.Visible = true; l6.Visible = true;
            l7.Visible = true; l8.Visible = true; l9.Visible = true; l10.Visible = true;
            TextBox1.Visible = true;
            TextBox3.Visible = true;
            TextBox4.Visible = true;
            TextBox5.Visible = true;
            TextBox6.Visible = true;
            TextBox7.Visible = true;
            TextBox8.Visible = true;
            TextBox9.Visible = true;
            TextBox10.Visible = true;
            txtmidnameg.Visible = true;
            txtlastg.Visible = true;
            DropDownList2.Visible = true;
            txtGISD.Visible = true;
        }
        else
        {
            ClearGuardian();
        }
    }

    protected void ClearGuardian()
    {
        l1.Visible = false;
        l2.Visible = false;
        l3.Visible = false;
        l4.Visible = false;
        l5.Visible = false;
        l6.Visible = false;
        l7.Visible = false;
        l8.Visible = false;
        l9.Visible = false;
        l10.Visible = false;
        TextBox1.Visible = false;
        TextBox3.Visible = false;
        TextBox4.Visible = false;
        TextBox5.Visible = false;
        TextBox6.Visible = false;
        TextBox7.Visible = false;
        TextBox8.Visible = false;
        TextBox9.Visible = false;
        TextBox10.Visible = false;
        txtmidnameg.Visible = false;
        txtlastg.Visible = false;
        DropDownList2.Visible = false;
        txtGISD.Visible = false;
    }

    protected void btnupdate_Click(object sender, EventArgs e)
    {
        int idStudent = Convert.ToInt32(Session["stue"]);
        string brusername = (string)Session["Brusername"];
        int brID = Convert.ToInt32(Session["BrBrid"]);
        string pname = "usp_updateAdmission";
        SqlParameter[] param = new SqlParameter[46];
        //----------student Father's Details----------//
        param[0] = new SqlParameter("@FfirstName", txtFFname.Text.Trim());
        param[1] = new SqlParameter("@FMiddleName", txtFMname.Text.Trim());
        param[2] = new SqlParameter("@FLastName", txtFLname.Text.Trim());
        param[3] = new SqlParameter("@FDateOfBirth", "1-1-1990");
        param[4] = new SqlParameter("@FNationality", txtFNation.Text.Trim());
        param[5] = new SqlParameter("@FQualification", ddlQualifiaction1.SelectedItem.Text.Trim());
        param[6] = new SqlParameter("@FOccupation", txtFOccup.Text.Trim());
        param[7] = new SqlParameter("@FDesignation", txtFDesig.Text.Trim());
        param[8] = new SqlParameter("@FNameOfOrganisation", txtFON.Text.Trim());
        param[9] = new SqlParameter("@FBusinessAddress", txtAddressF.Text.Trim());

        if (fuFather1.HasFile)
        {
            string fileexe = Path.GetExtension(fuFather1.FileName);
            if (fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".gif")
            {
                if (ViewState["FPhoto"] != null)
                {
                    File.Delete(Server.MapPath("../FatherPhoto/" + ViewState["FPhoto"].ToString()));
                    finfoevent = new FileInfo(ViewState["FPhoto"].ToString());
                    finfoevent.Delete();
                }
                string filename = Path.GetFileName(fuFather1.PostedFile.FileName);
                string path = Server.MapPath("../FatherPhoto/");
                fuFather1.SaveAs(Server.MapPath("../FatherPhoto/" + idStudent + filename));
                param[10] = new SqlParameter("@UploadFatherPhoto", idStudent + filename);
            }
            else
            {
                param[10] = new SqlParameter("@UploadFatherPhoto", lblFather.Text);
            }
        }
        else
        {
            param[10] = new SqlParameter("@UploadFatherPhoto", lblFather.Text);
        }
        param[11] = new SqlParameter("@FPhoneNo", txtFPhone.Text.Trim());
        param[12] = new SqlParameter("@FMobileNo", txtFMobile.Text.Trim());
        param[13] = new SqlParameter("@FEmail", txtFEmailid.Text.Trim());
        //-----------Mother Details-----------//

        param[14] = new SqlParameter("@MfirstName", txtMFname.Text.Trim());
        param[15] = new SqlParameter("@MMiddleName", txtMMname.Text.Trim());
        param[16] = new SqlParameter("@MLastName", txtMLname.Text.Trim());
        param[17] = new SqlParameter("@MDateOfBirth", "1-1-1990");
        param[18] = new SqlParameter("@MNationality", txtMNation.Text.Trim());
        param[19] = new SqlParameter("@MQualification", DropDownList1.SelectedItem.Text.Trim());
        param[20] = new SqlParameter("@MOccupation", txtMOccup.Text.Trim());
        param[21] = new SqlParameter("@MDesignation", txtMDesig.Text.Trim());
        param[22] = new SqlParameter("@MNameOfOrganisation", txtMON.Text.Trim());
        param[23] = new SqlParameter("@MBusinessAddress", txtAddressM.Text.Trim());
        param[24] = new SqlParameter("@MPhoneNo", txtMPhone.Text.Trim());
        param[25] = new SqlParameter("@MMobileNo", txtMMobile.Text.Trim());
        if (FileUpload1.HasFile)
        {
            string fileexe = Path.GetExtension(FileUpload1.FileName);
            if (fileexe == ".jpg" || fileexe == ".jpeg" || fileexe == ".png" || fileexe == ".gif")
            {
                if (ViewState["MPhoto"] != null)
                {
                    File.Delete(Server.MapPath("../MotherPhoto/" + ViewState["MPhoto"].ToString()));
                    finfoevent = new FileInfo(ViewState["MPhoto"].ToString());
                    finfoevent.Delete();
                }
                string filename = Path.GetFileName(FileUpload1.PostedFile.FileName);
                string path = Server.MapPath("../MotherPhoto/");
                FileUpload1.SaveAs(Server.MapPath("../MotherPhoto/" + idStudent + filename));
                param[26] = new SqlParameter("@UploadMotherPhoto", idStudent + filename);
            }
            else
            {
                param[26] = new SqlParameter("@UploadMotherPhoto", lblmother.Text);
            }
        }
        else
        {
            param[26] = new SqlParameter("@UploadMotherPhoto", lblmother.Text);
        }

        param[31] = new SqlParameter("@MEmail", txtMEmailid.Text.Trim());

        //-------Guardian Details---------//
        param[27] = new SqlParameter("@LfirstName", TextBox1.Text.Trim());
        param[28] = new SqlParameter("@LMiddleName", txtmidnameg.Text.Trim());
        param[29] = new SqlParameter("@LLastName", txtlastg.Text);
        param[30] = new SqlParameter("@LDateOfBirth", "1-1-1990");
        param[31] = new SqlParameter("@LNationality", TextBox3.Text.Trim());
        param[32] = new SqlParameter("@LQualification", DropDownList2.SelectedItem.Text.Trim());
        param[33] = new SqlParameter("@LOccupation", TextBox4.Text.Trim());
        param[34] = new SqlParameter("@LDesignation", TextBox5.Text.Trim());
        param[35] = new SqlParameter("@LNameOfOrganisation", TextBox6.Text.Trim());
        param[36] = new SqlParameter("@LBusinessAddress", TextBox7.Text.Trim());
        param[37] = new SqlParameter("@LPhoneNo", TextBox8.Text.Trim());
        param[38] = new SqlParameter("@LMobileNo", TextBox9.Text.Trim());
        param[39] = new SqlParameter("@LEmail", TextBox10.Text.Trim());
        param[40] = new SqlParameter("@mode", "updateparent");
        param[41] = new SqlParameter("@brid", brID);
        param[42] = new SqlParameter("@fyid", Convert.ToInt32(ViewState["fyid"]));
        param[43] = new SqlParameter("@adid", idStudent);
        param[44] = new SqlParameter("@branchname", brusername);
        param[45] = new SqlParameter("@intResult", Convert.ToInt32("0"));
        param[45].Direction = ParameterDirection.Output;

        int count = objdut.ExecuteSqlSP(param, pname);
        if (count == 1)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Updated successfully.");
            Response.Redirect("Parentsinfo.aspx");
        }
    }
}