<%@ Page Title="FeeType Report" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="feetypereport.aspx.cs" Inherits="BranchPanel_feetypereport" %>

<%@ Register Src="~/BranchPanel/feereport.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .active98 {
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

    <script language="javascript" type="text/javascript">
        function divexpandcollapse(divname) {
            var div = document.getElementById(divname);
            var img = document.getElementById('img' + divname);
            if (div.style.display == "none") {
                div.style.display = "inline";
                img.src = "../images/Green_Minus.gif";
                img.title = "Click here to hide";
            } else {
                div.style.display = "none";
                img.src = "../images/addd11.png";
                img.title = "Click here to show";
            }
        }
    </script>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a>Fee Managment</a></li>
            <li><a>Fee Collection</a></li>

            <li style="background: none;"><a class="active">Fee Type Report</a></li>
        </ul>

        <div class="arrowt">
            <a href="Recentfee.aspx">
                <img src="../images/back-button.png"></a>
        </div>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <%-- <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadlinenew">
      <span style="line-height:38px;">      Fee Type-Wise  Report </span>
        </div>--%>
        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>

                <div id="div45" runat="server">

                    <div class="for_sigle_row_form" id="Div1" runat="server" style="float: none; margin-right: 15px;">
                        <label style="width: 189px;"></label>
                        <asp:DropDownList ID="ddlsearch" runat="server" OnSelectedIndexChanged="ddlsearch_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="0">--Select FeeType--</asp:ListItem>
                            <asp:ListItem Value="1">Quarterly</asp:ListItem>
                            <asp:ListItem Value="2">Monthly</asp:ListItem>
                        </asp:DropDownList>

                        &nbsp;
                    </div>
                </div>

                <br />

                <table width="101%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px;"
                    class="stmft">
                    <tr>
                        <td colspan="10" class="containerHeadlinenew">
                            <asp:DropDownList ID="ddlRecordperPage" OnSelectedIndexChanged="ddlRecordperPage_SelectedIndexChanged" runat="server" Width="90px" AutoPostBack="true"
                                Font-Size="11px" Style="margin-top: -1.5px; margin-left: 18px;">
                                <asp:ListItem Value="0" Text="Page Size" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="1" Text="20"></asp:ListItem>
                                <asp:ListItem Value="2" Text="50"></asp:ListItem>
                                <asp:ListItem Value="3" Text="100"></asp:ListItem>
                            </asp:DropDownList>

                            <div style="float: right; width: 400px; margin-top: -1.5px;">
                                <asp:DropDownList ID="ddlEnquirySource" runat="server" Width="150px">
                                </asp:DropDownList>
                                <asp:Panel ID="pa1" DefaultButton="Button1" runat="server">
                                    <asp:TextBox ID="txtnamesearch" runat="server" placeholder="search student name" Width="150px" Height="23px"> </asp:TextBox>
                                </asp:Panel>
                                <asp:Button ID="Button1" runat="server" Text="Go" ToolTip="Click here for Search"
                                    CssClass="view-enquiry" Height="24px" OnClick="Button1_Click" />
                            </div>
                        </td>
                    </tr>
                </table>

                <asp:GridView runat="server" ID="gridAnnualFee" ShowHeader="true"
                    AutoGenerateColumns="false" GridLines="None" Width="100%" CssClass="stm" OnRowDataBound="gridAnnualFee_RowDataBound">
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="30px">
                            <ItemTemplate>
                                <a href="JavaScript:divexpandcollapse('div<%# Eval("adid") %>');">
                                    <img id='imgdiv<%# Eval("adid") %>' width="20px" border="0" src="../images/addd11.png" title="Click here to show" />
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Roll No">
                            <ItemTemplate>
                                <asp:Label ID="lbldate" runat="server" CssClass="adno" Text='<%# Bind("adno") %>'>  </asp:Label>
                                <asp:HiddenField ID="hd45" runat="server" Value='<%# Bind("adid") %>' />
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Class">
                            <ItemTemplate>
                                <asp:Label ID="lblclass" runat="server" CssClass="applyclass" Text='<%# Bind("applyclass") %>'> </asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Student Name">
                            <ItemTemplate>
                                <asp:Label ID="lblstudentname" runat="server" CssClass="FirstName" Text='<%# Bind("FirstName") %>'> </asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="18%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Pay Type">
                            <ItemTemplate>
                                <asp:Label ID="lblamnt23" runat="server" CssClass="total" Text='<%# Bind("paytypename") %>'> </asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="18%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Next Due Date">
                            <ItemTemplate>
                                <asp:Label ID="lbldues" runat="server" CssClass="total12"> </asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="18%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Due Amount">
                            <ItemTemplate>
                                <asp:Label ID="lbldues23" runat="server"> </asp:Label>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="18%" />
                        </asp:TemplateField>

                        <asp:TemplateField>
                            <ItemTemplate>
                                <tr>
                                    <td colspan="100%">
                                        <div id='div<%# Eval("adid") %>' style="display: none; position: relative; left: 15px; overflow: auto">
                                            <asp:GridView ID="gvChildGrid" runat="server" AutoGenerateColumns="false" BorderStyle="Double" Style="border: 3px solid;" BorderColor="#df5015" GridLines="Horizontal" Width="50%">
                                                <HeaderStyle BackColor="#df5015" Font-Bold="true" ForeColor="White" />
                                                <RowStyle BackColor="#E1E1E1" />
                                                <AlternatingRowStyle BackColor="White" />
                                                <HeaderStyle BackColor="#df5015" Font-Bold="true" ForeColor="White" />
                                                <Columns>

                                                    <asp:BoundField DataField="MonthName" HeaderText="" HeaderStyle-HorizontalAlign="Center" ItemStyle-ForeColor="DarkBlue" />

                                                    <asp:BoundField DataField="totalqfees" HeaderText="Total Fee" HeaderStyle-HorizontalAlign="Center" ItemStyle-ForeColor="DarkCyan" DataFormatString="Rs{0:f}" />
                                                    <asp:BoundField DataField="paidqamount" HeaderText="Paid Fee" HeaderStyle-HorizontalAlign="Center" DataFormatString="Rs{0:f}" />
                                                    <asp:BoundField DataField="balanceqfee" HeaderText="Balance Fee" HeaderStyle-HorizontalAlign="Center" DataFormatString="Rs{0:f}" ItemStyle-ForeColor="Sienna" />
                                                </Columns>
                                            </asp:GridView>
                                        </div>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                    <RowStyle CssClass="stm_dark" HorizontalAlign="Center" />
                    <AlternatingRowStyle CssClass="stm_light" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="stm_head" />
                </asp:GridView>

                <table width="101%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px;"
                    class="stmft">
                    <tr>
                        <td colspan="10" class="containerHeadline pagingstrip">
                            <asp:DropDownList ID="PageNo" runat="server" Width="80px" AutoPostBack="true" Font-Size="11px"
                                OnSelectedIndexChanged="PageNo_SelectedIndexChanged" Style="margin-top: -5.5px;">
                            </asp:DropDownList>
                            <div style="float: right; width: 157px; margin-top: -4px;">
                                <asp:ImageButton ID="firstpage" runat="server" ImageUrl="~/images/first.gif" Width="25px"
                                    OnClick="firstpage_Click" />
                                <asp:ImageButton ID="previous" runat="server" ImageUrl="~/images/previous.gif" Width="25px"
                                    OnClick="previous_Click" />
                                <asp:ImageButton ID="next" runat="server" ImageUrl="~/images/next.gif" Width="25px"
                                    OnClick="next_Click" />
                                <asp:ImageButton ID="last" runat="server" ImageUrl="~/images/last.gif" Width="25px"
                                    OnClick="last_Click" />
                            </div>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>