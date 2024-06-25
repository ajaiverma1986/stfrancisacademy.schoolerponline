<%@ Control Language="C#" AutoEventWireup="true" CodeFile="shortlist-management.ascx.cs" Inherits="branchpanel_employee_shortlist_management" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/employeeimage/9update.png" AlternateText="Sorry No Image" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" runat="server">Shortlisted Candidates</asp:Label>
            </dl>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; padding-bottom: 8px; margin-top: 10px;">
        <div style="margin-bottom: -3px; margin-top: 10px;">

            <asp:LinkButton ID="lbtnshorlistlist" runat="server" Style="font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none; margin-left: 20px !important;" Text="Shortlisted Candidates List" class="activeshortlistlist" ToolTip="Click here for shortlisted candidates list"
                CausesValidation="false" PostBackUrl="shortlisted-candidates-list.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtncreatenewshortlist" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Add Shortlisted Candidates" class="activecreateshortlist"
                ToolTip="Click here to add shortlisted candidates" CausesValidation="false" PostBackUrl="add-new-shortlist-candidates.aspx"></asp:LinkButton>
        </div>
    </div>
</div>