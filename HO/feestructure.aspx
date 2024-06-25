<%@ Page Title="Add Fees Type" Language="C#" AutoEventWireup="true" CodeFile="feestructure.aspx.cs" Inherits="HO_feetype" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content_top">

        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>

            <li><a href="#">Master settings</a></li>
            <li style="background: none;"><a class="active" href="#">Add Fees Type </a></li>
        </ul>
        <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">

            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1" frameborder="0" width="220" height="19" style="float: right; margin-top: 2px; margin-right: 0px;"></iframe>
        </div>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Add Fees Type
        </div>
        <%--  <asp:UpdatePanel ID="UPModulePermission" runat="server">
               <ContentTemplate>
              <div class="div_form" >--%>
        <br />
        <div class="for_sigle_row_form">
            <label>Fees Type:</label>
            <asp:TextBox ID="txtfeetype" runat="server"></asp:TextBox>
            &nbsp;<asp:RequiredFieldValidator ID="RD1" runat="server" ControlToValidate="txtfeetype" CssClass="rqd" ErrorMessage="Please Enter Fees Type."></asp:RequiredFieldValidator>
            <asp:Label ID="lblmsg"
                runat="server" ForeColor="Red" EnableViewState="False"></asp:Label>
        </div>
        <div class="for_sigle_row_form">
            <label>Active:</label>
            <asp:CheckBox ID="chkfetype" runat="server" />
        </div>
        <div class="for_sigle_row_form">
            <label></label>
            <asp:Label ID="lblMsg1" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <label></label>
            <asp:Button ID="btnfeetype" runat="server" Text="submit" CssClass="button1"
                OnClick="btnfeetype_Click" />
            <asp:Button ID="btnUpdate" runat="server" Text="Update"
                CssClass="button" OnClick="btnUpdate_Click" />
        </div>

        <table class="format" cellpadding="2" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
            <tr>
                <td>
                    <asp:GridView ID="grdFeeStruct" runat="server" AutoGenerateColumns="false" OnRowCommand="grdFeeStruct_RowCommand" Width="100%" CssClass="stm" BorderWidth="0">
                        <Columns>
                            <asp:TemplateField HeaderText="S.No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblsno" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="7%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fee Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblFeeName" runat="server" Text='<%# Eval("Feename") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("status") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="12%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgEdit" runat="server" CommandName="edit13" CommandArgument='<%# Eval("id") %>'
                                        ImageUrl="~/images/edit.gif" CausesValidation="false" />
                                </ItemTemplate>
                                <ItemStyle Width="7%" />
                            </asp:TemplateField>

                            <%--<asp:TemplateField  HeaderText="Delete">
                            <ItemTemplate>
                                 <asp:ImageButton ID="ImageButton1" runat="server" CommandName="delete" CommandArgument='<%# Eval("CID") %>'
                                                    ImageUrl="~/images/delete.gif"  CausesValidation="false" />
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        </Columns>
                        <RowStyle CssClass="stm_dark" />
                        <HeaderStyle CssClass="stm_head" />
                        <AlternatingRowStyle CssClass="stm_light" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
        <br />
        <br />
    </div>
    <%-- </ContentTemplate>
               </asp:UpdatePanel>
               </div>--%>
</asp:Content>