<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="studentattendance.aspx.cs" Inherits="BranchPanel_studentattendance" %>

<%@ Register Src="~/BranchPanel/studentadmission.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
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
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Student Administration</a></li>
            <li><a href="studentadmissionlistaspx.aspx">Admission</a></li>
            <li style="background: none;"><a class="active" href="#">View Admission Fee</a></li>
        </ul>
        <div class="arrowt">
            <a href="studentadmissionlistaspx.aspx">
                <img src="../images/back-button.png" /></a>
        </div>
    </div>

    <div class="clear">
    </div>

    <asp:UpdatePanel runat="server" ID="UpdatePanel1">
        <ContentTemplate>
            <div class="content_pane_cont input_content" id="contentPane">
                <My:stu runat="server" ID="Stu1" />
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
                    </table>
                </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>