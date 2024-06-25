using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
public partial class BranchPanel_createroot : System.Web.UI.Page
{

    private int count = 0;
    private CommonClass CommonClass = new CommonClass();
    private DataUtility objdut = new DataUtility();
    private DataUtility objdut1 = new DataUtility();
    private Utility objut = new Utility();
    private SqlParameter[] param;
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
    private SqlCommand cmd = new SqlCommand();
    private int i;
    private static int academicyear_id = 0;
    private string query, url;
    private DataTable dt, obj, obj2;
    private SqlDataReader dr;
    private DataTable dt5 = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
     {

         url = Request.Url.ToString();

         if (Session["BrUser"] == null)
         {
             Response.Redirect("~/Login.aspx?redirectUrl=" + url);
         }
         academicyear_id = Convert.ToInt32(objdut.GetScalar("select isnull(fyid,0) as fyid from financial_year where isactive=1 and isclosed=0"));
         Session["fy"] = academicyear_id;
        createstopage.Visible = false;
        stopposition.Visible = false;
        
        if (Request.QueryString.Count > 0)
        {
            btnsubmit.Text = "Update";
        }

        if (!IsPostBack)
        {
            divgrid.Visible = true;
            lblroot1.Text = "Create Route";
            
            if (Request.QueryString.Count > 0)
            {
                btncancel.Visible = false;
                Button1.Visible = true;
                lblroot1.Text = "Update Route";
                createstopage.Visible = true;
                btnsubmit.Text = "Update";
                int ridnew = Convert.ToInt32(Request.QueryString[0]);
                ViewState["stuadno"] = ridnew;
                fillall();
                //bindgrid();

            }
        }
    }

    private void fillall()
    {
        query = " select rid  ,routeno, ORIGIN, destination,distance from tbl_route where Rid=" + ViewState["stuadno"];

        dr = objdut.GetDataReader(query);
        dr.Read();
        if (dr.HasRows)
        {
            txtrouteno.Text = dr["routeno"].ToString();
            ViewState["rotno"] = txtrouteno.Text;
            txtorigin.Text = dr["ORIGIN"].ToString();
            txtdest.Text = dr["destination"].ToString();
            txtdistance.Text = dr["distance"].ToString();
            ViewState["rid"] = dr["rid"].ToString();
            dr.Close();
            int query2 = Convert.ToInt32(objdut.GetScalar("select COUNT(routename)as routno from tbl_stopage where routename='" + txtrouteno.Text + "'"));
            int query3 = Convert.ToInt32(objdut.GetScalar("select  stopageid from tbl_stopage where routename='" + txtrouteno.Text + "'"));
            ViewState["stopageid1"] = query3;

            txtstops.Text = query2.ToString();
            Gridview1.Visible = true;
            int a = Convert.ToInt32(txtstops.Text);
            DataTable dt = new DataTable();
            dt.Columns.Add("S.No", typeof(string));
            dt.Columns.Add("Select Zone", typeof(string));
            dt.Columns.Add("Select Area", typeof(string));
            dt.Columns.Add("Road Name", typeof(string));
            dt.Columns.Add("Stopage Name", typeof(string));
            dt.Columns.Add("Status", typeof(string));
            for (int y = 1; y <= a; y++)
            {
                DataRow dr1 = dt.NewRow();
                dr1["S.No"] = y.ToString();
                dr1["Select Zone"] = "";
                dr1["Select Area"] = "";
                dr1["Road Name"] = "";
                dr1["Stopage Name"] = "";
                dr1["Status"] = "";
                //dr["Status"] = "";
                dt.Rows.Add(dr1);
            }

            btnsubmit.Text = "Update";
            btnsubmit.Visible = true;
            Session["state"] = dt;
            bindgrid();
            fillgridnew();
        }
    }

    private void fillgridnew()
    {
        txtstops.Enabled = false;
        string query = "select zone,zoneid,area,areaid,stopageName,roadname,roadid from tbl_stopage where routename='" + ViewState["rotno"] + "'order by  pos asc";

        dt = objdut.GetDataTable(query);

        foreach (GridViewRow row in Gridview1.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                DropDownList ddlarea1 = (DropDownList)row.FindControl("ddlarae");
                DropDownList ddlzone1 = (DropDownList)row.FindControl("ddlzone");
                DropDownList ddlroad1 = (DropDownList)row.FindControl("ddlroad");
                TextBox txtstope = (TextBox)row.FindControl("TextBox3");

                ddlzone1.SelectedValue = dt.Rows[count]["zoneid"].ToString();
                ddlarea1.SelectedValue = dt.Rows[count]["areaid"].ToString();
                ddlroad1.SelectedValue = dt.Rows[count]["roadid"].ToString();
                txtstope.Text = dt.Rows[count]["stopageName"].ToString();
                int ddlid = Convert.ToInt32(ddlzone1.SelectedValue);
                ViewState["dd1l"] = ddlid;


                obj2 = objdut1.GetDataTable("select roadname,ROW_NUMBER() OVER(ORDER BY roadname ASC) as rowNumber from tbl_stopage group by roadname,routename having routename='" + ViewState["rotno"] + "'");
                ddlroad1.DataSource = obj2;
                ddlroad1.DataTextField = "roadname";
                ddlroad1.DataValueField = "rowNumber";
                ddlroad1.DataBind();
                ddlroad1.Items.Insert(0, "--Select Road Name--");



                obj = objdut.GetDataTable("select areaid ,areaname from tbl_addarea where zoneid=" + ViewState["dd1l"]);
                ddlarea1.DataSource = obj;
                ddlarea1.DataValueField = "areaid";
                ddlarea1.DataTextField = "areaname";
                ddlarea1.DataBind();
                ddlarea1.Items.Insert(0, "--Select Society--");

                count = count + 1;
            }
        }
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < Gridview1.Rows.Count; i++)
        {
            DropDownList chkUpdate = (DropDownList)Gridview1.Rows[i].Cells[0].FindControl("ddlarae");

            if (chkUpdate.SelectedIndex == 0)
            {
                Utility.ViewAlertMessage(this.Master.Page, "plz select Area!");
                return;
            }
            // Get the values of textboxes using findControl
            string strID = Gridview1.Rows[i].Cells[1].Text;
            DropDownList strName = (DropDownList)Gridview1.Rows[i].Cells[0].FindControl("ddlroad");

            if (strName.SelectedIndex == 0)
            {
                Utility.ViewAlertMessage(this.Master.Page, "plz Select Road Name");
                return;
            }
            string strLocation = ((TextBox)Gridview1.Rows[i].FindControl("TextBox3")).Text;

            if (strLocation == "")
            {
                Utility.ViewAlertMessage(this.Master.Page, "plz Enter stopage name!");
                return;
            }

            string chk = ((CheckBox)Gridview1.Rows[i].FindControl("chkstatus1")).Text;
        }

        if (btnsubmit.Text == "Submit")
        {
            if (checkValidation())
            {
                SqlParameter[] param = new SqlParameter[11];
                param[0] = new SqlParameter("@mode", "addroute");
                param[1] = new SqlParameter("@routeno", txtrouteno.Text.Trim());
                param[2] = new SqlParameter("@origin", txtorigin.Text.Trim());
                param[3] = new SqlParameter("@destination", txtdest.Text.Trim());
                param[4] = new SqlParameter("@distance", txtdistance.Text.Trim());
                param[5] = new SqlParameter("@status", 1);
                param[6] = new SqlParameter("@rid", Convert.ToInt32("0"));
                param[7] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                param[7].Direction = ParameterDirection.Output;
                param[8] = new SqlParameter("@posnew", Convert.ToInt32("0"));
                param[9] = new SqlParameter("@branchid", Session["BrBrid"]);
                param[10] = new SqlParameter("@fyid", ViewState["fy"]);

                int ret = objdut.ExecuteSqlSP(param, "usp_CrateRoute");
                if (ret > 0)
                {
                    if (txtstops.Text != "")
                    {
                        int pos = 1;
                        for (int i = 0; i < Gridview1.Rows.Count; i++)
                        {
                            DropDownList chkUpdate = (DropDownList)Gridview1.Rows[i].Cells[0].FindControl("ddlarae");
                            DropDownList ddlzone = (DropDownList)Gridview1.Rows[i].Cells[0].FindControl("ddlzone");
                            DropDownList ddlroad = (DropDownList)Gridview1.Rows[i].Cells[0].FindControl("ddlroad");

                            TextBox txtstopage = (TextBox)Gridview1.Rows[i].Cells[0].FindControl("TextBox3");

                            int ddlzoneid = Convert.ToInt32(chkUpdate.SelectedValue);
                            int ddlareaid = Convert.ToInt32(ddlzone.SelectedValue);
                            int ddlroadid = Convert.ToInt32(ddlroad.SelectedValue);
                            SqlParameter[] param1 = new SqlParameter[16];

                            param1[0] = new SqlParameter("@stop", txtstopage.Text);
                            param1[1] = new SqlParameter("@routeno", txtrouteno.Text);
                            param1[2] = new SqlParameter("@zone", ddlzone.SelectedItem.Text);
                            param1[3] = new SqlParameter("@zoneid", ddlareaid);
                            param1[4] = new SqlParameter("@area", chkUpdate.SelectedItem.Text);
                            param1[5] = new SqlParameter("@areaid", ddlzoneid);
                            param1[15] = new SqlParameter("@roadid", ddlroadid);
                            param1[6] = new SqlParameter("@road", ddlroad.SelectedItem.Text);
                            param1[7] = new SqlParameter("@status", 1);
                            param1[8] = new SqlParameter("@pos", pos);
                            param1[9] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                            param1[9].Direction = ParameterDirection.Output;
                            param1[10] = new SqlParameter("@mode", "gridinside");
                            param1[11] = new SqlParameter("@rid", Convert.ToInt32("0"));
                            param1[12] = new SqlParameter("@posnew", Convert.ToInt32("0"));
                            param1[13] = new SqlParameter("@branchid", Session["BrBrid"]);
                            param1[14] = new SqlParameter("@fyid", ViewState["fy"]);
                            int res = objdut.ExecuteSqlSP(param1, "usp_CrateRoute");
                            if (res == 1)

                                pos++;
                        }

                        Utility.ViewAlertMessage(this.Master.Page, "Route Created Successfully!");
                        reset();
                    }
                    else
                    {
                        Utility.ViewAlertMessage(this.Master.Page, "Error...");
                    }
                }
            }
        }
        else

            if (btnsubmit.Text == "Update")
            {
                if (checkValidation())
                {
                    for (int i = 0; i < Gridview1.Rows.Count; i++)
                    {
                        DropDownList chkUpdate = (DropDownList)Gridview1.Rows[i].Cells[0].FindControl("ddlarae");
                        DropDownList ddlzone = (DropDownList)Gridview1.Rows[i].Cells[0].FindControl("ddlzone");
                        DropDownList ddlroad = (DropDownList)Gridview1.Rows[i].Cells[0].FindControl("ddlroad");
                        TextBox txtstopage = (TextBox)Gridview1.Rows[i].Cells[0].FindControl("TextBox3");

                        int ddlzoneid = Convert.ToInt32(chkUpdate.SelectedValue);
                        int ddlareaid = Convert.ToInt32(ddlzone.SelectedValue);
                        int ddlroadid = Convert.ToInt32(ddlroad.SelectedValue);

                        if (txtpos.Text == "")
                        {
                            SqlParameter[] param1 = new SqlParameter[8];
                            param1[0] = new SqlParameter("@mode", "updateroute");
                            param1[1] = new SqlParameter("@routeno", txtrouteno.Text.Trim());
                            param1[2] = new SqlParameter("@origin", txtorigin.Text.Trim());
                            param1[3] = new SqlParameter("@destination", txtdest.Text.Trim());
                            param1[4] = new SqlParameter("@distance", txtdistance.Text.Trim());
                            param1[5] = new SqlParameter("@status", 1);
                            param1[6] = new SqlParameter("@rid", Convert.ToInt32(ViewState["stuadno"]));
                            param1[7] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                            param1[7].Direction = ParameterDirection.Output;
                            int ret = objdut.ExecuteSqlSP(param1, "usp_CrateRoute");
                            if (ret > 0)
                            {
                                SqlParameter[] param2 = new SqlParameter[14];
                                param2[0] = new SqlParameter("@stop", txtstopage.Text);
                                param2[1] = new SqlParameter("@routeno", txtrouteno.Text);
                                param2[2] = new SqlParameter("@zone", ddlzone.SelectedItem.Text);
                                param2[3] = new SqlParameter("@zoneid", ddlareaid);
                                param2[4] = new SqlParameter("@area", chkUpdate.SelectedItem.Text);
                                param2[5] = new SqlParameter("@areaid", ddlzoneid);
                                param2[13] = new SqlParameter("@roadid", ddlroadid);
                                param2[6] = new SqlParameter("@road", ddlroad.SelectedItem.Text);
                                param2[7] = new SqlParameter("@status", 1);
                                param2[8] = new SqlParameter("@pos", i + 1);
                                param2[9] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                                param2[9].Direction = ParameterDirection.Output;
                                param2[10] = new SqlParameter("@mode", "justupdate");
                                param2[11] = new SqlParameter("@rid", Convert.ToInt32("0"));
                                param2[12] = new SqlParameter("@posnew", "");
                                int res = objdut.ExecuteSqlSP(param2, "usp_CrateRoute");
                            }
                        }
                        else
                        {
                            if (i == Convert.ToInt16(txtpos.Text))
                            {
                                SqlParameter[] param = new SqlParameter[6];
                                param[0] = new SqlParameter("@mode", "updatepreviousrow");
                                param[1] = new SqlParameter("@posnew", txtpos.Text);
                                param[2] = new SqlParameter("@routeno", txtrouteno.Text);

                                param[3] = new SqlParameter("@status", 1);
                                param[4] = new SqlParameter("@rid", Convert.ToInt16("0"));
                                param[5] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                                param[5].Direction = ParameterDirection.Output;

                                int res = objdut.ExecuteSqlSP(param, "usp_CrateRoute");
                                if (res == 1)
                                {
                                }
                            }
                            else
                            {
                            }

                            if (i == Convert.ToInt16(txtpos.Text))
                            {
                                SqlParameter[] param1 = new SqlParameter[16];

                                param1[0] = new SqlParameter("@stop", txtstopage.Text);
                                param1[1] = new SqlParameter("@routeno", txtrouteno.Text);
                                param1[2] = new SqlParameter("@zone", ddlzone.SelectedItem.Text);
                                param1[3] = new SqlParameter("@zoneid", ddlareaid);
                                param1[4] = new SqlParameter("@area", chkUpdate.SelectedItem.Text);
                                param1[5] = new SqlParameter("@areaid", ddlzoneid);
                                param1[6] = new SqlParameter("@roadid", ddlroadid);
                                param1[13] = new SqlParameter("@road", ddlroad.SelectedItem.Text);
                                param1[7] = new SqlParameter("@status", 1);
                                param1[8] = new SqlParameter("@pos", (txtpos.Text.Trim()));
                                param1[9] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                                param1[9].Direction = ParameterDirection.Output;
                                param1[10] = new SqlParameter("@mode", "addnewrow");
                                param1[11] = new SqlParameter("@rid", Convert.ToInt32("0"));
                                param1[12] = new SqlParameter("@posnew", txtpos.Text.Trim());
                                param1[15] = new SqlParameter("@branchid", Session["BrBrid"]);
                                param1[14] = new SqlParameter("@fyid", ViewState["fy"]);
                                int res1 = objdut.ExecuteSqlSP(param1, "usp_CrateRoute");

                                if (res1 > 0)
                                {
                                }
                                else
                                {
                                }
                            }
                            else
                            {
                                if (i >= Convert.ToInt16(txtpos.Text))
                                {
                                    SqlParameter[] param2 = new SqlParameter[14];
                                    param2[0] = new SqlParameter("@stop", txtstopage.Text);
                                    param2[1] = new SqlParameter("@routeno", txtrouteno.Text);
                                    param2[2] = new SqlParameter("@zone", ddlzone.SelectedItem.Text);
                                    param2[3] = new SqlParameter("@zoneid", ddlareaid);
                                    param2[4] = new SqlParameter("@area", chkUpdate.SelectedItem.Text);
                                    param2[5] = new SqlParameter("@areaid", ddlzoneid);
                                    param2[6] = new SqlParameter("@roadid", ddlroadid);
                                    param2[13] = new SqlParameter("@road", ddlroad.SelectedItem.Text);
                                    param2[7] = new SqlParameter("@status", 1);
                                    param2[8] = new SqlParameter("@pos", Convert.ToInt32("0"));
                                    param2[9] = new SqlParameter("@intResult", Convert.ToInt32("0"));
                                    param2[9].Direction = ParameterDirection.Output;
                                    param2[10] = new SqlParameter("@mode", "Nowupdate");
                                    param2[11] = new SqlParameter("@rid", Convert.ToInt32("0"));
                                    param2[12] = new SqlParameter("@posnew", txtpos.Text.Trim());

                                    int res = objdut.ExecuteSqlSP(param2, "usp_CrateRoute");
                                }
                            }
                        }
                    }

                    Utility.ViewAlertMessage(this.Master.Page, "Update Route successfully!");
                    Response.Redirect("routelist.aspx");

                    reset();
                }
            }
    }

    public bool checkValidation()
    {
        if (txtrouteno.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Route No.!");
            return false;
        }
        if (txtorigin.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Oringin!");
            return false;
        }

        if (txtdest.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Destination!");
            return false;
        }

        if (txtdistance.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "Please Enter Distance!");
            return false;
        }
        if (txtstops.Text == "")
        {
            Utility.ViewAlertMessage(this.Master.Page, "plz Enter Stopage");
            return false;
        }
        else
            return true;
    }

    protected void btncancel_Click(object sender, EventArgs e)
    {
        txtrouteno.Text = "";
        txtdest.Text = "";
        txtorigin.Text = "";
        txtstops.Text = "";
        txtdistance.Text = "";

        Gridview1.Visible = false;

        Response.Redirect("createroot.aspx");
    }

    protected void Gridview1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
    }

    protected void Gridview1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
    }

    protected void Gridview1_RowEditing(object sender, GridViewEditEventArgs e)
    {
    }

    protected void Gridview1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
    }

    protected void Gridview1_SelectedIndexChanged(object sender, EventArgs e)
    {
    }

    protected void txtstops_TextChanged(object sender, EventArgs e)
    {
        Gridview1.Visible = true;

        if (txtstops.Text == "")
        {
            return;
        }
        i = Convert.ToInt32(txtstops.Text);

        dt5.Columns.Add("S.No", typeof(string));
        dt5.Columns.Add("Select zone", typeof(string));
        dt5.Columns.Add("Select Area", typeof(string));

        dt5.Columns.Add("Road Name", typeof(string));
        dt5.Columns.Add("Stopage Name", typeof(string));
        dt5.Columns.Add("Status", typeof(string));
        for (int y = 1; y <= i; y++)
        {
            DataRow dr = dt5.NewRow();
            dr["S.No"] = y.ToString();
            dr["Select zone"] = "";
            dr["Select Area"] = "";
            dr["Road Name"] = "";
            dr["Stopage Name"] = "";
            dr["Status"] = "";
            //dr["Status"] = "";
            dt5.Rows.Add(dr);
        }
        //btnsubmit.Text = "Submit";
        btnsubmit.Visible = true;
        Session["state"] = dt5;
        bindgrid();
    }

    protected void bindgrid()
    {
        Gridview1.DataSource = (DataTable)Session["state"];
        Gridview1.DataBind();
        txtstops.Visible = true;
        btnsubmit.Visible = true;
        for (int i = 0; i < Gridview1.Rows.Count; i++)
        {
            DropDownList chkUpdate = (DropDownList)Gridview1.Rows[i].Cells[0].FindControl("ddlzone");
            DropDownList ddlroad = (DropDownList)Gridview1.Rows[i].Cells[0].FindControl("ddlroad");
            chkUpdate.DataSource = CommonClass.Dll("zone");
            chkUpdate.DataTextField = "zonename";
            chkUpdate.DataValueField = "zoneid";
            chkUpdate.DataBind();
            chkUpdate.Items.Insert(0, new ListItem("--Select Sector--", "0"));
        }
    }

    private void reset()
    {
        txtrouteno.Text = "";
        txtdest.Text = "";
        txtorigin.Text = "";
        txtstops.Text = "";
        txtdistance.Text = "";
        btncancel.Text = "Back";
        Gridview1.Visible = false;
        //Response.Redirect("createroot.aspx?id="+Convert.ToInt32("0"));
        // Utility.ViewAlertMessage(this.Master.Page, "sucessfully Updated!");
        abc.Visible = false;
        btnsubmit.Enabled = false;
        for (int i = 0; i < Gridview1.Rows.Count; i++)
        {
            DropDownList chkUpdate = (DropDownList)Gridview1.Rows[i].Cells[0].FindControl("ddlarae");
            string strID = Gridview1.Rows[i].Cells[1].Text;
            //string strName = ((TextBox)Gridview1.Rows[i].FindControl("TextBox2")).Text;
            DropDownList ddlroad = (DropDownList)Gridview1.Rows[i].Cells[0].FindControl("ddlroad");
            string strLocation = ((TextBox)Gridview1.Rows[i].FindControl("TextBox3")).Text;
            chkUpdate.SelectedIndex = 0;
            ddlroad.SelectedIndex = 0;
            //strName = "";
            strLocation = "";
        }
    }

    protected void ddl_Course_SelectedIndexChanged(object sender, EventArgs e)
    {
        //for (int i = 0; i < Gridview1.Rows.Count; i++)
        //{
        GridViewRow row = ((GridViewRow)((DropDownList)sender).NamingContainer);
        //    var dataKey = Gridview1.DataKeys[row.RowIndex];

        DropDownList chkUpdate = (DropDownList)Gridview1.Rows[row.RowIndex].Cells[0].FindControl("ddlarae");
        DropDownList ddl2 = (DropDownList)Gridview1.Rows[row.RowIndex].Cells[0].FindControl("ddlzone");
        //DropDownList l = (DropDownList)Row.FindControl("ddlarae");
        DropDownList ddlroad = (DropDownList)Gridview1.Rows[row.RowIndex].Cells[0].FindControl("ddlroad");

        chkUpdate.Items.Clear();
        int zonenewid = Convert.ToInt32(ddl2.SelectedValue);

        obj2 = objdut.GetDataTable("select areaid ,areaname from tbl_addarea where zoneid=" + zonenewid);
        chkUpdate.DataSource = obj2;
        chkUpdate.DataTextField = "areaname";
        chkUpdate.DataValueField = "areaid";
        chkUpdate.DataBind();
        chkUpdate.Items.Insert(0, "--Select Society--");
    }

    protected void ddlarae_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridViewRow row = ((GridViewRow)((DropDownList)sender).NamingContainer);
        //    var dataKey = Gridview1.DataKeys[row.RowIndex];

        DropDownList chkUpdate = (DropDownList)Gridview1.Rows[row.RowIndex].Cells[0].FindControl("ddlarae");
        DropDownList ddl2 = (DropDownList)Gridview1.Rows[row.RowIndex].Cells[0].FindControl("ddlzone");
        //DropDownList l = (DropDownList)Row.FindControl("ddlarae");
        DropDownList ddlroad = (DropDownList)Gridview1.Rows[row.RowIndex].Cells[0].FindControl("ddlroad");
        int areaid1 = Convert.ToInt32(chkUpdate.SelectedValue);
        obj = objdut1.GetDataTable("select roadname,ROW_NUMBER() OVER(ORDER BY roadname ASC) as rowNumber from road_master group by roadname,Areaid having Areaid=" + areaid1);
        ddlroad.DataSource = obj;
        ddlroad.DataTextField = "roadname";
        ddlroad.DataValueField = "rowNumber";
        ddlroad.DataBind();
        ddlroad.Items.Insert(0, "--select Road--");
    }

    protected void txtrouteno_TextChanged(object sender, EventArgs e)
    {
        int query = Convert.ToInt32(objdut.GetScalar("select COUNT(RouteNo) from tbl_route where RouteNo='" + txtrouteno.Text + "'"));

        if (query == 1)
        {
            txtrouteno.Text = "";
            Utility.ViewAlertMessage(this.Master.Page, "Already exist Route No.");
            return;
        }
        else
        {
            //Utility.ViewAlertMessage(this.Master.Page, "Already exist Route No.");
        }
    }

    private void bindgrid1()
    {
        for (int i = 0; i < Gridview1.Rows.Count; i++)
        {
            DropDownList chkUpdate = (DropDownList)Gridview1.Rows[i].Cells[1].FindControl("ddlzone");

            chkUpdate.DataSource = CommonClass.Dll("zone");
            chkUpdate.DataTextField = "zonename";
            chkUpdate.DataValueField = "zoneid";
            chkUpdate.DataBind();
            chkUpdate.Items.Insert(0, new ListItem("--Select Sector--", "0"));
        }
    }

    private void fillgridnew1()
    {
        txtstops.Enabled = false;
        string query = "select zone,zoneid,area,areaid,roadid,stopageName,roadname from tbl_stopage where routename='" + ViewState["rotno"] + "' order by  pos asc  ";

        dt = objdut.GetDataTable(query);

        int rowIndex = 0;
        int j = 0;
        for (int i = 0; i < Gridview1.Rows.Count; i++)
        {
            var ddlzone1 = (DropDownList)Gridview1.Rows[rowIndex].Cells[0].FindControl("ddlzone");
            var ddlzrea1 = (DropDownList)Gridview1.Rows[rowIndex].Cells[0].FindControl("ddlarae");
            var ddlroad1 = (DropDownList)Gridview1.Rows[rowIndex].Cells[0].FindControl("ddlroad");
            var txtloc = (TextBox)Gridview1.Rows[rowIndex].Cells[0].FindControl("TextBox3");

            if (i != Convert.ToInt16(txtpos.Text))
            {
                ddlzone1.SelectedValue = dt.Rows[j]["zoneid"].ToString();
                ddlzrea1.SelectedValue = dt.Rows[j]["areaid"].ToString();
                ddlroad1.SelectedValue = dt.Rows[j]["roadid"].ToString();
                txtloc.Text = dt.Rows[j]["stopageName"].ToString();
                int ddlid = Convert.ToInt32(ddlzone1.SelectedValue);
                ViewState["dd1l"] = ddlid;
                j++;
            }
            else
            {
                //ddlzone1.SelectedValue = "0";
                //ddlzrea1.SelectedValue = "0";

                //txtroad.Text = "";
                //txtloc.Text = "";
                //  int ddlid = Convert.ToInt32(ddlzone1.SelectedValue);
                //  ViewState["dd1l"] = ddlid;
            }

            rowIndex++;
            obj = objdut.GetDataTable("select areaid ,areaname from tbl_addarea where zoneid=" + ViewState["dd1l"]);
            ddlzrea1.DataSource = obj;
            ddlzrea1.DataTextField = "areaname";
            ddlzrea1.DataValueField = "areaid";
            ddlzrea1.DataBind();
            ddlzrea1.Items.Insert(0, "--Select Area--");

            obj2 = objdut1.GetDataTable("select roadname,ROW_NUMBER() OVER(ORDER BY roadname ASC) as rowNumber from tbl_stopage group by roadname,routename having routename='" + ViewState["rotno"] + "'");
            ddlroad1.DataSource = obj2;
            ddlroad1.DataTextField = "roadname";
            ddlroad1.DataValueField = "rowNumber";
            ddlroad1.DataBind();

            ddlroad1.Items.Insert(0, "--Select Road Name--");

            count = count + 1;
        }
    }

    protected void txtpos_TextChanged(object sender, EventArgs e)
    {
        if (Convert.ToInt16(txtpos.Text) < Gridview1.Rows.Count)
        {
            Utility.ViewAlertMessage(this.Master.Page, "Plaz enter Valid position!");
            createstopage.Visible = true;
            radiobtn.SelectedValue = "2";
            txtpos.Text = "";
            return;
        }

        ViewState["postion"] = txtpos.Text;

        int rowIndex = 0;
        if (Session["state"] != null)
        {
            var dt = (DataTable)Session["state"];
            DataRow dr = null;

            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    var ddlzone = (DropDownList)Gridview1.Rows[rowIndex].Cells[0].FindControl("ddlzone");
                    var ddlzrea = (DropDownList)Gridview1.Rows[rowIndex].Cells[0].FindControl("ddlarae");
                    var ddlroad = (DropDownList)Gridview1.Rows[rowIndex].Cells[0].FindControl("ddlroad");
                    var txtloc = (TextBox)Gridview1.Rows[rowIndex].Cells[0].FindControl("TextBox3");

                    rowIndex++;
                }

                dr = dt.NewRow();

                dt.Rows.InsertAt(dr, Convert.ToInt32(txtpos.Text));
                dt.AcceptChanges();

                Gridview1.DataSource = dt;
                Gridview1.DataBind();

                bindgrid1();
                fillgridnew1();
            }
        }
    }

    protected void radiobtn_SelectedIndexChanged(object sender, EventArgs e)
    {
        stopposition.Visible = true;
    }

    protected void btncancel1_Click(object sender, EventArgs e)
    {
        Response.Redirect("tran.aspx?Rid=" + ViewState["stuadno"]);
    }

    
}
        


