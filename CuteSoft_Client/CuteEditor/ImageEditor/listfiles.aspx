<%@ Page %>

<%@ Import Namespace="CuteEditor.ImageEditor" %>
<script language="C#" runat="server">

    void Page_Load(object sender, System.EventArgs e)
    {
        ListFiles dw = new ListFiles(this.Page.Request.QueryString.Get("filepath"), this.Page.Request.QueryString.Get("idname"), this.Page.Request.QueryString.Get("gid"));
    }
</script>