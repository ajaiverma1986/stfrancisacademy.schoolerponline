<%@ Page Title="Create User" Language="C#" AutoEventWireup="true" CodeFile="CreateUser.aspx.cs" Inherits="AdminPanel_CreateUser"
    MasterPageFile="~/MasterPage.master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_top">
        <div class="content_pane_top_right">
            <div class="content_pane_mid">
                <div class="content_pane_top_head">
                </div>
                <div class="content_pane_top_status">
                </div>
                <div class="content_pane_top_sep">
                </div>
            </div>
        </div>
    </div>
    <div class="content_pane_cont" id="contentPane">
        <div class="div_form">
            <div align="left">
                <%--<img src="../images/banner_image1.jpg" alt="Image" />--%>
            </div>
            <div style="height: 10px">
            </div>
            <div id="divPageContent" align="center" runat="server">
                <table class="MainTable" cellspacing="0" cellpadding="0" border="0">
                    <tbody>
                        <tr>
                            <td align="left"></td>
                        </tr>
                        <%--<tr>
                <td style="width: 100%">
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                </td>
            </tr>--%>
                        <tr>
                            <td style="width: 100%" align="center">&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%" align="left" width="100%">
                                <br />
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btCreate" OnClick="Button1_Click" runat="server" Text="Create" CssClass="button"></asp:Button>
                                        <asp:Button ID="Button1" OnClick="Button1_Click1" runat="server" Text="Back" CssClass="button"
                                            OnClientClick="javascript:history.go(default.aspx);"></asp:Button>
                                        <asp:Label ID="lblStatus" runat="server" CssClass="lblclass" Font-Size="11pt"></asp:Label>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                &nbsp; &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%" align="center" width="100%">
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0" AssociatedUpdatePanelID="UpdatePanel1">
                                    <ProgressTemplate>
                                        &nbsp;<img src="../images/i_animated_loading_32_2.gif" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%" align="center">&nbsp;<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <fieldset style="width: 50%" id="fieldsetCreateUser" class="table" runat="server">
                                        <legend class="fldSet">Create User</legend>
                                        <table style="width: 75%" class="clsLegend">
                                            <tbody>
                                                <tr>
                                                    <td colspan="3"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 149px; height: 16px"></td>
                                                    <td style="width: 3px; height: 16px"></td>
                                                    <td style="width: 100px; height: 16px"></td>
                                                </tr>
                                                <tr>
                                                    <td align="right">User Name
                                                    </td>
                                                    <td style="width: 3px; height: 32px">:
                                                    </td>
                                                    <td style="width: 100px; height: 32px" align="left">
                                                        <asp:TextBox ID="txtUsername" runat="server" ValidationGroup="g1"></asp:TextBox><asp:RequiredFieldValidator
                                                            ID="RequiredFieldValidator2" runat="server" ValidationGroup="g1" SetFocusOnError="True"
                                                            ErrorMessage="Please Enter User Name" ControlToValidate="txtUsername">*</asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right">Password
                                                    </td>
                                                    <td style="width: 3px; height: 32px">:
                                                    </td>
                                                    <td style="width: 100px; height: 32px" align="left">
                                                        <asp:TextBox ID="txtPass" runat="server" ValidationGroup="g1" TextMode="Password"></asp:TextBox><asp:RequiredFieldValidator
                                                            ID="RequiredFieldValidator3" runat="server" ValidationGroup="g1" SetFocusOnError="True"
                                                            ErrorMessage="Please Enter Password" ControlToValidate="txtPass">*</asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <%-- <tr>
                                    <td align="right">
                                        branch</td>
                                    <td style="width: 3px; height: 32px">
                                        :</td>
                                    <td align="left" style="width: 100px; height: 32px">
                                        <asp:DropDownList ID="dropBranch" runat="server" Width="158px">
                                        </asp:DropDownList><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="dropBranch" ErrorMessage="Please Select Branch" InitialValue="0" SetFocusOnError="True" ValidationGroup="g1">*</asp:RequiredFieldValidator></td>
                                </tr>--%><tr>
                                    <td align="right">Role
                                    </td>
                                    <td style="width: 3px; height: 32px">:
                                    </td>
                                    <td style="width: 100px; height: 32px" align="left">
                                        <asp:DropDownList ID="dropRole" runat="server" Width="158px">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ValidationGroup="g1"
                                            SetFocusOnError="True" ErrorMessage="Please Select Role" ControlToValidate="dropRole"
                                            InitialValue="0">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                                <tr>
                                                    <td align="center" colspan="3">
                                                        <asp:Label ID="lblMsg" runat="server" CssClass="lblClass1" Font-Names="Verdana"></asp:Label>&nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="3">
                                                        <asp:Button ID="btUpdate" OnClick="Button3_Click" runat="server" Text="Update" CssClass="button"
                                                            ValidationGroup="g1" Width="60px"></asp:Button>&nbsp; &nbsp;<asp:Button ID="btSave"
                                                                OnClick="btSave_Click" runat="server" Text="Save" CssClass="button" ValidationGroup="g1"
                                                                Width="67px"></asp:Button>
                                                        &nbsp;
                                                            <asp:Button ID="Button4" OnClick="Button4_Click" runat="server" Text="Cancel" CssClass="button"
                                                                CausesValidation="False"></asp:Button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 149px"></td>
                                                    <td style="width: 3px"></td>
                                                    <td style="width: 100px"></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </fieldset>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; height: 25px">
                                <asp:UpdateProgress ID="UpdateProgress2" runat="server" DisplayAfter="0" AssociatedUpdatePanelID="UpdatePanel2">
                                    <ProgressTemplate>
                                        <img src="../images/i_animated_loading_32_2.gif" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; height: 350px" align="center">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand"
                                            OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating"
                                            Width="70%" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging"
                                            OnRowDataBound="GridView1_RowDataBound" GridLines="Horizontal">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr.No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblSrNo" runat="server" Text='<%# Container.DataItemIndex +1 %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" />
                                                    <HeaderStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="brname" HeaderText="Branch Name" />
                                                <asp:BoundField DataField="username" HeaderText="User Name">
                                                    <ItemStyle HorizontalAlign="Left" />
                                                    <HeaderStyle HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Password">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox1" runat="server" ToolTip='<%#Bind("pass")%>' Text="****"></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1" runat="server" ToolTip='<%#Bind("pass")%>' Text="****"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Left" />
                                                    <HeaderStyle HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="Rolename" HeaderText="Role">
                                                    <ItemStyle HorizontalAlign="Left" />
                                                    <HeaderStyle HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Edit">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/edit.gif" CommandArgument='<%# Eval("adid") %>'
                                                            CommandName="Edit" OnClientClick="return confirm('Are You sure to edit')" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Delete">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/delete.gif"
                                                            CommandArgument='<%# Eval("adid") %>' CommandName="delete" OnClientClick="return confirm('Are You sure to Delete')" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <FooterStyle CssClass="display format" />
                                            <HeaderStyle CssClass="display format" Wrap="False" />
                                            <PagerStyle CssClass="grdPaging" ForeColor="DarkViolet" HorizontalAlign="Center" />
                                            <RowStyle BackColor="#A3D0FF" />
                                            <AlternatingRowStyle BackColor="white" />
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="g1"
                                    ShowSummary="False" ShowMessageBox="True"></asp:ValidationSummary>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>