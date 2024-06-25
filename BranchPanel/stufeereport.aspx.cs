using System;
using System.Data;
using System.Web.UI.WebControls;

public partial class BranchPanel_stufeereport : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private Utility objUT = new Utility();
    private string PageName = "", url = "", srt;
    private long loginID;
    private BLL objUserBLL = new BLL();
    private decimal amount;
    private int branchID, brID, adid;
    private double result, amount1, Payableamount;
    private DataUtility objDUT = new DataUtility();
    private static int academiyr = 0;
    private DataTable dt;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();

        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!IsPostBack)
        {
            Table4.Visible = false;
            ViewState["acad"] = CommonClass.Scaler("ActiveAcademicYear");
            goforsearch.Visible = false;
            datalistdiv.Visible = false;
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (txtMemId.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please enter Student Id.");
            Table4.Visible = false;
            gridreport.Visible = false;
            lbltotalamn.Visible = false;

            return;
        }
        else if (txtMemId.Text != "")
        {
            string count1 = "select count(1) from tbl_Admission where adno='" + txtMemId.Text.Trim() + "' and fyid=" + ViewState["acad"] + " and brid=" + Session["BrBrid"];
            int cou;
            cou = Convert.ToInt32(objdut.GetScalar(count1));
            if (cou == 0)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Please enter valid Student Id.");
                Table4.Visible = false;
                gridreport.Visible = false;
                txtMemId.Text = "";
                return;
            }
            else
            {
                Table4.Visible = true;
                Session["adnon"] = txtMemId.Text.Trim();
                long loginID = objUT.GetAdmissionno(txtMemId.Text.Trim());
                Session["Adid"] = loginID;
                binddetail();
                dt = CommonClass.recentfee("stufeereport", loginID);
                if (dt.Rows.Count > 0)
                {
                    gridreport.DataSource = dt;
                    gridreport.DataBind();
                    gridreport.Visible = true;
                    Table2.Visible = true;
                    datalistdiv.Visible = false;
                    lbltotalamn.Text = "Total Amount = " + Convert.ToString(ViewState["lblrece"]);
                    lbltotalamn.Visible = true;
                    divsearchtext.Visible = false;
                    goforsearch.Visible = true;
                    binddatalist5(txtMemId.Text.Trim());
                    dataliststudent.Visible = true;
                }
                else
                {
                    gridreport.EmptyDataText = "No Record Found .";
                    gridreport.DataBind();
                    Table2.Visible = false;
                }
            }
        }
    }

    public void binddetail()
    {
        int trtype = Convert.ToInt16(objdut.GetScalar("select isnull(transportaion,0) from tbl_Admission where adid=" + Session["Adid"] + " and fyid=" + ViewState["acad"]));
        if (trtype == 1)
        {
            srt = "select isnull(sum(credit),0) as credit from tbl_Admission_student_Account where studentid=" + Session["Adid"] + "and  academicyearid=" + ViewState["acad"];
        }
        else
        {
            srt = "select isnull(sum(credit),0) as credit from tbl_Admission_student_Account where studentid=" + Session["Adid"] + "and  academicyearid=" + ViewState["acad"] + " and transtype!='Monthly-Transport Fee'";
        }
        double cou;
        cou = Convert.ToDouble(objdut.GetScalar(srt));
        lblTotal.Text = cou.ToString("0.00");
        string srt1 = "select isnull(sum(payfee),0) as payfee from Payfee_master where Studentid=" + Session["Adid"] + "and  fyid=" + ViewState["acad"];
        double cou1;
        cou1 = Convert.ToDouble(objdut.GetScalar(srt1));
        lblReceived.Text = cou1.ToString("0.00");
        ViewState["lblrece"] = lblReceived.Text;
        double a = cou;
        double b = cou1;
        double c = a - b;
        lblremain.Text = c.ToString("0.00");
    }

    public void binddatalist(string searchvalue)
    {
        BEL.branchid = Convert.ToInt16(Session["BrBrid"]);
        BEL.searchvalue = searchvalue;
        dt = objUserBLL.binddatalist();
        if (dt.Rows.Count > 0)
        {
            DataList2.DataSource = dt;
            DataList2.DataBind();
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "No record found.");
            return;
        }
    }

    protected void btnserach_Click(object sender, EventArgs e)
    {
        if (txtbookid.Text != "")
        {
            binddatalist(txtbookid.Text.Trim());
            datalistdiv.Visible = true;
            Table2.Visible = false;
            Table4.Visible = false;
            txtMemId.Text = "";
            divsearchtext.Visible = false;
            goforsearch.Visible = true;
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "The textbox cannot be empty.");
            return;
        }
    }

    protected void DataList2_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "edito")
        {
            string adno11 = e.CommandArgument.ToString();

            string count1 = "select count(1) from tbl_Admission where adno='" + adno11 + "' and fyid=" + ViewState["acad"] + " and brid=" + Session["BrBrid"];
            int cou;
            cou = Convert.ToInt32(objdut.GetScalar(count1));
            if (cou == 0)
            {
                Utility.ViewAlertMessage(this.Master.Page, "Please enter valid Student Id.");
                Table4.Visible = false;
                gridreport.Visible = false;
                txtMemId.Text = "";
                return;
            }
            else
            {
                Table4.Visible = true;
                long loginID = objUT.GetAdmissionno(adno11);

                binddetail();

                //int regno = Convert.ToInt32(CommonClass.zxy("getregno", Convert.ToInt32(Session["BrBrid"]), loginID));
                string regno = Convert.ToString(objdut.GetScalar("select sturegno from tbl_Admission where adid=" + loginID));
                //string srt11 = CommonClass.zxy("", Convert.ToInt32(Session["BrBrid"]), loginID);
                string srt11 = Convert.ToString(objdut.GetScalar("select (firstname+' '+MiddleName+' '+LastName) as name from student_master where sturegno=" + regno));
                dt = CommonClass.recentfee("stufeereport", loginID);
                if (dt.Rows.Count > 0)
                {
                    gridreport.DataSource = dt;
                    gridreport.DataBind();
                    gridreport.Visible = true;
                    Table2.Visible = true;
                    datalistdiv.Visible = false;
                    lbltotalamn.Text = "Total Amount = " + Convert.ToString(ViewState["lblrece"]);
                    binddatalist5(adno11);
                    divsearchtext.Visible = false;
                    goforsearch.Visible = true;
                    lbltotalamn.Visible = true;
                    dataliststudent.Visible = true;
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "Dues since admission time!!");
                    return;
                }
            }
        }
    }

    public void binddatalist5(string searchvalue)
    {
        BEL.branchid = Convert.ToInt16(Session["BrBrid"]);
        BEL.searchvalue = searchvalue;
        dt = objUserBLL.binddatalist5();
        if (dt.Rows.Count > 0)
        {
            dataliststudent.DataSource = dt;
            dataliststudent.DataBind();
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "No record found.");
            return;
        }
        dt.Clear();
    }

    protected void dataliststudent_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label nextmonth = (Label)e.Item.FindControl("lblnextmonth");
            Label lbadno = (Label)e.Item.FindControl("Label4");

            int studentid = Convert.ToInt32(objdut.GetScalar("select adid from tbl_admission where adno='" + lbadno.Text + "' and brid=" + Session["BrBrid"]));
            int paytype = Convert.ToInt32(CommonClass.Scaler("getPaytype", Convert.ToInt32(Session["BrBrid"]), studentid));
            int srt1 = Convert.ToInt32(CommonClass.Scaler("gettoppaymonth", Convert.ToInt32(Session["BrBrid"]), studentid));
            DataTable srt2 = CommonClass.recentfee("getpaydate", Convert.ToInt32(Session["BrBrid"]), srt1, studentid);
            string month;
            DateTime now = DateTime.Now;
            if (paytype == 2)
            {
                now = Convert.ToDateTime(srt2.Rows[0]["paydate"].ToString());
                month = Convert.ToString(now.AddMonths(1));
                nextmonth.Text = month;
                nextmonth.Text = (Convert.ToDateTime(month).ToString)("dd-MM-yyyy");
            }
            if (paytype == 1)
            {
                now = Convert.ToDateTime(srt2.Rows[0]["paydate"].ToString());
                month = Convert.ToString(now.AddMonths(3));
                nextmonth.Text = month;
                nextmonth.Text = (Convert.ToDateTime(month).ToString)("dd-MM-yyyy");
            }
        }
    }

    protected void goforsearch_Click(object sender, EventArgs e)
    {
        divsearchtext.Visible = true;
        datalistdiv.Visible = false;
        gridreport.Visible = false;
        Table4.Visible = false;
        dataliststudent.Visible = false;
        lbltotalamn.Visible = false;
        goforsearch.Visible = false;
        txtMemId.Text = "";
        txtbookid.Text = "";
    }

    protected void lnk_Click(object sender, EventArgs e)
    {
        stutype.Visible = true;
        lnk.Visible = false;
    }

    protected void btnserach_Click1(object sender, EventArgs e)
    {
        stutype.Visible = false;
        lnk.Visible = true;
        txtbookid.Text = "";
    }

    protected void gridreport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbl = (Label)e.Row.FindControl("lbldatetr");
            Label lbl1 = (Label)e.Row.FindControl("lbldateee");

            if (lbl1.Text == "Cash")
            {
                lbl1.ForeColor = System.Drawing.Color.Green;
            }

            if (lbl1.Text == "Cheque")
            {
                lbl1.ForeColor = System.Drawing.Color.Red;
            }

            if (lbl.Text == "Once-Admission Fee")
            {
                lbl.ForeColor = System.Drawing.Color.Blue;
            }
            else if (lbl.Text == "Half Yearly-Examination Fee")
            {
                lbl.ForeColor = System.Drawing.Color.Green;
            }
            else if (lbl.Text == "Quarterly-Development Charges")
            {
                lbl.ForeColor = System.Drawing.Color.MediumVioletRed;
            }
            else if (lbl.Text == "Monthly-Tution Fee")
            {
                lbl.ForeColor = System.Drawing.Color.OliveDrab;
            }
            else if (lbl.Text == "Monthly-Transport Fee")
            {
                lbl.ForeColor = System.Drawing.Color.DarkOrange;
            }
        }
    }
}