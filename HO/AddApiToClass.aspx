<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AddApiToClass.aspx.cs" Inherits="HO_AddApiToClass" %>

<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../js/jquery-1.8.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        function pageLoad() {
            $("#ctl00_ContentPlaceHolder1_btnSubmit").click(function () {
                var chkboxrowcount = $("#<%=grdclass.ClientID%> input[id*='chkclass1']:checkbox:checked").size();
                if (chkboxrowcount == 0) {
                    alert("Please select at least one Class.");
                    return false;
                }
            });
        };
    </script>
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>List of APIs with Class</h2>
        </div>
        <div id="divforfy" runat="server" class="for_sigle_row_form" style="display:none">
                            <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
                            <asp:DropDownList ID="ddlfinancialyear" runat="server" OnSelectedIndexChanged="ddlfinancialyear_SelectedIndexChanged" AutoPostBack="true">
                            </asp:DropDownList>
                        </div>
        <br />
        <div style="margin-top: 0px; position: relative;">
            <table cellpadding="2" cellspacing="0" border="0" style="width: 1000px; border-left: none !important;">
                <tr>
                    <td colspan="4" style="vertical-align: top; width: 500px;">
                        <div style="float: left; width: 500px; margin-left: 10px;">
                            <asp:GridView ID="grdAPI" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                                runat="server" CssClass="stm" GridLines="None" OnRowCommand="grdAPI_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="8%" />
                                    </asp:TemplateField>                                   
                                    <asp:TemplateField HeaderText="API Url">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lblsubject" runat="server" Text='<%# Bind("sms_api") %>' CommandName="c1"
                                                CommandArgument='<%# Bind("smsapiid") %>' ForeColor="black" Font-Underline="true"
                                                ToolTip="Click here to update Class for this Branch."></asp:LinkButton>
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="30%" ForeColor="Blue" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit" Visible="false">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lblsubject22" Font-Underline="true" ToolTip="Click here to update Class for this Branch."
                                                runat="server" Text="Edit" CommandName="c2" CommandArgument='<%# Bind("smsapiid") %>'></asp:LinkButton>
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
                            <asp:Button ID="btnSubmit" runat="server" Text="Update" CssClass="button_save sdr" OnClick="btnSubmit_Click1" />
                        </div>
                    </td>
                    <td valign="top" style="width: 500px;" id="tr2" runat="server">
                        <div style="width: 95%; float: left; margin-left: 10px;margin-top:-14px; position: relative;">
                            <asp:LinkButton ID="lnk" runat="server" Text="EDIT" Font-Size="Medium" Visible="false" CssClass="gft"
                                OnClick="lnk_Click" ToolTip="Click here to update Class for this Branch."></asp:LinkButton>
                            <asp:GridView ID="grdclass" AutoGenerateColumns="false" Width="100%" BorderWidth="0"
                                runat="server" CssClass="stm" GridLines="None" EmptyDataText="Click on Edit Button to add Class with Branch">
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
                                            <asp:CheckBox ID="chkclass1" Checked='<%#Eval("status") %>' runat="server" />
                                        </ItemTemplate>
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Class">
                                        <ItemTemplate>
                                            <asp:Label ID="lblsubject123" runat="server" Text='<%# Bind("Classname") %>'></asp:Label>
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
        <div style="margin-top:15px;">
        </div>
    </div>
</asp:Content>