using System.Data;

/// <summary>
/// Summary description for DynamicTable
/// </summary>
public class DynamicTable
{
    public DynamicTable()
    {
    }

    public DataTable CreateDataSource()
    {
        DataTable dt = new DataTable();
        DataColumn identity = new DataColumn("ID", typeof(int));
        dt.Columns.Add(identity);
        dt.Columns.Add("Name", typeof(string));
        return dt;
    }

    //This is the AddRow method to add a new row in Table dt
    public void AddRow(int id, string name, DataTable dt)
    {
        dt.Rows.Add(new object[] { id, name });
    }
}