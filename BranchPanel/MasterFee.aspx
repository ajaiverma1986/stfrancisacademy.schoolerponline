<%@ Page Title="Fee Master" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="MasterFee.aspx.cs" Inherits="BranchPanel_MasterFee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Fees Managment</a></li>
            <li style="background: none;"><a class="active" href="#">Fee Report</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px; margin-right: 0px;"></iframe>
        </div>
    </div>
    <div class="clear"></div>
    <div class="content_pane_cont" id="contentPane">

        <asp:UpdatePanel runat="server" ID="upd1">
            <ContentTemplate>

                <asp:Button ID="btn1" runat="server" Text="Recent" CssClass="button_save"
                    ToolTip="Click here to see most recently paid fee."
                    OnClick="btn1_Click" />

                <asp:Button ID="btn2" runat="server" Text="Monthly Fee" CssClass="button_save"
                    ToolTip="Click here to see fee report monthwise." OnClick="btn2_Click" />
                <asp:Button ID="btn3" runat="server" Text="Class Fee"
                    CssClass="button_save"
                    ToolTip="Click here to see fee details classwise." OnClick="btn3_Click" />
                <asp:Button ID="btn4" runat="server" Text="Duration"
                    CssClass="button_save"
                    ToolTip="Click here to see fee durationwise." OnClick="btn4_Click" />
                <asp:Button ID="btn5" runat="server" Text="Student"
                    CssClass="button_save"
                    ToolTip="Click here to see fee studentwise." OnClick="btn5_Click" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>