<%@ Page Title="Student Report" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master"
    AutoEventWireup="true" CodeFile="StudentReport.aspx.cs" Inherits="BranchPanel_StudentReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_top">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px; width: 33px;">Home</a></li>
            <li><a>Student Attendance</a></li>
            <li><a>Attendence Report</a></li>
            <li style="background: none;"><a class="active">Studentwise Attendance </a>
            </li>
        </ul>
    </div>

    <asp:Button ID="btn1" runat="server" Text="Day Attendance" CssClass="button_save"
        OnClick="btn1_Click" ToolTip="Click here to see attendance daywise." />

    <asp:Button ID="btn2" runat="server" Text="Monthly Attendance" CssClass="button_save"
        OnClick="btn2_Click" ToolTip="Click here to see attendance monthwise." />
    <asp:Button ID="btn3" runat="server" Text="Student Attendance" CssClass="button_save"
        OnClick="btn3_Click" ToolTip="Click here to see attendance studentwise." />

    <div class="content_pane_cont input_content" id="contentPane">
        <div class="containerHeadline" style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;">
            Studentwise Attendance
        </div>
        <br />
        <asp:UpdatePanel runat="server" ID="upd1">
            <ContentTemplate>
                <div class="for_sigle_row_form">
                    <label>
                        Select Class<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="DDLClass" runat="server" OnSelectedIndexChanged="DDLClass_SelectedIndexChanged"
                        AutoPostBack="true">
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Select Section<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="DDLSection" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DDLSection_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
                <div class="for_sigle_row_form">
                    <label>
                        Select Student<span style="color: #ff0066">*</span></label>
                    <asp:DropDownList ID="ddlStudent" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlStudent_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel runat="server" ID="UpdatePanel1">
            <ContentTemplate>
                <div style="margin-top: 15px;" align="center">
                    <table cellpadding="2" cellspacing="0" border="0" style="width: 100%; border-left: none !important;">

                        <tr>
                            <td colspan="5" style="border-bottom: 1px solid #ddd;">
                                <asp:GridView ID="GrdAttendence" AutoGenerateColumns="false" GridLines="None" Width="100%"
                                    BorderWidth="0" runat="server" CssClass="stm" EmptyDataText="Attendance is yet to be taken for this student.">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S No.">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="10%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Month Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMonth" runat="server" Text='<%# Bind("MonthName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="30%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Total Working Days">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTotalDays" runat="server" Text='<%# Bind("workingdays") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="20%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Present Days">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPDays" runat="server" Text='<%# Bind("PresentDays") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle Width="20%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Percentage">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPercent" runat="server" Text='<%# Bind("Percentage") %>' Font-Bold="true"></asp:Label>&nbsp;%
                                            </ItemTemplate>
                                            <ItemStyle Width="20%" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_dark" />
                                    <HeaderStyle CssClass="stm_head" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <div class="for_sigle_row_form">
                                    <label>
                                    </label>
                                    <asp:Button runat="server" ID="btnBack" CssClass="button_save" ToolTip="Click here to reset the list"
                                        Text="Back" OnClick="btnBack_Click" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>