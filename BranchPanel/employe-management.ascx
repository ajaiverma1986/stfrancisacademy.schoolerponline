<%@ Control Language="C#" AutoEventWireup="true" CodeFile="employe-management.ascx.cs" Inherits="BranchPanel_employe_management" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/employeemanagement.png" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" runat="server">Employee Master</asp:Label>
            </dl>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; padding-bottom: 8px; margin-top: 10px;">
        <div style="margin-bottom: -3px; margin-top: 10px;">

            <asp:LinkButton ID="lbtnofferedemployelist" runat="server" Text="Offered Employee List" class="sgpt1 activeofferlist" ToolTip="Click here to view  Offered Employee List"
                CausesValidation="false" PostBackUrl="offered-employer-list.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnappointedemployeelist" runat="server" Text="Appointed Employee List" class="sgpt1 activeappointlist" ToolTip="Click here to view  Appointed Employee List"
                CausesValidation="false" PostBackUrl="appointed-employer-list.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtncreatenewofferletter" runat="server" Text="Create New Offer Letter" class="sgpt1 activecreateoffer"
                ToolTip="Click here to Create New Offer Letter" CausesValidation="false" PostBackUrl="create-new-offer-letter.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtncreatenewappointletter" runat="server" Text="Create New Appointment Letter" class="sgpt1 activecreateappoint"
                ToolTip="Click here to Create New Appoint Letter" CausesValidation="false" PostBackUrl="create-new-appoint-letter.aspx"></asp:LinkButton>
        </div>
    </div>
</div>