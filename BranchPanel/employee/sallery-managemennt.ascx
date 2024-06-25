<%@ Control Language="C#" AutoEventWireup="true" CodeFile="sallery-managemennt.ascx.cs" Inherits="branchpanel_employee_sallery_managemennt" %>
<div class="student-photo_frame">
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/sallery-management.png" AlternateText="Sorry No Image" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" runat="server">Payroll Management</asp:Label>
            </dl>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; padding-bottom: 8px; margin-top: 10px;">
        <div style="margin-bottom: -3px; margin-top: 10px;">

            <asp:LinkButton ID="lbtnmonthlyreport" runat="server" Style="font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none; margin-left: 20px !important;" Text="Monthly Salary Report" class="activemonthly" ToolTip="Click here to see monthly salary report"
                CausesValidation="false" PostBackUrl="monthly-sallery-report.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnyearlyreport" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Yearly Salary Report" class="activeyearlyreport"
                ToolTip="Click here to see yearly salary report" CausesValidation="false" PostBackUrl="yearly-salary-report.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnadvancesalleryreport" runat="server" Style="font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none; margin-left: 20px !important;" Text="Advance Salary Report" class="activeadvance" ToolTip="Click here to see total advance salary report"
                CausesValidation="false" PostBackUrl="advance-salary-report.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnemployeedeductionreport" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Monthly Tax Report" class="activeemployeededuction"
                ToolTip="Click here to see total employee deduction report" CausesValidation="false" PostBackUrl="monthly-tax-report.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtntaxdeductionreport" runat="server" Style="font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none; margin-left: 20px !important;" Text="Salary Deduction Report" class="activetaxdeduction" ToolTip="Click here to see total salary deduction report"
                CausesValidation="false" PostBackUrl="salary-deduction-report.aspx"></asp:LinkButton>

            <%--<asp:LinkButton ID="lbtncompanypayabletaxreport" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Company Payable Tax" class="activecompanypayable"
                ToolTip="Click here to see company payable tax report" CausesValidation="false" PostBackUrl="companypayable-tax-report.aspx"></asp:LinkButton>

             <asp:LinkButton ID="lbtntotaltaxreport" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Total Tax" class="activetotaltax"
                ToolTip="Click here to see total tax report" CausesValidation="false" PostBackUrl="total-tax-report.aspx"></asp:LinkButton>--%>
        </div>
    </div>
</div>