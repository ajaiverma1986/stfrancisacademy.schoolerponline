<%@ Page Title="Attendance report" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="attendancereport.aspx.cs" Inherits="BranchPanel_attendancereport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:DropDownList ID="DDLClass" runat="server" AutoPostBack="True"
        OnSelectedIndexChanged="DDLClass_SelectedIndexChanged">
    </asp:DropDownList>
    &nbsp;<asp:DropDownList ID="DDLSection" runat="server" AutoPostBack="True"
        OnSelectedIndexChanged="DDLSection_SelectedIndexChanged">
    </asp:DropDownList>
    &nbsp;<asp:DropDownList ID="DDLMonth" runat="server" AutoPostBack="True"
        OnSelectedIndexChanged="DDLMonth_SelectedIndexChanged">
    </asp:DropDownList>
    &nbsp;
    <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click"
        Text="Button" />
    <br />
    <asp:GridView ID="GRD_ATT_REPORT" runat="server" AutoGenerateColumns="false" Width="100%">
        <Columns>
            <asp:TemplateField HeaderText="S.No.">
                <ItemTemplate>
                    <asp:Label ID="lblsno" runat="server" Text='<%# Container.DataItemIndex+1 %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Name">
                <ItemTemplate>
                    <%--<asp:Label ID="lbltrcode" runat="server" Text='<%# Eval("Name") %>'></asp:Label>--%>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <br />
</asp:Content>