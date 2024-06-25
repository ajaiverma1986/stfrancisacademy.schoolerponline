<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="mst_SetResult.aspx.cs" Inherits="BranchPanel_MasterUC_mst_SetResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Add Subject in Class</h2>
        </div>
        <br />
         <div class="for_sigle_row_form">
                <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
                <asp:DropDownList ID="ddlfinancialyear" runat="server" OnSelectedIndexChanged="ddlfinancialyear_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
            </div>
        <br />
        <br />
        <div class="clear"></div>
        <div style="margin-top: 0px; position: relative;">
            <table cellpadding="2" cellspacing="0" border="0" style="width: 1000px; border-left: none !important;">
                <tr>
                    <td colspan="4" style="vertical-align: top; width: 500px;">
                        <div style="float: left; width: 500px; margin-left: 10px;">
                            <asp:GridView ID="grdBranch" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                                runat="server" CssClass="stm" GridLines="None" OnRowCommand="grdBranch_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="8%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Class">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lblsubject" runat="server" Text='<%# Bind("classname") %>' CommandName="c1"
                                                CommandArgument='<%# Bind("id") %>' ForeColor="black" Font-Underline="true" ToolTip="Click here to update Course for this Branch."></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="30%" ForeColor="Blue" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit" Visible="false">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lblsubject22" Font-Underline="true" ToolTip="Click here to update subject for this Class."
                                                runat="server" Text="Edit" CommandName="c2" CommandArgument='<%# Bind("id") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="stm_dark" />
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <AlternatingRowStyle CssClass="stm_light" />
                            </asp:GridView>
                        </div>
                        <div class="clear">
                        </div>
                        <div class="for_sigle_row_form" style="width: 400px; margin-top: 5px;">
                            <asp:Button ID="btnSubmit" runat="server" Text="Update" CssClass="button_save sdr"
                                OnClick="btnSubmit_Click" />
                        </div>
                    </td>
                    <td valign="top" style="width: 500px;" id="tr2" runat="server">
                        <div style="width: 95%; float: left; margin-left: 10px; position: relative;margin-top:-14px">
                            <asp:LinkButton ID="lnk" runat="server" Text="EDIT" Visible="false" CssClass="gft"
                                OnClick="lnk_Click" ToolTip="Click here to add subject with Class" Font-Bold="true" Font-Size="Medium"></asp:LinkButton>
                            <asp:GridView ID="grdsubject" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                                runat="server" CssClass="stm" GridLines="None" EmptyDataText="Click on Edit Button to add Subject with Class">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo1" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkclass" runat="server" Checked='<%# Bind("Status") %>' />
                                            <asp:HiddenField ID="fResultTypeID" Value='<%#Eval("ResultTypeID") %>' runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Compulsory Subject">
                                        <ItemTemplate>
                                            <asp:Label ID="lblsubject123" runat="server" Text='<%# Bind("ResultType") %>'></asp:Label>
                                            <asp:HiddenField ID="HD12" runat="server" Value='<%# Bind("id") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="30%" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="stm_dark" />
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <AlternatingRowStyle CssClass="stm_light" />
                            </asp:GridView>
                            <asp:GridView ID="gridoptionalsubject" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                                runat="server" CssClass="stm1" GridLines="None" EmptyDataText="Click on Edit Button to add Subject with Class">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo1" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkclass" Checked='<%#Eval("Status") %>' runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Optional Subject">
                                        <ItemTemplate>
                                            <asp:Label ID="lblsubject123" runat="server" Text='<%# Bind("ResultType") %>'></asp:Label>
                                            <asp:HiddenField ID="HD12" runat="server" Value='<%# Bind("id") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="30%" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle CssClass="stm_dark" />
                                <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                <AlternatingRowStyle CssClass="stm_light" />
                            </asp:GridView>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div style="margin-top: 15px;">
        </div>
    </div>
</asp:Content>

