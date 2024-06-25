<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="loan-management.aspx.cs" Inherits="branchpanel_employee_loan_management" %>

<%@ Register Src="~/branchpanel/employee/employee-panel.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <style type="text/css">
        .activeploan {
            border-color: #2d9fdd!important;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd!important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }
    </style>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Employee Management</a></li>
            <li style="background: none;"><a>Employee List</a></li>
            <li style="background: none;"><a class="active" href="#">Loan Management</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div style="margin-left: 300px !important; margin-bottom: 30px !important;">
            <label style="color: red; font-size: 18px; font-family: Arial">Coming Soon...........???????????????????????</label>
        </div>
    </div>
</asp:Content>