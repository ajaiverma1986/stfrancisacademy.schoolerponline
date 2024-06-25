<%@ Page Title="Academic Year Setting" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="academicYear.aspx.cs" Inherits="HO_academicYear" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="content_top">
        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Master settings</a></li>
            <li style="background: none;"><a class="active" href="#">Academic Year Setting</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px; margin-right: 0px;"></iframe>
        </div>
    </div>
    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="FIELDSET1" runat="server">

        <%--<div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px;
            padding-top: 0px;" class="containerHeadline">
            Set Academic Year
        </div>--%>

        <div align="center">
            <table style="width: 80%">
                <tr>
                    <td style="text-align: right; padding-right: 10px;"></td>
                </tr>

                <tr>
                    <td style="text-align: left; padding-left: 200px;">
                        <div class="for_sigle_row_form shortinput">
                            <label>
                                Current Academic Year </span>
                            </label>
                            <b>
                                <asp:Label runat="server" ID="lblAcaYear"></asp:Label></b>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left; padding-left: 200px;">
                        <div class="for_sigle_row_form shortinput">
                            <label>
                                Select starting academic year<span style="color: Red;">* </span>
                            </label>
                            <asp:DropDownList runat="server" ID="ddlStartYear"
                                OnSelectedIndexChanged="ddlStartYear_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Value="0">--Select one--</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp;&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please select starting academic year"
                                ControlToValidate="ddlStartYear" SetFocusOnError="True" ValidationGroup="g1" InitialValue="0" CssClass="rqd"></asp:RequiredFieldValidator>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left; padding-left: 200px;">
                        <div class="for_sigle_row_form shortinput">
                            <label>
                                End academic year
                            </label>
                            <%--<asp:DropDownList runat="server" ID="ddlEndYear"></asp:DropDownList>--%>
                            <asp:TextBox runat="server" ID="txtEndYear"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left; padding-left: 200px;">
                        <div class="for_sigle_row_form shortinput">
                            <label>
                                Select starting academic month<span style="color: Red;">* </span>
                            </label>
                            <asp:DropDownList runat="server" ID="ddlMonth" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged">
                            </asp:DropDownList>&nbsp;&nbsp;
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please select starting academic month"
                                    ControlToValidate="ddlMonth" SetFocusOnError="True" ValidationGroup="g1" InitialValue="0" CssClass="rqd"></asp:RequiredFieldValidator>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left; padding-left: 200px;">
                        <div class="for_sigle_row_form shortinput">
                            <label>
                                End academic month
                            </label>
                            <%--<asp:DropDownList runat="server" ID="ddlEndMonth"></asp:DropDownList>--%>
                            <asp:TextBox runat="server" ID="txtEndMonth"></asp:TextBox>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td align="center">
                        <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                            </label>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btSave" runat="server" Text="Submit" CssClass="button1"
                                    ValidationGroup="g1" OnClick="btSave_Click" />
                            <asp:Button ID="Button4" runat="server" Text="Cancel" CssClass="button2" ValidationGroup="g1" CausesValidation="False" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="center" class="style9" colspan="6">
                        <asp:HiddenField ID="HfUid" runat="server" />
                        <asp:HiddenField ID="HfEID" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>