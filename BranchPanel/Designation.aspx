<%@ Page Title="Add Designation" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="Designation.aspx.cs" Inherits="BranchPanel_Designation" %>

<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content_top">
        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Master settings</a></li>
            <li><a href="#">Designation Master</a></li>
            <li style="background: none;"><a class="active" href="#">Add Designation</a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px; margin-right: 0px;"></iframe>
        </div>
    </div>

    <asp:Button ID="btn1" runat="server" Text="Add Department" CssClass="button_save"
        ToolTip="Click here to add Department." OnClick="btn1_Click" CausesValidation="false" />

    <asp:Button ID="btn2" runat="server" Text="Add Designation"
        CssClass="button_save" ToolTip="Click here to add designation in particular department." OnClick="btn2_Click"
        CausesValidation="false" />

    <asp:UpdatePanel ID="UPModulePermission" runat="server">
        <ContentTemplate>
            <div class="content_pane_cont input_content" id="contentPane">
                <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
                    class="containerHeadline">
                    Add Designation
         <asp:Button runat="server" ID="Button2" CssClass="button_save45" Text="Add Designation"
             ToolTip="Click here to Add Designation." OnClick="Button2_Click" />
                </div>
                <br />

                <div class="div_form" id="divall" runat="server">

                    <div class="for_sigle_row_form">
                        <label>Department:</label>
                        <asp:DropDownList ID="ddlCountry" runat="server"
                            OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Value="0" Selected="True">--Select Department --</asp:ListItem>
                        </asp:DropDownList>&nbsp
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Select Department"
                            ControlToValidate="ddlCountry" InitialValue="0" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>Designation:</label>
                        <asp:TextBox ID="txtState" runat="server" class="autosuggest"></asp:TextBox>&nbsp&nbsp
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter Designation"
                              ControlToValidate="txtState" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                    </div>
                    <div class="for_sigle_row_form">
                        <label>Active:</label>
                        <asp:CheckBox ID="chkfetype" runat="server" />
                    </div>
                    <div class="for_sigle_row_form">
                        <label></label>
                        <asp:Label ID="lblMsg1" runat="server" ForeColor="Red"></asp:Label>
                    </div>

                    <div class="for_sigle_row_form">
                        <label></label>
                        <asp:Button ID="btnstate" runat="server" Text="submit" CssClass="button_save"
                            OnClick="btnstate_Click" />
                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="button_save"
                            OnClick="btnUpdate_Click1" />
                        &nbsp;<asp:Button ID="Cancel" runat="server" Text="Cancel" CssClass="button_save"
                            CausesValidation="false" OnClick="Cancel_Click" />
                    </div>
                </div>

                <table cellpadding="2" id="divgrid" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
                    <tr>
                        <td>
                            <asp:GridView ID="Grid_state" AutoGenerateColumns="false" GridLines="None" BorderWidth="0" Width="100%"
                                runat="server" OnRowCommand="Grid_state_RowCommand" PageSize="20"
                                AllowPaging="true"
                                CssClass="stm">

                                <Columns>
                                    <asp:TemplateField HeaderText="S No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="7%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Department Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCountrysName" Text='<%# Eval("deptName") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Designation">
                                        <ItemTemplate>
                                            <asp:Label ID="lblstateName" Text='<%# Eval("desigName") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStatus" Text='<%# Eval("status") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="12%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Edit">
                                        <%-- <EditItemTemplate></EditItemTemplate>--%>
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgEdit" runat="server" CommandName="edit16" CommandArgument='<%# Eval("desigID") %>'
                                                ImageUrl="~/images/edit.gif" CausesValidation="false" />
                                        </ItemTemplate>
                                        <ItemStyle Width="7%" />
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