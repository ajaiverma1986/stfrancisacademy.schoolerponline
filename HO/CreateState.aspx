<%@ Page Title="Create State" Language="C#" AutoEventWireup="true" CodeFile="CreateState.aspx.cs" Inherits="AdminPanel_CreateState"
    MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript" language="javascript">
        function validate() {
            if (document.getElementById("ddlstate").selectedIndex == 0) {
                alert('Please Select State');
                document.getElementById("ddlstate").focus();
                return false;
            }
            if (document.getElementById("txtDistrictNo").value == "") {
                alert('Please Enter No Of District To be Created');
                document.getElementById("txtDistrictNo").focus();
                return false;
            }
        }
    </script>
    <div class="content_pane_top">
        <div class="content_pane_top_right">
            <div class="content_pane_mid">
                <div class="content_pane_top_head">
                </div>
                <div class="content_pane_top_status">
                    Create State
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
                <table style="width: 100%; font-size: 8pt; text-transform: capitalize; color: Black; font-family: Verdana; text-align: center;"
                    cellspacing="0" cellpadding="0" border="0">
                    <tbody>
                        <tr align="center">
                            <td style="width: 100%">&nbsp;<asp:UpdateProgress ID="UpdateProgress3" runat="server" DisplayAfter="0" AssociatedUpdatePanelID="UpdatePanel3">
                                <ProgressTemplate>
                                    <img src="../images/i_animated_loading_32_2.gif" />
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                                &nbsp;
                            </td>
                        </tr>
                        <tr align="center">
                            <td style="width: 100%" align="center">
                                <table width="60%" style="text-align: center">
                                    <tr>
                                        <td>
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                <ContentTemplate>
                                                    <%--<fieldset id="FieldsetCreateDistrict" runat="server" style="width: 80%; margin-left: 10px">
                                            <legend class="fldSet" style="width:100%; height:100%">Add State</legend>--%>
                                                    <div align="center" class="input_content" id="FIELDSET1" runat="server">
                                                        <table cellspacing="5" style="width: 100%">
                                                            <tr>
                                                                <td class="formTitle" colspan="4" style="height: 20px; width: 100%; vertical-align: top; text-align: center">&nbsp;Add State
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4" style="height: 10px; width: 100%; vertical-align: top; text-align: center"></td>
                                                            </tr>
                                                            <tr align="center">
                                                                <td align="right" style="width: 45%; height: 30px;">select Country <span style="color: #ff0033">*</span>
                                                                </td>
                                                                <td align="center" style="width: 5%; height: 30px;">:
                                                                </td>
                                                                <td align="left" style="width: 50%; height: 30px;">
                                                                    <asp:DropDownList ID="ddlState" runat="server" Width="154px">
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlState"
                                                                        ErrorMessage="Select State" InitialValue="0" SetFocusOnError="True" ValidationGroup="g1">*</asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                            <tr align="center">
                                                                <td align="right" style="width: 45%">no Of State <span style="color: #ff0033">*</span>
                                                                </td>
                                                                <td align="center" style="width: 5%;" valign="middle">:
                                                                </td>
                                                                <td align="left" style="width: 50%">
                                                                    <asp:TextBox ID="txtDistrictNo" runat="server" MaxLength="2"></asp:TextBox><asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDistrictNo"
                                                                        ErrorMessage="Enter No of State" SetFocusOnError="True" ValidationGroup="g1">*</asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                            <tr align="center">
                                                                <td align="right" style="width: 45%;"></td>
                                                                <td align="center" style="width: 5%;" valign="middle"></td>
                                                                <td align="left" style="width: 50%;">
                                                                    <asp:Button ID="btnCreatetable" runat="server" CssClass="button" OnClick="Button1_Click"
                                                                        Text="Create" ValidationGroup="g1" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="center" colspan="3" style="width: 45%; height: 48px;">
                                                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                                                                        ShowSummary="False" ValidationGroup="g1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <%-- </fieldset>--%>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                                &nbsp;&nbsp; &nbsp;&nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; text-align: left" align="center">
                                <asp:Button ID="back" runat="server" Text="Back" CssClass="button" OnClientClick="javascript:history.go(default.aspx);"
                                    OnClick="back_Click"></asp:Button>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%" valign="top" align="center">
                                <table width="60%" style="text-align: center">
                                    <tr>
                                        <td>
                                            <asp:UpdateProgress ID="UpdateProgress2" runat="server" DisplayAfter="0" AssociatedUpdatePanelID="UpdatePanel2">
                                                <ProgressTemplate>
                                                    <img src="../images/i_animated_loading_32_2.gif" />
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <br />
                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                <ContentTemplate>
                                                    <%--<fieldset style="width: 70%" id="fieldsetTableNoDistrict" runat="server">
                                            <legend class="fldSet">Enter No. Of State</legend>--%>
                                                    <div align="center" class="input_content" id="fieldsetTableNoDistrict" runat="server">
                                                        <table style="width: 100%" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td class="formTitle" style="height: 20px; width: 100%; vertical-align: top; text-align: center">&nbsp;Add State
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="height: 10px; width: 100%; vertical-align: top; text-align: center"></td>
                                                                </tr>
                                                                <tr align="center">
                                                                    <td style="width: 100%" align="center">
                                                                        <asp:GridView ID="GridView1" runat="server" Width="100%" PageSize="50" OnSelectedIndexChanging="GridView1_SelectedIndexChanging"
                                                                            OnPageIndexChanging="GridView1_PageIndexChanging" OnRowUpdating="GridView1_RowUpdating"
                                                                            OnRowEditing="GridView1_RowEditing" OnRowCancelingEdit="GridView1_RowCancelingEdit"
                                                                            AutoGenerateColumns="False" GridLines="None">
                                                                            <Columns>
                                                                                <asp:TemplateField ItemStyle-Width="35%" ItemStyle-HorizontalAlign="left">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="Label1" runat="server" Text='<%# String.Concat("State ",Container.DataItemIndex+1) %>'></asp:Label>&nbsp;<span
                                                                                            style="color: #ff0033">*</span>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="State Name" ItemStyle-Width="50%" ItemStyle-HorizontalAlign="Center">
                                                                                    <EditItemTemplate>
                                                                                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                                                                    </EditItemTemplate>
                                                                                    <ItemTemplate>
                                                                                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField ItemStyle-Width="15%" ItemStyle-HorizontalAlign="Center">
                                                                                    <ItemTemplate>
                                                                                        <asp:Image ID="imgstatus" runat="server" Visible="False" />
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                        <br />
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 100%" align="center">
                                                                        <asp:Label ID="lbmsg1" runat="server" ForeColor="Red"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 100%" align="center">
                                                                        <asp:Button ID="btnCreate" OnClick="Button2_Click" runat="server" Text="Save" CssClass="button"
                                                                            CausesValidation="False"></asp:Button>
                                                                        &nbsp;<asp:Button ID="Button1" OnClick="Button1_Click1" runat="server" Text="Cancel"
                                                                            CssClass="button" CausesValidation="False"></asp:Button>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <%--</fieldset>--%>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%" valign="top" align="center">
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <%--  <fieldset style="width: 70%" id="fieldsetTableEdit" runat="server">--%>
                                        <div align="center" class="input_content" id="fieldsetTableEdit" runat="server" style="width: 70%">
                                            <table style="width: 100%" class="clsLegend" cellspacing="5">
                                                <tbody>
                                                    <tr>
                                                        <td class="formTitle" style="height: 20px; width: 100%; vertical-align: top; text-align: center" colspan="3">Edit State
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 30%" align="right">country <span style="color: #ff0033">*</span>
                                                        </td>
                                                        <td style="width: 5%">
                                                            <strong>:</strong>
                                                        </td>
                                                        <td style="width: 65%" align="left">
                                                            <asp:TextBox ID="txtState" runat="server" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 30%; height: 26px" align="right">State <span style="color: #ff0033">*</span>
                                                        </td>
                                                        <td style="width: 5%; height: 26px">
                                                            <strong>:</strong>
                                                        </td>
                                                        <td style="width: 65%; height: 26px" align="left">
                                                            <asp:TextBox ID="txtDistrict" runat="server"></asp:TextBox>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" SetFocusOnError="True"
                                                                ErrorMessage="Enter  District" ControlToValidate="txtDistrict" ValidationGroup="g2">*</asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 30%; height: 15px" align="right"></td>
                                                        <td style="width: 5%; height: 15px"></td>
                                                        <td style="width: 65%; height: 15px" align="left">
                                                            <asp:Button ID="btnUpdate" OnClick="btnUpdate_Click" runat="server" Text="Update"
                                                                CssClass="button" ValidationGroup="g2"></asp:Button>&nbsp;
                                                            <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server" Text="Cancel"
                                                                CssClass="button" CausesValidation="False"></asp:Button>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 30%; height: 15px" align="right"></td>
                                                        <td style="width: 5%; height: 15px"></td>
                                                        <td style="width: 65%; height: 15px" align="left"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="height: 15px" align="center" colspan="3">
                                                            <asp:Label ID="lbMsg" runat="server" ForeColor="Red"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        </fieldset>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; height: 22px" valign="top" align="center"></td>
                        </tr>
                        <tr>
                            <td style="width: 100%; height: 24px; text-align: center" class="formTitle">List of State
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; height: 20px" valign="top" align="center">
                                <asp:UpdateProgress ID="UpdateProgress4" runat="server" DisplayAfter="0" AssociatedUpdatePanelID="UpdatePanel4">
                                    <ProgressTemplate>
                                        <img src="../images/i_animated_loading_32_2.gif" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; height: 250px" valign="top" align="center">
                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                    <ContentTemplate>
                                        <asp:GridView ID="GridStateDetail" GridLines="Horizontal" AllowPaging="True" AllowSorting="True"
                                            runat="server" AutoGenerateColumns="False" OnRowCommand="GridStateDetail_RowCommand"
                                            OnPageIndexChanging="GridStateDetail_PageIndexChanging" PageSize="20" Width="70%"
                                            OnRowEditing="GridStateDetail_RowEditing" OnRowDeleting="GridStateDetail_RowDeleting"
                                            OnSorting="GridStateDetail_Sorting" OnRowDataBound="GridStateDetail_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No.">
                                                    <%--<EditItemTemplate>
                                                        <asp:TextBox ID="TextBox1" runat="server"  ReadOnly="true"></asp:TextBox></EditItemTemplate>--%>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="countryname" HeaderText="Country" SortExpression="countryname" ReadOnly="true" />
                                                <asp:BoundField DataField="statename" HeaderText="State Name" SortExpression="statename" ReadOnly="true">
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Edit">
                                                    <%-- <EditItemTemplate>
                                                    </EditItemTemplate>--%>
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="ImageButton2" runat="server" CommandName="edit" CommandArgument='<%# Eval("sid") %>'
                                                            ImageUrl="~/images/edit.gif" OnClientClick="return confirm('Are u sure to edit')" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Delete">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="ImageButton1" runat="server" CommandName="delete" CommandArgument='<%# Eval("sid") %>'
                                                            ImageUrl="~/images/delete.gif" OnClientClick="return confirm('Are u sure to delete')" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <FooterStyle CssClass="display format" />
                                            <HeaderStyle CssClass="display format" Wrap="False" />
                                            <PagerStyle CssClass="grdPaging" HorizontalAlign="Right" />
                                            <RowStyle BackColor="#A3D0FF"></RowStyle>
                                            <AlternatingRowStyle BackColor="white"></AlternatingRowStyle>
                                            <PagerSettings FirstPageText="First Page" LastPageText="Last Page" Mode="NumericFirstLast"
                                                Position="TopAndBottom" />
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <br />
                                <asp:UpdateProgress ID="UpdateProgress5" runat="server" DisplayAfter="0" AssociatedUpdatePanelID="UpdatePanel4">
                                    <ProgressTemplate>
                                        <img src="../images/i_animated_loading_32_2.gif" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <br />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <br />
            </div>
        </div>
    </div>
</asp:Content>