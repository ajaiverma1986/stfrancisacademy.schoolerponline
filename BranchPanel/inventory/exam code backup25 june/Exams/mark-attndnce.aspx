<%@ Page Title="Mark Attendance" Language="C#" AutoEventWireup="true" CodeFile="mark-attndnce.aspx.cs" MasterPageFile="~/BranchPanel/MasterPage.master"
    Inherits="BranchPanel_Exam_mark_attndnce" %>

<%@ Register Src="~/BranchPanel/Exams/exam.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .active0 {
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
    <style type="text/css">
        .file_border {
            border: 1px solid #9A9A9A;
            border-radius: 3px;
            width: 150px;
            height: 20px;
            margin-top: 7px;
        }

        #content_pane {
            background: #fff;
        }
    </style>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Exams</a></li>
            <li style="background: none;"><a class="active" href="#">Mark Attendance</a></li>
        </ul>
        <div class="arrowt">
            <a href="testlist.aspx">
                <img src="../../images/back-button.png" /></a>
        </div>
    </div>
    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="contentPane" style="position: relative;">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div class="clear">
        </div>
        <div class="clear">
        </div>
        <asp:GridView ID="GridView1" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
            runat="server" CssClass="stm0" GridLines="None" OnRowCommand="GrdAttendence_RowCommand">
            <Columns>
                <asp:TemplateField HeaderText="S.No">
                    <ItemTemplate>
                        <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" Width="8%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Student Name">
                    <ItemTemplate>
                        <asp:Label ID="lblsubject" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                        <asp:HiddenField ID="HD1" runat="server" Value='<%# Bind("admiid") %>' />
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" Width="58%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mark Absent">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkclass" runat="server" Checked='<%# Bind("attstatus") %>' />
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                    <ItemStyle HorizontalAlign="Center" Width="17%" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Remove">
                    <ItemTemplate>
                        <asp:LinkButton ID="lbllnk1" runat="server" Text="remove" CommandArgument='<%# Bind("admiid") %>'
                            CommandName="removestufromlec"></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle Width="17%" />
                </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
            <RowStyle CssClass="stm_light" />
            <AlternatingRowStyle CssClass="stm_dark" />
        </asp:GridView>
        <div class="for_sigle_row_form">
            <label></label>
            <asp:Button ID="Button1" runat="server" Text="Save Attendance" CssClass="button_save"
                OnClick="btnsubmit_Click" />&nbsp;
        </div>
    </div>
</asp:Content>