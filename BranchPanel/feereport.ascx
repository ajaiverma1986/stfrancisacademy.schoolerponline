<%@ Control Language="C#" AutoEventWireup="true" CodeFile="feereport.ascx.cs" Inherits="BranchPanel_feereport" %>
<%@ OutputCache Duration='120'
    VaryByParam='none' %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/doll.jpg" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" Text="Fee Reports" runat="server"></asp:Label>
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
                <asp:Button ID="btnprofile" runat="server" Text="Overall Student Collection" class="sgpt1 active0"
                    CausesValidation="false" PostBackUrl="~/BranchPanel/Recentfee.aspx" />
                <asp:Button runat="server" ID="btnEnrollment" Text="Fee Collection" class="sgpt1 active4"
                    CausesValidation="false" Visible="false" PostBackUrl="~/BranchPanel/MonthWiseFee.aspx" />
                <asp:Button ID="btnadmission" runat="server" PostBackUrl="~/BranchPanel/ClassFee.aspx" Visible="false" Text="Class Fee Report" class="sgpt1 active2"
                    CausesValidation="false" />
                <asp:Button ID="btnreport" runat="server" Text="Student Fee Collection" Visible="false" class="sgpt1 active71"
                    CausesValidation="false" PostBackUrl="~/BranchPanel/stufeereport.aspx" OnClick="btnreport_Click" />

                <asp:Button runat="server" ID="btnaddvehicle" Text="Duration" Visible="false" class="sgpt1   active1"
                    CausesValidation="false" PostBackUrl="~/BranchPanel/FeeDuration.aspx" />
                <asp:Button ID="btnbus" runat="server" PostBackUrl="~/BranchPanel/getDistID.aspx?type=FS" Visible="false" Text="Pay Fee" class="sgpt1 active7"
                    CausesValidation="false" />
                <asp:Button ID="btnfeetype" runat="server" Text="Fee Type Collection" Visible="false" class="sgpt1 active98"
                    CausesValidation="false" PostBackUrl="~/BranchPanel/feetypereport.aspx" />
                <asp:Button ID="Button1" runat="server" Text="Discount fee Collection" Visible="false" class="sgpt1 active96"
                    CausesValidation="false" PostBackUrl="~/BranchPanel/discount_report.aspx" />
                <asp:Button ID="Button2" runat="server" Text="OverDueList" class="sgpt1 active66"
                    CausesValidation="false" PostBackUrl="~/BranchPanel/OverDueList.aspx" />
                <asp:Button ID="btntransaction" runat="server" Text="Transaction Report" class="sgpt1 active69"
                    CausesValidation="false" PostBackUrl="~/BranchPanel/transactiondetail.aspx" />
                <asp:Button ID="chequentn" runat="server" Text="DD/Cheque List" class="sgpt1 active695"
                    CausesValidation="false" PostBackUrl="~/BranchPanel/cheque-list.aspx" />
                <asp:Button ID="btndue" runat="server" Text="Due Report" class="sgpt1 active696"
                    CausesValidation="false" PostBackUrl="~/BranchPanel/duelist.aspx" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>