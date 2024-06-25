<%@ Control Language="C#" AutoEventWireup="true" CodeFile="admissioncontrol.ascx.cs" Inherits="BranchPanel_admissioncontrol" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/student_ad.jpg" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" Text="Student Admission" runat="server"></asp:Label>
            </dl>
        </div>
        <div class="clear">
        </div>
    </div>
    <div class="clear">
    </div>
    <asp:UpdatePanel ID="upd" runat="server">
        <ContentTemplate>
            <div style="margin-bottom: -3px; margin-top: 10px;">
                <asp:Button ID="btnstudentlist" runat="server" Text="Student List" class="sgpt1 active0"
                    CausesValidation="false" OnClick="btnstudentlist_Click" PostBackUrl="~/BranchPanel/studentadmissionlistaspx.aspx" />
                <asp:Button runat="server" ID="btnadmission" Text="New Admission" class="sgpt1 active4"
                    CausesValidation="false" OnClick="btnadmission_Click" PostBackUrl="~/BranchPanel/student-admission-form.aspx" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>