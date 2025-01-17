<%@ Page Language="C#" Inherits="CuteEditor.EditorUtilityPage" %>

<%@ Register TagPrefix="CE" Namespace="CuteEditor" Assembly="CuteEditor" %>
<script runat="server">

    protected CuteEditor.Impl.FileStorage fs;
    protected CuteEditor.Impl.EditorProvider provider;
    protected CuteEditor.Impl.SecuritySetting secset;

    override protected void OnInit(EventArgs args)
    {
        if (Context.Request.QueryString["IsFrame"] == null)
        {
            string FrameSrc = "OuterEditorFull.aspx?IsFrame=1&" + Request.ServerVariables["QUERY_STRING"];
            CuteEditor.CEU.WriteDialogOuterFrame(Context, "[[NewTemplate]]", FrameSrc);
            Context.Response.End();
        }
        base.OnInit(args);
        this.Load += new System.EventHandler(this.Page_Load);

        fs = CuteEditor.Impl.FileStorage.CreateInstance(Context);
        provider = CuteEditor.Impl.EditorProvider.CreateInstance(Context);
        secset = provider.LoadSecurity();
    }
</script>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Page-Enter" content="blendTrans(Duration=0.1)" />
    <meta http-equiv="Page-Exit" content="blendTrans(Duration=0.1)" />
    <link href='Load.ashx?type=themecss&file=dialog.css&theme=[[_Theme_]]' type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="Load.ashx?type=dialogscript&verfix=1006&file=DialogHead.js"></script>
    <!--[if IE]>
			<link href="Load.ashx?type=style&file=IE.css" type="text/css" rel="stylesheet" />
		<![endif]-->
    <title>[[NewTemplate]]</title>
</head>
<body bgcolor="white">
    <form runat="server" id="Form1">
        <ce:editor
            id="OuterEditor"
            autoconfigure="Compact"
            showdecreasebutton="false"
            showenlargebutton="false"
            usestandarddialog="true"
            runat="server"
            disableitemlist="print,DocumentPropertyPage,ToFullPage,FromFullPage,CssStyle,InsertTemplate">
			</ce:editor>
    </form>
</body>
</html>

<script runat="server">
    void Page_Load(object sender, System.EventArgs e)
    {
        CuteEditor.ToolControl tc = OuterEditor.ToolControls["insertcustombutonhere"];
        if (tc != null)
        {
            System.Web.UI.WebControls.Image Image1 = new System.Web.UI.WebControls.Image();
            Image1.ToolTip = "Close";
            Image1.ImageUrl = "../Themes/custom/images/close.gif";
            Image1.CssClass = "CuteEditorButton";
            SetMouseEvents(Image1);
            Image1.Attributes["onclick"] = "doClose();";

            System.Web.UI.WebControls.Image Image2 = new System.Web.UI.WebControls.Image();
            Image2.ToolTip = "Add uneditable regions";
            Image2.ImageUrl = "../Themes/custom/images/noneditable.gif";
            Image2.CssClass = "CuteEditorButton";
            SetMouseEvents(Image2);
            Image2.Attributes["onclick"] = "CuteEditor_GetEditor(this).ExecCommand('noneditable');";

            tc.Control.Controls.Add(Image2);
            tc.Control.Controls.Add(Image1);
        }

        string filename = Request.QueryString["f"];

        string virtualroot = CuteEditor.EditorUtility.ProcessWebPath(Context, null, secset.TemplateGalleryPath).TrimEnd('/') + "/";
        secset.VerifyInDirectory(filename, virtualroot);

        if (!filename.EndsWith(".htm") && !filename.EndsWith(".html"))
            filename = filename + ".htm";

        if (!IsPostBack)
        {
            if (System.IO.File.Exists(HttpContext.Current.Server.MapPath(filename)))
            {
                OuterEditor.LoadHtml(filename);
            }
        }
        else
        {
            GenerateWebConfig(virtualroot);

            OuterEditor.SaveFile(filename);

            savedpanel.Visible = true;

        }
        if (OuterEditor.BrowserType == BrowserType.CompatibleIE)
        {
            OuterEditor.FullPage = true;
        }
    }

    void GenerateWebConfig(string virtualroot)
    {
        string dir = HttpContext.Current.Server.MapPath(virtualroot);
        string file = System.IO.Path.Combine(dir, "web.config");
        if (!System.IO.File.Exists(file))
        {
            System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
            doc.LoadXml(@"<configuration>
	<system.web>
		<httpHandlers>
			<add verb='*' path='*.*' type='System.Web.HttpForbiddenHandler' />
		</httpHandlers>
	</system.web>
</configuration>");
            doc.Save(file);
        }
    }

    void SetMouseEvents(WebControl control)
    {
        control.Attributes["onmouseover"] = "CuteEditor_ButtonCommandOver(this)";
        control.Attributes["onmouseout"] = "CuteEditor_ButtonCommandOut(this)";
        control.Attributes["onmousedown"] = "CuteEditor_ButtonCommandDown(this)";
        control.Attributes["onmouseup"] = "CuteEditor_ButtonCommandUp(this)";
        control.Attributes["ondragstart"] = "CuteEditor_CancelEvent()";
    }
</script>

<script language="JavaScript" type="text/javascript">
    var OxOb729 = ["postback", "Save"]; function doClose() { Window_SetDialogReturnValue(window, null); var OxOa851 = []; Window_CloseDialog(window); }; function CuteEditor_OnCommand(editor, Ox4d, Ox4e, Ox4f) { if (Ox4d.toLowerCase() == OxOb729[0] && Ox4f == OxOb729[1]) { Window_SetDialogReturnValue(window, '<%= Request.QueryString["f"]%>'); }; };
</script>

<asp:panel runat="server" visible="false" id="savedpanel">
<script language="JavaScript" type="text/javascript">
    var OxOa851 = []; Window_CloseDialog(window);
</script>
</asp:panel>