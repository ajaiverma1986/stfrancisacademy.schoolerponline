<%@ Control Language="C#" AutoEventWireup="true" CodeFile="feeset.ascx.cs" Inherits="BranchPanel_feeset" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/fee_management.png" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" Text="Fee Setting" runat="server"></asp:Label>
            </dl>
        </div>
        <div class="clear">
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; margin-top: 10px;">
        <asp:Button ID="btnprofile" runat="server" Text="Applicable Fee" class="sgpt1 active0"
            CausesValidation="false" PostBackUrl="~/BranchPanel/feesSetting.aspx" />
        <asp:Button runat="server" ID="btnEnrollment" Text="Set Fee" class="sgpt1 active7"
            CausesValidation="false" PostBackUrl="~/BranchPanel/FeeAmountSetting.aspx" />
    </div>
</div>