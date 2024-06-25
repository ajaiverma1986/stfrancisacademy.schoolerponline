<%@ Control Language="C#" AutoEventWireup="true" CodeFile="set-holiday.ascx.cs" Inherits="BranchPanel_set_holiday" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/Holiday.png" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" runat="server">Holiday Management</asp:Label>
            </dl>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; padding-bottom: 8px; margin-top: 10px;">

        <div style="margin-bottom: -3px; margin-top: 10px;">

            <asp:LinkButton ID="lbtnsetocasionallyholiday" runat="server" Text="Set Occasionally Holiday" class="sgpt1 activeocassionallyholiday" ToolTip="Click here to set occasionally holiday"
                CausesValidation="false" PostBackUrl="holiday-management.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnsetweeklyoffholiday" runat="server" Text="Set Weekly Holiday" class="sgpt1 activeweeklyholiday" ToolTip="Click here to set occasionally holiday"
                CausesValidation="false" PostBackUrl="set-weekly-holiday.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnholidayreport" runat="server" Text="List Of Holiday" class="sgpt1 activelistofholiday"
                CausesValidation="false" PostBackUrl="~/BranchPanel/list-of-holiday.aspx"></asp:LinkButton>
        </div>
    </div>
</div>