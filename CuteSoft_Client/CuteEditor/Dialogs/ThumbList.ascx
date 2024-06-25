<%@ Control Language="c#" Inherits="CuteEditor.Dialogs.ThumbList" %>

<asp:DataList ID="MyList" RepeatDirection="Horizontal" Width="99%" HorizontalAlign="Center" Height="300" RepeatColumns="4" CellSpacing="0" runat="server" EnableViewState="true" OnItemDataBound="Item_DataBound">

    <ItemStyle HorizontalAlign="Center"></ItemStyle>
    <FooterStyle HorizontalAlign="Center"></FooterStyle>

    <ItemTemplate>
        <img class="spring_image" onload="render_spring_image(this)" onclick="insert(this.getAttribute('Url'))" title=""
            src="<%# ThumbUrl((String)(DataBinder.Eval(Container.DataItem,"Path"))) %>"
            tooltip="<nobr><%# String_Name%>: <%# DataBinder.Eval(Container.DataItem, "Name")%></nobr><br /><nobr><%# String_Size%>: <%# ( Convert.ToInt32(DataBinder.Eval(Container.DataItem, "Length")) /1024).ToString("n0")%> KB</nobr><br /><nobr><%# String_Createddate%>: <%# DataBinder.Eval(Container.DataItem, "CreationTime") %></nobr><br /><nobr><%# String_Modifieddate%>: <%# DataBinder.Eval(Container.DataItem, "LastWriteTime")%></nobr>"
            url="<%# DataBinder.Eval(Container.DataItem,"Url") %>" />
    </ItemTemplate>

    <FooterTemplate>
        <%# NumImagesDisplayed()%>
        <asp:PlaceHolder ID="plLinks" runat="server"></asp:PlaceHolder>
    </FooterTemplate>
</asp:DataList>

<input id="hdnCurPage" type="hidden" runat="server" />
<input id="hdnPrevPath" type="hidden" runat="server" />