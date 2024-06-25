
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="student-admission-list.ascx.cs" Inherits="BranchPanel_StudentManagement_student_admission_list" %>
<div class="student-photo_frame">
    <style>
        .user-deatils dt {
            width: 106px !important;
        }
    </style>
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" />
    </div>
    <div class="fee-stdent">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" runat="server"></asp:Label>
            </dl>
        </div>
        <div class="clear">
        </div>
        <div class="user-deatils">
            <dt>Admission No:</dt>
            <span>
                <asp:Label ID="lblAdmissionNo" runat="server"></asp:Label>
            </span>
        </div>
        <div class="clear">
        </div>
        <div class="user-deatils">
            <dt>Active Class:</dt>
            <span>
                <asp:Label ID="lblActiveClass" runat="server"></asp:Label>
            </span>
        </div>
        <div class="clear"></div>
        <div class="user-deatils">
            <dt>Parent Mobile: </dt>
            <span>
                <asp:Label ID="lblpmobile" runat="server"></asp:Label>
            </span>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; margin-top: 10px;">
        <asp:Button ID="btnprofile" runat="server" Text="Student Profile" class="userControlTab activestudentprofile" ToolTip="Click here to Update student profile" OnClick="btnprofile_Click" CausesValidation="false" />      
        <asp:Button ID="btnadmission" runat="server" Text="Admission Details" class="userControlTab activestudentadmissionlist" ToolTip="Click here for student Admission" CausesValidation="false" OnClick="btnadmission_Click" />
        <asp:Button ID="btnDiscount" runat="server" Text="Discount Details" class="userControlTab activestudentdiscountdetails" ToolTip="Click here" CausesValidation="false" OnClick="btnDiscount_Click" />
        <asp:Button ID="btnTrasport" runat="server" Text="Transportation Details" class="userControlTab activestudenttransport" ToolTip="Click here" CausesValidation="false" OnClick="btnTrasport_Click" />
        <asp:Button ID="btnbookdetails" runat="server" Text="Library Details" class="userControlTab activestudentlibrary" ToolTip="Click here" CausesValidation="false" OnClick="btnbookdetails_Click" />
        <asp:Button ID="btnstudentperformance" runat="server" Text="Student Performance" class="userControlTab activestudentperformance" ToolTip="Click here" CausesValidation="false" OnClick="btnstudentperformance_Click" />
        <asp:Button ID="btnhostel" runat="server" Text="Hostel Detail" class="userControlTab activestudenthostel" ToolTip="Click here" CausesValidation="false" OnClick="btnhostel_Click" />
    </div>
    <asp:HiddenField ID="hdnregistrationno" runat="server" />
     <asp:HiddenField ID="hdnRID" runat="server" />
    <script type="text/javascript">
       
    </script>
</div>