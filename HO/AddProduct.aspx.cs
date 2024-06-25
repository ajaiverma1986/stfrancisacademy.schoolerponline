using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class HO_AddProduct : System.Web.UI.Page
{
    private string url = "", PageName = "", q1 = "", q2 = "", q3 = "", filename = "", ctidquery = "", topicgridquery = "";
    private Utility objut = new Utility();
    private SqlParameter[] param = new SqlParameter[7];
    private DataUtility objdut = new DataUtility();
    private DataTable dt, dtsub, dtgrid;
    private int pid = 0, result = 0, classid = 0, subid = 0;
    private FileInfo finfoevent;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["User"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }

        if (!IsPostBack)
        {
            btnNP.Visible = true;
            btnSubmit.Text = "Submit";
            btnSubmit.ToolTip = "Click here to add this product.";
            lbltop.Text = "Product List";
            lblhead.Text = "Product List";
            div1.Visible = false;
            tbl1.Visible = true;
            divtop.Visible = false;
            ViewState["pid"] = null;
            tbl1.Visible = true;
            //fillCategory();
            Grid();
        }
    }

    [WebMethod]
    public static CountryDetails[] BindDatatoDropdown()
    {
        DataTable dt = new DataTable();
        List<CountryDetails> details = new List<CountryDetails>();

        using (SqlConnection con = new SqlConnection("Data Source=awapalsolutions;Initial Catalog=SinghStudy107;uid=sa;pwd=Oye_india"))
        {
            using (SqlCommand cmd = new SqlCommand("select cid,CategoryName from tbl_category where CategoryStatus=1", con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                foreach (DataRow dtrow in dt.Rows)
                {
                    CountryDetails country = new CountryDetails();
                    country.CountryId = Convert.ToInt32(dtrow["cid"].ToString());
                    country.CountryName = dtrow["CategoryName"].ToString();
                    details.Add(country);
                }
            }
        }
        return details.ToArray();
    }

    public class CountryDetails
    {
        public int CountryId { get; set; }

        public string CountryName { get; set; }
    }

    protected void Grid()
    {
        dtgrid = CommonClass.ABC("GetAllProduct");
        if (dtgrid.Rows.Count > 0)
        {
            Grid_Country.DataSource = dtgrid;
            Grid_Country.DataBind();
        }
        else
        {
            Grid_Country.EmptyDataText = "No product added yet.";
            Grid_Country.DataSource = null;
            Grid_Country.DataBind();
        }
    }

    protected void fillCategory()
    {
        if (CommonClass.ABC("GetAllCategory").Rows.Count > 0)
        {
            ddlCategory.DataSource = CommonClass.ABC("GetAllCategory");
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "cid";
            ddlCategory.DataBind();
            ListItem li = new ListItem("--Select Category--", "0");
            ddlCategory.Items.Insert(0, li);
            ddlSubCate.Items.Insert(0, new ListItem("--Select SubCategory--", "0"));
        }
        else
        {
            // Utility.ViewAlertMessage(this.Master.Page, "There is no category added. Please add categories first.");
            ListItem li = new ListItem("--Select Category--", "0");
            ddlCategory.Items.Insert(0, li);
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        pid = Convert.ToInt16(objdut.GetScalar("select isnull(max(pid),0)+1 from Product_Master"));
        if (ViewState["pid"] == null)
        {
            param[0] = new SqlParameter("@pid", 0);
        }
        else
        {
            param[0] = new SqlParameter("@pid", Convert.ToInt32(ViewState["pid"]));
        }
        param[1] = new SqlParameter("@categoryid", ddlCategory.SelectedValue);
        param[2] = new SqlParameter("@subcategoryid", ddlSubCate.SelectedValue);
        param[3] = new SqlParameter("@pname", txtPName.Text.Trim());
        param[4] = new SqlParameter("@pcode", txtPcode.Text.Trim());
        if (cbactive.Checked == true)
        {
            param[5] = new SqlParameter("@status", 1);
        }
        else
        {
            param[5] = new SqlParameter("@status", 0);
        }
        param[6] = new SqlParameter("@intresult", 0);
        param[6].Direction = ParameterDirection.Output;
        result = objdut.ExecuteSqlSP(param, "usp_addProduct");
        btnNP.Visible = true;
        if (result == 1)
        {
            if (ViewState["pid"] == null)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Product added successfully.");
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "Product details updated successfully.");
                ViewState["pid"] = null;
            }
            reset();
            tbl1.Visible = true;
            div1.Visible = false;
            Grid();
            lbltop.Text = "Product List";
            lblhead.Text = "Product List";
            btnSubmit.Text = "Submit";
            btnSubmit.ToolTip = "Click here to add this product.";
            return;
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "There was a problem adding the product!");
            reset();
            tbl1.Visible = true;
            div1.Visible = false;
            lbltop.Text = "Product List";
            lblhead.Text = "Product List";
            btnSubmit.Text = "Submit";
            btnSubmit.ToolTip = "Click here to add this product.";
            return;
        }
    }

    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlSubCate.Items.Clear();
        if (ddlCategory.SelectedValue != "0")
        {
            dtsub = CommonClass.ABC1("GetAllsubcatinsinglecat", Convert.ToInt32(ddlCategory.SelectedValue));
            if (dtsub.Rows.Count > 0)
            {
                ddlSubCate.DataSource = dtsub;
                ddlSubCate.DataTextField = "SubCategoryName";
                ddlSubCate.DataValueField = "SCID";
                ddlSubCate.DataBind();
                ddlSubCate.Items.Insert(0, new ListItem("--Select SubCategory--", "0"));
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "There is no subcategory added against selected category.");
                ddlSubCate.Items.Insert(0, new ListItem("--Select SubCategory--", "0"));
                return;
            }
        }
        else
        {
            ddlSubCate.Items.Insert(0, new ListItem("--Select SubCategory--", "0"));
            return;
        }
    }

    private void GenerateThumbnails(double scaleFactor, Stream sourcePath, string targetPath)
    {
        using (var image = System.Drawing.Image.FromStream(sourcePath))
        {
            var newWidth = (int)(image.Width * scaleFactor);
            var newHeight = (int)(image.Height * scaleFactor);
            var thumbnailImg = new Bitmap(newWidth, newHeight);
            var thumbGraph = Graphics.FromImage(thumbnailImg);
            thumbGraph.CompositingQuality = CompositingQuality.HighQuality;
            thumbGraph.SmoothingMode = SmoothingMode.HighQuality;
            thumbGraph.InterpolationMode = InterpolationMode.HighQualityBicubic;
            var imageRectangle = new Rectangle(0, 0, newWidth, newHeight);
            thumbGraph.DrawImage(image, imageRectangle);
            thumbnailImg.Save(targetPath, image.RawFormat);
        }
    }

    protected void Grid_Country_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        pid = Convert.ToInt32(e.CommandArgument);
        ViewState["pid"] = pid;
        if (e.CommandName == "edit0")
        {
            btnNP.Visible = false;
            divtop.Visible = false;
            grd1.DataSource = null;
            grd1.DataBind();
            tbl1.Visible = false;
            div1.Visible = true;
            btnSubmit.Text = "Update";
            btnSubmit.ToolTip = "Click here to update this product.";
            lbltop.Text = "Update Product";
            lblhead.Text = "Update Product";
            q3 = "Select * from Product_Master where pid=" + pid;
            dt = objdut.GetDataTable(q3);
            if (dt.Rows.Count > 0)
            {
                ddlCategory.Items.Clear();
                ddlSubCate.Items.Clear();
                fillCategory();
                ddlCategory.SelectedValue = dt.Rows[0]["cid"].ToString();
                q1 = "select SCID,SubCategoryName from tbl_SubCategory where SubCategoryStatus=1 and CID=" + ddlCategory.SelectedValue;
                dtsub = objdut.GetDataTable(q1);
                if (dtsub.Rows.Count > 0)
                {
                    ddlSubCate.DataSource = dtsub;
                    ddlSubCate.DataTextField = "SubCategoryName";
                    ddlSubCate.DataValueField = "SCID";
                    ddlSubCate.DataBind();
                    ddlSubCate.Items.Insert(0, new ListItem("--Select SubCategory--", "0"));
                }
                ddlSubCate.SelectedValue = dt.Rows[0]["scid"].ToString();

                txtPcode.Text = dt.Rows[0]["pcode"].ToString();
                txtPName.Text = dt.Rows[0]["pname"].ToString();
                if (Convert.ToInt32(dt.Rows[0]["status"]) == 1)
                {
                    cbactive.Checked = true;
                }
                else
                {
                    cbactive.Checked = false;
                }
                dtgrid = ShowTopics(Convert.ToInt32(ddlSubCate.SelectedValue));
                if (dtgrid.Rows.Count > 0)
                {
                    divtop.Visible = true;
                    grd1.DataSource = dtgrid;
                    grd1.DataBind();
                }
                else
                {
                    divtop.Visible = false;
                    grd1.DataSource = null;
                    grd1.DataBind();
                }
                dtgrid.Dispose();
            }
        }
    }

    protected void reset()
    {
        ddlCategory.Items.Clear();
        ddlSubCate.Items.Clear();
        fillCategory();
        //txtnop.Text = "";
        txtPcode.Text = "";
        txtPName.Text = "";
        cbactive.Checked = false;
    }

    protected void btnNP_Click(object sender, EventArgs e)
    {
        ViewState["pic"] = null;
        div1.Visible = true;
        tbl1.Visible = false;
        ViewState["pid"] = null;
        lblhead.Text = "Add Product";
        lbltop.Text = "Add Product";
        reset();
        divtop.Visible = false;
        grd1.DataSource = null;
        grd1.DataBind();
        btnNP.Visible = false;
        //imgstu.ImageUrl = null;
    }

    protected void ddlSubCate_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSubCate.SelectedValue != "0")
        {
            dt = ShowTopics(Convert.ToInt32(ddlSubCate.SelectedValue));
            if (dt.Rows.Count > 0)
            {
                divtop.Visible = true;
                grd1.DataSource = dt;
                grd1.DataBind();
            }
            else
            {
                divtop.Visible = false;
                grd1.DataSource = null;
                grd1.DataBind();
            }
            dt.Dispose();
        }
        else
        {
            divtop.Visible = false;
            grd1.DataSource = null;
            grd1.DataBind();
        }
    }

    protected DataTable ShowTopics(int sbid)
    {
        ctidquery = "select classid,subid from tbl_SubCategory where scid=" + sbid;
        dt = objdut.GetDataTable(ctidquery);
        classid = Convert.ToInt32(dt.Rows[0]["classid"].ToString());
        subid = Convert.ToInt32(dt.Rows[0]["subid"].ToString());
        dt.Dispose();
        topicgridquery = "select topicname from topic_master where status=1 and classid=" + classid + " and subjid=" + subid + "";
        dtgrid = objdut.GetDataTable(topicgridquery);
        return dtgrid;
    }

    protected void chk1_CheckedChanged(object sender, EventArgs e)
    {
        txtPName.Text = "";
        foreach (GridViewRow gvrow in grd1.Rows)
        {
            CheckBox txtfee = (CheckBox)gvrow.FindControl("chk1");
            if (txtfee.Checked)
            {
                Label Course = ((Label)(gvrow.FindControl("lblcourse"))) as Label;
                txtPName.Text = txtPName.Text + "," + Course.Text;
            }
        }
        if (txtPName.Text != "") txtPName.Text = txtPName.Text.Remove(0, 1);
    }
}