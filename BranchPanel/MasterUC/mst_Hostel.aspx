<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="mst_Hostel.aspx.cs" Inherits="BranchPanel_MasterUC_mst_Hostel" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            function lettersOnly(evt) {
                evt = (evt) ? evt : event;
                var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode :
              ((evt.which) ? evt.which : 0));
                if (charCode > 32 && (charCode < 65 || charCode > 90) &&
              (charCode < 97 || charCode > 122)) {
                    alertify.error("Please Enter Character Only.");
                    return false;
                }
                else
                    return true;
            };
            function isNumberKey(evt) {
                var charCode = (evt.which) ? evt.which : event.keyCode
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    alertify.error("Please Enter Only Numeric Value.");
                    return false;
                }
                else
                    return true;
            }
        });
    </script>

    <div class="content_pane_cont input_content branch-div-tbl" id="FIELDSET1" runat="server">
         <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2 id="Name" runat="server" >Hostel Detail List</h2>
             <asp:Button runat="server" ID="btnHostelFeeHead" CssClass="button_save"  Text="Hostel FeeHead List" Style="float: right; margin-top: 5px; margin-right: 3px" ToolTip="Click here to Hostel." OnClick="btnHostelFeeHead_Click" />
             <asp:Button runat="server" ID="btnHostelName" CssClass="button_save"  Text="Add Hostel FeeHead" Style="float: right; margin-top: 5px; margin-right: 3px" ToolTip="Click here to Hostel." OnClick="btnHostelName_Click1"/>      

             <asp:Button runat="server" ID="Button2" CssClass="button_save"  Text="Hostel Name List" Style="float: right; margin-top: 5px; margin-right: 3px" ToolTip="Click here to Hostel." OnClick="Button2_Click"/>
             <asp:Button runat="server" ID="btnFeeList" CssClass="button_save"  Text="Add Hostel Name" Style="float: right; margin-top: 5px; margin-right: 3px" ToolTip="Click here to Hostel." OnClick="btnFeeList_Click" />
             <asp:Button runat="server" ID="Button3" CssClass="button_save"  Text="Add Section to class stream" Style="float: right; margin-top: 5px; margin-right: 3px" ToolTip="Click here to Add Section." OnClick="Button3_Click" Visible="false" />
        </div>
        <br />
        <div id="divall" runat="server">
            <div class="for_sigle_row_form">
                <label>
                    Hostel Name<span style="color: Red;">* </span>
                </label>
                <asp:HiddenField ID="dfHouse" Value="0" runat="server" />
                <asp:TextBox ID="txtHostelName" Text="" onkeypress="return lettersOnly(event)" runat="server" placeholder="Enter Hostel Name Please."></asp:TextBox>
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

                    <asp:GridView ID="griview_Hostel" runat="server" EmptyDataText="No data found !" BorderWidth="0" GridLines="None" CssClass="stm" HeaderStyle-Height="30px"
                        AutoGenerateColumns="false" PagerSettings-Position="Bottom" AllowPaging="true"
                        PagerStyle-Font-Size="15px" PageSize="20" PagerStyle-HorizontalAlign="Right" OnRowDeleting="griview_Hostel_RowDeleting"
                        Width="100%" OnPageIndexChanging="griview_Hostel_PageIndexChanging" OnRowCommand="griview_Hostel_RowCommand" OnRowDataBound="griview_Hostel_RowDataBound">

                        <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />

                        <Columns>
                            <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblSNo" runat="server" Text="<%#Container.DataItemIndex+1%>"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Hostel Name" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblproducname" runat="server" Text='<% #Bind("HostelName")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>                            
                            <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblstatus" runat="server" Text='<% #Bind("isActive")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgEdit" runat="server" CommandName="Edit1" CommandArgument='<%# Eval("HostelID") %>'
                                        ImageUrl="~/images/edit.gif" CausesValidation="false" ToolTip="update" />
                                    <asp:HiddenField ID="lblclassid" runat="server" Value="0"></asp:HiddenField>
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Delete" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgEdit1" runat="server" CommandName="Delete" CommandArgument='<%# Eval("HostelID") %>'
                                        ImageUrl="~/images/delete.gif" CausesValidation="false" ToolTip="update" />
                                    <asp:HiddenField ID="lblclassid1" runat="server" Value="0"></asp:HiddenField>
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

       <%-- Ostel Fee--%>
        <div id="Feediv1" runat="server" visible="false">
            <div class="for_sigle_row_form">
                <label>
                    Class Name<span style="color: Red;">* </span>
                </label>
                <asp:DropDownList ID="ddlClass" runat="server" ></asp:DropDownList>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    FeeHead Name<span style="color: Red;">* </span>
                </label>
                 <asp:HiddenField ID="HdFeeHead" Value="0" runat="server" />
                <asp:TextBox ID="txtFeeHead" Text="" onkeypress="return lettersOnly(event)" runat="server" placeholder="Enter FeeHead Name Please."></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                   FeeHead Amount<span style="color: Red;">* </span>
                </label>              
                <asp:TextBox ID="txtFeeHeadAmt" Text="" onkeypress="return lettersOnly(event)" runat="server" placeholder="Enter FeeHead Amount Please."></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label style="padding-top: 3px;">
                    Status<span style="color: Red;"> </span>
                </label>

                <asp:CheckBox ID="ChkFeeHead" runat="server" Height="20px" Width="20px" />
            </div>
            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Button ID="btnFeeHead" runat="server" Text="Submit" CssClass="button_save" OnClick="btnFeeHead_Click"  
                    ValidationGroup="g1" />
                <asp:Button ID="Button5" runat="server" Text="Back" CssClass="button_save" OnClick="Button1_Click" />
            </div>
        </div>
        <table cellpadding="2" id="Table1" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
            <tr>
                <td>

                    <asp:GridView ID="GrtFeeHead" runat="server" EmptyDataText="No data found !" BorderWidth="0" GridLines="None" CssClass="stm" HeaderStyle-Height="30px"
                        AutoGenerateColumns="false" PagerSettings-Position="Bottom" AllowPaging="true"
                        PagerStyle-Font-Size="15px" PageSize="20" PagerStyle-HorizontalAlign="Right" OnRowDeleting="GrtFeeHead_RowDeleting"
                        Width="100%" OnPageIndexChanging="GrtFeeHead_PageIndexChanging" OnRowCommand="GrtFeeHead_RowCommand" OnRowDataBound="GrtFeeHead_RowDataBound">

                        <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />

                        <Columns>
                            <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblSNo" runat="server" Text="<%#Container.DataItemIndex+1%>"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Hostel Fee Name" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblHostelFeeName" runat="server" Text='<% #Bind("HostelFeeName")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>    
                             <asp:TemplateField HeaderText="Hostel Fee Amount" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblHostelFeeAmt" runat="server" Text='<% #Bind("HostelFeeAmt")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>      
                            <asp:TemplateField HeaderText="Class Name" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblClassName" runat="server" Text='<% #Bind("ClassName")%>'></asp:Label>
                                     <asp:HiddenField ID="lblclassid" runat="server" Value='<% #Bind("ClassID")%>'></asp:HiddenField>
                                </ItemTemplate>
                            </asp:TemplateField>                                                 
                            <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblstatus" runat="server" Text='<% #Bind("Status")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgEdit" runat="server" CommandName="Edit1" CommandArgument='<%# Eval("HostelFeeID") %>'
                                        ImageUrl="~/images/edit.gif" CausesValidation="false" ToolTip="update" />                                   
                                </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Delete" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgEdit1" runat="server" CommandName="Delete" CommandArgument='<%# Eval("HostelFeeID") %>'
                                        ImageUrl="~/images/delete.gif" CausesValidation="false" ToolTip="update" />
                                    <asp:HiddenField ID="lblclassid1" runat="server" Value="0"></asp:HiddenField>
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

