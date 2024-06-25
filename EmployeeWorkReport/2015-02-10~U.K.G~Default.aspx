<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="Slideshow">
        <ItemTemplate>
            <asp:Image Width="940" Height="400" ID="Image1" ImageUrl='<%# Eval("Image") %>' runat="server" />
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>