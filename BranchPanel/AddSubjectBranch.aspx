<%@ Page Title="Add Subject in Branch" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="AddSubjectBranch.aspx.cs" Inherits="BranchPanel_AddSubjectBranch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_top" style="margin-bottom: 20px;">
        <ul>
            <li><a href="Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Master Settings</a></li>
            <li style="background: none;"><a class="active">Subject Settings</a></li>
        </ul>
    </div>

    <asp:Button ID="btn1" runat="server" Text="Add Subject" CssClass="button_save" OnClick="btn1_Click"
        CausesValidation="false" />

    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Add Subject in Branch
        </div>
        <br />
        <div class="div_form st">
            <div class="for_sigle_row_form" runat="server" id="l1">
                <label>
                    Select Branch:</label>
                <asp:DropDownList ID="ddlbranch" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlbranch_SelectedIndexChanged">
                    <asp:ListItem Value="0" Selected="True">-- Select Branch --</asp:ListItem>
                </asp:DropDownList>
                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Select Branch"
                             ControlToValidate="ddlfeestype" SetFocusOnError="True"   CssClass="rqd"></asp:RequiredFieldValidator>--%>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Select Class:</label>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    <asp:ListItem Value="0" Selected="True">-- Select Class --</asp:ListItem>
                </asp:DropDownList>
                <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Select Branch"
                             ControlToValidate="ddlfeestype" SetFocusOnError="True"   CssClass="rqd"></asp:RequiredFieldValidator>--%>
            </div>
              <div class="for_sigle_row_form">
                <label>
                    Select Session:</label>
                <asp:DropDownList ID="ddlfyear" runat="server" AutoPostBack="true"
                    OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    <asp:ListItem Value="0" Selected="True">-- Select Session --</asp:ListItem>
                </asp:DropDownList>
            <div style="margin-top: 15px;">
                <table cellpadding="2" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
                    <tr id="tr1" runat="server" style="background: #33ccff;">
                        <td class="stm_head2" style="width: 8%; padding-left: 10px; color: #ffffff;">
                            <asp:Label ID="Label1" runat="server">S No.</asp:Label>
                        </td>
                        <td style="width: 12%; padding-left: 10px;" class="stm_head2">
                            <asp:CheckBox ID="chkall" runat="server" OnCheckedChanged="chkall_CheckedChanged"
                                AutoPostBack="true" />
                        </td>
                        <td style="padding-left: 10px; color: #ffffff;" class="stm_head2">
                            <asp:Label ID="lblhead" runat="server">Subject Name</asp:Label>
                        </td>
                        <td style="width: 12%; padding-left: 10px; color: #ffffff; font-weight: bold;">
                            <asp:Label ID="Label2" runat="server">Status</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" class="stm1" style="border-bottom: 0px;">
                            <asp:GridView ID="grdBranch" AutoGenerateColumns="false" ShowHeader="false" Width="100%" CssClass="stm"
                                BorderWidth="0" runat="server">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="8%" />
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
                                            <asp:HiddenField ID="HD1" runat="server" Value='<%# Bind("id") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblstatus" runat="server" Text='<%# Bind("status") %>'></asp:Label>
                                        </ItemTemplate>
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
                <br />
                <br />
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red" EnableViewState="False"></asp:Label>
                <br />
                <br />
                <label>
                </label>
                <asp:Button ID="btnSubmit" runat="server" Text="submit" CssClass="button_save" OnClick="btnSubmit_Click" />
            </div>
        </div>
    </div>
</asp:Content>