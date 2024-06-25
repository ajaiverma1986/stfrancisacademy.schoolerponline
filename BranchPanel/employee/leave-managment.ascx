<%@ Control Language="C#" AutoEventWireup="true" CodeFile="leave-managment.ascx.cs" Inherits="leave_managment" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/leavemanagement.jpg" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" runat="server">Leave Management</asp:Label>
            </dl>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; padding-bottom: 8px; margin-top: 10px;">

        <div style="margin-bottom: -3px; margin-top: 10px;">
            <asp:LinkButton ID="lbtnsetweeklyoffholiday" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Applied Leaves" class="oldleave" ToolTip="Get Old Applied Leaves"
                CausesValidation="false" PostBackUrl="requestleavelist.aspx"></asp:LinkButton>
            <asp:LinkButton ID="lnkhalfday" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Applied Half Day" class="halfday" ToolTip="Applied Half Day Leaves"
                CausesValidation="false" PostBackUrl="halfday-list.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnholidayreport" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Get Leave History" class="leavehistory"
                CausesValidation="false" PostBackUrl="leavehistory.aspx"></asp:LinkButton>
            <asp:LinkButton ID="lbtnsetocasionallyholiday" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Advance Paid Leave" class="todayleave" ToolTip="Advance Paid Leave"
                CausesValidation="false" PostBackUrl="advance-leave.aspx"></asp:LinkButton>
            <asp:LinkButton ID="lnladdeditleave" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Add New Leave" class="addedit"
                CausesValidation="false" PostBackUrl="add-eidtleave.aspx"></asp:LinkButton>
        </div>
    </div>
</div>