using System;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;

public class BasePage : System.Web.UI.Page
{
    private DataUtility objdut = new DataUtility();
    private SqlParameter[] param = new SqlParameter[4];

    //protected void LogActivity(string activity, bool recordPageUrl, int userid)
    //{
    //    param[0] = new SqlParameter("@UserId", userid);
    //    param[1] = new SqlParameter("@Activity", activity);
    //    if (recordPageUrl)
    //        param[2] = new SqlParameter("@PageUrl", Request.RawUrl);
    //    else
    //        param[2] = new SqlParameter("@PageUrl", DBNull.Value);

    //    param[3] = new SqlParameter("@intresult", 0);
    //    param[3].Direction = ParameterDirection.Output;
    //    int res = objdut.ExecuteSqlSP(param, "usp_LogUserActivity");
    //    if (res == 1)
    //    {
    //        return;
    //    }
    //}

    protected string FormatActivity(string activity, string pageUrl)
    {
        if (string.IsNullOrEmpty(pageUrl))
            return activity;
        else
            return string.Format(@"<a href=""{0}"">{1}</a>", pageUrl, activity);
    }

    protected string FormatLastUpdatedDate(DateTime lastUpdateDate, DateTime currentDate)
    {
        TimeSpan delta = currentDate.Subtract(lastUpdateDate);
        if (delta.Days > 7)
            return lastUpdateDate.ToShortDateString();
        else if (delta.Days > 1)
            return string.Format("{0} days ago", delta.Days);
        else if (delta.Days == 1)
            return string.Format("Yesterday", delta.Days);
        else if (delta.Hours > 1)
            return string.Format("{0} hours ago", delta.Hours);
        else if (delta.Hours == 1)
            return string.Format("1 hour ago", delta.Hours);
        else if (delta.Minutes > 1)
            return string.Format("{0} minutes ago", delta.Minutes);
        else if (delta.Minutes == 1)
            return string.Format("1 minute ago", delta.Minutes);
        else
            return "A few seconds ago";
    }

    protected override void OnLoad(EventArgs e)
    {
        if (string.IsNullOrEmpty(Page.Title) || string.Compare(Page.Title, "Untitled Page", true) == 0)
        {
            SiteMapNode current = SiteMap.CurrentNode;
            if (current != null)
                Page.Title = current.Title;
            else
                Page.Title = Path.GetFileNameWithoutExtension(Request.PhysicalPath);
        }

        base.OnLoad(e);
    }

    public void LogActivity(string p1, bool p2, int p3)
    {
        throw new NotImplementedException();
    }
}