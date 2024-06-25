<%@ Control Language="C#" AutoEventWireup="true" CodeFile="employee_email.ascx.cs" Inherits="BranchPanel_employee_employee_email" %>

<div class="student-photo_frame">
    <style type="text/css">
        .activeshortlistlist {
            border-color: #2d9fdd !important;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd !important;
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
    <script>
        $('.ctl00_lbtnshorlistlist').click(function () {
            $('.lbtnshorlistlist').addClass('activeshortlistlist');
            $('.lbtncreatenewshortlist').removeClass('activeshortlistlist');
        });

        $('.ctl00_lbtncreatenewshortlist').click(function () {
            $('.lbtncreatenewshortlist').addClass('activeshortlistlist');
            $('.lbtnshorlistlist').removeClass('activeshortlistlist');
        });
        </script>
    <div class="clear">
    </div>
    <div class="student-photo_frame_img">
        <asp:Image runat="server" ID="imgstu" ImageUrl="~/employeeimage/9update.png" />
    </div>
    <div style="float: left;">
        <div class="user-deatils">
            <dl>
                <asp:Label ID="lblname" runat="server">Email Management</asp:Label>
            </dl>
        </div>
    </div>
    <div class="clear">
    </div>
    <div style="margin-bottom: -3px; padding-bottom: 8px; margin-top: 10px;">
        <div style="margin-bottom: -3px; margin-top: 10px;">

             <asp:LinkButton ID="lbtnshorlistlist" runat="server" Style="font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none; margin-left: 20px !important;" Text="Email History" class="activeshortlistlist" 
                 ToolTip="Click here for shortlisted candidates list"
                CausesValidation="false" PostBackUrl="~/BranchPanel/employee/sms-history.aspx"></asp:LinkButton>

            <asp:LinkButton ID="lbtncreatenewshortlist" runat="server" Style="margin-left: 15px!important; font-size: 10pt; font-weight: bold; background-color: none; color: black; text-decoration: none" Text="Send Email" class="activecreateshortlist"
                ToolTip="Click here to add shortlisted candidates"
                CausesValidation="false" PostBackUrl="~/BranchPanel/employee/send-sms.aspx"></asp:LinkButton>
        </div>
    </div>
</div>
