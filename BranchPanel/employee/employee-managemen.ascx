<%@ Control Language="C#" AutoEventWireup="true" CodeFile="employee-managemen.ascx.cs" Inherits="branchpanel_employee_employee_managemen" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/employeeimage/9update.png" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" runat="server">Employee Management</asp:Label>
            </dl>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; padding-bottom: 8px; margin-top: 10px;">
        <div style="margin-bottom: -3px; margin-top: 10px;">

            <asp:LinkButton ID="lbtnofferedemployelist" runat="server" Style="font-size: 10pt; margin-left: 50px; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Employee List" class="activeofferlist" ToolTip="Click here for employee list."
                CausesValidation="false" PostBackUrl="employee-list.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtncreatenewappointletter" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Add Employee" class="activecreateappoint"
                ToolTip="Click here to appoint" CausesValidation="false" PostBackUrl="create-new-appoint-letter.aspx"></asp:LinkButton>

            <asp:LinkButton ID="LinkButton1" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Ex Employee List" class="activeexemployee"
                ToolTip="Click here for see ex employee list" CausesValidation="false" PostBackUrl="ex-employee-list.aspx"></asp:LinkButton>
        </div>
    </div>
</div>