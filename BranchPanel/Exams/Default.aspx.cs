using System;
using System.Data;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GridDataBind();
        }
    }

    private void GridDataBind()
    {
        DataSet objSet = new DataSet();
        try
        {
            objSet.ReadXml(Server.MapPath("XMLFile.xml"));
        }
        catch
        {
        }

        if (objSet != null && objSet.Tables.Count > 0)
        {
            DataView objv = new DataView(objSet.Tables[0], "", "Order", DataViewRowState.CurrentRows);

            DragDropGridView1.DataSource = objv;
            DragDropGridView1.DataBind();
        }
    }

    protected void DragDropGridView1_DragAndDrop(object sender, Utility.DragAndDropEventArgs e)
    {
        DataSet objSet = new DataSet();
        try
        {
            objSet.ReadXml(Server.MapPath("XMLFile.xml"));
        }
        catch
        {
        }

        if (objSet != null && objSet.Tables.Count > 0)
        {
            string strTempOrder = objSet.Tables[0].Rows[e.StartIndex]["Order"].ToString();
            objSet.Tables[0].Rows[e.StartIndex]["Order"] = objSet.Tables[0].Rows[e.EndIndex]["Order"];
            objSet.Tables[0].Rows[e.EndIndex]["Order"] = strTempOrder;
            objSet.AcceptChanges();
            DataView objv = new DataView(objSet.Tables[0], "", "Order", DataViewRowState.CurrentRows);

            DragDropGridView1.DataSource = objv;
            DragDropGridView1.DataBind();
        }
    }
}