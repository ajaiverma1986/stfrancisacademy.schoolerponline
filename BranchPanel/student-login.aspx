<%@ Page Title="Login Detail" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="student-login.aspx.cs" Inherits="BranchPanel_student_login" %>

<%@ Register Src="~/BranchPanel/studentadmission.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .active6 {
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

    <script type="text/javascript">
        $(document).ready(function () {
            $("#ctl00_ContentPlaceHolder1_divnewpaas").css("display", "none");
            $(".editlnk").click(function () {
                $("#ctl00_ContentPlaceHolder1_divnewpaas").css("display", "block");
            });
            $(".editlnk1").click(function () {
                $("#ctl00_ContentPlaceHolder1_divnewpaas").css("display", "none");
            });

        });
    </script>
    <div class="content_pane_cont" id="contentPane">
    </div>

    <div class="content_top">

        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Student Administration</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Admission</a></li>
            <li style="background: none;"><a class="active" href="#">Student Login</a></li>
        </ul>
        <div class="arrowt">
            <a href="studentadmissionlistaspx.aspx">
                <img src="../images/back-button.png" /></a>
        </div>
    </div>

    <div class="clear"></div>

    <div class="content_pane_cont input_content" id="Div1">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <%--  <div class="for_sigle_row_form">
                    <label runat="server" id="lblbnk">
                        URL<span style="color: Red"></span></label>
                    <%--<asp:LinkButton ID="linkurl" runat="server"  ></asp:LinkButton>--%>
        <%--  <asp:HyperLink ID="urllink" runat="server" ForeColor="#249cdd" Font-Bold="false" Font-Size="12px" Text="http://school.awapalsolutions.com/login.aspx" Target="_blank" NavigateUrl="http://school.awapalsolutions.com/login.aspx" />--%>
        <%--</div>--%>
        <div class="for_sigle_row_form">
            <asp:UpdatePanel ID="NameApplicant" runat="server">
                <ContentTemplate>
                    <label>
                        User Name<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtuser" runat="server"></asp:TextBox>&nbsp;
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <div class="for_sigle_row_form">
            <label>
                Password<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtpass" runat="server" ReadOnly="true">***</asp:TextBox>&nbsp;
            <asp:LinkButton ID="lnk1" runat="server" Text="Change Password" CssClass="editlnk"> </asp:LinkButton>
            <asp:LinkButton ID="lnkcancel" runat="server" Text="Cancel" CssClass="editlnk1" Style="color: red"> </asp:LinkButton>
        </div>

        <div id="divnewpaas" runat="server">
            <div class="for_sigle_row_form">
                <label>
                    New Password<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtnewpass" runat="server" TextMode="Password" SetFocusOnError="True"></asp:TextBox>&nbsp;
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                             ErrorMessage="&laquo; (Required)"
                                             ControlToValidate="txtnewpass"
                                             CssClass="rqd"
                                             ToolTip="Password is a REQUIRED field"></asp:RequiredFieldValidator>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Confirm Password<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtSchool" runat="server" TextMode="Password" SetFocusOnError="True"></asp:TextBox>&nbsp;
                                        <asp:CompareValidator ID="CompareValidator1" runat="server"
                                            ControlToValidate="txtSchool"
                                            CssClass="rqd"
                                            ControlToCompare="txtnewpass"
                                            ErrorMessage="No Match"
                                            ToolTip="Password must be the same" />
            </div>
        </div>

        <div class="for_sigle_row_form">
            <label>
            </label>
            <asp:Button runat="server" ID="btnSubmit" Text="Update" CssClass="button_save" OnClick="btnSubmit_Click" />

            <%--    <asp:Button runat="server" ID="btnCancel" CssClass="button_cancel" Text="Cancel"
                                             CausesValidation="false" />--%>
            <asp:Button runat="server" ID="btnsms" Visible="false" Text="Send sms" CssClass="button_save" />
        </div>
    </div>
</asp:Content>