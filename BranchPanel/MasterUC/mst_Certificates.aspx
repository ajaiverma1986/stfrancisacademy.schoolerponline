<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="mst_Certificates.aspx.cs" Inherits="BranchPanel_MasterUC_mst_Certificates" %>
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
            //$(".BtnExcel").click(function (e) {
            //    alertify.confirm("Are You Sure You Want To Download The ExcelSheet.", function (e) {
            //        if (e) {
            //            window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('#divgrid').html()));
            //            e.preventDefault();
            //        }
            //    });
            //    return false;
            //});
        });
    </script>

    <div class="content_pane_cont input_content branch-div-tbl" id="FIELDSET1" runat="server">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Student Certificate List</h2>
            <%--<asp:Button runat="server" ID="Button2" CssClass="button_save" Text="Add Student to House" Style="float: right; margin-top: 5px; margin-right: 3px" ToolTip="Click here to Add Section." OnClick="Button2_Click" />
            <asp:Button runat="server" ID="Button3" CssClass="button_save" Text="Add Section to class stream" Style="float: right; margin-top: 5px; margin-right: 3px" ToolTip="Click here to Add House." OnClick="Button3_Click" Visible="false" />
            <div class="upload">
                <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                      <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true" OnClick="IBExcel_Click"
                Height="20px" CssClass="BtnExcel" Style="float:right;"
                ToolTip="Click here to download Excel sheet" />  </div>--%>
        </div>
        <br />
        <div>
        </div>
        <div id="divall" runat="server">
            <div class="for_sigle_row_form" runat="server" id="Div1">
                <label>
                    Session<span style="color: Red;">* </span>
                </label>
                <asp:DropDownList ID="ddlFyid" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFyid_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form" runat="server" id="one">
                <label>
                    Class<span style="color: Red;">* </span>
                </label>
                <asp:DropDownList ID="ddlapplyingforclass" runat="server" OnSelectedIndexChanged="ddlapplyingforclass_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form" runat="server" id="two">
                <label>
                    Section<span style="color: Red;">* </span>
                </label>
                <asp:DropDownList ID="ddlSection" runat="server" OnSelectedIndexChanged="ddlSection_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
            </div>
            <br />
            <table cellpadding="2" id="tblHouseList" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
                <tr>
                    <td>

                        <asp:GridView ID="grdHouse" runat="server" EmptyDataText="No data found !" BorderWidth="0" GridLines="None" CssClass="stm" HeaderStyle-Height="30px"
                            AutoGenerateColumns="false" PagerSettings-Position="Bottom" AllowPaging="true"
                            PagerStyle-Font-Size="15px" PageSize="20" PagerStyle-HorizontalAlign="Right" OnPageIndexChanging="grdHouse_PageIndexChanging"
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
                                        <asp:Label ID="lblStdname" runat="server" Text='<% #Bind("StudentName")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                  <asp:TemplateField HeaderText="Class-Section" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblClassSec" runat="server" Text='<%#Eval("Class")+ "~" + Eval("Sec")%>'></asp:Label>                                        
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Admission No" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAdmNo" runat="server" Text='<% #Bind("AdmissionNo")%>'></asp:Label>
                                        <asp:HiddenField ID="lblStdNo" runat="server" Value='<% #Bind("StuRegNo")%>'></asp:HiddenField>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                  <asp:TemplateField HeaderText="Given TC" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTCCount" runat="server" Text=""></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="View" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgEdit" runat="server" CommandName="Edit1" CommandArgument='<% #Bind("StuRegNo")%>'
                                         ImageUrl="~/images/View-Button.png" Width="60px" Height="25px" CausesValidation="false" ToolTip="update" />
                                        <asp:HiddenField ID="lblclassid" runat="server" Value="0"></asp:HiddenField>
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
            <br />
            <div class="for_sigle_row_form">
                <label>
                </label>
                <asp:Button ID="btnAdd" runat="server" Text="Submit" CssClass="button_save" OnClick="btSave_Click"
                    ValidationGroup="g1" />
                <asp:Button ID="Button1" runat="server" Text="Back" CssClass="button_save" OnClick="Button1_Click" />
            </div>
        </div>        
    </div>
    <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

