<%@ Control Language="C#" AutoEventWireup="true" CodeFile="shortlisting.ascx.cs" Inherits="BranchPanel_shortlisting" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/registrationlistdetails.png" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" runat="server">Shorlisting</asp:Label>
            </dl>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; padding-bottom: 8px; margin-top: 10px;">

        <div style="margin-bottom: -3px; margin-top: 10px;">

            <asp:LinkButton ID="lnkregistrationlist" runat="server" Style="font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none; margin-left: 10px !important" Text="Selection" class="aciveselection" ToolTip="Click here for student Selection"
                CausesValidation="false" PostBackUrl="selection.aspx"></asp:LinkButton>

            <asp:LinkButton ID="btnshortlistedlist" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Shortlisted Candidate List" class="activesortlist"
                CausesValidation="false" PostBackUrl="shortlisted-student-list.aspx"></asp:LinkButton>

            <asp:LinkButton ID="btnrejectedlist" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Rejected Candidate List" class="activereject"
                CausesValidation="false" PostBackUrl="rejected-student-list.aspx"></asp:LinkButton>

            <asp:LinkButton ID="btwaitingstudent" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Waiting Candidate List" class="activea15"
                CausesValidation="false" PostBackUrl="waiting-student-list.aspx"></asp:LinkButton>
        </div>
    </div>
</div>