<%@ Page Title="Master S" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="MasterS.aspx.cs" Inherits="BranchPanel_MasterS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_cont" id="contentPane">
    </div>
    <div class="content_top" style="margin-bottom: 20px;">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Master Settings</a></li>
            <li style="background: none;"><a class="active" href="#">
                <asp:Label runat="server" ID="lblHead"></asp:Label></a></li>
        </ul>
    </div>

    <asp:Button ID="btn1" runat="server" Text="Applicable Fee" CssClass="button_save" OnClick="btn1_Click" />

    <asp:Button ID="btn2" runat="server" Text="Set Fee" CssClass="button_save" OnClick="btn2_Click" />
    <asp:Button ID="btn3" runat="server" Text="Transport Fee" CssClass="button_save" OnClick="btn3_Click" />

    <div class="clear">
    </div>
</asp:Content>