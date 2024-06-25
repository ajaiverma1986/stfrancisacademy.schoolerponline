<%@ Page Title="Add Section" Language="C#" AutoEventWireup="true" MasterPageFile="~/BranchPanel/MasterPage.master" CodeFile="SectionAdd.aspx.cs" Inherits="BranchPanel_SectionAdd" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="FIELDSET1" runat="server">
         <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Add Section</h2>
             <asp:Button runat="server" ID="Button2" CssClass="button_save"  Text="Add Section to class" Style="float: right; margin-top: 5px; margin-right: 3px" ToolTip="Click here to Add Section." OnClick="Button2_Click" />
             <asp:Button runat="server" ID="Button3" CssClass="button_save"  Text="Add Section to class stream" Style="float: right; margin-top: 5px; margin-right: 3px" ToolTip="Click here to Add Section." OnClick="Button3_Click" Visible="false" />
        </div>
        <br />
        <div id="divall" runat="server">
            <div class="for_sigle_row_form">
                <label>
                    Select Class<span style="color: Red;">* </span>
                </label>
                <asp:DropDownList ID="ddl_class" runat="server" AppendDataBoundItems="True">               
                </asp:DropDownList>&nbsp;
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Section<span style="color: Red;">* </span>
                </label>
                <asp:TextBox ID="txtsection" runat="server" MaxLength="1" placeholder="Enter Section Name Please."></asp:TextBox>
                <asp:Label ID="lblmsg" runat="server" Visible="false" CssClass="rqd"></asp:Label>

                <asp:RegularExpressionValidator ID="REValphaOnly1" runat="server" SetFocusOnError="True" ValidationGroup="g1" CssClass="rqd" ErrorMessage="Please enter only alphabets." ControlToValidate="txtsection" ValidationExpression="^[a-zA-Z ]+$"></asp:RegularExpressionValidator>
            </div>
            <div class="for_sigle_row_form">
                <label style="padding-top: 3px;">
                    Status<span style="color: Red;"> </span>
                </label>

                <asp:CheckBox ID="chkstatus" runat="server" Height="20px" Width="20px" />
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Button ID="btnAdd" runat="server" Text="Submit" CssClass="button_save" OnClick="btSave_Click"
                    ValidationGroup="g1" />
                <asp:Button ID="Button1" runat="server" Text="Back" CssClass="button_save" OnClick="Button1_Click" />
            </div>
        </div>
        <table cellpadding="2" id="divgrid" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
            <tr>
                <td>

                    <asp:GridView ID="griview_section" runat="server" EmptyDataText="No data found !" BorderWidth="0" GridLines="None" CssClass="stm" HeaderStyle-Height="30px"
                        AutoGenerateColumns="false" PagerSettings-Position="Bottom" AllowPaging="true"
                        PagerStyle-Font-Size="15px" PageSize="20" PagerStyle-HorizontalAlign="Right"
                        Width="100%" OnPageIndexChanging="griview_section_PageIndexChanging" OnRowCommand="griview_section_RowCommand" OnRowDataBound="griview_section_RowDataBound">

                        <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />

                        <Columns>
                            <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblSNo" runat="server" Text="<%#Container.DataItemIndex+1%>"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>                            
                            <asp:TemplateField HeaderText="Class" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblproducname" runat="server" Text='<% #Bind("classname")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="ClassID" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblproducID" runat="server" Text='<% #Bind("classid")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Section" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblsectionname" runat="server" Text='<% #Bind("sectionname")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>                            
                             <asp:TemplateField HeaderText="SectionID" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblsectionID" runat="server" Text='<% #Bind("cwsid")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblstatus" runat="server" Text='<% #Bind("Status")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgEdit" runat="server" CommandName="Edit1" CommandArgument='<%# Eval("cwsid") %>'
                                        ImageUrl="~/images/edit.gif" CausesValidation="false" ToolTip="update" />
                                    <asp:HiddenField ID="lblclassid" runat="server" Value='<% #Bind("classid")%>'></asp:HiddenField>
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
    <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>