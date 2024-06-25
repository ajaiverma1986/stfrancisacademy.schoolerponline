<%@ Control Language="C#" AutoEventWireup="true" CodeFile="emp-salary.ascx.cs" Inherits="HO_emp_salary" %>
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
            <dt>Code:</dt>
            <span>
                <asp:Label ID="lblempcode" runat="server"></asp:Label>
            </span>
        </div>
        <div class="clear">
        </div>
        <div class="user-deatils">
            <dt>Dept:</dt>
            <span>
                <asp:Label ID="lbldept" runat="server"></asp:Label>
            </span>
        </div>
        <div class="clear">
        </div>
        <div class="user-deatils">
            <dt>Desig:</dt>
            <span>
                <asp:Label ID="lbldesig" runat="server"></asp:Label>
            </span>
        </div>
        <div class="clear">
        </div>
        <div class="user-deatils">
            <dt>Mobile:</dt>
            <span>
                <asp:Label ID="lblmobile" runat="server"></asp:Label>
            </span>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; margin-top: 10px;">
        <asp:Button ID="btnadmission" runat="server" Text="View Profile" class="sgpt1 active1"
            ToolTip="Click here for view subject" OnClick="btnadmission_Click" CausesValidation="false" />
        <asp:Button ID="btnprofile" runat="server" Text="Login Details" class="sgpt1 active7"
            ToolTip="Click here to Update profile" OnClick="btnprofile_Click" CausesValidation="false" />
        <asp:Button runat="server" ID="btnEnrollment" Text="Performance" class="sgpt1 active0"
            ToolTip="Click here to view schedule." CausesValidation="false" OnClick="btnEnrollment_Click" />
        <asp:Button ID="btnasigntask" runat="server" Text="Assign Task" CausesValidation="false" class="sgpt1 active2" PostBackUrl="~/branchpanel/employee/assigntask.aspx" />
    </div>
</div>