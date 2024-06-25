using System;
using System.Data;
using System.Data.SqlClient;

using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BranchPanel_EmployeeList : System.Web.UI.Page
{
    private Utility objUT = new Utility();
    private DataUtility objdut = new DataUtility();
    private string query, query1 = "", url, PageName;
    private DataTable dt, dtt;
    private int count = 0, idemployee = 0;
    private int eid = 0;
    private int totalpage = 0, active = 0;
    private DateTime StartDate;

    protected void Page_Load(object sender, EventArgs e)
    {
        url = Request.Url.ToString();
        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        PageName = Utility.GetCurrentPagename();
        //if (!objUT.isAccessible(((User)Session["BrUser"]).UserID, PageName))
        //{
        //    // Response.Redirect("~/Login.aspx");
        //}
        if (!IsPostBack)
        {
            Session.Remove("empidkhan");
            lblBranch.Text = Session["Brusername"].ToString();
            query = @"select eid,branchname,(fname+' '+Lname) as employeename,CONVERT(varchar(13),dateofjoining,106) as joindate,
                      department,mobile, (case photo when '' then '~/images/9update.png' else ('~/branchpanel/employee/EmpDocument/'+photo) end ) as photo,
                      (case oem.hostatus when (esm.StatusId) then (esm.StatusName)  end) as status
                      from OfficeEmployee_Master oem left outer join tbl_employeestatusmaster esm on oem.hostatus=esm.StatusId where esm.statusname='working' or esm.statusname='ON LEAVE' or oem.hostatus=0 and oem.status=1 and brid=" + Convert.ToInt16(Session["BrBrid"]) + " order by oem.fname ";
            ViewState["query"] = query;
            fillGrid(query);
            //FIllStatus();
            Textbox1.Enabled = false;
            ddlempstatus.Items.Clear();
            ddlempstatus.Items.Insert(0, new ListItem("Select Item", "0"));
            ViewState["noofrecord"] = 50;
            ViewState["qu"] = query;
            ViewState["PageNo"] = 1;
            ViewState["sortby"] = "eid";
            setpage();
            ddlempstatus.Enabled = false;
            active = Counting(1);
            lblcounting.Text = "Total number of Active Employees :";
            lcount.Text = Convert.ToString(active);
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("AddEmployee.aspx");
    }

    protected void fillGrid(string query)
    {
        dt = objdut.GetDataTable(query);
        if (dt.Rows.Count > 0)
        {
            gvDetails.DataSource = dt;
            ViewState["dt"] = dt;
            gvDetails.DataBind();
        }
        else
        {
            gvDetails.EmptyDataText = "No employee added yet.";
            gvDetails.DataSource = null;
            gvDetails.DataBind();
        }
    }

    protected int Counting(int status)
    {
        string quco = "";
        if (status != 0)
        {
            quco = "select COUNT(eid) from OfficeEmployee_Master oem inner join tbl_EmployeeStatusMaster esm on oem.hostatus=esm.StatusId where oem.brid=" + Convert.ToInt16(Session["BrBrid"]) + " and oem.status=1 and esm.Isactive=1 and oem.hostatus=" + status + " ";
        }
        else
        {
            quco = "select COUNT(eid) from OfficeEmployee_Master where brid=" + Convert.ToInt16(Session["BrBrid"]) + " and status=1";
        }

        int cou = Convert.ToInt32(objdut.GetScalar(quco));
        return cou;
    }

    protected int depCount(int deptid)
    {
        string quco1 = "";
        quco1 = "select COUNT(eid) from OfficeEmployee_Master where brid=" + Convert.ToInt16(Session["BrBrid"]) + " and status=1 and depId=" + deptid;
        int cou = Convert.ToInt32(objdut.GetScalar(quco1));
        return cou;
    }

    protected int descount(int desigid)
    {
        string quco1 = "";
        quco1 = "select COUNT(eid) from OfficeEmployee_Master where brid=" + Convert.ToInt16(Session["BrBrid"]) + " and status=1 and desigId=" + desigid;
        int cou = Convert.ToInt32(objdut.GetScalar(quco1));
        return cou;
    }

    protected int datCount(DateTime dateofjoining)
    {
        string qo = "";
        qo = "select COUNT(eid) from OfficeEmployee_Master where brid=" + Convert.ToInt16(Session["BrBrid"]) + " and status=1 and convert(date,dateofjoining)=cast('" + dateofjoining + "' as datetime)";
        int co = Convert.ToInt32(objdut.GetScalar(qo));
        return co;
    }

    protected void gvDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        idemployee = Convert.ToInt16(e.CommandArgument);
        if (e.CommandName == "Update1")
        {
            Response.Redirect("viewdetails.aspx?eid=" + idemployee);
        }
        else if (e.CommandName == "emppofile")
        {
            Session["empidkhan"] = idemployee;
            //Response.Redirect("viewprofile.aspx");
            Response.Redirect("viewdetails.aspx");
        }

        if (e.CommandName == "delete")
        {
            GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            int e1 = Convert.ToInt32(e.CommandArgument);

            //LinkButton lbtn = (LinkButton)gvDetails.FindControl("lnkdel");

            //if (lbtn.Text == "working")
            //{
            string query1 = "Update OfficeEmployee_Master set status=0 where eid=" + e1;
            string query2 = "Update Employee_login set status=0 where eid=" + e1;
            int res = objdut.ExecuteSql(query1);
            if (res == 1)
            {
                int res1 = objdut.ExecuteSql(query2);
                if (res1 == 1)
                {
                }

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Message", "alert('Employee has been deleted successfully.')", true);
                fillGrid(ViewState["qu"].ToString());
                return;
            }
            //}
        }
    }

    protected void FIllStatus()
    {
        string que = "select statusname,statusid from tbl_EmployeeStatusMaster where Isactive=1";
        DataTable dtddl = objdut.GetDataTable(que);
        if (dtddl.Rows.Count > 0)
        {
            ddlempstatus.DataSource = dtddl;
            ddlempstatus.DataTextField = "statusname";
            ddlempstatus.DataValueField = "statusid";
            ddlempstatus.DataBind();
            ddlempstatus.Items.Insert(0, new ListItem("Select Status", "0"));
            ddlempstatus.Items.Insert(1, new ListItem("All", "6"));
        }
        else
        {
            ddlempstatus.Items.Insert(0, new ListItem("Select Status", "0"));
        }
    }

    private void fillgrid2(int pagesize, int currentpage, string sortby, int cid, int bid, string value)
    {
        SqlParameter[] param3 = new SqlParameter[7];
        param3[0] = new SqlParameter("@PageSize", pagesize);
        param3[1] = new SqlParameter("@CurrentPage", currentpage);
        param3[2] = new SqlParameter("@SortExpression", sortby);
        param3[3] = new SqlParameter("@searchid", cid);
        param3[4] = new SqlParameter("@courseid", bid);
        param3[5] = new SqlParameter("@value", value);
        param3[6] = new SqlParameter("@brid", Convert.ToInt16(Session["BrBrid"]));

        dtt = objdut.GetDataTableSP(param3, "employeesearch");
        if (dtt.Rows.Count > 0)
        {
            gvDetails.DataSource = dtt;
            gvDetails.DataBind();
        }
        else
        {
            Utility.ViewAlertMessage(this.Master.Page, "No record Found!");
            return;
        }
    }

    private void setpage()
    {
        query = "select Count(*) from OfficeEmployee_Master where brid=" + Convert.ToInt16(Session["BrBrid"]);
        int i = 0;
        PageNo.Items.Clear();
        PageNo.Items.Insert(i, Convert.ToString("Page No"));
        totalpage = Convert.ToInt32(objdut.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(objdut.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
        {
            //  totalpage = totalpage + 1;
        }
        else
        {
            totalpage = totalpage + 1;
        }
        for (int page = 1; totalpage > 0; totalpage = totalpage - 1)
        {
            PageNo.Items.Insert(page, Convert.ToString(page));
            page = page + 1;
        }
        if (Convert.ToInt32(ViewState["PageNo"]) > totalpage)
        {
            ViewState["PageNo"] = 1;
        }
    }

    protected void ddlRecordperPage_SelectedIndexChanged(object sender, EventArgs e)
    {
        Textbox1.Text = "";
        ddlsearchoption.SelectedIndex = 0;
        ddlempstatus.SelectedIndex = 0;
        if (ddlRecordperPage.SelectedValue != "0")
        {
            ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            if (ddlsearchoption.SelectedIndex > 0 || ddlempstatus.SelectedIndex > 0)
            {
                setpage();
                fillgrid2(Convert.ToInt32(ddlRecordperPage.SelectedItem.Text), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Convert.ToInt32(ddlempstatus.SelectedValue), "");
            }
            // fillgrid(Convert.ToInt32(ddlRecordperPage.SelectedItem.Text), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Convert.ToInt32(ddlEnquirySource.SelectedValue), "");
            else
            {
                fillgrid2(Convert.ToInt32(ddlRecordperPage.SelectedItem.Text), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), 0, 0, "");
            }
            //ViewState["noofrecord"] = ddlRecordperPage.SelectedItem.Text;
            //setpage();
            //fillgrid2(Convert.ToInt32(ddlRecordperPage.SelectedItem.Text), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), 0, 0, "");
        }
        active = Counting(1);
        lblcounting.Text = "Total number of Active Employees :";
        lcount.Text = Convert.ToString(active);
    }

    protected void ddlsearchoption_SelectedIndexChanged(object sender, EventArgs e)
    {
        Textbox1.Text = "";
        ddlempstatus.Items.Clear();
        if (ddlsearchoption.SelectedIndex != 0)
        {
            if (ddlsearchoption.SelectedIndex < 3)
            {
                Textbox1.Focus();
                Textbox1.Enabled = true;
                ddlempstatus.Enabled = false;
                ddlempstatus.Items.Insert(0, new ListItem("Select Item", "0"));
            }
            else
            {
                Textbox1.Enabled = false;
                ddlempstatus.Enabled = true;
                if (ddlsearchoption.SelectedIndex == 3)
                {
                    bindEmpStatus(3);
                }
                else if (ddlsearchoption.SelectedIndex == 4)
                {
                    bindEmpStatus(4);
                }
                else
                {
                    bindEmpStatus(5);
                }
            }
        }
        else
        {
            ddlempstatus.Items.Clear();
            ddlempstatus.Items.Insert(0, new ListItem("Select Item", "0"));
            ddlempstatus.Enabled = false;
            Textbox1.Enabled = false;
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (ddlsearchoption.SelectedIndex == 0)
        {
            if (ddlempstatus.SelectedValue == "0")
            {
                PageNo.Items.Clear();
                PageNo.Items.Insert(0, new ListItem("page No", "0"));
                string q1 = ViewState["query"].ToString();
                DataTable dto = objdut.GetDataTable(q1);
                if (dto.Rows.Count > 0)
                {
                    gvDetails.DataSource = dto;
                    gvDetails.DataBind();
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "No record found!");
                    gvDetails.DataSource = null;
                    gvDetails.DataBind();
                }
                active = Counting(1);
                lblcounting.Text = "Total number of Active Employees :";
                lcount.Text = Convert.ToString(active);
            }
        }
        else if (ddlsearchoption.SelectedIndex == 1)
        {
            string q2 = @"select eid,branchname,(fname+' '+Lname) as employeename,CONVERT(varchar(13),dateofjoining,106) as joindate,
                      department,mobile, (case photo when '' then '~/images/9update.png' else ('~/branchpanel/employee/EmpDocument/'+photo) end ) as photo,
                      (case oem.hostatus when (esm.StatusId) then (esm.StatusName)  end) as status
                      from OfficeEmployee_Master oem left outer join tbl_employeestatusmaster esm on oem.hostatus=esm.StatusId where oem.status!=0 and brid=" + Convert.ToInt16(Session["BrBrid"]) + " and (fname+' '+Lname)='" + Textbox1.Text.Trim() + "'";
            DataTable dti = objdut.GetDataTable(q2);
            lcount.Text = Convert.ToString(dti.Rows.Count);
            if (dti.Rows.Count > 0)
            {
                gvDetails.DataSource = dti;
                gvDetails.DataBind();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No record found!");
                gvDetails.DataSource = null;
                gvDetails.DataBind();
            }
        }
        else if (ddlsearchoption.SelectedIndex == 2)
        {
            string q2 = @"select eid,branchname,(fname+' '+Lname) as employeename,CONVERT(varchar(13),dateofjoining,106) as joindate,
                      department,mobile, (case photo when '' then '~/images/9update.png' else ('~/branchpanel/employee/EmpDocument/'+photo) end ) as photo,
                      (case oem.hostatus when (esm.StatusId) then (esm.StatusName)  end) as status
                      from OfficeEmployee_Master oem left outer join tbl_employeestatusmaster esm on oem.hostatus=esm.StatusId where oem.status!=0 and esm.statusname='working' or esm.statusname='ON LEAVE' or oem.hostatus=0 and brid=" + Convert.ToInt16(Session["BrBrid"]) + " and oem.mobile='" + Textbox1.Text.Trim() + "'";
            DataTable dti = objdut.GetDataTable(q2);
            if (dti.Rows.Count > 0)
            {
                gvDetails.DataSource = dti;
                gvDetails.DataBind();
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No record found!");
                gvDetails.DataSource = null;
                gvDetails.DataBind();
            }
        }
        else if (ddlsearchoption.SelectedIndex == 3)
        {
            if (ddlempstatus.SelectedIndex != 0)
            {
                string q1 = "";
                if (ddlempstatus.SelectedItem.Text == "All")
                {
                    q1 = @"select eid,branchname,(fname+' '+Lname) as employeename,CONVERT(varchar(13),dateofjoining,106) as joindate,
                                      department,mobile, (case photo when '' then '~/images/9update.png' else ('~/branchpanel/employee/EmpDocument/'+photo) end ) as photo,
                                      (case oem.hostatus when (esm.StatusId) then (esm.StatusName)  end) as status
                                      from OfficeEmployee_Master oem left outer join tbl_employeestatusmaster esm on oem.hostatus=esm.StatusId where oem.status!=0 and esm.statusname='working' or esm.statusname='ON LEAVE' or oem.hostatus=0 and  brid=" + Convert.ToInt16(Session["BrBrid"]) + " order by oem.fname";
                    active = Counting(0);
                    lblcounting.Text = "Total number of Employees :";
                    lcount.Text = Convert.ToString(active);
                }
                else
                {
                    q1 = @"select eid,branchname,(fname+' '+Lname) as employeename,CONVERT(varchar(13),dateofjoining,106) as joindate,
                                      department,mobile, (case photo when '' then '~/images/9update.png' else ('~/branchpanel/employee/EmpDocument/'+photo) end ) as photo,
                                      (case oem.hostatus when (esm.StatusId) then (esm.StatusName)  end) as status
                                      from OfficeEmployee_Master oem left outer join tbl_employeestatusmaster esm on oem.hostatus=esm.StatusId where brid=" + Convert.ToInt16(Session["BrBrid"]) + " and esm.statusid=" + ddlempstatus.SelectedValue + "order by oem.fname ";

                    if (ddlempstatus.SelectedItem.Text == "Working")
                    {
                        active = Counting(Convert.ToInt32(ddlempstatus.SelectedValue));
                        lblcounting.Text = "Total number of Working Employees :";
                        lcount.Text = Convert.ToString(active);
                    }
                    else if (ddlempstatus.SelectedIndex == 2)
                    {
                        active = Counting(Convert.ToInt32(ddlempstatus.SelectedValue));
                        lblcounting.Text = "Total number of Terminated Employees :";
                        lcount.Text = Convert.ToString(active);
                    }
                    if (ddlempstatus.SelectedIndex == 3)
                    {
                        active = Counting(Convert.ToInt32(ddlempstatus.SelectedValue));
                        lblcounting.Text = "Total number of Resigned Employees :";
                        lcount.Text = Convert.ToString(active);
                    }
                    if (ddlempstatus.SelectedIndex == 4)
                    {
                        active = Counting(Convert.ToInt32(ddlempstatus.SelectedValue));
                        lblcounting.Text = "Emloyees On Leave:";
                        lcount.Text = Convert.ToString(active);
                    }
                    if (ddlempstatus.SelectedIndex == 1)
                    {
                        active = Counting(Convert.ToInt32(ddlempstatus.SelectedValue));
                        lblcounting.Text = "Total number of Working Employees :";
                        lcount.Text = Convert.ToString(active);
                    }
                    if (ddlempstatus.SelectedIndex == 5)
                    {
                        active = Counting(Convert.ToInt32(ddlempstatus.SelectedValue));
                        lblcounting.Text = "Total number of Suspended Employees:";
                        lcount.Text = Convert.ToString(active);
                    }
                }
                DataTable dto = objdut.GetDataTable(q1);
                if (dto.Rows.Count > 0)
                {
                    gvDetails.DataSource = dto;
                    gvDetails.DataBind();
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "No record found!");
                    gvDetails.DataSource = null;
                    gvDetails.DataBind();
                }
            }
            else
            {
                ddlsearchoption.SelectedIndex = 0;
                Textbox1.Text = "";
                ddlempstatus.Enabled = false;
                ddlempstatus.Items.Clear();
                ddlempstatus.Items.Insert(0, new ListItem("Select Item", "0"));
                Textbox1.Enabled = false;
                fillGrid(ViewState["query"].ToString());
                active = Counting(1);
                lblcounting.Text = "Total number of Active Employees :";
                lcount.Text = Convert.ToString(active);
            }
        }
        else if (ddlsearchoption.SelectedIndex == 4)
        {
            if (ddlempstatus.SelectedIndex != 0)
            {
                string q2 = @"select eid,branchname,(fname+' '+Lname) as employeename,CONVERT(varchar(13),dateofjoining,106) as joindate,
                      department,mobile, (case photo when '' then '~/images/9update.png' else ('~/branchpanel/employee/EmpDocument/'+photo) end ) as photo,
                      (case oem.hostatus when (esm.StatusId) then (esm.StatusName)  end) as status
                      from OfficeEmployee_Master oem left outer join tbl_employeestatusmaster esm on oem.hostatus=esm.StatusId where oem.status!=0 and esm.statusname='working' or esm.statusname='ON LEAVE' or oem.hostatus=0 and brid=" + Convert.ToInt16(Session["BrBrid"]) + " and oem.depId=" + ddlempstatus.SelectedValue + "order by oem.fname ";
                DataTable dti = objdut.GetDataTable(q2);
                if (dti.Rows.Count > 0)
                {
                    gvDetails.DataSource = dti;
                    gvDetails.DataBind();
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "There are no employees in this department!!");
                    gvDetails.DataSource = null;
                    gvDetails.DataBind();
                }
                dti.Dispose();
                active = depCount(Convert.ToInt32(ddlempstatus.SelectedValue));
                lblcounting.Text = "Total number of Employees in this department :";
                lcount.Text = Convert.ToString(active);
            }
            else
            {
                ddlsearchoption.SelectedIndex = 0;
                Textbox1.Text = "";
                ddlempstatus.Enabled = false;
                Textbox1.Enabled = false;
                fillGrid(ViewState["query"].ToString());
                ddlempstatus.Items.Clear();
                ddlempstatus.Items.Insert(0, new ListItem("Select Item", "0"));
                active = Counting(1);
                lblcounting.Text = "Total number of Active Employees :";
                lcount.Text = Convert.ToString(active);
            }
        }
        else if (ddlsearchoption.SelectedIndex == 5)
        {
            if (ddlempstatus.SelectedIndex != 0)
            {
                string q2 = @"select eid,branchname,(fname+' '+Lname) as employeename,CONVERT(varchar(13),dateofjoining,106) as joindate,
                      department,mobile, (case photo when '' then '~/images/9update.png' else ('~/branchpanel/employee/EmpDocument/'+photo) end ) as photo,
                      (case oem.hostatus when (esm.StatusId) then (esm.StatusName)  end) as status
                      from OfficeEmployee_Master oem left outer join tbl_employeestatusmaster esm on oem.hostatus=esm.StatusId where oem.status!=0  and brid=" + Convert.ToInt16(Session["BrBrid"]) + " and oem.desigId=" + ddlempstatus.SelectedValue + "order by oem.fname ";
                DataTable dti = objdut.GetDataTable(q2);
                if (dti.Rows.Count > 0)
                {
                    gvDetails.DataSource = dti;
                    gvDetails.DataBind();
                }
                else
                {
                    Utility.ViewAlertMessage(this.Master.Page, "There are no employees in this designation!");
                    gvDetails.DataSource = null;
                    gvDetails.DataBind();
                }
                dti.Dispose();
                active = descount(Convert.ToInt32(ddlempstatus.SelectedValue));
                lblcounting.Text = "Total number of Employees on this designation :";
                lcount.Text = Convert.ToString(active);
            }
            else
            {
                ddlsearchoption.SelectedIndex = 0;
                Textbox1.Text = "";
                ddlempstatus.Enabled = false;
                Textbox1.Enabled = false;
                fillGrid(ViewState["query"].ToString());
                ddlempstatus.Items.Clear();
                ddlempstatus.Items.Insert(0, new ListItem("Select Item", "0"));
                active = Counting(1);
                lblcounting.Text = "Total number of Active Employees :";
                lcount.Text = Convert.ToString(active);
            }
        }
    }

    protected void PageNo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (PageNo.SelectedIndex > 0)
        {
            ViewState["PageNo"] = PageNo.SelectedItem.Text;
            if (ddlempstatus.SelectedIndex > 0)
            {
                fillgrid2(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Convert.ToInt32(ddlempstatus.SelectedValue), "");
            }
            else
            {
                fillgrid2(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearchoption.SelectedValue), 0, "");
            }
        }
        active = Counting(1);
        lblcounting.Text = "Total number of Active Employees :";
        lcount.Text = Convert.ToString(active);
    }

    protected void firstpage_Click(object sender, ImageClickEventArgs e)
    {
        //ddlempstatus.Items.Clear();
        ddlsearchoption.SelectedIndex = 0;
        //ddlempstatus.Items.Insert(0, new ListItem("Select Status", "0"));
        ddlempstatus.SelectedIndex = 0;

        Textbox1.Text = "";
        ViewState["PageNo"] = 1;
        if (PageNo.SelectedIndex >= 1)
        {
            PageNo.SelectedIndex = 1;
        }
        else
        {
            PageNo.SelectedIndex = 0;
        }

        if (Textbox1.Text != "")
        {
            fillgrid2(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Convert.ToInt32(ddlempstatus.SelectedValue), Textbox1.Text);
        }
        else
        {
            fillgrid2(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Convert.ToInt32(ddlempstatus.SelectedValue), "");
        }
        active = Counting(1);
        lblcounting.Text = "Total number of Active Employees :";
        lcount.Text = Convert.ToString(active);
    }

    protected void previous_Click(object sender, ImageClickEventArgs e)
    {
        int currentpage = Convert.ToInt32(ViewState["PageNo"]);
        if (currentpage > 1)
        {
            currentpage = currentpage - 1;
            ViewState["PageNo"] = currentpage;
            PageNo.SelectedIndex = currentpage;
            if (Textbox1.Text != "")
            {
                fillgrid2(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Convert.ToInt32(ddlempstatus.SelectedValue), Textbox1.Text);
            }
            else
            {
                fillgrid2(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Convert.ToInt32(ddlempstatus.SelectedValue), "");
            }
        }
        active = Counting(1);
        lblcounting.Text = "Total number of Active Employees :";
        lcount.Text = Convert.ToString(active);
    }

    protected void next_Click(object sender, ImageClickEventArgs e)
    {
        //ddlempstatus.Items.Clear();
        //ddlempstatus.Items.Insert(0, new ListItem("Select Status", "0"));
        ddlempstatus.SelectedIndex = 0;
        query = "select Count(*) from OfficeEmployee_Master where brid=" + Convert.ToInt16(Session["BrBrid"]);//"select Count(*) from student_master where status!=3 and brid=" + Convert.ToInt16(Session["BrBrid"]);
        totalpage = Convert.ToInt32(objdut.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
        if (Convert.ToInt32(objdut.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
        {
            //  totalpage = totalpage + 1;
        }
        else
        {
            totalpage = totalpage + 1;
        }
        int currentpage = Convert.ToInt32(ViewState["PageNo"]);
        if (currentpage < totalpage)
        {
            currentpage = currentpage + 1;
            ViewState["PageNo"] = currentpage;

            if (PageNo.SelectedIndex == 0)
            {
                return;
            }

            fillgrid2(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Convert.ToInt32(ddlempstatus.SelectedValue), "");
        }
        active = Counting(1);
        lblcounting.Text = "Total number of Active Employees :";
        lcount.Text = Convert.ToString(active);
    }

    protected void last_Click(object sender, ImageClickEventArgs e)
    {
        //ddlempstatus.Items.Clear();
        //ddlempstatus.Items.Insert(0, new ListItem("Select Status", "0"));
        ddlempstatus.SelectedIndex = 0;
        ddlsearchoption.SelectedIndex = 0;

        if (Textbox1.Text != "")
        {
            totalpage = 0;
        }
        else
        {
            query = "select Count(*) from OfficeEmployee_Master where brid=" + Convert.ToInt16(Session["BrBrid"]);//"select Count(*) from student_master where status!=3 and brid=" + Convert.ToInt16(Session["BrBrid"]);
            totalpage = Convert.ToInt32(objdut.GetScalar(query)) / Convert.ToInt32(ViewState["noofrecord"]);
            if (Convert.ToInt32(objdut.GetScalar(query)) % Convert.ToInt32(ViewState["noofrecord"]) == 0)
            {
                //  totalpage = totalpage + 1;
            }
            else
            {
                totalpage = totalpage + 1;
            }
        }

        ViewState["PageNo"] = totalpage;
        if (PageNo.Items.Count > 1)
        {
            PageNo.SelectedIndex = totalpage;
        }
        fillgrid2(Convert.ToInt32(ViewState["noofrecord"]), Convert.ToInt32(ViewState["PageNo"]), Convert.ToString(ViewState["sortby"]), Convert.ToInt32(ddlsearchoption.SelectedValue), Convert.ToInt32(ddlempstatus.SelectedValue), "");
        Textbox1.Text = "";
        active = Counting(1);
        lblcounting.Text = "Total number of Active Employees :";
        lcount.Text = Convert.ToString(active);
    }

    protected void gvDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //    LinkButton lnkdelete = (LinkButton)gvDetails.FindControl("lnkdel");
            //    if (lnkdelete.Text == "working")
            //    {
            //        lnkdelete.Enabled = true;
            //        lnkdelete.ToolTip = "This employee has been already activated.";
            //    }

            HiddenField hf = (HiddenField)e.Row.FindControl("hfimage");
            LinkButton lbtn = (LinkButton)e.Row.FindControl("lblbraddress1");
            string statusquery = "select isnull(hostatus,0) from OfficeEmployee_Master where status=1 and brid=" + Convert.ToInt16(Session["BrBrid"]) + " and eid=" + hf.Value;
            int statuscolor = Convert.ToInt32(objdut.GetScalar(statusquery));
            if (statuscolor == 1)
            {
                lbtn.ForeColor = System.Drawing.Color.FromArgb(0x2d9fdd);
            }
            else if (statuscolor == 2)
            {
                lbtn.ForeColor = System.Drawing.Color.FromArgb(0xE43733);
            }
            else if (statuscolor == 3)
            {
                lbtn.ForeColor = System.Drawing.Color.FromArgb(0x00852E);
            }
            else if (statuscolor == 4)
            {
                lbtn.ForeColor = System.Drawing.Color.FromArgb(0xF08100);
            }
            else
            {
                lbtn.ForeColor = System.Drawing.Color.FromArgb(0x2974F5);
            }
        }
    }

    protected void bindEmpStatus(int searchid)
    {
        string st = "";
        DataTable dto;
        if (searchid == 3)
        {
            st = "select statusname,statusid from tbl_EmployeeStatusMaster where Isactive=1";   //status query
            dto = objdut.GetDataTable(st);
            if (dto.Rows.Count > 0)
            {
                ddlempstatus.DataSource = dto;
                ddlempstatus.DataTextField = "statusname";
                ddlempstatus.DataValueField = "statusid";
                ddlempstatus.DataBind();
                ddlempstatus.Items.Insert(0, new ListItem("Select Status", "0"));
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No status has been added!!");
                ddlempstatus.Items.Insert(0, new ListItem("Select Item", "0"));
                return;
            }
            dto.Dispose();
        }
        else if (searchid == 4)
        {
            st = "select deptName,deptid from dept_master where status=1";   //department query
            dto = objdut.GetDataTable(st);
            if (dto.Rows.Count > 0)
            {
                ddlempstatus.DataSource = dto;
                ddlempstatus.DataTextField = "deptName";
                ddlempstatus.DataValueField = "deptid";
                ddlempstatus.DataBind();
                ddlempstatus.Items.Insert(0, new ListItem("Select Department", "0"));
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No department has been added!!");
                ddlempstatus.Items.Insert(0, new ListItem("Select Item", "0"));
                return;
            }
            dto.Dispose();
        }
        else
        {
            st = "select designame,desigid from designation_master where status=1";   //designation query
            dto = objdut.GetDataTable(st);
            if (dto.Rows.Count > 0)
            {
                ddlempstatus.DataSource = dto;
                ddlempstatus.DataTextField = "designame";
                ddlempstatus.DataValueField = "desigid";
                ddlempstatus.DataBind();
                ddlempstatus.Items.Insert(0, new ListItem("Select Designation", "0"));
            }
            else
            {
                Utility.ViewAlertMessage(this.Master.Page, "No designation has been added!!");
                ddlempstatus.Items.Insert(0, new ListItem("Select Item", "0"));
                return;
            }
            dto.Dispose();
        }
    }

    protected void txtDate_TextChanged(object sender, EventArgs e)
    {
        try
        {
            StartDate = Convert.ToDateTime(txtDate.Text.ToString());
        }
        catch
        {
            txtDate.Text = "";
            Utility.ViewAlertMessage(Page, "Please select a valid date.!");
            return;
        }
        if (!string.IsNullOrEmpty(txtDate.Text))
        {
            string qry = @"select eid,branchname,(fname+' '+Lname) as employeename,CONVERT(varchar(13),dateofjoining,106) as joindate,
                      department,mobile, (case photo when '' then '~/images/9update.png' else ('~/branchpanel/employee/EmpDocument/'+photo) end ) as photo,
                      (case oem.hostatus when (esm.StatusId) then (esm.StatusName)  end) as status
                      from OfficeEmployee_Master oem left outer join tbl_employeestatusmaster esm on oem.hostatus=esm.StatusId where brid=" + Convert.ToInt16(Session["BrBrid"]) + " and esm.statusname='working' or esm.statusname='ON LEAVE' or oem.hostatus=0 and convert(date,oem.dateofjoining)=cast('" + txtDate.Text + "' as datetime)";
            DataTable dto = objdut.GetDataTable(qry);
            if (dto.Rows.Count > 0)
            {
                gvDetails.DataSource = dto;
                gvDetails.DataBind();
            }
            else
            {
                gvDetails.DataSource = null;
                gvDetails.DataBind();
                Utility.ViewAlertMessage(this.Master.Page, "No record found!");
                txtDate.Text = "";
                ddlsearchoption.SelectedIndex = 0;
                ddlempstatus.Items.Clear();
                ddlempstatus.Items.Insert(0, new ListItem("Select Item", "0"));
            }
            dto.Dispose();
            if (!string.IsNullOrEmpty(txtDate.Text))
            {
                active = datCount(Convert.ToDateTime(txtDate.Text));
            }
            else
            {
                active = 0;
            }

            lblcounting.Text = "Total Number Of Employees Joined On This Date :";
            lcount.Text = Convert.ToString(active);
        }
        else
        {
            fillGrid(ViewState["query"].ToString());
            active = Counting(1);
            lblcounting.Text = "Total number of Active Employees :";
            lcount.Text = Convert.ToString(active);
        }
    }

    protected void gvDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
    }
}