using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

public partial class BranchPanel_tran : System.Web.UI.Page
{
    private CommonClass CommonClass = new CommonClass();
    private DataUtility objdut = new DataUtility();
    private Utility objut = new Utility();
    private SqlParameter[] param;
    private SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
    private SqlCommand cmd = new SqlCommand();
    private SqlDataReader dr1;
    private int i;

    protected void Page_Load(object sender, EventArgs e)
    {
        string url = Request.Url.ToString();

        if (Session["BrUser"] == null)
        {
            Response.Redirect("~/Login.aspx?redirectUrl=" + url);
        }
        if (!Page.IsPostBack)
        {
            // fildll();
            if (Request.QueryString.Count > 0)
            {
                int studentadno = Convert.ToInt32(Request.QueryString[0]);

                // ViewState["StuID"] = stuRegID;
                ViewState["stuadno"] = studentadno;
                showdetails();
                fiil1();
                filstopage();
                fillgridview();
            }
        }
    }

    private void fiil1()
    {
        int q1 = Convert.ToInt32(objdut.GetScalar("select COUNT(busno) from tbl_addbusforstudent where busno='" + ViewState["busno"] + "' and trstatus=1"));

        lblavail.Text = Convert.ToString(Convert.ToInt32(ViewState["noofsit"]) - q1);
    }

    private void filstopage()
    {
        int query = Convert.ToInt32(objdut.GetScalar("select COUNT(Routename) from tbl_stopage where RouteName='" + ViewState["r1"] + "'"));
        lblbus.Text = query.ToString();
    }

    private void fillgridview()
    {
        DataTable dt;
        string str = ViewState["routeNew"].ToString();

        string query = (" SELECT  s.stopageid, s.zone,s.stopagename,s.area,roadname,s.RouteName from tbl_stopage s,tbl_route r where s.routeid=r.Rid and s.routename='" + ViewState["routeNew"] + "' and s.branchid=" + Session["BrBrid"] + " and r.branchid=" + Session["BrBrid"] + "  order by s.pos asc");
        dt = objdut.GetDataTable(query);
        gridviewinventory1.DataSource = dt;
        gridviewinventory1.DataBind();
    }

    private void showdetails()
    {
        int idroute = Convert.ToInt32(ViewState["stuadno"]);
        string query = "Select RouteNo as RouteNo,Origin,Destination,Distance,v.noofseats,r.busno from tbl_route r,tbl_vehicleinfo v where r.BusNo=v.registrationno and Rid=" + idroute;
        SqlDataReader dr = objdut.GetDataReader(query);
        dr.Read();
        if (dr.HasRows)
        {
            lblroute.Text = dr["RouteNo"].ToString();
            ViewState["r1"] = lblroute.Text;
            ViewState["routeNew"] = lblroute.Text;
            lblorigin.Text = dr["Origin"].ToString();
            lbldestination.Text = dr["Destination"].ToString();
            lbldist.Text = dr["Distance"].ToString();
            lblmin.Text = dr["noofseats"].ToString();
            ViewState["noofsit"] = lblmin.Text;
            lblbusno.Text = dr["busno"].ToString();
            ViewState["busno"] = lblbusno.Text;
            dr.Close();
        }
        else
        {
            dr.Close();

            string query1 = "Select RouteNo ,Origin,Destination,Distance,busno from tbl_route  where Rid=" + idroute;
            dr1 = objdut.GetDataReader(query1);
            dr1.Read();
            if (dr1.HasRows)
            {
                lblroute.Text = dr1["RouteNo"].ToString();
                ViewState["r1"] = lblroute.Text;
                ViewState["routeNew"] = lblroute.Text;
                lblorigin.Text = dr1["Origin"].ToString();
                lbldestination.Text = dr1["Destination"].ToString();
                lbldist.Text = dr1["Distance"].ToString();
                lblmin.Text = "N/A";
                lblavail.Text = "N/A";
                if (dr1["busno"].ToString() == "")
                {
                    lblbusno.Text = "N/A";
                }

                dr1.Close();
            }
        }
        // dr1.Close();
    }

    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        int rid = Convert.ToInt32(ViewState["stuadno"]);

        Response.Redirect("createroot.aspx?rid=" + rid);
    }

    protected void btnsubmit1_Click(object sender, EventArgs e)
    {
        Response.Redirect("routelist.aspx");
    }
}