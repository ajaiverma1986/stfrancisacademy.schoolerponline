<%@ Page Title="My Profile" Language="C#" AutoEventWireup="true" CodeFile="MyProfile.aspx.cs" Inherits="HO_MyProfile"
    MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content_top">
        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Settings</a></li>
            <li style="background: none;"><a class="active" href="#">MyProfile</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px; margin-right: 0px;"></iframe>
        </div>
    </div>

    <div class="clear"></div>

    <div class="content_pane_cont input_content" id="contentPane">
        <div align="center" id="FIELDSET1" runat="server">
            <table style="width: 100%">
                <tr>
                    <td class="containerHeadline" style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;">My Profile
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                        <div class="for_sigle_row_form">
                            <div class="user_phot_frame">
                                <asp:Image ID="imguser" runat="server" />
                            </div>
                            <label>
                                Login ID<%--<span style="color:Red;">* </span>--%></label>
                            <asp:TextBox ID="txtloginid" runat="server" ReadOnly="true"></asp:TextBox>&nbsp&nbsp
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter login ID"
                                ControlToValidate="txtloginid" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Name<%--<span style="color:Red;">* </span>--%></label>
                            <asp:TextBox ID="txtName" runat="server"></asp:TextBox>&nbsp&nbsp
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter User Name"
                                ControlToValidate="txtName" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form shortinput3 select">
                            <label>
                                Date of Birth</label>
                            <asp:DropDownList ID="ddlday" runat="server">
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlmon" runat="server">
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlyear" runat="server">
                            </asp:DropDownList>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Mobile No.<%--<span style="color:Red;">* </span>--%></label>

                            <asp:TextBox ID="dsfds" Width="43px" runat="server"> </asp:TextBox>
                            <asp:TextBox ID="txtmobile" Width="239px" runat="server"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Phone No.<%--<span style="color:Red;">* </span>--%></label>
                            <asp:TextBox ID="txtphoneno" runat="server"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Fax No.<%--<span style="color:Red;">* </span>--%></label>
                            <asp:TextBox ID="txtfaxno" runat="server"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Email ID<%--<span style="color:Red;">* </span>--%></label>
                            <asp:TextBox ID="txtemailid" runat="server"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="instantid" runat="server">
                            <ContentTemplate>
                                <div class="for_sigle_row_form  shortinput">
                                    <label>
                                        Instant Messenger</label>
                                    <asp:DropDownList ID="ddlinsmess" runat="server">
                                        <asp:ListItem Value="0">Skype</asp:ListItem>
                                        <asp:ListItem Value="1">Live Chat</asp:ListItem>
                                        <asp:ListItem Value="2">Google Talk</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtinstmess" runat="server"></asp:TextBox>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Organisation Name<%--<span style="color:Red;">* </span>--%></label>
                            <asp:TextBox ID="txtorgname" runat="server"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Address</label>
                            <asp:TextBox ID="txtaddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <div class="for_sigle_row_form">
                                                <label>
                                                    Country</label>
                                                <asp:DropDownList ID="ddlcountry" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlcountry_SelectedIndexChanged">
                                                </asp:DropDownList>
                                                <asp:Label ID="lblCountryMsg" runat="server"></asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="for_sigle_row_form">
                                                <label>
                                                    State</label>
                                                <asp:DropDownList ID="ddlState" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlState_SelectedIndexChanged">
                                                </asp:DropDownList>
                                                <asp:Label ID="lblStateMsg" runat="server"></asp:Label>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <div class="for_sigle_row_form">
                                                <label>
                                                    City
                                                </label>
                                                <asp:DropDownList ID="ddlCity" runat="server">
                                                </asp:DropDownList>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Pin Code</label>
                            <asp:TextBox ID="txtPinCode" runat="server" CssClass="body" MaxLength="6" ValidationGroup="g1"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                PhotoUpload
                            </label>
                            <asp:FileUpload ID="fileupload1" runat="server" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                                Additional Information</label>
                            <asp:TextBox ID="txtaddinfo" runat="server" TextMode="MultiLine"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr id="TrUpdate" runat="server">
                    <td>
                        <div class="for_sigle_row_form">
                            <label>
                            </label>
                            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="button_save" OnClick="btnUpdate_Click"></asp:Button>
                            <asp:Button ID="btnUpdateCancel" runat="server" Text="Cancel" CssClass="button_save"
                                OnClick="btnUpdateCancel_Click"></asp:Button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:HiddenField ID="HfUid" runat="server" />
                        <asp:HiddenField ID="HfEID" runat="server" />
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="clear"></div>
</asp:Content>