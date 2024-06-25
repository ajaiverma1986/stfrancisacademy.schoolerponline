<%@ Page Title="Add Department" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="DepartMent.aspx.cs" Inherits="BranchPanel_DepartMent" %>

<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content_top">
        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Master settings</a></li>
            <li><a href="#">Department Master</a></li>
            <li style="background: none;"><a class="active" href="#">Add Department </a></li>
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
    <asp:UpdatePanel ID="upd" runat="server">
        <ContentTemplate>
            <div class="content_pane_cont input_content" id="contentPane">

                <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
                    class="containerHeadline">
                    Add Department
           <asp:Button runat="server" ID="Button2" CssClass="button_save45" Text="Add Department"
               ToolTip="Click here to Add Department." OnClick="Button2_Click" />
                </div>
                <div id="divall" runat="server">
                    <div class="div_form">
                        <div class="for_sigle_row_form">
                            <label>
                                Department:</label>
                            <asp:TextBox ID="txtcountry" runat="server"></asp:TextBox><asp:Label ID="lblmsg"
                                runat="server" ForeColor="Red" EnableViewState="False"></asp:Label>&nbsp&nbsp
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter Department Name"
                            ControlToValidate="txtcountry" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                                Active:</label>
                            <asp:CheckBox ID="chkcountrye" runat="server" />
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                            </label>
                            <asp:Label ID="lblMsg1" runat="server" ForeColor="Red"></asp:Label>
                        </div>
                        <div class="for_sigle_row_form">
                            <label>
                            </label>
                            <asp:Button ID="btncountry" runat="server" Text="Submit" CssClass="button_save" OnClick="btncountry_Click" />
                            <asp:Button ID="btnupdate" runat="server" Text="Update" CssClass="button_save" OnClick="btnupdate_Click" />
                        </div>
                    </div>
                </div>

                <table cellpadding="2" id="divgrid" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
                    <tr>
                        <td class="stm">
                            <asp:GridView ID="Grid_Country" AutoGenerateColumns="false" GridLines="None" BorderWidth="0" Width="100%"
                                runat="server" OnRowCommand="Grid_Country_RowCommand" PageSize="20" AllowPaging="true">
                                <Columns>
                                    <asp:TemplateField HeaderText="S No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo" Text='<%#Container.DataItemIndex+1 %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="7%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Department Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblClassName" Text='<%# Eval("countryName") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStatus" Text='<%# Eval("status") %>' runat="server"></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="12%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Edit">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imgEdit" runat="server" CommandName="edit0" CommandArgument='<%# Eval("CID") %>'
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