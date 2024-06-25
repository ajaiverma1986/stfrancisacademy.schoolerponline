<%@ Control Language="C#" AutoEventWireup="true" CodeFile="parentuser.ascx.cs" Inherits="ParentPanel_parentuser" %>

<div class="student-photo_fragvbgvbvvbme">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" />
    </div>
    <div style="float: left;">
        <div class="user-deatilsgfff">
            <dl>
                <asp:Label ID="lblname" runat="server"></asp:Label>
            </dl>
        </div>
        <div class="clear">
        </div>
        <div class="user-deatilsfgfg">
            <dt>Class:</dt>
            <span>
                <asp:Label ID="lblroll" runat="server"></asp:Label>
            </span>
        </div>
        <div class="clear">
        </div>
        <div class="user-deatilsfgfg">
            <dt>Section: </dt>
            <span>
                <asp:Label ID="lblmobile" runat="server"></asp:Label>
            </span>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; margin-top: 10px;">
        <asp:Button ID="btnprofile" runat="server" Text="Profile" class="sgpt1 active0" ToolTip="Click here to see student profile"
            CausesValidation="false" PostBackUrl="~/ParentPanel/studentviewinfo.aspx" />
        <asp:Button runat="server" ID="btnEnrollment" Text="Account Details" class="sgpt1 active7"
            ToolTip="Click here to see fee details." CausesValidation="false" PostBackUrl="~/ParentPanel/studentfeedetails.aspx" />
        <asp:Button runat="server" ID="btndiscount" Text="Monthly Account Report" class="sgpt1 active56"
            ToolTip="Click here to see monthly fee details." CausesValidation="false" PostBackUrl="~/ParentPanel/stumonthfee.aspx" />
        <asp:Button ID="btnupload" runat="server" Text="Upload Activity" class="sgpt1 active2"
            ToolTip="Click here for see student attendance details" CausesValidation="false" PostBackUrl="~/ParentPanel/uploadactivity.aspx" />
        <asp:Button ID="btnnewbatch" runat="server" Text="Pay Fees" class="sgpt1 active3"
            ToolTip="Click here to see student performance"
            CausesValidation="false" PostBackUrl="~/ParentPanel/parentpay.aspx" />
    </div>
</div>