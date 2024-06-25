using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class HO_createfeeSubType : System.Web.UI.Page
{
    private string url, PageName;
    private Utility objut = new Utility();
    private SqlParameter[] param = new SqlParameter[6];
    private DataUtility objdut = new DataUtility();
    private CommonClass CommonClass = new CommonClass();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillFeeType();
            fillGrid();
            btnUpdate.Visible = false;
            divtop.Visible = false;
            Button1.Visible = true;
            grdFeeSubType.Visible = true;
            divforsearching.Visible = true;
        }
    }

    protected void fillGrid()
    {
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        DataTable dt = CommonClass.ABC1("fillgridfee", ActiveFinancialyear);
        if (dt.Rows.Count > 0)
        {
            grdFeeSubType.DataSource = dt;
            grdFeeSubType.DataBind();
        }
        else
        {
            grdFeeSubType.EmptyDataText = "No Fee Type Added Till Now In The System";
            grdFeeSubType.DataBind();
        }
    }

    public void fillFeeType()
    {
        ddlfeestype.DataSource = CommonClass.Dll("feestructureDll");
        ddlfeestype.DataValueField = "ID";
        ddlfeestype.DataTextField = "feename";
        ddlfeestype.DataBind();
        ListItem li = new ListItem("-- Select One--", "0");
        ddlfeestype.Items.Insert(0, li);

        DataTable Dt = CommonClass.Dll("GetAcademicYearDDL");
        ddlfinancialyear.DataSource = Dt;
        ddlfinancialyear.DataValueField = "fyid";
        ddlfinancialyear.DataTextField = "FYName";
        ddlfinancialyear.DataBind();
        ListItem liforallacedmicyear = new ListItem("-- Select Session--", "0");
        ddlfinancialyear.Items.Insert(0, liforallacedmicyear);
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        ddlfinancialyear.SelectedValue = Convert.ToString(ActiveFinancialyear);

        ddlfinacialyearforsearching.DataSource = Dt;
        ddlfinacialyearforsearching.DataValueField = "fyid";
        ddlfinacialyearforsearching.DataTextField = "FYName";
        ddlfinacialyearforsearching.DataBind();
        ddlfinacialyearforsearching.SelectedValue = Convert.ToString(ActiveFinancialyear);
    }

    protected void btnfeetype_Click(object sender, EventArgs e)
    {
        if (ddlfinancialyear.SelectedValue == "0")
        {
            lblMsg1.Text = "Select Session Please.";
            ddlfinancialyear.Focus();
            return;
        }
        if (ddlfeestype.SelectedValue == "0")
        {
            lblMsg1.Text = "Select Session Please.";
            ddlfinancialyear.Focus();
            return;
        }
        if (txtfeeSubType.Text == "")
        {
            lblMsg1.Text = "Please Enter Fees Type.";
            txtfeeSubType.Focus();
            return;
        }
        else
        {
            if (txtfeeSubType.Text.Trim().IndexOf('&') != -1) {
                lblMsg1.Text = "sign & is not allow in Fees Type.";
                txtfeeSubType.Focus();
                return;
            }
        }
        int i = Convert.ToInt32(objdut.GetScalar("select count(1) from feestructure where feename='" + txtfeeSubType.Text.Trim() + "' and Fyid=" +ddlfinancialyear .SelectedValue+ ""));
          if (i == 0)
          {
              string Query = " insert into feestructure (Feesubtype,Feename,status,Fyid,TaxApplicable,DefaultMonth) values(@Feesubtype,@Feename,@status,@fyid,@taxapplicable,@DefaultMonth)";
              param[0] = new SqlParameter("@feename", txtfeeSubType.Text.Trim());
              if (chkfetype.Checked == true)
                  param[1] = new SqlParameter("@status", Convert.ToInt32(1));
              else
                  param[1] = new SqlParameter("@status", Convert.ToInt32(0));
              param[2] = new SqlParameter("@Feesubtype", ddlfeestype.SelectedValue);
              param[3] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
              if (chktaxapplicable.Checked == true)
                  param[4] = new SqlParameter("@taxapplicable", Convert.ToInt32(1));
              else
                  param[4] = new SqlParameter("@taxapplicable", Convert.ToInt32(0));


              string MonthList = "";
              for (int k = 0; k < CheckBoxList1.Items.Count; k++)
              {
                  if (CheckBoxList1.Items[k].Selected)
                  {
                      if (MonthList == "")
                      {
                          MonthList = CheckBoxList1.Items[k].Value;
                      }
                      else
                      {
                          MonthList = MonthList +","+ CheckBoxList1.Items[k].Value;
                      }
                  }

              }
              for (int j = 0; j < CheckBoxList2.Items.Count; j++)
              {
                  if (CheckBoxList2.Items[j].Selected)
                  {
                      if (MonthList == "")
                      {
                          MonthList = CheckBoxList2.Items[j].Value;
                      }
                      else
                      {
                          MonthList = MonthList + ","+CheckBoxList2.Items[j].Value;
                      }                      
                  }

              }
              if (txtfeeSubType.Text == "5")
              {
                  param[5] = new SqlParameter("@DefaultMonth", MonthList.ToString());
              }
              else
              {
                  param[5] = new SqlParameter("@DefaultMonth", ddlMonth.SelectedValue.ToString());
              }


              int result = objdut.ExecuteSql(param, Query);

              if (result > 0)
              {
                  txtfeeSubType.Text = "";
                  chkfetype.Checked = false;
                  fillGrid();
                  grdFeeSubType.Visible = true;
                  divforsearching.Visible = true;
                  divtop.Visible = false;
              }
          }
          else
          {
              Utility.ViewAlertMessage(this, "Fee Type Already Exists.");
              return;
          }
    }

    protected void grdFeeSubType_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "edit14")
        {
            int id = Convert.ToInt32(e.CommandArgument);
            int IsEditable = Convert.ToInt32(objdut.GetScalar("select IsEditable from feestructure where id='" + id + "'"));
            if (IsEditable == 0)
            {
                //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Can not be editable')", true);
                txtfeeSubType.Enabled = false;
            }
            //else if (IsEditable == 1)
            //{
            string query = "select id,feename,feesubtype,status,TaxApplicable,Fyid,ISNULL(DefaultMonth,0) DefaultMonth from feestructure where id=" + id;
            DataTable table = objdut.GetDataTable(query);
            if (table.Rows.Count > 0)
            {
                ddlfeestype.SelectedValue = table.Rows[0]["feesubtype"].ToString();
                txtfeeSubType.Text = table.Rows[0]["feename"].ToString();
                if (table.Rows[0]["status"].ToString() == "True")
                {
                    chkfetype.Checked = true;
                }
                else
                {
                    chkfetype.Checked = false;
                }
                if (table.Rows[0]["TaxApplicable"].ToString() == "1")
                {
                    chktaxapplicable.Checked = true;
                }
                else
                {
                    chktaxapplicable.Checked = false;
                }

                if (Convert.ToInt16(ddlfeestype.SelectedValue) == 2)
                {
                    tr_ddlMonth.Visible = true;
                    ddlMonth.SelectedValue = table.Rows[0]["DefaultMonth"].ToString();
                }
                else if (Convert.ToInt16(ddlfeestype.SelectedValue) == 5)
                {
                    ddlMonth.Visible = true;
                }
                else
                {
                    tr_ddlMonth.Visible = false;
                }

                string[] MonthList = table.Rows[0]["DefaultMonth"].ToString().Split(',');
                for (int a = 0; a < MonthList.Length; a++)
                {
                    for (int k = 0; k < CheckBoxList1.Items.Count; k++)
                    {
                        if (CheckBoxList1.Items[k].Value.ToString() == MonthList[a].ToString())
                        {
                            CheckBoxList1.Items[k].Selected = true;
                        }

                    }
                    for (int l = 0; l < CheckBoxList2.Items.Count; l++)
                    {
                        if (CheckBoxList2.Items[l].Value.ToString() == MonthList[a].ToString())
                        {
                            CheckBoxList2.Items[l].Selected = true;
                        }

                    }
                }
                ddlfinancialyear.SelectedValue = table.Rows[0]["Fyid"].ToString();
                ViewState["id"] = table.Rows[0]["id"].ToString();
                btnUpdate.Visible = true;
                btnfeetype.Visible = false;
                divtop.Visible = true;
                grdFeeSubType.Visible = false;
                divforsearching.Visible = false;
                Button1.Visible = false;
            }
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        btnfeetype.Visible = false;
        if (txtfeeSubType.Text != "")
        {
            if (txtfeeSubType.Text.Trim().IndexOf('&') != -1)
            {
                lblMsg1.Text = "sign & is not allow in Fees Type.";
                txtfeeSubType.Focus();
                return;
            }
          
            int j = Convert.ToInt32(objdut.GetScalar("select count(1) from feestructure where feename='" + txtfeeSubType.Text.Trim() + "' and Fyid=" +                                       ddlfinancialyear.SelectedValue + " and id<>"+Convert.ToInt32(ViewState["id"].ToString())+""));
              if (j == 0)
              {
                  int i = Convert.ToInt32(objdut.GetScalar("select count(1) from feestructure where feename='" + txtfeeSubType.Text.Trim() + "'"));
                  if (i >= 0)
                  {
                      string query = "update feestructure set feename=@feename,status=@status,feesubtype=@feesubtype,Fyid=@fyid,TaxApplicable=@taxapplicable,DefaultMonth=@DefaultMonth where id=" + Convert.ToInt32(ViewState["id"].ToString());
                      SqlParameter[] param = new SqlParameter[6];
                      param[0] = new SqlParameter("@feename", SqlDbType.VarChar);
                      param[0].Value = txtfeeSubType.Text;
                      param[1] = new SqlParameter("@status", SqlDbType.Bit);
                      if (chkfetype.Checked)
                      {
                          param[1] = new SqlParameter("@status", 1);
                      }
                      else
                      {
                          param[1] = new SqlParameter("@status", Convert.ToInt32(0));
                      }
                      param[2] = new SqlParameter("@feesubtype", SqlDbType.Int);
                      if (ddlfeestype.SelectedValue != "0")
                      {
                          param[2] = new SqlParameter("@feesubtype", Convert.ToInt16(ddlfeestype.SelectedValue));
                      }
                      else
                      {
                          param[2] = new SqlParameter("@feesubtype", 0);
                      }
                      param[3] = new SqlParameter("@fyid", ddlfinancialyear.SelectedValue);
                      if (chktaxapplicable.Checked == true)
                          param[4] = new SqlParameter("@taxapplicable", Convert.ToInt32(1));
                      else
                          param[4] = new SqlParameter("@taxapplicable", Convert.ToInt32(0));

                      string MonthList = "";
                      for (int k = 0; k < CheckBoxList1.Items.Count; k++)
                      {
                          if (CheckBoxList1.Items[k].Selected)
                          {
                              if (MonthList == "")
                              {
                                  MonthList = CheckBoxList1.Items[k].Value;
                              }
                              else
                              {
                                  MonthList = MonthList + "," + CheckBoxList1.Items[k].Value ;
                              }
                          }

                      }
                      for (int l = 0; l < CheckBoxList2.Items.Count; l++)
                      {
                          if (CheckBoxList2.Items[l].Selected)
                          {
                              if (MonthList == "")
                              {
                                  MonthList = CheckBoxList2.Items[l].Value;
                              }
                              else
                              {
                                  MonthList = MonthList + "," + CheckBoxList2.Items[l].Value;
                              }
                          }

                      }
                      if (ddlfeestype.SelectedValue == "5")
                      {
                          param[5] = new SqlParameter("@DefaultMonth", MonthList.ToString());
                      }
                      else
                      {
                          param[5] = new SqlParameter("@DefaultMonth", ddlMonth.SelectedValue.ToString());
                      }
                      int result1 = objdut.ExecuteSql(param, query);

                      if (result1 > 0)
                      {
                          txtfeeSubType.Text = "";
                          chkfetype.Checked = false;
                          btnUpdate.Visible = false;
                          btnfeetype.Visible = true;
                          fillGrid();
                          grdFeeSubType.Visible = true;
                          divforsearching.Visible = true;
                          divtop.Visible = false;
                          Button1.Visible = true;
                      }
                      else
                      {
                          Utility.ViewAlertMessage(this.Master.Page, "Fees sub type not Updated successfully.");
                      }
                  }
              }
              else
              {
                  Utility.ViewAlertMessage(this, "Fee Type Already Exists.");
                  return;
              }
        }
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        int ActiveFinancialyear = CommonClass.GetActiveAcedmicYear();
        btnfeetype.Visible = true;
        divtop.Visible = true;
        grdFeeSubType.Visible = false;
        divforsearching.Visible = false;
        txtfeeSubType.Enabled = true;
        ddlfinancialyear.SelectedValue = ActiveFinancialyear.ToString();
        txtfeeSubType.Text = "";
        ddlfeestype.SelectedValue = "0";
        chktaxapplicable.Checked = false;
        chkfetype.Checked = false;
    }
    protected void ddlfinacialyearforsearching_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dt = CommonClass.ABC1("fillgridfee", Convert.ToInt32(ddlfinacialyearforsearching.SelectedValue));
        if (dt.Rows.Count > 0)
        {
            grdFeeSubType.DataSource = dt;
            grdFeeSubType.DataBind();
        }
        else
        {
            grdFeeSubType.EmptyDataText = "No Fee Type Added Till Now In The System";
            grdFeeSubType.DataBind();
        }
    }

    protected void btnback_Click(object sender, EventArgs e)
    {
        btnUpdate.Visible = false;
        divtop.Visible = false;
        Button1.Visible = true;
        grdFeeSubType.Visible = true;
        divforsearching.Visible = true;
    }
}