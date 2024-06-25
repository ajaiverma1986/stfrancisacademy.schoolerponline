<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="set-sallery.aspx.cs" Inherits="BranchPanel_set_sallery" %>

<%@ Register Src="~/BranchPanel/employee/employee-panel.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .activesetsallery {
            border-color: #ccc!important;
            border-width: medium;
            background: #F7F7F7;
            color: #15A1BF!important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px!important;
            margin-top: 3px;
        }
    </style>
    <script type="text/javascript">
        function pageLoad() {
            document.title = "Set Employee Salary";

        }
    </script>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li style="background: none;"><a>Employee List</a></li>
            <li style="background: none;"><a class="active" href="#">Set Salary</a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <%--<My:stu runat="server" ID="MyUserInfoBoxControl" />--%>

        <div class="for_sigle_row_form">
            <label runat="server" id="Label1">
                Employee Name<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtemployeename" runat="server" ReadOnly="true"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form">
            <label runat="server" id="Label2">
                Salary Type<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtsallerytype" runat="server" ReadOnly="true" Text="Monthly"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form">
            <label runat="server" id="Label3">
                Salary Amount<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtsallery" runat="server"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form">
            <label></label>
            <asp:Button ID="btnsubmit" runat="server" Text="Submit" CssClass="button_save" OnClick="btnsubmit_Click" />
            <asp:Button ID="Button1" runat="server" Text="Back" CssClass="button_save" CausesValidation="false" OnClick="Button1_Click" />
        </div>
    </div>
</asp:Content>