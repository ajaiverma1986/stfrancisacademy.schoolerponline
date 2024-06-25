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
            <asp:LinkButton ID="lblsetattendance" runat="server" Style="font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none; margin-left: 40px" Text="Set Attendance Manually" class="activesetattendance" ToolTip="Click here to set attendance"
                CausesValidation="false" PostBackUrl="set-attendence.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnuploadexcelsheet" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Upload Attendance Excelsheet" class="activeuploadexcelsheet" ToolTip="Click here for upload attendance excel sheet."
                CausesValidation="false" PostBackUrl="load-attendance-excel-sheet.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lblattendancedailywise" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Attendance Report" class="activemonthlyattendancereportdaily" ToolTip="Click here for attendance report"
                CausesValidation="false" PostBackUrl="daily-wise-attendance-report.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lblmonthlyattendancereport" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Attendance Report Monthly Wise" class="activemonthlyattendancereport" ToolTip="Click here for monthly attendance report"
                CausesValidation="false" PostBackUrl="attendance-report-monthly-wise.aspx"></asp:LinkButton>
        </div>
    </div>
</div>