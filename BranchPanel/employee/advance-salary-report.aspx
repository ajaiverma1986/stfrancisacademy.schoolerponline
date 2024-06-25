<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="advance-salary-report.aspx.cs" Inherits="branchpanel_employee_advance_salary_report" %>

<%@ Register Src="~/branchpanel/employee/sallery-managemennt.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <style type="text/css">
        .activeadvance {
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
    </style>
    <script type="text/javascript">
        var payid = "0", isclosed = "0", issavecahnge = "0", isconfirm = "0", amountforpaid = "0", empid = "0";

        var monthid = "0", name = "", empcode = "", department = "", designation = "", status = "", fyid = "";

        function pageLoad() {
            document.title = 'Advance Salary Report';
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

        $(document).ready(function () {
            $(".BtnExcel").click(function (e) {
                alertify.confirm("Are You Sure You Want To Download The ExcelSheet.", function (e) {
                    if (e) {
                        window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('.divforstm').html()));
                        e.preventDefault();
                    }
                });
                return false;
            });
            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');

            $('#ctl00_ContentPlaceHolder1_ddlpayid').change(function () {
                FillField();
                BindGridAfterSearch();
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_ddldept').change(function () {
                FillField();
                BindGridAfterSearch();
                filldisig();
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_ddldesignation').change(function () {
                FillField();
                BindGridAfterSearch();
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_ddlstatus').change(function () {
                FillField();
                BindGridAfterSearch();
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').change(function () {
                FillField();
                BindGridAfterSearch();
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_txtName').on('change keyup', function () {
                FillField();
                BindGridAfterSearch();
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_txtempcode').blur(function () {
                FillField();
                BindGridAfterSearch();
                return false;
            });

            function filldisig() {
                call_progressbar("start");
                $.ajax(
                     {
                         type: "POST",
                         contentType: "application/json; charset=utf-8",
                         url: "monthly-sallery-report.aspx/binddesignation",
                         data: "{'did':'" + department + "'}",
                         dataType: "json",
                         success: function (data) {
                             $("#ctl00_ContentPlaceHolder1_ddldesignation").html("");
                             $.each(data.d, function (key, value) {
                                 $("#ctl00_ContentPlaceHolder1_ddldesignation").append($("<option></option>").val(value.desigid).html(value.designame));
                             });
                             call_progressbar("end");
                         },
                         error: function (result) {
                             call_progressbar("end");
                         }
                     });
            }

            function FillField() {

                monthid = $('#ctl00_ContentPlaceHolder1_ddlpayid').val();

                department = $('#ctl00_ContentPlaceHolder1_ddldept').val();

                designation = $('#ctl00_ContentPlaceHolder1_ddldesignation').val();

                status = $('#ctl00_ContentPlaceHolder1_ddlstatus').val();

                fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();

                name = $('#ctl00_ContentPlaceHolder1_txtName').val();

                empcode = $('#ctl00_ContentPlaceHolder1_txtempcode').val();

                payid = $('#ctl00_ContentPlaceHolder1_ddlpayid').val();
            }

            function BindGridAfterSearch() {
                call_progressbar("start");
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "advance-salary-report.aspx/BindGridByJs",
                    data: "{'fyid':'" + fyid + "','payid':'" + payid + "','empid':'" + empid + "','emprefno':'" + empcode + "','empname':'" + name + "','departmrnt':'" + department + "','designation':'" + designation + "','status':'" + status + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            $("[id*=gridadvancesalaryreport] tr").show();
                            $('#trnorecordfound').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lbltotal').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lblmonthlysalarytotal').css("display", "block");
                            $("[id*=gridadvancesalaryreport] tr:gt(1)").remove();
                            for (var i = 0; i < data.d.length; i++) {
                                row = $("[id*=gridadvancesalaryreport] tr:eq(1)").clone(true);
                                $("[id$=gridadvancesalaryreport]").append(row);
                                $(row).find('.RowNumber').html(data.d[i].RowNumber);
                                $(row).find('.Date').html(data.d[i].Date);
                                $(row).find('.emp_code').html(data.d[i].emp_code);
                                $(row).find('.emp_name').html(data.d[i].emp_name);
                                $(row).find('.amount').html(data.d[i].amount);
                                $(row).find('.statusname').html(data.d[i].statusname);
                                $(row).find('.paymentmodename').html(data.d[i].paymentmodename);
                                $(row).find('.remark').html(data.d[i].remark);
                                if (i <= 1) {
                                    $('#ctl00_ContentPlaceHolder1_lbltotal').html("Total");
                                    $('#ctl00_ContentPlaceHolder1_lblmonthlysalarytotal').html(data.d[i].totalamount);
                                }
                            }
                            $("[id*=gridadvancesalaryreport] tr").show();
                            $("[id*=gridadvancesalaryreport] tr:eq(1)").hide();
                            call_progressbar("end");
                        }
                        else {
                            $("[id*=gridadvancesalaryreport] tr").hide();
                            $('#trnorecordfound').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lbltotal').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lblmonthlysalarytotal').css("display", "none");
                            call_progressbar("end");
                        }
                    },
                    error: function (result) {
                        call_progressbar("end");
                    }
                });
            }

        });
    </script>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Payroll Management</a></li>
            <li style="background: none;"><a class="active" href="#">Advance Salary Report</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);" class="stm">
            <tr>
                <td class="containerHeadline" style="width: 100%">
                    <div style="float: left; width: 100%;">
                        <asp:DropDownList ID="ddlpayid" runat="server" Width="130px" Style="margin-left: -10px!important"></asp:DropDownList>
                        <asp:TextBox ID="txtName" runat="server" Width="90px" placeholder="Name" Height="23px"> </asp:TextBox>
                        <asp:TextBox ID="txtempcode" runat="server" Width="90px" placeholder="emp-code" Height="23px"> </asp:TextBox>
                        <asp:DropDownList ID="ddldept" runat="server" Width="165px">
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddldesignation" runat="server" Width="165px">
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlstatus" runat="server" Width="130px">
                            <asp:ListItem Value="0">---Select Status---</asp:ListItem>
                            <asp:ListItem Value="1">Pending</asp:ListItem>
                            <asp:ListItem Value="2">Adjusted</asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlfinancialyear" runat="server" Width="150px">
                        </asp:DropDownList>
                        <div class="upload">
                            <asp:Button ID="IBExcel" runat="server" Text="Download Excel" Visible="true"
                                CausesValidation="false" Height="20px" CssClass="BtnExcel" Style="float: right;"
                                ToolTip="Click here to download Excel sheet" />
                        </div>
                    </div>
                </td>
            </tr>
            <tr id="trnorecordfound" style="display: none !important;">
                <td>
                    <asp:Label ID="lblnorecord" runat="server" Text="No record found according to your searching." Style="margin-left: 100px; font-size: 15px !important; color: red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" style="width: 100%; padding-left: 0px; padding-right: 0px;">
                    <div class="divforstm">
                        <asp:GridView ID="gridadvancesalaryreport" AutoGenerateColumns="false" Width="100%" runat="server"
                            HeaderStyle-Height="30px" BorderWidth="0">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsno" Text='<%#Eval("RowNumber") %>' runat="server" CssClass="RowNumber"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lbldate" Text='<%# Eval("Date") %>' runat="server" CssClass="Date"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="emp-code" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblempcode" Text='<%#Eval("emp_code") %>' runat="server" CssClass="emp_code"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lblname" runat="server" Text='<%#Eval("emp_name") %>' CssClass="emp_name"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblamount" Text='<%# Eval("amount") %>' runat="server" CssClass="amount"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblstatus" Text='<%# Eval("statusname") %>' runat="server" CssClass="statusname"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Payment Mode" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblpaymentmode" Text='<%# Eval("paymentmodename") %>' runat="server" CssClass="paymentmodename"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Given Reason" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblresion" Text='<%# Eval("remark") %>' runat="server" CssClass="remark"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_dark" />
                            <HeaderStyle CssClass="stm_head" />
                        </asp:GridView>
                    </div>
                    <asp:Label ID="lbltotal" runat="server" CssClass="monthlysalarytotal" Text="Total:" Style="margin-left: 471px !important; font-size: 20px; color: green"></asp:Label>
                    <asp:Label ID="lblmonthlysalarytotal" runat="server" CssClass="total" Style="margin-left: 30px !important"></asp:Label>
                </td>
            </tr>
        </table>
        <div id="divProgressBar" class="progress"></div>
    </div>
</asp:Content>
