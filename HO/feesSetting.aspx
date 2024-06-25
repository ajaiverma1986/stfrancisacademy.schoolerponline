<%@ Page Title="Fee Setting" Language="C#" AutoEventWireup="true" CodeFile="feesSetting.aspx.cs" Inherits="HO_feesSetting"
    MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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

    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Add/View Fee Settings</h2>
        </div>
        <div class="for_sigle_row_form">
            <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
            <asp:DropDownList ID="ddlfinancialyear" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlfinancialyear_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Select Branch</label>
            <asp:DropDownList ID="DDlBranch" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DDlBranch_SelectedIndexChanged">
                <asp:ListItem Value="0" Selected="True">-- Select Branch --</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="for_sigle_row_form">
            <label>
                Select Class</label>
            <asp:DropDownList ID="ddlClass" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
        <br />
        <br />
        <div class="for_sigle_row_form" id="trdiv" runat="server" style="padding: 0px;">
            <div class="tbl-top-heading" style="width: 100%; margin-left: 0px" id="grddiv" runat="server">
                <h2>Select/Selected Fee Type For Selected Class</h2>
            </div>
            <table class="format" cellpadding="2" cellspacing="0"
                border="0" style="width: 300px; margin-left: 240px;">
                <asp:Repeater ID="rptfeetype" runat="server" OnItemDataBound="rptfeetype_ItemDataBound">
                    <ItemTemplate>
                        <tr class="for_cheackbox">
                            <td>
                                <br />
                                <asp:CheckBox ID="chkmodule" Checked='<%#Eval("status") %>' runat="server" CssClass="msrtn" />
                                <asp:Label ID="lblModule" Text='<%# Eval("feename") %>' runat="server" CssClass="msrtn1" Style="margin-top: -1px; font-weight: bold; color: green;"></asp:Label>
                                <asp:Label ID="lblModuleId" Text='<%# Eval("id") %>' Visible="false" runat="server"></asp:Label>
                            </td>
                            <td></td>

                            <tr>
                                <td>
                                    <table class="content smrt" cellpadding="2" cellspacing="0" border="0" style="margin-left: 35px;">
                                        <asp:Repeater ID="rptfeesubtype" runat="server">
                                            <ItemTemplate>
                                                <br />
                                                <tr>
                                                    <td>
                                                        <asp:CheckBox ID="chkpage" Checked='<%#Eval("status") %>' runat="server" />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblForm" runat="server" Text='<%#Eval("feename")%>' Style="margin-left: 5px; font-weight: bold; color: black;"></asp:Label>
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
        <div class="for_sigle_row_form">
            <label>
            </label>
            <br />
        </div>
        <div class="for_sigle_row_form">
            <label>
            </label>
            <asp:Button ID="ImageButton1" runat="server" Text="Submit" CssClass="button_save" OnClick="ImageButton1_Click" />
        </div>
        <div class="for_sigle_row_form">
            <label>
            </label>
            <asp:Label runat="server" ID="lblmsg" ForeColor="Red" EnableViewState="False"></asp:Label>
        </div>
    </div>
</asp:Content>