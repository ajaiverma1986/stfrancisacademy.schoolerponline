<%@ Control Language="C#" AutoEventWireup="true" CodeFile="attendance-management.ascx.cs" Inherits="BranchPanel_attendance_management" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/attendance-management.png" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" runat="server">Attendance Management</asp:Label>
            </dl>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; padding-bottom: 8px; margin-top: 10px;">

        <div style="margin-bottom: -3px; margin-top: 10px;">
            <asp:LinkButton ID="lblsetattendance" runat="server" Text="Set Attendance Manually" class="sgpt1 activesetattendance" ToolTip="Click here to set attendance"
                CausesValidation="false" PostBackUrl="set-attendence.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnuploadexcelsheet" runat="server" Text="Upload Attendance Excelsheet" class="sgpt1 activeuploadexcelsheet" ToolTip="Click here for upload attendance excel sheet."
                CausesValidation="false" PostBackUrl="load-attendance-excel-sheet.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lblmonthlyattendancereport" runat="server" Text="Attendance Report Monthly Wise" class="sgpt1 activemonthlyattendancereport" ToolTip="Click here for monthly attendance report"
                CausesValidation="false" PostBackUrl="attendance-report-monthly-wise.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lblattendancedailywise" runat="server" Text="Attendance Report Daily Wise" class="sgpt1 activemonthlyattendancereportdaily" ToolTip="Click here for daily attendance report"
                CausesValidation="false" PostBackUrl="daily-wise-attendance-report.aspx"></asp:LinkButton>
        </div>
    </div>
</div>