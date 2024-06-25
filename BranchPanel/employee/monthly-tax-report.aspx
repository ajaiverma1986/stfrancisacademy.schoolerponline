<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="monthly-tax-report.aspx.cs" Inherits="branchpanel_employee_employee_deduction_report" %>

<%@ Register Src="~/BranchPanel/employee/sallery-managemennt.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <style type="text/css">
        .activeemployeededuction {
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
            document.title = 'Yearly Salary Report';
        }

        function pageLoad() {
            document.title = 'Monthly Tax Report';
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
                    url: "monthly-tax-report.aspx/BindGridByJs",
                    data: "{'fyid':'" + fyid + "','payid':'" + payid + "','empid':'" + empid + "','emprefno':'" + empcode + "','empname':'" + name + "','departmrnt':'" + department + "','designation':'" + designation + "','status':'" + status + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            $("[id*=gridmonthlytaxreport] tr").show();
                            $('#trnorecordfound').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lbltotal').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lblemptds').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lblemployertds').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lblempesi').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lblemployeresi').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lblemppf').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lblemployerpf').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lblemployeededuction').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lblemployerdeduction').css("display", "block");
                            $("[id*=gridmonthlytaxreport] tr:gt(1)").remove();
                            for (var i = 0; i < data.d.length; i++) {
                                row = $("[id*=gridmonthlytaxreport] tr:eq(1)").clone(true);
                                $("[id$=gridmonthlytaxreport]").append(row);
                                $(row).find('.RowNumber').html(data.d[i].RowNumber);
                                $(row).find('.ref_no').html(data.d[i].ref_no);
                                $(row).find('.empname').html(data.d[i].name);
                                $(row).find('.employee_tds').html(data.d[i].employee_tds);
                                $(row).find('.employer_tds').html(data.d[i].employer_tds);
                                $(row).find('.employee_esi').html(data.d[i].employee_esi);
                                $(row).find('.employer_esi').html(data.d[i].employer_esi);
                                $(row).find('.employe_pf').html(data.d[i].employe_pf);
                                $(row).find('.employer_pf').html(data.d[i].employer_pf);
                                $(row).find('.total_employee_tax_deduction_employeewise').html(data.d[i].total_employee_tax_deduction_employeewise);
                                $(row).find('.total_employer_tax_deduction_employeewise').html(data.d[i].total_employer_tax_deduction_employeewise);
                                if (i <= 1) {
                                    $('#ctl00_ContentPlaceHolder1_lbltotal').html("Total");
                                    $('#ctl00_ContentPlaceHolder1_lblemptds').html(data.d[i].total_employee_tds);
                                    $('#ctl00_ContentPlaceHolder1_lblemployertds').html(data.d[i].total_employer_tds);
                                    $('#ctl00_ContentPlaceHolder1_lblempesi').html(data.d[i].total_employee_esi);
                                    $('#ctl00_ContentPlaceHolder1_lblemployeresi').html(data.d[i].total_employer_esi);
                                    $('#ctl00_ContentPlaceHolder1_lblemppf').html(data.d[i].total_employee_pf);
                                    $('#ctl00_ContentPlaceHolder1_lblemployerpf').html(data.d[i].total_employer_pf);
                                    $('#ctl00_ContentPlaceHolder1_lblemployeededuction').html(data.d[i].total_employee_tax_deduction_all);
                                    $('#ctl00_ContentPlaceHolder1_lblemployerdeduction').html(data.d[i].total_employer_tax_deduction_all);
                                }
                            }
                            $("[id*=gridmonthlytaxreport] tr").show();
                            $("[id*=gridmonthlytaxreport] tr:eq(1)").hide();
                            call_progressbar("end");
                        }
                        else {
                            $("[id*=gridmonthlytaxreport] tr").hide();
                            $('#trnorecordfound').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lbltotal').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lblemptds').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lblemployertds').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lblempesi').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lblemployeresi').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lblemppf').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lblemployerpf').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lblemployeededuction').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lblemployerdeduction').css("display", "none");
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
            <li style="background: none;"><a class="active" href="#">Monthly Tax Report</a></li>
        </ul>
    </div>
    <div class="content_pane_cont input_content" id="contentPane">
        <My:stu runat="server" ID="MyUserInfoBoxControl" />
        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 0px; box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.3);" class="stm">
            <tr>
                <td class="containerHeadline" style="width: 100%">
                    <div style="float: right; width: 100%;">
                        <asp:DropDownList ID="ddlpayid" runat="server" Width="130px">
                        </asp:DropDownList>
                        <asp:TextBox ID="txtName" runat="server" Width="90px" placeholder="Name" Height="23px"> </asp:TextBox>
                        <asp:TextBox ID="txtempcode" runat="server" Width="90px" placeholder="emp-code" Height="23px"> </asp:TextBox>
                        <asp:DropDownList ID="ddldept" runat="server" Width="165px">
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddldesignation" runat="server" Width="165px">
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlfinancialyear" runat="server" Width="180px">
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
                        <asp:GridView ID="gridmonthlytaxreport" AutoGenerateColumns="false" Width="100%" runat="server"
                            HeaderStyle-Height="30px" BorderWidth="0">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsno" Text='<%#Eval("RowNumber") %>' runat="server" CssClass="RowNumber"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="emp-code" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblempcode" Text='<%#Eval("ref_no") %>' runat="server" CssClass="ref_no"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name" ItemStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <asp:Label ID="lblname" runat="server" Text='<%#Eval("name") %>' CssClass="empname"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TDS Emp" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltdsemp" Text='<%# Eval("employee_tds") %>' runat="server" CssClass="employee_tds"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TDS Employer" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltdsemployer" Text='<%# Eval("employer_tds") %>' runat="server" CssClass="employer_tds"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ESI Emp" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblesisemp" Text='<%# Eval("employee_esi") %>' runat="server" CssClass="employee_esi"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ESI Employer" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblesiemployer" Text='<%# Eval("employer_esi") %>' runat="server" CssClass="employer_esi"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PF Emp" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblpfemp" Text='<%# Eval("employe_pf") %>' runat="server" CssClass="employe_pf"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PF Employer" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblpfemployer" Text='<%# Eval("employer_pf") %>' runat="server" CssClass="employer_pf"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Employee Deduction" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblemployeededuction" Text='<%# Eval("total_employee_tax_deduction_employeewise") %>' runat="server" CssClass="total_employee_tax_deduction_employeewise"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Employer Deduction" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblemployerdeduction" Text='<%# Eval("total_employer_tax_deduction_employeewise") %>' runat="server" CssClass="total_employer_tax_deduction_employeewise"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_dark" />
                            <HeaderStyle CssClass="stm_head" />
                        </asp:GridView>
                    </div>
                    <asp:Label ID="lbltotal" runat="server" CssClass="monthlysalarytotal" Text="Total:" Style="margin-left: 205px !important; font-size: 20px; color: green"></asp:Label>
                    <asp:Label ID="lblemptds" runat="server" CssClass="total" Style="margin-left: 43px !important"></asp:Label>
                    <asp:Label ID="lblemployertds" runat="server" CssClass="total" Style="margin-left: 54px !important"></asp:Label>
                    <asp:Label ID="lblempesi" runat="server" CssClass="total" Style="margin-left: 54px !important"></asp:Label>
                    <asp:Label ID="lblemployeresi" runat="server" CssClass="total" Style="margin-left: 47px !important"></asp:Label>
                    <asp:Label ID="lblemppf" runat="server" CssClass="total" Style="margin-left: 46px !important"></asp:Label>
                    <asp:Label ID="lblemployerpf" runat="server" CssClass="total" Style="margin-left: 43px !important"></asp:Label>
                    <asp:Label ID="lblemployeededuction" runat="server" CssClass="total" Style="margin-left: 93px !important"></asp:Label>
                    <asp:Label ID="lblemployerdeduction" runat="server" CssClass="total" Style="margin-left: 116px !important"></asp:Label>
                </td>
            </tr>
        </table>
        <div id="divProgressBar" class="progress"></div>
    </div>
</asp:Content>
