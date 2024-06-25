<%@ Page Title="" Language="C#" MasterPageFile="~/BranchPanel/MasterPage.master" AutoEventWireup="true" CodeFile="DailyExpenseReport.aspx.cs" Inherits="BranchPanel_Fee_Management_DailyExpenseReport" %>

<%@ Register Src="~/BranchPanel/Fee Management/FeeAccount.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .conductedlecture234 {
            height: auto;
            margin-bottom: 3px;
        }
    </style>
    <style>
        .conductedlecture235 {
            background: none repeat scroll 0 0 #eeefff;
            border: 1px solid #b4b8ff;
            border-radius: 4px;
            color: #000;
            float: left;
            font-size: 12px;
            line-height: 30px;
            margin-left: 100px;
            padding: 0 15px;
            text-align: left;
            width: auto;
        }

        .conductedlecture236 {
            background: none repeat scroll 0 0 #d4feff;
            border: 1px solid #41e1e6;
            border-radius: 4px;
            color: #000;
            float: left;
            font-size: 12px;
            line-height: 30px;
            margin-left: 100px;
            padding: 0 15px;
            text-align: left;
            width: auto;
        }

        #ctl00_ContentPlaceHolder1_grdAppoinmentLetter td {
            border-color: #c3c0c0 !important;
        }

        #ctl00_ContentPlaceHolder1_grdAppoinmentLetter a {
            color: black !important;
        }

        .texthover {
            border: solid 1px red !important;
        }

        .activeexemployee1 {
            border-color: #2d9fdd !important;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd !important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }


        .user-deatils1 span {
            float: left;
            font-size: 12px;
        }

        .user-deatils1 dt {
            font-size: 12px !important;
        }

        .del-activestatusupdate {
            margin-left: 419px !important;
            margin-top: -60px !important;
        }

            .del-activestatusupdate input {
                margin-right: 5px !important;
                margin-left: 5px !important;
            }

            .del-activestatusupdate label {
                color: #3399FF !important;
                font-size: 15px !important;
            }

        .student-photo_frame1 {
            height: 165px !important;
        }

        .lblMessage {
            color: #FF5217;
            font-style: italic;
            font-size: 20px;
            font-family: sans-serif;
        }

        .t1 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            font-weight: bold;
            padding-left: 25px;
            text-align: left !important;
            width: 70px !important;
            border: 1px solid #CCCCCC;
        }

        .t2 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            text-align: left !important;
            width: 70px !important;
            border: 1px solid #CCCCCC;
            padding-left: 10px;
        }

        .t3 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            font-weight: bold;
            padding-left: 10px;
            text-align: left !important;
            width: 40px !important;
            border: 1px solid #CCCCCC;
        }

        .t4 {
            height: 30px;
            padding-top: 5px;
            font-size: 12px !important;
            text-align: left !important;
            width: 70px !important;
            border: 1px solid #CCCCCC;
            padding-left: 10px;
        }

        .tblHeading {
            border-bottom: 1px solid #ddd !important;
            width: 95%;
            color: #493f3f;
            font-weight: bold;
            font-size: 17px;
            vertical-align: top;
            text-align: left;
            height: 30px;
            padding-bottom: 2px;
            padding-left: 15px;
            padding-top: 4px;
        }

        .showpopup {
            opacity: 1;
            position: fixed;
            left: 4%;
            top: 3%;
            background: none repeat scroll 0 0 #fff;
            border: 15px solid #8CBF26;
            border-radius: 17px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000;
            font-family: sans-serif;
            height: 600px;
            width: 1200px;
            z-index: 99999999999;
            overflow: scroll;
        }

            .showpopup td {
                vertical-align: top;
                color: #666666;
            }

        .showpopup2 {
            background: none repeat scroll 0 0 #FFFFFF;
            border: 15px solid #CD3B09;
            border-radius: 25px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000000;
            font-family: sans-serif;
            height: 40%;
            left: 32%;
            opacity: 1;
            position: fixed;
            top: 15%;
            width: 38%;
            z-index: 2147483647;
        }

        .forlabel label {
            float: none !important;
            margin-bottom: -12px;
            margin-left: 3px !important;
            margin-right: 10px !important;
        }

        .trqualification {
            margin-top: 0px;
            height: 30px;
            border: 2px solid #CCCCCC !important;
            text-align: center;
            padding-left: 5px;
        }

        .tdfortrqualification {
            width: 20%;
            border: 1px solid #CCCCCC !important;
        }

        .eductabletxt {
            width: 100%;
            border: none;
            margin-left: 0px;
            text-transform: none !important;
        }
    </style>
    <div class="branch-div-tbl">
        <div class="content_top" style="margin-bottom: 20px;">
            <ul>
                <li><a href="../Default.aspx" style="background: url(~/images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
                <li><a>Fee Management</a></li>
                <li style="background: none;"><a class="active">Daily Expense List</a></li>
            </ul>
            <div style="width: auto; padding-left: 10px; height: 25px; margin-top: 2px; float: right; margin-right: 10px;">
            </div>
        </div>
        <div class="content_pane_cont input_content" id="contentPane">
            <My:stu runat="server" ID="MyUserInfoBoxControl" />
            <asp:HiddenField ID="HiddenField1" runat="server" />
            <div class="tbl-top-heading">
                <h2>Find Account Report </h2>
            </div>
            <div class="conductedlecture234 firstbox" style="border: 1px solid #DEB1D9;">
                <dd>Total No. of Expense</dd>
                <div class="clear"></div>
                <span id="lbltotalstudent" runat="server" style="font-weight: bold;" ></span>
            </div>
            <%-- <div class="conductedlecture234 secbox" style="border: 1px solid #f5d88c;">
                <dd>Total Overdue Fees</dd>
                <div class="clear"></div>
                <span id="lbloverduefee" style="font-weight: bold;"></span>
            </div>
            <div class="conductedlecture234 firstbox" style="border: 1px solid #DEB1D9;">
                <dd>Daily Fee Transaction</dd>
                <div class="clear"></div>
                <span id="Span1" style="font-weight: bold;"></span>
            </div>
            <div class="conductedlecture234 firstbox" style="border: 1px solid #DEB1D9;">
                <dd>Registration Fee Report</dd>
                <div class="clear"></div>
                <span id="Span2" style="font-weight: bold;"></span>
            </div>--%>
            <div class="conductedlecture234 firstbox" style="border: 1px solid #DEB1D9;">
                <dd>Expance Report</dd>
                <div class="clear"></div>
                <span id="Span3" style="font-weight: bold;" runat="server"></span>
            </div>
            <div class="clear"></div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);" class="stm">
                <tr>
                    <td class="containerHeadline" style="width: 100%">
                        <div class="for_sigle_row_form">
                            <asp:DropDownList ID="ddlbranchid" runat="server" Width="200px" Visible="false">
                            </asp:DropDownList>

                            <asp:TextBox ID="txtfromdate" runat="server" Width="150px" placeholder="From Date" onkeypress="return false"> </asp:TextBox>
                            <asp:TextBox ID="txttodate" runat="server" Width="150px" placeholder="To Date" onkeypress="return false"> </asp:TextBox>
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
                                            <asp:Label ID="lblDescription" Text='<%# Eval("fullDescription") %>' runat="server" CssClass="Description" data-tooltip='<%#Eval("Description")%>'></asp:Label>
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
                                    <asp:TemplateField HeaderText="View Attachment" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:ImageButton runat="server" ID="btnviewreport" ImageUrl="~/images/viewquestion.png" Style="height: 15px; width: 15px; border-width: 0px;" CssClass="viewdocument" />
                                            <asp:Label ID="lbltopic" Text='<%#Eval("expence_file") %>' Style="display: none" runat="server" ForeColor="Chocolate" CssClass="filename"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Download Attachment" ItemStyle-HorizontalAlign="Right">
                                        <ItemTemplate>
                                            <asp:ImageButton runat="server" ID="btndownloadreport" ImageUrl="~/images/download.png" Style="height: 15px; width: 15px; border-width: 0px;" OnClick="btndownloadreport_Click1" CssClass="downloaddocument" />
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
            <table class="" style="width: 100%;" cellpadding="0" cellspacing="0">
                <tr class="stm_head" align="center">
                    <td align="center" scope="col"></td>
                    <td align="center" scope="col"></td>
                    <td align="center" scope="col"></td>
                    <td align="center" scope="col"></td>
                    <td align="center" scope="col"></td>

                    <td align="center" scope="col" style="width: 56%;"></td>
                    <td align="center" scope="col">
                        <asp:Label ID="lbltotal" runat="server" CssClass="total"></asp:Label>
                    </td>
                    <td align="center" scope="col">
                        <asp:Label ID="lbltax" runat="server" CssClass="total"></asp:Label>
                    </td>
                    <td align="center" scope="col">
                        <asp:Label ID="lblamounaftertax" runat="server" CssClass="total"></asp:Label>
                    </td>
                    <td align="center" scope="col" style="width: 12%;"></td>
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
                    url: "../../HO/expense_list.aspx/BindGridByJs",
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
                    $("#divProgressBar").append('<img id="loader" alt="" src="~/images/loader_new.gif" />');
                    $("#divProgressBar").addClass("progressAdd");
                }
                if (progtype == "end") {
                    $("#divProgressBar").find("#loader").remove();
                    $("#divProgressBar").removeClass("progressAdd");
                }
            }

        </script>
        <div id="div1" class="progress"></div>
    </div>
</asp:Content>


