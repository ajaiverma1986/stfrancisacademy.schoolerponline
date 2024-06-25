<%@ Page Title="Add Area" Language="C#" AutoEventWireup="true" CodeFile="Addarea.aspx.cs" MasterPageFile="~/BranchPanel/MasterPage.master" Inherits="BranchPanel_Addarea" %>

<%@ Register Src="~/BranchPanel/transport.ascx" TagName="stu" TagPrefix="trans" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .active0 {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }
    </style>
    <style>
        #ctl00_ContentPlaceHolder1_GridStateDetail_ctl03_rblday label {
            display: none;
        }

        .style1 {
            height: 38px;
        }
    </style>

    <div class="content_top">
        <ul>
            <li><a href="Default.aspx">Home</a></li>
            <li><a>Master Settings</a></li>
            <li><a>Transport Settings</a></li>
            <li style="background: none;"><a class="active">Add Area </a></li>
            <div class="arrowt">
                <a href="../Branchpanel/Addarea.aspx">
                    <img src="../images/back-button.png"></a>
            </div>
        </ul>
    </div>
     <%-- <trans:stu runat="server" ID="myuc" />--%>
    <div class="content_pane_cont input_content" id="contentPane">
      

        <asp:UpdatePanel ID="upd33" runat="server">
            <ContentTemplate>

                <div id="divtop" runat="server" style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
                    class="containerHeadlinenew">
                    <%--<span style="line-height: 39px;">Add Area</span>--%>
                    <asp:Button runat="server" ID="Button2" CssClass="view-enquiry" Text="Add Area"
                        ToolTip="Click here to Add Area." OnClick="Button2_Click" Style="float: right; margin-top: 8.5px;" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <asp:UpdatePanel ID="upda1" runat="server">
            <ContentTemplate>

                <div id="divall" runat="server">
                    <div class="for_sigle_row_form">
                        <label>
                            Select Zone<span style="color: Red;">* </span>
                        </label>
                        <asp:DropDownList ID="ddl_Busroot" runat="server">
                        </asp:DropDownList>&nbsp;
                    </div>
                    <div class="for_sigle_row_form">
                        <label>
                            Area<span style="color: Red;">* </span>
                        </label>
                        <asp:TextBox ID="txtarea" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Enter Area"
                            ControlToValidate="txtarea" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd"></asp:RequiredFieldValidator>
                    </div>

                    <div class="for_sigle_row_form">
                        <label>
                        </label>
                        <asp:Button ID="btnAdd" runat="server" Text="Submit" CssClass="button_save" OnClick="btSave_Click"
                            ValidationGroup="g1" />
                        <asp:Button ID="Button1" runat="server" Text="Cancel" CssClass="button_cancel" OnClick="Button1_Click" />
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <asp:UpdatePanel ID="updpnel" runat="server">
            <ContentTemplate>

                <table cellpadding="2" id="divgrid" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important;">
                    <tr>
                        <td>

                            <asp:GridView ID="griview_addarea" runat="server" EmptyDataText="No data found !" CssClass="stm" BorderWidth="0" HeaderStyle-Height="30px"
                                AutoGenerateColumns="false" PagerSettings-Position="Bottom" GridLines="None" AllowPaging="true"
                                PagerStyle-Font-Size="15px" PageSize="10" PagerStyle-HorizontalAlign="Right"
                                Width="101%" OnPageIndexChanging="griview_addarea_PageIndexChanging"
                                OnRowCommand="griview_addarea_RowCommand">

                                <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />

                                <Columns>
                                    <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSNo" runat="server" Text="<%#Container.DataItemIndex+1%>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Zone" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblproducname" runat="server" Text='<% #bind("zonename")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Area" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblstatus" runat="server" Text='<% #bind("areaname")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkview" runat="server" Text="Edit" CommandName="Edit1" CommandArgument='<%# Bind("areaid") %>' CausesValidation="false" ToolTip="update"></asp:LinkButton>
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
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>