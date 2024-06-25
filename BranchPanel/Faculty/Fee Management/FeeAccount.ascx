<%@ Control Language="C#"  AutoEventWireup="true" CodeFile="FeeAccount.ascx.cs" EnableViewState="false" Inherits="BranchPanel_Fee_Management_FeeAccount" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; padding-bottom: 8px; margin-top: 10px;">
        <div style="margin-bottom: -3px; margin-top: 10px;">

            <asp:LinkButton ID="lbtnofferedemployelist" runat="server" Style="font-size: 10pt; margin-left: 50px; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Total Overdue Fees" class="activeofferlist" ToolTip="Click here for employee list."
                CausesValidation="false" PostBackUrl="AllFeeAccount.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtncreatenewappointletter" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Daily Fee Transaction" class="activecreateappoint"
                ToolTip="Click here to appoint" CausesValidation="false" PostBackUrl="~/BranchPanel/Fee Management/DailyFeeTrans.aspx"></asp:LinkButton>

            <asp:LinkButton ID="LinkButton1" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Registration Fee Report" class="activeexemployee"
                ToolTip="Click here for see ex employee list" CausesValidation="false" PostBackUrl="~/BranchPanel/Fee Management/RegistrationFeeReport.aspx"></asp:LinkButton>

             <asp:LinkButton ID="LinkButton2" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Daily Expense Report" class="activeexemployee1"
                ToolTip="Click here for see ex employee list" CausesValidation="false" PostBackUrl="~/BranchPanel/Fee Management/DailyExpenseReport.aspx"></asp:LinkButton>
        </div>
    </div>
</div>
