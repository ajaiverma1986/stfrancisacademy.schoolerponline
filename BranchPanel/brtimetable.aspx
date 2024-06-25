<%@ Page Title="Time Table Setting" Language="C#" AutoEventWireup="true" CodeFile="brtimetable.aspx.cs"
    Inherits="BranchPanel_brtimetable" MasterPageFile="~/BranchPanel/MasterPage.master" %>

<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function get(txt1, ddl1) {
            var tb = (txt1.value);
            if (tb == "") {
                ClearSelection(ddl1);
            }
            else {
                for (var i = 0; i < ddl1.options.length; i++) {
                    if (ddl1.options[i].value.toUpperCase().match(tb.toUpperCase())) {
                        ddl1.options[i].selected = true;
                        txt1.value = '';
                        return false;
                    }
                    else {
                        ClearSelection(ddl1);
                    }

                }
            }

        }
        function get1(txt1, ddl1, ddl2) {
            var tb = (txt1.value);
            if (tb == "") {
                ClearSelection(ddl1);
                ClearSelection(ddl2);
            }
            else {
                for (var i = 0; i < ddl1.options.length; i++) {
                    if (ddl1.options[i].value.toUpperCase().match(tb.toUpperCase())) {
                        ddl1.options[i].selected = true;
                        ddl2.options[i].selected = true;
                        txt1.value = '';
                        return false;
                    }
                    else {
                        ClearSelection(ddl1);
                        ClearSelection(ddl2);
                    }

                }
            }

        }
        function ClearSelection(lb) {
            lb.selectedIndex = 0;
        }
        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
               && (charCode <= 90)) {
                return false;
            }
            else {
                return true;
            }
        }
        function check() {

            if (document.getElementById('<%=txtnoofperiod.ClientID %>').value.trim() == "") {
                alert("Please enter No. Of Period Before Lunch!");
                document.getElementById('<%=txtnoofperiod.ClientID %>').focus();
                return false;
            }
            if (document.getElementById('<%=txtnoofperiod.ClientID %>').value.trim() == "") {
                alert("Please enter No. Of Period After Lunch!");
                document.getElementById('<%=txtnoofperiod.ClientID %>').focus();
                return false;
            }

            var skillsSelect = document.getElementById('<%=ddlFrom.ClientID %>');
            var selectedText = skillsSelect.options[skillsSelect.selectedIndex].text;
            var skillsSelect1 = document.getElementById('<%=ddlTo.ClientID %>');
            var selectedText1 = skillsSelect1.options[skillsSelect1.selectedIndex].text;
            if (selectedText == selectedText1) {
                alert(" Start time and from time can not be same");
                return false;
            }
        }
    </script>
    <style>
        #ctl00_ContentPlaceHolder1_GridStateDetail_ctl03_rblday label {
            display: none;
        }

        .style1 {
            height: 38px;
        }

        .grd {
            background: #F4FFFF;
            height: 27px;
            border: none;
            padding: 5px 15px 0px 0px;
        }

            .grd:hover {
                background: #fff;
            }

            .grd h5 {
                font-size: 12px;
                font-weight: normal;
                color: #fff;
                font-weight: bold;
                float: left;
                margin: 3px;
                width: 110px;
                text-align: left;
                padding-left: 20px;
            }
    </style>
    <div class="content_pane_cont" id="contentPane">
    </div>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Master Settings</a></li>
            <li style="background: none;"><a class="active">Timetable Settings </a>
            </li>
        </ul>
    </div>
    <div class="clear">
    </div>
    <asp:UpdatePanel runat="server" ID="upd1">
        <ContentTemplate>
            <div class="content_pane_cont input_content" id="FIELDSET1" runat="server">
                <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 4px;"
                    class="containerHeadline stripheading">
                    Set Time Structure
                </div>
                <table width="100%">
                    <tr>
                        <td>
                            <table style="width: 100%;">
                                <tr>
                                    <td style="text-align: right; padding-right: 10px;">
                                        <asp:DropDownList ID="dropUserGroup" runat="server" AutoPostBack="True" Visible="false">
                                            <asp:ListItem Value="0">-- Select User Group --</asp:ListItem>
                                            <asp:ListItem Value="10101">Back Office</asp:ListItem>
                                            <asp:ListItem Value="101" Selected="True">Branch Office</asp:ListItem>
                                            <asp:ListItem Value="1001">FSO</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="for_sigle_row_form">
                                            <label>
                                                Start Time<span style="color: Red;">* </span>
                                            </label>
                                            <asp:DropDownList ID="ddlFrom" BorderColor="#33CCFF" runat="server" Width="157px"
                                                Enabled="false">
                                            </asp:DropDownList>
                                            <b style="font-weight: normal; margin-left: 7px;">To<span style="color: Red;">*
                                            </b></label>
                                            <asp:DropDownList ID="ddlTo" BorderColor="#33CCFF" runat="server" Width="157px" Enabled="false">
                                            </asp:DropDownList>
                                            <asp:Label ID="lbltotaltime" runat="server" ForeColor="Red" Style="margin-left: 30px"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="for_sigle_row_form skt_new">
                                            <label>
                                                No. Of Period Before Lunch<span style="color: Red;">*</span></label>
                                            <asp:TextBox ID="txtnoofperiod" runat="server" onkeypress="return noAlphabets(event)"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="for_sigle_row_form skt_new">
                                            <label>
                                                No. Of Period After Lunch<span style="color: Red;">*</span></label>
                                            <asp:TextBox ID="txtafterlunch" runat="server" sonkeypress="return noAlphabets(event)"
                                                AutoPostBack="True" OnTextChanged="txtafterlunch_TextChanged"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="for_sigle_row_form skt_new">
                                            <label>
                                            </label>
                                            <asp:Label runat="server" ID="lblperiods" Font-Bold="true" ForeColor="Magenta"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr runat="server" id="trnoofperdiod" visible="false">
                                    <td style="width: 100%;">
                                        <div class="time_table_design">
                                            <label>
                                            </label>
                                            <table runat="server" id="fieldsetTableNoDistrict" width="612px" align="left" style="margin-top: 5px; border-left: 0px;">
                                                <tbody>
                                                    <tr align="center">
                                                        <td style="" align="center">
                                                            <div style="border-bottom: none; border: none;">
                                                                <table border="0" cellspacing="0" cellpadding="0" id="td1" runat="server">
                                                                    <tr style="background: #33CCFF; height: 36px; font-size: 14px; color: #fff; font-weight: bold; line-height: 36px;">
                                                                        <td style="border-left: 0px;">Period
                                                                        </td>
                                                                        <td>Start time
                                                                        </td>
                                                                        <td>End Time
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <asp:GridView ID="GridView1" runat="server" Width="100%" ShowHeader="false" AutoGenerateColumns="false"
                                                                GridLines="None" OnRowDataBound="GridView1_RowDataBound">
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <div class="" style="border-bottom: none; border-right: none;">
                                                                                <table border="0" cellspacing="0" cellpadding="0">
                                                                                    <tr>
                                                                                        <td class="" align="center" style="border-left: 0px;">
                                                                                            <asp:Label ID="Label1" runat="server"></asp:Label><span style="color: #ff0033">*</span>
                                                                                        </td>
                                                                                        <td align="left">
                                                                                            <asp:DropDownList ID="ddlstarthour" runat="server" Width="125px">
                                                                                            </asp:DropDownList>
                                                                                            <br />
                                                                                            <asp:TextBox Height="21px" runat="server" ID="txtauto"
                                                                                                BorderWidth="1px" BorderColor="#33CCFF" Width="125px" placeholder="Enter time"></asp:TextBox><br />
                                                                                        </td>
                                                                                        <td align="left">
                                                                                            <asp:DropDownList ID="ddlendhour" runat="server" Width="125px" AutoPostBack="true"
                                                                                                OnSelectedIndexChanged="ddlendhour_SelectedIndexChanged">
                                                                                            </asp:DropDownList>
                                                                                            <br />
                                                                                            <asp:TextBox Height="21px" runat="server" ID="txtauto1" BorderColor="#33CCFF" Width="125px"
                                                                                                BorderWidth="1px" placeholder="Enter time"></asp:TextBox>
                                                                                            <br />
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </div>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                    <%--    <tr>
                                                        <td style="width: 100%" align="center">
                                                            <asp:Label ID="lbmsg1" runat="server" ForeColor="Red"></asp:Label>
                                                        </td>
                                                    </tr>--%>
                                                </tbody>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr runat="server" id="trshowbtn">
                                    <td>
                                        <div class="for_sigle_row_form" id="divbtn" runat="server">
                                            <label>
                                            </label>
                                            <asp:Button ID="btnCreate" runat="server" Style="margin-left: 0px" Text="Save" CssClass="button_save"
                                                CausesValidation="False" OnClick="btnCreate_Click" OnClientClick="return check();"></asp:Button>
                                            <asp:Button ID="Button1" runat="server" Text="Cancel" CssClass="button_save" CausesValidation="False"
                                                OnClick="Button1_Click"></asp:Button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" class="style1" colspan="6">
                                        <asp:HiddenField ID="HfUid" runat="server" />
                                        <asp:HiddenField ID="HfEID" runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <%-- </ContentTemplate>
                    </asp:UpdatePanel>--%>
                        </td>
                    </tr>
                </table>
                <div class="content_pane_cont" id="contentPanedf" runat="server" visible="false">
                    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="false"
                        ShowSummary="False" ValidationGroup="g1" />
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>