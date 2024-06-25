using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

namespace Demo
{
    public partial class TodayPage : System.Web.UI.Page
    {
        DataUtility ObjDut = new DataUtility();
        protected void Page_Load(object sender, EventArgs e)
        {
            AddColumn();
            AddColumn1();
        }
        private void AddColumn()
        {

            DataTable dt = new DataTable();

            DataRow dr = null;

            dt.Columns.Add(new DataColumn("SubName", typeof(string)));

           // dt.Columns.Add(new DataColumn("PerTest_10 ", typeof(string)));

            dt.Columns.Add(new DataColumn("NoteBook_5", typeof(string)));

            dt.Columns.Add(new DataColumn("SubEnrichment_5", typeof(string)));

            dt.Columns.Add(new DataColumn("HalfyearlyExam_5", typeof(string)));

            dt.Columns.Add(new DataColumn("MarksObtained_100", typeof(string)));

            dt.Columns.Add(new DataColumn("Gr", typeof(string)));

            dt.Columns.Add(new DataColumn("PPerTest_10", typeof(string)));

            dt.Columns.Add(new DataColumn("NNoteBook_5", typeof(string)));

            dt.Columns.Add(new DataColumn("SSubEnrichment_5", typeof(string)));

            dt.Columns.Add(new DataColumn("yearlyExam_5", typeof(string)));

            dt.Columns.Add(new DataColumn("MMarksObtained_100", typeof(string)));

            dt.Columns.Add(new DataColumn("GGr", typeof(string)));

            dr = dt.NewRow();

            dr["SubName"] = "Language 1";
            //,Language 2,Language 3,Mathematics,Science,So.Science,Any Other Sub";

            //dr["PerTest_10"] = "Column 2";

            dr["NoteBook_5"] = "Column 3";

            dr["SubEnrichment_5"] = "Column 3";

            dr["HalfyearlyExam_5"] = "Column 3";

            dr["MarksObtained_100"] = "Column 3";

            dr["Gr"] = "Column 3";

            dr["PPerTest_10"] = "Column 3";

            dr["NNoteBook_5"] = "Column 3";

            dr["SSubEnrichment_5"] = "Column 3";

            dr["yearlyExam_5"] = "Column 3";

            dr["MMarksObtained_100"] = "Column 3";

            dr["GGr"] = "Column 3";

            dt.Rows.Add(dr);
            dt.AcceptChanges();
            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }
        private void AddColumn1()
        {

            DataTable dt = new DataTable();

            DataRow dr = null;

            dt.Columns.Add(new DataColumn("SubName", typeof(string)));

            // dt.Columns.Add(new DataColumn("PerTest_10 ", typeof(string)));

            dt.Columns.Add(new DataColumn("NoteBook_5", typeof(string)));

            dt.Columns.Add(new DataColumn("SubEnrichment_5", typeof(string)));

            dt.Columns.Add(new DataColumn("HalfyearlyExam_5", typeof(string)));

            dt.Columns.Add(new DataColumn("MarksObtained_100", typeof(string)));

            dt.Columns.Add(new DataColumn("Gr", typeof(string)));

            dt.Columns.Add(new DataColumn("PPerTest_10", typeof(string)));

            dt.Columns.Add(new DataColumn("NNoteBook_5", typeof(string)));

            dt.Columns.Add(new DataColumn("SSubEnrichment_5", typeof(string)));

            dt.Columns.Add(new DataColumn("yearlyExam_5", typeof(string)));

            dt.Columns.Add(new DataColumn("MMarksObtained_100", typeof(string)));

            dt.Columns.Add(new DataColumn("GGr", typeof(string)));

            dr = dt.NewRow();

            dr["SubName"] = "Language 1";
            //,Language 2,Language 3,Mathematics,Science,So.Science,Any Other Sub";

            //dr["PerTest_10"] = "Column 2";

            dr["NoteBook_5"] = "Column 3";

            dr["SubEnrichment_5"] = "Column 3";

            dr["HalfyearlyExam_5"] = "Column 3";

            dr["MarksObtained_100"] = "Column 3";

            dr["Gr"] = "Column 3";

            dr["PPerTest_10"] = "Column 3";

            dr["NNoteBook_5"] = "Column 3";

            dr["SSubEnrichment_5"] = "Column 3";

            dr["yearlyExam_5"] = "Column 3";

            dr["MMarksObtained_100"] = "Column 3";

            dr["GGr"] = "Column 3";

            dt.Rows.Add(dr);
            dt.AcceptChanges();
            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

    }
}