<%@ Control Language="C#" AutoEventWireup="true" CodeFile="teacher.ascx.cs" Inherits="TeacherPanel_teacher" %>
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
        <asp:Button ID="btnprofile" runat="server" Text="Profile" class="sgpt1 active0" ToolTip="Click here to See Your profile"
            CausesValidation="false" PostBackUrl="Profile.aspx" />

        <asp:Button ID="Button1" runat="server" Text="Subject" class="sgpt1 active2" ToolTip="Click here to See Your Subject and Class detail"
            CausesValidation="false" PostBackUrl="facultySubjects.aspx" />

        <asp:Button runat="server" ID="btncontent" Text="Course Content"
            class="sgpt1 active71" ToolTip="Click here to view  Lecture schedule." CausesValidation="false" PostBackUrl="~/TeacherPanel/coursecountent.aspx" />

        <asp:Button runat="server" ID="btnEnrollment" Text="Lecture Schedule" PostBackUrl="Schedule.aspx"
            class="sgpt1 active7" ToolTip="Click here to view  Lecture schedule." CausesValidation="false" />

        <asp:Button runat="server" ID="BtnUploadAssignment" Text="Upload Assignment" PostBackUrl="upload-assignment.aspx"
            class="sgpt1 active8" ToolTip="Click Here to View  Uplaoded Assignment ." CausesValidation="false" />

        <%--           <asp:Button ID="btntask" runat="server" Text="Task" PostBackUrl="~/TeacherPanel/TaskList.aspx"
            class="sgpt1 active17" ToolTip="Click here To see your Login detail" CausesValidation="false" />--%>

        <%-- <asp:Button ID="btnadmission" runat="server" Text="Login Details" PostBackUrl="logindetail.aspx"
            class="sgpt1 active1" ToolTip="Click here To see your Login detail" CausesValidation="false" />--%>

        <%--  <asp:Button ID="Button2" runat="server" Text="Salary Details"
            class="sgpt1 active12" ToolTip="Click here for Salary Detail"
            CausesValidation="false" onclick="Button2_Click"
            PostBackUrl="~/TeacherPanel/fxsalaryreport.aspx" />--%>
    </div>
</div>