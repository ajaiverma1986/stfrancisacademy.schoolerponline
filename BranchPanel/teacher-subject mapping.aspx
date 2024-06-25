<%@ Page Title="Teacher Subject Mapping" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="teacher-subject mapping.aspx.cs" Inherits="BranchPanel_teacher_subject_mapping" %>

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
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Master settings</a></li>

            <li style="background: none;"><a class="active" href="#">Teacher subject Mapping </a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px; margin-right: 0px;"></iframe>
        </div>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Add Department
        </div>
        <br />
        <div runat="server">
            <div id="grddiv" runat="server" style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px; margin-top: 15px; background: #33ccff; line-height: 35px; height: 35px;"
                class="containerHeadline">
                Add Subject and Class Rights
            </div>
            <div>
                <div class="for_sigle_row_form">
                    <label>
                        Select Teacher</label>
                    <asp:DropDownList ID="ddlteacher" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlteacher_SelectedIndexChanged">
                        <asp:ListItem Value="0">--Select One--</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div>
                    <asp:Label ID="lbl" runat="server"></asp:Label>
                </div>
                <table class="format" cellpadding="2" cellspacing="0" border="0" style="width: 300px; margin-left: 240px;">
                    <asp:Repeater ID="rptModule" runat="server" OnItemDataBound="rptModule_ItemDataBound">
                        <ItemTemplate>
                            <tr class="for_cheackbox">
                                <td>
                                    <asp:CheckBox ID="chkmodule" Checked='<%#Eval("status") %>' runat="server" />
                                    <asp:Label ID="lblModule" Text='<%# Eval("classname") %>' runat="server"></asp:Label>
                                    <asp:Label ID="lblModuleId" Text='<%# Eval("classid") %>' Visible="false" runat="server"></asp:Label>
                                </td>
                                <td></td>
                                <tr>
                                    <td>
                                        <table class="content smrt" cellpadding="2" cellspacing="0" border="0" style="margin-left: 35px;">
                                            <asp:Repeater ID="rptForm" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td>
                                                            <asp:CheckBox ID="chkpage" Checked='<%#Eval("status") %>' runat="server" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblForm" runat="server" Text='<%#Eval("Subjectname")%>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblpageid" Visible="false" runat="server" Text='<%#Eval("Subjectid")%>'></asp:Label>
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
        <div>
            <asp:Button ID="btnAdd" runat="server" Text="Submit" ValidationGroup="g1" OnClick="btnAdd_Click" CssClass="button_save" />
        </div>
    </div>
</asp:Content>