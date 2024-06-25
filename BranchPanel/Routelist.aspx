<%@ Page Title="Route List" Language="C#" AutoEventWireup="true" EnableEventValidation="false" MasterPageFile="~/BranchPanel/MasterPage.master" CodeFile="Routelist.aspx.cs" Inherits="BranchPanel_Routelist" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%--<div class="content_pane_cont" id="contentPane">
          </div>--%>
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a>Transport Management</a></li>
            <li style="background: none;"><a class="active">Route List</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            <%--<iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px;
                margin-right: 0px;"></iframe>--%>
        </div>
    </div>
    <%--<div class="clear">
    </div>--%>
    <%--<asp:UpdatePanel ID="upd1" runat="server">
         <ContentTemplate>--%>
    <div class="content_pane_cont input_content" id="contentPane">
        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
                    class="stm">
                    <tr>
                        <td colspan="10" class="containerHeadlinenew" style="border-top: medium none;">

                            <span class="topheadingnew"></span>
                            <div style="float: right; width: 283px;">

                                <asp:DropDownList ID="ddlEnquirySource" runat="server" Width="150px" Style="margin-top: 6.5px;">
                                </asp:DropDownList>
                                <asp:Button ID="Button1" runat="server" Text="Go" ToolTip="Click here for Search"
                                    CssClass="view-enquiry" OnClick="Button1_Click" Style="margin-top: 6.5px;" />

                                <asp:Button ID="btnreset" runat="server" Text="Reset" ToolTip="Click here for reset"
                                    CssClass="view-enquiry1" Style="margin-top: 5px;" OnClick="btnreset_Click" />
                                <asp:ImageButton ID="IBExcel" runat="server" ImageUrl="~/images/Excel-32-d.gif" Visible="true"
                                    OnClick="ImageButton1_Click" CssClass="excel3" Width="25" ToolTip="Click here to download Excel sheet" Style="margin-top: 6.5px; margin-left: -8px;" />
                            </div>
                            <asp:DropDownList ID="ddlRecordperPage" runat="server" Width="90px" AutoPostBack="true"
                                Font-Size="11px" OnSelectedIndexChanged="ddlRecordperPage_SelectedIndexChanged" Style="margin-top: 4.9px;">
                                <asp:ListItem Value="0" Text="Page Size" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="1" Text="10"></asp:ListItem>
                                <asp:ListItem Value="2" Text="20"></asp:ListItem>
                                <asp:ListItem Value="3" Text="50"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>

                <table cellpadding="2" cellspacing="0" border="0" style="width: 100%; border-left: none !important;">
                    <tr>

                        <td>
                            <asp:GridView ID="Gridview1" runat="server" HeaderStyle-Height="30px" CssClass="stm" BorderWidth="0"
                                AutoGenerateColumns="false" GridLines="None" OnRowCommand="Gridview1_RowCommand" Width="100%" OnPageIndexChanging="Gridview1_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lblsno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                            <%--<asp:Label ID="Label1" Text='<%# Eval("RowNumber") %>' runat="server"></asp:Label>--%>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Route No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblrouteno" runat="server" Text='<%# Bind("Routeno") %>'>"> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Start">
                                        <ItemTemplate>
                                            <asp:Label ID="lblsource" runat="server" Text='<%#Bind("Origin")%>'> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="End">
                                        <ItemTemplate>
                                            <asp:Label ID="lbldest" runat="server" Text='<%#Bind("Destination") %>'>'> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Distance (in KM)">
                                        <ItemTemplate>
                                            <asp:Label ID="lblbus" runat="server" Text='<%#Bind("Distance")%>'>' </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="No of Student">
                                        <ItemTemplate>
                                            <asp:Label ID="lblcountstu" runat="server" Text='<%#Bind("noofstudent") %>'></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkview" runat="server" Text="View" CommandName="View" ToolTip="Create Stops Between Source and Destination" CommandArgument='<%# Bind("Rid")%>'></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
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
                        <td colspan="10" class="containerHeadline pagingstrip" style="padding-left: 10px; padding-bottom: 5px;">
                            <asp:DropDownList ID="PageNo" runat="server" Width="80px" AutoPostBack="true" Font-Size="11px" OnSelectedIndexChanged="PageNo_SelectedIndexChanged">
                            </asp:DropDownList>
                            <div style="float: right; width: 143px;">
                                <asp:ImageButton ID="firstpage" runat="server" ImageUrl="~/images/first.gif" Width="25px" OnClick="firstpage_Click" />
                                <asp:ImageButton ID="previous" runat="server" ImageUrl="~/images/previous.gif" Width="25px" OnClick="previous_Click" />
                                <asp:ImageButton ID="next" runat="server" ImageUrl="~/images/next.gif" Width="25px" OnClick="next_Click" />
                                <asp:ImageButton ID="last" runat="server" ImageUrl="~/images/last.gif" Width="25px" OnClick="last_Click" />
                            </div>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="IBExcel" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <%--  </ContentTemplate>
          <Triggers>
            <asp:PostBackTrigger ControlID="IBExcel" />
        </Triggers>
         </asp:UpdatePanel>--%>
</asp:Content>