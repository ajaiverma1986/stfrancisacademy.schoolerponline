<%@ Control Language="C#" AutoEventWireup="true" CodeFile="transport.ascx.cs" Inherits="BranchPanel_transport" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/Transportation.png" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" Text="Transport Setting" runat="server"></asp:Label>
            </dl>
        </div>
        <div class="clear">
        </div>
    </div>
    <div class="clear">
    </div>

    <div style="margin-bottom: -3px; margin-top: 10px;">
        <asp:Button ID="btnprofile" runat="server" Text="Add Area" class="sgpt1 active0"
            CausesValidation="false" PostBackUrl="~/BranchPanel/Addarea.aspx" OnClick="btnprofile_Click" />
        <asp:Button runat="server" ID="btnEnrollment" Text="Add Road" class="sgpt1 active2"
            CausesValidation="false" PostBackUrl="~/BranchPanel/addroad.aspx" />
        <asp:Button ID="btnadmission" runat="server" PostBackUrl="~/BranchPanel/createroot.aspx" Text=" Create Route" class="sgpt1 active4"
            CausesValidation="false" />

        <asp:Button runat="server" ID="btnaddvehicle" Text="Add Vehicle" class="sgpt1   active1"
            CausesValidation="false" PostBackUrl="~/BranchPanel/AddVehicle.aspx" />
        <asp:Button ID="btnbus" runat="server" PostBackUrl="~/BranchPanel/bustoroute.aspx" Text=" Vehicle to Route" class="sgpt1 active7"
            CausesValidation="false" OnClick="btnbus_Click" />
    </div>
</div>