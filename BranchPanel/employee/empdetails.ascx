<%@ Control Language="C#" AutoEventWireup="true" CodeFile="empdetails.ascx.cs" Inherits="branchpanel_employee_empdetails" %>
<style>
    .emp {
        background: none repeat scroll 0 0 #e2e2e2;
        border-bottom: 1px solid #ccc;
        height: auto;
        margin-bottom: 30px;
        width: 100%;
        display: none;
    }

        .emp dl {
            color: #2d9fdd;
            float: left;
            font-size: 20px;
            margin-bottom: 7px;
            margin-top: 10px;
        }
</style>
<div class="emp">
    <style>
        .user-deatils span {
            margin-top: 3px;
        }
    </style>
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/images/employeemanagement.png" AlternateText="Sorry No Image." />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl style="text-transform: capitalize">
                <asp:Label ID="lblname" runat="server" Text="Amit Kumar Sharma"></asp:Label>
            </dl>
        </div>
        <div class="clear">
        </div>
        <div class="user-deatils">
            <span style="font-size: 14px !important;">Mobile No:</span>
            <span style="float: right; margin-left: 10px ! important">
                <asp:Label ID="lblmobile" runat="server" Text="7827739166"></asp:Label>
            </span>
        </div>

        <div class="clear"></div>
        <div class="user-deatils">
            <span style="font-size: 14px !important;">Department:</span>
            <span style="float: right; margin-left: 10px ! important">
                <asp:Label ID="lbldepartment" runat="server" Text="Teacher"></asp:Label>
            </span>
        </div>

        <div class="clear"></div>
        <div class="user-deatils">
            <span style="font-size: 14px !important;">Designation:</span>
            <span style="float: right; margin-left: 10px ! important">
                <asp:Label ID="lbldesignation" runat="server" Text="Teacher"></asp:Label>
            </span>
        </div>
    </div>

    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; padding-bottom: 8px; margin-top: 10px;">
        <div style="margin-bottom: -3px; margin-top: 10px;">
            <asp:LinkButton ID="lbtnprofile" runat="server" Style="font-size: 10pt; font-weight: bold; background-color: none; margin-left: 20px !important; color: black; text-decoration: none; margin-left: 20px !important" Text="My Account" class="activeprofile" ToolTip="Click here for view And update profile"
                CausesValidation="false" PostBackUrl="emp-profile.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtncalculatesallery" runat="server" Style="font-size: 10pt; margin-left: 15px!important; font-weight: bold; background-color: none; color: black; text-decoration: none; margin-left: 30px !important" Text="Salary" class="activecalculatesallery" ToolTip="Click here for calculate sallery"
                CausesValidation="false" PostBackUrl="calculate-sallery.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnmonthwiseattendance" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none; margin-left: 30px !important" Text="Attendance" class="activemonthwiseattendance"
                ToolTip="click here for see attendance report" CausesValidation="false" PostBackUrl="monthly-attendance-report.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnworkreport" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none; margin-left: 30px !important" Text="Task" class="activetaskmanagement"
                ToolTip="Click here for task management" CausesValidation="false" PostBackUrl="task-report.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnleavereport" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none; margin-left: 30px !important" Text="Leave" class="activeleavereport"
                ToolTip="Click here for leave management" CausesValidation="false" PostBackUrl="leave-report.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnperformance" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none; margin-left: 30px !important" Text="Performance" class="activeperformancereport"
                ToolTip="Click here for performance graph" CausesValidation="false" PostBackUrl="performance-graph-report.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtnloanmanagement" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none; margin-left: 30px !important" Text="Loan Management" class="activeploan"
                ToolTip="Click here for loan management" CausesValidation="false" PostBackUrl="loan-management.aspx"></asp:LinkButton>
        </div>
    </div>
</div>