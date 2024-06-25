<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="ViewResult.aspx.cs" Inherits="BranchPanel_Exams_ViewResult" %>

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
            <h2>Student Exam Result List</h2>
            <asp:Button runat="server" ID="Button2" CssClass="button_save" Text="Add Student to House" Style="float: right; margin-top: 5px; margin-right: 3px" ToolTip="Click here to Add Section." OnClick="Button2_Click" Visible="false" />
            <asp:Button runat="server" ID="Button3" CssClass="button_save" Text="Add Section to class stream" Style="float: right; margin-top: 5px; margin-right: 3px" ToolTip="Click here to Add House." OnClick="Button3_Click" Visible="false" />
            <div class="upload">
                <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="false" OnClick="IBExcel_Click"
                    Height="20px" CssClass="BtnExcel" Style="float: right;"
                    ToolTip="Click here to download Excel sheet" />
                <a href="testlist.aspx">
                <img src="../../images/back-button.png" alt="school-logo" /></a>
            </div>
        </div>
        <br />
        <div>
        </div>
        <div id="divall" runat="server">
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
                <asp:DropDownList ID="ddlSection" runat="server" OnSelectedIndexChanged="ddlSection_SelectedIndexChanged1" AutoPostBack="true" >
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form" runat="server" id="Div1">
                <label>
                    Result Type<span style="color: Red;">* </span>
                </label>
                <asp:DropDownList ID="ddlResultType" Enabled="false" runat="server" OnSelectedIndexChanged="ddlSection_SelectedIndexChanged" AutoPostBack="true" >
                    <asp:ListItem Value="0" Text="Select Type"></asp:ListItem>
                    <asp:ListItem Value="1" Text="Term I"></asp:ListItem>
                    <asp:ListItem Value="2" Text="Term II"></asp:ListItem>
                     
                   <%-- <asp:ListItem Value="4" Text="Term I-II"></asp:ListItem>--%>
                    
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form" runat="server" id="Div2">
                <label>
                    Select All Student
                </label>
                 <asp:CheckBox ID="ChkResult" runat="server" AutoPostBack="true" OnCheckedChanged="ChkResult_CheckedChanged"></asp:CheckBox>
            </div>
            <div class="for_sigle_row_form" runat="server"  style="float:right">
                <asp:Button ID="btnVResult" runat="server" Text="View Result" Visible="false" CssClass="button_save" OnClick="btnVResult_Click" />
            </div>
            <br />
            <table cellpadding="2" id="tblHouseList" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
                <tr>
                    <td>

                        <asp:GridView ID="grdHouse" runat="server" EmptyDataText="No data found !" BorderWidth="0" GridLines="None" CssClass="stm" HeaderStyle-Height="30px"
                            AutoGenerateColumns="false" PagerSettings-Position="Bottom" AllowPaging="true"
                            PagerStyle-Font-Size="15px" PageSize="150" PagerStyle-HorizontalAlign="Right" OnPageIndexChanging="grdHouse_PageIndexChanging"
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
                                <asp:TemplateField HeaderText="Result" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRollNo" runat="server" Text='<% #Bind("RegNewNo")%>'></asp:TextBox>                                       
                                    </ItemTemplate>
                                </asp:TemplateField>
                               <%-- <asp:TemplateField HeaderText="View" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="imgEdit" runat="server" CommandName="Edit1" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="View Result" CausesValidation="false" ToolTip="update" />
                                        <asp:HiddenField ID="lblclassid" runat="server" Value="0"></asp:HiddenField>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="Check" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="ChkResult1" runat="server"></asp:CheckBox>
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
           <%-- <div class="for_sigle_row_form" runat="server" visible="false">
                <label>
                </label>
                <asp:Button ID="btnAdd" runat="server" Text="Submit" CssClass="button_save" OnClick="btSave_Click"
                    ValidationGroup="g1" />
                <asp:Button ID="Button1" runat="server" Text="Back" CssClass="button_save" OnClick="Button1_Click" />
            </div>--%>
        </div>
        <table cellpadding="2" id="divgrid" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
            <tr>
                <td>

                    <asp:GridView ID="griview_AllHouse" runat="server" EmptyDataText="No data found !" BorderWidth="0" GridLines="None" CssClass="stm" HeaderStyle-Height="30px"
                        AutoGenerateColumns="false" PagerSettings-Position="Bottom" AllowPaging="true"
                        PagerStyle-Font-Size="15px" PageSize="20" PagerStyle-HorizontalAlign="Right"
                        Width="100%" OnPageIndexChanging="griview_AllHouse_PageIndexChanging" OnRowCommand="griview_AllHouse_RowCommand" OnRowDataBound="griview_AllHouse_RowDataBound">

                        <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />

                        <Columns>
                            <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblSNo" runat="server" Text="<%#Container.DataItemIndex+1%>"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="House Name" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblproducname" runat="server" Text='<% #Bind("Housename")%>'></asp:Label>
                                    <asp:HiddenField ID="hdfhouseID" runat="server" Value='<% #Bind("HouseID")%>'></asp:HiddenField>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="No. of Student" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblNoStd" runat="server" Text="0"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="View" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgEdit" runat="server" CommandName="ViewAll" CommandArgument='<%# Eval("HouseID") %>'
                                        ImageUrl="~/images/view.png" CausesValidation="false" ToolTip="update" Width="35" Height="35" />
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
    </div>
    <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

