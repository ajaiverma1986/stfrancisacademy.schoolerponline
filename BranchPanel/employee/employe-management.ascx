<%@ Control Language="C#" AutoEventWireup="true" CodeFile="employe-management.ascx.cs" Inherits="BranchPanel_employe_management" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/offerjobdemo.png" AlternateText="Sorry No Image" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" runat="server">offer job</asp:Label>
            </dl>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; padding-bottom: 8px; margin-top: 10px;">
        <div style="margin-bottom: -3px; margin-top: 10px;">

            <asp:LinkButton ID="lbtnofferedemployelist" runat="server" Style="font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Offer Letter List" class="activeofferlist" ToolTip="Click here for offer letter list"
                CausesValidation="false" PostBackUrl="offered-employer-list.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtncreatenewofferletter" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Create Offer Letter" class="activecreateoffer"
                ToolTip="Click here to create  offer letter" CausesValidation="false" PostBackUrl="create-new-offer-letter.aspx"></asp:LinkButton>
        </div>
    </div>
</div>