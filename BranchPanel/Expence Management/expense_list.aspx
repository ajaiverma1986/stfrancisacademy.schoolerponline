<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="expense_list.aspx.cs" Inherits="BranchPanel_Expence_Management_expense_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="content_pane_cont input_content branch-div-tbl" id="contentPane">
        <div class="tbl-top-heading">
            <h2>Expense List</h2>
            <div class="upload">
                <i class="fa fa-cloud-upload icon"></i>
                <asp:Button ID="IBExcel" runat="server" Height="20px" CssClass="btnExcel" ToolTip="Click here to " Text="Download Exel Sheet" OnClientClick="return false;" />
            </div>
        </div>
        <div class="searchbar containerHeadline">
            <div class="clear"></div>
            <asp:TextBox ID="txtfromdate" runat="server" ReadOnly="true" Width="150px" placeholder="From Date"> </asp:TextBox>
            <asp:TextBox ID="txttodate" runat="server" ReadOnly="true" Width="150px" placeholder="To Date"> </asp:TextBox>
            <asp:DropDownList ID="ddlcategory" runat="server" Width="180px"></asp:DropDownList>

            <asp:ImageButton ID="Imageforclear" runat="server" Width="25px" ImageUrl="~/images/clearsearch.png" ToolTip="Click Here For Reset The Search." />
            <div class="clear"></div>
        </div>




        <div id="trnorecordfound" runat="server" style="display: none !important;">

            <asp:Label ID="lblnorecord" runat="server" Text="No record found according to your searching." Style="margin-left: 100px; font-size: 15px !important; color: red"></asp:Label>

        </div>
        <div class="grid-data-resposive m-l-sm m-r-sm">

            <div id="divgridforsalary" runat="server" class="divgridforsalary divTableDataHolder">
                <asp:GridView ID="grdformonthlysalaryreport" AutoGenerateColumns="false" Width="100%" runat="server"
                    GridLines="None" CssClass="stm" OnRowCommand="grdformonthlysalaryreport_RowCommand">
                    <Columns>
                        <asp:TemplateField ItemStyle-Width="0px" HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblRowNumber" Text='<%#Eval("RowNumber") %>' runat="server" CssClass="RowNumber"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="80px" HeaderText="Expense Date" ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblExpenseDate" Text='<%#Eval("ExpenseDate") %>' runat="server" CssClass="ExpenseDate"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="110px" HeaderText="Category Name" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="121px">
                            <ItemTemplate>
                                <asp:Label ID="lblTitlename" runat="server" Text='<%#Eval("Titlename") %>' CssClass="Titlename" data-tooltip='<%#Eval("Titlename")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-Width="110px" HeaderText="Category Description" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="121px">
                            <ItemTemplate>
                                <asp:Label ID="lblCategoryDescription" runat="server" Text='<%#Eval("CategoryDescription") %>' CssClass="CategoryDescription"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="121px">
                            <ItemTemplate>
                                <asp:Label ID="lblDescription" Text='<%# Eval("Description") %>' runat="server" CssClass="Description" data-tooltip='<%#Eval("Description")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Label ID="lblamount" Text='<%# Eval("Expense") %>' runat="server" CssClass="Expense"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="VAT & TAX" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Label ID="lbltax" Text='<%# Eval("vat_servicetax") %>' runat="server" CssClass="vat_servicetax"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Total Amount" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px">
                            <ItemTemplate>
                                <asp:Label ID="lblwithtotalamountwithtax" Text='<%# Eval("Expensewithtax") %>' runat="server" CssClass="Expensewithtax"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Edit">
                            <ItemTemplate>
                                <asp:ImageButton runat="server" ID="btneditexpense" ImageUrl="~/images/edit.png" Style="height: 15px; width: 15px; border-width: 0px;" CssClass="editexpense" />
                                <asp:Label ID="lblexid" Text='<%#Eval("Exid") %>' Style="display: none" runat="server" CssClass="Exid"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="View Attachment" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:ImageButton runat="server" ID="btnviewreport" ImageUrl="../../images/viewquestion.png" Style="height: 15px; width: 15px; border-width: 0px;" CssClass="viewdocument" />
                                <asp:Label ID="lbltopic" Text='<%#Eval("expence_file") %>' Style="display: none" runat="server" ForeColor="Chocolate" CssClass="filename"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Download Attachment" ItemStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <asp:ImageButton runat="server" ID="btndownloadreport" ImageUrl="../../images/download.png" Style="height: 15px; width: 15px; border-width: 0px;" OnClick="btndownloadreport_Click1" CssClass="downloaddocument" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                    <RowStyle CssClass="stm_light clseveryrow" />
                    <AlternatingRowStyle CssClass="stm_dark clseveryrow" />
                </asp:GridView>

            </div>
            <div id="div2" runat="server">
            </div>



            <table class="" style="width: 100%;" cellpadding="0" cellspacing="0">
                <tr class="stm_head" align="center">
                    <td align="center" scope="col"></td>
                    <td align="center" scope="col"></td>
                    <td align="center" scope="col"></td>
                    <td align="center" scope="col"></td>
                    <td align="center" scope="col"></td>
                    <td align="center" scope="col" style="width: 50%;"></td>
                    <td align="center" scope="col">
                        <asp:Label ID="lbltotal" runat="server" CssClass="total" Style="font-weight: bold; width: 150px; margin-right: 65px !important;"></asp:Label>
                    </td>
                    <td align="center" scope="col">
                        <asp:Label ID="lbltax" runat="server" CssClass="total" Style="font-weight: bold; width: 150px; margin-right: 65px !important;"></asp:Label>
                    </td>
                    <td align="center" scope="col">
                        <asp:Label ID="lblamounaftertax" runat="server" CssClass="total" Style="font-weight: bold; width: 150px; margin-right: 65px !important;"></asp:Label>
                    </td>


                    <td align="center" scope="col" style="width:17%"></td>
                    <td align="center" scope="col"></td>
                </tr>
            </table>
        </div>
        <asp:HiddenField ID="forurl" runat="server" />
        <div id="divProgressBar" class="progress"></div>

    </div>
     <script type="text/javascript">
         var file;
         $(document).ready(function () {
             $('.viewdocument').click(function () {
                 file = $(this).parent('td').parent('tr').find('td:eq(9)').find('span').text();
                 if (file != "") {
                     var url = 'http://www.schoolerponline.in/BranchPanel/Expence Management/ExpenceDocument/';
                     window.open(url + file);
                 }
                 else {
                     alert("There is no file to view.");
                 }
                 return false;
             });
             $('.editexpense').live('click', function () {
                 var exid = $(this).parent('td').parent('tr').find('td:eq(8)').find('span').text();
                 window.location.href = 'expense-manager.aspx?exid=' + exid;
                 return false;
             });
             $("#ctl00_ContentPlaceHolder1_txttodate,#ctl00_ContentPlaceHolder1_txtfromdate").datepicker({
                 changeMonth: true,
                 changeYear: true,
                 yearRange: '1985:2050',
                 dateFormat: "dd MM yy"
             });
             $('#ctl00_ContentPlaceHolder1_txttodate,#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_ddlcategory').change(function () {
                 FillField();
                 BindGridAfterSearch();
                 return false;
             });
             $(".btnExcel").click(function (e) {
                 window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.divgridforsalary').html()));
                 e.preventDefault();
             });
             $("#ctl00_ContentPlaceHolder1_Imageforclear").click(function () {
                 fromdate = "", todate = "", titleid = 0;
                 $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").val('');
                 $("#ctl00_ContentPlaceHolder1_ddlcategory").val('0');
                 BindGridAfterSearch();
                 return false;
             });
         });
         var payid = 0, fyid = 0, fromdate = "", todate = "", titleid = 0;
         function FillField() {
             fromdate = $('#ctl00_ContentPlaceHolder1_txtfromdate').val();
             todate = $('#ctl00_ContentPlaceHolder1_txttodate').val();
             titleid = $('#ctl00_ContentPlaceHolder1_ddlcategory').val();
         }
         function BindGridAfterSearch() {
             var totalexpense = 0, totalvat = 0, totalamount = 0;
             $('#ctl00_ContentPlaceHolder1_lbltax,#ctl00_ContentPlaceHolder1_lblamounaftertax').val('');
             call_progressbar("start");
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "expense_list.aspx/BindGridByJs",
                 data: "{'payid':'" + payid + "','fyid':'" + fyid + "','fromdate':'" + fromdate + "','todate':'" + todate + "','titleid':'" + titleid + "'}",
                 dataType: "json",
                 async: false,
                 success: function (data) {
                     if (data.d.length > 0) {
                         $('#ctl00_ContentPlaceHolder1_lbltotal').html('Amount:');
                         $('#ctl00_ContentPlaceHolder1_lbltax').html('Vat & Tax:');
                         $('#ctl00_ContentPlaceHolder1_lblamounaftertax').html('Total Amount:');
                         $('#ctl00_ContentPlaceHolder1_lbltotal,#ctl00_ContentPlaceHolder1_lbltax,#ctl00_ContentPlaceHolder1_lblamounaftertax,#ctl00_ContentPlaceHolder1_divgridforsalary').css("display", "block");
                         $('#ctl00_ContentPlaceHolder1_lblnorecord,#ctl00_ContentPlaceHolder1_trnorecordfound').css("display", "none");
                         $("[id*=grdformonthlysalaryreport] tr").show();
                         $("[id*=grdformonthlysalaryreport] tr:gt(1)").remove();
                         for (var i = 0; i < data.d.length; i++) {
                             row = $("[id*=grdformonthlysalaryreport] tr:eq(1)").clone(true);
                             $("[id$=grdformonthlysalaryreport]").append(row);
                             $(row).find('.RowNumber').html(data.d[i].RowNumber);
                             $(row).find('.ExpenseDate').html(data.d[i].ExpenseDate);
                             $(row).find('.Titlename').html(data.d[i].fullTitlename);
                             $(row).find('.Titlename').attr("data-tooltip", data.d[i].Titlename);
                             $(row).find('.CategoryDescription').html(data.d[i].CategoryDescription);
                             $(row).find('.Description').html(data.d[i].fullDescription);
                             $(row).find('.Description').attr("data-tooltip", data.d[i].Description);
                             $(row).find('.Expense').html(data.d[i].Expense);
                             $(row).find('.vat_servicetax').html(data.d[i].vat_servicetax);
                             $(row).find('.Expensewithtax').html(data.d[i].Expensewithtax);
                             $(row).find('.filename').html(data.d[i].expence_file);
                             $(row).find('.Exid').html(data.d[i].Exid);
                             totalexpense = (parseFloat(totalexpense) + parseFloat(data.d[i].Expense))
                             totalvat = (parseFloat(totalvat) + parseFloat(data.d[i].vat_servicetax))
                             totalamount = (parseFloat(totalamount) + parseFloat(data.d[i].Expensewithtax))
                             if (i % 2 != 0)
                                 $(row).addClass('stm_light');
                             else
                                 $(row).addClass('stm_dark');
                         }
                         $("[id*=grdformonthlysalaryreport] tr").show();
                         $("[id*=grdformonthlysalaryreport] tr:eq(1)").hide();
                         $('#ctl00_ContentPlaceHolder1_lbltotal').html($('#ctl00_ContentPlaceHolder1_lbltotal').html() + totalexpense);
                         $('#ctl00_ContentPlaceHolder1_lbltax').html($('#ctl00_ContentPlaceHolder1_lbltax').html() + totalvat);
                         $('#ctl00_ContentPlaceHolder1_lblamounaftertax').html($('#ctl00_ContentPlaceHolder1_lblamounaftertax').html() + totalamount);
                     }
                     else {
                         $('#ctl00_ContentPlaceHolder1_divgridforsalary,#ctl00_ContentPlaceHolder1_lblnorecord,#ctl00_ContentPlaceHolder1_trnorecordfound').css("display", "block");
                         $("[id*=grdformonthlysalaryreport] tr").hide();
                         $('#ctl00_ContentPlaceHolder1_lbltotal,#ctl00_ContentPlaceHolder1_lbltax,#ctl00_ContentPlaceHolder1_lblamounaftertax').css("display", "none");
                         $('#ctl00_ContentPlaceHolder1_lbltotal').html('Amount: ');
                         $('#ctl00_ContentPlaceHolder1_lbltax').html('Vat & Tax: ');
                         $('#ctl00_ContentPlaceHolder1_lblamounaftertax').html('Total Amount: ');
                     }
                     call_progressbar("end");
                 },
                 error: function (result) {
                     call_progressbar("end");
                     return false;
                 }
             });
         }
         function call_progressbar(progtype) {
             if (progtype == "start") {
                 $("#divProgressBar").find("#loader").remove();
                 $("#divProgressBar").append('<img id="loader" alt="" src="../../images/loader_new.gif" />');
                 $("#divProgressBar").addClass("progressAdd");
             }
             if (progtype == "end") {
                 $("#divProgressBar").find("#loader").remove();
                 $("#divProgressBar").removeClass("progressAdd");
             }
         }
    </script>
</asp:Content>

