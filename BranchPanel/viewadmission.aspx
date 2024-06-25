<%@ Page Title="View Admission" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="viewadmission.aspx.cs" Inherits="BranchPanel_viewadmission" %>

<%@ Register Src="~/BranchPanel/studentadmission.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
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

    <div class="content_top">

        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Student Administration</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Admission</a></li>
            <li style="background: none;"><a class="active" href="#">View Admission</a></li>
        </ul>
        <div class="arrowt">
            <a href="studentadmissionlistaspx.aspx">
                <img src="../images/back-button.png" /></a>
        </div>
    </div>

    <div class="clear"></div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div class="for_sigle_row_form" id="dvregno" runat="server" visible="false">
            <label>
                Registration No.(for reference)</label>
            <asp:TextBox ID="txtRegNo" runat="server" Enabled="true"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Name of Applicant<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtName" runat="server" CssClass="fname"></asp:TextBox>&nbsp;
                                        <asp:TextBox ID="txtmidname" runat="server" CssClass="mname"></asp:TextBox>&nbsp
                                        <asp:TextBox ID="txtLName" runat="server" CssClass="lname"></asp:TextBox>&nbsp
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="for_sigle_row_form">
                    <label>
                        Date of Birth<span style="color: Red">*</span></label>
                    <asp:TextBox ID="txtToDate" runat="server">
                    </asp:TextBox>&nbsp;
                                         <asp:Label runat="server" ID="DateTimeLabel" ForeColor="Black" Font-Size="12px" Text=""></asp:Label>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="for_sigle_row_form">
            <label>
                Father's Name<span style="color: Red">*</span></label>
            <asp:TextBox runat="server" ID="txtFname" CssClass="fname"></asp:TextBox>&nbsp;
                                        <asp:TextBox ID="txtmidname1" runat="server" CssClass="mname"></asp:TextBox>&nbsp;
                                        <asp:TextBox ID="txtlastname1" runat="server" CssClass="lname"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Mother's Name<span style="color: Red">*</span></label>
            <asp:TextBox runat="server" ID="txtmother" CssClass="fname"></asp:TextBox>&nbsp;
                                        <asp:TextBox ID="txtmidname2" runat="server" CssClass="mname"></asp:TextBox>&nbsp;
                                        <asp:TextBox ID="txtlastname2" runat="server" CssClass="lname"></asp:TextBox>
        </div>
        <div class="for_sigle_row_form ">
            <label>
                Gender<span style="color: Red">*</span></label>
            <asp:RadioButtonList runat="server" ID="rbgender" RepeatDirection="Horizontal" CssClass="labelfor_radio">
                <asp:ListItem Value="1">Male</asp:ListItem>
                <asp:ListItem Value="0">Female</asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div class="clear"></div>
        <asp:UpdatePanel runat="server" ID="up12">
            <ContentTemplate>
                <div class="for_sigle_row_form">
                    <label>
                        Applying for Class<span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddlClass" runat="server">
                    </asp:DropDownList>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <%-- <asp:UpdatePanel runat="server" ID="UpdatePanel2">
            <ContentTemplate>
                <div class="for_sigle_row_form">
                    <label>
                        Section<span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddlSection" runat="server">
                    </asp:DropDownList>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>--%>
        <div class="for_sigle_row_form">
            <label>
                Address Line<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtPAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
        </div>
        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>
                <div class="for_sigle_row_form">
                    <label>
                        Country<span style="color: Red">*</span></label>
                    <asp:DropDownList runat="server" ID="ddlCountry1" AutoPostBack="true" OnSelectedIndexChanged="ddlCountry1_SelectedIndexChanged">
                    </asp:DropDownList>&nbsp;
                                        <asp:Label runat="server" ID="lblCountryMsg" ForeColor="Chocolate" Text=""></asp:Label>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        State/Province<span style="color: Red">*</span></label>
                    <asp:DropDownList ID="ddl_state" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddl_state_SelectedIndexChanged">
                    </asp:DropDownList>&nbsp;
                                         <asp:Label runat="server" ID="lblStateMsg" ForeColor="Chocolate" Text=""></asp:Label>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        City<span style="color: Red">*</span></label>
                    <asp:DropDownList runat="server" ID="ddlCity1">
                    </asp:DropDownList>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="for_sigle_row_form">
            <label>
                PIN/ZIP code<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtPZIP" runat="server" MaxLength="8"></asp:TextBox>&nbsp;
                                         <asp:RegularExpressionValidator ID="RegularExpressionValidator1" CssClass="rqd" ControlToValidate="txtPZIP"
                                             runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Mobile No.<span style="color: Red">*</span></label>
            <asp:TextBox ID="txtmob" runat="server" MaxLength="15"></asp:TextBox>&nbsp;
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" CssClass="rqd" ControlToValidate="txtmob"
                                            runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
        </div>

        <div class="for_sigle_row_form">
            <label>
            </label>
            <br />
        </div>

        <div class="tab-pane" id="tab6">
            <div class="for_sigle_row_form">
                <label>
                    Admission No.<span style="color: Red">*</span></label>
                <asp:TextBox ID="txtadmNo" runat="server" Enabled="false"></asp:TextBox>
            </div>
        </div>

        <div class="for_sigle_row_form" style="margin-left: 240px;">
            <asp:Button ID="btnupdate" runat="server" Text="Update" CssClass="button_save" OnClick="btnupdate_Click" />
        </div>
    </div>
</asp:Content>