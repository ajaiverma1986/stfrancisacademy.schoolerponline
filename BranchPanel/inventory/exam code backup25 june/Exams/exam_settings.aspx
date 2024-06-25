<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master" CodeFile="exam_settings.aspx.cs" Inherits="BranchPanel_Exams_exam_settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script language="javascript" type="text/javascript">
        function checkPage(rptName, i, j, rptPage, chkmodule, chkpage, txt) {
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
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Exams</a></li>
            <li style="background: none;"><a class="active" href="#">Exam Setting</a></li>
        </ul>
        <div class="arrowt">
            <a href="testlist.aspx">
                <img src="../../images/back-button.png" alt="" /></a>
        </div>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
        </div>

        <div class="clear"></div>
        <div class="for_sigle_row_form">
            <label>
                Exam Name<span style="color: Red">*</span></label>
            <asp:DropDownList ID="ddltest" runat="server" OnSelectedIndexChanged="ddltest_SelectedIndexChanged" AutoPostBack="true">
                <asp:ListItem Value="0">--Select Exam--</asp:ListItem>
            </asp:DropDownList>

            <asp:RequiredFieldValidator ID="ddltest13" runat="server" ControlToValidate="ddltest"
                ErrorMessage="Please Select Test Name." SetFocusOnError="True" InitialValue="0" CssClass="rqd"></asp:RequiredFieldValidator>

            <label style="float:right">
                <a href="SetExamToClass.aspx" Class="button_save" >Set Exam to Classes</a>
            </label>
        </div>

        <%--  <div class="for_sigle_row_form" runat="server" id="dd1">
                <label>
                    Exam Shift<span style="color: Red">*</span></label>
              <asp:DropDownList ID="ddlshift" runat="server">
              <asp:ListItem Value="0">--Select Shift--</asp:ListItem>
                    <asp:ListItem Value="1">Morning</asp:ListItem>
                    <asp:ListItem Value="2">Evening</asp:ListItem>
              </asp:DropDownList>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlshift"
                    ErrorMessage="Please Select shift." SetFocusOnError="True" InitialValue="0" CssClass="rqd"></asp:RequiredFieldValidator>
         </div>--%>
        <%-- <div class="for_sigle_row_form">
        <label>
            Exam Time</label>
        <asp:DropDownList ID="ddlftime" Width="100px" runat="server">
        </asp:DropDownList>
        &nbsp;To
        <asp:DropDownList ID="ddltotime" Width="100px" runat="server">
        </asp:DropDownList>
    </div>--%>

        <div id="grddiv" runat="server" style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px; margin-top: 15px; background: #33ccff; line-height: 35px; height: 35px;"
            class="containerHeadline">
            Exam Setting
        </div>
        <table class="format" cellpadding="2" cellspacing="0" border="0" style="width: 300px; margin-left: 240px;">
            <asp:Repeater ID="rptModule" runat="server" OnItemDataBound="rptModule_ItemDataBound">
                <ItemTemplate>
                    <tr class="for_cheackbox">
                        <td>
                            <asp:CheckBox ID="chkmodule" Checked='<%# Convert.ToBoolean(Eval("status")) %>' Enabled="false" runat="server" />
                            <asp:Label ID="lblModule" Text='<%# Eval("Classname") %>' runat="server"></asp:Label>
                            <asp:Label ID="lblModuleId" Text='<%# Eval("id") %>' Visible="false" runat="server"></asp:Label>
                        </td>
                        <tr>
                            <td>
                                <table class="content smrt" cellpadding="2" cellspacing="0" border="0" style="margin-left: 35px;">
                                    <asp:Repeater ID="rptForm" runat="server" OnItemDataBound="rptModule1_ItemDataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkpage" Checked='<%# Convert.ToString(Eval("status"))=="1"%>' runat="server" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblForm" runat="server" Text='<%#Eval("Subjectname")%>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblpageid" Visible="false" runat="server" Text='<%#Eval("Subjectid")%>'></asp:Label>
                                                    <asp:HiddenField ID="HD1" runat="server" Value='<%#Eval("subjectid")%>' />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtbox" runat="server" Text='<%#Eval("marks")%>'></asp:TextBox>
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

        <div class="for_sigle_row_form">
            <label>
                <asp:Button ID="Button1" runat="server" Text="Save" CssClass="button_save" OnClick="btnsubmit_Click"
                    OnClientClick="return validateCheckBoxes()" />
            </label>
        </div>
    </div>
</asp:Content>