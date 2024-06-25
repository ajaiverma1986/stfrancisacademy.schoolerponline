<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="facultyimagelist.aspx.cs" Inherits="BranchPanel_facultyimagelist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .BotonDeImagen {
            width: 95px;
            height: 95px;
        }
    </style>

    <style>
        .BotonDeImagen1 {
            width: 95px;
            height: 95px;
        }
    </style>
    <div class="content_pane_cont" id="contentPane">
    </div>

    <div class="content_top">
        <ul>
            <li><a href="facultyimagelist.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>Image List</a></li>
            <li style="background: none;"><a class="active">Images</a></li>
        </ul>
    </div>
    <div class="clear">
    </div>

    <div class="content_pane_cont input_content" id="FIELDSET1" runat="server">

        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            Image List
        </div>

        <table cellpadding="2" id="divgrid" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
            <tr>
                <td>

                    <asp:GridView ID="grdfiles" runat="server" EmptyDataText="No data found !" CssClass="stm" BorderWidth="0" HeaderStyle-Height="30px"
                        AutoGenerateColumns="false" PagerSettings-Position="Bottom" GridLines="None" AllowPaging="true"
                        PagerStyle-Font-Size="15px" PageSize="10" PagerStyle-HorizontalAlign="Right"
                        Width="100%">

                        <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />

                        <Columns>
                            <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblSNo" runat="server" Text="<%#Container.DataItemIndex+1%>"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblproducname" runat="server" Text='<% #Bind("fname")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mobile No" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblphne" runat="server" Text='<% #Bind("mobile")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Content" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Image runat="server" ID="imgsource" CssClass="BotonDeImagen" ImageUrl='<%# Eval("photo") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkview" runat="server" Text="Publish" CommandName="Edit1" CommandArgument='<%# Bind("fid") %>' CausesValidation="false" ToolTip="update"></asp:LinkButton>
                                </ItemTemplate>
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
</asp:Content>