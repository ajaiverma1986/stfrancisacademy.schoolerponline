<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="expense_list.aspx.cs" Inherits="HO_expense_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style>
        .containerHeadline {
            background: none repeat scroll 0 0 #F5FDFF;

            position: relative;
            color: #1C95AE !important;
            height: 30px;
            line-height: 30px;
            padding-top: 5px;
            padding-left: 15px;
            font-family: verdana, Arial, Helvetica, sans-serif;
            font-size: 18px;
            border-bottom: 2px dotted #C9C6C6;
            padding-bottom: 5px;
            padding-left: 15px;
            padding-top: 5px;
            font-weight: 500;
        }

        .for_sigle_row_form select {
            border: 1px solid #CCCCCC;
            border-radius: 4px;
            color: #676767;
            height: 35px;
            margin-bottom: 0;
            padding: 7px 5px;
            width: 355px;
        }

        .student-photo_frame {
            background: none repeat scroll 0 0 #F4F1F1;
            border: 1px solid #CCCCCC;
            height: auto;
            margin-bottom: 30px;
            width: 100%;
        }
         [data-tooltip] {
            position: relative;
            z-index: 2;
            cursor: pointer;
        }

            /* Hide the tooltip content by default */
            [data-tooltip]:before,
            [data-tooltip]:after {
                visibility: hidden;
                -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)";
                filter: progid: DXImageTransform.Microsoft.Alpha(Opacity=0);
                opacity: 0;
                pointer-events: none;
            }
              /* Position tooltip above the element */
            [data-tooltip]:before {
                position: absolute;
                bottom: 150%;
                left: 50%;
                margin-bottom: 5px;
                margin-left: -50px;
                padding: 7px;
                width:auto;
                -webkit-border-radius: 3px;
                -moz-border-radius: 3px;
                border-radius: 3px;
                background-color: #000;
                background-color: hsla(0, 0%, 20%, 1.0);
                color: #fff;
                content: attr(data-tooltip);
                text-align: center;
                font-size: 14px;
                line-height: 1.2;
            }
            /* Triangle hack to make tooltip look like a speech bubble */
            [data-tooltip]:after {
                position: absolute;
                bottom: 150%;
                left: 50%;
                margin-left: -5px;
                width: 0;
                border-top: 5px solid #000;
                border-top: 5px solid hsla(0, 0%, 20%, 1.0);
                border-right: 5px solid transparent;
                border-left: 5px solid transparent;
                content: " ";
                font-size: 0;
                line-height: 0;
            }

            /* Show tooltip content on hover */
            [data-tooltip]:hover:before,
            [data-tooltip]:hover:after {
                visibility: visible;
                -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=100)";
                filter: progid: DXImageTransform.Microsoft.Alpha(Opacity=100);
                opacity: 1;
            }
            .separator {
            display: block;
            height: 2px;
            background-color: #E6E6E6;
            margin: 10px 0 15px;
        }

        .bg-blue {
            background-color: #E2E2E2;
        }
    </style>
     <div class="cheadline1" style="width: 100%; margin-left: 0px">
        <span class="spanheading">Expense List</span>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);" class="stm">
            <tr>
                <td class="containerHeadline" style="width: 100%">
                   <div class="for_sigle_row_form">
                        <asp:DropDownList ID="ddlbranchid" runat="server" Width="200px">
                        </asp:DropDownList>
                        
                        <asp:TextBox ID="txtfromdate" runat="server" Width="150px" placeholder="From Date"   onkeypress="return false"> </asp:TextBox>
                        <asp:TextBox ID="txttodate" runat="server" Width="150px" placeholder="To Date"   onkeypress="return false"> </asp:TextBox>
                        <asp:DropDownList ID="ddlcategory" runat="server" Width="180px">
                        </asp:DropDownList>
                        <asp:ImageButton ID="IBExcel" runat="server" ImageUrl="~/images/Excel-32-d.gif"
                            BackColor="#C8F1FB" Height="20px"
                            CssClass="btnExcel" ToolTip="Click here to download Excel sheet" OnClientClick="return false;" />
                        <asp:ImageButton ID="Imageforclear" runat="server" Width="25px" ImageUrl="~/images/clearsearch.png" ToolTip="Click Here For Reset The Search." OnClientClick="return false;" />
                    </div>
                </td>
            </tr>

            <tr id="trnorecordfound" runat="server" style="display: none !important;">
                <td>
                    <asp:Label ID="lblnorecord" runat="server" Text="No record found according to your searching." Style="margin-left: 100px; font-size: 15px !important; color: red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                    <div id="divgridforsalary" runat="server" class="divgridforsalary">
                        <asp:GridView ID="grdformonthlysalaryreport" AutoGenerateColumns="false" Width="100%" runat="server"
                            HeaderStyle-Height="30px" BorderWidth="0" GridLines="None" CssClass="stm">
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
                                <asp:TemplateField ItemStyle-Width="110px" HeaderText="Branch Name" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="121px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblbranchname" Text='<%#Eval("Brname") %>' runat="server" CssClass="BranchName"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField ItemStyle-Width="110px" HeaderText="Category Name" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="121px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTitlename" runat="server" Text='<%#Eval("fullTitlename") %>' CssClass="Titlename" data-tooltip='<%#Eval("Titlename")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                         <asp:TemplateField ItemStyle-Width="110px" HeaderText="Category Description" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="121px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCategoryDescription" runat="server" Text='<%#Eval("CategoryDescription") %>' CssClass="CategoryDescription"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Description" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="121px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDescription" Text='<%# Eval("fullDescription") %>' runat="server" CssClass="Description"  data-tooltip='<%#Eval("Description")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>        
                                        <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right" HeaderStyle-Width="100px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblamount" Text='<%# Eval("Expense") %>' runat="server" CssClass="Expense"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="VAT & TAX" ItemStyle-HorizontalAlign="Right"  HeaderStyle-Width="100px">
                                            <ItemTemplate>
                                                <asp:Label ID="lbltax" Text='<%# Eval("vat_servicetax") %>' runat="server" CssClass="vat_servicetax"></asp:Label>
                                            </ItemTemplate>
                                            </asp:TemplateField>
                                         <asp:TemplateField HeaderText="Total Amount" ItemStyle-HorizontalAlign="Right"  HeaderStyle-Width="100px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblwithtotalamountwithtax" Text='<%# Eval("Expensewithtax") %>' runat="server" CssClass="Expensewithtax"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="View Attachment" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                 <asp:ImageButton runat="server" ID="btnviewreport"  ImageUrl="../images/viewquestion.png" style="height:15px;width:15px;border-width:0px;" CssClass="viewdocument" />
                                               <asp:Label ID="lbltopic"  Text='<%#Eval("expence_file") %>' Style="display:none" runat="server"  ForeColor="Chocolate" CssClass="filename" ></asp:Label>                                          
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Download Attachment" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                 <asp:ImageButton runat="server" ID="btndownloadreport"  ImageUrl="../images/download.png" style="height:15px;width:15px;border-width:0px;" OnClick="btndownloadreport_Click1" CssClass="downloaddocument"/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_light clseveryrow" />
                                    <AlternatingRowStyle CssClass="stm_dark clseveryrow" />
                        </asp:GridView>
                    </div>
                </td>
            </tr>
        </table>
         <table class="" style="width:100%; " cellpadding="0" cellspacing="0">
                    <tr class="stm_head" align="center">
                        <td align="center" scope="col"></td>
                        <td align="center" scope="col"></td>
                        <td align="center" scope="col"></td>
                        <td align="center" scope="col"></td>
                        <td align="center" scope="col"></td>
                        
                        <td align="center" scope="col" style="width:56%;"></td>
                        <td align="center" scope="col">
                           <asp:Label ID="lbltotal" runat="server" CssClass="total" ></asp:Label>
                        </td>
                        <td align="center" scope="col">
                            <asp:Label ID="lbltax" runat="server" CssClass="total" ></asp:Label>
                        </td>
                        <td align="center" scope="col">
                            <asp:Label ID="lblamounaftertax" runat="server" CssClass="total"></asp:Label>
                        </td>
                        <td align="center" scope="col" style="width:12%;"></td>
                        <td align="center" scope="col"></td>
                    </tr>
                </table>
         <asp:HiddenField ID="forurl" runat="server" />
        <div id="divProgressBar" class="progress"></div>
    </div>
     <script type="text/javascript">
         $(document).ready(function () {
            
             $('.viewdocument').click(function () {
                 file = $(this).parent('td').parent('tr').find('td:eq(9)').find('span').text();
                 if (file != "") {
                     var url = $('#ctl00_ContentPlaceHolder1_forurl').val() + '/BranchPanel/Expence Management/ExpenceDocument/';
                     window.open(url + file);
                 }
                 else {
                     alert("There is no file to view.");
                 }
                 return false;
             });
             $("#ctl00_ContentPlaceHolder1_txtfromdate,#ctl00_ContentPlaceHolder1_txttodate").datepicker({
                 changeMonth: true,
                 changeYear: true,
                 yearRange: '1985:2050',
                 dateFormat: "dd MM yy"
             });

             $('#ctl00_ContentPlaceHolder1_ddlcategory').change(function () {
                 FillField();
                 BindGridAfterSearch();
                 return false;
             });
             $('#ctl00_ContentPlaceHolder1_txtfromdate').change(function () {
                 FillField();
                 BindGridAfterSearch();
                 return false;
             });
             $('#ctl00_ContentPlaceHolder1_txttodate').change(function () {
                 FillField();
                 BindGridAfterSearch();
                 return false;
             });
             $('#ctl00_ContentPlaceHolder1_ddlbranchid').change(function () {
                 FillField();
                 BindGridAfterSearch();
                 return false;
             });
             $("#ctl00_ContentPlaceHolder1_Imageforclear").click(function () {
                 fromdate = "", todate = "", titleid = 0, Brid = 0, categoryid = 0;
                 $("#ctl00_ContentPlaceHolder1_txttodate").val('');
                 $("#ctl00_ContentPlaceHolder1_txtfromdate").val('');
                 $("#ctl00_ContentPlaceHolder1_ddlbranchid").val('0');
                 $("#ctl00_ContentPlaceHolder1_ddlcategory").val('0');
                
                 BindGridAfterSearch();
                 return false;
             });
             $(".btnExcel").click(function (e) {
                 alertify.confirm("Are You Sure To Download The ExcelSheet?", function (e) {
                     if (e) {
                         window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.divgridforsalary').html()));
                         e.preventDefault();
                     }
                 });
                 return false;
             });
         });
         var payid = 0, fyid = 0, fromdate = "", todate = "", categoryid = 0, Brid = 0;
         function FillField() {
             fromdate = $('#ctl00_ContentPlaceHolder1_txtfromdate').val();
             todate = $('#ctl00_ContentPlaceHolder1_txttodate').val();
             categoryid = $('#ctl00_ContentPlaceHolder1_ddlcategory').val();
             Brid = $('#ctl00_ContentPlaceHolder1_ddlbranchid').val();
         }
         function BindGridAfterSearch() {
             var totalexpense = 0, totalvat = 0, totalamount = 0;
             $('#ctl00_ContentPlaceHolder1_lbltax').val('');
             $('#ctl00_ContentPlaceHolder1_lblamounaftertax').val('');

             call_progressbar("start");
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "expense_list.aspx/BindGridByJs",
                 data: "{'fromdate':'" + fromdate + "','todate':'" + todate + "','categoryid':'" + categoryid + "','Brid':'" + Brid + "'}",
                 dataType: "json",
                 success: function (data) {
                     if (data.d.length > 0) {
                         $('#ctl00_ContentPlaceHolder1_lbltotal').html('Total: ');
                         $('#ctl00_ContentPlaceHolder1_lbltotal').css("display", "block");
                         $('#ctl00_ContentPlaceHolder1_lbltax').html('Vat & Tax:');
                         $('#ctl00_ContentPlaceHolder1_lbltax').css("display", "block");
                         $('#ctl00_ContentPlaceHolder1_lblamounaftertax').html('Total Amount:');
                         $('#ctl00_ContentPlaceHolder1_lblamounaftertax').css("display", "block");
                         $('#ctl00_ContentPlaceHolder1_divgridforsalary').css("display", "block");
                         $('#ctl00_ContentPlaceHolder1_lblnorecord').css("display", "none");
                         $("[id*=grdformonthlysalaryreport] tr").show();
                         $('#ctl00_ContentPlaceHolder1_trnorecordfound').css("display", "none");
                         $("[id*=grdformonthlysalaryreport] tr:gt(1)").remove();
                         for (var i = 0; i < data.d.length; i++) {
                             row = $("[id*=grdformonthlysalaryreport] tr:eq(1)").clone(true);
                             $("[id$=grdformonthlysalaryreport]").append(row);
                             $(row).find('.RowNumber').html(data.d[i].RowNumber);
                             $(row).find('.ExpenseDate').html(data.d[i].ExpenseDate);
                             $(row).find('.BranchName').html(data.d[i].Brname);
                             $(row).find('.Titlename').html(data.d[i].fullTitlename);
                             $(row).find('.CategoryDescription').html(data.d[i].CategoryDescription);
                             $(row).find('.Description').html(data.d[i].fullDescription);
                             $(row).find('.Description').attr("data-tooltip", data.d[i].Description);
                             $(row).find('.Expense').html(data.d[i].Expense);
                             $(row).find('.vat_servicetax').html(data.d[i].vat_servicetax);
                             $(row).find('.Expensewithtax').html(data.d[i].Expensewithtax);
                             $(row).find('.filename').html(data.d[i].expence_file);
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
                         $('#ctl00_ContentPlaceHolder1_divgridforsalary').css("display", "block");
                         $('#ctl00_ContentPlaceHolder1_lblnorecord').css("display", "block");
                         $("[id*=grdformonthlysalaryreport] tr").hide();
                         $('#ctl00_ContentPlaceHolder1_trnorecordfound').css("display", "block");
                         $('#ctl00_ContentPlaceHolder1_lbltotal').css("display", "none");
                         $('#ctl00_ContentPlaceHolder1_lbltotal').html('Amount: ');

                         $('#ctl00_ContentPlaceHolder1_lbltax').css("display", "none");
                         $('#ctl00_ContentPlaceHolder1_lbltax').html('Vat & Tax: ');

                         $('#ctl00_ContentPlaceHolder1_lblamounaftertax').css("display", "none");
                         $('#ctl00_ContentPlaceHolder1_lblamounaftertax').html('Total Amount: ');
                     }
                     call_progressbar("end");
                 },
                 error: function (result) {
                     alertify.error('Error Here While Binding The Grid.');
                     call_progressbar("end");
                     return false;
                 }
             });
         }
         function call_progressbar(progtype) {
             if (progtype == "start") {
                 $("#divProgressBar").find("#loader").remove();
                 $("#divProgressBar").append('<img id="loader" alt="" src="../images/loader_new.gif" />');
                 $("#divProgressBar").addClass("progressAdd");
             }
             if (progtype == "end") {
                 $("#divProgressBar").find("#loader").remove();
                 $("#divProgressBar").removeClass("progressAdd");
             }
         }
        
    </script>
    <div id="div1" class="progress"></div>
</asp:Content>

