<%@ Control Language="C#" AutoEventWireup="true" CodeFile="faculty-detail.ascx.cs" Inherits="facultypath" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" runat="server"></asp:Label>
            </dl>
        </div>
        <div class="clear">
        </div>

        <div class="user-deatils">
            <dt>Mobile: </dt>
            <span>
                <asp:Label ID="lblmobile" runat="server"></asp:Label>
            </span>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; margin-top: 10px;">
        <asp:Button ID="btnprofile" runat="server" Text="Profile" class="sgpt1 active0" ToolTip="Click here to Update profile"
            PostBackUrl="~/BranchPanel/Faculty/updateprofile1.aspx" CausesValidation="false" />
        <asp:Button runat="server" ID="btnEnrollment" Text="Schedule" class="sgpt1 active7"
            ToolTip="Click here to view schedule." CausesValidation="false" />
        <asp:Button ID="btnadmission" runat="server" Text="Subjects" class="sgpt1 active1"
            ToolTip="Click here for view subject" PostBackUrl="~/BranchPanel/Faculty/facultysubject.aspx" CausesValidation="false" />
    </div>
</div>