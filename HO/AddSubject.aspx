<%@ Page Title="Add Subject" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AddSubject.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Add Subject</h2>
            <asp:Button runat="server" ID="Button1" CssClass="button_save" Text="Add Subject"
                ToolTip="Click here to add Subject." OnClick="Button1_Click" Style="float: right; margin-top: 5px; margin-right: 3px" />
            <asp:Button runat="server" ID="btnaddoptionalsubject" CssClass="button_save" Style="margin-left: 745px; margin-top: 4px" Text="Add Optional Subject"
                ToolTip="Click here to add Subject." OnClick="btnaddoptionalsubject_Click" />
        </div>
        <br />
        <div id="formtop" runat="server">
            <div class="for_sigle_row_form">
                <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
                <asp:DropDownList ID="ddlfinancialyear" runat="server">
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form">
                <label>Add Subject:</label>
                <asp:TextBox ID="txtAddClass" runat="server"></asp:TextBox>
                <asp:Label ID="lblmsg"
                    runat="server" ForeColor="Red" EnableViewState="False"></asp:Label>
            </div>
            <div class="for_sigle_row_form">
                <label></label>
                <asp:Label ID="lblMsg1" runat="server" ForeColor="Red"></asp:Label>
                <br />
                <label></label>
                <asp:Button ID="btnSubmit" runat="server" Text="submit" CssClass="button_save" OnClick="btnSubmit_Click" />
                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="button_save" OnClick="btnUpdate_Click" />
                <asp:Button ID="btnback" runat="server" Text="Back" CssClass="button_save" OnClick="btnback_Click" />
            </div>
        </div>

        <div id="addoptional" runat="server">
            <div class="for_sigle_row_form">
                <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
                <asp:DropDownList ID="ddlforfyear" runat="server" OnSelectedIndexChanged="ddlforfyear_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form">
                <label>Select Class:</label>
                <asp:DropDownList ID="ddloptionalclass" runat="server"></asp:DropDownList>
            </div>
            <div class="for_sigle_row_form">
                <label>Subject Name:</label>
                <asp:TextBox ID="txtoptionalsub" runat="server"></asp:TextBox>
                <div class="for_sigle_row_form">
                </div>
                <br />
                <label></label>
                <asp:Button ID="btnoptional" runat="server" Text="submit" CssClass="button_save" OnClick="btnoptional_Click" />
                <asp:Button ID="btnop" runat="server" Text="Update" CssClass="button_save" OnClick="btnop_Click" />
                <asp:Button ID="btnbackforoptional" runat="server" Text="Back" CssClass="button_save" OnClick="btnbackforoptional_Click" />
            </div>
        </div>
        <div id="griddiv" runat="server">
            <table cellpadding="2" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
                <tr>
                    <td>
                        <div class="for_sigle_row_form" id="divforsearching" runat="server">
                            <asp:DropDownList ID="ddlfinacialyearforsearching" runat="server" Style="width: 150px; margin-left: 5px" OnSelectedIndexChanged="ddlfinacialyearforsearching_SelectedIndexChanged" AutoPostBack="true">
                            </asp:DropDownList>
                        </div>
                        <asp:GridView ID="grdBranch" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                            runat="server" OnRowCommand="grdBranch_RowCommand" CssClass="stm" GridLines="None">

                            <Columns>
                                <asp:TemplateField HeaderText="S No.">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="22%" HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Subject Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSubjectName" Text='<%# Eval("SubjectName") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="22%" HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Subject Type">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsubtyp" Text='<%# Eval("subtype") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="22%" HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Session">
                                    <ItemTemplate>
                                        <asp:Label ID="lblfyname" Text='<%# Eval("Fyname") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="22%" HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStatus" Text='<%# Eval("status") %>' runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="22%" HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgEdit" runat="server" CommandName="edit12" CommandArgument='<%# Eval("id") %>'
                                            ImageUrl="~/images/edit.gif" CausesValidation="false" />
                                    </ItemTemplate>
                                    <ItemStyle Width="22%" HorizontalAlign="Center" />
                                    <HeaderStyle HorizontalAlign="Center" />
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
        <br />
        <br />
    </div>
</asp:Content>