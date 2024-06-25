<%@ Page Title="Add Subject With Branch" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="AddSubjectBranch.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Add Subject With Branch</h2>
        </div>
        <br />
        <div class="clear"></div>
        <div class="div_form st">
            <div class="for_sigle_row_form">
                <label>
                    Select Session:</label>
                <asp:DropDownList ID="ddlfyear" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    <asp:ListItem Value="0" Selected="True">-- Select Session --</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form">

                <div class="clear"></div>
                <label>
                    Select Branch:</label>
                <asp:DropDownList ID="ddlbranch" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlbranch_SelectedIndexChanged">
                    <asp:ListItem Value="0" Selected="True">-- Select Branch --</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Select Class:</label>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    <asp:ListItem Value="0" Selected="True">-- Select Class --</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div style="margin-top: 15px;">
                <table style="width: 100%;" class="stm">
                    <tr id="tr1" runat="server" class="stm_head">
                        <td style="width: 8%;">
                            <asp:Label ID="Label1" runat="server">S No.</asp:Label>
                        </td>
                        <td style="width: 12%;">
                            <asp:CheckBox ID="chkMarkAll" runat="server" OnCheckedChanged="chkMarkAll_CheckedChanged"
                                AutoPostBack="true" />Is Marks Grade Mode
                        </td>
                        <td style="width: 12%;">
                            <asp:CheckBox ID="chkall" runat="server" OnCheckedChanged="chkall_CheckedChanged"
                                AutoPostBack="true" />Status
                        </td>
                        <td style="width: 12%;">
                            <asp:Label ID="lblhead" runat="server">Subject Name</asp:Label>
                        </td>
                        <td style="width: 12%;">
                            <asp:Label ID="Label2" runat="server">Status</asp:Label>
                        </td>
                    </tr>
                    <tr id="tr2" runat="server">
                        <td colspan="5" class="stm1" style="border-bottom: 0px;">
                            <asp:GridView ID="grdBranch" AutoGenerateColumns="false" ShowHeader="false" Width="100%" CssClass="stm"
                                BorderWidth="0" runat="server" GridLines="None">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="8%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkmode" Checked='<%#Eval("IsGrade") %>' runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle Width="12%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkclass" Checked='<%#Eval("status") %>' runat="server" />
                                        </ItemTemplate>
                                        <ItemStyle Width="12%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblsubject" runat="server" Text='<%# Bind("SubjectName") %>'></asp:Label>
                                            <asp:HiddenField ID="HD1" runat="server" Value='<%# Bind("subjectid") %>' />
                                        </ItemTemplate>
                                        <ItemStyle Width="12%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblstatus" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="12%" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="stm_dark" />
                                <AlternatingRowStyle CssClass="stm_light" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
            </div>
            <div class="for_sigle_row_form">
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red" EnableViewState="False"></asp:Label>
                <asp:Button ID="btnSubmit" runat="server" Text="submit" CssClass="button_save" OnClick="btnSubmit_Click" />
            </div>
        </div>
    </div>
</asp:Content>