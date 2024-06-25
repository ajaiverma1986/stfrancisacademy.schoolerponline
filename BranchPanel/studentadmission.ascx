<%@ Control Language="C#" AutoEventWireup="true" CodeFile="studentadmission.ascx.cs" Inherits="BranchPanel_studentadmission" %>

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
            <dt>Roll No:</dt>
            <span>
                <asp:Label ID="lblroll" runat="server"></asp:Label>
            </span>
        </div>
        <div class="clear">
        </div>
        <div class="user-deatils">
            <dt>Mobile: </dt>
            <span>
                <asp:Label ID="lblmobile" runat="server"></asp:Label>
            </span>
        </div>
        <div class="user-deatils" style="display: none">
            <%--  use for transport--%>
            <dt>class: </dt>
            <span>
                <asp:Label ID="lblclasss" runat="server" Style="display: none"></asp:Label>
            </span>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; margin-top: 10px;">
        <asp:Button ID="btnprofile" runat="server" Text="Profile" class="sgpt1 active0" ToolTip="Click here to Update student profile"
            CausesValidation="false" OnClick="btnprofile_Click" />
        <asp:Button runat="server" ID="btnEnrollment" Text="Admission" class="sgpt1 active7"
            ToolTip="Click here to see fee details." CausesValidation="false" PostBackUrl="~/BranchPanel/studentfees.aspx" />

        <asp:Button ID="btnadmission" runat="server" Text="Attendance" Visible="false" class="sgpt1 active2"
            ToolTip="Click here for see student attendance details" CausesValidation="false" PostBackUrl="~/BranchPanel/studentattendance.aspx" />
        <asp:Button ID="btnnewbatch" runat="server" Text=" Performance" Visible="false" class="sgpt1 active3"
            ToolTip="Click here to see student performance"
            CausesValidation="false" PostBackUrl="~/BranchPanel/studentperformance.aspx" />
        <asp:Button ID="btnatten" runat="server" Text="Results" Visible="false" class="sgpt1 active4"
            ToolTip="Click here for student Attendance" CausesValidation="false" />
        <asp:Button ID="btnper" runat="server" Text="Parent Details" class="sgpt1 active5" ToolTip="Click here to see parent details"
            CausesValidation="false" PostBackUrl="~/BranchPanel/Parentsinfo.aspx" />
        <asp:Button ID="btngd" runat="server" Text="Login details" class="sgpt1 active6" ToolTip="Click here for login details"
            CausesValidation="false" PostBackUrl="~/BranchPanel/student-login.aspx" />
        <asp:Button ID="Button1" runat="server" Text="View Complete Details" class="sgpt1 active8" ToolTip="Click here to see student full information"
            CausesValidation="false" OnClick="Button1_Click" />
        <asp:Button ID="btntransport" runat="server" Text="Transportation details" class="sgpt1 active61" ToolTip="Click here for Transportation details"
            CausesValidation="false" PostBackUrl="~/BranchPanel/transportdetail.aspx" />
    </div>
</div>