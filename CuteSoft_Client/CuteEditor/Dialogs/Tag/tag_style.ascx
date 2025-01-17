<%@ Control Inherits="CuteEditor.EditorUtilityCtrl" Language="c#" AutoEventWireup="false" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="uc1" TagName="Tag_Style_Font" Src="Tag_Style_Font.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Tag_Style_Background" Src="Tag_Style_Background.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Tag_Style_Text" Src="Tag_Style_Text.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Tag_Style_Other" Src="Tag_Style_Other.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Tag_Style_List" Src="Tag_Style_List.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Tag_Style_Border" Src="Tag_Style_Border.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Tag_Style_Layout" Src="Tag_Style_Layout.ascx" %>
<%
    object[] p1 = { "Font", "[[Font]]" };
    object[] p2 = { "Text", "[[Text]]" };
    object[] p4 = { "Border", "[[Border]]" };
    object[] p5 = { "Layout", "[[Layout]]" };
    object[] p3 = { "Background", "[[Background]]" };
    object[] p6 = { "Other", "[[Other]]" };
    object[] ps = { p1, p2, p3, p4, p5, p6 };
    string activepanel = Context.Request.QueryString["Style"];
    if (activepanel == null || activepanel == "") activepanel = "Font";
    Control panel = FindControl("Panel" + activepanel);
    panel.Visible = true;
    string activetext = "";
%>

<script type="text/javascript" src="Load.ashx?type=dialogscript&verfix=1006&file=Dialog_Tag_Style.js"></script>

<table border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;width:99%">
	<tr>
		<td style="width:90px;vertical-align:top" id="navtd">
			<%
                foreach (object[] px in ps)
                {
                    string pname = px[0].ToString();
                    string ptext = px[1].ToString();
                    bool iscurrent = activepanel == pname;
                    if (iscurrent) activetext = ptext;
			%>
			<div class='buttons'><a <%=iscurrent?"class='current'":""%>' href='<%=CuteEditor.EditorUtility.ReplaceParam(Context.Request.RawUrl,"Style",pname)%>'>
				<img alt="" src="Load.ashx?type=image&file=style.<%=pname%>.gif" />
				<%=ptext%>
			</a>
			</div>
			<%
            }
			%>
		</td>
		<td style="white-space:nowrap;width:3px" ></td>
		<td>
			<uc1:Tag_Style_Font id="PanelFont" runat="server" Visible="False"></uc1:Tag_Style_Font>
			<uc1:Tag_Style_Background id="PanelBackground" runat="server" Visible="False"></uc1:Tag_Style_Background>
			<uc1:Tag_Style_Text id="PanelText" runat="server" Visible="False"></uc1:Tag_Style_Text>
			<uc1:Tag_Style_Border id="PanelBorder" runat="server" Visible="False"></uc1:Tag_Style_Border>
			<uc1:Tag_Style_Layout id="PanelLayout" runat="server" Visible="False"></uc1:Tag_Style_Layout>
			<uc1:Tag_Style_List id="PanelList" runat="server" Visible="False"></uc1:Tag_Style_List>
			<uc1:Tag_Style_Other id="PanelOther" runat="server" Visible="False"></uc1:Tag_Style_Other>
		</td>
	</tr>
</table>
<script type="text/javascript">
    var OxOb6d9 = ["ondblclick", "navtd", "shiftKey", "style"]; Window_GetElement(window, OxOb6d9[1], true)[OxOb6d9[0]] = function () { if (event[OxOb6d9[2]]) { alert(element[OxOb6d9[3]].cssText); }; };
</script>