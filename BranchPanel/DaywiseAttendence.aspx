<%@ Page Title="Daywise Attendence Report" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="DaywiseAttendence.aspx.cs" Inherits="BranchPanel_DaywiseAttendence" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Student Attendence</a></li>
            <li><a href="#">Attendence Report</a></li>
            <li style="background: none;"><a class="active" href="#">Daywise Attendence</a></li>
        </ul>
    </div>

    <asp:Button ID="btn1" runat="server" Text="DayWise Attendance" CssClass="button_save"
        OnClick="btn1_Click" ToolTip="Click here to see attendance daywise." />

    <asp:Button ID="btn2" runat="server" Text="Monthly Attendance" CssClass="button_save"
        OnClick="btn2_Click" ToolTip="Click here to see attendance monthwise." />
    <asp:Button ID="btn3" runat="server" Text="Student Attendance" CssClass="button_save"
        OnClick="btn3_Click" ToolTip="Click here to see attendance studentwise." />

    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Daywise Attendence Report
        </div>
        <div class="for_sigle_row_form">
        </div>
        <asp:UpdatePanel runat="server" ID="upd1">
            <ContentTemplate>
                <div class="for_sigle_row_form">
                    <label>
                        Select Month & Date<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="DDLMonth" runat="server" Width="125px" AutoPostBack="True"
                        OnSelectedIndexChanged="DDLMonth_SelectedIndexChanged">
                    </asp:DropDownList>
                    &nbsp;
                    <asp:DropDownList ID="ddldays" runat="server" Width="80px" AutoPostBack="True" OnSelectedIndexChanged="ddldays_SelectedIndexChanged">
                    </asp:DropDownList>
                    &nbsp;
                    <asp:TextBox ID="txtDAyname" runat="server" Width="80px" ReadOnly="true"></asp:TextBox>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel runat="server" ID="UpdatePanel1">
            <ContentTemplate>
                <div style="margin-top: 15px;">
                    <table cellpadding="2" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
                        <%--<tr id="tr1" runat="server" style="background: #33ccff;">
                            <td class="stm_head2" style="width: 8%; padding-left: 10px; color: #dddddd;">
                                <asp:Label ID="Label1" runat="server">S No.</asp:Label>
                            </td>
                            <td class="stm_head2" style="width: 12%; padding-left: 10px; color: #dddddd;">
                                Class
                            </td>
                            <td style="padding-left: 10px; color: ##dddddd;" class="stm_head2">
                                <asp:Label ID="lblhead" runat="server">Section</asp:Label>
                            </td>
                            <td style="width: 12%; padding-left: 10px; color: #dddddd; font-weight: bold;">
                                <asp:Label ID="Label2" runat="server">Total Student</asp:Label>
                            </td>
                            <td style="width: 12%; padding-left: 10px; color: #dddddd; font-weight: bold;">
                                <asp:Label ID="Label3" runat="server">Total Present Student</asp:Label>
                            </td>
                            <td style="width: 12%; padding-left: 10px; color: #dddddd; font-weight: bold;">
                                <asp:Label ID="Label4" runat="server">Total Absent Student</asp:Label>
                            </td>
                        </tr>--%>
                        <tr>
                            <td>
                                <asp:GridView ID="GrdAttendence" AutoGenerateColumns="false" EmptyDataText="No records for this date.!"
                                    ShowFooter="true" Width="100%" BorderWidth="0" runat="server" GridLines="None" CssClass="stm"
                                    OnRowDataBound="GrdAttendence_RowDataBound" OnRowCommand="GrdAttendence_RowCommand">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S No.">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="8%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Class">
                                            <ItemTemplate>
                                                <asp:Label ID="lblclassname" runat="server" Text='<%#Eval("classname") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="12%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Section">
                                            <ItemTemplate>
                                                <asp:Label ID="lblsubject" runat="server" Text='<%# Bind("sectionname") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                Total
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total Student">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lblTotal" runat="server" Text='<%# Bind("Totalstudent") %>' ToolTip="Click here to see attendance details for this class."
                                                    CommandName="View" CommandArgument='<%# Bind("CWSID") %>' Font-Bold="true" ForeColor="Black" Font-Size="Larger" Font-Underline="true">
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lbltotalF" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="12%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total Present Student">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPStudent" runat="server" Text='<%# Bind("Presentstudent") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lbltotalPF" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="12%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total Absent Student">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAstudent" runat="server" Text='<%# Bind("Astu") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lbltotalAF" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle Width="12%" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_dark" />
                                    <HeaderStyle CssClass="stm_head" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>