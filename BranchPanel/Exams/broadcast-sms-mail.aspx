<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master"
    CodeFile="broadcast-sms-mail.aspx.cs" Inherits="BranchPanel_Exams_broadcast_sms_mail" %>

<%@ Register Src="~/BranchPanel/Exams/exam.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .active0 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd;
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
    <style type="text/css">
        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 20px;
            margin-top: 7px;
        }

        #content_pane {
            background: #fff;
        }
    </style>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Exams</a></li>
            <li style="background: none;"><a class="active" href="#">Mark Attendance</a></li>
        </ul>
        <div class="arrowt">
            <a href="testlist.aspx">
                <img src="../../images/back-button.png" /></a>
        </div>
    </div>
    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="contentPane" style="position: relative;">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div class="clear">
        </div>
        <div class="clear">
        </div>
        <label>
            Send Sms To</label>
        <asp:RadioButtonList ID="RadioButtonList1" runat="server">
            <asp:ListItem Value="0">Students</asp:ListItem>
            <asp:ListItem Value="1">Parents</asp:ListItem>
            <asp:ListItem Selected="True" Value="2">Both</asp:ListItem>
        </asp:RadioButtonList>
        <br />
    </div>
</asp:Content>