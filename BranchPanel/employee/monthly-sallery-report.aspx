<%@ Page Title="" Language="C#" MasterPageFile="~/branchpanel/MasterPage.master" AutoEventWireup="true" CodeFile="monthly-sallery-report.aspx.cs" Inherits="branchpanel_employee_monthly_sallery_report" %>

<%@ Register Src="~/branchpanel/employee/sallery-managemennt.ascx" TagName="stu" TagPrefix="My" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <link href="../../css/alertify.core.css" rel="stylesheet" type="text/css" />
    <link href="../../css/alertify.default.css" rel="stylesheet" type="text/css" />
    <script src="../../js/alertify.js" type="text/javascript"></script>
    <style type="text/css">
        .activemonthly {
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

        #divforprint {
            width: 800px;
            margin: auto;
            text-align: center;
        }

            #divforprint h3 {
                font-weight: normal;
                font-family: Verdana;
                font-size: 13px;
            }

            #divforprint table td {
                padding: 10px;
            }

        .activecalculatesallery {
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

        .txttotaleffectiveday {
            border: dotted 0.05px;
            opacity: 1 !important;
            width: 43px !important;
            text-align: center !important;
        }

        #divcheque .for_sigle_row_form {
            margin-left: -27px !important;
        }

        #divadvancecheck .for_sigle_row_form {
            margin-left: -27px !important;
        }

        #ctl00_ContentPlaceHolder1_radiobuttontypeofadjustment {
            width: 100%;
        }

            #ctl00_ContentPlaceHolder1_radiobuttontypeofadjustment td {
                width: 50%;
            }

            #ctl00_ContentPlaceHolder1_radiobuttontypeofadjustment label {
                width: 44px !important;
                float: left !important;
                padding-top: 2px;
            }

        .paytable {
            width: 100%;
        }

            .paytable td {
                padding: 5px;
            }

        .btnadvanceback {
            cursor: pointer;
            margin-bottom: -132px;
            margin-left: 313px;
            margin-top: -40px;
            position: absolute !important;
        }

        #ctl00_ContentPlaceHolder1_gvdetails_ctl02_txteffectiveday {
            width: 35px !important;
        }

        .showpopup1 {
            background: none repeat scroll 0 0 #fff;
            border: 10px solid #ddd;
            border-right: 0px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.32);
            color: #000;
            font-family: sans-serif;
            left: 0%;
            /*margin-left: -550px;*/
            opacity: 1;
            padding-bottom: 20px;
            position: absolute;
            width: 1110px;
            z-index: 100;
            /* height: 550px; */
            top: 50%;
            margin-top: -200px;
        }

    </style>
    <script type="text/javascript">
        var payid = "0", isclosed = "0", issavecahnge = "0", isconfirm = "0", amountforpaid = "0", empid = "0";

        var monthid = "0", name = "", empcode = "", department = "", designation = "", status = "", fyid = "";

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
        function pageLoad() {
            document.title = 'Monthly Salary Report';
        }

        $(document).ready(function () {
            $(".PrintSlip").click(function () {
                //FillField();
                payid = $(this).parents(".clseveryrow").find("input[type=hidden][id*=hfrecalculatepayid]").val();
                isclosed = $(this).parents(".clseveryrow").find("input[type=hidden][id*=hfisclosed]").val();
                empid = $(this).parents(".clseveryrow").find("input[type=hidden][id*=hfempid]").val();
                if (isclosed == 1) {
                    window.open("PaySlipReport.aspx?EID=" + empid + "&payid=" + payid + "");
                }
                else {
                    alert("Sorry, Without Pay ! Salary Slip can not Generate...");
                }
                return false;
                //var divContents = $("#divforprint").html();
                //var printWindow = window.open('', '', 'height=400,width=800');
                //printWindow.document.write('<html><head><title>DIV Contents</title>');
                //printWindow.document.write('</head><body >');
                //printWindow.document.write(divContents);
                //printWindow.document.write('</body></html>');
                //printWindow.document.close();
                //printWindow.print();
            });
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
            $('.Recalculate').click(function () {

                payid = $(this).parents(".clseveryrow").find("input[type=hidden][id*=hfrecalculatepayid]").val();
                isclosed = $(this).parents(".clseveryrow").find("input[type=hidden][id*=hfisclosed]").val();
                empid = $(this).parents(".clseveryrow").find("input[type=hidden][id*=hfempid]").val();
                if (parseInt(isclosed) == parseInt(1)) {
                    alertify.error('You can not recalculate locked salary.');
                    return false;
                }
                else {
                    window.location.href = "../../branchpanel/employee/calculate-sallery.aspx?xxxx=" + empid + "&xxxxx=r&xxxxxx=" + payid + "";
                    return false;
                }
            });

            $('.Pay').click(function () {
                var isclosetemp = "0";
                payid = $(this).parents(".clseveryrow").find("input[type=hidden][id*=hfimgbuttonpaynow]").val();
                isconfirm = $(this).parents(".clseveryrow").find("input[type=hidden][id*=hfconfirmpayid]").val();
                isclosetemp = $(this).parents(".clseveryrow").find("input[type=hidden][id*=hfisclosedsecond]").val();
                empid = $(this).parents(".clseveryrow").find("input[type=hidden][id*=hfempidsecond]").val();
                if (parseInt(isconfirm) == parseInt(1)) {
                    alertify.error('Already paid.')
                    return false;
                }
                else if (parseInt(isclosetemp) == parseInt(0)) {
                    alertify.error('You can not pay because you did not lock the salary.')
                    return false;
                }
                else {
                    window.location.href = "../../branchpanel/employee/calculate-sallery.aspx?xxxx=" + empid + "&xxxxx=p&xxxxxx=" + payid + "";
                    return false;
                }
            });

            $('#ctl00_ContentPlaceHolder1_ddlpayid').change(function () {
                FillField();
                BindGridAfterSearch(0);
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_ddldept').change(function () {
                FillField();
                BindGridAfterSearch(0);
                filldisig();
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_ddldesignation').change(function () {
                FillField();
                BindGridAfterSearch(0);
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_ddlstatus').change(function () {
                FillField();
                BindGridAfterSearch(0);
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_ddlfinancialyear').change(function () {
                FillField();
                BindGridAfterSearch(0);
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_txtName').on('change keyup', function () {
                FillField();
                BindGridAfterSearch(0);
                return false;
            });

            $('#ctl00_ContentPlaceHolder1_txtempcode').blur(function () {
                FillField();
                BindGridAfterSearch(0);
                return false;
            });

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

            function BindGridAfterSearch(empid) {
                call_progressbar("start");
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "monthly-sallery-report.aspx/BindGridByJs",
                    data: "{'fyid':'" + fyid + "','payid':'" + payid + "','empid':'" + empid + "','emprefno':'" + empcode + "','empname':'" + name + "','departmrnt':'" + department + "','designation':'" + designation + "','status':'" + status + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d.length > 0) {
                            $("[id*=grdformonthlysalaryreport] tr").show();
                            $('#trnorecordfound').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lbltotal').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lblmonthlysalarytotal').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lblsyscalculatedsalarytotal').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lbltotalrecalculatedsalary').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lbltotaldeduction').css("display", "block");
                            $("[id*=grdformonthlysalaryreport] tr:gt(1)").remove();
                            for (var i = 0; i < data.d.length; i++) {
                                row = $("[id*=grdformonthlysalaryreport] tr:eq(1)").clone(true);
                                $("[id$=grdformonthlysalaryreport]").append(row);
                                $(row).find('.serialno').html(data.d[i].RowNumber);
                                $(row).find('.empcode').html(data.d[i].ref_no);
                                $(row).find('.empname').html(data.d[i].name);
                                $(row).find('.monthlysalary').html(data.d[i].monthly_salary);
                                $(row).find('.syscalculatedsalary').html(data.d[i].calculated_salary);
                                $(row).find('.recalculatedsalary').html(data.d[i].modified_salary);
                                $(row).find('.deduction').html(data.d[i].deduction);
                                //For Bind Hidden Field
                                $(row).find("input[type=hidden][id*=hfrecalculatepayid]").val(data.d[i].payid);
                                $(row).find("input[type=hidden][id*=hfisclosed]").val(data.d[i].paid_status_id);
                                $(row).find("input[type=hidden][id*=hfempid]").val(data.d[i].empid);
                                $(row).find("input[type=hidden][id*=hfimgbuttonpaynow]").val(data.d[i].payid);
                                $(row).find("input[type=hidden][id*=hfconfirmpayid]").val(data.d[i].locked_status_id);
                                $(row).find("input[type=hidden][id*=hfisclosedsecond]").val(data.d[i].paid_status_id);
                                $(row).find("input[type=hidden][id*=hfempidsecond]").val(data.d[i].empid);
                                if (i <= 1) {
                                    $('#ctl00_ContentPlaceHolder1_lbltotal').html("Total");
                                    $('#ctl00_ContentPlaceHolder1_lblmonthlysalarytotal').html(data.d[i].total_monthly_salary);
                                    $('#ctl00_ContentPlaceHolder1_lblsyscalculatedsalarytotal').html(data.d[i].total_calculatedsalary_salary);
                                    $('#ctl00_ContentPlaceHolder1_lbltotalrecalculatedsalary').html(data.d[i].total_modifiedsalary_salary);
                                    $('#ctl00_ContentPlaceHolder1_lbltotaldeduction').html(data.d[i].total_tax_deduction);
                                }

                            }
                            $("[id*=grdformonthlysalaryreport] tr").show();
                            $("[id*=grdformonthlysalaryreport] tr:eq(1)").hide();

                        }
                        else {
                            $("[id*=grdformonthlysalaryreport] tr").hide();
                            $('#trnorecordfound').css("display", "block");
                            $('#ctl00_ContentPlaceHolder1_lbltotal').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lblmonthlysalarytotal').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lblsyscalculatedsalarytotal').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lbltotalrecalculatedsalary').css("display", "none");
                            $('#ctl00_ContentPlaceHolder1_lbltotaldeduction').css("display", "none");

                        }
                        call_progressbar("end");
                    },
                    error: function (result) {
                        call_progressbar("end");
                        return false;
                    }
                });
            }

        });
    </script>
    <div class="content_top">
        <ul>
            <li><a href="monthly-sallery-report.aspx" style="background: url(../../images/content_home_icon.png) left center no-repeat; padding-left: 21px;">Home</a></li>
            <li><a>HR Management</a></li>
            <li><a>Payroll Management</a></li>
            <li style="background: none;"><a class="active" href="#">Monthly Salary Report</a></li>
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
                        <asp:GridView ID="grdformonthlysalaryreport" AutoGenerateColumns="false" Width="100%" runat="server"
                            HeaderStyle-Height="30px" BorderWidth="0">
                            <Columns>
                                <asp:TemplateField HeaderText="S.No." ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsno" Text='<%#Eval("RowNumber") %>' runat="server" CssClass="serialno"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="emp-code" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblempcode" Text='<%#Eval("ref_no") %>' runat="server" CssClass="empcode"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="200px">
                                    <ItemTemplate>
                                        <asp:Label ID="lblname" runat="server" Text='<%#Eval("name") %>' CssClass="empname"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Monthly Salary" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmonthlysalary" Text='<%# Eval("monthly_salary") %>' runat="server" CssClass="monthlysalary"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sys.calculated salary" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblsyscalculatedsalary" Text='<%# Eval("calculated_salary") %>' runat="server" CssClass="syscalculatedsalary"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Recalculated Salary" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lblrecalculatedsalary" Text='<%# Eval("modified_salary") %>' runat="server" CssClass="recalculatedsalary"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tax Deduction" ItemStyle-HorizontalAlign="Right">
                                    <ItemTemplate>
                                        <asp:Label ID="lbldeduction" Text='<%# Eval("deduction") %>' runat="server" CssClass="deduction"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Recalculate" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnrecalculate" runat="server" ImageUrl="~/images/recalculate.png" Style="width: 25px;" CssClass="Recalculate" />
                                        <asp:HiddenField ID="hfrecalculatepayid" Value='<%# Eval("payid") %>' runat="server" />
                                        <asp:HiddenField ID="hfisclosed" Value='<%# Eval("paid_status_id") %>' runat="server" />
                                        <asp:HiddenField ID="hfempid" runat="server" Value='<%# Eval("empid") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:Label ID="lblstatus" runat="server" Text='<%# Eval("paid_status_name") %>' CssClass="paystatus"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Pay" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnpaynow" runat="server" ImageUrl="~/images/paynow.png" Style="width: 30px" CssClass="Pay" />
                                        <asp:HiddenField ID="hfimgbuttonpaynow" Value='<%# Eval("payid") %>' runat="server" />
                                        <asp:HiddenField ID="hfconfirmpayid" Value='<%# Eval("locked_status_id") %>' runat="server" />
                                        <asp:HiddenField ID="hfisclosedsecond" Value='<%# Eval("paid_status_id") %>' runat="server" />
                                        <asp:HiddenField ID="hfempidsecond" runat="server" Value='<%# Eval("empid") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Print" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnprint" runat="server" ImageUrl="~/images/print.png" Style="width: 30px" CssClass="PrintSlip" />
                                      <%--  <asp:HiddenField ID="hfimgbuttonpaynow" Value='<%# Eval("payid") %>' runat="server" />
                                        <asp:HiddenField ID="hfconfirmpayid" Value='<%# Eval("locked_status_id") %>' runat="server" />
                                        <asp:HiddenField ID="hfisclosedsecond" Value='<%# Eval("paid_status_id") %>' runat="server" />
                                        <asp:HiddenField ID="hfempidsecond" runat="server" Value='<%# Eval("empid") %>' />--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                            <RowStyle CssClass="stm_light clseveryrow" />
                            <AlternatingRowStyle CssClass="stm_dark clseveryrow" />
                        </asp:GridView>
                    </div>
                    <div style="float: left; width: 34%; text-align: center;">
                        <asp:Label ID="lbltotal" runat="server" CssClass="monthlysalarytotal" Text="Total:" Style="font-size: 20px; color: green"></asp:Label>
                    </div>
                    <div style="float: left; width: 13%;">
                        <asp:Label ID="lblmonthlysalarytotal" runat="server" CssClass="total"></asp:Label>
                    </div>
                    <div style="float: left; width: 14%;">
                        <asp:Label ID="lblsyscalculatedsalarytotal" runat="server" CssClass="total"></asp:Label>
                    </div>
                    <div style="float: left; width: 13%;">
                        <asp:Label ID="lbltotalrecalculatedsalary" runat="server" CssClass="total"></asp:Label>
                    </div>
                    <div style="float: left; width: 10%;">
                        <asp:Label ID="lbltotaldeduction" runat="server" CssClass="total"></asp:Label>
                    </div>

                </td>
            </tr>
        </table>        
        <div id="divProgressBar" class="progress"></div>
    </div>
</asp:Content>