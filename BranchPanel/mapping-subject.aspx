<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="mapping-subject.aspx.cs" Inherits="BranchPanel_mapping_subject" %>

<%@ Register Src="~/BranchPanel/employee/employee-panel.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .activesubject {
            border-color: #ccc!important;
            border-width: medium;
            background: #F7F7F7;
            color: #15A1BF!important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px!important;
            margin-top: 3px;
        }

        .for_sigle_row_form {
            margin-bottom: 12px;
            margin-left: 0px !important;
            margin-right: 0px !important;
            padding: 0px !important;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function pageLoad() {
            document.title = "Allocate/Deallocate Subjects To Employee";

        }
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
    <script type="text/javascript">
        function Showalert() {
            alert("The image has been uploaded successfully.");
        }
        function Showalert1() {
            alert("The image has been deleted successfully.");
        }
        function Showalert2() {
            alert("There is an error. Please try again.");
        }
    </script>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Hr Management</a></li>
            <li style="background: none;"><a>Employee List</a></li>
            <li style="background: none;"><a class="active" href="#">Mapping Subject</a></li>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
       <%-- <My:stu runat="server" ID="MyUserInfoBoxControl" />--%>
        <br />
        <div class="for_sigle_row_form" runat="server" id="kk">
            <label runat="server" id="l1" style="margin-left: 17%;">
                Faculty Name</label>
            <asp:TextBox ID="txtfacultyname" runat="server" ReadOnly="true"></asp:TextBox>
            &nbsp&nbsp
        </div>
        <div class="for_sigle_row_form" id="trdiv" runat="server" style="padding: 0px;">
            <div id="grddiv" style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
                class="containerHeadlinenew">
                <span style="line-height: 39px;">Select subject From Classes </span>
                <asp:Button runat="server" ID="Button1" CssClass="view-enquiry" Text="Edit"
                    ToolTip="Click here to add class with subject." OnClick="Button1_Click" Style="float: right; height: 25px; margin-right: 12px; margin-top: 7.5px; padding: 0 5px 1px;" />
            </div>
        </div>

        <table class="format" cellpadding="2" cellspacing="0" border="0" style="width: 300px; margin-left: 240px;">
            <asp:Repeater ID="rptfeetype" runat="server" OnItemDataBound="rptfeetype_ItemDataBound">
                <ItemTemplate>
                    <tr class="for_cheackbox">
                        <td>
                            <asp:CheckBox ID="chkmodule" Checked='<%#Convert.ToBoolean( Eval("status")) %>' runat="server"
                                CssClass="msrtn" />
                            <asp:Label ID="lblModule" Text='<%# Eval("className") %>' runat="server" CssClass="msrtn1"></asp:Label>
                            <asp:Label ID="lblModuleId" Text='<%# Eval("id") %>' Visible="false" runat="server"></asp:Label>
                        </td>
                        <td></td>
                        <tr>
                            <td>
                                <table class="content smrt" cellpadding="2" cellspacing="0" border="0" style="margin-left: 35px;">
                                    <asp:Repeater ID="rptfeesubtype" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkpage" Checked='<%# Convert.ToBoolean(Eval("status")) %>' runat="server" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblForm" runat="server" Text='<%#Eval("subjectname")%>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblpageid" Visible="false" runat="server" Text='<%#Eval("subjectid")%>'></asp:Label>
                                                    <asp:HiddenField ID="HD1" runat="server" Value='<%#Eval("csmid")%>' />
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
        <asp:Button ID="btn" runat="server" Text="Submit" CssClass="button_save" OnClick="btn_Click1" Visible="false" Style="margin-left: 500px !important" />
    </div>
</asp:Content>