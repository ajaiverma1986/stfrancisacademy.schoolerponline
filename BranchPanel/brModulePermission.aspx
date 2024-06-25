<%@ Page Title="User Permission" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true"
    CodeFile="brModulePermission.aspx.cs" Inherits="ModulePermission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">
        function checkPage(rptName, i, j, rptPage, chkmodule, chkpage) {
            var r = rptPage + "_ctl";
            var K;
            if (j < 10)
                K = "0" + j;
            else
                K = j;

            var s1 = document.getElementById(r + K + "_" + chkpage);
            if (s1.checked == true) {
                var s2 = document.getElementById(chkmodule);
                s2.checked = true;
            }
        }

        function checkModule(rptName, itemCount, rptPage, chkmodule, chkpage) {
            var s1 = document.getElementById(chkmodule);
            if (s1.checked == true) {
                for (i = 0; i < itemCount; i++) {
                    r = rptPage + "_ctl";
                    if (i <= 9) {
                        s2 = document.getElementById(r + "0" + i + "_" + chkpage);
                        s2.checked = true;
                    }
                    else {
                        s2 = document.getElementById(r + i + "_" + chkpage);
                        s2.checked = true;
                    }
                }
            }
            if (s1.checked == false) {
                for (i = 0; i < itemCount; i++) {
                    r = rptPage + "_ctl";
                    if (i <= 9) {
                        s2 = document.getElementById(r + "0" + i + "_" + chkpage);
                        s2.checked = false;
                    }
                    else {
                        s2 = document.getElementById(r + i + "_" + chkpage);
                        s2.checked = false;
                    }
                }
            }
        }
    </script>

    <div class="content_top">

        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>

            <li><a href="#">User Manager</a></li>
            <li style="background: none;"><a class="active" href="#">User Rights</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
        </div>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">

        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline  stripheading">
            Select User
        </div>
        <br />

        <asp:UpdatePanel ID="UPModulePermission" runat="server">
            <ContentTemplate>
                <div class="div_form">
                    <div class="row" runat="server" visible="false">
                        <div class="left13">
                            User Group :
                        </div>
                        <div class="right30">
                            <asp:DropDownList ID="dropUserGroup" runat="server" AutoPostBack="True" OnSelectedIndexChanged="dropUserGroup_SelectedIndexChanged"
                                Width="150px">
                                <asp:ListItem Value="0">-- Select User Group --</asp:ListItem>
                                <asp:ListItem Value="10101">Back Office</asp:ListItem>
                                <asp:ListItem Value="101" Selected="True">Branch Office</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row" id="trRO" runat="server">
                        <div class="left13">
                            RO :
                        </div>
                        <div class="right30">
                            <asp:DropDownList ID="dropRO" runat="server" AutoPostBack="True" Width="150px" OnSelectedIndexChanged="dropRO_SelectedIndexChanged">
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="for_sigle_row_form">
                        <label>User Role:</label>

                        <asp:DropDownList ID="ddlRole" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRole_SelectedIndexChanged">
                        </asp:DropDownList>&nbsp&nbsp
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Select User Role"
                                  ControlToValidate="ddlRole" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                    </div>
                    <div class="for_sigle_row_form">

                        <label>User Name: </label>

                        <asp:DropDownList ID="ddlUserName" runat="server" AutoPostBack="True"
                            OnSelectedIndexChanged="ddlUserName_SelectedIndexChanged">
                        </asp:DropDownList>&nbsp&nbsp
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Select User Name"
                                  ControlToValidate="ddlUserName" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>

                        <div class="hide">

                            <div class="left30">
                                Group Permission :
                            </div>
                            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                            <div class="right20">
                                <asp:CheckBox ID="chkGroupPermission" runat="server" AutoPostBack="True" OnCheckedChanged="chkGroupPermission_CheckedChanged" />
                            </div>
                        </div>
                    </div>
                    <div>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UPModulePermission">
                            <ProgressTemplate>
                                <div style="position: absolute; top: 205px; left: 575px; z-index: 500px;">
                                    <span>
                                        <asp:Label ID="lblWaiting" runat="server" ForeColor="Red" Style="font-size: 11px;"
                                            Text="Please Wait..." Height="15px" Width="100px"></asp:Label>
                                    </span>
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                    <div id="grddiv" runat="server" visible="false" style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px; margin-top: 15px; background: #0FC5E6; line-height: 35px; height: 35px;"
                        class="containerHeadline">
                        <span style="color: #fff;">User Rights</span>
                    </div>

                    <div class=" shadow1" id="div1" visible="false" runat="server" style="overflow-x: hidden; height: 350px; border: 1px solid #DDDDDD; margin-left: 33%; margin-top: 10px; padding-left: 35px; width: 262px; border-radius: 5px; background: #fff; padding-bottom: 10px;">

                        <table class="format" cellpadding="2" cellspacing="0" border="0">

                            <asp:Repeater ID="rptModule" runat="server" OnItemDataBound="rptModule_ItemDataBound">

                                <ItemTemplate>

                                    <tr class="for_cheackbox">
                                        <td>
                                            <asp:CheckBox ID="chkmodule" Checked='<%#Eval("IsAccessible") %>' runat="server" />
                                            <asp:Label ID="lblModule" Text='<%# Eval("title") %>' runat="server"></asp:Label>
                                            <asp:Label ID="lblModuleId" Text='<%# Eval("id") %>' Visible="false" runat="server"></asp:Label>
                                        </td>
                                        <td></td>
                                        <tr>

                                            <td>
                                                <table class="content smrt" cellpadding="2" cellspacing="0" border="0" style="margin-left: 35px;">
                                                    <asp:Repeater ID="rptForm" runat="server">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td>
                                                                    <asp:CheckBox ID="chkpage" Checked='<%#Eval("IsPageAccessible") %>' runat="server" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblForm" runat="server" Text='<%#Eval("title")%>'></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblpageid" Visible="false" runat="server" Text='<%#Eval("id")%>'></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </table>
                                            </td>
                                        </tr>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </div>
                </div>
                <div class="for_sigle_row_form" style="margin-left: 13.2%;">
                    <label></label>
                    <asp:Button ID="ImageButton1" runat="server" OnClick="imgSubmit_Click" Text="Submit" CssClass="button_save" />
                    <asp:Button ID="ImageButton2" runat="server" OnClick="imgClear_Click" Text="Clear" CssClass="button_save" CausesValidation="false" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>