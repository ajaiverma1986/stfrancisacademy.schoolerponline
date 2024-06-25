<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="DiscountList.aspx.cs" Inherits="BranchPanel_DiscountList"
    EnableEventValidation="false" %>

<%@ Register Src="~/BranchPanel/feereport.ascx" TagName="fee" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .active1 {
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
            margin-bottom: 2px;
        }

        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 28px;
            margin-top: 7px;
        }
    </style>
    <%--<div class="content_top">
        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Master Report</a></li>
            <li><a>Fee Report</a></li>
            <li style="background: none;"><a class="active">Discount List</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
        </div>
    </div>--%>

    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:fee runat="server" ID="MyUserInfoBoxControl" />
        <table width="101%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px;"
            class="stmft">
            <tr>
                <td colspan="10" class="containerHeadline">

                    <asp:DropDownList ID="ddlRecordperPage" runat="server" Width="90px" AutoPostBack="true"
                        Font-Size="11px" OnSelectedIndexChanged="ddlRecordperPage_SelectedIndexChanged">
                        <asp:ListItem Value="0" Text="Page Size" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="1" Text="10"></asp:ListItem>
                        <asp:ListItem Value="2" Text="20"></asp:ListItem>
                        <asp:ListItem Value="3" Text="50"></asp:ListItem>
                    </asp:DropDownList>
                    <div style="float: right; width: 576px; margin-right: -340px">

                        <asp:DropDownList ID="ddlsearch" runat="server" Width="150px">
                        </asp:DropDownList>

                        <asp:Button ID="btnsearch" runat="server" Text="Go" ToolTip="Click here for Search"
                            CssClass="view-enquiry" OnClick="btnsearch_Click" Height="24px" />
                        <asp:ImageButton ID="IBExcel" runat="server" ImageUrl="~/images/Excel-32-d.gif" Visible="true"
                            CausesValidation="false" OnClick="ImageButton1_Click" Height="23px"
                            CssClass="excel" ToolTip="Click here to download Excel sheet" Style="margin-top: 0; margin-left: -5px;" />
                    </div>
                </td>
            </tr>
        </table>

        <table width="101%" border="0" cellspacing="0" cellpadding="0" runat="server" id="GridBatch">

            <tr>
                <td align="left" colspan="7" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                    <asp:GridView runat="server" ID="gvdetails" PageSize="20" AutoGenerateColumns="false"
                        Width="100%" CssClass="stm" GridLines="None"
                        EmptyDataText="No record found.">
                        <Columns>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="name" HeaderText="Student Name" ItemStyle-Width="15%"
                                ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="coursename" HeaderText="Course" ItemStyle-Width="20%"
                                ItemStyle-HorizontalAlign="Center" />
                            <asp:TemplateField HeaderText="Branch name" HeaderStyle-ForeColor="#7A96C5">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lbstu3"
                                        Text='<%#Eval("name1") %>' ForeColor="#5A94CE" Font-Bold="true"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actual Course Fee (₹)">

                                <ItemTemplate>

                                    <asp:Label ID="lblDate2" runat="server" Text='<%# Eval("totalamount","{0:0.00}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="discounttype" HeaderText="Discount Type" ItemStyle-Width="15%"
                                ItemStyle-HorizontalAlign="Center" />
                            <asp:TemplateField HeaderText="Discount Value (₹)">
                                <ItemTemplate>

                                    <asp:Label ID="lblDate23" runat="server" Text='<%# Eval("Discountamount","{0:0.00}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actual Payable Amount (₹)">
                                <ItemTemplate>

                                    <asp:Label ID="lblDate232" runat="server" Text='<%# Eval("payable","{0:0.00}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                        <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td align="left" colspan="7" runat="server" visible="false" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                    <asp:GridView runat="server" ID="GridView1" PageSize="20" AutoGenerateColumns="false"
                        Width="100%" CssClass="stm" GridLines="None"
                        EmptyDataText="No record found.">
                        <Columns>
                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                                <ItemTemplate>
                                    <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="name" HeaderText="Student Name" ItemStyle-Width="15%"
                                ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="coursename" HeaderText="Course" ItemStyle-Width="20%"
                                ItemStyle-HorizontalAlign="Center" />
                            <asp:TemplateField HeaderText="Branch name" HeaderStyle-ForeColor="#7A96C5">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="lbstu3"
                                        Text='<%#Eval("name1") %>' ForeColor="#5A94CE" Font-Bold="true"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actual Course Fee (₹)">

                                <ItemTemplate>

                                    <asp:Label ID="lblDate2" runat="server" Text='<%# Eval("totalamount","{0:0.00}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="discounttype" HeaderText="Discount Type" ItemStyle-Width="15%"
                                ItemStyle-HorizontalAlign="Center" />
                            <asp:TemplateField HeaderText="Discount Value (₹)">
                                <ItemTemplate>

                                    <asp:Label ID="lblDate23" runat="server" Text='<%# Eval("Discountamount","{0:0.00}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actual Payable Amount (₹)">
                                <ItemTemplate>

                                    <asp:Label ID="lblDate232" runat="server" Text='<%# Eval("payable","{0:0.00}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                        <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="10" class="containerHeadline" style="padding-left: 10px;">
                    <asp:DropDownList ID="PageNo" runat="server" Width="80px" AutoPostBack="true" Font-Size="11px"
                        OnSelectedIndexChanged="PageNo_SelectedIndexChanged" Style="margin-top: -4px;">
                    </asp:DropDownList>
                    <div style="margin-left: 350px; float: left; width: 300px;">
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
</asp:Content>