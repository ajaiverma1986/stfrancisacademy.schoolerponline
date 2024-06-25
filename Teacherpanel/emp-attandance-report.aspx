<%@ Page Title="" Language="C#" MasterPageFile="~/Teacherpanel/employee-panel-master.master" AutoEventWireup="true" CodeFile="emp-attandance-report.aspx.cs" Inherits="EmployeePanel_emp_attandance_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../js/jquery-1.11.1.min.js"></script>

    <script src="../js/jquery-1.7.2.min.js"></script>
    <script src="../Calender/js/jquery-ui-1.8.19.custom.min.js"></script>
    <script src="../js/jquery.com-ui-1.10.0-jquery-ui.js"></script>
    <link href="../css/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
        .attendanceactive {
            outline: 0;
            background-image: none;
            -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            box-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
            color: #333333;
            background-color: #82403B;
            background-image: none;
            border-color: #bab9b8;
        }

        input {
            cursor: pointer !important;
        }

        #ctl00_head_gridfordailyattreport {
            width: 100% !important;
        }

        .user-deatils1 span {
            float: left;
            font-size: 10px;
            margin-top: 6px;
        }

        .user-deatils1 dt {
            font-size: 11px !important;
            width: 190px !important;
        }

        .student-photo_frame1 {
            height: 150px !important;
        }

        #ctl00_head_gridfordailyattreport td {
            padding-left: 4px !important;
        }

            #ctl00_head_gridfordailyattreport td input {
                margin-left: 25px !important;
            }
    </style>

    <script type="text/javascript">
        var payid = "0", fyid = "", fromdate = "", todate = "";

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
            $(document).on("click", "[id*=gvDetails] [id*=lbtn53]", function () {
                payid = $(this).parent('td').find('input[type=hidden]').val();
                fyid = $('#ctl00_head_ddlfinancialyear').val();
                $('#ctl00_head_tabledetails').css("display", "none");
                $('#tabledescription').css("display", "block");
                $('#ctl00_head_gridfordailyattreport').css("width", "1072px");
                BindGridAfterSearch();
                return false;
            });

            $('#ctl00_head_ddlpayid').change(function () {
                payid = $('#ctl00_head_ddlpayid').val();
                fyid = $('#ctl00_head_ddlfinancialyear').val();

                BindFirstGridAfterSearch();
                return false;
            });

            $('#ctl00_head_ddlfinancialyear').change(function () {
                payid = $('#ctl00_head_ddlpayid').val();
                fyid = $('#ctl00_head_ddlfinancialyear').val();
                BindFirstGridAfterSearch();
                return false;
            });

            $("#ctl00_head_txtattendancedate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "d MM yy",
                maxDate: new Date()
            });

            $("#ctl00_head_txtattendancetodate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "d MM yy",
                maxDate: new Date()
            });

            $("#linkleave").attr("href", "requestleavelist.aspx");
            $("#imgheaderlogo").attr('src', '../../images/logo.png');
            $("#hfwebmethodurl").val('../default.aspx/getleaverequest');

            $('#ctl00_head_btnback').click(function () {
                $('#ctl00_head_tabledetails').css("display", "block");
                $('#tabledescription').css("display", "none");
                $('.trnorecordfound').css("display", "none");
                return false;
            });

            $("#ctl00_head_txtattendancedate").on("change blur", function () {
                fromdate = $("#ctl00_head_txtattendancedate").val();
                BindGridAfterSearch();
                return false;
            });

            $("#ctl00_head_txtattendancetodate").on("change blur", function () {
                todate = $("#ctl00_head_txtattendancetodate").val();
                BindGridAfterSearch();
                return false;
            });

        });

        function BindGridAfterSearch() {
            call_progressbar("start");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "emp-attandance-report.aspx/BindGridByJs",
                data: "{'fyid':'" + fyid + "','payid':'" + payid + "','fromdate':'" + fromdate + "','todate':'" + todate + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("[id*=gridfordailyattreport] tr").show();
                        $('.trnorecordfound').css("display", "none");
                        $('.trnorecordfound').css("width", "900px!important");
                        $("[id*=gridfordailyattreport] tr:gt(1)").remove();

                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=gridfordailyattreport] tr:eq(1)").clone(true);
                            $("[id$=gridfordailyattreport]").append(row);
                            $(row).find('.Number').html(data.d[i].Number);
                            $(row).find('.Date').html(data.d[i].Date);
                            $(row).find('.present').attr("src", data.d[i].present);
                            $(row).find('.Intime').html(data.d[i].Intime);
                            $(row).find('.Outtime').html(data.d[i].Outtime);
                            $(row).find('.islate').attr("src", data.d[i].islate);
                            $(row).find('.ishalfday').attr("src", data.d[i].ishalfday);
                            $(row).find('.paidleave').attr("src", data.d[i].paidleave);
                            $(row).find('.unpaidleave').attr("src", data.d[i].unpaidleave);
                        }
                        $("[id*=gridfordailyattreport] tr").show();
                        $("[id*=gridfordailyattreport] tr:eq(1)").hide();
                        call_progressbar("end");
                    }
                    else {

                        $("[id*=gridfordailyattreport] tr").hide();
                        $('.trnorecordfound').css("display", "block");
                        $('.trnorecordfound').css("width", "900px!important");
                        call_progressbar("end");
                    }
                },
                error: function (result) {
                    call_progressbar("end");
                }
            });
        }

        function BindFirstGridAfterSearch() {
            call_progressbar("start");
            $('#ctl00_head_divfornoofpresenttotal').css("display", "block");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "emp-attandance-report.aspx/BindMainGridByJs",
                data: "{'fyid':'" + fyid + "','payid':'" + payid + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d.length > 0) {
                        $("[id*=gvDetails] tr").show();
                        $('.trnorecordfound').css("display", "none");
                        $("[id*=gvDetails] tr:gt(1)").remove();

                        $("#ctl00_head_trfortop").css("display", "block");
                        $("#ctl00_head_trforbottom").css("display", "block");

                        for (var i = 0; i < data.d.length; i++) {
                            row = $("[id*=gvDetails] tr:eq(1)").clone(true);
                            $("[id$=gvDetails]").append(row);
                            $(row).find('.RowNumber').html(data.d[i].RowNumber);
                            $(row).find('.Month').html(data.d[i].Month);
                            $(row).find('.Noofworkingdays').html(data.d[i].Noofworkingdays);
                            $(row).find('.Noofpresentdays').html(data.d[i].Noofpresentdays);
                            $(row).find('.NoofLateCome').html(data.d[i].NoofLateCome);
                            $(row).find('.NoofHalfDays').html(data.d[i].NoofHalfDays);
                            $(row).find('.NoofPaidLeave').html(data.d[i].NoofPaidLeave);
                            $(row).find('.Noofunpaidleave').html(data.d[i].Noofunpaidleave);
                            $(row).find('.Noofabsentdays').html(data.d[i].Noofabsentdays);
                            if (i <= 1) {
                                $('#ctl00_head_lblwork').html(data.d[i].TotalNoofworkingdays);
                                $('#ctl00_head_lblPresent').html(data.d[i].TotalNoofpresentdays);
                                $('#ctl00_head_lblLate').html(data.d[i].TotalNoofLateCome);
                                $('#ctl00_head_lblHalf').html(data.d[i].TotalNoofHalfDays);
                                $('#ctl00_head_lblPaid').html(data.d[i].TotalNoofPaidLeave);
                                $('#ctl00_head_lblUnpaid').html(data.d[i].TotalNoofunpaidleave);
                                $('#ctl00_head_lblAbsent').html(data.d[i].TotalNoofabsentdays);
                            }

                            $(row).find("input[type=hidden][id*=hfpayid]").val(data.d[i].payid);
                        }
                        $("[id*=gvDetails] tr").show();
                        $("[id*=gvDetails] tr:eq(1)").hide();

                    }
                    else {
                        $("#ctl00_head_trfortop").css("display", "none");
                        $("#ctl00_head_trforbottom").css("display", "none");
                        $('#ctl00_head_divfornoofpresenttotal').css("display", "none ");
                        $("[id*=gvDetails] tr").hide();
                        $('.trnorecordfound').css("display", "block");

                    }
                    if (data.d.length == 1) {
                        $('#ctl00_head_divfornoofpresenttotal').css("display", "none");
                    }
                    call_progressbar("end");
                },
                error: function (result) {
                    call_progressbar("end");
                    return false;
                }
            });
        }
    </script>
    <style>
        /*tr {
            border-bottom:1px black!important;
        }*/

        td {
            border-bottom: 1px solid black !important;
            border-top: 1px black !important;
        }
    </style>

    <div class="col-md-9">
        <div class="content-wrapper">
            <div class="content-inner">
                <div class="page-header">
                    <div class="header-links hidden-xs">
                        <a id="lbLogOut" href="../teacher-login.aspx"><i class="icon-signout"></i>Logout
                        </a>
                    </div>
                    <h1>
                        <i class="icon-user"></i>
                        Attendance Report
                    </h1>
                </div>
                <div class="main-content">
                    <table width="100%" id="tabledetails" border="0" cellspacing="0" cellpadding="0" runat="server" style="display: none !important;">
                        <tr>
                            <td class="containerHeadline" style="width: 1072px;">
                                <div style="float: right; width: 100%; margin-bottom: 10px!important">
                                    <asp:DropDownList ID="ddlpayid" runat="server" Width="150px">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlfinancialyear" runat="server" Width="150px">
                                    </asp:DropDownList>
                                </div>
                            </td>
                        </tr>
                        <tr class="trnorecordfound" style="display: none !important; width: 900px">
                            <td style="width: 1072px">
                                <asp:Label ID="lblnorecord" runat="server" Text="No record found according to your searching." Style="margin-left: 10px; font-size: 15px !important; color: red"></asp:Label>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="11" style="width: 100%;">
                                <table id="trfortop" runat="server" style="width: 100%; margin-top: 2px; display: none">
                                    <tr class="stm_head" style="width: 100%!important;">

                                        <td colspan="2" style="text-align: center; width: 159px; border-left: 1px solid black"></td>
                                        <td colspan="5" style="text-align: center; width: 458px; border: 1px solid black">Days</td>
                                        <td colspan="2" style="text-align: center; width: 178px; border: 1px solid black">Leaves</td>
                                        <td colspan="1" style="text-align: center; width: 88px; border-right: 1px solid black"></td>
                                    </tr>
                                </table>

                                <asp:GridView runat="server" ID="gvDetails" ShowHeader="true" AutoGenerateColumns="false" CssClass="stm"
                                    CellPadding="5" Width="100%" HeaderStyle-Height="0px">
                                    <Columns>
                                        <asp:TemplateField HeaderStyle-Width="50px" HeaderText="SNo." ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmainserialno" runat="server" Text='<%# Eval("RowNumber") %>' CssClass="RowNumber"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderStyle-Width="110px" HeaderText="Month" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmainmonth" runat="server" Text='<%# Eval("Month") %>' CssClass="Month"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderStyle-Width="110px" HeaderText="Working" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmainworkingdays" runat="server" Text='<%# Eval("Noofworkingdays") %>' CssClass="Noofworkingdays"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Present" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmainpresentdays" runat="server" Text='<%# Eval("Noofpresentdays") %>' Width="15px" Enabled="false" CssClass="Noofpresentdays" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Late" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmainlatedays" runat="server" Text='<%# Eval("NoofLateCome") %>' CssClass="NoofLateCome"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Half" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmainhalfdays" runat="server" Text='<%# Eval("NoofHalfDays") %>' CssClass="NoofHalfDays"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderStyle-Width="125px" HeaderText="Absent" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmaintotalabsentdays" runat="server" Text='<%# Eval("Noofabsentdays") %>' Width="15px" Enabled="false" CssClass="Noofabsentdays" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderStyle-Width="105px" HeaderText="Paid" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmainpaidleave" runat="server" Text='<%# Eval("NoofPaidLeave") %>' Width="15px" Enabled="false" CssClass="NoofPaidLeave" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Unpaid" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmaintotalunpaidleave" runat="server" Text='<%# Eval("Noofunpaidleave") %>' Width="15px" Enabled="false" CssClass="Noofunpaidleave" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Details" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="lbtn53" runat="server" ToolTip="Click here to show attendance details" CssClass="LinkClick" Width="20px" ImageUrl="~/images/showdetails.png" />
                                                <asp:HiddenField ID="hfpayid" runat="server" Value='<%# Bind("payid") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_light" />
                                    <AlternatingRowStyle CssClass="stm_dark" />
                                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr id="trforbottom" runat="server" style="width: 100%">
                            <td style="border: 0px solid black !important;">
                                <table style="width: 100%; border-top: none!important">
                                    <tr class="stm_head" style="width: 100%!important; border-top: none!important">

                                        <td style="text-align: center; border-left: 1px solid black; width: 22px!important"></td>

                                        <td style="text-align: center; border-left: 0px solid black; width: 140px!important">
                                            <asp:Label ID="lbltotaltext" runat="server" Text="Total:-" Style="margin-left: 77px; font-size: 20px; color: green"></asp:Label></td>

                                        <td style="text-align: center; border: 1px solid black; width: 109px!important">
                                            <asp:Label ID="lblwork" runat="server" Text="0" Style="font-size: 11pt"></asp:Label>
                                        </td>
                                        <td style="text-align: center; border: 1px solid black; width: 104px!important">
                                            <asp:Label ID="lblPresent" runat="server" Text="0" Style="margin-left: 0px; font-size: 11pt"></asp:Label>
                                        </td>
                                        <td style="text-align: center; border: 1px solid black; width: 100px!important">
                                            <asp:Label ID="lblLate" runat="server" Text="0" Style="margin-left: 0px; font-size: 11pt"></asp:Label>
                                        </td>
                                        <td style="text-align: center; border: 1px solid black; width: 100px!important">
                                            <asp:Label ID="lblHalf" runat="server" Text="0" Style="margin-left: 3px; font-size: 11pt"></asp:Label>
                                        </td>
                                        <td style="text-align: center; border: 1px solid black; width: 100px!important">
                                            <asp:Label ID="lblPaid" runat="server" Text="0" Style="margin-left: 0px; font-size: 11pt"></asp:Label></td>

                                        <td style="text-align: center; border: 1px solid black; width: 100px!important">
                                            <asp:Label ID="lblUnpaid" runat="server" Text="0" Style="margin-left: 6px; font-size: 11pt"></asp:Label></td>

                                        <td style="text-align: center; border: 1px solid black; width: 100px!important">
                                            <asp:Label ID="lblAbsent" runat="server" Text="0" Style="margin-left: 5px; font-size: 11pt"></asp:Label></td>

                                        <td style="text-align: center; width: 100px; border-right: 1px solid black;"></td>
                                    </tr>
                                </table>

                                <asp:Label ID="lblmsgformaingrid" runat="server" Text="No attendance found." Style="display: none; color: red; font-size: 20px"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table id="tabledescription" width="100%" border="0" cellspacing="0" cellpadding="0" style="display: none !important;">
                        <tr>
                            <td align="left" colspan="11" style="width: 100%;">
                                <div class="for_sigle_row_form">
                                    <asp:TextBox ID="txtattendancedate" runat="server" Placeholder="From Date" ReadOnly="true" Style="width: 150px !important;"></asp:TextBox>
                                    <asp:TextBox ID="txtattendancetodate" runat="server" Placeholder="To Date" ReadOnly="true" Style="width: 150px !important;"></asp:TextBox>
                                </div>
                            </td>
                        </tr>
                        <tr style="display: none !important;" class="trnorecordfound">
                            <td>
                                <asp:Label ID="Label1" runat="server" Text="No record found according to your searching." Style="margin-left: 100px; font-size: 15px !important; color: red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="11" style="width: 100%;">
                                <asp:GridView runat="server" ID="gridfordailyattreport" ShowHeader="true" AutoGenerateColumns="false"
                                    Width="900px" CssClass="stm">
                                    <Columns>
                                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="SNo." ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblserialno" runat="server" Text='<%# Eval("Number") %>' CssClass="Number"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="110px" HeaderText="Date" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblreportdate" runat="server" Text='<%# Eval("Date","{0:MMM dd yyyy}") %>' CssClass="Date"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Present/Absent" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="lblpresentstatus" runat="server" ImageUrl='<%# Eval("present") %>' Width="15px" Enabled="false" CssClass="present" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="In Time" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblintime" runat="server" Text='<%# Eval("Intime") %>' CssClass="Intime"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Out Time" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblouttime" runat="server" Text='<%# Eval("Outtime") %>' CssClass="Outtime"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="105px" HeaderText="Late" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="lbllatestatus" runat="server" ImageUrl='<%# Eval("islate") %>' Width="15px" Enabled="false" CssClass="islate" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="100px" HeaderText="Halfday" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="lblhalfdaystatus" runat="server" ImageUrl='<%# Eval("ishalfday") %>' Width="15px" Enabled="false" CssClass="ishalfday" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="125px" HeaderText="PaidLeave" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="lblpaidleavestatus" runat="server" ImageUrl='<%# Eval("paidleave") %>' Width="15px" Enabled="false" CssClass="paidleave" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderStyle-Width="125px" HeaderText="UnPaidLeave" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="lblunpaidleavestatus" runat="server" ImageUrl='<%# Eval("unpaidleave") %>' Width="15px" Enabled="false" CssClass="unpaidleave" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="stm_head" HorizontalAlign="Center" />
                                    <RowStyle CssClass="stm_light" />
                                    <AlternatingRowStyle CssClass="stm_dark" />
                                    <PagerStyle BackColor="#999999" ForeColor="White" HorizontalAlign="Center" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                    <asp:Button ID="btnback" runat="server" Text="Back" CssClass="button_save" Style="margin-left: 20px !important; width: 60px !important; margin-top: 10px !important" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>