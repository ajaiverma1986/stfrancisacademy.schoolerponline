<%@ Page Title="Change Password" Language="C#" AutoEventWireup="true" CodeFile="changepasswordnew.aspx.cs" Inherits="HO_changepasswordnew" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        #ctl00_ContentPlaceHolder1_CompareValidator1 {
            margin-left: 578px;
            left: 0;
            margin-top: 5px;
            position: absolute;
            width: 180px;
        }
    </style>
    <div class="content_top">

        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Settings</a></li>
            <li style="background: none;"><a class="active" href="#">Change Password</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right;">

            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1" frameborder="0" width="220" height="19" style="float: right; margin-top: 2px; margin-right: 0px;"></iframe>
        </div>
    </div>
    <div class="clear"></div>

    <div class="content_pane_cont input_content" id="contentPane">
        <div class="containerHeadline" style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;">
            Change Password
        </div>
        <br />

        <div class="for_sigle_row_form">
            <label>Login ID<%--<span style="color:Red;">* </span>--%></label>

            <asp:TextBox ID="txtUserName" runat="server" ReadOnly="true"></asp:TextBox>&nbsp&nbsp
        </div>

        <div class="for_sigle_row_form">
            <label>Old Password<span style="color: Red;">* </span></label>

            <asp:TextBox ID="txtoldpwd" runat="server" TextMode="Password"></asp:TextBox>&nbsp;
                  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtoldpwd" Display="Dynamic"
                      ErrorMessage="Please Enter Old Password" CssClass="rqd"></asp:RequiredFieldValidator>
        </div>

        <div class="for_sigle_row_form">

            <label>New Password<span style="color: Red;">* </span></label>

            <asp:TextBox ID="txtnewpwd" runat="server" TextMode="Password"></asp:TextBox>&nbsp;
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtnewpwd" Display="Dynamic"
                        ErrorMessage="Please Enter New Password" CssClass="rqd"></asp:RequiredFieldValidator>
        </div>

        <div class="for_sigle_row_form">
            <label>Confirm Password<span style="color: Red;">* </span></label>

            <asp:TextBox ID="txtconpwd" runat="server" TextMode="Password"></asp:TextBox>&nbsp;
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtconpwd"
                       ErrorMessage="Please Enter Confirm Password" CssClass="rqd"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Both Password should be same"
                ControlToCompare="txtnewpwd" ControlToValidate="txtconpwd" CssClass="rqd" Display="Dynamic"></asp:CompareValidator>
        </div>

        <div class="for_sigle_row_form">
            <label></label>
            <asp:Label ID="lblmsg" runat="server"></asp:Label>
        </div>
        <div class="for_sigle_row_form">
            <label>
            </label>

            <asp:Button ID="btnUpdate" runat="server" Text="Update"
                CssClass="button_save" OnClick="btnUpdate_Click"></asp:Button>
            <asp:Button ID="btnUpdateCancel" runat="server" CausesValidation="false"
                Text="Cancel" CssClass="button_save" OnClick="btnUpdateCancel_Click"></asp:Button>
            <%-- <asp:Button ID="btback" runat="server" Text="Back" CssClass="button1" ></asp:Button>--%>
        </div>
    </div>
    <div>
    </div>
</asp:Content>