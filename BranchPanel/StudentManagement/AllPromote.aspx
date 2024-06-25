<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="AllPromote.aspx.cs" Inherits="BranchPanel_StudentManagement_AllPromote" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('[id*=chkSelectAll1]').click(function () {
                var isChecked = $('[id*=chkSelectAll1]').is(':checked');
                    functionCheckall(isChecked);
            });
            //$('[id*=chkEditAll]').click(function () {
            //    var isChecked = $('[id*=chkEditAll]').is(':checked');
            //    functionEditall(!isChecked);
            //});
            $('#ctl00_ContentPlaceHolder1_ddlStatus1').live('change', function () {
                if ($('#ctl00_ContentPlaceHolder1_ddlStatus1').val() != '0') {
                    $('[id*=chkEditAll]').disabled = false;
                    $('[id*=chkSelectAll1]').disabled = false;
                } else {
                    $('[id*=chkEditAll]').disabled = true;
                    $('[id*=chkSelectAll1]').disabled = true;
                }
            });
            $("#chkSelectAll").click(function () {
                debugger;
                alert('d');
                var isChecked = $('#chkSelectAll').is(':checked');
                functionCheckall(isChecked);
            });
            $(".button_save").click(function () {
                if ($("#ctl00_ContentPlaceHolder1_ddlStatus1").val == "4") {
                    if ($("#ctl00_ContentPlaceHolder1_ddlFyid").val == "0") {
                        alertify.error("Please Select Session.");
                        return false;
                    }
                    if ($("#ctl00_ContentPlaceHolder1_ddlPrmClass").val == "0") {
                        alertify.error("Please Select Promoted Class");
                        return false;
                    }
                if ($("#ctl00_ContentPlaceHolder1_ddlPrmSection").val == "0") {
                        alertify.error("Please Select Promoted Section");
                        return false;
                    }
                }
            });
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
        function functionCheckall(checked) {
            debugger;
            var GridView1 = document.getElementById("<%=grdStatus.ClientID %>");
            if (GridView1 != null || GridView1 != undefined) {
                for (i = 1; i < GridView1.rows.length; i++) {
                    var isDisabled = GridView1.rows[i].cells[7].getElementsByTagName("INPUT")[0].disabled;
                    if (!isDisabled) {
                        GridView1.rows[i].cells[7].getElementsByTagName("INPUT")[0].checked = checked;
                    }
                }
            }
        }

        function functionEditall(checked) {
            var GridView1 = document.getElementById("<%=grdStatus.ClientID %>");
            if (GridView1 != null || GridView1 != undefined) {
                for (i = 1; i < GridView1.rows.length; i++) {
                    GridView1.rows[i].cells[5].getElementsByTagName("SELECT")[0].disabled = checked;
                    GridView1.rows[i].cells[6].getElementsByTagName("SELECT")[0].disabled = checked;
                    GridView1.rows[i].cells[7].getElementsByTagName("INPUT")[0].disabled = checked;
                }
            }
        }
    </script>

    <div class="content_pane_cont input_content branch-div-tbl" id="FIELDSET1" runat="server">
        <div class="tbl-top-heading" style="width: 100%; margin-left: 0px">
            <h2>Student Status List</h2>
            <asp:Button runat="server" ID="Button2" CssClass="button_save" Text="Add Student Status" Style="float: right; margin-top: 5px; margin-right: 3px" ToolTip="Click here to Add Section." OnClick="Button2_Click" />
            <asp:Button runat="server" ID="Button3" CssClass="button_save" Text="Add Section to class stream" Style="float: right; margin-top: 5px; margin-right: 3px" ToolTip="Click here to Add Status." OnClick="Button3_Click" Visible="false" />
            <div class="upload">
                <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                      <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true" OnClick="IBExcel_Click"
                Height="20px" CssClass="BtnExcel" Style="float:right;"
                ToolTip="Click here to download Excel sheet" />  </div>
        </div>
        <br />
        <div>
        </div>
        <div id="divall" runat="server">
             <div class="for_sigle_row_form" runat="server" id="Div5">
                <label>
                    Current Session <span style="color: Red;">* </span>
                </label>
                <asp:DropDownList ID="ddlCurrFyid" runat="server" OnSelectedIndexChanged="ddlCurrFyid_SelectedIndexChanged" AutoPostBack="true">
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
            <div class="for_sigle_row_form" runat="server" id="Div1">
                <label>
                    Change Status<span style="color: Red;">*</span>
                </label>
                <asp:DropDownList ID="ddlStatus1" runat="server" OnSelectedIndexChanged="ddlStatus1_SelectedIndexChanged" AutoPostBack="true">
                    <asp:ListItem Value="0" Text="--Select Status--"></asp:ListItem>
                    <asp:ListItem Value="1" Text="Terminated"></asp:ListItem>
                    <asp:ListItem Value="2" Text="Transfered"></asp:ListItem>
                    <asp:ListItem Value="3" Text="PassOut"></asp:ListItem>
                    <asp:ListItem Value="4" Text="Promoted"></asp:ListItem>
                    <asp:ListItem Value="5" Text="Running"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="for_sigle_row_form" runat="server" id="Div2" visible="false">
                <label>
                    Session<span style="color: Red;">*</span>
                </label>
                <asp:DropDownList ID="ddlFyid" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFyid_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form" runat="server" id="Div3" visible="false">
                <label>
                    Class<span style="color: Red;">*</span>
                </label>
                <asp:DropDownList ID="ddlPrmClass" runat="server" OnSelectedIndexChanged="ddlPrmClass_SelectedIndexChanged" AutoPostBack="true">
                </asp:DropDownList>
            </div>
            <div class="for_sigle_row_form" runat="server" id="Div4" visible="false">
                <label>
                    Section<span style="color: Red;">*</span>
                </label>
                <asp:DropDownList ID="ddlPrmSection" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPrmSection_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
            <%--<div class="for_sigle_row_form" runat="server" id="divSelectAll" visible="false">
                <input type="checkbox" name="chkSelectAll" value="chkSelectAll" id="chkSelectAll" />
                <label for="vehicle1">Select All</label>
            </div>--%>
            <br />
            <table cellpadding="2" id="tblStatusList" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
                <tr>
                    <td>

                        <asp:GridView ID="grdStatus" runat="server" EmptyDataText="No data found !" BorderWidth="0" GridLines="None" CssClass="stm" HeaderStyle-Height="30px"
                            AutoGenerateColumns="false" PagerSettings-Position="Bottom" AllowPaging="true" OnPageIndexChanging="grdStatus_PageIndexChanging"
                            PagerStyle-Font-Size="15px" PageSize="100" PagerStyle-HorizontalAlign="Right"
                            Width="100%" OnRowCommand="grdStatus_RowCommand" OnRowDataBound="grdStatus_RowDataBound">

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
                                        <asp:HiddenField ID="hdfSessionID" runat="server" Value='<% #Bind("Fyid")%>'></asp:HiddenField>
                                        <asp:HiddenField ID="hdfClassID" runat="server" Value='<% #Bind("Class")%>'></asp:HiddenField>
                                        <asp:HiddenField ID="hdfSectionID" runat="server" Value='<% #Bind("Sec")%>'></asp:HiddenField>
                                        <asp:Label ID="lblClassSec" runat="server" Text='<%#Eval("Class")+ "~" + Eval("Sec")%>'></asp:Label>                                        
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Admission No" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAdmNo" runat="server" Text='<% #Bind("AdmissionNo")%>'></asp:Label>
                                        <asp:HiddenField ID="lblStdNo" runat="server" Value='<% #Bind("StuRegNo")%>'></asp:HiddenField>
                                        <asp:HiddenField ID="lblSAMID" runat="server" Value='<% #Bind("SAMID")%>'></asp:HiddenField>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status Name" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStatusName" runat="server" Text=""></asp:Label>
                                        <asp:HiddenField ID="hdfStatusID" runat="server" Value='<% #Bind("statusID")%>'></asp:HiddenField>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Class" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlClass" runat="server">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Section" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlSection1" runat="server">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        Select All
                                        <asp:CheckBox
                                            ID="chkSelectAll1"
                                            runat="server" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="ChkStatus" runat="server"></asp:CheckBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                      Edit All  <asp:CheckBox
                                            ID="chkEditAll"
                                            runat="server" 
                                            OnCheckedChanged="chkEditAll_CheckedChanged" 
                                            AutoPostBack="true" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgEdit" runat="server" CommandName="Edit1" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" ImageUrl="~/images/edit.gif" CausesValidation="false" ToolTip="update" />
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
        <table cellpadding="2" id="divgrid" runat="server" cellspacing="0" border="0" style="width: 100%; border-left: none !important; border-bottom: 1px solid #ddd;">
            <tr>
                <td>

                    <asp:GridView ID="griview_AllStatus" runat="server" EmptyDataText="No data found !" BorderWidth="0" GridLines="None" CssClass="stm" HeaderStyle-Height="30px"
                        AutoGenerateColumns="false" PagerSettings-Position="Bottom" AllowPaging="true"
                        PagerStyle-Font-Size="15px" PageSize="20" PagerStyle-HorizontalAlign="Right"
                        Width="100%" OnPageIndexChanging="griview_AllStatus_PageIndexChanging" OnRowCommand="griview_AllStatus_RowCommand" OnRowDataBound="griview_AllStatus_RowDataBound">

                        <PagerStyle CssClass="gridpager" HorizontalAlign="Center" />

                        <Columns>
                            <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblSNo" runat="server" Text="<%#Container.DataItemIndex+1%>"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Status Name" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblproducname" runat="server" Text='<% #Bind("Statusname")%>'></asp:Label>
                                    <asp:HiddenField ID="hdfStatusID" runat="server" Value='<% #Bind("StatusID")%>'></asp:HiddenField>
                                </ItemTemplate>
                            </asp:TemplateField>
                              <asp:TemplateField HeaderText="No. of Student" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Label ID="lblNoStd" runat="server" Text="0"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="View" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgEdit" runat="server" CommandName="ViewAll" CommandArgument='<%# Eval("StatusID") %>'
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


