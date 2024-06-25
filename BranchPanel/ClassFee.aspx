<%@ Page Title="Class Fee Report" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="ClassFee.aspx.cs" Inherits="BranchPanel_ClassFee" %>

<%@ Register Src="~/BranchPanel/feereport.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .active2 {
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
            <li><a href="Default.aspx">Home</a></li>
            <li><a>Fee Managment</a></li>
            <li><a>Fee Collection</a></li>
            <li style="background: none;"><a class="active">Class Fee Report</a></li>
        </ul>
        <div class="arrowt">
            <a href="Recentfee.aspx">
                <img src="../images/back-button.png"></a>
        </div>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <br />
        <asp:UpdatePanel runat="server" ID="upd1">
            <ContentTemplate>
                <div class="for_sigle_row_form">
                    <label>
                        Select Class<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="DDLClass" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DDLClass_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Select Month<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList runat="server" ID="ddlMonth" AutoPostBack="true"
                        OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
                <br />
                <div id="Table4" runat="server">

                    <table width="101%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px;"
                        class="stmft">
                        <tr>
                            <td colspan="10" class="containerHeadlinenew">
                                <asp:DropDownList ID="ddlRecordperPage" runat="server" Width="90px" AutoPostBack="true"
                                    Font-Size="11px" OnSelectedIndexChanged="ddlRecordperPage_SelectedIndexChanged" Style="margin-top: -1.5px; margin-left: 18px;">
                                    <asp:ListItem Value="0" Text="Page Size" Selected="True"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="20"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="50"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="100"></asp:ListItem>
                                </asp:DropDownList>

                                <div style="float: right; width: 223px; margin-top: -1.5px;">
                                    <asp:Panel ID="pa1" DefaultButton="Button1" runat="server">
                                        <asp:TextBox ID="txtnamesearch" runat="server" placeholder="search student name" Width="150px" Height="23px"> </asp:TextBox>
                                    </asp:Panel>
                                    <asp:Button ID="Button1" runat="server" Text="Go" ToolTip="Click here for Search"
                                        CssClass="view-enquiry" OnClick="Button1_Click" Height="24px" />
                                </div>
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="2" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important;">
                        <tr>
                            <td align="left" colspan="7" style="width: 100%; padding-left: 0px; padding-right: 0px;">

                                <asp:GridView runat="server" ID="gridreport" ShowHeader="true" AutoGenerateColumns="false" GridLines="None" Width="100%" CssClass="stm">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S No.">
                                            <ItemTemplate>
                                                <asp:Label ID="sno" runat="server" Text='<%# Bind("RowNumber") %>'> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lbldate" runat="server" Text='<%# Bind("name") %>'> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Class">
                                            <ItemTemplate>
                                                <asp:Label ID="lblclass" runat="server" Text='<%# Bind("applyclass") %>'> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Admission No">
                                            <ItemTemplate>
                                                <asp:Label ID="lblstudentname" runat="server" Text='<%# Bind("ADNO") %>'> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblamnt" runat="server" Text='<%# Bind("totalfee","{0:0.00}") %>'> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Paid Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lblpafee" runat="server" Text='<%# Bind("payefee","{0:0.00}") %>'> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Due Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="lbduefee" runat="server" Text='<%# Bind("duefees","{0:0.00}") %>'> </asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_dark" />
                                    <AlternatingRowStyle CssClass="stm_light" />
                                    <HeaderStyle CssClass="stm_head" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>

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
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>