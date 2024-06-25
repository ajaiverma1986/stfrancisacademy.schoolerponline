<%@ Page Title="Vechile List" Language="C#" AutoEventWireup="true" CodeFile="VehicleReport.aspx.cs" EnableEventValidation="false" MasterPageFile="~/BranchPanel/MasterPage.master" Inherits="adminPanel_VehicleReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        #ctl00_ContentPlaceHolder1_CompareValidator1 {
            margin-left: 578px;
            left: 0;
            margin-top: 5px;
            position: absolute;
            width: 184px;
        }

        .stm td {
            border-bottom: none;
            color: #333333;
            line-height: 35px;
            padding-left: 10px;
            padding-right: 5px;
        }

        .stm_head th {
            border-top: 1px solid #DDDDDD;
            color: #3A3A3A !important;
            font-size: 13px;
            padding-left: 9px;
            text-align: left;
        }
    </style>

    <%--</div>--%>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a>Transport Management</a></li>
            <li style="background: none;"><a class="active">Vehicle List</a></li>
        </ul>
        <%--    <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right;
            margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px;
                margin-right: 0px;"></iframe>
        </div>--%>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">

        <asp:UpdatePanel ID="upd22" runat="server">
            <ContentTemplate>

                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);"
                    class="stm">
                    <tr>
                        <td class="containerHeadlinenew" style="border-top: medium none;">
                            <span class="topheadingnew"></span>

                            <div style="float: right; width: 283px;">

                                <asp:DropDownList ID="ddlEnquirySource" runat="server" Width="150px" Style="margin-top: 5.8px;">
                                </asp:DropDownList>
                                <asp:Button ID="Button1" runat="server" Text="Go" ToolTip="Click here for Search"
                                    CssClass="view-enquiry" OnClick="Button1_Click1" Style="margin-top: 5px;" />

                                <asp:Button ID="btnreset" runat="server" Text="Reset" ToolTip="Click here for reset"
                                    CssClass="view-enquiry1" Style="margin-top: 5px;" OnClick="btnreset_Click" />
                                <asp:ImageButton ID="IBExcel" runat="server"
                                    ImageUrl="~/images/Excel-32-d.gif"
                                    OnClick="ImageButton1_Click" CssClass="excel"
                                    ToolTip="Click here to download Excel sheet" Width="25px" Style="margin-top: 5px; margin-left: -8px;" />
                            </div>
                            &nbsp;
                    <asp:DropDownList ID="ddlRecordperPage" runat="server" Width="90px" AutoPostBack="true"
                        Font-Size="11px" OnSelectedIndexChanged="ddlRecordperPage_SelectedIndexChanged" Style="margin-top: 5.8px; margin-left: 8px;">
                        <asp:ListItem Value="0" Text="Page Size" Selected="True"></asp:ListItem>
                        <asp:ListItem Value="1" Text="2"></asp:ListItem>
                        <asp:ListItem Value="2" Text="5"></asp:ListItem>
                        <asp:ListItem Value="3" Text="10"></asp:ListItem>
                    </asp:DropDownList></td>
                    </tr>

                    <tr>
                        <td align="left" colspan="10" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                            <asp:GridView ID="gvDetails" AutoGenerateColumns="false" EmptyDataText="No data found !"
                                CellPadding="0" GridLines="None" runat="server" BorderWidth="0" Width="100%" HeaderStyle-Height="30px" CssClass="stm"
                                OnRowCommand="gvDetails_RowCommand" OnPageIndexChanging="gvDetails_PageIndexChanging" OnRowDataBound="gvDetails_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" HeaderText=" S. No." ItemStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="sno" runat="server" Text="<%#Container.DataItemIndex+1 %>"> </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <HeaderTemplate>
                                            <asp:Label ID="lblsnox1" runat="server">Registration No</asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblregistrationno" Text='<%#Eval("registrationNo") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="lblsnox2" runat="server">Next FC Date</asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblcontactnodriver" Text='<%#Eval("NextFCDate") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <HeaderTemplate>
                                            <asp:Label ID="lblsnox3" runat="server">Model No</asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>

                                            <asp:Label ID="lblmodel" Text='<%#Eval("modelno") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <HeaderTemplate>
                                            <asp:Label ID="lblsnox4" runat="server">Total Seats</asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>

                                            <asp:Label ID="lblnoofseats" Text='<%#Eval("noofseats") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                        <HeaderTemplate>
                                            <asp:Label ID="lavseats" runat="server">Available Seats</asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>

                                            <asp:Label ID="lblavailable" runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="lblsnox5" runat="server">Next Tax Date</asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblnexttaxdate" Text='<%#Eval("NextTaxDate") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <asp:Label ID="lblsnox6" runat="server">Next Insurance Date</asp:Label>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblnextinsurencedate" Text='<%#Eval("NextInsuranceDate") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="View" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkView" runat="server" CommandName="ed" Text="View" CommandArgument='<% #bind("Id")%>'></asp:LinkButton>
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
                        <td colspan="10" class="containerHeadline pagingstrip" style="padding-left: 10px; padding-bottom: 5px;">
                            <asp:DropDownList ID="PageNo" runat="server" Width="80px" AutoPostBack="true" Font-Size="11px" OnSelectedIndexChanged="PageNo_SelectedIndexChanged">
                            </asp:DropDownList>
                            <div style="float: right; width: 137px;">
                                <asp:ImageButton ID="firstpage" runat="server" ImageUrl="~/images/first.gif" Width="25px" OnClick="firstpage_Click" />
                                <asp:ImageButton ID="previous" runat="server" ImageUrl="~/images/previous.gif" Width="25px" OnClick="previous_Click" />
                                <asp:ImageButton ID="next" runat="server" ImageUrl="~/images/next.gif" Width="25px" OnClick="next_Click" />
                                <asp:ImageButton ID="last" runat="server" ImageUrl="~/images/last.gif" Width="25px" OnClick="last_Click" />
                            </div>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>