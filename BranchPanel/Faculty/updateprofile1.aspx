<%@ Page Title="Update Profile" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="updateprofile1.aspx.cs" Inherits="BranchPanel_Faculty_updateprofile1" %>

<%@ Register Src="~/faculty-detail.ascx" TagName="stu" TagPrefix="My" %>

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
    <script type="text/javascript">
        function lettersOnly(evt) {
            evt = (evt) ? evt : event;
            var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
          ((evt.which) ? evt.which : 0));
            if (charCode > 32 && (charCode < 65 || charCode > 90) &&
          (charCode < 97 || charCode > 122)) {
                return false;
            }
            else
                return true;
        };
        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90))
                return false;

            return true;
        };
    </script>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="viewfaculty.aspx">Faculty</a></li>
            <li style="background: none;"><a class="active">Profile </a></li>
        </ul>
        <div class="arrowt">
            <a href="viewfaculty.aspx">
                <img src="../../images/back-button.png" /></a>
        </div>
    </div>
    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />

        <br />
        <div class="for_sigle_row_form" runat="server" id="kk">
            <div class="for_sigle_row_form" runat="server" id="Div1">
                <%-- <div class="user_phot_frame">
                <asp:Image ID="imgStudent" runat="server" /></div>--%>
                <div class="for_sigle_row_form">
                    <label>
                        Reference NO<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtRefNo" runat="server"></asp:TextBox>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Title<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlTitle" runat="server" AppendDataBoundItems="True">
                    </asp:DropDownList>
                    &nbsp&nbsp&nbsp<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                        ErrorMessage="Select Title" ControlToValidate="ddlTitle" InitialValue="0" CssClass="rqd"
                        Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Name<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtFName" runat="server" CssClass="fname"></asp:TextBox>&nbsp
                                            <asp:TextBox ID="txtMName" runat="server" CssClass="mname"></asp:TextBox>&nbsp
                                            <asp:TextBox ID="txtLName" runat="server" CssClass="lname"></asp:TextBox>&nbsp
                                            <asp:RequiredFieldValidator ID="rfvFname" runat="server" ControlToValidate="txtFName"
                                                ErrorMessage="Enter First Name" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                    &nbsp<asp:RequiredFieldValidator ID="rfvLname" runat="server" ControlToValidate="txtLName"
                        ErrorMessage="Enter Last Name" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Date of Birth<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox>&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtToDate"
                ErrorMessage="Please select DOB." SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Gender<span style="color: Red">*</span></label>
                    <asp:RadioButtonList runat="server" ID="rbgender" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                        <asp:ListItem Value="1" Selected="True"> Male</asp:ListItem>
                        <asp:ListItem Value="0">Female</asp:ListItem>
                    </asp:RadioButtonList>
                    &nbsp;
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        D.O.J<span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtDate" runat="server"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                        ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtDate" ErrorMessage="Please Select Joining Date."
                        SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Address Line<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtPAddress" runat="server" TextMode="MultiLine"></asp:TextBox>&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtPAddress"
                ErrorMessage="Please enter address." SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                </div>

                <div class="for_sigle_row_form">
                    <label>
                        Mobile No. <span style="color: #ff0066">*</span></label>
                    <asp:TextBox ID="txtMobileNo2" runat="server" MaxLength="10"></asp:TextBox>&nbsp;
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" CssClass="rqd" ControlToValidate="txtMobileNo2"
                                                runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                </div>
                <%-- <div class="for_sigle_row_form">
            <label>
                Phone No.<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtmob" runat="server" MaxLength="15" onkeypress="return noAlphabets(event)"></asp:TextBox>&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please enter phone number"
                ControlToValidate="txtmob" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="rqd" ControlToValidate="txtmob"
                runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
        </div>--%>
                <%--<div class="for_sigle_row_form">
            <label>
              Highest Qualification<span style="color: Red">*</span>
            </label>
            <asp:DropDownList ID="ddlqua" runat="server">
                <asp:ListItem Value="0">--Select Qualification--</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rd2" runat="server" InitialValue="0" CssClass="rqd"
                ErrorMessage="Plz select Qualification" ControlToValidate="ddlqua"></asp:RequiredFieldValidator>
        </div>--%>
                <div class="for_sigle_row_form">
                    <label>
                        Professional Qualification
                    </label>
                    <asp:DropDownList ID="DropDownList1" runat="server">
                    </asp:DropDownList>
                    <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" InitialValue="0" CssClass="rqd"
                ErrorMessage="Plz select Qualification" ControlToValidate="ddlqua"></asp:RequiredFieldValidator>--%>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Experience
                    </label>
                    <asp:DropDownList ID="ddlexp" runat="server">
                        <asp:ListItem Value="0">--Select Exp</asp:ListItem>
                        <asp:ListItem Value="1">0-6 Months</asp:ListItem>
                        <asp:ListItem Value="2">1-3 year</asp:ListItem>
                        <asp:ListItem Value="3">3-5 year</asp:ListItem>
                        <asp:ListItem Value="5">above 5 years</asp:ListItem>
                    </asp:DropDownList>
                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" InitialValue="0"
                CssClass="rqd" ErrorMessage="Plz select Experience" ControlToValidate="ddlexp"></asp:RequiredFieldValidator>--%>
                </div>
                <asp:UpdatePanel runat="server" ID="upd1234">
                    <ContentTemplate>
                        <div class="for_sigle_row_form">
                            <label>
                                EmailId</label>
                            <asp:TextBox ID="txtMEmailid" runat="server" AutoPostBack="true"></asp:TextBox>&nbsp;
                    <asp:Label runat="server" ID="lblMemail" ForeColor="Red"></asp:Label>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="for_sigle_row_form" style="position: relative;">
                    <label>
                        Upload photo</label>
                    <asp:FileUpload runat="server" ID="fuPhoto" />&nbsp;
            <asp:Label runat="server" ID="lblPhoto" Text="" Visible="false"></asp:Label>
                    <div class="df0" style="left: 480px;">
                        <div class="df">
                            <ul>
                                <li>
                                    <img src="../../images/questionmark.png" />
                                    <ul>
                                        <li>Only .jpeg,.png,.giff image files supported.</li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <asp:Label runat="server" ID="lblmother" ForeColor="Chocolate" Text="" Visible="false"></asp:Label>
                </div>
                <br />
                <div class="for_sigle_row_form" style="margin-left: 240px;">
                    <asp:Button ID="btnsubmit" runat="server" Text="Update" CssClass="button_save" OnClick="btnsubmit_Click" />
                </div>
            </div>
        </div>
</asp:Content>