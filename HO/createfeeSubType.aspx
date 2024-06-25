<%@ Page Title="Add Fees Sub Type" Language="C#" AutoEventWireup="true" CodeFile="createfeeSubType.aspx.cs" Inherits="HO_createfeeSubType" MasterPageFile="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Add Fee Type</h2>
            <asp:Button runat="server" ID="Button1" CssClass="button_save" Text="Add Fee"
                ToolTip="Click here to create fee subtype." OnClick="Button1_Click" Style="float: right; margin-top: 5px; margin-right: 3px" />
        </div>
        <div id="divtop" runat="server">
            <div class="for_sigle_row_form">
                <label>Select Session<span style="font-weight: bold; color: red">*</span></label>
                <asp:DropDownList ID="ddlfinancialyear" runat="server">
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form">
                <label>Fee Category<span style="font-weight: bold; color: red">*</span></label>
                <asp:DropDownList ID="ddlfeestype" runat="server">
                </asp:DropDownList>
            </div>
            <div class="clear"></div>
             <div class="for_sigle_row_form" id="tr_ddlMonth" runat="server">
                <label>Choose Day<span style="font-weight: bold; color: red">*</span></label>
                <asp:DropDownList ID="ddlMonth" runat="server">  
                    <asp:ListItem Value="0" Text="Select Month"></asp:ListItem>  
                    <asp:ListItem Value="4" Text="April"></asp:ListItem>
                    <asp:ListItem Value="5" Text="May"></asp:ListItem>
                    <asp:ListItem Value="6" Text="June"></asp:ListItem>
                    <asp:ListItem Value="7" Text="July"></asp:ListItem>
                    <asp:ListItem Value="8" Text="August"></asp:ListItem>
                    <asp:ListItem Value="9" Text="September"></asp:ListItem>
                    <asp:ListItem Value="10" Text="October"></asp:ListItem>
                    <asp:ListItem Value="11" Text="November"></asp:ListItem>
                    <asp:ListItem Value="12" Text="December"></asp:ListItem>
                    <asp:ListItem Value="1" Text="January"></asp:ListItem>
                    <asp:ListItem Value="2" Text="Febuary"></asp:ListItem>
                    <asp:ListItem Value="3" Text="March"></asp:ListItem>              
                </asp:DropDownList>
            </div>
            <div class="clear"></div>
            <div class="for_sigle_row_form" id="months" runat="server">
            <div class="col-sm-3">
                <asp:CheckBoxList ID="CheckBoxList1" runat="server">
                    <asp:ListItem Value="4" Text="April" ></asp:ListItem>
                    <asp:ListItem Value="5" Text="May" ></asp:ListItem>
                    <asp:ListItem Value="6" Text="June"  ></asp:ListItem>
                    <asp:ListItem Value="7" Text="July" ></asp:ListItem>
                    <asp:ListItem Value="8" Text="August" ></asp:ListItem>
                    <asp:ListItem Value="9" Text="September" ></asp:ListItem>
                </asp:CheckBoxList>
            </div>
            <div class="col-sm-3">
                <asp:CheckBoxList ID="CheckBoxList2" runat="server">
                    <asp:ListItem Value="10" Text="October" ></asp:ListItem>
                    <asp:ListItem Value="11" Text="November" ></asp:ListItem>
                    <asp:ListItem Value="12" Text="December" ></asp:ListItem>
                    <asp:ListItem Value="1" Text="January" ></asp:ListItem>
                    <asp:ListItem Value="2" Text="February" ></asp:ListItem>
                    <asp:ListItem Value="3" Text="March" ></asp:ListItem>
                </asp:CheckBoxList>
            </div>
        </div>
            <div class="clear"></div>
            <div class="for_sigle_row_form">
                <label>Fee Type<span style="font-weight: bold; color: red">*</span></label>
                <asp:TextBox ID="txtfeeSubType" runat="server" placeholder="Fee Type "></asp:TextBox>
            </div>
            <div class="for_sigle_row_form">
                <label style="margin-top: -10px !important;">Tax Applicable</label>
                <asp:CheckBox ID="chktaxapplicable" runat="server" />
            </div>
            <div class="clear"></div>
            <div class="for_sigle_row_form">
                <label style="margin-top: -10px !important;">Active</label>
                <asp:CheckBox ID="chkfetype" runat="server" />
            </div>
            <div class="for_sigle_row_form">
                <label></label>
                <asp:Label ID="lblMsg1" runat="server" ForeColor="Red"></asp:Label>
                <br />
                <label></label>
                <asp:Button ID="btnfeetype" runat="server" Text="Submit" CssClass="button_save"
                    OnClick="btnfeetype_Click" />
                <asp:Button ID="btnUpdate" runat="server" Text="Update"
                    CssClass="button_save" OnClick="btnUpdate_Click" />
                <asp:Button ID="btnback" runat="server" Text="Back" CssClass="button_cancel" OnClick="btnback_Click"/>
            </div>
        </div>
        <table cellpadding="2" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
            <tr>
                <td>
                    <div class="for_sigle_row_form" id="divforsearching" runat="server">
                        <asp:DropDownList ID="ddlfinacialyearforsearching" runat="server" style="width:150px;margin-left:5px" OnSelectedIndexChanged="ddlfinacialyearforsearching_SelectedIndexChanged" AutoPostBack="true">
                        </asp:DropDownList>
                    </div>
                    <div class="clear"></div>
                    <br />
                    <asp:GridView ID="grdFeeSubType" runat="server" AutoGenerateColumns="false" CssClass="stm" BorderWidth="0"
                        Width="100%" OnRowCommand="grdFeeSubType_RowCommand" GridLines="None">
                        <Columns>
                            <asp:TemplateField HeaderText="S.No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblsno" runat="server" Text='<%#Container.DataItemIndex+1 %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="100px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fee Type">
                                <ItemTemplate>
                                    <asp:Label ID="lblFeeName" runat="server" Text='<%# Eval("Feename") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="200px" HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fee Category">
                                <ItemTemplate>
                                    <asp:Label ID="lblFeeSubType" runat="server" Text='<%# Eval("feeMaintype") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="200px" HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Tax Applicable">
                                <ItemTemplate>
                                    <asp:Label ID="lbltaxapllicable" runat="server" Text='<%# Eval("TaxApplicable") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="200px" HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                               <asp:TemplateField HeaderText="Session">
                                <ItemTemplate>
                                    <asp:Label ID="lblsession" runat="server" Text='<%# Eval("FYName") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="200px" HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("status") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="200px" HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgEdit" runat="server" CommandName="edit14" CommandArgument='<%# Eval("id") %>'
                                        ImageUrl="~/images/edit.gif" CausesValidation="false" />
                                </ItemTemplate>
                                <ItemStyle Width="100px" HorizontalAlign="Center" />
                                <HeaderStyle HorizontalAlign="Center" />
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
    <script type="text/javascript">
        $(document).ready(function () {
            $('#ctl00_ContentPlaceHolder1_tr_ddlMonth').hide();
            $('#ctl00_ContentPlaceHolder1_months').hide();
            $('#ctl00_ContentPlaceHolder1_ddlfinancialyear,#ctl00_ContentPlaceHolder1_ddlfeestype,#ctl00_ContentPlaceHolder1_txtfeeSubType,#ctl00_ContentPlaceHolder1_grdFeeSubType_ctl10_imgEdit').on('click focus', function () {
                $('#ctl00_ContentPlaceHolder1_lblMsg1').html('');
                if ($('#ctl00_ContentPlaceHolder1_ddlfeestype').val() == '2')
                {
                    $('#ctl00_ContentPlaceHolder1_months').hide();
                    $('#ctl00_ContentPlaceHolder1_tr_ddlMonth').show();                   
                }
                else if ($('#ctl00_ContentPlaceHolder1_ddlfeestype').val() == '5') {
                    $('#ctl00_ContentPlaceHolder1_months').show();
                    $('#ctl00_ContentPlaceHolder1_tr_ddlMonth').hide();
                }
                else {
                    $('#ctl00_ContentPlaceHolder1_tr_ddlMonth').hide();
                }
            });
            
        });
    </script>
</asp:Content>