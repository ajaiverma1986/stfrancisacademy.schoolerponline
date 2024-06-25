<%@ Page Title="Add Class" Language="C#" AutoEventWireup="true" CodeFile="AddClass.aspx.cs" Inherits="HO_feetype" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <asp:UpdatePanel ID="UPModulePermission" runat="server">
            <ContentTemplate>
                 <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Add Class</h2>
            <asp:Button runat="server" ID="Button1" CssClass="button_save" Text="Add Class"
                    ToolTip="Click here to add a new Class." OnClick="Button1_Click" Style="float: right; margin-top: 5px; margin-right: 3px" />
        </div>
                <div>
                    <br />
                    <div id="divall" class="new-registration main-div-tbl" style="border:none !important" runat="server">
                        <div class="for_sigle_row_form">
                            <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
                            <asp:DropDownList ID="ddlfinancialyear" runat="server">
                            </asp:DropDownList>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>Add Class:<span style="font-weight: bold; color: red">*</span></label>
                            <asp:TextBox ID="txtAddClass" runat="server" placeholder="Enter Class Name Please"></asp:TextBox>
                            
                        </div>
                        <div class="for_sigle_row_form">
                            <label>Enter Display Order:<span style="font-weight: bold;  color: red">*</span></label>
                            <asp:TextBox ID="txtdisplayorder" runat="server" onkeypress="return noAlphabets(event)" placeholder="Enter Display Order Please"></asp:TextBox>
                        </div>
                        <div class="for_sigle_row_form">
                            <label style="padding-top: 4px;">
                                School Type<span style="color: Red; font-weight: bold">*</span></label>
                            <div style="width: 240px; height: 20px; float: left;">
                                <asp:RadioButtonList runat="server" ID="rbtnlistschooltype" RepeatDirection="Horizontal" CssClass="labelfor_radio" Style="margin: 0px;">
                                    <asp:ListItem Value="1" Selected="True">School</asp:ListItem>
                                    <asp:ListItem Value="2">Play School</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                        <div class="for_sigle_row_form">
                            <label></label>
                            <asp:Label ID="lblMsg1" runat="server" ForeColor="Red"></asp:Label>
                            <br />
                            <br />
                            <label></label>
                            <asp:Button ID="btnSubmit" runat="server" Text="submit" CssClass="button_save" OnClick="btnSubmit_Click" />
                            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="button_save" OnClick="btnUpdate_Click" />
                            <asp:Button ID="btnback" runat="server" Text="Back" CssClass="button_save" OnClick="btnback_Click" />
                        </div>
                    </div>
                    <div id="divgrid" runat="server">
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
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Class Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblClassName" Text='<%# Eval("Classname") %>' runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Session">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblfname" Text='<%# Eval("FyName") %>' runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblStatus" Text='<%# Eval("status") %>' runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                                            </asp:TemplateField>
                                               <asp:TemplateField HeaderText="Display Order">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldisplayorder" Text='<%# Eval("DisplayOrder") %>' runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Edit">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="imgEdit" runat="server" CommandName="edit12" CommandArgument='<%# Eval("id") %>'
                                                        ImageUrl="~/images/edit.gif" CausesValidation="false" />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="15%" />
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
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <script type="text/javascript">
        function noAlphabets(event) {
            var charCode = (event.which) ? event.which : event.keyCode
            if ((charCode >= 97) && (charCode <= 122) || (charCode >= 65)
                  && (charCode <= 90))
                return false;

            return true;
        };
    </script>
</asp:Content>