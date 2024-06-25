<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="SetPayrollMst.aspx.cs" Inherits="BranchPanel_employee_SetPayrollMst" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="FIELDSET1" runat="server">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>House Student List</h2>
            <div class="upload">
                <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true"
                    Height="20px" CssClass="BtnExcel" Style="float: right;"
                    ToolTip="Click here to download Excel sheet" />
            </div>
        </div>
         <div class="for_sigle_row_form">
                            <asp:Label ID="lblMonth" runat="server" Text="Month"></asp:Label>
                            <asp:DropDownList ID="ddlMonth" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMonth_SelectedIndexChanged">
                                <asp:ListItem Value="0">--Select Session--</asp:ListItem>
                                <asp:ListItem Value="1">Monthly</asp:ListItem>
                                <asp:ListItem Value="2">Annualy</asp:ListItem>
                            </asp:DropDownList>&nbsp;      
                        </div>
        <asp:GridView ID="grdHouse" runat="server" EmptyDataText="No data found !" BorderWidth="0" GridLines="None" CssClass="stm" HeaderStyle-Height="30px"
            AutoGenerateColumns="false" PagerSettings-Position="Bottom" AllowPaging="true"
            PagerStyle-Font-Size="15px" PageSize="20" PagerStyle-HorizontalAlign="Right"
            Width="100%" OnRowCommand="grdHouse_RowCommand" OnRowDataBound="grdHouse_RowDataBound">

            <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />

            <Columns>
                <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblSNo" runat="server" Text="<%#Container.DataItemIndex+1%>"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Student Name" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:Label ID="lblStdname" runat="server" Text='<% #Bind("Name")%>'></asp:Label>
                         <asp:Label ID="lblPayMstID" runat="server" Text='<% #Bind("ID")%>' Visible="false"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Percentage" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <div class="for_sigle_row_form">
                            <asp:CheckBox ID="cType" runat="server"></asp:CheckBox>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Value" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <div class="for_sigle_row_form">
                            <asp:TextBox ID="txtValue" runat="server" Text="0.0" Enabled="false"></asp:TextBox>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Duration" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <div class="for_sigle_row_form">
                            <asp:Label ID="lblType" runat="server" Text='<% #Bind("Type")%>' Visible="false"></asp:Label>
                            <asp:DropDownList ID="ddlType" runat="server" Enabled="false">
                                <asp:ListItem Value="0">--Select Session--</asp:ListItem>
                                <asp:ListItem Value="1">Monthly</asp:ListItem>
                                <asp:ListItem Value="2">Annualy</asp:ListItem>
                            </asp:DropDownList>&nbsp;      
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <asp:ImageButton ID="imgEdit" runat="server" CommandName="Edit1" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" ImageUrl="~/images/edit.gif" CausesValidation="false" ToolTip="update" />
                        <asp:HiddenField ID="lblclassid" runat="server" Value="0"></asp:HiddenField>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
            <RowStyle CssClass="stm_dark" />
            <HeaderStyle CssClass="stm_head" />
        </asp:GridView>
        <div class="for_sigle_row_form" style="margin-bottom: 5px !important">
            <label style="padding-top: 7px;">
            </label>
            <asp:Button ID="btnclose" runat="server" Text="UPDATE" CssClass="button4" OnClick="btSave_Click" />
        </div>
    </div>
</asp:Content>

