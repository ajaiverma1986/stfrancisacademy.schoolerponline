<%@ Page Title="Student ExamMaster" Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master" CodeFile="stuexammaster.aspx.cs" Inherits="BranchPanel_Exams_stuexammaster" %>

<%@ Register Src="~/BranchPanel/Exams/exam.ascx" TagName="stu" TagPrefix="My" %>

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
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="testlist.aspx">Exam List</a></li>
            <li style="background: none;"><a class="active">Students in Exam</a></li>
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

        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="containerHeadline" colspan="2" style="padding-left: 15px;">
                    <asp:DropDownList ID="ddlselectbatch" runat="server" Width="150px" Font-Size="11px">
                    </asp:DropDownList>
                    <asp:Button ID="Button1" runat="server" float="left" Text="Go" ToolTip="Click here to view only selected batch Student"
                        CssClass="view-enquiry" OnClick="Button1_Click" />
                </td>
            </tr>
            <tr>
                <td valign="top" align="left" style="width: 50%; padding-right: 0px; padding-left: 15px; padding-top: 10px">
                    <asp:GridView ID="GRDSTUDENT" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                        runat="server" CssClass="stm0" GridLines="None" EmptyDataText="No student found for this lecture who is already in this lecture."
                        OnRowCommand="GRDSTUDENT_RowCommand">
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
                            <asp:TemplateField HeaderText="Remove">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbllnk1" runat="server" Text="Remove" CommandArgument='<%# Bind("semid") %>'
                                        CommandName="removestufromlec"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Width="17%" HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                    </asp:GridView>
                </td>
                <td valign="top" style="width: 50%; padding-left: 15px; padding-top: 10px; padding-right: 15px;">
                    <asp:GridView ID="grdLateStudents" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                        runat="server" CssClass="stm0" GridLines="None" EmptyDataText="No student found for this lecture who can be added to this lecture!"
                        OnRowCommand="grdLateStudents_RowCommand">
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
                                    <asp:Label ID="lblsubject1" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                                    <asp:HiddenField ID="HD12" runat="server" Value='<%# Bind("admiid") %>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="58%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Add">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbllnk12" runat="server" Text="Add" CommandArgument='<%# Bind("semid") %>'
                                        CommandName="addStudent"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Width="17%" HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                        <RowStyle CssClass="stm_light" />
                        <AlternatingRowStyle CssClass="stm_dark" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <br />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>