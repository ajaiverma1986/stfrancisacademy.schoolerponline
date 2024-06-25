<%@ Page Title="Add Route" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="AddRoot.aspx.cs" Inherits="Transport_AddRoot" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/BranchPanel/transport.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        #ctl00_ContentPlaceHolder1_CompareValidator1 {
            margin-left: 578px;
            left: 0;
            margin-top: 5px;
            position: absolute;
            width: 184px;
        }
    </style>
    <div class="content_pane_cont" id="contentPane">
    </div>

    <div class="content_top">
        <ul>
            <li><a href="../Common/Default.aspx" style="background: url(../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a href="#">Add Route</a></li>
        </ul>
        <%--<div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right;
            margin-right: 10px;">
            <iframe src="http://free.timeanddate.com/clock/i3us2nsj/n771/tcf7f7f7/pcf7f7f7/ahl/tt0/tw1/tm1"
                frameborder="0" width="220" height="19" style="float: right; margin-top: 2px;
                margin-right: 0px;"></iframe>
        </div>--%>
    </div>
    <div class="clear">
    </div>
    <div class="content_pane_cont input_content" id="FIELDSET1" runat="server">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <div style="border-bottom: 1px solid #DDDDDD; padding-bottom: 0px; padding-left: 15px; padding-top: 0px;"
            class="containerHeadline">
            <b>Add Route </b>
        </div>
        <br />

        <table class="format" cellpadding="2" cellspacing="0" border="0" style="width: 900px; margin-left: 200px;">
            <tr>
                <td>
                    <asp:GridView ID="gvDetails" DataKeyNames="Id,Area,status" runat="server" Width="90%" align="center"
                        PageSize="50" BorderColor="#CCCCCC"
                        AutoGenerateColumns="false" EmptyDataText="No Data"
                        AllowPaging="true" AlternatingRowStyle-BackColor="#F7F7F7" BackColor="White"
                        ShowFooter="true" HeaderStyle-Font-Bold="true"
                        OnRowCancelingEdit="gvDetails_RowCancelingEdit"
                        OnRowDeleting="gvDetails_RowDeleting" OnRowEditing="gvDetails_RowEditing"
                        OnRowUpdating="gvDetails_RowUpdating"
                        OnRowCommand="gvDetails_RowCommand">
                        <HeaderStyle BackColor="#E6E6E6" Font-Size="15px" ForeColor="#666666" />

                        <AlternatingRowStyle BackColor="#F7F7F7" />
                        <Columns>
                            <asp:TemplateField ItemStyle-CssClass="gra" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="Center">
                                <EditItemTemplate>
                                    <asp:ImageButton ID="imgbtnUpdate" CommandName="Update" runat="server" ImageUrl="~/BranchPanel/images/update.jpg" ToolTip="Update" Height="20px" Width="20px" OnClientClick="abc" />
                                    <asp:ImageButton ID="imgbtnCancel" runat="server" CommandName="Cancel" ImageUrl="~/BranchPanel/images/Cancel.jpg" ToolTip="Cancel" Height="20px" Width="20px" />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgbtnEdit" CommandName="Edit" runat="server" ImageUrl="~/BranchPanel/images/Edit.jpg" ToolTip="Edit" Height="20px" Width="20px" />
                                    <asp:ImageButton ID="imgbtnDelete" CommandName="Delete" Text="Edit" runat="server" ImageUrl="~/BranchPanel/images/delete.jpg" ToolTip="Delete" Height="20px" Width="20px" />
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:ImageButton ID="imgbtnAdd" runat="server" ImageUrl="~/BranchPanel/images/AddNewitem.jpg" CommandName="AddNew" Width="30px" Height="30px" ToolTip="Add new User" ValidationGroup="validaiton" />
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Area" ItemStyle-CssClass="gra" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="Center">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtcity1" runat="server" Text='<%#Eval("Area") %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblitemUsr" runat="server" Text='<%#Eval("Area") %>' />
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtftrusrname" runat="server" />
                                    <asp:RequiredFieldValidator ID="rfvusername" runat="server" ControlToValidate="txtftrusrname" Text="*" ValidationGroup="validaiton" />
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fee" ItemStyle-CssClass="gra" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="Center">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtcity" runat="server" Text='<%#Eval("fees","{0:f}") %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblcity" runat="server" Text='<%#Eval("fees","{0:f}")  %>' />
                                </ItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtftrcity" runat="server" align="center" />
                                    <asp:RequiredFieldValidator ID="rfvcity" runat="server" ControlToValidate="txtftrcity" Text="*" ValidationGroup="validaiton" />
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status" ItemStyle-CssClass="gra" ItemStyle-HorizontalAlign="center" HeaderStyle-HorizontalAlign="Center">
                                <EditItemTemplate>
                                    <asp:CheckBox ID="chkstatus" runat="server" Checked='<%#Eval("status1") %>' />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblstatus" runat="server" Text='<%#Eval("status") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>

        <asp:Label ID="lblresult" runat="server"></asp:Label>
    </div>
</asp:Content>