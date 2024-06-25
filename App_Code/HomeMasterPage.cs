using System;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.UI;

/// <summary>
/// This Class Contain All Method Which Relates To The Master Page Of Ho
/// </summary>
public class HomeMasterPage : Control
{
    public HomeMasterPage()
    {
    }

    /// <summary>
    /// This Is Master Method Of Ho which Has One Parameter That Is Mode
    /// </summary>
    public static string MasterMethod(string Mode)
    {
        DataUtility ObjDut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[1];
        Param[0] = new SqlParameter("@Mode", Mode);
        return (Convert.ToString(ObjDut.GetScalerSP(Param, "[Usp_NewMasterProc]")));
    }

    /// <summary>
    /// This Is Master Method Of Ho which Has Two Parameter That Is Mode And Valueone
    /// </summary>
    public static string MasterMethod(string Mode, string valueone)
    {
        DataUtility ObjDut = new DataUtility();
        SqlParameter[] Param = new SqlParameter[2];
        Param[0] = new SqlParameter("@Mode", Mode);
        Param[1] = new SqlParameter("@valueone", valueone);
        return (Convert.ToString(ObjDut.GetScalerSP(Param, "[Usp_NewMasterProc]")));
    }

    /// <summary>
    /// This is For Generate Dynamic Menu By User Id.
    /// </summary>
    public string RenderMenu(string userId)
    {
        DataUtility ObjDut = new DataUtility();
        StringBuilder content = new StringBuilder();
        content.AppendFormat(@"<ul class='nav'><li class='active'><a href='../Common/Default.aspx'><i class='fa fa-dashboard icon'><b class='bg-danger'></b>
                            </i><span>Dashboard</span></a></li>");
        DataTable Dt = new DataTable();
        if (Convert.ToInt32(HttpContext.Current.Session["adBrid"]) == 0)
        {
            if (HttpContext.Current.Session["RootNode"] != null)
            {
                Dt = (DataTable)HttpContext.Current.Session["RootNode"];
            }
            else
            {
                SqlParameter[] RootParam = new SqlParameter[2];
                RootParam[0] = new SqlParameter("@UserID", userId);
                RootParam[1] = new SqlParameter("@QueryType", "GetMenuByUserId");
                Dt = ObjDut.GetDataSetSP(RootParam, "[uspLogin]").Tables[0];
                HttpContext.Current.Session["RootNode"] = Dt;
            }
        }
        else if (Convert.ToInt32(HttpContext.Current.Session["adBrid"]) != 0)
        {
            if (HttpContext.Current.Session["RootNodeBr"] != null)
            {
                Dt = (DataTable)HttpContext.Current.Session["RootNodeBr"];
            }
            else
            {
                SqlParameter[] RootParam = new SqlParameter[2];
                RootParam[0] = new SqlParameter("@UserID", userId);
                RootParam[1] = new SqlParameter("@QueryType", "GetMenuByUserId");
                Dt = ObjDut.GetDataSetSP(RootParam, "[uspLogin]").Tables[0];
                HttpContext.Current.Session["RootNodeBr"] = Dt;
            }
        }

        IEnumerable query = from d in Dt.AsEnumerable() where d.Field<int>("ParentId") == 0 select d;
        foreach (DataRow Dr in query)
        {
            content.AppendFormat(@"<li><a href='#'><i class=""{0}""><b class=""{1}""></b></i><span class='pull-right'><i class='fa fa-angle-down text'>
                             </i><i class='fa fa-angle-up text-active'></i></span><span>{2}</span> </a><ul class='nav lt'>",
                             Dr["imageurl"].ToString(), Dr["MenuClass"].ToString(), Dr["title"].ToString() + "");

            IEnumerable childNode = from d in Dt.AsEnumerable() where d.Field<int>("ParentId") == int.Parse(Dr["id"].ToString()) select d;
            foreach (DataRow DrChildNode in childNode)
            {
                string url = DrChildNode["Url"].ToString();
                url = ResolveUrl(url);
                content.AppendFormat(@"<li><a href=""{0}""><i class='fa fa-angle-right'></i><span>{1}</span> </a></li>", url, DrChildNode["title"].ToString());
            }
            content.AppendFormat(@"</ul></li>");
        }
        content.AppendFormat(@"</ul>");
        string MenuContent = content.ToString();
        return content.ToString();
    }
}