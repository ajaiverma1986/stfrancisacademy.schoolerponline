<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="mst_FeeFine.aspx.cs" Inherits="BranchPanel_Fee_Management_mst_FeeFine" %>
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
            <h2>Fee Fine</h2>
             <asp:Button runat="server" ID="Button2" CssClass="button_save"  Text="Add Fee Fine" Style="float: right; margin-top: 5px; margin-right: 3px" ToolTip="Click here to Add Section." OnClick="Button2_Click" />
             <asp:Button runat="server" ID="Button3" CssClass="button_save"  Text="Add Section to class stream" Style="float: right; margin-top: 5px; margin-right: 3px" ToolTip="Click here to Add Section." OnClick="Button3_Click" Visible="false" />
        </div>
        <br />
        <div id="divall" runat="server">
            <div class="for_sigle_row_form">
                <label>
                    Fee Name<span style="color: Red;">* </span>
                </label>
                <asp:TextBox ID="txtFeeName" Text="Late Fee" ReadOnly="true" onkeypress="return lettersOnly(event)" runat="server" placeholder="Enter Fee Name Please."></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Fee Type<span style="color: Red;">* </span>
                </label>
                <asp:DropDownList ID="ddlFeeType" runat="server" AppendDataBoundItems="True"> 
                    <asp:ListItem Value="0" Text="--Select--"></asp:ListItem>              
                    <asp:ListItem Value="1" Text="Day Wise"></asp:ListItem>         
                    <asp:ListItem Value="2" Text="Fixed"></asp:ListItem>              
                </asp:DropDownList>&nbsp;
            </div>
             <div class="for_sigle_row_form">
                <label>
                    Fee Amount<span style="color: Red;">* </span>
                </label>
                <asp:TextBox ID="txtFeeAmt" onkeypress="return isNumberKey(event)" runat="server" placeholder="Enter Fee Amount Please."></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label>
                    Fine After Days<span style="color: Red;">* </span>
                </label>
                <asp:TextBox ID="txtNoDays" onkeypress="return isNumberKey(event)" runat="server"  placeholder="Enter Section Name Please."></asp:TextBox>
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

                    <asp:GridView ID="griview_LateFee" runat="server" EmptyDataText="No data found !" BorderWidth="0" GridLines="None" CssClass="stm" HeaderStyle-Height="30px"
                        AutoGenerateColumns="false" PagerSettings-Position="Bottom" AllowPaging="true"
                        PagerStyle-Font-Size="15px" PageSize="20" PagerStyle-HorizontalAlign="Right"
                        Width="100%" OnPageIndexChanging="griview_LateFee_PageIndexChanging" OnRowCommand="griview_LateFee_RowCommand" OnRowDataBound="griview_LateFee_RowDataBound">

                        <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />

                        <Columns>
                            <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblSNo" runat="server" Text="<%#Container.DataItemIndex+1%>"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fine Name" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblproducname" runat="server" Text='<% #Bind("FeeName")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fine Type" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblfinetype" runat="server" Text='<% #Bind("Feetype")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fine After Days" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblFeeAtfer" runat="server" Text='<% #Bind("FeeAfterDays")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fine Amount" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblsectionname" runat="server" Text='<% #Bind("FeeAmt")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblstatus" runat="server" Text='<% #Bind("isActive")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgEdit" runat="server" CommandName="Edit1" CommandArgument='<%# Eval("FeeID") %>'
                                        ImageUrl="~/images/edit.gif" CausesValidation="false" ToolTip="update" />
                                    <asp:HiddenField ID="lblclassid" runat="server" Value='<% #Bind("Brid")%>'></asp:HiddenField>
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

