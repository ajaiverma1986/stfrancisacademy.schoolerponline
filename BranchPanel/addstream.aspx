<%@ Page Title="Set Stream" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="addstream.aspx.cs" Inherits="BranchPanel_addstream" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a>Master Settings</a></li>
            <li><a>Class Setting</a></li>
            <li style="background: none;"><a class="active">Add Stream with Class </a></li>
            <div class="arrowt">
                <a href="../Branchpanel/Addarea.aspx">
                    <img src="../images/back-button.png"></a>
            </div>
        </ul>
    </div>

    <div class="content_pane_cont input_content" id="contentPane">
        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>

                <div id="divtop" runat="server" style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
                    class="containerHeadlinenew">
                    <asp:Button runat="server" ID="Button2" CssClass="button_save" Text="Map Stream"
                        ToolTip="Click here to Add Stram to class." Style="float: right; margin-top: 9.5px;" OnClick="Button2_Click" />
                </div>
                <div id="idrepeater" runat="server">
                    <div class="for_sigle_row_form">
                        <label>
                            Class</label>
                        <asp:DropDownList ID="ddlClass" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                        </asp:DropDownList>
                        &nbsp&nbsp
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Select Class"
                ControlToValidate="ddlClass" SetFocusOnError="True" CssClass="rqd"></asp:RequiredFieldValidator>
                    </div>

                    <div id="table1" visible="false" runat="server">
                        <table class="format shadow1" cellpadding="2" cellspacing="0" border="0" style="border: 2px solid #DDDDDD; margin-left: 39%; margin-top: 79px; padding-left: 35px; width: 262px; border-radius: 5px; background: #fff; padding-bottom: 75px;">
                            <asp:Repeater ID="rptfeesubtype" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <br />
                                            <br />
                                            <asp:CheckBox ID="chkpage" runat="server" />
                                        </td>
                                        <td>
                                            <br />
                                            <br />
                                            <asp:Label ID="lblForm" runat="server" Text='<%#Eval("stream")%>'></asp:Label>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </div>
                    <asp:Button runat="server" ID="Button1" CssClass="button_save" Text="Map Stream"
                        ToolTip="Click here to Add Stream to class." Style="margin-left: 489px; margin-top: 28.5px; display: none" OnClick="Button1_Click" />
                    <asp:Button runat="server" ID="Button3" CssClass="button_save" Text="Cancel"
                        ToolTip="Click here to go back." Style="margin-left: 504px; margin-top: 12.5px; display: none" OnClick="Button3_Click" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <asp:UpdatePanel ID="upd34" runat="server">
            <ContentTemplate>
                <div id="griddiv" runat="server">

                    <table cellpadding="2" id="divgrid" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important;">
                        <tr>
                            <td>

                                <asp:GridView ID="gridview_mapstream" runat="server" EmptyDataText="No data found !" CssClass="stm" BorderWidth="0" HeaderStyle-Height="30px"
                                    AutoGenerateColumns="false" PagerSettings-Position="Bottom" GridLines="None" AllowPaging="true"
                                    PagerStyle-Font-Size="15px" PageSize="10" PagerStyle-HorizontalAlign="Right"
                                    Width="101%">

                                    <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />

                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSNo" runat="server" Text="<%#Container.DataItemIndex+1%>"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Class" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblproducname" runat="server" Text='<% #Bind("class_name")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Stream" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblstatus" runat="server" Text='<% #Bind("stream_name")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkview" runat="server" Text="Active" CommandName="Edit1" CommandArgument='<%# Bind("stream_name") %>' CausesValidation="false" ToolTip="update"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_dark" />
                                    <AlternatingRowStyle CssClass="stm_light" />
                                    <HeaderStyle CssClass="stm_head" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>