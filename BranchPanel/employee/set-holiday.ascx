<%@ Control Language="C#" AutoEventWireup="true" CodeFile="set-holiday.ascx.cs" Inherits="BranchPanel_set_holiday" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/Holiday.png" AlternateText="Sorry No Image" />
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

            <asp:LinkButton ID="lbtnsetocasionallyholiday" runat="server" Style="font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Set Occasionally Holiday" class="activeocassionallyholiday" ToolTip="Click here to set occasionally holiday"
                CausesValidation="false" PostBackUrl="holiday-management.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnsetweeklyoffholiday" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Set Weekly Holiday" class="activeweeklyholiday" ToolTip="Click here to set occasionally holiday"
                CausesValidation="false" PostBackUrl="set-weekly-holiday.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnholidayreport" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="List Of Holiday" class="activelistofholiday"
                CausesValidation="false" PostBackUrl="list-of-holiday.aspx"></asp:LinkButton>
        </div>
    </div>
</div>