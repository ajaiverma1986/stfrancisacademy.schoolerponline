using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class BranchPanel_MasterUC_ViewStdsecBy : System.Web.UI.Page
{
    DataUtility objdut = new DataUtility();
    DataTable dtClassSec = new DataTable();
    DataTable dtSec = new DataTable();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        ShowClassSection();
    }
    public void ShowClassSection()
    {
        fillclass();
    }
    public void fillclass()
    {       
        SqlParameter[] param = new SqlParameter[2];
        param[0] = new SqlParameter("@mode", 3);
        param[1] = new SqlParameter("@brid", Session["BrBrid"]);
        dt = objdut.GetDataTableSP(param, "Usp_Class");
        if (dt.Rows.Count > 0)
        {
            if (dtClassSec.Columns.Count == 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string Class = "";

                    if (i == 0)
                    {
                        dtClassSec.Columns.Add("Section/Class");
                    }

                    if (Convert.ToBoolean(dt.Rows[Convert.ToInt32(i)]["Status"]) == true)
                    {
                        Class = dt.Rows[Convert.ToInt32(i)]["Classname"].ToString() + "," + dt.Rows[Convert.ToInt32(i)]["Classid"].ToString();
                        dtClassSec.Columns.Add(Class.ToString());
                    }
                }
            }
            if (dtClassSec.Columns.Count > 0)
            {
                string querynew = @"select DISTINCT sectionname from
                   ClassWithSection Cws inner join Class_Master Cm ON Cws.Classid=Cm.Id  where branchid=" + Session["BrBrid"] + "";
                dtSec = objdut.GetDataTable(querynew);
                if (dtSec.Rows.Count > 0)
                {
                    for (int j = 0; j < dtSec.Rows.Count; j++)
                    {
                        string sec = "";
                        sec = dtSec.Rows[j]["sectionname"].ToString();
                        DataRow drClassSec = dtClassSec.NewRow();
                        drClassSec["Section/Class"] = sec;
                        dtClassSec.Rows.Add(drClassSec);
                    }
                }
            }
        }
        if (dtSec.Rows.Count > 0)
        {
            Panel1.Controls.Add(DataTableToHTMLTable(dtClassSec, true));
        }
    }
    public Table DataTableToHTMLTable(DataTable dt, bool includeHeaders)
    {
        Table tbl = new Table();
        TableRow tr = null;
        TableCell cell = null;

        TableHeaderRow htr = new TableHeaderRow();
        TableHeaderCell hcell = null;

        tbl.Style.Add("width", "100%");

        int rows = dt.Rows.Count;
        int cols = dt.Columns.Count;

        if (includeHeaders)
        {            
            for (int i = 0; i < cols; i++)
            {
                string[] clas = dt.Columns[i].ColumnName.ToString().Split(',');
                hcell = new TableHeaderCell();
                hcell.Text = clas[0].ToString();
                htr.Cells.Add(hcell);
                hcell.Style.Add("width", (Convert.ToDecimal(100/cols)+"%"));
                hcell.Attributes.Add("class", "tr");
            }
            tbl.Rows.Add(htr);
        }
        HtmlAnchor htmlAnchor;
        int CountStd = 0;
        DataUtility objdut = new DataUtility();
        for (int j = 0; j < rows; j++)
        {
            string Sect = dt.Rows[j]["Section/Class"].ToString();
            tr = new TableRow();
            for (int k = 0; k < cols; k++)
            {
                int StdCount = 0;
                string SectionID = "";
                string[] clas = dt.Columns[k].ColumnName.ToString().Split(',');
                if (k == 0)
                {
                    cell = new TableCell();
                    cell.Text = Sect.ToString();
                    cell.Attributes.Add("class", "td");
                    tr.Cells.Add(cell);
                }
                else
                {
                    string strsec = "select Coalesce(nullif(CAST(cwsid as varchar(50)),''),0) SECTIONID from ClassWithSection Cws inner join Class_Master Cm ON Cws.Classid=Cm.Id  where branchid=" + HttpContext.Current.Session["BrBrid"] + " and classid=" + clas[1] + " and sectionname='" + Sect + "'";
                    SectionID = Convert.ToString(objdut.GetScalar("select Coalesce(nullif(CAST(cwsid as varchar(50)),''),0) SECTIONID from ClassWithSection Cws inner join Class_Master Cm ON Cws.Classid=Cm.Id  where branchid=" + HttpContext.Current.Session["BrBrid"] + " and classid=" + clas[1] + " and sectionname='" + Sect + "'"));
                    if (SectionID != "")
                    {
                        StdCount = (int)(objdut.GetScalar("select Count(*) from tbl_StudentAdmissionMaster where brid=" + HttpContext.Current.Session["BrBrid"] + " and classid=" + clas[1] + " and sectionid=" + SectionID + ""));
                        CountStd = CountStd + StdCount;
                        Label1.Text = "Total No. of Student : "+CountStd.ToString();
                    }

                    htmlAnchor = new HtmlAnchor();
                    htmlAnchor.HRef = "~/BranchPanel/Admission/admission-list.aspx?ClassID=" + clas[1] + "&SectionID=" + SectionID + "";
                    htmlAnchor.InnerText = StdCount.ToString();
                    cell = new TableCell(); ;
                    cell.Controls.Add(htmlAnchor);

                    cell.Attributes.Add("class", "td");
                    tr.Cells.Add(cell);
                }
            }
            tbl.Rows.Add(tr);
        }
        return tbl;
    }
}