<%@ Page Title="View TimeTable" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="MasterTime.aspx.cs" Inherits="BranchPanel_MasterTime" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_cont" id="contentPane">
    </div>

    <div class="content_top" style="margin-bottom: 20px;">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Time Table</a></li>
            <li style="background: none;"><a class="active" href="#">
                <asp:Label runat="server" ID="lblHead" Text="View TimeTable"></asp:Label></a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px; margin-right: 0px;"></iframe>
        </div>
    </div>

    <asp:Button ID="btn1" runat="server" Text="Class Timetable" CssClass="button_save"
        ToolTip="Click here to view Class timetable." OnClick="btn1_Click" />

    <asp:Button ID="btn2" runat="server" Text="Teacher Timetable"
        CssClass="button_save" ToolTip="Click here to view teacher timetable."
        OnClick="btn2_Click" />
</asp:Content>