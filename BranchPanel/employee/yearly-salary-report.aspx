<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="yearly-salary-report.aspx.cs" Inherits="branchpanel_employee_yearly_salary_report" %>

<%@ Register Src="~/branchpanel/employee/sallery-managemennt.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <style type="text/css">
        .activeyearlyreport {
            border-color: #2d9fdd!important;
            border-width: medium;
            background: #F7F7F7;
            color: #2d9fdd!important;
            padding: 5px 13px 5px 13px;
            margin-left: 10px;
            height: auto;
            border-radius: 3px 3px 0px 0px;
            border: 1px solid #ccc;
            border-bottom: none;
            font-size: 12px;
            margin-top: 3px;
        }

        .total {
            font-size: 14px !important;
            color: green !important;
        }
    </style>
    <script type="text/javascript">

        var payid = "0", fyid = "0";

        function pageLoad() {
            document.title = 'Yearly Salary Report';
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

            $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').change(function () {
                FillField();
                BindGridAfterSearch();
                return false;
            });

        });

        function FillField() {
            payid = $('#ctl00_ContentPlaceHolder1_ddlpayid').val();
            fyid = $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').val();
        }

        function BindGridAfterSearch() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "yearly-salary-report.aspx/BindGridByJs",
                data: "{'fyid':'" + fyid + "','payid':'" + payid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("[id*=gridyearlysalaryreport] tr").show();
                        $('#trnorecordfound').css("display", "none");
                        $('#ctl00_ContentPlaceHolder1_lbltotal').css("display", "block");
                        $('#ctl00_ContentPlaceHolder1_lblnoofemployee').css("display", "block");
                        $('#ctl00_ContentPlaceHolder1_lblmonthlysalarytotal').css("display", "block");
                        $('#ctl00_ContentPlaceHolder1_lblsalarydeduction').css("display", "block");
                        $('#ctl00_ContentPlaceHolder1_lbltaxdeduction').css("display", "block");
                        $('#ctl00_ContentPlaceHolder1_lblrecalculatedsalary').css("display", "block");
                        $('#ctl00_ContentPlaceHolder1_lblemployertax').css("display", "block");
                        $("[id*=gridyearlysalaryreport] tr:gt(1)").remove();
                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=gridyearlysalaryreport] tr:eq(1)").clone(true);
                            $("[id$=gridyearlysalaryreport]").append(row);
                            $(row).find('.serialno').html(data.d[i].RowNumber);
                            $(row).find('.monthname').html(data.d[i].month_name);
                            $(row).find('.noofemployee').html(data.d[i].no_of_employee);
                            $(row).find('.monthlysalary').html(data.d[i].monthlysalary);
                            $(row).find('.salarydeduction').html(data.d[i].salary_deduction);
                            $(row).find('.taxdeduction').html(data.d[i].employee_tax_deduction);
                            $(row).find('.recalculatedsalary').html(data.d[i].modifiedsalary);
                            $(row).find('.employertax').html(data.d[i].employer_tax_deduction);
                            $(row).find('.status').html(data.d[i].status);
                            if (i <= 1) {
                                $('#ctl00_ContentPlaceHolder1_lbltotal').html("Total");
                                $('#ctl00_ContentPlaceHolder1_lblnoofemployee').html(data.d[i].total_no_of_employee);
                                $('#ctl00_ContentPlaceHolder1_lblmonthlysalarytotal').html(data.d[i].total_monthly_salary);
                                $('#ctl00_ContentPlaceHolder1_lblsalarydeduction').html(data.d[i].total_salary_deduction);
                                $('#ctl00_ContentPlaceHolder1_lbltaxdeduction').html(data.d[i].total_employee_tax_deduction);
                                $('#ctl00_ContentPlaceHolder1_lblrecalculatedsalary').html(data.d[i].total_modified_salary);
                                $('#ctl00_ContentPlaceHolder1_lblemployertax').html(data.d[i].total_employer_tax_deduction);
                            }
                        }
                        $("[id*=gridyearlysalaryreport] tr").show();
                        $("[id*=gridyearlysalaryreport] tr:eq(1)").hide();
                        call_progressbar("end");
                    }
                    else {
                        $("[id*=gridyearlysalaryreport] tr").hide();
                        $('#trnorecordfound').css("display", "block");
                        $('#ctl00_ContentPlaceHolder1_lbltotal').css("display", "none");
                        $('#ctl00_ContentPlaceHolder1_lblnoofemployee').css("display", "none");
                        $('#ctl00_ContentPlaceHolder1_lblmonthlysalarytotal').css("display", "none");
                        $('#ctl00_ContentPlaceHolder1_lblsalarydeduction').css("display", "none");
                        $('#ctl00_ContentPlaceHolder1_lbltaxdeduction').css("display", "none");
                        $('#ctl00_ContentPlaceHolder1_lblrecalculatedsalary').css("display", "none");
                        $('#ctl00_ContentPlaceHolder1_lblemployertax').css("display", "none");
                        call_progressbar("end");
                    }
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }
    </script>
    <div class="content_top">
        <ul>
            <li><a href="../Default.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Payroll Management</a></li>
            <li style="background: none;"><a class="active" href="#">Yearly Salary Report</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);" class="stm">
            <tr>
                <td class="containerHeadline" style="width: 100%">
                    <div style="float: right; width: 100%;">
                        <asp:DropDownList ID="ddlpayid" runat="server" Width="150px">
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlfinancialyear" runat="server" Width="150px">
                        </asp:DropDownList>
                        <div class="upload">
                            <i class="fa fa-cloud-download icon"><b class="bg-info"></b></i>
                            <asp:Button ID="IBExcel" runat="server" Text="Download Excel file" Visible="true"
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
                        <asp:GridView ID="gridyearlysalaryreport" AutoGenerateColumns="false" Width="100%" runat="server"
                            HeaderStyle-Height="30px" BorderWidth="0">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsno" Text='<%#Eval("RowNumber") %>' runat="server" CssClass="serialno"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Month" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmonth" Text='<%#Eval("month_name") %>' runat="server" CssClass="monthname"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="No of emp." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblnoofemp" runat="server" Text='<%#Eval("no_of_employee") %>' CssClass="noofemployee"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Monthly Salary" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsalary" Text='<%# Eval("monthlysalary") %>' runat="server" CssClass="monthlysalary"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Salary Deduction" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsalarydeduction" Text='<%# Eval("salary_deduction") %>' runat="server" CssClass="salarydeduction"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tax Deduction" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltaxdeduction" Text='<%# Eval("employee_tax_deduction") %>' runat="server" CssClass="taxdeduction"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Recalculated Salary" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblrecalculatedsalary" Text='<%# Eval("modifiedsalary") %>' runat="server" CssClass="recalculatedsalary"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Employer Tax" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblemployertax" Text='<%# Eval("employer_tax_deduction") %>' runat="server" CssClass="employertax"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblstatus" Text='<%# Eval("status") %>' runat="server" CssClass="status"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_dark" />
                            <HeaderStyle CssClass="stm_head" />
                        </asp:GridView>
                    </div>
                    <asp:Label ID="lbltotal" runat="server" CssClass="monthlysalarytotal" Text="Total:" Style="margin-left: 115px !important; font-size: 20px; color: green"></asp:Label>
                    <asp:Label ID="lblnoofemployee" runat="server" CssClass="total" Style="margin-left: 37px !important"></asp:Label>
                    <asp:Label ID="lblmonthlysalarytotal" runat="server" CssClass="total" Style="margin-left: 69px !important"></asp:Label>
                    <asp:Label ID="lblsalarydeduction" runat="server" CssClass="total" Style="margin-left: 64px !important"></asp:Label>
                    <asp:Label ID="lbltaxdeduction" runat="server" CssClass="total" Style="margin-left: 70px !important"></asp:Label>
                    <asp:Label ID="lblrecalculatedsalary" runat="server" CssClass="total" Style="margin-left: 95px !important"></asp:Label>
                    <asp:Label ID="lblemployertax" runat="server" CssClass="total" Style="margin-left: 99px  !important"></asp:Label>
                </td>
            </tr>
        </table>
        <div id="divProgressBar" class="progress"></div>
    </div>
</asp:Content>