<%@ Control Language="C#" AutoEventWireup="true" CodeFile="view-time-table.ascx.cs" Inherits="BranchPanel_view_time_table" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/time-table.png" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" runat="server">View TimeTable Master</asp:Label>
            </dl>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; padding-bottom: 8px; margin-top: 10px;">

        <div style="margin-bottom: -3px; margin-top: 10px;">

            <asp:LinkButton ID="lbtndefaulttimetable" runat="server" Style="font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none; margin-left: 20px !important;" Text="Day wise TimeTable" class="activedefaulttimetable" ToolTip="Click here to view  Registration list"
                CausesValidation="false" PostBackUrl="default-view-timetable.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnclasstimetable" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Class wise TimeTable" class="activeclasstimetable" ToolTip="Click here to view  Registration list"
                CausesValidation="false" PostBackUrl="class-view-timetable.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnteachertimetable" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Teacher wise TimeTable" class="activeteachertimetable"
                CausesValidation="false" PostBackUrl="teacher-view-timetable.aspx"></asp:LinkButton>
        </div>
    </div>
</div>